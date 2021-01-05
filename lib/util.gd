# Some functionalities that could be present in GAP or QPA but are not

##  For GAP

DeclareOperation( "ForwardOrbitUnderFunctionNC", [ IsObject, IsFunction ] );

DeclareOperation( "IsTransientUnderFunctionNC",
 [ IsObject, IsFunction, IsObject ]
 );
 
DeclareOperation( "IsPreperiodicUnderFunctionNC",
 [ IsObject, IsFunction, IsObject ]
 );

DeclareOperation( "IsPeriodicUnderFunctionNC",
 [ IsObject, IsFunction, IsObject ]
 );

##  <#GAPDoc Label="DocIsCollectedList">
##    <ManSection>
##      <Prop Name="IsCollectedList" Arg="list"/>
##      <Description>
##        Argument: <A>list</A>, a list
##        <Br />
##      </Description>
##      <Returns>
##        &true; if all entries of <A>list</A> are lists of length <M>2</M>
##        having a positive integer in their second entry, and &false;
##        otherwise.
##      </Returns>
##      <Description>
##        This property will return &true; on lists returned from the &GAP;
##        operation <Ref Oper="Collected" BookName="Reference"/>, as well as on
##        combinations of such lists using <Ref Func="Concatenation"
##        BookName="Reference"/> or <Ref Oper="Append" BookName="Reference"/>.
##        This is the principal intended use of this property.
##        <P />
##
##        When this document refers to a <E>collected list</E>, it means a list
##        for which <Ref Prop="IsCollectedList"/> returns &true;.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsCollectedList", IsList );

##  <#GAPDoc Label="DocIsCollectedDuplicateFreeList">
##    <ManSection>
##      <Prop Name="IsCollectedDuplicateFreeList" Arg="clist"/>
##      <Description>
##        Argument: <A>clist</A>
##        <Br />
##      </Description>
##      <Returns>
##        &true; if <A>clist</A> is a collected list with no repeated elements
##      </Returns>
##      <Description>
##        In particular, if <A>clist</A> was created by applying <Ref
##        Oper="Collected" BookName="Reference"/> to a duplicate-free list (see
##        <Ref Filt="IsDuplicateFreeList" BookName="Reference"/>), then this
##        property will return &true;. This is the principal intended use of
##        this property.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsCollectedDuplicateFreeList", IsList );

##  <#GAPDoc Label="DocIsCollectedHomogeneousList">
##    <ManSection>
##      <Prop Name="IsCollectedHomogeneousList" Arg="clist"/>
##      <Description>
##        Argument: <A>clist</A>, a collected list
##        <Br />
##      </Description>
##      <Returns>
##        &true; if the elements of <C>clist</C> form a homogeneous list, and
##        &false; otherwise
##      </Returns>
##      <Description>
##        If <C>obj</C> is the result of applying <Ref Oper="Collected"
##        BookName="Reference"/> to a homogeneous list, then this property
##        returns &true;. This is the principal intended use of this property.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsCollectedHomogeneousList", IsList );

##  <#GAPDoc Label="DocCollectedLength">
##    <ManSection>
##      <Attr Name="CollectedLength" Arg="clist"/>
##      <Description>
##        Argument: <A>clist</A>, a collected list
##        <Br />
##      </Description>
##      <Returns>
##        the sum of the multiplicities in <A>clist</A>
##      </Returns>
##    </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "CollectedLength", IsList );

##  <#GAPDoc Label="DocRecollected">
##    <ManSection>
##      <Oper Name="Recollected" Arg="clist"/>
##      <Description>
##        Argument: <A>clist</A>, a collected list
##        <Br />
##      </Description>
##      <Returns>
##        a collected list, removing repeated elements in <A>clist</A> and
##        totalling their multiplicities.
##      </Returns>
##      <Description>
##        If <A>clist</A> contains entries with matching first entries, say
##        <C>[ obj, n ]</C> and <C>[ obj, m ]</C>, then it will combine them
##        into a single entry <C>[ obj, n+m ]</C> with totalised multiplicity.
##        This can be necessary when dealing with concatenations (see <Ref
##        Func="Concatenation" BookName="Reference"/>) of collected lists.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation( "Recollected", [ IsList ] );

