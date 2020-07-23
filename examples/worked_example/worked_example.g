####-------####################################################################
### SETUP   ###################################################################
####-------####################################################################

##  There are three SB algebras defined in other folders. We read them into GAP
##  here.
# Read( "sbstrips/examples/worked_example/alg1.g" );
# Read( "sbstrips/examples/worked_example/alg2.g" );
# Read( "sbstrips/examples/worked_example/alg3.g" );

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
q2.a^3 * q2.v1 * q2.b;
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

####---------------------------################################################
### ENTERING STRIPS INTO GAP    ###############################################
####---------------------------################################################

##  Here is an illustration of a string for <alg2>
##           
##         *        *
##       /a  \b   /c  \d   *
##      *     \c /a    \d /b
##              *        *
##
##  We may also denote it as follows
##      (a)^-1 (bc) (ca)^-1 (d)^2 (b)^-1
##  This specifies both the "syllables" (a, bc, ca, d^2, b) in order and their
##  orientations (-1, 1, -1, 1, -1). Let's pick out one syllable in particular:
##           
##         *        *
##       /  \\b   /   \   *
##      *    \\c /     \ / 
##             *        *
##
##  We would call the path bc in GAP by typing
##
##      gap> alg2.b*alg2.c;     # (call this <path>)
##
##  How does the strip zig-zag to the right of this syllable? Relative to the
##  (righthand) end of the syllable, the zigzag goes 2 up, then 2 down, then 1
##  up. We will record this in the list
##
##      gap> [-2, 2, -1];       # (call this <right_list>)
##
##  (where positive integers measure "downwards" and negative "upwards"). What
##  about on the left? Well, from the start of the syllable, the zigzag goes 2
##  down... and that's it. We'd record this in the list
##
##      gap> [2];               # (call this <left_list>)
##
##  We use this information to specify this strip to GAP.
##
##      gap> Stripify( [2], alg2.b*alg2.c, [-2, 2, -1] );
##
##  Of course, other "reference" syllables are available. We could also write
##
##         *       *
##       /   \   /  \\d   *
##      *     \ /    \\d / 
##             *       *
##
##  in which case we would enter the following into GAP:
##
##      gap> Stripify( [1, -2, 2], alg2.d^2, [-1] );
##
##  Hopefully this figure explains the numbers in the lists (and how they
##  should be understood as working outwards from the reference syllable).
##
##        1    -2   2        dd  -1
##          *           *
##        /   \       /    \\d     *
##      *       \   /        \\d  / 
##                *             *
##
##  Now, in fact, we needn't specify an entire syllable. Any nonstationary sub-
##  -path will do. We then enter left_list and right_list arguments relative to
##  the left and right ends of whatever subpath we choose. Here are two
##  examples.
##
##         *        *
##       /  \     /   \   *
##      *    \\c /     \ / 
##             *        *
##      gap> Stripify( [1, -1], alg2.c, [ -2, 2, -1 ] );
##
##         *        *
##       /  \\c   /   \   *
##      *    \   /     \ / 
##             *        *
##      gap> Stripify( [1], alg2.c, [ 1, -2, 2, -1 ] );
##
##  In the above, we've been reading strips left-to-right, but this is
##  artificial. We could just as well think of the strip as:
##
##              *        *
##      *     /d  \c   /b \a
##       \b  /d    \a /c    *
##         *         *
##
##      (b) (d)^-2 (ca) (bc)^-1 (a)
##
##  We can <Stripify> this just as easily:
##
##              *         *
##      *     /   \\c   /  \ 
##       \   /     \\a /     *
##         *         *
##
##      gap> Stripify( [-1, 2], alg2.c * alg2.a, [-2, 1] );
##
##              *         *
##      *     /   \\c   /  \ 
##       \   /     \   /     *
##         *         *
##
##      gap> Stripify( [-1, 2], alg2.c, [1, -2, 1] );
##
##  <Stripify> has some in-built error testing. If you see any of the following
##  error messages then SBSTRIPS thinks you've given it dud input. 
##    + I cannot find an overquiver path that lifts the given path [path]!
##        Contact the maintainer of the sbstrips package.
##    + The given path does not belong to a special biserial algebra!
##    + The given path does not lift!
##    + <left_list> and <right_list> must be lists of integers!
##    + Integers in <left_list> must alternate in sign!
##    + Integers in <right_list> must alternate in sign!
##    + The central path does not lift to the overquiver!
##    + A path in <left_list> does not lift!
##    + A path in <right_list> does not lift
##
##  Please let me know (unless you agree with its complaint). 

####---------------------------################################################
### TAKING SYZYGIES OF STRIPS   ###############################################
####---------------------------################################################

##  You two new friends are the functions <SyzygyOfStrip> and
##  <NthSyzygyOfStrip>. These are called as
##
##      SyzygyOfStrip( str );
##      NthSyzygyOfStrip( str, N );
##
##  where <str> is a strip or list of strips, and <N> is a nonnegative integer.
##  Both of these operations return a list of strips, namely the strips index-
##  -ing the nonzero summands of the syzygy of <N>th syzygy of <str>. (The 0th
##  syzygy of <str> is (the list containing) <str>.)
##
##      gap> s := Stripify( [1, -2, 2], alg2.d^2, [-1] );
##      gap> NthSyzygyOfStrip( s, 14 );
##
##  (The above calculation took 2157ms on my laptop. If you are similarly nosey
##  then you can type the following.)
##
##      gap> time;

####-------------------########################################################
### FURTHER COMMENTS    #######################################################
####-------------------########################################################

##  WHAT ABOUT SIMPLE MODULES?
##
##  I think the above method for entering a strip is pretty user-friendly. How-
##  -ever it does not provide for the strings associated to simple modules.
##  There are existing methods in SBSTRIPS to implement them but none is very
##  user-friendly.
##
##  Recall that the syzygy of any simple module S_i is the radical rad(P_i) of
##  the associated indecomposable projective module P_i. This radical is always
##  a string module. In the example algebras provided above, none of these rad-
##  -icals are simple, and so you can just use them to investigate syzygies of
##  simples. (These radicals may be decomposable... but then you can pass a
##  list of the strips indexing the summands to either syzygy operation).

##  WHAT IF I FIND BUGS?
##
##  Then you please tell me! I get the most insight if you log both your inputs
##  and GAP's outputs and send me that log file... but really I'll take what I
##  can get.

##  :)
