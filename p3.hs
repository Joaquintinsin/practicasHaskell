{- 1. Define una función que, dadas dos listas ys y xs de naturales ordenadas,
retorne el merge de estas listas, es decir, la lista ordenada compuesta por los
elementos de ys y xs. -}
merge :: [Int] -> [Int] -> [Int]
merge [] [] = []
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys) | (x <= y) = x:merge xs (y:ys)
                    | otherwise = y:merge (x:xs) ys

-- 2. Define una función que, dada una lista de naturales, la ordene.
inti :: [a] -> [a]
inti [x] = []
inti (x:xs) = x:inti (xs)

lst :: [a] -> [a]
lst [x] = [x]
lst (x:xs) = lst (xs)

burbujeo :: [Int] -> [Int]
burbujeo [] = []
burbujeo [x] = [x]
burbujeo (x:y:xs) | (x <= y) = x:burbujeo (y:xs)
                  | otherwise = y:burbujeo (x:xs)

ordenar :: [Int] -> [Int]
ordenar [] = []
ordenar [x] = [x]
ordenar (x:xs) = ordenar(inti (burbujeo (x:xs))) ++ (lst(burbujeo (x:xs)))

longitud :: [a] -> Int
longitud [] = 0
longitud (x:xs) = 1+longitud xs

{- 3. Define una función que, recursivamente y sólo utilizando adición y multiplicación, 
calcule, dado un natural n, el número 2^n . -}
potDos :: Int -> Int
potDos 0 = 1
potDos n = 2*potDos(n-1)

{- 4. Define una función que, dado un número natural n, retorne su representación
binaria como secuencia de bits. -}
secBin1 :: Int -> [Int]
secBin1 0 = []
secBin1 n = (mod n 2):secBin1 (div n 2)

secBin :: Int -> [Int]
secBin 0 = [0]
secBin x = reverse(secBin1 x)

{- 5 *. Define una función que, dado un número natural n en su representación
binaria, decida si n es par o no. -}
binPar :: [Int] -> Bool
binPar xs | (head(reverse(xs)) == 0) = True
          | otherwise = False

{- 6. Define la función que retorne la distancia de Hamming: dadas dos listas es el
número de posiciones en que los correspondientes elementos son distintos. Por
ejemplo: distanciaH ”roma””camino”− > 3
distanciaH ”romano””rama”− > 1 -}
absM :: Int -> Int
absM x | (x < 0) = -x
       | otherwise = x

distanciaH :: (Eq a) => [a] -> [a] -> Int
distanciaH [] [] = 0
distanciaH [] ys = 0
distanciaH xs [] = 0
distanciaH (x:xs) (y:ys) | (x /= y) = 1+distanciaH xs ys
                         | otherwise = distanciaH xs ys

{- 7. Define la función que, dado un número natural, decida si el mismo es un
cuadrado perfecto o no. -}
listaCuadr :: Int -> Int -> [Int]
listaCuadr x 0 = []
listaCuadr x n | ((n-1)*(n-1) == x) = (n-1):listaCuadr x (n-1)
               | otherwise = listaCuadr x (n-1)

cuadPerf :: Int -> Bool
cuadPerf 0 = True
cuadPerf n = if (longitud(listaCuadr n n) >= 1) then True else False

perfSq :: Int -> Bool
perfSq x | ((longitud xs) /= 0) = True
         | otherwise = False
    where
        xs = [n | n <- [0..x] , n*n == x]

{- 8. Define la función repetidos de forma tal que dado una lista de elementos, un elemento z y 
un entero n; z aparece n veces. Retorne verdadero o falso. -}
contador :: (Eq a) => [a] -> a -> Int
contador [] n = 0
contador (x:xs) n | (x == n) = 1+contador xs n
                  | otherwise = contador xs n

elemRepetidos :: (Eq a) => [a] -> a -> Int -> Bool
elemRepetidos _ _ 0 = True
elemRepetidos [] _ n = False
elemRepetidos (x:xs) z n | (n == (contador (x:xs) z)) = True
                         | otherwise = False

{- 9. Define la función nelem tal que nelem xs n es elemento enésimo de xs,
empezando a numerar desde el 0. Por ejemplo:
nelem [1, 3, 2, 4, 9, 7] 3 −> 4 -}
nElem' :: [a] -> Int -> a
nElem' (x:xs) n = if (n <= 0) then x else nElem' xs (n-1)

nElem :: [a] -> Int -> a
nElem (x:xs) n | (n == 0) = x
               | otherwise = nElem xs (n-1)

idx :: [a] -> Int -> a
idx (x:xs) 0 = x
idx (x:xs) n = idx xs (n-1)

{- 10 *. Define la función posicionesC tal que posicionesC xs c es la lista de la
posiciones del caracter c en la cadena xs. Por ejemplo:
posicionesC ”Catamarca” a −> [1, 3, 5, 8] -}
-- pos entra la lista, el elemento y el int inicializado en 0 que es la primera pos de la lista
pos :: Eq a => [a] -> a -> Int -> [Int]
pos [] _ _ = []
pos (x:xs) a n | (x == a) = n:pos xs a (n+1)
               | otherwise = pos xs a (n+1)
-- lo unico q hace es inicializar en cero xd
posicionesC :: Eq a => [a] -> a -> [Int]
posicionesC xs a = pos xs a 0

{- 11. Define la función compact, dada una lista retorna la lista sin los elementos
repetidos consecutivos. Por ejemplo: compact [1, 3, 3, 5, 8, 3] = [1, 3, 5, 8, 3]. -}
compact :: (Eq a) => [a] -> [a]
compact [] = []
compact [x] = [x]
compact (x:y:xs) | (x == y) = compact (y:xs)
                 | otherwise = x:compact (y:xs)


