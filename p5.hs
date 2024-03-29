{-
1. Generar una lista infinita de unos.
[1,1..] [n|n<-[1,1..]]

2. Generar una lista infinita de naturales comenzando desde un numero dado.
[n,(n+1)..] [n|x<-[1,2..n],n>x]

3. Generar una lista con los primeros n naturales.
linf = [1,2..]
take n linf

4 *. Retornar los primeros 5 elementos de una lista infinita de enteros positivos.
linf = [0,1..]
primeros5 :: [Int]
primeros5 = take 5 linf

Utilizando funciones de alto orden resolver:
5. Dada una lista de enteros, retornar sus cuadrados, es decir, dado [x0, x1, . . . , xn]
deberia retornar [x^20, x^21, . . . , x^2n] -}
cuadList :: [Int] -> [Int]
cuadList [] = []
cuadList (x:xs) = (x^2) : cuadList xs

cuadList' :: [Int] -> [Int]
cuadList' [] = []
cuadList' (x:xs) = map (^2) (x:xs)

{- 6. Dado un entero positivo, retornar la lista de sus divisores. -}
tomarN :: Int -> [Int]
tomarN 0 = []
tomarN x = take x [1,2..]

divisores :: Int -> [Int]
divisores n | n==0 = [1,2..]
            | otherwise = [x|x<-[1..n],mod n x == 0]

esDiv' :: Int -> Int -> Bool
esDiv' n m = mod n m == 0

divisores' :: Int -> [Int]
divisores' 0 = [1,2..]
divisores' n = filter (esDiv' n) (tomarN n)

{- 7. Dada una lista de naturales, obtener la lista que contenga solo los numeros primos de la lista original. -}
esPrimo' :: Int -> Int -> Bool
esPrimo' x 1 = False
esPrimo' x n = mod x n == 0 || esPrimo' x (n-1)

