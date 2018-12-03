module Main (main) where

import AOC.Input
import AOC.Parsing
import AOC.Misc

year = 2018
day  = 3

data Rect = Rect { claimId, x, y, w, h :: Int }

parser :: Parser Rect
parser = Rect <$ char '#' <*> number
              <* string " @ " <*> number <* char ',' <*> number
              <* string ": "  <*> number <* char 'x' <*> number

coords :: Rect -> [(Int, Int)]
coords (Rect _ x y w h) = [(i, j) | i <- [x .. x + w - 1]
                                  , j <- [y .. y + h - 1]]

disjoint :: Rect -> Rect -> Bool
disjoint r1 r2 = x1 > x2 + w2 || x1 + w1 < x2 ||
                 y1 > y2 + h2 || y1 + h1 < y2
  where
    Rect _ x1 y1 w1 h1 = r1
    Rect _ x2 y2 w2 h2 = r2

part1 :: [Rect] -> Int
part1 = count ((>1) . snd) . tally . concatMap coords

part2 :: [Rect] -> Int
part2 rs = head [ claimId r | (r, rs') <- pickOne rs
                            , all (disjoint r) rs' ]

main :: IO ()
main = do
  input <- getParsedLines year day parser
  print $ part1 input
  print $ part2 input
