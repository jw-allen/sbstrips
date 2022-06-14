##  <#GAPDoc Label="DocIs1RegQuiver">
##  <ManSection>
##    <Prop Name="Is1RegQuiver" Arg="quiver"/>
##    <Description>
##      Argument: <A>quiver</A>, a quiver
##      <Br />
##    </Description>
##    <Returns>
##      either <C>true</C> or <Code>false</Code>, depending on whether or not
##      <A>quiver</A> is <M>1</M>-regular.
##    </Returns>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty("Is1RegQuiver", IsQuiver);

##  <#GAPDoc Label="Doc1RegQuivIntActionFunction">
##  <ManSection>
##    <Attr Name="1RegQuivIntActionFunction" Arg="quiver"/>
##    <Description>
##      Argument: <A>quiver</A>, a <M>1</M>-regular quiver (as tested by
##      <Ref Prop="Is1RegQuiver"/>)
##      <Br />
##    </Description>
##    <Returns>
##      a single function <C>f</C> describing the <M>&ZZ;</M>-actions on the
##      vertices and the arrows of <A>quiver</A>
##    </Returns>
##    <Description>
##      Recall that a quiver is <M>1</M>-regular iff the source and target
##      functions <M>s,t</M> are bijections from the arrow set to the vertex
##      set (in which case the inverse <M>t^{-1}</M> is well-defined). The
##      generator <M>1 \in &ZZ;</M> acts as ``<M>t^{-1}</M> then <M>s</M>'' on
##      vertices and ``<M>s</M> then <M>t^{-1}</M>'' on arrows.
##      <Br />
##      In practice you will probably want to use
##      <Ref Oper="1RegQuivIntAct"/>, since it saves you having to remind
##      &SBStrips; which quiver you intend to act on.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute("1RegQuivIntActionFunction", IsQuiver);

##  <#GAPDoc Label="Doc1RegQuivIntAct">
##  <ManSection>
##    <Oper Name="1RegQuivIntAct" Arg="x, k"/>
##    <Description>
##      Arguments: <A>x</A>, which is either a vertex or an arrow of a
##      <M>1</M>-regular quiver; <A>k</A>, an integer.
##      <Br />
##    </Description>
##    <Returns>
##      the path <M>x+k</M>, as per the <M>&ZZ;</M>-action (see below).
##    </Returns>
##    <Description>
##      Recall that a quiver is <M>1</M>-regular iff the source and target
##      functions <M>s,t</M> are bijections from the arrow set to the vertex
##      set (in which case the inverse <M>t^{-1}</M> is well-defined). The
##      generator <M>1 \in &ZZ;</M> acts as ``<M>t^{-1}</M> then <M>s</M>'' on
##      vertices and ``<M>s</M> then <M>t^{-1}</M>'' on arrows.
##      <Br />
##      This operation figures out from <A>x</A> the quiver to which <A>x</A>
##      belongs and applies <Ref Attr="1RegQuivIntActionFunction"/> of tha
##      quiver. For this reason, it is more user-friendly.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareOperation("1RegQuivIntAct", [IsPath, IsInt]);

##  <#GAPDoc Label="DocPathBySourceAndLength">
##  <ManSection>
##    <Oper Name="PathBySourceAndLength" Arg="vert, len"/>
##    <Description>
##      Arguments: <A>vert</A>, a vertex of a <M>1</M>-regular quiver <M>Q</M>;
##      <A>len</A>, a nonnegative integer.
##      <Br />
##    </Description>
##    <Returns>
##      the unique path in <M>Q</M> which has source <A>vert</A> and length
##      <A>len</A>.
##    </Returns>
##  </ManSection>
##  <#/GAPDoc>
DeclareOperation("PathBySourceAndLength", [IsQuiverVertex, IsInt]);

##  <#GAPDoc Label="DocPathByTargetAndLength">
##  <ManSection>
##    <Oper Name="PathByTargetAndLength" Arg="vert, len"/>
##    <Description>
##      Arguments: <A>vert</A>, a vertex of a <M>1</M>-regular quiver <M>Q</M>;
##      <A>len</A>, a nonnegative integer.
##      <Br />
##    </Description>
##    <Returns>
##      the unique path in <M>Q</M> which has target <A>vert</A> and length
##      <A>len</A>.
##    </Returns>
##  </ManSection>
##  <#/GAPDoc>
DeclareOperation("PathByTargetAndLength", [IsQuiverVertex, IsInt]);

##  <#GAPDoc Label="DocIs2RegQuiver">
##  <ManSection>
##    <Prop Name="Is2RegQuiver" Arg="quiver"/>
##    <Description>
##      Argument: <A>quiver</A>, a quiver
##      <Br />
##    </Description>
##    <Returns>
##      either <C>true</C> or <C>false</C>, depending on whether or not
##      <A>quiver</A> is <M>2</M>-regular.
##    </Returns>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty("Is2RegQuiver", IsQuiver);

##  <#GAPDoc Label="Doc1RegQuivFromCycleLengths">
##  <ManSection>
##    <Prop Name="1RegQuivFromCycleLengths" Arg="cycle_lengths"/>
##    <Description>
##      Argument: <A>cycle_lengths</A>, a list of integers
##      <Br />
##    </Description>
##    <Returns>
##      a <M>1</M>-regular quiver with cycles of the given lengths.
##    </Returns>
##    <Description>
##      The vertices are named sequentially ("v1", "v2", ...) within each cycle
##      and then in order of the cycles as given by the cycle lengths
##      The arrows ("a1", "a2", ...) are named such that their number
##      corresponds to the number of their source
##      (i.e. the source of "a3" is "v3").
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareOperation("1RegQuivFromCycleLengths", [IsList]);
