{-
Ejercicios Repaso

---------------------------------------
1) a) En Haskell, definir una función

 f : Int -> [Int] -> Bool
 
que dado un número n y una lista xs, retorne true si y solo si hay repetidos en los 
primeros n elementos de la lista xs.
[1,2,3,4,5,6]
take 3 xs
False

[1,1,2,_]
3
true

[1,2,3,4,6,6]
take 3 xs
false
take length xs xs
true
-}
f :: Int -> [Int] -> Bool
f n [] = False
f n [x] = False
f n (x:xs) = not(null (hayRep(qsort(take n (x:xs))))) -- qsort = quicksort

hayRep :: Eq a => [a] -> [a]
hayRep [] = []
hayRep [x] = []
hayRep (x:y:xs) | x==y = x : hayRep (y:xs)
                | otherwise = hayRep (y:xs)

qsort :: (Ord a) => [a] -> [a]  
qsort [] = []  
qsort (x:xs) =   
    let smallerSorted = qsort [a | a <- xs, a <= x]  
        biggerSorted = qsort [a | a <- xs, a > x]  
    in  smallerSorted ++ [x] ++ biggerSorted 

{-
b) Utilice su número de documento para evaluar:
f 3 <su dni> con evaluación aplicativa y con evaluación normal. 

c) Qué sucede si evalúa f  3 [1..] con evaluación aplicativa, y que sucede si la evalúa usando orden normal.

---------------------------------------------
2) Dada las siguientes definiciones 
K.x.y = x
inf = inf+1

a) Evaluar normal y aplicativo la siguiente expresión:

K.3.inf

Normal:
K.3.inf == K(3)(inf) == K(3(inf))
= {def K}
3

Aplic:
K.3.inf
= {def inf}
K.3.(inf+1)
= {def inf}
K.3.((inf+1)+1)
= {def inf}
K.3.((inf+1)+1)+1)
...
infinito
...

----------------------------------------------------   
3)
    a)Definir en haskell un tipo nuevo para árboles binarios, que distinga las hojas.
    b)Definir además una función que calcule la cantidad de hojas de un árbol.
-}
data Tree a = Hoja (Tree a) a (Tree a) | Vacio

{-
------------------------------------------------------  
4) En haskell definir con listas por comprensión, una lista que contenga todas las coordenadas de una Matriz infinita, pero de manera Diagonal.

Es decir : 

darCoordDiagonalmente = 
[(0,0),
(0,1),(1,0),
(0,2),(1,1),(2,0),
(0,3),(1,2),(2,1),(3,0),
(0,4),(1,3),(2,2),(3,1),(4,0),
(0,5),(1,4),(2,3),(3,2),(4,1),(5,0),
(0,6),(1,5),(2,4),(3,3),(4,2),(5,1),(6,0)
.. ] -}

darCoordDiag :: [(Int,Int)]
darCoordDiag = [(x,(n-x)) | n <- [0,1..] , x <- [0..n]]

{-
----------------------------------------------
5) Evalue en forma aplicativa y forma normal la siguiente expresion

and ((square 2) == 5) (inf == inf))

considerando las definiciones de cada caso:

a)
square :: Int -> Int
square x = x*x

inf :: Int -> Int
inf = inf+1

and :: Bool -> Bool -> Bool
and true true = true
and true false = false
and false true = false
and false false = false

Aplicativo:
and ((square 2)==5) (inf==inf)
={def square}
and ((2*2)==5) (inf==inf)
={aritmetica}
and (4==5) (inf==inf)
={def ==}
and False (inf==inf)
={def inf}
and False ((inf+1)==inf)
={def inf}
and False (((inf+1)+1)==inf)
... no termina

Normal:
and ((square 2)==5) (inf==inf)
={def square}
and ((2*2)==5) (inf==inf)
={aritmetica}
and (4==5) (inf==inf)
={def ==}
and False (inf==inf)
={def inf}
and False ((inf+1)==inf)
={def inf}
and False (((inf+1)+1)==inf)
... no termina

b) 
square :: Int -> Int
square x = x*x

inf :: Int -> Int
inf = inf+1

and :: Bool -> Bool -> Bool
and true y = y
and false x = false

Aplicativo:
and ((square 2)==5) (inf==inf)
={def square}
and ((2*2)==5) (inf==inf)
={aritmetica}
and (4==5) (inf==inf)
={def ==}
and False (inf==inf)
={def inf}
and False ((inf+1)==inf)
={def inf}
and False (((inf+1)+1)==inf)
... no termina

Normal:
and ((square 2)==5) (inf==inf)
={def square}
and ((2*2)==5) (inf==inf)
={aritmetica}
and (4==5) (inf==inf)
={def ==}
and False (inf==inf)
={def and}
False

data listasHaskell a = [] | a:listasHaskell a
-}