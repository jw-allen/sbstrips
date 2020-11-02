DeclareRepresentation( "IsStripRep", IsPositionalObjectRep, [] );
DeclareRepresentation( "IsVirtualStripRep", IsStripRep, [] );

DeclareOperation( "SyllableListOfStripNC", [ IsStripRep ] );

DeclareAttribute( "StripFamilyOfSbAlg", IsSpecialBiserialAlgebra );
DeclareAttribute( "ZeroStripOfSbAlg", IsSpecialBiserialAlgebra );

##  <#GAPDoc Label="DocStripify">
##    <ManSection>
##      <Heading>
##        Stripify
##      </Heading>
##
##      <Meth Name="Stripify" Label="for an arrow, +/-1 and a list of integers"
##      Arg="arr, N, int_list"/>
##      <Description>
##        Arguments: <A>arr</A>, the residue of an arrow in a special biserial
##        algebra (see below); <A>N</A>, an integer which is either <C>1</C> or
##        <C>-1</C>; <A>int_list</A>, a (possibly empty) list of nonzero
##        integers whose entries are alternately positive and negative).
##        <P />
##        (Remember that residues of arrows in an quiver algebra can be easily
##        accessed using the <C>\.</C> operation. See <Ref Oper="."
##        Label="for a path algebra" BookName="QPA"/> for details and see below
##        for examples.)
##        <P />
##      </Description>
##      <Returns>
##        the strip specified by this data
##      </Returns>
##      <Description>
##        Recall that &SBStrips; uses strip objects to represent the kind of
##        decorated graph that representation theorists call "strings". Now,
##        suppose you draw that string on the page as a linear graph with some
##        arrows pointing to the right (the "positive" direction) and some to
##        the left (the "negative" direction). See further below for examples.
##        <P />
##        (Of course, this method assumes that the string contains at least one
##        arrow. There is a different, easier, method for strings comprising
##        only a single vertex. Namely <Ref Meth="Stripify"
##        Label="for paths of a special biserial algebra"/> called with the
##        residue of a vertex.)
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
##      </Description>
##
##      <Meth Name="Stripify" Label="for a path of a special biserial algebra"
##      Arg="path"/>
##      <Description>
##        Arguments: <A>path</A>, the residue (in a special biserial algebra)
##        of some path.
##        <P />
##        (Remember that residues of vertices and arrows can be easily accessed
##        using <Ref Oper="." Label="for a path algebra" BookName="QPA"/>, and
##        that these can be multiplied together using <Ref Oper="\*"
##        BookName="Reference"/> to make a path.)
##        <P />
##      </Description>
##      <Returns>
##        The strip corresponding to <A>path</A>
##      </Returns>
##      <Description>
##        Recall that uniserial modules are string modules. The uniserial
##        modules of a SB algebra are in <M>1</M>-to-<M>1</M> correspondence
##        with the paths <M>p</M> linearly independent from all other paths.
##        Therefore, this path is all you need to specify the strip.
##        <P />
##      </Description>
##
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation( "Stripify", [ IsMultiplicativeElement, IsInt, IsList ] );
DeclareOperation( "ReflectionOfStrip", [ IsStripRep ] );

##  <#GAPDoc Label="DocSyzygyOfStrip">
##    <ManSection>
##      <Heading>
##        SyzygyOfStrip
##      </Heading>
##
##      <Description>
##        (This attribute takes <M>1</M>st syzygies of strips. For higher
##        syzygies, <Ref Oper="NthSyzygyOfStrip" Label="for strips"/> may be
##        more convenient while <Ref Oper="CollectedNthSyzygyOfStrip"
##        Label="for strips"/> may be more efficient.)
##        <P />
##      </Description>
##
##		<Attr Name="SyzygyOfStrip" Label="for strips" Arg="strip"/>
##      <Description>
##		  Argument: <A>strip</A>, a strip
##        <Br />
##      </Description>
##      <Returns>
##        a list of strips, corresponding to the indecomposable direct summands
##        of the syzygy of <A>strip</A>
##        <P />
##      </Returns>
##
##		<Attr Name="SyzygyOfStrip" Label="for lists of strips" Arg="list"/>
##      <Description>
##        Argument: <A>list</A>, a list of strips
##        <Br />
##      </Description>
##      <Returns>
##        a list of strips, corresponding to the indecomposable direct summands
##        of the syzygy of the strips in <A>list</A>
##      </Returns>
##      <Description>
##        The syzygy of each strip in <A>list</A> is calculated. This gives
##        several lists of strips, which are then concatenated.
##        <P />
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
##      <Description>
##        This operation calculates <M>N</M>th syzygies of strips. For large
##        <M>N</M> (say, <M>N \geq 10</M>) consider using <Ref
##        Oper="CollectedNthSyzygyOfStrip" Label="for strips"/> instead, since
##        it is much more efficient.
##      </Description>
##
##      <Meth Name="NthSyzygyOfStrip" Label="for strips" Arg="strip, N"/>
##      <Description>
##        Arguments: <A>strip</A>, a strip; <A>N</A>, a positive integer
##        <P />
##      </Description>
##      <Returns>
##        a list of strips containing the indecomposable <A>N</A>th syzygy
##        strips of <A>strip</A>
##        <P />
##      </Returns>
##
##      <Meth Name="NthSyzygyOfStrip" Label="for lists of strips"
##      Arg="list, N"/>
##      <Description>
##        Argument: <A>list</A>, a list of strips; <A>N</A>, a positive integer
##        <P />
##      </Description>
##      <Returns>
##        the <A>N</A>th syzygy strips of each strip in <A>list</A> in turn, all in
##        a single list
##        <P />
##      </Returns>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation( "NthSyzygyOfStrip", [ IsStripRep, IsInt ] );

