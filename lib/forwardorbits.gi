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

#########1#########2#########3#########4#########5#########6#########7#########
