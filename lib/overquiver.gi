InstallMethod(
    2RegAugmentationOfQuiver,
    "for a connected special biserial (aka sub-2-regular) quiver",
    [ IsQuiver ],
    function( ground_quiv )
        local
            a,              # Arrow variable
            arr_data,       # Arrow data, originally of <ground_quiv>
            is2reg,         # Local function testing for 2-regularity
            k,              # Integer variable
            new_quiv,       # Quiver variable
            ground_quiv_op, # Opposite quiver of <ground_quiv>
            s,              # String variable
            u, v,           # Vertex variables
            vert_data;      # Vertex data, originally of <ground_quiv>



        if Has2RegAugmentationOfQuiver( ground_quiv ) then
            return 2RegAugmentationOfQuiver( ground_quiv );

        # Test input quiver
        elif not IsSpecialBiserialQuiver( ground_quiv ) then
            Error( "The given quiver\n", ground_quiv, "\nis not special ",
             "biserial (ie, some vertex has in- or outdegree exceeding 2)" );
            
        elif not IsConnectedQuiver( ground_quiv ) then
            Error( "The given quiver\n", ground_quiv, "\nis not connected" );

        else
            # Construct a new quiver, checking first whether the opposite
            #  quiver of <ground_quiv> has a 2-regular augmentation <2reg>. If
            #  so then use the opposite quiver of <2reg> (so that
            #  <OppositeQuiver> and <2RegAugmentationOfQuiver> are compatible);
            #  if not then create a new quiver object.
        
            ground_quiv_op := OppositeQuiver( ground_quiv );
            
            if Has2RegAugmentationOfQuiver( ground_quiv_op ) then
                # In this case, all of the hard work has gone into constructing
                #  <2RegAugmentationOfQuiver( ground_quiv_op )>. We need only
                #  "conjugate" by <OppositeQuiver> or <OppositePath>
                new_quiv := OppositeQuiver(
                 2RegAugmentationOfQuiver( ground_quiv_op )
                 );
                
                # Make each vertex of <new_quiv> know the vertex of
                #  <ground_quiv> it corresponds to
                for v in VerticesOfQuiver( new_quiv ) do
                    v!.2RegAugPathOf := OppositePath(
                     OppositePath( v )!.2RegAugPathOf
                     );
                od;
                
                # Make each vertex of <ground_quiv> know the vertex of
                #  <new_quiv> it corresponds to
                for v in VerticesOfQuiver( ground_quiv ) do
                    v!.2RegAugPath := OppositePath(
                     OppositePath( v )!.2RegAugPath
                     );
                od;
                
                # Make each arrow of <new_quiv> know the arrow of <ground_quiv>
                #  it corresponds to, if any. (Connect it to the zero path if
                #  not.)
                for a in ArrowsOfQuiver( new_quiv ) do
                    if not IsZeroPath( OppositePath( a )!.2RegAugPathOf ) then
                        a!.2RegAugPathOf := OppositePath(
                         OppositePath( a )!.2RegAugPathOf
                        );
                        
                    else
                        a!.2RegAugPathOf := Zero( ground_quiv );
                    fi;
                od;
                
                # Make each arrow of <ground_quiv> know the arrow of <new_quiv>
                #  it corresponds to
                for a in ArrowsOfQuiver( ground_quiv ) do
                    a!.2RegAugPath := OppositePath(
                     OppositePath( a )!.2RegAugPath
                     );
                od;
                
        
            else
                # In this case, we have to do all the hard work. The first job
                #  is to create the new quiver object <new_quiv>.
                
                # We Store data of <ground_quiv>
                vert_data := List(
                    VerticesOfQuiver( ground_quiv ),
                    x -> String( x )
                );
                arr_data := List(
                    ArrowsOfQuiver( ground_quiv ),
                    x -> [ String( SourceOfPath(x) ),
                           String( TargetOfPath(x) ),
                           String( x )
                         ]
                );

                # Iteratively augment <ground_quiv> until 2-regular
                new_quiv := ground_quiv;
                k := 0;

                while not Is2RegQuiver( new_quiv ) do
                    # Track how many arrows are being added
                    k := k + 1;
                    # Find first vertex with outdegree < 2
                    u := String(
                     First(
                      VerticesOfQuiver( new_quiv ),
                      x -> OutDegreeOfVertex(x) <> 2
                     )
                    );
                    # Find first vertex with indegree < 2
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
                    Append( arr_data, [ [ u, v, s ] ] );
                    # Construct augmented quiver
                    new_quiv := Quiver( vert_data, arr_data );
                od;
                
                # Now that we have a 2-regular augmentation, we make vertices
                #  of <new_quiv> aware of their counterparts in <ground_quiv>,
                #  and vice versa
                for k in [ 1 .. Length( VerticesOfQuiver( ground_quiv ) ) ] do
                    VerticesOfQuiver( new_quiv )[k]!.2RegAugPathOf :=
                     VerticesOfQuiver( ground_quiv )[k];
                    VerticesOfQuiver( ground_quiv )[k]!.2RegAugPath :=
                     VerticesOfQuiver( new_quiv )[k];
                od;

                # We also make arrows of <new_quiv> aware of their counterparts
                #  in <ground_quiv>, and vice versa
                k := 1;
                while k <= Length( ArrowsOfQuiver( ground_quiv ) ) do
                    ArrowsOfQuiver( new_quiv )[k]!.2RegAugPathOf :=
                     ArrowsOfQuiver( ground_quiv )[k];
                    ArrowsOfQuiver( ground_quiv )[k]!.2RegAugPath :=
                     ArrowsOfQuiver( new_quiv )[k];
                    k := k + 1;
                od;

                # Then we make augmented arrows know they have no counterpart
                #  in <ground_quiv>
                while k <= Length( ArrowsOfQuiver( new_quiv ) ) do
                    ArrowsOfQuiver( new_quiv )[k]!.2RegAugPathOf :=
                     Zero( ground_quiv );
                    k := k + 1;
                od;
            fi;
            
            # Make <new_quiv> remember it is a 2-regular augmentation (and of
            #  whom)
            SetIs2RegAugmentationOfQuiver( new_quiv, true );
            SetOriginalSBQuiverOf2RegAugmentation( new_quiv, ground_quiv );

            # Make zero path of <new_quiv> know its counterpart in
            #  <ground_quiv>, and vice versa
            Zero( new_quiv )!.2RegAugPathOf := Zero( ground_quiv );
            Zero( ground_quiv )!.2RegAugPath := Zero( new_quiv );

            # Return 2-regular augmentation <new_quiv> of <ground_quiv>. Note
            #  that if <ground_quiv> was 2-regular already then <new_quiv>
            #  and <ground_quiv> are identical, but the object has been changed
            #  in place.
            return new_quiv;
        fi;
    end
);

