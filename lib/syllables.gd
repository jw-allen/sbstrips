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

##  <#GAPDoc Label="DocIsStationarySyllable">
##    <ManSection>
##      <Prop Name="IsStationarySyllable" Arg="sy"/>
##      <Description>
##        Argument: <A>sy</A>, a syllable
##        <Br />
##      </Description>
##      <Returns>
##        either <C>true</C> or <C>false</C>, depending on whether or not the
##        underlying path of <A>sy</A> is a stationary path.
##      </Returns>
##    </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsStationarySyllable", IsSyllableRep );

DeclareOperation( "SbAlgOfSyllable", [ IsSyllableRep ] );

DeclareAttribute( "DescentFunctionOfSbAlg", IsSpecialBiserialAlgebra );
DeclareAttribute( "SidestepFunctionOfSbAlg", IsSpecialBiserialAlgebra );

DeclareOperation( "IsPeakCompatiblePairOfSyllables",
 [ IsSyllableRep, IsSyllableRep ] );
DeclareOperation( "IsValleyCompatiblePairOfSyllables",
 [ IsSyllableRep, IsSyllableRep ] );

#########1#########2#########3#########4#########5#########6#########7#########
