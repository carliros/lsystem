{-# LANGUAGE FlexibleContexts, RankNTypes #-}
module ParserLS where

import Text.ParserCombinators.UU
import Text.ParserCombinators.UU.BasicInstances
import Text.ParserCombinators.UU.Utils ( runParser, lexeme, pDigit, pLetter, pSpaces, pSymbol )
import SistemaL
import Data.Char
import Data.Maybe
import Data.List
import Text.Printf

parseFileSistemasL :: FilePath -> IO [SistemaL]
parseFileSistemasL file 
    = do input <- readFile file
         let res = runParser file pSistemasL input :: [SistemaL]
         mbres <- mapM verificar res
         return $ catMaybes mbres
    where verificar sl = case testSistemaL sl of
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
    where funchar c = c `notElem` "[]{},; \n\r\t"

-- auxiliar parsers
pSimpleWord :: Parser String
pSimpleWord = pList1 (pLetter <|> pDigit) <?> "Simple Word"

pKeyword :: String -> Parser String
pKeyword = lexeme . pToken
