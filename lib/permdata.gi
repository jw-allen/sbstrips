InstallMethod(
	ComponentsOfCommutativityRelationsOfSba,
	"for special biserial algebras",
	[IsSpecialBiserialAlgebra],
	function ( sba )
		local
			is2nomialgens,	# Local function testing for 2-nomiality of
							#  presentation
			iscommurel,		# Local function testing for a commutativity
							#  relation
			ismonrel,		# Local function testing for a monomial relation
			list,			# List of components of commutativity relations
			rels;			# Defining relations of <sba>
			
		if HasComponentsOfCommutativityRelationsOfSba( sba ) then
			return ComponentsOfCommutativityRelationsOfSba( sba );
			
		else
			# Write functions answering whether an element of a path algebra is
			#  supported on one or two paths
			ismonrel := function( elt )
				if Length( CoefficientsAndMagmaElements( elt ) ) = 2 then
					return true;
				else
					return false;
				fi;
			end;
			
			iscommurel := function( elt )
				if Length( CoefficientsAndMagmaElements( elt ) ) = 4 then
					return true;
				else
					return false;
				fi;
			end;
			
			# Write logical disjunction of <ismonrel> and <iscommurel> 
			is2nomialgens := function( elt )
				if ( ismonrel( elt ) or iscommurel( elt ) ) then
					return true;
				else
					return fail;
				fi;
			end;
			
			# Verify that <sba> has been presented 2-nomially.
			rels := RelationsOfAlgebra( sba );

			if false in List( rels, x -> is2nomialgens( x ) ) then
				Error( "The given algebra\n", sba, "\nhas not been presented ",
				 "by monomial and commutativity relations!" );
			else
				list := Filtered( rels, iscommurel );
			fi;
			
			Apply( list, x -> CoefficientsAndMagmaElements( x ){ [1,3] } );
			
			return Immutable( list );
		fi;
	end
);

#########1#########2#########3#########4#########5#########6#########7#########
