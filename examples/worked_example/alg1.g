##  In this example, we create the path algebra kQ/J^4, where Q is the 1-
##   regular quiver with 3 vertices (v1, v2, v3) and 3 arrows (a: v1 -> v2,
##   b: v2 -> v3, c: v3 -> v1) and J is the arrow ideal.

# Construct the quiver
q1 := Quiver(
 3,                                   # Number of vertices = 3
 [ [1,2,"a"], [2,3,"b"], [3,1,"c"] ]  # List of arrows
 );

# Construct the path algebra
kq1 := PathAlgebra( Rationals, q1 );

# Construct the ideal
rels1 := NthPowerOfArrowIdeal( kq1, 4 );
gb1 := GBNPGroebnerBasis( rels1, kq1 );
ideal1 := Ideal( kq1, gb1 );
GroebnerBasis( ideal1, gb1 );

# Construct the algebra
alg1 := kq1/ideal1;
