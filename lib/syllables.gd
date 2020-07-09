DeclareRepresentation( "IsSyllableRep", IsAttributeStoringRep,
 [ "path", "perturbation", "sb_alg" ] );

DeclareAttribute( "SyllableFamilyOfSbAlg", IsSpecialBiserialAlgebra );

DeclareAttribute( "SyllableSetOfSbAlg", IsSpecialBiserialAlgebra );

DeclareOperation( "Syllabify", [ IsPath, IsInt ] );
DeclareOperation( "UnderlyingPathOfSyllable", [ IsSyllableRep ] );
DeclareOperation( "PerturbationTermOfSyllable", [ IsSyllableRep ] );

DeclareAttribute( "ZeroSyllableOfSbAlg", IsSpecialBiserialAlgebra );

DeclareProperty( "IsZeroSyllable", IsSyllableRep );

DeclareProperty( "IsStableSyllable", IsSyllableRep );
DeclareProperty( "IsSyllableWithStableSource", IsSyllableRep );

DeclareOperation( "SbAlgOfSyllable", [ IsSyllableRep ] );

DeclareAttribute( "DescentFunctionOfSbAlg", IsSpecialBiserialAlgebra );
DeclareAttribute( "SidestepFunctionOfSbAlg", IsSpecialBiserialAlgebra );

DeclareProperty( "IsUltimatelyDescentStableSyllable", IsSyllableRep );

#########1#########2#########3#########4#########5#########6#########7#########
