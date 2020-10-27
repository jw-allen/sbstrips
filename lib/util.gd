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
##      </Description>
##      <Returns>
##        &true; if all entries of <A>list</A> are lists of length <M>2</M>
##        having a positive integer in their second entry, and &false;
##        otherwise.
##      </Returns>
##      <Description>
##        This property will return &true; on lists returned from the &GAP;
##        operation <Ref Oper="Collected" BookName="Reference"/>, as well as on
##        concatenations (<Ref Func="Concatenation" BookName="Reference"/>) of
##        such lists. This is the principal
##        intended use of this property.
##        <P />
##
##        When this document refers to a <E>collected list</E>, it means a list
##        for which <Ref Prop="IsCollectedList"/> returns &true;
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsCollectedList", IsList );

##  <#GAPDoc Label="DocIsCollectedDuplicateFreeList">
##    <ManSection>
##      <Prop Name="IsCollectedDuplicateFreeList" Arg="clist"/>
##      <Description>
##        Argument: <A>clist</A>
##      </Description>
##      <Returns>
##        &true; if <A>clist</A> is a collected list (see <Ref
##        Prop="IsCollectedList"/>, all first entries of which are distinct.
##      </Returns>
##      <Returns>
##        In particular, if <A>clist</A> was created by applying <Ref
##        Oper="Collected" BookName="Reference"/> to a duplicate-free list (see
##        <Ref Filt="IsDuplicateFreeList" BookName="Reference"/>), then this
##        property will return &true;. This is the principal intended use of
##        this property.
##      </Returns>
##    </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsCollectedDuplicateFreeList", IsList );

##  <#GAPDoc Label="DocIsCollectedHomogeneousList" Arg="clist">
##    <ManSection>
##      <Prop Name="IsCollectedHomogeneousList" Arg="clist"/>
##      <Description>
##        Argument: <A>clist</A>, a collected list
##      </Description>
##      <Returns>
##        &true; if replacing each entry of <A>clist</A> by its respective
##        first element gives a homogeneous list (see <Ref
##        Filt="IsHomogeneousList" BookName="Reference"/>), and &false;
##        otherwise
##      </Returns>
##      <Description>
##        If <C>obj</C> is the result of applying <Ref Oper="Collected"
##        BookName="Reference"/> to a homogeneous list, then this property
##        returns &true;. This is the principal intended use of this property.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsCollectedHomogeneousList", IsList );

DeclareAttribute( "CollectedLength", IsList );

##  <#GAPDoc Label="DocRecollected">
##    <ManSection>
##      <Oper Name="Recollected" Arg="clist"/>
##      <Description>
##        Argument: <A>clist</A>, a collected list
##      </Description>
##      <Returns>
##        a collected list whose entries all have distinct first entries.
##      </Returns>
##      <Description>
##        If <A>clist</A> contains entries with matching first entries, say
##        <C>[ obj, n ]</C> and <C>[ obj, m ]</C>, then it will combine them
##        into a single entry <C>[ obj, n+m ]</C> with totalised multiplicity.
##        This can be necessary when dealing with concatenations (<Ref
##        Func="Concatenation" BookName="Reference"/>) of
##        collected lists.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation( "Recollected", [ IsList ] );

##  <#GAPDoc Label="DocUncollected">
##    <ManSection>
##      <Oper Name="Uncollected" Arg="clist"/>
##      <Description>
##        Argument: <A>clist</A>, a collected list
##      </Description>
##      <Returns>
##        a (flat) list, where each (first entry of an) entry in <A>clist</A>
##        appears with the appropriate multiplicity
##      </Returns>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation( "Uncollected", [ IsList ] );


##  For QPA

##  <#GAPDoc Label="DocStringMethodForPaths">
##    <ManSection>
##      <Meth Name="String" Arg="path" Label="for paths of length at least 2"/>
##      <Description>
##        Argument: <A>path</A>, a path of length at least <M>2</M> in a quiver
##        (see <Ref Filt="IsPath" BookName="QPA"/> and <Ref Attr="LengthOfPath"
##        BookName="QPA"/> for details)
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
##        Argument: <A>alg</A>, a quiver algebra (see <Ref
##        Filt="IsQuiverAlgebra" BookName="QPA"/>)
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
##        Argument: <A>alg</A>, a quiver algebra (see <Ref
##        Filt="IsQuiverAlgebra" BookName="QPA"/>)
##      </Description>
##      <Returns>
##        the residues of the vertices in the defining quiver of <A>alg</A>, 
##        listed together
##      </Returns>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation( "VerticesOfQuiverAlgebra", [ IsQuiverAlgebra ] );