(module plugins.web-devicons
  {autoload {devicons nvim-web-devicons}})

(devicons.set_icon
  {:html {:icon ""
          :color "#DE8C92"
          :name "html"}
   :css {:icon ""
         :color "#61afef"
         :name "css"}
   :js {:icon ""
        :color "#EBCB8B"
        :name "Js"}
   :ts {:icon "ﯤ"
        :color "#519aba"
        :name "Ts"}
   :png {:icon " "
         :color "#BD77DC"
         :name "png"}
   :jpg {:icon " "
         :color "#BD77DC"
         :name "jpg"}
   :jpeg {:icon " "
          :color "#BD77DC"
          :name "jpeg"}
   :mp3 {:icon ""
         :color "#C8CCD4"
         :name "mp3"}
   :mp4 {:icon ""
         :color "#C8CCD4"
         :name "mp4"}
   :lock {:icon ""
          :color "#117cad"
          :name "lock"}
   :graphql {:icon ""
             :color "#e632ad"
             :name "graphql"}
   :gql {:icon ""
         :color "#e632ad"
         :name "graphql"}
   :fnl {:icon ""
         :color "#fff3d7"
         :name "fennel"}})
