# DeclareProperty( "Is1RegularQuiver", IsQuiver );

DeclareOperation( "QuiverOfQuiverPath", [ IsPath ] );

# DeclareAttribute( "1RegQuivIntActionFunction", IsQuiver );

# DeclareOperation( "1RegQuivIntAct" [ IsPath, IsInt ] );

DeclareAttribute( "2RegAugmentationOfQuiver", IsQuiver );

DeclareProperty( "Is2RegAugmentationOfSbQuiver", IsQuiver );

DeclareAttribute( "OriginalSbQuiverOf2RegAugmentation", IsQuiver );

DeclareAttribute( "RetractionOf2RegAugmentation", IsQuiver );

DeclareAttribute( "CompatibleTrackPermutationOfSbAlg",
 IsSpecialBiserialAlgebra );
 
DeclareAttribute( "OverquiverOfSbAlg", IsSpecialBiserialAlgebra );

DeclareProperty( "IsOverquiver", IsQuiver );

DeclareAttribute( "SbAlgOfOverquiver", IsSpecialBiserialAlgebra );

#########1#########2#########3#########4#########5#########6#########7#########
