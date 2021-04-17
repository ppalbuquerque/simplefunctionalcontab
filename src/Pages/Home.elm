module Pages.Home exposing (init, update, view, Model, Msg)

import Browser exposing (Document)
import Html exposing (..)

-- Model --
type alias Model =
  { entries : List String }

init : ( Model, Cmd Msg )
init =
  (initialModel, Cmd.none)

initialModel : Model
initialModel =
  { entries = ["Entry 1", "Entry 2"] }

-- Update --

type Msg 
  = FetchEntries
  | EntriesReceived (List String)

update : Msg -> Model ->  ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchEntries ->
          ( model, Cmd.none )
        
        EntriesReceived entries ->
          ( model, Cmd.none )


-- View --
view : Model -> Document Msg
view model =
  { title = "Home"
  , body = [div [] [ h3 [] [ text "Home Page" ] ]] 
  }
