DeclareRepresentation( "IsStripRep", IsAttributeStoringRep, [ "data" ] );
DeclareRepresentation( "IsVirtualStripRep", IsStripRep, [] );

DeclareOperation( "IsCollectedListOfStripReps", [ IsList ] );
DeclareOperation( "IsFlatListOfStripReps", [ IsList ]  );

DeclareOperation( "SyllableListOfStripNC", [ IsStripRep ] );
DeclareOperation( "PathAndOrientationListOfStripNC", [ IsStripRep ] );
DeclareOperation( "DefiningDataOfStripNC", [ IsStripRep ] );

DeclareAttribute( "StripFamilyOfSBAlg", IsSpecialBiserialAlgebra );
DeclareAttribute( "ZeroStripOfSBAlg", IsSpecialBiserialAlgebra );

##  <#GAPDoc Label="DocStripify">
##    <ManSection>
##      <Heading>
##        Stripify
##      </Heading>
##
##      <Meth Name="Stripify" Label="for an arrow, +/-1 and a list of integers"
##      Arg="arr, N, int_list"/>
##      <Meth Name="Stripify" Label="for a path of a special biserial algebra"
##      Arg="path"/>
##      <Description>
##        Arguments (first method): <A>arr</A>, an arrow in a SB algebra
##        (see note below); <A>N</A>, an integer which is either <C>1</C> or
##        <C>-1</C>; <A>int_list</A>, a (possibly empty) list of nonzero
##        integers whose entries are alternately positive and negative).
##        <P />
##        Argument (second method): <A>path</A>, a path in a SB algebra.
##        <P />
##        (<E>Note.</E> Remember that vertices and arrows in a SB algebra,
##        which is to say the elements in the algebra corresponding to the
##        vertices and arrows of the quiver, can be easily accessed using <Ref
##        Oper="." Label="for a path algebra" BookName="QPA"/>, and that these
##        can be multiplied together using <Ref Oper="\*"
##        BookName="Reference"/> to make a path in the SB algebra.)
##        <Br />
##      </Description>
##      <Returns>
##        the strip specified by these data
##      </Returns>
##      <Description>
##        The first method is intended for specifying arbitrary string( graphs)
##        over a SB algebra to &GAP;. The second method is more specialized,
##        being intended for specifying those string( graph)s where all arrows
##        point in the same direction. This includes the vacuous case where the
##        string (graph) has no arrows.
##        <P /> 
##        For the first method, suppose you draw your string graph on the page
##        as a linear graph with some arrows pointing to the right (the
##        "positive" direction) and some to the left (the "negative"
##        direction). See further below for examples.
##        <P />
##        The first arrow (ie, the leftmost one drawn on the page) is
##        <A>arr</A>. If it points to the right (the "positive" direction),
##        then set <A>N</A> to be <C>1</C>. If it points to the left (the
##        "negative" direction), then set <A>N</A> to be <C>-1</C>.
##        <P />
##        Now, ignore that first arrow <A>arr</A> and look at the rest of the
##        graph. It is made up of several paths that alternately point
##        rightward and leftward. Each path has a <E>length</E>; that is, the
##        total number of arrows in it. Enter the lengths of these paths to
##        <A>int_list</A> in the order you read them, using positive numbers
##        for paths pointing rightwards and negative numbers for paths pointing
##        leftwards.
##        <P />
##        &SBStrips; will check that your data validily specify a strip. If it
##        doesn't think they do, then it will throw up an Error message.
##        <P />
##        For the second method, &SBStrips; directly infers the string (graph)
##        and the SB algebra directly from <A>path</A>.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation( "Stripify", [ IsMultiplicativeElement, IsInt, IsList ] );
DeclareOperation( "ReflectionOfStrip", [ IsStripRep ] );

DeclareOperation( "SBAlgOfStrip", [ IsStripRep ] );

