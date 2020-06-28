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
    Syllabify,
    "for an overquiver path, a bit and a special biserial algebra",
    [ IsPath, IsInt, IsSpecialBiserialAlgebra ],
    function( path, perturb, sba )
        local
            data,   # 
            fam,    # Syllable family of <sba>
            oquiv,  # Overquiver of <sba>

        oquiv := OverquiverOfSbAlg( sba );
        if not ( path in oquiv ) then
            Error( "The given path\n", path, "\ndoes not belong to the",
             " overquiver of the given special biserial algebra\n", sba );
         elif not ( path in LinIndOfSbAlg( sba ) ) then
            Error( "The given path\n", path, "\ndoes not have linearly",
             " independent residue in the given special biserial algebra\n",
             sba );
         elif not ( perturb in [ 0, 1 ] ) then
            Error( "The given perturbation term, ", perturb, ", is neither 0",
             " nor 1 (integers)! If you mean the zero syllable, then use the",
             " boolean <fail>." );
         else
            fam := SyllableFamilyOfSbAlg( sba );
            data := rec(
             path := path,
             perturbation := perturb,
             sb_alg := sba
            );

            return Immutable( Objectify( fam, data ) );
         fi;
    end
);

InstallOtherMethod(
    Syllabify,
    "for an overquiver path and a perturbation term",
    [ IsPath, IsInt ],
    function( path, perturb )
        local
            oquiv,  # Quiver variable
            sba;    # Algebra variable

        oquiv := QuiverContainingPath( path );
        if not IsOverquiver( oquiv ) then
            Error( "The given path\n", path, "\nmust belong to an overquiver",
             " of a special biserial algebra!" );
        else
            oquiv := QuiverContainingPath( path );
            sba := SbAlgOfOverquiver( oquiv );
            
            return Syllabify( path, perturb, sba );
        fi;
    end
);

InstallOtherMethod(
    Syllabify,
    "for a zero path, the <fail> boolean and a special biserial algebra",
    [ IsPath, IsBool, IsSpecialBiserialAlgebra ],
    function( path, bool, sba )
        local
            ;   # adas
        asdasdas
    end
);

#########1#########2#########3#########4#########5#########6#########7#########
