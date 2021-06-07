module BList exposing (map, indexedMap, filter, partition, unzip)

{-| This is a simple test-case to check if some common list-functions can be implemented differently,
but maybe with some performance benefits.


# Transform

@docs map, indexedMap, filter, partition, unzip

-}

{- Apply a function to every element of a list.
   map sqrt [1,4,9] == [1,2,3]
   map not [True,False,True] == [False,True,False]
   So `map func [ a, b, c ]` is the same as `[ func a, func b, func c ]`
-}


map : (a -> b) -> List a -> List b
map f xs =
    mapHelper f [] xs


mapHelper : (a -> b) -> List b -> List a -> List b
mapHelper f output input =
    case input of
        [] ->
            List.reverse output

        x :: xs ->
            mapHelper f (f x :: output) xs


{-| Same as `map` but the function is also applied to the index of each
element (starting at zero).
indexedMap Tuple.pair ["Tom","Sue","Bob"] == [ (0,"Tom"), (1,"Sue"), (2,"Bob") ]
-}
indexedMap : (Int -> a -> b) -> List a -> List b
indexedMap f xs =
    indexedMapHelper f 0 xs []


indexedMapHelper : (Int -> a -> b) -> Int -> List a -> List b -> List b
indexedMapHelper f i input output =
    case input of
        [] ->
            List.reverse output

        x :: xs ->
            indexedMapHelper f (i + 1) xs (f i x :: output)


{-| Keep elements that satisfy the test.
filter isEven [1,2,3,4,5,6] == [2,4,6]
-}
filter : (a -> Bool) -> List a -> List a
filter isGood list =
    filterHelper isGood list []


filterHelper : (a -> Bool) -> List a -> List a -> List a
filterHelper isGood input output =
    case input of
        [] ->
            List.reverse output

        x :: xs ->
            filterHelper
                isGood
                xs
                (if isGood x then
                    x :: output

                 else
                    output
                )


{-| Partition a list based on some test. The first list contains all values
that satisfy the test, and the second list contains all the value that do not.
partition (\\x -> x < 3) [0,1,2,3,4,5] == ([0,1,2], [3,4,5])
partition isEven [0,1,2,3,4,5] == ([0,2,4], [1,3,5])
-}
partition : (a -> Bool) -> List a -> ( List a, List a )
partition pred list =
    partitionHelper pred (List.reverse list) [] []


partitionHelper : (a -> Bool) -> List a -> List a -> List a -> ( List a, List a )
partitionHelper pred list trues falses =
    case list of
        [] ->
            ( trues, falses )

        x :: xs ->
            if pred x then
                partitionHelper pred xs (x :: trues) falses

            else
                partitionHelper pred xs trues (x :: falses)


{-| Decompose a list of tuples into a tuple of lists.
unzip [(0, True), (17, False), (1337, True)] == ([0,17,1337], [True,False,True])
-}
unzip : List ( a, b ) -> ( List a, List b )
unzip pairs =
    unzipHelper (List.reverse pairs) [] []


unzipHelper : List ( a, b ) -> List a -> List b -> ( List a, List b )
unzipHelper pairs a b =
    case pairs of
        [] ->
            ( a, b )

        ( xa, xb ) :: xs ->
            unzipHelper xs (xa :: a) (xb :: b)
