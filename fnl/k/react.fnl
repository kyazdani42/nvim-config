(module k.react
  {autoload {nvim aniseed.nvim
             str aniseed.string}})

(local jsx-lines
  [
   "import React from 'react';"
   ""
   "export const %s = () => {"
   "  return <div></div>;"
   "};"
  ])

(local tsx-lines
  [
   "import React from 'react';"
   ""
   "interface %sProps {}"
   ""
   "export const %s: React.FC<%sProps> = () => {"
   "  return <div></div>;"
   "};"
  ])

(fn format-lines [list name]
  (vim.tbl_map (partial (fn [s] (string.format s name name))) list))

(fn set-lines [lines]
  (nvim.buf_set_lines 0 0 -1 false lines))

(defn create-component [name]
  (let [ft (nvim.buf_get_option (nvim.get_current_buf) :ft)]
    (do
      (when (or (= ft :javascript) (= ft :javascriptreact))
        (set-lines (format-lines jsx-lines name)))
      (when (= ft :typescriptreact)
        (set-lines (format-lines tsx-lines name))))))
