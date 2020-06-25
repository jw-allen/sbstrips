DeclareRepresentation( "IsVertexIndexedSequenceRep", IsAttributeStoringRep,
 [ "indices", "terms", "kind_of_seq" ] );

DeclareAttribute( "VertexIndexedSequenceFamilyOfQuiver", IsQuiver );

DeclareOperation( "VISify", [ IsQuiver, IsList, IsString ] );

#########1#########2#########3#########4#########5#########6#########7#########
