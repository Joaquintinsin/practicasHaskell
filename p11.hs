Práctico 11: Imperativo - Lógica de Hoare
    · Reglas wp
{wp}.False = False
{wp}.S.{Q} ^ {wp}.S.{R} = {wp}.S.{Q^R}
{wp}.S.{Q} v {wp}.S.{R} -> {wp}.S.{QvR}
{wp}.skip.{Q} = {Q}
{wp}.(x:=E).{Q} = {Q(x:=E)}
{wp}.S;T.{Q} = {wp}.S.{{wp}.T.{Q}}
{wp}.if.{Q} = {(B0 v B1 v ... v Bn) ^ (B0 -> {wp}.S0.{Q}) ^ ... ^ (Bn -> {wp}.Sn.{Q})}

################################################################################
#Ejercicio 1. Encontrar la precondición más débil de los siguientes programas: #
################################################################################
#    a.  {wp} x := (x - y) * (x + y) {(x + y² = 0)}
=wp de la asignacion
{ (((x-y)*(x+y)) + y² = 0) }
=diferencia de cuadrado
{ x²-y² + y² = 0 }
=existencia del opuesto
{ x² = 0 }
=raiz en ambos lados
{ x=0 }

wp = {x=0}

#    b. {wp} q, r := q + 1, r - y {q * y + r = x}
=wp de la asignacion
{ (q+1) * y + (r-y) = x }
=distributiva
{ qy + y + r - y = x }
=existencia del opuesto
{ qy + r = x }

wp = { qy + r = x }

#    c. {wp}
#       a := a ≡ b;
#       b := a ≡ b;
#       a := a ≡ b;
#       { (a≡ B) ^ (b≡ A) }
=wp de la composicion {wp}.S;T.{Q} = {wp}.S.{{wp}.T.{Q}}
{wp} a := a ≡ b {{wp} b := a ≡ b {{wp} a := a ≡ b { (a ≡ B) ^ (b ≡ A) }}}
=wp de la asignacion {wp}.(x:=E).{Q} = {Q(x:=E)}
{wp} a := a ≡ b {{wp} b := a ≡ b {(a ≡ b ≡ B) ^ (b ≡ A) }}
=wp de la asignacion
{wp} a := a ≡ b {{(a ≡ (a ≡ b) ≡ B) ^ ((a ≡ b) ≡ A) }}
=wp de la asignacion
{{((a ≡ b) ≡ ((a ≡ b) ≡ b) ≡ B) ^ (((a ≡ b) ≡ b) ≡ A) }}
=asociatividad y conmutativa equivalencia
{{(a ≡ a) ≡ (b ≡ b) ≡ b ≡ B ^ a ≡ (b ≡ b) ≡ A}}
=existencia neutro
{{True ≡ True ≡ b ≡ B ^ a ≡ True ≡ A}}
=existencia neutro
{b ≡ B ^ a ≡ A}

wp = {b ≡ B ^ a ≡ A}

###############################################
#Ejercicio 2. Calcular expresiones E tal que: #
###############################################
    · Reglitas Ternas Hoare
{P} x := E {Q} ≡ [P -> Q(x := E)]
{P} S;T {Q} ≡ {P} S {R} ^ {P} T {Q}
{P} S {Q} ≡ [P -> wp.S.Q]

#    a.  {A = q * B + r} q := E; r := r - B {A = q * B + r}
=Def wp , def wp composicion
(A = q * B + r) -> {wp} q := E {{wp} r := r - B {A = q * B + r}}
=Def wp composicion
(A = q * B + r) -> {wp} q := E {A = q * B + (r - B)}
=Def wp composicion
(A = q * B + r) -> {A = E * B + (r - B)}
=Asociatividad
(A = q * B + r) -> {A = E * B + r - B}
=Precondicion
q * B + r = E * B + r - B
=Resto r ambos lados
q * B = E * B - B
=Sumo B ambos lados
(q * B) + B = E * B
=Factor comun
B * (q + 1) = E * B
=Divido B ambos lados
q + 1 = E


