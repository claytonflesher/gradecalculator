import Html exposing (Attribute, div, text, input)
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
  div []
    [ input
      [ type' "range"
      , H.min "0"
      , H.max "100"
      , value <| toString model
      , onInput Update
      ] []
    , text <| toString model
    ]

main =
  Html.beginnerProgram
    { model = 25
    , view = view
    , update = update
    }
