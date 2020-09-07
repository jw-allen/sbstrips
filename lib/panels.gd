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

#########1#########2#########3#########4#########5#########6#########7#########
