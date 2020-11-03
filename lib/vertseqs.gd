DeclareRepresentation( "IsVertexIndexedSequenceRep", IsAttributeStoringRep,
 [ "quiver", "indices", "terms", "kind_of_seq" ] );

DeclareAttribute( "VertexIndexedSequenceFamilyOfQuiver", IsQuiver );

DeclareOperation( "VISify", [ IsQuiver, IsList, IsString ] );
