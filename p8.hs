-- 1. Definir la función nand a b = not (a && b) en Haskell sin utilizar not y &&.
nand:: Bool->Bool->Bool
nand True True = False
nand _ _ = True

-- ----------------------------------------------------
-- 2. Definir en Haskell la función
-- maj retorna True sii al menos 2 argumentos son True.
-- ----------------------------------------------------
maj :: Bool -> Bool -> Bool -> Bool
maj True True _ = True
maj True _ True = True
maj _ True True = True
maj _ _ _ = False

-- ---------------------------------------------------- 
-- Para las siguientes funciones se debe respetar el 
-- perfil propuesto.
-- La lista [Int] de paraTodo representa las posiciones 
-- sobre las que cuantificamos en [a].
-- Mientras que (Int -> [a] -> Bool) es la propiedad.
--		Ejemplo: paraTodo [0,1,2,3] [4,1,2,6] even 
--		retorna False, ya que existe una posición 
--		en la que el elemento de la lista es impar. 
--		paraTodo [0,2,4,6] [2,2,4,4,4,5,6] even  
--		retorna True.
-- ----------------------------------------------------
{-
3. En Haskell un predicado sobre un tipo A es una función p :: A −> Bool,
por ejemplo:
    even :: Int −> Bool
    even x = x ‘mod ‘ 2 == 0

Se puede pensar como un predicado sobre números cuya variable libre es x.
Además en Haskell tenemos las siguientes funciones que operan sobre listas de
booleanos:
    and :: [Bool] −> Bool
retorna True sii todos los elementos son True
    or :: [Bool] −> Bool
retorna True sii al menos un elemento es True

Con estos dos operadores y listas por comprensión podemos escribir una
versión ejecutable de los cuantificadores en Haskell. Por ejemplo el siguiente
cuantificador:
    (∀i : 0 ≤ i < #xs : even xs.i)
Puede escribirse literalmente como:
    and [even (xs !! i) | i <- [0..(length xs) - 1]]
Pero en Haskell lo más común es escribirlo de la siguiente forma:
    and [even x | x <- xs]

Utilizar estas ideas para escribir los siguientes cuantificadores:
    · (∃i : 0 ≤ i < #xs : p xs.i)
    · (∀i : 0 ≤ i < #xs : p xs.i)
Para un predicado p dado.

· or[p (xs!!i) | i <- [0..(length xs) - 1]]
  or[p x | x <- xs]
· and[p (xs!!i) | i <- [0..(length xs) - 1]]
  and[p x | x <- xs]
-}
paraTodoMio :: [Int] -> [a] -> (Int -> [a] -> Bool) -> Bool
paraTodoMio [] _ f = True
paraTodoMio (x:xs) [] f = True
paraTodoMio (x:xs) (y:ys) f = and [f i (y:ys) | i <- (x:xs)]

paraTodoClase :: [Int] -> [a] -> (Int -> [a] -> Bool) -> Bool
paraTodoClase indices xs f = and [f i xs | i <- indices]

even' :: Int -> [Int] -> Bool
even' n [] = True
even' n (x:xs) = even ((x:xs)!!n) -- && even' n xs ... si recurso sobre xs muevo la lista original

-- ----------------------------------------------------
-- La lista [Int] de paraTodo representa las posiciones 
-- sobre las que cuantificamos en [a]. 
-- (Int -> [a] -> Bool) es la propiedad.
--
--		Ejemplo: existe [0,1,2,3] [4,1,2,6] odd
--		retorna True.
-- ----------------------------------------------------
existe :: [Int] -> [a] -> (Int -> [a] -> Bool)-> Bool
existe [] _ f = False
existe (x:xs) [] f = False
existe (x:xs) (y:ys) f = or [f i (y:ys) | i <- (x:xs)]

odd' :: Int -> [Int] -> Bool
odd' n [] = False
odd' n (x:xs) = odd ((x:xs)!!n) -- || odd' n xs ... si recurso sobre xs muevo la lista original

{-
4. Utilizando las ideas asociadas a listas por comprensión, y las funciones
sum, product, y length, escribir los cuantificadores de sumatoria, productoria y
contatoria para ejemplos concretos.
-}

sumatoria :: [Int] -> [Int] -> (Int -> Bool) -> Int
sumatoria [] _ f = 0
sumatoria (p:ps) [] f = 0
sumatoria (p:ps) xs f = sum [(xs!!i) | i <- (p:ps) , f (xs!!i)]

contatoria :: [Int] -> [Int] -> (Int -> [Int] -> Bool) -> Int
contatoria is xs p = length [i | i <- is , p i xs]

{-
sumatoria ::Num a => [Int] -> [a] -> (a -> Bool) -> Int
sumatoria [] _ f = 0
sumatoria (p:ps) [] f = 0
sumatoria (p:ps) xs f = sum [(xs!!i) | i <- (p:ps) , f (xs!!i)]
-}

productoriaMio :: [Int] -> [Int] -> (Int -> [Int] -> Int) -> Int
productoriaMio [] _ f = 0
productoriaMio (p:ps) [] f = 0
productoriaMio (p:ps) xs f = (f p xs) * (productoriaMio ps xs f)

productoriaClase :: [Int] -> [Int] -> (Int -> [Int] -> Int) -> Int
productoriaClase is xs p = product [p i xs | i <- is]