##  <#GAPDoc Label="DocSyzygyOfStrip">
##    <ManSection>
##      <Heading>
##        SyzygyOfStrip
##      </Heading>
##
##		<Attr Name="SyzygyOfStrip" Label="for strips" Arg="strip"/>
##  <!--
##		<Attr Name="SyzygyOfStrip" Label="for lists of strips" Arg="list"/>
##  -->
##      <Description>
##		  Argument: <A>strip</A>, a strip
##  <!--
##        <P />
##        Argument (second method): <A>list</A>, a list of strips
##  -->    
##        <Br />
##      </Description>
##      <Returns>
##        a list of strips, corresponding to the indecomposable direct summands
##        of the syzygy of <A>strip</A>.
##      </Returns>
##      <Description>
##  <!--
##        The second method just calls the first method on each entry of
##        <A>list</A> and concatenates the results.
##        <P />
##  -->
##        For higher syzygies, <Ref Oper="NthSyzygyOfStrip"
##        Label="for strips"/> is probably more convenient and <Ref
##        Oper="CollectedNthSyzygyOfStrip" Label="for strips"/> probably more
##        efficient.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "SyzygyOfStrip", IsStripRep );

##	<#GAPDoc Label="DocNthSyzygyOfStrip">
##    <ManSection>
##      <Heading>
##        NthSyzygyOfStrip
##      </Heading>
##
##      <Meth Name="NthSyzygyOfStrip" Label="for strips" Arg="strip, N"/>
##  <!--    
##      <Meth Name="NthSyzygyOfStrip" Label="for lists of strips"
##      Arg="list, N"/>
##  -->
##      <Description>
##        Arguments: <A>strip</A>, a strip; <A>N</A>, a positive integer
##  <!--
##        <P />
##        Arguments (second method): <A>list</A>, a list of strips; <A>N</A>, a
##        positive integer
##  -->
##        <Br />
##      </Description>
##      <Returns>
##        a list of strips containing the indecomposable <A>N</A>th syzygy
##        strips of <A>strip</A>
##        <P />
##      </Returns>
##      <Description>
##  <!--
##        The second method simply calls the first method on each of the strips
##        in <A>list</A> and concatenates the results.
##        <P />
##  -->
##        For large <M>N</M> -- say, <M>N \geq 10</M> -- consider using <Ref
##        Oper="CollectedNthSyzygyOfStrip" Label="for strips"/> instead, since
##        it is much more efficient.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation( "NthSyzygyOfStrip", [ IsStripRep, IsInt ] );

##	<#GAPDoc Label="DocCollectedSyzygyOfStrip">
##	  <ManSection>
##      <Heading>
##        CollectedSyzygyOfStrip
##      </Heading>
##
##		<Meth Name="CollectedSyzygyOfStrip" Label="for strips" Arg="strip"/>
##  <!--
##      <Meth Name="CollectedSyzygyOfStrip" Label="for (flat) lists of strips"
##      Arg="list"/>
##      <Meth Name="CollectedSyzygyOfStrip"
##      Label="for collected lists of strips" Arg="clist"/>
##  -->
##      <Description>
##        Argument: <A>strip</A>, a strip
##  <!--
##        <P />
##        Argument (second method): <A>list</A>, a (flat) list of strips
##        <P />
##		  Argument (third method): <A>clist</A>, a collected list of strips
##  -->
##        <Br />
##      </Description>
##      <Returns>
##        a collected list, whose elements are the syzygy strips of
##        <A>strip</A>
##      </Returns>
##      <Description>
##        This is equivalent to calling
##        <C>Collected( SyzygyOfStrip( </C><A>strip</A><C> ) );</C>.
##  <!--
##        The second
##        method applies the first method to each entry in <A>list</A> and then
##        combines the result; this is equivalent to
##        <C>Collected( SyzygyOfStrip( </C><A>list</A><C> ) );</C>.
##        <P />
##  -->
##      </Description>
##	  </ManSection>
##	<#/GAPDoc>
DeclareOperation( "CollectedSyzygyOfStrip", [ IsStripRep ] );

