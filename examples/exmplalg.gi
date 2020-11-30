InstallGlobalFunction(
    SBStripsExampleAlgebra,
    function( n )
        local
            sba,        # SB algebra
            gb,         # Groebner basis of <ideal>
            ideal,      # Ideal defined by <rels>
            info_quiv,  # Local function that prints info about <quiv>, 
                        #  depending on the level of <InfoSBStrips>
            pa,         # Path algebra
            quiv,       # Ground quiver 
            rels;       # Defining relations

        info_quiv := function( quiver )
            local
                a,  # Arrow variable
                v;  # Vertex variable
                
            Info( InfoSBStrips, 2,
             "The quiver of this algebra has ",
             Length( VerticesOfQuiver( quiver ) ), " vertices" );
             
            for v in VerticesOfQuiver( quiver ) do
                Info( InfoSBStrips, 3, "  ", v );
            od;
            
            Info( InfoSBStrips, 2, "and ",
             Length( ArrowsOfQuiver( quiver ) ), " arrows" );
            
            for a in ArrowsOfQuiver( quiver ) do
                Info( InfoSBStrips, 3, "  ", a, ": ", SourceOfPath( a ),
                 " --> ", TargetOfPath( a )
                 );
            od;
        end;

        if not n in [ 1, 2, 3, 4, 5, 6 ] then
            Error( "The input ", n,
             " should be a positive integer between 1 and 6 inclusive!" );
                
        elif n = 1 then
            quiv := Quiver(
             2,
             [ [ 1, 1, "a" ], [ 1, 2, "b" ], [ 2, 1, "c" ], [ 2, 2, "d" ] ]
             );
            
            pa := PathAlgebra( Rationals, quiv );
            
            rels := [
             pa.a * pa.a,
             pa.b * pa.d,
             pa.c * pa.b,
             pa.d * pa.c,
             pa.c * pa.a * pa.b,
             (pa.d)^4,
             pa.a * pa.b * pa.c - pa.b * pa.c * pa.a
             ];

       elif n = 2 then
            quiv := Quiver(
             3,
             [ [ 1, 2, "a" ], [ 2, 3, "b" ], [ 3, 1, "c" ] ]
             );
            
            pa := PathAlgebra( Rationals, quiv );
            
            rels := NthPowerOfArrowIdeal( pa, 4 );

        elif n = 3 then
            quiv := Quiver(
             4,
             [ [1,2,"a"], [2,3,"b"], [3,4,"c"], [4,1,"d"],
               [4,4,"e"], [1,2,"f"], [2,3,"g"], [3,1,"h"]
             ]
             );
                        
            pa := PathAlgebra( Rationals, quiv );
            
            rels := [
             pa.a * pa.g, pa.b * pa.h, pa.c * pa.e, pa.d * pa.f,
             pa.e * pa.d, pa.f * pa.b, pa.g * pa.c, pa.h * pa.a,
             pa.a * pa.b * pa.c * pa.d * pa.a -
               ( pa.f * pa.g * pa.h )^2 * pa.f,
             pa.d * pa.a * pa.b * pa.c - ( pa.e )^3,
             pa.c * pa.d * pa.a * pa.b * pa.c,
             ( pa.h * pa.f * pa.g )^2 * pa.h
             ];
            
        elif n = 4 then
            quiv := Quiver(
             8,
             [ [ 1, 1, "a" ], [ 1, 2, "b" ], [ 2, 2, "c" ], [ 2, 3, "d" ],
               [ 3, 4, "e" ], [ 4, 3, "f" ], [ 3, 4, "g" ], [ 4, 5, "h" ],
               [ 5, 6, "i" ], [ 6, 5, "j" ], [ 5, 7, "k" ], [ 7, 6, "l" ],
               [ 6, 7, "m" ], [ 7, 8, "n" ], [ 8, 8, "o" ], [ 8, 1, "p" ] 
               ]
             );
             
            pa := PathAlgebra( Rationals, quiv );
            
            rels := [
             pa.a * pa.a, pa.b * pa.d, pa.c * pa.c, pa.d * pa.g,
             pa.e * pa.h, pa.f * pa.e, pa.g * pa.f, pa.h * pa.k,
             pa.i * pa.m, pa.j * pa.i, pa.k * pa.n, pa.l * pa.j,
             pa.m * pa.l, pa.n * pa.p, pa.o * pa.o, pa.p * pa.b,
             pa.a * pa.b * pa.c * pa.d,
             pa.c * pa.d * pa.e - pa.d * pa.e * pa.f * pa.g,
             pa.e * pa.f * pa.g * pa.h,
             pa.g * pa.h * pa.i * pa.j * pa.k,
             pa.f * pa.g * pa.h * pa.i -
               pa.h * pa.i * pa.j * pa.k * pa.l,
             pa.j * pa.k * pa.l * pa.m * pa.n - pa.m * pa.n * pa.o,
             pa.o * pa.p * pa.a * pa.b - pa.p * pa.a * pa.b * pa.c
             ];
            
        elif n = 5 then
            quiv := Quiver(
             4,
             [ [ 1, 2, "a" ], [ 2, 3, "b" ], [ 3, 4, "c" ], [ 4, 1, "d" ],
               [ 1, 2, "e" ], [ 2, 3, "f" ], [ 3, 1, "g" ], [ 4, 4, "h" ]
               ]
             );
            
            pa := PathAlgebra( Rationals, quiv );
            
            rels := [
             pa.a * pa.f, pa.b * pa.g, pa.c * pa.h, pa.d * pa.e,
             pa.e * pa.b, pa.f * pa.c, pa.g * pa.a, pa.h * pa.d,
             pa.a * pa.b * pa.c * pa.d * pa.a * pa.b -
               pa.e * pa.f * pa.g * pa.e * pa.f * pa.g * pa.e * pa.f,
             pa.c * pa.d * pa.a * pa.b * pa.c * pa.d -
               pa.g * pa.e * pa.f * pa.g * pa.e * pa.f * pa.g,
             pa.b * pa.c * pa.d * pa.a * pa.b * pa.c,
             pa.d * pa.a * pa.b * pa.c * pa.d * pa.a,
             ( pa.h )^6
             ];
        
        elif n = 6 then
            quiv := Quiver(
             2,
             [ [ 1, 2, "a" ], [ 2, 1, "b" ], [ 1, 1, "c" ], [ 2, 2, "d" ] ]
             );
            
            pa := PathAlgebra( Rationals, quiv );
            
            rels := [
             pa.a * pa.d, pa.b * pa.a, (pa.c)^2, pa.d * pa.b,
             pa.a * pa.b * pa.c - pa.c * pa.a * pa.b,
             pa.b * pa.c * pa.a, pa.d^3
             ];

        fi;
        
        info_quiv( quiv );
        
        gb := GBNPGroebnerBasis( rels, pa );
        ideal := Ideal( pa, gb );
            
        GroebnerBasis( ideal, gb );
            
        sba := pa/ideal;
        
        return sba;
    end
);