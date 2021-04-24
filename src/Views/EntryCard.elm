module Views.EntryCard exposing (viewEntryCard)

import Html exposing (..)
import Html.Attributes exposing (class)
import Data.Entry exposing (Entry)

viewEntryCard : Entry -> Html msg
viewEntryCard entry = 
  div [ class "entry-card-container" ]
    [ span [] [ text entry.date ] 
    , div []
        [ div []
            [ span [ class "info-title" ] [ text "Valor atual" ]
            ,  span [] [ text (String.fromInt entry.actualValue) ] 
            ]
        , div []
            [ span [ class "info-title" ] [ text "Ganho" ]
            ,  span [ class "entry-gain-text" ] [ text ("+ " ++ String.fromInt entry.gain) ] 
            ]
        , div []
            [ span [ class "info-title" ] [ text "Acumulado" ]
            ,  span [] [ text (String.fromInt entry.acumulated) ] 
            ]
        ]
    ]