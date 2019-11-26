module Data.Radar exposing (Blip, Quadrant(..), Ring(..))


type alias Blip =
    { name : String
    , rowNum : Int
    , ring : Ring
    , quadrant : Quadrant
    , isNew : Bool
    , moved : Int
    , description : String
    }


type Quadrant
    = Tools
    | Techniques
    | Platforms
    | LangsAndFrameworks


type Ring
    = Hold
    | Assess
    | Trial
    | Adopt
