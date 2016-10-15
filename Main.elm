import Html exposing (Html, input, text, div)
import Html.App exposing (beginnerProgram)
import Html.Attributes exposing (type')
import Html.Events exposing (on, targetValue, onInput)
import Json.Decode as Json

type alias Model =
    { value : String
    }

main =
  beginnerProgram
      { model = {value = "50"}
      , view = view
      , update = update
      }

type Msg = Slider String

view : Model -> Html Msg
view model =
    div []
      -- [ input [type' "range", on "input" (Json.map Slide targetValue)] []
      [ input [type' "range", onInput Slider] []
      , text model.value
      ]

update : Msg -> Model -> Model
update msg model =
    case msg of
      Slider v ->
        { model | value = v}
