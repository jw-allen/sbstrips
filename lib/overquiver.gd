##  <#GAPDoc Label="Doc2RegAugmentationOfQuiver">
##  <ManSection>
##    <Attr Name="2RegAugmentationOfQuiver" Arg="ground_quiv"/>
##    <Description>
##      Argument: <A>ground_quiv</A>, a sub<M>2</M>-regular quiver (as tested
##      by <Ref BookName="qpa" Prop="IsSpecialBiserialQuiver"/>)
##      <Br />
##    </Description>
##    <Returns>
##      a <M>2</M>-regular quiver of which <A>ground_quiv</A> may naturally be
##      seen as a subquiver
##    </Returns>
##    <Description>
##      If <A>ground_quiv</A> is itself sub-<M>2</M>-regular, then this
##      attribute returns <A>ground_quiv</A> identically. If not, then this
##      attribute constructs a brand new quiver object which has vertices and
##      arrows having the same names as those of <A>ground_quiv</A>, but also
##      has arrows with names <C>augarr1</C>, <C>augarr2</C> and so on.
##      <Br />
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "2RegAugmentationOfQuiver", IsQuiver );

##  <#GAPDoc Label="DocIs2RegAugmentationOfQuiver">
##  <ManSection>
##    <Prop Name="Is2RegAugmentationOfQuiver" Arg="quiver"/>
##    <Description>
##      Argument: <A>quiver</A>, a quiver
##      <Br />
##    </Description>
##    <Returns>
##      &true; if <A>quiver</A> was constructed by
##      <Ref Label="2RegAugmentationOfQuiver"/> or if <A>quiver</A> was an
##      already <M>2</M>-regular quiver, and &false; otherwise.
##    </Returns>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "Is2RegAugmentationOfQuiver", IsQuiver );

##  <#GAPDoc Label="DocOriginalSBQuiverOf2RegAugmentation">
##  <ManSection>
##    <Attr Name="OriginalSBQuiverOf2RegAugmentation" Arg="quiver"/>
##    <Description>
##      Argument: <A>quiver</A>, a quiver
##      <Br />
##    </Description>
##    <Returns>
##      The sub-<M>2</M>-regular quiver of which <A>quiver</A> is the
##      <M>2</M>-regular augmentation.
##    </Returns>
##    <Description>
##      Informally speaking, this attribute is the "inverse" to
##      <C>2RegAugmentationOfQuiver</C>.
##      <Br />
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "OriginalSBQuiverOf2RegAugmentation", IsQuiver );

##  <#GAPDoc Label="DocRetractionOf2RegAugmentation">
##  <ManSection>
##    <Attr Name="RetractionOf2RegAugmentation" Arg="quiver"/>
##    <Description>
##      Argument: <A>quiver</A>, a quiver constructed using
##      <C>2RegAugmentationOfQuiver</C>
##      <Br />
##    </Description>
##    <Returns>
##      a function <C>ret</C>, which accepts paths in <A>quiver</A> as input
##      and which outputs paths in <C>OriginalSBQuiverOf2RegAugmentation(
##      quiver )</C> <Ref Label="2RegAugmentationOfQuiver"/>.
##    </Returns>
##    <Description>
##      One can identify <C>OriginalSBQuiverOf2RegAugmentation( quiver )</C>
##      with a subquiver of <A>quiver</A>. Some paths in <A>quiver</A> lie
##      wholly in that subquiver, some do not. This function <C>ret</C> takes
##      those that do to the corresponding path of
##      <C>OriginalSBQuiverOf2RegAugmentation( quiver )</C>, and those that
##      do not to the zero path of <C>OriginalSBQuiverOf2RegAugmentation(
##      quiver )</C>.
##      <Br />
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "RetractionOf2RegAugmentation", IsQuiver );

##  (This belongs behind the scenes only. We provide no formal documentation.)
##
##  Let <sba> be a special biserial algebra (as judged by the QPA property
##   <IsSpecialBiserialAlgebra>). Mathematically speaking, there are several
##   possible overquivers for <sba>. Each possibility corresponds to a simul-
##   -taneous choice, for each vertex of the quiver of <sba>, out of two
##   options. This attribute picks one such possibility, and so "the" over-
##   -quiver for <sba> is the overquiver corresponding to this choice.
DeclareAttribute( "CompatibleTrackPermutationOfSBAlg",
 IsSpecialBiserialAlgebra );

##  <#GAPDoc Label="DocOverquiverOfSBAlg">
##  <ManSection>
##    <Attr Name="OverquiverOfSBAlg" Arg="sba"/>
##    <Description>
##      Argument: <A>sba</A>, a special biserial algebra
##      <Br />
##    </Description>
##    <Returns>
##      a quiver <C>oquiv</C> with which uniserial <A>sba</A>-modules can be
##      conveniently (and unambiguously) represented.
##    </Returns>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "OverquiverOfSBAlg", IsSpecialBiserialAlgebra );

