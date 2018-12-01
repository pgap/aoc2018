module AOC.Search where

import qualified Data.Set as Set

bfs :: Ord a => (a -> [a]) -> a -> [a]
bfs = bfsOn id

bfsOn :: Ord b => (a -> b) -> (a -> [a]) -> a -> [a]
bfsOn rep next start = search Set.empty [start] []
  where
    search _    []     []  = []
    search seen []     ys  = search seen (reverse ys) []
    search seen (x:xs) ys
      | Set.member r seen  = search seen xs ys
      | otherwise          = x : search (Set.insert r seen) xs (next x ++ ys)
      where
        r = rep x
