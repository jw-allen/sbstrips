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

# InstallMethod for "Display", "ViewObj", "String" operations for IsPanelRep

# InstallMethod for "PanelOfBoundarySyllable" operation

# InstallMethod for "StationaryPanelsOfSbAlg" (panels of stationary syllables) 
#  attribute of IsSpecialBiserialAlgebra

# InstallMethod for "IsUnboundedPanel" property of IsPanelRep

# InstallMethod for "aileron segments of panel" attribute of IsPanelRep

#########1#########2#########3#########4#########5#########6#########7#########
