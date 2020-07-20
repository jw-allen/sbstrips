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
        
        # <sy_list> and <ori_list> need to be reversed individually and then
        #  interwoven
        sy_list := Reversed( sy_list );
        ori_list := Reversed( ori_list );
        
        list := [1..l];
        for k in list do
            if IsOddInt( k ) then
                list[ k ] := sy_list[ Floor( k/2 ) ];
            elif IsEvenInt( k ) then
                list[ k ] := ori_list[ Floor( k/2 ) ];
            fi;
        od;
        
        return list;
    end
);

InstallMethod(
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
            
            Info( InfoDebug, 1, "Normalising on left, calling again..." );
            
            return CallFuncList(
            StripifyFromSyllablesAndOrientationsNC,
             norm_arg
             );
        elif arg[ len ] <> 1 then
            norm_sy := SidestepFunctionOfSbAlg( sba )( arg[ len - 1 ] );
            norm_arg := Concatenation( arg, [ norm_sy, 1 ] );
            
            Info( InfoDebug, 1, "Normalising on right, calling again..." );
            
            return CallFuncList(
            StripifyFromSyllablesAndOrientationsNC,
             norm_arg
             );
        fi;
        
        # Now we create the <IsStripRep> object.
        
        Info( InfoDebug, 1, "no normalisation needed, creating object..." );
        
        data := arg;
        fam := StripFamilyOfSbAlg( sba );
        type := NewType( fam, IsStripRep );
        
        return Objectify( type, [ data ] );
    end
);

InstallGlobalFunction(
    StripifyFromSbAlgPathNC,
    "for a nonstationary path in an SB algebra between two lists of integers",
    function( left_list, path, right_list )
        local
            1_sba,      # Multiplicative unit of <sba>
            2reg,       # 2-regular augmention of <quiv>
            cont,       # Contraction of <oquiv> (function <oquiv> --> <2reg>)
            i,          # Vertex variable (for source/target of a path)
            k, l, r,    # Integer variable (for entries of <left_list> or
                        #  <right_list>)
            len,        # Integer variable (for length of a path)
            linind,     # Set of <oquiv> paths with linearly independent res-
                        #  -idue in <sba>
            list,       # List variable, to store syllables and orientations
            matches,    # List of paths in <lin_ind> that lift <path>
            oquiv,      # Overquiver of <sba>
            over_path,  # Lift <path> to overquiver
            p,          # Path variable
            quiv,       # Ground quiver of <sba>
            ret,        # Retraction of <2reg> (function <2reg> --> <quiv> )
            sba;        # SB algebra to which <path> belongs
        
        sba := PathAlgebraContainingElement( path );
        1_sba := One( sba );
        
        quiv := QuiverOfPathAlgebra( OriginalPathAlgebra( sba ) );
        2reg := 2RegAugmentationOfQuiver( quiv );
        ret := RetractionOf2RegAugmentation( 2reg );
        oquiv := OverquiverOfSbAlg( sba );
        cont := ContractionOfOverquiver( oquiv );

        linind := LinIndOfSbAlg( sba );
        
        # Find the path <over_path> in <oquiv> whose <sba>-residue is <path>.
        #  (Recall that entries of <linind> are paths in <oquiv>. Applying
        #  <cont> and then <ret> turns them into entries of <quiv>. Multiplying
        #  by <1_sba> subsequently makes elements of <sba>.)
        matches := Filtered( linind, x -> ( 1_sba * ret( cont( x ) ) ) = path );
        if Length( matches ) <> 1 then
            Error( "I cannot find an overquiver path that lifts the given \
             path ", path, "! Contact the maintainer of the sbstrips package."
             );
        else
            over_path := matches[1];
        fi;

#########1#########2#########3#########4#########5#########6#########7#########
        # First, we normalise. If <left_list> has a last entry that is negative
        #  and/or <right_list> has a first entry that is positive, then we
        #  "absorb" those entries into <over_path>, remove them from their res-
        #  -pective lists, and call the function again.
        # (We need to be careful as <left_list> or <right_list> may be empty.
        
        if Length( left_list ) > 0 then
            l := left_list[ Length( left_list ) ];
            if l < 0 then
                i := TargetOfPath( over_path );
                len := LengthOfPath( over_path );
                over_path := PathByTargetAndLength( i, len - l );

                path := ret( cont( over_path ) )*1_sba;
                left_list := left_list{ [ 1..( Length( left_list ) - 1 ) ] };
                return StripifyFromSbAlgPathNC( left_list, path, right_list );
            fi;
        fi;
        
        if Length( right_list ) > 0 then
            r := right_list[1];
            if r > 0 then
                i := SourceOfPath( over_path );
                len := LengthOfPath( over_path );
                over_path := PathBySourceAndLength( i, len+r );
                
                path := ret( cont( over_path ) )*1_sba;
                right_list := right_list{ [ 2..( Length( right_list ) ) ] };
                return StripifyFromSbAlgPathNC( left_list, path, right_list  );
            fi;
        fi;
        
        # Now <left_list> is either empty or ends in a positive integer, and
        #  <right_list> is either empty or begins with a negative integer. We
        #  can turn the input into a syllable-and-orientation list to be
        #  handled by <StripifyFromSyllablesAndOrientationsNC>.
        
        list := [ over_path, 1 ];

        # Develop <list> on the right
        i := ExchangePartnerOfVertex( TargetOfPath( over_path ) );
        for k in [ 1..Length( right_list ) ] do
            if right_list[k] < 0 then
                p := PathByTargetAndLength( i, -( right_list[k] ) );
                list := Concatenation( list, [ p, -1 ] );
                i := ExchangePartnerOfVertex( SourceOfPath( p ) );
            elif
                right_list[k] > 0 then
                p := PathBySourceAndLength( i, right_list[k] );
                list := Concatenation( list, [ p, 1 ] );
                i := ExchangePartnerOfVertex( TargetOfPath( p ) );
            fi;
        od;
        
        # Develop <list> on the left
        i := ExchangePartnerOfVertex( SourceOfPath( over_path ) );
        for k in [ 1..Length( left_list ) ] do
            if Reversed( left_list )[k] < 0 then
                p := PathByTargetAndLength( i, -( Reversed( left_list )[k] ) );
                list := Concatenation( [p, 1], list );
                i := ExchangePartnerOfVertex( SourceOfPath( p ) );
            elif Reversed( left_list )[k] > 0 then
                p := PathBySourceAndLength( i, Reversed( left_list )[k] );
                list := Concatenation( [p, - 1], list );
                i := ExchangePartnerOfVertex( TargetOfPath( p ) );
            fi;
        od;

        # This gives a list paths in <oquiv> and orientations. Now we turn each
        #  path into a syllable. Almost all syllables are interior (ie, have
        #  pertubation term 0). The only exceptions are: the first syllable
        #  only if its orientation is -1 and; the last syllable only if its
        #  orientation is 1.
        for k in [ 1..Length( list ) ] do
            if IsOddInt( k ) then
                if ( (k = 1) and (list[k+1] = -1) ) then
                    list[k] := Syllabify( list[k], 1 );
                elif ( (k+1 = Length( list )) and (list[k+1] = 1) ) then
                    list[k] := Syllabify( list[k], 1 );
                else
                    list[k] := Syllabify( list[k], 0 );
                fi;
            fi;
        od;
        
        # Pass <list> to StripifyFromSyllablesAndOrientationsNC
        return CallFuncList(
         StripifyFromSyllablesAndOrientationsNC,
         list
         );
    end
);

