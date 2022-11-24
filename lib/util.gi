# Some functionalities that could be present in GAP or QPA but are not

InstallMethod(
    ForwardOrbitUnderFunctionNC,
    [IsObject, IsFunction],
    function(obj, func)
        local
            latest, # Last entry of <orbit>
            orbit;  # Forward orbit sequence of <obj> under <func>

        orbit := [obj];
        while IsDuplicateFreeList(orbit) do
            # Let <latest> be the final entry of <orbit>
            latest := orbit[Length(orbit)];

            # Apply <func> to <latest>; append this to <orbit>
            Add(orbit, func(latest));

            # Repeat until <orbit> contains a duplicate entry. BE WARNED that
            #  this function does not check whether higher iterates of <func>
            #  are defined on <obj>, not does it check whether duplicates are
            #  guaranteed to arise!
        od;

        return orbit;
    end
);

InstallMethod(
    IsTransientUnderFunctionNC,
    [IsObject, IsFunction, IsObject],
    function(obj, func, fixpt)
        local
            latest, # Last entry of <orbit>
            orbit;  # Forward orbit of <obj> under <func>

        orbit := ForwardOrbitUnderFunctionNC(obj, func);
        latest := orbit[Length(orbit)];

        # If the <func>-orbit of <obj> ends in <fixpt>, then we call <obj>
        #  "transient with respect to <func>". Otherwise, it is "preperiodic
        #  with respect to <func>".
        return (latest = fixpt);
    end
);

InstallMethod(
    IsPreperiodicUnderFunctionNC,
    [IsObject, IsFunction, IsObject],
    function(obj, func, fixpt)
        # <obj> is "periodic with respect to <func>" iff it is not "transient
        #  with respect to <func>". Here, <fixpt> is the distinguished fixpoint
        #  of func in which all <func>-transient orbits terminate.

        return not IsTransientUnderFunctionNC(obj, func, fixpt);
    end
);

InstallMethod(
    IsPeriodicUnderFunctionNC,
    [IsObject, IsFunction, IsObject],
    function(obj, func, fixpt)
    # <obj> is "periodic with respect to <func>" if <func>, or some repeated
    #  composition of <func> with itself, fixes <obj>. The only exception is
    #  the distinguished fixpoint <fixpt> of <func>: by fiat, we impose that
    #  <fixpt> is "transient with respect to <func>", as are all objects whose
    #  <func>-orbit contains (and therefore stabilises at) <fixpt>

    local
        latest, # Last entry of <orbit>
        orbit;  # Forward orbit of <obj> under <func>

    if IsTransientUnderFunctionNC(obj, func, fixpt) then
        return false;
    else
        orbit := ForwardOrbitUnderFunctionNC(obj, func);
        latest := orbit[Length(orbit)];
        return (obj = latest);
    fi;

    end
);

InstallMethod(
    IsCollectedList,
    "for lists",
    [IsList],
    function(list)
        local
            mults,  # List of multiplicities
            objs;   # List of objects

        if HasIsCollectedList(list) then
            return IsCollectedList(list);

        elif IsEmpty(list) then
            return true;

        else
            if not (ForAll(list, IsList)) then
                return false;
            elif not(ForAll(list, x -> Length(x) = 2)) then
                return false;
            else
                mults := List(list, x -> x[2]);

                if not (ForAll(mults, IsPosInt)) then
                    return false;
                else
                    return true;
                fi;
            fi;
        fi;
    end
);

InstallMethod(
    ElementsOfCollectedList,
    "for a collected list",
    [IsList],
    function(clist)
        if not IsCollectedList(clist) then
            TryNextMethod();

        else
            return List(clist, x -> x[1]);
        fi;
    end
);

InstallMethod(
    MultiplicityOfElementInCollectedList,
    "for an object and a collected list",
    [IsObject, IsList],
    function(obj, clist)
        local
            j, k;   # Integer variables

        if not IsCollectedList(clist) then
            TryNextMethod();

        else
            j := 0;

            for k in [1 .. Length(clist)] do
                if clist[k][1] = obj then
                    j := j + clist[k][2];
                fi;
            od;

            return j;
        fi;
    end
);

