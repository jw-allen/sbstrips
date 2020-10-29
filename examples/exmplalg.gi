InstallGlobalFunction(
    SBStripsExampleAlgebra,
    MemoizePosIntFunction(
        function( n )
            local
                sba,        # SB algebra
                gb,         # Groebner basis of <ideal>
                ideal,      # Ideal defined by <rels>
                info_quiv,  # Local function that prints info about <quiv>, 
                            #  depending on the level of <InfoSBStrips>
                pa,         # Path algebra
                quiv,       # Ground quiver 
                rels,       # Defining relations

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
                quiv := 
                return;
            
            elif n = 2 then
                return;
                
            elif n = 3 then
                return;
                
            elif n = 4 then
                return;
                
            elif n = 5 then
                return;
            
            elif n = 6 then
                return;
            fi;
        end,
    );
);