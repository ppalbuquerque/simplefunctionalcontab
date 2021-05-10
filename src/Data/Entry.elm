module Data.Entry exposing (Entry, entriesDecoder)

import Json.Decode as Decode
    exposing
    ( Decoder
    , int
    , string
    , list
    )
import Json.Decode.Pipeline exposing (required)

type alias Entry =
    { id : EntryId
    , date : String
    , dayValue : Int
    , profit: Int
    , acumulated: Int
    }

type EntryId
    = EntryId Int

idDecoder : Decoder EntryId
idDecoder =
    Decode.map EntryId int

entriesDecoder : Decoder (List Entry)
entriesDecoder =
    list entryDecoder

entryDecoder : Decoder Entry
entryDecoder =
    Decode.succeed Entry
      |> required "id" idDecoder
      |> required "date" string
      |> required "dayValue" int
      |> required "profit" int
      |> required "acumulated" int