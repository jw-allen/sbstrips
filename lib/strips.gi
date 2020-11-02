InstallMethod(
    StripFamilyOfSbAlg,
    "for special biserial algebra",
    [ IsSpecialBiserialAlgebra ],
    function( sba )
        local
            fam;

        if HasStripFamilyOfSbAlg( sba ) then
            return StripFamilyOfSbAlg( sba );
        else
            fam := NewFamily( "StripFamilyForSbAlg" );
            fam!.sb_alg := sba;
            
            return fam;
        fi;
    end
);

InstallMethod(
    ReflectionOfStrip,
    "for a strip rep",
    [ IsStripRep ],
    function( strip )
        local
            data,       # Defining data of <strip>
            k, l,       # Integer variables 
            list,       # List variable (for the output)
            ori_list,   # Sublist of orientations in <data>
            sy_list;    # Sublist of syllables in <data>
            
        data := strip![1];
        l := Length( data );
        
        # The syllables are in the odd positions of <data>; the orientations in
        #  the even positions.
        sy_list := data{ Filtered( [ 1..l ], IsOddInt ) };
        ori_list := data{ Filtered( [ 1..l ], IsEvenInt ) };

        # <sy_list> needs to be reversed individually and then interwoven with
        #  <ori_list>
        sy_list := Reversed( sy_list );
        
        list := [1..l];
        for k in list do
            if IsOddInt( k ) then
                list[ k ] := sy_list[ (k+1)/2  ];
            elif IsEvenInt( k ) then
                list[ k ] := ori_list[ k/2 ];
            fi;
        od;

        return CallFuncList( StripifyFromSyllablesAndOrientationsNC, list );
    end
);

InstallOtherMethod(
    \=,
    "for strips",
    \=,
    [ IsStripRep, IsStripRep ],
    function( strip1, strip2 )
        local
            data1, data2,           # Defining data of <strip1> and <strip2>
            l,                      # Integer variable (for a length of a list)
            ori_list1, ori_list2,   # Orientation list of <data1> and <data2>
            sy_list1, sy_list2;     # Syllable list of <data1> and <data2>
            
        data1 := strip1![1];
        data2 := strip2![1];
        
        if Length( data1 ) <> Length( data2 ) then
            return false;
        else
            l := Length( data1 );
            sy_list1 := data1{ Filtered( [ 1..l ], IsOddInt ) };
            ori_list1 := data1{ Filtered( [ 1..l ], IsEvenInt ) };
            sy_list2 := data2{ Filtered( [ 1..l ], IsOddInt ) };
            ori_list2 := data2{ Filtered( [ 1..l ], IsEvenInt ) };
            
            if ( sy_list1 = sy_list2 ) and ( ori_list1 = ori_list2 ) then
                return true;
            elif ( sy_list1 = Reversed( sy_list2 ) ) and
             ( sy_list1 = Reversed( sy_list2 ) ) then
                return true;
            else
                return false;
            fi;
        fi;
    end
);

InstallGlobalFunction(
    StripifyFromSyllablesAndOrientationsNC,
    "for a list of syllables and alternating orientations",
    function( arg )
        local
            data,       # Defining data of the strip to output
            fam,        # Strip family of <sba>
            len,        # Length of <arg>
            norm_sy,    # Syllable added in order to normalize
            norm_arg,   # Normalised version of <arg>
            sba,        # SB algebra from which the syllables are taken
            type;       # Type variable
        
        len := Length( arg );
        sba := SbAlgOfSyllable( arg[1] );
        
        # This is an NC function, so we can assume that the arguments are
        #      sy1, or1, sy2, or2, sy3, or3, ..., syN, orN
        #  where [ sy1, sy2, sy3, ..., syN ] are alternately peak- and valley-
        #  neighbour syllables and [ or1, or2, or3, ..., orN ] are alternately
        #  -1 and 1.
        
        # First, we normalize. This means putting a stationary trivial syllable
        #  with orientation -1 at the start and one with orientation 1 at the
        #  end if necessary and calling the function again
        
        if arg[2] <> -1 then
            norm_sy := SidestepFunctionOfSbAlg( sba )( arg[1] );
            norm_arg := Concatenation( [ norm_sy, -1 ], arg );
            
            Info( InfoSBStrips, 4, "Normalizing on left, calling again..." );
            
            return CallFuncList(
            StripifyFromSyllablesAndOrientationsNC,
             norm_arg
             );
        elif arg[ len ] <> 1 then
            norm_sy := SidestepFunctionOfSbAlg( sba )( arg[ len - 1 ] );
            norm_arg := Concatenation( arg, [ norm_sy, 1 ] );
            
            Info( InfoSBStrips, 4, "Normalizing on right, calling again..." );
            
            return CallFuncList(
            StripifyFromSyllablesAndOrientationsNC,
             norm_arg
             );
        fi;
        
        # Now we create the <IsStripRep> object.
        
        Info( InfoSBStrips, 4, "no normalisation needed, creating object..." );
        
        data := arg;
        fam := StripFamilyOfSbAlg( sba );
        type := NewType( fam, IsStripRep );
        
        return Objectify( type, [ data ] );
    end
);

# +---------------------------------------------------------------------------+
# CAN THE FOLLOWING BE REMOVED?

# InstallGlobalFunction(
    # StripifyFromSbAlgPathNC,
    # "for a nonstationary path in an SB algebra between two lists of integers",
    # function( left_list, path, right_list )
        # local
            # 1_sba,      # Multiplicative unit of <sba>
            # 2reg,       # 2-regular augmention of <quiv>
            # cont,       # Contraction of <oquiv> (function <oquiv> --> <2reg>)
            # i,          # Vertex variable (for source/target of a path)
            # k, l, r,    # Integer variable (for entries of <left_list> or
                        # #  <right_list>)
            # len,        # Integer variable (for length of a path)
            # linind,     # Set of <oquiv> paths with linearly independent res-
                        # #  -idue in <sba>
            # list,       # List variable, to store syllables and orientations
            # matches,    # List of paths in <lin_ind> that lift <path>
            # oquiv,      # Overquiver of <sba>
            # over_path,  # Lift <path> to overquiver
            # p,          # Path variable
            # quiv,       # Ground quiver of <sba>
            # ret,        # Retraction of <2reg> (function <2reg> --> <quiv> )
            # sba;        # SB algebra to which <path> belongs
        
        # sba := PathAlgebraContainingElement( path );
        # 1_sba := One( sba );
        
        # quiv := QuiverOfPathAlgebra( OriginalPathAlgebra( sba ) );
        # 2reg := 2RegAugmentationOfQuiver( quiv );
        # ret := RetractionOf2RegAugmentation( 2reg );
        # oquiv := OverquiverOfSbAlg( sba );
        # cont := ContractionOfOverquiver( oquiv );

        # linind := LinIndOfSbAlg( sba );
        
        # # Find the path <over_path> in <oquiv> whose <sba>-residue is <path>.
        # #  (Recall that entries of <linind> are paths in <oquiv>. Applying
        # #  <cont> and then <ret> turns them into entries of <quiv>. Multiplying
        # #  by <1_sba> subsequently makes elements of <sba>.)
        # matches := Filtered( linind, x -> ( 1_sba * ret( cont( x ) ) ) = path );
        # if Length( matches ) <> 1 then
            # Error( "I cannot find an overquiver path that lifts the given \
             # path ", path, "! Contact the maintainer of the sbstrips package."
             # );
        # else
            # over_path := matches[1];
        # fi;

        # # First, we normalise. If <left_list> has a last entry that is negative
        # #  and/or <right_list> has a first entry that is positive, then we
        # #  "absorb" those entries into <over_path>, remove them from their res-
        # #  -pective lists, and call the function again.
        # # (We need to be careful as <left_list> or <right_list> may be empty.
        
        # if Length( left_list ) > 0 then
            # l := left_list[ Length( left_list ) ];
            # if l < 0 then
                # i := TargetOfPath( over_path );
                # len := LengthOfPath( over_path );
                # over_path := PathByTargetAndLength( i, len - l );

                # path := ret( cont( over_path ) )*1_sba;
                # left_list := left_list{ [ 1..( Length( left_list ) - 1 ) ] };
                # return StripifyFromSbAlgPathNC( left_list, path, right_list );
            # fi;
        # fi;
        
        # if Length( right_list ) > 0 then
            # r := right_list[1];
            # if r > 0 then
                # i := SourceOfPath( over_path );
                # len := LengthOfPath( over_path );
                # over_path := PathBySourceAndLength( i, len+r );
                
                # path := ret( cont( over_path ) )*1_sba;
                # right_list := right_list{ [ 2..( Length( right_list ) ) ] };
                # return StripifyFromSbAlgPathNC( left_list, path, right_list  );
            # fi;
        # fi;
        
        # # Now <left_list> is either empty or ends in a positive integer, and
        # #  <right_list> is either empty or begins with a negative integer. We
        # #  can turn the input into a syllable-and-orientation list to be
        # #  handled by <StripifyFromSyllablesAndOrientationsNC>.
        
        # list := [ over_path, 1 ];

        # # Develop <list> on the right
        # i := ExchangePartnerOfVertex( TargetOfPath( over_path ) );
        # for k in [ 1..Length( right_list ) ] do
            # if right_list[k] < 0 then
                # p := PathByTargetAndLength( i, -( right_list[k] ) );
                # list := Concatenation( list, [ p, -1 ] );
                # i := ExchangePartnerOfVertex( SourceOfPath( p ) );
            # elif
                # right_list[k] > 0 then
                # p := PathBySourceAndLength( i, right_list[k] );
                # list := Concatenation( list, [ p, 1 ] );
                # i := ExchangePartnerOfVertex( TargetOfPath( p ) );
            # fi;
        # od;
        
        # # Develop <list> on the left
        # i := ExchangePartnerOfVertex( SourceOfPath( over_path ) );
        # for k in [ 1..Length( left_list ) ] do
            # if Reversed( left_list )[k] < 0 then
                # p := PathByTargetAndLength( i, -( Reversed( left_list )[k] ) );
                # list := Concatenation( [p, 1], list );
                # i := ExchangePartnerOfVertex( SourceOfPath( p ) );
            # elif Reversed( left_list )[k] > 0 then
                # p := PathBySourceAndLength( i, Reversed( left_list )[k] );
                # list := Concatenation( [p, - 1], list );
                # i := ExchangePartnerOfVertex( TargetOfPath( p ) );
            # fi;
        # od;

        # # This gives a list paths in <oquiv> and orientations. Now we turn each
        # #  path into a syllable. Almost all syllables are interior (ie, have
        # #  pertubation term 0). The only exceptions are: the first syllable
        # #  only if its orientation is -1 and; the last syllable only if its
        # #  orientation is 1.
        # for k in [ 1..Length( list ) ] do
            # if IsOddInt( k ) then
                # if ( (k = 1) and (list[k+1] = -1) ) then
                    # list[k] := Syllabify( list[k], 1 );
                # elif ( (k+1 = Length( list )) and (list[k+1] = 1) ) then
                    # list[k] := Syllabify( list[k], 1 );
                # else
                    # list[k] := Syllabify( list[k], 0 );
                # fi;
            # fi;
        # od;
        
        # # Pass <list> to StripifyFromSyllablesAndOrientationsNC
        # return CallFuncList(
         # StripifyFromSyllablesAndOrientationsNC,
         # list
         # );
    # end
