{-# LANGUAGE FlexibleContexts, RankNTypes #-}
module ParserLS where

import Text.ParserCombinators.UU
import Text.ParserCombinators.UU.BasicInstances
import Text.ParserCombinators.UU.Utils
import SistemaL
import Data.Char
import Data.Maybe
import Data.List
import Text.Printf

-- %% Parser Interface %%
--execParser' :: Parser a -> String -> (a, [Error LineColPos])
--execParser' p = parse ((,) <$> p <*> pEnd) . createStr (LineColPos 0 0 0)

runParser' :: String -> Parser a -> String -> IO a
runParser' inputName p s
    = do let (a,b) = execParser p s 
         if null b
          then return a
          else printf "Failed parsing '%s' :\n%s" inputName (showErrors s b) >> return a
    where showErrors :: String -> [Error LineColPos] -> String
          showErrors s errs = foldr (\e r -> "-> " ++ (pruneError s e) ++ r) "\n" errs
          pruneError :: String -> Error LineColPos -> String
          pruneError _ (DeletedAtEnd x    ) = printf "\nUnexpected '%s' at end." x
          pruneError s (Inserted x pos exp) = prettyError s exp pos ++ printf "\n\t Corrected with inserting: '%s'" x
          pruneError s (Deleted  x pos exp) = prettyError s exp pos ++ printf "\n\t Corrected with deleting: %s" x

          prettyError :: String -> [String] -> LineColPos -> String
          prettyError s exp p@(LineColPos line c abs) = printf "\nExpected %s at %s :\n%s\n%s\n%s\n"
                                                           (show_expecting p exp)
                                                           (show p)
                                                           aboveString
                                                           inputFrag
                                                           belowString
                             where
                                s' = map (\c -> if c=='\n' || c=='\r' || c=='\t' then ' ' else c) s
                                aboveString = replicate 30 ' ' ++ "v"
                                belowString = replicate 30 ' ' ++ "^"
                                inputFrag   = replicate (30 - c) ' ' ++ (take 71 $ drop (c - 30) s')


parseFileSistemasL :: FilePath -> IO [SistemaL]
parseFileSistemasL file 
    = do input <- readFile file
         res <- runParser' file pSistemasL input
         mbres <- mapM verificar res
         return $ catMaybes mbres
    where verificar sl = case (testSistemaL sl) of
                             Left errs -> do mapM_ putStrLn errs
                                             return Nothing
                             Right sl  -> return $ Just sl

pSistemasL :: Parser [SistemaL]
pSistemasL = pSpaces *> pList pSistemaL <* pSpaces

pSistemaL :: Parser SistemaL
pSistemaL = SistemaL <$> pNombre <* pSymbol "{" <*> pAlfabeto
                                 <* pSymbol ";" <*> pInicio
                                 <* pSymbol ";" <*> pProducciones
                                 <* pSymbol "}"

pAlfabeto :: Parser Alfabeto
pAlfabeto = pKeyword "alfabeto" *> pSymbol "=" *> pListaS1 (pSymbol ",") pSLSimbolo

pInicio :: Parser Inicio
pInicio = pKeyword "inicio" *> pSymbol "=" *> pListaS1 (pSymbol ",") pSLSimbolo

pProducciones :: Parser Producciones
pProducciones = pKeyword "producciones" *> pSymbol "=" *> pListaS1 (pSymbol ";") pProduccion

pProduccion :: Parser Produccion
pProduccion = (,) <$> pSLSimbolo <* pSymbol "->" <*> pListaS1 (pSymbol ",") pSLSimbolo

pListaS1 :: Parser String -> Parser a -> Parser [a]
pListaS1 sep simb = pSymbol "[" 
                        *> pList1Sep sep simb <*
                    pSymbol "]" 

pListaS :: Parser String -> Parser a -> Parser [a]
pListaS sep simb = pSymbol "[" 
                        *> pListSep sep simb <*
                   pSymbol "]" 

pNombre :: Parser String
pNombre = lexeme $ unwords <$> pList1Sep_ng pSpaces pSimpleWord

pSLSimbolo :: Parser Simbolo
pSLSimbolo = lexeme $ Simbolo <$> pMunch funchar
    where funchar c = not $ elem c "[]{},; \n\r\t"

-- auxiliar parsers
pSimpleWord :: Parser String
pSimpleWord = pList1 (pLetter <|> pDigit) <?> "Simple Word"

pKeyword :: String -> Parser String
pKeyword = lexeme . pToken
