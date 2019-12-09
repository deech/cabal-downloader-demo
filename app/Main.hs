module Main where

import Paths_cabal_downloader_demo
import System.FilePath((</>))

main :: IO ()
main = do
  rfc <- lines <$> (readFile =<< getDataFileName ("data-files" </> "jsonrfc.txt"))
  putStrLn $ unlines (take 15 rfc)
