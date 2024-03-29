data BinTree a = Nil | Node (BinTree a) a (BinTree a) deriving (Show)

arb1 = Node (Nil) (5) (Node (Nil) (4) (Node (Node (Nil) (3) (Nil)) (2) (Node (Nil) (1) (Nil))))
arb2 = Node (Node (Node (Node (Node (Node Nil 6 Nil) 5 Nil) 4 Nil) 3 Nil) 2 Nil) 1 Nil
arb3 = Node (Node (Node Nil 4 Nil) 2 (Node Nil 5 Nil)) 1 (Node (Node Nil 6 Nil) 3 (Node Nil 7 Nil))

size :: BinTree a -> Int
size Nil = 0
size (Node hi raiz hd) = 1 + size (hi) + size (hd)

height :: BinTree a -> Int
height Nil = 0
height (Node hi raiz hd) = 1 + max (height2 (hi)) (height2 (hd))

inOrder :: BinTree a -> String
inOrder (Nil) = "Nil "
inOrder (Node hi a hd) = "a" ++ " " ++ inOrder hi ++ inOrder hd
