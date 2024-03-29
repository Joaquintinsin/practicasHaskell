-- f x = x^3
f :: Int -> Int
f 0 = 0
f n = f a + h a + 1
  where a = n-1

h :: Int -> Int
h n = 3 * (g n + n)
  where
    g :: Int -> Int
    g 0 = 0
    g n = g a + 2 * a + 1
      where a = n-1

-- Haskell's implementations of Cube
f' x = x * x * x

f'' x = x^3
