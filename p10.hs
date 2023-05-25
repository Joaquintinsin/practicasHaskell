split2 :: [a] -> [([a],[a])]
split2 xs = [(take n xs, drop n xs) | n <- [0..length xs]]

split3 :: [a] -> [([a],[a],[a])]
split3 [] = []
split3 xs = [(as,bs,cs) | (as,bs) <- split2 xs , (bs,cs) <- split2 bs]
-- split3 xs = [(take i as, take j bs, drop j cs) | i <- [0..length xs] , j <- [0..length xs]]

Practico 10: Induccion - Derivaciones
Ejercicio 1. Demostrar que la concatenacion de listas es asociativa:
#######################################################
Probar: (xs ++ ys) ++ zs = xs ++ (ys ++ zs)

(++) :: [a] -> [a] -> [a]
(++) [] ys = ys -- [] ++ ys = ys
(++) (x:xs) ys = x:(xs++ys)
La H.I. sale de lo que quiero probar poque es xs, y el caso inductivo es (x:xs)

    · Caso Base: ++.[]
([] ++ ys) ++ zs = [] ++ (ys ++ zs)
={def ++}
ys ++ zs = ys ++ zs
={logica}
True

    · Caso inductivo: ++.(x:xs)
((x:xs) ++ ys) ++ zs = (x:xs) ++ (ys ++ zs)
={def ++}
x:(xs++ys) ++ zs = x:(xs ++ (ys ++ zs))
={H.I.}
x:(xs++ys) ++ zs = x:(xs ++ ys) ++ zs
={logica}
True


Ejercicio 2. Demostrar las siguientes propiedades
    · map (f o g)xs = (map f) o (map g)xs
    · reversa (xs ++ ys) = reversa ys ++ reversa xs
    · reversa (reversa xs) = xs
#######################################################
Probar: map (f o g) xs = (map f) o (map g) xs

o :: (a -> a) -> (a -> a) -> [a] -> a
o f g [] = []
o f g xs = f (g xs) -- f o g xs = f (g xs) con notacion infija

map :: (a -> a) -> [a] -> [a]
map f [] = []
map f (x:xs) = f x : map f xs

    · Caso base: map.(fog).[]
map (f o g) [] = (map f) o (map g) []
={def map}
[] = (map f) o (map g) []
={def o}
[] = []
={logica}
True

    · Caso inductivo: map.(fog).(x:xs)
map (f o g) (x:xs) = (map f) o (map g) (x:xs)
={def map}
(f o g) x : map (f o g) xs = (map f) o (map g) (x:xs)
={def o}
(f o g) x : map (f o g) xs = (map f) (map g (x:xs))
={H.I.}
(f o g) x : (map f) o (map g) xs = (map f) (map g (x:xs))
={def map}
(f o g) x : (map f) o (map g) xs = (map f) (g x : map g xs)
=??? terminar

#######################################################
Probar: reversa (xs ++ ys) = reversa ys ++ reversa xs

reversa :: [a] -> [a]
reversa [] = []
reversa (x:xs) = reversa xs ++ [x]

    · Caso base: rev.[]
reversa ([] ++ ys) = reversa ys ++ reversa []
={def ++}
reversa ys = reversa ys ++ reversa []
={def reversa}
reversa ys = reversa ys ++ []
={def ++}
reversa ys = reversa ys
={logica}
True

    · Caso inductivo: rev.(x:xs)
reversa ((x:xs) ++ ys) = reversa ys ++ reversa (x:xs)
={def ++}
reversa (x:(xs++ys)) = reversa ys ++ reversa (x:xs)
={def reversa}
revesa (xs++ys) ++ [x] = reversa ys ++ reversa xs ++ [x]
={H.I.}
reversa ys ++ reversa xs ++ [x] = reversa ys ++ reversa xs ++ [x]
={logica}
True

#######################################################
Probar: reversa (reversa xs) = xs

reversa :: [a] -> [a]
reversa [] = []
reversa (x:xs) = reversa xs ++ [x]

    · Caso base: reversa.[]
reversa(reversa []) = []
={def reversa}
reversa [] = []
={def reversa}
[] = []
={logica}
True

    · Caso inductivo: reversa.(x:xs)
