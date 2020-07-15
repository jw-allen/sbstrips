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
            a_seq, b_seq,   # Integer and bit sequences of <source_enc>
            a_i, b_i,       # <i>th terms of <a_seq> and <b_seq>
            a_j, b_j,       # <j>th terms of <a_seq> and <b_seq>
            check,          # Local function
            desc,           # Descent function of <sba>
            i, j,           # Vertex variables
            is_triv,        # Local function testing trivialness of syllable
            n1_sy, n2_sy, s1_sy, s2_sy,
                            # Syllable variables: 'n' = north, 's' = south
            patch,          # Patch variable
            proper_sylls,   # Members of <sy_set> that are neither zero nor
                            #  virtual
            obj,            # Object to be made into a patch, or defining data
                            #  thereof
            oquiv,          # Overquiver of <sba>
            overts,         # Vertices of <oqvui>
            set,            # Set variables
            source_enc,     # Source encoding of permissible data of <sba>
            sy_set,         # Syllable set of <sba>
            triv_list,      # List of patches with northern trivial syllable
                            #  replaced by <zero_sy>
            type,           # Type variable 
            zero_sy;        # Zero syllable of <sba>

        if HasPatchSetOfSbAlg( sba ) then
            return PatchSetOfSbAlg( sba );
        else
            # Assign key variables
            type := NewType(
             PatchFamilyOfSbAlg( sba ),
             IsComponentObjectRep and IsPatchRep
             );

            oquiv := OverquiverOfSbAlg( sba );
            overts := VerticesOfQuiver( oquiv );
            zero_sy := ZeroSyllableOfSbAlg( sba );
            
            source_enc := SourceEncodingOfPermDataOfSbAlg( sba );
            a_seq := source_enc[1];
            b_seq := source_enc[2];

            desc := DescentFunctionOfSbAlg( sba );
            sy_set := SyllableSetOfSbAlg( sba );
            proper_sylls := Filtered(
             sy_set,
             x -> not ( IsZeroSyllable(x) or IsVirtualSyllable(x) )
             );

            # Begin with empty patch set.
            set := [ ];

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
            SetZeroPatchOfSbAlg( sba, obj );
            Add( set, obj );

            Info( InfoDebug, 1, "Made zero patch" );

            # Create the "virtual" patches. These correspond to targets of
            #  (overquiver representatives of) components of commuativity
            #  relations. On one side (east or west), these have as northern
            #  component a virtual syllable (ie, a syllable with source/
            #  length/perturbation tuple [i,0,0] for some target i of a commu-
            #  -tativity rel) and as southern component the associated trivial
            #  syllable (ie, [i,0,1]) as southern component. On the other side,
            #  both components are <zero_sy>

            for i in Filtered( overts, IsRepresentativeOfCommuRelTarget ) do
                n1_sy := Syllabify( PathBySourceAndLength( i, 0 ), 0 );
                s1_sy := Syllabify( PathBySourceAndLength( i, 0 ), 1 );
                n2_sy := zero_sy;
                s2_sy := zero_sy;
                
                # Create virtual patch that looks like
                #    [  i,0,0  | zero_sy ]
                #    [  i,0,1  | zero_sy ]
                
                obj := rec(
                 NW := n1_sy, NE := n2_sy, SW := s1_sy, SE := s2_sy
                 );
                ObjectifyWithAttributes(
                 obj, type,
                 IsZeroPatch, false,
                 IsPatchOfStringProjective, false,
                 IsPatchOfPinModule, false,
                 IsVirtualPatch, true
                 );
                Add( set, obj );

                # Create virtual patch that looks like
                #    [ zero_sy |  i,0,0  ]
                #    [ zero_sy |  i,0,1  ]
                
                obj := rec(
                 NW := n2_sy, NE := n1_sy, SW := s2_sy, SE := s1_sy
                 );
                ObjectifyWithAttributes(
                 obj, type,
                 IsZeroPatch, false,
                 IsPatchOfStringProjective, false,
                 IsPatchOfPinModule, false,
                 IsVirtualPatch, true
                 );
                Add( set, obj );
            od;

            Info( InfoDebug, 1, "Made virtual patches" );

            # With the zero and virtual patches done, we now turn to patches
            #  corresponding to pin (= projective-injective nonuniserial)
            #  modules. We could call these 'pin patches'.

            # First, we create those pin patches associated to socle quotients
            #  of pin mods. These are the pin patches where both northern
            #  entries are 'pin boundaries' and they deserve special treatment
            #  because their southern entries must be virtual syllables. The
            #  sources of the northern entries form an exchange pair. There-
            #  -fore, such pin patches are uniquely identified by their north-
            #  -west entry and so are in one-to-one correspondence with the set
            #  of 'pin boundaries'.
            
            for i in overts do
                b_i := b_seq.( String( i ) );
                if b_i = 0 then
                    a_i := a_seq.( String( i ) );

                    # (Normally we denote the exchange partner of <i> by
                    #  <i_dagger> or similar. Here, solely in order to save
                    #  space, we use <j>.)
                    j := ExchangePartnerOfVertex( i );
                    a_j := a_seq.( String( j ) );

                    n1_sy := Syllabify( 
                     PathBySourceAndLength( i, a_i - 1  ),
                     1
                     );
                    s1_sy := Syllabify(
                     PathBySourceAndLength( 1RegQuivIntAct( i, -a_i ), 0 ),
                     0
                     );
                    n2_sy := Syllabify( 
                     PathBySourceAndLength( j, a_j - 1 ),
                     1
                     );
                    s2_sy := Syllabify(
                     PathBySourceAndLength( 1RegQuivIntAct( j, -a_j ), 0 ),
                     0
                     );
                     
                    obj := rec(
                     NW := n1_sy, NE := n2_sy, SW := s1_sy, SE := s2_sy
                     );
                    ObjectifyWithAttributes(
                     obj, type,
                     IsZeroPatch, false,
                     IsPatchOfStringProjective, false,
                     IsPatchOfPinModule, true,
                     IsVirtualPatch, false
                     );
                    Add( set, obj );
                fi;
            od;

            Info( InfoDebug, 1, "Made patches with two pin boundaries" );

            # Second, we create those featuring exactly one 'pin boundary'.
            #  These also deserve special treatment, as any southern entry on
            #  the nonboundary side must have perturbation term 1 (not 0).
            # The patches will have the 'pin boundary' syllable in a northern
            #  component on one side; beneath it on that side goes <zero_sy>.
            #  On the other side, the northern component is any non-'pin bound-
            #  -ary' syllable with source <j>, and the southern component is
            #  the <desc>-image thereof with perturbation term adjusted to 1:
            #  here, <j> denotes the exchange partner of the source <i> of the
            #  'pin boundary' syllable. General theory ensures that this
            #  <desc>-image is never <zero_sy>. We write a local boolean func-
            #  -tion <check> that returns <true> exactly on such non-'pin
            #  boundary' syllables
            
            for i in overts do
                b_i := b_seq.( String( i ) );
                if b_i = 0 then
                    # Create syllables <n1_sy> and <s1_sy> to go on the 'pin'
                    #  boundary side
                    a_i := a_seq.( String( i ) );
                    n1_sy := Syllabify(
                     PathBySourceAndLength( i, a_i -1 ), 1
                     );
                    s1_sy := zero_sy;

                    # Run through all syllables that can go in the northern
                    #  component on the other side. These will be exactly those
                    #  syllable satisfying <check>
                    j := ExchangePartnerOfVertex( i );
                    check := function( x )
                        return (
                         ( SourceOfPath( UnderlyingPathOfSyllable( x ) ) = j )
                         and
                         ( not IsPinBoundarySyllable( x ) )
                         );
                    end;

                    # Create the relevant patches in turn. These have northern
                    #  entry some <n2_sy>, and southern entry and adjusted ver-
                    #  -sion of <desc(n2_sy)>.
                    for n2_sy in Filtered( proper_sylls, check ) do
                        s2_sy := Syllabify(
                         UnderlyingPathOfSyllable( desc( n2_sy ) ),
                         1
                         );
                        
                        obj := rec(
                         NW := n1_sy, NE := n2_sy, SW := s1_sy, SE := s2_sy
                         );
                        ObjectifyWithAttributes(
                         obj, type,
                         IsZeroPatch, false,
                         IsPatchOfStringProjective, false,
                         IsPatchOfPinModule, true,
                         IsVirtualPatch, false
                         );
                        Add( set, obj );
                        
                        obj := rec(
                         NW := n2_sy, NE := n1_sy, SW := s2_sy, SE := s1_sy
                         );
                        ObjectifyWithAttributes(
                         obj, type,
                         IsZeroPatch, false,
                         IsPatchOfStringProjective, false,
                         IsPatchOfPinModule, true,
                         IsVirtualPatch, false
                         );
                        Add( set, obj );
                    od;
                fi;
            od;

            Info( InfoDebug, 1, "Made patches with one pin boundary" );

            # Third, we create the pin patches with no 'pin boundaries'. The
            #  southern entry on each side is just the descent-image of the
            #  northern entry above.

            for n1_sy in
             Filtered( proper_sylls, x -> not IsPinBoundarySyllable(x) )
             do
                s1_sy := desc( n1_sy );
                i := SourceOfPath( UnderlyingPathOfSyllable( n1_sy ) );
                b_i := b_seq.( String( i ) );
                j := ExchangePartnerOfVertex( i );
                
                check := function( x )
                    local
                        source; # Source of underlying path of <x>

                    source := SourceOfPath( UnderlyingPathOfSyllable( x ) );
                    return (
                     ( source = j )
                     and
                     ( not IsPinBoundarySyllable( x ) )
                     );
                end;
                
                for n2_sy in Filtered( proper_sylls, check ) do
                    s2_sy := desc( n2_sy );
                    
                    obj := rec(
                     NW := n1_sy, NE := n2_sy, SW := s1_sy, SE := s2_sy
                     );
                    ObjectifyWithAttributes(
                     obj, type,
                     IsZeroPatch, false,
                     IsPatchOfStringProjective, ( b_i = 1 ),
                     IsPatchOfPinModule, ( b_i = 0 ),
                     IsVirtualPatch, false
                     );
                    Add( set, obj );
                    Info( InfoDebug, 2, "made patchrep",
                     "\n",
                     "\n#I  ", obj!.NW,
                     "\n#I    ", obj!.NE,
                     "\n#I  ", obj!.SW,
                     "\n#I    ", obj!.SE,
                     "\n" );
                    
