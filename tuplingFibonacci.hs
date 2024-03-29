-- Ejemplo de Fibonacci con técnica de tupling

-- fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fst(tuplingFib n)
  where
    -- tuplingFib :: Int -> (Int, Int)
    tuplingFib 0 = (0,1)
    tuplingFib n = (b, a + b)
      where (a, b) = tuplingFib (n-1)

-- Si se descomenta el perfil, funciona hasta fib 46, despues se pasa a negativos
-- Si se deja sin un tipo específico, Haskell va a pasar a int o long int, etc cuando lo necesite y va a andar mejor
