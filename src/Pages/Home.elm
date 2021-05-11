module Pages.Home exposing ( init, update, view, Model, Msg)

import Browser exposing (Document)
import Html exposing (..)
import Html.Attributes exposing (type_, id, style, class, default)
import Html.Events exposing (onClick)
import Http
import RemoteData exposing (WebData)

import Views.Header as Header
import Views.SidebarMenu as SidebarMenu
import Views.EntryCard exposing (viewEntryCard)
import Views.TextInput
import Data.Entry exposing (Entry, entriesDecoder)
import Date exposing (Date)
import DatePicker exposing (DateEvent(..), defaultSettings)
import Formatter exposing (formatMonthToPtBr, formatDayToPtBr)

-- Model --
type alias NewEntry =
    { date : Maybe Date
    , datePicker : DatePicker.DatePicker 
    }

type alias Model =
  { entries : WebData (List Entry)
  , isModalOpen : Bool
  , newEntry : NewEntry 
  }

datePickerSettings : DatePicker.Settings
datePickerSettings =
  { defaultSettings | 
    placeholder = "Escolha uma data"
  , dateFormatter = Date.format "dd/MM/yyyy"
  , monthFormatter = formatMonthToPtBr
  , dayFormatter = formatDayToPtBr
  }

init : WebData (List Entry) -> ( Model, Cmd Msg )
init entries =
  let
    initialCmd =
      if RemoteData.isNotAsked entries then
        fetchEntries
      else
        Cmd.none
    
    ( datePicker, datePickerCmd ) =
      DatePicker.init
  in
  (initialModel entries datePicker
  , Cmd.batch [ initialCmd, Cmd.map ToDatePicker datePickerCmd ]
  )

initialModel : WebData (List Entry) -> DatePicker.DatePicker -> Model
initialModel entries datePicker =
  { entries = entries
  , isModalOpen = True
  , newEntry = NewEntry Nothing datePicker 
  }

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
  | OpenAddModal
  | ToDatePicker DatePicker.Msg

update : Msg -> Model ->  ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchEntries ->
          ( model, Cmd.none )
        
        EntriesReceived entries ->
          ( { model | entries = entries }, Cmd.none )
        
        OpenAddModal ->
          ( { model | isModalOpen = True }, Cmd.none )
        
        ToDatePicker subMsg ->
          let
            ( newDatePicker, dateEvent ) =
              DatePicker.update datePickerSettings subMsg model.newEntry.datePicker
            
            newDate =
              case dateEvent of
                Picked changedDate ->
                  Just changedDate
                
                _ ->
                  model.newEntry.date
            
            oldEntryForm = model.newEntry
            newEntryForm = 
              { oldEntryForm | date = newDate, datePicker = newDatePicker }
          in
          ( { model | newEntry = newEntryForm  }, Cmd.none )


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
                    [ button [ class "primary-button", onClick OpenAddModal ]
                        [ text "Nova Entrada" ]
                    , button [ class "warning-button", style "margin-left" "1rem" ]
                        [ text "Fechar Semana" ] ] 
                ]
            , viewEntries model.entries
            ]
        ] 
    , SidebarMenu.view
    , viewAddEntryForm model.isModalOpen model.newEntry.date model.newEntry.datePicker
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

viewAddEntryForm : Bool -> Maybe Date -> DatePicker.DatePicker -> Html Msg
viewAddEntryForm isModalOpen date pickerDate =
  if isModalOpen then
    div [ class "overlay" ]
      [ div [ class "modal-card" ] 
          [ h3 [ class "page-title" ] [ text "Criar nova entrada" ] 
          , span [] [ text "Coloque o valor da venda e data associada." ]  
          , div [ class "add-entry-form-inputs" ]
              [ Views.TextInput.view "Comissão" 
              , DatePicker.view date datePickerSettings pickerDate
                  |> Html.map ToDatePicker 
              ]
          ]
      ]
  else
    div [] []
    