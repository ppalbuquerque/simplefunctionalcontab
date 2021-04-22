module Main exposing (main)
import Browser exposing (Document, UrlRequest)
import Browser.Navigation as Nav
import Url exposing (Url)
import Html exposing (..)
import Pages.Home as HomePage
import Route exposing (Route(..))

type Page
  = NotFound
  | Home HomePage.Model

type alias Model =
    Page

init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url navKey =
  changeRoute (Route.parseUrl url)

-- Routing --
changeRoute : Route -> ( Model, Cmd Msg )
changeRoute route =
  case route of
    Route.NotFound ->
      ( NotFound, Cmd.none )

    Route.Home ->
      HomePage.init
        |> updateWith Home HomeMsg

-- Update --
type Msg 
  = ChangedUrl Url
  | LinkClicked UrlRequest
  | HomeMsg HomePage.Msg

update : Msg -> Model -> (Model, Cmd msg)
update msg model =
    (model, Cmd.none)

updateWith : (subModel -> Model) -> (subMsg -> Msg) -> ( subModel, Cmd subMsg ) -> ( Model, Cmd Msg )
updateWith toModel toMsg ( subModel, subCmd ) =
  ( toModel subModel
  , Cmd.map toMsg subCmd
  )

-- View --
view : Model -> Document Msg
view model =
  case model of
    NotFound ->
      { title = "Not Found", body = [ div [] [ h3 [] [ text "Not Found" ] ] ] }
    
    Home homeModel ->
      viewWith HomeMsg (HomePage.view homeModel)

viewWith : (subPageMsg -> Msg) -> (Document subPageMsg) -> (Document Msg)
viewWith toMainMsg document =
  { title = document.title 
  , body = List.map (Html.map toMainMsg) document.body
  }

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