InstallMethod(
    Is2RegAugmentationOfQuiver,
    "for 2-regular augmentation",
    [ IsQuiver ],
    function( quiver )
        # A problem arose when evalutating the property
        #  <Is2RegAugmentationOfQuiver> of a 2-regular quiver, say <Q>, before
        #  evaluating the attribute <2RegAugmentationOfQuiver>. This attribute
        #  of <Q> wants to have value <Q>, causing the property to be <true>.
        #  If the property is tested first, then it will have value <false>,
        #  which causes problems since the attribute wants to set the property
        #  to <true>. The code below is a workaround for this problem.

        if not IsSpecialBiserialQuiver( quiver ) then
            return false;
        else
            2RegAugmentationOfQuiver( quiver );
            if HasIs2RegAugmentationOfQuiver( quiver ) then
                return Is2RegAugmentationOfQuiver( quiver );

            # When not already decided, print message and return <false>
            else

                Print( "The property <Is2RegAugmentationOfQuiver> only recognizes \
                 2-regular augmentations constructed using the <2RegAugmentationOf\
                 Quiver> operation.\n Contact the maintainer of the <sbstrips> \
                 package if you believe there is an error here.\n" );
                return false;
            fi;
        fi;
    end
);

InstallMethod(
    OriginalSBQuiverOf2RegAugmentation,
    "for 2-regular augmentations of special biserial quivers",
    [ IsQuiver ],
    function( quiver )
        if HasOriginalSBQuiverOf2RegAugmentation( quiver ) then
            return OriginalSBQuiverOf2RegAugmentation( quiver );
        else
            Print( "This attribute only recognizes 2-regular augmentations con\
             structed using the <2RegAugmentationOfQuiver> operation.\n\
             Contact the maintainer of the <sbstrips> package if you believe \
             there is an error here.\n" );
            return fail;
        fi;
    end
);

