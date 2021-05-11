module Formatter exposing 
    (
        toBrlCurrency
    ,   toDateString
    ,   formatMonthToPtBr
    ,   formatDayToPtBr
    )

import FormatNumber exposing (format)
import FormatNumber.Locales exposing (Locale, Decimals(..))
import DateFormat
import Time exposing (Month(..), Weekday(..))


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

formatMonthToPtBr : Month -> String
formatMonthToPtBr month =
    case month of
        Jan ->
            "Janeiro"

        Feb ->
            "Fevereiro"

        Mar ->
            "Março"

        Apr ->
            "Abril"

        May ->
            "Maio"

        Jun ->
            "Junho"

        Jul ->
            "Julho"

        Aug ->
            "Agosto"

        Sep ->
            "Setembro"

        Oct ->
            "Outubro"

        Nov ->
            "Novembro"

        Dec ->
            "Dezembro"

formatDayToPtBr : Weekday -> String
formatDayToPtBr day =
     case day of
        Mon ->
            "Seg"

        Tue ->
            "Ter"

        Wed ->
            "Qua"

        Thu ->
            "Qui"

        Fri ->
            "Sex"

        Sat ->
            "Sab"

        Sun ->
            "Dom"
