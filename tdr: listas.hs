data ListInt = Nil | Concat Int ListInt
-- where Concat :: Int -> ListInt -> ListInt

data List a = Nill | Conc a (List a)
-- where Conc :: a -> (List a) -> (List a)

data NoEmptyList a = Only a | Con a (NoEmptyList a)
-- where Conc :: a -> (NoEmptyList a) -> (NoEmptyList a)
