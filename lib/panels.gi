InstallMethod(
    PanelFamilyOfSBAlg,
    "for special biserial algebras",
    [ IsSpecialBiserialAlgebra ],
    function( sba )
        local
            fam;    # Family variable
        
        if HasPanelFamilyOfSBAlg( sba ) then
            return PanelFamilyOfSBAlg( sba );
        else
            fam := NewFamily( "PanelFamilyForSBAlg" );
            fam!.sb_alg := sba;
            
            return fam;
        fi;
    end
);

# InstallMethod for "PanellifyNC" operation, which is like Objectify for panels
#
#   # Maybe I don't need this? ^^^^

# InstallMethod for "Display", "ViewObj", "String" operations for IsPanelRep

# InstallMethod for "PanellifyFromUnstableSyllable" operation
InstallMethod(
    PanellifyFromUnstableSyllable,
    "for an unstable syllable",
    [ IsSyllableRep ],
    function( sy )
        local
            branches,   #
            col,        #
            descent,    #
            edge_func,  #
            edges,      #
            fam,        #
            branch_func,
                        #
            go,         #
            left_index, #
            panel,      #
            parity,     #
            patch,      #
            row,        #
            sba,        #
            sidestep,   #
            sprawl,     #
            zero_syll;  #
            
        # Test for, and reject, syllables beside unstable ones.
        if IsZeroSyllable( sy ) then
            Error( "Cannot panellify from a zero syllable" );
        elif PerturbationTermOfSyllable( sy ) = 0 then
            Error( "Cannot panellify from a stable syllable" );
            
        # Otherwise, proceed.
        else
            # Setup
            sba := FamilyObj( sy )!.sb_alg;
            zero_syll := ZeroSyllableOfSBAlg( sba );
            fam := PanelFamilyOfSBAlg( sba );
            
            descent := DescentFunctionOfSBAlg( sba );
            sidestep := SidestepFunctionOfSBAlg( sba );
            sprawl := function( x )
                return sidestep( descent( x ) );
            end;
            
            branch_func := function( list )
                local
                    k,
                    output;

                output := [];
                for k in [ 1 .. Length( list ) ] do
                    if list[k] = 0 then
                        output[k] := "...";
                    else
                        output[k] := panel[row+1][ list[k] ];
                    fi;
                od;
                return output;
            end;
            
            edge_func := function( list, row_no )
                local
                    pos;
                
                # pos := 
            end;
            
            # Initialize
            panel := [ [ sy, zero_syll, zero_syll ] ];
            edges := [ sy ];
            row := 1;
            go := true;
            
            # Work one row at a time (indexed by <row>) and continue until a repeat in <edges> or a branch occurs
            while IsDuplicateFreeList( edges ) and ( go = true ) do
                
                panel[ row + 1 ] := [];
                col := 1;
                branches := [];

                parity := (-1)^( row + col );
                if parity = 1 then
                    left_index := 1;
                else
                    left_index := 0;
                fi;
                
                # Work one column at a time (indexed by <col>)
                while col <= Length( panel[row] ) do
                    parity := (-1)^( row + col );

                    # Populate a cell (<panel[row+1][col]>) in the next row
                    #  using one (<panel[row][col]>) in this row and an appro-
                    #  -priate neighbouring cell. If ever you use the patch of
                    #  a string projective, assign <go> to <false>, so that we
                    #  stop after this row.
                    if parity = 1 then
                        if col = 1 then
                            patch := PatchifyByTop(
                             sidestep( panel[row][col] ), panel[row][col]
                             );
                        else
                            patch := PatchifyByTop(
                             panel[row][ col - 1 ], panel[row][col]
                             );
                        fi;
                        
                        panel[ row + 1 ][col] := patch!.SE;
                        if IsPatchOfStringProjective( patch ) then
                            go := false;
                        fi;

                    else
                        patch := PatchifyByTop(
                         panel[row][col], panel[row][col+1]
                         );
                        panel[row+1][col] := patch!.SW;
                        
                        if IsPatchOfStringProjective( patch ) then
                            go := false;
                            Add( branches, [ left_index .. col] );
                            left_index := col + 1;
                        fi;
                    fi;

                    col := col + 1;
                od;
                
                panel[row+1][col] := zero_syll;
                
                # Cap off final segment at the right.
                Add( branches, [left_index, col - 1] );

                # If branching has occured, then sort out <branches>
                if go = false then
                    Apply( branches, branch_func );
                    
                # It is possible that the row has all zeros
                elif not false in List( panel[row], IsZeroSyllable ) then;
                    Error( "alarm bells ringing!!!!!" );

                # If no branching has occured, then sort out <edges>
                else
                    
                fi;
                
                row := row + 1;
            od;
        fi;
    end
);


# InstallMethod for "StationaryPanelsOfSBAlg" (panels of stationary syllables) 
#  attribute of IsSpecialBiserialAlgebra

# InstallMethod for "IsUnboundedPanel" property of IsPanelRep

# InstallMethod for "aileron segments of panel" attribute of IsPanelRep

#########1#########2#########3#########4#########5#########6#########7#########
