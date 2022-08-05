# Creates a SBAlg from an overquiver <O>, a list of pairs of vertices that will be
#  identified <v_pairs>, and the source data encoding <a> and <b>
InstallMethod(
    SBAlgFromSourceData,
    "for a 1-regular quiver, a vertex pairing, a VIS of positive integers and a binary VIS",
    [IsQuiver, IsList, IsVertexIndexedSequenceRep, IsVertexIndexedSequenceRep],
    function(O, v_pairs, a, b)
        local
            quiver,
            2reg,
            kQ,
            find_inv_vertex,
            over_to_under,
            addMonomialRelation,
            relations,
            pair,
            o_v,
            o_p1,
            o_p2,
            u_p1,
            u_p2,
            a_p1,
            a_p2,
            f_p1,
            f_p2,
            n_p1,
            n_p2,
            s_p1,
            s_p2,
            q_p,
            gb,
            ideal,
            algebra;

        O := StructuralCopy(O);

        if not Is1RegQuiver(O) then
            Print("not 1 regular\n");
            return fail;
        fi;

        if not ForAll(v_pairs, IsList) then
            Print("not a pairing of vertices\n");
            return fail;
        elif not ForAll(v_pairs, x -> Length(x) = 2) then
            Print("not a pairing of vertices\n");
            return fail;
        fi;

        2reg := QuiverQuotient(O, v_pairs);
        if 2reg = fail then
            Print("failed quotient\n");
            return fail;
        fi;

        quiver := QuiverFilterArrows(2reg, function(x)
            if a.(String(SourceOfPath(O.(String(x))))) = 0 and b.(String(SourceOfPath(O.(String(x))))) = 1 then
                return false;
            else
                return true;
            fi;
        end);

        #TODO put this check behind an option
        if not IsConnectedQuiver(quiver) then
            # Print("quotient quiver is disconnected:\n", quiver, "\n");
            return fail;
        fi;

        kQ := PathAlgebra(Rationals, quiver);

        # Find the vertex paired to the input vertex
        find_inv_vertex := function(vertex)
            local p;
            for p in v_pairs do
                if vertex = p[1] then
                    return p[2];
                elif vertex = p[2] then
                    return p[1];
                fi;
            od;
            return fail;
        end;

        # Convert a vertex, path or list of arrows in the overquiver to
        # a path in the base quiver
        over_to_under := function(path)
            local
                arrows,
                find_class;

            find_class := function(vertex)
                local i;
                i := 1;
                while i <= Length(v_pairs) do
                    if vertex in v_pairs[i] then
                        return i;
                    fi;
                    i := i + 1;
                od;
                return fail;
            end;

            if IsQuiverVertex(path) then
                return quiver.(Concatenation("v", String(find_class(path))));
            elif IsPath(path) then
                path := WalkOfPath(path);
            elif not IsList(path) or not ForAll(path, IsArrow) then
                return fail;
            fi;
            arrows := List(path, x -> quiver.(String(x)));

            return Product(arrows);
        end;

        relations := [];

        # Calculate and add a monomial relation starting at a given vertex
        addMonomialRelation := function(vertex)
            local
                t_p,
                o_p,
                u_p,
                a_p;
            t_p := PathBySourceAndLength(vertex, a.(String(vertex)));
            # Only add a relation if a long enough path exists
            if a.(String(TargetOfPath(t_p))) <> 0 then
                o_p := PathBySourceAndLength(vertex, a.(String(vertex))+1);

                u_p := over_to_under(o_p);

                a_p := ElementOfPathAlgebra(kQ, u_p);

                Add(relations, a_p);
            fi;
        end;

        for pair in v_pairs do
            # Add relations that determine the length of paths in the
            # projectives
            if b.(String(pair[1])) = 0 and b.(String(pair[2])) = 0 then
                if a.(String(pair[1])) <= 1 or a.(String(pair[2])) <= 1 then
                    Print(
                        "ERROR: The 'a' and 'b' sequences are incompatible\n"
                    );
                    return fail;
                fi;
                o_p1 := PathBySourceAndLength(pair[1], a.(String(pair[1])));
                o_p2 := PathBySourceAndLength(pair[2], a.(String(pair[2])));

                u_p1 := over_to_under(o_p1);
                u_p2 := over_to_under(o_p2);

                # Check if components of commutativity relation start and 
                # end at the same point in the base quiver, but not overquiver
                if SourceOfPath(u_p1) <> SourceOfPath(u_p2) 
                  or TargetOfPath(u_p1) <> TargetOfPath(u_p2)
                  or TargetOfPath(o_p1) = TargetOfPath(o_p2) then
                    Print(
                        "ERROR: The 'a' and 'b' sequences are incompatible ", 
                        "with the vertex pairs\n"
                    );
                    return fail;
                fi;

                a_p1 := ElementOfPathAlgebra(kQ, u_p1);
                a_p2 := ElementOfPathAlgebra(kQ, u_p2);

                Add(relations, a_p1-a_p2);
            elif b.(String(pair[1])) = 1 and b.(String(pair[2])) = 1 then
                addMonomialRelation(pair[1]);
                addMonomialRelation(pair[2]);
            else
                Print(
                    "ERROR: The 'b' sequence is incompatible",
                    "with vertex pairs\n"
                );
                return fail;
            fi;

            # Add relations of length two to make special biserial
            f_p1 := OutgoingArrowsOfVertex(O.(String(pair[1])))[1];
            f_p2 := OutgoingArrowsOfVertex(O.(String(pair[2])))[1];

            n_p1 := find_inv_vertex(TargetOfPath(f_p1));
            n_p2 := find_inv_vertex(TargetOfPath(f_p2));
            s_p1 := OutgoingArrowsOfVertex(O.(String(n_p1)))[1];
            s_p2 := OutgoingArrowsOfVertex(O.(String(n_p2)))[1];

            if a.(String(SourceOfPath(f_p1))) <> 0
              and a.(String(n_p1)) <> 0 then
                u_p1 := over_to_under([f_p1, s_p1]);
                a_p1 := ElementOfPathAlgebra(kQ, u_p1);
                Add(relations, a_p1);
            fi;

            if a.(String(SourceOfPath(f_p2))) <> 0
              and a.(String(n_p2)) <> 0 then
                u_p2 := over_to_under([f_p2, s_p2]);
                a_p2 := ElementOfPathAlgebra(kQ, u_p2);
                Add(relations, a_p2);
            fi;
        od;

        # Only quotient if there are relations
        if Length(relations) > 0 then
            gb := GBNPGroebnerBasis(relations, kQ);
            ideal := Ideal(kQ, gb);
            GroebnerBasis(ideal, gb);

            algebra := kQ/ideal;
        else
            algebra := kQ;
        fi;

        if not IsSpecialBiserialAlgebra(algebra) then
            Print("\nERROR: not special biserial\n");
            Print(algebra,"\n");
            Print(O,"\n");
            Print(quiver,"\n");
            Print(v_pairs, "\n", a, "\n", b, "\n");
            return fail;
        fi;

        return algebra;
    end
);
