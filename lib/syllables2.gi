InstallMethod(
    SyllableFamilyOfSbAlg,
    "for a special biserial algebra",
    [ IsSpecialBiserialAlgebra ],
    function( sba )
        local
            fam;    # Family variable

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

InstallMethod(
    SyllableSetOfSbAlg,
    "for special biserial algebras",
    [ IsSpecialBiserialAlgebra ],
    function( sba )
        local
            a_i, b_i,       # <i>th terms of <a_seq> and <b_seq>
            a_seq, b_seq,   # Integer and bit sequences of <source_enc>
            ep,             # Bit variable for perturbation
            i,              # Vertex variable
            l,              # Length variable
            obj,            # Object to be made into a syllable, or data therof
            oquiv,          # Overquiver of <sba>
            set,            # List variable
            source_enc,     # Source encoding of permissible data of <sba>
            type;           # Type variable

        if HasSyllableSetOfSbAlg( sba ) then
            return SyllableSetOfSbAlg( sba );
        else
            oquiv := OverquiverOfSbAlg( sba );
            type := NewType(
             SyllableFamilyOfSbAlg( sba ),
             IsComponentObjectRep and IsSyllableRep
             );
             
            set := Set( [ ] );

            # Create zero syllable
            obj := rec(
             path := Zero( oquiv ),
             perturbation := fail,
             sb_alg := sba
            );
            
            ObjectifyWithAttributes(
             obj, type,
             IsZeroSyllable, true,
             IsStableSyllable, fail,
             SbAlgOfSyllable, sba
            );
            
            AddSet( list, obj );
            
            # Create nonzero syllables
            source_enc := SourceEncodingOfPermData( sba );
            a_seq := source_enc[1];
            b_seq := source_enc[2];

            # Nonzero syllables correspond to tuples [ i, l, ep ] satisfying
            #      0 < l + ep < a_i + b_i + ep,
            #  where a_i and b_i are the <i>th terms of <a_seq> and <b_seq>.
            #  Such tuples can be enumerated. The variables <i> and <ep> have
            #  finite ranges so we can range over them first, and then range
            #  over values of <l> that do not exceed the upper inequality.
            for i in VerticesOfQuiver( oquiv ) do
                a_i := a_seq.( String( i ) );
                b_i := b_seq.( String( i ) );

                for ep in [ 0, 1 ] do
                    l := 0;

                    while l + ep < a_i + b_i + ep do
                        if 0 < l + ep then
                            obj := rec(
                             path := PathBySourceAndLength( i, l ),
                             perturbation := ep,
                             sb_alg := sba
                             );
                            ObjectifyWithAttributes(
                             obj, type,
                             IsZeroSyllable, false,
                             IsStableSyllable, ( ep = 0 ),
                             SbAlgOfSyllable, sba
                             );
                            MakeImmutable( obj );
                            AddSet( set, obj );
                        fi;
                        l := l + 1;
                    od;
                od;
            od;
            
            MakeImmutable( set );
            return set;
        fi;
    end
);

#########1#########2#########3#########4#########5#########6#########7#########
