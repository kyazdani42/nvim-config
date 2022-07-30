(module yazdan.statusline.filename
  {autoload {nvim aniseed.nvim
             const yazdan.statusline.constant}})

(defn- colorize [s]
  (.. const.groups.fname s))

(defn- path-relative [fname]
  (nvim.fn.fnamemodify fname ":p:."))

(defn get [bufnr]
  (let [fname (nvim.buf_get_name bufnr)]
    (if (= 0 (length fname))
      {:value (colorize "[NO NAME]") :length 9 :original ""}
      (let [modified (string.format " %s " (path-relative fname))]
        {:value (colorize modified) :length (length modified) :original fname}))))
