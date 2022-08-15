# Save for very minor adjustments, the code in this file was written by Dr
#  Frank Luebeck in answer to an issue I posted on GAPDoc's issue tracker on
#  GitHub: see https://github.com/frankluebeck/GAPDoc/issues/44 . I thank him
#  for his help and for this code. I also thank Prof Max Horn for his
#  suggestions with my issue.


# The string <pathtoroot> gives the location of the root directory of GAP, rel-
#  -ative to the path <path>, below. (Informally, it describes how to go "from
#  path to root".)

pathtoroot := "../../../../../../gap-4.11.0/";

if IsBound(pathtoroot) then
  relpath := pathtoroot;

else
  relpath:="../../..";

fi;

LoadPackage("GAPDoc");


# This string <path> specifies the (absolute) location of the  doc/  directory
#  of my package. Once SBStrips leaves its development phase and I keep the
#  source code in (the  pkg/  subdirectory of) the root GAP directory, I must
#  update <path>.

path := "/proc/cygdrive/C/Users/Joe/Documents/GitHub/pkg/sbstrips-0.7.0/doc";
main := "main.xml";
files := ["../lib/1reg.gd",
           "../lib/info.gd",
           "../lib/overquiver.gd",
           "../lib/patchreps.gd",
           "../lib/permdata.gd",
           "../lib/strips.gd",
           "../lib/syllables.gd",
           "../lib/util.gd",
           "../lib/vertseqs.gd",
           "titlepage.xml",
           "ChExample.xml",
           "ChIntroduction.xml",
           "ChMathematicalBackground.xml",
           "ChQpaUtilities.xml",
           "ChStripsSyzygies.xml",
           "ChMiscUtilities.xml",
           "ApExampleSbas.xml",
           "sbstripsbib.xml"
];
bookname := "SBStrips";

MakeGAPDocDoc(path, main, files, bookname, relpath, "MathJax");

# This makes HTML versions look nicer
CopyHTMLStyleFiles("Documents/GitHub/pkg/sbstrips-0.7.0/doc/");

# This affords compatibility with old style package manuals
GAPDocManualLab("SBStrips");
