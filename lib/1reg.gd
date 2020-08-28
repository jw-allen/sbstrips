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
##    <Attr Name="1RegQuivIntActionFunction" Arg="quiver">
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
##        Recall that a quiver is <M>1</M>-regular iff the source and target
##        functions <M>s,t</M> are bijections from the arrow set to the vertex
##        set (in which case the inverse <M>t^{-1}</M> is well-defined). The
##        generator <M>1 \in &ZZ;</M> acts as ``<M>t^{-1}</M> then <M>s</M>''
##        on vertices and ``<M>s</M> then <M>t^{-1}</M>'' on arrows.
##        <Br />
##        In practice you will probably want to use
##        <Ref Oper="Doc1RegQuivIntAct"/>, since it saves you having to remind
##        &sbstrips; which quiver you intend to act on.
##      </Description>
##    </Attr>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "1RegQuivIntActionFunction", IsQuiver );

##  <#GAPDoc Label="Doc1RegQuivIntAct">
##  <ManSection>
##    <Oper Name="1RegQuivIntAct" Arg="x k">
##      <Description>
##        Arguments: <A>x</A>, which is either a vertex or an arrow of a
##        <M>1</M>-regular quiver; <A>k</A>, an integer.
##        <Br />
##      </Description>
##      <Returns>
##        the path <M>x+k</M>, as per the <M>&ZZ;</M>-action (see below).
##      </Returns>
##      <Description>
##        Recall that a quiver is <M>1</M>-regular iff the source and target
##        functions <M>s,t</M> are bijections from the arrow set to the vertex
##        set (in which case the inverse <M>t^{-1}</M> is well-defined). The
##        generator <M>1 \in &ZZ;</M> acts as ``<M>t^{-1}</M> then <M>s</M>''
##        on vertices and ``<M>s</M> then <M>t^{-1}</M>'' on arrows.
##        <Br />
##        This operation figures out from <A>x</A> the quiver to which <A>x</A>
##        belongs and applies <Ref Attr="Doc1RegQuivIntActionFunction"> of that
##        quiver. For this reason, it is more user-friendly.
##      </Description>
##    </Oper>
##  </ManSection>
##  <#/GAPDoc>  
DeclareOperation( "1RegQuivIntAct", [ IsPath, IsInt ] );

DeclareOperation( "PathBySourceAndLength", [ IsQuiverVertex, IsInt ] );

DeclareOperation( "PathByTargetAndLength", [ IsQuiverVertex, IsInt ] );

#########1#########2#########3#########4#########5#########6#########7#########
