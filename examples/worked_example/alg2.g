##  In this example, we create the path algebra
##       kQ/< a^2, bd, cb, dc, abc-cba, cab, d^4 >
##   where Q is the 2-regular quiver with 2 vertices (v1 and v2) and 4 arrows
##   (a: v1 -> v1, b: v1 -> v2, c: v2 -> v1, d: v2 -> v2). The given relations
##   mean that the indecomposable projective right modules have the following
##   structure
##
##         (P_1)               (P_2)
##          v1                  v2
##        /    \              /    \
##       a      b            c      d
##       |      |            |      |
##      ab      bc          ca      d^2
##        \    /                    |
##        abc=bca                   d^3

# Construct the quiver
q2 := Quiver(
 2,                                             # Number of vertices = 2
 [ [1,1,"a"], [1,2,"b"], [2,1,"c"], [2,2,"d"] ] # List of arrows
 );

# Construct the path algebra
kq2 := PathAlgebra( Rationals, quiv2 );

# Construct the ideal
rels2 := [ kq2.a * kq2.a,
           kq2.b * kq2.d,
           kq2.c * kq2.b,
           kq2.d * kq2.c,
           kq2.c * kq2.a * kq2.b,
           (kq2.d)^4,
           kq2.a * kq2.b * kq2.c - kq2.b * kq2.c * kq2.a ];
gb2 := GBNPGroebnerBasis( rels2, kq2 );
ideal2 := Ideal( kq2, gb2 );
GroebnerBasis( ideal2,gb2 );

# Construct the algebra
alg2 := kq2/ideal2;
