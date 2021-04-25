DeclareRepresentation( "IsPatchRep", IsAttributeStoringRep,
 [ "NW", "NE", "SW", "SE" ]
 );

DeclareAttribute( "PatchFamilyOfSBAlg", IsSpecialBiserialAlgebra );
DeclareAttribute( "PatchSetOfSBAlg", IsSpecialBiserialAlgebra );
DeclareAttribute( "ZeroPatchOfSBAlg", IsSpecialBiserialAlgebra );
DeclareSynonymAttr( "BlankPatchOfSBAlg", ZeroPatchOfSBAlg );

DeclareAttribute( "IsZeroPatch", IsPatchRep );
DeclareAttribute( "IsPatchOfStringProjective", IsPatchRep );
DeclareAttribute( "IsPatchOfPinModule", IsPatchRep );
DeclareAttribute( "IsVirtualPatch", IsPatchRep );
DeclareAttribute( "ReflectionOfPatch", IsPatchRep );

DeclareOperation( "Patchify",
 [ IsSyllableRep, IsSyllableRep, IsSyllableRep, IsSyllableRep ]
 );
DeclareOperation( "PatchifyByTop", [ IsSyllableRep, IsSyllableRep ] );

DeclareOperation( "OverlapFunctionNC", [ IsPatchRep, IsPatchRep ] );