#####
##### TESTED UP TO HERE IN GAP
#####

InstallGlobalFunction(
    Stripify,
    "for a list, alternately of syllables and their orientations",
    [ IsList ],
    function( list )
        local
            fam,        # Family of a test syllable
            indices,    # List of
            k,          # Index variable
            len,        # Length of <list>
            sublist;    # Particular part of <list>

        # We perform some checks on <list> before delegating to the global
        #  function <StripifyFromSyllablesAndOrientationsNC>
        if IsEmpty( list ) then
            TryNextMethod();
        elif not IsEvenInt( Length( list ) ) then
            TryNextMethod();
        else
            len := Length( list );
            
            # Check all entries in odd positions of <list> are syllables, all
            #  from the same family
            indices := List( [1..len], IsOddInt );
            sublist := list{ indices };
            if false in List( sublist, IsSyllableRep ) then
                TryNextMethod();
            else
                fam := FamilyObj( ( sublist )[1] );
                if false in List( sublist, x -> FamilyObj( x ) = fam ) then
                    TryNextMethod();
                fi;
            fi;
            
            # Check all entries in even positions of <list> are alternately
            #  either 1 or -1
            indices := List( [1..len], x -> IsEvenInt );
            sublist := list{ indices };
            if false in List( sublist, x -> ( x in [ 1, -1 ] ) ) then
                TryNextMethod();
            else
                for k in [ 1..( Length( sublist ) ) ] do
                    if IsBound( sublist[k+1] ) then
                        if sublist[k]*sublist[k+1] <> -1 then
                            TryNextMethod();
                        fi;
                    fi;
                od;
            fi;
            
            # PICK UP FROM HERE!
            #  NEXT CHECK: PEAK AND VALLEY COMPATIBILITY!
        fi;
        
    end
);

#########1#########2#########3#########4#########5#########6#########7#########
