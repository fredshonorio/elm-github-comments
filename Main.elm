import App exposing (init, update, view, subscriptions, IssueRef)
import Html

main = Html.programWithFlags { init = init
                             , view = view
                             , update = update
                             , subscriptions = subscriptions
                             }
