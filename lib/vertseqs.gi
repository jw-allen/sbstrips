InstallMethod(
    VertexIndexedSequenceFamilyOfQuiver,
    "for quivers",
    [IsQuiver],
    function(quiver)
        local
            fam,    # VIS family
            pfn;    # Path family name of <quiver>
        if HasVertexIndexedSequenceFamilyOfQuiver(quiver) then
            return VertexIndexedSequenceFamilyOfQuiver(quiver);
        else
            fam := NewFamily("VertexIndexedSequenceFamily");
            fam!.quiver := quiver;
        fi;

        return fam;
    end
);

InstallMethod(
    VISify,
    "for quivers and a sequence indexed by the vertices of the quiver",
    [IsQuiver, IsList, IsString],
    function(quiv, list, str)
        local
            data_rec,   # Record variable
            term_rec,   # Record variable
            k,          # Integer variable
            type,       # Type variable
            visfam,     # vertex-indexed sequence family of <quiver>
            verts;      # Vertices of <quiv>

        # Test input
        verts := VerticesOfQuiver(quiv);
        if Length(verts) <> Length(list) then
            Error("The given quiver\n", quiv, "\n must have as many vertices",
             " as the given list\n", list, "\nhas entries!");

        else
            # Build data of vertex-indexed sequence
            type := NewType(
             VertexIndexedSequenceFamilyOfQuiver(quiv),
             IsComponentObjectRep and IsVertexIndexedSequenceRep
            );

            term_rec := rec();
            k := 1;
            for k in [1 .. Length(verts)] do
                term_rec.(String(verts[k])) := list[k];
            od;

            data_rec := rec(
             quiver := quiv,
             indices := List(verts, String),
             terms:= term_rec
            );
            if not IsEmpty(str) then
                data_rec.kind_of_seq := str;
            fi;

            # Output
            return Immutable(Objectify(type, data_rec));
        fi;
    end
);

InstallOtherMethod(
    VISify,
    "for a quiver and a list",
    [IsQuiver, IsList],
    function(quiv, list)
        return VISify(quiv, list, "");
    end
);

InstallMethod(
    Display,
    "for vertex-indexed sequences",
    [IsVertexIndexedSequenceRep],
    function(seqrep)
        local
            x;  # Variable
        Print("<");
        if IsBound(seqrep!.kind_of_seq) then
            Print(seqrep!.kind_of_seq, " ");
        fi;
        Print("sequence indexed by vertices of ");
        ViewObj(seqrep!.quiver);
        Print(">\n");
        for x in seqrep!.indices do
            Print("  ", x, " := ", seqrep!.terms.(x));
            if Position(seqrep!.indices, x) <> Length(seqrep!.indices) then
                Print(",\n");
            fi;
        od;
    end
);

InstallMethod(
    ViewObj,
    "for vertex-indexed sequences",
    [IsVertexIndexedSequenceRep],
    function(seqrep)
        Print("<vertex-indexed ");
        if IsBound(seqrep!.kind_of_seq) then
            Print(seqrep!.kind_of_seq, " ");
        fi;
        Print("sequence>");
    end
);


InstallMethod(
    PrintObj,
    "for vertex-indexed sequences",
    [IsVertexIndexedSequenceRep],
    function(seqrep)
        local
            x,
            list;
        list := [];
        for x in seqrep!.indices do
            Append(list, [seqrep!.terms.(x)]);
        od;

        Print("VISify(");
        ViewObj(seqrep!.quiver);
        Print(",", "  ");
        Print(list);
        if "kind_of_seq" in NamesOfComponents(seqrep) then
            Print(", ");
            Print("\"", seqrep!.kind_of_seq, "\"");
        fi;
        Print(");");
    end
);

InstallMethod(
    \.,
    "for vertex-indexed sequences",
    [IsVertexIndexedSequenceRep, IsPosInt],
    function(vis, int)
        return vis!.terms.(NameRNam(int));
    end
);

InstallMethod(
    \=,
    "for vertex-indexed sequences",
    [IsVertexIndexedSequenceRep, IsVertexIndexedSequenceRep],
    function(vis1, vis2)
        if (vis1!.quiver = vis2!.quiver and
         vis1!.indices = vis2!.indices and
         vis1!.terms = vis2!.terms) then
            return true;
        else
            return false;
        fi;
    end
);
