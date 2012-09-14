{-|
User Interface and Compilation process for L-System and Turtle movement

student: Carlos Gomez
date: Sat May 15 22:51:57 BOT 2010
-}
module Main where

import Graphics.UI.WXCore
import Graphics.UI.WX
import GenSequences
import Process
import ParserLS
import SistemaL

main :: IO()
main = start gui

-- | GUI for L-system
gui :: IO()
gui = do -- read the data base file of l-system
         db      <- readDataBase
         -- variables
         dbls    <- variable [value := db]       -- lista of l-systems
         points  <- variable [value := []]          -- list of point draw lines
         lsystem <- variable [value := head db]   -- actual l-system to use

         f       <- frame [text := "L-System And Turtle Movement"]
         screen  <- panel f [on paint := onScreenPaint points]       -- screen is the place where to draw the lines

         -- state turtle
         spanel  <- panel f []
         xs      <- entry spanel [text := "200"]
         ys      <- entry spanel [text := "200"]
         as      <- entry spanel [text := "0"]
         ds      <- entry spanel [text := "10"]
         bs      <- entry spanel [text := "90"]
         nl      <- entry spanel [text := "1"]
         brender <- button f [text := "Render", on command := render lsystem points xs ys as ds bs nl screen]
         bclear  <- button f [text := "Clear" , on command := set points [value := []] >> repaint screen]
         let opts = map getNombre db
         lstB    <- choice spanel [items := opts, selection := 0]
         set lstB [on select := chgSystem lsystem lstB dbls]
         updateDB <- button spanel [text := "Update DB", on command := updateDataBase lstB dbls lsystem]
         set spanel [layout := row 5 $
                          [         boxed "state turtle" (column 5 [ row 5 [label "x:", widget xs, label "y:", widget ys, label "angle a:", widget as]
                                                                   , row 5 [label "distance:", widget ds, label "angle b:", widget bs]])
                          , hfill $ boxed "L-System" (row 5 [label "L-System", widget lstB, label "Nro-Iterations", widget nl, widget updateDB])
                          ]]
         set f [layout := column 5 [ hfill $ widget spanel
                              , fill $ widget screen
                              , row 5 [hfill $ widget brender, hfill $ widget bclear]]]
         return ()

updateDataBase lstB dbls lsystem
    = do db <- readDataBase
         set dbls [value := db]
         let opts = map getNombre db
         set lstB [items := opts]
         set lsystem [value := head db]
         return ()

readDataBase 
    = do lss <- catch (parseFileSistemasL "./db/db.sl") (\err -> putStrLn (show err) >> return [])
         let defaultLS = SistemaL "Single Line" [Simbolo "F"] [Simbolo "F"] [(Simbolo "F",[Simbolo "F"])]
         return $ defaultLS : lss

-- | change the actual L-System to another
chgSystem lsystem chc dbls
    = do n  <- get chc selection
         db <- get dbls value
         let ls  = db !! n
         set lsystem [value := ls]

-- | generate a sequence and then render the sequence on screen
render lsystem points xs ys an ds bn nl screen 
    = do x <- get xs text
         y <- get ys text
         a <- get an text
         d <- get ds text
         b <- get bn text
         ns <- get nl text
         ls <- get lsystem value
         let c = black -- default init color
         -- we generate the sequense
         let sequence = generate ls (toInt ns)
         let tortuga = ((toDouble x, toDouble y, toRad (toDouble a)), toDouble d, toRad (toDouble b), c)
         listPoints <- get points value
         let newPoints = processSequence sequence tortuga listPoints
         set points [value := newPoints]
         repaint screen

-- | draw lines on screen according to the list of points
onScreenPaint points dc (Rect rx ry dx dy) 
    = do lst <- get points value
         mapM_ drawP lst
    where drawP ((x,y), (x',y'), c) = line dc (pt x (dy-y)) (pt x' (dy-y')) [color := c]

-- | Converts to Radians
toRad :: Double -> Double
toRad n = n / 360 * 2 * pi

-- | Converts to Int
toInt :: String -> Int
toInt = read

-- | Converts to Double
toDouble :: String -> Double
toDouble = read . fix
    where fix xss@(x:xs) = if x == '.' then '0':xss
                                       else let (tr, sr) = splitAt 2 xss
                                            in if tr == "-." then "-0."++sr
                                                             else xss