##	<#GAPDoc Label="DocCollectedSyzygyOfStrip">
##	  <ManSection>
##      <Heading>
##        CollectedSyzygyOfStrip
##      </Heading>
##
##      <Description>
##        This operation calculates syzygies, and then collects the result into
##        a collected list, using <Ref Oper="Collected" BookName="Reference"/>.
##        It has different methods, depending on whether its input is a single
##        strip, a (flat) list of strips or a collected list of strips.
##        <P />
##      </Description>
##
##		<Meth Name="CollectedSyzygyOfStrip" Label="for strips" Arg="strip"/>
##      <Description>
##        Argument: <A>strip</A>, a strip
##        <P />
##      </Description>
##      <Returns>
##        a collected list, whose elements are the syzygy strips of
##        <A>strip</A>
##        <P />
##      </Returns>
##      <Description>
##        This is equivalent to calling
##        <C>Collected( SyzygyOfStrip( </C><A>strip</A><C> ) )</C>.
##        <P />
##      </Description>
##
##      <Meth Name="CollectedSyzygyOfStrip" Label="for flat lists of strips"
##      Arg="list"/>
##      <Description>
##        Argument: <A>list</A>, a (flat) list of strips
##        <P />
##      </Description>
##      <Returns>
##        a collected list, whose elements are the syzygy strips of the strips
##        in <A>list</A>
##        <P />
##      </Returns>
##      <Description>
##        This is equivalent to calling
##        <C>Collected( SyzygyOfStrip( </C><A>list</A><C> ) )</C>.
##        <P />
##      </Description>
##
##      <Meth Name="CollectedSyzygyOfStrip"
##      Label="for collected lists of strips" Arg="clist"/>
##		<Description>
##		  Argument: <A>clist</A>, a collected list of strips
##		</Description>
##		<Returns>
##		  a collected list, whose elements are the syzygy strips of the strips
##        in <A>clist</A>
##		</Returns>
##	  </ManSection>
##	<#/GAPDoc>
DeclareOperation( "CollectedSyzygyOfStrip", [ IsStripRep ] );

##  <#GAPDoc Label="DocCollectedNthSyzygyOfStrip">
##    <ManSection>
##      <Heading>
##        CollectedNthSyzygyOfStrip
##      </Heading>
##
##      <Description>
##        This operation calculates <M>N</M>th syzygies of strips and collects
##        the result into a collected list. It has different methods, depending
##        on whether its input is a single strip, a (flat) list of strips or a
##        collected of strips.
##      </Description>
##
##      <Meth Name="CollectedNthSyzygyOfStrip" Label="for strips"
##      Arg="strip, N"/>
##      <Description>
##        Arguments: <A>strip</A>, a strip; <A>N</A>, a positive integer
##        <P />
##      </Description>
##      <Returns>
##        a collected list, whose entries are the <A>N</A>th syzygies of
##        <A>strip</A>
##        <P />
##     </Returns>
##
##      <Meth Name="CollectedNthSyzygyOfStrip" Label="for lists of strips"
##      Arg="list, N"/>
##      <Description>
##        Arguments: <A>list</A>, a (flat) list of strips; <A>N</A>, a positive
##        integer
##        <P />
##      </Description>
##      <Returns>
##        a collected list, whose entries are the <A>N</A>th syzygies of the
##        strips in <A>list</A>
##        <P />
##      </Returns>
##
##      <Meth Name="CollectedNthSyzygyOfStrip"
##      Label="for collected lists of strips" Arg="list, N"/>
##      <Description>
##        Arguments: <A>clist</A>, a collected list of strips; <A>N</A>, a
##        positive integer
##        <P />
##      </Description>
##      <Returns>
##        a collected list, whose entries are the <A>N</A>th syzygies of the
##        strips in <A>clist</A>
##      </Returns>
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
##        <P />
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
##        <P />
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
##        <P />
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
##        <P />
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
##        <P />
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

##  <#GAPDoc Label="DocIsWeaklyPeriodicStripByNthSyzygy">
##    <ManSection>
##      <Oper Name="IsWeaklyPeriodicStripByNthSyzygy" Arg="strip, N"/>
##      <Description>
##        Arguments: <A>strip</A>, a strip; <A>N</A>, a positive integer
##        <P />
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
##    <Oper Name="IsFiniteSyzygyTypeStripByNthSyzygy" Arg="strip, N"/>
##      <Description>
##        Arguments: <A>strip</A>, a strip; <A>N</A>, a positive integer
##        <P />
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
##        <P />
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

##  <#GAPDoc Label="DocModuleOfStrip">
##    <ManSection>
##      <Meth Name="ModuleOfStrip" Arg="strip" Label="for a strip"/>
##      <Description>
##        Argument: <A>strip</A>, a strip
##        <P />
##      </Description>
##      <Returns>
##        a right module for the SB algebra over which <A>strip</A> is defined
##      </Returns>
##      <Description>
##        The indecomposable modules for a SB algebra come in two kinds (over
##        an algebraically closed field, at least). One of those are <E>string
##        modules</E>, so-called because they may be described by the decorated
##        graphs that representation theorists call <E>strings</E> and which
##        the &SBStrips; package calls <E>strips</E>.
##        <P />
##        This operation returns the string module corresponding to the strip 
##        <A>strip</A>. More specifically, it gives that module as a quiver,
##        ultimately using <Ref Oper="RightModuleOverPathAlgebra"
##        Label="with dimension vector" BookName="QPA"/>.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation( "ModuleDataOfStrip", [ IsStripRep ] );
DeclareOperation( "ModuleOfStrip", [ IsStripRep ] );

#########1#########2#########3#########4#########5#########6#########7#########
