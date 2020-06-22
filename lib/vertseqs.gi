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
    PrintObj,
    "for vertex-indexed sequences",
    [ IsVertexIndexedSequenceRep ],
    function( seqrep )
        Print( "<" );
        if IsBound( seqrep!.kind_of_seq ) then
            Print( seqrep!.kind_of_seq, " " );
        fi;
        Print( "sequence>\n" ),
        for x in seqrep!.indices do
            Print( x, " := ", seqrep!.terms.(x), "\n" );
        od;
    end
);

#########1#########2#########3#########4#########5#########6#########7#########
