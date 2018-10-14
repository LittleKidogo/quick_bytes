import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Url
import Manual


-- MAIN


main : Program String Model Msg
main =
  Browser.application
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlChange = UrlChanged
    , onUrlRequest = LinkClicked
    }


-- Manual 
type alias Manual =
    { title : String
    , description : String
    , body : String
    , tags : List String
    , slug : String
    }


-- MODEL


type alias Model =
  { key : Nav.Key
  , url : Url.Url
  , navigationView : Bool
  , tags : List String
  }


init : String -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    let 
        urlCmd 
            = Nav.pushUrl key flags
     in 
        ( Model key url False Manual.tags,  urlCmd)



-- UPDATE


type Msg
  = LinkClicked Browser.UrlRequest
  | UrlChanged Url.Url
  | MenuTapped


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    LinkClicked urlRequest ->
      case urlRequest of
        Browser.Internal url ->
          ( model, Nav.pushUrl model.key (Url.toString url) )

        Browser.External href ->
          ( model, Nav.load href )

    UrlChanged url ->
      ( { model | url = url }
      , Cmd.none
      )
    
    MenuTapped ->
        let 
            showState =
                case model.navigationView of 
                    True -> { model | navigationView = False }
                    
                    False -> { model | navigationView = True }
         in
           ( showState
           , Cmd.none
           )

-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
  { title = "Quick Bytes"
  , body =
      [ navBar
      , div [ class "container" ]
            [ p [ class "category-title" ] [ text "Main Categories" ]
            , div [ class "cat-box"] (List.map viewCategory Manual.tags)
            ]
      ]
  }


menuList : Model ->List String -> Html msg 
menuList model items = 
    let 
        itemViews =
            List.map viewLink items

        show = 
           case model.navigationView of 
               True -> "show-class"
               
               False -> "hide-class"
        
    in
        ul [ class show]
           itemViews


homeLink : String -> String -> Html msg 
homeLink path pathname =
    a [ href path ] [text pathname]

viewLink : String -> Html msg
viewLink path =
  li [] [ a [ href path ] [ text path ] ]

viewCategory : String -> Html msg
viewCategory path =
  li [] [ a [ class "category-link", href path ] [ text path ] ]




navBar : Html Msg 
navBar = 
    nav [ class "navbar navbar-dark navigation-bar"]
        [ img [ src "images/lk_logo.png",  class "nav-logo"] [ text "Home"]
        , div [] 
            [ input [ type_ "text", placeholder "Search ...",  class "nav-input" ] []
            , button [ class "nav-button" ] [ text  "NEW" ]
            ]
        ]

