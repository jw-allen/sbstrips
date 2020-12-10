SetPackageInfo( rec(

 PackageName := "SBStrips",
 
 Subtitle := "strips and strings for special biserial algebras",
 
 Version := "v0.6.0",
 
 Date := "26/11/2020",
 
 License := "GPL-2.0-or-later",
 
 Persons := [
  rec(
   LastName := "Allen",
   FirstNames := "Joe",
   IsAuthor := true,
   IsMaintainer := true,
   Email := Concatenation( [
    "jo", "e.a", "llen", "@", "brist", "ol", ".", "ac", ".", "uk" 
    ] ),
   WWWHome := "https://research-information.bris.ac.uk/en/persons/joe-allen",
   PostalAddress := Concatenation( [
    "School of Mathematics,\n",
    "Fry Building,\n",
    "Woodland Rd, Bristol,\n",
    "BS8 1UG"
     ] ),
   Place := "Bristol",
   Institution := "University of Bristol"
   )
  ],

 Status := "dev",
 
 SourceRepository := rec( 
  Type := "git", 
  URL := "https://github.com/jw-allen/sbstrips"
  ),

 IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
 
 PackageWWWHome := ~.SourceRepository.URL,
 
 ArchiveURL := Concatenation(
  ~.SourceRepository.URL,
  "/archive/",
  ~.Version
  ),
  
 ArchiveFormats := ".tar.gz",

 README_URL := 
  Concatenation( ~.PackageWWWHome, "/README" ),

 PackageInfoURL :=
  "https://github.com/jw-allen/sbstrips/blob/master/PackageInfo.g",

 AbstractHTML :=
  "String modules for special biserial (SB) algebras are represented by string\
 graphs. The syzygy of a string module (over an SB algebra) is a direct sum of\
 string modules, by a 2004 result of Liu and Morin, therefore syzygy-taking\
 can be performed at the (combinatorial) level of string graphs rather than\
 the (homological-algebraic) level of modules. This package represents string\
 graphs in <span class=\"pkgname\">GAP</span> by objects called strips and it\
 implements syzygy-taking as an operation on them. Together with some\
 utilities for book-keeping, it allows for very efficient calculation of Kth\
 syzygyies for large K.",
 
 PackageDoc := rec(
   BookName := "SBStrips",
   ArchiveURLSubset := ["doc"],
   HTMLStart := "doc/chap0.html",
   PDFFile := "doc/manual.pdf",
   SixFile := "doc/manual.six",
   LongTitle := ~.Subtitle
  ),

 Dependencies := rec(
  GAP := ">=4.11",
  NeededOtherPackages := [
   ["qpa", "1.30"], ["GAPDoc", ">=1.6"]
   ],
  SuggestedOtherPackages := [],
  ExternalConditions := []
  ),

 AvailabilityTest := ReturnTrue,

 Keywords := [ "special biserial algebra", "string module", "syzygy" ]
) );
