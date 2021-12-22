(module statusline
  {autoload {nvim aniseed.nvim
             a aniseed.core
             const statusline.constant
             fname statusline.filename
             git statusline.git}})

(fn get-mode-data []
  (let [mode-name (?. (nvim.get_mode) :mode)]
    (let [mode (?. const.modes mode-name)]
      (if (a.nil? mode)
        {:val (.. "!! UNKNOWN MODE !! " mode-name) :color const.groups.cursorline}
        mode))))

(defn get-mode []
  (let [mode (get-mode-data)]
    {:value (.. mode.color mode.val) :length (length mode.val) :color mode.color}))

(fn get-ft-formatted [bufnr]
  (let [ft (nvim.buf_get_option bufnr :ft)]
    (if (= ft "")
      ""
      (string.format "%s |" ft))))

(fn get-num-lines [bufnr]
  (length (nvim.buf_get_lines bufnr 0 -1 false)))

(fn get-row-col-formatted [num-lines]
  (let [(_ row col) (unpack (nvim.fn.getpos "."))]
    (string.format "%s:%s | %s%%%% |" row col (math.floor (* 100 (/ row num-lines))))))

(fn get-buf-info [bufnr mode-color]
  (let [ft (get-ft-formatted bufnr)
        num-lines (get-num-lines bufnr)
        row-col-percent (get-row-col-formatted num-lines)
        formatted (string.format " %s %s %s " ft row-col-percent num-lines)]
    {:value (.. (string.gsub mode-color "MD" "Info") formatted) :length (length formatted)}))

(fn format-line [content]
  (let [left-side (.. content.mode.value content.filename.value)
        right-side (.. content.git.value content.bufinfo.value)
        total-size (nvim.win_get_width 0)
        content-length (+ content.mode.length content.filename.length content.git.length content.bufinfo.length)
        padding (string.rep " " (- total-size content-length))]
    (string.format "%s%s%s%s%s" const.groups.normal-float left-side const.groups.normal-float padding right-side)))

(defn update []
  (let [bufnr (nvim.get_current_buf)]
    (if (= (nvim.buf_get_option bufnr :ft) "NvimTree")
      ""
      (let [mode (get-mode)
            filename (fname.get bufnr)
            git (git.get-branch filename.original)
            bufinfo (get-buf-info bufnr mode.color)]
        (format-line {:mode mode
                      :filename filename
                      :git git
                      :bufinfo bufinfo})))))

(defn clear []
  (let [dashes (string.rep "―" (nvim.win_get_width 0))]
    (set vim.opt_local.statusline (.. const.groups.vertsplit dashes))))

(defn update-colorscheme []
  (each [name color (pairs const.colors)]
    (let [gui (or (and color.gui (.. "gui=" color.gui)) "")
          guibg (or (and color.guibg (.. "guibg=" color.guibg)) "")
          guifg (or (and color.guifg (.. "guifg=" color.guifg)) "")]
      (nvim.ex.hi! (string.format "def %s %s %s %s" name gui guibg guifg)))))

(update-colorscheme)
(nvim.ex.function! "Status() \n return luaeval(\"require 'statusline'.update()\") \n endfunction")
(nvim.ex.augroup "StatusLine")
(nvim.ex.au!)
(nvim.ex.au "TabEnter,WinLeave,BufEnter,WinEnter,VimEnter * lua require'statusline'.clear()")
(nvim.ex.au "BufEnter,VimEnter * setlocal statusline=%!Status()")
(nvim.ex.au "Colorscheme * lua require'statusline'.update_colorscheme()")
(nvim.ex.augroup "END")
