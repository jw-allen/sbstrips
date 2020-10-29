# Set up
path := Directory( "./gap4r8/pkg/sbstrips/doc/" );
files := [ "../lib/1reg.gd", "../lib/overquiver.gd", "../lib/panels.gd",
 "../lib/patchreps.gd", "../lib/permdata.gd", "../lib/strips.gd",
 "../lib/syllables.gd", "../lib/util.gd", "../lib/vertseqs.gd",
 "titlepage.xml", "discrete_model_chap.xml", "example_chap.xml",
 "introduction_chap.xml", "patches_chap.xml", "permissible_data_chap.xml",
 "quiver_utilities_overquiver_chap.xml", "strips_syzygies_chap.xml",
 "syllables_chap.xml", "utilities_chap.xml", "vis_encodings_chap.xml",
 "sbstripsbib.xml"
 ];
bookname := "manual";

# Compose document
doc := ComposedDocument("GAPDoc", path, main, files, true);

# Make and check tree 
r := ParseTreeXMLString( doc[1], doc[2] );
CheckAndCleanGapDocTree( r );

# Make and print text files
t := GAPDoc2Text( r , path );
GAPDoc2TextPrintTextFiles( t , path );

# Make and print LaTeX files
l := GAPDoc2LaTeX( r );
FileString( Filename( path, Concatenation( bookname, ".tex") ), l );

# At this point, run TeX
# REMEMBER TO RUN BIBTEX AND MAKEINDEX!

# Add page number information to Six file
AddPageNumbersToSix( r, Filename( path, Concatenation( bookname, ".pnr" ) ) );
PrintSixFile( Filename( path, "manual.six" ), r, bookname );

# Make and print HTML files
h := GAPDoc2HTML( r, path );
GAPDoc2HTMLPrintHTMLFiles( h, path );