##  <#GAPDoc Label="DocUncollected">
##    <ManSection>
##      <Oper Name="Uncollected" Arg="clist"/>
##      <Description>
##        Argument: <A>clist</A>, a collected list
##        <Br />
##      </Description>
##      <Returns>
##        a (flat) list, where each element in <A>clist</A> appears with the
##        appropriate multiplicity
##      </Returns>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation( "Uncollected", [ IsList ] );

##  <#GAPDoc Label="DocCollectedListElementwiseFunction">
##    <ManSection>
##      <Oper Name="CollectedListElementwiseFunction" Arg="clist, func"/>
##      <Description>
##        Arguments: <A>clist</A>, a collected list; <A>func</A>, a function
##        <Br />
##      </Description>
##      <Returns>
##        a new collected list, obtained from <A>clist</A> by applying
##        <A>func</A> to each element.
##      </Returns>
##      <Description>
##        If <A>func</A> returns lists (perhaps because it implements a
##        "many-valued function"), consider using <Ref
##        Oper="CollectedListElementwiseListValuedFunction"/> instead. 
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation( "CollectedListElementwiseFunction", [ IsList, IsFunction ] );

##  <#GAPDoc Label="DocCollectedListElementwiseListValuedFunction">
##    <ManSection>
##      <Oper Name="CollectedListElementwiseListValuedFunction"
##      Arg="clist, func"/>
##      <Description>
##        Arguments: <A>clist</A>, a collected list; <A>func</A>, a function
##        (presumed to return lists of objects).
##        <Br />
##      </Description>
##      <Returns>
##        a new collected list.
##      </Returns>
##      <Description>
##        Imagine <A>clist</A> were unpacked into a flat list, <A>func</A> were
##        applied to each element of the flat list in turn and the result
##        concatenated then collected. That is what this operation returns
##        (although it determines the result more efficiently than the
##        procedure just described).
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation(
 "CollectedListElementwiseListValuedFunction", [ IsList, IsFunction ]
 );

##  <#GAPDoc Label="DocElementsOfCollectedList">
##    <ManSection>
##      <Oper Name="ElementsOfCollectedList" Arg="clist"/>
##      <Description>
##        Argument: <A>clist</A>, a collected list.
##        <Br />
##      </Description>
##      <Returns>
##        the elements of <A>clist</A>.
##      </Returns>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation( "ElementsOfCollectedList", [ IsList ] );

##  For QPA

##  <#GAPDoc Label="DocStringMethodForPaths">
##    <ManSection>
##      <Meth Name="String" Arg="path" Label="for paths of length at least 2"/>
##      <Description>
##        Argument: <A>path</A>, a path of length at least <M>2</M> in a quiver
##        (see <Ref Filt="IsPath" BookName="QPA"/> and <Ref Attr="LengthOfPath"
##        BookName="QPA"/> for details)
##        <Br />
##      </Description>
##      <Returns>
##        a string describing <A>path</A>
##      </Returns>
##      <Description>
##        Methods for <Ref Attr="String" BookName="Reference"/> already exist
##        for vertices and arrows of a quiver; that is to say, paths of length
##        <M>0</M> or <M>1</M>. &QPA; forgets these for longer paths: at
##        present, only the default answer <C>"&lt;object&gt;"</C> is returned.
##        <P />
##        A path in &QPA; is products of arrows. Accordingly, we write its
##        string as a <C>*</C>-separated sequences of its constituent arrows.
##        This is in-line with how paths are printed using <Ref Oper="ViewObj"
##        BookName="Reference"/>.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
# OBVIOUSLY, THE ATTRIBUTE <String> DOES NOT NEED DECLARING!