InstallMethod(
    IsCollectedHomogeneousList,
    "for lists",
    [IsList],
    function(clist)
        local
            objs;   # First entries of entries of <clist>

        if HasIsCollectedHomogeneousList(clist) then
            return IsCollectedHomogeneousList(clist);

        else
            if not IsCollectedList(clist) then
                return false;

            else
                objs := List(clist, x -> x[1]);

                return IsHomogeneousList(objs);
            fi;
        fi;
    end
);

InstallMethod(
    IsCollectedDuplicateFreeList,
    "for lists",
    [IsList],
    function(clist)
        local
            objs;   # First entries of entries of <clist>

        if HasIsCollectedDuplicateFreeList(clist) then
            return IsCollectedDuplicateFreeList(clist);

        else
            if not IsCollectedList(clist) then
                return false;

            else
                objs := List(clist, x -> x[1]);

                return IsDuplicateFreeList(objs);
            fi;
        fi;
    end
);

InstallMethod(
    Recollected,
    "for collected lists",
    [IsList],
    function(clist)
        local
            list,   # List variable (for the better-collected version of
                    #  <clist>)
            j, k;   # Integer variables

        if not IsCollectedList(clist) then
            TryNextMethod();

        elif IsCollectedDuplicateFreeList(clist) then
            return clist;

        else
            list := ShallowCopy(clist);
            k := 1;

            while k <= Length(list) do
                j := 1;

                while k + j <= Length(list) do
                    if list[k][1] = list[k + j][1] then
                        list[k][2] := list[k][2] + list[k + j][2];
                        Remove(list, k + j);

                    else
                        j := j + 1;
                    fi;
                od;

                k := k + 1;
            od;

            return list;
        fi;
    end
);

InstallMethod(
    Uncollected,
    "for collected lists",
    [IsList],
    function(clist)
        local
            j, k,
            list;

        if not IsCollectedList(clist) then
            TryNextMethod();

        else
            list := [];
            for k in [1 .. Length(clist)] do
                for j in [1 .. clist[k][2]] do
                    Add(list, clist[k][1]);
                od;
            od;

            return list;
        fi;
    end
);

InstallMethod(
    CollectedLength,
    "for collected lists",
    [IsList],
    function(clist)
        if not IsCollectedList(clist) then
            TryNextMethod();

        else
            return Sum(clist, x -> x[2]);
        fi;
    end
);

InstallMethod(
    CollectedListElementwiseFunction,
    "for a collected list and a function",
    [IsList, IsFunction],
    function(clist, func)
        local
            new,    # List variable, for the output
            x;      # Variable, for entries of <clist>

        if not IsCollectedList(clist) then
            Error("The first argument ", clist,
             " should be a collected list!");

        else
            new := List(clist, entry -> ShallowCopy(entry));

            for x in new do
                x[1] := func(x[1]);
            od;

            return new;
        fi;
    end
);

InstallMethod(
    CollectedListElementwiseListValuedFunction,
    "for a collected list and a (flat) list-valued function",
    [IsList, IsFunction],
    function(clist, func)
        local
            elt,            # Variable, for elements of <clist>
            entry,          # Variable, for entries of <clist>
            j, k,           # Integer variables, indexing entries of lists
            image_clist,    # Collected image of <elt> in <func>
            list,           # List variable
            mult;           # Integer variable, for multiplicity of <elt>

        if not IsCollectedList(clist) then
            Error("The first argument ", clist,
             " should be a collected list!");

        else
            # Tidy up <clist>
            clist := Recollected(clist);

            list := [];

            # Work entry-by-entry of <clist>
            for k in [1 .. Length(clist)] do
                entry := clist[k];

                # Say each entry of <clist> is
                #       [elt, mult]
                #  We calculate and <Collect> the <func>-image of <elt> and
                #  then multiply all multiplicities in the image by <mult>.
                #  That gives us the collected image of the entry.
                elt := entry[1];
                mult := entry[2];
                image_clist := func(elt);

                if not IsCollectedList(image_clist) then
                    image_clist := Collected(image_clist);
                fi;

                for j in [1 .. Length(image_clist)] do
                    image_clist[j][2] := image_clist[j][2] * mult;
                od;

                # We record this in collected list <syz_clist>
                Append(list, image_clist);
            od;

            # Once the collected syzygies for each entry of <clist> have been
            #  calculated, we tidy up the answer
            return Recollected(list);
        fi;
    end
);