##  <#GAPDoc Label="DocCollectedNthSyzygyOfStrip">
##    <ManSection>
##      <Heading>
##        CollectedNthSyzygyOfStrip
##      </Heading>
##      <Meth Name="CollectedNthSyzygyOfStrip" Label="for strips"
##      Arg="strip, N"/>
##  <!--
##      <Meth Name="CollectedNthSyzygyOfStrip" Label="for lists of strips"
##      Arg="list, N"/>
##      <Meth Name="CollectedNthSyzygyOfStrip"
##      Label="for collected lists of strips" Arg="list, N"/>
##  -->
##      <Description>
##        Arguments: <A>strip</A>, a strip; <A>N</A>, a positive integer.
##  <!--
##        <P />
##        Arguments (second method): <A>list</A>, a (flat) list of strips;
##        <A>N</A>, a positive integer.
##        <P />
##        Arguments (third method): <A>clist</A>, a collected list of strips;
##        <A>N</A>, a positive integer.
##  -->
##        <Br />
##      </Description>
##      <Returns>
##        a collected list, whose entries are the <A>N</A>th syzygies of
##        <A>strip</A>.
##  <!--
##        (first method), or of the strip in <A>list</A> (second
##        method) or in <A>clist</A> (third method), taking multiplicities of
##        elements into account in latter case
##        <P />
##  -->
##     </Returns>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation( "CollectedNthSyzygyOfStrip", [ IsStripRep, IsInt ] );

DeclareGlobalFunction( "StripifyFromSyllablesAndOrientationsNC" );
DeclareGlobalFunction( "StripifyFromSBAlgPathNC" );
DeclareGlobalFunction( "StripifyVirtualStripNC" );

##  <#GAPDoc Label="DocSimpleStripsOfSBAlg">
##    <ManSection>
##      <Attr Name="SimpleStripsOfSBAlg" Arg="sba"/>
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
##        vertices of that quiver are ordered; <C>SimpleStripsOfSBAlg</C>
##        adopts that order for strips of simple modules.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "SimpleStripsOfSBAlg", IsSpecialBiserialAlgebra );

##  <#GAPDoc Label="DocProjectiveStripsOfSBAlg">
##    <ManSection>
##      <Attr Name="ProjectiveStripsOfSBAlg" Arg="sba"/>
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
##        vertices of that quiver are ordered; <C>ProjectiveStripsOfSBAlg</C>
##        adopts that order for strips of projective modules.
##        <P/>
##
##        If the projective module corresponding to the <C>j</C>th vertex of
##        <A>sba</A> is a string module, then
##        <C>ProjectiveStripsOfSBAlg( sba )[j]</C> returns the strip describing
##        that string module. If not, then it returns &fail;.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "ProjectiveStripsOfSBAlg", IsSpecialBiserialAlgebra );

##  <#GAPDoc Label="DocInjectiveStripsOfSBAlg">
##    <ManSection>
##      <Attr Name="InjectiveStripsOfSBAlg" Arg="sba"/>
##      <Description>
##        Argument: <A>sba</A>, a special biserial algebra
##        <Br />
##      </Description>
##      <Returns>
##        a list <C>inj_list</C>, whose entries are either strips or the
##        boolean &fail;. 
##      </Returns>
##      <Description>
##        You will have specified <A>sba</A> to &GAP; via some quiver. The
##        vertices of that quiver are ordered; <C>InjectiveStripsOfSBAlg</C>
##        adopts that order for strips of projective modules.
##        <P/>
##
##        If the injective module corresponding to the <C>j</C>th vertex of
##        <A>sba</A> is a string module, then
##        <C>InjectiveStripsOfSBAlg( sba )[j]</C> returns the strip describing
##        that string module. If not, then it returns &fail;.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "InjectiveStripsOfSBAlg", IsSpecialBiserialAlgebra );

