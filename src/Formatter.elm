module Formatter exposing (toBrlCurrency)

import FormatNumber exposing (format)
import FormatNumber.Locales exposing (Locale, Decimals(..))

toBrlCurrency : Int -> String
toBrlCurrency value =
    let
        brlLocale =
            Locale (Exact 2) "." "," "-" "" "" "" "" ""
    in
    "R$ " ++ format brlLocale (toFloat (value // 100))