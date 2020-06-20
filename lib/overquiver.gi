InstallMethod(
    Is1RegularQuiver,
    "for quivers",
    [IsQuiver],
    function( quiver )
        local
            v,      # Vertex variable
            verts;  # Vertices of <quiver>
        
        # Test vertex degrees
        verts := VerticesOfQuiver( quiver );
		
        for v in verts do
            if InDegreeOfVertex( v ) <> 1 or OutDegreeOfVertex( v ) <> 1 then
                return false;
            fi;
        od;
		
        return true;
    end
);

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
    1RegQuivIntActionFunction,
    "for 1-regular quivers",
    [ IsQuiver ],
    function ( quiver )
        local
            func;	# Function variable
			
        if Has1RegQuivIntActionFunction( quiver ) then
            return 1RegQuivIntActionFunction( quiver );
		
        # Test input
        elif not Is1RegularQuiver( quiver ) then
            Error( "The given quiver\n", quiver, "\nis not 1-regular!" );

        else
            # Write (nonrecursive!) function. For us, vertices are like
            #   i+1 --> i
            # and arrows are like
            #   --{a+1}--> vertex --{a}-->
            func := function( x, K );
                local
                    k,	# Integer variable
                    y;	# Quiver generator variable
					
                # Test input
                if not x in GeneratorsOfQuiver( quiver ) then
                    Error( "The first argument\n", x, "\nmust be a vertex or ",
                     "an arrow of the quiver\n", quiver );
                elif not IsInt( K ) then
                    Error( "The second argument\n", K,
                     "\nmust be an integer" );
            	 
                else
                    x := y;
                    k := K;
					
                    while k <> 0 do
                        if IsQuiverVertex( x ) and k > 0 then
                            x := TargetOfPath( OutgoingArrowsOfVertex(x)[1] );
                            k := k - 1;
							
                        elif IsQuiverVertex( x ) and k < 0 then
                            x := SourceOfPath( IncomingArrowsOfVertex(x)[1] );
                            k := k + 1;
							
                        elif IsArrow( x ) and k > 0 then
                            x := OutgoingArrowsOfVertex( TargetOfPath(x) )[1];
                            k := k-1;
							
                        elif IsArrow( x ) and k < 0 then
                            x := IncomingArrowsOfVertex( SourceOfPath(x) )[1];
                            k := k + 1;
                        fi;
                    od;
					
                    return x;
                fi;
            end;
			
            return func;
        fi;
    end
);

InstallMethod(
    1RegQuivIntAct,
    "for a generator of a one-regular quiver and an integer",
    [ IsPath, IsInt ],
    function( x, k )
        local
            func,	# Z-action function of <quiver>
            quiver;	# Quiver to which <x> belongs
			
        quiver := QuiverOfQuiverPath( x );
		
        # Test first argument <x>
        if not Is1RegularQuiver( quiver ) then
            Error( "The given quiver\n", quiver, "\nis not 1-regular!" );
			
        else
            # Apply appropriate Z-action function
            func := 1RegQuivIntActFunc( quiver );
            return func( x, k );
        fi;
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
#########1#########2#########3#########4#########5#########6#########7#########
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

#########1#########2#########3#########4#########5#########6#########7#########
#########1#########2#########3#########4#########5#########6#########7#########