# );
# +---------------------------------------------------------------------------+

InstallGlobalFunction(
    StripifyVirtualStripNC,
    [ IsList ],
    function( list )
        local
            fam,        # Syllable family to which syllables in <list> belong
            sba,        # SB algebra to which syllables in <list> belong
            type,       # Type variable
            zero_sy;    # Zero syllable of <sba>
                    
        fam := FamilyObj( list[1] );
        sba := fam!.sb_alg;
        zero_sy := ZeroSyllableOfSbAlg( sba );
        
        list := [ zero_sy, -1, list[1], 1, list[3], -1, zero_sy, 1 ];
        type := NewType( fam, IsVirtualStripRep );
        return Objectify( type, [ list ] );
    end
);

InstallMethod(
    Display,
    "for a strip rep",
    [ IsStripRep ],
    function( strip )
        local
            data,   # Defining data of <strip>
            k;      # Integer variable
        
        if IsZeroStrip( strip ) then
            Print( "<zero strip>\n" );
        else
            data := strip![1];
            for k in [ 1..Length( data ) ] do
                if IsOddInt( k ) then
                    if data[k+1] = -1 then
                        Print( data[k], "^-1" );
                    elif data[k+1] = 1 then
                        Print( data[k] );
                    fi;
                fi;
            od;
            Print( "\n" );
        fi;
    end
);

InstallMethod(
    ViewObj,
    "for a strip rep",
    [ IsStripRep ],
    function( strip )
        local         
            as_quiv_path,   # Local function that turns a syllable into the 
                            #  <quiv>-path that it represents
            data,           # Defining data of <strip>
            k,              # Integer variable
            sy;             # Syllable variable
            
        if IsZeroStrip( strip ) then
            Print( "<zero strip>" );
        else
        
            # Each syllable of <sba> represents a path of <sba>: this is the
            #  function that will tell you which
            as_quiv_path := function( sy )
                return GroundPathOfOverquiverPathNC(
                 UnderlyingPathOfSyllable( sy )
                 );
                
            end;
            
            # Print the strip so it looks something like
            #      (p1)^-1(q1) (p2)^-1(q2) (p3)^-1(q3) ... (pN)^-1(qN)
            data := strip![1];
            for k in [ 1..Length( data ) ] do
                if IsOddInt( k ) then
                    sy := data[k];
                    Print( "(", as_quiv_path( sy ), ")" );
                    if data[k+1] = -1 then
                        Print( "^-1" );
                    elif (data[k+1] = 1) and (IsBound( data[k+2] )) then
                        Print( " " );
                    fi;
                fi;
            od;
        fi;
    end
);

InstallMethod(
    String,
    "for a strip rep",
    [ IsStripRep ],
    function( strip )
        local         
            as_quiv_path,   # Local function that turns a syllable into the 
                            #  <quiv>-path that it represents
            data,           # Defining data of <strip>
            k,              # Integer variable
            string,         # String variable
            sy;             # Syllable variable
            
        if IsZeroStrip( strip ) then
            return "<zero strip>";
            
        elif IsVirtualStripRep( strip ) then
            return "<virtual strip>";
        
        else
        
            # Each syllable of <sba> represents a path of <sba>: this is the
            #  function that will tell you which
            as_quiv_path := function( sy )
                return GroundPathOfOverquiverPathNC(
                 UnderlyingPathOfSyllable( sy )
                 );
                
            end;
            
            string := "";
            
            # Print the strip so it looks something like
            #      (p1)^-1(q1) (p2)^-1(q2) (p3)^-1(q3) ... (pN)^-1(qN)
            data := strip![1];
            for k in [ 1..Length( data ) ] do
                if IsOddInt( k ) then
                    sy := data[k];
                    Append(
                     string,
                     Concatenation( "(", String( as_quiv_path( sy ) ), ")" )
                     );
                    if data[k+1] = -1 then
                        Append( string, "^-1" );
                    elif (data[k+1] = 1) and (IsBound( data[k+2] )) then
                        Append( string, " " );
                    fi;
                fi;
            od;
            
            return string;
        fi;
    end
);

## +--------------------------------------------------------------------------+
##  CAN THE FOLLOWING BE REMOVED?

# # <Stripify> has several methods. Ultimately, it will delegate to other
# #  functions for all the hard work. Prior to delegation, it must check that its
# #  input is in a legal format.
# # In the first case, it will be given a list of syllables and orientations alt-
# #  -ernately. This list must be nonempty and have even length for starters. The
# #  syllables must alternately be peak and valley neighbours. The only boundary
# #  syllables must appear at the boundary of the string; ie in the leftmost
# #  position (which must have orientation -1) or the rightmost position (orien-
# #  -tation 1). Further, the orientations must be alternately 1 and -1. 