#    b.  {x * y + p * q = N } x := x - p; q := E {x * y + p * q = N }
=Def wp
(x * y + p * q = N) -> {wp} x := x - p; q := E {x * y + p * q = N}
=Def wp composicion
(x * y + p * q = N) -> {wp} x := x - p {{wp} q := E {x * y + p * q = N}}
=Def wp asignacion
(x * y + p * q = N) -> {wp} x := x - p {x * y + p * E = N}
=Def wp asignacion
(x * y + p * q = N) -> {(x - p) * y + p * E = N}
=Distributiva
(x * y + p * q = N) -> {x * y - p * y + p * E = N}
=Precondición
x*y - p*y + p*E = x*y + p*q
=Resto x*y ambos lados
- p*y + p*E = p*q
=Factor comun
p * (-y + E) = p*q
=Divido p ambos lados
-y + E = q
=Resto y ambos lados
E = q + y

#################################################################
#* Ejercicio 3. Demostrar la corrección del siguiente programa: #
#################################################################
#    {x = A ^ y = B}
#    x := x - y;
#    y := x + y;
#    x := y - x;
#    {x = B ^ y = A}
=def wp : {P} S {Q} ≡ [P -> wp.S.Q]
[(x = A ^ y = B) -> {wp} x := x - y; y := x + y; x := y - x; {x = B ^ y = A}]
=def wp composicion
[(x = A ^ y = B) -> {wp} x := x - y; y := x + y; {{wp} x := y - x {x = B ^ y = A}}]
=def wp asignacion
[(x = A ^ y = B) -> {wp} x := x - y; y := x + y; {y - x = B ^ y = A}]
=def wp composicion
[(x = A ^ y = B) -> {wp} x := x - y; {{wp} y := x + y {y - x = B ^ y = A}}]
=def wp asignacion
[(x = A ^ y = B) -> {wp} x := x - y; {(x + y) - x = B ^ (x + y) = A}]
=def wp asignacion
[(x = A ^ y = B) -> {((x - y) + y) - (x - y) = B ^ ((x - y) + y) = A}]
=asociatividad
[(x = A ^ y = B) -> {x - y + y - (x - y) = B ^ (x - y + y) = A}]
=existencia opuesto, prop distributiva
[(x = A ^ y = B) -> {x - x + y = B ^ x = A}]
=existencia opuesto
[(x = A ^ y = B) -> { y = B ^ x = A}]
={logica}
True

####################################################################
#Ejercicio 4. Demostrar la corrección de los siguientes programas. #
####################################################################
#En todos los casos x, y: Int y a, b: Bool.
# a. {True}
#    if x ≥ y -> skip
#    [] x ≤ y -> x,y := y,x
#    fi
#    {x ≥ y}
=def wp
[P -> {wp}.S.{Q}]
=(P = True) , (S = if) , Q = (x ≥ y)
[True -> {wp}.if.{x ≥ y}]
=def wp if : {wp}.if.{Q} = {(B0 v B1 v ... Bn) ^ (B0 -> {wp}.S0.{Q}) ^ ... ^ (Bn -> {wp}.Sn.{Q})}
[True -> {(x ≥ y v x ≤ y) ^ (x ≥ y -> {wp}.skip.{x ≥ y}) ^ (x ≤ y -> {wp}. x,y := y,x .{x ≥ y})}]
=logica
{True ^ (x ≥ y -> {wp}.skip.{x ≥ y}) ^ (x ≤ y -> {wp}. x,y := y,x .{x ≥ y})}
=logica , def wp skip , def wp asignacion
{(x ≥ y -> x ≥ y) ^ (x ≤ y -> y ≥ x)}
=logica
{True ^ True}
=logica
True


