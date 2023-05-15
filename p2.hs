{- Practico 2 (fuertemente tipado quiere decir que en tiempo de ejecución, el tipo
no va cambiar. Durante toda la ejecución del programa el tipo se mantiene.)
Cuando una funcion recibe un "a" (aparentemente sin tipo) va a convertirlo en un tipo que pueda operar
por ej, si el "a" es un entero, va a dejarlo tipado como entero, y al operarlo va a funcionar como
un numero entero. Si el "a" fue una lista, va a dejarlo como lista y va a operarlo como lista.
 Ejercicio 2
 Funcion head: devuelve el primer elemento de la lista -}
hd :: [a] -> a
hd (x:xs) = x --x es el primer elemento, xs es el resto de la lista = un elemento seguido de una lista

-- Funcion tail: devuelve una lista sin el primer elemento
tl :: [a] -> [a]
tl (x:xs) = xs --xs es toda la otra parte

-- Funcion last: devuelve el ultimo elemento de la lista
lst :: [a] -> a
lst [x] = x
lst (x:xs) = lst (xs)

-- Funcion init: devuelve una lista sin el ultimo elemento
inti :: [a] -> [a]
inti [x] = []
inti (x:xs) = x:inti (xs)

{- Ejercicio 3
Defina una función máximo de tres, tal que maxTres x y z es el máximo valor entre x, y, z .
Por ejemplo: maxTres 6 7 4 = 7 -}
max' :: Int -> Int -> Int
max' x y | x < y = y
         | otherwise = x

maxTres :: Int -> Int -> Int -> Int
maxTres x y z = max' x (max' y z) -- solo funciona en el interpretador xd

{- Ejercicio 4: Defina las siguientes operaciones sobre listas (vistas en el teórico): 
concatenar, tomar, tirar y flechita.
-}
conc :: (Eq a) => [a] -> [a] -> [a]
conc xs ys | ( xs == [] && ys == [] ) = []
           | ( xs /= [] && ys == [] ) = xs
           | ( xs == [] && ys /= [] ) = ys
           | ( xs /= [] && ys /= [] ) = hd(xs):conc xs ys

conc' :: [a] -> [a] -> [a]
conc' [] [] = []
conc' [] ys = ys
conc' xs [] = xs
conc' (x:xs) ys = x:conc' xs ys --pone a la cabeza de la 2da lista

tomar :: Int -> [a] -> [a] --Hace una lista con los n primeros elementos de la lista
tomar n [] = []
tomar 0 xs = []
tomar n (x:xs) = x:tomar (n-1) xs

tirar :: Int -> [a] -> [a] --Se deshace de los n primeros elementos de la lista
tirar n [] = []
tirar 0 xs = xs
tirar n (x:xs) = tirar (n-1) xs

flechitaReves :: a -> [a] -> [a] --Agrega un elemento al final
flechitaReves a [] = [a]
flechitaReves a xs = xs ++ [a]

concUlt :: a -> [a] -> [a]
concUlt n [] = [n]
concUlt n (x:xs) = x:concUlt n xs

-- Ejercicio 5: Defina una función abs: Int -> Int que calcula el valor absoluto de un número.
absM :: Int -> Int
absM x | x < 0 = -x
       | otherwise = x


{- Ejercicio 6: Defina una función edad :: (Nat,Nat,Nat) -> (Nat,Nat,Nat) -> Int que dada dos fechas
indica los años transcurridos entre ellas. Por ejemplo: edad (20,10,1968) (30,4,1987) = 18 -}
edad :: (Int,Int,Int) -> (Int,Int,Int) -> Int
edad (d1,m1,a1) (d2,m2,a2) | m1 < m2 = absM(a1-a2)
                           | m1 > m2 = absM(a1-a2)-1
                           | m1 == m2 && d1 > d2 = absM(a1-a2)-1
                           | m1 == m2 && d1 <= d2 = absM(a1-a2)

-- absM( (mod n1 31) + (mod (n2) 12) + (mod n3 2024) - (mod n4 31) - (mod n5 12) - (mod n6 2024) )

{- Ejercicio 7: La disyunción excluyente xor de dos fórmulas se verifica si una es verdadera y 
la otra es falsa. Defina la función xor que calcule la disyunción excluyente a partir de la tabla 
de verdad. Ahora defina la función xor2 que calcule la disyunción excluyente pero sin que considere 
todos los posibles valores de las entradas. ¿Cuál será la diferencias entre ambas definiciones? -}

xor :: Bool -> Bool -> Bool
xor p q | p == True && q == True = False
        | p == True && q == False = True
        | p == False && q == True = True
        | p == False && q == False = False

xor2 :: Bool -> Bool -> Bool
xor2 p q | p == True && q == False = True
         | p == False && q == True = True
         | otherwise = False

xor3 :: Bool -> Bool -> Bool
xor3 True False = True
xor3 False True = True
xor3 _ _ = False

-- Diferencia en cuanto a definiciones ni valores de verdad ninguno, pero se ahorran casos
-- y hace más legible la función. Solo destacamos los dos casos que nos importan

-- Ejercicio 8: Defina una función que dado un número natural, decida si el mismo es primo o no.
primo :: Int -> Bool -- Se rompe con 979
primo x | ( x == 1 || x == 2 || x == 3 || x == 5 ) = True
        | ( (mod x 2) == 0 || (mod x 3) == 0 || (mod x 4) == 0 || (mod x 5) == 0 ) = False
        | otherwise = True

prim' :: Int -> Int -> Bool
prim' x 1 = False
prim' x y = mod x y == 0 || prim' x (y-1)

prim :: Int -> Bool
prim 1 = False
prim 2 = True
prim x = not (prim' x (x-1))

{- Ejercicio 9: Defina una función que dado un número natural n, retorne la lista de todos
los números naturales primos menores que n.
listaPrimosMenores :: Int -> [Int]
listaPrimosMenores n | n == 1 = []
                     | n == 2 = [1]
                     | n == 3 = [1,2]
                     | n == 5 = [1,2,3]
listaPrimosMenores completar y primMen funca maso, pq no los menores de n sino n tambien...-}
primMen :: Int -> [Int]
primMen n | n <= 0 = []
          | otherwise = if (primo n == False) then primMen(n-1) else [n] ++ primMen(n-1)

-- Ejercicio 10: Defina una función que dada una lista, retorne la reversa de la misma.
rev :: [a] -> [a]
rev [] = []
rev (x:xs) = rev (xs) ++ [x]

-- Ejercicio 11: Defina una función que dadas dos listas, decida si las listas son iguales.
listIgu :: (Eq a) => [a] -> [a] -> Bool
listIgu [] [] = True
listIgu xs [] = False
listIgu [] ys = False
listIgu (x:xs) (y:ys) = if (x == y) then listIgu xs ys else False

longitud :: [a] -> Int
longitud [] = 0
longitud (x:xs) = 1 + longitud xs


-- Ejercicio 12: Defina una función que dada una lista decida si es un palı́ndromo o no.
palindromo :: (Eq a) => [a] -> Bool
palindromo [] = True
palindromo xs = if (listIgu xs (reverse xs)) then True else False

-- Ejercicio 13: Defina una función que dados tres números a, b, c devuelva la cantidad de
-- raı́ces reales de la ecuación a(x^2) + bx + c = 0
rReales :: Float -> Float -> Float -> Int
rReales a b c | (b^2) - 4*a*c > 0 = 2
              | (b^2) - 4*a*c < 0 = 0
              | otherwise = 1

