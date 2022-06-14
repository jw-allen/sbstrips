##  Test file for the  sbstrips  package

# Begin test
gap> START_TEST("sbstrips.tst");

# Quiver algebra construction using  qpa .
gap> quiv1 := Quiver(2,
> [[1, 1, "a"], [1, 2, "b"], [2, 1, "c"], [2, 2, "d"]]
> );
<quiver with 2 vertices and 4 arrows>
gap> pa1 := PathAlgebra(Rationals, quiv1);
<Rationals[<quiver with 2 vertices and 4 arrows>]>
gap> rels := [pa1.a * pa1.a, pa1.b * pa1.d,
>              pa1.c * pa1.b, pa1.d * pa1.c,
>              pa1.c * pa1.a * pa1.b, (pa1.d)^4,
>              pa1.a * pa1.b * pa1.c - pa1.b * pa1.c * pa1.a];
[(1)*a^2, (1)*b*d, (1)*c*b, (1)*d*c, (1)*c*a*b, (1)*d^4,
  (1)*a*b*c+(-1)*b*c*a]
gap> gb := GBNPGroebnerBasis(rels, pa1);
[(1)*a^2, (1)*b*d, (1)*c*b, (1)*d*c, (-1)*a*b*c+(1)*b*c*a, (1)*c*a*b,
  (1)*d^4]
gap> ideal := Ideal(pa1, gb);
<two-sided ideal in <Rationals[<quiver with 2 vertices and 4 arrows>]>,
  (7 generators)>
gap> GroebnerBasis(ideal, gb);
<complete two-sided Groebner basis containing 7 elements>
gap> alg1 := pa1/ideal;
<Rationals[<quiver with 2 vertices and 4 arrows>]/
<two-sided ideal in <Rationals[<quiver with 2 vertices and 4 arrows>]>,
  (7 generators)>>

#   Teaching a strip to  sbstrips
gap> s := Stripify(alg1.a, -1, [2, -1, 1, -1, 1, -2, 1]);
(a)^-1(b*c) (a)^-1(b) (d)^-1(c) (c*a)^-1(d)
gap> IsStripRep(s);
true
gap> t := Stripify(alg1.d, -1, [2, -1, 1, -1, 1, -2, 1]);
(d)^-1(c*a) (c)^-1(d) (b)^-1(a) (b*c)^-1(a)
gap> s = t;
true

# How to calculate syzygies of string(module)s using strips
gap> SyzygyOfStrip(s);
[(v2)^-1(c) (a)^-1(b*c) (c*a)^-1(d^2), (a)^-1(v1), (d)^-1(v2)]
gap> Length(last);
3
gap> 4th_syz := NthSyzygyOfStrip(s, 4);
[(v2)^-1(c*a) (c)^-1(v2), (v2)^-1(d^2), (a)^-1(v1), (v2)^-1(d^2),
  (a)^-1(b*c) (a)^-1(v1), (d^2)^-1(v2), (v1)^-1(a), (v2)^-1(v2),
  (v2)^-1(c) (c*a)^-1(v2), (v1)^-1(a), (v2)^-1(v2),
  (v2)^-1(c) (c*a)^-1(v2), (v2)^-1(v2), (a)^-1(v1),
  (v2)^-1(c*a) (c)^-1(v2), (v2)^-1(d), (a)^-1(v1), (v2)^-1(d^2),
  (a)^-1(v1), (d^2)^-1(v2)]
gap> Length(4th_syz);
20
gap> Set(4th_syz);
[(v2)^-1(v2), (a)^-1(v1), (v2)^-1(d), (v2)^-1(d^2),
  (v2)^-1(c*a) (c)^-1(v2), (a)^-1(b*c) (a)^-1(v1)]
gap> Collected(4th_syz);
[[(v2)^-1(v2), 3], [(a)^-1(v1), 6], [(v2)^-1(d), 1],
  [(v2)^-1(d^2), 5], [(v2)^-1(c*a) (c)^-1(v2), 4],
  [(a)^-1(b*c) (a)^-1(v1), 1]]
gap> CollectedSyzygyOfStrip(s);
[[(a)^-1(v1), 1], [(d)^-1(v2), 1],
  [(v2)^-1(c) (a)^-1(b*c) (c*a)^-1(d^2), 1]]
