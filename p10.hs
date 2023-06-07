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
map (f o g)xs   -#-#-#-     (map f) (map g xs)

    · reversa (xs ++ ys) = reversa ys ++ reversa xs
    · reversa (reversa xs) = xs
#######################################################
Probar: map (f o g) xs = (map f) o (map g) xs

o :: (a -> a) -> (a -> a) -> [a] -> [a]
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
f xs = (exists i : 0 <= i < #xs : xs.i = (sum xs - xs.i))   --está bien especificado

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
={def #}
(exists i : 0 <= i < 1 + #xs : (x:xs).i = (sum (x:xs) - (x:xs).i))
={logica}
(exists i : 0 = i v 1 <= i < 1 + #xs : (x:xs).i = (sum (x:xs) - (x:xs).i))
={particion de rango}
(exists i : 0 = i : (x:xs).i = (sum (x:xs) - (x:xs).i))
v
(exists i : 1 <= i < 1 + #xs : (x:xs).i = (sum (x:xs) - (x:xs).i))
={rango unitario}
(x:xs).0 = (sum (x:xs) - (x:xs).0) v (exists i : 1 <= i < 1 + #xs : (x:xs).i = (sum (x:xs) - (x:xs).i))
={def index}
(x = sum (x:xs) - x) v (exists i : 1 <= i < 1 + #xs : (x:xs).i = (sum (x:xs) - (x:xs).i))
={cambio variable [i := j+1]}
(x = sum (x:xs) - x) v (exists j : 1 <= j+1 < 1 + #xs : (x:xs).(j+1) = (sum (x:xs) - (x:xs).(j+1)))
={aritmetica}
(x = sum (x:xs) - x) v (exists j : 0 <= j < #xs : (x:xs).(j+1) = (sum (x:xs) - (x:xs).(j+1)))
={def index}
(x = sum (x:xs) - x) v (exists j : 0 <= j < #xs : xs.j = (sum (x:xs) - xs.j))
={def sum}
(x = x + sum xs - x) v (exists j : 0 <= j < #xs : xs.j = x + sum xs - xs.j))
={aritmetica}
(x = sum xs) v (exists j : 0 <= j < #xs : xs.j = x + sum xs - xs.j))
Continuacion en *

    Defino g : g xs a = (exists i : 0 <= i < #xs : xs.i = a + sum xs - xs.i)
        · Caso base: g [] a
    (exists i : 0 <= i < #[] : [].i = a + sum [] - [].i)
    ={def #}
    (exists i : 0 <= i < 0 : [].i = a + sum [] - [].i)
    ={logica}
    (exists i : False : [].i = a + sum [] - [].i)
    ={rango vacio}
    False

        · Caso inductivo : g (x:xs) a
    (exists i : 0 <= i < #(x:xs) : (x:xs).i = a + sum (x:xs) - (x:xs).i)
    ={def #}
    (exists i : 0 <= i < 1 + #xs : (x:xs).i = a + sum (x:xs) - (x:xs).i)
    ={logica}
    (exists i : 0 = i v 1 <= i < 1 + #xs : (x:xs).i = a + sum (x:xs) - (x:xs).i)
    ={particion de rango}
    (exists i : 0 = i : (x:xs).i = a + sum (x:xs) - (x:xs).i)
    v
    (exists i : 1 <= i < 1 + #xs : (x:xs).i = a + sum (x:xs) - (x:xs).i)
    ={rango unitario}
    ((x:xs).0 = a + sum (x:xs) - (x:xs).0) v (exists i : 1 <= i < 1 + #xs : (x:xs).i = a + sum (x:xs) - (x:xs).i)
    ={def index}
    (x = a + sum (x:xs) - x) v (exists i : 1 <= i < 1 + #xs : (x:xs).i = a + sum (x:xs) - (x:xs).i)
    ={cambio variable [i := j+1]}
    (x = a + sum (x:xs) - x) v (exists j : 1 <= j+1 < 1 + #xs : (x:xs).(j+1) = a + sum (x:xs) - (x:xs).(j+1))
    ={aritmetica}
    (x = a + sum (x:xs) - x) v (exists j : 0 <= j < #xs : (x:xs).(j+1) = a + sum (x:xs) - (x:xs).(j+1))
    ={def index}
    (x = a + sum (x:xs) - x) v (exists j : 0 <= j < #xs : xs.j = a + sum (x:xs) - xs.j)
    ={def sum}
    (x = a + x + sum xs - x) v (exists j : 0 <= j < #xs : xs.j = a + x + sum xs - xs.j)
    ={aritmetica}
    (x = a + sum xs) v (exists j : 0 <= j < #xs : xs.j = a + x + sum xs - xs.j)
    ={H.I.}
    (x = a + sum xs) v g xs (a+x)

    g [] n = False
    g (x:xs) n = (x == (n + sum xs)) v (g xs (n+x))

*Continuacion def f
={def g}
(x = sum xs) v g (x:xs) 0


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

-- Especificar y derivar una funcion que dada una lista determine si 
-- existe un elemento en ella que sea igual a la suma del resto de los elementos de la lista.
g [] n = False
g (x:xs) n = (x == (n + sum xs)) || (g xs (n+x))

f [] = False
f (x:xs) = (x == sum xs) || g (x:xs) 0

* Ejercicio 8. Dada f : Nat -> Bool y suponiendo (∃n : 0 ≤ n : f.n), especificar
y derivar una funcion que encuentre el minimo natural x tal que f.x. 
--Pagina 193 libro derivar una funcion (g) que satisface f



Ejercicio 9. Derivar un programa usando la siguiente especificacion:
P xs.ys = (∃as, bs :: ys = as ++ xs ++ bs),
que dadas dos listas determina si la primera es subsegmento de la segunda.
-- partir un rango en subsegmentos quiere decir pensar en que es vacio o no es vacio

P xs.ys = (∃as, bs :: ys = as ++ xs ++ bs)

    · Caso base: P [] ys
(∃as, bs :: ys = as ++ [] ++ bs)
={def ++}
(∃as, bs :: ys = as ++ bs)
={logica}
(∃as, bs : as = [] v as /= [] : ys = as ++ bs)
={particion de rango}
(∃as, bs : as = [] : ys = as ++ bs) v (∃as, bs : as /= [] : ys = as ++ bs)
={anidamiento}
(∃bs : : (∃as : as = [] : ys = as ++ bs)) v (∃bs : : (∃as : as /= [] : ys = as ++ bs))
={rango unitario}
(∃bs : : ys = [] ++ bs) v (∃bs : : ys = (a:as) ++ bs)
={def ++}
(∃bs : : ys = bs) v (∃bs : : ys = (a:as) ++ bs)
={intercambio bool}
(∃bs : ys = bs : True) v (∃bs : : ys = (a:as) ++ bs)
={termino constante}
True v (∃bs : : ys = (a:as) ++ bs)
={logica}
True

    · Caso base: P (x:xs) []
(∃as, bs :: [] = as ++ (x:xs) ++ bs)
={logica}
(∃as, bs :: [] = as ^ [] = (x:xs) ^ [] = bs)
={logica}
(∃as, bs :: [] = as ^ False ^ [] = bs)
={logica}
(∃as, bs :: False)
={termino constante}
False

    · Caso inductivo: P (x:xs) (y:ys)
(∃as, bs :: (y:ys) = as ++ (x:xs) ++ bs)
={logica}
(∃as, bs : as = [] v as /= [] : (y:ys) = as ++ (x:xs) ++ bs)
={particion de rango}
(∃as, bs : as = [] : (y:ys) = as ++ (x:xs) ++ bs) v (∃as, bs : as /= [] : (y:ys) = as ++ (x:xs) ++ bs)
={rango unitario}
(∃bs :: (y:ys) = [] ++ (x:xs) ++ bs) v (∃as,bs : as /= [] : (y:ys) = as ++ (x:xs) ++ bs)
={as /= [] -> (a:as) /= []}
(∃bs :: (y:ys) = [] ++ (x:xs) ++ bs) v (∃a,as,bs : (a:as) /= [] : (y:ys) = (a:as) ++ (x:xs) ++ bs)
={def ++}
(∃bs :: (y:ys) = (x:xs) ++ bs) v (∃a,as,bs : (a:as) /= [] : (y:ys) = (a:as) ++ (x:xs) ++ bs)
={logica: (a:as) /= [] = True}
(∃bs :: (y:ys) = (x:xs) ++ bs) v (∃a,as,bs :: (y:ys) = (a:as) ++ (x:xs) ++ bs)
={def = para listas}
(∃bs :: y = x ^ ys = xs ++ bs) v (∃a,as,bs :: y = a ^ ys = as ++ (x:xs) ++ bs)
={distributiva ^ respecto al existe}
y = x ^ (∃bs :: ys = xs ++ bs) v (∃a,as,bs :: y = a ^ ys = as ++ (x:xs) ++ bs)
={intercambio rango y termino}
y = x ^ (∃bs :: ys = xs ++ bs) v (∃a,as,bs : y = a : ys = as ++ (x:xs) ++ bs)
={rango unitario}
y = x ^ (∃bs :: ys = xs ++ bs) v (∃as,bs :: ys = as ++ (x:xs) ++ bs)
={H.I. = P.(x:xs).ys}
y = x ^ (∃bs :: ys = xs ++ bs) v (P (x:xs) ys)
={modularizacion}
(y = x ^ Q.xs.ys) v (P (x:xs) ys)

donde Q xs ys = (∃bs :: ys = xs ++ bs)
derivamos Q:
    · Caso base: Q [] ys
(∃bs :: ys = [] ++ bs)
={def ++}
(∃bs :: ys = bs)
={intercambio}
(∃bs : ys = bs : True)
={termino constante}
True

    · Caso 1: Q (x:xs) []
(∃bs :: [] = (x:xs) ++ bs)
={def = para listas}
(∃bs :: False)
={termino constante}
False

    · Caso inductivo: Q (x:xs) (y:ys)
(∃bs :: (y:ys) = (x:xs) ++ bs)
={def ++}
(∃bs :: (y:ys) = x:(xs ++ bs))
={def = en listas}
(∃bs :: y=x ^ ys = xs ++ bs)
={distributiva ^ respecto al existe}
y = x ^ (∃bs :: ys = xs ++ bs)
={H.I.}
y = x ^ Q xs ys

programa:
P : [Num] -> [Num] -> Bool
P [] ys = True
P (x:xs) [] = False
P (x:xs) (y:ys) = ((x == y) && Q xs ys) || P (x:xs) ys

Q : [Num] -> [Num] -> Bool
Q [] ys = True
Q (x:xs) [] = False
Q (x:xs) (y:ys) = (x == y) && Q xs ys

-- dadas dos listas determina si la primera es subsegmento de la segunda.
f1 :: Eq a => [a] -> [a] -> Bool
f1 [] ys = True
f1 (x:xs) [] = False
f1 (x:xs) (y:ys) = ((x == y) && f2 xs ys) || f1 (x:xs) ys

f2 :: Eq a => [a] -> [a] -> Bool
f2 [] ys = True
f2 (x:xs) [] = False
f2 (x:xs) (y:ys) = (x == y) && f2 xs ys

Ejercicio 10. Especificar y derivar una funcion que dada una lista de números
calcula el promedio de la misma, recorriendo la lista una sola vez
(Ayuda: utilizar tuplas).
f xs = (sumatoria i : 0 <= i < #xs : xs.i)
g xs = (contatoria i : 0 <= i < #xs : i)
h xs = (f xs , g xs)
    f xs / g xs

    · Caso base : h [x] = (f [x] , g [x])
={def h}
f [x] / g [x]
={def f, def g}
sumatoria [x] / contatoria [x]
={def sumatoria , def contatoria}
x / 1
={def h}
(x,1)

    · Caso inductivo : h (x:xs) = (f (x:xs) , g (x:xs))
={def h}
f (x:xs) / g (x:xs)
={def f, def g}
sum (x:xs) / contatoria (x:xs)
={def sum, def contatoria}
(x + sum xs) / (1 + contatoria xs)
={def h}
(x + sum xs , 1 + contatoria xs)
={introducción a y b}
[a := sum xs , b := contatoria xs]
(x + a , 1 + b)
={igualdad de pares}
[(a,b) = (sum xs, contatoria xs)]
(x + a , 1 + b)
={H.I.}
[(a,b) = h xs]
(x + a , 1 + b)

h [x] = (x,1)
h (x:xs) = (x+a , 1+b)
    where
        (a,b) = h xs

h' xs = fst (h xs)


* Ejercicio 11. Implementar todas las funciones obtenidas de las derivaciones
dadas en el téorico y en el practico.