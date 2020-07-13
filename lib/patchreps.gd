DeclareRepresentation( "IsPatchRep", IsAttributeStoringRep,
 [ "NW", "NE", "SW", "SE" ]
 );

DeclareAttribute( "PatchFamilyOfSbAlg", IsSpecialBiserialAlgebra );
DeclareAttribute( "PatchSetOfSbAlg", IsSpecialBiserialAlgebra );
DeclareAttribute( "ZeroPatchOfSbAlg", IsSpecialBiserialAlgebra );

DeclareAttribute( "IsZeroPatch", IsPatchRep );
DeclareAttribute( "IsPatchOfStringProjective", IsPatchRep );
DeclareAttribute( "IsPatchOfPinModule", IsPatchRep );
DeclareAttribute( "IsVirtualPatch", IsPatchRep );
DeclareAttribute( "ReflectionOfPatch", IsPatchRep );

DeclareOperation( "Patchify",
 [ IsPatchRep, IsPatchRep, IsPatchRep, IsPatchRep ]
 );

#########1#########2#########3#########4#########5#########6#########7#########
