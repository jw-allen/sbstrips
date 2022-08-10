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
                    "ERROR: The 'b' sequence is incompatible ",
                    "with vertex pairs\n"
                );
                return fail;
            fi;

            # Add relations of length two to make special biserial
            f_p1 := IncomingArrowsOfVertex(O.(String(pair[1])))[1];
            f_p2 := IncomingArrowsOfVertex(O.(String(pair[2])))[1];
            s_p1 := OutgoingArrowsOfVertex(O.(String(pair[1])))[1];
            s_p2 := OutgoingArrowsOfVertex(O.(String(pair[2])))[1];

            if a.(String(pair[1])) <> 0
              and a.(String(SourceOfPath(f_p2))) <> 0 then
                u_p2 := over_to_under([f_p2, s_p1]);
                a_p2 := ElementOfPathAlgebra(kQ, u_p2);
                Add(relations, a_p2);
            fi;

            if a.(String(pair[2])) <> 0
              and a.(String(SourceOfPath(f_p1))) <> 0 then
                u_p1 := over_to_under([f_p1, s_p2]);
                a_p1 := ElementOfPathAlgebra(kQ, u_p1);
                Add(relations, a_p1);
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

# Creates an iterator of SBAlgs from an overquiver <O>, and the source data
#  encoding <a> and <b>
InstallMethod(
    SBAlgsFromOverquiverAndSourceDataLists,
    "for a 1-regular quiver, a list of positive integers and a binary list",
    [IsQuiver, IsList, IsList],
    function(overquiver, a, b)
        local
            a_vis,
            b_vis,
            add_pin_pairs,
            add_remaining_pairs,
            pairings,
            alg,
            alg_iter;

        if not IsQuiver(overquiver) then
            return fail;
        fi;
        if not (NumberOfVertices(overquiver) mod 2 = 0) then
            return fail;
        fi;

        a_vis := VISify(overquiver, a);
        b_vis := VISify(overquiver, b);

        # Function to recursively pair all of the pin vertices (and the corresponding endpoints of their commutativity components)
        add_pin_pairs := function(cur_pairs)
            local
                copy_pairs,
                paired,
                unpaired,
                pin_verts,
                new_pairs,
                add_pair,
                temp_pairs,
                adding,
                v1,
                v2;

            copy_pairs := ShallowCopy(cur_pairs);
            paired := Union(copy_pairs);
            unpaired := Filtered(VerticesOfQuiver(overquiver), v -> not v in paired);

            pin_verts := Filtered(unpaired, v -> b_vis.(String(v)) = 0);
            if Length(pin_verts) mod 2 = 1 then
                Error("odd number of unpaired pin vertices");
            fi;

            new_pairs := [];

            add_pair := function(v1, v2, pairs)
                local u1, u2;
                if v1 = v2 then
                    return fail;
                fi;
                if v1 in Union(pairs) or v2 in Union(pairs) then
                    if [v1,v2] in pairs or [v2,v1] in pairs then
                        return pairs;
                    else
                        return fail;
                    fi;
                elif b_vis.(String(v1)) = 0 and b_vis.(String(v2)) = 0 then
                    u1 := 1RegQuivIntAct(v1, -a_vis.(String(v1)));
                    u2 := 1RegQuivIntAct(v2, -a_vis.(String(v2)));

                    return add_pair(u1, u2, Concatenation(pairs,[[v1,v2]]));
                elif b_vis.(String(v1)) = 1 and b_vis.(String(v2)) = 1 then
                    return Concatenation(pairs,[[v1,v2]]);
                else
                    return fail;
                fi;
            end;

            if Length(pin_verts) >= 2 then
                v1 := pin_verts[1];
                for v2 in pin_verts{[2..Length(pin_verts)]} do
                    adding := add_pair(v1,v2, copy_pairs);
                    if adding <> fail and Length(adding) > 0 then
                        temp_pairs := adding;
                        Append(new_pairs, add_pin_pairs(temp_pairs));
                    fi;
                od;
                return new_pairs;
            elif Length(pin_verts) = 0 then
                return [cur_pairs];
            fi;
        end;

        # Function to enumerate all possible pairings of remaining (non-pin) vertices
        add_remaining_pairs := function(cur_pairs)
            local
                copy_pairs,
                paired,
                unpaired,
                rem,
                output;

            copy_pairs := ShallowCopy(cur_pairs);
            paired := Union(copy_pairs);
            unpaired := Filtered(VerticesOfQuiver(overquiver), v -> not v in paired);

            if Length(unpaired) = 0 then
                return [cur_pairs];
            else
                rem := PairingsOfList(unpaired);

                return List(rem, x -> Concatenation(cur_pairs, x));
            fi;
        end;

        pairings := add_pin_pairs([]);
        pairings := List(pairings, x -> add_remaining_pairs(x));
        pairings := Concatenation(pairings);

        # TODO implement checks for "canonical ordering" of choices of
        # additional edges when not 2-regular

        alg_iter := IteratorByFunctions( rec(
            pair_iter := Iterator(pairings),

            NextIterator := function(iter)
                local
                    alg,
                    pairing,
                    O;

                alg := fail;

                while alg = fail and not IsDoneIterator(iter!.pair_iter) do
                    pairing := NextIterator(iter!.pair_iter);
                    alg := SBAlgFromSourceData(overquiver, pairing, a_vis, b_vis);
                od;

                # Will only return 'fail' if there are no further pairings
                # to check
                return alg;
            end,
            IsDoneIterator := function(iter)
                return IsDoneIterator(iter!.pair_iter);
            end,
            ShallowCopy := iter -> rec(
                pair_iter := ShallowCopy(iter!.pair_iter)
            )
        ) );

        return alg_iter;
    end
);

