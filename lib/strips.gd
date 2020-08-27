DeclareRepresentation( "IsStripRep", IsPositionalObjectRep, [] );
DeclareRepresentation( "IsVirtualStripRep", IsStripRep, [] );

DeclareGlobalFunction( "SyllableListOfStripNC" );

DeclareAttribute( "StripFamilyOfSbAlg", IsSpecialBiserialAlgebra );
DeclareAttribute( "ZeroStripOfSbAlg", IsSpecialBiserialAlgebra );

DeclareOperation( "Stripify", [ IsList ] );
DeclareOperation( "ReflectionOfStrip", [ IsStripRep ] );
DeclareOperation( "SyzygyOfStrip", [ IsStripRep ] );
DeclareOperation( "NthSyzygyOfStrip", [ IsStripRep, IsInt ] );

DeclareGlobalFunction( "StripifyFromSyllablesAndOrientationsNC" );
DeclareGlobalFunction( "StripifyFromSbAlgPathNC" );
DeclareGlobalFunction( "StripifyVirtualStripNC" );

DeclareAttribute( "SimpleStripsOfSbAlg", IsSpecialBiserialAlgebra );
DeclareAttribute( "ProjectiveStripsOfSbAlg", IsSpecialBiserialAlgebra );
DeclareAttribute( "InjectiveStripsOfSbAlg", IsSpecialBiserialAlgebra );

DeclareOperation(
 "TestStripForFiniteSyzygyTypeAtMost",
 [ IsStripRep, IsInt ]
 );

##  <#GAPDoc Label="DocWidthOfStrip">
##    <ManSection>
##      <Oper Name="WidthOfStrip" Arg="strip">
##        <Description>
##          Argument: <A>strip</A>, a strip
##          <Br />
##        </Description>
##        <Returns>
##          a nonnegative integer, counting the number (with multiplicity) of
##          syllables of <A>strip</A> are nonstationary.
##        </Returns>
##      </Oper>
##    </ManSection>
##  <#/GAPDoc>

DeclareOperation( "WidthOfStrip", [ IsStripRep ] );

#########1#########2#########3#########4#########5#########6#########7#########
