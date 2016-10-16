import Html exposing (Attribute, div, text, input, ul, li, br, span)
import Html.App as Html
import Html.Attributes as H exposing (..)
import Html.Events exposing (on, onInput)
import Json.Decode exposing (string, map)
import String

type alias Model = Int

type Msg
    = Update String

update : Msg -> Model -> Model
update (Update v) model =
    String.toInt (Debug.log "" v) |> Result.withDefault 0

view model =
  div [class "container"] [
    div [class "container"][
      span [] [text "Number of Questions"]
    , br [] []
    , span [] [text <| toString model]
    , br [] []
    , input [ type' "range", H.min "0", H.max "100", value <| toString model, onInput Update] []
    ]
    , div [class "col-sm-2"]
        [ span [] [text "Missed"]
        , renderMissedList model
        ]
    , div [class "col-sm-2"]
        [ span [] [text "Score"]
        , renderScoreList model
        ]
    ]

main =
  Html.beginnerProgram
    { model = 25
    , view = view
    , update = update
    }

renderMissedList : Int -> Html.Html Msg
renderMissedList n =
  [0..n]
  |> List.map (\x -> li [class "list-group-item"] [ text (toString x) ])
  |> ul [class "list-group"]


renderScoreList : Int -> Html.Html Msg
renderScoreList n =
  [0..n]
  |> List.map (\x -> li [class "list-group-item"] [ text (calculateScore n x) ])
  |> List.reverse
  |> ul [class "list-group"]

calculateScore : Int -> Int -> String
calculateScore total correct =
  let
      t = toFloat total
      c = toFloat correct
  in
     round ((c / t) * 100)
     |> toString
