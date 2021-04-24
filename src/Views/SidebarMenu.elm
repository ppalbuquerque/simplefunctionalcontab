module Views.SidebarMenu exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, src)

view : Html msg
view =
  div [ class "sidebar-menu" ]
    [ h3 [] [ text "Miss France" ] 
    , ul [] 
        [ li [ class "sidebar-menu-item" ]
            [  
              img [ src "/assets/images/bulletlist.png" ] []
            , p [] [ text "Lista de entradas" ]
            ] 
        , li [ class "sidebar-menu-item" ]
            [  
              img [ src "/assets/images/chart.png" ] []
            , p [] [ text "Gráficos" ]
            ]
        , li [ class "sidebar-menu-item" ]
            [  
              img [ src "/assets/images/cog.png" ] []
            , p [] [ text "Configurações" ]
            ]
        ]
    ]