module Pages.Home exposing (init, update, view, Model, Msg)

import Browser exposing (Document)
import Html exposing (..)
import Html.Attributes exposing (type_, id, style, class, default)
import Http
import RemoteData exposing (WebData)

import Views.Header as Header
import Views.SidebarMenu as SidebarMenu
import Views.EntryCard exposing (viewEntryCard)
import Data.Entry exposing (Entry, entriesDecoder)

-- Model --
type alias Model =
  { entries : WebData (List Entry) }

init : WebData (List Entry) -> ( Model, Cmd Msg )
init entries =
  let
    initialCmd =
      if RemoteData.isNotAsked entries then
        fetchEntries
      else
        Cmd.none
  in
  (initialModel entries, initialCmd)

initialModel : WebData (List Entry) -> Model
initialModel entries =
  { entries = entries }

-- API
fetchEntries : Cmd Msg
fetchEntries =
  Http.get
    { url = "http://localhost:5000/entries"
    , expect =
        entriesDecoder
          |> Http.expectJson (RemoteData.fromResult >> EntriesReceived)
    }

-- Update --

type Msg 
  = FetchEntries
  | EntriesReceived (WebData (List Entry))

update : Msg -> Model ->  ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchEntries ->
          ( model, Cmd.none )
        
        EntriesReceived entries ->
          ( { model | entries = entries }, Cmd.none )


-- View --
view : Model -> Document Msg
view model =
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
            , viewEntries model.entries
            ]
        ] 
    , SidebarMenu.view
    ]
  }

viewEntries : WebData (List Entry) -> Html Msg
viewEntries entries =
  case entries of
    RemoteData.NotAsked ->
      text ""
    
    RemoteData.Loading ->
      h3 [] [ text "Loading" ]
    
    RemoteData.Success entriesFetched ->
      div [ class "list-entries" ]
        (List.map viewEntryCard entriesFetched)
    
    RemoteData.Failure httpError ->
      text "Error on fetch"