InstallMethod(
    IsCollectedSublist,
    "for two collected lists",
    [IsList, IsList],
    function(sublist, superlist)
        local
            elt,        # Member of <elt_list>
            elt_list,   # List of elements in <sublist>
            k,          # Integer variable indexing entries of <sublist>
            mult_sublist, mult_superlist;
                        # Integer variable, giving the multiplicity of <elt> in
                        #  <sublist> and <superlist> respectively

        if not IsCollectedList(sublist) and IsCollectedList(superlist) then
            TryNextMethod();

        else
            elt_list := ElementsOfCollectedList(sublist);

            for elt in elt_list do
                mult_sublist :=
                 MultiplicityOfElementInCollectedList(elt, sublist);
                mult_superlist :=
                 MultiplicityOfElementInCollectedList(elt, superlist);

                if mult_superlist < mult_sublist then
                    return false;
                fi;
            od;

            return true;
        fi;
    end
);

InstallMethod(
    CollectedFiltered,
    "for a collected list and a boolean-valued function",
    [IsList, IsFunction],
    function(clist, bool_func)
        local
            k,          # Integer variable, indexing the entries of <clist>
            new_clist;  # List variable, storing the collected list to be
                        #  returned

        if not IsCollectedList(clist) then
            Error(
             "The first argument\n", clist, "\nis not a collected list!"
            );

        else
            new_clist := [];

            for k in [1 .. Length(clist)] do
                if bool_func(clist[k][1]) then
                    Add(new_clist, [clist[k][1], clist[k][2]]);
                fi;
            od;

            return Recollected(new_clist);
        fi;
    end
);

InstallMethod(
    PairingsOfList,
    "for a list",
    [IsList],
    function(list)
        local
            pairings,
            p1,
            sublist,
            newpairs,
            i;
        if not (Length(list) mod 2 = 0) then
            return fail;
        fi;
        pairings := [];
        if Length(list) > 2 then
            for i in [2..Length(list)] do
                p1 := [list[1], list[i]];
                sublist := list{Concatenation([2..i-1],[i+1..Length(list)])};
                # Display(p1);
                # Display(sublist);

                newpairs := List(PairingsOfList(sublist), p2 -> Concatenation([p1],p2));

                Append(pairings, newpairs);
            od;
        elif Length(list) = 2 then
            return [[list]];
        fi;
        return pairings;
    end
);

InstallMethod(
    RotationOfList,
    "for a list and an integer",
    [IsList, IsInt],
    function(list, shift)
        local
            l, s;
        l := Length(list);
        s := shift mod l;
        return Concatenation(list{[s+1 .. l]}, list{[1 .. s]});
    end
);

# Useful functions for QPA

InstallMethod(
    String,
    "for paths of length at least 2",
    [IsPath],
    function(path)
        local
            k,      # Integer variable
            output, # List to store output, as it is being writte
            walk;   # Walk of path

        # Methods for <String> are already installed for vertices and arrows
        #  (that is, paths of length 0 or 1).
        if LengthOfPath(path) <= 1 then
            TryNextMethod();

        else
            # The returned string should be like "a1*a2*a3* .. .*aN", where "a1"
            #  etc are the constituent arrows of path (in order).

            walk := WalkOfPath(path);
            k := 1;
            output := [];
            for k in [1 .. Length(walk)] do
                if k <> 1 then
                    Add(output, "*");
                fi;
                Add(output, String(walk[k]));
            od;

            return Concatenation(output);
        fi;
    end
);

