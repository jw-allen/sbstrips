SetPackageInfo(rec(

 PackageName := "SBStrips",

 Subtitle := "for syzygies of string modules over special biserial algebras",

 Version := "v0.7.0",

 Date := "15/08/2022",

 License := "GPL-2.0-or-later",

 Persons := [
  rec(
   LastName := "Allen",
   FirstNames := "Joe",
   IsAuthor := true,
   IsMaintainer := true,
   Email := Concatenation([
    "jo", "e.a", "llen", "@", "brist", "ol", ".", "ac", ".", "uk"
]),
   WWWHome := "https://research-information.bris.ac.uk/en/persons/joe-allen",
   PostalAddress := Concatenation([
    "School of Mathematics,\n",
    "Fry Building,\n",
    "Woodland Rd, Bristol,\n",
    "BS8 1UG"
]),
   Place := "Bristol",
   Institution := "University of Bristol"
)
],

 Status := "dev",

 SourceRepository := rec(
  Type := "git",
  URL := "https://github.com/jw-allen/sbstrips"
),

 IssueTrackerURL := Concatenation(~.SourceRepository.URL, "/issues"),

 PackageWWWHome := "https://jw-allen.github.io/sbstrips/",

 ArchiveURL := Concatenation(
  ~.SourceRepository.URL,
  "/archive/",
  ~.Version
),

 ArchiveFormats := ".tar.gz",

 README_URL :=
  Concatenation(~.PackageWWWHome, "/README"),

 PackageInfoURL :=
  Concatenation(~.PackageWWWHome, "/PackageInfo.g"),

 AbstractHTML :=
  "String modules for special biserial (SB) algebras are represented by \
string graphs. Many modules related to a given string module, including its \
syzygy, transpose and vector-space dual and hence Auslander-Reiten translate \
and inverse translate, are also string modules. These related modules can be \
calculated combinatorially rather than algebraically. SBStrips implements \
this functionality in GAP, representing string graphs as objects called \
strips. It includes some tests for associated properties such as syzygy type, \
delooping level and weak periodicity.\n\n SBStrips also includes bookkeeping \
functionality for multisets, which it calls collected lists, and it \
integrates with (and depends on) the QPA package for quiver algebras and \
their modules.",

 PackageDoc := rec(
   BookName := "SBStrips",
   ArchiveURLSubset := ["doc"],
   HTMLStart := "doc/chap0.html",
   PDFFile := "doc/main.pdf",
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

 TestFile := "tst/testall.g",

 Keywords := ["special biserial algebra", "string module", "syzygy"]
));
