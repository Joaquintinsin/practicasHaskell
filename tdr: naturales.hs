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

natToInt :: Nat -> Int
natToInt Zero = 0
natToInt (Succ n) = 1 + (natToInt n)

intToNat :: Int -> Nat
intToNat 0 = Zero
intToNat x = Succ (intToNat (x-1))

sumaNat :: Nat -> Nat -> Nat
sumaNat Zero Zero = Zero
sumaNat Zero m = m
sumaNat n Zero = n
sumaNat n m = intToNat( (natToInt n) + (natToInt m) )

multNat :: Nat -> Nat -> Nat
multNat Zero m = Zero
multNat n Zero = Zero
multNat n m = intToNat (natToInt n * natToInt m)

par :: Nat -> Bool
par n = (mod (natToInt n) 2) == 0
