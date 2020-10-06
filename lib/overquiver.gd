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
##        The sub-<M>2</M>-regular quiver of which <A>quiver</A> is the <M>2</M>-regular augmentation.
##      </Returns>
##      <Description>
##        Informally speaking, this attribute is the "inverse" to <C>2RegAugmentationOfQuiver</C>.
##        <Br />
##      </Description>
##    </Attr>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "OriginalSbQuiverOf2RegAugmentation", IsQuiver );
DeclareAttribute( "RetractionOf2RegAugmentation", IsQuiver );

DeclareAttribute( "CompatibleTrackPermutationOfSbAlg",
 IsSpecialBiserialAlgebra );
 
DeclareAttribute( "OverquiverOfSbAlg", IsSpecialBiserialAlgebra );
DeclareProperty( "IsOverquiver", IsQuiver );
DeclareAttribute( "ContractionOfOverquiver", IsQuiver );
DeclareAttribute( "SbAlgOfOverquiver", IsQuiver );

DeclareGlobalFunction( "GroundPathOfOverquiverPathNC" );
DeclareGlobalFunction( "SbAlgResidueOfOverquiverPathNC" );

DeclareAttribute( "ExchangePartnerOfVertex", IsQuiverVertex );

#########1#########2#########3#########4#########5#########6#########7#########
