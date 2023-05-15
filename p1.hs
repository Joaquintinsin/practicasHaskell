{- Práctico 1
 Ejercicio 1:
    ((2^ 29)/(2^ 9)) == (2^ 20)

    tail tomo una lista y devolvio una lista sin su primer elemento
    head devuelve el primer elemento de una lista

 Ejercicio 2: 
    head (tail "hola mundo")

 Ejercicio 3:
    reverse toma una lista y devuelve la misma lista dada vuelta
    head (reverse "hola mundo")

 Ejercicio 4:
    muestra que recibe y que devuelve
    :t tail
    tail :: [a] -> [a]	// denotamos lista con los corchetes. la a denota que es cualquier tipo

 Ejercicio 5:
    :t mod
    mod :: Integral a => a -> a -> a
    mod 2 (head(tail(reverse [1,2,3]))) == 0

 Ejercicio 6:
    :t sum // sum suma todos los elementos de la lista

    sum :: (Foldable t, Num a) => t a -> a     False

    ghci> mod (sum [15,2,2]) 3 == 0
    ghci> mod (sum [3,3,3]) 3 == 0
    True

 Ejercicio 7:
    ghci> mod (sum [3,3,3]) 6 == 0
    False
    ghci> mod (sum [6,6,6]) 6 == 0
    True

 Ejercicio 8: Escriba una función que dado un número retorne la lista de sus digitos.
 usar :load /ruta1/ruta2/etc/archivo.hs para si ejecutamos el ghci en otro lado
 operador ":" = concatena elemento con lista a la cabeza
    |> :: a -> [a] -> [a]
 operador "++" = concatena lista con lista (concat)
    ++ :: [a] -> [a] -> [a]
    [1,2]++[3,4] -> [1,2,3,4]
 guarda/condicional = cubrir todo el dominio
-}
nroLista :: Int -> [Int]
nroLista a = if a <= 9 then [a] else nroLista (div a 10)++[mod a 10]

-- hecho con condicionales:
nroLista2 :: Int -> [Int]
nroLista2 a | a < 10 = [a]
            | otherwise = nroLista2 (div a 10)++[mod a 10]

-- xs es convencion de nombre para listas (como si fuese una variable)
digito :: Int -> [Int]
digito a | a < 10 = [a]
         | otherwise = mod a 10 : digito (div a 10)


{- Ejercicio 9: Utilizando las funciones reverse y == determine si una frase, 
representada como un string, es un palı́ndromo.
    ghci> "nolo" == reverse "nolo"
    False
    ghci> "larutanatural" == reverse "larutanatural"
    True

 Ejercicio 10: ¿Que arrojará como resultado la evaluación de la siguiente expresión en
Hugs? (head.(drop 3)) "0123456" ¿Que tipo tiene el valor resultante? ¿Que función sobre 
listas de las dadas en clase se podrı́a implemntar de esta manera? Investigue qué comando
se usa en ghci para saber el número de pasos realizados por el interprete.
    arroja 3 , tiene tipo del mismo de la lista , 

 Ejercicio 11: Utilizando ghc compile alguna de sus funciones para obtener código eje-
cutable.
    ya compile algo, es como gcc

 Ejercicio 12: Utilice Cabal para crear un proyecto, el proyecto debe ejecutar la función
reverse sobre un texto que se dé como entrada.
    crear estructura basica de desarrollo para haskell
-}
