# Some functionalities that could be present in GAP or QPA but are not

InstallMethod(
    ForwardOrbitUnderFunctionNC,
    [ IsObject, IsFunction ],
    function( obj, func )
        local
            latest, # Last entry of <orbit>
            orbit;  # Forward orbit sequence of <obj> under <func> 

        orbit := [ obj ];
        while IsDuplicateFreeList( orbit ) do
            # Let <latest> be the final entry of <orbit>
            latest := orbit[ Length( orbit ) ];
            
            # Apply <func> to <latest>; append this to <orbit>
            Add( orbit, func( latest ) );
            
            # Repeat until <orbit> contains a duplicate entry. BE WARNED that
            #  this function does not check whether higher iterates of <func>
            #  are defined on <obj>, not does it check whether duplicates are
            #  guaranteed to arise!
        od;
        
        return orbit;
    end
);

InstallMethod(
    IsTransientUnderFunctionNC,
    [ IsObject, IsFunction, IsObject ],
    function( obj, func, fixpt )
        local
            latest, # Last entry of <orbit>
            orbit;  # Forward orbit of <obj> under <func>

        orbit := ForwardOrbitUnderFunctionNC( obj, func );
        latest := orbit[ Length( orbit ) ];
        
        # If the <func>-orbit of <obj> ends in <fixpt>, then we call <obj>
        #  "transient with respect to <func>". Otherwise, it is "preperiodic
        #  with respect to <func>".
        return ( latest = fixpt );
    end
);

InstallMethod(
    IsPreperiodicUnderFunctionNC,
    [ IsObject, IsFunction, IsObject ],
    function( obj, func, fixpt )
        # <obj> is "periodic with respect to <func>" iff it is not "transient
        #  with respect to <func>". Here, <fixpt> is the distinguished fixpoint
        #  of func in which all <func>-transient orbits terminate.

        return not IsTransientUnderFunctionNC( obj, func, fixpt );
    end
);

InstallMethod(
    IsPeriodicUnderFunctionNC,
    [ IsObject, IsFunction, IsObject ],
    function( obj, func, fixpt )
    # <obj> is "periodic with respect to <func>" if <func>, or some repeated
    #  composition of <func> with itself, fixes <obj>. The only exception is
    #  the distinguished fixpoint <fixpt> of <func>: by fiat, we impose that
    #  <fixpt> is "transient with respect to <func>", as are all objects whose
    #  <func>-orbit contains (and therefore stabilises at) <fixpt>
    
    local
        latest, # Last entry of <orbit>
        orbit;  # Forward orbit of <obj> under <func>
    
    if IsTransientUnderFunctionNC( obj, func, fixpt ) then
        return false;
    else
        orbit := ForwardOrbitUnderFunctionNC( obj, func );
        latest := orbit[ Length( orbit ) ];
        return ( obj = latest );
    fi;

    end
);

InstallMethod(
    IsCollectedList,
    "for lists",
    [ IsList ],
    function( list )
        local
            mults,  # List of multiplicities
            objs;   # List of objects
            
        if HasIsCollectedList( list ) then
            return IsCollectedList( list );

        else
            if not ( ForAll( list, IsList ) ) then
                return false;
            elif not( ForAll( list, x -> Length( x ) = 2 ) ) then
                return false;
            else
                mults := List( list, x -> x[2] );
                
                if not ( ForAll( mults, IsPosInt ) ) then
                    return false;
                else
                    return true;
                fi;
            fi;
        fi;
    end
);

InstallMethod(
    IsCollectedHomogeneousList,
    "for lists",
    [ IsList ],
    function( clist )
        local
            mults,  # List of multiplicities
            objs;   # List of objects

        if HasIsCollectedHomogeneousList( clist ) then
            return IsCollectedHomogeneousList( clist );
        else
            if not IsCollectedList( clist ) then
                return false;
            else
                objs := List( clist, x -> x[1] );
                
                return IsHomogeneousList( objs );
            fi;
        fi;
    end
);

InstallMethod(
    Recollected,
    "for collected lists",
    [ IsList ],
    function( clist )
        local
            j, k,   # Integer variable
            list,   # List variable
            mults,  # List of multiplicities
            objs;   # List of objects
            
        if not IsCollectedList( clist ) then
            TryNextMethod();
        
        else
            objs := List( clist, x -> x[1] );
            mults := List( clist, x -> x[2] );
            
            list := [];
            
            ## Unpack <clist> into a single list, then apply <Collected>
            for k in [ 1..Length( clist ) ] do
                j := 1;
                while j <= mults[k] do
                    Add( list, objs[k] );
                    j := j + 1;
                od;
            od;
            
            return Collected( list );
        fi;
    end
);

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
