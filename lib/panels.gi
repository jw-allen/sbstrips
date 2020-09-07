InstallMethod(
    PanelFamilyOfSbAlg,
    "for special biserial algebras",
    [ IsSpecialBiserialAlgebra ],
    function( sba )
        local
            fam;    # Family variable
        
        if HasPanelFamilyOfSbAlg( sba ) then
            return PanelFamilyOfSbAlg( sba );
        else
            fam := NewFamily( "PanelFamilyForSbAlg" );
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
            add_zero,   # Local function, adding copies of <zero> to rows 
            branch_left_index,
                        # Left column index demarcating branches in <next_row>
            branch_list,
                        # List variable, storing branches at the bottom of
                        #  <panel>
            col, row,   # Integer variables, respectively indexing columns and
                        #  rows
            descent,    # Descent function of <sba>
            fam,        # Panel family of <sba>
            go,         # Boolean variable
            max,        # Integer variable, storing the greatest forward
                        #  <descent>-orbit length of syllables in <test_row>
            nbr_col,    # Column of peak neighbour cell to <panel[row][col]>
            nbr_syll,   # Syllable in peak neighbour position to <this_syll>
            next_row,   # next row, under construction
            orbit,      # <sprawl>-orbit of <sy>
            panel,      # List variable
            parity,     # Integer variable, either +1 or -1
            patch, this_patch, that_patch,
                        # Patch variables
            sba,        # SB algebra to which <sy> belongs
            sidestep,   # Sidestep function of <sba>
            sprawl,     # Local function
            stop_at,    # Threshold at which to terminate
            test_row,   # Row to be tested for cut-off threshold
            this_syll;  # <[row][col]>th entry of <panel>
            threshold;  # Threshold for terminating an unbounded panel
            zero_syll;  # Zero syllable of <sba>
            
        # Test for, and reject, syllables beside unstable ones.
        if IsZeroSyllable( sy ) then
            Error( "Cannot panellify from a zero syllable" );
        elif PerturbationTermOfSyllable( sy ) = 0 then
            Error( "Cannot panellify from a stable syllable" );
            
        # Otherwise, proceed.
        else
            sba := FamilyObj( sy )!.sb_alg;
            zero_syll := ZeroSyllableOfSbAlg( sba );
            fam := PanelFamilyOfSbAlg( sba );
            
            descent := DescentFunctionOfSbAlg( sba );
            sidestep := SidestepFunctionOfSbAlg( sba );
            sprawl := function( x )
                return sidestep( descent( x ) );
            end;
            
            orbit := ForwardOrbitUnderFunctionNC( sy, sprawl );

            add_zero := function( pnl )
                local
                    r,  # Row variable
                
                for r in [1..Length( pnl )] do
                    Add( pnl[r], zero_syll );
                od;
            end;

            # The length <L> of <orbit> is the column component of the
            #  repetition vector. We then calculate the number of distinct
            #  terms in the forward <descent>-orbit of each term in the <C>th
            #  row (beside the last, which is the repeated stationary syll-
            #  -able). Let <max> be the maximum of all these numbers. We stop
            #  after <max + L> rows.
            
            # Initialize row iteration
            go := true;
            threshold := infinity;

            panel := [ [ sy ] ];
            row := 1;

            # Iteration over rows
            while go = true and row < threshold do
                # "Pad out" <panel> to a <row>-by-<row+1> matrix by adding
                #  <zero> in the final column.
                add_zero( panel );
                
                # Initialise column iteration
                col := 1;
                next_row := [];
                branch_list := [];
                
                if IsOddInt( row ) then
                    branch_left_index := 0;
                else
                    branch_left_index := 1;
                fi;
                branch_right_index := branch_left_index + 1;
                
                # Iteration over columns
                while col <= row do
                    parity := (-1)^( row + col );
                    nbr_col := col - parity;
                    this_syll := panel[row][col];
                    
                    if col = 1 and nbr_col = 0 then
                        nbr_syll := sidestep( this_syll );
                    else
                        nbr_syll := panel[row][nbr_col];
                    fi;
                    
                    if parity = 1 then
                        this_patch := PatchifyByTop( nbr_syll, this_syll );
                        next_row[col] := patch!.SE;
                    else
                        patch := PatchifyByTop( this_syll, nbr_syll );
                        next_row[col] := patch!.SW;
                    fi;
                    
                    if IsPatchOfStringProjective( patch ) then
                        if go = true then
                            go := false;
                        fi;
                        
                        if parity = -1 then
                            Add( branch_list, [ branch_left_index .. col ] );
                            branch_left_index := col + 1;
                        fi;
                    fi;
                    
                    col := col + 1;
                od;
                
                if row = Length( orbit ) + 1 then
                    test_row := panel[row]{ 1..( Length( panel[row] ) - 1 ) };
                    max := Maximum(
                     List(
                      test_row,
                      s -> Length( ForwardOrbitUnderFunctionNC( s, desc ) )
                      )
                     );
                    threshold := max + row;
                fi;
                
                if go = true then
                    panel[ row + 1 ] := next_row;
                else
                    
                fi;
            od;

            # What's the inductive step?
            #  1. We populate <panel> one row at a time.
            #  2. We populate only the cells on or beneath the leading diagonal.
            #  3. We read the bottom row, and use that to figure out what to
            #  (putatively) put in the next row.
            #  4. Given any cell in the bottom row, we view it and its peak
            #  neighbor as the top of a patch. If the peak neighbor is off the 
            #  left side of the panel, we can infer it using <sidestep>.
            
           
           # STILL NOT DONE, PICK UP FROM HERE
           
        fi;
    end
);


# InstallMethod for "StationaryPanelsOfSbAlg" (panels of stationary syllables) 
#  attribute of IsSpecialBiserialAlgebra

# InstallMethod for "IsUnboundedPanel" property of IsPanelRep

# InstallMethod for "aileron segments of panel" attribute of IsPanelRep

#########1#########2#########3#########4#########5#########6#########7#########