# A wrapper function for SBAlgsFromOverquiverAndSourceDataLists that checks all possibly
# valid "source data encodings" for a given radical length
InstallMethod(
    SBAlgsFromCyclesAndRadLength,
    "for a list of positive integers and a positive integer",
    [IsList, IsPosInt],
    function(cycle_lengths, rad_len)
        local
            validASeq,
            genCycleWithMax,
            allSourceDataLists,
            O,
            sDataLists,
            sData,
            alg_iter,
            i;

        validASeq := function(x, cycle_lengths)
            local
                i,
                cycles,
                l,
                c;
            i := 0;
            cycles := [];
            for l in cycle_lengths do
                Add(cycles, x{[i+1..i+l]});
                i := i + l;
            od;
            for c in cycles do
                if c[1] <> Maximum(c) then
                    # ... the first value in a cycle is not the maximal one
                    #     (this removes most rotationally equivalent lists)
                    return false;
                fi;
                for i in [2..Length(c)] do
                    if c[i] < c[i-1]-1 then
                        # ... the length decreases too quickly
                        return false;
                    fi;
                od;
            od;
            return true;
        end;

        genCycleWithMax := function(len, max)
            local
                seqs,
                index,
                x_seq,
                x_cnt;

            seqs := Tuples([0..max], len-1);
            seqs := Reversed(seqs);
            seqs := Filtered(seqs, function(s)
                local pos;
                pos := Position(s, max);
                if pos <> fail and pos > len/2 then
                    return false;
                fi;
                return true;
            end);
            seqs := List(seqs, s -> Concatenation([max],s));
            seqs := Filtered(seqs, s -> validASeq(s,[len]));

            # filter rotationally equivalent
            index := 1;
            while index <= Length(seqs) do
                x_seq := seqs[index];
                x_cnt := Set(Collected(x_seq));
                if ForAny([1..index-1],
                    function(j)
                        local
                            y_seq,
                            p;
                        y_seq := seqs[j];
                        if x_cnt = Set(Collected(y_seq)) then
                            for p in Positions(y_seq, Maximum(y_seq)) do
                                if x_seq{[1..len-p+1]} = y_seq{[p..len]}
                                    and x_seq{[len-p+2..len]} = y_seq{[1..p-1]} then
                                    return true;
                                fi;
                            od;
                        fi;
                        return false;
                    end
                ) then
                    Remove(seqs, index);
                else
                    index := index + 1;
                fi;
            od;

            return seqs;
        end;

        # Generates a list of all possibly valid "source data encodings" with radical length <rad_len>
        # on an overquiver with cycle lengths <cycle_lengths>
        allSourceDataLists := function(cycle_lengths, rad_len)
            local
                cycle_maxs,
                cycle_max,
                cycle_seqs,
                cur_len,
                cur_max,
                a_seqs,
                b_seqs,
                paired,
                i,
                new_seqs;

            cycle_maxs := Tuples([0..rad_len-1], Length(cycle_lengths));
            cycle_maxs := Filtered(cycle_maxs, x -> Maximum(x)=rad_len-1);

            # Generate all possible a sequences
            a_seqs := [];
            for cycle_max in cycle_maxs do
                cycle_seqs := [];
                for i in [1..Length(cycle_max)] do
                    cur_len := cycle_lengths[i];
                    cur_max := cycle_max[i];
                    Add(cycle_seqs, genCycleWithMax(cur_len, cur_max));
                od;
                cycle_seqs := Cartesian(cycle_seqs);
                new_seqs := List(cycle_seqs, x->Concatenation(x));
                Append(a_seqs, new_seqs);
            od;

            # Remove sequence if invalid
            a_seqs := Filtered(a_seqs, x -> validASeq(x, cycle_lengths));
            a_seqs := Filtered(a_seqs, x -> x <> fail);

            # Allow all binary tuples
            b_seqs := Tuples([0,1], Sum(cycle_lengths));
            # Remove tuples where the number of 1s is odd
            b_seqs := Filtered(b_seqs, x -> Sum(x) mod 2 = 0);

            # Create all pairs of sequences for a and b
            paired := Cartesian(a_seqs, b_seqs);
            # Remove pair if ...
            paired := Filtered(paired, 
                function(x)
                    local
                        i;
                    for i in [1..Length(x[1])] do
                        if x[1][i] <= 1 and x[2][i] = 0 then
                            # ... there is a vertex which should be "pin" and "length zero or one"
                            return false;
                        fi;
                    od;
                    return true;
                end
            );

            return paired;
        end;

        O := 1RegQuivFromCycleLengths(cycle_lengths);
        sDataLists := allSourceDataLists(cycle_lengths, rad_len);

        alg_iter := IteratorByFunctions( rec(
            sub_iter := Iterator([]),
            dat_iter := Iterator(sDataLists),

            NextIterator := function(iter)
                local val;

                # If finished current sub_iter
                while IsDoneIterator(iter!.sub_iter) do
                    if IsDoneIterator(iter!.dat_iter) then
                        return fail;
                    fi;
                    # Save next source data
                    sData := NextIterator(iter!.dat_iter);
                    #TODO remove
                    # Display(cycle_lengths);
                    # Display(sData);

                    # Calculate new sub_iter from the source data
                    iter!.sub_iter := Iterator(SBAlgsFromOverquiverAndSourceDataLists(O, sData[1], sData[2]));
                od;
                val := NextIterator(iter!.sub_iter);

                while val = fail and not IsDoneIterator(iter!.sub_iter) do
                    sData := NextIterator(iter!.dat_iter);
                    iter!.sub_iter := Iterator(SBAlgsFromOverquiverAndSourceDataLists(O, sData[1], sData[2]));
                    val := NextIterator(iter!.sub_iter);
                od;

                return val;
            end,
            IsDoneIterator := function(iter)
                return IsDoneIterator(iter!.sub_iter) and IsDoneIterator(iter!.dat_iter);
            end,
            ShallowCopy := iter -> rec(
                sub_iter := ShallowCopy(iter!.sub_iter),
                dat_iter := ShallowCopy(iter!.dat_iter)
            )
        ) );

        return alg_iter;
    end
);
