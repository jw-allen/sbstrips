InstallMethod(
    ComponentsOfCommutativityRelationsOfSBAlg,
    "for special biserial algebras",
    [IsSpecialBiserialAlgebra],
    function (sba)
        local
            is2nomialgens,  # Local function testing for 2-nomiality of
                            #  presentation
            iscommurel,     # Local function testing for a commutativity
                            #  relation
            ismonrel,       # Local function testing for a monomial relation
            list,           # List of components of commutativity relations
            rels;           # Defining relations of <sba>

        if HasComponentsOfCommutativityRelationsOfSBAlg(sba) then
            return ComponentsOfCommutativityRelationsOfSBAlg(sba);

        else
            # Write functions answering whether an element of a path algebra is
            #  supported on one or two paths
            ismonrel := function(elt)
                if Length(CoefficientsAndMagmaElements(elt)) = 2 then
                    return true;
                else
                    return false;
                fi;
            end;

            iscommurel := function(elt)
                if Length(CoefficientsAndMagmaElements(elt)) = 4 then
                    return true;
                else
                    return false;
                fi;
            end;

            # Write logical disjunction of <ismonrel> and <iscommurel>
            is2nomialgens := function(elt)
                if (ismonrel(elt) or iscommurel(elt)) then
                    return true;
                else
                    return fail;
                fi;
            end;

            # Verify that <sba> has been presented 2-nomially.
            rels := RelationsOfAlgebra(sba);

            if false in List(rels, x -> is2nomialgens(x)) then
                Error("The given algebra\n", sba, "\nhas not been presented ",
                "by monomial and commutativity relations!");
            else
                list := Filtered(rels, iscommurel);
            fi;

            Apply(list, x -> CoefficientsAndMagmaElements(x){[1,3]});

            return Immutable(list);
        fi;
    end
);

InstallMethod(
    ComponentExchangeMapOfSBa,
    "for special biserial algebras",
    [IsSpecialBiserialAlgebra],
    function(sba)
        local
            complist,   # List of components of commutativity relations of
                        #  <sba>
            func;       # Function variable

        if HasComponentExchangeMapOfSBa(sba) then
            return ComponentExchangeMapOfSBa(sba);

        else
            complist := ComponentsOfCommutativityRelationsOfSBAlg(sba);

            func := function(elt)
                local
                    found,
                    k,
                    pair;

                found := false;
                k := 1;
                while ((found = false) and (k <= Length(complist))) do
                    if elt in complist[k] then
                        found := true;
                    else
                        k := k+1;
                    fi;
                od;

                if found = false then
                    Print("The given element\n", elt, "\nis not a component",
                     " of a commutativity relation of the special biserial",
                     " algebra\n", sba);
                    return fail;
                else
                    pair := ShallowCopy(complist[k]);
                    Remove(pair, Position(pair, elt));
                fi;

                return pair[1];
            end;

            return func;
        fi;
    end
);

InstallMethod(
    LinDepOfSBAlg,
    "for special biserial algebras",
    [IsSpecialBiserialAlgebra],
    function(sba)
        local
            a,      # Arrow variable
            comps,  # Components of commutativity relations defining <sba>
            k,      # Integer variable
            list,   # List of linearly-dependent paths
            oarrs,  # Arrows of the overquiver of <sba>
            p,      # Path variable
            walk;   # List variable for walks of paths
        if HasLinDepOfSBAlg(sba) then
            return LinDepOfSBAlg(sba);
        else
            comps := ComponentsOfCommutativityRelationsOfSBAlg(sba);
            oarrs := ArrowsOfQuiver(OverquiverOfSBAlg(sba));

            # Lift each path appearing within <comps>; do this by lifting each
            #  constituent arrow (in the ground quiver to one in the over-
            #  -quiver and then multiplying them together.
            list := [];
            for p in Flat(comps) do
                walk := ShallowCopy(WalkOfPath(p));
                for k in [1..Length(walk)] do
                    walk[k] := First(oarrs, function(x)
                        return (GroundPathOfOverquiverPathNC(x) = walk[k]);
                    end);
                od;
                Add(list, Product(walk));
            od;

            # Return the resulting list (of paths in the overquiver)
            Sort(list);
            return Immutable(list);
        fi;
    end
);

