module Data.Json exposing (..)

import Json.Decode exposing (succeed)
import Json.Decode.Pipeline

type alias KksTech =
    { title : String
    , date : String
    , technologies : KksTechTechnologies
    }

type alias Product =
    { name: String
    , moved: Int
    }

type alias KksTechTechnologiesFrameworks =
    { inEvaluierung : List Product
    , inEinfuehrung : List Product
    , produktiv : List Product
    , auslaufend : List Product
    }

type alias KksTechTechnologiesDataManagement =
    { inEvaluierung : List Product
    , inEinfuehrung : List Product
    , produktiv : List Product
    , auslaufend : List Product
    }

type alias KksTechTechnologiesInfrastruktur =
    { inEvaluierung : List Product
    , inEinfuehrung : List Product
    , produktiv : List Product
    , auslaufend : List Product
    }

type alias KksTechTechnologiesSprachen =
    { inEvaluierung : List Product
    , inEinfuehrung : List Product
    , produktiv : List Product
    , auslaufend : List Product
    }

type alias KksTechTechnologies =
    { frameworks : KksTechTechnologiesFrameworks
    , dataManagement : KksTechTechnologiesDataManagement
    , infrastruktur : KksTechTechnologiesInfrastruktur
    , sprachen : KksTechTechnologiesSprachen
    }

decodeProduct : Json.Decode.Decoder Product
decodeProduct =
    succeed Product
        |> Json.Decode.Pipeline.required "name" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "moved" (Json.Decode.int)

decodeKksTech : Json.Decode.Decoder KksTech
decodeKksTech =
    succeed KksTech
        |> Json.Decode.Pipeline.required "title" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "date" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "technologies" (decodeKksTechTechnologies)

decodeKksTechTechnologiesFrameworks : Json.Decode.Decoder KksTechTechnologiesFrameworks
decodeKksTechTechnologiesFrameworks =
    succeed KksTechTechnologiesFrameworks
        |> Json.Decode.Pipeline.required "inEvaluierung" (Json.Decode.list decodeProduct)
        |> Json.Decode.Pipeline.required "inEinfuehrung" (Json.Decode.list decodeProduct)
        |> Json.Decode.Pipeline.required "produktiv" (Json.Decode.list decodeProduct)
        |> Json.Decode.Pipeline.required "auslaufend" (Json.Decode.list decodeProduct)

decodeKksTechTechnologiesDataManagement : Json.Decode.Decoder KksTechTechnologiesDataManagement
decodeKksTechTechnologiesDataManagement =
    succeed KksTechTechnologiesDataManagement
        |> Json.Decode.Pipeline.required "inEvaluierung" (Json.Decode.list decodeProduct)
        |> Json.Decode.Pipeline.required "inEinfuehrung" (Json.Decode.list decodeProduct)
        |> Json.Decode.Pipeline.required "produktiv" (Json.Decode.list decodeProduct)
        |> Json.Decode.Pipeline.required "auslaufend" (Json.Decode.list decodeProduct)

decodeKksTechTechnologiesInfrastruktur : Json.Decode.Decoder KksTechTechnologiesInfrastruktur
decodeKksTechTechnologiesInfrastruktur =
    succeed KksTechTechnologiesInfrastruktur
        |> Json.Decode.Pipeline.required "inEvaluierung" (Json.Decode.list decodeProduct)
        |> Json.Decode.Pipeline.required "inEinfuehrung" (Json.Decode.list decodeProduct)
        |> Json.Decode.Pipeline.required "produktiv" (Json.Decode.list decodeProduct)
        |> Json.Decode.Pipeline.required "auslaufend" (Json.Decode.list decodeProduct)

decodeKksTechTechnologiesSprachen : Json.Decode.Decoder KksTechTechnologiesSprachen
decodeKksTechTechnologiesSprachen =
    succeed KksTechTechnologiesSprachen
        |> Json.Decode.Pipeline.required "inEvaluierung" (Json.Decode.list decodeProduct)
        |> Json.Decode.Pipeline.required "inEinfuehrung" (Json.Decode.list decodeProduct)
        |> Json.Decode.Pipeline.required "produktiv" (Json.Decode.list decodeProduct)
        |> Json.Decode.Pipeline.required "auslaufend" (Json.Decode.list decodeProduct)

decodeKksTechTechnologies : Json.Decode.Decoder KksTechTechnologies
decodeKksTechTechnologies =
    succeed KksTechTechnologies
        |> Json.Decode.Pipeline.required "frameworks" (decodeKksTechTechnologiesFrameworks)
        |> Json.Decode.Pipeline.required "dataManagement" (decodeKksTechTechnologiesDataManagement)
        |> Json.Decode.Pipeline.required "infrastruktur" (decodeKksTechTechnologiesInfrastruktur)
        |> Json.Decode.Pipeline.required "sprachen" (decodeKksTechTechnologiesSprachen)
