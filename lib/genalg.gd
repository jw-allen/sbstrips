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
##        a special biserial algebra matching the provided source data, if 
##        one exists, else returns 'fail'
##      </Returns>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation("SBAlgFromSourceData", [IsQuiver, IsList, IsVertexIndexedSequenceRep, IsVertexIndexedSequenceRep]);

##  <#GAPDoc Label="DocSBAlgsFromOverquiverAndSourceDataLists">
##    <ManSection>
##      <Oper Name="SBAlgsFromOverquiverAndSourceDataLists" Arg="O, a, b"/>
##      <Description>
##        Arguments: <A>O</A>, a 1-regular quiver; <A>v_pairs</A>, a vertex
##          indexed sequence of non-negative integers <A>a</A>; and a binary
##          vertex indexed sequence <A>b</A>.
##        <Br />
##      </Description>
##      <Returns>
##        an iterator of special biserial algebras matching the provided
##        overquiver and vertex indexed sequences
##        NOTE: may include repeats, and final entry could be 'fail'
##      </Returns>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation("SBAlgsFromOverquiverAndSourceDataLists", [IsQuiver, IsList, IsList]);

##  <#GAPDoc Label="DocSBAlgsFromCyclesAndRadLength">
##    <ManSection>
##      <Oper Name="SBAlgsFromCyclesAndRadLength" Arg="cycle_lengths, rad_len"/>
##      <Description>
##        Arguments: <A>cycle_lengths</A>, a list of positive integers; and
##          <A>rad_len</A>, a positive integer
##        <Br />
##      </Description>
##      <Returns>
##        an iterator of special biserial algebras with an overquiver having
##        the given cycle lengths, and with the specified radical length
##        NOTE: may include repeats, and final entry could be 'fail'
##      </Returns>
##    </ManSection>
##  <#/GAPDoc>
DeclareOperation("SBAlgsFromCyclesAndRadLength", [IsList, IsPosInt]);
