module Formatter exposing (toBrlCurrency, toDateString)

import FormatNumber exposing (format)
import FormatNumber.Locales exposing (Locale, Decimals(..))
import DateFormat
import Time

toBrlCurrency : Int -> String
toBrlCurrency value =
    let
        brlLocale =
            Locale (Exact 2) "." "," "-" "" "" "" "" ""
    in
    "R$ " ++ format brlLocale (toFloat (value // 100))

toDateString : Int -> String
toDateString milis =
    DateFormat.format "dd/MM/yyyy" Time.utc (Time.millisToPosix milis)