# b. {True}
#    x, y := y * y, x * x;
#    if x ≥ y -> x := x + 1
#    [] x ≤ y -> y := y - x
#    fi
#    {x ≥ 0 ^ y ≥ 0}
={def wp}
[P -> {wp}.S.{Q}]
={reemplazo}
[True -> {wp}. x,y := y*y, x*x ; if .{x ≥ 0 ^ y ≥ 0}]
={logica , def wp composicion}
{wp}. x,y := y*y, x*x ; {{wp}.if.{x ≥ 0 ^ y ≥ 0}}
={def wp if}
{wp}. x,y := y*y, x*x ; {(x ≥ y v x ≤ y) ^ (x ≥ y -> {wp}. x := x + 1 .{x ≥ 0 ^ y ≥ 0}) ^ (x ≤ y -> {wp}. y := y - x .{x ≥ 0 ^ y ≥ 0})}
={logica , def wp asignacion x2}
{wp}. x,y := y*y, x*x ; {True ^ (x ≥ y -> {x + 1 ≥ 0 ^ y ≥ 0}) ^ (x ≤ y -> {x ≥ 0 ^ y - x ≥ 0})}
={logica: existencia neutro ^}
{wp}. x,y := y*y, x*x ; {(x ≥ y -> {x + 1 ≥ 0 ^ y ≥ 0}) ^ (x ≤ y -> {x ≥ 0 ^ y - x ≥ 0})}
={def wp asignacion}
{((y*y) ≥ (x*x) -> {(y*y) + 1 ≥ 0 ^ (x*x) ≥ 0}) ^ ((y*y) ≤ (x*x) -> {(y*y) ≥ 0 ^ (x*x) - (y*y) ≥ 0})}
={logica: precondicion & transitividad ≥}
{True ^ ((y*y) ≤ (x*x) -> {(y*y) ≥ 0 ^ (x*x) - (y*y) ≥ 0})}
={logica: existencia neutro ^}
{((y*y) ≤ (x*x) -> {(y*y) ≥ 0 ^ (x*x) - (y*y) ≥ 0})}
={aritmetica}
{(0 ≤ (x*x) - (y*y) -> {(y*y) ≥ 0 ^ (x*x) - (y*y) ≥ 0})}
={logica: precondicion}
{(y*y) ≥ 0 ^ True}
={logica: existencia neutro ^ . prop potencia en R}
True


# c. {True}
#    if not a or b -> a := not a
#    [] a or not b -> b := not b
#    fi
#    {a ∨ b}
=def wp
[True -> {wp}.if.{a ∨ b}]
=logica , def wp if
{(not a or b v a or not b) ^ (not a or b -> {wp}. a := not a .{a ∨ b}) ^ (a or not b -> {wp}. b := not b .{a ∨ b})}
=logica: tautologia v
{True ^ (not a or b -> {wp}. a := not a .{a ∨ b}) ^ (a or not b -> {wp}. b := not b .{a ∨ b})}
=logica: existencia neutro ^ . def wp asignacion x2
{(not a or b -> {(not a) ∨ b}) ^ (a or not b -> {a ∨ (not b)})}
= or = v
{((not a) or b -> {(not a) or b}) ^ (a or (not b) -> {a or (not b)})}
=logica
{True ^ True}
=logica
True


# d. {N ≥ 0}
#    x := 0
#    do x <> N -> x := x + 1
#    od
#    {x = N}

## como cota: tomar algo relacionado con el programa de manera tal que la accion achique la cota.
## elegir una cota entendiendo lo que va haciendo el programa y que acciones va haciendo para que yo tome eso
## como cota. preg orientativas: que variable itero? hasta donde la itero?
## invariante asociado a la postcondicion siempre
## el invariante es un predicado que vale antes de entrar al ciclo, durante y al finalizar el ciclo.

I = {x ≤ N}
Demostracion del do por medio del teorema:
#    · Inicializacion: {P}.S0.{I}
{N ≥ 0}. x := 0 .{x ≤ N}
=def wp
[N ≥ 0 -> {wp}. x := 0 .{x ≤ N}]
={def wp asignacion}
[N ≥ 0 -> {0 ≤ N}]
={logica}
True

#    · Postcondición: I ^ not B0 ^ ... ^ not Bn -> Q
x ≤ N ^ not (x <> N) -> x = N
={logica}
x ≤ N ^ x = N -> x = N
={precondicion}
True

