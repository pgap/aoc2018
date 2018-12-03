module Main (main) where

import AOC.Input
import AOC.Parsing
import AOC.Grid
import AOC.Misc

import Data.List (find)
import Data.Map (Map)
import qualified Data.Map as Map

year = 2018
day  = 3

data Rect = Rect { claimId, x, y, w, h :: Int }

parser :: Parser Rect
parser = Rect <$ char '#' <*> number
              <* string " @ " <*> number <* char ',' <*> number
              <* string ": "  <*> number <* char 'x' <*> number

coords :: Rect -> [Coord]
coords (Rect _ x y w h) = [C i j | i <- [x .. x + w - 1],
                                   j <- [y .. y + h - 1]]

fabric :: [Rect] -> Map Coord Int
fabric rs = Map.fromListWith (+) [(c, 1) | c <- concatMap coords rs]

part1 :: [Rect] -> Int
part1 = count (>1) . Map.elems . fabric

part2 :: [Rect] -> Int
part2 rs = claimId r
  where
    Just r = find disjoint rs
    disjoint r = all (==1) [m Map.! c | c <- coords r]
    m = fabric rs

main :: IO ()
main = do
  input <- getParsedLines year day parser
  print $ part1 input
  print $ part2 input
