module Views.EntryCard exposing (viewEntryCard)

import Html exposing (..)
import Html.Attributes exposing (class)
import Data.Entry exposing (Entry)
import Formatter

viewEntryCard : Entry -> Html msg
viewEntryCard entry = 
  div [ class "entry-card-container" ]
    [ span [] [ text entry.date ] 
    , div []
        [ div []
            [ span [ class "info-title" ] [ text "Valor atual" ]
            ,  span [] [ text (Formatter.toBrlCurrency entry.dayValue) ] 
            ]
        , div []
            [ span [ class "info-title" ] [ text "Ganho" ]
            ,  span [ class "entry-gain-text" ] [ text ("+ " ++ Formatter.toBrlCurrency entry.profit) ] 
            ]
        , div []
            [ span [ class "info-title" ] [ text "Acumulado" ]
            ,  span [] [ text (Formatter.toBrlCurrency entry.acumulated) ] 
            ]
        ]
    ]