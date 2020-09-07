##  <#GAPDoc Label="DocIsPanelRep">
##  <ManSection>
##    <Filt Name="IsPanelRep" Type="Representation">
##      <Description>
##        Panels in &sbstrips; belong to this representation filter.
##      </Description>
##    </Filt>
##  </ManSection>
##  <#/GAPDoc>
DeclareRepresentation( "IsPanelRep", IsAttributeStoringRep, [ "panel" ] );

DeclareOperation( "PanellifyNC", [ IsList ] );

##  <#GAPDoc Label="DocStationaryPanelsOfSbAlg">
##  <ManSection>
##    <Attr Name="StationaryPanelsOfSbAlg" Arg="sba">
##      <Description>
##        Argument: <A>sba</A>, a special biserial algebra
##      </Description>
##      <Returns>
##        the stationary panels of <A>sba</A>; that is, the list of panels
##        corresponding to the stationary syllables of <A>sba</A>.
##      </Returns>
##      <Description>
##        These are what control whether the <A>sba</A> is syzygy-finite.
##      </Description>
##    </Attr>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "StationaryPanelsOfSbAlg", IsSpecialBiserialAlgebra );

#########1#########2#########3#########4#########5#########6#########7#########
