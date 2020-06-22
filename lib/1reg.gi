InstallMethod(
    Is1RegQuiver,
    "for quivers",
    [IsQuiver],
    function( quiver )
        local
            v,      # Vertex variable
            verts;  # Vertices of <quiver>
        
        # Test vertex degrees
        verts := VerticesOfQuiver( quiver );
		
        for v in verts do
            if InDegreeOfVertex( v ) <> 1 or OutDegreeOfVertex( v ) <> 1 then
                return false;
            fi;
        od;
		
        return true;
    end
);

InstallMethod(
    1RegQuivIntActionFunction,
    "for 1-regular quivers",
    [ IsQuiver ],
    function ( quiver )
        local
            func;	# Function variable
			
        if Has1RegQuivIntActionFunction( quiver ) then
            return 1RegQuivIntActionFunction( quiver );
		
        # Test input
        elif not Is1RegQuiver( quiver ) then
            Error( "The given quiver\n", quiver, "\nis not 1-regular!" );

        else
            # Write (nonrecursive!) function. For us, vertices are like
            #   i+1 --> i
            # and arrows are like
            #   --{a+1}--> vertex --{a}-->
            func := function( x, K )
                local
                    k,	# Integer variable
                    y;	# Quiver generator variable
					
                # Test input
                if not x in GeneratorsOfQuiver( quiver ) then
                    Error( "The first argument\n", x, "\nmust be a vertex or ",
                     "an arrow of the quiver\n", quiver );
                elif not IsInt( K ) then
                    Error( "The second argument\n", K,
                     "\nmust be an integer" );
            	 
                else
                    x := y;
                    k := K;
					
                    while k <> 0 do
                        if IsQuiverVertex( x ) and k > 0 then
                            x := TargetOfPath( OutgoingArrowsOfVertex(x)[1] );
                            k := k - 1;
							
                        elif IsQuiverVertex( x ) and k < 0 then
                            x := SourceOfPath( IncomingArrowsOfVertex(x)[1] );
                            k := k + 1;
							
                        elif IsArrow( x ) and k > 0 then
                            x := OutgoingArrowsOfVertex( TargetOfPath(x) )[1];
                            k := k-1;
							
                        elif IsArrow( x ) and k < 0 then
                            x := IncomingArrowsOfVertex( SourceOfPath(x) )[1];
                            k := k + 1;
                        fi;
                    od;
					
                    return x;
                fi;
            end;
			
            return func;
        fi;
    end
);

InstallMethod(
    1RegQuivIntAct,
    "for a generator of a one-regular quiver and an integer",
    [ IsPath, IsInt ],
    function( x, k )
        local
            func,	# Z-action function of <quiver>
            quiver;	# Quiver to which <x> belongs
			
        quiver := QuiverOfQuiverPath( x );
		
        # Test first argument <x>
        if not Is1RegQuiver( quiver ) then
            Error( "The given quiver\n", quiver, "\nis not 1-regular!" );
			
        else
            # Apply appropriate Z-action function
            func := 1RegQuivIntActFunc( quiver );
            return func( x, k );
        fi;
    end
);

InstallMethod(
    PathBySourceAndLength,
    "for 1 regular quivers",
    [ IsQuiverVertex, IsInt ],
    function( vert, len )
        local
            a,      # Arrow variable
            l,      # Integer variable
            walk;   # List
        if not Is1RegQuiver( QuiverOfQuiverQuiverPath( vert ) ) then
            Error( "The given vertex\n", vert, "\ndoes not belong to a 1-",
             "regular quiver!\n" );
        elif len < 0 then
            Error( "The given length must be nonnegative!\n" );
        elif len = 0 then
            return vert;
        else
            a := IncomingArrowsOfVertex( vert )[1];
            walk := List( [1..len], x -> 1RegQuivIntAct( a, -1*x ) );
            return Product( walk );
        fi;
    end
);

InstallMethod(
    PathByTargetAndLength,
    "for 1 regular quivers",
    [ IsQuiverVertex, IsInt ],
    function( vert, len )
        return OppositePath(
         PathBySourceAndLength( OppositePath( vert ), len )
         );
    end
);
#########1#########2#########3#########4#########5#########6#########7#########
