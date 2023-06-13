Practico 12: Imperativo - Calculo de programas imperativos
################################################################################
# Ejercicio 1. Derivar dos programas que calculen r = X Y a partir de cada una #
# de las siguientes definiciones de la función exponencial:                    #
################################################################################
# · (a)
#     exp (x,y) = (y = 0 → 1
#                 [] y /= 0 → x*exp(x,y-1)
#                 )

# · (b)
#     exp (x,y) = (y = 0 → 1
#                 [] y /= 0 → ( y mod 2 = 0 → exp(x*x,y div 2)
#                             [] y mod 2 = 1 → x*exp(x,y-1)
#                             )
#                 )


# Diseñar los dos programas a partir de:
# Precondición R: {x = X ∧ y = Y ∧ x ≥ 0 ∧ y ≥ 0}
# Postcondición Q: {r = X Y }
# Invariante P: {y ≥ 0 ∧ r ∗ x y = X Y }
# Para cada programa usar una de las definiciones. tener en cuenta las mismas a
# la hora de decidir la manera de achicar la cota.

################################################################################
# Ejercicio 2. Dado n > 0, desarrollar un programa que devuelva en la variable #
# k la mayor potencia de 2 menor o igual que n.                                #
################################################################################
# Precondición R: {n > 0}
# Postcondición Q: {0 < k ≤ n ∧ n < 2 ∗ k ∧ (∃j : 0 ≤ j : k = 2 j )}
# Invariante P: {0 < k ≤ n ∧ (∃j : 0 ≤ j : k = 2 j )}

#############################################
# Ejercicio 3. Sea A un arreglo de enteros. #
#############################################
# · (a) Derivar un programa que determine si todos los elementos de A son positivos.
Q: {(paraTodo i : 0<=i<N : A.i >= 0) = r}
I: {(paraTodo i : 0<=i<j : A.i >= 0) = r ^ 0<=j<=N}
Para sacar la guarda usamos I ^ ¬B -> Q , despejamos B porque I y Q ya los tenemos
I ^ ¬B -> Q
(paraTodo i : 0<=i<j : A.i >= 0) = r ^ 0<=j<=N ^ ¬B -> (paraTodo i : 0<=i<N : A.i >= 0) = r
Si ¬B = {j = N} tenemos
(paraTodo i : 0<=i<j : A.i >= 0) = r ^ 0<=j<=N ^ j = N -> (paraTodo i : 0<=i<N : A.i >= 0) = r
=logica
(paraTodo i : 0<=i<N : A.i >= 0) = r ^ 0<=j<=N -> (paraTodo i : 0<=i<N : A.i >= 0) = r
=precondicion
True

Para sacar la inicializacion usamos {P}S{I} 
busco inicializar las variables libres del invariante (r y j)
como r va a ser el resultado de la especificacion, tengo que ponerle el neutro, en este caso True
como j todavia no trató ningun elemento hay que forzar el rango vacio, en este caso con el 0
La precondicion la tenemos que poner en base a la inicializacion para que cumpla el invariante
o la vemos antes: P = {N >= 0}
la inicializacion S en este caso va a ser j,r := 0,True;

Mientras estoy iterando el invariante se cumple (tercer inciso del do)
I ^ Bi -> {wp} S {I}
(paraTodo i : 0<=i<j : A.i >= 0) = r ^ 0<=j<=N ^ j = N -> {wp} S {(paraTodo i : 0<=i<j : A.i >= 0) = r ^ 0<=j<=N}
=def S
(paraTodo i : 0<=i<j : A.i >= 0) = r ^ 0<=j<=N ^ j = N -> {wp} r,j := E,j+1 {(paraTodo i : 0<=i<j : A.i >= 0) = r ^ 0<=j<=N}
=def wp
(paraTodo i : 0<=i<j : A.i >= 0) = r ^ 0<=j<=N ^ j = N -> {(paraTodo i : 0<=i<(j+1) : A.i >= 0) = E ^ 0<=(j+1)<=N}
=particion de rango
(paraTodo i : 0<=i<j : A.i >= 0) = r ^ 0<=j<=N ^ j = N -> {(paraTodo i : 0<=i<j : A.i >= 0) ^ {(paraTodo i : j<=i<(j+1) : A.i >= 0) = E ^ 0<=(j+1)<=N}
=rango unitario
(paraTodo i : 0<=i<j : A.i >= 0) = r ^ 0<=j<=N ^ j = N -> {(paraTodo i : 0<=i<j : A.i >= 0) ^ A.j >= 0 = E ^ 0<=(j+1)<=N}
=antecedente
(paraTodo i : 0<=i<j : A.i >= 0) = r ^ 0<=j<=N ^ j = N -> {r ^ A.j >= 0 = E ^ 0<=(j+1)<=N}
=antecedente
(paraTodo i : 0<=i<j : A.i >= 0) = r ^ 0<=j<=N -> {r ^ A.j >= 0 = E}
=logica
{r ^ A.j >= 0 = E}

Ver correcion total: 4 y 5. Cota propuesta v = {N-j}
    
r,j := A.i >= 0 && r , j+1 ;

# · (b) Derivar un programa que determine si algún elemento de A es positivo.

######################################################################
# Ejercicio 4. Derivar un programa para la siguiente especificación: #
######################################################################
# M : Int, A : Array[0..M )of Int
# varr : Int
# {M ≥ 1}
# S
# {r = (N p : 0 ≤ p < M : A.p ≥ 0)}

#############################################################################
# Ejercicio 5. Calcular un programa que, dados dos enteros positivos x e y, #
# devuelva en una variable el mı́nimo común múltiplo de ambos.               #
#############################################################################
# Ayuda: el mı́nimo común múltiplo de dos enteros psositivos se puede especificar
# por: mcm.x.y = (M in n : 1 ≤ n ∧ n mod x = 0 ∧ n mod y = 0 : n)

