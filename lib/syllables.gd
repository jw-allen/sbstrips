DeclareRepresentation( "IsSyllableRep", IsAttributeStoringRep,
 [ "path", "perturbation", "sb_alg" ] );

DeclareAttribute( "SyllableFamilyOfSbAlg", IsSpecialBiserialAlgebra );
DeclareAttribute( "SyllableSetOfSbAlg", IsSpecialBiserialAlgebra );
DeclareAttribute( "ZeroSyllableOfSbAlg", IsSpecialBiserialAlgebra );

DeclareOperation( "Syllabify", [ IsPath, IsInt ] );

DeclareOperation( "UnderlyingPathOfSyllable", [ IsSyllableRep ] );
DeclareOperation( "PerturbationTermOfSyllable", [ IsSyllableRep ] );

DeclareProperty( "IsZeroSyllable", IsSyllableRep );
DeclareProperty( "IsVirtualSyllable", IsSyllableRep );
DeclareProperty( "IsStableSyllable", IsSyllableRep );
DeclareProperty( "IsSyllableWithStableSource", IsSyllableRep );
DeclareProperty( "IsUltimatelyDescentStableSyllable", IsSyllableRep );
DeclareProperty( "IsPinBoundarySyllable", IsSyllableRep );

DeclareOperation( "SbAlgOfSyllable", [ IsSyllableRep ] );

DeclareAttribute( "DescentFunctionOfSbAlg", IsSpecialBiserialAlgebra );
DeclareAttribute( "SidestepFunctionOfSbAlg", IsSpecialBiserialAlgebra );

DeclareOperation( "IsPeakCompatiblePairOfSyllables",
 [ IsSyllableRep, IsSyllableRep ] );
DeclareOperation( "IsValleyCompatiblePairOfSyllables",
 [ IsSyllableRep, IsSyllableRep ] );

#########1#########2#########3#########4#########5#########6#########7#########
