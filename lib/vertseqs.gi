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