##  <#GAPDoc Label="DocUniserialStripsOfSBAlg">
##    <ManSection>
##      <Attr Name="UniserialStripsOfSBAlg" Arg="sba"/>
##      <Description>
##        Argument: <A>sba</A>, a special biserial algebra
##        <Br />
##      </Description>
##      <Returns>
##        a list of the strips that correspond to uniserial modules for
##        <A>sba</A>
##      </Returns>
##      <Description>
##        Simple modules are uniserial, therefore every element of <Ref
##        Attr="SimpleStripsOfSBAlg"/> will occur in this list too.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "UniserialStripsOfSBAlg", IsSpecialBiserialAlgebra );

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
##      <Returns>
##        &true; if <A>strip</A> is the zero strip of some SB algebra, and
##        &false; otherwise.
##      </Returns>
##      <Description>
##        Note that &SBStrips; knows which SB algebra <A>strip</A> belongs to.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsZeroStrip", IsStripRep );

##  <#GAPDoc Label="DocIsWeaklyPeriodicStripByNthSyzygy">
##    <ManSection>
##      <Oper Name="IsWeaklyPeriodicStripByNthSyzygy" Arg="strip, N"/>
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
DeclareOperation( "IsWeaklyPeriodicStripByNthSyzygy", [ IsStripRep, IsPosInt ]
 );

##  <#GAPDoc Label="DocIsFiniteSyzygyTypeStripByNthSyzygy">
##    <ManSection>
##      <Oper Name="IsFiniteSyzygyTypeStripByNthSyzygy" Arg="strip, N"/>
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
##        Arguments: <A>sba</A>, a special biserial algebra (ie, <Ref
##        Prop="IsSpecialBiserialAlgebra" BookName="QPA"/> returs &true;);
##        <A>N</A>, a positive integer
##        <Br />
##      </Description>
##      <Returns>
##        &true;, if all strips of injective string modules have finite syzygy
##        type by the <A>N</A>th syzygy, and &false; otherwise.
##      </Returns>
##      <Description>
##        This function calls <Ref Attr="InjectiveStripsOfSBAlg"/> for
##        <A>sba</A>, filters out all the &fail;s, and then checks each
##        remaining strip individually using <Ref
##        Oper="IsFiniteSyzygyTypeStripByNthSyzygy"/> (with second argument
##        <A>N</A>).
##        <P />
##
##        <E>Author's note.</E> For every special biserial algebra the author 
##        has tested, this function returns true (for sufficiently large
##        <A>N</A>). It suggests  that the minimal injective cogenerator of a
##        SB algebra always has finite syzygy type. This condition implies many
##        homological conditions of interest (including the big finitistic
##        dimension conjecture)!
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "TestInjectiveStripsUpToNthSyzygy" );

##  <#GAPDoc Label="DocModuleOfStrip">
##    <ManSection>
##      <Meth Name="ModuleOfStrip" Arg="strip"/>
##  <!--
##      <Meth Name="ModuleOfStrip" Arg="list"
##      Label="for a (flat) list of strips"/>
##      <Meth Name="ModuleOfStrip" Arg="clist"
##      Label="for a collected list of strips"/>
##  -->
##      <Description>
##        Argument: a strip <A>strip</A>.
##  <!--
##        <P />
##        Argument (second method): a list <A>list</A> of strips.
##        <P />
##        Argument (third method): a collected list <A>clist</A> of strips.
##  -->
##        <Br />
##      </Description>
##      <Returns>
##        a right module for the SB algebra over which <A>strip</A> is defined,
##        or a list or collected list of the modules associated to the strips
##        in <A>list</A> or <A>clist</A> respectively.
##      </Returns>
##      <Description>
##        This operation returns the string module corresponding to the strip
##        <A>strip</A>. More specifically, it gives that module as a quiver,
##        ultimately using <Ref Oper="RightModuleOverPathAlgebra"
##        Label="with dimension vector" BookName="QPA"/>.
##  <!--
##        <P />
##        The second and third methods apply the first method to
##        each strip in <A>list</A> or in <A>clist</A> respectively, returning
##        a list or collected list of modules as befits.
##  -->
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation( "ModuleDataOfStrip", [ IsStripRep ] );
DeclareOperation( "ModuleOfStrip", [ IsStripRep ] );