# InstallOtherMethod(
    # Stripify,
    # "for a list, alternately of syllables and their orientations",
    # [ IsList ],
    # function( list )
        # local
            # fam,        # Family of a test syllable
            # indices,    # List variable (for indices of interest)
            # k,          # Index variable
            # len,        # Length of <list>
            # pert,       # Variable for perturbation term of a syllable
            # sublist;    # Particular part of <list> (indexed by <indices>)

        # # We perform some checks on <list> before delegating to the global
        # #  function <StripifyFromSyllablesAndOrientationsNC>, namely verifying
        # #  that <list> has even but nonzero length
        # if IsEmpty( list ) then
            # Info( InfoDebug, 2, "Input list is empty!" );
            # TryNextMethod();
        # elif not IsEvenInt( Length( list ) ) then
            # Info( InfoDebug, 2, "Input list has odd length!" );
            # TryNextMethod();
        # else
            # len := Length( list );
            
            # # Check all entries in odd positions of <list> are syllables, all
            # #  from the same family
            # indices := Filtered( [1..len], IsOddInt );
            # sublist := list{ indices };
            # if false in List( sublist, IsSyllableRep ) then
                # Info( InfoDebug, 2, "Input list contains a non-syllable!" );
                # TryNextMethod();
            # else
                # fam := FamilyObj( sublist[1] );
                # if false in List( sublist, x -> FamilyObj( x ) = fam ) then
                    # Info( InfoDebug, 2, "Input syllable families disagree!" );
                    # TryNextMethod();
                # fi;
            # fi;
            # Info( InfoDebug, 2, "Syllables entered correctly" );
            
            # # Check all entries in even positions of <list> are alternately
            # #  either 1 or -1
            # indices := Filtered( [1..len], IsEvenInt );
            # sublist := list{ indices };
            # if false in List( sublist, x -> ( x in [ 1, -1 ] ) ) then
                # Info( InfoDebug, 2, "Orientations must be 1 or -1!" );
                # TryNextMethod();
            # else
                # for k in [ 1..( Length( sublist ) ) ] do
                    # if IsBound( sublist[k+1] ) then
                        # if sublist[k]*sublist[k+1] <> -1 then
                            # Info( InfoDebug, 2, "Orientations must alternate!"
                             # );
                            # TryNextMethod();
                        # fi;
                    # fi;
                # od;
            # fi;
            # Info( InfoDebug, 2, "Orientations entered correctly" );
            
            # # Check that all pairs
            # #      (p_i)^-1(q_i)
            # #  of consecutive syllables are peak neighbors and all pairs
            # #      (q_i)(p_{i+1})
            # #  are valley neighbours
            # indices := Filtered( [1..len], IsOddInt );
            # for k in indices do
                # if IsBound( list[k+2] ) then
                    # if list[k+1] = -1 then
                        # if ( not
                         # IsPeakCompatiblePairOfSyllables( list[k], list[k+2] )
                         # ) then
                            # Info( InfoDebug, 2, "Peak compatibility failure!");
                            # TryNextMethod();
                        # fi;
                    # elif list[k+1] = 1 then
                        # if ( not
                         # IsValleyCompatiblePairOfSyllables(list[k], list[k+2])
                         # ) then
                            # Info( InfoDebug, 2,
                             # "Valley compatibility failure!" );
                            # TryNextMethod();
                        # fi;
                    # fi;
                # fi;
            # od;
            # Info( InfoDebug, 2, "Peak and valley-compatibility holds!" );
        # fi;

        # # A nonzero syllable must be boundary iff it is either the leftmost
        # #  syllable and has orientation -1 or the rightmost syllable and has
        # #  orientation 1. Check this.
        # indices := Filtered( [1..len], IsOddInt );
        # for k in indices do
            # pert := PerturbationTermOfSyllable( list[k] );
            # if ( k = 1 and list[k+1] = -1 ) or
             # ( k = Maximum( indices ) and list[k+1] = 1 )
             # then
                # if pert = 0 then
                    # Info( InfoDebug, 2, "Interior syllable at boundary!" );
                    # TryNextMethod();
                # fi;
            # else
                # if pert = 1 then
                    # Info( InfoDebug, 2, "Boundary syllable at interior!" );
                # fi;
            # fi;
        # od;
        # Info( InfoDebug, 2, "Interior/boundary syllables appropriate!" );
        
        # # Check for virtual syllables. The only permitted appearance of virtual
        # #  syllables is if <list> looks like
        # #      [ <virtual syllable>, 1, <virtual syllable>, -1 ]
        # indices := Filtered( [1..len], IsOddInt );
        # sublist := list{ indices };
        # if true in List( sublist, IsVirtualSyllable ) then
            # if false in List( sublist, IsVirtualSyllable ) then
                # Info( InfoDebug, 2,
                 # "There are virtual syllables among nonvirtual ones!"
                 # );
            # fi;
            # if Length( sublist ) <> 2 then
                # Info( InfoDebug, 2,
                 # "There are too many virtual syllables!"
                 # );
                # TryNextMethod();
            # fi;
            # if not ( list[2] = 1 and list[4] = -1 ) then
                # Info( InfoDebug, 2,
                 # "These virtual syllables have the wrong orientation!"
                 # );
                # TryNextMethod();
            # fi;
            
            # Info( InfoDebug, 2, "Returning virtual strip" );
            # return StripifyVirtualStripNC( list );
        # fi;
        
        # # All checks are complete; we delegate to another function for the hard
        # #  work!
        # return CallFuncList(
         # StripifyFromSyllablesAndOrientationsNC,
         # list
        # );
    # end
# );

## +--------------------------------------------------------------------------+

