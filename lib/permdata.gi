InstallMethod(
    ComponentsOfCommutativityRelationsOfSbAlg,
    "for special biserial algebras",
    [ IsSpecialBiserialAlgebra ],
    function ( sba )
        local
            is2nomialgens,  # Local function testing for 2-nomiality of
                            #  presentation
            iscommurel,     # Local function testing for a commutativity
                            #  relation
            ismonrel,       # Local function testing for a monomial relation
            list,           # List of components of commutativity relations
            rels;           # Defining relations of <sba>

        if HasComponentsOfCommutativityRelationsOfSbAlg( sba ) then
            return ComponentsOfCommutativityRelationsOfSbAlg( sba );

        else
            # Write functions answering whether an element of a path algebra is
            #  supported on one or two paths
            ismonrel := function( elt )
                if Length( CoefficientsAndMagmaElements( elt ) ) = 2 then
                    return true;
                else
                    return false;
                fi;
            end;

            iscommurel := function( elt )
                if Length( CoefficientsAndMagmaElements( elt ) ) = 4 then
                    return true;
                else
                    return false;
                fi;
            end;

            # Write logical disjunction of <ismonrel> and <iscommurel> 
            is2nomialgens := function( elt )
                if ( ismonrel( elt ) or iscommurel( elt ) ) then
                    return true;
                else
                    return fail;
                fi;
            end;

            # Verify that <sba> has been presented 2-nomially.
            rels := RelationsOfAlgebra( sba );

            if false in List( rels, x -> is2nomialgens( x ) ) then
                Error( "The given algebra\n", sba, "\nhas not been presented ",
                "by monomial and commutativity relations!" );
            else
                list := Filtered( rels, iscommurel );
            fi;

            Apply( list, x -> CoefficientsAndMagmaElements( x ){ [1,3] } );

            return Immutable( list );
        fi;
    end
);

InstallMethod(
    ComponentExchangeMapOfSba,
    "for special biserial algebras",
    [ IsSpecialBiserialAlgebra ],
    function( sba )
        local
            complist,   # List of components of commutativity relations of
                        #  <sba>
            func;       # Function variable

        if HasComponentExchangeMapOfSba( sba ) then
            return ComponentExchangeMapOfSba( sba );

        else
            complist := ComponentsOfCommutativityRelationsOfSbAlg( sba );

            func := function( elt )
                local
                    found,
                    k,
                    pair;

                found := false;
                k := 1;
                while ( (found = false) and ( k <= Length( complist ) ) ) do
                    if elt in complist[ k ] then
                        found := true;
                    else
                        k := k+1;
                    fi;
                od;

                if found = false then
                    Print( "The given element\n", elt, "\nis not a component",
                     " of a commutativity relation of the special biserial",
                     " algebra\n", sba );
                    return fail;
                else
                    pair := ShallowCopy( complist[ k ] );
                    Remove( pair, Position( pair, elt ) );
                fi;

                return pair[ 1 ];
            end;

            return func;
        fi;
    end
);

InstallMethod(
    LinDepOfSbAlg,
    "for special biserial algebras",
    [ IsSpecialBiserialAlgebra ],
    function( sba )
        local
            a,      # Arrow variable
            comps,  # Components of commutativity relations defining <sba>
            k,      # Integer variable
            list,   # List of linearly-dependent paths
            oarrs,  # Arrows of the overquiver of <sba>
            p,      # Path variable
            walk;   # List variable for walks of paths
        if HasLinDepOfSbAlg( sba ) then
            return LinDepOfSbAlg( sba );
        else
            comps := ComponentsOfCommutativityRelationsOfSbAlg( sba );
            oarrs := ArrowsOfQuiver( OverquiverOfSbAlg( sba ) );

            # Lift each path appearing within <comps>; do this by lifting each
            #  constituent arrow (in the ground quiver to one in the over-
            #  -quiver and then multiplying them together.
            list := [];
            for p in Flat( comps ) do
                walk := ShallowCopy( WalkOfPath( p ) );
                for k in [1..Length( walk )] do
                    walk[k] := First( oarrs, x -> ( x!.LiftOf!.2RegAugPathOf = ( walk[k] ) ) );
                od;
                Append( list, [ Product( walk ) ] );
            od;

            # Return the resulting list (of paths in the overquiver)
            Sort( list );
            return Immutable( list );
        fi;
    end
);

