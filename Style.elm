module Style exposing (comment, commentHeader, commentContent, commentHeaderItem, commentDate, commentAuthor)
import Html exposing (Attribute)
import Html.Attributes exposing (style)

-- #586069

comment : List (Attribute msg)
comment = [ style [ ("display", "flex")
                  , ("flex-direction", "column")
                  , ("border-width", "1 px")
                  , ("border-color", "rgb(234, 236, 239)")
                  , ("border-style", "solid")
                  , ("margin", "10px")
                  ]
          ]

commentDate : Attribute msg
commentDate = style [ ("color", "#586069") ]

commentAuthor : List (Attribute msg)
commentAuthor = [ style [ ("margin", "10px" ) ] ]
    
commentHeader : List (Attribute msg)
commentHeader = [ style [ ("border-bottom-width", "1 px")
                        , ("border-bottom-style", "solid")
                        , ("border-bottom-color", "rgb(234, 236, 239)")
                        , ("display", "flex")
                        , ("height", "80px")
                        , ("align-items", "center")
                        , ("margin", "10px" )
                        ]
                 ]

commentHeaderItem : List (Attribute msg)
commentHeaderItem = [] -- [ style [ ("margin", "10px" ) ] ]

commentContent : List (Attribute msg)
commentContent = [ style [ ("margin-left", "10px")
                         , ("margin-right", "10px")
                         ]
                 ]
