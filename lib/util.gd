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
##        concatenations (&seeconc;) of such lists. This is the principal
##        intended use of this property.
##        <P />
##
##        When this document refers to a <E>collected list</E>, it means a list
##        for which <Ref Prop="IsCollectedList"/> returns &true;
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsCollectedList", IsList );

##  <#GAPDoc Label="DocIsCollectedHomogeneousList">
##    <ManSection>
##      <Prop Name="IsCollectedHomogeneousList" Arg="clist"/>
##      <Description>
##        Argument: <A>clist</A>, a collected list (&seeclist;)
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

##  <#GAPDoc Label="DocRecollected">
##    <ManSection>
##      <Oper Name="Recollected" Arg="clist"/>
##      <Description>
##        Argument: <A>clist</A>, a collected list (&seeclist;)
##      </Description>
##      <Returns>
##        A collected list whose entries all have distinct first entries.
##      </Returns>
##      <Description>
##        If <A>clist</A> contains entries with matching first entries, say
##        <C>[ obj, n ]</C> and <C>[ obj, m ]</C>, then it will combine them
##        into a single entry <C>[ obj, n+m ]</C> with totalised multiplicity.
##        This can be necessary when dealing with concatenations (&seeconc;) of
##        collected lists.
##      </Description>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation( "Recollected", [ IsList ] );


##  For QPA

DeclareOperation( "ArrowsOfQuiverAlgebra", [ IsQuiverAlgebra ] );
DeclareOperation( "VerticesOfQuiverAlgebra", [ IsQuiverAlgebra ] );