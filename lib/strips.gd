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

##  <#GAPDoc Label="DocSimpleStripsOfSbAlg">
##    <ManSection>
##      <Attr Name="SimpleStripsOfSbAlg", Arg="sba"/>
##      <Description>
##        Argument: <A>sba</A>, a special biserial algebra (ie, <Ref
##        Prop="IsSpecialBiserialAlgebra" BookName="QPA"/> returs &true;)
##        <Br />
##      </Description>
##      <Returns>
##        a list <C>simple_list</C>, whose <M>j</M>th entry is the simple strip
##        corresponding to the <M>j</M>th vertex of <A>sba</A>.
##      </Returns>
##      <Description>
##        You will have specified <A>sba</A> to &GAP; via some quiver. The
##        vertices of that quiver are ordered; <C>SimpleStripsOfSbAlg</C>
##        adopts that order for strips of simple modules.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "SimpleStripsOfSbAlg", IsSpecialBiserialAlgebra );

##  <#GAPDoc Label="DocProjectiveStripsOfSbAlg">
##    <ManSection>
##      <Attr Name="ProjectiveStripsOfSbAlg", Arg="sba"/>
##      <Description>
##        Argument: <A>sba</A>, a special biserial algebra (ie, <Ref
##        Prop="IsSpecialBiserialAlgebra" BookName="QPA"/> returs &true;)
##        <Br />
##      </Description>
##      <Returns>
##        a list <C>proj_list</C>, whose entry are either strips or the boolean
##        &fail;. 
##      </Returns>
##      <Description>
##        You will have specified <A>sba</A> to &GAP; via some quiver. The
##        vertices of that quiver are ordered; <C>ProjectiveStripsOfSbAlg</C>
##        adopts that order for strips of projective modules.
##        <P/>
##
##        If the projective module corresponding to the <C>j</C>th vertex of
##        <A>sba</A> is a string module, then
##        <C>ProjectiveStripsOfSbAlg( sba )[j]</C> returns the strip describing
##        that string module. If not, then it returns &fail;.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "ProjectiveStripsOfSbAlg", IsSpecialBiserialAlgebra );

##  <#GAPDoc Label="DocInjectiveStripsOfSbAlg">
##    <ManSection>
##      <Attr Name="InjectiveStripsOfSbAlg", Arg="sba"/>
##      <Description>
##        Argument: <A>sba</A>, a special biserial algebra (ie, <Ref
##        Prop="IsSpecialBiserialAlgebra" BookName="QPA"/> returs &true;)
##        <Br />
##      </Description>
##      <Returns>
##        a list <C>inj_list</C>, whose entry are either strips or the boolean
##        &fail;. 
##      </Returns>
##      <Description>
##        You will have specified <A>sba</A> to &GAP; via some quiver. The
##        vertices of that quiver are ordered; <C>InjectiveStripsOfSbAlg</C>
##        adopts that order for strips of projective modules.
##        <P/>
##
##        If the injective module corresponding to the <C>j</C>th vertex of
##        <A>sba</A> is a string module, then
##        <C>InjectiveStripsOfSbAlg( sba )[j]</C> returns the strip describing
##        that string module. If not, then it returns &fail;.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "InjectiveStripsOfSbAlg", IsSpecialBiserialAlgebra );

##  <#GAPDoc Label="DocWidthOfStrip">
##    <ManSection>
##      <Oper Name="WidthOfStrip" Arg="strip"/>
##      <Description>
##        Argument: <A>strip</A>, a strip
##        <Br />
##      </Description>
##      <Returns>
##        a nonnegative integer, counting the number (with multiplicity) of
##        syllables of <A>strip</A> are nonstationary.
##      </Returns>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation( "WidthOfStrip", [ IsStripRep ] );

##  <#GAPDoc Label="DocIsZeroStrip">
##    <ManSection>
##      <Prop Name="IsZeroStrip" Arg="strip"/>
##      <Description>
##        Argument: <A>strip</A>, a strip
##        <Br />
##      </Description>
##      <Returns
##        &true; if <A>strip</A> is the zero strip of some SB algebra, and
##        &false; otherwise.
##      </Returns>
##      <Description>
##        Note that &sbstrips; knows which SB algebra <A>strip</A> belongs to.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsZeroStrip", IsStripRep );

##  <#GAPDoc Label="DocIsPeriodicStripByNthSyzygy">
##    <ManSection>
##      <Oper Name="IsPeriodicStripByNthSyzygy" Arg="strip, N"/>
##      <Description>
##        Arguments: <A>strip</A>, a strip; <A>N</A>, a positive integer
##        <Br />
##      </Description>
##      <Returns>
##        &true; if <A>strip</A> is appears among its own first <A>N</A>
##        syzygies, and &false; otherwise.
##      </Returns>
##      <Description>
##        If the call to this function returns &true;, then it will also print
##        the index of the syzygy at which <A>strip</A> first appears.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation( "IsPeriodicStripByNthSyzygy", [ IsStripRep, IsPosInt ] );

##  <#GAPDoc Label="DocIsFiniteSyzygyTypeStripByNthSyzygy">
##    <ManSection>
##    <Oper Name="IsFiniteSyzygyTypeStripByNthSyzygy" Arg="strip, N"/>
##      <Description>
##        Arguments: <A>strip</A>, a strip; <A>N</A>, a positive integer
##        <Br />
##      </Description>
##      <Returns>
##        &true; if the strips appearing in the <A>N</A>th syzygy of
##        <A>strip</A> have all appeared among earlier syzygies, and &false;
##        otherwise.
##      </Returns>
##      <Description>
##        If the call to this function returns &true;, then it will also print
##        the smallest <A>N</A> for which it would return &true;.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation(
 "IsFiniteSyzygyTypeStripByNthSyzygy",
 [ IsStripRep, IsPosInt ]
 );
 
# This is a temporary, informal function I intend to remove (or rename?)
##  <GAPDoc Label="DocTestInjectivesStripsUpToNthSyzygy">
##    <ManSection>
##      <Func Name="TestInjectivesStripsUpToNthSyzygy" Arg="sba, N"/>
##      <Description>
##        Arguments: <A>sba</A> a special biserial algebra (ie, <Ref
##        Prop="IsSpecialBiserialAlgebra" BookName="QPA"/> returs &true;);
##        <A>N</A>, a positive integer
##        <Br />
##      </Description>
##      <Returns>
##        &true;, if all strips of injective string modules have finite syzygy
##        type by the <A>N</A>th syzygy, and &false; otherwise.
##      </Returns>
##      <Description>
##        This function calls <Ref Attr="InjectiveStripsOfSbAlg"/> for
##        <A>sba</A>, filters out all the &fail;s, and then checks each
##        remaining strip individually using <Ref
##        Oper="IsFiniteSyzygyTypeStripByNthSyzygy"/> (with second argument
##        <A>N</A>).
##        <P />
##
##        <E>Author's note.</E> For every special biserial algebra I test, this
##        function returns true for sufficiently large <A>N</A>. It suggests
##        that the injective cogenerator of a SB algebra always has finite
##        syzygy type. This condition implies many homological conditions of
##        interest (including the big finitistic dimension conjecture)!
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "TestInjectivesStripsUpToNthSyzygy" );

#########1#########2#########3#########4#########5#########6#########7#########