##  <#GAPDoc Label="DocIsOverquiver">
##  <ManSection>
##    <Prop Name="IsOverquiver" Arg="quiver"/>
##    <Description>
##      Argument: <A>quiver</A>, a quiver
##      <Br />
##    </Description>
##    <Returns>
##      &true; if <A>quiver</A> was constructed by <Ref
##      Label="OverquiverOfSBAlg"/>, and &false; otherwise.
##    </Returns>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsOverquiver", IsQuiver );

##  <#GAPDoc Label="DocContractionOfOverquiver">
##  <ManSection>
##    <Attr Name="ContractionOfOverquiver" Arg="oquiv"/>
##    <Description>
##      Argument: <A>oquiv</A>, an overquiver (as constructed by <Ref
##      Label="OverquiverOfSBAlg" />)
##      <Br />
##    </Description>
##    <Returns>
##      a function <C>cont</C>, which takes a path in <A>oquiv</A> as input.
##    </Returns>
##    <Description>
##      Recall that <A>oquiv</A> was the overquiver of some special biserial
##      algebra, say <C>sba</C>, defined over some original quiver, say
##      <C>orig_quiv</C>. Also recall that <A>oquiv</A> was constructed using
##      <Ref Label="OverquiverOfSBAlg" />.
##      <P />
##      When <Ref Label="OverquiverOfSBAlg" /> is called on <C>sba</C>, it
##      creates the <M>2</M>-regular augmentation <C>orig_quiv</C>. Call the
##      augmentation <C>2reg</C>. Notice that <C>orig_quiv</C> can be
##      identified with a subquiver of <C>2reg</C>, and that <C>2reg</C> can be
##      viewed as a quotient quiver of <A>oquiv</A>. Using that quotient map,
##      paths in <A>oquiv</A> can be viewed as paths in <C>2reg</C>. That is
##      what <C>cont</C> does: given any path in <A>oquiv</A>, <C>cont</C>
##      returns the corresponding path in <A>2reg</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "ContractionOfOverquiver", IsQuiver );

##  <#GAPDoc Label="DocSBAlgOfOverquiver">
##  <ManSection>
##    <Attr Name="SBAlgOfOverquiver" Arg="quiver"/>
##    <Description>
##      Argument: <A>quiver</A>, an overquiver (as constructed by <Ref
##      Label="OverquiverOfSBAlg" />)
##      <Br />
##    </Description>
##    <Returns>
##      The special biserial algebra from which <A>quiver</A> was constructed.
##      constructed.
##    </Returns>
##    <Description>
##      Informally speaking, this attribute is the "inverse" to
##      <C>OverquiverOfSBAlg</C>.
##      <Br />
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "SBAlgOfOverquiver", IsQuiver );

##  (These belong behind the scenes only. We provide no formal documentation.)
##
##  Let <oquiv> be the overquiver of the special biserial algebra <sba>, and
##   suppose that <sba> is originally defined over the quiver <quiver>. An
##   intermediate step in the construction of <oquiv> is the construction of
##   <2reg>, the 2-regular augmentation of <quiver>.
##  There is a diagram of maps of quivers as follows.
##
##      <quiver>  >--->  <2reg>  <<---  <oquiv>
##
##   This diagram induces a map on paths as follows.
##
##      {paths in <quiver>}  >--->  {paths in <2reg>}  <<-- {paths in <oquiv>}
##
##   The (injective) lefthand map has a retraction (also called a left inverse).
##
##      {paths in <quiver>}  <----  {paths in <2reg>}  <<-- {paths in <oquiv>}
##
##   This latter concatenation, which takes a path in <oquiv> as input and
##   gives a (possibly zero) path in <quiver> as output, is
##   <GroundPathOfOverquiverPathNC>. If you further view that resulting path in
##   <quiver> as a path in <sba>, you've used <SBAlgResidueOfOverquiverPathNC>.
DeclareGlobalFunction( "GroundPathOfOverquiverPathNC" );
DeclareGlobalFunction( "SBAlgResidueOfOverquiverPathNC" );

##  <#GAPDoc Label="DocExchangePartnerOfVertex">
##  <ManSection>
##    <Attr Name="ExchangePartnerOfVertex" Arg="v"/>
##    <Description>
##      Argument: <A>v</A>, a vertex of an overquiver <C>oquiv</C> (as
##      constructed by <Ref Label="OverquiverOfSBAlg" />)
##      <Br />
##    </Description>
##    <Returns>
##      The unique other vertex of <C>oquiv</C> that represents the same vertex
##      as <A>v</A>
##    </Returns>
##    <Description>
##      Suppose that <A>v</A> belongs to <C>oquiv</C> and <C>oquiv</C> is the
##      overquiver of the special biserial algebra <C>sba</C>. The vertices of
##      <C>oquiv</C> map onto the vertices of <C>sba</C> exactly two-to-one.
##      This attribute exchanges the two vertices with common image.
##      <Br />
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "ExchangePartnerOfVertex", IsQuiverVertex );
