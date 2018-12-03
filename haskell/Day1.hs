module Main (main) where

import AOC.Input
import AOC.Parsing

import qualified Data.Set as Set

year = 2018
day  = 1

parser :: Parser Int
parser = number

firstRecurring :: Ord a => [a] -> Maybe a
firstRecurring xs = search xs (Set.empty)
  where
    search []     _       = Nothing
    search (x:xs) seen
      | Set.member x seen = Just x
      | otherwise         = search xs (Set.insert x seen)

part1, part2 :: [Int] -> Int
part1 = sum
part2 xs = s
  where
    Just s = firstRecurring sums
    sums = scanl (+) 0 (cycle xs)

main :: IO ()
main = do
  input <- getParsedLines year day parser
  print $ part1 input
  print $ part2 input
