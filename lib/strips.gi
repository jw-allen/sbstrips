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

#########1#########2#########3#########4#########5#########6#########7#########
