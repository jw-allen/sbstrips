DeclareAttribute( "ComponentsOfCommutativityRelationsOfSBAlg",
 IsSpecialBiserialAlgebra );

DeclareAttribute( "ComponentExchangeMapOfSBa", IsSpecialBiserialAlgebra );

DeclareAttribute( "LinDepOfSBAlg", IsSpecialBiserialAlgebra );
DeclareSynonymAttr( "ComponentsOfSBAlg", LinDepOfSBAlg );

DeclareAttribute( "LinIndOfSBAlg", IsSpecialBiserialAlgebra );

DeclareAttribute( "NonzeroPathsOfSBAlg", IsSpecialBiserialAlgebra );

DeclareAttribute( "PermDataOfSBAlg", IsSpecialBiserialAlgebra );

DeclareAttribute( "SourceEncodingOfPermDataOfSBAlg",
 IsSpecialBiserialAlgebra );
 
DeclareAttribute( "TargetEncodingOfPermDataOfSBAlg",
 IsSpecialBiserialAlgebra );
 
DeclareProperty( "IsRepresentativeOfCommuRelSource", IsQuiverVertex );
DeclareProperty( "IsRepresentativeOfCommuRelTarget", IsQuiverVertex );