InstallMethod(
    Stripify,
    "for an arrow of a special biserial algebra, +/-1 and a list of integers",
    [ IsMultiplicativeElement, IsInt, IsList ],
    function( arr, N, int_list )
        local
            1_sba,      # Unity of <sba>
            a_seq, a_i, # Integer sequence in the source encoding of perm-
                        #  -issible data of <sba>, and its <i>th term
            b_seq, b_i, # Bit sequence in the source encoding of permissible
                        # data of <sba>, and its <i>th term
            c_seq, c_i, # Integer sequence in the target encoding of perm-
                        #  -issible data of <sba>, and its <i>th term
            d_seq, d_i, # Bit sequence in the target encoding of permissible
                        #  data of <sba>, and its <i>th term
            i,          # Vertex variable (to be used when inferring
                        #  <syll_list> from the input
            k,          # Integer variable (indexing entries of <int_list>)
            oarr,       # Arrow of <sba> which represents <arr>
            opath,      # Path variable (for paths in <oquiv>)
            oquiv,      # Overquiver of <sba>
            oquiv_arrs, # Arrows of <oquiv>
            quiv,       # Original quiver of <sba>
            r,          # Integer variable (for entries of <int_list>)
            s,          # Integer variable, either 0 or 1 (depending on whether
                        #  <arr> should point with the first syllable specified
                        #  by <int_list> or against it
            sba,        # SB algebra to which <arr> belongs
            sba_arrs,   # "Arrows" of <sba>
            syll,       # Syllable variable
            syll_list,  # List of syllables, to be inferred from input
            test_alt;   # Local function, testing that the entries of
                        #  <int_list> alternate in sign 
        
        # Write testing function
        test_alt := function( list )
            local
                m;  # Integer variable (indexing the entries of <list>
            
            # Consecutive entries alternate in sign iff their product is
            #  negative
            for m in [ 1 .. ( Length( list ) - 1 ) ] do
                if list[m] * list[m+1] >= 0 then
                    return false;
                fi;
            od;
            
            return true;
        end;
        
        # Name the algebra to which <arr> belongs
        sba := PathAlgebraContainingElement( arr );
        
        # First round of testing on inputs
        if not N in [ 1, -1 ] then
            Error( "The second argument\n", N, "\nshould be 1 or -1!" );
            
        elif not ForAll( int_list, IsInt ) then
            Error( "The third argument\n", int_list,
             "\nshould be a list of integers!" );
             
        elif not test_alt( int_list ) then
            Error( "The entries of the third argument\n", int_list,
            "\nshould alternate in sign!" );
            
        elif not IsSpecialBiserialAlgebra( sba ) then
            Error( "The first argument\n", sba,
             "\nshould be a special biserial algebra!" );
             
        else
            # Test that <arr> is an "arrow" of <sba>
            oquiv := OverquiverOfSbAlg( sba );
            oquiv_arrs := ArrowsOfQuiver( oquiv );
            sba_arrs := List(
             oquiv_arrs,
             SbAlgResidueOfOverquiverPathNC
             );
             
            if not arr in sba_arrs then
                Error( "The first argument\n", arr,
                "\n should be an arrow of a special biserial algebra!" );
                
            else
                # Represent <arr> as an arrow of <oquiv>
                oarr := First(
                 oquiv_arrs,
                 x -> SbAlgResidueOfOverquiverPathNC( x ) = arr
                 );
                
                # If <int_list> is empty, then our task is easy
                if IsEmpty( int_list ) then
                    opath := oarr;
                    syll := Syllabify( oarr, 1 );
                    return StripifyFromSyllablesAndOrientationsNC( syll, N );
                fi;
                
                # Otherwise, <int_list> is nonempty. We construct the syllables
                #  in turn. We'll need the permissible data of <sba>.
                a_seq := SourceEncodingOfPermDataOfSbAlg( sba )[1];
                b_seq := SourceEncodingOfPermDataOfSbAlg( sba )[2];
                c_seq := TargetEncodingOfPermDataOfSbAlg( sba )[1];
                d_seq := TargetEncodingOfPermDataOfSbAlg( sba )[2];
                syll_list := [];
                
                # The first syllable must be constructed with care. We'll
                #  proceed case by case.
                # In the first two cases, the strip begins with an immediate
                #  alternation: ie
                #       o --> o <--<--<-- ...
                #  or
                #       o <-- o -->-->--> ...
                #  Here, the first syllable is really just <oarr>. (We already
                #  know that this is a syllable, as <oarr> has a residue in
                #  <sba>.)
                if N = 1 and int_list[1] < 0 then
                    syll := Syllabify( oarr, 0 );
                    i := ExchangePartnerOfVertex( TargetOfPath( oarr ) );
                    s := 0;
                    
                elif N = -1 and int_list[1] > 0 then
                    syll := Syllabify( oarr, 1 );
                    i := ExchangePartnerOfVertex( SourceOfPath( oarr ) );
                    s := 0;
                
                # In the remaining two cases, <oarr> is the first or last arrow
                #  of some longer equioriented interval in the string: ie
                #       o --> -->-->--> ...
                #  or
                #       o <-- <--<--<-- ...
                #  Here, we must verify that that equioriented interval is not
                #  "too long". (The verifications are mutually dual.)
                # If the verification passes, we create the syllable. This
                #  "uses" up the first entry of <int_list>, which we may sub-
                #  -sequently <Remove>.
                elif N = 1 and int_list[1] > 0 then
                    i := SourceOfPath( oarr );
                    r := int_list[1];
                    a_i := a_seq.( String( i ) );
                    b_i := b_seq.( String( i ) );
                    
                    if r+1 < a_i + b_i then
                        opath := PathBySourceAndLength( i, r+1 );
                        
                        if Length( int_list ) = 1 then
                            syll := Syllabify( opath, 1 );
                            
                        else
                            syll := Syllabify( opath, 0 );
                        fi;
                        
                        Remove( int_list, 1 );
                        i := ExchangePartnerOfVertex( TargetOfPath( opath ) );
                        s := 1;
                        
                    else
                        Error( "The 1st entry of\n", int_list,
                         "\ndoes not specify a valid syllable! ",
                         "(Combining with the first input arrow\n", arr,
                         "\nit made too long a path!)" );
                    fi;
                    
                elif N = -1 and int_list[1] < 0 then
                    i := TargetOfPath( oarr );
                    r := - int_list[1];
                    c_i := c_seq.( String( i ) );
                    d_i := d_seq.( String( i ) );
                    
                    if r+1 < c_i + d_i then
                        opath := PathByTargetAndLength( i, r+1 );
                        syll := Syllabify( opath, 1 );
                        Remove( int_list, 1 );
                        i := ExchangePartnerOfVertex( SourceOfPath( opath ) );
                        s := 1;
                        
                    else
                        Error( "The 1st entry of\n", int_list,
                         "\ndoes not specify a valid syllable! ",
                         "(Combining with first input arrow\n", arr,
                         "\nit made too long a path!)" );
                     fi;
                fi;
                Append( syll_list, [ syll, N ] );
                
                # With the first syllable out of the way, we read along
                #  <int_list> (or what's left of it). For each, we add to the
                #  end of the syllable list, provided that the data do correct-
                #  -ly specify a syllable.
                for k in [ 1 .. Length( int_list ) ] do
                    r := AbsInt( int_list[k] );
                    
                    if int_list[k] > 0 then
                        a_i := a_seq.( String( i ) );
                        b_i := b_seq.( String( i ) );
                        
                        if r < a_i + b_i then
                            opath := PathBySourceAndLength( i, r );
                            
                            if k = Length( int_list ) then
                                syll := Syllabify( opath, 1 );
                                
                            else
                                syll := Syllabify( opath, 0 );
                            fi;
                            i := ExchangePartnerOfVertex(
                             TargetOfPath( opath )
                             );
                            
                        else
                            Error( "The ", Ordinal( k+s ), " entry of\n",
                             int_list, "\ndoes not specify a syllable! ",
                             "(It is too long!)" );
                        fi;
                        
                    else
                        c_i := c_seq.( String( i ) );
                        d_i := d_seq.( String( i ) );
                        
                        if r < c_i + d_i then
                            opath := PathByTargetAndLength( i, r );
                            syll := Syllabify( opath, 0 );
                            i := ExchangePartnerOfVertex(
                             SourceOfPath( opath )
                             );
                            
                        else
                            Error( "The ", Ordinal( k+s ), " entry of\n",
                             int_list, "\ndoes not specify a syllable! ",
                             "(It is too long!)" );
                        fi;
                    fi;
                    Append( syll_list, [ syll, SignInt( int_list[k] ) ] );
                od;
                
                return CallFuncList(
                 StripifyFromSyllablesAndOrientationsNC,
                 syll_list
                 );
            fi;
        fi;
    end
);

InstallOtherMethod(
    Stripify,
    "for a path of a special biserial algebra",
    [ IsMultiplicativeElement ],
    function( path )
        local
            opath,          # Overquiver path that lifts <path>
            opath_list,     # List of nonzero overpaths of <sba>
            perm_data,      # Permissible data of <sba>
            pos,            # Position of <path> in <residue_list>
            residue_list,   # Residues of <opath_list> in <sba>
            sba,            # Special biserial algebra to which <path> belongs
            syll;           # Syllable representing <path>
            
        sba := PathAlgebraContainingElement( path );
        
        # Test input for validity
        if not IsSpecialBiserialAlgebra( sba ) then
            Error( "The input path\n", path,
             "\nmust belong to a special biserial algebra" );
        fi;
        
        perm_data := PermDataOfSbAlg( sba );
        opath_list := perm_data[1];
        residue_list := List(
         opath_list,
         SbAlgResidueOfOverquiverPathNC
         );
         
        if not path in residue_list then
            Error( "The input path\n", path,
             "\nmust have nonzero residue in a special biserial algebra!" );
        fi;
        
        pos := Position( residue_list, path );
        opath := opath_list[ pos ];
        syll := Syllabify( opath, 1 );
        return StripifyFromSyllablesAndOrientationsNC( syll, -1 );
    end
);

# InstallOtherMethod(
    # Stripify,
    # "for a vertex of a special biserial algebra",
    # [ IsMultiplicativeElement ],
    # function( vert )
        # local
            # pos,        # Position of <vert> in <sba_verts>
            # sba,        # SB algebra to which <vert> belongs
            # sba_verts,  # Vertices of <sba>
            # simps;      # List of strips for simple modules of <sba> 
            
        # sba := PathAlgebraContainingElement( vert );
        # sba_verts := ArrowsOfQuiverAlgebra( sba );
        
        # # Test input for validity
        # if not IsSpecialBiserialAlgebra( sba ) then
            # Error( "The input\n", vert,
             # "\nmust belong to a special biserial algebra!" );
             
        # elif not vert in sba_verts then
            # TryNextMethod();

        # # Tests passed. Find position of <vert> in <sba_verts>. Return the
        # #  strip of the corresponding simple module for <sba>.
        # else
            # pos := Position( sba_verts, vert );
            # simps := SimpleStripsOfSbAlg( sba );
            
            # return simps[ pos ];
        # fi;
    # end
# );

# InstallOtherMethod(
    # Stripify,
    # "for an arrow of a special biserial algebra",
    # [ IsMultiplicativeElement ],
    # function( arr )
        # local
            # sba,
            # sba_arrs;
            
        # sba := PathContainingElement( arr );
        # sba_arrs := ArrowsOfQuiverAlgebra( sba );
        
        # # Test input for validity
        # if not IsSpecialBiserialAlgebra( sba ) then
            # Error( "The input\n", arr,
             # "\nmust belong to a special biserial algebra!" );
             
        # elif not arr in sba_arrs then
            # TryNextMethod();
            
        # else
            # return Stripify( arr, -1, [] );
        # fi;
    # end
# );

InstallMethod(
    ZeroStripOfSbAlg,
    "for special biserial algebras",
    [ IsSpecialBiserialAlgebra ],
    function( sba )
        local
            fam,        # Strip family of <sba>
            obj,        # Object variable
            type,       # Type variable
            zero_sy;    # Zero syllable of <sba>
        
        fam := StripFamilyOfSbAlg( sba );
        type := NewType( fam, IsStripRep );
        zero_sy := ZeroSyllableOfSbAlg( sba );
        obj := [ [ zero_sy, -1, zero_sy, 1 ] ];
        
        ObjectifyWithAttributes(
         obj, type,
         IsZeroStrip, true
         );
        
        return obj;
    end
);