##  <#GAPDoc Label="DocDirectSumModuleOfListOfStrips">
##    <ManSection>
##      <Meth Name="DirectSumModuleOfListOfStrips"
##      Label="for a (flat) list of strips" Arg="list"/>
##      <Meth Name="DirectSumModuleOfListOfStrips"
##      Label="for a collected list of strips" Arg="clist"/>
##      <Description>
##        Argument (first method): <A>list</A>, a list of strips
##        <P />
##        Argument (second method): <A>clist</A>, a collected list of strips
##        <Br />
##      </Description>
##      <Returns>
##        the quiver representation corresponding to the direct sum of
##        <M>A</M>-modules whose indecomposable direct summands are specified
##        by <A>list</A> or <A>clist</A>.
##      </Returns>
##      <Description>
##        The methods for this operation make the obvious requirement that all
##        strips present belong to the the same SB algebra.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation( "DirectSumModuleDataOfListOfStrips", [ IsList ] );
DeclareOperation( "DirectSumModuleOfListOfStrips", [ IsList ] );

##  <#GAPDoc Label="DocVectorSpaceDualOfStrip"/>
##    <ManSection>
##      <Attr Name="VectorSpaceDualOfStrip" Arg="strip"/>
##      <Attr Name="OppositeStrip" Arg="strip"/>
##      <Attr Name="DOfStrip" Arg="strip"/>
##      <Description>
##        Argument: <A>strip</A>, a strip representing some string module
##        <M>X</M> over a <M>K</M>-algebra <M>A</M>.
##        <Br />
##      </Description>
##      <Returns>
##        a strip representing the vector-space dual module
##        <M>\D M = \Hom_K(X,K)</M> of <M>X</M>.
##      </Returns>
##      <Description>
##        Recall that <M>\D X</M> is a module for <M>A^\op</M>, the opposite
##        algebra to <M>A</M>.
##        <P />
##        <C>OppositeStrip</C> and <C>DOfStrip</C> are synonyms for
##        <C>VectorSpaceDualOfStrip</C>.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "VectorSpaceDualOfStrip", IsStripRep );
DeclareSynonymAttr( "OppositeStrip", VectorSpaceDualOfStrip );
DeclareSynonymAttr( "DOfStrip", VectorSpaceDualOfStrip );

##  <#GAPDoc Label="DocTrDOfStrip">
##    <ManSection>
##      <Attr Name="TrDOfStrip" Arg="strip"/>
##      <Attr Name="ARInverseTranslateOfStrip" Arg="strip"/>
##      <Description>
##        Argument: <A>strip</A>, a strip representing some string module
##        <M>X</M>.
##        <Br />
##      </Description>
##      <Returns>
##        a strip representing the Auslander-Reiten inverse translate
##        <M>\Tr \D X</M> of <M>X</M>.
##      </Returns>
##      <Description>
##        Recall that if <M>X</M> is injective then <M>\Tr \D X = 0</M>.
##        <P />
##        <C>ARInverseTranslateOfStrip</C> is a synonym for <C>TrDOfStrip</C>.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "LeftAlterationTowardsTrDOfStrip", IsStripRep );
DeclareAttribute( "RightAlterationTowardsTrDOfStrip", IsStripRep );
DeclareAttribute( "TrDOfStrip", IsStripRep );
DeclareSynonymAttr( "ARInverseTranslateOfStrip", IsStripRep );

##  <#GAPDoc Label="DocTransposeOfStrip">
##    <ManSection>
##      <Attr Name="TransposeOfStrip" Arg="strip"/>
##      <Attr Name="TrOfStrip" Arg="strip"/>
##      <Description>
##        Argument: <A>strip</A>, a strip representing some string module
##        <M>X</M>.
##        <Br />
##      </Description>
##      <Returns>
##        a strip representing the transpose <M>\Tr X</M> of <M>X</M>.
##      </Returns>
##      <Description>
##        Recall that if <M>X</M> is an <M>A</M>-module, then <M>\Tr X</M> is
##        an <M>A^\op</M>-module.
##        <P />
##        <C>TrOfStrip</C> is a synonym for <C>TransposeOfStrip</C>.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "TrOfStrip", IsStripRep );
DeclareSynonymAttr( "TransposeOfStrip", TrOfStrip );