#                    obj := rec(
#                     NW := n2_sy, NE := n1_sy, SW := s2_sy, SE := s1_sy
#                     );
#                    ObjectifyWithAttributes(
#                     obj, type,
#                     IsZeroPatch, false,
#                     IsPatchOfStringProjective, ( b_i = 1 ),
#                     IsPatchOfPinModule, ( b_i = 0 ),
#                     IsVirtualPatch, false
#                     );
#                    Add( set, obj );
#                    Info( InfoDebug, 2, "made patchrep",
#                     "\n",
#                     "\n#I  ", obj!.NW,
#                     "\n#I    ", obj!.NE,
#                     "\n#I  ", obj!.SW,
#                     "\n#I    ", obj!.SE,
#                     "\n" );
                od;
            od;

            Info( InfoDebug, 1, "Made patches with no pin boundaries" );

            # Lastly, create the patches that have exactly one "northern" comp-
            #  -onent featuring <zero_sy>. These syllables can be constructed
            #  by replacing a single trivial syllable (ie, a syllable whose
            #  source/length/pertubation tuple is [i,0,1] for some vertex i) in
            #  a northern component by <zero_sy>.

            # {Is it possible to make this functionality part of the the
            #  previous step?}

            is_triv := function( x )
                local
                    path,   # Underlying path of <x>
                    pert;   # Perturbation term of <x>
                path := UnderlyingPathOfSyllable( x );
                pert := PerturbationTermOfSyllable( x );
                
                return ( IsQuiverVertex( path ) and ( pert = 1 ) );
            end;
            
            triv_list := [];
            
            for patch in set do
                if is_triv( patch!.NW ) then
                    n1_sy := zero_sy;
                    s1_sy := patch!.SW;
                    n2_sy := patch!.NE;
                    s2_sy := patch!.SE;

                    obj := rec(
                     NW := n1_sy, NE := n2_sy, SW := s1_sy, SE := s2_sy
                     );
                    ObjectifyWithAttributes(
                     obj, type,
                     IsZeroPatch, false,
                     IsPatchOfStringProjective,
                      IsPatchOfStringProjective( patch ),
                     IsPatchOfPinModule, IsPatchOfPinModule( patch ),
                     IsVirtualPatch, false
                     );
                    Add( triv_list, obj );
                fi;

                if is_triv( patch!.NE ) then
                    n1_sy := patch!.NW;
                    s1_sy := patch!.SW;
                    n2_sy := zero_sy;
                    s2_sy := patch!.SE;

                    obj := rec(
                     NW := n1_sy, NE := n2_sy, SW := s1_sy, SE := s2_sy
                     );
                    ObjectifyWithAttributes(
                     obj, type,
                     IsZeroPatch, false,
                     IsPatchOfStringProjective,
                      IsPatchOfStringProjective( patch ),
                     IsPatchOfPinModule, IsPatchOfPinModule( patch ),
                     IsVirtualPatch, false
                     );
                    Add( triv_list, obj );
                fi;
            od;
            
            Info( InfoDebug, 1, "Made \"replacement\" patches" );
            
            Append( set, triv_list );
            
            return Immutable( Set( set ) );
        fi;
    end
);

