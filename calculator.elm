import Html exposing (..)
import Html.Attributes exposing (..)
--import Html.Events exposing (onInput)

main =
    Html.program { init = init, view = view, update = update, subscriptions = subscriptions }



-- MODEL

type alias Model =
  {
  }


-- UPDATE

type Msg = ActionOne

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ActionOne -> (model, Cmd.none)



-- VIEW

view : Model -> Html Msg
view model =
  div []
  [ stylesheet "css/index.css"
  , div [ id "calculator" ]
      [ div [ id "screen-container" ]
        [ div [ id "screen" ] []
        ]
      , div [ id "buttons-container"]
        [ div [ class "buttons" ]
          [ span [ class "operator", id "clear" ] [ text "C" ]
          , span [ class "operator" ] [ text "÷" ]
          , span [ class "operator" ] [ text "x" ]
          , span [ ] [ text "7" ]
          , span [ ] [ text "8" ]
          , span [ ] [ text "9" ]
          , span [ class "operator" ] [ text "-" ]
          , span [ ] [ text "4" ]
          , span [ ] [ text "5" ]
          , span [ ] [ text "6" ]
          , span [ class "operator" ] [ text "+" ]
          , span [ ] [ text "1" ]
          , span [ ] [ text "2" ]
          , span [ ] [ text "3" ]
          , span [ class "operator", id "equals" ] [ text "=" ]
          , div [ class "l-row" ]
            [ span [ id "zero" ] [ text "0" ] ]
          ]
        ]
      ]
  ]

stylesheet : String -> Html Msg
stylesheet url =
    let
        tag = "link"
        attrs =
            [ attribute "rel"       "stylesheet"
            , attribute "property"  "stylesheet"
            , attribute "href"      url
            ]
        children = []
    in
        node tag attrs children


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- INIT

init : (Model, Cmd Msg)
init = (Model, Cmd.none)