InstallMethod(
    ArrowsOfQuiverAlgebra,
    "for a quiver algebra",
    [IsQuiverAlgebra],
    function(alg)
        local
            1_alg,  # Multiplicative identity of <alg>
            arrs,   # Arrows of <quiv>
            quiv;   # Original quiver of <alg>

        1_alg := One(alg);
        quiv := QuiverOfPathAlgebra(OriginalPathAlgebra(alg));
        arrs := ArrowsOfQuiver(quiv);

        return List(arrs, x -> x * 1_alg);
    end
);

InstallMethod(
    VerticesOfQuiverAlgebra,
    "for a quiver algebra",
    [IsQuiverAlgebra],
    function(alg)
        local
            1_alg,  # Multiplicative identity of <alg>
            verts,  # Vertices of <quiv>
            quiv;   # Original quiver of <alg>

        1_alg := One(alg);
        quiv := QuiverOfPathAlgebra(OriginalPathAlgebra(alg));
        verts := VerticesOfQuiver(quiv);

        return List(verts, x -> x * 1_alg);
    end
);

InstallMethod(
    FieldOfQuiverAlgebra,
    "for a quiver algebra",
    [IsQuiverAlgebra],
    function(alg)
        # Accessing the components of <alg> is naughty, and may be impacted by
        #  future updates of QPA. I therefore isolate the close dependence in
        #  this single, easily-modified operation.
        return alg!.LeftActingDomain;
    end
);

InstallMethod(
    DefiningQuiverOfQuiverAlgebra,
    "for a quiver algebra",
    [IsQuiverAlgebra],
    function(alg)
        return QuiverOfPathAlgebra(OriginalPathAlgebra(alg));
    end
);

InstallMethod(
    PathOneArrowLongerAtSource,
    "for paths",
    [IsPath],
    function(path)
        local
            arrow,  # Arrow to add
            vertex; # Source vertex of <path>

        if HasPathOneArrowLongerAtSource(path) then
            return PathOneArrowLongerAtSource(path);

        else
            vertex := SourceOfPath(path);
            if not (InDegreeOfVertex(vertex) = 1) then
                return fail;

            else
                arrow := IncomingArrowsOfVertex(vertex)[1];
                return arrow * path;
            fi;
        fi;
    end
);

InstallMethod(
    PathOneArrowLongerAtTarget,
    "for paths",
    [IsPath],
    function(path)
        local
            arrow,  # Arrow to add
            vertex; # Target vertex of <path>

        if HasPathOneArrowLongerAtTarget(path) then
            return PathOneArrowLongerAtTarget(path);

        elif IsZeroPath(path) then
            return fail;

        else
            vertex := TargetOfPath(path);
            if not (OutDegreeOfVertex(vertex) = 1) then
                return fail;

            else
                arrow := OutgoingArrowsOfVertex(vertex)[1];
                return path * arrow;
            fi;
        fi;
    end
);

InstallMethod(
    PathOneArrowShorterAtSource,
    "for paths",
    [IsPath],
    function(path)
        local
            l,          # Length of <path>
            new_path,   # Appropriate subpath of <path>
            walk;       # Walk of path

        if HasPathOneArrowShorterAtSource(path) then
            return PathOneArrowShorterAtSource(path);

        elif IsZeroPath(path) then
            return fail;

        elif LengthOfPath(path) < 1 then
            return fail;

        elif LengthOfPath(path) = 1 then
            return TargetOfPath(path);

        else
            walk := WalkOfPath(path);
            l := LengthOfPath(path);
            new_path := Product(walk{[2 .. l]});
            return new_path;
        fi;
    end
);

InstallMethod(
    PathOneArrowShorterAtTarget,
    "for paths",
    [IsPath],
    function(path)
        local
            l,          # Length of <path>
            new_path,   # Appropriate subpath of <path>
            walk;       # Walk of path

        if HasPathOneArrowShorterAtTarget(path) then
            return PathOneArrowShorterAtTarget(path);

        elif IsZeroPath(path) then
            return fail;

        elif LengthOfPath(path) < 1 then
            return fail;

        elif LengthOfPath(path) = 1 then
            return SourceOfPath(path);

        else
            walk := WalkOfPath(path);
            l := LengthOfPath(path);
            new_path := Product(walk{[1 .. l-1]});
            return new_path;
        fi;
    end
);

