module Views.Header exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class)

view : Html msg
view =
  div [ class "header-container" ]
    [ h3 [ class "page-title" ] [ text "Simple Functional Contab" ] 
    ]