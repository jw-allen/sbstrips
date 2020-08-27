DeclareRepresentation( "IsStripRep", IsPositionalObjectRep, [] );
DeclareRepresentation( "IsVirtualStripRep", IsStripRep, [] );

DeclareOperation( "SyllableListOfStripNC", [ IsStripRep ] );

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

##  <#GAPDoc Label="DocIsZeroStrip">
##    <ManSection>
##      <Prop Name="IsZeroStrip" Arg="strip">
##        <Description>
##          Argument: <A>strip</A>, a strip
##          <Br />
##        </Description>
##        <Returns>
##          &true; if <A>strip</A> is the zero strip of some SB algebra,
##          and &false; otherwise.
##        </Returns>
##        <Description>
##          Note that &sbstrips; knows which SB algebra <A>strip</A> belongs
##          to.
##          <Br />
##        </Description>
##      </Prop>
##    </ManSection>
##  <#/GAPDoc>

DeclareProperty( "IsZeroStrip", [IsStripRep] );

#########1#########2#########3#########4#########5#########6#########7#########
