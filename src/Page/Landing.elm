module Page.Landing exposing (Model, Msg(..), initialModel, update, view)

import Data.Json exposing (KksTechTechnologies, Product, decodeKksTech)
import Data.Radar exposing (Blip, Quadrant(..), Ring(..))
import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (class, placeholder, type_, value)
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode exposing (decodeString)
import List exposing (concat, map)


type alias Model =
    { url : String
    , error_ : Maybe String
    , isLoading : Bool
    }


initialModel : Model
initialModel =
    Model "" Nothing False


type Msg
    = RetrieveRadarData
    | RetrieveRadarDataSuccess (List Blip)
    | RetrieveRadarDataFailure String
    | UpdateUrl String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RetrieveRadarData ->
            ( { model | isLoading = True }
            , httpGetData "http://localhost:63342/techRadar/src/tech.json"
            )

        RetrieveRadarDataSuccess _ ->
            -- This is handled in Main.elm
            ( model
            , Cmd.none
            )

        RetrieveRadarDataFailure error ->
            ( { model | error_ = Just error, isLoading = False }
            , Cmd.none
            )

        UpdateUrl url ->
            ( { model | url = url }
            , Cmd.none
            )


httpResultToMsg : Result Http.Error String -> Msg
httpResultToMsg result =
    case result of
        Ok json ->
            let
                techData =
                    Debug.log ("json " ++ json) (decodeString decodeKksTech json)

                blips =
                    case techData of
                        Ok data ->
                            transform data.technologies

                        Err error ->
                            []
            in
            RetrieveRadarDataSuccess blips

        Err httpError ->
            RetrieveRadarDataFailure "Unable to retrieve Google Sheet"


transform : KksTechTechnologies -> List Blip
transform kksTechTechnologies =
    trafoFrameworks kksTechTechnologies.frameworks.inEvaluierung


trafoFrameworks : List Product -> List Blip
trafoFrameworks products =
    map trafoProduct products


trafoProduct : Product -> Blip
trafoProduct product =
    { name = product.name
    , rowNum = 1
    , ring = Assess
    , quadrant = LangsAndFrameworks
    , isNew = False
    , moved = product.moved
    , description = product.name
    }


httpGetData : String -> Cmd Msg
httpGetData dataUrl =
    Http.get
        { url = dataUrl
        , expect = Http.expectString httpResultToMsg
        }


getRing : String -> Result String Ring
getRing ringStr =
    if ringStr == "hold" then
        Ok Hold

    else if ringStr == "assess" then
        Ok Assess

    else if ringStr == "trial" then
        Ok Trial

    else if ringStr == "adopt" then
        Ok Adopt

    else
        Err <| "Invalid ring value" ++ ringStr


getQuadrant : String -> Result String Quadrant
getQuadrant quadrantStr =
    if quadrantStr == "tools" then
        Ok Tools

    else if quadrantStr == "techniques" then
        Ok Techniques

    else if quadrantStr == "platforms" then
        Ok Platforms

    else if quadrantStr == "languages & frameworks" then
        Ok LangsAndFrameworks

    else
        Err <| "Invalid quadrant value" ++ quadrantStr


getNew : String -> Result String Bool
getNew isNewStr =
    if isNewStr == "TRUE" then
        Ok True

    else if isNewStr == "FALSE" then
        Ok False

    else
        Err <| "Invalid isNew value" ++ isNewStr



-- View


view : Model -> Html Msg
view model =
    div
        [ class "inputContainer" ]
        [ urlInput model.url
        , showRadarButton model.isLoading
        , text <| Maybe.withDefault "" <| model.error_
        ]


urlInput : String -> Html Msg
urlInput url =
    input
        [ type_ "text"
        , class "sheetInput"
        , value url
        , onInput UpdateUrl
        , placeholder "e.g. https://docs.google.com/spreadsheets/d/1waDG0_W3-yNiAaUfxcZhTKvl7AUCgXwQw8mdPjCz86U/"
        ]
        []


showRadarButton : Bool -> Html Msg
showRadarButton isLoading =
    button
        [ onClick RetrieveRadarData
        , class "sheetInputButton"
        ]
        [ text <| buttonText isLoading ]


buttonText : Bool -> String
buttonText isLoading =
    if isLoading then
        "Please wait.."

    else
        "Show radar"
