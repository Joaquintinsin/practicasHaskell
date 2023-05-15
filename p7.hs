--Ejercicio 1 Utilizando el calculo proposicional presentado en el teorico, demuestre las siguientes formulas.
-- 1) (P → Q) ∨ (Q → P)
(P → Q) ∨ (Q → P)
≡ {def impl x2}
(P v Q ≡ Q) v (Q v P ≡ P)
≡ {distr v ≡}
((P v Q ≡ Q) v (Q v P) ) ≡ ((P v Q ≡ Q) v P)
≡ {asoc v}
((P v Q ≡ Q) v Q v P ) ≡ ((P v Q ≡ Q) v P)
≡ {distr v ≡}
((P v Q v Q ≡ Q v Q) v P ) ≡ ((P v Q v P ≡ Q v P))
≡ {idemp v}
((P v Q ≡ Q) v P ) ≡ ((P v Q ≡ Q v P))
≡ {neutro ≡}
True

-- 2) P → Q ≡ ¬P ∨ Q
P → Q ≡ ¬P ∨ Q
≡ {def impl}
(P v Q ≡ Q) ≡ ¬P v Q
≡ {neutro v}
(P v Q ≡ Q v False) ≡ ¬P v Q
≡ {distr v ≡}
(P ≡ False) v Q ≡ ¬P v Q
≡ {contrapositiva}
¬P v Q ≡ ¬P v Q
≡ {neutro}
True

-- 3) P ∨ (P ∧ Q) ≡ P
P ∨ (P ∧ Q) ≡ P
≡ {regla dorada}
P v (P ≡ Q ≡ P v Q) ≡ P
≡ {distr v ≡}
(P v P ≡ (P v (Q ≡ P v Q))) ≡ P
≡ {distr v ≡}
(P v P ≡ (P v Q ≡ P v (P v Q))) ≡ P
≡ {idemp v x2}
P ≡ (P v Q ≡ P v Q) ≡ P
≡ {simetria}
P ≡ P ≡ (P v Q ≡ P v Q)
≡ {neutro x2}
True ≡ True
≡ {neutro}
True

{- Ejercicio 2 Recuerde el mundo de los caballeros y mentirosos. En este mundo hay dos clases de personas:
· los caballeros que solo dicen la verdad.
· los mentirosos que solo dicen mentiras.
Suponiendo que encontramos una persona A en este mundo que nos dice una asercion S. Esta situacion es formalizada con la formula A ≡ S (intuitivamente A es un caballero si y solo si nos dice la verdad). Utilizando la logica proposicional, averigue (en caso de ser posible) quienes son caballeros y quienes mentirosos en los siguientes casos: -}
-- 1) A dice: yo soy un caballero y B es un mentiroso.
A ≡ A ^ ¬B
≡ {regla dorada}
¬B ≡ ¬B v A
≡ {neutro v}
¬B v False ≡ ¬B v A
≡ {distr v ≡}
¬B v (False ≡ A)
≡ {contrapositiva}
¬B v ¬A

entonces, B es un mentiroso o A es un mentiroso

-- 2) A dice: yo soy un mentiroso y B es un caballero.
A ≡ ¬A ^ B
≡ {doble negacion}
¬¬A ≡ ¬A ^ B
≡ {neg ≡}
¬(¬A ≡ ¬A ^ B)
≡ {regla dorada}
¬(B ≡ B v ¬A)
≡ {neutro v}
¬(B v False ≡ B v ¬A)
≡ {distr v ≡}
¬(B v (False ≡ ¬A))
≡ {contrapositiva}
¬(B v A)
≡ {De Morgan}
¬B ^ ¬A

entonces, B es un mentiroso y A es un mentiroso

-- 3) A dice: yo soy un caballero y B es un caballero.
A ≡ A ^ B
≡ {regla dorada}
B ≡ B v A
≡ {neutro v}
B v False ≡ B v A
≡ {distr v ≡}
B v (False ≡ A)
≡ {contrapositiva}
B v ¬A

entonces, B es un caballero o A es un mentiroso

