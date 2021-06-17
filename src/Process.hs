-- | Este modulo abstrae el movimiento Tortuga, su estado y la forma en que lo procesa
module Process (
-- * Estado Tortuga
  Tortuga
, Estado
, Distancia
, Angulo
, PosX
, PosY
, Points
-- * Procesar Secuancia
, processSequence
) where

import SistemaL

-- | Representa el estado de una tortuga
type Tortuga = ( Estado         -- estado actual de la tortuga
               , Distancia      -- distancia que que avanza la tortuga
               , Angulo         -- angulo con que gira
               , Color          -- color con el que dibuja
               )

type Distancia = Double
type Angulo    = Double
type PosX      = Double
type PosY      = Double

data Color = Black | Darkgrey | Dimgrey | Mediumgrey | Grey | Lightgrey | White | Red | Green | Blue | Cyan | Magenta | Yellow

-- | Representa el estado actual de una tortuga
type Estado = ( PosX        -- su posicion x
              , PosY        -- su posicion y
              , Angulo      -- su angulo
              )

type Points = [((Int,Int),(Int,Int), Color)]

-- | procesa una lista de secuencias
processSequence :: [Simbolo] -> Tortuga -> Points -> Points
processSequence seq state points 
    = let (newPoints, newState) = foldl funMix (points,state) seq
      in newPoints
    where funMix (points, state) cmd = doCommand cmd state points

-- | procesar un comando especifico
doCommand :: Simbolo -> Tortuga -> Points -> (Points, Tortuga)
doCommand simb state@((x, y, an), d, bn, c) points
    = let getCmd     (Simbolo str) = head str
          getCmdName (Simbolo str) = str
      in case getCmd simb of
            'F' -> let (x', y') = (x + d * cos an, y + d * sin an)
                       ptline = ((round x, round y),(round x',round y'), c)
                       newPoints = ptline : points
                       newState  = ((x', y', an), d, bn, c)
                   in (newPoints, newState) 

            'f' -> let (x', y') = (x + d * cos an, y + d * sin an)
                       newState = ((x', y', an), d, bn, c)
                   in (points, newState)

            '+' -> let newState = ((x, y, an + bn), d, bn, c)
                   in (points, newState) 
            
            '-' -> let newState = ((x, y, an - bn), d, bn, c)
                   in (points, newState) 

            _   -> case getCmdName simb of
                      "black"       -> let newState = ((x, y, an), d, bn, Black)
                                       in (points, newState)
                      "darkgrey"    -> let newState = ((x, y, an), d, bn, Darkgrey)
                                       in (points, newState)
                      "dimgrey"     -> let newState = ((x, y, an), d, bn, Dimgrey)
                                       in (points, newState)
                      "mediumgrey"  -> let newState = ((x, y, an), d, bn, Mediumgrey)
                                       in (points, newState)
                      "grey"        ->  let newState = ((x, y, an), d, bn, Grey)
                                       in (points, newState)
                      "lightgrey"   -> let newState = ((x, y, an), d, bn, Lightgrey)
                                       in (points, newState)
                      "white"       -> let newState = ((x, y, an), d, bn, White)
                                       in (points, newState)
                      "red"         -> let newState = ((x, y, an), d, bn, Red)
                                       in (points, newState)
                      "green"       -> let newState = ((x, y, an), d, bn, Green)
                                       in (points, newState)
                      "blue"        -> let newState = ((x, y, an), d, bn, Blue)
                                       in (points, newState)
                      "cyan"        -> let newState = ((x, y, an), d, bn, Cyan)
                                       in (points, newState)
                      "magenta"     -> let newState = ((x, y, an), d, bn, Magenta)
                                       in (points, newState)
                      "yellow"      -> let newState = ((x, y, an), d, bn, Yellow)
                                       in (points, newState)
                      _             -> (points,state)   -- error "[Process] Unknow Command."

