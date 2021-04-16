module Main exposing (main)
import Browser exposing (Document, UrlRequest)
import Browser.Navigation as Nav
import Url exposing (Url)
import Html exposing (..)

type Page 
  = Home

type alias Model =
    Page

init : () -> Url -> Nav.Key -> ( Model, Cmd msg )
init _ url navKey =
  ( Home, Cmd.none )

-- Update --
type Msg 
  = ChangedUrl Url
  | LinkClicked UrlRequest

update : Msg -> Model -> (Model, Cmd msg)
update msg model =
    (model, Cmd.none)
        

-- View --
view : Model -> Document Msg
view model =
  { title = "Simple Functional Contab"
  , body = [ div [] [ h3 [] [ text "Hello World!" ] ] ] }

main : Program () Model Msg
main =
  Browser.application
    { init = init 
    , update = update
    , view = view
    , subscriptions = \_ -> Sub.none
    , onUrlChange = ChangedUrl
    , onUrlRequest = LinkClicked
    }