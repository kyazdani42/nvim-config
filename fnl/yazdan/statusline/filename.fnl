(module yazdan.statusline.filename
  {autoload {nvim aniseed.nvim
             const yazdan.statusline.constant
             devicon nvim-web-devicons}})

(defn- colorize [s]
  (.. const.groups.fname s))

(defn- path-relative [fname]
  (nvim.fn.fnamemodify fname ":p:."))

(defn get [bufnr]
  (let [fname (nvim.buf_get_name bufnr)]
    (if (= 0 (length fname))
      {:value (colorize "[NO NAME]") :length 9 :original ""}
      (let [modified (string.format "%s %s " (or (devicon.get_icon fname) "") (path-relative fname))]
        {:value (colorize modified)
         :length (length modified)
         :original fname}))))
