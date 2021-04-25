DeclareRepresentation( "IsSyllableRep", IsAttributeStoringRep,
 [ "path", "stability", "sb_alg" ] );

DeclareAttribute( "SyllableFamilyOfSBAlg", IsSpecialBiserialAlgebra );
DeclareAttribute( "SyllableSetOfSBAlg", IsSpecialBiserialAlgebra );
DeclareAttribute( "ZeroSyllableOfSBAlg", IsSpecialBiserialAlgebra );
DeclareSynonymAttr( "BlankSyllableOfSBAlg", ZeroSyllableOfSBAlg );

DeclareOperation( "Syllabify", [ IsPath, IsInt ] );

DeclareOperation( "UnderlyingPathOfSyllable", [ IsSyllableRep ] );
DeclareOperation( "StabilityTermOfSyllable", [ IsSyllableRep ] );

DeclareProperty( "IsZeroSyllable", IsSyllableRep );
DeclareProperty( "IsVirtualSyllable", IsSyllableRep );
DeclareProperty( "IsStableSyllable", IsSyllableRep );
DeclareProperty( "IsSyllableWithStableSource", IsSyllableRep );
DeclareProperty( "IsUltimatelyDescentStableSyllable", IsSyllableRep );

##  <#GAPDoc Label="DocIsPinBoundarySyllable">
##    <ManSection>
##      <Prop Name="IsPinBoundarySyllable" Arg="sy"/>
##      <Description>
##        Argument: <A>sy</A>, a syllable
##        <Br />
##      </Description>
##      <Returns>
##        either &true; or &false;
##      </Returns>
##      <Description>
##        A <E>pin boundary</E> syllable is a boundary syllable whose
##        underlying path can be obtained from the component of a commutativity
##        relation by deleting the last arrow.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsPinBoundarySyllable", IsSyllableRep );

##  <#GAPDoc Label="DocIsStationarySyllable">
##    <ManSection>
##      <Prop Name="IsStationarySyllable" Arg="sy"/>
##      <Description>
##        Argument: <A>sy</A>, a syllable
##        <Br />
##      </Description>
##      <Returns>
##        either &true; or &false;, depending on whether or not the underlying
##        path of <A>sy</A> is a stationary path.
##      </Returns>
##    </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsStationarySyllable", IsSyllableRep );

DeclareOperation( "SBAlgOfSyllable", [ IsSyllableRep ] );

DeclareAttribute( "DescentFunctionOfSBAlg", IsSpecialBiserialAlgebra );
DeclareAttribute( "SidestepFunctionOfSBAlg", IsSpecialBiserialAlgebra );

DeclareOperation( "IsPeakCompatiblePairOfSyllables",
 [ IsSyllableRep, IsSyllableRep ] );
DeclareOperation( "IsValleyCompatiblePairOfSyllables",
 [ IsSyllableRep, IsSyllableRep ] );