InstallMethod(
    RetractionOf2RegAugmentation,
    "for 2-regular augmentations of special biserial quivers",
    [ IsQuiver ],
    function( quiver )
        local
            func,       # Function variable
            orig_quiv,  # Quiver of which <quiver> is the 2-reg augmentation
            ret;        # Retraction function

        if HasRetractionOf2RegAugmentation( quiver ) then
            return RetractionOf2RegAugmentation( quiver );
            
        # If the opposite quiver of <quiver> has a retraction map, then the
        #  hard work is already done. We need only "conjugate" by
        #  <OppositePath> (and add a few minor tweaks for dealing with zero
        #  paths).
        elif HasRetractionOf2RegAugmentation( OppositeQuiver( quiver ) ) then
            orig_quiv := OriginalSBQuiverOf2RegAugmentation( quiver );
            ret := RetractionOf2RegAugmentation( OppositeQuiver( quiver ) );
            
            func := function( path )
            
                if IsZeroPath( path ) then
                    return Zero( orig_quiv );
                    
                elif IsZeroPath( ret( OppositePath( path ) ) ) then
                    return Zero( orig_quiv );
                    
                else
                    return OppositePath( ret( OppositePath( path ) ) );
                fi;
            end;
            
            return func;

        # Test validity of <quiver>; if found wanting then return a function
        #  that returns a warning message each time, alongside <fail>
        elif not Is2RegAugmentationOfQuiver( quiver ) then
            Print( "The given quiver\n", quiver, "\nhas not been constructed ",
             " using the <2RegAugmentationOfQuiver> operation.\n");

             func := function( input )
                Print( "You are calling the retraction of a 2-regular ",
                 "augmentation map that doesn't exist; something's gone ",
                 "wrong! Please contact the maintainer of the sbstrips ",
                 "package.\n" );
                return fail;
             end;

             return func;

        else
            # Construct retraction function
            func := function( path )
                local
                    walk;   # List variable

                # Check input
                if not path in quiver then
                    Error( "The given path\n", path, "\n does not belong to ",
                     "the 2-regular augmentation\n", quiver );

                # Zero or trivial paths know which ground path they lift
                elif
                 ( path = Zero( quiver ) ) or ( IsQuiverVertex( path ) )
                 then
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
    CompatibleTrackPermutationOfSBAlg,
    "for special biserial algebras",
    [ IsSpecialBiserialAlgebra ],
    function( sba )
        local
            2reg,                   # 2-regular augmentation of the ground
                                    #  quiver of <sba>
            ideal,                  # Defining ideal of <sba>
            in1, in2, out1, out2,   # Arrow variables
            in_pa,                  # Local function
            list,                   # List variable
            pa,                     # Path algebra of which <sba> is a quotient
            v;                      # Vertex variable

        if HasCompatibleTrackPermutationOfSBAlg( sba ) then
            return CompatibleTrackPermutationOfSBAlg( sba );
            
        elif
         HasCompatibleTrackPermutationOfSBAlg( OppositePathAlgebra( sba ) )
         then
            list := CompatibleTrackPermutationOfSBAlg(
             OppositePathAlgebra( sba )
             );
             
            return Immutable(
             List(
              list,
              x -> Reversed( List( x, OppositePath ) )
              )
             );

        else
            # Write local function that turns a path of the 2-regular
            #  augmentation into its residue in <sba>
            pa := OriginalPathAlgebra( sba );
            2reg := 2RegAugmentationOfQuiver( QuiverOfPathAlgebra( pa ) );
            in_pa := function( path )
                return ElementOfPathAlgebra(
                 pa,
                 RetractionOf2RegAugmentation( 2reg )( path )
                 );
            end;

            # For each vertex in turn, exhaust the arrows incident to that
            #  vertex using a pair of paths of length 2. There are only two
            #  possible pairs to chose from for each vertex. Use <list> to keep
            #  track of (the walks of) those length 2 paths chosen.

            list := [];
            ideal := IdealOfQuotient( sba );

            for v in VerticesOfQuiver( 2reg ) do
                in1 := IncomingArrowsOfVertex( v )[1];
                in2 := IncomingArrowsOfVertex( v )[2];
                out1 := OutgoingArrowsOfVertex( v )[1];
                out2 := OutgoingArrowsOfVertex( v )[2];

                if
                 ( not ( in_pa( in1 ) * in_pa( out1 ) in ideal ) )
                 or
                 ( not ( in_pa( in2 ) * in_pa( out2 ) in ideal ) )
                 then
                    Append( list,
                     [ Immutable( [ in1, out1 ] ), Immutable( [ in2, out2 ] ) ]
                     );
                else
                    Append( list,
                     [ Immutable( [ in1, out2 ] ), Immutable( [ in2, out1 ] ) ]
                     );
                fi;
            od;
            
            Sort( list );

            return Immutable( list );
        fi;
    end
);

