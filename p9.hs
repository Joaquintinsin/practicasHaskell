Práctico 9: Especificaciones

Para tener en cuenta algunos conceptos: por subsegmento de xs o subsecuencia 
de xs entendemos a cualquier lista cuyos elementos están en xs, en el mismo orden y consecutivamente. 
Por ejemplo, si la lista es xs = [1, 4, 2, 1, 1, 8, 7] los siguientes son ejemplos de subsegmentos:
    · secuencia vacı́a: [].
    · subsegmento unitario [4].
    · subsegmento inicial [1, 4].
    · [2, 1, 1].
    · [1, 4, 2, 1, 1, 8, 7].
    · subsegmento final [8, 7].

#############################################################################
# Ejercicio 1. Expresar en lenguaje formal (de primer orden) las siguientes #
# especificaciones.                                                         #
#############################################################################
#  a) f es una función que determina si los elementos de una lista xs son iguales.
f xs : (paraTodo i : 0 <= i < length xs - 1 : xs.i == xs.(i+1))
f xs : (paraTodo i : 0 <= i < #xs : xs.0 == xs.i)

f1a :: Eq a => [a] -> Bool
f1a xs = and[head xs == xs!!i | i <- [0..(length xs)-1]]

#  b) f es una función que determina si los elementos de una lista xs son todos diferentes.
f xs : (paraTodo i : 0 <= i < length xs - 1 : xs.i /= xs.(i+1))
f xs : (paraTodo i,j : 0 <= i < #xs ^ 0 <= j < #xs ^ i /= j : xs.i /= xs.j)
f xs : (paraTodo i : 0 <= i < #xs : (paraTodo j : 0 <= j < i : xs.i /= xs.j))
f xs : not(exists i : 0 <= i < length xs - 1 : xs.i == xs.(i+1))

f1b :: Eq a => [a] -> Bool
f1b xs = not(or[xs!!i == xs!!(i+1) | i <- [0..(length xs)-2]])
--f1b xs = and[ and[xs!!i /= xs!!j | j <- [0..i]] | i <- [0..(length xs)-1] ]

#  c) f es una función que determina si los elementos de una lista xs están ordenados.
f xs : (paraTodo i : 0 <= i < length xs - 1 : xs.i <= xs.(i+1))

f1c :: Ord a => [a] -> Bool
f1c xs = and[xs!!i <= xs!!(i+1) | i <- [0..(length xs)-2]]

#  d) P es un predicado que es true sii cuando aparece 1 en xs entonces debe aparecer 0 en xs.
P xs : (exists j : 0 <= j < length xs : (xs.j == 1) ^ (exists i : 0 <= i < length xs : xs.i == 0))
P xs : (exists j : 0 <= j < length xs : (xs.j == 1)) -> (exists i : 0 <= i < length xs : xs.i == 0)

p1d :: [Int] -> Bool
p1d xs = if or[xs!!j == 1 | j <- [0..(length xs)-1]] 
        then or[xs!!i == 0 | i <- [0..(length xs)-1]]
        else False

#  e) p es el producto de todos los elementos primos de xs. 
P xs : (productoria i : 0 <= i < length xs ^ prime (xs.i) : xs.i)
    where
        prime Num -> Bool
        prime n : not(paraTodo i : 0 <= i < #xs - 1 : n ´mod´ i == 0)
        prime n : (contatoria i : 0 <= i < #xs - 1 : n ´mod´ i) == 2

p1e :: [Int] -> Int
p1e xs = product[xs!!i | i <- [0..(length xs)-1] , esPrimo(xs!!i)]

esPrimo' :: Int -> Int -> Bool
esPrimo' x 1 = False
esPrimo' x n = mod x n == 0 || esPrimo' x (n-1)

esPrimo :: Int -> Bool
esPrimo 1 = False
esPrimo x = not(esPrimo' x (x-1))

###############################################################################
# Ejercicio 2. Sea xs un lista no vacı́a con elementos booleanos, tal que true #
# aparezca al menos una vez en la lista. Especificar:                         #
###############################################################################
#  a) n es el menor entero tal que xs.n = true.
(Min n : -inf < n < +inf ^ xs.n == True : n) {si no hay true devuelve el neutro: +inf}
(Min n : 0 <= n < #xs ^ xs.n == True : n)    {si no hay true devuelve el neutro: #xs-1}

#  b) n es el último elemento de la lista tal que xs.n = true.
(Max n : 0 <= n < #xs ^ xs.n == True : n)

#  c) f es una función que devuelve true si y solo si todos los elementos de xs son equivalentes.
f xs : (paraTodo i : 0 <= i < length xs - 1 : xs.i)
f xs : not(exists i : 0 <= i < length xs : xs.i == False)

######################################################
# Ejercicio 3. Especificar las siguientes funciones: #
######################################################
#  a) f.xs determina si xs tiene la misma cantidad de pares que impares.
f xs : (contatoria i : 0 <= i < #xs : xs.i ´mod´ 2 == 0) == (contatoria i : 0 <= i < #xs : xs.i ´mod´ 2 == 1)
f xs : (paraTodo i : 0 <= i < #xs : (contatoria j : 0 <= j < #xs ^ j /= i : xs.j ´mod´ 2 = 0)
                                    = (contatoria k : 0 <= k < #xs ^ k /= i : xs.k ´mod´ 2 = 1))

#  b) f.n determina si n es primo.
f n : (contatoria i : 1 <= i <= n : n ´mod´ i = 0) = 2

#  c) f.xs.ys determina si ys es una subsecuencia de xs.
f xs ys : (exists as,bs : True : xs = (as++ys++bs))

#  d) f.xs.ys determina si ys es una subsecuencia final de xs.
f xs ys : (exists as,bs : True : xs = (as++ys++bs))
f xs ys : (exists as : True : xs = (as++ys))

##########################################
# Ejercicio 4. Especificar lo siguiente: #
##########################################
#    a) Dada una lista de enteros, especifique la suma del subsegmento de suma mı́nima de la lista. 
# Por ejemplo, si la lista es xs = [1, −4, −2, 1, −5, 8, −7] el subsegmento que da la suma 
# mı́nima es [−4, −2, 1, −5], cuya suma es -10. 
# Si xs = [1, 3, 5] , el subsegmento que da la suma mı́nima es [] , pues la suma de la lista vacı́a 
# es cero.
f xs : (Min as : (exists bs,cs : True : xs = (bs++as++cs)) : Sum (as) )
    f4a :: [Int] -> Int
    f4a = min [sum as | xs == bs++as++cs]

#  b) Especifique la función maxigual que determina la longitud del máximo subsegmento en donde todos 
# sus elementos son iguales: maxigual : [A] -> Num. 
# [1,2,3,4] = 0   , [1,2,3,2,4] = 0
# [2,2,1,3,4] = 2
# [1,1,1,3,2,2,3,4,3,5,3,6,3,3] = 3
maxigual xs : (Max as,bs,cd : as++bs++cs == xs ^ iguales (bs) : #bs)
    iguales xs : (paraTodo i : 0 <= i < #xs : xs.0 == xs.i)

#  c) Especifique la función maxdistinto : [Int]− > Int que determina la longitud del subsegmento más 
# largo en donde todos los elementos son distintos.
maxdistinto xs : (Max as,bs,cd : as++bs++cs == xs ^ iguales (bs) : #bs)
    distinto xs : (paraTodo i,j : 0 <= i <= j < #xs : i==j v xs.i /= xs.j)

#######################################################################################################
# Ejercicio 5. Dadas las funciones split3 :: [a] -> [([a], [a], [a])] y split2 :: [a] -> [([a], [a])] #
# dadas en clases. Escribir las siguientes especificaciones usando listas por comprensión:            #
#######################################################################################################
#  a) La especificación del ejercicio 1(e).
P xs : (productoria i : 0 <= i < length xs ^ prime (xs.i) : xs.i)
    where
        prime Num -> Bool
        prime n : not(paraTodo i : 0 <= i < #xs - 1 : n ´mod´ i == 0)
        prime n : (contatoria i : 0 <= i < #xs - 1 : n ´mod´ i) == 2

esPrimo' :: Int -> Int -> Bool
esPrimo' x 1 = False
esPrimo' x n = mod x n == 0 || esPrimo' x (n-1)

esPrimo :: Int -> Bool
esPrimo 1 = False
esPrimo x = not(esPrimo' x (x-1)) -}

f5a :: [Int] -> Int
f5a xs = product [xs!!i | i <- [0..(length xs)-1] , esPrimo(xs!!i)]

#  b) La especificación del ejercicio 3(c).
f xs ys : (exists as,bs : True : xs = (as++ys++bs))

f5b :: Eq a => [a] -> [a] -> Bool
f5b xs ys = or[ys == bs | (as,bs,cs) <- split3 xs]

#  c) La especificación del ejercicio 3(d).
f xs ys : (exists as : True : xs = (as++ys))

f5c :: Eq a => [a] -> [a] -> Bool
f5c xs ys = or[ys==cs | (as,cs) <- split2 xs]

#  d) La siguiente especificación: Dada una lista de números, calcular el valor de subsegmento
# de suma máxima.
f xs : (Max as : (exists bs,cs : True : xs = (bs++as++cs)) : Sum (as) )

f5d :: [Int] -> Int
f5d xs = maximum [sum as | (bs,as,cs) <- split3 xs]

##    Según chat:
##    data Result = Result [Int] Int
##    
##    findMaxAndSum :: [Int] -> Result
##    findMaxAndSum xs = Result maxSubList sumSubList
##      where
##        subLists = [ (bs, as, cs) | bs <- segments, as <- segments, cs <- segments ]
##        segments = tail (init (segmentsOf xs))
##        sumSubList = maximum [ sum as | (bs, as, cs) <- subLists ]
##        maxSubList = maximumBy (comparing length) [ as | (bs, as, cs) <- subLists, xs == bs ++ as ++ cs ]
##    
##    segmentsOf :: [a] -> [[a]]
##    segmentsOf [] = [[]]
##    segmentsOf (x:xs) = [x:rest | rest <- ([] : segmentsOf xs)] ++ segmentsOf xs

split3 :: [a] -> [([a], [a], [a])]
split3 xs = [(take i xs, take (j - i) (drop i xs), drop j xs) | i <- [0..length xs], j <- [i..length xs]]

split2 :: [a] -> [([a],[a])]
split2 xs = [(take i xs,drop i xs) | i <- [0..length xs]]