gap> CollectedNthSyzygyOfStrip(s, 4);
[[(v2)^-1(c) (c*a)^-1(v2), 4], [(v2)^-1(v2), 3], [(v1)^-1(a), 6],
  [(v2)^-1(d^2), 5], [(v2)^-1(d), 1], [(a)^-1(b*c) (a)^-1(v1), 1]]

# How to calculate Nth syzygies efficiently for large N
gap> CollectedNthSyzygyOfStrip(s, 20);
[[(v2)^-1(c) (c*a)^-1(v2), 66012], [(v2)^-1(v2), 55403],
  [(v1)^-1(a), 121414], [(v2)^-1(d^2), 101901], [(v2)^-1(d), 1],
  [(a)^-1(b*c) (a)^-1(v1), 1]]
gap> CollectedNthSyzygyOfStrip(s, 200);
[[(v2)^-1(c) (c*a)^-1(v2),
      28610320653810477165032088685001500201865067503083660],
  [(v2)^-1(v2), 24012263187173292438733091914788756514219413052446981]
    ,
  [(v1)^-1(a), 52622583840983769603765180599790256716084480555530640],
  [(v2)^-1(d^2), 44165437642884416151601614150885951220530708429827491
], [(v2)^-1(d), 1], [(a)^-1(b*c) (a)^-1(v1), 1]]

# How to call the strips representing simple, projective and injective
#  (string) modules

gap> SimpleStripsOfSBAlg(alg1);
[(v1)^-1(v1), (v2)^-1(v2)]
gap> Stripify(alg1.a * alg1.b);
(a*b)^-1(v1)
gap> Stripify(alg1.c);
(c)^-1(v2)
gap> Stripify(alg1.d^3);
(d^3)^-1(v2)
gap> Stripify(alg1.v1);
(v1)^-1(v1)
gap> s1 := Stripify(alg1.v1);;
gap> s2 := Stripify(alg1.v2);;
gap> SimpleStripsOfSBAlg(alg1);
[(v1)^-1(v1), (v2)^-1(v2)]
gap> [s1, s2] = SimpleStripsOfSBAlg(alg1);
true
gap> IndecProjectiveStripsOfSBAlg(alg1);
[fail, (c*a)^-1(d^3)]
gap> IndecInjectiveStripsOfSBAlg(alg1);
[fail, (v1)^-1(a*b) (d^3)^-1(v2)]

# Some inbuilt tests for string modules using strips
gap> SetInfoLevel(InfoSBStrips, 3);
gap> alg2 := SBStripsExampleAlgebra(2);
#I  The quiver of this algebra has 3 vertices
#I    v1
#I    v2
#I    v3
#I  and 3 arrows
#I    a: v1 --> v2
#I    b: v2 --> v3
#I    c: v3 --> v1
<Rationals[<quiver with 3 vertices and 3 arrows>]/
<two-sided ideal in <Rationals[<quiver with 3 vertices and 3 arrows>]>,
  (3 generators)>>
gap> SetInfoLevel(InfoSBStrips, 2);
gap> UniserialStripsOfSBAlg(alg2);
[(v1)^-1(v1), (v2)^-1(v2), (v3)^-1(v3), (a)^-1(v1), (b)^-1(v2),
  (c)^-1(v3), (a*b)^-1(v1), (b*c)^-1(v2), (c*a)^-1(v3), (a*b*c)^-1(v1),
  (b*c*a)^-1(v2), (c*a*b)^-1(v3)]
gap> u := last[7];
(a*b)^-1(v1)
gap> IsWeaklyPeriodicStripByNthSyzygy(u, 4);
#I  Examining strip: (a*b)^-1(v1)
#I  This strip does not occur as a summand of its first 4 syzygies
false
gap> IsWeaklyPeriodicStripByNthSyzygy(u, 10);
#I  Examining strip: (a*b)^-1(v1)
#I  This strip first appears as a direct summand of its 6th syzygy
true
gap> UniserialStripsOfSBAlg(alg1);
[(v1)^-1(v1), (v2)^-1(v2), (a)^-1(v1), (b)^-1(v1), (c)^-1(v2),
  (d)^-1(v2), (a*b)^-1(v1), (b*c)^-1(v1), (c*a)^-1(v2), (d^2)^-1(v2),
  (d^3)^-1(v2)]