InstallMethod(
    OverquiverOfSBAlg,
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
            part,           # Compatible track permutation of <sba>
            ret,            # Retraction of <2reg> to <ground_quiv>
            v;              # Vertex variable
            
        if HasOverquiverOfSBAlg( sba ) then
            return OverquiverOfSBAlg( sba );

        # The first step is to create a new quiver object <oquiv>. The second
        #  step is to enter information into that quiver.
        # If the opposite path algebra of <sba> already has an overquiver, then
        #  we can save much hard work by dualising (or rather "opposite-ing")
        #  information from that overquiver.

        else
            # In this case, the opposite path algebra of <sba> already has an
            #  overquiver.
            if HasOverquiverOfSBAlg( OppositePathAlgebra( sba ) ) then
                # Creating a new quiver object is straightforward.
                oquiv := OppositeQuiver(
                 OverquiverOfSBAlg( OppositePathAlgebra( sba ) )
                 );
                 
                2reg := OppositeQuiver( OppositeQuiver( oquiv )!.2Reg );
            
                # Loading <oquiv> with information is straightforward.
                oquiv!.2Reg := 2reg;
                
                for v in VerticesOfQuiver( oquiv ) do
                    v!.LiftOf := OppositePath( OppositePath( v )!.LiftOf );
                od;
                
                for a in ArrowsOfQuiver( oquiv ) do
                    a!.LiftOf := OppositePath( OppositePath( v )!.LiftOf );
                od;
                
                Zero( oquiv )!.LiftOf := Zero( 2reg );
                
            # In this case, we complete all the hard work.
            else        
                part := CompatibleTrackPermutationOfSBAlg( sba );
                N := Length( part );

                ground_quiv := QuiverOfPathAlgebra(
                 OriginalPathAlgebra( sba )
                 );
                2reg := 2RegAugmentationOfQuiver( ground_quiv );
                2reg_arrs := ArrowsOfQuiver( 2reg );
                ret := RetractionOf2RegAugmentation( 2reg );

                # Vertices of overquiver correspond to entries of <part>. For
                #  convenience, entries of <part> will be identified with their
                # indices.

                # Any arrow <arr> of <2reg> is the incoming arrow in some path
                #  in <part>. Write a local function finding the entry index of
                #  that path in <part>.
                in_arr_pos := function( arr )
                    local
                        k;  #integer variable
                        
                    k := 1;
                    for k in [ 1 .. Length( part ) ] do
                    
                        if part[k][1] = arr then
                            return k;
                            
                        else
                            k := k + 1;
                        fi;
                    od;
                end;

                # Similarly but for outcoming arrow
                out_arr_pos := function( arr )
                    local
                        k;  # integer variable
                        
                    k := 1;
                    for k in [1..Length( part )] do
                    
                        if part[k][2] = arr then
                            return k;
                            
                        else
                            k := k + 1;
                        fi;
                    od;
                end;

                # Write function that names lifts of arrows
                oarr_str := function( arr )
                    return Concatenation( [ String( arr ), "_over" ] );
                end;

                # Arrows of <2reg> lift to arrows of the overquiver. An arrow
                #  <a> points from [?,a] to [a,?] (or, rather, the vertices
                #  corresponding to those paths of length 2).

                arr_data := [];
                for a in 2reg_arrs do
                    Append( arr_data,
                     [ [ out_arr_pos( a ), in_arr_pos( a ), oarr_str( a ) ] ]
                     );
                od;

                # Create overquiver <oquiv>.
                oquiv := Quiver( N, arr_data );
                
                # Load vertices with data
                k := 1;
                overts := VerticesOfQuiver( oquiv );
                while k <= N do
                    overts[k]!.LiftOf := TargetOfPath( part[k][1] );
                    k := k + 1;
                od;

                # Load arrows with data
                k := 1;
                oarrs := ArrowsOfQuiver( oquiv );
                while k <= Length( oarrs ) do
                    oarrs[k]!.LiftOf := 2reg_arrs[k] ;
                    k := k+1;
                od;
                
                # Load zero path with data
                    Zero( oquiv )!.LiftOf := Zero( 2reg );

                # Load quiver with data
                SetIsOverquiver( oquiv, true );
                SetSBAlgOfOverquiver( oquiv, sba );
                oquiv!.2Reg := 2reg;
                
                # Create contraction function
                ContractionOfOverquiver( oquiv );;
            fi;

            # Return <oquiv>
            return oquiv;
        fi;
    end
);

