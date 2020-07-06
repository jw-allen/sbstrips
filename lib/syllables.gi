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

InstallMethod(
    ZeroSyllableOfSbAlg,
    "for special biserial algebras",
    [ IsSpecialBiserialAlgebra ],
    function( sba )
        local
            data,       # Record of data for output syllable
            type,       # Syllable type
            zero_path;  # Zero path of the overquiver of <sba>

        if HasZeroSyllableOfSbAlg( sba ) then
            return ZeroSyllableOfSbAlg( sba );
        else
            zero_path := Zero( OverquiverOfSbAlg( sba ) );
            type := NewType(
             SyllableFamilyOfSbAlg( sba ),
             IsComponentObjectRep and IsSyllableRep );
            data := rec(
             path := zero_path,
             perturbation := fail,
             sb_alg := sba
            );

            ObjectifyWithAttributes( data, type,
             IsZeroSyllable, true );
             
            return Immutable( data );
        fi;
    end
);

InstallOtherMethod(
    Syllabify,
    "for a zero path, the <fail> boolean and a special biserial algebra",
    [ IsZeroPath, IsBool, IsSpecialBiserialAlgebra ],
    function( zero, bool, sba )
        local
            oquiv;  # Overquiver of <sba>
        
        oquiv := QuiverContainingPath( zero )
        if not IsOverquiver( oquiv ) then
            Error( "The given zero path\n", zero, "\nmust belong to an \
             overquiver of a special biserial algebra!" );
        elif not ( bool = fail ) then
            Error( "The perturbation term of a zero path must be <fail>!" );
        else
            return ZeroSyllableOfSbAlg( sba );
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
            type;   # Type

        oquiv := OverquiverOfSbAlg( sba );
        if not ( path in oquiv ) then
            Error( "The given path\n", path, "\ndoes not belong to the \
             overquiver of the given special biserial algebra\n", sba );
         elif not ( path in LinIndOfSbAlg( sba ) ) then
            Error( "The given path\n", path, "\ndoes not have linearly \
             independent residue in the given special biserial algebra\n",
             sba );
         elif not ( perturb in [ 0, 1 ] ) then
            Error( "The given perturbation term, ", perturb, ", is neither 0 \
             nor 1 (integers)! If you mean the zero syllable, then use the \
             boolean <fail>." );
         else
            fam := SyllableFamilyOfSbAlg( sba );
            type := NewType( fam, IsComponentObjRep and IsSyllableRep );
            data := rec(
             path := path,
             perturbation := perturb,
             sb_alg := sba
            );

            ObjectifyWithAttributes( data, type,
             IsZeroSyllable, false );

            return Immutable( data );
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
            Error( "The given path\n", path, "\nmust belong to an overquiver \
             of a special biserial algebra!" );
        else
            sba := SbAlgOfOverquiver( oquiv );
            
            return Syllabify( path, perturb, sba );
        fi;
    end
);

InstallMethod(
    Display,
    "for zero syllables",
    [ IsZeroSyllable ],
    function( sy )
        ViewObj( sy );
        Print( "sb algebra := ", SbAlgOfSyllable( sy ), "\n" );
    end
);

InstallMethod(
    Display,
    "for nonzerosyllables",
    [ IsSyllableRep ],
    function( sy )
        ViewObj( sy );
        Print( "underlying path := ", sy!.path, ",\n" );
        Print( "perturbation term  := ", sy!.perturbation, ",\n" );
        Print( "sb algebra := ", SbAlgOfSyllable( sy ), "\n" );
    end
);

InstallMethod(
    ViewObj,
    "for syllables",
    [ IsSyllableRep ],
    function( sy )
        Print( "<" );
        if IsZeroSyllable( sy ) then
            Print( "zero" );
        elif IsStableSyllable( sy ) then
            Print( "stable" );
        else
            Print( "unstable" );
        fi;
        Print( " syllable for special biserial algebra>\n" );
    end
);

#InstallMethod(
#    PrintObj,
#    "for zero syllables",
#    [ IsZeroSyllable ],
#    function( sy )
#        Syllabify(  )
#    end
#);

InstallMethod(
    SbAlgOfSyllable,
    "for syllables",
    [ IsSyllableRep ]
    function( sy )
        return sy!.sb_alg;
    end
);

InstallMethod(
    IsStableSyllable,
    "for syllables",
    [ IsSyllableRep ],
    function( sy )
        if HasIsStableSyllable( sy ) then
            return IsStableSyllable( sy );
        else
            if IsZeroSyllable( sy ) then
                return fail;
            elif sy!.perturbation = 0 then
                return true;
            else
                return false;
            fi;
        fi;
    end
);

InstallMethod(
    DescentFunctionOfSbAlg,
    "for special biserial algebras",
    [ IsSpecialBiserialAlgebra ],
    function( sba )
        local
            desc;       # Function variable
            
        if HasDescentFunctionOfSbAlg( sba ) then
            return DescentFunctionOfSbAlg( sba );
            
        else
            desc := function( sy )
                local
 
                    a_seq, b_seq,   # Integer and bit sequences of <source_enc>
                    a_i1, b_i1,     # <i1>th terms of <a_seq> and <b_seq>
                    a_i2, b_i2,     # <i2>th terms of <a_seq> and <b_seq>
                    ep1, ep2,       # Bit variables
                    i1, i2,         # Vertex variables
                    l1, l2,         # Integer variable
                    oquiv,          # Overquiver of <sba>
                    path,           # Underlying path of <sy>
                    source_enc;     # Source encoding of permissible data of
                                    #  <sba>

                if not SbAlgOfSyllable( sy ) = sba then
                    Error( "The given syllable\n", sy, "\ndoes not belong to \
                     the special biserial algebra\n", sba );

                elif IsZeroSyllable( sy ) then
                    return ZeroSyllableOfSbAlg( sba );

                else
                    oquiv := OverquiverOfSbAlg( sba );
                    source_enc := SourceEncodingOfPermDataOfSbAlg( sba );
                    a_seq := source_enc[1];
                    b_seq := source_enc[2];
                    
                    path := sy!.path;
                    i1 := SourceOfPath( path );
                    l1 := LengthOfPath( path );
                    ep1 := sy!.perturbation;
                    
                    a_i1 := a_seq
                    
                fi
            end;
        fi;
    end
);