gap> uu := last[7];
(a*b)^-1(v1)
gap> IsWeaklyPeriodicStripByNthSyzygy(uu, 10);
#I  Examining strip: (a*b)^-1(v1)
#I  This strip does not occur as a summand of its first 10 syzygies
false
gap> IsWeaklyPeriodicStripByNthSyzygy(uu, 100);
#I  Examining strip: (a*b)^-1(v1)
#I  This strip does not occur as a summand of its first 100 syzygies
false
gap> IsWeaklyPeriodicStripByNthSyzygy(uu, 10000);
#I  Examining strip: (a*b)^-1(v1)
#I  This strip does not occur as a summand of its first 10000 syzygies
false
gap> IsFiniteSyzygyTypeStripByNthSyzygy(uu, 10000);
#I  Examining strip: (a*b)^-1(v1)
#I  This strip has finite syzygy type.
#I  The set of strings appearing as summands of its first N syzygies\
stabilizes at index N=4, at which point it has cardinality 6
true
gap> s1 := SimpleStripsOfSBAlg(alg1)[1];
(v1)^-1(v1)
gap> IsFiniteSyzygyTypeStripByNthSyzygy(s1, 10);
#I  Examining strip: (v1)^-1(v1)
#I  The set of strings appearing as summands of its first 10 syzygies h\
as cardinality 15
false
gap> IsFiniteSyzygyTypeStripByNthSyzygy(s1, 100);
#I  Examining strip: (v1)^-1(v1)
#I  The set of strings appearing as summands of its first 100 syzygies \
has cardinality 105
false
gap> U := UniserialStripsOfSBAlg(alg1);;
gap> a := U[3]; b := U[4]; ab := U[7];
(a)^-1(v1)
(b)^-1(v1)
(a*b)^-1(v1)
gap> DeloopingLevelOfStripIfAtMostN(a, 0);
0
gap> DeloopingLevelOfStripIfAtMostN(a, 1);
0
gap> DeloopingLevelOfStripIfAtMostN(b, 0);
fail
gap> DeloopingLevelOfStripIfAtMostN(b, 1);
1
gap> DeloopingLevelOfStripIfAtMostN(ab, 10);
2
gap> DeloopingLevelOfSBAlgIfAtMostN(alg1, 10);
0
gap> DeloopingLevelOfSBAlgIfAtMostN(alg2, 10);
0
gap> for k in [1 .. 5] do
>   Print(
>     DeloopingLevelOfSBAlgIfAtMostN(SBStripsExampleAlgebra(k), 10)
>   );
>   Print("\n");
> od;
#I  The quiver of this algebra has 2 vertices
#I  and 4 arrows
0
#I  The quiver of this algebra has 3 vertices
#I  and 3 arrows
0
#I  The quiver of this algebra has 4 vertices
#I  and 8 arrows
2
#I  The quiver of this algebra has 8 vertices
#I  and 16 arrows
0
#I  The quiver of this algebra has 4 vertices
#I  and 8 arrows
1

