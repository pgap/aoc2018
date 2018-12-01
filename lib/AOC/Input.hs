{-# LANGUAGE OverloadedStrings #-}

module AOC.Input ( getInput
                 , getParsedInput
                 , getParsedLines
                 ) where

import AOC.Parsing
import Control.Monad             (unless)
import Network.HTTP.Client
import Network.HTTP.Client.TLS   (tlsManagerSettings)
import Network.HTTP.Types.Status (statusCode)
import System.Directory          (doesFileExist)
import System.Environment        (getArgs, getEnv)
import Text.Printf

import qualified Data.ByteString.Char8 as C8
import qualified Data.ByteString.Lazy.Char8 as LC8

makeRequest :: Int -> Int -> IO Request
makeRequest year day = do
  session <- getEnv "AOC_SESSION"

  let url    = printf "http://adventofcode.com/%d/day/%d/input" year day
      cookie = printf "session=%s" session

  request <- parseRequest url
  return request { requestHeaders = [("Cookie", C8.pack cookie)] }

fetchFromHttp :: Int -> Int -> FilePath -> IO ()
fetchFromHttp year day path = do
  manager  <- newManager tlsManagerSettings
  request  <- makeRequest year day
  response <- httpLbs request manager

  case statusCode (responseStatus response)  of
    200 -> LC8.writeFile path (responseBody response)
    _   -> fail "Unexpected response"

getInput :: Int -> Int -> IO (String)
getInput year day = do
  args <- getArgs
  case args of
    file:_ -> readFile file
    _      -> do
      let path = printf "../input/input%02d.txt" day
      fileExists <- doesFileExist path
      unless fileExists $ fetchFromHttp year day path
      readFile path

getParsedInput :: Int -> Int -> Parser a -> IO a
getParsedInput year day p = do 
  input <- getInput year day
  parseOrFail p input

getParsedLines :: Int -> Int -> Parser a -> IO [a]
getParsedLines year day p = parseLines p <$> getInput year day
