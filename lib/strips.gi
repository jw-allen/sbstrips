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

InstallGlobalFunction(
    StripifyFromSyllablesAndOrientationsNC,
    "for a list of syllables and alternating orientations,
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
        sba := SbAlgebraOfSyllable( arg[1] );
        
        # This is an NC function, so we can assume that the arguments are
        #      sy1, or1, sy2, or2, sy3, or3, ..., syN, orN
        #  where [ sy1, sy2, sy3, ..., syN ] are alternately peak- and valley-
        #  neighbour syllables and [ or1, or2, or3, ..., orN ] are alternately
        #  -1 and 1.
        
        # First, we normalize. This means putting a stationary trivial syllable
        #  with orientation -1 at the start and one with orientation 1 at the
        #  end if necessary and calling the function again
        
        if arg[2] <> -1 then
            norm_sy := SidestepFunctionOfSbAlg( arg[1] );
            norm_arg := Concatenation( [ norm_sy, -1 ], arg );
            return StripifyFromSyllablesAndOrientationsNC( norm_arg );
        elif arg[ len ] <> 1 then
            norm_sy := SidestepFunctionOfSbAlg( arg[ len - 1 ] );
            norm_arg := Concatenation( arg, [ norm_sy, 1 ] );
            return StripifyFromSyllablesAndOrientationsNC( norm_arg );
        fi;
        
        # Now we create the <IsStripRep> object.
        
        data := arg;
        fam := StripFamilyOfSbAlg( sba );
        type := NewType( fam, IsStripRep );
        
        Objectify( type, [ data ] );
        
        return data;
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
            k,          # Integer variable (for entries of <left_list> or
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
        
        # First, we normalise. If <left_list> has a last entry <l1> that is
        #  negative and/or <right_list> has a first entry <r1> that is pos-
        #  -itive, then we "absorb" them both into <over_path>, remove them
        #  from their respective lists, and call the function again.
        # (We need to be careful as <left_list> or <right_list> may be empty.
        
        if Length( left_list ) > 0 then
            l := left_list[ Length( left_list ) ]
            if l < 0 then
                i := TargetOfPath( over_path );
                len := LengthOfPath( over_path );
                over_path := PathByTargetAndLength( i, len - l );

                path := ret( cont( over_path ) )*1_sba;
                left_list := left_list{ [ 1..( Length( left_list ) - 1 ) ] };
                return StripifyFromSbAlgPathNC( left_list, path, right_list );
            fi;
        elif Length( right_list ) > 0 then
            r := right_list[1];
            if r > 0
                i := SourceOfPath( over_path );
                len := LengthOfPath( over_path );
                over_path := PathBySourceAndLength( i, len+l );
                
                path := ret( cont( over_path ) )*1_sba;
                right_list := right_list{ [ 2..( Length( right_list ) ) ] };
                return StripifyFromSbAlgPathNC( left_list, path, right_list  );
            fi;
        fi;
        
        # Now <left_list> is either empty or ends in a positive integer, and
        #  <right_list> is either empty or begins with a negative integer. We
        #  can turn the input into a syllable-and-orientation list to be
        #  handled by <StripifyFromSyllablesAndOrientationsNC>.
        
        list := [ overpath, 1 ]

        # Develop <list> on the right
        i := ExchangePartnerOfVertex( TargetOfPath( overpath ) );
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
        i := ExchangePartnerOfVertex( SourceOfPath( overpath ) );
        for k in [ 1..Length( left_list ) ] do
            if Reversed( left_list )[k] < 0 then
                p := PathByTargetAndLength( i, -( Reversed( left_list )[k] ) );
                list := Concatenation( [p, 1], list );
                i := ExchangePartnerOfVertex( SourceOfPath( p ) );
            elif Reversed( left_list )[k] > 0 then
                p := PathBySourceAndLength( i, Reversed( left_list )[k] ) );
                i := ExchangePartnerOfVertex( TargetOfPath( p ) );
            fi;
        od;
        
        # Pass <list> to StripifyFromSyllablesAndOrientationsNC
        return StripifyFromSyllablesAndOrientationsNC( list );
    end
);

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
