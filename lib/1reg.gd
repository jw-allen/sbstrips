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

##  <#GAPDoc Label="Doc1RegQuivIntActionFunction">
##  <ManSection>
##    <Attr Name="Is1RegQuiver" Arg="quiver">
##      <Description>
##        Argument: <A>quiver</A>, a <M>1</M>-regular quiver (as tested by
##        <Ref Prop="DocIs1RegQuiver"/>)
##        <Br />
##      </Description>
##      <Returns>
##        a single function <C>f</C> describing the <M>&ZZ;</M>-actions on the
##        vertices and the arrows of <A>quiver</A>
##      </Returns>
##      <Description>
##         Recall that a quiver is <M>1</M>-regular iff the source and target
##         functions <M>s,t</M> are bijections from the arrow set to the vertex
##         set (in which case the inverse <M>t^{-1}</M> is well-defined). The
##         generator <M>1 \in &ZZ;</M> acts as ``<M>t^{-1}</M> then <M>s</M>''
##         on vertices and ``<M>s</M> then <M>t^{-1}</M>'' on arrows.
##         <Br />
##      </Description>
##    </Attr>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "1RegQuivIntActionFunction", IsQuiver );

DeclareOperation( "1RegQuivIntAct", [ IsPath, IsInt ] );

DeclareOperation( "PathBySourceAndLength", [ IsQuiverVertex, IsInt ] );

DeclareOperation( "PathByTargetAndLength", [ IsQuiverVertex, IsInt ] );

#########1#########2#########3#########4#########5#########6#########7#########
