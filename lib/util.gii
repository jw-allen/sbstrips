# Some functionalities that could be present in GAP or QPA but are not

# Useful functions for QPA

InstallMethod(
    String,
    "for paths of positive length",
    [ IsPath ],
    function( path )
        local
            k,      # Integer variable
            output, # List to store output, as it is being writte
            walk;   # Walk of path

        # Methods for <String> are already installed for vertices and arrows
        #  (that is, paths of length 0 or 1).
        if LengthOfPath( path ) <= 1 then
            TryNextMethod();

        else
            # The returned string should be like "a1*a2*a3*...*aN", where "a1"
            #  etc are the constituent arrows of path (in order).

            walk := WalkOfPath( path );
            k := 1;
            output := [];
            for k in [1..Length( walk )] do
                if k <> 1 then
                    Add( output, "*" );
                fi;
                Add( output, String( walk[k] ) );
            od;
            
            return Concatenation( output );
        fi;
    end
);

#########1#########2#########3#########4#########5#########6#########7#########
