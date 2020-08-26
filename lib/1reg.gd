##  <#GAPDoc Label="DocIs1RegQuiver">
##  <ManSection>
##    <Prop Name="Is1RegQuiver" Arg="quiver">
##      <Description>
##        Argument: <A>quiver</A>, a quiver
##        <Br />
##      </Description>
##      <Returns>
##        either <C>true</C> or <Code>false</Code>, depending on whether or not
##        <A>quiver</A> is <M>1</M>-regular.
##      </Returns>
##    </Prop>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "Is1RegQuiver", IsQuiver );

DeclareAttribute( "1RegQuivIntActionFunction", IsQuiver );

DeclareOperation( "1RegQuivIntAct", [ IsPath, IsInt ] );

DeclareOperation( "PathBySourceAndLength", [ IsQuiverVertex, IsInt ] );

DeclareOperation( "PathByTargetAndLength", [ IsQuiverVertex, IsInt ] );

#########1#########2#########3#########4#########5#########6#########7#########