InstallMethod(
    QuiverQuotient,
    "for a quiver and a partition of its vertices",
    [IsQuiver, IsList],
    function(quiver, parts)
        local
            vertices,   # list of vertices of constructed quiver
            arrows,     # list of arrows of constructed quiver
            p,          # loop variable for classes of the partition
            a,          # loop variable for arrows of input quiver
            v,          # loop variable for vertices of input quiver
            find_class, # helper function for finding partition class of vertex
            s, t,       # ends of an arrow in construction loop
            quot;

        if not ForAll(parts, IsList) then
            Error("The second argument\n", parts, "\nmust be a list of lists",
             "of vertices of the quiver\n", quiver);
        elif Set(Flat(parts)) <> Set(VerticesOfQuiver(quiver)) then
            Error("The second argument\n", parts, "\nmust be a list of lists",
             "of vertices of the quiver\n", quiver);
        elif Length(Flat(parts)) <> NumberOfVertices(quiver) then
            Error("The second argument\n", parts, "\nmust include all",
             "vertices of the quiver\n", quiver);
        fi;

        vertices := List([1 .. Length(parts)], function(i)
            return Concatenation("v", String(i));
        end);

        find_class := function(vertex)
            local i;
            i := 1;
            while i <= Length(parts) do
                if vertex in parts[i] then
                    return i;
                fi;
                i := i + 1;
            od;
            return fail;
        end;

        arrows := [];
        for a in ArrowsOfQuiver(quiver) do
            s := Concatenation("v", String(find_class(SourceOfPath(a))));
            t := Concatenation("v", String(find_class(TargetOfPath(a))));
            Add(arrows, [s, t, String(a)]);
        od;

        quot := Quiver(vertices, arrows);

        for v in VerticesOfQuiver(quiver) do
            v!.LiftOf := quot.(Concatenation("v", String(find_class(v))));
        od;

        for a in ArrowsOfQuiver(quiver) do
            a!.LiftOf := quot.(String(a));
        od;

        SetIsCoveringQuiver(quiver, true);
        quiver!.quotient := quot;
        SetIsQuotientQuiver(quot, true);
        quot!.covering := quiver;

        return quot;
    end
);

InstallMethod(
    IsCoveringQuiver,
    "for quivers",
    [IsQuiver],
    function(quiver)
        if HasIsCoveringQuiver(quiver) then
            return IsCoveringQuiver(quiver);
        else
            # Covering quivers are exactly those quivers that have been
            #  inputted to the <QuiverQuotient> command. Such quivers have
            #  this property set (to <true>) at creation. Therefore any quiver
            #  for which this property has not been set must not have been so
            #  inputted.
            return false;
        fi;
    end
);

InstallMethod(
    IsQuotientQuiver,
    "for quivers",
    [IsQuiver],
    function(quiver)
        if HasIsQuotientQuiver(quiver) then
            return IsQuotientQuiver(quiver);
        else
            # Quotient quivers are exactly those quivers constructed using the
            #  <QuiverQuotient> command. Such quivers have this property set
            #  (to <true>) at creation. Therefore any quiver for which this
            #  property has not been set must not have been so constructed.
            return false;
        fi;
    end
);

InstallMethod(
    QuiverFilterArrows,
    "for a quiver and a partition of its vertices",
    [IsQuiver, IsFunction],
    function(quiver, fn)
        local
            vertices,
            arrows;

        vertices := List(VerticesOfQuiver(quiver), x -> String(x));
        arrows := Filtered(ArrowsOfQuiver(quiver), x -> fn(x));
        arrows := List(arrows, function(x)
            return [
                String(SourceOfPath(x)),
                String(TargetOfPath(x)),
                String(x)
            ];
        end);

        return Quiver(vertices, arrows);
    end
);