InstallMethod(
    LinIndOfSBAlg,
    "for special biserial algebras",
    [IsSpecialBiserialAlgebra],
    function(sba)
        local
            2reg,   # 2-regular augmentation of ground quiver of <sba>
            cont,   # Contaction of overquiver of <sba>
            ideal,  # Defining ideal of <sba>
            in_pa,  # Local function
            l,      # Integer variable
            list,   # List variable
            lindep, # Linearly dependent paths of <sba>
            oquiv,  # Overquiver of <sba>
            p,      # Path variable
            pa,     # Original path algebra of <sba>
            ret,    # Retraction of <2reg>
            v;      # Vertex variable
        if HasLinIndOfSBAlg(sba) then
            return LinIndOfSBAlg(sba);
        else
            pa := OriginalPathAlgebra(sba);
            ideal := IdealOfQuotient(sba);
            2reg := 2RegAugmentationOfQuiver(QuiverOfPathAlgebra(pa));
            oquiv := OverquiverOfSBAlg(sba);
            cont := ContractionOfOverquiver(oquiv);
            ret := RetractionOf2RegAugmentation(2reg);

            # Write local function that turns a path in the overquiver into the
            #  corresponding one in <pa>
            in_pa := function(path)
                return ElementOfPathAlgebra(pa, ret(cont(path)));
            end;

            lindep := LinDepOfSBAlg(sba);
            list := [];
            for v in VerticesOfQuiver(oquiv) do
                l := 0;
                p := PathBySourceAndLength(v, l);
                while not ((in_pa(p) in ideal) or (p in lindep)) do
                    Append(list, [p]);
                    l := l + 1;
                    p := PathBySourceAndLength(v, l);
                od;
            od;

            Sort(list);

            # Return the resulting list (of paths in the overquiver)
            return Immutable(list);
        fi;
    end
);

InstallMethod(
    PermDataOfSBAlg,
    "for special biserial algebras",
    [IsSpecialBiserialAlgebra],
    function(sba)
        if HasPermDataOfSBAlg(sba) then
            return PermDataOfSBAlg(sba);
        else
            return Immutable([LinIndOfSBAlg(sba), LinDepOfSBAlg(sba)]);
        fi;
    end
);

InstallMethod(
    SourceEncodingOfPermDataOfSBAlg,
    "for special biserial algebras",
    [IsSpecialBiserialAlgebra],
    function(sba)
        local
            a, b,           #
            a_data, b_data, # Information
            comp_sources,   #
            k,              # Integer variable
            lindep,         #
            linind,         #
            oquiv,          # Overquiver of <sba>
            overts,         # Vertices of <oquiv>
            paths,          # List variable
            perm_data,      # Permissible data of <sba>
            pos,            #
            v;              # Vertex variable

        if HasSourceEncodingOfPermDataOfSBAlg(sba) then
            return SourceEncodingOfPermDataOfSBAlg(sba);
        else
            oquiv := OverquiverOfSBAlg(sba);
            overts := VerticesOfQuiver(oquiv);
            lindep := LinDepOfSBAlg(sba);
            linind := LinIndOfSBAlg(sba);

            comp_sources := List(lindep, SourceOfPath);

            a_data := List([1..Length(overts)], x -> 0);
            b_data := List([1..Length(overts)], x -> 1);

            for k in [1..Length(overts)] do
                v := overts[k];
                if v in comp_sources then
                    pos := Position(comp_sources, v);
                    a_data[k] := LengthOfPath(lindep[pos]);
                    b_data[k] := 0;
                else
                    paths := Filtered(linind, x -> SourceOfPath(x) = v);
                    a_data[k] := Maximum(List(paths, LengthOfPath));
                fi;
            od;

            a := VISify(oquiv, a_data, "integer");
            b := VISify(oquiv, b_data, "bit");

            return Immutable([a, b]);
        fi;
    end
);

