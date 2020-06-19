InstallMethod(
	ComponentsOfCommutativityRelationsOfSba,
	"for special biserial algebras",
	[ IsSpecialBiserialAlgebra ],
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

InstallMethod(
	ComponentExchangeMapOfSba,
	"for special biserial algebras"
	[ IsSpecialBiserialAlgebra ],
	function( sba )
		local
			complist,	# List of components of commutativity relations of
						#  <sba>
			func;		# Function variable
		
		if HasComponentExchangeMapOfSba( sba ) then
			return ComponentExchangeMapOfSba( sba );

		else
			complist := ComponentsOfCommutativityRelationsOfSba( sba );
			
			func := function( elt )
				local
					found,
					k,
					pair;

				found := false;
				k := 1;
				while ( (found = false) and ( k <= Length( complist ) ) ) do
					if elt in complist[ k ] then
						found := true;
					else
						k := k+1;
					fi;
				od;
				
				if found = false then
					Print( "The given element\n", elt, "\nis not a component of a commutativity relation of the special biserial algebra\n", sba );
					return fail;
				else
					pair := ShallowCopy( complist[ k ] );
					Remove( pair, Position( pair, elt ) );
				fi;
				
				return pair[ 1 ];
			end;
			
			return func;
		fi;
	end
);

#########1#########2#########3#########4#########5#########6#########7#########
