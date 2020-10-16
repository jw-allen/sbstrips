DeclareRepresentation( "IsStripRep", IsPositionalObjectRep, [] );
DeclareRepresentation( "IsVirtualStripRep", IsStripRep, [] );

DeclareOperation( "SyllableListOfStripNC", [ IsStripRep ] );

DeclareAttribute( "StripFamilyOfSbAlg", IsSpecialBiserialAlgebra );
DeclareAttribute( "ZeroStripOfSbAlg", IsSpecialBiserialAlgebra );

DeclareOperation( "Stripify", [ IsList ] );
DeclareOperation( "ReflectionOfStrip", [ IsStripRep ] );

##	<#GAPDoc Label="DocSyzygyOfStrip">
##	  <ManSection>
##      <Oper Name="SyzygyOfStrip" Arg="strip_or_list" />
##      <Description>
##        This operation calculates syzygies of strips. It has different
##        methods, depending on whether its input is a single strip or a list
##        of strips.
##      </Description>
##		<Meth Name="SyzygyOfStrip" Label="for strips" Arg="strip"/>
##		<Meth Name="SyzygyOfStrip" Label="for lists of strips" Arg="list"/>
##		<Description>
##		  Argument: <A>strip</A>, a strip (in the first method); <A>list</A>, a
##        list of strips (in the second method)
##		</Description>
##		<Returns>
##		  a list of strips
##		</Returns>
##		<Description>
##		  In the first method, the syzygy of the strip <A>strip</A> is
##        calculated and its summands are returned in a list. In the second
##        method, the syzygy of each strip in <A>list</A> is calculated and
##        their summands returned in a single list.
##        <P />
##
##        These calculations can be iterated using <Ref
##        Oper="NthSyzygyOfStrip"/> and performed more efficiently using <Ref
##        Oper="CollectedSyzygyOfStrip"/> or <Ref
##        Oper="CollectedNthSyzygyOfStrip"/>.
##		</Description>
##	  </ManSection>
##	<#/GAPDoc>
DeclareOperation( "SyzygyOfStrip", [ IsStripRep ] );

##	<#GAPDoc Label="DocNthSyzygyOfStrip">
##	  <ManSection>
##      <Oper Name="NthSyzygyOfStrip" Arg="strip_or_list, N"/>
##      <Description>
##        This operation calculates <A>N</A>th syzygies of strips. It has
##        different methods, depending on whether its input is a single strip
##        or a list of strips.
##      </Description>
##		<Meth Name="NthSyzygyOfStrip" Label="for strips" Arg="strip, N"/>
##		<Meth Name="NthSyzygyOfStrip" Label="for lists of strips"
##      Arg="list, N"/>
##		<Description>
##		  Argument: <A>strip</A>, a strip (in the first method), or
##        <A>list</A>, a list of strips (in the second method); <A>N</A>, a
##        nonnegative integer
##		</Description>
##		<Returns>
##		  a list of strips
##		</Returns>
##		<Description>
##		  In the first method, the <A>N</A>th syzygy of <A>strip</A> is
##        calculated and its summands are returned in a list. In the second
##        method, the <A>N</A>th syzygy of <A>strip</A> is calculated and their
##        symmands are returned in a single list.
##        <P />
##
##        This operation iterates <Ref Oper="SyzygyOfStrip"/>. When the result
##        has a lot of summands, as is often the case for large <A>N</A>, <Ref
##        Oper="CollectedNthSyzygyOfStrip"/> is more efficient.
##		</Description>
##	  </ManSection>
##	<#/GAPDoc>
DeclareOperation( "NthSyzygyOfStrip", [ IsStripRep, IsInt ] );

