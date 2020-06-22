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

InstallMethod(
    2RegAugmentationOfQuiver,
    "for connected special biserial (aka sub-2-regular) quivers",
    [ IsQuiver ],
    function( ground_quiv )
    	local
            arr_data,   # Arrow data, originally of <ground_quiv>
            is2reg,     # Local function testing for 2-regularity
            k,          # Integer variable
            new_quiv    # Quiver variable
            s,          # String variable
            u, v        # Vertex variables
            vert_data;  # Vertex data, originally of <ground_quiv>
            
        if Has2RegAugmentationOfQuiver( ground_quiv ) then
            return 2RegAugmentationOfQuiver( ground_quiv );
            
        # Test input quiver
        elif not IsSpecialBiserialQuiver( ground_quiv ) then
            Error( "The given quiver\n", ground_quiv, "\nis not special ",
             "biserial (ie, some vertex has in- or outdegree exceeding 2)");
        elif not IsConnectedQuiver( ground_quiv ) then
            Error( "The given quiver\n", ground_quiv, "\nis not connected" );
            
        else
            # Write local function testing for 2-regularity
            is2reg := function( Q )
                local
                    ans,        # Whether <Q> is 2-regular?; true until false
                    x;          # Vertex variable

                ans := true;
                for x in VerticesOfQuiver( Q ) do
                    if ( (InDegreeOfVertex(x) <> 2) or
                     (OutDegreeOfVertex(x) <> 2) ) then
                        ans := false;
                    fi;
                 od;
                 return ans;
            end;
            
            # Store data of <ground_quiv>
            vert_data := List(
                VerticesOfQuiver( ground_quiv ),
                x -> String( x )
            );
            arr_data := List(
                ArrowsOfQuiver( ground_quiv ),
                x -> [ String( SourceOfPath(x) ), String( TargetOfPath(x) ),
                    String( a ) ]
            );
           
            # Iteratively augment quiver until 2-regular
            new_quiv := ground_quiv;
            k := 0;
            
            while not is2reg( new_quiv ) do
                # Track how many arrows are being added
                k := k + 1;
                # Find first vertex with outdeg < 2
                u := String(
                 First(
                  VerticesOfQuiver( new_quiv ),
                  x -> OutDegreeOfVertex(x) <> 2
                 )
                );
                # Find first vertex with indeg < 2
                v := String(
                 First(
                  VerticesOfQuiver( new_quiv ),
                  x -> InDegreeOfVertex(x) <> 2
                 )
                );
                # Write name for augmenting arrow
                s := Concatenation(
                    [ "augarr", String( k ) ]
                );
                # Record data for new arrow
                Append( arr_data, [ [ x, y, s ] ] );
                # Construct augmented quiver
                new_quiv := Quiver( vert_data, arr_data );
            od;
            
            # Make <new_quiv> remember it is a 2-regular augmentation (and of
            #  whom)
            SetIs2RegAugmentationOfSbQuiver( new_quiv, true );
            SetOriginalSbQuiverOf2RegAugmentation( new_quiv, ground_quiv );

            # Make vertices of <new_quiv> aware of their counterparts in
            # <ground_quiv>, and vice versa
            k := 1;
            while k <= Length( VerticesOfQuiver( ground_quiv ) ) do
                VerticesOfQuiver( new_quiv )[k]!.2RegAugPathOf :=
                 VerticesOfQuiver( ground_quiv )[k];
                VerticesOfQuiver( ground_quiv )[k].2RegAugPath :=
                 VerticesOfQuiver( new_quiv )[k];
                k := k + 1;
            od;
            
            # Make arrows of <new_quiv> aware of their counterparts in
            #  <ground_ground>, and vice versa
            k := 1;
            while k <= Length( ArrowsOfQuiver( ground_quiv ) ) do
                ArrowsOfQuiver( new_quiv )[k]!.2RegAugPathOf :=
                 ArrowsOfQuiver( ground_quiv )[k];
                ArrowsOfQuiver( ground_quiv )[k]!.2RegAugPath :=
                 ArrowsOfQuiver( new_quiv )[k];
                k := k + 1;
            od;
            
            # Make augmented arrows know they have no counterpart in
            #  <ground_quiv>
            while k <= Length( ArrowsOfQuiver( new_quiv ) ) do
                ArrowsOfQuiver( new_quiv )[k].2RegAugPathOf :=
                 Zero( ground_quiv );
                k := k + 1;
            od;
            
            # Make zero path of <new_quiv> know its counterpart in
            #  <ground_quiv>, and vice versa
            Zero( new_quiv )!.2RegAugPathOf := Zero( ground_quiv );
            Zero( ground_quiv )!.2RegAugPath := Zero( new_quiv );
            
            # Return 2-regular augmentation <new_quiv> of <ground_quiv>. Note
            #  that if <ground_quiv> was 2-regular already then <new_quiv>
            #  and <ground_quiv> are identical.
            return new_quiv;
        fi;
    end
);