esPrimo :: Int -> Bool
esPrimo 1 = False
esPrimo x = not(esPrimo' x (x-1))

listPrim :: [Int] -> [Int]
listPrim xs = filter esPrimo xs

{- 8 *. Dada una lista de naturales, retornar la suma de los cuadrados de la lista.-}
cuadrado :: Int -> Int
cuadrado x = x*x

sumaCuad :: [Int] -> Int
sumaCuad [] = error "sumaCuad: Undefined for empty lists"
sumaCuad xs = sum (map cuadrado xs)

{- 9. Dada una lista de naturales, retornar la lista con sus sucesores. -}
sucesorNat :: [Int] -> [Int]
sucesorNat [] = []
sucesorNat xs = map (+1) xs

{- 10. Dada una lista de enteros, sumar todos sus elementos. -}
sumadorLista :: [Int] -> Int
sumadorLista [] = 0
sumadorLista (x:xs) = x + sumadorLista xs

sumElemInt :: [Int] -> Int
sumElemInt xs = foldl (+) 0 xs

{- 11 *. Definir el factorial usando fold. -}
factFold :: Int -> Int
factFold 0 = 1
factFold n = foldl (*) 1 [1..n]

{-12 *. Redefinir la funcion and tal que and xs se verifica si todos los elementos de xs son verdaderos. Por ejemplo: 
and [1<2, 2<3, 1/=0] = True, and [1<2, 2<3, 1 == 0] = False. -}
myAnd :: [Bool] -> Bool
myAnd [] = True
myAnd (x:xs) = x && myAnd xs 

{- 13. Usando foldl o foldr definir una funcion tam::[a]->Int que devuelve la cantidad de elementos de una lista dada. Dar un ejemplo en los cuales foldr y foldl evaluen diferente con los mismos parametros. -}
sumListl :: Int -> a -> Int
sumListl n _ = n+1

taml :: [a] -> Int
taml xs = foldl (sumListl) 0 xs

sumListr :: a -> Int -> Int
sumListr _ n = n+1

tamr :: [a] -> Int
tamr xs = foldr (sumListr) 0 xs

{- Utilizando listas por comprension resolver:
14. Dada una lista de enteros, retornar sus sucesores. -}
lSuc :: [Int] -> [Int]
lSuc [] = []
lSuc xs = [e+1 | e <- xs]

{- 15 *. Dada una lista de naturales, retornar sus cuadrados. -}
lCuad :: [Int] -> [Int]
lCuad [] = []
lCuad xs = [e*e | e <- xs]

{- 16. Dada una lista de enteros, retornar los elementos pares que sean mayores a 10. -}
lParesMay10 :: [Int] -> [Int]
lParesMay10 [] = []
lParesMay10 xs = [e | e <- xs , mod e 2 == 0 && e > 10]

{- 17. Dado un entero, retornar sus divisores. -}
lDivisores :: Int -> [Int]
lDivisores x = [e | e <- [1,2..x] , mod x e == 0]

{- 18 *. Definir la funcion todosOcurrenEn :: Eq a => [a] -> [a] -> Bool tal que todos
OcurrenEn xs ys se verifica si todos los elementos de xs son elementos de ys. Por ejemplo: todosOcurrenEn [1,5,2,5] [5,1,2,4] = True,
todosOcurrenEn [1,5,2,5] [5,2,4] = False 
notElem :: (Foldable t, Eq a) => a -> t a -> Bool compara los elem de x con y, si x no pertenece lo guarda, si esta no lo guarda. el null sobre esa lista devuelve true si esta vacia o falso si tiene algo
null :: Foldable t => t a -> Bool -}
todosOcurrenEn :: Eq a => [a] -> [a] -> Bool
todosOcurrenEn xs ys = length([x | x <- xs , x `notElem` ys]) == 0

{- 19. Dado un natural n, retornar los numeros primos comprendidos entre 2 y n.
esPrimo' :: Int -> Int -> Bool
esPrimo' x 1 = False
esPrimo' x n = mod x n == 0 || esPrimo' x (n-1)

esPrimo :: Int -> Bool
esPrimo 1 = False
esPrimo x = not(esPrimo' x (x-1))
-}
lPrimosN :: Int -> [Int]
lPrimosN n = [x | x <- [2,3..n] , esPrimo x]

{- 20. Dadas dos listas de naturales, retornar su producto cartesiano. -}
lProdCart :: [Int] -> [Int] -> [(Int,Int)]
lProdCart [] [] = []
lProdCart xs ys = [(x,y) | x <- xs , y <- ys]

{- 21 *. Dadas una lista y un elemento retornar el numero de ocurrencias del elemento x en la lista ys. -}
cantOcurr :: Eq a => [a] -> a -> Int
cantOcurr [] _ = 0
cantOcurr xs x = length ([e | e <- xs , e == x])

{- si el elemento esta en la lista quiero que ingrese un 1 en la lista que se esta creando (por comprension) y que despues sume todos los 
1 de la lista -> devuelve la cant de ocurrencias -}
listOcu :: Eq a => a -> [a] -> Int
listOcu x [] = 0
listOcu x xs = foldl (+) 0 [y | y <- [1] , e <- xs , e == x]
--listOcu x xs = foldl (+) 0 [y | y <- [0,1] , e <- xs , e == x && y == 0] -- siempre que Predicado(e,x,y) pone ceros (se rompe)
--listOcu x xs = foldl (+) 0 [y | y <- [0,1] , e <- xs , e == x && y == 1] -- siempre que Predicado(e,x,y) pone unos en la lista
--listOcu x xs = foldl (+) 0 [1 | e <- xs , e == x] -- pone unos en una lista siempre que Predicado(e,x) 

{- 22. Escribir la funcion split2 :: [a] -> [([a],[a])], que dada una lista xs, devuelve la lista con todas las formas de partir xs en 
dos. Por ejemplo: split2 [1,2,3] = [([],[1,2,3]), ([1],[2,3]), ([1,2],[3]),([1,2,3],[])]. -}
split2 :: [a] -> [([a],[a])]
split2 xs = [(take i xs,drop i xs) | i <- [0..length xs]]

--Chat
split2' :: [a] -> [([a], [a])]
split2' [] = [([], [])] -- Caso base: lista vacía, retorna una lista con una tupla de dos listas vacías
split2' (x:xs) = ([], x:xs) : [(x:ys, zs) | (ys, zs) <- split2 xs]

{- 23 *. Definir una funcion que, dada una lista de enteros, devuelva la suma de la suma de todos los segmentos iniciales.
Por ejemplo: sumaSeg [1,2,3] = 0 + 1 + 3 + 6 = 10. -}
sumatoria :: Int -> Int
sumatoria 0 = 0
sumatoria n = n + sumatoria (n-1)

sumaSeg :: [Int] -> Int
sumaSeg [] = 0
sumaSeg (x:xs) = foldl (+) 0 (map sumatoria (x:xs))
-- map sumatoria (x:xs) = [1,3,6] . Le aplico foldl de la suma con el neutro y va a sumar 1+3+6 = 10
-- sumaSeg [1,5,6,7] = 0 + 1 + 6 + 12 + 19 = 38

-- 24. Definir la lista infinita de los numeros pares.
infPares = [x | x <- [0,1..] , mod x 2 == 0]
