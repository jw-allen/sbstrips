InstallMethod(
    Is1RegQuiver,
    "for quivers",
    [IsQuiver],
    function(quiver)
        local
            v,      # Vertex variable
            verts;  # Vertices of <quiver>

        # Test vertex degrees
        verts := VerticesOfQuiver(quiver);

        for v in verts do
            if InDegreeOfVertex(v) <> 1 or OutDegreeOfVertex(v) <> 1 then
                return false;
            fi;
        od;

        return true;
    end
);

InstallMethod(
    Is2RegQuiver,
    "for quivers",
    [IsQuiver],
    function(quiver)
        local
            v,      # Vertex variable
            verts;  # Vertices of <quiver>

        # Test vertex degrees
        verts := VerticesOfQuiver(quiver);

        for v in verts do
            if InDegreeOfVertex(v) <> 2 or OutDegreeOfVertex(v) <> 2 then
                return false;
            fi;
        od;

        return true;
    end
);

InstallMethod(
    1RegQuivIntActionFunction,
    "for 1-regular quivers",
    [IsQuiver],
    function (quiver)
        local
            func; # Function variable

        if Has1RegQuivIntActionFunction(quiver) then
            return 1RegQuivIntActionFunction(quiver);

        # Test input
        elif not Is1RegQuiver(quiver) then
            Error("The given quiver\n", quiver, "\nis not 1-regular!");

        else
            # Write (nonrecursive!) function. For us, vertices are like
            #   i+1 --> i
            # and arrows are like
            #   --{a+1}--> vertex --{a}-->
            func := function(x, K)
                local
                    k, # Integer variable
                    y; # Quiver generator variable

                # Test input
                if not x in GeneratorsOfQuiver(quiver) then
                    Error("The first argument\n", x, "\nmust be a vertex or ",
                     "an arrow of the quiver\n", quiver);
                elif not IsInt(K) then
                    Error("The second argument\n", K,
                     "\nmust be an integer");

                else
                    y := x;
                    k := K;

                    while k <> 0 do
                        if IsQuiverVertex(y) and k < 0 then
                            y := TargetOfPath(OutgoingArrowsOfVertex(y)[1]);
                            k := k + 1;

                        elif IsQuiverVertex(y) and k > 0 then
                            y := SourceOfPath(IncomingArrowsOfVertex(y)[1]);
                            k := k - 1;

                        elif IsArrow(y) and k < 0 then
                            y := OutgoingArrowsOfVertex(TargetOfPath(y))[1];
                            k := k + 1;

                        elif IsArrow(y) and k > 0 then
                            y := IncomingArrowsOfVertex(SourceOfPath(y))[1];
                            k := k - 1;
                        fi;
                    od;

                    return y;
                fi;
            end;

            return func;
        fi;
    end
);

InstallMethod(
    1RegQuivIntAct,
    "for a generator of a one-regular quiver and an integer",
    [IsPath, IsInt],
    function(x, k)
        local
            func,   # Z-action function of <quiver>
            quiver; # Quiver to which <x> belongs

        quiver := QuiverContainingPath(x);

        # Test first argument <x>
        if not Is1RegQuiver(quiver) then
            Error("The given quiver\n", quiver, "\nis not 1-regular!");

        else
            # Apply appropriate Z-action function
            func := 1RegQuivIntActionFunction(quiver);
            return func(x, k);
        fi;
    end
);

InstallMethod(
    PathBySourceAndLength,
    "for 1 regular quivers",
    [IsQuiverVertex, IsInt],
    function(vert, len)
        local
            a,      # Arrow variable
            l,      # Integer variable
            walk;   # List
        if not Is1RegQuiver(QuiverContainingPath(vert)) then
            Error("The given vertex\n", vert, "\ndoes not belong to a 1-",
             "regular quiver!\n");
        elif len < 0 then
            Error("The given length must be nonnegative!\n");
        elif len = 0 then
            return vert;
        else
            a := IncomingArrowsOfVertex(vert)[1];
            walk := List([1 .. len], x -> 1RegQuivIntAct(a, -1 * x));
            return Product(walk);
        fi;
    end
);

InstallMethod(
    PathByTargetAndLength,
    "for 1 regular quivers",
    [IsQuiverVertex, IsInt],
    function(vert, len)
        return OppositePath(
         PathBySourceAndLength(OppositePath(vert), len)
        );
    end
);

InstallMethod(
    1RegQuivFromCycleLengths,
    "for a list of positive integers",
    [IsList],
    function(cycle_lengths)
        local
            vertices,   # list of vertices
            arrows,     # list of arrows
            i,          # loop variable for names of vertices and arrows
            len,        # loop variable for the length of each of the cycles
            j,          # loop variable for vertices in a cycle
            Q;          # output quiver

        if not ForAll(cycle_lengths, IsPosInt) then
            TryNextMethod();
        fi;

        vertices := [];
        arrows := [];

        i := 0;
        for len in cycle_lengths do
            for j in [1 .. len] do
                Add(vertices, Concatenation("v", String(i + j)));
                Add(arrows, [Concatenation("v", String(i + j)),
                               Concatenation("v", String((j mod len) + i + 1)),
                               Concatenation("a", String(i + j))
                ]);
            od;
            i := i + len;
        od;

        Q := Quiver(vertices, arrows);
        # If this assertion fails then something very weird has gone wrong
        Assert(1, Is1RegQuiver(Q), "Constructed quiver is not 1-regular");

        return Q;
    end
);