InstallMethod(
    TargetEncodingOfPermDataOfSBAlg,
    "for special biserial algebras",
    [IsSpecialBiserialAlgebra],
    function(sba)
        local
            c, d,           #
            c_data, d_data, # Information
            comp_targets,   #
            k,              # Integer variable
            lindep,         #
            linind,         #
            oquiv,          # Overquiver of <sba>
            overts,         # Vertices of <oquiv>
            paths,          # List variable
            perm_data,      # Permissible data of <sba>
            pos,            #
            v;              # Vertex variable

        if HasTargetEncodingOfPermDataOfSBAlg(sba) then
            return TargetEncodingOfPermDataOfSBAlg(sba);
        else
            oquiv := OverquiverOfSBAlg(sba);
            overts := VerticesOfQuiver(oquiv);
            lindep := LinDepOfSBAlg(sba);
            linind := LinIndOfSBAlg(sba);

            comp_targets := List(lindep, TargetOfPath);

            c_data := List([1..Length(overts)], x -> 0);
            d_data := List([1..Length(overts)], x -> 1);

            for k in [1..Length(overts)] do
                v := overts[k];
                if v in comp_targets then
                    pos := Position(comp_targets, v);
                    c_data[k] := LengthOfPath(lindep[pos]);
                    d_data[k] := 0;
                else
                    paths := Filtered(linind, x -> TargetOfPath(x) = v);
                    c_data[k] := Maximum(List(paths, LengthOfPath));
                fi;
            od;

            c := VISify(oquiv, c_data, "integer");
            d := VISify(oquiv, d_data, "bit");

            return Immutable([c, d]);
        fi;
    end
);

InstallMethod(
    IsRepresentativeOfCommuRelSource,
    "for vertices of overquivers",
    [IsQuiverVertex],
    function(vert)
        local
            b_seq,      # Bit sequence of <source_enc>
            oquiv,      # Overquiver to which <vert> belongs
            sba,        # SB algebra of which <oquiv> is overquiver
            source_enc; # Source encoding of permissible data of <sba>

        if HasIsRepresentativeOfCommuRelSource(vert) then
            return IsRepresentativeOfCommuRelSource(vert);
        else
            oquiv := QuiverContainingPath(vert);
            if not IsOverquiver(oquiv) then
                TryNextMethod();
            else
                sba := SBAlgOfOverquiver(oquiv);
                source_enc := SourceEncodingOfPermDataOfSBAlg(sba);
                b_seq := source_enc[2];

                return (b_seq.(String(vert)) = 0);
            fi;
        fi;
    end
);

InstallMethod(
    IsRepresentativeOfCommuRelTarget,
    "for vertices of overquivers",
    [IsQuiverVertex],
    function(vert)
        local
            d_seq,      # Bit sequence of <target_enc>
            oquiv,      # Overquiver to which <vert> belongs
            sba,        # SB algebra of which <oquiv> is overquiver
            target_enc; # Target encoding of permissible data of <sba>

        if HasIsRepresentativeOfCommuRelTarget(vert) then
            return IsRepresentativeOfCommuRelTarget(vert);
        else
            oquiv := QuiverContainingPath(vert);
            if not IsOverquiver(oquiv) then
                TryNextMethod();
            else
                sba := SBAlgOfOverquiver(oquiv);
                target_enc := TargetEncodingOfPermDataOfSBAlg(sba);
                d_seq := target_enc[2];

                return (d_seq.(String(vert)) = 0);
            fi;
        fi;
    end
);
