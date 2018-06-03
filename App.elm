module App exposing (init, update, view, subscriptions, IssueRef)
import Html
import Html exposing (Html, Attribute, text, a, div, img)
import Html.Attributes exposing (href, src, height, title, target)
import RemoteData exposing (WebData, RemoteData(..))
import Github exposing (Comments, Comment, Msg(..), getComments)
import Github exposing (Owner, Repo, IssueNumber)
import Style
import Date exposing (Date)
import Date.Format

type alias IssueRef = 
    { owner : Owner
    , repo : Repo
    , issue : IssueNumber
    }
    
type alias Flags = IssueRef

type alias Model =
    { issue : IssueRef
    , comments : WebData Comments
    }

    
main = Html.programWithFlags { init = init
                             , view = view
                             , update = update
                             , subscriptions = subscriptions
                             }

init : Flags -> ( Model, Cmd Msg )
init { owner, repo, issue } =
    ( { issue = IssueRef owner repo issue
      , comments = Loading }
    , (getComments owner repo issue)
    )

    
update msg model =
    case msg of
        CommentsResponse response ->
            ( { model | comments = response }, Cmd.none )
                    
subscriptions =  \_ -> Sub.none
                
view : Model -> Html Msg
view model =
    case model.comments of
        NotAsked -> text "Initialising."
        Loading -> text "Loading."
        Failure err -> text ("Error: " ++ toString err)
        Success comments -> viewComments model.issue comments

showDate : Maybe Date -> String
showDate dt =
    case dt of
        Just date -> Date.Format.format "%d/%m/%Y" date
        Nothing -> "somewhen"

tooltipDate : Maybe Date -> String
tooltipDate dt =
    case dt of
        Just date -> Date.Format.formatISO8601 date
        Nothing -> "somewhen"

viewComment : Comment -> Html Msg
viewComment { html_url, body_html, login, avatar_url, created_at } =
    let 
        date = showDate created_at
        dateTitle = tooltipDate created_at
        header = div Style.commentHeader
                     [ div Style.commentHeaderItem
                           [ img [ src avatar_url
                                 , Style.commentAvatar
                                 ]
                                 []
                           ]
                     , div Style.commentAuthor
                           [ text login
                           , text " - "
                           , a [ href html_url, Style.commentDate, title dateTitle ] [ text date ]
                           ]
                     ]
        content = div Style.commentContent [ body_html ]
    in div Style.comment
           [ header
           , content
           ]

viewComments : IssueRef -> Comments -> Html Msg
viewComments issue comments =
    div [] [ div [] [ a [ href (issueUrl issue), target "_blank" ] [ text "Add a comment (opens Github)" ] ]
           , div [] (List.map viewComment comments)
           ]

issueUrl : IssueRef -> String
issueUrl { owner, repo, issue } =
    "https://github.com/" ++ owner ++ "/" ++ repo ++ "/issues/" ++ (toString issue)
