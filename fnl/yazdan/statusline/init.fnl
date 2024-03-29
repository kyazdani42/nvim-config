(module yazdan.statusline
  {autoload {nvim aniseed.nvim
             a aniseed.core
             tree nvim-tree.core
             const yazdan.statusline.constant
             fname yazdan.statusline.filename
             git yazdan.statusline.git}})

(defn- get-mode-data []
  (let [mode-name (?. (nvim.get_mode) :mode)]
    (let [mode (?. const.modes mode-name)]
      (if (a.nil? mode)
        {:val (.. "!! UNKNOWN MODE !! " mode-name) :color const.groups.cursorline}
        mode))))

(defn get-mode []
  (let [mode (get-mode-data)]
    {:value (.. mode.color mode.val) :length (length mode.val) :color mode.color}))

(defn- get-ft-formatted [bufnr]
  (let [ft (nvim.buf_get_option bufnr :ft)]
    (if (= ft "")
      ""
      (string.format "%s |" ft))))

(defn- get-num-lines [bufnr]
  (length (nvim.buf_get_lines bufnr 0 -1 false)))

(defn- get-row-col-formatted [num-lines]
  (let [(_ row col) (unpack (nvim.fn.getpos "."))]
    (string.format "%s:%s | %s%%%% |" row col (math.floor (* 100 (/ row num-lines))))))

(defn- get-buf-info [bufnr mode-color]
  (let [ft (get-ft-formatted bufnr)
        num-lines (get-num-lines bufnr)
        row-col-percent (get-row-col-formatted num-lines)
        formatted (string.format " %s %s %s " ft row-col-percent num-lines)]
    {:value (.. (string.gsub mode-color "MD" "Info") formatted) :length (length formatted)}))

(defn- format-line [content]
  (let [left-side (.. content.mode.value content.filename.value)
        right-side (.. content.git.value content.bufinfo.value)
        total-size (: vim.opt.columns :get)
        content-length (+ content.mode.length content.filename.length content.git.length content.bufinfo.length)
        padding (string.rep " " (- total-size content-length))]
    (string.format "%s%s%s%s%s%s" const.groups.normal-float left-side const.groups.normal-float padding right-side const.groups.reset-fg)))

(defn- special-format [str]
  (.. "%#SpecialComment# " str const.groups.reset-fg))

(defn- get-branch-name [bufnr]
  (. (git.get-branch (. (fname.get bufnr) :original)) :value))

(def- empty {:length 0 :value ""})

(defn update []
  (let [bufnr (nvim.get_current_buf)]
    (match (nvim.buf_get_option bufnr :ft)
      "NvimTree" (special-format (tree.get_cwd))
      "TelescopePrompt" (special-format "Telescope")
      "fugitiveblame" (special-format "Blamer")
      _ (let [mode (get-mode)
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
(nvim.ex.function! "Status() \n return luaeval(\"require 'yazdan.statusline'.update()\") \n endfunction")
(nvim.create_augroup :StatusLine {:clear true})
(nvim.create_autocmd [:BufEnter :VimEnter] {:command "setlocal statusline=%!Status()"})
(nvim.create_autocmd :Colorscheme {:callback (. (require :yazdan.statusline) :update-colorscheme)})