InstallMethod(
    IsOverquiver,
    "for quivers",
    [ IsQuiver ],
    function( quiver )
        if HasIsOverquiver( quiver ) then
            return IsOverquiver( quiver );
            
        elif HasIsOverquiver( OppositeQuiver( quiver ) ) then
            return IsOverquiver( OppositeQuiver( quiver ) );
        
        else
            # Overquivers are exactly those quivers constructed using the
            #  <OverquiverOfSBAlg> command. Such quivers have this property set
            #  (to <true>) at creation. Therefore any quiver for which this
            #  property has not been set must not have been so constructed.
            return fail;
        fi;
    end
);

InstallMethod(
    ContractionOfOverquiver,
    "for overquivers",
    [ IsQuiver ],
    function( oquiv )
        local
            cont,   # Function to be returned
            contop, # Contraction of opposite quiver
            ret;    # Retraction of 2-regular augmentation on which <oquiv> is
                    #  based

        if HasContractionOfOverquiver( oquiv ) then
            return ContractionOfOverquiver( oquiv );
            
        elif HasContractionOfOverquiver( OppositeQuiver( oquiv ) ) then
            contop := ContractionOfOverquiver( OppositeQuiver( oquiv ) );
            cont := function( path )
                if IsZeroPath( path ) then
                    return path!.LiftOf;
                
                else
                    return OppositePath( contop( OppositePath( path ) ) );
                fi;
            end;
            
            return cont;
            
        # Test input quiver
        elif not IsOverquiver( oquiv ) then
            Error( "The given quiver\n", oquiv, "\nis not an overquiver!" );

        else
            cont := function( path )
                # NOTE. The input to this function is a path in an overquiver
                #  <oquiv>. The output is a path in the ground quiver of the SB
                #  algebra of which <oquiv> is the overquiver.

                local
                    walk;   # List variable
                    
                # Test input path
                if not path in oquiv then
                    Print( "The given path\n", path, "\ndoes not belong to the\
                     given overquiver\n", oquiv);
                    return fail;
  
                # Zero or stationary paths know the ground paths they lift
                elif path = Zero( oquiv ) or IsQuiverVertex( path ) then
                    return path!.LiftOf;
                    
                # Paths of positive length lift the product of the paths lifted
                #  by their constituent arrows
                else
                    walk := List( WalkOfPath( path ), x -> x!.LiftOf );
                    return Product( walk );
                fi;
            end;
            
            return cont;
        fi;
    end
);

