##  In this example, we construct the algebra
##       kQ/< Al*Ch, Be*Ps, Ga*Ep, De*Ph, Ep*De, Ph*Be, Ch*Ga, Ps*Al,
##            Al*Be*Ga*De*Al - (Ph*Ch*Ps)^2,
##            De*Al*Be*Ga - Ep^3
##            Ga*De*Al*Be*Ga,
##            (Ps*Ph*Ch)^2*Ps
##   where Q is the 2-regular quiver with 4 vertices (v1, v2, v3, v4) and 8
##   arrows (Al: v1 -> v2, Be: v2 -> v3, Ga: v3 -> v4, De: v4 -> v1,
##   Ep: v4 -> v4, Ph: v1 -> v2, Ch: v2 -> v3, Ps: v3 -> v1 ). The given
##   relations mean that the indecomposable projective right modules have the
##   following structure
##
##                 (P_1)                                   (P_2)
##                  v1                                      v2
##                /    \                                  /    \
##              Al      Ph                              Be      Ch*Ps
##              |        |                              |        | 
##           Al*Be      Ph*Ch                        Be*Ga      Ch*Ps
##              |        |                              |        |
##              |       Ph*Ch*Ps                  Be*Ga*De      Ch*Ps*Ph
##           Al*Be       |                              |        |
##              |       Ph*Ch*Ps*Ph            Be*Ga*De*Al      Ch*Ps*Ph*Ch
##              |        |                              |        |
##        Al*Be*Ga      Ph*Ch*Ps*Ph         Be*Ga*De*Al*Be      Ch*Ps*Ph*Ch*Ps
##              |        |                                       |
##              |       Ph*Ch*Ps*Ph*Ch                          (Ch*Ps*Ph)^2
##     Al*Be*Ga*De       |                                       |
##              |       (Ph*Ch*Ps)^2                            (Ch*Ps*Ph)^2*Ch
##               \      /
##   Al*Be*Ga*De*Al = (Ph*Ch*Ps)^2*Ph
##
##               (P_3)                                (P_4)
##                v3                                   v4
##              /    \                               /    \
##            De      Ps                           De      |
##            |        |                           |      Ep
##         Ga*De      Ps*Ph                     De*Al      |
##            |        |                           |      Ep^2
##      Ga*De*Al      Ps*Ph*Ch               De*Al*Be      |
##            |        |                            \     /
##   Ga*De*Al*Be      Ps*Ph*Ch*Ps          De*Al*Be*Ga = Ep^3
##                     |
##                    Ps*Ph*Ch*Ps*Ph
##                     |
##                    (Ps*Ph*Ch)^2

# Construct the quiver
#  (just in case it isn't clear: the arrow names are short for Greek letters)
q3 := Quiver(
 4,                                                     # Number of verts = 4
 [ [1,2,"Al"], [2,3,"Be"], [3,4,"Ga"], [4,1,"De"],      # List of arrows
   [4,4,"Ep"], [1,2,"Ph"], [2,3,"Ch"], [3,1,"Ps"] ]
 );
 
# Construct the path algebra
kq3 := PathAlgebra( Rationals, q3 );

# Construct the ideal
rels3 := [ kq3.Al * kq3.Ch,
           kq3.Be * kq3.Ps,
           kq3.Ga * kq3.Ep,
           kq3.De * kq3.Ph,
           kq3.Ep * kq3.De,
           kq3.Ph * kq3.Be,
           kq3.Ch * kq3.Ga,
           kq3.Ps * kq3.Al,
           kq3.Al * kq3.Be * kq3.Ga * kq3.De * kq3.Al -
            ( kq3.Ph * kq3.Ch * kq3.Ps )^2 * kq3.Ph,
           kq3.De * kq3.Al * kq3.Be * kq3.Ga - ( kq3.Ep )^3,
           kq3.Ga * kq3.De * kq3.Al * kq3.Be * kq3.Ga,
           ( kq3.Ps * kq3.Ph * kq3.Ch )^2 * kq3.Ps,
];
gb3 := GBNPGroebnerBasis( rels3, kq3 );
ideal3 := Ideal( kq3, gb3 );
GroebnerBasis( ideal3, gb3 );

# Construct the algebra
alg3 := kq3/ideal3;