reversa (reversa (x:xs)) = (x:xs)
={def reversa}
reversa (reversa xs ++ [x]) = (x:xs)
={prop reversa: reversa (xs ++ ys) = reversa ys ++ reversa xs}
reversa [x] ++ reversa (reversa xs) = (x:xs)
={H.I.}
reversa [x] ++ xs = (x:xs)
={def reversa}
[x] ++ xs = (x:xs)
={def : / def ++}
(x:xs) = (x:xs)
={logica}
True


Ejercicio 3. Especificar y derivar la siguiente funcion:
    f xs dice si todos los elementos son iguales.
f xs = (forall i : 0 <= i < #xs : xs.0 = xs.i )

    · Caso base: f.[]
(forall i : 0 <= i < #[] : [].0 = [].i )
={def #}
(forall i : 0 <= i < 0 : [].0 = [].i )
={logica}
(forall i : False : [].0 = [].i )
={rango vacio}
True

    · Caso inductivo: f.(x:xs)
(forall i : 0 <= i < #(x:xs) : (x:xs).0 = (x:xs).i )
={def #}
(forall i : 0 <= i < 1 + #xs : (x:xs).0 = (x:xs).i )
={def index}
(forall i : 0 <= i < 1 + #xs : x = (x:xs).i )
={aritmetica}
(forall i : 0 <= i < 1 v 1 <= i < 1 + #xs : x = (x:xs).i )
={particion de rango}
(forall i : 0 <= i < 1 : x = (x:xs).i ) ^ (forall i : 1 <= i < 1 + #xs : x = (x:xs).i )
={aritmetica}
(forall i : 0 = i : x = (x:xs).i ) ^ (forall i : 1 <= i < 1 + #xs : x = (x:xs).i )
={rango unitario}
x = (x:xs).0 ^ (forall i : 1 <= i < 1 + #xs : x = (x:xs).i )
={def index}
x = x ^ (forall i : 1 <= i < 1 + #xs : x = (x:xs).i )
={logica}
True ^ (forall i : 1 <= i < 1 + #xs : x = (x:xs).i )
={neutro ^}
(forall i : 1 <= i < 1 + #xs : x = (x:xs).i )
={cambio variable [i := j+1]}
(forall j : 1 <= j+1 < 1 + #xs : x = (x:xs).(j+1) )
={aritmetica}
(forall j : 0 <= j < #xs : x = (x:xs).(j+1) )
={def index}
(forall j : 0 <= j < #xs : x = xs.j )

no se puede aplicar H.I. (x sobra y no se puede reescribir)
entonces hay que pasar a otro metodo de derivacion:
modularizacion.

Sea g xs y = (forall j : 0 <= j < #xs : y = xs.j )

    · Caso base: g [] y
(forall j : 0 <= j < #[] : y = [].j )
={def #}
(forall j : 0 <= j < 0 : y = [].j )
={logica}
(forall j : False : y = [].j )
={rango vacio}
True

    · Caso inductivo: g (x:xs) y
(forall j : 0 <= j < #(x:xs) : y = (x:xs).j )
={def #}
(forall j : 0 <= j < 1 + #xs : y = (x:xs).j )
={logica}
(forall j : 0 <= j < 1 v 1 <= j < 1 + #xs : y = (x:xs).j )
={particion de rango}
(forall j : 0 <= j < 1 : y = (x:xs).j ) ^ (forall j : 1 <= j < 1 + #xs : y = (x:xs).j )
={aritmetica}
(forall j : 0 = j : y = (x:xs).j ) ^ (forall j : 1 <= j < 1 + #xs : y = (x:xs).j )
={rango unitario}
y = (x:xs).0 ^ (forall j : 1 <= j < 1 + #xs : y = (x:xs).j )
={def index}
y = x ^ (forall j : 1 <= j < 1 + #xs : y = (x:xs).j )
={cambio variable [j := i + 1]}
y = x ^ (forall j : 1 <= i + 1 < 1 + #xs : y = (x:xs).(i + 1) )
={aritmetica}
y = x ^ (forall j : 0 <= i < #xs : y = (x:xs).(i + 1) )
={def index}
y = x ^ (forall j : 0 <= i < #xs : y = xs.i )
={H.I.}
y = x ^ g xs y

La funcion que resuelve queda:
g [] z = True
g (x:xs) z = z=x ^ g xs z

La función que se usa queda:
f [] = True
f (x:xs) = g (x:xs) x


Ejercicio 4. Especificar y derivar una funcion que dada una lista de numeros
devuelva su producto.

f :: Num a => [a] -> a
f xs = (productoria i : 0 <= i < #xs : xs.i )

    · Caso base: f []
(productoria i : 0 <= 1 < #[] : [].i )
={def #}
(productoria i : 0 <= 1 < 0 : [].i )
={lógica}
(productoria i : Falso : [].i )
={rango vacío}
1

    · Caso inductivo: f (x:xs)
(productoria i : 0 <= i < #(x:xs) : (x:xs).i )
={def #}
(productoria i : 0 <= i < 1 + #xs : (x:xs).i )
={particion de rango}
(productoria i : 0 <= i < 1 : (x:xs).i ) * (productoria i : 1 <= i < 1 + #xs : (x:xs).i )
={aritmetica}
(productoria i : 0 = i : (x:xs).i ) * (productoria i : 1 <= i < 1 + #xs : (x:xs).i )
={rango unitario}
( (x:xs).0 ) * (productoria i : 1 <= i < 1 + #xs : (x:xs).i )
={def index , cambio de variable [i := j + 1]}
x * (productoria j : 1 <= j + 1 < 1 + #xs : (x:xs).(j+1) )
={aritmetica}
x * (productoria j : 0 <= j < #xs : (x:xs).(j+1) )
={def index}
x * (productoria j : 0 <= j < #xs : xs.j )
={H.I.}
x * f.xs


* Ejercicio 5. Derivar una funcion que dada una lista determina si los elementos 
estan ordenados de forma creciente.
f xs = (forall i : 0 <= i < #xs - 1 : xs.i <= xs.(i+1))

    · Caso base: f []
(forall i : 0 <= i < #[] - 1 : [].i <= [].(i+1))
={def #}
(forall i : 0 <= i < 0 - 1 : [].i <= [].(i+1))
={logica}
(forall i : False : [].i <= [].(i+1))
={rango vacio}
True

    · Caso inductivo: f (x:xs)
(forall i : 0 <= i < #(x:xs) - 1 : (x:xs).i <= (x:xs).(i+1))

--particion de rango de una. reviso qué pasa con el primer elemento así saco el (x:xs) de encima y 
--trabajo con xs

={def #}
(forall i : 0 <= i < 1 + #xs - 1 : (x:xs).i <= (x:xs).(i+1))
={aritmetica}
(forall i : 0 <= i < #xs : (x:xs).i <= (x:xs).(i+1))
={def index}
(forall i : 0 <= i < #xs : (x:xs).i <= xs.i)
={logica}
(forall i : 0 = i v 1 <= i < #xs : (x:xs).i <= xs.i)
={particion de rango}
(forall i : 0 = i : (x:xs).i <= xs.i ) ^ (forall i : 1 <= i < #xs : (x:xs).i <= xs.i)
={rango unitario}
(x:xs).0 <= xs.0 ^ (forall i : 1 <= i < #xs : (x:xs).i <= xs.i)
={def index}
x <= xs.0 ^ (forall i : 1 <= i < #xs : (x:xs).i <= xs.i)
={cambio de variable [i := j + 1]}
x <= xs.0 ^ (forall j : 1 <= j + 1 < #xs : (x:xs).(j+1) <= xs.(j+1))
={aritmetica}
x <= xs.0 ^ (forall j : 0 <= j < #xs - 1 : (x:xs).(j+1) <= xs.(j+1))
={def index}
x <= xs.0 ^ (forall j : 0 <= j < #xs - 1 : xs.j <= xs.(j+1))
={H.I.}
x <= xs.0 ^ f xs

Su implementación:
f :: Ord a => [a] -> Bool
f [] = True
f (x:xs) = x <= xs!!0 ^ f xs


Ejercicio 6. Sea m :: [Num] -> Num una funcion que devuelve el minimo de una lista dada. 
Especificar y derivar m.
m xs = (Min i : 0 <= i < #xs : xs.i)

    · Caso base: m []
(Min i : 0 <= i < #[] : [].i)
={def #}
(Min i : 0 <= i < 0 : [].i)
={logica}
(Min i : False : [].i)
={rango vacio}
+infinity

    · Caso inductivo: m (x:xs)
(Min i : 0 <= i < #(x:xs) : (x:xs).i)
={aritmetica}
(Min i : 0 = i v 1 <= i < #(x:xs) : (x:xs).i)
={particion de rango}
(Min i : 0 = i : (x:xs).i) min (Min i: 1 <= i < #(x:xs) : (x:xs).i)
={rango unitario}
((x:xs).0) min (Min i: 1 <= i < #(x:xs) : (x:xs).i)
={def index}
x min (Min i: 1 <= i < #(x:xs) : (x:xs).i)
={def #}
x min (Min i: 1 <= i < #xs + 1 : (x:xs).i)
={cambio variable [i := j + 1]}
x min (Min j: 1 <= j + 1 < #xs + 1 : (x:xs).(j+1))
={aritmetica}
x min (Min j: 0 <= j < #xs : (x:xs).(j+1))
={def index}
x min (Min j: 0 <= j < #xs : xs.j)
={H.I.}
x min f xs


Ejercicio 7. Especificar y derivar una funcion que dada una lista determine si
existe un elemento en ella que sea igual a la suma del resto de los elementos de la lista.
f xs = (exists i : 0 <= i < #xs : xs.i = (sum xs - xs.i))

    · Caso base: f []
(exists i : 0 <= i < #[] : [].i = (sum [] - [].i))
={def #}
(exists i : 0 <= i < 0 : [].i = (sum [] - [].i))
={logica}
(exists i : False : [].i = (sum [] - [].i))
={rango vacio}
False

    · Caso inductivo: f (x:xs)
(exists i : 0 <= i < #(x:xs) : (x:xs).i = (sum (x:xs) - (x:xs).i))


    Especificacion de sum: 
    sum xs = (Sum i : 0 <= i < #xs : xs.i)
        · Caso base: sum []
    (Sum i : 0 <= i < #[] : [].i)
    ={def #}
    (Sum i : 0 <= i < 0 : [].i)
    ={logica}
    (Sum i : False : [].i)
    ={rango vacio}
    0

        · Caso inductiva: sum (x:xs)
    (Sum i : 0 <= i < #(x:xs) : (x:xs).i)
    ={logica}
    (Sum i : 0 = i v 1 <= i < #(x:xs) : (x:xs).i)
    ={particion de rango}
    (Sum i : 0 = i : (x:xs).i ) + (Sum i : 1 <= i < #(x:xs) : (x:xs).i)
    ={rango unitario}
    (x:xs).0 + (Sum i : 1 <= i < #(x:xs) : (x:xs).i)
    ={def index}
    x + (Sum i : 1 <= i < #(x:xs) : (x:xs).i)
    ={cambio variable [i := j + 1]}
    x + (Sum j : 1 <= j + 1 < #(x:xs) : (x:xs).(j+1))
    ={def #}
    x + (Sum j : 1 <= j + 1 < #xs + 1 : (x:xs).(j+1))
    ={aritmetica}
    x + (Sum j : 0 <= j < #xs : (x:xs).(j+1))
    ={def index}
    x + (Sum j : 0 <= j < #xs : xs.j)
    ={H.I.}
    x + sum xs

* Ejercicio 8. Dada f : Nat -> Bool y suponiendo ∃n : 0 ≤ n : f.n, especificar
y derivar una funcion que encuentre el minimo natural x tal que f.x.




Ejercicio 9. Derivar un programa usando la siguiente especificacion:
P xs.ys = (∃as, bs :: ys = as + +xs + +bs),
que dadas dos listas determina si la primera es subsegmento de la segunda.




Ejercicio 10. Especificar y derivar una funcion que dada una lista de números
calcula el promedio de la misma, recorriendo la lista una sola vez
(Ayuda: utilizar tuplas).




* Ejercicio 11. Implementar todas las funciones obtenidas de las derivaciones
dadas en el téorico y en el practico.



