module Style exposing (comment, commentHeader, commentContent, commentHeaderItem, commentDate, commentAuthor, commentAvatar)
import Html exposing (Attribute)
import Html.Attributes exposing (class)

comment : List (Attribute msg)
comment = [ class "comments-comment" ]

commentDate : Attribute msg
commentDate = class "comments-date"

commentAuthor : List (Attribute msg)
commentAuthor = [ class "comments-author" ]
    
commentHeader : List (Attribute msg)
commentHeader = [ class "comments-header" ]

commentHeaderItem : List (Attribute msg)
commentHeaderItem = [] -- [ style [ ("margin", "10px" ) ] ]

commentContent : List (Attribute msg)
commentContent = [ class "comments-content" ]

commentAvatar : Attribute msg
commentAvatar = class "comments-avatar"