InstallMethod(
    ViewObj,
    "for patch reps",
    [ IsPatchRep ],
    function( patch )
        local
            ne, nw, se, sw; # Cardinal directions

        if IsZeroPatch( patch ) then
            Print( "<zero patch>" );
        elif IsVirtualPatch( patch ) then
            Print( "virtual patch>" );
        else
            nw := patch!.NW;
            ne := patch!.NE;
            sw := patch!.SW;
            se := patch!.SE;
            Print( nw, "\n", "  ", ne, "\n", sw, "\n", "  ", se, "\n" );
        fi;
    end
);

InstallMethod(
    Patchify,
    "for a 4-tuple of syllables",
    \=,
    [ IsSyllableRep, IsSyllableRep, IsSyllableRep, IsSyllableRep ],
    function( sy_NW, sy_NE, sy_SW, sy_SE )
        local
            matches,    # List of patches matching this description 
            patch_set,  # Patch set of <sba>
            sba;        # SB algebra of which <sy_NW> etc are syllables

        sba := FamilyObj( sy_NW )!.sb_alg;
        patch_set := PatchSetOfSbAlg( sba );
        matches := Filtered(
         patchset,
         x -> [ x!.NW, x!.NE, x!.SW, x!.SE ] = [ sy_NW, sy_NE, sy_SW, sy_SE ]
         );
        if Length( matches ) <> 1 then
            Error( "No patch matches that description!" );
        else
            return matches[1];
        fi;
    end;
);

InstallMethod(
    ReflectionOfPatch,
    "for a patch rep",
    [ IsPatchRep ],
    function( patch )
        if HasReflectionOfPatch then
            return ReflectionOfPatch( patch );
        else
            return Patchify( patch!.NE, patch!.NW, patch!.SE, patch!.SW );
        fi;
    end
);

#########1#########2#########3#########4#########5#########6#########7#########
