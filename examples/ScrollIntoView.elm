import Dom.Scroll
import Html
import Html.Attributes as Attr
import Html.Events as Ev
import Task


type Msg
    = Scroll Int
    | NoOp


main : Program Never () Msg
main =
    Html.program
        { init = ( (), Cmd.none )
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }


numbers : List Int
numbers =
    List.range 1 1000


view : () -> Html.Html Msg
view () =
    let
        number n =
            Html.li [ Attr.id (toString n), Ev.onClick (Scroll n) ] [ Html.text (toString n) ]
    in
        Html.ul [] (List.map number numbers)


update : Msg -> () -> ( (), Cmd.Cmd Msg )
update action () =
    case action of
        Scroll n ->
            ( (), scroll (toString (1000 - n)) )

        NoOp ->
            ( (), Cmd.none )


scroll : String -> Cmd.Cmd Msg
scroll id =
    Task.attempt (always NoOp) (Dom.Scroll.intoView id)
