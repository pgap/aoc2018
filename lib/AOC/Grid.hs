module AOC.Grid where

import Data.Ix

data Coord = C !Int !Int deriving (Eq, Show, Ord, Ix)
data Delta = D !Int !Int deriving (Eq, Show, Ord, Ix)

move :: Coord -> Delta -> Coord
move (C x y) (D dx dy) = C (x + dx) (y + dy)

left, right, up, down :: Delta
left  = leftBy 1
right = rightBy 1
up    = upBy 1
down  = downBy 1

leftBy, rightBy, upBy, downBy :: Int -> Delta
leftBy   n = D (-n)  0
rightBy  n = D   n   0
upBy     n = D   0 (-n)
downBy   n = D   0   n

origin :: Coord
origin = C 0 0

adjecent :: Coord -> [Coord]
adjecent c = [move c d | d <- [left, right, up, down]]

neighbours :: Coord -> [Coord]
neighbours = neighboursBy 1

neighboursBy :: Int -> Coord -> [Coord]
neighboursBy n c = [move c d | d <- range (D (-n) (-n), D n n)]

manhattan :: Coord -> Int
manhattan (C x y) = abs x + abs y
