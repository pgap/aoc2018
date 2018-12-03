module Main (main) where

import AOC.Input

year = 2018
day  = 1

--parseInput :: String -> 
parseInput = id

--part1, part2 ::
part1 = id
part2 = id

main :: IO ()
main = do
  input <- parseInput <$> getInput year day
  print $ part1 input
  print $ part2 input

