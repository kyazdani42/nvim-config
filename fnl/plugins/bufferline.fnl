(module plugins.bufferline
  {autoload {bufferline bufferline}})

(local options
  {:view "default"
   :buffer_close_icon ""
   :modified_icon "✗"
   :close_icon ""
   :left_trunc_marker "<"
   :right_trunc_marker ">"
   :max_name_length 18
   :max_prefix_length 15
   :tab_size 18
   :diagnostics false
   :show_buffer_close_icons false
   :persist_buffer_sort true
   :enforce_regular_tabs false
   :always_show_bufferline true
   :sort_by "directory"})

(local bg_def "#1b1e2b")
(local bg_sel "#121622")
(local fg_def "#a6accd")
(local red "#df4344")
(local cyan "#89ddff")

(local default {:guifg fg_def :guibg bg_def})

(local highlights 
  {
   :fill default
   :background default 
   :buffer_visible default

   :buffer_selected {:guifg "normal_fg"
                     :guibg bg_sel
                     :gui "bold"}

   :modified {:guifg red
              :guibg bg_def}

   :modified_visible {:guifg red
                      :guibg bg_def}

   :modified_selected {:guifg red
                       :guibg bg_sel}

   :indicator_selected {:guifg bg_def
                        :guibg bg_def}

   :separator_selected {:guifg bg_sel
                        :guibg bg_sel}

   :separator_visible {:guifg bg_def
                       :guibg bg_def}

   :separator {:guifg bg_def
               :guibg bg_def}

   :tab default 
   :tab_close default

   :tab_selected {:guifg fg_def
                  :guibg bg_sel}

   :pick_selected {:guifg cyan
                   :guibg bg_sel
                   :gui "bolditalic"}

   :pick_visible {:guifg cyan
                  :guibg bg_def
                  :gui "bolditalic"}

   :pick {:guifg cyan
          :guibg bg_def
          :gui "bolditalic"}})

(bufferline.setup {:options options :highlights highlights})
