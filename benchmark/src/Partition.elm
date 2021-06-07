module Partition exposing (..)

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
    in
    Benchmark.compare ("Testing " ++ String.fromInt size ++ " Elements")
        "with List.partition"
        (\_ -> List.partition (\i -> modBy 2 i == 0) sampleList)
        "with BList.partition"
        (\_ -> BList.partition (\i -> modBy 2 i == 0) sampleList)
