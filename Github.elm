module Github exposing (Comments, Comment, getComments, Msg(..), Owner, Repo, IssueNumber)

import Html.Attributes
import Html exposing (Html, span)
import Json.Decode exposing (Decoder, field, string, map, map5, list)
import Json.Encode
import Http exposing (request, emptyBody, expectJson, header)
import RemoteData
import RemoteData exposing (WebData)
import Result
import Date exposing (Date)
import String

type Msg = CommentsResponse (WebData Comments)
type alias Comments = List Comment

type alias Comment =
    { html_url: String
    , body_html : Html Msg
    , login : String
    , avatar_url: String
    , created_at: Maybe Date
    }

type alias Owner = String
type alias Repo = String
type alias IssueNumber = Int
    
commentsDecoder : Decoder (List Comment)
commentsDecoder = list
    ( map5 Comment
          (field "html_url" string)
          (field "body_html" string |> map textHtml)
          (field "user" (field "login" string))
          (field "user" (field "avatar_url" string))
          (field "created_at" string |> map (Result.toMaybe << Date.fromString))
    )
          
url : Owner -> Repo -> IssueNumber -> String
url owner repo number =
    String.join "/" [ "https://api.github.com", "repos", owner, repo, "issues", toString number
                    , "comments?sort=created&direction=desc"
                    ]
      
getComments : Owner -> Repo -> IssueNumber -> Cmd Msg
getComments owner repo number =
    jsonGetWithHeaders (url owner repo number) [ header "Accept" "application/vnd.github.v3.html+json" ] commentsDecoder
        |> RemoteData.sendRequest
        |> Cmd.map CommentsResponse        
           
jsonGetWithHeaders url headers decoder =
    request
       { method = "GET"
       , headers = headers
       , url = url
       , body = emptyBody
       , expect = expectJson decoder
       , timeout = Nothing
       , withCredentials = False
       }
        
textHtml: String -> Html msg
textHtml t =
    span [ Json.Encode.string t |> Html.Attributes.property "innerHTML" ] []
