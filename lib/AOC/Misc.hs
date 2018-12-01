module AOC.Misc where

import Data.List (tails)
import qualified Data.Map as M
import qualified Data.Set as S

tally :: Ord a => [a] -> [(a, Int)]
tally xs = M.toList $ M.fromListWith (+) [(x, 1) | x <- xs]

count :: (a -> Bool) -> [a] -> Int
count f = length . filter f

cardinality :: Ord a => [a] -> Int
cardinality = S.size . S.fromList

none :: (a -> Bool) -> [a] -> Bool
none f = not . any f

combinations :: Int -> [a] -> [[a]]
combinations 0 _  = return []
combinations n xs = do y:ts <- tails xs
                       ys   <- combinations (n-1) ts
                       return (y:ys)
