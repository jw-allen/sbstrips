SetPackageInfo( rec(

 PackageName := "SBStrips",
 
 Subtitle := "strips and strings for special biserial algebras",
 
 Version := "v0.6.0",
 
 Date := "05/11/2020",
 
 License := "GPL-2.0-or-later",
 
 Persons := [
  rec(
   LastName := "Allen",
   FirstNames := "Joe",
   IsAuthor := true,
   IsMaintainer := true,
   Email := Concatenation( [
    "jo", "e.a", "llen", "@", "brist", "ol", ".", "ac", ".", "uk" 
    ]),
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
  "The <span class=\"pkgname\">SBstrips</span> package models 'strings' -- \
the decorated graphs used in representation theory. These graphs are known \
to describe a type of module for a special biserial algebra called a string \
module. The syzygy of a string module is a direct sum of string modules; \
hence syzygy-taking is essentially a one-to-many operation on strings. \
<span class=\"pkgname\">SBstrips</span> package implements 'strings' as a \
data structure called 'strips', and performs this syzygy calculation.",
 
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
