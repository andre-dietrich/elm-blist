module Unzip exposing (..)

import BList
import Benchmark exposing (..)
import Benchmark.Runner exposing (BenchmarkProgram, program)


main : BenchmarkProgram
main =
    program suite


suite : Benchmark
suite =
    let
        size =
            1024

        sampleList =
            List.range 0 size
                |> BList.map (\i -> ( i, i * 2 ))
    in
    Benchmark.compare ("Mapping " ++ String.fromInt size ++ " Elements")
        "with List.map"
        (\_ -> List.unzip sampleList)
        "with BList.map"
        (\_ -> BList.unzip sampleList)
