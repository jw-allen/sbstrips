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
    function( patch1, patch2 )
        local
            tuple1, tuple2; # Data of <patch1> and <patch2>

        # Patches can be ordered lexicographically by their underlying data
        tuple1 := [ patch1!.NW, patch1!.NE, patch1!.SW, patch1!.SE ];
        tuple2 := [ patch2!.NW, patch2!.NE, patch2!.SW, patch2!.SE ];
        
        return tuple1 < tuple2;
    end
);

InstallMethod(
    PatchSetOfSbAlg,
    "for special biserial algebras",
    [ IsSpecialBiserialAlgebra ],
    function( sba )
        local
            i,          # Vertex variable
            n1_sy, n2_sy, s1_sy, s2_sy,
                        # Syllable variables: 'n' = north, 's' = south
            obj,        # Object to be made into a patch, or defining data
                        #  thereof
            oquiv,      # Overquiver of <sba>
            set,        # Set variables
            type,       # Type variable 
            zero_sy;    # Zero syllable of <sba>

        if HasPatchSetOfSbAlg( sba ) then
            return PatchSetOfSbAlg( sba );
        else
            type := NewType(
             PatchFamilyOfSbAlg( sba ),
             IsComponentObjectRep and IsPatchRep
             );

            oquiv := OverquiverOfSbAlg( sba );
            zero_sy := ZeroSyllableOfSbAlg( sba );

            # Create zero patch. This is the only patch to have both "northern"
            #  components feature <zero_sy>

            obj := rec(
             NW := zero_sy, NE := zero_sy, SW := zero_sy, SE := zero_sy
             );
            ObjectifyWithAttributes(
             obj, type,
             IsZeroPatch, true,
             IsPatchOfStringProjective, false,
             IsPatchOfPinModule, false,
             IsVirtualPatch, false
             );

            # Create the "virtual" patches. These correspond to targets of
            #  (overquiver representatives of) components of commuativity
            #  relations. On one side (east or west), these have as northern
            #  component a virtual syllable (ie, a syllable with source/
            #  length/perturbation tuple [i,0,0] for some target i of a commu-
            #  -tativity rel) and as southern component the associated trivial
            #  syllable (ie, [i,0,1]) as southern component. On the other side,
            #  both components are <zero_sy>

            for i in Filtered(
             VerticesOfQuiver( oquiv ),
             IsRepresentativeOfCommuRelTarget
             )
             do
                n1_sy := Syllabify( PathBySourceAndLength( i, 0 ), 0 );
                s1_sy := Syllabify( PathBySourceAndLength( i, 0 ), 1 );
                n2_sy := zero_sy;
                s2_sy := zero_sy;
            od;


            # Create the patches that have exactly one "northern" component
            #  feature <zero_sy>. These syllables can be constructed by
            #  replacing a single trivial syllable (ie, a syllable whose
            #  source/length/pertubation tuple is [i,0,1] for some vertex i) in
            #  a northern component by <zero_sy>

#########1#########2#########3#########4#########5#########6#########7#########
        fi;
    end
);

#########1#########2#########3#########4#########5#########6#########7#########