InstallMethod(
    Is2RegAugmentationOfSbQuiver,
    "for 2-regular augmentation",
    [ IsSpecialBiserialQuiver ]
    function( quiver )
        if HasIs2RegAugmentationOfSbQuiver( quiver ) then
            return Is2RegAugmentationOfSbQuiver( quiver );
        
        # When not already decided, print message and return <false>
        else

            Print( "The property <Is2RegAugmentationOfSbQuiver> only",
             " recognizes 2-regular augmentations constructed using the",
             " <2RegAugmentationOfQuiver> operation.\n",
             "Contact the maintainer of the <sbstrips> package if you believe",
             " there is an error here.\n" );
            return false;
        fi;
    end;
);

InstallMethod(
    OriginalSbQuiverOf2RegAugmentation,
    "for 2-regular augmentations of special biserial quivers",
    [ IsSpecialBiserialQuiver ],
    function( quiver )
        if HasOriginalSbQuiverOf2RegAugmentation( quiver ) then
            return OriginalSbQuiverOf2RegAugmentation( quiver );
        else
            Print( "This attribute only recognizes 2-regular augmentations ",
             "constructing using the <2RegAugmentationOfQuiver> operation.\n",
             "Contact the maintainer of the <sbstrips> package if you believe",
             " there is an error here.\n" );
            return fail;
        fi;
    end
);

InstallMethod(
    RetractionOf2RegAugmentation,
    "for 2-regular augmentations of special biserial quivers",
    [ IsSpecialBiserialQuiver ],
    function( quiver )
        local
            func,       # Function variable
            orig_quiv;  # Quiver of which <quiver> is the 2-reg augmentation

        if HasRetractionOf2RegAugmentation( quiver ) then
            return RetractionOf2RegAugmentation( quiver );

        # Test validity of <quiver>; if found wanting then return a function
        #  that returns a warning message each time alongside <fail>
        elif not Is2RegAugmentationOfSbQuiver( quiver ) then
            Print( "The given quiver\n", quiver, "\nhas not been constructed"
             " using the <2RegAugmentationOfQuiver> operation.\n");
             
             func := function( input )
                Print( "You are calling the retraction of a 2-regular",
                 " augmentation map that doesn't exist; something's gone"
                 " wrong!\n" )
                return fail
             end;
             
             return func;

        else
            # Construct retraction function
            func := function( path )
                local
                    walk;   #
                # Check input
                if not path in quiver then
                    Error( "The given path\n", path, "\n does not belong to",
                     " the 2-regular augmentation\n", quiver );

                # Zero or trivial paths know which ground path they lift
                elif path = Zero( quiver ) or IsQuiverVertex( path ) then
                    return path!.2RegAugPathOf;

                # Paths of positive lengths have walks, each constituent arrow
                #  of which knows the ground arrow it lifts
                else
                    walk := List( WalkOfPath( path ), x -> x!.2RegAugPathOf );
                    return Product( walk );
                fi;
            end;
            
            return func;
        fi;
    end
);

