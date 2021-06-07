module IndexedMap exposing (..)

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
        "with List.indexedMap"
        (\_ -> List.indexedMap (\i j -> i + j) sampleList)
        "with BList.indexedMap"
        (\_ -> BList.indexedMap (\i j -> i + j) sampleList)