#    · Invariante: {Bi ^ I}.Si.{I}
{(x <> N) ^ x ≤ N} x := x + 1 {x ≤ N}
={def wp}
[(x <> N) ^ x ≤ N -> {wp} x := x + 1 {x ≤ N}]
={def wp asignacion}
[(x <> N) ^ x ≤ N -> x+1 ≤ N]
={logica}
[x < N -> x+1 ≤ N]
={aritmetica}
[x < N -> x ≤ N - 1]
={aritmetica}
[x < N -> x < N]
={logica}
True

# Correción parcial demostrada.
# Dem correción total:
v = {N - x}
#    · Variante (a): I ^ Bi -> v ≥ 0
x ≤ N ^ x <> N -> N - x ≥ 0
={aritmetica}
x ≤ N ^ x <> N -> N ≥ x
    Podria ser True directamente porque p ^ q -> p = True
={precondicion}
x ≤ N ^ x <> N -> N > x
={logica}
x < N -> N > x
={logica}
True

#    · Variante (b): {I ^ Bi ^ v = A}.Si.{v < A}
{x ≤ N ^ x <> N ^ N - x = A} x := x + 1 {N - x < A}
={def wp}
[{x ≤ N ^ x <> N ^ N - x = A} -> {wp} x := x + 1 {N - x < A}]
={wp asignacion}
[{x ≤ N ^ x <> N ^ N - x = A} -> {N - (x + 1) < A}]
={logica}
[{x < N ^ N - x = A} -> {N - (x + 1) < A}]
={aritmetica}
[{x < N ^ N - x = A} -> {N - x < A + 1}]
    desde acá, en (*) hay otra forma
={aritmetica}
[{0 < N - x ^ N - x = A} -> {N - x < A + 1}]
={precondicion}
[{0 < N - x ^ N - x = A} -> {N - x < N - x + 1}]
={aritmetica}
[{0 < N - x ^ N - x = A} -> {0 < 1}]
={logica}
[{0 < N - x ^ N - x = A} -> True]
={logica}
True

(*)
={leibniz}
[{0 < 0} -> {N - x < 1}]
={logica}
[False -> {N - x < 1}]
={logica}
True

# Correción total demostrada.


###########################################
#Ejercicio 5. Dado el siguiente programa: #
###########################################
# con N : Nat
# var n : Nat; r : Bool
# var A: array array:[0..N) of Nat
#     {N > 0}
#      n,r := 0, True
#         I = {r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n ≤ N }
#      do n <> N
#       n,r := n + 1, r and A.n = A.(N - n -1)
#      od
#     {r = <∀i : 0 ≤ i < N : A.i = A.(N - i - 1)> }

¿Qué hace este algoritmo? Demostrar la corrección del mismo.
    Compara capicuamente los elementos de un arreglo que sean todos iguales

## recorrer una secuencia: remplazar cte por variable. la cte que remplazo es el limite hasta donde llega la sec

# Demostracion parcial:
# 1) Inicializacion: {P} S {I}
=def wp
[P -> {wp} S {I}]
=def P, S, I
[{N > 0} -> {wp} n,r := 0, True {r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n ≤ N }]
=def wp asignacion
[{N > 0} -> True = <∀i : 0 ≤ i < 0 : A.i = A.(N - i - 1)> ^ 0 ≤ 0 ≤ N]
=rango vacio, aritmetica
[{N > 0} -> True = True ^ 0 ≤ N]
=def =
[{N > 0} -> True ^ 0 ≤ N]
=existencia neutro ^ , aritmetica
[{N > 0} -> 0 < N v 0 = N]
=precondicion
True

# 2) Postcondicion: I ^ ~B0 ^ ... ^ ~Bn -> Q
=def I, B0, Q
{r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n ≤ N } ^ ~(n <> N) 
    -> {r = <∀i : 0 ≤ i < N : A.i = A.(N - i - 1)> }
=def ~ , asoc y conm ^
{r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n ≤ N } ^ n = N 
    -> {r = <∀i : 0 ≤ i < N : A.i = A.(N - i - 1)> }