InstallMethod(
    IsZeroStrip,
    "for a strip rep",
    [ IsStripRep ],
    function( strip )
        # Zero strips know at creation that they are zero strips. Consequently,
        #  if <strip> is a zero strip, then <HasIsZeroStrip( strip )> will
        #  return <true>. If it doesn't, then <strip> was created without being
        #  a zero strip, and so is not ever going to be one.
        if HasIsZeroStrip( strip ) then
            return IsZeroStrip( strip );
            
        else
            return false;
        fi;
    end
);

InstallMethod(
    SyllableListOfStripNC,
    "for a strip",
    [ IsStripRep ],
    function( strip )
        local
            data,       # Defining data of <strip>
            indices;    # Odd indices of <data>

        data := strip![1];
        indices := Filtered( [1..Length( data )], IsOddInt );
        return data{ indices };
    end
);

InstallMethod(
    SyzygyOfStrip,
    "for a strip",
    [ IsStripRep ],
    function( strip )
        local
            data,       # Underlying data of strip
            indices,    # List variable, for indices of interest
            j, k,       # Integer variables, for indices
            len,        # Length of <data>
            patch,      # Patch variable
            patch_list, # List variable, for patches
            sba,        # SB algebra of which <strip> is a strip
            summands,   # Integer variable
            sy_list,    # Syllable (sub)list of <data>
            syz_list,   # List whose entries are the defining data lists of
                        #  strips
            zero_patch; # Zero patch of <sba>

        if IsZeroStrip( strip ) then
            return [];
        
        else
            sy_list := SyllableListOfStripNC( strip );
            
            # We use <sy_list> to specify a list of patches, sandwiched between
            #  two copies of the zero patch of <sba>.
            
            sba := FamilyObj( strip )!.sb_alg;
            zero_patch := ZeroPatchOfSbAlg( sba );
            patch_list := [ zero_patch ];
            
            indices := [ 1..Length( sy_list ) ];
            for k in indices do
                if IsOddInt( k ) then
                    patch := PatchifyByTop( sy_list[k], sy_list[k+1] );
                    Add( patch_list, patch );
                fi;
            od;
            Add( patch_list, zero_patch );

            # We now read the syzygy strips off of the southern parts of
            #  <patch_list>, separating them at patches of string projectives
            
            syz_list := [ [ ] ];
            j := 1;
            
            for k in [ 2 .. ( Length( patch_list ) - 1 ) ] do
                if IsPatchOfStringProjective( patch_list[k] ) then
                    if not IsZeroSyllable( patch_list[k]!.SW ) then
                        Append( syz_list[j], [ patch_list[k]!.SW, 1 ] );
                    fi;
                    Add( syz_list, [] );
                    j := j + 1;
                    if not IsZeroSyllable( patch_list[k]!.SE ) then
                        Append( syz_list[j], [ patch_list[k]!.SE, -1 ] );
                    fi;
                else
                    if not IsZeroSyllable( patch_list[k]!.SW ) then
                        Append( syz_list[j], [ patch_list[k]!.SW, 1 ] );
                    fi;
                    if not IsZeroSyllable( patch_list[k]!.SE ) then
                        Append( syz_list[j], [ patch_list[k]!.SE, -1 ] );
                    fi;
                fi;
            od;
            
            # Each entry of <syz_list> is a list of syllables and orientations.
            #  If it's empty, remove it. If it gives a virtual strip, make
            #  that virtual strip and then take its syzygy again. If it doesn't
            #  give a virtual strip, <Stripify> it.
            j := 1;
            while j <= Length( syz_list ) do
            
                # If the list is empty, remove it
                if IsEmpty( syz_list[j] ) then
                    Remove( syz_list, j );
                    
                else
                # If the list features virtual syllables, make the associated
                #  virtual strip and then take its syzygy.
                    indices := Filtered(
                     [ 1 .. Length( syz_list[j] ) ],
                     IsOddInt
                     );
                    data := syz_list[j]{ indices };
                    if ForAny( data, IsVirtualSyllable ) then
                        syz_list[j] := StripifyVirtualStripNC( syz_list[j] );
                        syz_list[j] := SyzygyOfStrip( syz_list[j] )[1];
                        
                    else
                        syz_list[j] := CallFuncList(
                         StripifyFromSyllablesAndOrientationsNC,
                         syz_list[j]
                        );
                    fi;
                    j := j + 1;
                fi;
            od;
            
            return Flat( syz_list );
        fi;
    end
);

InstallOtherMethod(
    SyzygyOfStrip,
    "for a list of strips",
    [ IsList ],
    function( list )
        if false in List( list, IsStripRep ) then
            TryNextMethod();
        else
            return Flat( List( list, SyzygyOfStrip ) );
        fi;
    end
);

InstallMethod(
    NthSyzygyOfStrip,
    "for a strip",
    [ IsStripRep, IsInt ],
    function( strip, N )
        local
            k,      # Integer variable (indexing the syzygy to be determined)
            syz;    # Variable to iteratively store syzygies

        if N < 0 then
            Error( "<N> must be a nonnegative integer!" );
        elif N = 0 then
            return strip;
        else
            syz := strip;
            for k in [1..N] do
                Info( InfoDebug, 2, "Calculated ", Ordinal( k ), " syzygy!" );
                syz := SyzygyOfStrip( syz );
            od;
            
            return syz;
        fi;
    end
);

InstallOtherMethod(
    NthSyzygyOfStrip,
    "for a strip",
    [ IsList, IsInt ],
    function( list, N )
        local
            k,      # Integer variable (indexing the syzygy to be determined)
            syz;    # Variable to iteratively store syzygies

        if false in List( list, IsStripRep ) then
            Error( "<list> must be a list of strips!" );
        elif N < 0 then
            Error( "<N> must be a nonnegative integer!" );
        elif N = 0 then
            return list;
        else
            syz := list;
            for k in [1..N] do
                Info( InfoDebug, 2, "Calculated ", Ordinal( k ), " syzygy!" );
                syz := SyzygyOfStrip( syz );
            od;
            
            return syz;
        fi;
    end
);

InstallMethod(
    CollectedSyzygyOfStrip,
    "for a strip-rep",
    [ IsStripRep ],
    function( strip )
        return Collected( SyzygyOfStrip( strip ) );
    end
);

InstallOtherMethod(
    CollectedSyzygyOfStrip,
    "for a list of strip-reps",
    [ IsList ],
    function( list )
        if not ( ForAll( list, IsStripRep ) ) then
            TryNextMethod();
            
        else
            return CollectedSyzygyOfStrip( Collected( list ) );
        fi;
    end
);

InstallOtherMethod(
    CollectedSyzygyOfStrip,
    "for a collected list of strip-reps",
    [ IsList ],
    function( clist )
        local
            # j, k,       # Integer variables
            # list,       # List variable (for object to be returned)
            # syz_list;   # List variable (for list of syzygies)
            entry,      # List variable, for entries of <clist>
            j, k,       # Integer variables, indexing entries of <syz_clist> 
                        #  <clist> respectively 
            list,       # List variable, for storing the output as it is being
                        #  constructed
            mult,       # Integer variable, for multiplicities in <clist>
            strip,      # Strip variable, for strips in <clist>
            syz_clist;  # List variable, for collected syzygies of entries of
                        #  <clist>
            
        if not IsCollectedList( clist ) then
            TryNextMethod();
        
        else
            # Tidy up <clist>
            clist := Recollected( clist );
            
            list := [];

            # Work entry-by-entry of <clist>            
            for k in [ 1 .. Length( clist ) ] do
                entry := clist[k];
                
                # Say each entry is
                #       [ strip, mult ]
                #  We calculate the collected syzygy of <strip> then multiply
                #  all multiplicities by <mult>. That gives us the collected
                #  syzygy of the entry.
                strip := entry[1];
                mult := entry[2];
                syz_clist := CollectedSyzygyOfStrip( strip );
                
                for j in [ 1 .. Length( syz_clist ) ] do
                    syz_clist[j][2] := syz_clist[j][2] * mult;
                od;
                
                # We record this in collected list <syz_clist>
                Append( list, syz_clist );
            od;
            
            # Once the collected syzygies for each entry of <clist> have been
            #  calculated, we tidy up the answer            
            return Recollected( list );
        
            # list := [];
            # for k in [ 1..Length( clist ) ] do
                # syz_list := SyzygyOfStrip( clist[k][1] );
                # for j in [ 1.. clist[k][2] ] do
                    # Append( list, syz_list );
                # od;
            # od;
            
            # return Collected( list );
        fi;
    end
);