-- 4) Nos encontramos con A y B, A dice: al menos uno de nosotros es un mentiroso
A ≡ ¬A v ¬B
≡ {De Morgan}
A ≡ ¬(A ^ B)
≡ {neg ≡}
¬(A ≡ A ^ B)
≡ {regla dorada}
¬(B ≡ B v A)
≡ {neutro v}
¬(B v False ≡ B v A)
≡ {distr v ≡}
¬(B v (False ≡ A))
≡ {contrapositiva}
¬(B v ¬A)
≡ {De Morgan}
¬B ^ ¬¬A
≡ {doble neg}
¬B ^ A

entonces, B es un mentiroso y A es un caballero

-- 5) A dice: yo soy un mentiroso o B es un caballero.
A ≡ ¬A v B
≡ {De Morgan}
A ≡ ¬(A ^ ¬B)
≡ {neg ≡}
¬(A ≡ A ^ ¬B)
≡ {regla dorada}
¬(¬B ≡ ¬B v A)
≡ {neutro v}
¬(¬B v False ≡ ¬B v A)
≡ {distr v ≡}
¬(¬B v (False ≡ A))
≡ {contrapositiva}
¬(¬B v ¬A)
≡ {De Morgan}
¬¬B ^ ¬¬A
≡ {doble neg x2}
B ^ A

entonces, B es un caballero y A es un caballero

-- 6) Le preguntan a A si es un caballero. A responde:Si soy un caballero, entonces me comere el sombrero. Demostrar que A se tiene que comer el sombrero.
A ≡ A -> C
≡ {def imp}
A ≡ ¬A v C
≡ {De Morgan}
A ≡ ¬(A ^ ¬C)
≡ {neg ≡}
¬(A ≡ A ^ ¬C)
≡ {regla dorada}
¬(¬C ≡ ¬C v A)
≡ {neutro v}
¬(¬C v False ≡ ¬C v A)
≡ {distr v ≡}
¬(¬C v (False ≡ A))
≡ {contrapositiva}
¬(¬C v ¬A)
≡ {De Morgan}
¬¬C ^ ¬¬A
≡ {doble neg x2}
C ^ A

entonces, dado que A es un caballero por hipótesis, la fórmula C ^ A debe resultar verdadera: como A ≡ True, entonces C ≡ True
por el neutro de ^. C significa que se comerá el sombrero, dado que es True, entonces A se debe comer el sombrero.

-- Ejercicio 3 Dada la definicion del cuantificador N : (N i : R.i : T.i) = (Sumatoria i : R.i ∧ T.i : 1)
-- 1) Enunciar y demostrar la regla de particion de rango de la contatoria.
{regla de particion de rango:
(⊕i : R ∨ S : Ti) = (⊕i : R : Ti) ⊕ (⊕i : S : Ti) [Partición de Rango]
Siempre que ⊕ sea idempotente o R ∧ S ≡ false.}

(N i : R.i v S.i : T.i)
≡ {def N}
(Sumatoria i : (R.i v S.i) ^ T.i : 1)
≡ {distr v ^}
(Sumatoria i : (R.i ^ T.i) v (S.i ^ T.i) : 1)
≡ {partición de rango: sumatoria es idempotente (asociativa y conmutativa)}
(Sumatoria i : R.i ^ T.i : 1) + (Sumatoria i : S.i ^ T.i : 1)
≡ {def N}
(N i : R.i ^ T.i : 1) + (N i : S.i ^ T.i : 1)

-- 2) Idem con la regla del rango vacio.
{regla de rango vacio:
    (⊕i : False : Ti) = e [Rango Vacio] (e es el neutro de ⊕)

(N i : False : T.i)
≡ {def N}
(Sumatoria i : False ^ T.i : 1)
≡ {def ^}
(Sumatoria i : False : 1)
≡ {regla rango vacío = neutro de Sumatoria}
0

-- 3) Probar (Sumatoria i : R.i ∧ T.i : K) = K ∗ (N i : R.i : T.i)
¿(Sumatoria i : R.i ∧ T.i : K) = K ∗ (N i : R.i : T.i)?
K ∗ (N i : R.i : T.i
≡ {def N}
K * (Sumatoria i : R.i ^ T.i : 1)
≡ {prop distr}
(Sumatoria i : R.i ^ T.i : k * 1)
≡ {aritmetica}
(Sumatoria i : R.i ^ T.i : k)

