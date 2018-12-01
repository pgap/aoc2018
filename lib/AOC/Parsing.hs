
module AOC.Parsing ( Parser
                   , (<|>)
                   , parseTest
                   , parseOrDie
                   , parseOrFail
                   , parseLines
                   , some, many
                   , sepBy, endBy
                   , char, string
                   , space, eof
                   , decimal
                   , number
                   ) where

import Text.Megaparsec ( Parsec
                       , (<|>)
                       , parse, parseTest
                       , parseErrorTextPretty
                       , some, many
                       , sepBy, endBy
                       , eof
                       )

import Text.Megaparsec.Char (char, string, newline, space)
import Text.Megaparsec.Char.Lexer (decimal, signed)
import Data.Void

type Parser = Parsec Void String

number :: Integral a => Parser a
number = signed (return ()) decimal

parseOrDie :: Parser a -> String -> a
parseOrDie p s = case parse p s s of
  Left  e -> error $ parseErrorTextPretty e
  Right a -> a

parseOrFail :: Monad m => Parser a -> String -> m a
parseOrFail p s = case parse p s s of
  Left  e -> fail $ parseErrorTextPretty e
  Right a -> return a

parseLines :: Parser a -> String -> [a]
parseLines p = parseOrDie $ p `endBy` newline
