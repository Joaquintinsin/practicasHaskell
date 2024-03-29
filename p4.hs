{-
1. Muestra los pasos de reducción hasta llegar a la forma normal de la expresión:
2 * cuadrado.(head.[2,4,5,6,7,8])
Considerando las siguientes definiciones para cuadrado y head:
cuadrado :: Int -> Int
cuadrado x = x * x

head :: [a] -> a
head (x:xs) = x

· a) utilizando el orden de reducción aplicativo.
· b) utilizando el orden de reducción normal.

Aplicativo:
2 * cuadrado.(head.[2,4,5,6,7,8])
= {def head}
2 * cuadrado.2
= {def cuadrado}
2 * (2*2)
= {aritmetica}
2 * 4
= {aritmetica}
8

Normal:
2 * cuadrado.(head.[2,4,5,6,7,8])
= {def cuadrado}
2 * (head.[2,4,5,6,7,8] * head.[2,4,5,6,7,8])
={def head}
2 * (2 * head.[2,4,5,6,7,8])
={def head}
2 * (2 * 2)
={aritmetica}
2 * 4
={aritmetica}
8

2. Dada la definición: linf = 1 : linf . Resuelve los siguientes pasos para la
expresión head. linf :
· a) Muestre los pasos de reducción utilizando el orden aplicativo.
· b) Haga lo mismo pero siguiendo el orden de reducción normal.
Compara dichos resultados.

Aplicativo:
head. linf
={def linf}
head.(1:linf)
={def linf}
head. (1:(1:linf))
... no termina

Normal:
head. linf
={def linf}
head.(1:linf)
={def head}
1

3. Dada la siguiente definición:
f :: Int -> Int -> Int
f x 0 = x
f x (n+1) = cuadrado (f x n)
Resuelve los siguientes pasos para la expresión f .2.3 :
· a) Muestra los pasos de reducción utilizando el orden aplicativo.
· b) Has lo mismo pero siguiendo el orden de reducción normal.
Compara dichos resultados.

Aplicativo:
f .2.3
={def f}
cuadrado (f 2 2)
={def f}
cuadrado (cuadrado (f 2 1))
={def f}
cuadrado (cuadrado (cuadrado (f 2 0)))
={def f}
cuadrado (cuadrado (cuadrado (2)))
={def cuadrado}
cuadrado (cuadrado (2*2))
={aritmetica}
cuadrado (cuadrado 4)
={def cuadrado}
cuadrado (4*4)
={aritmetica}
cuadrado 16
={def cuadrado}
16 * 16
={aritmetica}
256

Normal:
f .2.3
={def f}
cuadrado (f 2 2)
={def cuadrado}
(f 2 2) * (f 2 2)
={def f}
(cuadrado (f 2 1)) * (f 2 2)
={def cuadrado}
((f 2 1) * (f 2 1)) * (f 2 2)
={def f}
((cuadrado (f 2 0) * (f 2 1))) * (f 2 2)
={def cuadrado}
(((f 2 0) * (f 2 0) * (f 2 1))) * (f 2 2)
={def f}
(((2 * (f 2 0)) * (f 2 1))) * (f 2 2)
={def f}
(((2 * 2) * (f 2 1))) * (f 2 2)
= {aritmetica}
((4 * (f 2 1))) * (f 2 2)
={def f}
((4 * (cuadrado (f 2 0)))) * (f 2 2)
={def cuadrado}
((4 * ((f 2 0) * (f 2 0)))) * (f 2 2)
={def f}
((4 * (2 * (f 2 0)))) * (f 2 2)
={aritmetica}
(8 * f 2 0) * (f 2 2)
={def f}
(8 * 2) * (f 2 2)
={aritmetica}
16 * (f 2 2)
={def f}
16 * (cuadrado (f 2 1))
={def cuadrado}
16 * ((f 2 1) * (f 2 1))
={def f}
16 * ((cuadrado f 2 0) * (f 2 1))
={def cuadrado}
16 * (((f 2 0) * (f 2 0)) * (f 2 1))
={def f}
16 * ((2 * (f 2 0)) * (f 2 1))
={aritmetica}
32 * ((f 2 0) * (f 2 1))
={def f}
32 * (2 * (f 2 1))
={aritmetica}
64 * (f 2 1)
={def f}
64 * (cuadrado (f 2 0))
={def cuadrado}
64 * ((f 2 0) * (f 2 0))
={def f}
64 * (2 * (f 2 0))
={aritmetica}
128 * (f 2 0)
={def f}
128 * 2
={aritmetica}
256

-}
cantCeros :: [Int] -> Int
cantCeros [] = 0
cantCeros (x:xs) | x == 0 = 1 + cantCeros xs
                 | otherwise = cantCeros xs

cantCeros2 :: [Int] -> Int
cantCeros2 [] = 0
cantCeros2 (x:xs) | head (x:xs) == 0 = 1 + cantCeros2 xs
                  | otherwise = cantCeros2 xs