InstallMethod(
    CompatibleTrackPermutationOfSbAlg,
    "for special biserial algebras",
    [ IsSpecialBiserialAlgebra ],
    function( sba )
        local
            2reg,                   # 2-regular augmentation of the ground
                                    #  quiver of <sba>
            ideal,                  # Defining ideal of <sba>
            in1, in2, out1, out2,   # Arrow variables
            list,                   # List variable
            pa,                     # Path algebra of which <sba> is a quotient
            v;                      # Vertex variable

        if HasCompatibleTrackPermutationOfSbAlg( sba ) then
            return CompatibleTrackPermutationOfSbAlg( sba );

        else
            # Write local function that turns a path of the 2-regular
            #  augmentation into its residue in <sba>
            pa := OriginalPathAlgebra( sba );
            2reg := 2RegAugmentationOfSbQuiver( QuiverOfPathAlgebra( pa ) );
            in_pa := function( path )
                return ElementOfPathAlgebra(
                 pa,
                 RetractionOf2RegAugmentation( path )
                 );
            end;

            # For each vertex in turn, exhaust the arrows incident to that
            #  vertex using a pair of paths of length 2. There are only two
            #  possible pairs to chose from for each vertex. Use <list> to keep
            #  track of (the walks of) those length 2 paths chosen.

            list := [];
            ideal := IdealOfQuotient( sba );

            for v in verts do
                in1 := IncomingArrowsOfVertex( v )[1];
                in2 := IncomingArrowsOfVertex( v )[2];
                out1 := OutgoingArrowsOfVertex( v )[1];
                out2 := OutgoingArrowsOfVertex( v )[2];

                if not ( in_pa( in1 ) * in_pa( out1 ) ) in ideal then
                    Append( list,
                     [ Immutable( [ in1, out1 ] ), Immutable( [ in2, out2 ] ) ]
                     );
                 else
                    Append( list,
                     [ Immutable( [ in1, out2 ] ), Immutable( [ in2, out1 ] ) ]
                     );
                 fi;
            od;
            
            return Immutable( list );
        fi;
    end
);

InstallMethod(
    OverquiverOfSbAlg,
    "for special biserial algebras",
    [ IsSpecialBiserialAlgebra ],
    function( sba )
        local
            2reg,           # 2-regular augmentation of <ground_quiv>
            2reg_arrs,      # Arrows of <2reg>
            a,              # Arrow variable
            arr_data,       # Data yielding arrows of <oquiv>
            ground_quiv,    # Ground quiver of <sba>
            in_arr_pos,     # Local function
            k, N,           # Integer variables
            oarr_str,       # Naming function
            oarrs,          # Arrows of <oquiv>
            oquiv,          # Overquiver
            overts,         # Vertices of <oquiv>
            out_arr_pos,    # Local function
            part;           # Compatible track permutation of <sba>
        if HasOverquiverOfSbAlg( sba ) then
            return OverquiverOfSbAlg( sba );

        else
            part := CompatibleTrackPermutationOfSbAlg( sba );
            N := Length( part );
            
            ground_quiv := QuiverOfPathAlgebra( OriginalPathAlgebra( sba ) );
            2reg := 2RegAugmentationOfQuiver( ground_quiv );
            2reg_arrs := ArrowsOfQuiver( 2reg );

            # Vertices of overquiver correspond to entries of <part>. For
            #  convenience, entries of <part> will be identified with their
            #  indices

            # <arr> is the incoming arrow in some path in <part>. Write a local
            #  function finding the entry index of that path in <part>
            in_arr_pos := function( arr )
                local
                    k;  integer variable
                if part[k][1] = arr then
                    return k;
                else
                    k := k + 1;
                fi;
            end;

            # Similarly but for outcoming arrow
            out_arr_pos := function( arr )
                local
                    k;  integer variable
                if part[k][2] = arr then
                    return k;
                else
                    k := k + 1;
                fi;
            end;

            # Write function that names lifts of arrows
            oarr_str := function( arr )
                return Concatenation( [ String( arr ), "_over" ] );
            end;
            
            # Arrows of <2reg> lift to arrows of the overquiver. An arrow <a>
            #  points from [?,a] to [a,?] (or, rather, the vertices
            #  corresponding to those length 2 paths)

            arr_data := [];
            for a in 2reg_arrs do
                Append( arr_data,
                 [ [ out_arr_pos( a ), in_arr_pos( a ), oarr_str( a ) ] ]
                 );
            od;
            
            # Create overquiver <oquiv>
            oquiv := Quiver( N, arr_data );
            
            # Load vertices with data
            k := 1;
            overts := VerticesOfQuiver( oquiv );
            while k <= N do
                overts[k]!.LiftOf := TargetOfPath( parts[k][1] );
                k := k + 1;
            od;
            
            # Load arrows with data
            k := 1;
            oarrs := ArrowsOfQuiver( oquiv );
            while k <= Length( oarrs ) do
                oarrs[k]!.LiftOf ArrowsOfQuiver( ground_quiv )[k];
                k := k+1;
            od;
            
            # Load quiver with data
            SetIsOverquiver( oquiv, true );
            SetSbAlgOfOverquiver( oquiv, sba );
            
            # Return <oquiv>
            return over_quiv;
        fi;
    end
);

#########1#########2#########3#########4#########5#########6#########7#########
#########1#########2#########3#########4#########5#########6#########7#########