InstallMethod(
    LinIndOfSbAlg,
    "for special biserial algebras",
    [ IsSpecialBiserialAlgebra ],
    function( sba )
        local
            2reg,   # 2-regular augmentation of ground quiver of <sba>
            cont,   # Contaction of overquiver of <sba>
            ideal,  # Defining ideal of <sba>
            in_pa,  # Local function
            l,      # Integer variable
            list,   # List variable
            lindep, # Linearly dependent paths of <sba>
            oquiv,  # Overquiver of <sba>
            p,      # Path variable
            pa,     # Original path algebra of <sba>
            ret,    # Retraction of <2reg>
            v;      # Vertex variable
        if HasLinIndOfSbAlg( sba ) then
            return LinIndOfSbAlg( sba );
        else
            pa := OriginalPathAlgebra( sba );
            ideal := IdealOfQuotient( sba );
            2reg := 2RegAugmentationOfQuiver( QuiverOfPathAlgebra( pa ) );
            oquiv := OverquiverOfSbAlg( sba );
            cont := ContractionOfOverquiver( oquiv );
            ret := RetractionOf2RegAugmentation( 2reg );

            # Write local function that turns a path in the overquiver into the
            #  corresponding one in <pa>
            in_pa := function( path )
                return ElementOfPathAlgebra( pa, ret( cont( path ) ) );
            end;
            
            lindep := LinDepOfSbAlg( sba );
            list := [];
            for v in VerticesOfQuiver( oquiv ) do
                l := 0;
                p := PathBySourceAndLength( v, l ); 
                while not ( ( in_pa(p) in ideal ) or ( p in lindep ) ) do
                    Append( list, [ p ] );
                    l := l + 1;
                    p := PathBySourceAndLength( v, l );
                od;
            od;
            
            Sort( list );
            
            # Return the resulting list (of paths in the overquiver)
            return Immutable( list );
        fi;
    end
);

InstallMethod(
    PermDataOfSbAlg,
    "for special biserial algebras",
    [ IsSpecialBiserialAlgebra ],
    function( sba )
        if HasPermDataOfSbAlg( sba ) then
            return PermDataOfSbAlg( sba );
        else
            return Immutable( [ LinIndOfSbAlg( sba ), LinDepOfSbAlg( sba ) ] );
        fi;
    end
);

#InstallMethod(
#    SourceEncodingOfPermDataOfSbAlg,
#    "for special biserial algebras",
#    [ IsSpecialBiserialAlgebra ],
#    function( sba )
#        local
#            overts,     # Vertices of the overquiver of <sba>
#            perm_data;  # Permissible data of <sba>

#        if HasSourceEncodingOfPermDataOfSbAlg( sba ) then
#            return SourceEncodingOfPermDataOfSbAlg( sba );
#        else
#            perm_data := PermDataOfSbAlg( sba );
#            overts := VerticesOfQuiver( OverquiverOfSba( sba ) );
#            
#            #### RESUME FROM HERE
#        fi;
#    end;
#);

# Source encoding
#  Integer sequence } can also be inferred as quotient and remainder modulo 2
#  Bit sequence     }  of some integer
#
# Target encoding
#  Integer sequence } can also be inferred as quotient and remainder modulo 2
#  Bit sequence     }  of some integer


#########1#########2#########3#########4#########5#########6#########7#########
#########1#########2#########3#########4#########5#########6#########7#########
#########1#########2#########3#########4#########5#########6#########7#########
