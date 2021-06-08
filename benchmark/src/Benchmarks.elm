module Benchmarks exposing (..)

import BList
import Benchmark exposing (Benchmark, describe)
import Benchmark.Runner exposing (BenchmarkProgram)


main : BenchmarkProgram
main =
    Benchmark.Runner.program suite


listOfSize : Int -> List Int
listOfSize n =
    List.range 1 n


mapBenchmark : Int -> Benchmark
mapBenchmark n =
    let
        list =
            listOfSize n

        f =
            (+) 5
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "map core"
        (\_ -> List.map f list)
        "map BList"
        (\_ -> BList.map f list)


indexedMapBenchmark : Int -> Benchmark
indexedMapBenchmark n =
    let
        list =
            listOfSize n

        f =
            (+)
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "indexedMap core"
        (\_ -> List.indexedMap f list)
        "indexedMap BList"
        (\_ -> BList.indexedMap f list)


filterBenchmark : Int -> Benchmark
filterBenchmark n =
    let
        list =
            listOfSize n

        f x =
            remainderBy 2 x == 0
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "filter core"
        (\_ -> List.filter f list)
        "filter BList"
        (\_ -> BList.filter f list)


partitionBenchmark : Int -> Benchmark
partitionBenchmark n =
    let
        list =
            listOfSize n

        f x =
            remainderBy 2 x == 0
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "partition core"
        (\_ -> List.partition f list)
        "partition BList"
        (\_ -> BList.partition f list)


unzipBenchmark : Int -> Benchmark
unzipBenchmark n =
    let
        list =
            listOfSize n
                |> List.map (\x -> ( x, n + x ))
    in
    Benchmark.compare ("list of " ++ String.fromInt n ++ " integers")
        "unzip core"
        (\_ -> List.unzip list)
        "unzip BList"
        (\_ -> BList.unzip list)


suite : Benchmark
suite =
    let
        n =
            1000
    in
    describe "core vs BList"
        [ mapBenchmark n
        , indexedMapBenchmark n
        , filterBenchmark n
        , partitionBenchmark n
        , unzipBenchmark n
        ]
