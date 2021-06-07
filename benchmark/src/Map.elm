module Map exposing (..)

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
        "with List.map"
        (\_ -> List.map ((*) 2) sampleList)
        "with BList.map"
        (\_ -> BList.map ((*) 2) sampleList)