##  <#GAPDoc Label="DocDTrOfStrip">
##    <ManSection>
##      <Attr Name="DTrOfStrip" Arg="strip"/>
##      <Attr Name="ARTranslateOfStrip" Arg="strip"/>
##      <Description>
##        Argument: <A>strip</A>, a strip representing some string module
##        <M>X</M>.
##        <Br />
##      </Description>
##      <Returns>
##        a strip representing the Auslander-Reiten translate <M>\D \Tr X</M>
##        of <M>X</M>.
##      </Returns>
##      <Description>
##        Recall that if <M>X</M> is projective then <M>\D \Tr X = 0</M>.
##        <P />
##        <C>ARTranslateOfStrip</C> is a synonym for <C>DTrOfStrip</C>.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "DTrOfStrip", IsStripRep );
DeclareSynonymAttr( "ARTranslateOfStrip", DTrOfStrip );

##  <#GAPDoc Label="DocSuspensionOfStrip">
##    <ManSection>
##      <Attr Name="SuspensionOfStrip" Arg="strip"/>
##      <Description>
##        Argument: <A>strip</A>, a strip representing some string module
##        <M>X</M>
##        <Br />
##      </Description>
##      <Returns>
##        a list of strips, representing the indecomposable direct summands of
##        the suspension <M>\suspension X = \Tr \syzygy \Tr X</M> of <M>X</M>
##      </Returns>
##    </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "SuspensionOfStrip", IsStripRep );

##  <#GAPDoc Label="DocIsStripDirectSummand">
##    <ManSection>
##      <Oper Name="IsStripDirectSummand" Arg="strip_or_strips, list"/>
##      <Description>
##        Arguments: <A>strip_or_strips</A>, a strip or list of strips or
##        collected list of strips; <A>list</A>, a list or collected list of
##        strips.
##        <Br />
##      </Description>
##      <Returns>
##        &true; if the string module represented by <A>strip_or_strips</A> is
##        a direct summand of the string module represented by the strips in
##        <A>list</A>, and &false; otherwise.
##      </Returns>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation( "IsStripDirectSummand", [ IsList, IsList ] );

##  <#GAPDoc Label="DocIsIndecProjectiveStrip">
##    <ManSection>
##      <Prop Name="IsIndecProjectiveStrip" Arg="strip"/>
##      <Description>
##        Arguments: <A>strip</A>, a strip.
##      </Description>
##      <Returns>
##        &true; if <A>strip</A> represents a indecomposable projective string
##        module, and &false; otherwise. (The indecomposability requirement
##        means this returns &false; on zero strips.)
##      </Returns>
##    </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsIndecProjectiveStrip", IsStripRep );

##  <#GAPDoc Label="DocIsIndecInjectiveStrip">
##    <ManSection>
##      <Prop Name="IsIndecInjectiveStrip" Arg="strip"/>
##      <Description>
##        Arguments: <A>strip</A>, a strip.
##      </Description>
##      <Returns>
##        &true; if <A>strip</A> represents a indecomposable injective string
##        module, and &false; otherwise. (The indecomposability requirement
##        means this returns &false; on zero strips.)
##      </Returns>
##    </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsIndecInjectiveStrip", IsStripRep );

##  <#GAPDoc Label="DocWithoutProjectiveStrips">
##    <ManSection>
##      <Oper Name="WithoutProjectiveStrips" Arg="list"/>
##      <Description>
##        Argument: <A>list</A>, a list or collected list of strips
##      </Description>
##      <Returns>
##        a new list or collected list <A>new_list</A> obtained from
##        <A>list</A> by removing all the projective strips.
##      </Returns>
##    </ManSection>
##  <#/GAPDoc>