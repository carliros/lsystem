module Main where

import SistemaL
import ParserLS ( parseFileSistemasL )

readDataBase 
    = do lss <- parseFileSistemasL "./db/db.sl"
         let defaultLS = SistemaL "Single Line" [Simbolo "F"] [Simbolo "F"] [(Simbolo "F",[Simbolo "F"])]
         return $ defaultLS : lss

main :: IO ()
main = do
  putStrLn "Hello world"
  dt <- readDataBase
  putStrLn $ show dt
