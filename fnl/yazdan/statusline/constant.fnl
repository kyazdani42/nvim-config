(module yazdan.statusline.constant)

(def- white "#ffffff")
(def- black "#1b1e2b")
(def- dark-blue "#292d3e")
(def- cyan "#89bbdd")
(def- grey "#353b52")
(def- dark-grey "#32374d")
(def- blue "#959dcb")
(def- violet "#b9a3eb")
(def- green "#d0e7d0")

(def colors
  {:STNormalFlatMD   {:guifg dark-grey :guibg black}
   :STNormalFlatInfo {:guifg dark-grey :guibg black}

   :STNormalMD  {:guifg white     :guibg dark-blue}
   :STVisualMD  {:guifg dark-blue :guibg cyan}
   :STInsertMD  {:guifg dark-blue :guibg violet}
   :STReplaceMD {:guifg dark-blue :guibg green}
   :STTermMD    {:guifg dark-blue :guibg blue}

   :STNormalInfo  {:guifg white  :guibg grey}
   :STVisualInfo  {:guifg cyan   :guibg grey}
   :STInsertInfo  {:guifg violet :guibg grey}
   :STReplaceInfo {:guifg green  :guibg grey}
   :STTermInfo    {:guifg blue   :guibg grey}
   :BgAsFg        {:guifg "bg"}
   :STGitBranch   {:guifg black  :guibg  blue :gui "bold"}})

(def modes
  {:n   {:color "%#STNormalMD#" :val " NORMAL "}
   :no  {:color "%#STNormalMD#" :val " N-Operator Pending "}

   :v   {:color "%#STVisualMD#" :val " VISUAL "}
   :V   {:color "%#STVisualMD#" :val " V-LINE "}
   :\22 {:color "%#STVisualMD#" :val " V-BLOCK "}

   :i   {:color "%#STInsertMD#" :val " INSERT "}
   :ic  {:color "%#STInsertMD#" :val " INSERT "}
   :ix  {:color "%#STInsertMD#" :val " INSERT "}

   :R   {:color "%#STReplaceMD#" :val " REPLACE "}
   :Rv  {:color "%#STReplaceMD#" :val " V-REPLACE "}

   :t   {:color "%#STTermMD#" :val " TERMINAL "}

   :s   {:color "%#STNormalFlatMD#" :val " SELECT "}
   :S   {:color "%#STNormalFlatMD#" :val " S-LINE "}
   :^S  {:color "%#STNormalFlatMD#" :val " S-BLOCK "}
   :c   {:color "%#STNormalFlatMD#" :val " COMMAND "}
   :cv  {:color "%#STNormalFlatMD#" :val " VIM EX "}
   :ce  {:color "%#STNormalFlatMD#" :val " EX "}
   :r   {:color "%#STNormalFlatMD#" :val " PROMPT "}
   :rm  {:color "%#STNormalFlatMD#" :val " MORE "}
   :r?  {:color "%#STNormalFlatMD#" :val " CONFIRM "}
   :!   {:color "%#STNormalFlatMD#" :val " SHELL "}})

(def groups
  {:normal       "%#Normal#"
   :normal-float "%#NormalFloat#"
   :git          "%#STGitBranch#"
   :cursorline   "%#CursorLine#"
   :vertsplit    "%#VertSplit#"
   :fname        "%#STGitBranch#"
   :reset-fg     "%#BgAsFg#"})