InstallMethod(
    CollectedNthSyzygyOfStrip,
    "for a strip and a positive integer",
    [ IsStripRep, IsInt ],
    function( strip, N )
        return CollectedNthSyzygyOfStrip( [ [ strip, 1 ] ], N );
    end
);

InstallOtherMethod(
    CollectedNthSyzygyOfStrip,
    "for a (flat) list and a positive integer",
    [ IsList, IsInt ],
    function( list, N )
        if IsCollectedList( list ) then
            TryNextMethod();
        elif not ForAll( list, IsStripRep ) then
            Error( "The first argument\n", list, "\nmust be a list of strips!"
             );
        else
            return CollectedNthSyzygyOfStrip( Collected( list ), N );
        fi;
    end
);

InstallOtherMethod(
    CollectedNthSyzygyOfStrip,
    "for a collected list and a positive integer",
    [ IsList, IsInt ],
    function( clist, N )
        local
            ans,    # Collected list variable (for the output)
            k;      # Integer variable (for counting up to N)
            
        if not IsCollectedList( clist ) then
            TryNextMethod();
        elif IsPosInt( -N ) then
            Error( "The second argument, ", N, " must be a nonnegative integer"
             );
        elif N = 0 then
            return clist;
        else
            ans := clist;
            for k in [ 1..N ] do
                ans := CollectedSyzygyOfStrip( ans );
            od;
            
            return ans;
        fi;
    end
);

InstallMethod(
    SimpleStripsOfSbAlg,
    "for a special biserial algebra",
    [ IsSpecialBiserialAlgebra ],
    function( sba )
        local
            make_strip, # Local function, that takes an exchange pair of vert-
                        #  -ices of <oquiv> into a simple string
            olift,      # Local function, that lifts a vertex of <quiv> to (a
                        #  list of) vertices of <oquiv>
            oquiv,      # Overquiver of <sba>
            overts,     # Vertices of <oquiv>
            quiv,       # Ground quiver of <sba>
            verts;      # Vertices of <quiv>
            
        if HasSimpleStripsOfSbAlg( sba ) then
            return SimpleStripsOfSbAlg( sba );
        else
            oquiv := OverquiverOfSbAlg( sba );
            overts := VerticesOfQuiver( oquiv );
        
            quiv := QuiverOfPathAlgebra( OriginalPathAlgebra( sba ) );
            verts := VerticesOfQuiver( quiv );
            
            olift := function( v )
                return Filtered(
                 overts,
                 u -> GroundPathOfOverquiverPathNC( u ) = v
                 );
            end;
            
            make_strip := function( x )
                return StripifyFromSyllablesAndOrientationsNC(
                 Syllabify( x[1], 1 ), -1, Syllabify( x[2], 1 ), 1
                 );
            end;
            
            return Immutable( List( verts, v -> make_strip( olift( v ) ) ) );
        fi;
    end
);

InstallMethod(
    ProjectiveStripsOfSbAlg,
    "for a special biserial algebra",
    [ IsSpecialBiserialAlgebra ],
    function( sba )
        local
            a_seq, a_i, a_j,    # Integer sequence in the source encoding of
                                #  permissible data of <sba>, and its <i>th and
                                #  <j>th terms
            b_seq, b_i, b_j,    # Bit sequence in the source encoding of perm-
                                #  -issible data of <sba>, and its <i>th and
                                #  <j>th terms
            i, j,               # Vertex variable (for vertices of <oquiv>)
            k,                  # Integer variable (for indices of <list>
            list,                # List variable (for the output)
            olift,              # Local function, that lifts a vertex of <quiv>
                                #  to (a list of) vertices of <oquiv>
            p, q,               # Path variables
            oquiv,              # Overquiver of <sba>
            overts,             # Vertices of <oquiv>
            quiv;               # Ground quiver of <sba>

        if HasProjectiveStripsOfSbAlg( sba ) then
            return ProjectiveStripsOfSbAlg( sba );
        else
            quiv := QuiverOfPathAlgebra( OriginalPathAlgebra( sba ) );
            list := ShallowCopy( VerticesOfQuiver( quiv ) );

            a_seq := SourceEncodingOfPermDataOfSbAlg( sba )[1];
            b_seq := SourceEncodingOfPermDataOfSbAlg( sba )[2];

            oquiv := OverquiverOfSbAlg( sba );
            overts := VerticesOfQuiver( oquiv );

            olift := function( v )
                return Filtered(
                 overts,
                 u -> GroundPathOfOverquiverPathNC( u ) = v
                 );
            end;
            
            Apply( list, olift );
            
            for k in [ 1..( Length( list ) ) ] do
                i := list[k][1];
                j := list[k][2];
                b_i := b_seq.( String( i ) );
                if b_i = 0 then
                    list[k] := fail;
                else
                    a_i := a_seq.( String( i ) );
                    a_j := a_seq.( String( j ) );
                    b_j := b_seq.( String( j ) );
                    
                    p := Syllabify( PathBySourceAndLength( i, a_i ), 1 );
                    q := Syllabify( PathBySourceAndLength( j, a_j ), 1 );
                    
                    list[k] :=
                     StripifyFromSyllablesAndOrientationsNC( p, -1, q, 1 );
                fi;
            od;
            
            return list;
        fi;
    end
);

InstallMethod(
    InjectiveStripsOfSbAlg,
    "for a special biserial algebra",
    [ IsSpecialBiserialAlgebra ],
    function( sba )
        local
            c_seq, c_i, c_j,    # Integer sequence in the target encoding of
                                #  permissible data of <sba>, and its <i>th and
                                #  <j>th terms
            d_seq, d_i, d_j,    # Bit sequence in the target encoding of perm-
                                #  -issible data of <sba>, and its <i>th and
                                #  <j>th terms
            i, j,               # Vertex variable (for vertices of <oquiv>)
            k,                  # Integer variable (for indices of <list>
            list,               # List variable (for the output)
            olift,              # Local function, that lifts a vertex of <quiv>
                                #  to (a list of) vertices of <oquiv>
            p, q,               # Path/syllable variables
            oquiv,              # Overquiver of <sba>
            overts,             # Vertices of <oquiv>
            quiv;               # Ground quiver of <sba>

        if HasInjectiveStripsOfSbAlg( sba ) then
            return InjectiveStripsOfSbAlg( sba );
        else
            quiv := QuiverOfPathAlgebra( OriginalPathAlgebra( sba ) );
            list := ShallowCopy( VerticesOfQuiver( quiv ) );

            c_seq := TargetEncodingOfPermDataOfSbAlg( sba )[1];
            d_seq := TargetEncodingOfPermDataOfSbAlg( sba )[2];

            oquiv := OverquiverOfSbAlg( sba );
            overts := VerticesOfQuiver( oquiv );

            olift := function( v )
                return Filtered(
                 overts,
                 u -> GroundPathOfOverquiverPathNC( u ) = v
                 );
            end;
            
            Apply( list, olift );
            
            for k in [ 1..( Length( list ) ) ] do
                i := list[k][1];
                j := list[k][2];
                d_i := d_seq.( String( i ) );
                if d_i = 0 then
                    list[k] := fail;
                else
                    c_i := c_seq.( String( i ) );
                    c_j := c_seq.( String( j ) );
                    d_j := d_seq.( String( j ) );
                    
                    p := PathByTargetAndLength( i, c_i );
                    q := PathByTargetAndLength( j, c_j );
                    
                    if ( c_i = 0 and c_j = 0 ) then
                        p := Syllabify( p, 1 );
                        q := Syllabify( q, 1 );
                        list[k] :=
                         StripifyFromSyllablesAndOrientationsNC( p, -1, q, 1 );
                    elif ( c_i > 0 and c_j = 0 ) then
                        p := Syllabify( p, 1 );
                        list[k] :=
                         StripifyFromSyllablesAndOrientationsNC( p, 1 );
                    elif ( c_i = 0 and c_j > 0 ) then
                        q := Syllabify( q, 1 );
                        list[k] :=
                         StripifyFromSyllablesAndOrientationsNC( q, -1 );
                    else
                        p := Syllabify( p, 0 );
                        q := Syllabify( q, 0 );
                        list[k] :=
                         StripifyFromSyllablesAndOrientationsNC( p, 1, q, -1 );
                    fi;
                fi;
            od;
            
            return list;
        fi;
    end
);