=leibniz
{r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n ≤ N } ^ n = N 
    -> {r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> }
=asociativa de ^
r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ (0 ≤ n ≤ N ^ n = N) 
    -> {r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> }
=logica
r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ N 
    -> {r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> }
=logica p ^ q -> p = true
True

# 3) Invariante: {Bi ^ I}.Si.{I}
{n <> N ^ {r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n ≤ N }}
    n,r := n + 1, r and A.n = A.(N - n -1)
{r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n ≤ N }
=def wp
[{n <> N ^ {r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n ≤ N }}
    -> {wp}.n,r := n + 1, r and A.n = A.(N - n -1).{r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n ≤ N }]
=def wp asignacion
[{n <> N ^ {r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n ≤ N }}
    -> {(r ^ A.n = A.(N - n -1)) = <∀i : 0 ≤ i < n + 1 : A.i = A.(N - i - 1)> ^ 0 ≤ n + 1 ≤ N }]
=rango unitario
[{n <> N ^ {r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n ≤ N }}
    -> {(r ^ <∀i : i = n : A.i = A.(N - i - 1)> = <∀i : 0 ≤ i < n + 1 : A.i = A.(N - i - 1)> ^ 0 ≤ n + 1 ≤ N }]
=antecedente : r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)>
[{n <> N ^ {r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n ≤ N }}
    -> {(<∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ <∀i : i = n : A.i = A.(N - i - 1)> = <∀i : 0 ≤ i < n + 1 : A.i = A.(N - i - 1)> ^ 0 ≤ n + 1 ≤ N }]
=particion de rango al reves
[{n <> N ^ {r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n ≤ N }}
    -> {(<∀i : 0 ≤ i ≤ n : A.i = A.(N - i - 1)> = <∀i : 0 ≤ i < n + 1 : A.i = A.(N - i - 1)> ^ 0 ≤ n + 1 ≤ N }]
=logica
[{n <> N ^ {r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n ≤ N }}
    -> {(<∀i : 0 ≤ i ≤ n : A.i = A.(N - i - 1)> = <∀i : 0 ≤ i ≤ n : A.i = A.(N - i - 1)> ^ 0 ≤ n + 1 ≤ N }]
=def igualdad
[{n <> N ^ {r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n ≤ N }}
    -> True ^ 0 ≤ n + 1 ≤ N }]
=existencia neutro ^
[{n <> N ^ {r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n ≤ N }}
    -> 0 ≤ n + 1 ≤ N }]
=logica
[{{r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n < N }}
    -> 0 ≤ n + 1 ≤ N }]
=monotonia de relacion de orden (0 ≤ n < N -> 0 ≤ n + 1 ≤ N)
True

# Correccion parcial demostrada.

# Correccion total:
    · v = {N-n}
# 4) Variante (a): I ^ Bi -> v ≥ 0
r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n ≤ N ^ n <> N -> N-n ≥ 0
=logica, aritmetica
r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n < N -> N ≥ n
=logica
r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ (0 ≤ n ^ n < N) -> (N > n v N = n)
=logica q ^ s ^ p -> p v r = True
True

# 5) Variante (b) : {I ^ Bi ^ v=A} Si {v<A}
{r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n ≤ N ^ n <> N ^ N-n = A} 
    n,r := n + 1, r and A.n = A.(N - n -1)
{N-n<A}
=logica
{r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n < N ^ N-n = A} 
    n,r := n + 1, r and A.n = A.(N - n -1)
{N-n<A}
=def wp
[{r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n < N ^ N-n = A} 
    -> {wp} n,r := n + 1, r and A.n = A.(N - n -1) {N-n<A}]
=def wp asignacion
[{r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n < N ^ N-n = A} -> {N-n-1<A}]
=leibniz
[{r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n < N ^ N-n = A} -> {A-1<A}]
=aritmetica
[{r = <∀i : 0 ≤ i < n : A.i = A.(N - i - 1)> ^ 0 ≤ n < N ^ N-n = A} -> True]
=logica
True

# Correcion total demostrada.
