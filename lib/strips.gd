DeclareRepresentation( "IsStripRep", IsPositionalObjectRep, [] );

DeclareAttribute( "StripFamilyOfSbAlg", IsSpecialBiserialAlgebra );
DeclareAttribute( "ZeroStripOfSbAlg", IsSpecialBiserialAlgebra );

DeclareGlobalFunction( "StripifyFromSyllablesAndOrientationsNC" );
DeclareGlobalFunction( "StripifyFromSbAlgPathNC" );

DeclareOperation( "Stripify", [ IsList ] );
DeclareOperation( "ReflectionOfStrip", [ IsStripRep ] );

DeclareAttribute( "SimpleStripsOfSbAlg", IsSpecialBiserialAlgebra );
DeclareAttribute( "ProjectiveStripsOfSbAlg", IsSpecialBiserialAlgebra );
DeclareAttribute( "InjectiveStripsOfSbAlg", IsSpecialBiserialAlgebra );

#########1#########2#########3#########4#########5#########6#########7#########