InstallMethod(
    WidthOfStrip,
    "for a strip rep",
    [ IsStripRep ],
    function( strip )
        local
            data,       # Defining data of <strip>
            sy_list;    # List of syllables of <strip>
        
        # Once the zero strip of a SB algebra is implemented, <WidthOfStrip>
        #  must return <-infinity> for it.
        
        # Virtual strips have width <-infinity>
        if IsVirtualStripRep( strip ) then
            return -infinity;

        # Remaining strips (neither zero nor virtual) have a nonnegative width,
        #  namely the number of nonstationary syllables they contain.
        else
            sy_list := SyllableListOfStripNC( strip );

            return Number( sy_list, x -> not IsStationarySyllable( x ) );
        fi;
    end
);

InstallOtherMethod(
    \<,
    "for two strip reps",
    \=,
    [ IsStripRep, IsStripRep ],
    function( strip1, strip2 )
        local
            list1, list2,           # Whichever of <sy_list_1> and <sy_list_r1>
                                    #  comes first, ordered lexicographically,
                                    #  and similarly for <sy_list_2> and
                                    #  <sy_list_r2>
            sy_list_1, sy_list_2,   # Syllable lists of <strip1> and <strip2>
            sy_list_r1, sy_list_r2; # Syllable lists of the reflections of
                                    #  <strip1> and <strip2>
                                    
        # In essence, this method is length-lexicographical. The zero strip
        #  is the minimal element, followed by the virtual strips; these extra-
        #  ordinary strips have width <-infinity> so are dealt with separately.
        #  Once they are out of the way, the length-lexicographical ordering
        #  kicks in.

        # We first compare the widths of <strip1> and <strip2>. This will dis-
        #  -tinguish a strip that is zero or virtual from one that is neither.
        if WidthOfStrip( strip1 ) < WidthOfStrip( strip2 ) then
            return true;

        elif WidthOfStrip( strip1 ) > WidthOfStrip( strip2 ) then
            return false;

        # If both of the above fail, <strip1> and <strip2> have the same width.
        else
        
            # If that width is <-infinity> then <strip1> and <strip2> are zero
            #  or virtual. In that case, if one is zero and the other isn't
            #  then the zero strip is less (in the sense of <\<>).
            if IsZeroStrip( strip1 ) and ( not IsZeroStrip( strip2 ) ) then
                return true;
            elif ( not IsZeroStrip( strip1 ) ) and IsZeroStrip( strip2 ) then
                return false;
            elif IsZeroStrip( strip1 ) and IsZeroStrip( strip2 ) then
                return false;

            # If none of the above cases are met, then neither <strip1> nor
            #  <strip2> is a zero strip. In this case, the lexicographical
            #  order we define below will distinguish between strips of the
            #  same width. (This includes width <-infinity>, in which case we
            #  must be distinguishing between virtual strips.)
            else

                # Recall that any strip is equal (ie, \= returns true) to its
                #  reflection. This means that we don't just compare strips, we
                #  compare "reflection"-classes of strips. In practice, we come
                #  up with a "dictionary" version of each strip and use this as
                #  the basis for our comparison. We write out the syllable list
                #  of the strip and write out that of its reflection, compare
                #  the two lexicographically (via the \< ordering on syll-
                #  -ables); whichever of this is least, is the "dictionary"
                #  version of the input strip.
            
                sy_list_1  := SyllableListOfStripNC( strip1 );
                sy_list_r1 := SyllableListOfStripNC(
                 ReflectionOfStrip( strip1 )
                 );
                list1 := Minimum( sy_list_1, sy_list_r1 );

                sy_list_2  := SyllableListOfStripNC( strip2 );
                sy_list_r2 := SyllableListOfStripNC(
                 ReflectionOfStrip( strip2 )
                 );
                list2 := Minimum( sy_list_2, sy_list_r2 );
                
                return list1 < list2;
            fi;
        fi;
    end
);

InstallMethod(
    IsWeaklyPeriodicStripByNthSyzygy,
    "for a strip and a positive integer",
    [ IsStripRep, IsPosInt ],
    function( strip, N )
        local
            found_yet,  # Boolean, storing whether a repeat has been found
            j,          # Integer variable
            syz;        # List variable

        found_yet := false;
        j := 0;
        syz := Set( [ strip ] );
        while found_yet = false and j < N do
            j := j + 1;
            syz := Set( SyzygyOfStrip( syz ) );
            if strip in syz then
                found_yet := true;
                Print( "The given strip appears in its own ", Ordinal( j ),
                 " syzygy\n");
            fi;
        od;
        return found_yet;        
    end
);

InstallMethod(
    IsFiniteSyzygyTypeStripByNthSyzygy,
    "for a strip and a positive integer",
    [ IsStripRep, IsPosInt ],
    function( strip, N )
        local
            j,              # Integer variable, storing which "stage" our cal-
                            #  -culation is at
            new_syz_set,    # Set variable, storing those strips "new" at stage
                            #  <j>
            old_syz_set;    # Set variable, storing those strips "old" at stage
                            #  <j> (ie, seen strictly before)
                            
        # Initialize at stage <0>. At this stage, nothing is "old" and <strip>
        #  is new
        j := 0;
        new_syz_set := Set( [ strip ] );
        old_syz_set := Set( [] );

        # Proceed stage by stage
        while j <= N do
            # Increment the stage number
            j := j + 1;

            # All strips new at the previous stage are old at the current one
            UniteSet( old_syz_set, new_syz_set );

            # Take syzygies of the strips that were new at the previous stage
            new_syz_set := Set( SyzygyOfStrip( new_syz_set ) );

            # Remove from the syzygies the strips that are old at this stage
            SubtractSet( new_syz_set, old_syz_set );

            # Whatever is left is new at this stage. If nothing is new at this
            #  stage, then <strip> has finite syzygy type of degree at most <j>
            #  and we can stop.
            
            if IsEmpty( new_syz_set ) then
                Info( InfoSBStrips, 2, "Examining strip: ", String( strip ) );
                Info( InfoSBStrips, 2, "This strip has finite syzygy type." );
                Info( InfoSBStrips, 2, "The set of strings appearing as ",
                 "summands of its first N syzygies stabilizes at N=",
                 String( j-1 ), ", at which point it has cardinality ",
                 String( Size( old_syz_set ) ) );
                return true;
            fi;
        od;
        
        Info( InfoSBStrips, 2, "Examining strip: ", String( strip ) );
        Info( InfoSBStrips, 2, "The set of strings appearing as summands of ",
         "its first ", String( N ), " syzygies has cardinality ",
         Size( old_syz_set ) );
        return false;
    end
);

InstallGlobalFunction(
    TestInjectiveStripsUpToNthSyzygy,
    "for a SB algebra and a positive integer",
    function( sba, N )
        local
            non_pin_inj_list,   # <inj_list>, with all <fail>s removed
            inj_list,           # The pinjective strips of <sba>
            test_list;          # Results of testing the entries of
                                #  <non_pin_inj_list> up to degree <N>
            
        inj_list := InjectiveStripsOfSbAlg( sba );
        non_pin_inj_list := Filtered( inj_list, x -> not ( x = fail ) );
        test_list := List(
         non_pin_inj_list,
         x -> IsFiniteSyzygyTypeStripByNthSyzygy( x, N )
         );
        
        if false in test_list then
            Print( "The given SB algebra has failed the test.\n" );
        else
            Print( "The given SB algebra has passed the test!\n" );
        fi;
        
        return;
    end
);

