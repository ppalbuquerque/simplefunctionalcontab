module Views.Header exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, id, type_, for)

view : String -> Html msg
view pageTitle =
  div [ class "header-container" ]
    [ div [ class "header-content" ]
        [ label [ class "hamburguer-menu", for "hamburguer-checkbox" ]
            [ span [ class "spinner-bar", id "spinner01" ] [] 
            , span [ class "spinner-bar", id "spinner02" ] []
            , span [ class "spinner-bar", id "spinner03" ] []
            ]
        , h3 [ class "page-title" ] [ text pageTitle ] 
        ]
    ]