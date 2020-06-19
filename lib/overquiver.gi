InstallMethod(
    IsOneRegularQuiver,
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

#########1#########2#########3#########4#########5#########6#########7#########
