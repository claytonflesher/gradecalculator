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
      span [] [text "Number of Questions"]
    , br [] []
    , input [ type' "range", H.min "0", H.max "100", value <| toString model, onInput Update] []
    , br [] []
    , span [] [text <| toString model]
    , br [] []
    , span [] [text "Correct"]
    , renderCorrectList model
    , span [] [text "Score"]
    , br [] []
    , renderScoreList model
    ]

main =
  Html.beginnerProgram
    { model = 25
    , view = view
    , update = update
    }

renderCorrectList : Int -> Html.Html Msg
renderCorrectList n =
  [0..n]
  |> List.map (\x -> li [] [ text (toString x) ])
  |> List.reverse
  |> ul [class "list-group"]


renderScoreList : Int -> Html.Html Msg
renderScoreList n =
  [0..n]
  |> List.map (\x -> li [] [ text (calculateScore n x) ])
  |> List.reverse
  |> ul [class "list-group"]

calculateScore : Int -> Int -> String
calculateScore total correct =
  round (((toFloat correct) / (toFloat total)) * 100)
  |> toString