##	<#GAPDoc Label="DocCollectedSyzygyOfStrip">
##	  <ManSection>
##      <Oper Name="CollectedSyzygyOfStrip" Arg="strip_or_list_or_clist"/>
##      <Description>
##        This operation calculates syzygies, and then collects the result into
##        a multiset-like list, using <Ref Oper="Collected"
##        BookName="Reference"/>. It has different methods, depending on
##        whether its input is a single strip, a (flat) list of strips or a
##        collected list of strips.
##      </Description>
##		<Meth Name="CollectedSyzygyOfStrip" Label="for strips" Arg="strip"/>
##      <Meth Name="CollectedSyzygyOfStrip" Label="for flat lists of strips"
##      Arg="list"/>
##      <Meth Name="CollectedSyzygyOfStrip"
##      Label="for collected lists of strips" Arg="clist"/>
##		<Description>
##		  Argument: <A>strip</A>, a strip (in the first method), or
##        <A>list</A>, a (flat) list of strips (in the second method), or
##        <A>clist</A>, a collected list of strips (in the third method)
##		</Description>
##		<Returns>
##		  a collected list of strips
##		</Returns>
##	  </ManSection>
##	<#/GAPDoc>
DeclareOperation( "CollectedSyzygyOfStrip", [ IsStripRep ] );

##  <#GAPDoc Label="DocCollectedNthSyzygyOfStrip">
##    <ManSection>
##      <Oper Name="CollectedNthSyzygyOfStrip"
##      Arg="strip_or_list_or_clist, N"/>
##      <Description>
##        This operation calculates <A>N</A>th syzygies of strips, and collects
##        the result into a multiset-like list, using <Ref Oper="Collected"
##        BookName="Reference"/>. It has different methods, depending on
##        whether its input is a single strip, a (flat) list of strips or a
##        collected list of strips.
##      </Description>
##		<Meth Name="CollectedNthSyzygyOfStrip" Label="for strips"
##      Arg="strip, N"/>
##      <Meth Name="CollectedNthSyzygyOfStrip"
##      Label="for flat lists of strips, N"
##      Arg="list, N"/>
##      <Meth Name="CollectedNthSyzygyOfStrip"
##      Label="for collected lists of strips" Arg="clist"/>
##		<Description>
##		  Argument: <A>strip</A>, a strip (in the first method), or
##        <A>list</A>, a (flat) list of strips (in the second method), or
##        <A>clist</A>, a collected list of strips (in the third method);
##        <A>N</A> a nonnegative integer
##		</Description>
##		<Returns>
##		  a collected list of strips
##		</Returns>
##      <Description>
##        The input to each method gives rise to a collected list of strips:
##        respectively, <C>Collected( [ strip ] )</C>, <C>Collected( list )</C>
##        or <C>clist</C>. Once the input strips have been collected in this
##        manner, &GAP; only needs to calculate the syzygy of each unique input
##        strip once and then multiply the frequency of each syzygy summand by
##        the number of instances of the input strip. This eliminates much of
##        the duplicated effort to which <Ref Oper="NthSyzygyOfStrip"/> is
##        liable.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation( "CollectedNthSyzygyOfStrip", [ IsStripRep, IsInt ] );

DeclareGlobalFunction( "StripifyFromSyllablesAndOrientationsNC" );
DeclareGlobalFunction( "StripifyFromSbAlgPathNC" );
DeclareGlobalFunction( "StripifyVirtualStripNC" );

##  <#GAPDoc Label="DocSimpleStripsOfSbAlg">
##    <ManSection>
##      <Attr Name="SimpleStripsOfSbAlg" Arg="sba"/>
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
##      <Attr Name="ProjectiveStripsOfSbAlg" Arg="sba"/>
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
##      <Attr Name="InjectiveStripsOfSbAlg" Arg="sba"/>
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
 
##  <#GAPDoc Label="DocTestInjectiveStripsUpToNthSyzygy">
##    <ManSection>
##      <Func Name="TestInjectiveStripsUpToNthSyzygy" Arg="sba, N"/>
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
DeclareGlobalFunction( "TestInjectiveStripsUpToNthSyzygy" );

#########1#########2#########3#########4#########5#########6#########7#########
