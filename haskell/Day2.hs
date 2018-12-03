module Main (main) where

import AOC.Input
import AOC.Misc (count, tally)

year = 2018
day  = 2

parseInput :: String -> [String] 
parseInput = lines

part1 :: [String] -> Int
part1 ss = count2 * count3
  where
    counts = map tally ss
    count2 = count (any (\(_, n) -> n == 2)) counts
    count3 = count (any (\(_, n) -> n == 3)) counts

part2 :: [String] -> String
part2 ss = head [common | s1 <- ss,
                          s2 <- ss,
                          let common = [c1 | (c1, c2) <- zip s1 s2, c1 == c2],
                          length common == length s1 - 1]

main :: IO ()
main = do
  input <- parseInput <$> getInput year day
  print $ part1 input
  print $ part2 input
