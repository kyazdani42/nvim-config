(module statusline.git
  {autoload {nvim aniseed.nvim
             a aniseed.core
             const statusline.constant}})

(local branch-by-name {})

(fn to-escaped-path [fname]
  (nvim.fn.fnameescape (nvim.fn.fnamemodify fname ":p:h")))

(fn format-cmd [cwd]
  (string.format "git -C %s rev-parse --abbrev-ref HEAD" cwd))

(fn git-rev-parse [fname]
  (string.gsub (nvim.fn.system (format-cmd (to-escaped-path fname))) "\n" ""))

(fn set-branch [fname]
  (when (not (?. branch-by-name fname))
    (tset branch-by-name fname (git-rev-parse fname))))

(fn format-branch [branch]
  (string.format "%s%s" const.groups.git branch))

(fn pad-branch-name [branch]
  (string.format " %s " branch))


(fn is-git-branch? [branch]
  (a.nil? (string.match branch "fatal")))

(defn get-branch [fname]
  "Retrieve current branch name and set it in lookup table"
  (set-branch fname)
  (let [branch (pad-branch-name (?. branch-by-name fname))]
    (if (is-git-branch? branch)
      {:value (format-branch branch) :length (length branch)}
      {:value "" :length 0})))
