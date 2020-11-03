##  <#GAPDoc Label="DocIsPanelRep">
##  <ManSection>
##    <Filt Name="IsPanelRep" Type="Representation"/>
##    <Description>
##      Panels in &SBStrips; belong to this representation filter.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareRepresentation( "IsPanelRep", IsAttributeStoringRep, [ "panel" ] );

##  <#GAPDoc Label="DocPanelFamilyOfSBAlg">
##  <ManSection>
##  <Attr Name="PanelFamilyOfSBAlg" Arg="sba"/>
##    <Description>
##      Argument: <A>sba</A>, a SB algebra
##    </Description>
##    <Returns>
##      the family to which all panels of <A>sba</A> belong
##    </Returns>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "PanelFamilyOfSBAlg", IsSpecialBiserialAlgebra );

# Maybe I don't need this? I feel as though I'll always want to use
#  <ObjectifyWithAttributes> rather than just <Objectify>?
DeclareOperation( "PanellifyNC", [ IsList ] );

DeclareOperation( "PanellifyFromUnstableSyllable", [ IsSyllableRep ] );

##  <#GAPDoc Label="DocStationaryPanelsOfSBAlg">
##  <ManSection>
##    <Attr Name="StationaryPanelsOfSBAlg" Arg="sba"/>
##    <Description>
##      Argument: <A>sba</A>, a SB algebra
##    </Description>
##    <Returns>
##      the stationary panels of <A>sba</A>; that is, the list of panels
##      corresponding to the stationary syllables of <A>sba</A>.
##    </Returns>
##    <Description>
##      These are what control whether the <A>sba</A> is syzygy-finite.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "StationaryPanelsOfSBAlg", IsSpecialBiserialAlgebra );


##  <#GAPDoc Label="DocIsUnboundedPanel">
##  <ManSection>
##    <Prop Name="IsUnboundedPanel" Arg="panel"/>
##    <Description>
##      Argument: <A>panel</A>, a panel for a SB algebra
##    </Description>
##    <Returns>
##      &false; if the construction of <A>panel</A> was halted due to
##      branching, and &true; if it was terminated ahead of an infinite loop.
##    </Returns>
##    <!-- Only when this returns &false; does <A>panel</A> have "aileron
##    segments" or whatever I'm calling them. -->
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsUnboundedPanel", IsPanelRep );

#########1#########2#########3#########4#########5#########6#########7#########
