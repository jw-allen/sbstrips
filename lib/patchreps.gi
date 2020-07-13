InstallMethod(
    PatchFamilyOfSbAlg,
    "for special biserial algebras",
    [ IsSpecialBiserialAlgebra ],
    function( sba )
        local
            fam;    # Family variable

        if HasPatchFamilyOfSbAlg( sba ) then
            return PatchFamilyOfSbAlg( sba );
        else
            fam := NewFamily( "PatchFamilyForSbAlg" );
            fam!.sb_alg := sba;
            
            return fam;
        fi;
    end
);

InstallOtherMethod(
    \=,
    "for patch reps",
    \=,
    [ IsPatchRep, IsPatchRep ],
    function( patch1, patch2 )
        local
            tuple1, tuple2; # Data of <patch1> and <patch2>
            
        # Patches are equal iff they comprise the same data in the same places
        tuple1 := [ patch1!.NW, patch1!.NE, patch1!.SW, patch1!.SE ];
        tuple2 := [ patch2!.NW, patch2!.NE, patch2!.SW, patch2!.SE ];

        return tuple1 = tuple2;
    end
);

InstallOtherMethod(
    \<,
    "for patch reps",
    \=,
    [ IsPatchRep, IsPatchRep ],
    function( patch1, patch2)
        local
            tuple1, tuple2; # Data of <patch1> and <patch2>

        # Patches can be ordered lexicographically by their underlying data
        tuple1 := [ patch1!.NW, patch1!.NE, patch1!.SW, patch1!.SE ];
        tuple2 := [ patch2!.NW, patch2!.NE, patch2!.SW, patch2!.SE ];
        
        return tuple1 < tuple2;
    end
);

#########1#########2#########3#########4#########5#########6#########7#########
