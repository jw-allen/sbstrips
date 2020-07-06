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
