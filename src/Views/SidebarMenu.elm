module Views.SidebarMenu exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)

view : Html msg
view =
  div [ class "sidebar-menu" ]
    [ h3 [] [ text "Miss France" ] 
    , ul [] 
        [ li [] [ text "Listar Entradas" ] 
        , li [] [ text "Gráficos" ]
        , li [] [ text "Configurações" ]
        ]
    ]