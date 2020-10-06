##  <#GAPDoc Label="Doc2RegAugmentationOfQuiver">
##  <ManSection>
##    <Attr Name="2RegAugmentationOfQuiver" Arg="ground_quiv">
##      <Description>
##        Argument: <A>ground_quiv</A>, a sub<M>2</M>-regular quiver (as tested
##        by <Ref BookName="qpa" Prop="IsSpecialBiserialQuiver"/>)
##        <Br />
##      </Description>
##      <Returns>
##        a <M>2</M>-regular quiver of which <A>ground_quiv</A> may naturally
##        be seen as a subquiver
##      </Returns>
##      <Description>
##        If <A>ground_quiv</A> is itself sub-<M>2</M>-regular, then this
##        attribute returns <A>ground_quiv</A> identically. If not, then this
##        attribute constructs a brand new quiver object which has vertices
##        and arrows having the same names as those of <A>ground_quiv</A>, but
##        also has arrows with names <C>augarr1</C>, <C>augarr2</C> and so on.
##        <Br />
##      </Description>
##    </Attr>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "2RegAugmentationOfQuiver", IsQuiver );

##  <#GAPDoc Label="DocIs2RegAugmentationOfQuiver">
##  <ManSection>
##    <Prop Name="Is2RegAugmentationOfQuiver" Arg="quiver">
##      <Description>
##        Argument: <A>quiver</A>, a quiver
##        <Br />
##      </Description>
##      <Returns>
##        &true; if <A>quiver</A> was constructed by
##        <Ref Label="Doc2RegAugmentationOfQuiver"/> or if <A>quiver</A> was an
##        already <M>2</M>-regular quiver, and &false; otherwise.
##      </Returns>
##    </Prop>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "Is2RegAugmentationOfQuiver", IsQuiver );

##  <#GAPDoc Label="DocOriginalSbQuiverOf2RegAugmentation">
##  <ManSection>
##    <Attr Name="OriginalSbQuiverOf2RegAugmentation" Arg="quiver">
##      <Description>
##        Argument: <A>quiver</A>, a quiver
##        <Br />
##      </Description>
##      <Returns>
##        The sub-<M>2</M>-regular quiver of which <A>quiver</A> is the
##        <M>2</M>-regular augmentation.
##      </Returns>
##      <Description>
##        Informally speaking, this attribute is the "inverse" to
##        <C>2RegAugmentationOfQuiver</C>.
##        <Br />
##      </Description>
##    </Attr>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "OriginalSbQuiverOf2RegAugmentation", IsQuiver );

##  <#GAPDoc Label="DocRetractionOf2RegAugmentation">
##  <ManSection>
##    <Attr Name="RetractionOf2RegAugmentation" Arg="quiver">
##      <Description>
##        Argument: <A>quiver</A>, a quiver constructed using
##        <C>2RegAugmentationOfQuiver</C>
##        <Br />
##      </Description>
##      <Returns>
##        a function <C>ret</C>, which accepts paths in <A>quiver</A> as input
##        and which outputs paths in
##        <C>OriginalSbQuiverOf2RegAugmentation( quiver )</C>
##        <Ref Label="Doc2RegAugmentationOfQuiver"/>.
##      </Returns>
##      <Description>
##        One can identify <C>OriginalSbQuiverOf2RegAugmentation( quiver )</C>
##        with a subquiver of <A>quiver</A>. Some paths in <A>quiver</A> lie
##        wholly in that subquiver, some do not. This function <C>ret</C> takes
##        those that do to the corresponding path of
##        <C>OriginalSbQuiverOf2RegAugmentation( quiver )</C>, and those that
##        do not to the zero path of
##        <C>OriginalSbQuiverOf2RegAugmentation( quiver )</C>.
##        <Br />
##      </Description>
##    </Attr>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "RetractionOf2RegAugmentation", IsQuiver );

##  This attribute only belongs behind the scenes; no documentation provided.
DeclareAttribute( "CompatibleTrackPermutationOfSbAlg",
 IsSpecialBiserialAlgebra );

##  <#GAPDoc Label="DocOverquiverOfSbAlg">
##  <ManSection>
##    <Attr Name="OverquiverOfSbAlg" Arg="sba">
##      <Description>
##        Argument: <A>sba</A>, a special biserial algebra
##        <Br />
##      </Description>
##      <Returns>
##        a quiver <C>oquiv</C> with which uniserial <A>sba</A>-modules can be
##        conveniently (and unambiguously) represented.
##      </Returns>
##    </Attr>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "OverquiverOfSbAlg", IsSpecialBiserialAlgebra );

DeclareProperty( "IsOverquiver", IsQuiver );
DeclareAttribute( "ContractionOfOverquiver", IsQuiver );
DeclareAttribute( "SbAlgOfOverquiver", IsQuiver );

DeclareGlobalFunction( "GroundPathOfOverquiverPathNC" );
DeclareGlobalFunction( "SbAlgResidueOfOverquiverPathNC" );

DeclareAttribute( "ExchangePartnerOfVertex", IsQuiverVertex );

#########1#########2#########3#########4#########5#########6#########7#########
