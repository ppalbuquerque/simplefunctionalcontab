module Views.TextInput exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class)

view : String -> Html msg
view labelName =
  div [ class "text-input-container" ]
    [ label [] [ text labelName ] 
    , input [] []
    ]