####-------####################################################################
### SETUP   ###################################################################
####-------####################################################################

##  There are three SB algebras defined in other folders. We read them into GAP
##  here.
Read( "sbstrips/examples/worked_example/alg1.g" );
Read( "sbstrips/examples/worked_example/alg2.g" );
Read( "sbstrips/examples/worked_example/alg3.g" );

##  The above documents bind certain variables. For example, the second binds
q2;
    # The name of a quiver.
kq2;
    # The name of a path algebra (over the rationals).
alg2;
    # The name of a special biserial algebra.

##  Changing the `2' above to a `1' or `3' yields quivers/path algebras/SB alg-
##  -ebras defined in other files.

####---------------------------------------------------------------############
### CRASH COURSE IN QPA SYNTAX (more details in QPA documentation)  ###########
####---------------------------------------------------------------############

##  Both <q1> and <q2> have an arrow named "a". All of the quivers have vert-
##  -ices named <v1> and <v2>. To clarify `which' "a" we mean, we use the
##  following syntax
q1.a;
    # Element a (an arrow) of quiver <q1>
q2.a;
    # Element a (an arrow) of quiver <q2>
q2.v1;
    # Element v1 (a vertex) of quiver <q2>

##  Paths in a quiver are formed as the product of vertices and arrows.
q1.v1 * q1.v1;
    # The stationary path at v1 in q1
q1.a * q1.b * q1.c;
    # The path abc in q1
q2.a^3 * q1.v1 * q2.b;
    # The path aaab in q2

##  If a quiver is used to construct a path algebra (as <q1> was used for <kq1>
##  etc) or a quotient (as for <alg1>, etc), then paths of the quiver give rise
##  to elements of that path algebra or quotient in a straightforward way.
kq1.a;
    # Element of path algebra <kq1> corresponding to element a of <q1>
kq2.v1;
    # Element of path algebra <kq2> corresponding to element v1 of <q2>
alg2.d;
    # Element of quiver algebra <alg2> corresponding to element d of <alg2>

##  This extends to paths
(kq1.a * kq1.b * kq1.c)^2*kq1.a;
alg2.v1 * alg2.a;

####-------------------------------############################################
### CRASH COURSE IN SBSTRIPS SYNTAX ###########################################
####-------------------------------############################################

##  Here is an illustration of a string for <alg2>
##           
##         *        *
##       /a  \b   /c  \d
##      *     \c /a    \d /b
##              *        *
##
##  We may also denote it as follows
##      (a)^-1 (bc) (ca)^-1 (d)^2 (b)^-1
##  This specifies both the "syllables" (a, bc, ca, d^2, b) in order and their
##  orientations (-1, 1, -1, 1, -1). Let's pick out one syllable in particular:
##           
##         *        *
##       /  \\b   /   \ 
##      *    \\c /     \ / 
##             *        *
##
##  We would call the path bc in GAP by typing
##
##      alg2.b*alg2.c;          # (call this <path>)
##
##  How does the strip zig-zag to the right of this syllable? Relative to the
##  end of the syllable, the zigzag goes 2 up, then 2 down, then 1 up. We will
##  record this in the list
##
##      [-2, 2, -1];            # (call this <right_list>)
##
##  (where positive integers measure "downwards" and negative "upwards"). What
##  about on the left? Well, from the start of the syllable, the zigzag goes 2
##  down... and that's it. We'd record this in the list
##
##      [2];                    # (call this <left_list>)
##
##  We use this information to specify this strip to GAP.
##
##      Stripify( [2], alg2.b*alg2.c, [-2, 2, -1] );
##
##  Of course, other "reference" syllables are available. We could also write
##
##         *       *
##       /   \   /  \\d
##      *     \ /    \\d / 
##             *       *
##
##  in which case we would enter the following into GAP (without the hash-signs)
##
##      Stripify( [1, -2, 2], alg2.d^2, [-1] );
##
##  Hopefully this figure explains the numbers in the lists (and how they
##  should be understood as working outwards from the reference syllable).
##
##       1   -2  2   dd  -1
##         *       *
##       /   \   /  \\d
##      *     \ /    \\d / 
##             *       *
