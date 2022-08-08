##  <#GAPDoc Label="DocSBAlgFromSourceData">
##    <ManSection>
##      <Oper Name="SBAlgFromSourceData" Arg="O, v_pairs, a, b"/>
##      <Description>
##        Arguments: <A>O</A>, a 1-regular quiver; <A>v_pairs</A>, a pairing of
##          the vertices of O; a vertex indexed sequence of non-negative
##          integers <A>a</A>; and a binary vertex indexed sequence <A>b</A>.
##        <Br />
##      </Description>
##      <Returns>
##        a special biserial algebra matching the provided source data
##      </Returns>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation("SBAlgFromSourceData", [IsQuiver, IsList, IsVertexIndexedSequenceRep, IsVertexIndexedSequenceRep]);
