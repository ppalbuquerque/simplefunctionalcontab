module Pages.Home exposing (init, update, view, Model, Msg)

import Browser exposing (Document)
import Html exposing (..)
import Html.Attributes exposing (type_, id, style, class, default)
import Views.Header as Header
import Views.SidebarMenu as SidebarMenu
import Views.EntryCard exposing (viewEntryCard)

import Data.Entry exposing (Entry)

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
  let
    mockEntry = Entry "19/04/2021" 100  100 100  
  in
  { title = "Home"
  , body = 
    [
      input [ type_ "checkbox", id "hamburguer-checkbox", default True,style "display" "none" ] []
      , div [ class "wrapper" ]
        [ Header.view "Listagem de entradas" 
        , div [ class "content" ]
            [ div [ class "page-top-section" ]
                [ h1 [ class "page-title" ] [ text "Entradas" ]
                , div []
                    [ button [ class "primary-button" ]
                        [ text "Nova Entrada" ]
                    , button [ class "warning-button", style "margin-left" "1rem" ]
                        [ text "Fechar Semana" ] ] 
                ]
            , viewEntryCard mockEntry 
            ]
        ] 
    , SidebarMenu.view
    ]
  }
