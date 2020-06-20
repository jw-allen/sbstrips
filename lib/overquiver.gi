InstallMethod(
    Is1RegularQuiver,
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
    QuiverOfQuiverPath,
    "for paths in a quiver",
    [IsPath],
    function( path )

    # Access original quiver from <path>'s family
    # We isolate this utility from other functions in case future versions of
	#  QPA operate differently

    return FamilyObj( path )!.quiver;
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
        elif not Is1RegularQuiver( quiver ) then
            Error( "The given quiver\n", quiver, "\nis not 1-regular!" );

        else
            # Write (nonrecursive!) function. For us, vertices are like
            #   i+1 --> i
            # and arrows are like
            #   --{a+1}--> vertex --{a}-->
            func := function( x, K );
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
        if not Is1RegularQuiver( quiver ) then
            Error( "The given quiver\n", quiver, "\nis not 1-regular!" );
			
        else
			# Apply appropriate Z-action function
            func := 1RegQuivIntActFunc( quiver );
            return func( x, k );
        fi;
    end
);

InstallMethod(
    
);
										
#########1#########2#########3#########4#########5#########6#########7#########
#########1#########2#########3#########4#########5#########6#########7#########