##  <#GAPDoc Label="DocArrowsOfQuiverAlgebra">
##    <ManSection>
##      <Oper Name="ArrowsOfQuiverAlgebra" Arg="alg"/>
##      <Description>
##        Argument: <A>alg</A>, a quiver algebra
##        <Br />
##      </Description>
##      <Returns>
##        the residues of the arrows in the defining quiver of <A>alg</A>, 
##        listed together
##      </Returns>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation( "ArrowsOfQuiverAlgebra", [ IsQuiverAlgebra ] );

##  <#GAPDoc Label="DocVerticesOfQuiverAlgebra">
##    <ManSection>
##      <Oper Name="VerticesOfQuiverAlgebra" Arg="alg"/>
##      <Description>
##        Argument: <A>alg</A>, a quiver algebra
##        <Br />
##      </Description>
##      <Returns>
##        the residues of the vertices in the defining quiver of <A>alg</A>, 
##        listed together
##      </Returns>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation( "VerticesOfQuiverAlgebra", [ IsQuiverAlgebra ] );

##  <#GAPDoc Label="DocFieldOfQuiverAlgebra">
##    <ManSection>
##      <Oper Name="FieldOfQuiverAlgebra" Arg="alg"/>
##      <Description>
##        Argument: <A>alg</A>, a quiver algebra
##        <Br />
##      </Description>
##      <Returns>
##        the field of definition of <A>alg</A>
##      </Returns>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation( "FieldOfQuiverAlgebra", [ IsQuiverAlgebra ]  );

##  <#GAPDoc Label="DocDefiningQuiverOfQuiverAlgebra">
##    <ManSection>
##      <Oper Name="DefiningQuiverOfQuiverAlgebra" Arg="alg"/>
##      <Description>
##        Argument: <A>alg</A>, a quiver algebra
##        <Br />
##      </Description>
##      <Returns>
##        the quiver of definition of <A>alg</A>
##      </Returns>
##      <Description>
##        This single operation performs <Ref Attr="OriginalPathAlgebra"
##        BookName="QPA"/> and then <Ref Attr="QuiverOfPathAlgebra"
##        BookName="QPA"/>
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation( "DefiningQuiverOfQuiverAlgebra", [ IsQuiverAlgebra ] );

##  <#GAPDoc Label="DocPathOneArrowDifferent">
##  <ManSection>
##    <Heading>
##      Paths obtained by adding/removing an arrow at source/target
##    </Heading>
##    <Attr Name="PathOneArrowLongerAtSource" Arg="path"/>
##    <Attr Name="PathOneArrowLongerAtTarget" Arg="path"/>
##    <Attr Name="PathOneArrowShorterAtSource" Arg="path"/>
##    <Attr Name="PathOneArrowShorterAtTarget" Arg="path"/>
##    <Description>
##      Argument: <A>path</A>, a path
##      <Br />
##    </Description>
##    <Returns>
##      a path <C>new_path</C> which differs from <A>path</A> by one arrow in
##      the appropriate way, or &fail; if no such arrow exists.
##    </Returns>
##    <Description>
##      Both of the <C>-Shorter-</C>  attributes require <A>path</A> to have
##      length at least <M>1</M>, as measured by <Ref Attr="LengthOfPath"
##      BookName="QPA"/>.
##      <P />
##      Both of the <C>-Longer-</C> attributes require there to exist a unique
##      arrow to add. So, for example <C>PathOneArrowLongerAtSource</C>
##      requires the source of <A>path</A> to have indegree exactly <M>1</M>,
##      as measured by <Ref Attr="InDegreeOfVertex" BookName="QPA"/>. This is
##      always the situation with <M>1</M>-regular quivers, where these
##      operations are most intended to be used.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "PathOneArrowLongerAtSource", IsPath );
DeclareAttribute( "PathOneArrowLongerAtTarget", IsPath );
DeclareAttribute( "PathOneArrowShorterAtSource", IsPath );
DeclareAttribute( "PathOneArrowShorterAtTarget", IsPath );