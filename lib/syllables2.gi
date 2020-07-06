InstallMethod(
    SyllableFamilyOfSbAlg,
    "for a special biserial algebra",
    [ IsSpecialBiserialAlgebra ],
    function( sba )
        local
            fam;    #

        if HasSyllableFamilyOfSbAlg( sba ) then
            return SyllableFamilyOfSbAlg( sba );
        else
            fam := NewFamily( "SyllableFamilyForSbAlg" );
            fam!.sb_alg := sba;
            
            return fam;
        fi;
    end
);

InstallMethod(
    \=,
    "for syllables",
    =,
    [ IsSyllableRep, IsSyllableRep ],
    function( sy1, sy2 )
        if ( sy1!.path = sy2!.path and
         sy1!.perturbation = sy2!.perturbation and
         sy1!.sb_alg = sy2!.sb_alg ) then
            return true;
        else
            return false;
        fi;
    end
);

InstallMethod(
    \<,
    "for syllables",
    =,
    [ IsSyllableRep, IsSyllableRep ],
    function( sy1, sy2 )
        local
            ep1, ep2,       # Perturbation terms of <sy1> and <sy2>
            i1, i2,         # Sources of <path1> and <path2>
            len1, len2,     # Lengths of <path1> and <path2>
            path1, path2;   # Underlying paths of <sy1> and <sy2>
           
        # The zero syllable is the <-minimal syllable
        if IsZeroSyllable( sy1 ) and ( not IsZeroSyllable(sy2) ) then
            return true;
        elif ( not IsZeroSyllable(sy1) ) and IsZeroSyllable( sy2 ) then
            return false;
            
        # The order is strict, not reflexive
        elif sy1 = sy2 then
            return false;
            
        # If all of the above fails, then we are dealing with distinct
        #  syllables from the same SB algebra, neither of which are the zero 
        #  syllable. In this case, we construct a tuple of data for each
        #  syllable and compare the tuples lexicographically.
        else
            path1 := sy1!.path;
            path2 := sy2!.path;
            i1 := SourceOfPath( path1 );
            i2 := SourceOfPath( path2 );
            len1 := LengthOfPath( path1 );
            len2 := LengthOfPath( path2 );
            ep1 := sy1!.perturbation;
            ep2 := sy2!.perturbation;
            
            return [ i1, len1, ep1 ] < [ i2, len2, ep2 ];
        fi;
);

#########1#########2#########3#########4#########5#########6#########7#########
