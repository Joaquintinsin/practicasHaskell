{- Práctico 9: Especificaciones
Para tener en cuenta algunos conceptos: por subsegmento de xs o subsecuencia 
de xs entendemos a cualquier lista cuyos elementos están en xs, en el mismo orden y consecutivamente. 
Por ejemplo, si la lista es xs = [1, 4, 2, 1, 1, 8, 7] los siguientes son ejemplos de subsegmentos:
    · secuencia vacı́a: [].
    · subsegmento unitario [4].
    · subsegmento inicial [1, 4].
    · [2, 1, 1].
    · [1, 4, 2, 1, 1, 8, 7].
    · subsegmento final [8, 7].

Ejercicio 1. Expresar en lenguaje formal (de primer orden) las siguientes
especificaciones. -}
--    a) f es una función que determina si los elementos de una lista xs son iguales.
f xs : (paraTodo i : 0 <= i < length xs - 1 : xs.i == xs.(i+1))
f xs : (paraTodo i : 0 <= i < #xs : xs.0 == xs.i)

--    b) f es una función que determina si los elementos de una lista xs son todos diferentes.
f xs : (paraTodo i : 0 <= i < length xs - 1 : xs.i /= xs.(i+1))
f xs : (paraTodo i,j : 0 <= i < #xs ^ 0 <= j < #xs ^ i /= j : xs.i /= xs.j)
f xs : (paraTodo i : 0 <= i < #xs : (paraTodo j : 0 <= j < i : xs.i /= xs.j))
f xs : not(exists i : 0 <= i < length xs - 1 : xs.i == xs.(i+1))

--    c) f es una función que determina si los elementos de una lista xs están ordenados.
f xs : (paraTodo i : 0 <= i < length xs - 1 : xs.i < xs.(i+1))

--    d) P es un predicado que es true sii cuando aparece 1 en xs entonces debe aparecer 0 en xs.
P xs : (exists j : 0 <= j < length xs : (xs.j == 1) ^ (exists i : 0 <= i < length xs : xs.i == 0))
P xs : (exists j : 0 <= j < length xs : (xs.j == 1)) -> (exists i : 0 <= i < length xs : xs.i == 0)

--    e) p es el producto de todos los elementos primos de xs. 
P xs : (productoria i : 0 <= i < length xs ^ prime (xs.i) : xs.i)
    where
        prime Num -> Bool
        prime n : not(paraTodo i : 0 <= i < #xs - 1 : n ´mod´ i == 0)
        prime n : (contatoria i : 0 <= i < #xs - 1 : n ´mod´ i) == 2


{- Ejercicio 2. Sea xs un lista no vacı́a con elementos booleanos, tal que true
aparezca al menos una vez en la lista. Especificar: -}
--    · n es el menor entero tal que xs.n = true.
(exists n : 0 == n : xs.n == True) = (xs.0 == True)

--    · n es el último elemento de la lista tal que xs.n = true.
(exists n : length xs - 1 == n : xs.n == True)

--    · f es una función que devuelve true si y solo si todos los elementos de xs son equivalentes.
f xs : (paraTodo i : 0 <= i < length xs - 1 : xs.i == xs.(i+1))
f xs : not(exists i : 0 <= i < length xs : xs.i == False)


-- Ejercicio 3. Especificar las siguientes funciones:
--    · f.xs determina si xs tiene la misma cantidad de pares que impares.
f xs : (paraTodo i : 0 <= i < #xs - 1 : (contatoria : True : xs.i ´mod´ 2 == 0) 
                                 == (contatoria : True : xs.i ´mod´ 2 == 1))
--    · f.n determina si n es primo.

--    · f.xs.ys determina si ys es una subsecuencia de xs.

--    · f.xs.ys determina si ys es una subsecuencia final de xs.


{- Ejercicio 4. Especificar lo siguiente:
    · Dada una lista de enteros, especifique la suma del subsegmento de suma mı́nima de la lista. 
Por ejemplo, si la lista es xs = [1, −4, −2, 1, −5, 8, −7] el subsegmento que da la suma 
mı́nima es [−4, −2, 1, −5], cuya suma es -10. 
Si xs = [1, 3, 5] , el subsegmento que da la suma mı́nima es [] , pues la suma de la lista vacı́a 
es cero.
    · Especifique la funcin maxigual que determina la longitud del máximo subsegmento en donde todos 
sus elementos son iguales: maxigual : [A] -> Num.
    · Especifique la función maxdistinto : [Int]− > Int que determina la longitud del subsegmento más 
largo en donde todos los elementos son distintos. -}


{- Ejercicio 5. Dadas las funciones split3 :: [a] -> [([a], [a], [a])] y 
split2 :: [a] -> [([a], [a])] dadas en clases. Escribir las siguientes especificaciones usando listas
por comprensión:
    · La especificación del ejercicio 1(e).
    · La especificación del ejercicio 3(c).
    · La especificación del ejercicio 3(d).
    · La siguiente especificación: Dada una lista de números, calcular el valor de subsegmento
de suma máxima. -}