InstallMethod(
    SBAlgOfOverquiver,
    "for overquivers",
    [ IsQuiver ],
    function( quiver )
        local
            sba_op; # Opposite SB algebra to that of <quiver>

        if HasSBAlgOfOverquiver( quiver ) then
            return SBAlgOfOverquiver( quiver );
            
        elif HasSBAlgOfOverquiver( OppositeQuiver( quiver ) ) then
            sba_op := SBAlgOfOverquiver( OppositeQuiver( quiver ) );
            
            if not ( sba_op = fail ) then
                return OppositePathAlgebra( sba_op );
            else
                return fail;
            fi;
        
        elif not IsOverquiver( quiver ) then
            return fail;
        else
            Error( "Somehow the given quiver\n", quiver, "\nis an overquiver ",
             "that doesn't know the special biserial algebra to which it ",
             "belongs! Please contact the maintainer of the sbstrips package."
             );
        fi;
    end
);

InstallMethod(
    ExchangePartnerOfVertex,
    "for vertices of overquivers",
    [ IsQuiverVertex ],
    function( v )
        local
            cont,           # Contraction of <oquiv>
            oquiv,          # Overquiver to which <v> belongs
            images,         # Apply <cont> to <overts>
            overts,         # Vertices of <oquiv>
            u,              # Vertex
            u_pos, v_pos;   # Positions of <u> and <v>

        if HasExchangePartnerOfVertex( v ) then
            return ExchangePartnerOfVertex( v );
        else
            oquiv := QuiverContainingPath( v );
            if not IsOverquiver( oquiv ) then
                TryNextMethod();
            else
                cont := ContractionOfOverquiver( oquiv );
                overts := VerticesOfQuiver( oquiv );
                
                # Search for the vertex <u>, distinct from <v>, that has the
                #  same image in <cont> as <v> does
                v_pos := Position( overts, v );
                images := List( overts, cont );
                Unbind( images[ v_pos ] );
                u_pos := Position( images, cont( v ) );
                u := overts[ u_pos ];
                
                # <ExchangePartnerOfVertex> represents an involution and we're
                #  about to say "<v> goes to <u>". While we're here, let's
                #  commit to memory that "<u> goes to <v>".
                
                SetExchangePartnerOfVertex( u, v );
                
                return u;
            fi;
        fi;
    end
);

InstallGlobalFunction(
    GroundPathOfOverquiverPathNC,
    function( path )
        local
            2reg,   # 2-regular augmentation of <quiv>
            cont,   # Contraction of <oquiv>
            oquiv,  # Overquiver to which <path> belongs
            quiv,   # Original quiver of <sba>
            ret,    # Retraction of <2reg>
            sba;    # SB algebra of which <oquiv> is overquiver
            
        oquiv := QuiverContainingPath( path );
        cont := ContractionOfOverquiver( oquiv );
        
        sba := SBAlgOfOverquiver( oquiv );
        
        quiv := QuiverOfPathAlgebra( OriginalPathAlgebra( sba ) );
        2reg := 2RegAugmentationOfQuiver( quiv );
        ret := RetractionOf2RegAugmentation( 2reg );
        
        return ret( cont( path ) );
    end
);

InstallGlobalFunction(
    SBAlgResidueOfOverquiverPathNC,
    function( path )
        local
            oquiv,  # Overquiver to which <path> belongs
            1_sba;  # Multiplicative unit of <sba>

        oquiv := QuiverContainingPath( path );
        1_sba := One( SBAlgOfOverquiver( oquiv ) );
        
        return GroundPathOfOverquiverPathNC( path ) * 1_sba;
    end
);
