{- Práctico 6: Programación Funcional: Tipos de datos recursivos
1. Definir el tipo Nat, visto en el teórico.
-}
--Forma 1:
data Nat = Zero | Succ Nat deriving (Show, Eq)

class Orden a where
    may :: a -> a -> Bool
    men :: a -> a -> Bool
    mayIg :: a -> a -> Bool
    menIg :: a -> a -> Bool

    may n m = not (menIg n m)
    men n m = not (mayIg n m)
    mayIg n m = not (men n m)
    menIg n m = not (may n m)

instance Orden Nat where
    may Zero (Succ m) = False
    may (Succ n) Zero = True
    may (Succ n) (Succ m) = may n m

{-
--Forma 2:
data Nat = Zero | Succ Nat -- si instanciamos no derivamos

instance Show Nat where
    show = show.natToInt

instance Eq Nat where
    n == m = (natToInt n) == (natToInt m)

permite hacer:
intToNat 4 == intToNat 4
True
ghci> intToNat 4 == intToNat 3
False
ghci> intToNat 2
2
ghci> intToNat (-1)
^CInterrupted.


--Forma 3:
data Nat = Zero | Succ Nat -- si no lo derivamos, por mas que lo instanciemos no podemos mostrarlo. Solo podemos usar las funciones que se le instanciaron, en este caso igual y distinto. La clase Iguales a está instanciando a los Naturales por medio de la clase Iguales a

class Iguales a where
    igual :: a -> a -> Bool
    distinto :: a -> a -> Bool
    igual x y = not (distinto x y)
    distinto x y = not (igual x y)

instance Iguales Nat where
    igual Zero Zero = True
    igual Zero _ = False
    igual _ Zero = False
    igual (Succ n) (Succ m) = igual n m
-}

{- 2. Definir la función natToInt : Nat → Int que dado un número Nat retorna su entero correspondiente.
Por ejemplo: natToInt (Suc(Suc Zero)) = 2. -}
natToInt :: Nat -> Int
natToInt Zero = 0
natToInt (Succ n) = 1 + (natToInt n)

{- 3. Definir la función intToNat : Int → Nat que dado un número entero retorna su Nat correspondiente.
Por ejemplo: intToNat 2 = (Suc(Suc Zero)). -}
intToNat :: Int -> Nat
intToNat 0 = Zero
intToNat x = Succ (intToNat (x-1))

-- 4. Definir la función sumaNat : Nat → Nat → Nat, la cual suma dos números Nat.
sumaNat :: Nat -> Nat -> Nat
sumaNat Zero Zero = Zero
sumaNat Zero m = m
sumaNat n Zero = n
sumaNat n m = intToNat( (natToInt n) + (natToInt m) )

-- multNat, multiplica dos naturales
multNat :: Nat -> Nat -> Nat
multNat Zero m = Zero
multNat n Zero = Zero
multNat n m = intToNat (natToInt n * natToInt m)

-- par, si es par o no un nat
par :: Nat -> Bool
par n = (mod (natToInt n) 2) == 0

-- 5. Definir los árboles binarios.
data BinTree a = Nil | Node (BinTree a) a (BinTree a) deriving (Show)

{-
Node (Nil) 5 (Node (Nil) 4 (Node (Node (Nil) 3 (Nil)) 2 (Node (Nil) 1 (Nil))))
    5
   /  \
Nil     4
       /   \
    Nil     2
           /  \
        3       1
       /  \    /  \
    Nil   Nil Nil Nil

Definir las siguientes funciones sobre árboles binarios: size y height
6. La función size, que dado un árbol retorna el número de nodos del árbol.
7. La función height, que dado un árbol retorna la altura del mismo. -}
size :: BinTree a -> Int
size Nil = 0
size (Node hi raiz hd) = 1 + size (hi) + size (hd)

-- problemas con arboles lineales y arboles comunes
height1 :: BinTree a -> Int
height1 Nil = 0
height1 (Node (Nil) raiz (Nil)) = 1
height1 (Node (Nil) raiz hd) = 1 + height1 (hd)
height1 (Node hi raiz (Nil)) = 1 + height1 (hi)
height1 (Node hi raiz hd) | size hi > size hd = 1 + height1 (hi)
                          | otherwise = 1 + height1 (hd)

-- anda bien
height2 :: BinTree a -> Int
height2 Nil = 0
height2 (Node hi raiz hd) = 1 + max (height2 (hi)) (height2 (hd))

arb1 = Node (Nil) (5) (Node (Nil) (4) (Node (Node (Nil) (3) (Nil)) (2) (Node (Nil) (1) (Nil))))
arb2 = Node (Node (Node (Node (Node (Node Nil 6 Nil) 5 Nil) 4 Nil) 3 Nil) 2 Nil) 1 Nil
arb3 = Node (Node (Node Nil 4 Nil) 2 (Node Nil 5 Nil)) 1 (Node (Node Nil 6 Nil) 3 (Node Nil 7 Nil))

inOrder :: BinTree a -> String
inOrder (Nil) = "Nil "
inOrder (Node hi a hd) = "a" ++ " " ++ inOrder hi ++ inOrder hd
