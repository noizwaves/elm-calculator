import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

main =
    Html.program { init = init, view = view, update = update, subscriptions = subscriptions }



-- MODEL

type Component = NumberLiteral Int | Multiply | Plus | Minus | Divide

type Display = Expression (List Component) | Error

type alias Model = Display


-- UPDATE

type Msg = PressDigit Int | PressMultiply | PressPlus | PressMinus | PressDivide | PressEqual | PressClear

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case model of
    Error ->
      case msg of
        PressClear -> (Expression [NumberLiteral 0], Cmd.none)
        PressMultiply -> (model, Cmd.none)
        PressPlus -> (model, Cmd.none)
        PressMinus -> (model, Cmd.none)
        PressDivide -> (model, Cmd.none)
        PressDigit n -> (model, Cmd.none)
        PressEqual -> (model, Cmd.none)
    Expression components ->
      case msg of
        PressClear -> (Expression [NumberLiteral 0], Cmd.none)
        PressMultiply -> (Expression (components ++ [Multiply]), Cmd.none)
        PressPlus -> (Expression (components ++ [Plus]), Cmd.none)
        PressMinus -> (Expression (components ++ [Minus]), Cmd.none)
        PressDivide -> (Expression (components ++ [Divide]), Cmd.none)
        PressDigit n ->
          let
            lastComponent = List.head (List.reverse components)
          in
            case lastComponent of
              Nothing -> (Expression [NumberLiteral n], Cmd.none)
              Just component ->
                case component of
                  Multiply -> (Expression (components ++ [NumberLiteral n]), Cmd.none)
                  Plus -> (Expression (components ++ [NumberLiteral n]), Cmd.none)
                  Minus -> (Expression (components ++ [NumberLiteral n]), Cmd.none)
                  Divide -> (Expression (components ++ [NumberLiteral n]), Cmd.none)
                  NumberLiteral last -> (Expression ((dropLast components) ++ [NumberLiteral (last * 10 + n)]), Cmd.none)
        PressEqual -> (evaluate components, Cmd.none)

dropLast : List a -> List a
dropLast list =
  let
    tail = List.tail (List.reverse list)
  in
    case tail of
      Nothing -> []
      Just tt -> List.reverse tt

evaluate : List Component -> Display
evaluate components = Error


-- VIEW

view : Model -> Html Msg
view model =
  div []
  [ stylesheet "css/index.css"
  , div [ id "calculator" ]
      [ div [ id "screen-container" ]
        [ div [ id "screen" ] [ viewDisplay model ]
        ]
      , div [ id "buttons-container"]
        [ div [ class "buttons" ]
          [ span [ class "operator", id "clear", onClick PressClear ] [ text "C" ]
          , span [ class "operator", onClick PressDivide ] [ text "÷" ]
          , span [ class "operator", onClick PressMultiply ] [ text "x" ]
          , span [ onClick (PressDigit 7) ] [ text "7" ]
          , span [ onClick (PressDigit 8) ] [ text "8" ]
          , span [ onClick (PressDigit 9) ] [ text "9" ]
          , span [ class "operator", onClick PressMinus ] [ text "-" ]
          , span [ onClick (PressDigit 4) ] [ text "4" ]
          , span [ onClick (PressDigit 5) ] [ text "5" ]
          , span [ onClick (PressDigit 6) ] [ text "6" ]
          , span [ class "operator", onClick PressPlus ] [ text "+" ]
          , span [ onClick (PressDigit 1) ] [ text "1" ]
          , span [ onClick (PressDigit 2) ] [ text "2" ]
          , span [ onClick (PressDigit 3) ] [ text "3" ]
          , span [ class "operator", id "equals", onClick PressEqual ] [ text "=" ]
          , div [ class "l-row" ]
            [ span [ id "zero", onClick (PressDigit 0) ] [ text "0" ] ]
          ]
        ]
      ]
  ]

viewDisplay : Display -> Html Msg
viewDisplay display =
  case display of
    Error -> text "Error"
    Expression components ->
      let
        asStrings = List.map viewComponent components
      in
        text (List.foldr (++) "" asStrings)

viewComponent : Component -> String
viewComponent component =
  case component of
     NumberLiteral num -> toString num
     Multiply -> "x"
     Plus -> "+"
     Minus -> "-"
     Divide -> "÷"


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
init = (Expression [ NumberLiteral 0 ], Cmd.none)