gap> for k in [1 .. 5] do
>   TestInjectiveStripsUpToNthSyzygy(SBStripsExampleAlgebra(k), 10);
> od;
#I  The quiver of this algebra has 2 vertices
#I  and 4 arrows
#I  Examining strip: (v1)^-1(a*b) (d*d*d)^-1(v2)
#I  This strip has finite syzygy type.
#I  The set of strings appearing as summands of its first N syzygies stabilizes at index N=3, at which point it has cardinality 5
The given SB algebra has passed the test!
#I  The quiver of this algebra has 3 vertices
#I  and 3 arrows
#I  Examining strip: (v1)^-1(a*b*c)
#I  This strip has finite syzygy type.
#I  The set of strings appearing as summands of its first N syzygies stabilizes at index N=0, at which point it has cardinality 1
#I  Examining strip: (v2)^-1(b*c*a)
#I  This strip has finite syzygy type.
#I  The set of strings appearing as summands of its first N syzygies stabilizes at index N=0, at which point it has cardinality 1
#I  Examining strip: (v3)^-1(c*a*b)
#I  This strip has finite syzygy type.
#I  The set of strings appearing as summands of its first N syzygies stabilizes at index N=0, at which point it has cardinality 1
The given SB algebra has passed the test!
#I  The quiver of this algebra has 4 vertices
#I  and 8 arrows
#I  Examining strip: (v1)^-1(a*b*c*d) (f*g*h*f*g*h)^-1(v1)
#I  This strip has finite syzygy type.
#I  The set of strings appearing as summands of its first N syzygies stabilizes at index N=7, at which point it has cardinality 14
#I  Examining strip: (v2)^-1(b*c*d*a*b) (g*h*f*g*h*f*g)^-1(v2)
#I  This strip has finite syzygy type.
#I  The set of strings appearing as summands of its first N syzygies stabilizes at index N=6, at which point it has cardinality 13
The given SB algebra has passed the test!
#I  The quiver of this algebra has 8 vertices
#I  and 16 arrows
#I  Examining strip: (v7)^-1(n*o*p*a) (n*o*p)^-1(v7)
#I  This strip has finite syzygy type.
#I  The set of strings appearing as summands of its first N syzygies stabilizes at index N=8, at which point it has cardinality 21
#I  Examining strip: (v1)^-1(b*c*d) (d*e*f)^-1(v2)
#I  This strip has finite syzygy type.
#I  The set of strings appearing as summands of its first N syzygies stabilizes at index N=8, at which point it has cardinality 22
#I  Examining strip: (v4)^-1(f*g*h) (g*h*i*j)^-1(v3)
#I  This strip has finite syzygy type.
#I  The set of strings appearing as summands of its first N syzygies stabilizes at index N=9, at which point it has cardinality 16
#I  Examining strip: (v4)^-1(h*i*j*k) (i*j*k*l*m)^-1(v5)
#I  This strip has finite syzygy type.
#I  The set of strings appearing as summands of its first N syzygies stabilizes at index N=8, at which point it has cardinality 16
The given SB algebra has passed the test!
#I  The quiver of this algebra has 4 vertices
#I  and 8 arrows
#I  Examining strip: (v1)^-1(a*b*c*d*a) (e*f*g*e*f*g*e)^-1(v1)
#I  This strip has finite syzygy type.
#I  The set of strings appearing as summands of its first N syzygies stabilizes at index N=6, at which point it has cardinality 13
#I  Examining strip: (v3)^-1(c*d*a*b*c) (h*h*h*h*h)^-1(v4)
#I  This strip has finite syzygy type.
#I  The set of strings appearing as summands of its first N syzygies stabilizes at index N=4, at which point it has cardinality 12
The given SB algebra has passed the test!

# How to turn a strip into a quiver representation
gap> module := ModuleOfStrip(s);
<[6, 5]>
gap> Print(module);
<Module over <Rationals[<quiver with 2 vertices and 4 arrows>]/
<two-sided ideal in <Rationals[<quiver with 2 vertices and 4 arrows>]>
, (7 generators)>> with dimension vector [6, 5]>
gap> 4th_syz := NthSyzygyOfStrip(s, 4);;
#I  Examining strip: (a)^-1(b*c) (a)^-1(b) (d)^-1(c) (c*a)^-1(d)
#I  Calculated 1st syzygy...
#I  Calculated 2nd syzygy...
#I  Calculated 3rd syzygy...
#I  Calculated 4th syzygy...
gap> ModuleOfStrip(4th_syz);
[<[2, 2]>, <[0, 3]>, <[2, 0]>, <[0, 3]>, <[4, 1]>,
  <[0, 3]>, <[2, 0]>, <[0, 1]>, <[2, 2]>, <[2, 0]>,
  <[0, 1]>, <[2, 2]>, <[0, 1]>, <[2, 0]>, <[2, 2]>,
  <[0, 2]>, <[2, 0]>, <[0, 3]>, <[2, 0]>, <[0, 3]>]
