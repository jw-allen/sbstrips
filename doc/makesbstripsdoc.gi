##  These functions only exist for the convenience of the author, Joe Allen.
##   The end user should not need them (and, indeed, they're unlikely to work
##   on your device). 
##  These functions take straight from Chapter 5 of the GAPDoc manual.

InstallGlobalFunction(
    SBStripsDocumentationList,
    function()
        local
            bookname,   # What the created documents should be called
            doc,        # Composed document
            files,      # Where the parser should look
            main,       # Main XML file to be unpacked
            path,       # Documentation directory
            r;          # GAPDoc tree for SBStrips

        # Define input to <ComposedDocument>
        path := Directory( "./gap4r8/pkg/sbstrips/doc" );
        main := "main.xml";
        files := [ "../lib/1reg.gd",
                   "../lib/overquiver.gd",
                   "../lib/panels.gd",
                   "../lib/patchreps.gd",
                   "../lib/permdata.gd",
                   "../lib/strips.gd",
                   "../lib/syllables.gd",
                   "../lib/util.gd",
                   "../lib/vertseqs.gd",
                   "sbstripsbib.bib"
                   ];
        bookname := "sbstripsdoc";
        doc := ComposedDocument("GAPDoc", path, main, files, true);
        
        # Make GAPDoc tree
        r := ParseTreeXMLString( doc[1], doc[2] );
        CheckAndCleanGapDocTree(r);
        
        return [ r, path, main, files, bookname, doc ];
    end
);

InstallGlobalFunction(
    MakeSBStripsDoc1,
    function()
        local
            bookname,   # What the created documents should be called
            l,          # Document as LaTeX file
            list,       # SBStrips documentation data list
            path,       # Documentation directory
            r,          # GAPDoc tree for SBStrips
            t;          # Document as text file
        
        list := SBStripsDocumentationList();
        r := list[1];
        path := list[2];
        bookname := list[5];
        
        # Make text files
        t := GAPDoc2Text( r , path );
        GAPDoc2TextPrintTextFiles( t , path );
        
        # Make LaTeX files
        l := GAPDoc2LaTeX( r );
        FileString(
         Filename( path, Concatenation( bookname, ".tex") ),
         l
         );
    end
);

InstallGlobalFunction(
    MakeSBStripsDoc2,
    function()
        local
            bookname,   # What the created documents should be called
            h,          # Document as HTML file
            list,       # SBStrips documentation data list
            path,       # Documentation directory
            r;          # GAPDoc tree for SBStrips
            
        list := SBStripsDocumentationList();
        r := list[1];
        path := list[2];
        bookname := list[5];
        
        # Add page number information to Six file
        AddPageNumbersToSix(
         r,
         Filename(
          path,
          Concatenation( bookname, ".pnr" )
          )
         );
        PrintSixFile( Filename( path, "manual.six" ), r, bookname );
        
        h := GAPDoc2HTML(r, path);
        GAPDoc2HTMLPrintHTMLFiles(h, path);
    end
);

#########1#########2#########3#########4#########5#########6#########7#########
