InstallMethod(
    VertexIndexedSequenceFamilyOfQuiver,
    "for quivers",
    [ IsQuiver ],
    function( quiver )
        local
            fam,    # VIS family
            pfn;    # Path family name of <quiver>
        if HasVertexIndexedSequenceFamilyOfQuiver( quiver ) then
            return VertexIndexedSequenceFamilyOfQuiver( quiver );
        else
            pfn := FamilyObj( Zero( quiver ) )!.NAME;
            if Length( pfn ) < 20 then

                Print( "The path family for this quiver\n", quiver, "\nhas an",
                 " unexpected name!\n Please contact the maintainer of the",
                 " sbstrips package.\n" );
            elif not pfn{[1..19]} = "FamilyOfPathsWithin" then
                Print( "The path family for this quiver\n", quiver, "\nhas an",
                " unexpected name!\n Please contact the maintainer of the",
                " sbstrips package.\n" );
            else
                fam := NewFamily(
                 Concatenation(
                    "VertexIndexedSequenceFamilyOf",
                    pfn{[20..Length( pfn )]}
                  )
                 );
            fi;

            return fam;
        fi;
    end
);

InstallMethod(
    VISify,
    "for quivers and a sequence indexed by the vertices of the quiver",
    [ IsQuiver, IsList, IsString ],
    function( quiv, list, str )
        local
            data_rec,   # Record variable
            term_rec,   # Record variable
            k,          # Integer variable
            type,       # Type variable
            visfam,     # vertex-indexed sequence family of <quiver>
            verts;      # Vertices of <quiv>

        # Test input
        verts := VerticesOfQuiver( quiv );
        if Length( verts ) <> Length( list ) then
            Error( "The given quiver\n", quiv, "\n must have as many vertices",
             " as the given list\n", list, "\nhas entries!" );

        else
            # Build data of vertex-indexed sequence
            type := NewType(
             VertexIndexedSequenceFamilyOfQuiver( quiv ),
             IsComponentObjectRep and IsVertexIndexedSequenceRep
             );

            term_rec := rec();
            k := 1;
            for k in [1..Length(verts)] do
                term_rec.( String( verts[k] ) ) := list[k];
            od;

            data_rec := rec(
             quiver := quiv,
             indices := List( verts, String ),
             terms:= term_rec
             );
            if not IsEmpty( str ) then
                data_rec.kind_of_seq := str;
            fi;

            # Output
            return Objectify( type, data_rec );
        fi;
    end
);

InstallOtherMethod(
    VISify,
    "for a quiver and a list",
    [ IsQuiver, IsList ],
    function( quiv, list )
        return VISify( quiv, list, "" );
    end
);

InstallMethod(
    Display,
    "for vertex-indexed sequences",
    [ IsVertexIndexedSequenceRep ],
    function( seqrep )
        local
            x;  # Variable
        Print( "<" );
        if IsBound( seqrep!.kind_of_seq ) then
            Print( seqrep!.kind_of_seq, " " );
        fi;
        Print( "sequence indexed by vertices of " );
        ViewObj( seqrep!.quiver ); 
        Print( ">\n" );
        for x in seqrep!.indices do
            Print( "  ", x, " := ", seqrep!.terms.( x ) );
            if Position( seqrep!.indices, x ) <> Length( seqrep!.indices ) then
                Print( ",\n");
            fi;
        od;
    end
);

InstallMethod(
    ViewObj,
    "for vertex-indexed sequences",
    [ IsVertexIndexedSequenceRep ],
    function( seqrep )
        Print( "<vertex-indexed " );
        if IsBound( seqrep!.kind_of_seq ) then
            Print( seqrep!.kind_of_seq, " " );
        fi;
        Print( "sequence>" );
    end
);


InstallMethod(
    PrintObj,
    "for vertex-indexed sequences",
    [ IsVertexIndexedSequenceRep ],
    function( seqrep )
        local
            x,
            list;
        list := [];
        for x in seqrep!.indices do
            Append( list, [ seqrep!.terms.( x ) ] );
        od;

        Print( "VISify( " );
        ViewObj( seqrep!.quiver );
        Print( ",", "  " );
        Print( list );
        if "kind_of_seq" in NamesOfComponents( seqrep ) then
            Print( ", " );
            Print( "\"", seqrep!.kind_of_seq, "\"" );
        fi;
        Print( " );" ); 
    end
);

#########1#########2#########3#########4#########5#########6#########7#########