gap> coll_4th_syz := CollectedNthSyzygyOfStrip(s, 4);
[[(v2)^-1(c) (c*a)^-1(v2), 4], [(v2)^-1(v2), 3], [(v1)^-1(a), 6],
  [(v2)^-1(d^2), 5], [(v2)^-1(d), 1], [(a)^-1(b*c) (a)^-1(v1), 1]
]
gap> ModuleOfStrip(coll_4th_syz);
[[<[2, 2]>, 4], [<[0, 1]>, 3], [<[2, 0]>, 6],
  [<[0, 3]>, 5], [<[0, 2]>, 1], [<[4, 1]>, 1]]
gap> 4th_syz := NthSyzygyOfStrip(s, 4);;
#I  Examining strip: (a)^-1(b*c) (a)^-1(b) (d)^-1(c) (c*a)^-1(d)
#I  Calculated 1st syzygy...
#I  Calculated 2nd syzygy...
#I  Calculated 3rd syzygy...
#I  Calculated 4th syzygy...
gap> coll_4th_syz := CollectedNthSyzygyOfStrip(s, 4);;
gap> DirectSumModuleOfListOfStrips(4th_syz);
<[24, 29]>
gap> DirectSumModuleOfListOfStrips(coll_4th_syz);
<[24, 29]>

# Collected lists
gap> list := ["s", "b", "s", "t", "r", "i", "p", "s"];
["s", "b", "s", "t", "r", "i", "p", "s"]
gap> clist := Collected(list);
[["b", 1], ["i", 1], ["p", 1], ["r", 1], ["s", 3],
["t", 1]]
gap> entry := clist[5];
["s", 3]
gap> hello := Collected(["h", "e", "l", "l", "o"]);
[["e", 1], ["h", 1], ["l", 2], ["o", 1]]
gap> world := Collected(["w", "o", "r", "l", "d"]);
[["d", 1], ["l", 1], ["o", 1], ["r", 1], ["w", 1]]
gap> hello_world := Concatenation(hello, world);
[["e", 1], ["h", 1], ["l", 2], ["o", 1], ["d", 1],
["l", 1], ["o", 1], ["r", 1], ["w", 1]]
gap> IsCollectedList(hello_world);
true
gap> Recollected(hello_world);
[["e", 1], ["h", 1], ["l", 3], ["o", 2], ["d", 1],
["r", 1], ["w", 1]]

# 1-regular quivers
gap> Q1 := 1RegQuivFromCycleLengths([2, 3, 4, 5, 7]);
<quiver with 21 vertices and 21 arrows>
gap> Is1RegQuiver(Q1);
true
gap> equality := [];;
gap> for v in VerticesOfQuiver(Q1) do
>   Add(equality, 1RegQuivIntAct(v, 420) = v);
> od;
gap> ForAll(equality, x -> x);
true
gap> equality := [];;
gap> for v in VerticesOfQuiver(Q1) do
>   Add(equality, 1RegQuivIntAct(v, 11) = v);
> od;
gap> ForAny(equality, x -> x);
false

# 2-regular quivers
gap> Q2 := 1RegQuivFromCycleLengths([2, 3, 4, 5]);
<quiver with 14 vertices and 14 arrows>
gap> Is1RegQuiver(Q2);
true
gap> parts1 := [];;
gap> parts2 := [];;
gap> parts3 := [];;
gap> for k in [1 .. NumberOfVertices(Q2) / 2] do
>   Add(parts1, VerticesOfQuiver(Q2){[2 * k - 1, 2 * k]});
>   Add(parts2, VerticesOfQuiver(Q2){[k, NumberOfVertices(Q2) - k + 1]});
>   Add(parts3, VerticesOfQuiver(Q2){[k, NumberOfVertices(Q2) / 2 + k]});
> od;
gap> Q2reg1 := QuiverQuotient(Q2, parts1);
<quiver with 7 vertices and 14 arrows>
gap> Q2reg2 := QuiverQuotient(Q2, parts2);
<quiver with 7 vertices and 14 arrows>
gap> Q2reg3 := QuiverQuotient(Q2, parts3);
<quiver with 7 vertices and 14 arrows>
gap> Is2RegQuiver(Q2reg1);
true
gap> Is2RegQuiver(Q2reg2);
true
gap> Is2RegQuiver(Q2reg3);
true

# End test
gap> STOP_TEST("sbstrips.tst");
