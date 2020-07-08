InstallMethod(
    ForwardOrbitNC,
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
            Add( orbit, func( obj ) );
            
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
    function( obj, func, zero )
        local
            latest, # Last entry of <orbit>
            orbit;  # Forward orbit of <obj> under <func>

        orbit := ForwardOrbitNC( obj, func );
        latest := orbit[ Length( orbit ) ];
        
        # If the <func>-orbit of <obj> ends in <zero>, then we call <obj>
        #  "transient with respect to <func>". Otherwise, it is "preperiodic
        #  with respect to <func>".
        return ( latest = zero );
    end
);

InstallMethod(
    IsPreperiodicUnderFunctionNC,
    [ IsObject, IsFunction, IsObject ],
    function( obj, func, zero )
        # <obj> is "periodic with respect to <func>" iff it is not "transient
        #  with respect to <func>". Here, <zero> is the distinguished fixpoint
        #  of func in which all <func>-transient orbits terminate.

        return not IsTransientUnderFunctionNC( obj, func, zero );
    end
);

#########1#########2#########3#########4#########5#########6#########7#########
