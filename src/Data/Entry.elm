module Data.Entry exposing (Entry)

type alias Entry =
    { date : String
    , actualValue : Int
    , gain: Int
    , acumulated: Int
    }