InstallMethod(
    ModuleDataOfStrip,
    "for a strip-rep",
    [ IsStripRep ],
    function( strip )
        local
            data,       # Syllable and orientation list in <strip>
            dim_vector, # Dimension vector of the output module
            expand_last_syll, expand_neg_syll, expand_pos_syll,
                        # Local functions which turn syllables into "expanded
                        #  walks"
            expanded,   # Total expanded walk of strip
            field,      # Ground field of <sba>
            gens,       # Arrow-indexed list of matrices corresponding to the
                        #  <field>-linear maps described by <strip>
            get_field,  # Local function that obtains the ground_field of <sba>
            is_nonnull_mat,
                        # Local function, to be used to filter out matrices of
                        #  zeroes from output
            L_data, L_expanded,
                        # Integer variable (for the lengths of <data> and
                        #  <expanded> respectively)
            m,          # Integer variable (for the even indices of <data>)
            matrix_of_arrow,
                        # Local function which turns an arrow of <quiv> into
                        #  a matrix representing a linear map, as specified by
                        #  <expanded>
            one,        # Multiplicative identity of <field>
            quiv,       # Ground quiver of <sba>
            sba,        # SB algebra to which <strip> belongs
            vertex_multiplicity_up_to,
                        # Local function which counts the number of times a
                        #  vertex appears in <expanded> before a given index
            zero;       # Additive identity of <field>
           
        sba := FamilyObj( strip )!.sb_alg;
        quiv := QuiverOfPathAlgebra( OriginalPathAlgebra( sba ) );
        
        # Accessing the components of <sba> is naughty, and may be impacted by
        #  future updates of QPA. I therefore make it clear where the close
        #  dependence lies.
        get_field := function( quiver_algebra )
            return quiver_algebra!.LeftActingDomain;
        end;
        
        field := get_field( sba );
        one := One( field );
        zero := Zero( field );
        
        # Test that input is a "proper" strip
        if IsZeroStrip( strip ) then
            return ZeroModule( sba );

#        elif IsVirtualStrip( strip ) then
#            Error( "Virtual strips do not represent modules!" );
        fi;
        
        # Otherwise, our first (real) step is to unpack the data of <strip>. We
        #  unpack it into a list whose entries are alternately (i) vertices of
        #  the ground quiver and (ii) lists of the form [ arr, N ] for <arr> an
        #  arrow of the ground quiver and <N> either 1 or -1. From this
        #  "expanded walk" <expanded>, creating the associated string module is
        #  straightforward.
        #
        # The "expanded walk" of a given positive syllable
        #
        #          A      B       C
        #       i --> ii --> iii --> iv
        #
        #  looks like
        #
        #       [ i, [A,1], ii, [B,1], iii, [C,1] ]
        #
        #  (notice there's no iv!) while the "expanded walk" of a negative
        #  syllable
        #
        #           C       B      A
        #       iv <-- iii <-- ii <-- i
        #
        #  looks like
        #
        #       [ iv, [C,-1], iii, [B,-1], ii, [A,-1] ]
        #  (notice there's no i!). These are respectively calculated using the
        #  functions <expand_pos_syll> and <expand_neg_syll>.
        #
        # Once the "expanded walk" of each syllable is concatenated, there then
        #  needs to be a "rounding off": that is, we add on the iv or the i, as
        #  appropriate. This is what <expand_last_syll> does.
        
        expand_last_syll := function( syll, N )
            local
                opath,  # Underlying path (in the overquiver) of <syll>
                path;   # Ground path represented by <opath>
                
            opath := UnderlyingPathOfSyllable( syll );
            path := GroundPathOfOverquiverPathNC( opath );
            
            if N = 1 then
                return [ TargetOfPath( path ) ];
                
            else
                return [ SourceOfPath( path ) ];
            fi;
        end;
        
        expand_neg_syll := function( syll )
            local
                a,          # Arrow variable (for entries of <walk>)
                exp_walk,   # "Expanded" version of <walk>
                k,          # Integer variable (indexing the entries of <walk>
                opath,      # Underlying path (in the overquiver) of <syll>
                path,       # Ground path represented by <opath>
                walk;       # Walk of <path>
            
            opath := UnderlyingPathOfSyllable( syll );
            path := GroundPathOfOverquiverPathNC( opath );
            walk := WalkOfPath( path );
            exp_walk := [ ];
            
            # Note that if <walk> is a stationary path, then the following FOR
            #  loop is null            
            for k in [ 1 .. Length( WalkOfPath( path ) ) ] do
                a := walk[k];
                Add( exp_walk, [ a, -1 ] );
                Add( exp_walk, TargetOfPath( a ) );
            od;
            
            # If <walk> is a stationary path, then <ex_walk> has length 1 and
            #  so equals its reverse
            return Reversed( exp_walk );
        end;
        
        expand_pos_syll := function( syll )
            local
                a,          # Arrow variable (for entries of <walk>)
                exp_walk,   # "Expanded" version of <walk>
                k,          # Integer variable (indexing the entries of <walk>
                opath,      # Underlying path (in the overquiver) of <syll>
                path,       # Ground path represented by <opath>
                walk;       # Walk of <path>
                
            opath := UnderlyingPathOfSyllable( syll );
            path := GroundPathOfOverquiverPathNC( opath );
            walk := WalkOfPath( path );
            exp_walk := [];
            
            # Note that if <walk> is a stationary path, then the following FOR
            #  loop is null  
            for k in [ 1 .. Length( WalkOfPath( path ) ) ] do
                a := walk[k];
                Add( exp_walk, SourceOfPath( a ) );
                Add( exp_walk, [ a, 1 ] );
            od;
            
            return exp_walk;
        end;
        
        data := strip![1];
        L_data := Length( data );
        expanded := [];
        
        for m in Filtered( [ 1 .. L_data ], IsEvenInt ) do
            if data[m] = -1 then
                Append( expanded, expand_neg_syll( data[ m-1 ] ) );
                
            else
                Append( expanded, expand_pos_syll( data[ m-1 ] ) );
            fi;
        od;
        
        Append(
         expanded,
         CallFuncList( expand_last_syll, data{ [ L_data - 1, L_data ] } )
         );
        
        # Now, the "expanded walk" is finished. From it, we obtain the
        #  dimension vector and matrices of the desired quiver representation.
        
        # The entries of <expanded> at odd indices constitute a basis for the
        #  resulting module. Therefore, the dimension of the vector space at a
        #  given vertex <v> is the number of times <v> appears in <expanded>.
        #
        # The basis of the resulting module is the coproduct (ie, disjoint
        #  union) of the bases at each vertex, but note that we take the basis
        #  vectors of the module in the order they appear in <expanded>. When
        #  determining which basis vector is sent by a linear map to which
        #  other vector (or rather, concretely, in which position of the
        #  associated matrix to place a <one>), we need to know how many other
        #  basis vector of *that vertex space* have appeared in the order be-
        #  -fore it.
        
        vertex_multiplicity_up_to := function( vertex, index )
            return Number(
             expanded{ [ 1 .. index ] },
             x -> x = vertex
             );
        end;
        
        L_expanded := Length( expanded );
        
        dim_vector := List(
         VerticesOfQuiver( quiv ),
         v -> vertex_multiplicity_up_to( v, L_expanded )
         );
        
        matrix_of_arrow := function( arrow )
            local
                c, r,   # Integer variables (respectively for the column and
                        #  row index of <mat> that needs a <one>
                C, R,   # Integer variables (respectively for the number of
                        #  columns and rows <matrix> must have)
                entry,  # Variable (for the entries of <expanded> at odd
                        #  indices)
                matrix, # Matrix variable, for the matrix of the linear map
                        # associated to <arrow>
                k,      # Integer variable (for the odd indices of <expanded>)
                source, # Source of <arrow>
                target; # Target of <arrow>
            
            source := SourceOfPath( arrow );
            target := TargetOfPath( arrow );
            
            R := vertex_multiplicity_up_to( source, L_expanded );
            C := vertex_multiplicity_up_to( target, L_expanded );
            
            matrix := NullMat( R, C, field );
            
            for k in Filtered( [ 1 .. L_expanded ], IsEvenInt ) do
                entry := expanded[ k ];
                
                if entry[1] = arrow then
                    if entry[2] = 1 then
                        r := vertex_multiplicity_up_to( source, k-1 );
                        c := vertex_multiplicity_up_to( target, k+1 );
                        matrix[r][c] := one;
                        
                    else
                        r := vertex_multiplicity_up_to( source, k+1 );
                        c := vertex_multiplicity_up_to( target, k-1 );
                        matrix[r][c] := one;
                    fi;
                fi;
            od;
            
            return matrix;
        end;
        
        # We only need to tell GAP about matrices of nonzero linear maps. The
        #  following function can detect them.
        is_nonnull_mat := function( mat )
            return not ForAll( Flat( mat ), x -> x = zero );
        end;
        
        # We find the nonzero matrices and tell them to GAP.
        gens := List(
         Filtered(
          ArrowsOfQuiver( quiv ),
          x -> is_nonnull_mat( matrix_of_arrow( x ) )
          ),
         x -> [ String( x ), matrix_of_arrow( x ) ]
         );
         
        return Immutable( [ sba, dim_vector, gens ] );
    end
);

InstallMethod(
    ModuleOfStrip,
    "for strip-reps",
    [ IsStripRep ],
    function( strip )
        local
            get_sba,    # Local function that obtains <sba> from <strip>
            sba;        # SB algebra to which <strip> belongs

        if IsZeroStrip( strip ) then
            # Accessing the components of <strip> is naughty, and may be
            #  impacted by future changes to how this information is stored.
            #  To minimise possible impact, I concentrate all the naughty
            #  access into one local function.
            
            get_sba := function( s )
                return FamilyObj( s )!.sb_alg;
            end;
            
            sba := get_sba( strip );
        
            return ZeroModule( sba );
            
        else
            return CallFuncList(
             RightModuleOverPathAlgebra,
             ModuleDataOfStrip( strip )
             );
        fi;
     end
);