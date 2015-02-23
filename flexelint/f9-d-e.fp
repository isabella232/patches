1V1.0
SVers. 9.00d
SVers. 9.00e
2880Hcustom.c
337Hcustom.h
490Ha2.c
1779Ha3.c
735Ha4.c
2567Ha5.c
3307Ha6.c
1845Ha7.c
1031Ha8.c
1345Ha9.c
2820Ha10.c
3659Ha11.c
225Ha12.c
3887Ha13.c
3793Ha14.c
1473Ha15.c
1437Ha16.c
1860Ha17.c
3187Ha18.c
3115Ha19.c
97Ha20.c
2789Ha21.c
145Ha22.c
3490Ha23.c
3005Ha24.c
200Ha25.c
237Ha26.c
4102Ha27.c
1895Ha28.c
776Ha29.c
3854Ha30.c
Fcustom.c
35861D1I1"e"
12D1
1549D4
25I9"

       "
13D4I8"
       "
15D9I52"<ptr to buffer initially containing the null string>"
14I66"    parent == <name of an actively #include'ing file if any>

    "
7I5"will "
6D34
39D5I39"FILE * associated with the opened file."
10D63I22"If parent is non-null,"
68D42
51D2I27" name of the parent will be"
7D31I20"placed into the loca"
36D28I22"pointed to by prefix.
"
33D5I2"If"
21D13I32"NULL, indicating failure to find"
18D21I5"file,"
26D1I5"and i"
7D51I54"Lint option +compiler(search_actively_including_stack)"
56D9I78"(needed to support Microsoft's compiler strategy),
    lint will make repeated"
14D16I11"s to i_open"
22D16I18"the same arguments"
21D84I19"but where parent is"
89D7I17"parent #including"
12D43I13"prior parent."
48D2I18"This goes on until"
7D52I38"current including stack is exhausted;
"
57D73I30"if i_open returns NULL in each"
79D40I18"ose instances then"
45D7I67"i_open is called again with

        ordinal == 2
        prefix =="
12I34"first -i parameter (specifying an "
6D40I2"e "
46I6"ory).
"
5D65I30"This is repeated for each -i o"
70D11I68" increasing ordinal each time until
    i_open returns a non NULL or"
16D34I37"-i list is exhausted.  If the -i list"
39D111I12"is exhausted"
119D20I49"re is still no success, i_open is called one last"
25D58I68"time with ordinal == 0 and prefix == NULL.  If NULL is returned this"
64D35I37"ime, error No. 7 is reported.

    If"
40D20I55"name of the file opened is not simply the concatenation"
28D51I13"the name with"
56D37I37"prefix then name should be overwritte"
43D95I4"(nam"
100D67I1"a"
73D3I48"er to a buffer of MAXFNM length).

    parent is"
8D35I7"name of"
40D49I7"current"
55D3I25"being processed. i.e. the"
8D58I7"name of"
63I10"including "
5D148I37"  It is NULL for modules and indirect"
153D14I50"files.  line is the current include line, if any.
"
19D14I65"As an exceptional case, if the include directive contains neither"
19D1I64"quotes nor angle brackets, the information following the include"
7D17I15"s passed as the"
24D33I47"the delimeter is 0, and the parent is nonNULL.
"
38D52I58"This argument list has been made deliberately more general"
57D27I61"than was required in order to handle the diverse requirements"
32D113I25"of a variety of systems.
"
118D13I67"Lint will close files if the include file depth becomes larger than"
18D14I69"MAX_OPEN.  Subsequently, i_open is used to reopen the files, with the"
19D4
11D1I65" = -1, and line is either null or if the name had previously been"
6D16I61"overwritten will point to the overwritten name).  The rest of"
21D16I62"the arguments are identical to the ones used when the file was"
21D1I89"opened originally. The prefix is never NULL when reopening the file.
 */

/*lint +fvr */
"
9D106I10"strcpy();
"
114D11I46"strcat();
/*lint -fvr */
int sys_env_var();   "
16D16I31"forward reference */

FILE * i_"
22D4I13" name, mode )"
9I1"c"
8D4I5"name;"
9D53I8"cCHARPTR"
58D16I1";"
21D32I1"{"
41D26I54"!attempt_open( name, mode ) ) return NULL;
#if OS_MINT"
31D5I52"if( gfl_sh > 0 ) return shopen( name, mode );
#endif"
10D59I27"return fopen( name, mode );"
64D20I112"}

/*lint -e{715}  unused paramters are OK in this function */

FILE * i_open( name, delimeter, ordinal, prefix,"
27D12I8", line )"
17I15"cCHARPTR name;
"
5D2I21"nt delimeter;
    int"
10D57I1";"
62D56I15"CHARPTR prefix;"
61D15I15"cCHARPTR parent"
21D5I14"cCHARPTR line;"
10D15I1"{"
20D5I64"char buffer[ARG_LEN]; /* max file name length set in custom.h */"
10D10I40"FILE *f = NULL;
    cCHARPTR mode = "r";"
15D18I23"2nd argument to fopen()"
26D39I15"CHARPTR p;


  "
44D21I68"if the +frb flag is set then "rb" will be the open mode if available"
29D4
12D2I2"rb"
7I41") mode = MD_RD_B;
    if( delimeter == 0 "
11I17"
        {
      "
5D35I52"do not accept delimeter == 0 unless this is a module"
47D2I32"in which case parent == NULL  */"
11D29I18"if( ordinal == 1 )"
42D28I1"{"
41D65I12"Errorno(12);"
78D16I62"/* This will be issued only once (even though it's possible to"
29D49I56"   come here more than once with ordinal==1 for the same"
65D40I57"file search in the case of the "actively-including-stack""
53D26I14"   search). */"
39D19I1"}"
28D27I52"/* Note the above error is in addition to error 7 */"
36I23"return NULL;
        }
"
5D53I14"witch(ordinal)"
62D5I1"{"
10D9I7"case 1:"
14I11"/* Either:
"
7D24
32D6I37"     - it's the first time through or"
11D59
67D57
65D5I51"- we're doing an "actively-including-stack" search."
18D15
25D35I2"*/"
44D10I64"if( delimeter == '<' ) return NULL;  /* try directories first */"
19D5I66"if( gfl_di > 0 && parent )  /* use directory of including file? */"
14D45I5"    {"
50D76
101D33I8"arent );"
42D19I7"    p ="
27D9I17"+ strlen(buffer);"
18D7I60"    while( *--p != SEP1 && *p != SEP1A && *p != SEP1B && p >"
14D20I2" )"
33D1I16"    /* loop */ ;"
14D14I49"/* emerging: p points to SEP1 (or SEP1A or SEP1B)"
27D7I32"   OR neither char found and p ="
15D11I3" */"
24D5I26"if( p > buffer ) p[1] = 0;"
18I28"else buffer[0] = 0;
        "
8D19I33"prefix ) strcpy( prefix, buffer )"
33I42"strcat( buffer, name );
            }
    "
8D25
38D5I23"strcpy( buffer, name );"
14D19I21"break;
    case -1:  "
24D30I40"attempt to reopen after a forcible close"
42D23I10"if( line )"
29D9I37"if a name was originally manufactured"
25D7I13"{
           "
14D23I7"[0] = 0"
37D60I5"sg_sf"
73D4I12"line, MAXFNM"
20D5I6"break;"
20D7
15D6I45"/*lint -fallthrough otherwise fall through */"
11D7I10"default:  "
16D45I53"middle case, or the restore case, use prefix if there"
73D7I34"prefix ? prefix : "" );
#if os_MPW"
16D6I36"(void) sys_env_var( buffer );
#endif"
15D11I15"strcat( buffer,"
17D41I13");
#if os_MVS"
46D43
51D37I1"{"
46D1I18"    int level = 0;"
10D20
25D11I7"or( p ="
18D39I11"; *p; p++ )"
48D55
63I14"{
            "
5D47I23"f( *p == '(' ) level++;"
60D47I33"    else if( *p == ')' ) level--;"
60D47I5"    }"
57D23
30D63I49"level > 0 )  /* must be a partitioned data set */"
72D1I9"        {"
6D33I27"            /* remove .H */"
38D8I45"            p = buffer + strlen( buffer ) - 2"
14D68I8"        "
73D65I35"f( strcmp( p, ".H" ) == 0 ) *p = 0;"
70D63I35"            strcat( buffer, ")'" );"
68D65I13"            }"
70D26I47"        }
#endif
        break;
    case 0:  /*"
31D32I45"case of last resort -- give plain name a shot"
40D15I27"    strcpy( buffer, name );"
20D8I9"    break"
14D12I5"    }"
17D9I52"/* if name ends in ".lob" use special binary mode */"
14D28
33D50I37"ast_ext( name, ext_TEST, dot_lob ) ||"
59D16I37"last_ext( name, ext_TEST, dot_lph ) )"
21D9I5"    {"
14D78I19"    mode = MD_RD_B;"
83D123
128D39I57" = i_fopen( buffer, mode );
#if OS_MINT | os_QNX | os_MPW"
44D57I58"    /*  this establishes a buffer of 2048 bytes for binary"
62D38I56"        input files (the only kind of file for which I/O"
43D15I11"        tim"
20D82I39"significant.  If your compiler supports"
87D15I55"        the ANSI function setvbuf, by all means use it."
20D13I22"     */
#ifndef C_terp"
18D45I24"    if( f && setvbuf( f,"
50D55I20", _IOFBF, 2048 ) ) f"
63D41I14"
#endif
#endif"
46D70I5"    }"
75D56I33"else f = i_fopen( buffer, mode );"
61D61I9"return f;"
66D49I73"}

/*  ind_tst(fn) is called to determine if the file-name provided
    i"
59D26I20"nsidered an indirect"
31D20I6".  The"
25D25I19"name was previously"
30D5I63"determined not to end in dot_lnt (see above).  This is here for"
10D39I65"historical reasons and for completeness and generality.  A better"
44D52I128"approach would be to place the option "+lnt=LNT" in sys_olist.
 */

/*lint -e{715}  unused paramters are OK in this function */
"
57D9I15"int
ind_tst(fn)"
14D22I8"char *fn"
28D4I27"{
#if os_MVS
    int len;

"
9D15I21"en = (int) strlen(fn)"
21D45
50D16I48"en > 5 && strcmp( fn + (len - 5), ".LNT'" ) == 0"
27D1I16"return 1;
#endif"
6D35I8"return 0"
41D34I68"}

 int
/*  extract_file_id( idname, len, fileNm ) will look for the"
39D4I5" name"
9I64"of a full path name and return the result (minus the extension)
"
5D12I10"n idname. "
17D17I38"is the maximum length of idname.  E.g."
22D12I67"fileNm = "C:\directory\subdir\alpha.cpp"
    will return "alpha" in"
19D28I28" provided len is at least 6."
33D34I28"If len were 5 then "alph" is"
41D3I3"ed."
8D13I2"Th"
22D2I91"value is 1 if an appropriate name could be found
 */
extract_file_id( idname, len, fileNm )"
7D6I73"CHARPTR idname;
    unsigned len;
    cCHARPTR fileNm;
    {
    cCHARPTR"
11D43I26"Dot = NULL;   /* points to"
49D6I13"dot if any */"
11D4I44"cCHARPTR lastNm = NULL;    /* points to last"
10D55I14"in the path */"
60D62I70"cCHARPTR nameEnd;          /* points just after last char of fileNm */"
67D53I15"cCHARPTR probe;"
65D38I29"/* used to traverse fileNm */"
43D34I61"char  c;                   /* temporary character variable */"
39D23I72"unsigned nchars;           /* number of characters to be copied back */
"
28D10I15"lastNm = fileNm"
16D14I42"for( probe = fileNm; c = *probe; ++probe )"
19I4"    "
6D8I20"    if( c == '.' ) {"
13D2I1"D"
7D40I8"probe; }"
45D18I53"    else if( c == SEP1 || c == SEP1A || c == SEP1B )
"
29D20I14" {
           "
25D16I11"Dot = NULL;"
21D23
29D27I19"  lastNm = probe+1;"
32D8
16I2"}
"
8D39I1"}"
44D19I45"nameEnd = probe;
    if( lastNm && *lastNm )
"
27D36I1"{"
41D44I17"    if( lastDot )"
49D11I14"End = lastDot;"
19D60I40" nchars = (unsigned) (nameEnd - lastNm);"
65D14I40"    if( nchars >= len ) nchars = len-1;
"
22D25I43"strncpy( idname, lastNm, (size_t) nchars );"
30D36I25"    idname[nchars] = '\0'"
46D44I9"return 1;"
53D13I1"}"
18D19I14"else return 0;"
24D5I66"}

/*  last_ext(name, action, suff ) will look for the last extent"
10D50I65"of a file name and either replace it (action = ext_REP) or append"
55D48I62"a default (action = ext_APP) if none exists or test it (action"
53D13I52"== ext_TEST).  The suffix must include the dot as in"
18D12I17"        last_ext("
17D23I24", ext_REP, ".bak" )
 */
"
28D31I4"int
"
36D14I25"ext( name, action, suff )"
19D68I22"register CHARPTR  name"
74D5I11"int action;"
10D29I14"cCHARPTR suff;"
34D65I1"{"
70D46I8"CHARPTR "
56D13I23"= NULL;    /* points to"
18D33I14" dot if any */"
38D65I18"CHARPTR  name_end;"
73D32I44"   /* points just after last char of name */"
37D5I56"register CHARPTR probe;      /* used to traverse name */"
10D42I8"char  c;"
50D2
10D39
44I65"/* temporary character variable */
    int retval = FALSE;       "
6D35I31"the return value */

#if os_VMS"
40D14I39"CHARPTR  trailer;    /* will point to a"
19D33I16" name trailer */"
41I79"/* such trailers will be put back after the ext_TEST case */
    char  tch = 0;"
5D45
50I66"/* trailer character */
    for( probe = name + strlen(name) - 1;
"
7D46I45"  probe > name && isdigit(*probe);  probe-- )"
56D2I12"/* loop */ ;"
7D59I19"if( *probe == ';' )"
68D17I1"{"
26D11I47"/* we really do have a trailer, snip if off */
"
16D40I47"   tch = *probe;  *probe = 0;  trailer = probe;"
49D13I26"}
#endif

    for( probe ="
18D30I23"; c = *probe; ++probe )"
39D1I1"{"
6D4I3"   "
9D27I12"c == '.' ) {"
37D41I10"= probe; }"
46I4"    "
9D28I56"c == SEP1 || c == SEP1A || c == SEP1B ) last_dot = NULL;"
33D15
21D66I33"    name_end = probe;
#if OS_MINT"
71D58I65"if( name_end > name && name_end[-1] == ':' ) return FALSE;
#endif"
63D64I24"if( action == ext_TEST )"
69D62I5"    {"
67D47I19"    if( last_dot &&"
52D6I43"fncmp( last_dot, suff) == 0 ) retval = TRUE"
12D49I64"    else if( !last_dot && *suff == 0 ) retval = TRUE;
#if os_VMS"
54D26
31D18I31"f( tch ) *trailer = tch;
#endif"
23D9I5"    }"
14D12I41"else if( action == ext_APP && !last_dot )"
17I4"    "
6D12I19"    int useit = 0;
"
17D10I18"os_UNIX | os_LINUX"
15D76I6"    /*"
81D24I31" Unix (and maybe for others ?),"
37D1I44"source files without extents should not have"
14D45I44".c appended to it.  But indirect files -- OK"
58I67"Also dot_h would have been requested with +fdh
         */
        "
5D35I39"uff == dot_lnt || suff == dot_h ) useit"
41I6"#else
"
8D5I17"useit = 1;
#endif"
14D23I12"if( useit ) "
29D61I38"lint !e774 always evaluates to true */"
69D62
67D13I9"{ strcpy("
18D49I30"_end, suff ); retval = TRUE; }"
57D63I2" }"
68D35I4"else"
41D10I77"ction == ext_REP ) strcpy( last_dot ? last_dot : name_end, suff );
#if os_VMS"
15D5I37"else if( tch ) *trailer = tch;
#endif"
10D55I14"return retval;"
60D52I68"}

/*  main(argc,argv) is, of course, the call made by the operating"
57D67I58"system to get lint started.  This gives the customizer the"
72D44I64"chance to process stylized options.  For example if the customer"
49D33I24"would want ~567 to mean "
38D2I33"off error 567 then this should be"
7D16I47"translated into -e567 before passing control to"
26D9
16D33I7"Note, t"
38D6I5"is no"
14D2I24"from sys_main(); rather,"
7D60I25"sys_exit() is called.
 */"
65D63I19"int
main(argc,argv)"
68D16I9"int argc;"
21D5I11"char **argv"
17D57I27"scr_param();
#if debug && 0"
62D19I45"test_wild_match(); return 0;
#endif
#if os_9
"
27I2"{
"
5D33I9"   int i;"
38D62I31"    for( i = 0; i < argc; i++ )"
67D20I38"        {
            /* -? on command"
27D32I22"mplies options dump */"
37D73I53"        if( strcmp( argv[i] , "-?" ) == 0 ) argc = 1;"
78D57I9"        }"
62D54I26"    }
#endif
#if os_THINKC"
59D26I25"/* Here we assume that it"
31D18I33"ifficult or impossible to prepare"
23D58I64"   a command line.  If no argument exists, an arglist consisting"
63D81I40"   of a single name is created.  This is"
86D9I3"nam"
14D29I22"a file in which
      "
34D5I59"user places arguments that would have otherwise been placed"
10D38I23"   on the command line."
43D22I3" */"
27D11I15"if( argc <= 1 )"
16D12
22D42I55"    char *av[3];    /* internally generated arglist */
"
51D2I12"av[0] =  "";"
7D39I31"/* command name not examined */"
48D5I63"av[1] = "flexe.lnt"; /* user places arguments into this file */"
14D18I40"av[2] = NULL;    /* terminate arglist */"
27D22I18"sys_main( 2, av );"
31D70I8"return 0"
80D36I8"}
#endif"
41D17I19"sys_main(argc,argv)"
23D54I40"/* control doesn't really arrive here */"
59D24
31D2I1"0"
8D59I60"}

/*  scr_need(n) requests n more lines for this screenful."
64D22I63"If n more lines do not exist then a 'new page' is required.
 */"
27D16I16"Void
scr_need(n)"
21D5I6"int n;"
10D28I1"{"
38D8I21" > (scr_ht - scr_n) )"
14D3I25"/* if not n lines left */"
12D2
7D2I10" = scr_ht;"
10D26
31I35"/* force new line next scr_out */
 "
5D21
30D6I12"out(s,nlflag"
18D39I27"to output help information."
44D6I70"If nlflag is 1 a new line is added.  The value returned is:
    0   =="
11D68I25"line was written normally"
84D64I21" line was not written"
69D26I50"-1  == the user requested printing of the previous"
33D17
22D80I6"+1  =="
85D7I68"user requested printing of the next screen.
    The logic of filling"
12D40I24"s is done by the caller."
45D66I33"The logic of when to stop filling"
71D19I13"screen is don"
26I3"
  "
6D36I27"logic of how far to back up"
41D48I30"how far to go forward is based"
53D27I76"in part on the appearance of subheadings (.c lines) within the text.
    See"
32D36I30" scr_ht and scr_wth above.
 */"
41D43I22"int
scr_out(s, nlflag)"
48D74I11"cCHARPTR s;"
82D14I8" nlflag;"
19D19I1"{"
24D1I71"if( scr_n >= scr_ht && std_err == stderr )
        {
        scr_n = 1;"
6D10I1"!"
17D2I4"&& !"
11D21
26D31I9"        {"
36D16I22"        char buf[120];"
21D59I26"        unsigned char ch;
"
64D27I75"        fprintf( std_err, "------> quit (q), previous (p), or next [n] " );"
32D14I40"        (Void) fgets( buf, 119, stdin );"
19D15I4"    "
21D41I8"r_n = 0;"
46D30I54"        ch = (unsigned char) tolower( buf[0] & 0xFF );"
35D7I80"        if( ch == 'p' ) return -1;
            else if( ch == 'e' || ch == 'q' )"
12D56I13"exit( 0, 0 );"
61D17I12"        else"
24D41I3" 1;"
46D37I16"        }
#endif"
42D57I5"    }"
62D23I28"fprintf( std_err, "%s", s );"
28D12I12"if( nlflag )"
17D13
23D21I12"    ++scr_n;"
26D17I27"    fprintf( std_err, "\n" "
24D19I5"    }"
24D19
26D21I1"0"
27D48I69"}


/*  scr_param() is called early on and just once.  It is a chance"
53D41I60"to set the screen parameters (scr_ht, scr_wth) from run-time"
46D21I93"considerations.  Otherwise they default to static initializations.
 */
static void scr_param("
27D5I22"{
#if os_NT || os_DOSX"
10D44I23"screen_height();
#endif"
49D11I71"}


/*  sys_arg() is called for each argument.  The argument could come"
16D16I61"from the command line, or from an environment variable (LINT)"
21D19I59"or from within a .LNT file.  System dependent modifications"
24D50I62"to the argument may be made here.  The difference between this"
55D9I61"function and sys_option() is that sys_arg() is called for ALL"
14D46I33"arguments not just options; also,"
51D18I30"option() is called for options"
23D30I43"within a lint comment and sys_arg() is not."
35D7I2"It"
14D8I65"s a 1 if an alteration to the argument has been made, else 0.
 */"
13D9I17"int
sys_arg(abuf)"
14D5I19"char abuf[ARG_LEN];"
10D17I1"{"
22D11I60"OS_MINT | os_MPW | os_THINKC | os_UNIX | os_LINUX
    return"
19D4I21"_var(abuf);
#else
   "
11D40I10" 0;
#endif"
45D12I16"}

/*  sys_def()"
23D40I32"before each module to pre-define"
45D7I36"preprocessor variables.
 */
    Void"
12D6I4"def("
12D12I14"{
#if os_AMIGA"
17D1I43"scan_sym( "AMIGA", "1" );
#endif
#if os_VMS"
6D67I30"scan_sym( "VAX", "1" );
#endif"
72D68I68"}


/*  sys_dircmp(nm1,nm2) is called to compare two directory names"
73D16I29"for equality.  It returns 0 i"
21D49I31"y are equal (just like strcmp)."
54D55I37"This differs from sys_fncmp() in that"
60D62I57"either directory may have an optional SEP1 tacked on.
 */"
67D18I23"int
sys_dircmp(nm1,nm2)"
31D8I3"nm1"
14D27I12"CHARPTR nm2;"
32D71I1"{"
76D55I19"size_t len1, len2;
"
60D25I19"len1 = strlen(nm1);"
30D18I18"len2 = strlen(nm2)"
24D64I18"if( len1 == len2 )"
72D11I22"sys_fncmp( nm1, nm2 );"
17D16I16"f( len1 > len2 )"
24D27I23"sys_dircmp( nm2, nm1 );"
32D66I41"/* we can be assured that len1 < len2  */"
71D64I22"if( len1 + 1 == len2 )"
73D34I1"{"
39D54I44"    /* nm2 has exactly one more character */"
59D63I11"    int ch;"
68D33I16"    int retval;
"
38D60I19"    ch = nm2[len1];"
65D61I50"    if( ch == SEP1 || ch == SEP1A || ch == SEP1B )"
66D45I9"        {"
50D66I25"        nm2[len1] = '\0';"
71D22I39"        retval = sys_fncmp( nm1, nm2 );"
27D17I29"        nm2[len1] = (char) ch"
23D1I68"        return retval;
            }
        }
    return -1;
    }
"
6D167I70"!os_QNX
/*  sys_env(nm) returns the environment string associated with"
172D8I68"name nm.  It is called with arguments "LINT" and "INCLUDE".
 */
    "
15D21I12"
sys_env(nm)"
26I13"cCHARPTR nm;
"
5D46
51D15I68"/* So far as we know the following systems do not support getenv().
"
20D23I67"  Actually, VMS supports getenv() but our doc suggests using 'lint'"
28D17I70"   as the name of the FlexeLint executable.  So until the Installation"
22D21I55"   Notes get updated we can't support getenv() for VMS."
26D22I62" */
#if os_ATARI | os_VERS | os_DG | os_A2GS | os_VOS | os_VMS"
27D32I18"return NULL;
#else"
37D40I17"CHARPTR getenv();"
45D35I27"return getenv( nm );
#endif"
40D45I71"}

/*  sys_putenv(directive) takes a directive of the form "name=value""
50D10I12"and assigns "
15D14I7" to the"
36I7"name.
 "
7D63I25"int
sys_putenv(directive)"
68D54I19"cCHARPTR directive;"
59D31I60"{
#if os_ATARI | os_VERS | os_DG | os_A2GS | os_VOS | os_VMS"
36D47I18"return NULL;
#else"
52D58I13"int putenv();"
63D63I34"return putenv( directive );
#endif"
68D15I66"}

#endif


/*  sys_env_var( arg ) is called to expand environment"
20D12I64"variables (shell variables).  Sequences within arg of the form:
"
21D15I20"VAR_START  variable-"
20D22I9" VAR_END
"
27D9I54"are replaced by the value of the environment variable."
14D49I63"The maximum length of arg is assumed to be ARG_LEN.  characters"
54D13I33"beyond this length are truncated."
18D58I60"If the arg is an option (such as -d..., -format..., -sem...)"
63D49I61"that may contain the '%' character as data we do not look for"
54D13I45"this special sequence but return immediately."
18D23I2"It"
30D42I7"s a 1 i"
48D34I41"argument has been altered, otherwise 0.

"
42D14I22"int
sys_env_var( arg )"
19D14I17"char arg[ARG_LEN]"
20D85I42"{
#if OS_MINT | os_UNIX | os_LINUX
#define"
96D1I120"'%'
#define VAR_END '%'
#endif
#if os_MPW | os_THINKC
#define VAR_START '{'
#define VAR_END '}'
#endif

#ifdef VAR_START"
6I37"static cCHARPTR const opt_ignore[] =
"
9I46" "d", "format", "sem", "program_info", NULL };"
5I15"int option = 0;"
5D15I23"/* this is an option */"
20D20I16"cCHARPTR optname"
26D9I21"char tmpbuf[ARG_LEN];"
14D39I22"char  envbuf[ARG_LEN];"
44I33"char *s,    /* pointer to arg */
"
8D1I36" *ss,   /* another pointer to arg */"
11D15I30"*t,    /* pointer to tmpbuf */"
25D24
33D5I1","
11D27I21"position of VAR_START"
40D21I59"*env_value,  /* value of environment variable */
         *"
31D47I2"; "
52D6I36"position just after the last variabl"
15D32I11"int varopen"
38D26I37"   /* we are processing a variable */"
31I6"int i;"
6D24I19"/* a handy index */"
29D17I9"int count"
22I33"   /* number of substitutions */
"
5D38I58"/* pre-scan looking for an option we should not process */"
43I64"for( s = arg;  *s == '-' || *s == '+' || *s == aoc_plus;  s++ )
"
8D15I11"option = 1;"
20I13"if( option )
"
8D43I42"for( i = 0; optname = opt_ignore[i]; i++ )"
56D20I1"{"
33D19I41"for( ss = s; *optname ; optname++, ss++ )"
32D1I5"    {"
10D30
38D1I46"while( *ss == '\"' || *ss == aoc_quote ) ++ss;"
10D41
49D21I36"if( *optname != tolower(*ss) ) break"
31D10
20D10I27"            if( !*optname )"
25D59I9"        }"
64D17I21"/* ok, its not one of"
22D35I37"forbidden options, lets go further */"
40D54I14"tmpbuf[0] = 0;"
59D17I15"varstart = arg;"
22D34I17"lastvarend = arg;"
39D22I23"for( s = arg; *s; s++ )"
27I4"    "
6D41
49D41I29"!varopen && *s == VAR_START )"
46D62
70D12I1"{"
17D69
77D1I12"varopen = 1;"
10D15I17"    varstart = s;"
24D49I5"    }"
58D32I35"else if( varopen && *s == VAR_END )"
41D1I5"    {"
6D22
28D38I14"  varopen = 0;"
43D40I16"        count++;"
45D23I58"        *varstart = 0;   /*  temporily establish prefix */"
28D63I48"        sg_sfcat( tmpbuf, lastvarend, ARG_LEN );"
68D58I45"        *varstart = VAR_START;  /* restore */"
63D62I64"        for( t = varstart + 1, i = 0; *t && *t != VAR_END; t++ )"
67D63I30"             envbuf[i++] = *t;"
68D62I22"        envbuf[i] = 0;"
67D62I38"        env_value = sys_env( envbuf );"
67D42I16"        if( env_"
48D10I1")"
15D54I51"            sg_sfcat( tmpbuf, env_value, ARG_LEN );"
59D53I28"        /* else return 0; */"
58D54I27"        lastvarend = s + 1;"
59D55I9"        }"
60D54I5"    }"
59D56I23"if( count && !varopen )"
61D52I5"    {"
57D55I44"    sg_sfcat( tmpbuf, lastvarend, ARG_LEN );"
60D2I86"    strcpy( arg, tmpbuf );
        return 1;
        }
#endif
    return 0;
    }

/* "
9D5I22"it( err_cnt, zero_opt "
17D36I12"to exit from"
41D37I57"Lint.  err_cnt is the total number of errors encountered."
42D24I54"zero_opt is 1 if the -zero option was requested and is"
29D13I17"0 otherwise.
 */
"
18D1I34"Void
sys_exit( err_cnt, zero_opt )"
7D9I21"nt err_cnt, zero_opt;"
14D4
10D15I20"extern Void exit();
"
20D20I15"xmlout_tag(-1);"
25D28I45"if( (unsigned) err_cnt > 255 ) err_cnt = 255;"
33I62"if( zero_opt ) /* act as though no errors were encountered */
"
8D1I12"err_cnt = 0;"
6I69"if( gfl_pa > 0 )  /* the pause flag -- serves to keep window open */
"
8D28I1"{"
37I16"char buf[120];

"
8D1I49"fprintf( std_err, "Type any key to terminate:" );"
10I33"(Void) fgets( buf, 119, stdin );
"
8D25I1"}"
30I22"pipe_out( 'F', NULL );"
6D7I38"/* FlexeLint is Finished */
#if os_VMS"
12D9I40"exit( err_cnt ? 02000000000 : 1 );
#else"
14D44I23"exit( err_cnt );
#endif"
49D23I10"}


/*  sy"
32D8I44"name) is used to expand wild card characters"
13D44I6"within"
50D8I3"nam"
13D18I37"If the argument name is non-NULL, thi"
24D41I66"is a setup call.  sys_expand returns non-NULL to indicate that
   "
46D16I59"name is worthy of expansion.  If sys_expand returns NULL on"
21D27I62"this first call the name does not contain wild-card characters"
32D23I62"and will be treated normally (will be passed to i_open above)."
28D48I58"If a nonNULL is returned then this return value is ignored"
53D45I24"but sys_expand() will be"
50D35I25"ed repeatedly with a NULL"
40D14I53"argument to indicate that the caller is interested in"
19D5I33"the next name.  sys_expand() will"
13D19I13"the name as a"
24D6I37"char *.  When no more names are left,"
11D61I13"expand() will"
66D14I24"return NULL.  The char *"
20D40I24"sys_expand() returns may"
45D85
94D29I99"a static area within this module or it may be a
    malloc'ed area. sys_expand()'s caller will only"
34D100
105D63I54"the information there and it can be overwritten as soo"
69D3I14"as sys_expand("
8D56I43"called again. Of course sys_expand() cannot"
61D26I37"return a pointer to an auto area.
 */"
31D67I24"CHARPTR
sys_expand(name)"
72D26
34D36I5"name;"
41D15I1"{"
20D13I10"if( name )"
18D11I5"    {"
16D9I14"    cCHARPTR s"
15D1I20"    /* setup call */"
6D66I28"    for( s = name; *s; s++ )"
71D16
23D43I2" {"
48D76I4"    "
84D13I58"*s == '?' || *s == '*' )
                {
               "
21D23I14"os_expand( nam"
32D30I13"            }"
35D38I17"        }
       "
51I28"  /* signal no wild cards */"
5D11I5"    }"
16D13I29"else return os_expand( name )"
19D10I44"}

 unsigned
/*  sys_fattrib( path ) returns"
16D2I32"attributes.  The file attributes"
7D52I62"for our limited purposes include at least the following flags."
57D45I27"fatt_ORDIN => ordinary file"
50D60I23"fatt_DIR   => directory"
65D5I48"This is a wrapper function around a system call."
10D21I85"For example, on POSIX systems it results in a call to stat().
 */
sys_fattrib( path )"
26D21I13"cCHARPTR path"
27D5I1"{"
10D10I25"return os_fattrib( path )"
16D68I17"}

/*  sys_fgets("
75D1I48", len, file, last ) is like the library function"
6D53
61D21I52"except that it can have system dependent properties."
26D52I60"The first three arguments are identical to fgets().  The 4th"
58D4I27"last) if used will point to"
9D96I45"last (extended) character read.
 */

#if !os_"
101D14I80"&& !os_IBM
/*  sys_fgets( buffer, len, file, last ) will be identical to fgets()"
19D43I2"if"
48D58I57"frn flag is OFF.  If it is ON, a solitary carriage return"
63D15I64"(cr) is treated as a newline (nl), whereas a cr followed by a nl"
20D13I26"is taken together as a nl."
18D11I67"The last character read by this input stream is saved by the caller"
16D33I26"via the pointer last.
 */
"
42D1I35"ys_fgets( buffer, len, file, last )"
6D15I14"CHARPTR buffer"
21D9
18D56I4"len;"
61D29I11"FILE *file;"
35D63I8"nt *last"
69D11I1"{"
16D34I21"register CHARPTR s;  "
39D31I19"points to next loca"
36D13I13"in the buffer"
21D17I16"register int ch;"
24D2I43"/* character just read from input stream */"
7D51I75"register unsigned rem; /* number of writable bytes remaining in buffer */

"
56D9I52"if( gfl_rn <= 0 ) return fgets( buffer, len, file );"
14D25I30"/*  len must be at least 4  */"
30D14I72"if( !file || len < 4 || *last == EOF ) return NULL;
    s = buffer;
    "
19D43I9" len - 2;"
48D9I18"ch = getc( file );"
14D76
81D1I4"last"
10D5I7"&& ch ="
11I20" ) ch = getc( file )"
6D74
84D19I35"EOF ) { *last = EOF; return NULL; }"
24D5I60"while( ch != '\r' && ch != '\n' && ch != EOF && --rem != 0 )"
10D9I5"    {"
14D13I20"    *s++ = (char) ch"
19D21I22"    ch = getc( file );"
26D41I11"    }
    *"
46D1I5"= ch;"
6D14I42"if( ch == '\r' || ch == '\n' ) *s++ = '\n'"
20D12I8"*s++ = 0"
18D10I13"return buffer"
16D13I82"}
#endif

#if os_DOSX
/*  The following rendition of fgets() treats nl (i.e. '\n')"
18D1I52"as a line break and does not insist on finding cr-nl"
6D16I58"(i.e. the '\r' '\n' combination) to terminate a line as is"
21D32I62"done by the compiler we use to compile the DOSX version of our"
37D22I77"product.  The 4th argument is unused (hence the name).
 */
CHARPTR sys_fgets("
29D11I34", len, file, un_last )
    CHARPTR"
18D8
14I30"unsigned len;
    FILE *file;
"
5D40I12"nt *un_last;"
45D8
14D40I18"register CHARPTR s"
46D24I15"register int ch"
30D22I74"register unsigned rem; /* number of writable bytes remaining in buffer */
"
27D9I29"/* len must be at least 4  */"
14D3I52"if( !file || (ch = getc( file )) == EOF || len < 4 )"
11D6I4"NULL"
12D5I11"s = buffer;"
10D16I14"*s = (char) ch"
22D88I71"rem = len - 2;  /* no. of bytes minus current position and minus Nul */"
93D67I16"if( ch != '\n' )"
72D62I5"    {"
67D64I50"    while( (ch = getc(file)) != EOF && ch != '\n' "
70D65I9"        {"
70D64I25"        *++s = (char) ch;"
69D66I62"        if( --rem == 0 ) break;  /* if no bytes remain quit */"
71D54I9"        }"
59D25I67"    /* we coalesce cr-nl into nl and a terminal cr becomes an nl */"
30D16
21D6I25"f( *s == '\r' ) *s = '\n'"
12D1I60"    /* otherwise append a nl only if we actually saw one. */"
6D29I8"    else"
34D12I25"ch == '\n' ) *++s = '\n';"
21D1I1"}"
6D38I8"*++s = 0"
44D4
10I7" buffer"
6D5I21"}
#endif


#if os_IBM"
10D21I47"CHARPTR
sys_fgets( buffer, len, file, un_last )"
26D47I15"CHARPTR buffer;"
52D62I12"unsigned len"
68D14I11"FILE *file;"
19I14"int *un_last;
"
10D22I16"CHARPTR endptr;
"
27D57I45"if( fgets( buffer, len, file ) && buffer[0] )"
66D4I60"{
        endptr = buffer + (strlen( buffer ) - 1 );
       "
9D63I37"*endptr-- == '\n' && *endptr == ' ' )"
90D19I34"while( *endptr == ' ' ) endptr--;
"
25D22
28I18"*++endptr = '\n';
"
6D18
24D27I14"*++endptr = 0;"
50D1I14"return buffer;"
6D29
35I38"    else return NULL;
    }
#endif



"
11D21I8"( option"
29D33I49"is called for each -i option.  (If pri == 0, then"
38D39I36"this is a --i option.) The purpose i"
44D8I26"convert a directory into a"
13D26I30"prefix by tacking on the local"
35D3I1"y"
11D10I13"ion character"
16D54I65"Thus, for Unix, "-i/usr" becomes "-i/usr/" The flag +fip (gfl_ip)"
59D76I21"enables -i to work in"
81D41I39"old way (a prefix only).  A change made"
46D19I50"for version 6 is to make a call on add_search() at"
24D34I9"bottom of"
39D68I33"this routine.  This enables us to"
73D3
8D6I23"include() which in turn"
11D34I32"enables us to support multiple d"
45D21I11"with -i
 */"
26D27I11"Void
sys_i("
34D28I7", pri )"
33D29I7"CHARPTR"
36D15I1";"
20D50I8"int pri;"
55D64I1"{"
69D38I13"unsigned len;"
43D16I7"int c;
"
21D15I16"if( gfl_im > 0 )"
20D9
19D11I38"    sys_include( NULL, option+2, pri )"
17D10I10"    return"
16D72I5"    }"
77D9I31"len = (unsigned) strlen(option)"
16D9I47"f( gfl_ip > 0 && len > 1 && option[1] == 'i' )
"
15D11I46"  /* we are done, do not add a file separation"
21D20I5" */ ;"
25D64I4"else"
69D18I5"len )"
23D4I5"    {"
13D1I18"c = option[len-1];"
14D54I49"c == SEP1 || c == SEP1A || c == SEP1B ) /* OK */;"
68D33I67"if( len < ARG_LEN-2 )   /* if we don't exceed an argument length */"
42D37I5"    {"
46D1I50"    option[len] = SEP1;      /* tack on the ... */"
6D57
65D2I18"option[len+1] = 0;"
9D10I26"/* separation character */"
19D25I5"    }"
34D5I1"}"
10D21I28"add_search( option+2, pri );"
26D13I75"}


/*  sys_include( incvar, plist, pri ) processes an environment variable"
18D23I52"specified by incvar (if NULL it defaults to INCLUDE)"
28D70I57"incvar specifies a list of directories separated by SEP2."
75D19I54"Each directory is converted into a directory prefix by"
24D34I59"appending SEP1.  It is then passed to function add_search()"
39D16I27"to add it to the directory "
22D30I25" list.  These same search"
35D24
30D7I13"s reappear as"
12D11I34"argument named 'prefix' to i_open."
16D53I61"If plist is non NULL it gets used as the input source instead"
58D19I60"of calling sys_env().
    pri determines search priority.  D"
26D15I12"ies given by"
20D12I8"$INCLUDE"
17D30I66"environment variable or --i options are considered to have low
   "
40D14I42"(i.e., pri == 0). -i options have pri == 1"
19D15I50"Mod 2/26/97: At one time we would routinely ignore"
20D70
75D5I59"s.  Now we copy them provided they are interior blanks.
 */"
10D27I38"Void
sys_include( incvar, plist, pri )"
32D9I16"cCHARPTR incvar;"
14D8I15"cCHARPTR plist;"
13D4I9"int pri;
"
14D58I12"cCHARPTR  p;"
63D46I11"CHARPTR  q;"
51D6I22"char  buf[MAXFNM + 2];"
11D35I42"limited to length of single directory name"
43I25"int c, c1;
    int count;"
6D21I2"/*"
28D12I32"of characters added to buffer */"
17D25I3"int"
31D25I5" = 0;"
30D34I41"number of interior blanks that we owe */
"
39I32"if( plist ) p = plist;
    else
"
8D41I1"{"
50D59I16"if( incvar ) p ="
64D64I37"env( incvar );
#if os_MPW | os_THINKC"
69D59I42"    else p = sys_env( "CIncludes" );
#else"
64D37I12"    else p ="
42D24I24"env( "INCLUDE" );
#endif"
29D65I5"    }"
70D67I16"if( !p ) return;"
72D56I8"q = buf;"
61D18I10"count = 0;"
23D21I6"for(;;"
27D19
25D16I4"    "
21D36I8" = *p++;"
41D24I29"    if( c == SEP2 || c == 0 )"
29D24I9"        {"
29D34I21"        if( q > buf )"
39D33I13"            {"
38D70I23"            c1 = q[-1];"
75D59I70"            if( c1 != SEP1 && c1 != SEP1A && c != SEP1B ) *q++ = SEP1;"
64D65I19"            *q = 0;"
70D12I12"            "
18D4I3"map"
9D11I8", 'd' );"
16D14I51"            add_search( buf, plist && pri ? 1 : 0 )"
20D14I53"            /* adds the string buf to the search path"
19D1I53"               with low (0) priority (i.e. lower than"
6D16I58"               -i<directory> option).  if the 2nd argument"
21D53
61D2
9D35I39"were 1 then the priority would be high."
48D52
57D14I2"*/"
23I8"        "
6D13I15"        q = buf"
19D83I18"        count = 0;"
88D69I18"        blank = 0;"
74D62I27"        if( c == 0 ) break;"
67D47I9"        }"
52D57I8"    else"
62D27I27"        {
            if( c"
32D29I40" ' )  /* don't insert blanks just yet */"
34D60I46"            { if( count ) blank++; continue; }"
65D63I49"        /* now dump out the accumulated blanks */"
68D51I46"        while( blank > 0 && count < MAXFNM-1 )"
56D66I45"            { *q++ = ' '; blank--; count++; }"
71D28I14"        /* add"
36D27I23"character if it fits */"
32D15I49"        if( count++ < MAXFNM-1 ) *q++ = (char) c;"
20D27I28"        /* count < MAXFNM */"
32D11I9"        }"
16D12I5"    }"
17D54I75"}

/*  sys_fncmp(nm1,nm2) is called to compare two file names for equality."
59D16I59"Most systems support exact comparision.  This is especially"
21D5I48"true since most file names are passed sys_fnorm("
10D29I13"ch normalizes"
34D16I65"the name.  However some systems support mixed case in directories"
21D47I67"but do not require the user to employ the same case when specifying"
52I57"the file.  In this case the comparison must be done case
"
5D77I17"ndependently.
 */"
82D81I22"int
sys_fncmp(nm1,nm2)"
86D35I24"cCHARPTR nm1, nm2;
    {"
40D18I11"FNMAP_MIXED"
23D35I37"char buf1[ MAXFNM ], buf2[ MAXFNM ];
"
40D20I23"sys_fnfold( buf1, nm1 )"
26D24
30D51I18"fold( buf2, nm2 );"
56D57I34"return strcmp( buf1, buf2 );
#else"
62D10I65"return strcmp( nm1, nm2 );
#endif
    }


/*  sys_fnfold( buffer,"
15D42I38" ) is a utility routine to copy a file"
47D55I59"name into buffer and fold any mixed alphabetic letters to a"
60I77"monotone case for the purpose of comparisons.
 */
#if FNMAP_MIXED
    static "
11D15I19"fold( buffer, name "
29D2I6"buffer"
8D11I13"cCHARPTR name"
19D81
99I1"h"
6D17I14"register int i"
24D60I31"for( i = 0; i < MAXFNM-1; i++ )"
65D17I5"    {"
22D9I39"    if( ch = (unsigned char) name[i] )
"
16D71
76D21I51"buffer[i] = (char) (gfl_ff > 0 ? toupper(ch) : ch);"
26D59I15"    else break;"
64D50I5"    }"
55D35I14"buffer[i] = 0;"
40D5I83"}
#endif

/*  sys_fnmap(nm,context) is called to map file names and directory names"
10D54I69"to lower case or upper case if the O.S. does not distinguish the case"
59D51I62"of filenames, or to neither if the O.S. does distinguish case."
56D9I47"This function is called for every name found on"
14D54I28"the command line or in an in"
60D4I23" file (context == 'c'),"
9D63I61"in an include file (context == '"', '<' or 0 depending on the"
68D67I60"kind of #include statement), in a -i option, -libdir option,"
72D65I63"or INCLUDE environment variable (context == 'd' for directory),"
70D68I51"a -libh opton (context == 0) or in a -o...() option"
73D62I66"(context == 'o' for output).  File names could be mapped in i_open"
67D11I63"but by mapping here, it aids in the early detection of .lnt and"
16D26I77".lob files.
 */

/*lint -e{715}  unused paramters are OK in this function */
"
31D13I27"Void
sys_fnmap(nm, context)"
18D20I15"CHARPTR nm;
   "
26D3I7"ontext;"
8D41I54"{
#if FNMAP_UC | FNMAP_LC | os_NT | os_UNIX | os_LINUX"
46D8I17"register int c;

"
15D41I34"nm) while( c = (unsigned char) *nm"
52I13"{
#if os_VMS
"
8D24I43"if( c == '/' ) c = ':';
#endif
#if FNMAP_UC"
33D29I33"if( gfl_ff > 0 ) c = toupper(c); "
34D15I40"map to upper case */
#endif
#if FNMAP_LC"
24I78"if( gfl_ff > 0 ) c = tolower(c);   /* map to lower case */
#endif
#if OS_MINT
"
8D24I54"if( c == '/' ) c = '\\';
#endif
#if os_UNIX | os_LINUX"
33I32"if( c == '\\' ) c = '/';
#endif
"
8D1I17"*nm++ = (char) c;"
10D61I8"}
#endif"
66D9I64"}

/*  sys_fnorm(nm,context) is called to normalize a file name."
14D59I57"In principle this means selecting a unique representation"
64D21I41"for a file name.  In practice, this means"
27D19I14"ing parent
   "
30D8I6"design"
13I31"s (..)  from a full path name.
"
8D23I27"Void
sys_fnorm(nm, context)"
28D17I11"CHARPTR nm;"
22D67I12"int context;"
72D62I82"{
#if OS_MINT | os_AMIGA | os_UNIX | os_LINUX | os_XENIX | os_9 | os_UCOS | os_QNX"
67D44I15"register int c;"
49D3I19"CHARPTR src, dest;
"
8D90
151D6I21"    if( !nm ) return;"
11D80I72"src = nm;       /* initially source (src) and destination (dest)  ... */"
85D73I36"dest = nm;       /* are identical */"
78D13I59"/* first remove initial current directory specifications */"
18D1I50"while( src[0] == '.' && src[1] == SEP1 ) src += 2;"
6D11I35"while( c = (unsigned char) *src++ )"
16D26I5"    {"
31D11I11"    if( c ="
21D40I30"src[0] == '.' && src[1] == '.'"
55D12
20D15I12"      src[2]"
24D43I13"&& dest != nm"
54D4I5"    {"
9D9I64"        /* found a parent specification, remove prior directory."
14D26I13"           At"
31D24I45"top of the loop, src (prior to the increment)"
29D15I67"           and dest both pointed to a SEP1;  this situation must be"
20D2I7"       "
8D17I52"produced with dest pointing to the previous SEP1 and"
22D101I26"           src pointing to"
106D33I37"following SEP1.  If there is no prior"
38D65I62"           SEP1, src must point just after the following SEP1."
70D61I11"         */"
66D50I26"        while( dest > nm )"
55D50I13"            {"
55D68I29"            register int ch;
"
73D65I41"            ch = (unsigned char) *--dest;"
70D59I58"            if( ch == SEP1 || ch == SEP1A || ch == SEP1B )"
64D58I36"                { src += 2; break; }"
63D58I53"            else if( dest == nm )  /* no prior SEP */"
63D55I36"                { src += 3; break; }"
60D67I13"            }"
72D62I4"    "
67D7I56"ontinue;  /* dest and src have been properly adjusted */"
12D10I9"        }"
15D1I59"    else if( c == SEP1 && src[0] == '.' && src[1] == SEP1 )"
6D30I9"        {"
35D92I29"        /* remove redundant c"
99D9I1"d"
17D44I132" specification: */
            src++;
            continue;
            /* We'll write a separator next time around (if appropriate)"
49D63I64"          */
            }
        *dest++ = (char) c;
        }"
68D93I122"OS_MINT
    /* it was found experimentally that attempting to open a file whose
       name ends in a trailing blank opens"
98D29I72"same file as if the
       blank weren't there creating a nasty bug.
   "
34D25I83"    while( dest > nm && isspace( dest[-1] ) )
        --dest;
#endif
    *dest = 0;"
32D21I64"    sys_fnmap( nm, context );   /* map to case as appropriate */"
29D152I16"    }


 CHARPTR"
161D24I19"fnsimple(name) will"
31D11
16D9I6"simple"
14D9I7" of the"
14D34I18" name
    by point"
39D20I60"o the correct spot within its buffer.
 */
sys_fnsimple(name)"
25D29I7"CHARPTR"
34D29I1";"
34D69I1"{"
74D40I19"CHARPTR p;

    p ="
46D16I17"+ strlen( name );"
21D16I64"while( *p != SEP1 && *p != SEP1A && *p != SEP1B && *p != SEP2 &&"
21D26I11"       p !="
38D19I7"    p--"
25D13I60"if( *p == SEP1 || *p == SEP1A || *p == SEP1B || *p == SEP2 )"
18D2I8"    p++;"
7D84I9"return p;"
89D5I55"}

/*  sys_mixed() returns the value of FNMAP_MIXED
 */"
10D25I15"int
sys_mixed()"
30D24I5"{
   "
31I12" FNMAP_MIXED"
6D38I76"}


#if !os_QNX
/*  sys_option( s, state ) is called whenever option s is to"
43D9I58"be processed whether the option appeared A) on the command"
14D33I65"line, B) in an indirect (.lnt) file, C) within a LINT environment"
38D40I61"variable, D) within sys_olist (see above) or E) within a lint"
45D41I50"comment.   This gives the customizer the chance to"
46D9I50"massage any option before passing it off to lint.
"
14D23I68"state is used for split options.  state is initially 0 and otherwise"
28D5I65"equals the last return value of sys_option (which is normally 0)."
10D24I59"Some systems such as MPW insist that options such as -dNAME"
29D24I58"be split into -d NAME.  In this case sys_option( "-d", 0 )"
29D68I58"is called and a 1 is returned.  The caller then knows that"
73D12I66"NAME is not a filename and calls sys_option("NAME", 1).
    If you"
17D19I56"not using option -split you can forget about this (other"
24D23I29"than to always return 0).
 */"
28D26I27"int
sys_option( s , state )"
31D16I8"char *s;"
21D19I10"int state;"
24D7I1"{"
12D35I30"return lnt_option( s, state );"
40D69I192"}
#endif

/* the following include is to gain access to getcwd().  This stands for
   "get Current Working Directory".  It's no big loss if this isn't available.
   Just define this as a macro"
76D1I309"ing 0 as indicated below.
 */
#if os_UNIX | os_LINUX | os_UCOS | os_9 | os_XENIX | os_QNX
/*  If you don't have unistd.h change the '1' on the next line to a '0'  */
#if 1
#include <unistd.h>
#else
#define getcwd(a,b) 0
#endif
#endif

#if os_NT
#include <direct.h>
#ifdef __WATCOMC__
#define _getdcwd(a,b,c) 0"
6I20"get cwd for a given "
5D1I95" -- not avail in V. 10 */
#endif
#endif

/*  sys_pathname( buffer, name ) returns in buffer the"
12D2I4"name"
7D33I68"of a file.  This usually amounts to prepending the current directory"
38D40I29"if this is not already a full"
45D28I15".  The returned"
34D5I8"may have"
10D51I69"redundancies (e.g. "/x/../y/z" == "/y/z"). File normalization is done"
56D13I62"elsewhere (sys_fnorm).  As a last resort name is simply copied"
18D40I16"into buffer.
 */"
45D54I31"void
sys_pathname( buffer, name"
61D50I19"char buffer[MAXFNM]"
56D8I21"CHARPTR name;
    {

"
20D17I76"buffer, name );

#if os_UNIX | os_LINUX | os_UCOS | os_9 | os_XENIX | os_QNX"
26I2"{
"
8D1I21"char locbuf[MAXFNM];
"
10D8I20"if( name[0] == '/' )"
25D5I34"if( getcwd( locbuf, MAXFNM - 1 ) )"
14D49I5"    {"
62D1I25"strcpy( buffer, locbuf );"
14D23I29"sg_sfcat( buffer, "/", MAXFNM"
40D5I7"g_sfcat"
15D6I12"name, MAXFNM"
22D7I1"}"
16D5I19"}
#endif

#if os_NT"
14D4I1"{"
13D5I20"char locbuf[MAXFNM];"
14D40I20"char longbf[MAXFNM];"
49D92
98D3I58"[0] = 0;
#define is_SLASH(ch) ((ch)=='\\' || (ch) == '/')
"
12I33"/* there are four possibilities:
"
8D44I19"   drive: full path"
56I20"drive: partial path
"
9D35I11"  full path"
47I13"partial path
"
5D25I6"    */"
34D21I4"if( "
28D1I18" && name[1] == ':'"
16I2"{
"
8D1I15"    int drive;
"
14I56"if( is_SLASH(name[2]) ) return;  /* drive: full path */
"
8D21I20"    /* drive: partia"
28D18
33D7I32"drive = tolower( (unsigned char)"
12D3I17"[0] ) + 1 - 'a';
"
11D37I14"    name += 2;"
50I44"if( _getdcwd( drive, locbuf, MAXFNM - 1 ) )
"
8D2
10I2"{
"
8D2
10D15I27"win_lngnm( locbuf, longbf )"
29D1I48"    if( longbf[ strlen( longbf ) - 1 ] == '\\' )"
10D26
34D32I38"    longbf[ strlen( longbf ) - 1 ] = 0"
42D34
42D9I25"strcpy( locbuf, longbf );"
14D77I13"            }"
82D30I12"        else"
37D31I1";"
36D63I9"        }"
68D55I53"    else if( is_SLASH(name[0]) && is_SLASH(name[1]) )"
60D67I9"        {"
72D10I86"        win_lngnm( name, longbf );
            strcpy( buffer, longbf );
            r"
15D55I1";"
60D17I9"        }"
22D11I8"    else"
16I8"        "
6D42I6"      "
50D6I27"drive, full or partial path"
14D68I42"        if( getcwd( locbuf, MAXFNM - 1 ) )"
73D68I13"            {"
73D64I40"            win_lngnm( locbuf, longbf );"
69D65I56"            if( longbf[ strlen( longbf ) - 1 ] == '\\' )"
70D64I51"                longbf[ strlen( longbf ) - 1 ] = 0;"
69D60I37"            strcpy( locbuf, longbf );"
65D56I35"            if( is_SLASH(name[0]) )"
61D16I12"            "
22D20I68"                    locbuf[2] = 0; /* full path -- just use drive */"
25D42I68"                name++;        /* but don't use leading character */"
47D24I17"                }"
29D54I8"        "
60D63I24"            else return;"
68D66I9"        }"
71D25I29"    strcpy( buffer, locbuf );"
30D23I37"    sg_sfcat( buffer, "\\", MAXFNM );"
28D17I21"    sg_sfcat( buffer,"
22I10", MAXFNM )"
6D1I13"    }
#endif
"
6D18I58"}


/*  sys_pragma(s) is called at initialization with s ="
24D36I13".  If control"
41D58I68"is wanted for each pragma then return 1 at this time. else return 0."
63D56I63"If 1 was returned then for each pragma, sys_pragma(s) is called"
61D64I55"with s containing the pragma line absent the "#pragma"."
69D17I67"Continuations will have been processed so you will receive one long"
22D40I70"string.  Return values on these subsequent calls are not examined.
 */"
45D5I17"int
sys_pragma(s)"
10I18"cCHARPTR s;
    {
"
8D75I3"s ="
81D1I46" ) /* first call */ return 0;  /* no thanks */"
6D25I68"else return 1;  /* this won't happen because of prior return of 0 */"
30D9I68"}

/*  sys_tick() is called periodically; this has several purposes."
14D7I63"On a non-preemptive scheduler a check can be made to see if som"
13D9I65"higher priority task requires work.  This is done on the MAC with"
14D4I65"SpinCursor().  It can also be used to respond more rapidly to an
"
9D34I59"nterrupt request from the user.  This is the purpose of the"
39D41I56"dos_break() call which releases a pending interrupt.
 */"
46D9I15"Void
sys_tick()"
14D5I22"{
#if os_DOS | os_DOSX"
10D33I42"dos_break();
#endif
#if os_MPW | os_THINKC"
38D43I24"SpinCursor( 1 ) ;
#endif"
48D36I53"pipe_out( 'P', NULL );  /* post a progress message */"
44D1
9D54I53"truncate(name) will truncate a filename to an 8X3 nam"
60D66I35"As a peculiarity, the names compris"
71D16I37"he path are not truncated,
    nor is"
21D25I14"extension.
 */"
30D62I23"Void
sys_truncate(name)"
67D58I23"register CHARPTR  name;"
63D59I1"{"
64D42I35"CHARPTR  last_dot = NULL;    /* poi"
49D9I18"last dot if any */"
14D49
57D27I50" last_name = NULL;   /* points to the last name */"
32D10I56"register CHARPTR probe;      /* used to traverse name */"
15D34
39D12I36" c;                     /* temporary"
17D13I17"acter variable */"
19D24I16"last_name = name"
30D50I40"for( probe = name; c = *probe; ++probe )"
55D36I5"    {"
41D45I47"    if( c == SEP1 || c == SEP1A || c == SEP1B )"
50D11I9"        {"
16D17I24"        last_dot = NULL;"
22D15I25"        last_name = NULL;"
20D75I9"        }"
80D24I8"    else"
29D16I9"        {"
21D14I42"        if( !last_name ) last_name = probe"
20D1I41"        if( c == '.' )  last_dot = probe;"
6D19I9"        }"
24D38I5"    }"
43D9I32"if( !last_dot ) last_dot = probe"
15D2I43"if( last_name && last_dot - last_name > 8 )"
7D24I36"    strcpy( last_name+8, last_dot );"
29D8I67"}


/*  sys_vmsg(sflag,consumed) can be used to partially customize"
13D8I56"the verbosity messages (see -v... option).  This returns"
13D17I56"a string to be appended to the normal verbosity message."
22D1I62"If sflag is set to 1 then the user has previously used the 's'"
6D18I58"(storage report) request with the -v option (as in -vsm )."
23D36I59"The second argument is equal to the nominal number of bytes"
41D9I58"consumed so far (as measured by the arguments to malloc()."
14D81I43"NULL can be returned to signify no message."
86D4I1"
"
11D14I26" sys_vmsg( sflag, consumed"
21D9I9"int sflag"
15D7I19"Unsigned32 consumed"
19I7"static "
5D42I9"buf[100];"
47D27I18"char numeral[60];
"
32I13"if( !sflag ) "
7D9
19D9I163"/* we now convert from long to thousand numeral */
    cvt_lth( numeral, (long) consumed );
    sprintf( buf, "consumed %s bytes", numeral );
    return buf;
    }"
15I718"  Part III
    ANSI functions.
    You might need them depending on your library.
 */

#if os_AMIGA | os_UCOS

    Void *
memcpy(to,from,n)
    char *to, *from;
    unsigned int n;
    {
    char *areaptr = to;
    while( n-- > 0 ) *areaptr++ = *from++;
    return to;
    }

    Void *
memset(p,val,len)
    char *p;
    int val;
    unsigned int len;
    {
    char *areaptr = p;
    while( len-- > 0 ) *areaptr++ = val;
    return p;
    }

/*  strchr(s,ch) is an ANSI function to locate a character
    within a string
 */
    CHARPTR
strchr( s, ch )
    CHARPTR s;
    char ch;
    {
    char c = ch;    /* old compilers 'expand' ch */
    while( *s && *s != c ) s++;
    return *s ? s : NULL;
    }

#endif



/*"
Fcustom.h
7158I6"\
    "
12D8I28"(size_t)(size),(size_t)(cnt)"
16D8I6"size_t"
94D8I28"(size_t)(size),(size_t)(cnt)"
1923D6I29"
/*
   FlexeLint makes use of"
13D9I45"Unsigned32 (unsigned integer of length 32)
  "
14D120I20"Unsigned16 (unsigned"
129D62I27"of length 16) for a variety"
67D67I30"f purposes.  For most machines"
73D53I28"is easily achieved with the
"
60D78I1"s"
88D37I7"int and"
47D11I148"short.
   If your compiler's int and short differ in length from these numbers
   then use the nearest unsigned integer greater than or equal to the"
17D19I14"lengths.
 */

"
27D75
84D35I8"int    U"
42I88"32;
typedef unsigned short  Unsigned16;

typedef int Int32;
typedef short Int16;

/* The"
5D25I26"s MAX_INT_t and MAX_UINT_t"
34D47I140"below are used to
   manipulate user values during value tracking and should designate
   the largest integer type available.  You may use a"
52D57I7"-DLINT_"
64D58I12"=integer-typ"
63D5I126"on the command line to override the default determination of what
   this maximum integer should be.
 */

#ifdef LINT_MAX_INT
"
17D5I5"LINT_"
12D4I11" MAX_INT_t;"
16I32" /* maximum integer type */
    "
17D4I12"LINT_MAX_INT"
16I36"   /* maximum unsigned type */
#else"
5D10I9"#if os_NT"
15D120I29"    typedef __int64 MAX_INT_t"
128D62
69I73"/* maximum integer type */
        typedef unsigned __int64 MAX_UINT_t;  "
5D53I35"maximum unsigned type */
    #else
"
60D65I61" #if defined __STDC_VERSION__ && __STDC_VERSION__ >= 199901L
"
71D65
71D43I19"#include <stdint.h>"
56I28"typedef intmax_t MAX_INT_t;
"
12I30"typedef uintmax_t MAX_UINT_t;
"
7D60I7" #else
"
69D51I27"   typedef long MAX_INT_t;
"
60D53I37"   typedef unsigned long MAX_UINT_t;
"
60D38I111" #endif
    #endif
#endif

/*  Section C. -- declarations for objects within custom.c */

/*  Part I, Data  */
"
46D65I13"int ansi_flag"
73D5I28"/* flag to inhibit common MS"
11D1I5"sions"
17D9I6"aoc_cm"
16D42
48D10I28"used to separate sub-options"
26D7I8"aoc_plus"
15D17I39"/* used to introduce options as in +fmd"
33D9I9"aoc_quest"
19D13I36"used in error inhibition as in -e7??"
29D9I9"aoc_quote"
19D39I41"used to quote blank-embedded names as in
"
45D42
48D16I56"                   lint "hard disk:C programs:myprog.c" "
27D11I19"char aoc_lp;       "
16D33I25"'(' used in -option(list)"
44D29I59"char aoc_rp;         /* ')' used in -option(list) */
extern"
34D51I14" aoc_star;    "
57D42I32"used as wild-card in -esym names"
62D6I56"default_ext[]; /* default extents */
extern char dot_c[]"
15D27I11"/* c extent"
39D17I11"har dot_cpp"
29D25I10"cpp extent"
37D17I13"har dot_cxx[]"
24I43"/* cxx extent */
extern char dot_h[];      "
5D25I13"header extent"
37D16I13"har dot_lnt[]"
23I45"/* normally .lnt */
extern char dot_lob[];   "
6D67I38"normally .lob */
extern char dot_lph[]"
74I44"/* normally .lph */
extern char dot_vac[];  "
7D65I35"normally .vac */
extern int scr_ht;"
70D54I129"The number of lines on the screen */
extern int scr_wth; /* The number of characters on a line of the screen */
extern int scr_n;"
60D47I68"The number of lines that have been written */
extern cCHARPTR sys_id"
59I56"/* System Identification */
extern cCHARPTR sys_odesc[];"
9D32I9"System op"
37D16I40"description */
extern cCHARPTR sys_olist"
25I22"/* System Options List"
7I34"*/
extern cCHARPTR sys_vers;      "
6D34I64"Version Number */

/*  Part II, Functions */

int extract_file_i"
48D12I9"/* called"
17D38I37"xtract a module name */
FILE * i_open"
57D8I9"/* called"
13D41I28"pen a file */
FILE * i_fopen"
59I65"/* low level call to open a file */
int last_ext();              "
6D9I6"tests/"
15D2I20"es a filename extens"
10D21I11"int ind_tst"
32D23I15"          /* in"
29D9I10"-file test"
19D6I7"cr_need"
25D1
7D44I43" to ensure n lines of screen */
int scr_out"
61I4"    "
6D38I38" to output a line to the screen */
int"
43D4I3"arg"
23D59
64D18I21"argument modification"
29D8I3"int"
13D7I6"dircmp"
12D57
62D60I11" /* used to"
68D1
6D4I10"directory "
10D30I3"*/
"
39D5I3"def"
16D17I16"         /* used"
24D26I28"-define variables */
CHARPTR"
31D5I3"env"
16I6"      "
11D39I33"get an environment string */
Void"
44D8I4"exit"
13D54
66I2"  "
11D34I25"exit to system */
CHARPTR"
39D7I6"expand"
16D34I24"     /* expands file nam"
47D3I8"unsigned"
8D5I7"fattrib"
10I57"/* returns file attributes */
extern CHARPTR sys_fgets();"
5I56"/* fgets() replacement */
extern int sys_fncmp();       "
5D35I42"compares two filenames or portions thereof"
46D3I4"Void"
8D6I5"fnmap"
20D28I32"map file names to preferred case"
39D3I4"Void"
8D6I5"fnorm"
20D39I28"used to normalize a file nam"
51D4I7"CHARPTR"
9D7I7"fnsimpl"
13D30I26"/* obtain simplified file "
45D3I4"Void"
8D6I1"i"
17D67
74D36I27"used to append to -i option"
56D7I6"includ"
16D30I37" /* used to process INCLUDE variables"
41D7I3"int"
12D4I5"mixed"
13D29I40"   /* indicates that we are in mixed mod"
34D8I49"extern int sys_option();        /* passes each op"
13D19I73"onto lint */
extern int sys_pragma();        /* passes the pragma line in"
24D102
108D26I7" use */"
34D12I19"Void sys_pathname()"
18D32I30"/* determines the full pathnam"
44D12I16"int sys_putenv()"
24D15I32"modifies an environment variable"
26D12I15"Void sys_tick()"
21D35I40" /* called periodically to show activity"
46D12I19"Void sys_truncate()"
18D3
8D44I25"uncates a filename to 8x3"
55D12I18"CHARPTR sys_vmsg()"
19D21I42"/* customize verbosity message */

/*  Sec"
26D2I158"D.
    Declarations for objects within FlexeLint or within libraries
    that are not declared within stdio.h and are used by custom.c
 */

typedef int UFLAG;"
20D2I2"di"
14D33I27"directory of including file"
54D2I2"ff"
14D41I15"fold file names"
62D2I2"im"
14D25I32"-i can have multiple directories"
36D13I12"UFLAG gfl_ip"
21D48I73" /* treat -i directives as prefixs not directories */
extern UFLAG gfl_pa"
57D59I46"/* pause at termination */
extern UFLAG gfl_rb"
68D22I13"/* always use"
27D31I41""rb" form of fopen */
extern UFLAG gfl_rn"
40I74"/* \r not followed by \n is regarded as a \n */
extern UFLAG gfl_sh;      "
5D55I47"shared-file form of fopen */
extern double atof"
65D6
16D46I36"s Ascii to Float */
int attempt_open"
58I65"/* indicate an attempt to open a file */
Void background();      "
7D51I51"runs FlexeLint in the background */
Void add_search"
64D21I42"/* adds a directory to the search sequence"
30D8I7"cvt_lth"
23D33I41" /* convert from long to thousand numeral"
42D8I7"Errorno"
23D73I55" /* issues an error message by number */
int lnt_option"
83D53
60D43I20"processes options */"
49D7I7"pipe_ou"
26D51I47"progress information to a pipe */
Void scan_sym"
66I80"/* defines a specific symbol with a value */
#if os_NT
Void screen_height();    "
7D25I21"ets the screen height"
36D12I14"void win_lngnm"
19I73"/* converts short path names to long */
#endif
Void sg_sfcat();          "
6D34I52"afe strcat() -- checks buffer length */
int strcmp()"
42D55
63D24I11"/* standard"
32D18I33"comparison */
extern FILE *shopen"
27I42"/* shared open */
extern FILE *std_err;   "
7D25I31"possibly redirected stderr file"
40D1
17I1" "
29D20
34D3I4"ncpy"
16D8I25"/* copy n characters to a"
16I44"*/
CHARPTR strrchr();          /* find char "
16D16I37"scanning from right */
CHARPTR strstr"
30I61"/* find string within a string */
size_t strlen();           "
Fa2.c
209D4I7"7 A9235"
18D2I1"9"
12I16"A6 A10;
typedef "
291D20
27D4I8"32 A9069"
14I19"A9069 A24;
typedef "
10D4I2"25"
14D9I13"unsigned A890"
21D6I10"9069 A9150"
17D6I10"9069 A9070"
17D8I8"9070 A27"
18D12I9"A9070 A28"
22I21"A9070 A5793;
typedef "
10D4I2"29"
14D17
26D8I5"A6228"
19D6I8"9070 A30"
25D3I8"long A31"
13I17"A17 A32;
typedef "
11D1I1"3"
11D7I12"unsigned A34"
19D5I5"4 A35"
17D5I5"5 A36"
21D1I1"7"
17D1I1"8"
16D2I2"39"
18D1I1"0"
17D1I1"1"
17D1I1"2"
12D6I6"34 A43"
22D1I1"4"
17D1I1"5"
11D7I7"A42 A46"
17I17"int A47;
typedef "
342D2I4"9236"
17D4I2"63"
19D1I3"577"
18D1I1"4"
16D4I2"65"
20D2I2"19"
18D4I4"8258"
14I19"A54 A7616;
typedef "
138D6I3"A16"
60D13I3"A72"
122D6I5"A9069"
20D6I5"A9069"
1373I69"struct A9304
{
A17 A9305;
A5794 A9306;
};
extern struct A9304 A9307;
"
6D4I4"9308"
14D4I4"9309"
17D1I1"5"
11D4I4"5566"
14D4I4"5567"
14D3I17"7618();
Void A761"
8D13
19D3I17"5569();
Void A915"
8D9I10"Void A9152"
14D17I2"74"
22D1I15"0();
Void A7621"
10I41"6226();
A5794 A6227();
A81 A7622();
A58 A"
460D2I4"9070"
28D2I4"9070"
151I19"struct A114 A9153;
"
1389D2I2"92"
16D6I12"5794 A7637()"
15I16"A4 A202;
extern "
3337D2I4"9070"
159I11"A58 A9238; "
88D2I4"9070"
39D2I4"9070"
367I11"A17 A9071;
"
535I13"A9236 A9239;
"
1098D2I4"9070"
380D7I8"17 A9154"
24D1I1"1"
12D6I7"62 A442"
16I17"A4 A443 ;
extern "
150D3I4"9072"
14D10I9"Void A451"
22D9I9"5794 A452"
21D9I9"9036 A453"
29D1I1"4"
13D12
20D1I1"5"
12D9I22"A315 A456 ;
A5794 A457"
28D1I1"8"
18D4I3"459"
21D3I4"5268"
14D16
24D1I1"0"
12I16"A4 A461;
extern "
8D1I1"2"
12D8I11"Void A463()"
22D4I3"464"
13I18"A58 A8823;
extern "
1037D7I10"Void A9155"
18D9I7"A4 A504"
20I20"Void A505();
extern "
1042D2I4"9070"
1940D8I19"struct A640 * A9310"
24D4I3"663"
15D10I9"A48 A7505"
29D2I2"37"
19D3I4"7176"
14D7I9"Void A664"
22D4I3"665"
16D8I7"4 A4442"
19D6I6"A17 A5"
27D3I2"66"
21D2I3"031"
21D1I1"7"
20D1I1"8"
12I20"Void A669();
extern "
278D3I4"4476"
14D10I17"struct A640 *A675"
27D4I4"7719"
21D4I4"8914"
15D8I12"Void A7720()"
18D7I7"17 A933"
18D8I7"7 A5254"
18D2I2"81"
7D1I1"0"
11D2I2"17"
7D1I1"1"
11D1I2"35"
6D1I1"2"
11D1I2"92"
6D1I1"3"
11D2I1"7"
7D1I1"4"
11D8I7"4 A2145"
18D1I2"68"
6D1I1"6"
13D14I6"*A2147"
24D8I7"4 A2148"
18D7I16"2 A2149[M_TOKEN]"
17D2I2"87"
7D1I1"0"
11D2I1"4"
7D1I1"1"
15D4I4"2152"
14D2I2"36"
7D1I1"3"
11D27I7"35 A826"
38D1I2"17"
6D3I1"4"
13D10I28"7
A2155,
A2156,
A2157,
A6214"
19D4I2"A9"
9D1I1"8"
12D10I9"A17 A8825"
27D3I3"215"
15D3I4"Void"
8D1I1"0"
18D4I4"8209"
23D1I1"1"
12D3I4"Void"
8D1I1"2"
12D10I9"A35 A2163"
29D1I1"4"
12D5I4"Void"
10D1I1"0"
12D9I8"A35 A216"
22D7I10"9036 A8211"
24D4I4"5255"
15D4I2"A4"
9D11I16"6();
extern Void"
16I37"7();
extern Void A2168();
struct A216"
465I42"struct A9073
{
A48 A9074;
A9069 A9075;
};
"
422D6I7"8 A9076"
17D9I8"A42 A982"
20D8I9"long A983"
24D4I3"984"
16D8I8"87 A6039"
20D8I8"61 A7724"
19D9I9"A92 A7260"
20D8I9"long A985"
24D4I3"986"
16D9I8"34 A5670"
20I21"A5794 A987();
extern "
1045I7"9129,
A"
44D4I4"9156"
11I42"9157,
A9158,
A9159,
A9160,
A9161,
A8639,
A"
21D10I2"91"
15D2I2"91"
7I29"9164,
A6176, 
A7062,
A7063,
A"
91I21"9240,
A9241,
A9130,
A"
21I28"9165,
A9166,
A9167,
A9168,
A"
28I14"9292,
A9169,
A"
92I42"9242,
A9243,
A9131,
A9132,
A9133,
A9134,
A"
71I7"9170,
A"
307D4I4"9171"
21I42"9244();
extern Void A8266();
extern Void A"
8I80"extern Void A9172();
extern A4 A9173();
extern A4 A9174();
extern Void A9175();
"
746D9I7"4 A9176"
21D7I9"5794 A868"
19D6I6"7 A598"
25D1I1"0"
19D1I1"1"
13D10I7"61 A872"
22D7I10"5794 A6037"
19D10I7"61 A873"
22D7I10"5794 A8589"
20D5I6"8 A874"
16D9I7"A4 A875"
28D1I1"6"
20D1I1"7"
20D1I1"8"
19D2I2"79"
19D4I3"880"
21D4I4"6172"
21D3I4"9293"
20D4I4"9177"
21D4I4"8787"
23D1I1"1"
20D1I2"29"
18D4I4"7262"
23D1I1"2"
20D1I1"3"
20D2I2"48"
21D1I1"4"
20D1I1"5"
18D3I4"5667"
22D1I1"6"
19D2I2"87"
20D2I2"88"
20D2I2"89"
19D4I3"890"
21D4I3"891"
21D4I3"892"
21D4I4"7745"
24D1I1"6"
21D1I1"7"
20I1"4"
18D3I4"7748"
20D4I4"7749"
21D4I3"893"
23D1I1"4"
18D4I4"1857"
22D3I3"958"
22D1I1"5"
19D3I3"061"
20D3I4"5821"
20D4I3"896"
21D3I4"7507"
20D4I3"897"
21D4I4"5981"
23D1I1"8"
19D3I3"750"
20D3I4"8212"
20D3I3"899"
20D3I4"7177"
22D1I1"0"
18D4I3"901"
23D1I1"2"
20D1I1"3"
18D3I4"8944"
22D1I1"4"
18D4I3"905"
21D3I3"907"
21D4I4"9078"
23D1I1"7"
18D3I4"5077"
20D3I4"8267"
20D3I4"8830"
14D7I9"Void A908"
25D2I2"09"
13D9I9"Void A910"
28D1I1"1"
12D9I7"A4 A912"
20D16
24D1I1"3"
14D8I7"4 A5431"
19D11I9"Void A914"
22D10I9"Void A915"
22D11I6"7 A916"
27D2I2"17"
13D9I10"A5794 A918"
27D3I4"1739"
15D6I9"5794 A919"
24D4I3"920"
15D9I9"Void A921"
26D4I3"922"
15D20I14"A5794 A923();
"
31D4I3"924"
16D7I10"5794 A7263"
19D8I8"61 A5668"
19D7I12"Void A5669()"
16D18
26D13I12"7734 A7751; "
21D7I7"4 A7752"
18D18I10"A4 A5914()"
28D6I10"861 A926()"
16D8I6"4 A927"
18D6I8"4 A928()"
15D9I19"struct A849 *A929()"
19D6I9"61 A930()"
16D8I12"9236 A9245()"
18D6I12"9236 A9246()"
15D9I12"Void A9247()"
18D7I18"struct A144 *A5050"
17D8I6"7 A931"
18D6I8"61 *A932"
16D8I6"7 A933"
21D7I7"*A934;
"
14D18I7"A7 A935"
28D7I8"61 *A936"
16D18I7"A7 A937"
27D18I9"A61 *A938"
27D18I7"A7 A939"
28D9I8"61 *A940"
19D9I6"7 A941"
19D9I8"61 *A942"
19D12I10"61 A6038; "
19D11I18"struct A144 *A1696"
23D8I5" A943"
18D10I7"7 A9294"
19D11I18"struct A144 *A7178"
20D17
26D7I8"44 *A717"
17D7I18"struct A144 *A5432"
17D6I9"5794 A944"
15D17I10"A5794 A945"
26D20I12"A5794 A946;
"
27D4I5"A5794"
9D3I1"4"
19D6I4"7180"
15D12I11"A5794 A7227"
21D12I11"A5794 A7181"
22D7I10"5794 A5510"
17D8I7"68 A948"
17D18
26D10I9"114 *A949"
20D7I6"7 A950"
17D7I6"4 A951"
16D10I17"struct A114 *A952"
19D13I20"struct A144 *A7265; "
27D3I3"266"
15D7I10"5794 A1689"
24D4I4"7753"
15D18I10"Void A7754"
30D10I7"6 A1022"
20D10I8"81 A5511"
19D12I9"A81 A8770"
21D12I18"struct A561 *A1023"
21D12I8"A4 A1024"
22D10I7"7 A1025"
19D18I8"A4 A1026"
29D18I9"A49 A1027"
29D10I9"Void A775"
22D10I8"A4 A1028"
27D15I8"1029();
"
21D4I31"9079();
A48 A9080();
Void A9081"
15D21
38D1I1"0"
13D7I8"17 A1031"
18D18I9"A79 A1032"
35D4I4"5671"
15D8I10"Void A5672"
19D9I10"Void A8401"
21D8I8"17 A5512"
19D10I18"struct A561 *A1033"
21D9I10"Void A9135"
20D9I18"struct A561 *A1034"
21D7I10"5794 A1035"
18D47I10"Void A2317"
58D9I10"Void A5673"
20D9I10"Void A1036"
20D9I10"Void A1037"
20D11I18"struct A561 *A1038"
22D8I6"A4 A56"
21D9I18"struct A561 *A1039"
20D11I10"Void A7182"
22D18I10"A4 A7183()"
27D10I9"A58 A8268"
22D7I28"78 A1040();
extern Void A775"
12D6I49"extern A81 A1041();
extern A81 A7508();
extern A4"
11D3I49"7();
extern A5794 A8590();
struct A7758 *A7759();"
12D51I3"0()"
60D18I11"A78 A1042()"
28D8I10"78 A5271()"
18D8I10"78 A1043()"
18D8I12"5972 A1044()"
17D9I12"Void A2274()"
18D17I42"A54 A5433();
extern A9036 A9039();
extern "
26D106I9"44 *A5434"
116D7I12"9150 A9178()"
16D13I32"Void A7761();
extern A48 A7906()"
23D31I63"7758
{
A40 A7762;
A87 A7763, A7764;
A17 A7765, A7766;
A67 A7767"
43D21
29D11I10"7758 A7768"
20D79I9"A87 A7769"
88D12I9"A87 A7770"
21D12I9"A88 A7771"
21D12I9"A10 A7772"
21D43I17"const A88 A7773;
"
52D19I43"045
{
A18 A1046;
A72 A1047;
A7470 A1048;
A3"
24D2I58"49;
};
struct A1050
{
A18 A1051;
A17 A1052;
A5794 A1053;
}"
12D7I7"7 A3140"
17D34I14"81 A3143[20];
"
43D9I33"054
{
A54 A1055;
A55 A1056[25];
}"
19D8I9"55 *A3164"
19D11I19"struct A1054 *A7509"
20D78
86D209I12"144 *A7774;
"
217D10I51"7500
{
struct A7500 *A7775; A54 A7510; A42 A7511; }"
19D9I12"Void A1057()"
18D8I12"Void A1058()"
17D9I10"Void A1059"
20D8I10"Void A1060"
19D10I11"A5794 A1061"
21D22I18"struct A118 *A1062"
33D13I8" A1063;
"
20D13I8"A4 A7267"
26D4I4"7776"
14D10I8"63 A7777"
19D21
29D3I3"114"
8D2I2"64"
11I40"A81 A7512();
extern A49 A1073();
extern "
8D2I66"74();
extern A72 A1075[];
extern A9036 A1076();
extern A9036 A7778"
14D94I118"3097
{
A70 A3098; A72 A3099; A7468 A3100; A7468 A3101; A72 A3102; A72 A3103; A72 A3104; A7 A3105; A4 A3106; A7 A5282; "
100D5I85"283; A32 A5284; A74 A5966; A17 A6270; };
extern A81 A3107;
extern A315 A3108;
extern "
13D55I62"3097 A3109;
extern A58 A3110;
extern A4 A6067;
extern A72 A311"
60D10I14"extern A6 A311"
15D45
52D11I14"Void A1077();
"
19D7I21"48 strcat(), strcpy()"
17D9I14"48 strncpy(); "
16D11I13"int strncmp()"
24D4I4"1078"
15D8I7"2 A7268"
27D2I2"79"
13D12I18"struct A553 *A1080"
21I17"A7 A9295;
extern "
6D67I3"108"
72I66"struct A553
{
struct A553 *A1082;
A7 A1083;
struct A114 A1084;
};
"
15D81I1"8"
86D75I59"struct A5513
{
A81 A5514;
struct A147 *A5515;
};
A5972 A777"
80D39I10"A5972 A778"
44D17I10"A5972 A778"
22D16I10"A5972 A778"
21D16I10"A5972 A778"
21D16I10"A5972 A778"
21I15"A5972 A7785();
"
7D14I11"A74 A6242; "
21D12I8"A7 A1086"
21D12I8"A7 A7184"
21D12I11"A5794 A5248"
25D6I4"7185"
15D10I10"A95 *A1087"
27D4I4"1088"
21D4I4"1089"
21D4I4"7186"
21D3I3"109"
21D4I4"7187"
15D10I11"A5794 A1091"
21D9I10"Void A1092"
27D3I3"093"
20D4I4"8269"
20D3I3"094"
14D10I8"A4 A1095"
21D10I8"A4 A1096"
28D3I3"097"
20D4I4"1098"
16D10I7"4 A1099"
21D10I11"A94 * A5272"
21D9I10"A94 * A110"
21D10I11"A94 * A1101"
29D2I2"02"
19D4I4"1103"
15D11I10"Void A1104"
30D2I2"05"
21D2I2"06"
19D4I4"5675"
21D4I4"6243"
15D10I8"A4 A5518"
27D4I4"7786"
21D4I4"5516"
21D4I4"5517"
21D4I4"5519"
22D3I3"520"
14D18I12"Void A5521()"
27D17
23D4I4"5522"
15D10I9"A23 A7787"
21D8I10"Void A1107"
19D10I10"Void A1108"
22D10I7"4 A1109"
21D11I10"Void A1110"
22D11I10"Void A1111"
22D11I10"Void A1112"
22I21"Void A2942();
extern "
7D4I4"1113"
15D55I12"Void A2949()"
64D13I12"Void A7070()"
22D9I12"Void A1114()"
18D10I12"Void A1115()"
19D9I12"Void A7269()"
19D8I12"94 * A1116()"
17D9I12"Void A1117()"
18D18I12"Void A1118()"
27D18I12"Void A1119()"
27D26I12"Void A7788()"
35D8I12"Void A5676()"
17D18
26D2I2"20"
21D2I2"21"
21D2I2"22"
13D9I10"Void A8270"
26D4I4"5249"
15D10I18"struct A144 *A5523"
19I17"A7 A5822;
extern "
6D4I4"7789"
21D4I4"7790"
19D4I4"7791"
15D10I10"A94 *A7792"
21D10I11"A5794 A7793"
22D7I10"5794 A7794"
19D7I10"5794 A7795"
18D10I11"A5794 A7796"
22D8I10"5794 A7797"
20D2I4"5794"
7D3I45"8();
struct A5304 { A77 A3049; A5794 A1148; }"
12D12I13"A2 A1123[100]"
21D12I9"A17 A1124"
21D12I10"A13 *A1125"
21D12I9"A81 A1126"
23D9I7"8 A1127"
19D1I1"5"
6D4I2"28"
13D11I18"struct A144 *A1129"
20D11I18"struct A144 *A1130"
20D11I26"const struct A5304 A3050[]"
21D10I7"4 A1131"
20D17I8"38 A1132"
26D45I9"Void A113"
65D1I1"3"
21D1I1"3"
13D9I8"A17 A113"
29D1I1"3"
13D10I8"A4 A2979"
29D1I1"3"
19D3I3"917"
23D2I2"39"
13I19"A4 A1140();
extern "
8D1I1"4"
6D124I231"extern Void A5529();
extern A4 A5530();
extern A7 A5532();
extern Void A5533();
extern A66 A5534();
extern A66 A7799();
extern Void A5531();
extern Void A1142();
extern Void A1143();
extern Void A1144();
extern A50 A1145();
extern "
131D339I15"46();
extern A7"
344D13I118"47();
extern A48 A1148();
extern A48 A1149();
extern A77 A1150();
extern A58 *A5067, *A5068;
extern A17 *A8945, *A8946"
22D4I6"8271()"
15D5I193"53();
extern Void A1154();
extern Void A1155();
extern Void A1156();
extern Void A1157();
extern Void A5823();
extern Void A1158();
extern Void A1159();
extern Void A1160();
extern Void A1161()"
15D4I4"8402"
15D19
25D4I75"8403; A54 A8404; A13 *A8405; A7468 A8406; A72 A8407; A58 *A8408;
A58 *A8409"
19D52I1"6"
57D1I1"7"
6D56I4"63;
"
61D10I229"
A7132,
A7133,
A1164,
A1165,
A1166,
A1167,
A1168,
A1169,
A1170,
A1171,
A1172,
A1173;
A13 A1174[ (2000 / CHARLEN) ];
A18 A5435;
A17 A6040;
A13 A7800[ (2000 / CHARLEN) ];
A61 A6041;
A17 A6042;
} ;
extern A13 A9180[(2000 / CHARLEN)]"
20D4I4"9248"
14D88I6"9249; "
95D17I17"9296; A17 A9250; "
24D6I6"9251; "
13D6I19"9297; FILE *A9252; "
16D9I18"struct A9248 A9253"
18D127I14"Void A9254();
"
135D27I104"391
{
struct A633 *A1175;
struct A144 *A1176;
struct A144 *A1177;
struct A144 *A1178;
};
struct A1179
{
"
32D262I91"180;
A53 A1181;
A17 A1182;
A53 A1183;
A5794 A1184;
A5794 A1185;
};
struct A1186
{
struct A8"
267D31I5"187;
"
40D27
33D12I8"188;
};
"
21D18I6"189
{
"
26D71I105"640 *A1190;
A5794 A1191;
};
struct A1192
{
A17 A1193;
A9 A1194;
A70 A1195;
};
struct A1196 { A2 A1197[3];"
77I833" *A1198; };
struct A1199
{
A5794 A1200;
A35 A1201;
A42 A1202;
};
Void A1203();
Void A1204();
Void A1205();
struct A5677
{
A5794 A5678;
A42 A5679;
A5794 A5680;
A5794 A5681;
};
extern A17 A6244;
extern long A7418;
extern A49 *A1206;
extern A49 *A1207;
extern A2 A1208[ARG_LEN];
extern A42 A8197; extern A2 A3496[ARG_LEN];
extern struct A1196 A1209[];
extern const A6 A1210;
extern A7 A5406;
extern A7 A5407;
extern A7 A6210;
extern A42 A1211;
extern A4 A1212;
extern A72 A1213;
extern A72 A1214;
extern A18 A1215;
extern A18 A1216;
extern A4 A7228;
extern A61 A1217;
extern A61 A1218;
extern A67 A1219;
extern A13 *A6043;
extern A13 *A1220;
extern A13 *A1221;
extern struct A1162 A1222;
extern struct A144 *A1223;
extern struct A144 *A1224;
extern struct A144 *A1225;
extern A48 A1226;
extern A7 A1227;
extern A9070 A1228;
extern UFLAG"
1095I7"9298,
A"
2534D19
33D4I4"9255"
14D7I9"2 A7190[]"
16D8I18"struct A144 *A1398"
21D4I4"1399"
14D8I7"4 A7807"
18D7I6"7 A621"
21D7I6"9181; "
15I1"1"
6D1I1"0"
11D1I2"68"
6D1I1"1"
11D1I1"4"
6D1I2"2 "
11D1I1"7"
6D1I1"3"
10D4I2"A7"
9D3I1"4"
12D4I2"A7"
9D3I1"5"
12D4I2"A4"
9D3I1"6"
12D9I10"Void A1407"
20D9I10"Void A1408"
26D4I4"1409"
17D6I7"8 A1410"
17D10I9"A58 A1411"
21D8I10"Void A8257"
19D10I8"A4 A8411"
27D4I4"5063"
15D4I2"A6"
9D1I1"2"
12D2I4"Void"
7D1I1"3"
18D4I4"1414"
21D4I4"1415"
15D10I8"A4 A1416"
21D19I10"Void A5687"
36D4I4"5688"
15D10I10"Void A5689"
21D10I19"struct A5677 *A5690"
30D1I1"7"
12D10I10"A13 *A5396"
21D10I9"Void A141"
28D4I4"1419"
21D4I4"6052"
15D10I11"A5794 A7808"
30D1I1"4"
18D4I4"5545"
21D4I4"5546"
15D8I10"Void A5547"
19D2I4"Void"
7D1I1"0"
12D2I4"Void"
7D25I1"1"
36D9I7"A4 A624"
21D9I9"A48 A9182"
20D9I8"A4 A1422"
20D4I2"A4"
9D12I5"3();
"
26D5I6" A1424"
16D10I12"Void A3500()"
19D8I10"Void A1425"
19D8I9"int A3493"
19D10I9"int A3494"
27D4I4"1426"
15D10I19"struct A1189 *A1427"
21D12I10"A13 *A8273"
22D7I6"4 A599"
19D9I7"A4 A599"
21D8I10"Void A9311"
27D2I2"28"
13D12I10"Void A7191"
31D2I2"29"
13D8I10"Void A6080"
25D4I4"9183"
15D10I9"A54 A1430"
21D1I1"V"
6D4I4"1431"
15D10I8"A4 A7475"
30D1I1"2"
12D9I12"UFLAG *A1433"
29D1I1"4"
12D10I8"A4 A1435"
29D2I2"36"
13D1I1"v"
6D4I4"6246"
15D1I1"v"
6D4I4"7809"
21D4I4"1437"
23D2I2"38"
14D10I10"34 A5691()"
19D20
28D2I2"39"
19D4I4"1440"
15D10I12"Void A1441()"
19D17
26D1I1"2"
21D1I1"3"
12D11I10"Void A5773"
30D2I2"44"
13D12I11"A5794 A1445"
21I20"A5794 A1446;
extern "
6D4I4"1447"
21D4I4"3532"
15D12I10"A2 A3526[]"
21I17"A4 A3527;
extern "
6D2I2"14"
21D4I4"1449"
15D10I11"A5794 A1450"
30D1I1"1"
18D4I4"1452"
15D10I8"A4 A9184"
27D4I4"5274"
21D73I6"1453()"
82D19I12"Void A5651()"
28D20I12"Void A5548()"
29D20
26D4I130"3443();
extern Void A6072();
extern Void A1454();
extern Void A3363();
extern Void A1455();
extern Void A1456();
extern Void A5107"
17D89I65"065
{
A67 A1066;
A5794 A1067;
A5794 *A1068;
A17 A1069;
};
extern "
97D44I20"1065 *A1070;
extern "
52D40I53"1065 A1071[];
extern A67 A1072[];
extern Void A6209()"
53D12I85"
{
A79 A547;
A79 A548;
A79 A549;
A79 A6232;
A79 A5661;
A87 A6233;
A87 A5662;
A23 A552"
23D16I24"53 *A554, *A555, *A6234,"
21D1I12"63, *A557;
}"
11D29I14"93
{
A17 A8274"
34D35I21"98 A8275;
A8198 A8276"
50D44I10"8277[1];
}"
54D41I6"561
{
"
56D4I165"62;
struct A561 *A563;
A40 A564;
A40 A565;
A81 A566;
A58 A567;
A42 A568;
A68 A569;
struct A147 A570;
A17 A571;
A24 A572;
A61 A573;
A96 *A574;
struct A1537 * A7443;
}"
13D11I8"A81 A575"
20D9I17"struct A561 *A576"
28D1I1"7"
18D2I1"5"
22D2I2"79"
19D3I4"8278"
22D1I1"0"
20D1I1"1"
19D3I2"82"
22D9I1"3"
20D7I10"Void A5664"
18D19
27I65"4(), A585();
extern A4 A586();
extern A4 A5665();
extern Void A58"
1854I50"9136
{
struct A9136 *A9137; A17 A9138; };
struct A"
109D9I19"struct A9136 *A9139"
18D18
26D9I10"9136 A9140"
19D9I8"58 A7273"
18D4I3"A17"
9D3I1"4"
12D11I17"struct A588 A1719"
20D4I2"A2"
9D3I3"6[]"
20D2I2"77"
13D10I9"A89 A1978"
29D2I2"79"
19D4I4"1980"
21D4I4"7274"
24D1I1"1"
13D8I7"4 A9185"
19D18I8"A4 A9186"
35D4I4"5897"
24D1I1"2"
12D3I4"Void"
8D1I1"3"
12D10I9"A72 A1984"
21D10I18"struct A561 *A1985"
27D3I3"914"
23D2I2"86"
21D2I2"87"
13D27
33D26I4"9142"
37D10I9"A78 A1988"
27D4I4"1990"
21D4I4"1989"
21D4I4"1991"
15D8I10"Void A1992"
25D4I4"1993"
15I27"struct A144 *A7824; extern "
6D4I26"5553();
struct A147 *A7825"
23D2I2"26"
19D4I4"7827"
21D64I6"7828()"
73D8I10"Void A7829"
20D7I7"4 A7830"
18D9I12"Void A8412()"
18D9I12"Void A7831()"
18D9I12"Void A7832()"
18D19I12"Void A8413()"
28I14"Void A8414();
"
8D20I7"1457
{
"
26D12I4"58;
"
18D3I25"59;
A4 A1460;
A9 A1461;
}"
12D19I10"A9 A1461()"
28D18I10"A9 A1462()"
28D1I1"9"
6D1I1"3"
11D19I8"A4 A1464"
30D9I7"4 A1465"
19D20
28D11I10"83 **A5078"
21D9I18"struct A83 **A5079"
25D2I2"66"
13D9I7"4 A1467"
19D3I11"struct A144"
8D2I2"68"
12D11I18"struct A144 *A7476"
21D9I7"4 A1469"
19D10I19"struct A640 **A3651"
20D9I18"struct A640 **A365"
21D8I9"17 *A1470"
19D8I9"68 *A1471"
26D13I14"640 **A1472 ;
"
22D7I7"3 A1473"
18D11I7"4 A1474"
22D7I9"13 *A1475"
18D7I9"13 *A1476"
18D7I9"13 *A1477"
18D4I2"53"
9D2I2"78"
13D2I2"68"
7D2I2"79"
12D9I3"A17"
15D1I1"0"
12D1I2"57"
6D1I1"1"
11I19"A57 A3660 ;
extern "
17D3I4"5 ; "
11D10I8"57 A1482"
22D6I10"036 *A1483"
17D10I7"4 A1484"
20D18I8"A4 A8214"
29D8I7"4 A1485"
19D7I11"9036 *A1486"
18D7I9"81 *A1487"
17D8I16"const A81 *A1488"
19D7I7"6 A1489"
25D11I10"144 *A7276"
21D4I4"9036"
9D1I1"0"
11D17I8"A9 A1491"
27I21"A9036 A1492 ;
extern "
8D9I10"640 *A1493"
19D17I9"A63 A1494"
27D17I8"A4 A1495"
28D8I7"4 A1496"
22D4I4"5825"
18D4I5"1497 "
21D8I9"640 *A149"
19D12I12"A5794 A1499 "
21D12I18"struct A83 *A1500 "
21D10I18"struct A83 *A1501 "
19D13I18"struct A83 *A1502 "
22D10I18"struct A83 *A5080 "
20D9I9"53 A1503 "
18D12I9"A4 A1504 "
21D12I8"A4 A6247"
21I27"struct A83 *A6248 ;
extern "
6D4I4"9040"
23D2I2"05"
14D7I7"4 A1506"
18D10I11"A5794 A1507"
21D9I10"Void A7451"
20D10I8"A4 A7833"
22D8I7"4 A6249"
25D4I4"6250"
23D2I2"08"
13D8I10"Void A1509"
28D1I1"0"
12D4I2"A6"
9D1I1"1"
21D1I1"2"
12D10I9"A68 A1513"
21D7I9"Void A151"
20I203"81 A5692();
extern Void A8215();
extern Void A1515();
extern A4 A1516();
extern Void A1517();
extern Void A1518();
extern Void A1519();
extern Void A1520();
extern A4 A3738();
extern A4 A7834();
extern A"
561D1I1" "
11D1I1" "
11D1I1" "
10D1I1" "
10D1I1" "
10D1I1" "
848D4I4"9082"
15D19I10"Void A9083"
30D19I10"Void A9084"
30I21"Void A3863();
extern "
17D2I2"89"
13D10I19"struct A1537 *A1590"
21D10I19"struct A1537 *A1591"
27D2I2"71"
21D4I4"1592"
21D4I4"1593"
15D9I10"Void A7841"
29D1I1"2"
12D4I3"A74"
9D1I1"7"
18D4I4"7843"
21D4I4"8218"
15D9I10"Void A8219"
29D1I1"5"
13I1"7"
6D1I1"6"
12D3I4"Void"
8D1I1"7"
12D10I8"A4 A7848"
21D10I9"A74 A7849"
21D1I1"V"
8D24I4"94()"
33D9I4"void"
14D1I3"1()"
10D4I4"void"
9D9I17"2();
typedef A22*"
14I57"3;
extern const A51 A1524;
extern long A1525;
struct A152"
1445D10I8"A4 A9085"
27D4I4"3763"
15D9I10"Void A8835"
21D2I2"35"
7D1I3"4()"
10D11I3"A58"
16D1I1"5"
10D2I11"struct A147"
7D3I1"6"
12I19"A4 A3767();
extern "
2788D2I4"9070"
433D8I10"Void A9086"
19D9I9"A74 A9087"
28D1I1"6"
12D8I9"Void A737"
19D9I8"A4 A4551"
20D9I9"Void A738"
25D3I4"4724"
14D10I8"A58 A741"
29D1I2"77"
20D1I1"3"
18D4I3"744"
15I21"Void A8202();
extern "
1326D1I1" "
15D1I1" "
11D1I1" "
2390D2I4"9070"
215D2I4"9070"
12D1I2"72"
52D4I4"9088"
6927D1I1"7"
1080D10I9"4
A9176( "
15I1" "
15D38I77"A4 A2850;
if( A912( A1730 ) ||
A1140( A9180, A1730 ) ) goto A1711;
goto A1712"
43D10I31"11: A2850 = (A4) 1; 
goto A1713"
16D7I53"2: A2850 = (A4) 0; 
A1713:
return A2850;
}
A5794
A868"
12D57I6"0)
A67"
62D11I27"0;
{
struct A1065 *A1731, *"
16D28I11";
A67 A1750"
40D10I5"071;
"
15D17I7":if( !("
22D23
29D22
29D4I43"1) ) goto A1712;
goto A1713;
A1712:
A1749 ="
9D63I16"1 + 1;
if( A1749"
69D3I73"6 > A1730 ) goto A1713;
A1731 = A1749;
goto A1711;
A1713:
A1070 = A1731;
"
9I137"= A1730 - A1731->A1066;
return (A1731->A1069 & 0x04 && A1730 != 200 ) ?
"Internal Error; contact Gimpel Software." :
A1731->A1068[ A1750 "
489D6I3"A72"
171D3I13"(size_t)( 8 )"
165D6I3"A72"
93D1
23I9"(size_t)("
8I1")"
6423I1"!"
5I22" ) return 0;
if( A1800"
9133D96I4"5794"
101D60I20"6;
A9294++;
A9295++;"
66D11I3"108"
46D30I42"A2076 = A1113( A1080 );
goto A1713;
A1712:"
35D32I9"6 = ""; 
"
37D23I41":
if( ((A1309 > 0) || (A6210 & 0x20) ) ) "
32D22I1"4"
33D34I2"5;"
39D17I15"4: A8599( 0x8, "
22D19I1","
24D21I13"7, A2076 ); 
"
26I64":
if( (!(A1309 > 0) || (A6210 & 0x10) ) ) goto A1716;
goto A1717"
6D25I15"6:
A8599( 0x2, "
30D27I51", A1737, A2076 );
A8599( 0x1, A1806, A1737, A2076 )"
33D51I15"7:
if( !--A9294"
62D2I2"20"
13D1I1"1"
6D24I19"20: A1667( A943 ); "
29D17I97"1:
if( !--A9295 ) goto A1722;
goto A1723;
A1722: A1115( &A1080 ); 
A1723: ;
}
Void
A8599( A2070, "
22D21I1","
26D16I44"7, A2076 )
A7 A2070;
enum A6173 A1806;
A5794"
22D5I60";
A5794 A2076;
{
if( A6210 & A2070 ) goto A1711;
goto A1712;"
10D29I19"1:
{
A7 A1750;
A67 "
34D125I41";
switch( A2070 )
{
case 0x8:
A1750 = 2;
"
134I21"3;
case 0x2:
A1750 = "
12D2I67"3;
case 0x1:
A1750 = 0;
goto A1713;
default:
A882(200,3);
return;
}"
7D7I3"3:
"
14D8I31" A6212[A1806][A1750].A6206;
if("
15D39
50D1I1"4"
12D1I1"5"
7D34I57"4:
{
A5794 A7103 = A6212[A1806][A1750].A6207;
A5794 A1791"
40D26I2"6:"
32D3I43"750 && (*(A6212[A1806][A1750].A6208) == 0 )"
15D1I1"7"
11D2I2"20"
8D21I10"7:
A1750--"
31D2I2"16"
7D13I46"20:
A1791 = A6212[A1806][A1750].A6208;
A7750( "
18I199", A7103, A1791, A1737, A2076, "", "" );
}
A1715: ;
}
A1712: ;
}
Void
A9293( A2324, A2328, A2591, A2595 )
A23 A2324; struct A553 *A2328;
A23 A2591; struct A553 *A2595;
{
if( !((A2324|A2591) & 0x400000"
12D1I1"1"
12D1I1"1"
7D18I23"11: return; 
goto A1713"
23D9I2"12"
16D39I15"2324 & 0x400000"
50D2I2"14"
12D1I1"1"
7D22I39"14: A1085( &A1080, A2328 ); 
goto A1716"
27D1I1"1"
9D4I15"2591 & 0x400000"
15D2I2"17"
13D1I1"0"
6D47I61"17: A1085( &A1080, A2595 ); 
A1720:
A1716:
A6172( A9292, "" )"
52D14I160"13: ;
}
Void
A9177(A1806,A80)
enum A6173 A1806;
A81 A80;
{
extern void A8599();
if( ((A1309 > 0) || (A6210 & 0x20) ) ) goto A1711;
goto A1712;
A1711: A8599( 0x8"
19D76I39"06, A919( &(A80->A9153) ), "" ); 
A1712"
82D13I34"(!(A1309 > 0) || (A6210 & 0x10) ) "
23D2I2"13"
12D2I2"14"
7D23I98"13:
A8599( 0x2, A1806, A919( &(A80->A9153) ), "" );
A8599( 0x1, A1806, A919( &(A80->A9153) ), "" )"
28D18I11"14:
A1701 ="
23D3I144";
}
Void
A1677(A1730,A1841)
register A67 A1730;
A5794 A1841;
{register A4 A1842 = (A4) 0;
struct A1065 *A1742 = A1070;
if( A1742->A1069 & 0x02 )"
12D2I14"11;
goto A1712"
7D107I71"11:
if( A1730 == 306 || A1730 == 309 || A1730 == 314 || A1730 == 322 ) "
115D79I2"13"
89D9I8"14;
A171"
14D36I16"842 = A912(A1730"
47D33I46"15;
A1714: A1842 = (A4) 1;
A1715:
if( A1842 ) "
41D54I2"16"
64D64I29"17;
A1716: A1377 = 4;
A1717: "
74D83I20"20;
A1712: if( A912("
88D1I34") ) goto A1721;
goto A1722;
A1721:"
6D17I25"2 = (A4) 1;
A1722:
A1720:"
24D12I38"742->A1069 & (0x08|0x02|0x04) &&
A8945"
23D1I1"2"
12D2I2"25"
7D11I22"23:( *( A8945 ) ) |= 1"
16D19I4"25: "
25D31I3"842"
42D2I2"26"
12D2I2"27"
7D2I2"26"
8D16I52"A1377 && A1400 ) goto A1766;
goto A1767;
A1766:
{
A6"
21D27I78"2, A1843;
A5794 A9256;
A7187( (A5) 1, 0 );
A1089( "\n", NULL );
A1843 = A1086;"
32D37I13"2 = 0;
A1770:"
43D4I12"1732 < A1843"
14D1I1"6"
12D1I1"6"
8D34I2"1:"
39D10I15"2++;
goto A1770"
15D42I37"68:
A1089( "    ", NULL ); goto A1771"
47D13I105"69:
switch( A1377 )
{
case 1:
A1089( "--- Compiling template function: $s\n",
A1792( A725, (A17) 0x01 ) )"
23D2I46"72;
case 2:
if( A1498 ) goto A1773;
goto A1774"
7D10I29"73:
A9256 = A663(A1498->A645,"
19D52
60D14I2"75"
19D13I33"74: A9256 = "unknown module name""
18D73I54"75:
A1089( "--- Wrap-up for Module: $s\n\n", A9256 );
"
81D2I51"72;
case 3:
A1089( "--- Global Wrap-up\n\n", NULL )"
12D65I33"72;
case 4:
A1089( "\n", NULL );
"
73D2I54"72;
case 5:
A1089( "--- Thread messages:\n\n" , NULL )"
12D48I57"72;
case 6:
A1089( "--- Additional Misra Messages:\n\n" ,"
53D26I33" );
goto A1772;
default:
A865(287"
31D8I39"A1772:
A7187( (A5) 0, 0 );
}
A1767:
A16"
15I14"42->A1067, A17"
8D14I127"1 );
A1377 = 0;
;
if( A1376 && A1400 ) goto A1776;
goto A1777;
A1776:
A7293();
A1777:
A1678((A4) 1);
if( A1742->A1069 & 0x02 ||"
20D30I44" == 6 ) goto A1778;
goto A1779;
A1778:
if( ("
35D36I10" == 309 ||"
42D28I27" == 328) && (A1239 > 0) ||
"
33D30I36" == 330 && (A8199 > 0) ) goto A1780;"
36D31I3"656"
42D1I1"8"
12D1I1"8"
7D31I10"81:
fprint"
36D4I20"56, "ERROR %u %s\n","
16D74I3"1 )"
79D38I41"82:;
sys_exit( (int) A1215+1, (int) A1406"
44D28I33"80: ;
A1779: ;
goto A1783;
A1727:"
42D133I8";
A1783:"
139D135I9"9294 <= 0"
146D2I2"84"
12D2I2"85"
7D9I119"84: A1667( A943 ); 
A1785:
if( A1216 && A1215 >= A1216 ) goto A1786;
goto A1787;
A1786:
A865(315);
A1787: ;
}
Void
A897"
20D42I62"758 )
A67 A1730;
A5794 A1758;
{
if( !A1758 ) goto A1711;
goto "
47D15I38";
A1711: A1758 = "unnamed";
A1712:
if("
20D4I7"2( A173"
9D25I44"758 ) ) goto A1713;
goto A1714;
A1713:
A5996"
36D3I74"758 );
A1714:(A5052 = NULL, A6001 = 0, A1678((A4) 0));
}
Void
A5981( A1730"
9D1I8"4, A1849"
25D1I1"4"
7D48I17"9;
{
A898( A1730,"
53D65I2"4,"
70D31I22"9, NULL );
}
Void
A898"
44D17I1"4"
23D49I1"5"
55D2I20"6 )
A67 A1730;
A5794"
7D71I1"4"
77D1I1"5"
7D14I8"6;
{
if("
20D30I16" == 0 ) return; "
40D1I1"4"
39D1I1"4"
26D39I13"A6002( A1730,"
44D31I10"4 ),
A6000"
44D11I10"5 ),
A6000"
24D24I1"6"
38D1I1"3"
12D1I1"4"
7D1I1"3"
21D1I1"4"
7D1I1"5"
7D1I1"6"
9D1I1"4"
52D3I4"7750"
20D2I32"1854, A1855, A1856, A7885, A7886"
30D6I38"5794 A1854, A1855, A1856, A7885, A7886"
14D1I14"A6002( A1730, "
8D67I7",
A6000"
79D12I11"54 ),
A6000"
22D43I13"1855 ),
A6000"
55D73I11"56 ),
A6000"
83D22I14"7885 ),
A6000("
28D49I9", A7886 )"
82I14"
A7882( A1730,"
6D37
42D5I53"54, A1855, A1856, A7885, A7886 );
A1712:(A5052 = NULL"
11D28I4"1 = "
33D44I25"678((A4) 0));
}
Void
A900"
57D86I1"7"
92D15I1"8"
39D12I1"7"
17D18I5"48;
{"
28D1I1"7"
39D1I1"7"
22D13I43"if( !A1848 ) goto A1713;
goto A1714;
A1713:"
18D10I31"8 = "unnamed";
A1714:
if( A6002"
22D24I5"47 ),"
29D1I1"2"
13D2I2"48"
16D1I1"5"
12D1I1"6"
7D8I8"5:
A5997"
21D1I1"7"
6D8I1"4"
17D1I1"6"
52D4I5"901( "
9I22", A1847, A1848, A1849 "
13D70
78D19I20"847, A1848, A1849;
{"
24D21I6"!A1847"
54D77I18" A1847 = "unnamed""
85D14I74"
if( !A1848 ) goto A1713;
goto A1714;
A1713: A1848 = "unnamed";
A1714:
if("
19D4I7"2( A173"
9D26I15"847 ) , A6002( "
32D16I16" A1848 ),
A6000("
22D50I7", A1849"
64D1I1"5"
12D1I1"6"
7D81I8"5:
A5998"
86D22I2"30"
27D2I16"47, A1848, A1849"
8D9I27"716:(A5052 = NULL, A6001 = "
14D50
72D4I3"899"
16D7
12D4I2"80"
27D4I20"44;
A81 A80;
{
if( !"
9D21
85D6I43"A6002( A1730, A1844 ) , A6003( A1730, A80 )"
39D29I6"
A5997"
41D17I42"44, A1698 );
A1714:(A5052 = NULL, A6001 = "
22D12I26"678((A4) 0));
}
Void
A7177"
24D49I6"44, A8"
54D4I22"758 )
A67 A1730;
A5794"
10D9I61";
A81 A80;
A5794 A1758;
{
if( !A1844 ) goto A1711;
goto A1712"
15D16I32"1: A1844 = "unnamed";
A1712:
if("
21D4I7"2( A173"
9D25I13"844 ) , A6003"
35D15I12"80 ), A6000("
21D7I1","
13D58
72D1I1"3"
12D1I1"4"
7D1I1"3"
7D1I1"8"
12D3I3"844"
10I7", A1758"
8D1I1"4"
52D3I4"5081"
15D2I2"44"
7D2I9"26, A1827"
25D2I13"44;
A81 A1826"
7D5I18"27;
{
A5794 A1828;"
10D45I6"!A1844"
78D29I34" A1844 = "unnamed";
A1712:
A6002( "
34D1
6D1I17"44 );
A6003( A173"
7D14I2"26"
20D3I22"828 = A1698;
if( A6003"
14D8I31"827 ) ) goto A1713;
goto A1714;"
13D25I14"3: A5998( A173"
30D32I3"844"
37D1I42"28, A1698 );
A1714:(A5052 = NULL, A6001 = "
6D11I31"678((A4) 0));
}
Void
A865(A1730"
24D38I7"{
A1677"
48D16I4"868("
21D17I16") );
}
Void
A884"
28D40I16"758 )
A67 A1730;"
50D17I30"58;
{
A5794 A1791;
if( A6000( "
22D44
49D8I24"58 ) ) goto A1711;
goto "
13D9I43";
A1711:
A1791 = A1689( A868(A1730), A1758,"
16D8I25"NULL, NULL );
A1677( A173"
13I41"791 );
A1712:(A5052 = NULL, A6001 = 0, A1"
24D3I2"5("
9D28I11"A1758,A1818"
49D2I32"758;
A6 A1818;
{
if( A6000( A173"
7D20I38"758 ) ) goto A1711;
goto A1712;
A1711:"
26D4I81"924( (A72) 100 + ((A72) strlen(A1758)) ) ) goto A1713;
goto A1714;
A1713:
sprintf"
9D2I22"06, A868(A1730), A1758"
7D12I11"18 );
A1677"
23D18I45"706 );
A1714: ;
A1712:(A5052 = NULL, A6001 = "
23D13I26"678((A4) 0));
}
Void
A5667"
26D38I28"0, A1844, A1851 )
A67 A1730;"
47D24I3"850"
29D2I2"44"
9D43I34";
{
if( !A1844 ) goto A1711;
goto "
48D62I8";
A1711:"
67D57I21"4 = "unnamed";
A1712:"
62I63"!A1851 ) goto A1713;
goto A1714;
A1713: A1851 = "";
A1714:
if( "
17D2I2"50"
10D1I1"2"
14D1I1"4"
9D1I1"0"
12D3I3"851"
17D1I1"5"
12D1I1"6"
7D1I1"5"
20D2I2"50"
8D8I8"4, A1851"
16D1I1"6"
53D2I2"86"
12D9I9"1758, A80"
24I13"5794 A1758;
A"
8D30I11"{
if( A6000"
40D39I14"1758 ) , A6003"
51D13I42" ) ) goto A1711;
goto A1712;
A1711:
A5997("
19D29I38", A1758, A1698 );
A1712:(A5052 = NULL,"
34D28I4"1 = "
33D44I25"678((A4) 0));
}
Void
A887"
55D14I3"850"
19D35I26"51 )
A67 A1730;
A5794 A185"
40D26I16"851;
{
if( A6000"
36D1I20"1850 ) , A6000( A173"
6D32I40"851 ) ) goto A1711;
goto A1712;
A1711:
{"
42D2I23"91 = A1689( A868(A1730)"
7D42I1"5"
47D12I24"851, NULL, NULL );
A1677"
23D25I9"791 );
}
"
30D20I24":(A5052 = NULL, A6001 = "
26D9I31"78((A4) 0));
}
Void
A888( A1730"
14D35I1"5"
40D27I17"851, A1852 )
A67 "
32D52
64D1I1"0"
7D30I1"1"
35D20I5"52;
{"
31I1" "
6D6I9" A1850 ) "
12D2I3"0( "
8D6I9" A1851 ) "
14I1" "
6D5I7" A1852 "
40D7I28"{
A5794 A1791 = A1689( A868("
12I1")"
5D2I2"50"
8D8I1"1"
14D1I7"2, NULL"
7I25"677( A1730, A1791 );
}
A1"
54D3I3"889"
13D1I3"185"
8D1I1"1"
7D1I8"2, A1853"
16D9
18D1I1"0"
7D1I15"1, A1852, A1853"
13D1I1"0"
11D6I9"1850 ) , "
24D1I1"1"
23D1I25"2 ) , A6000( A1730, A1853"
37D3I35"{
A5794 A1791 = A1689( A868(A1730),"
8D46
51D3I3"851"
9D1I1"2"
7D28I9"3 );
A167"
40D13I8"791 );
}"
18D9
61D3I3"890"
13D2I4"1845"
7D16I9"46, A1758"
31D9
17D2I2"45"
7D9I9"46, A1758"
21D1I1"0"
11D2I4"1845"
23D2I2"46"
10D1I1"2"
12D26I3"758"
66D1I1"8"
12D3I3"845"
8D16I9"46, A1758"
76D3I3"895"
15I7", A1836"
23D11I30"A7 A1836;
{
A950 = A1836;
A894"
23D55I11", A920(A80)"
60D45I7"950 = 0"
55D4I4"7061"
65D1I35"A6003( A1730, A80 ),
A6002( A1730, "
9I2") "
30I32"
A5998( A1730, A1698, A920(A80),"
7D11I1")"
19D4I14"(A5052 = NULL,"
9D7I4"1 = "
12D13I26"678((A4) 0));
}
Void
A5958"
25D54I6", A175"
64D63I4"
A67"
69I22";
A81 A80;
A5794 A1758"
6D28I15"4;
{
if( A6003("
34D7I45", A80 ),
A6000( A1730, A1758 ),
A6002( A1730,"
12D63I3"4 )"
96I28"
A5998( A1730, A1698, A1758,"
5D13I3"4 )"
21D70I14"(A5052 = NULL,"
75D7I4"1 = "
12D48I27"678((A4) 0));
}
Void
A7745("
54D24
29D10I23",A1854,A1827,A1855)
A67"
16I30";
A81 A1826,A1827;
A5794 A1854"
5D43I24"55;
{
A5794 A1828;
A6003"
55D3I13"26 );
A1828 ="
9D38I5";
if("
43D36I2"0("
42D18I14"A1854), A6003("
23D29I8",A1827),"
34D3I2"0("
9D28I5"A1855"
67D1I1"9"
12D2I2"82"
7D3I17"854, A1698, A1855"
63D4I3"902"
20D3I3"854"
8D2I2"55"
33D35I23"854, A1855;
{
if( A6003"
47D44I9" ),
A6000"
54D1I19"1854 ),
A6000( A173"
6D9I88"855 ) ) goto A1711;
goto A1712;
A1711:
if( A1855 ) goto A1713;
goto A1714;
A1713: A5998("
15D104I7", A1698"
109D32I2"54"
37D9I44"55 );
goto A1715;
A1714: A5997( A1730, A1698"
14D8I75"54 );
A1715: ;
A1712:(A5052 = NULL, A6001 = 0, A1678((A4) 0));
}
Void
A903("
14D11I38", A80, A1854, A1855, A1856 )
A67 A1730"
18D29I3"80;"
39D115I2"54"
120D2I2"55"
7D32I15"56;
{
if( A6003"
44D14I16" ),
A6000( A1730"
19D8I12"54 ),
A6000("
14D50I16", A1855 ),
A6000"
60D2I4"1856"
38D21I5"A5999"
26D37
52D12I15"4, A1855, A1856"
17D12
67D3I3"904"
13D11I2"80"
30D28I10"80;
{
if( "
43D46I2"80"
86D1I1"6"
12D23I3"698"
83D4I4"5828"
14D4I2"80"
9D2I2"44"
21D14I3"80;"
24D54I5"44;
{"
59D21I6"!A1844"
54D36I121" A1844 = "unnamed";
A1712:
if( A6002( A1730, A1844 ) , A6003( A1730, A80 ) ) goto A1713;
goto A1714;
A1713:
A5997( A1730,"
42D34I7", A1844"
39D55I28"1714:(A5052 = NULL, A6001 = "
60D25I11"678((A4) 0)"
30D29I16"Void
A8985( A173"
34D33I3"847"
45D2I2"48"
7D16I2"27"
31I13"5794 A1847;
A"
8D7
19D1I1"8"
8D11I4"1827"
22D121I49"8517;
if( !A1847 ) goto A1711;
goto A1712;
A1711:"
126D42I21"7 = "unnamed";
A1712:"
47D21I6"!A1848"
33D1I1"3"
12D1I1"4"
7D30I2"3:"
35D23I13"8 = "unnamed""
29D16I2"4:"
21D4I7"3( A173"
9D26I46"827 );
A8517 = A1076( A943, A1698 );
if( A6002"
38D2I18"47 ),
A6003( A1730"
8D21I11"6 ),
A6002("
27D53I77", A1848 ) ) goto A1715;
goto A1716;
A1715:
A5999( A1730, A1847, A1698, A1848,"
59D54
59D66I28"1716:(A5052 = NULL, A6001 = "
71D46I25"678((A4) 0));
}
Void
A894"
56D19I1"8"
24D13I9"758 )
A67"
19D6I69";
A81 A80;
A5794 A1758;
{
if( A6003( A1730, A80 ), A6000( A1730, A175"
47D1I1"7"
18D17I3"175"
28D1I40"(A5052 = NULL, A6001 = 0, A1678((A4) 0))"
11D4I4"1857"
14D4I9"80, A1758"
9D9I2"36"
28D21I3"80;"
30D23I35"758;
A7 A1836;
{
A950 = A1836;
A902"
33D4I20"80, A1758, A920(A80)"
9D19I21"950 = 0;
}
Void
A5821"
29D33I15"80, A1740 )
A67"
39D47I91";
A81 A80;
A58 A1740;
{
A5794 A1860;
A1860 = A1076( A943, A1153(A1740,(A6230) 0x01) );
A582"
58D51I1"8"
56D11I4"860 "
23D3I3"944"
14D2I2"79"
9D22I15"6, A1797, A1827"
37I11"58 A1796;
A"
8D1I16";
A58 A1797;
A81"
7D21
34D2I45"61 = A1076( A943, A1153(A1796,(A6230) 0x01) )"
11D59I3"851"
65D10I45"076( A943, A1153(A1797,(A6230) 0x01) );
A8985"
22I21"61, A1826, A8518, A18"
6D20I12"}
Void
A1858"
30D29I29"80, A1796, A1797, A1836 )
A67"
35D25I40";
A81 A80;
A58 A1796, A1797;
A7 A1836;
{"
46D3I1"0"
39D5I21"{
A5794 A1859 = A1795"
10I37"96, A1797 );
A950 = A1836;
A5998( A17"
6D28
33D4I16"A1859, A920(A80)"
9I12"950 = 0;
}
A"
55D4I3"896"
25D7
37D7
25D26
63I4"if( "
21D42
76D48I20"A5998( A1730, A1828,"
54D21
32D1I1"7"
7D34I75"1712:(A5052 = NULL, A6001 = 0, A1678((A4) 0));
}
Void
A7507( A1730, A1826, "
39D56I6" )
A67"
62D1I5";
A81"
6D9I30"6, A1827;
{
A5794 A1828;
A5794"
15D56I13";
A6003( A173"
61D25I31"826 );
A1828 = A1698;
if( A6003"
35D31I41"1827 ) ) goto A1711;
goto A1712;
A1711:
{"
39D102I26"7518;
A5794 A7519;
A3242 ="
107D8I35"8;
A7518 = A1076( A943, A920(A1826)"
13D28I55"7266();
A7519 = A1076( A943, A920(A1827) );
A5999( A173"
33D11I25"828, A7518, A3242, A7519 "
16I50"A1712:(A5052 = NULL, A6001 = 0, A1678((A4) 0));
}
"
7D3I3"747"
13D7
15D10I3"827"
15D2I16"44, A7887, A7888"
17D13
21D11I7", A1827"
20D4I4"1844"
11D4I11"7887, A7888"
17D7I2"28"
16D4I47"3242;
A5794 A7889;
A6003( A1730, A1826 );
A1828"
9D36I24"698;
A6003( A1730, A1827"
41D15I73"3242 = A1698;
A5993( A1730, A1844 );
A6003( A1730, A7887 );
A7889 = A1698"
22D13I20"6003( A1730, A7888 )"
48D4I4"7882"
17D1I35"8, A3242, A1844, A7889, A1698, NULL"
7D25I12"712:(A5052 ="
32D18I47"A6001 = 0, A1678((A4) 0));
}
Void
A8943( A1730,"
23D56I1"6"
63D21I5", A17"
27D36I9"797 )
A67"
42D155I5";
A81"
161D39
49D1I1"7"
10D3I16"96;
A58 A1797;
{"
11D7I5"8517;"
17D19I1"6"
45D2I2"96"
20D3I69"A5794 A8518 = A1076( A943, A1153(A1797,(A6230) 0x01) );
A6003( A1730,"
8D63I1"7"
68D18I18"8517 = A1076( A943"
25D22I3" );"
44D2I48"61 ),
A6003( A1730, A1826 ),
A6002( A1730, A8518"
16D1I1"1"
12D1I1"2"
7D1I1"1"
7D1I1"9"
12D3I10"698, A8517"
8D8I8"61, A851"
17D42I3"2: "
52D3I4"7748"
14D3I17"826, A1827, A7887"
18D8I22"81 A1826, A1827, A7887"
13D3I30"5794 A1828;
A5794 A3242;
A6003"
14D27I27"826 );
A1828 = A1698;
A6003"
38D14I32"827 );
A3242 = A1698;
if( A6003("
20D80I48", A7887 ) ) goto A1711;
goto A1712;
A1711:
A5998"
92D8I65"28, A3242, A1698 );
A1712:(A5052 = NULL, A6001 = 0, A1678((A4) 0)"
19D4I4"8212"
15D3I3"826"
9D8I22"7, A7887, A7888, A8221"
23D11
26I21", A7887, A7888, A8221"
13D2I64"28;
A5794 A3242;
A5794 A7889;
A5794 A8222;
A6003( A1730, A1826 )"
7D2I2"28"
7D34I10"698;
A6003"
46D14
20D11I20"A3242 = A1698;
A6003"
21D24I29"7887 );
A7889 = A1698;
A6003("
30D53I16", A7888 );
A8222"
58D33I14"698;
if( A6003"
43D43I45"8221 ) ) goto A1711;
goto A1712;
A1711:
A7882"
54D3I17"828, A3242, A7889"
8D1I48"22, A1698, NULL );
A1712:(A5052 = NULL, A6001 = "
6D9I27"678((A4) 0));
}
Void
A7749("
15D44I27", A1826, A1827, A7887 )
A67"
49D2I29"0;
A81 A1826, A1827, A7887;
{"
12D9I58"28;
A5794 A3242;
A5794 A7889;
A6003( A1730, A1826 );
A1828"
14D24I24"698;
A6003( A1730, A1827"
29D4I4"3242"
9D33I14"698;
if( A6003"
43D155I41"7887 ) ) goto A1711;
goto A1712;
A1711:
{"
163D4I4"7518"
13D4I4"7519"
13D4I11"7890;
A7889"
9I15"698;
A7518 = A1"
12D23I9"920(A1826"
28D47I13"A7266();
A751"
52D87
100D4I10"920(A1827)"
9D24I12"7266();
A789"
30D13I30"076( A943, A920(A7887) );
A788"
26D30I42"28, A7518, A3242, A7519, A7889, A7890 );
}"
35D45I1"2"
90D8I11"Void
A881( "
13I13", A80, A1758 "
13D25I27"A81 A80;
A5794 A1758;
{
if("
30D13I1"3"
20D57I15", A80 ) , A6000"
64D63I9", A1758 )"
98D30I5"5997("
39D12I12"1697, A1758 "
21D46I14"(A5052 = NULL,"
51D15I13"1 = 0, A1678("
21D52I17"));
}
Void
A7262("
58D39I41", A7295, A1826, A1740, A7296, A1827 )
A67"
45D25I153";
A5794 A7295;
A81 A1826;
A58 A1740;
A5794 A7296;
A81 A1827;
{
A5794 A1850 = "";
A5794 A1851 = A1076( A943, A1153(A1740,(A6230) 0x01) );
A5794 A1852 = """
32D14I13"1826 && A7295"
26D1I1"1"
12D1I1"2"
7D1I1"1"
6D10I60"03( A1730, A1826 );
A1850 = A866( A7295, A1698, NULL, NULL )"
16D1I1"2"
7D6I15"A1827 && A7296 "
17D1I1"3"
12D1I1"4"
6D34I9"13:
A6003"
39D2I71"30, A1827 );
A1852 = A866( A7296, A1698, NULL, NULL );
A1714:
if( A6002"
11D15I5"A1851"
20D15
23D4I9"15;
goto "
9D2
8D57I9"5:
A5998("
62D1I86"0, A1850, A1851, A1852 );
A1716:(A5052 = NULL, A6001 = 0, A1678((A4) 0));
}
Void
A8829"
11D35I31"7295, A1826, A1740, A1758 )
A67"
40D32I125"0;
A5794 A7295;
A81 A1826;
A58 A1740;
A5794 A1758;
{
A5794 A1850 = "";
A5794 A1851 = A1076( A943, A1153(A1740,(A6230) 0x01) )"
38D5I5"A1826"
10D3I42"7295 ) goto A1711;
goto A1712;
A1711:
A600"
14D22I56"1826 );
A1850 = A866( A7295, A1698, NULL, NULL );
A1712:"
27D8I6"A6002("
13D14I8"0, A1851"
19D27I37"goto A1713;
goto A1714;
A1713:
A5998("
32D32I24"0, A1850, A1851, A1758 )"
37D11I35"14:(A5052 = NULL, A6001 = 0, A1678("
16D1I3"0))"
10D18I5"A905("
23D28I37"0, A1740 )
A67 A1730;
A58 A1740;
{
A8"
33D44I36"1730, A1153(A1740,0) );
}
Void
A907("
49D74I1"0"
79D53I13"40, A80 )
A67"
58D190I35"0;
A58 A1740;
A81 A80;
{
A5794 A186"
195D93I33"860 = A1076( A943, A1153(A1740,0)"
98D6I24"899( A1730, A1860, A80 )"
16D13I81"5077( A1730, A1740, A1826, A1827 )
A67 A1730;
A58 A1740;
A81 A1826, A1827;
{
A579"
18D44I2"60"
50D1I1"0"
6D51I42"076( A943, A1153(A1740,0) );
A5081( A1730,"
56D82I30"0, A1826, A1827 );
}
Void
A907"
87D26I187"730, A1740, A1758 )
A67 A1730;
A58 A1740;
A5794 A1758;
{
A887( A1730, A1153(A1740,0), A1758 );
}
Void
A9078( A1730, A1796, A1797, A1758 )
A67 A1730;
A58 A1796, A1797;
A5794 A1758;
{
A5794"
31D94I38"1;
A1861 = A1076( A943, A1153(A1796,0)"
99D30I42"888( A1730, A1861, A1153(A1797,0), A1758 )"
40D31I5"8267("
36D22I91"0, A1740, A8290, A1758 )
A67 A1730;
A58 A1740;
A18 A8290;
A5794 A1758;
{
A5794 A1737;
A5794"
27D17I92"0;
A1737 = A1076( A943, A979( A8290 ) );
A1860 = A1076( A943, A1153(A1740,0) );
A901( A1730,"
22D51I2"0,"
56D5I177"7, A1758 );
}
Void
A8830( A1730, A8847, A80, A1740 )
A67 A1730;
struct A588 *A8847;
A81 A80;
A58 A1740;
{
A4 A8848 = !!( A492(A8847->A592) & 1 );
A5794 A8849;
A5794 A8850;
A5794"
10D26I43"0 = A1076( A943, A1153(A1740,(A6230) 0x01) "
34D13I4"8848"
46D21I29"
A8849 = A6237(A8847->A589);
"
33D10I38"A1712: A8849 = A8827((A88)A8847->A589)"
18D36I66"
A8849 = A1076( A943, A8849 );
A6003( A1730, A80 );
A8850 = A1698;"
41D16I13"A6002( A1730,"
21D71I2"0 "
84D1I1"4"
12D1I1"5"
7D25I39"4:
A5998( A1730, A8849, A8850, A1860 );"
30D66I34"5:(A5052 = NULL, A6001 = 0, A1678("
71D48I73"0));
}
A4
A912(A1730)
A67 A1730;
{
struct A809 **A6054;
A6 A6006 = A6001;"
53D156I59"A1730 == 830 ) return ( A1222.A7132 > 0) ? (A4) 0 : (A4) 1;"
165D15I65"0 == 831 ) return ( A1222.A7133 > 0) ? (A4) 0 : (A4) 1;
if( A415 "
25D2I2"11"
12D2I2"12"
7D3I35"11:
A6006 += A5980( &A1325, &A5986,"
8D15I17"0, A918(A415, 0))"
20D53I45"12:
A6006 -= (A6) A1140( A1222.A1174, A1730);"
59D86I25"6006 < 0 ) return (A4) 0;"
93D43I44"220 && (A1496||(A1266 > 0)) &&
A1140( A1220,"
48D39I39"0 ) ) return (A4) 0;
if( A1217 && A1729"
45D13I49"0, A1217 ) ) return (A4) 0;
if( A4793 && *A4793 )"
22D2I14"13;
goto A1714"
7D28I17"13:
A6054 = A4793"
33D74I15"17:
if( *A6054)"
83D27I4"15;
"
35D14I2"16"
19D48I23"20: A6054--;
goto A1717"
53D3I4"15:
"
9D11I46"729( A1730, (*A6054)->A5303 ) ) return (A4) 0;"
20D14I2"20"
19D27I4"16: "
32D4I15"14:
if( A936 ) "
12D5I3"21;"
14D2I2"22"
7D141I2"21"
147D70I8"*A936 &&"
75D97I2"3("
102D35I39"0, A936 ) ) return (A4) 0;
if( *A938 &&"
40D81I14"3( A1730, A938"
86D30I14"return (A4) 0;"
35D36I147"*A932 && A1733( A1730, A932 ) ) return (A4) 0;
if( *A934 && A1733( A1730, A934 ) ) return (A4) 0;
if( *A942 && A1733( A1730, A942 ) ) return (A4) 0"
41D33I142"22:
return (A4) 1;
}
Void
Errorno(A1732) A67 A1732; { A865(A1732); }
Void
A7297( A7298 )
struct A114 *A7298;
{
A49 *A2098;
A54 A1732;
A4 A7299"
38D56I85"4) 0;
A1732=( 0);
A1713:
if( A2098 = ( A7265)->A988+ A1732, A1732 <= ( A7265)->A991 )"
66D50I3"1;
"
59D62I19"2;
A1714: A1732++;
"
71D13I1"3"
19D34I44"1:
A952 = (struct A114*) *A2098;
if( A952 ) "
42D2I14"15;
goto A1716"
7D45I12"15:A865(830)"
50D25I18"16:
A7299 = (A4) 1"
35D2I2"14"
7D23I25"12:
if( (A952 = A7298) )
"
31D2I2"17"
13D1I1"0"
6D37I12"17:A865(830)"
43D3I16"0:
A952 = NULL;
"
8D11I4"7299"
22D2I2"21"
12D2I2"22"
7D37I21"21:
A1009( A7265, 0 )"
42D4I136"22: ;
}
Void
A1678(A1809)
A4 A1809;
{
struct A114 *A1862;
struct A553 *A1863;
A1862 = A1701; A1701 = NULL;
A1863 = A1080; A1080 = NULL;
"
11D9I2"62"
20D2I2"11"
12D2I2"12"
7D33I16"11:
if( A1809 ) "
41D2I14"13;
goto A1714"
7D6I9"13: A7297"
11D34I4"62 )"
39D41I4"14: "
46D13I38"12:
if( A1863 ) goto A1715;
goto A1716"
18D37I2"15"
46D40I2"09"
51D2I2"17"
12D2I2"20"
7D38I22"17: A1110( A1863, 30 )"
43D55I16"20:
if( A9295 ) "
63D38I2"21"
48D38I16"22;
A1721: A1080"
44D7I4"63; "
16D2I2"23"
7D15I29"22: A1115( &A1863 ); 
A1723: "
20D23I2"16"
35D15I31"908(A1807)
A9 A1807;
{static A2"
20D5I170"6[20] = "";
static A53 A1864 = 0;
static A53 A1865=0;
static A4 A1866=(A4) 0;
A4 A1867 = (A4) 0;
A53 A1732;
A9 A1868;
A53 A9299;
A53 A1927;
A1868 = (A9)(A15)(A1807);
if( "
11I1"!"
6D28I1"6"
61D1I1" "
7D10I11"868 != '\f'"
43D26I12"A1664(A1868)"
34I16" return; 
A1712:"
5D23I118"(A1868 == '&' || A1868 == '<' || A1868 == '>' || A1868 == '\"') &&
(A5252 > 0) && (A7184 > 0) ) goto A1715;
goto A1716"
29D1I31"5: A5249(A1868); return; 
A1716"
9D10I77"868 == '\n' || A1868 == ' ' || A1868 == '\t' ||
(A1867 = (A4) 1, A1864 >= 20)"
22D1I1"7"
11D2I2"20"
8D10I122"7:
if( (A1654 + A1865 + A1864) > A7188.A1181 &&
A7188.A1181 &&
A1864 && (A1654 + 1) > A7188.A1183 ) goto A1721;
goto A1722"
15D30I40"21:
A1664( '\n' );
A1732 = 0;
A1726:
if("
35D44I128"2 < A7188.A1183) goto A1723;
goto A1725;
A1727: A1732++;
goto A1726;
A1723:A1664( ' ' ); goto A1727;
A1725:
A1865 = 0;
A1722:
if"
49D113I61"65 ) goto A1766;
goto A1767;
A1766:A1664( ' ' );
A1767:
A1865"
120D14I6"1732 ="
19D13I9"1770:
if("
18D160I32"2 < A1864) goto A1768;
goto A176"
165D146I14"771: A1732++;
"
154D14I2"70"
19D2I56"68:A1664( (A9)(A15)( A1736[A1732] ) ); goto A1771;
A1769"
7D2I33"64 = 0;
A1736[20-1] = '\0';
A1866"
7D54I3"867"
59D33I74"20:
switch( A1868 )
{
case '\n':
A1664( '\n' ); A1865 = 0; A1866 = (A4) 0;"
42D4I27"72;
case '\t':
if( A1503 ) "
12D1I13"73;
goto A177"
7D25I14"73:
{
A53 A186"
30D5I37"869 = A1503 - (A1654 % A1503);
A1775:"
13D8I7"9-- > 0"
19D72I4"76;
"
80D23I23"77;
A1776:A1664( ' ' );"
32D3I10"75;
A1777:"
12D2I16"72;
}
goto A1778"
7D25I26"74: A1664( '\t' );
A1778: "
33D14I13"72;
case ' ':"
19D11I6"5 = 1;"
20D37I29"72;
case '\f': A1664( '\f' );"
46D3I37"72;
case ':':
A1868 = A1702;
default:"
9D18I4"1866"
29D2I2"79"
12D2I2"80"
7D18I18"79: A1664(A1868); "
24D10I16"927 = A7188.A118"
22D2I2"81"
12D2I2"82"
7D18I27"81: A9299 = A1654 - A1927; "
26D2I2"83"
7D2I20"82: A9299 = 0;
A1783"
9D50I29"9299 >= 60 || A9299 >= 20 && "
55D10I75"68 == '>' || A1868 == ',' || A1868 == '}' || A1868 == ')' ||
A1868 == ';' )"
21D2I2"84"
12D2I2"85"
7D23I16"84: A908( '\n' )"
28D4I17"85: ; 
goto A1786"
9D4I33"80: A1736[ A1864++ ] = (A2) A1868"
9D85I4"86:
"
97D11I1"}"
18D216I140" ;
}
Void
A911(A1737, A1872)
register A5794 A1737;
A8703 *A1872;
{
A2 A1873[20];
A6 A1730;
register A9 A1833;
register A8703 A1874;
A1711:if"
221D118I62"33 = (A9)(A15)( *A1737++ ) ) goto A1712;
goto A1713;
A1712:
if"
123D36I41"33 == '$') goto A1714;
goto A1715;
A1714:"
41D62I86"4 = *A1872;
switch( A1833 = (A9)(A15)( *A1737++ ) )
{
case 's':
A910( (A5794) A1874 );"
71D4I51"16;
case 'c':
A908( (A9)(A15)( *(char *)A1874 ) ); "
12D2I85"16;
case 'h':
case 'i':
case 'T':
case 't':
if( A1833 == 'h' ) goto A1717;
goto A1720"
7D16I45"17: A1730 = (A6) *(short *) A1874;
goto A1721"
21D25I2"20"
34D11I9"33 == 'i'"
22D2I2"22"
12D2I2"23"
7D43I27"22: A1730 = *(A6 *) A1874;
"
51D14I2"25"
19D20I4"23: "
25D37I11"1833 == 'X'"
48D2I2"26"
12D2I2"27"
7D38I3"26:"
47D3I14"*(A9 *) A1874;"
12D2I2"66"
7D2I52"27: if( A1833 == 'C' ) goto A1767;
goto A1768;
A1767"
12D26I83"*(A7 *) A1874;
goto A1769;
A1768: if( A1833 == 'T' ) goto A1770;
goto A1771;
A1770:"
32D45I45" = (A6) *(A34 *) A1874;
goto A1772;
A1771: if"
50D47I9"33 == 't'"
58D2I2"73"
12D2I2"74"
7D89I41"73: A1730 = (A6) *(A3 *)A1874;
goto A1775"
94D2I55"74: A1730 = 0;
A1775:
A1772:
A1769:
A1766:
A1725:
A1721"
11D2I24"33 == 'X' && ' ' < A1730"
8D3I10"730 <= 127"
14D1I1"7"
12D1I1"7"
7D43I28"76:
A908((A9)(A15)(A1730));
"
51D14I2"78"
19D27I55"77:
A910( strcpy( A1873, A976((A6) A1730 ) ) );
A1778:
"
34D3I39"716;
case 'l':
A1685( *(long *) A1874 )"
12D2I103"716;
default:
A865(246);
}
A1716:
A1872 = A1872 + 1;
goto A1779;
A1715:
A908(A1833);
A1779: ; goto A171"
7D25I70"713: ;
}
Void
A1680(A1730)
A67 A1730;
{
A1649 = A1652;
++A7272[A1730];"
30D21I5"A1219"
31D3I3"711"
12D25I15"712;
A1711:
if("
32D21I9"> 1000 ) "
28D2I14"713;
goto A171"
8D16I18"13: A1730 -= 1000;"
24D57I12"711;
A1714:
"
67D55I42">= A1219 ) return;
A1712:
if( A1730 != 865"
65D3I3"715"
12D22I43"716;
A1715: ++A1215;
A1716: ;
}
Void
A1685("
27D10I7")
long "
15D61I21";
{
A910( A6237((A87)"
66D23I17") );
}
Void
A1681"
28D36I83"76, A1877, A1878 )
A5794 A1876;
A67 A1877;
A5794 A1878;
{static const struct A633 *"
44D54I16"NULL;
static A53"
59D58I18"0 = 0;
A4 A1881 = "
64D73I111";
A68 A1882;
A53 A1730=0;
A57 A1871;
register struct A633 *A1885=NULL;
struct A640 *A1886 = NULL;
struct A114 *"
78D108I23" = NULL;
struct A1189 *"
114D36I11"= NULL;
A48"
41D1I13"8=NULL;
A1871"
6D49I85"649;
A1680(A1877);
memset((A49)( &A853),0,(size_t)( sizeof(struct A853) ));
A853.A856"
55D8I2"76"
18D33I1"9"
39D10I46"77;
if( A5052 = A5053( A1877, NULL, A5052 ) ) "
17D43I47"711;
goto A1712;
A1711:
A1878 = A1689( "%s %e","
48D3I9"8, A5052,"
8D9I49", NULL );
A5052 = NULL;
A1712:
A853.A854 = A1878;"
15D15I3"415"
25D3I3"713"
12D52I41"714;
A1713: A853.A860 = A415->A129;
A1714"
59D15I11"1862 = A952"
25D5I73"715;
if( A1330 && (A1887 = A1424()) &&
A1887->A1190->A652 & (A17) 0x10 ) "
12D74I4"716;"
80D15I12"1886 = A1493"
25D3I3"717"
11D3I3"172"
8D17I24"717:
A1885 = A1886->A645"
25D48I13"1721;
A1720: "
55D33I10"62 = A1064"
42D6I40"1722;
if( !A1330 && (A1887 = A1424()) ) "
12D18I79"1723;
if( A7188.A1182 & (2|4) ) goto A1725;
goto A1726;
A1725:
A1887 = NULL;
if"
23D39I2"62"
44D48I28"701 ) goto A1727;
goto A1766"
53D3I37"27:
A1701 = NULL;
goto A1767;
A1766: "
8D26I14"7188.A1182 & 2"
37D2I2"68"
12D2I2"69"
7D2I2"68"
11D9I10"86 = A1498"
20D2I2"70"
12D2I2"71"
7D2I2"70"
7D61I85"85 = A1886->A645;
A1771: ;
A1769: ;
A1767: ;
A1726:
A1723:
A1722:
A1721:
A1716:
A1715"
67D28I33"A1885 && A1886 && A415 && A416 ) "
36D44I2"72"
54D59I2"73"
64D121I31"72:
{
struct A149 *A5366;
A1882"
126D13I183"023 ? A1023->A569 :
A948 ? A948 :
(A5366 = ( (A415)->A156 == (A41) 20 ? (A415)->A155.A150 : (struct A149 *) 0 )) ? A5366->A7166 : 0;
A853.A857 = A1882;
A853.A858 = 0;
A853.A855 = A663"
18D104I118"85 ,(A4) 0);
A909( A7180 );
A853.A857 = A1023 ? A1023->A569 : A948;
A853.A857 = A1882;
A853.A858 = 0;
A853.A855 = A663"
109D50I67"85 ,(A4) 0);
A853.A860 = A415->A129;
A1879 = A1885;
A948 = A853.A85"
55D32I7"880 = 0"
39D9I15"7188.A1180 >= 4"
20D23I4"74;
"
31D14I2"75"
19D30I16"74: A909( A945 )"
35D12I7"75: ;
}"
21D2I2"76"
7D4I4"73: "
11D9I11"85 && A1886"
20D2I2"77"
12D2I2"78"
7D52I80"77:
A1882 = A1886->A642;
if( (A5106 > 0) ) goto A1779;
goto A1780;
A1779: A7226("
57D48I5"780:
"
53D11I37"5398 && A1023 && A1023->A569 != A1882"
22D2I2"81"
12D2I2"82"
7D27I51"81: A1882 = A1023->A569; A1888 = NULL; A1730 = 0; 
"
35D41I16"83;
A1782: A1730"
46D10I12"686(&A1888);"
19D46I19"8 = A1730; 
A1783:
"
54D41I11"7 = A1882;
"
51I59"= A663( A1885 ,(A4) 0);
if( (A1886->A641 || A828) && A1888 "
10D2I2"84"
12D2I2"85"
7D21I89"84:
A1881 = A1885 != A1879 || A1882 != A948 ||
A7188.A1182 & (0x80 | 8) ||
A1699 || A1377"
26D4I25"85:
if( A1888 && A1881 ) "
12D37I2"86"
47D31I25"87;
A1786:
A1699 = (A4) 0"
38D11I15"7188.A1180 >= 2"
22D1I1"8"
11D2I2"88"
8D48I27"88:
if( A7188.A1180 >= 4 ) "
55D48I5"890;
"
55D13I31"891;
A1890: A909( A945 );
A1891"
19D9I21"!(A7188.A1182 & 0x80)"
19D3I3"892"
12D26I30"893;
A1892:
A8734( A1888, A173"
33D4I15"893: ;
A1889: ;"
12D23I11"894;
A1787:"
28D46I6"!A1888"
56D3I3"895"
12D31I48"896;
A1895: A908( '\n' );
goto A1897;
A1896: if("
36D26I60"0 != A1880 && !(A7188.A1182 & 1) &&
!(A7188.A1182 & 0x80) ) "
33D28I32"898;
goto A1899;
A1898:
A8731( 1"
34D2I16"0 ); A8730(A1730"
7D14I74"899:
A1897:
A1894:
A1879 = A1885;
A948 = A1882;
A1880 = A1730;
goto A1900;"
19D12I12"8: if( A1862"
22D3I3"901"
12D11I70"902;
A1901:
A1879 = 0;
A1885 = ((struct A633 *) A1206[ A1862->A116 ]);"
18D32I3"885"
42D3I3"903"
12D24I44"904;
A1903:
A853.A855 = A663(A1885,(A4) 0);
"
31D30I2"90"
35D5I92"904:
A853.A855 = "location unknown";
A1905:
A853.A857 = A1862->A115;
if( A7188.A1180 >= 4 ) "
12D25I3"906"
34D47I10"907;
A1906"
52D25I20"9( A945 );
A1907: ;
"
32D25I24"908;
A1902: if( A1887 ) "
32D2I14"909;
goto A191"
7D5I5"909:
"
12D10I17"86 = A1887->A1190"
20D2I2"91"
12D2I2"91"
7D2I2"91"
8D66I75"85 = A1886->A645;
A853.A855 = A663(A1885,(A4) 0);
A853.A857 = A1886->A642;
"
73D30I88"913;
A1912: A853.A855 = "?"; A853.A857 = 0; A1879 = NULL; 
A1913:
if( A7188.A1180 >= 4 )"
38D29I5"914;
"
36D13I10"915;
A1914"
18D10I20"9( A945 );
A1915: ;
"
17D30I34"916;
A1910:
if( A7188.A1180 >= 4 )"
38D28I5"917;
"
35D12I10"918;
A1917"
17D78I8"9( A945 "
83D16I70"918:
A1879 = NULL;
A1916:
A1908:
A1900:
A1776:
if( A7188.A1180 >= 4 ) "
23D127I5"919;
"
133D4I25"2330;
A1919: A909( A946 )"
12D87I46"2331;
A2330: A909( A944 );
A2331:
A908( '\n' )"
95D27I34"881 && A1888 && A7188.A1182 & 0x80"
36D4I4"2332"
12D12I26"2333;
A2332:
A8734( A1888,"
17D1I31"0 );
A2333:
A908( '\f' );
A1649"
6D23I16"871;
}
A4
A7201("
30D16I25")
A5794 A1737;
{
A9 A1833"
22D3I2"1:"
8D17I26"1833 = (A9)(A15)(*A1737++)"
29D1I1"2"
12D1I1"3"
7D25I39"2:
if( A1833 == '%' ) goto A1714;
goto "
30D9I28";
A1714:
A1833 = (A9)(A15)(*"
14D135I41"++);
switch( toupper(A1833) )
{
case 'F':"
140D7I28"!A853.A855 ) return (A4) 1;
"
16D20I11"6;
case 'I'"
26D7I28"!A853.A860 ) return (A4) 1;
"
16D2I36"6;
case ')':
return (A4) 0;
default:"
12D2I4"6;
}"
7D15I3"6: "
21D43I5"5: ;
"
52D13I1"1"
19D28I42"3:
return (A4) 0;
}
Void
A909(A1737)
A5794"
33D9I60"7;
{
A9 A1868, A1920;
A4 A1921 = (A4) 1; A5794 A5086 = A1737"
15D25I2"1:"
31D19I25"868 = (A9)(A15)(*A1737++)"
31D1I1"2"
11D2I2"13"
8D23I1"2"
29D32I7"!A1921 "
42D2I2"14"
12D2I2"15"
7D2I2"14"
8D8I5"A1868"
13D16I19"%' || A1868 == '\\'"
27D2I2"16"
12D2I2"17"
7D36I50"16:
A1868 = (A9)(A15)(*A1737++);
if( A1868 == 0 ) "
44D2I45"13;
if( A1868 == ')' ) goto A1720;
goto A1721"
8D10I29"0: A1921 = (A4) 1; goto A1711"
16D4I11"1: ;
A1717:"
13D2I2"11"
7D3I46"15:
if( A1868 == '%' ) goto A1722;
goto A1723;"
8D45I44"2:
{
A53 A1922;
++A7184; A1920 = (A9)(A15)(*"
50D20I5"++);
"
25D12I26" = toupper(A1920);
switch("
17D4I24")
{
case '(': if( A7201("
9D2I1")"
13D2I2"26"
12D2I2"27"
7D29I26"26: A1921 = (A4) 0;
A1727:"
38D2I68"25;
case ')': goto A1725;
case 'M':
A1702 = A1703;
A910( A853.A854 )"
7D100I82"02 = ':';
goto A1725;
case 'T': A910( A853.A856 ); goto A1725;
case 'F':
case 'A':"
105D23I164"A853.A855 ) goto A1766;
goto A1767;
A1766:
A910( A853.A855 );
A1767:
goto A1725;
case 'L':
A910( A979(A853.A857) );
goto A1725;
case 'C':
A1922 = A853.A858;
if( A19"
29D154I2"'C"
166D2I2"68"
12D2I2"69"
7D2I2"68"
7D2I2"22"
9D93I32"69:
A910( A976( (A6) A1922 ) );
"
101D4I47"25;
case 'N': A910( A979( (A18) A853.A859 ) ); "
12D37I12"25;
case 'I'"
43D15I9"A853.A860"
26D2I2"70"
12D2I2"71"
7D48I30"70:
A910( A853.A860 );
A1771:
"
56D63I4"25;
"
68D99I123"'{':
--A7184; if( A5086 == A7227 &&
A719 && A7446 != A719->A1627 ) goto A1772;
goto A1773;
A1772:
A7230( A5100, A719, A1737"
104D7I54"7446 = A719->A1627;
goto A1774;
A1773:
A483( A415, A41"
12D163I33"737 );
A1774:
++A7184; 
A1775:if("
168D92I27"37 ) goto A1776;
goto A1777"
97D13I2"76"
23D20I31"7[0] == '%' && A1737[1] == '}' "
30D2I2"78"
12D2I2"79"
7D2I2"78"
8D5I8"7 += 2; "
13D2I2"77"
7D40I13"79:
++A1737;
"
48D2I2"75"
7D47I4"77:
"
55D2I24"25;
case '}':
A1737 = """
12D79I27"25;
case '%':
A908( '%' );
"
87D4I41"25;
default: A908( '%' ); A908( A1868 ); "
12D2I34"25;
}
A1725:
--A7184;
}
goto A1780"
7D31I46"23: if( A1868 == '\\' ) goto A1781;
goto A1782"
36D54I72"81:
A1868 = (A9)(A15)(*A1737++);
switch(A1868)
{
case 'n': A908( '\n' );"
63D4I30"83;
case 'a': A908( '\007' ); "
12D101I26"83;
case 't': A908( '\t' )"
111D85I26"83;
case 's': A908( ' ' );"
94D4I30"83;
case '\\': A908( A1868 ); "
12D2I110"83;
case 'q': A908( '"' ); goto A1783;
default: A908( '\\' ); A908( A1868 ); goto A1783;
}
A1783: ;
goto A1784"
7D106I15"82: A908(A1868)"
111D79I15"84: ;
A1780: ;
"
87D14I2"11"
19D95I118"13: ;
}
A7
A1923()
{
A7 A1730 = (A7) (A1486 - A1483);
if( A1730 && !(A7188.A1182 & 0x20) && (!A1492[0] || !A1492[1]) )"
104D2I14"11;
goto A1712"
7D101I11"11:
A1730--"
106D95I99"12:
return A1730;
}
A5794
A1924(A1730)
A7 A1730;
{
A9036 A1737;
if( A1730 >= (A7) (A1486 - A1483) )"
104D2I14"11;
goto A1712"
7D8I9"11: A1737"
13D66I5"492;
"
74D14I2"13"
19D119I9"12: A1737"
124D88I12"483[A1730+1]"
93D95I28"13:
if( A7188.A1182 & 0x40 )"
104D2I14"14;
goto A1715"
7D88I24"14: A1737 = A5864(A1737)"
93D40I16"15:
return A1737"
46D8I45"3
A1686(A1932)
A48 *A1932;
{
A6 A1732;
A5794 "
13D28I46";
A53 A1933;
register A5794 A1934 = A1499;
A48"
33D34I27"6 = A1490;
extern A53 A1935"
40D13I4"A828"
46I42"
if( A827 ) goto A1713;
goto A1714;
A1713:"
5D23I8"6 = A827"
29D20I1"4"
27D53I32"1935 >= (A53) A1489 || A1935 < 0"
65D1I1"5"
12D1I1"6"
7D2I28"5: A1935 = 0;
A1716:
A1934 ="
7D14I8"6 + A193"
21D2I24"2:
A1732 = 0;
A1933 = 0;"
9D29I19"934 < A1736 + A1489"
63D20
25D32I8" = A1736"
38D1I1"3"
7D14I18"A1732++ < A1489 &&"
20D46I27" < A1934) goto A1721;
goto "
51D2
8D5I39"1:
if( *A1731++ == '\t' && A1503 > 0 ) "
13D1I13"25;
goto A172"
7D2I90"25:
A1933 += A1503 - A1933 % A1503;
goto A1727;
A1726: ++A1933;
A1727: ;
goto A1723;
A1722"
7D65I12"20:
*A1932 ="
70D35I1"6"
46D3I3"933"
15D22I51"0(A1737)
A5794 A1737;
{
A2 A1868;
A1711:if( A1868 ="
27D25I29"37++ ) goto A1712;
goto A1713"
30D104I49"12: A908( (A9)(A15)(A1868) ); goto A1711;
A1713: "
114D105I86"7293()
{
A57 A1871 = A1649;
A1649 = A1652;
A908('\n');
A1649 = A1871;
}
Void
A7226()
{"
110D5I184"!((A719) && (A719)->A1620 == 1 && (A719)->A1625) ) return; A909( A7227 );
}
A48
A1936( A1937 )
A5794 A1937;
{static A2 A1938[20];
A5794 A1737;
strcpy( A1938, "." );
if( A1937[0] == '.'"
38D126I8" A1937++"
132D14I17"2:
sg_sfcat( A193"
19D17I34"937, 20 );
sys_fnmap( A1938, 'e' )"
22D20I31"37 = A1938;
A1715:
if( *A1737) "
29D1I1"3"
12D1I1"4"
9D10I20" A1737++;
goto A1715"
16D14I25"3:
if( isupper(*A1737) ) "
22D2I14"14;
goto A1716"
8D15I64"4:
if( *A1737 && sys_mixed() && (gfl_ff > 0) ) goto A1717;
goto "
20D19I1";"
24D52I27"7:
{
A2 A7142[200];
sprintf"
57D1I114"42, "Upper case characters within extension '%s';"
" these will match lower case when +fff is on; try -fff" ,
A193"
6D27I25"A887( 686, A1226, A7142 )"
32D16I21"1720:
return A1938;
}"
26D1I114"44 *A7178 = NULL;
struct A144 *A7179 = NULL;
struct A144 *A5432 = NULL;
A7 A916 = 0;
A54
A1940( A1728 )
struct A14"
6D3I3"728"
15D56I10"1728->A991"
61D37I16"18
A5440(A1731)
"
47D8I56"62 *A1731;
{
A18 A2906 = 1; int A1732;
A1732 = 0;
A1713:"
13D96I48"A1732 < (2000 / CHARLEN)) goto A1711;
goto A1712"
101D50I3"14:"
55D49I91"2++;
goto A1713;
A1711:
A2906 += (A18) A1731->A1174[A1732]; goto A1714;
A1712:
return A2906"
60D72I6"13()
{"
79D15I27"330 ) return; if( !A7178 ) "
45D78I28"
A7178 = A999( 6, (A41) 16 )"
86D12I33"
A1009( A7178, 1 );
if( !A1696 ) "
21D1I1"3"
12D1I1"4"
7D79I30"3: A1696 = A999( 10, (A41) 0 )"
85D2I39"4:
A914( A7178 );
A916 = 0;
A931 = 0;
{"
7D5I7"! A1690"
17D1I1"5"
11D2I2"16"
8D108I8"5: A1522"
113D3I70"523 *) & A1690, (A1523 *) & A932, 20, (A72) sizeof( A61 )); A1690[ 20]"
8D39I12"A61 ) A1524;"
48D14I2"17"
19D91I8"16: A932"
96D11I66"690; 
A1717: A1690[0] = ( A61 ) ( 0); }
A933 = 0;
{ if( ! A1691 ) "
20D1I13"0;
goto A1721"
7D26I51"0: A1522( (A1523 *) & A1691, (A1523 *) & A934, 20, "
31D1
9D15I47" A61 )); A1691[ 20] = ( A61 ) A1524; goto A1722"
21D4I17"1: A934 = A1691; "
9D3I78"2: A1691[0] = ( A61 ) ( 0); }
A935 = 0;
{ if( ! A1692 ) goto A1723;
goto A1725"
8D4I112"23: A1522( (A1523 *) & A1692, (A1523 *) & A936, 20, (A72) sizeof( A61 )); A1692[ 20] = ( A61 ) A1524; goto A1726"
9D198I100"25: A936 = A1692; 
A1726: A1692[0] = ( A61 ) ( 0); }
A937 = 0;
{ if( ! A1693 ) goto A1727;
goto A176"
203D89I101"727: A1522( (A1523 *) & A1693, (A1523 *) & A938, 20, (A72) sizeof( A61 )); A1693[ 20] = ( A61 ) A1524"
99D36I85"67;
A1766: A938 = A1693; 
A1767: A1693[0] = ( A61 ) ( 0); }
A939 = 0;
{ if( ! A1694 )"
45D35I4"68;
"
43D82I2"69"
87D26I112"68: A1522( (A1523 *) & A1694, (A1523 *) & A940, 20, (A72) sizeof( A61 )); A1694[ 20] = ( A61 ) A1524; goto A1770"
31D2I8"69: A940"
7D21I66"694; 
A1770: A1694[0] = ( A61 ) ( 0); }
A941 = 0;
{ if( ! A1695 ) "
29D2I14"71;
goto A1772"
7D17I112"71: A1522( (A1523 *) & A1695, (A1523 *) & A942, 20, (A72) sizeof( A61 )); A1695[ 20] = ( A61 ) A1524; goto A1773"
22D3I52"72: A942 = A1695; 
A1773: A1695[0] = ( A61 ) ( 0); }"
8D5I6"!A5432"
16D2I2"74"
12D2I2"75"
7D13I54"74:
A5432 = A999( 6, (A41) 16 );
A1775: ;
}
A54
A5431("
18D26I111")
struct A1162 *A1731;
{
A54 A1732;
A49 *A2098;
struct A1162 *A1749;
if( !A1731->A5435 ) goto A1711;
goto A1712"
31D6I15"11: A1731->A543"
11D4I11"5440(A1731)"
9D23I14"12: A1732=( 0)"
28D68I31"15:
if( A2098 = ( A5432)->A988+"
73D23I51"2, A1732 <= ( A5432)->A991 ) goto A1713;
goto A1714"
29D6I38"6: A1732++;
goto A1715;
A1713:
if( A17"
12D28I22"struct A1162 *) *A2098"
39D2I2"17"
13D1I1"0"
6D77I5"17:
i"
82D101I59"749->A5435 == A1731->A5435 ) goto A1721;
goto A1722;
A1721:"
106D77I6"memcmp"
82D11I53"49, A1731, sizeof(struct A1162) ) == 0 )
return A1732"
17D28I14"2: ;
A1720: ;
"
36D80I2"16"
85D63I2"14"
68D50I5"49 = "
59D3I4"1162"
9D77I41"005( A5432 );
memcpy((A49)( A1749),(A49)("
82D12I56"1),(size_t)( sizeof( struct A1162 ) ));
return A1011;
}
"
18D15I108"914( A1728 )
struct A144 *A1728;
{
struct A1162 *A1731;
A1731 = (struct A1162 *) A1005(A1728);
memcpy((A49)("
20D8I172"1),(A49)( &A1222),(size_t)( sizeof( struct A1162 ) ));
}
Void
A915( A1728 )
struct A144 *A1728;
{
struct A1162 *A1731;
A54 A1808;
A1731 = (struct A1162 *) A1008(A1728);
if("
13D39I1"1"
73D29I27"memcpy((A49)( &A1222),(A49)"
35D9I71"1),(size_t)( sizeof( struct A1162 ) ));
if( (A1808 = A1940(A1728)) > 1 "
39D10I24"3:
A1009( A1728, A1808 )"
28D15I19"4: if( A1808 < 1 )
"
27D42I10"goto A1717"
48D1I68"6:A865(1233);
A1717: ;
A1715: ;
goto A1720;
A1712: A865(1233);
A1720"
7D7
13D20I105"917()
{
A1711:if( A916 > 0 ) goto A1712;
goto A1713;
A1712:
A915( A7178 );
--A916;
goto A1711;
A1713: ;
}"
26D66I102"
A919(A1941)
struct A114 *A1941;
{
return A923( A1941->A115, (A63) A1941->A116, (A63) A1941->A117 );
}"
72D67I50"
A920(A1942)
A81 A1942;
{
static struct A114 A2946"
76D3I3"942"
12I81" A919( &A2946 );
return A919( &A1942->A131 );
}
Void
A7266()
{
struct A114 *A1731"
6D103I48"1 = (struct A114 *) A1005( A7265 );
memcpy((A49)"
109D12I157"1),(A49)( &A1700),(size_t)( sizeof( struct A114 ) ));
}
Void
A921(A1941)
struct A114 *A1941;
{
struct A640 *A1886;
struct A1189 *A1887;
if( A1063 && A1064 )
"
21D1I1"1"
12D1I1"2"
7D20I83"1:memcpy((A49)( A1941),(A49)( A1064),(size_t)( sizeof( struct A114 ) ));
goto A1713"
26D56I3"2: "
61D28I6"949 )
"
37D1I1"4"
12D1I1"5"
7D54I14"4:memcpy((A49)"
59D4I63"41),(A49)( A949),(size_t)( sizeof( struct A114 ) ));
goto A1716"
9D15I4"15: "
21D19I4"494 "
29D2I2"17"
13D1I1"0"
6D11I86"17:
A1941->A116 = (A5775) A1494;
A1941->A117 = (A5776) A390;
A1941->A115 = A1493->A642"
22D1I1"1"
10D13I54"if( (A1887 = ( *(A1331) )) && (A1886 = A1887->A1190) )"
23I12"2;
goto A172"
7D24I90"2:
A1941->A116 = (A5775) A1886->A644;
A1941->A117 = (A5776) A1886->A645->A635;
A1941->A115"
29D3I21"886->A642;
goto A1725"
9D27I60"3:
memset((A49)( A1941),0,(size_t)( sizeof(struct A114) ));
"
32D12I2": "
17D23I4"21: "
28D100I4"16: "
105D278I8"13: ;
}
"
284D41I20"922(A1942)
A81 A1942"
46D1I99"921( &A1942->A131 );
}
A5794
A923(A1943, A1944, A1877)
A68 A1943;
A63 A1944;
A54 A1877;
{
static A2"
6D2I37"6[400];
A2 A1945 [(MAXFNM + 20)];
A48"
7D60I108"1;
A5794 A1946;
A18 A1947;
struct A633 *A1948;
A6 A1949;
switch( A950 )
{
case 1: A1946 = "conflicts with ";"
73I33"case 2: A1946 = "compare with "; "
9D3I39"1;
case 3: A1946 = "defined at "; goto "
8D17I38";
default: A1946 = NULL; goto A1711;
}"
22D1I1"1"
10D6I2"46"
18D1I1"2"
12D1I1"3"
7D2I26"2:
strcpy( A1736, A1946 );"
7D17I3"1 ="
22D12I27"6 + ((A72) strlen(A1736));
"
21D13I1"4"
18D2I2"13"
8D15I9"1 = A1736"
21D8I5"4:
if"
13D19I4"43 )"
28D4I9"15;
goto "
9D14
20D10I11"5:
sprintf("
15D1I27"1, "line %s", A979(A1943) )"
6D41I14"00.A115 = A194"
47D23I23"00.A116 = (A5775) A1944"
28D44I23"00.A117 = (A5776) A1877"
49D4I23"01 = &A1700;
goto A1717"
9D242I40"16: sprintf( A1731, "location unknown" )"
248D58I38"7:
A1949 = (A6) ((A72) strlen(A1736));"
64D8I5"1944 "
18D2I2"20"
12D2I2"21"
7D23I53"20:
A1947 = 0;
A1948 = ((struct A633 *) A1206[A1944])"
28D15I185"22:
++A1947;
sprintf( A1945, ", %s ", A1947 == 1 ? "file" : "module" );
sg_sfcat( A1945, A663(A1948,(A4) 0), (MAXFNM + 20) );
if( ((A72) strlen(A1945)) + ((A72) strlen(A1736)) < 400-1 )"
24D2I14"26;
goto A1727"
7D62I44"26:
strcat( A1736, A1945 );
A1727:
if( A1947"
68I8"|| A951 "
10D52I4"25;
"
57D8I46"1948->A635 == A1877 || A1877 == A390 || !A1877"
19D2I2"66"
12D2I2"67"
7D22I4"66:
"
27D11I21"1944 == A1494 && A149"
23D2I2"68"
12D2I2"69"
7D17I20"68:
A1736[A1949] = 0"
22D190I4"69:
"
199D1I1"5"
6D21I49"67:
A1948 = ((struct A391 *) A1207[A1877])->A1175"
27D3I2"3:"
8D15I9"1947 == 1"
27D13I1"2"
19D17I3"5: "
22D3I68"21:
return A1736;
}
static Void
A8730(A1730)
A53 A1730;
{
A53 A1732;"
8D2
12D6I22"0 >= 3 && A1730 <= 256"
17D2I2"11"
12D2I2"12"
7D34I10"11:
A7200("
40D37I14"32 = 0;
A1715:"
43D5I12"1732 < A1730"
16D1I1"3"
12D1I1"4"
7D22I12"6: ++A1732;
"
31D13I1"5"
21D19I13"
A7198(' '); "
28D1I1"6"
9D13I29"
A7199( A7188.A1184 );
A7198("
20D23
29D32I206"2: ;
}
static Void
A8732( A1737, A1730 )
A5794 A1737;
A53 A1730;
{
A53 A1732;
A9 A1833;
A53 A1927 = A7188.A1181;
A5794 A1928 = "";
A5794 A1929 = "";
A5794 A1930 = A7188.A1185;
A53 A1931;
if( !A1737 ) return"
37D20I19"30 += 2;
if( !A1927"
31D1I1"1"
12D1I1"1"
7D29I14"11: A1927 = 79"
34D4I42"12:
A1927 -= (A53) ((A72) strlen(A1929));
"
10D10I11"730 > A1927"
21D2I2"13"
12D2I2"14"
7D31I21"13: A1730 = A1927 / 2"
36D4I73"14:
A1931 = (A53) (((A72) strlen(A1928)) + ((A72) strlen(A1930)));
A1715:"
10D10I24"730 > A1931 && A1737[-1]"
21D1I1"1"
12D1I1"1"
7D20I22"16: --A1730; --A1737; "
28D2I2"15"
7D4I47"17:
A7200();
A7199( A1930 );
A1732 = 0;
A1722:
"
10D11I19"732 < A1730 - A1931"
21D2I2"20"
12D2I2"21"
7D18I11"23: A1732++"
28D2I2"22"
7D23I17"20: A7198( ' ' );"
32D13I1"2"
19D32I18"21:
A7199( A1928 )"
37D18I10"32 = A1730"
23D4I45"27:
if( A1732 < A1927) goto A1725;
goto A1726"
9D4I23"66: A1732++;
goto A1727"
9D4I100"25:
if( (A1833 = (A9)(A15)( A1737[ A1732-A1730 ] )) && A1737[A1732+1-A1730] ) goto A1767;
goto A1768"
9D4I112"67:
if( (A1833==' '||A1833=='\t'||A1833=='\n'||A1833=='\f'||A1833=='\r') || A1833 < ' ' ) goto A1769;
goto A1770"
9D4I28"69: A7198( ' ' );
goto A1771"
9D4I18"70: A7198( A1833 )"
9D2I2"71"
15D1I1"2"
6D18I14"68: goto A1726"
24D11I23"2: ;
goto A1766;
A1726:"
18D12I87" A1929 );
A7198( '\n' );
}
static Void
A8731( A1925, A1926 )
int A1925;
A53 A1926;
{
A7"
17D21I46"2, A1730;
if( !(A7188.A1182 & 0x10) ) return;
"
27D14I13"730 = A1923()"
26D1I1"1"
12D1I1"2"
7D39I16"1: A1699 = (A4) "
46D21I2"2:"
27D4I8"1925 > 0"
16D1I1"3"
12D1I1"4"
7D17I12"3:
A1732 = 1"
23D23I16"7:
if( A1732 <= "
29D6I31" goto A1715;
goto A1716;
A1720:"
11D37I5"2++;
"
46D13I1"7"
19D14I32"5:
A8732( A1924(A1732), A1926 );"
23D2I11"20;
A1716: "
12D2I2"21"
8D2I10"4:
A1732 ="
7D15I1"0"
20D40I7"25:
if("
45D17I31"2 >= 1) goto A1722;
goto A1723;"
22D5I2"6:"
10D12I5"2--;
"
20D2I2"25"
8D3I33"2:
A8732( A1924(A1732), A1926 ); "
11D95I2"26"
100D16I4"23: "
21D51I62"21: ;
}
Void
A8734( A7233, A5019 )
A48 A7233;
A53 A5019;
{
A53"
57D5I3";
A"
11D16I121"4;
A53 A1824;
A5794 A2126; A53 A7234; A53 A7891;
A2126 = A7231(&A7234); A7234 += A5019; A7891 = A7879(); A7234 += A7891; "
21D12I14"7188.A1182 & 1"
45I56" A8730(A7234); A8731(-1,A7234); 
A1712: A7200(); 
A1715:"
6D49I32"7891 > 0) goto A1713;
goto A1714"
54D44I23"16: A7891--;
goto A1715"
49D10I26"13: A7198(' '); goto A1716"
16D32I2"4:"
37D75I83"4 = A8733( A2126, 0 ); if( *A7188.A1184 && A7188.A1180 == 2 ) goto A1717;
goto A172"
82D11I7"7: A188"
17D19I40"53) ((A72) strlen(A7233)); if( A5019 < 0"
30D2I2"21"
12D1I1"2"
7D4I22"21: A5019 = 0;
A1722: "
9D11I12"5019 > A1883"
22D2I2"23"
12D1I1"2"
7D92I17"23: A5019 = A1883"
97D13I9"25: A1884"
18D62I82"233[ A5019 ]; A7233[ A5019 ] = '\0'; A1824 = A8733( A7233, A1824 ); A7233[A5019] ="
67D84I16"4; --A7184; A182"
89D78I16"8733( A7188.A118"
84D6I51"24 ); ++A7184; A8733( A7233 + A5019, A1824 ); goto "
11D2I35";
A1720: A8733( A7233, 0 );
A1726: "
7D11I15"853.A859 == 783"
44D30I14" A8733("\n", 0"
40D34I25"if( !(A7188.A1182 & 1) ) "
42D2I14"67;
goto A1768"
7D4I35"67:
A8731( 1, A7234 ); A8730(A7234)"
9D3I37"68: ;
}
Void
A7198(A1868)
A9 A1868;
{"
9D16I4"7185"
27D2I2"11"
12D2I2"12"
7D44I23"11:
if( A1868 == ' ' ) "
53D1I13"3;
goto A1714"
7D51I42"3:A1666( "&nbsp;" );
goto A1715;
A1714: if"
56D133I35"68 == '\n' ) goto A1716;
goto A1717"
139D39I22"6:A1666( "</tt>\n" );
"
47D14I2"20"
20D19I19"7: if( (A7184 <= 0)"
30D2I2"21"
12D2I2"22"
7D37I8"21:A1664"
42D28I6"68 );
"
36D14I2"23"
19D46I22"22: if( A1868 == '&' )"
56D26I3"5;
"
35D26I27"6;
A1725:A1666( "&amp;" );
"
35D25I28"7;
A1726: if( A1868 == '<' )"
34D39I4"66;
"
47D47I2"67"
52D44I39"66:A1666( "&lt;" );
goto A1768;
A1767: "
49D22I11"1868 == '>'"
33D2I2"69"
12D2I2"70"
7D27I39"69:A1666( "&gt;" );
goto A1771;
A1770: "
33D12I11"868 == '\"'"
23D2I2"72"
12D2I2"73"
7D26I32"72:A1666( "&quot;" );
goto A1774"
31D6I9"73: A1664"
11D34I4"68 )"
39D34I4"74: "
39D18I4"71: "
23D7I5"68: ;"
12D13I3"7: "
18D2I2"23"
9D28I15"20: ;
A1715: ;
"
36D14I2"75"
19D32I17"12: A1664( A1868 "
38D11I51"75: ;
}
Void
A7199(A1737)
A5794 A1737;
{
A2 A1868;
"
16D2I29":if( A1868 = *A1737++ ) goto "
7D127I38";
goto A1713;
A1712: A7198( (A9)(A15)("
132D33I4") );"
46I38"A1713: ;
}
Void
A7200()
{
if( A7185 ) "
9I12"1;
goto A171"
9D24I16"A1666( "<tt>" );"
31D37I97" ;
}
A53
A8733(A1737,A1730)
A5794 A1737;
A53 A1730;
{
if( A1504 && A1503 ) goto A1711;
goto A1712"
43D34I13"1:
if( *A1737"
45D1I1"3"
12D1I1"4"
7D3I96"5: A1737++;
goto A1711;
A1713:
switch( *A1737 )
{
case '\t':
A1717: A1730++; A7198(' '); 
A1720:"
9D78I11"730 % A1503"
90D2I9"7;
A1721:"
12D2I74"6;
case '\n':
case '\f':
A1730 = 0;
default:
A7198( (A9)(A15)(*A1737) );
}"
9D52I1" "
63D1I1"5"
7D15I5"4: ;
"
24D13I1"2"
18D39I20"12: A7199( A1737 );
"
44D13I24":
return A1730;
}
A4
A92"
19D24I49"83 )
A72 A1883;
{
A72 A1950;
if( A1883 > A1705 ) "
33D1I13"1;
goto A1712"
7D20I43"1:
if( A1883 > 10000 ) return (A4) 0;
A1950"
25D12I16"883 + 200;
A1706"
17D4I60"027( A1706, A1705, 1, A1950, (A4) 0 );
A1705 = A1950;
A1712:"
12D5I6"(A4) 1"
10D27I52"5794
A7880( A1829 )
A5794 A1829;
{
A9 A1833;
A7 A183"
34D18I35"A5794 A1835 = NULL;
A72 A1952 = 0;
"
23D2I38":
if( A1833 = (A9)(A15)( *A1829++ ) ) "
11I12"3;
goto A171"
7D25I44"3:
if( A1833 == '%' ) goto A1714;
goto A1715"
31D207I8"4:
A1833"
212D4I19"9)(A15)( *A1829++ )"
10D6I28"A1833 == 's' || A1833 == 'e'"
18D1I1"6"
12D1I1"7"
7D27I1"6"
34D20I21"1835 = A7881[A1834++]"
31D2I2"20"
12D2I2"21"
7D101I9"20:
{
A48"
106D5I36"4;
A72 A1883 = ((A72) strlen(A1835))"
11D96I23"A924(A1952 + A1883 + 2)"
107D2I2"22"
12D2I2"23"
7D2I2"22"
8D1I1"4"
6D47I16"706 + A1952;
if("
52D67I51"4 != A1835 ) goto A1725;
goto A1726;
A1725: strcpy("
72D55I19"4, A1835 );
A1726:
"
62D10I9"33 == 'e'"
21D2I2"27"
12D2I2"66"
7D2I2"27"
8D2I50"3 = ((A72) strlen( A5660(A1734) ));
A1766:
A1952 +"
8D36I21"3;
A1723: ;
}
A1721:
"
45D13I1"1"
19D23I3"7: "
29D6I27"5:
if( A924( A1952 + 2 ) ) "
14D2I14"67;
goto A1768"
7D13I33"67: A1706[A1952++] = (A2) (A1833)"
18D37I6"68: ;
"
46D13I1"1"
19D16I51"2:
A1706[A1952] = '\0';
return A1706;
}
A5794
A1689"
21D27I133"29, A1830, A1831, A1832, A1951 )
A5794 A1829, A1830, A1831, A1832, A1951;
{
A9 A1833;
A7 A1834 = 0;
A5794 A1835 = NULL;
A72 A1952 = 0"
32D48I40"11:
if( A1833 = (A9)(A15)( *A1829++ ) ) "
56D1I13"13;
goto A171"
7D38I2"13"
45D4I11"1833 == '%'"
15D2I2"14"
12D1I1"1"
7D64I38"14:
A1833 = (A9)(A15)( *A1829++ );
if("
69D43I11"3 == 's' ||"
49D30I32" == 'e' ) goto A1716;
goto A1717"
35D21I31"16:
switch( ++A1834 )
{
case 1:"
27D12
17D28I24"830; goto A1720;
case 2:"
33D26I3"5 ="
31D10I2"1;"
19D4I27"20;
case 3: A1835 = A1832; "
12D34I25"20;
case 4: A1835 = A1951"
44D14I23"20;
default: A865(285);"
19D10I10"5 = A1951;"
19D4I25"20;
}
A1720:
if( A1835 ) "
12D2I14"21;
goto A1722"
7D47I9"21:
{
A48"
52D6I65"4;
A72 A1883 = ((A72) strlen(A1835));
if( A924(A1952 + A1883 + 2)"
17D2I2"23"
12D2I2"25"
7D40I45"23:
A1734 = A1706 + A1952;
if( A1734 != A1835"
52D1I1"6"
12D1I1"7"
7D34I25"6: strcpy( A1734, A1835 )"
40D39I19"7:
if( A1833 == 'e'"
50D2I2"66"
12D2I2"67"
7D35I42"66:
A1883 = ((A72) strlen( A5660(A1734) ))"
40D11I18"67:
A1952 += A1883"
17D4I6"5: ;
}"
11D2
11D2I2"11"
10I9" ;
A1715:"
5D30I16"A924( A1952 + 2 "
43D1I1"8"
12D1I1"9"
7D74I41"8: A1706[A1952++] = (A2) (A1833);
A1769: "
84D2I2"11"
7D69I2"12"
74D14I147"06[A1952] = '\0';
return A1706;
}
A5794
A7263( A1757 )
A67 A1757;
{
A5794 A1841 = A868(A1757);
A57 A1824;
A5794 A1754;
A9 A1868;
A4 A2885 = (A4) 0;"
19D20I7"!A1841 "
30D1I1"1"
12D1I1"1"
7D22I61"11: A865(1245); return ""; 
A1712:
A1824 = A1649;
A1649 = A94"
27D70I5"668()"
75D25I3"13:"
30D25I25"A1868 = (A9)(A15)(*A1841)"
37D2I2"14"
12D2I2"15"
7D20I2"14"
29D17I78"68 == '%' && A1841[0] && A1841[1] &&
(islower(A1841[1]) || isupper(A1841[1])) "
27D2I2"16"
12D2I2"17"
7D11I55"16:
A2885 = (A4) 1;
A1841+=2;
A1868 = (A9)(A15)(*A1841)"
21D2I2"14"
7D58I15"17:
if( A2885 )"
67D11I2"20"
21D2I2"21"
7D38I34"20:
A1666("___");
A2885 = (A4) 0;
"
46D14I2"22"
19D24I9"21:
A1664"
29D19I24"68 );
++A1841;
A1722: ;
"
27D14I2"13"
19D23I14"15:A1664('\0')"
28D104I10"54 = A1669"
110D69I3"649"
74D4I36"824;
return A1754;
}
A9236
A9246()
{"
13D20I91"322 *A9257 = A511(3);
A82 A4351;
A4351 = A420.A338;
A1713:
if( A4351) goto A1711;
goto A171"
25D13I79"714: A4351 = A4351->A159.A158;
goto A1713;
A1711:
{
A9036 A1741 = A4351->A129;
"
18D212I26"A1741 || isdigit(A1741[0])"
224D1I1"5"
12D1I1"6"
7D44I1"5"
49D13I17"41 = (A9036) ""; "
18D5I25"6:A512( A9257,(A50) A5433"
10D7I12"41, 2 ) );
}"
17D12
19D2I40"2:
return A9245( A9257 );
}
A9236
A9245("
7D15I112"1 )
struct A322 *A1731;
{
A54 *A1748;
A54 *A1809;
A8 A1808;
A8 A1804;
A9236 A1732;
A54 A1730;
struct A322 *A9258"
20D17I61"48 = (A54 *) (A1731->A323);
A1808 = A1731->A324;
if( !A9255 )"
27D1I13"1;
goto A1712"
7D47I26"1: A9255 = A999( 10, (A41)"
52D291I7"
A1712:"
301D19I23", A1730 = ( A9255)->A99"
25D24I4"15:
"
40D2I2"30"
14D1I1"3"
12D1I1"4"
7D39I3"6: "
46I62";
goto A1715;
A1713:
A9258 = (struct A322 *) A9255->A988[A1732"
7D65I40"!A9258 || (A1731->A324 != A9258->A324) )"
75D1I41"6;
A1809 = (A54 *) A9258->A323;
A1804 = 0"
6D169I2"21"
175D6I13"A1804 < A1808"
17D1I1"7"
11D2I2"20"
7D2I2"22"
8D3I3"804"
13D2I2"21"
8D1I1"7"
7D22I31"A1748[A1804] != A1809[A1804] )
"
29D3I3"810"
13D2I2"22"
7D11I39"20:A517( A1731 );
return A1732;
A1810:
"
22D1I1"6"
7D50I21"4:
A1012 = (A49) A173"
55D23I14"005( A9255 );
"
32D6I63"9236) A1011;
}
A61
A5668()
{static A61 A1954 = 0;
if( !A1954 ) "
14D1I13"11;
goto A171"
7D52I26"11: A1954 = A1743( A1072 )"
57D74
86D9I133"1954;
}
Void
A5669()
{
A61 A1954 = A5668();
A931++;
( * ( ( *++ A932 == A1524 ) ? (A1521( (A1523 *)& A932 ), A932) : A932 ) = A1954 )"
14D12I35"4
A7752( A1730, A1758 )
A67 A1730;
"
20D55I25"758;
{
A4 A1809 = (A4) 0;"
60D6I7"!A1758 "
36D22I20"1: A1758 = "unnamed""
28D1I1"2"
7D18I20"A6002( A1730, A1758 "
31D1I1"3"
12D1I1"4"
7D22I17"3:
A1809 = (A4) 1"
28D3I89"4:(A5052 = NULL, A6001 = 0, A1678((A4) 0));
return A1809;
}
A53
A7879()
{
A53 A1730 = 0;
"
8D5I94"A7751.A7735 && (A1493) && (A1493)->A645 && (A1493)->A645->A636 & (A9070) 0x400000) && A7751.A7"
11D10
18D2I2"11"
12D2I2"12"
7D22I55"11:
A1730 = A1086 > 1 ? 4 * ((A53)A1086-1) : 0;
A1712:
"
33D23I126"0;
}
A5794
A7231(A7235)
A53 *A7235;
{
static A2 A2812[ 8 + 1 ]; A53 A1730 = 0; struct A640 *A1886; A68 A1882;
A2812[0] = '\0';"
28D17I13"A1886 = A1493"
28D2I2"11"
12D2I2"12"
7D17I49"11:
A1882 = A1886->A642; if( A1882 > A1886->A7688"
29D1I13"3;
goto A1714"
6D4I24"13: A1886->A7688 = A1882"
9D14I6"14: ; "
24D1I1"5"
9D31I8" A1882 ="
36D9I69"1715:
if( A7751.A7735 && A7751.A7736 ) goto A1716;
goto A1717;
A1716:"
14D67I7"0 = 8; "
73D14I3"882"
25D2I2"20"
12D2I2"21"
7D2I101"20: A7641( A2812, A976( (A6) (A1882) ), 8, 2 );
goto A1722;
A1721: A7642( A2812, 8 );
A1722: ; 
A1717"
8D45I5"A7235"
56D2I2"23"
12D1I1"2"
7D87I18"23: *A7235 = A1730"
93D2I78"5: return A2812; }
Void
A7753(A1835)
A48 A1835;
{
A48 A1748[20];
A48 A3557;
A6"
7D14I40"0;
A9 A1833;
A4 A3491 = (A4) 1;
int A173"
20D3I51"30 = A994( A1748, 19, A1835, 0 ); A3557 = A1748[0];"
8D9I53"!A3557 ) return; A1833 = (A9)(A15)(*A3557); if( A1833"
14D27I2"-'"
38D2I2"11"
12D2I2"12"
7D28I29"11: A3491 = (A4) 0; A3557++; "
36D2I2"13"
7D3I22"12: if( A1833 == '+' )"
13D1I13"4;
goto A1715"
6D26I29"14: A3491 = (A4) 1; A3557++; "
31D70I10"5:
A1713: "
76D13I6"730 =="
18D44
52D1I1"1"
12D1I1"1"
7D38I2"16"
45D6I24"strcmp( A3557, "number" "
11D24I1"0"
36D2I2"20"
12D2I2"21"
7D51I44"20: A7751.A7736 = A3491;
goto A1722;
A1721: "
56D7I24"strcmp( A3557, "indent" "
12D26I1"0"
38D2I2"23"
12D2I2"25"
7D23I24"23: A7751.A7737 = A3491;"
32D2I2"26"
7D19I11"25: A1418()"
24D1I10"26: ;
A172"
14D2I2"27"
7D4I4"17:
"
9D6I23"strcmp( A3557, "class" "
11D3I1"0"
15D2I2"66"
12D2I2"67"
7D11I22"66:
A7751.A7738 = A566"
17D9I93"48, ((0x001 | 0x002 | 0x004 | 0x008) | 0x010) );
goto A1768;
A1767: if( (strcmp( A3557, "dir""
15D91I5"0) ) "
99D2I14"69;
goto A1770"
7D38I21"69:
A1732 = 1;
A1773:"
43D81I20"A1835 = A1748[A1732]"
92D1I1"1"
12D1I1"2"
7D1I1"4"
7D1I1"2"
13D2I2"73"
8D25I57"1:
A668( A1835, 'd', A3491, &A7751.A7739,
&A7751.A7740 );"
34D2I11"74;
A1772: "
12D2I2"75"
7D29I4"70: "
34D52I25"strcmp( A3557, "h" ) == 0"
64D2I2"76"
12D2I2"77"
7D23I13"76:
A1732 = 1"
29D18I51"0:
if( A1835 = A1748[A1732]) goto A1778;
goto A1779"
24D5I17"1: A1732++;
goto "
10D2
8D3I68"8:
A668( A1835, 'h', A3491, &A7751.A7741,
&A7751.A7742 ); goto A1781"
9D3I15"9: ;
goto A1782"
9D14I37"7: if( (strcmp( A3557, "m" ) == 0) ) "
22D2I14"83;
goto A1784"
7D2I20"83:
A1732 = 1;
A1787"
8D92I20"A1835 = A1748[A1732]"
102D2I2"85"
12D2I2"86"
7D16I3"88:"
21D18I5"2++;
"
26D14I2"87"
19D14I57"85:
A668( A1835, 'm', A3491, &A7751.A7743,
&A7751.A7744 )"
24D2I2"88"
7D170I6"86: ;
"
177D15I3"889"
20D30I20"84: A1418();
A1889: "
35D23I4"82: "
28D48I59"75: ;
A1768: ;
A1727: ;
}
Void
A7754()
{
A57 A1871 = A1649;"
57D54I15"640 *A1886;
A53"
60D31I7";
A1886"
36D17I144"493; if( !(A7751.A7735 && (A1886) && (A1886)->A645 && (A1886)->A645->A636 & (A9070) 0x400000) || A1886->A642 == 0 || A1490[0] == '\0' )
return; "
23D2I8"886->A64"
9D3I59"886->A7688 ) return; A1649 = A1652; A7200(); if( A1377 == 4"
15D1I1"1"
12D1I1"2"
7D39I46"1: A7198( '\n' ); A1377 = 0; A7200(); 
A1712: "
44D4I18" = A7879();
A1715:"
11D104I9"732 > 0) "
113D1I13"3;
goto A1714"
7D2I281"6: A1732--;
goto A1715;
A1713: A7198( ' ' ); goto A1716;
A1714: A7199( A7231(NULL) ); ++A7184; A8733( A1490, 0 ); --A7184; A1649 = A1871; }
A4
A1955( A1956, A1957 )
A2 A1956, A1957;
{
static A2 A1945[2] = { 0, 0 };
static A2 A1958[2] = { 0, 0 };
A1945[0] = A1956;
A1958[0] = A1957;"
10D4I28"sys_fncmp( A1945, A1958 ) =="
10D99I4000"struct A849 *
A929(A1959,A1960)
struct A144 *A1959;
A5794 A1960;
{
A54 A1759;
A54 A1732 = 1;
struct A849 *A1961;
A1759 = A1959->A991;
A1711:if( A1732 <= A1759 ) goto A1712;
goto A1713;
A1712:
A1961 = (struct A849 *) A1959->A988[A1732++];
if( strcmp( A1960, A1961->A850 ) == 0 )
return (struct A849 *) A1961;
goto A1711;
A1713:
A1961 = (struct A849 *) A1005( A1959 );
A1961->A850 = A1076( A1344, A1960 );
return A1961;
}
A4
A5914( A5794 A1960 )
{
int A2008 = 0;
A5794 A1737;
A1737=A1960;
A1713:
if( *A1737) goto A1711;
goto A1712;
A1714: ++A1737;
goto A1713;
A1711:
if( (( *A1737 ) == '[') ) goto A1715;
goto A1716;
A1715: ++A2008;
goto A1717;
A1716: if( (( *A1737 ) == ']') ) goto A1720;
goto A1721;
A1720:
if( --A2008 < 0 ) return (A4) 0;
goto A1722;
A1721: if( (( *A1737 ) == '`') ) goto A1723;
goto A1725;
A1723:
if( !*++A1737 ) goto A1712;
A1725: ;
A1722: ;
A1717: ;
goto A1714;
A1712:
return A2008 == 0;
}
A5794
A5919( A5794 A1960 )
{
int A2008 = 0;
A5794 A1737;
A1737=A1960;
A1713:
if( *A1737) goto A1711;
goto A1712;
A1714: ++A1737;
goto A1713;
A1711:
if( (( *A1737 ) == '[') ) goto A1715;
goto A1716;
A1715: ++A2008;
goto A1717;
A1716: if( (( *A1737 ) == ']') ) goto A1720;
goto A1721;
A1720:
if( --A2008 < 0 ) return A1737+1;
goto A1722;
A1721: if( ((*A1737) == '`') ) goto A1723;
goto A1725;
A1723:
if( !*++A1737 ) goto A1712;
A1725: ;
A1722: ;
A1717: ;
goto A1714;
A1712:
return A1737;
}
A4 A927 = (A4) 0;
A861
A926( A1737, A1731 )
A5794 A1737;
A5794 A1731;
{
A2 A1962;
A861 A1841;
if( (strcmp( A1731, "**SH**" ) == 0) ) goto A1711;
goto A1712;
A1711:
if( A4442(A1737) ) return (A861) 1;
return (A861) (-1);
A1712:
if( A1962 = *A1731++ ) goto A1713;
goto A1714;
A1713:
if( ((A1962) == '*' || (char)(A1962) == aoc_star) ) goto A1715;
goto A1716;
A1715:
A1717:
if( ((*A1731) == '*' || (char)(*A1731) == aoc_star) ) goto A1721;
goto A1722;
A1721: A1731++;
goto A1723;
A1722: if( ((*A1731) == '[') && !((A1731[1]) == ']') ) goto A1725;
goto A1726;
A1725:
A1731 = A5919( A1731 );
goto A1727;
A1726: goto A1720;
A1727: ;
A1723: ;
goto A1717;
A1720:
if( !*A1731 ) return (A861) 1;
A1766:
A1841 = A926(A1737++,A1731);
if( A1841 == (A861) 1 ) return (A861) 1;
if( A1841 == (A861) (-1) ) goto A1767;
goto A1766;
A1767:
return (A861) 0;
goto A1768;
A1716: if( ((A1962) == '[') && ((*A1731) == ']') ) goto A1769;
goto A1770;
A1769:
if( !*A1737 || !A1737[1] ) return (A861) (-1);
if( ((*A1737) == '[') && ((A1737[1]) == ']') ) goto A1771;
goto A1772;
A1771: A1737+=2; A1731++; 
goto A1773;
A1772: return (A861) 0;
A1773: ;
goto A1774;
A1770: if( ((A1962) == '[') ) goto A1775;
goto A1776;
A1775:
if( A926( A1737, A1731 ) == (A861) 1 ) return (A861) 1;
{
A5794 A2555 = A5919( A1731 );
return A926( A1737, A2555 );
}
goto A1777;
A1776: if( ((A1962) == ']') ) goto A1778;
if( !*A1737 ) return (A861) (-1);
if( ((A1962) == '?' || (char)(A1962) == aoc_quest) ) goto A1779;
goto A1780;
A1779: A1737++;
goto A1781;
A1780:
if( ((A1962) == '`') ) goto A1782;
goto A1783;
A1782: A1962 = *A1731++;
A1783:
if( (A927 ? A1955( A1962, *A1737 ) : ( A1962)==( *A1737 )) ) goto A1784;
goto A1785;
A1784: A1737++;
goto A1786;
A1785: return (A861) 0;
A1786: ;
A1781: ;
A1778: ;
A1777: ;
A1774: ;
A1768: ;
goto A1712;
A1714:
if( *A1737 ) return (A861) 0;
return (A861) 1;
}
A4
A928(A1737)
A5794 A1737;
{
A1711:if( *A1737 ) goto A1712;
goto A1713;
A1712:
if( (strcmp( A1737, "[]" ) == 0) ) goto A1714;
goto A1715;
A1714: A1737 += 2; goto A1711;
A1715:
if( ((*A1737) == '*' || (char)(*A1737) == aoc_star) || ((*A1737) == '?' || (char)(*A1737) == aoc_quest) || ((*A1737) == '[') )
return (A4) 1;
if( ((*A1737) == '`') ) goto A1716;
goto A1717;
A1716: if( !*++A1737 ) goto A1713;
A1717:
A1737++;
goto A1711;
A1713:
return (A4) 0;
}
A4
A5995(A1959,A1741,A1963)
struct A144 *A1959;
A5794 A1741;
A5794 A1963;
{
A54 A1759;
A54 A1732 = 1;
struct A849 *A1961;
A1759 = A1959->A991;
A1711:if( A1732 <= A1759 ) goto A1712;
goto A1713;
A1712:
A1961 = (struct A849 *) A1959->A988[A1732++];
if( A1961 && A875( ((A48)( A1961->A851 )), A1963"
99I197" ) &&
A926( A1741, A1961->A850 ) == (A861) 1 )
return (A4) 1;
goto A1711;
A1713:
return (A4) 0;
}
/*  Obfuscation by "The C Shroud" 
    Gimpel Software -- Collegeville, PA, USA  (610) 584-4261 */
"
Fa3.c
209D4I7"7 A9235"
18D2I1"9"
12I16"A6 A10;
typedef "
291D20
27D4I8"32 A9069"
14I19"A9069 A24;
typedef "
10D4I2"25"
14D9I13"unsigned A890"
21D6I10"9069 A9150"
17D6I10"9069 A9070"
17D8I8"9070 A27"
18D12I9"A9070 A28"
22I21"A9070 A5793;
typedef "
10D4I2"29"
14D17
26D8I5"A6228"
19D6I8"9070 A30"
25D3I8"long A31"
13I17"A17 A32;
typedef "
11D1I1"3"
11D7I12"unsigned A34"
19D5I5"4 A35"
17D5I5"5 A36"
21D1I1"7"
17D1I1"8"
16D2I2"39"
18D1I1"0"
17D1I1"1"
17D1I1"2"
12D6I6"34 A43"
22D1I1"4"
17D1I1"5"
11D7I7"A42 A46"
17I17"int A47;
typedef "
342D2I4"9236"
17D4I2"63"
19D1I3"577"
18D1I1"4"
16D4I2"65"
20D2I2"19"
18D4I4"8258"
14I19"A54 A7616;
typedef "
138D6I3"A16"
60D13I3"A72"
122D6I5"A9069"
20D6I5"A9069"
1373I69"struct A9304
{
A17 A9305;
A5794 A9306;
};
extern struct A9304 A9307;
"
6D4I4"9308"
14D4I4"9309"
17D1I1"5"
11D4I4"5566"
14D4I4"5567"
14D3I17"7618();
Void A761"
8D13
19D3I17"5569();
Void A915"
8D9I10"Void A9152"
14D17I2"74"
22D1I15"0();
Void A7621"
10I41"6226();
A5794 A6227();
A81 A7622();
A58 A"
460D2I4"9070"
28D2I4"9070"
151I19"struct A114 A9153;
"
1389D2I2"92"
16D6I12"5794 A7637()"
15I16"A4 A202;
extern "
3337D2I4"9070"
159I11"A58 A9238; "
88D2I4"9070"
39D2I4"9070"
367I11"A17 A9071;
"
535I13"A9236 A9239;
"
1098D2I4"9070"
380D7I8"17 A9154"
24D1I1"1"
12D6I7"62 A442"
16I17"A4 A443 ;
extern "
150D3I4"9072"
14D10I9"Void A451"
22D9I9"5794 A452"
21D9I9"9036 A453"
29D1I1"4"
13D12
20D1I1"5"
12D9I22"A315 A456 ;
A5794 A457"
28D1I1"8"
18D4I3"459"
21D3I4"5268"
14D16
24D1I1"0"
12I16"A4 A461;
extern "
8D1I1"2"
12D8I11"Void A463()"
22D4I3"464"
13I18"A58 A8823;
extern "
1037D7I10"Void A9155"
18D9I7"A4 A504"
20I20"Void A505();
extern "
1042D2I4"9070"
1940D8I19"struct A640 * A9310"
24D4I3"663"
15D10I9"A48 A7505"
29D2I2"37"
19D3I4"7176"
14D7I9"Void A664"
22D4I3"665"
16D8I7"4 A4442"
19D6I6"A17 A5"
27D3I2"66"
21D2I3"031"
21D1I1"7"
20D1I1"8"
12I20"Void A669();
extern "
278D3I4"4476"
14D10I17"struct A640 *A675"
27D4I4"7719"
21D4I4"8914"
15D8I12"Void A7720()"
18D7I7"17 A933"
18D8I7"7 A5254"
18D2I2"81"
7D1I1"0"
11D2I2"17"
7D1I1"1"
11D1I2"35"
6D1I1"2"
11D1I2"92"
6D1I1"3"
11D2I1"7"
7D1I1"4"
11D8I7"4 A2145"
18D1I2"68"
6D1I1"6"
13D14I6"*A2147"
24D8I7"4 A2148"
18D7I16"2 A2149[M_TOKEN]"
17D2I2"87"
7D1I1"0"
11D2I1"4"
7D1I1"1"
15D4I4"2152"
14D2I2"36"
7D1I1"3"
11D27I7"35 A826"
38D1I2"17"
6D3I1"4"
13D10I28"7
A2155,
A2156,
A2157,
A6214"
19D4I2"A9"
9D1I1"8"
12D10I9"A17 A8825"
27D3I3"215"
15D3I4"Void"
8D1I1"0"
18D4I4"8209"
23D1I1"1"
12D3I4"Void"
8D1I1"2"
12D10I9"A35 A2163"
29D1I1"4"
12D5I4"Void"
10D1I1"0"
12D9I8"A35 A216"
22D7I10"9036 A8211"
24D4I4"5255"
15D4I2"A4"
9D11I16"6();
extern Void"
16I37"7();
extern Void A2168();
struct A216"
465I42"struct A9073
{
A48 A9074;
A9069 A9075;
};
"
422D6I7"8 A9076"
17D9I8"A42 A982"
20D8I9"long A983"
24D4I3"984"
16D8I8"87 A6039"
20D8I8"61 A7724"
19D9I9"A92 A7260"
20D8I9"long A985"
24D4I3"986"
16D9I8"34 A5670"
20I21"A5794 A987();
extern "
1045I7"9129,
A"
44D4I4"9156"
11I42"9157,
A9158,
A9159,
A9160,
A9161,
A8639,
A"
21D10I2"91"
15D2I2"91"
7I29"9164,
A6176, 
A7062,
A7063,
A"
91I21"9240,
A9241,
A9130,
A"
21I28"9165,
A9166,
A9167,
A9168,
A"
28I14"9292,
A9169,
A"
92I42"9242,
A9243,
A9131,
A9132,
A9133,
A9134,
A"
71I7"9170,
A"
307D4I4"9171"
21I42"9244();
extern Void A8266();
extern Void A"
8I80"extern Void A9172();
extern A4 A9173();
extern A4 A9174();
extern Void A9175();
"
746D9I7"4 A9176"
21D7I9"5794 A868"
19D6I6"7 A598"
25D1I1"0"
19D1I1"1"
13D10I7"61 A872"
22D7I10"5794 A6037"
19D10I7"61 A873"
22D7I10"5794 A8589"
20D5I6"8 A874"
16D9I7"A4 A875"
28D1I1"6"
20D1I1"7"
20D1I1"8"
19D2I2"79"
19D4I3"880"
21D4I4"6172"
21D3I4"9293"
20D4I4"9177"
21D4I4"8787"
23D1I1"1"
20D1I2"29"
18D4I4"7262"
23D1I1"2"
20D1I1"3"
20D2I2"48"
21D1I1"4"
20D1I1"5"
18D3I4"5667"
22D1I1"6"
19D2I2"87"
20D2I2"88"
20D2I2"89"
19D4I3"890"
21D4I3"891"
21D4I3"892"
21D4I4"7745"
24D1I1"6"
21D1I1"7"
20I1"4"
18D3I4"7748"
20D4I4"7749"
21D4I3"893"
23D1I1"4"
18D4I4"1857"
22D3I3"958"
22D1I1"5"
19D3I3"061"
20D3I4"5821"
20D4I3"896"
21D3I4"7507"
20D4I3"897"
21D4I4"5981"
23D1I1"8"
19D3I3"750"
20D3I4"8212"
20D3I3"899"
20D3I4"7177"
22D1I1"0"
18D4I3"901"
23D1I1"2"
20D1I1"3"
18D3I4"8944"
22D1I1"4"
18D4I3"905"
21D3I3"907"
21D4I4"9078"
23D1I1"7"
18D3I4"5077"
20D3I4"8267"
20D3I4"8830"
14D7I9"Void A908"
25D2I2"09"
13D9I9"Void A910"
28D1I1"1"
12D9I7"A4 A912"
20D16
24D1I1"3"
14D8I7"4 A5431"
19D11I9"Void A914"
22D10I9"Void A915"
22D11I6"7 A916"
27D2I2"17"
13D9I10"A5794 A918"
27D3I4"1739"
15D6I9"5794 A919"
24D4I3"920"
15D9I9"Void A921"
26D4I3"922"
15D20I14"A5794 A923();
"
31D4I3"924"
16D7I10"5794 A7263"
19D8I8"61 A5668"
19D7I12"Void A5669()"
16D18
26D13I12"7734 A7751; "
21D7I7"4 A7752"
18D18I10"A4 A5914()"
28D6I10"861 A926()"
16D8I6"4 A927"
18D6I8"4 A928()"
15D9I19"struct A849 *A929()"
19D6I9"61 A930()"
16D8I12"9236 A9245()"
18D6I12"9236 A9246()"
15D9I12"Void A9247()"
18D7I18"struct A144 *A5050"
17D8I6"7 A931"
18D6I8"61 *A932"
16D8I6"7 A933"
21D7I7"*A934;
"
14D18I7"A7 A935"
28D7I8"61 *A936"
16D18I7"A7 A937"
27D18I9"A61 *A938"
27D18I7"A7 A939"
28D9I8"61 *A940"
19D9I6"7 A941"
19D9I8"61 *A942"
19D12I10"61 A6038; "
19D11I18"struct A144 *A1696"
23D8I5" A943"
18D10I7"7 A9294"
19D11I18"struct A144 *A7178"
20D17
26D7I8"44 *A717"
17D7I18"struct A144 *A5432"
17D6I9"5794 A944"
15D17I10"A5794 A945"
26D20I12"A5794 A946;
"
27D4I5"A5794"
9D3I1"4"
19D6I4"7180"
15D12I11"A5794 A7227"
21D12I11"A5794 A7181"
22D7I10"5794 A5510"
17D8I7"68 A948"
17D18
26D10I9"114 *A949"
20D7I6"7 A950"
17D7I6"4 A951"
16D10I17"struct A114 *A952"
19D13I20"struct A144 *A7265; "
27D3I3"266"
15D7I10"5794 A1689"
24D4I4"7753"
15D18I10"Void A7754"
30D10I7"6 A1022"
20D10I8"81 A5511"
19D12I9"A81 A8770"
21D12I18"struct A561 *A1023"
21D12I8"A4 A1024"
22D10I7"7 A1025"
19D18I8"A4 A1026"
29D18I9"A49 A1027"
29D10I9"Void A775"
22D10I8"A4 A1028"
27D15I8"1029();
"
21D4I31"9079();
A48 A9080();
Void A9081"
15D21
38D1I1"0"
13D7I8"17 A1031"
18D18I9"A79 A1032"
35D4I4"5671"
15D8I10"Void A5672"
19D9I10"Void A8401"
21D8I8"17 A5512"
19D10I18"struct A561 *A1033"
21D9I10"Void A9135"
20D9I18"struct A561 *A1034"
21D7I10"5794 A1035"
18D47I10"Void A2317"
58D9I10"Void A5673"
20D9I10"Void A1036"
20D9I10"Void A1037"
20D11I18"struct A561 *A1038"
22D8I6"A4 A56"
21D9I18"struct A561 *A1039"
20D11I10"Void A7182"
22D18I10"A4 A7183()"
27D10I9"A58 A8268"
22D7I28"78 A1040();
extern Void A775"
12D6I49"extern A81 A1041();
extern A81 A7508();
extern A4"
11D3I49"7();
extern A5794 A8590();
struct A7758 *A7759();"
12D51I3"0()"
60D18I11"A78 A1042()"
28D8I10"78 A5271()"
18D8I10"78 A1043()"
18D8I12"5972 A1044()"
17D9I12"Void A2274()"
18D17I42"A54 A5433();
extern A9036 A9039();
extern "
26D106I9"44 *A5434"
116D7I12"9150 A9178()"
16D13I32"Void A7761();
extern A48 A7906()"
23D31I63"7758
{
A40 A7762;
A87 A7763, A7764;
A17 A7765, A7766;
A67 A7767"
43D21
29D11I10"7758 A7768"
20D79I9"A87 A7769"
88D12I9"A87 A7770"
21D12I9"A88 A7771"
21D12I9"A10 A7772"
21D43I17"const A88 A7773;
"
52D19I43"045
{
A18 A1046;
A72 A1047;
A7470 A1048;
A3"
24D2I58"49;
};
struct A1050
{
A18 A1051;
A17 A1052;
A5794 A1053;
}"
12D7I7"7 A3140"
17D34I14"81 A3143[20];
"
43D9I33"054
{
A54 A1055;
A55 A1056[25];
}"
19D8I9"55 *A3164"
19D11I19"struct A1054 *A7509"
20D78
86D209I12"144 *A7774;
"
217D10I51"7500
{
struct A7500 *A7775; A54 A7510; A42 A7511; }"
19D9I12"Void A1057()"
18D8I12"Void A1058()"
17D9I10"Void A1059"
20D8I10"Void A1060"
19D10I11"A5794 A1061"
21D22I18"struct A118 *A1062"
33D13I8" A1063;
"
20D13I8"A4 A7267"
26D4I4"7776"
14D10I8"63 A7777"
19D21
29D3I3"114"
8D2I2"64"
11I40"A81 A7512();
extern A49 A1073();
extern "
8D2I66"74();
extern A72 A1075[];
extern A9036 A1076();
extern A9036 A7778"
14D94I118"3097
{
A70 A3098; A72 A3099; A7468 A3100; A7468 A3101; A72 A3102; A72 A3103; A72 A3104; A7 A3105; A4 A3106; A7 A5282; "
100D5I85"283; A32 A5284; A74 A5966; A17 A6270; };
extern A81 A3107;
extern A315 A3108;
extern "
13D55I62"3097 A3109;
extern A58 A3110;
extern A4 A6067;
extern A72 A311"
60D10I14"extern A6 A311"
15D45
52D11I14"Void A1077();
"
19D7I21"48 strcat(), strcpy()"
17D9I14"48 strncpy(); "
16D11I13"int strncmp()"
24D4I4"1078"
15D8I7"2 A7268"
27D2I2"79"
13D12I18"struct A553 *A1080"
21I17"A7 A9295;
extern "
6D67I3"108"
72I66"struct A553
{
struct A553 *A1082;
A7 A1083;
struct A114 A1084;
};
"
15D81I1"8"
86D75I59"struct A5513
{
A81 A5514;
struct A147 *A5515;
};
A5972 A777"
80D39I10"A5972 A778"
44D17I10"A5972 A778"
22D16I10"A5972 A778"
21D16I10"A5972 A778"
21D16I10"A5972 A778"
21I15"A5972 A7785();
"
7D14I11"A74 A6242; "
21D12I8"A7 A1086"
21D12I8"A7 A7184"
21D12I11"A5794 A5248"
25D6I4"7185"
15D10I10"A95 *A1087"
27D4I4"1088"
21D4I4"1089"
21D4I4"7186"
21D3I3"109"
21D4I4"7187"
15D10I11"A5794 A1091"
21D9I10"Void A1092"
27D3I3"093"
20D4I4"8269"
20D3I3"094"
14D10I8"A4 A1095"
21D10I8"A4 A1096"
28D3I3"097"
20D4I4"1098"
16D10I7"4 A1099"
21D10I11"A94 * A5272"
21D9I10"A94 * A110"
21D10I11"A94 * A1101"
29D2I2"02"
19D4I4"1103"
15D11I10"Void A1104"
30D2I2"05"
21D2I2"06"
19D4I4"5675"
21D4I4"6243"
15D10I8"A4 A5518"
27D4I4"7786"
21D4I4"5516"
21D4I4"5517"
21D4I4"5519"
22D3I3"520"
14D18I12"Void A5521()"
27D17
23D4I4"5522"
15D10I9"A23 A7787"
21D8I10"Void A1107"
19D10I10"Void A1108"
22D10I7"4 A1109"
21D11I10"Void A1110"
22D11I10"Void A1111"
22D11I10"Void A1112"
22I21"Void A2942();
extern "
7D4I4"1113"
15D55I12"Void A2949()"
64D13I12"Void A7070()"
22D9I12"Void A1114()"
18D10I12"Void A1115()"
19D9I12"Void A7269()"
19D8I12"94 * A1116()"
17D9I12"Void A1117()"
18D18I12"Void A1118()"
27D18I12"Void A1119()"
27D26I12"Void A7788()"
35D8I12"Void A5676()"
17D18
26D2I2"20"
21D2I2"21"
21D2I2"22"
13D9I10"Void A8270"
26D4I4"5249"
15D10I18"struct A144 *A5523"
19I17"A7 A5822;
extern "
6D4I4"7789"
21D4I4"7790"
19D4I4"7791"
15D10I10"A94 *A7792"
21D10I11"A5794 A7793"
22D7I10"5794 A7794"
19D7I10"5794 A7795"
18D10I11"A5794 A7796"
22D8I10"5794 A7797"
20D2I4"5794"
7D3I45"8();
struct A5304 { A77 A3049; A5794 A1148; }"
12D12I13"A2 A1123[100]"
21D12I9"A17 A1124"
21D12I10"A13 *A1125"
21D12I9"A81 A1126"
23D9I7"8 A1127"
19D1I1"5"
6D4I2"28"
13D11I18"struct A144 *A1129"
20D11I18"struct A144 *A1130"
20D11I26"const struct A5304 A3050[]"
21D10I7"4 A1131"
20D17I8"38 A1132"
26D45I9"Void A113"
65D1I1"3"
21D1I1"3"
13D9I8"A17 A113"
29D1I1"3"
13D10I8"A4 A2979"
29D1I1"3"
19D3I3"917"
23D2I2"39"
13I19"A4 A1140();
extern "
8D1I1"4"
6D124I231"extern Void A5529();
extern A4 A5530();
extern A7 A5532();
extern Void A5533();
extern A66 A5534();
extern A66 A7799();
extern Void A5531();
extern Void A1142();
extern Void A1143();
extern Void A1144();
extern A50 A1145();
extern "
131D339I15"46();
extern A7"
344D13I118"47();
extern A48 A1148();
extern A48 A1149();
extern A77 A1150();
extern A58 *A5067, *A5068;
extern A17 *A8945, *A8946"
22D4I6"8271()"
15D5I193"53();
extern Void A1154();
extern Void A1155();
extern Void A1156();
extern Void A1157();
extern Void A5823();
extern Void A1158();
extern Void A1159();
extern Void A1160();
extern Void A1161()"
15D4I4"8402"
15D19
25D4I75"8403; A54 A8404; A13 *A8405; A7468 A8406; A72 A8407; A58 *A8408;
A58 *A8409"
19D52I1"6"
57D1I1"7"
6D56I4"63;
"
61D10I229"
A7132,
A7133,
A1164,
A1165,
A1166,
A1167,
A1168,
A1169,
A1170,
A1171,
A1172,
A1173;
A13 A1174[ (2000 / CHARLEN) ];
A18 A5435;
A17 A6040;
A13 A7800[ (2000 / CHARLEN) ];
A61 A6041;
A17 A6042;
} ;
extern A13 A9180[(2000 / CHARLEN)]"
20D4I4"9248"
14D88I6"9249; "
95D17I17"9296; A17 A9250; "
24D6I6"9251; "
13D6I19"9297; FILE *A9252; "
16D9I18"struct A9248 A9253"
18D127I14"Void A9254();
"
135D27I104"391
{
struct A633 *A1175;
struct A144 *A1176;
struct A144 *A1177;
struct A144 *A1178;
};
struct A1179
{
"
32D262I91"180;
A53 A1181;
A17 A1182;
A53 A1183;
A5794 A1184;
A5794 A1185;
};
struct A1186
{
struct A8"
267D31I5"187;
"
40D27
33D12I8"188;
};
"
21D18I6"189
{
"
26D71I105"640 *A1190;
A5794 A1191;
};
struct A1192
{
A17 A1193;
A9 A1194;
A70 A1195;
};
struct A1196 { A2 A1197[3];"
77I833" *A1198; };
struct A1199
{
A5794 A1200;
A35 A1201;
A42 A1202;
};
Void A1203();
Void A1204();
Void A1205();
struct A5677
{
A5794 A5678;
A42 A5679;
A5794 A5680;
A5794 A5681;
};
extern A17 A6244;
extern long A7418;
extern A49 *A1206;
extern A49 *A1207;
extern A2 A1208[ARG_LEN];
extern A42 A8197; extern A2 A3496[ARG_LEN];
extern struct A1196 A1209[];
extern const A6 A1210;
extern A7 A5406;
extern A7 A5407;
extern A7 A6210;
extern A42 A1211;
extern A4 A1212;
extern A72 A1213;
extern A72 A1214;
extern A18 A1215;
extern A18 A1216;
extern A4 A7228;
extern A61 A1217;
extern A61 A1218;
extern A67 A1219;
extern A13 *A6043;
extern A13 *A1220;
extern A13 *A1221;
extern struct A1162 A1222;
extern struct A144 *A1223;
extern struct A144 *A1224;
extern struct A144 *A1225;
extern A48 A1226;
extern A7 A1227;
extern A9070 A1228;
extern UFLAG"
1095I7"9298,
A"
2534D19
33D4I4"9255"
14D7I9"2 A7190[]"
16D8I18"struct A144 *A1398"
21D4I4"1399"
14D8I7"4 A7807"
18D7I6"7 A621"
21D7I6"9181; "
15I1"1"
6D1I1"0"
11D1I2"68"
6D1I1"1"
11D1I1"4"
6D1I2"2 "
11D1I1"7"
6D1I1"3"
10D4I2"A7"
9D3I1"4"
12D4I2"A7"
9D3I1"5"
12D4I2"A4"
9D3I1"6"
12D9I10"Void A1407"
20D9I10"Void A1408"
26D4I4"1409"
17D6I7"8 A1410"
17D10I9"A58 A1411"
21D8I10"Void A8257"
19D10I8"A4 A8411"
27D4I4"5063"
15D4I2"A6"
9D1I1"2"
12D2I4"Void"
7D1I1"3"
18D4I4"1414"
21D4I4"1415"
15D10I8"A4 A1416"
21D19I10"Void A5687"
36D4I4"5688"
15D10I10"Void A5689"
21D10I19"struct A5677 *A5690"
30D1I1"7"
12D10I10"A13 *A5396"
21D10I9"Void A141"
28D4I4"1419"
21D4I4"6052"
15D10I11"A5794 A7808"
30D1I1"4"
18D4I4"5545"
21D4I4"5546"
15D8I10"Void A5547"
19D2I4"Void"
7D1I1"0"
12D2I4"Void"
7D25I1"1"
36D9I7"A4 A624"
21D9I9"A48 A9182"
20D9I8"A4 A1422"
20D4I2"A4"
9D12I5"3();
"
26D5I6" A1424"
16D10I12"Void A3500()"
19D8I10"Void A1425"
19D8I9"int A3493"
19D10I9"int A3494"
27D4I4"1426"
15D10I19"struct A1189 *A1427"
21D12I10"A13 *A8273"
22D7I6"4 A599"
19D9I7"A4 A599"
21D8I10"Void A9311"
27D2I2"28"
13D12I10"Void A7191"
31D2I2"29"
13D8I10"Void A6080"
25D4I4"9183"
15D10I9"A54 A1430"
21D1I1"V"
6D4I4"1431"
15D10I8"A4 A7475"
30D1I1"2"
12D9I12"UFLAG *A1433"
29D1I1"4"
12D10I8"A4 A1435"
29D2I2"36"
13D1I1"v"
6D4I4"6246"
15D1I1"v"
6D4I4"7809"
21D4I4"1437"
23D2I2"38"
14D10I10"34 A5691()"
19D20
28D2I2"39"
19D4I4"1440"
15D10I12"Void A1441()"
19D17
26D1I1"2"
21D1I1"3"
12D11I10"Void A5773"
30D2I2"44"
13D12I11"A5794 A1445"
21I20"A5794 A1446;
extern "
6D4I4"1447"
21D4I4"3532"
15D12I10"A2 A3526[]"
21I17"A4 A3527;
extern "
6D2I2"14"
21D4I4"1449"
15D10I11"A5794 A1450"
30D1I1"1"
18D4I4"1452"
15D10I8"A4 A9184"
27D4I4"5274"
21D73I6"1453()"
82D19I12"Void A5651()"
28D20I12"Void A5548()"
29D20
26D4I130"3443();
extern Void A6072();
extern Void A1454();
extern Void A3363();
extern Void A1455();
extern Void A1456();
extern Void A5107"
17D89I65"065
{
A67 A1066;
A5794 A1067;
A5794 *A1068;
A17 A1069;
};
extern "
97D44I20"1065 *A1070;
extern "
52D40I53"1065 A1071[];
extern A67 A1072[];
extern Void A6209()"
53D12I85"
{
A79 A547;
A79 A548;
A79 A549;
A79 A6232;
A79 A5661;
A87 A6233;
A87 A5662;
A23 A552"
23D16I24"53 *A554, *A555, *A6234,"
21D1I12"63, *A557;
}"
11D29I14"93
{
A17 A8274"
34D35I21"98 A8275;
A8198 A8276"
50D44I10"8277[1];
}"
54D41I6"561
{
"
56D4I165"62;
struct A561 *A563;
A40 A564;
A40 A565;
A81 A566;
A58 A567;
A42 A568;
A68 A569;
struct A147 A570;
A17 A571;
A24 A572;
A61 A573;
A96 *A574;
struct A1537 * A7443;
}"
13D11I8"A81 A575"
20D9I17"struct A561 *A576"
28D1I1"7"
18D2I1"5"
22D2I2"79"
19D3I4"8278"
22D1I1"0"
20D1I1"1"
19D3I2"82"
22D9I1"3"
20D7I10"Void A5664"
18D19
27I65"4(), A585();
extern A4 A586();
extern A4 A5665();
extern Void A58"
1854I50"9136
{
struct A9136 *A9137; A17 A9138; };
struct A"
109D9I19"struct A9136 *A9139"
18D18
26D9I10"9136 A9140"
19D9I8"58 A7273"
18D4I3"A17"
9D3I1"4"
12D11I17"struct A588 A1719"
20D4I2"A2"
9D3I3"6[]"
20D2I2"77"
13D10I9"A89 A1978"
29D2I2"79"
19D4I4"1980"
21D4I4"7274"
24D1I1"1"
13D8I7"4 A9185"
19D18I8"A4 A9186"
35D4I4"5897"
24D1I1"2"
12D3I4"Void"
8D1I1"3"
12D10I9"A72 A1984"
21D10I18"struct A561 *A1985"
27D3I3"914"
23D2I2"86"
21D2I2"87"
13D27
33D26I4"9142"
37D10I9"A78 A1988"
27D4I4"1990"
21D4I4"1989"
21D4I4"1991"
15D8I10"Void A1992"
25D4I4"1993"
15I27"struct A144 *A7824; extern "
6D4I26"5553();
struct A147 *A7825"
23D2I2"26"
19D4I4"7827"
21D64I6"7828()"
73D8I10"Void A7829"
20D7I7"4 A7830"
18D9I12"Void A8412()"
18D9I12"Void A7831()"
18D9I12"Void A7832()"
18D19I12"Void A8413()"
28I14"Void A8414();
"
8D20I7"1457
{
"
26D12I4"58;
"
18D3I25"59;
A4 A1460;
A9 A1461;
}"
12D19I10"A9 A1461()"
28D18I10"A9 A1462()"
28D1I1"9"
6D1I1"3"
11D19I8"A4 A1464"
30D9I7"4 A1465"
19D20
28D11I10"83 **A5078"
21D9I18"struct A83 **A5079"
25D2I2"66"
13D9I7"4 A1467"
19D3I11"struct A144"
8D2I2"68"
12D11I18"struct A144 *A7476"
21D9I7"4 A1469"
19D10I19"struct A640 **A3651"
20D9I18"struct A640 **A365"
21D8I9"17 *A1470"
19D8I9"68 *A1471"
26D13I14"640 **A1472 ;
"
22D7I7"3 A1473"
18D11I7"4 A1474"
22D7I9"13 *A1475"
18D7I9"13 *A1476"
18D7I9"13 *A1477"
18D4I2"53"
9D2I2"78"
13D2I2"68"
7D2I2"79"
12D9I3"A17"
15D1I1"0"
12D1I2"57"
6D1I1"1"
11I19"A57 A3660 ;
extern "
17D3I4"5 ; "
11D10I8"57 A1482"
22D6I10"036 *A1483"
17D10I7"4 A1484"
20D18I8"A4 A8214"
29D8I7"4 A1485"
19D7I11"9036 *A1486"
18D7I9"81 *A1487"
17D8I16"const A81 *A1488"
19D7I7"6 A1489"
25D11I10"144 *A7276"
21D4I4"9036"
9D1I1"0"
11D17I8"A9 A1491"
27I21"A9036 A1492 ;
extern "
8D9I10"640 *A1493"
19D17I9"A63 A1494"
27D17I8"A4 A1495"
28D8I7"4 A1496"
22D4I4"5825"
18D4I5"1497 "
21D8I9"640 *A149"
19D12I12"A5794 A1499 "
21D12I18"struct A83 *A1500 "
21D10I18"struct A83 *A1501 "
19D13I18"struct A83 *A1502 "
22D10I18"struct A83 *A5080 "
20D9I9"53 A1503 "
18D12I9"A4 A1504 "
21D12I8"A4 A6247"
21I27"struct A83 *A6248 ;
extern "
6D4I4"9040"
23D2I2"05"
14D7I7"4 A1506"
18D10I11"A5794 A1507"
21D9I10"Void A7451"
20D10I8"A4 A7833"
22D8I7"4 A6249"
25D4I4"6250"
23D2I2"08"
13D8I10"Void A1509"
28D1I1"0"
12D4I2"A6"
9D1I1"1"
21D1I1"2"
12D10I9"A68 A1513"
21D7I9"Void A151"
20I203"81 A5692();
extern Void A8215();
extern Void A1515();
extern A4 A1516();
extern Void A1517();
extern Void A1518();
extern Void A1519();
extern Void A1520();
extern A4 A3738();
extern A4 A7834();
extern A"
561D1I1" "
11D1I1" "
11D1I1" "
10D1I1" "
10D1I1" "
10D1I1" "
848D4I4"9082"
15D19I10"Void A9083"
30D19I10"Void A9084"
30I21"Void A3863();
extern "
17D2I2"89"
13D10I19"struct A1537 *A1590"
21D10I19"struct A1537 *A1591"
27D2I2"71"
21D4I4"1592"
21D4I4"1593"
15D9I10"Void A7841"
29D1I1"2"
12D4I3"A74"
9D1I1"7"
18D4I4"7843"
21D4I4"8218"
15D9I10"Void A8219"
29D1I1"5"
13I1"7"
6D1I1"6"
12D3I4"Void"
8D1I1"7"
12D10I8"A4 A7848"
21D10I9"A74 A7849"
21D1I1"V"
8D24I4"94()"
33D9I4"void"
14D1I3"1()"
10D4I4"void"
9D9I17"2();
typedef A22*"
14I57"3;
extern const A51 A1524;
extern long A1525;
struct A152"
1445D10I8"A4 A9085"
27D4I4"3763"
15D9I10"Void A8835"
21D2I2"35"
7D1I3"4()"
10D11I3"A58"
16D1I1"5"
10D2I11"struct A147"
7D3I1"6"
12I19"A4 A3767();
extern "
2788D2I4"9070"
433D8I10"Void A9086"
19D9I9"A74 A9087"
28D1I1"6"
12D8I9"Void A737"
19D9I8"A4 A4551"
20D9I9"Void A738"
25D3I4"4724"
14D10I8"A58 A741"
29D1I2"77"
20D1I1"3"
18D4I3"744"
15I21"Void A8202();
extern "
1326D1I1" "
15D1I1" "
11D1I1" "
2390D2I4"9070"
215D2I4"9070"
12D1I2"72"
52D4I4"9088"
2817I6"(A72) "
600D3I3"A72"
12I7"((A72) "
22I1")"
1234D3I13"(size_t)( 7 )"
4204I6"(A72) "
1190I7"((A72) "
13I1")"
1242D2I4"9070"
245I7"((A72) "
13I1")"
9245D1I7"1000000"
17804D1I3"470"
13D1I3"470"
248I1"2"
223I7"((A72) "
13I1")"
41I1" "
863D34I31"9076(A2086, A2026, A2006)
A9069"
39D10I44"6;
struct A9073 *A2026;
A7470 A2006;
{
A7470"
15D1I1"2"
7D27I2"2="
34D40I2"3:"
46D10I10"1732<A2006"
21D1I1"1"
12D1I1"2"
11D11I6"1732++"
22D1I1"3"
7D2I28"1:
if( A2026[A1732].A9075 =="
7D13I41"6 )
return A2026[A1732].A9074;
goto A1714"
19D26I26"2:
return "";
}
A48
A6238("
31D2I5")
A88"
8D19I28";
{
static A2 A2080[25];
A48"
24D17
23D10
15D8I15"A2080+(25-1);
*"
16D29I34"0;
A1711: {
A9 A2088;
A2088 = (A9)"
35D24I11" % 16);
if("
29D16I31"8 < 10 ) goto A1714;
goto A1715"
21D4I3"14:"
9D20I20"8 += '0';
goto A1716"
26D1I27"5: A2088 += 'A' - 10;
A1716"
19D7I7"A2088;
"
13D7I2"= "
13D1I18"/ 16;
} 
A1712:if("
8D4I16"> 0 ) goto A1711"
10D5I41"3:
*--A1731 = 'x';
*--A1731 = '0';
return"
10D38
44D8I37"48
A979(A1730)
A18 A1730;
{
static A2"
13D7I25"0[25];
A48 A1731;
A1731 ="
12D5I91"0+(25-1);
*A1731 = 0;
A1711:
*--A1731 = (A2) ('0' + A1730 % 10);
A1730 = A1730 / 10;
A1712:"
10D6I30"1730 > 0 ) goto A1711;
A1713:
"
13D14I18"A1731;
}
A92
A980("
20D2I27" )
A88 A2089;
{
if( A230 ) "
16D6I8"UNLONG) "
11I27";
return (A92) (A87) (A2089"
4388I6"(A72) "
1433D8I5"if( !"
13D27I25" ) goto A1711;
goto A1712"
32D6I12"11:
return 0"
12D16I3"2:
"
21D24I35" = A2091->A991;
A2092 = A2091->A988"
29D6I19"32 = 1;
A1715:
if( "
11D2I11" <= A1759) "
14D26I21"goto A1714;
A1716: ++"
31D18I2";
"
27D1I1"5"
7D3I31"3:
if( A1806 == A2092[A1732] ) "
10I33"A1732; goto A1716;
A1714:
return "
408D3I14"A41 A3936;
A49"
8I32"1;
struct A9056 *A1809;
if( A173"
202I8"1731 = A"
50I8"3936 = A"
43D35I47"
if( A3936 == (A41) 53 ) goto A1723;
goto A1725"
41D22I79"3:
A1809 = (struct A9056 *) A1731;
A1671( A1809->A9058, (A72) ( A1809->A9057 ))"
28D22I17"5:
A1074( A1731, "
32D12I11"2 );
A1722:"
17I47"2[A1732] = NULL;
A1720: goto A1716;
A1714:
A209"
6D4I6"0 = --"
11D12
17D1I8"->A991 ="
6I26"0;
}
A4
A2104( A2091, A173"
1383I6"(A72) "
44I6"(A72) "
Fa4.c
209D4I7"7 A9235"
18D2I1"9"
12I16"A6 A10;
typedef "
291D20
27D4I8"32 A9069"
14I19"A9069 A24;
typedef "
10D4I2"25"
14D9I13"unsigned A890"
21D6I10"9069 A9150"
17D6I10"9069 A9070"
17D8I8"9070 A27"
18D12I9"A9070 A28"
22I21"A9070 A5793;
typedef "
10D4I2"29"
14D17
26D8I5"A6228"
19D6I8"9070 A30"
25D3I8"long A31"
13I17"A17 A32;
typedef "
11D1I1"3"
11D7I12"unsigned A34"
19D5I5"4 A35"
17D5I5"5 A36"
21D1I1"7"
17D1I1"8"
16D2I2"39"
18D1I1"0"
17D1I1"1"
17D1I1"2"
12D6I6"34 A43"
22D1I1"4"
17D1I1"5"
11D7I7"A42 A46"
17I17"int A47;
typedef "
342D2I4"9236"
17D4I2"63"
19D1I3"577"
18D1I1"4"
16D4I2"65"
20D2I2"19"
18D4I4"8258"
14I19"A54 A7616;
typedef "
138D6I3"A16"
60D13I3"A72"
122D6I5"A9069"
20D6I5"A9069"
1373I69"struct A9304
{
A17 A9305;
A5794 A9306;
};
extern struct A9304 A9307;
"
6D4I4"9308"
14D4I4"9309"
17D1I1"5"
11D4I4"5566"
14D4I4"5567"
14D3I17"7618();
Void A761"
8D13
19D3I17"5569();
Void A915"
8D9I10"Void A9152"
14D17I2"74"
22D1I15"0();
Void A7621"
10I41"6226();
A5794 A6227();
A81 A7622();
A58 A"
460D2I4"9070"
28D2I4"9070"
151I19"struct A114 A9153;
"
1389D2I2"92"
16D6I12"5794 A7637()"
15I16"A4 A202;
extern "
3337D2I4"9070"
159I11"A58 A9238; "
88D2I4"9070"
39D2I4"9070"
367I11"A17 A9071;
"
535I13"A9236 A9239;
"
1098D2I4"9070"
380D7I8"17 A9154"
24D1I1"1"
12D6I7"62 A442"
16I17"A4 A443 ;
extern "
150D3I4"9072"
14D10I9"Void A451"
22D9I9"5794 A452"
21D9I9"9036 A453"
29D1I1"4"
13D12
20D1I1"5"
12D9I22"A315 A456 ;
A5794 A457"
28D1I1"8"
18D4I3"459"
21D3I4"5268"
14D16
24D1I1"0"
12I16"A4 A461;
extern "
8D1I1"2"
12D8I11"Void A463()"
22D4I3"464"
13I18"A58 A8823;
extern "
1037D7I10"Void A9155"
18D9I7"A4 A504"
20I20"Void A505();
extern "
1042D2I4"9070"
1940D8I19"struct A640 * A9310"
24D4I3"663"
15D10I9"A48 A7505"
29D2I2"37"
19D3I4"7176"
14D7I9"Void A664"
22D4I3"665"
16D8I7"4 A4442"
19D6I6"A17 A5"
27D3I2"66"
21D2I3"031"
21D1I1"7"
20D1I1"8"
12I20"Void A669();
extern "
278D3I4"4476"
14D10I17"struct A640 *A675"
27D4I4"7719"
21D4I4"8914"
15D8I12"Void A7720()"
18D7I7"17 A933"
18D8I7"7 A5254"
18D2I2"81"
7D1I1"0"
11D2I2"17"
7D1I1"1"
11D1I2"35"
6D1I1"2"
11D1I2"92"
6D1I1"3"
11D2I1"7"
7D1I1"4"
11D8I7"4 A2145"
18D1I2"68"
6D1I1"6"
13D14I6"*A2147"
24D8I7"4 A2148"
18D7I16"2 A2149[M_TOKEN]"
17D2I2"87"
7D1I1"0"
11D2I1"4"
7D1I1"1"
15D4I4"2152"
14D2I2"36"
7D1I1"3"
11D27I7"35 A826"
38D1I2"17"
6D3I1"4"
13D10I28"7
A2155,
A2156,
A2157,
A6214"
19D4I2"A9"
9D1I1"8"
12D10I9"A17 A8825"
27D3I3"215"
15D3I4"Void"
8D1I1"0"
18D4I4"8209"
23D1I1"1"
12D3I4"Void"
8D1I1"2"
12D10I9"A35 A2163"
29D1I1"4"
12D5I4"Void"
10D1I1"0"
12D9I8"A35 A216"
22D7I10"9036 A8211"
24D4I4"5255"
15D4I2"A4"
9D11I16"6();
extern Void"
16I37"7();
extern Void A2168();
struct A216"
465I42"struct A9073
{
A48 A9074;
A9069 A9075;
};
"
422D6I7"8 A9076"
17D9I8"A42 A982"
20D8I9"long A983"
24D4I3"984"
16D8I8"87 A6039"
20D8I8"61 A7724"
19D9I9"A92 A7260"
20D8I9"long A985"
24D4I3"986"
16D9I8"34 A5670"
20I21"A5794 A987();
extern "
1045I7"9129,
A"
44D4I4"9156"
11I42"9157,
A9158,
A9159,
A9160,
A9161,
A8639,
A"
21D10I2"91"
15D2I2"91"
7I29"9164,
A6176, 
A7062,
A7063,
A"
91I21"9240,
A9241,
A9130,
A"
21I28"9165,
A9166,
A9167,
A9168,
A"
28I14"9292,
A9169,
A"
92I42"9242,
A9243,
A9131,
A9132,
A9133,
A9134,
A"
71I7"9170,
A"
307D4I4"9171"
21I42"9244();
extern Void A8266();
extern Void A"
8I80"extern Void A9172();
extern A4 A9173();
extern A4 A9174();
extern Void A9175();
"
746D9I7"4 A9176"
21D7I9"5794 A868"
19D6I6"7 A598"
25D1I1"0"
19D1I1"1"
13D10I7"61 A872"
22D7I10"5794 A6037"
19D10I7"61 A873"
22D7I10"5794 A8589"
20D5I6"8 A874"
16D9I7"A4 A875"
28D1I1"6"
20D1I1"7"
20D1I1"8"
19D2I2"79"
19D4I3"880"
21D4I4"6172"
21D3I4"9293"
20D4I4"9177"
21D4I4"8787"
23D1I1"1"
20D1I2"29"
18D4I4"7262"
23D1I1"2"
20D1I1"3"
20D2I2"48"
21D1I1"4"
20D1I1"5"
18D3I4"5667"
22D1I1"6"
19D2I2"87"
20D2I2"88"
20D2I2"89"
19D4I3"890"
21D4I3"891"
21D4I3"892"
21D4I4"7745"
24D1I1"6"
21D1I1"7"
20I1"4"
18D3I4"7748"
20D4I4"7749"
21D4I3"893"
23D1I1"4"
18D4I4"1857"
22D3I3"958"
22D1I1"5"
19D3I3"061"
20D3I4"5821"
20D4I3"896"
21D3I4"7507"
20D4I3"897"
21D4I4"5981"
23D1I1"8"
19D3I3"750"
20D3I4"8212"
20D3I3"899"
20D3I4"7177"
22D1I1"0"
18D4I3"901"
23D1I1"2"
20D1I1"3"
18D3I4"8944"
22D1I1"4"
18D4I3"905"
21D3I3"907"
21D4I4"9078"
23D1I1"7"
18D3I4"5077"
20D3I4"8267"
20D3I4"8830"
14D7I9"Void A908"
25D2I2"09"
13D9I9"Void A910"
28D1I1"1"
12D9I7"A4 A912"
20D16
24D1I1"3"
14D8I7"4 A5431"
19D11I9"Void A914"
22D10I9"Void A915"
22D11I6"7 A916"
27D2I2"17"
13D9I10"A5794 A918"
27D3I4"1739"
15D6I9"5794 A919"
24D4I3"920"
15D9I9"Void A921"
26D4I3"922"
15D20I14"A5794 A923();
"
31D4I3"924"
16D7I10"5794 A7263"
19D8I8"61 A5668"
19D7I12"Void A5669()"
16D18
26D13I12"7734 A7751; "
21D7I7"4 A7752"
18D18I10"A4 A5914()"
28D6I10"861 A926()"
16D8I6"4 A927"
18D6I8"4 A928()"
15D9I19"struct A849 *A929()"
19D6I9"61 A930()"
16D8I12"9236 A9245()"
18D6I12"9236 A9246()"
15D9I12"Void A9247()"
18D7I18"struct A144 *A5050"
17D8I6"7 A931"
18D6I8"61 *A932"
16D8I6"7 A933"
21D7I7"*A934;
"
14D18I7"A7 A935"
28D7I8"61 *A936"
16D18I7"A7 A937"
27D18I9"A61 *A938"
27D18I7"A7 A939"
28D9I8"61 *A940"
19D9I6"7 A941"
19D9I8"61 *A942"
19D12I10"61 A6038; "
19D11I18"struct A144 *A1696"
23D8I5" A943"
18D10I7"7 A9294"
19D11I18"struct A144 *A7178"
20D17
26D7I8"44 *A717"
17D7I18"struct A144 *A5432"
17D6I9"5794 A944"
15D17I10"A5794 A945"
26D20I12"A5794 A946;
"
27D4I5"A5794"
9D3I1"4"
19D6I4"7180"
15D12I11"A5794 A7227"
21D12I11"A5794 A7181"
22D7I10"5794 A5510"
17D8I7"68 A948"
17D18
26D10I9"114 *A949"
20D7I6"7 A950"
17D7I6"4 A951"
16D10I17"struct A114 *A952"
19D13I20"struct A144 *A7265; "
27D3I3"266"
15D7I10"5794 A1689"
24D4I4"7753"
15D18I10"Void A7754"
30D10I7"6 A1022"
20D10I8"81 A5511"
19D12I9"A81 A8770"
21D12I18"struct A561 *A1023"
21D12I8"A4 A1024"
22D10I7"7 A1025"
19D18I8"A4 A1026"
29D18I9"A49 A1027"
29D10I9"Void A775"
22D10I8"A4 A1028"
27D15I8"1029();
"
21D4I31"9079();
A48 A9080();
Void A9081"
15D21
38D1I1"0"
13D7I8"17 A1031"
18D18I9"A79 A1032"
35D4I4"5671"
15D8I10"Void A5672"
19D9I10"Void A8401"
21D8I8"17 A5512"
19D10I18"struct A561 *A1033"
21D9I10"Void A9135"
20D9I18"struct A561 *A1034"
21D7I10"5794 A1035"
18D47I10"Void A2317"
58D9I10"Void A5673"
20D9I10"Void A1036"
20D9I10"Void A1037"
20D11I18"struct A561 *A1038"
22D8I6"A4 A56"
21D9I18"struct A561 *A1039"
20D11I10"Void A7182"
22D18I10"A4 A7183()"
27D10I9"A58 A8268"
22D7I28"78 A1040();
extern Void A775"
12D6I49"extern A81 A1041();
extern A81 A7508();
extern A4"
11D3I49"7();
extern A5794 A8590();
struct A7758 *A7759();"
12D51I3"0()"
60D18I11"A78 A1042()"
28D8I10"78 A5271()"
18D8I10"78 A1043()"
18D8I12"5972 A1044()"
17D9I12"Void A2274()"
18D17I42"A54 A5433();
extern A9036 A9039();
extern "
26D106I9"44 *A5434"
116D7I12"9150 A9178()"
16D13I32"Void A7761();
extern A48 A7906()"
23D31I63"7758
{
A40 A7762;
A87 A7763, A7764;
A17 A7765, A7766;
A67 A7767"
43D21
29D11I10"7758 A7768"
20D79I9"A87 A7769"
88D12I9"A87 A7770"
21D12I9"A88 A7771"
21D12I9"A10 A7772"
21D43I17"const A88 A7773;
"
52D19I43"045
{
A18 A1046;
A72 A1047;
A7470 A1048;
A3"
24D2I58"49;
};
struct A1050
{
A18 A1051;
A17 A1052;
A5794 A1053;
}"
12D7I7"7 A3140"
17D34I14"81 A3143[20];
"
43D9I33"054
{
A54 A1055;
A55 A1056[25];
}"
19D8I9"55 *A3164"
19D11I19"struct A1054 *A7509"
20D78
86D209I12"144 *A7774;
"
217D10I51"7500
{
struct A7500 *A7775; A54 A7510; A42 A7511; }"
19D9I12"Void A1057()"
18D8I12"Void A1058()"
17D9I10"Void A1059"
20D8I10"Void A1060"
19D10I11"A5794 A1061"
21D22I18"struct A118 *A1062"
33D13I8" A1063;
"
20D13I8"A4 A7267"
26D4I4"7776"
14D10I8"63 A7777"
19D21
29D3I3"114"
8D2I2"64"
11I40"A81 A7512();
extern A49 A1073();
extern "
8D2I66"74();
extern A72 A1075[];
extern A9036 A1076();
extern A9036 A7778"
14D94I118"3097
{
A70 A3098; A72 A3099; A7468 A3100; A7468 A3101; A72 A3102; A72 A3103; A72 A3104; A7 A3105; A4 A3106; A7 A5282; "
100D5I85"283; A32 A5284; A74 A5966; A17 A6270; };
extern A81 A3107;
extern A315 A3108;
extern "
13D55I62"3097 A3109;
extern A58 A3110;
extern A4 A6067;
extern A72 A311"
60D10I14"extern A6 A311"
15D45
52D11I14"Void A1077();
"
19D7I21"48 strcat(), strcpy()"
17D9I14"48 strncpy(); "
16D11I13"int strncmp()"
24D4I4"1078"
15D8I7"2 A7268"
27D2I2"79"
13D12I18"struct A553 *A1080"
21I17"A7 A9295;
extern "
6D67I3"108"
72I66"struct A553
{
struct A553 *A1082;
A7 A1083;
struct A114 A1084;
};
"
15D81I1"8"
86D75I59"struct A5513
{
A81 A5514;
struct A147 *A5515;
};
A5972 A777"
80D39I10"A5972 A778"
44D17I10"A5972 A778"
22D16I10"A5972 A778"
21D16I10"A5972 A778"
21D16I10"A5972 A778"
21I15"A5972 A7785();
"
7D14I11"A74 A6242; "
21D12I8"A7 A1086"
21D12I8"A7 A7184"
21D12I11"A5794 A5248"
25D6I4"7185"
15D10I10"A95 *A1087"
27D4I4"1088"
21D4I4"1089"
21D4I4"7186"
21D3I3"109"
21D4I4"7187"
15D10I11"A5794 A1091"
21D9I10"Void A1092"
27D3I3"093"
20D4I4"8269"
20D3I3"094"
14D10I8"A4 A1095"
21D10I8"A4 A1096"
28D3I3"097"
20D4I4"1098"
16D10I7"4 A1099"
21D10I11"A94 * A5272"
21D9I10"A94 * A110"
21D10I11"A94 * A1101"
29D2I2"02"
19D4I4"1103"
15D11I10"Void A1104"
30D2I2"05"
21D2I2"06"
19D4I4"5675"
21D4I4"6243"
15D10I8"A4 A5518"
27D4I4"7786"
21D4I4"5516"
21D4I4"5517"
21D4I4"5519"
22D3I3"520"
14D18I12"Void A5521()"
27D17
23D4I4"5522"
15D10I9"A23 A7787"
21D8I10"Void A1107"
19D10I10"Void A1108"
22D10I7"4 A1109"
21D11I10"Void A1110"
22D11I10"Void A1111"
22D11I10"Void A1112"
22I21"Void A2942();
extern "
7D4I4"1113"
15D55I12"Void A2949()"
64D13I12"Void A7070()"
22D9I12"Void A1114()"
18D10I12"Void A1115()"
19D9I12"Void A7269()"
19D8I12"94 * A1116()"
17D9I12"Void A1117()"
18D18I12"Void A1118()"
27D18I12"Void A1119()"
27D26I12"Void A7788()"
35D8I12"Void A5676()"
17D18
26D2I2"20"
21D2I2"21"
21D2I2"22"
13D9I10"Void A8270"
26D4I4"5249"
15D10I18"struct A144 *A5523"
19I17"A7 A5822;
extern "
6D4I4"7789"
21D4I4"7790"
19D4I4"7791"
15D10I10"A94 *A7792"
21D10I11"A5794 A7793"
22D7I10"5794 A7794"
19D7I10"5794 A7795"
18D10I11"A5794 A7796"
22D8I10"5794 A7797"
20D2I4"5794"
7D3I45"8();
struct A5304 { A77 A3049; A5794 A1148; }"
12D12I13"A2 A1123[100]"
21D12I9"A17 A1124"
21D12I10"A13 *A1125"
21D12I9"A81 A1126"
23D9I7"8 A1127"
19D1I1"5"
6D4I2"28"
13D11I18"struct A144 *A1129"
20D11I18"struct A144 *A1130"
20D11I26"const struct A5304 A3050[]"
21D10I7"4 A1131"
20D17I8"38 A1132"
26D45I9"Void A113"
65D1I1"3"
21D1I1"3"
13D9I8"A17 A113"
29D1I1"3"
13D10I8"A4 A2979"
29D1I1"3"
19D3I3"917"
23D2I2"39"
13I19"A4 A1140();
extern "
8D1I1"4"
6D124I231"extern Void A5529();
extern A4 A5530();
extern A7 A5532();
extern Void A5533();
extern A66 A5534();
extern A66 A7799();
extern Void A5531();
extern Void A1142();
extern Void A1143();
extern Void A1144();
extern A50 A1145();
extern "
131D339I15"46();
extern A7"
344D13I118"47();
extern A48 A1148();
extern A48 A1149();
extern A77 A1150();
extern A58 *A5067, *A5068;
extern A17 *A8945, *A8946"
22D4I6"8271()"
15D5I193"53();
extern Void A1154();
extern Void A1155();
extern Void A1156();
extern Void A1157();
extern Void A5823();
extern Void A1158();
extern Void A1159();
extern Void A1160();
extern Void A1161()"
15D4I4"8402"
15D19
25D4I75"8403; A54 A8404; A13 *A8405; A7468 A8406; A72 A8407; A58 *A8408;
A58 *A8409"
19D52I1"6"
57D1I1"7"
6D56I4"63;
"
61D10I229"
A7132,
A7133,
A1164,
A1165,
A1166,
A1167,
A1168,
A1169,
A1170,
A1171,
A1172,
A1173;
A13 A1174[ (2000 / CHARLEN) ];
A18 A5435;
A17 A6040;
A13 A7800[ (2000 / CHARLEN) ];
A61 A6041;
A17 A6042;
} ;
extern A13 A9180[(2000 / CHARLEN)]"
20D4I4"9248"
14D88I6"9249; "
95D17I17"9296; A17 A9250; "
24D6I6"9251; "
13D6I19"9297; FILE *A9252; "
16D9I18"struct A9248 A9253"
18D127I14"Void A9254();
"
135D27I104"391
{
struct A633 *A1175;
struct A144 *A1176;
struct A144 *A1177;
struct A144 *A1178;
};
struct A1179
{
"
32D262I91"180;
A53 A1181;
A17 A1182;
A53 A1183;
A5794 A1184;
A5794 A1185;
};
struct A1186
{
struct A8"
267D31I5"187;
"
40D27
33D12I8"188;
};
"
21D18I6"189
{
"
26D71I105"640 *A1190;
A5794 A1191;
};
struct A1192
{
A17 A1193;
A9 A1194;
A70 A1195;
};
struct A1196 { A2 A1197[3];"
77I833" *A1198; };
struct A1199
{
A5794 A1200;
A35 A1201;
A42 A1202;
};
Void A1203();
Void A1204();
Void A1205();
struct A5677
{
A5794 A5678;
A42 A5679;
A5794 A5680;
A5794 A5681;
};
extern A17 A6244;
extern long A7418;
extern A49 *A1206;
extern A49 *A1207;
extern A2 A1208[ARG_LEN];
extern A42 A8197; extern A2 A3496[ARG_LEN];
extern struct A1196 A1209[];
extern const A6 A1210;
extern A7 A5406;
extern A7 A5407;
extern A7 A6210;
extern A42 A1211;
extern A4 A1212;
extern A72 A1213;
extern A72 A1214;
extern A18 A1215;
extern A18 A1216;
extern A4 A7228;
extern A61 A1217;
extern A61 A1218;
extern A67 A1219;
extern A13 *A6043;
extern A13 *A1220;
extern A13 *A1221;
extern struct A1162 A1222;
extern struct A144 *A1223;
extern struct A144 *A1224;
extern struct A144 *A1225;
extern A48 A1226;
extern A7 A1227;
extern A9070 A1228;
extern UFLAG"
1095I7"9298,
A"
2534D19
33D4I4"9255"
14D7I9"2 A7190[]"
16D8I18"struct A144 *A1398"
21D4I4"1399"
14D8I7"4 A7807"
18D7I6"7 A621"
21D7I6"9181; "
15I1"1"
6D1I1"0"
11D1I2"68"
6D1I1"1"
11D1I1"4"
6D1I2"2 "
11D1I1"7"
6D1I1"3"
10D4I2"A7"
9D3I1"4"
12D4I2"A7"
9D3I1"5"
12D4I2"A4"
9D3I1"6"
12D9I10"Void A1407"
20D9I10"Void A1408"
26D4I4"1409"
17D6I7"8 A1410"
17D10I9"A58 A1411"
21D8I10"Void A8257"
19D10I8"A4 A8411"
27D4I4"5063"
15D4I2"A6"
9D1I1"2"
12D2I4"Void"
7D1I1"3"
18D4I4"1414"
21D4I4"1415"
15D10I8"A4 A1416"
21D19I10"Void A5687"
36D4I4"5688"
15D10I10"Void A5689"
21D10I19"struct A5677 *A5690"
30D1I1"7"
12D10I10"A13 *A5396"
21D10I9"Void A141"
28D4I4"1419"
21D4I4"6052"
15D10I11"A5794 A7808"
30D1I1"4"
18D4I4"5545"
21D4I4"5546"
15D8I10"Void A5547"
19D2I4"Void"
7D1I1"0"
12D2I4"Void"
7D25I1"1"
36D9I7"A4 A624"
21D9I9"A48 A9182"
20D9I8"A4 A1422"
20D4I2"A4"
9D12I5"3();
"
26D5I6" A1424"
16D10I12"Void A3500()"
19D8I10"Void A1425"
19D8I9"int A3493"
19D10I9"int A3494"
27D4I4"1426"
15D10I19"struct A1189 *A1427"
21D12I10"A13 *A8273"
22D7I6"4 A599"
19D9I7"A4 A599"
21D8I10"Void A9311"
27D2I2"28"
13D12I10"Void A7191"
31D2I2"29"
13D8I10"Void A6080"
25D4I4"9183"
15D10I9"A54 A1430"
21D1I1"V"
6D4I4"1431"
15D10I8"A4 A7475"
30D1I1"2"
12D9I12"UFLAG *A1433"
29D1I1"4"
12D10I8"A4 A1435"
29D2I2"36"
13D1I1"v"
6D4I4"6246"
15D1I1"v"
6D4I4"7809"
21D4I4"1437"
23D2I2"38"
14D10I10"34 A5691()"
19D20
28D2I2"39"
19D4I4"1440"
15D10I12"Void A1441()"
19D17
26D1I1"2"
21D1I1"3"
12D11I10"Void A5773"
30D2I2"44"
13D12I11"A5794 A1445"
21I20"A5794 A1446;
extern "
6D4I4"1447"
21D4I4"3532"
15D12I10"A2 A3526[]"
21I17"A4 A3527;
extern "
6D2I2"14"
21D4I4"1449"
15D10I11"A5794 A1450"
30D1I1"1"
18D4I4"1452"
15D10I8"A4 A9184"
27D4I4"5274"
21D73I6"1453()"
82D19I12"Void A5651()"
28D20I12"Void A5548()"
29D20
26D4I130"3443();
extern Void A6072();
extern Void A1454();
extern Void A3363();
extern Void A1455();
extern Void A1456();
extern Void A5107"
17D89I65"065
{
A67 A1066;
A5794 A1067;
A5794 *A1068;
A17 A1069;
};
extern "
97D44I20"1065 *A1070;
extern "
52D40I53"1065 A1071[];
extern A67 A1072[];
extern Void A6209()"
53D12I85"
{
A79 A547;
A79 A548;
A79 A549;
A79 A6232;
A79 A5661;
A87 A6233;
A87 A5662;
A23 A552"
23D16I24"53 *A554, *A555, *A6234,"
21D1I12"63, *A557;
}"
11D29I14"93
{
A17 A8274"
34D35I21"98 A8275;
A8198 A8276"
50D44I10"8277[1];
}"
54D41I6"561
{
"
56D4I165"62;
struct A561 *A563;
A40 A564;
A40 A565;
A81 A566;
A58 A567;
A42 A568;
A68 A569;
struct A147 A570;
A17 A571;
A24 A572;
A61 A573;
A96 *A574;
struct A1537 * A7443;
}"
13D11I8"A81 A575"
20D9I17"struct A561 *A576"
28D1I1"7"
18D2I1"5"
22D2I2"79"
19D3I4"8278"
22D1I1"0"
20D1I1"1"
19D3I2"82"
22D9I1"3"
20D7I10"Void A5664"
18D19
27I65"4(), A585();
extern A4 A586();
extern A4 A5665();
extern Void A58"
1854I50"9136
{
struct A9136 *A9137; A17 A9138; };
struct A"
109D9I19"struct A9136 *A9139"
18D18
26D9I10"9136 A9140"
19D9I8"58 A7273"
18D4I3"A17"
9D3I1"4"
12D11I17"struct A588 A1719"
20D4I2"A2"
9D3I3"6[]"
20D2I2"77"
13D10I9"A89 A1978"
29D2I2"79"
19D4I4"1980"
21D4I4"7274"
24D1I1"1"
13D8I7"4 A9185"
19D18I8"A4 A9186"
35D4I4"5897"
24D1I1"2"
12D3I4"Void"
8D1I1"3"
12D10I9"A72 A1984"
21D10I18"struct A561 *A1985"
27D3I3"914"
23D2I2"86"
21D2I2"87"
13D27
33D26I4"9142"
37D10I9"A78 A1988"
27D4I4"1990"
21D4I4"1989"
21D4I4"1991"
15D8I10"Void A1992"
25D4I4"1993"
15I27"struct A144 *A7824; extern "
6D4I26"5553();
struct A147 *A7825"
23D2I2"26"
19D4I4"7827"
21D64I6"7828()"
73D8I10"Void A7829"
20D7I7"4 A7830"
18D9I12"Void A8412()"
18D9I12"Void A7831()"
18D9I12"Void A7832()"
18D19I12"Void A8413()"
28I14"Void A8414();
"
8D20I7"1457
{
"
26D12I4"58;
"
18D3I25"59;
A4 A1460;
A9 A1461;
}"
12D19I10"A9 A1461()"
28D18I10"A9 A1462()"
28D1I1"9"
6D1I1"3"
11D19I8"A4 A1464"
30D9I7"4 A1465"
19D20
28D11I10"83 **A5078"
21D9I18"struct A83 **A5079"
25D2I2"66"
13D9I7"4 A1467"
19D3I11"struct A144"
8D2I2"68"
12D11I18"struct A144 *A7476"
21D9I7"4 A1469"
19D10I19"struct A640 **A3651"
20D9I18"struct A640 **A365"
21D8I9"17 *A1470"
19D8I9"68 *A1471"
26D13I14"640 **A1472 ;
"
22D7I7"3 A1473"
18D11I7"4 A1474"
22D7I9"13 *A1475"
18D7I9"13 *A1476"
18D7I9"13 *A1477"
18D4I2"53"
9D2I2"78"
13D2I2"68"
7D2I2"79"
12D9I3"A17"
15D1I1"0"
12D1I2"57"
6D1I1"1"
11I19"A57 A3660 ;
extern "
17D3I4"5 ; "
11D10I8"57 A1482"
22D6I10"036 *A1483"
17D10I7"4 A1484"
20D18I8"A4 A8214"
29D8I7"4 A1485"
19D7I11"9036 *A1486"
18D7I9"81 *A1487"
17D8I16"const A81 *A1488"
19D7I7"6 A1489"
25D11I10"144 *A7276"
21D4I4"9036"
9D1I1"0"
11D17I8"A9 A1491"
27I21"A9036 A1492 ;
extern "
8D9I10"640 *A1493"
19D17I9"A63 A1494"
27D17I8"A4 A1495"
28D8I7"4 A1496"
22D4I4"5825"
18D4I5"1497 "
21D8I9"640 *A149"
19D12I12"A5794 A1499 "
21D12I18"struct A83 *A1500 "
21D10I18"struct A83 *A1501 "
19D13I18"struct A83 *A1502 "
22D10I18"struct A83 *A5080 "
20D9I9"53 A1503 "
18D12I9"A4 A1504 "
21D12I8"A4 A6247"
21I27"struct A83 *A6248 ;
extern "
6D4I4"9040"
23D2I2"05"
14D7I7"4 A1506"
18D10I11"A5794 A1507"
21D9I10"Void A7451"
20D10I8"A4 A7833"
22D8I7"4 A6249"
25D4I4"6250"
23D2I2"08"
13D8I10"Void A1509"
28D1I1"0"
12D4I2"A6"
9D1I1"1"
21D1I1"2"
12D10I9"A68 A1513"
21D7I9"Void A151"
20I203"81 A5692();
extern Void A8215();
extern Void A1515();
extern A4 A1516();
extern Void A1517();
extern Void A1518();
extern Void A1519();
extern Void A1520();
extern A4 A3738();
extern A4 A7834();
extern A"
561D1I1" "
11D1I1" "
11D1I1" "
10D1I1" "
10D1I1" "
10D1I1" "
848D4I4"9082"
15D19I10"Void A9083"
30D19I10"Void A9084"
30I21"Void A3863();
extern "
17D2I2"89"
13D10I19"struct A1537 *A1590"
21D10I19"struct A1537 *A1591"
27D2I2"71"
21D4I4"1592"
21D4I4"1593"
15D9I10"Void A7841"
29D1I1"2"
12D4I3"A74"
9D1I1"7"
18D4I4"7843"
21D4I4"8218"
15D9I10"Void A8219"
29D1I1"5"
13I1"7"
6D1I1"6"
12D3I4"Void"
8D1I1"7"
12D10I8"A4 A7848"
21D10I9"A74 A7849"
21D1I1"V"
8D24I4"94()"
33D9I4"void"
14D1I3"1()"
10D4I4"void"
9D9I17"2();
typedef A22*"
14I57"3;
extern const A51 A1524;
extern long A1525;
struct A152"
1445D10I8"A4 A9085"
27D4I4"3763"
15D9I10"Void A8835"
21D2I2"35"
7D1I3"4()"
10D11I3"A58"
16D1I1"5"
10D2I11"struct A147"
7D3I1"6"
12I19"A4 A3767();
extern "
2788D2I4"9070"
433D8I10"Void A9086"
19D9I9"A74 A9087"
28D1I1"6"
12D8I9"Void A737"
19D9I8"A4 A4551"
20D9I9"Void A738"
25D3I4"4724"
14D10I8"A58 A741"
29D1I2"77"
20D1I1"3"
18D4I3"744"
15I21"Void A8202();
extern "
1326D1I1" "
15D1I1" "
11D1I1" "
2390D2I4"9070"
215D2I4"9070"
12D1I2"72"
52D4I4"9088"
1739I14"A7 A9294 = 0;
"
904D106I6"static"
115D82I140"9073 A9089[] =
{
{ "et_ASGN", (A78) 0x01 },
{ "et_ACC", (A78) 0x02 },
{ "et_MOD", (A78) 0x04 },
{ "et_ADDR", (A78) 0x08 },
{ "et_CALL", (A78"
88D384I48" },
{ "et_DOT", (A78) 0x20 },
{ "et_SAA", (A78) "
389D199I102"},
{ "et_SAT", (A78) 0x80 },
{ "et_SAPC", (A78) 0x100 },
{ "et_SAX", (A78) 0x200 },
{ "et_SAM", (A78) "
204D97I50" },
{ "et_SAPCP", (A78) 0x800 },
{ "et_SATP", (A78"
102D327I26"000 },
{ "et_FREE", (A78) "
332D24I23"0 },
{ "et_RET", (A78) "
29D429I86"000 },
{ "et_REALL", (A78) 0x4000 },
{ "et_CHNUL", (A78) 0x10000 },
{ "et_THIS", (A78)"
437D24I85" },
{ "et_ASSERT", (A78) 0x40000 },
{ "et_DUAL", (A78) 0x80000 },
{ "et_CH_NEG", (A78"
30D132I316"0000 },
{ "et_COPY", (A78) 0x400000 },
{ "et_REF", (A78) 0x800000 },
{ "et_DEEP", (A78) 0x1000000 },
{ "et_CAST1", (A78) 0x2000000 },
{ "et_THREAD", (A78) 0x4000000 },
{ "et_LHS", (A78) 0x8000000 },
{ "et_STRING", (A78) 0x10000000 },
{ "et_STRINFO", (A78) 0x20000000 },
{ "et_TH_PROT", (A78) 0x40000000 },
};
static "
140D85I9"9073 A909"
90D268I87"
{
{ "MALLOC", 0x01 },
{ "NEW", 0x02 },
{ "NEWA", 0x04 },
{ "STATIC", 0x08 },
{ "AUTO","
273D231I31" },
{ "MOS", 0x20 },
{ "CONST","
236D99I38" },
{ "MODIFIED", 0x80 },
{ "UNKNOWN","
105D101I93" },
{ "CUSTOD", 0x200 },
{ "ALIAS", 0x400 },
{ "ADOPT", 0x800 },
{ "FREE", 0x2000 },
{ "RET","
107I174"0 },
{ "NULTERM", 0x4000 },
{ "STRINFO", 0x8000 },
{ "READ", 0x10000 },
{ "WRITE", 0x20000 },
};
A48 A9091();
A7 A1025 = 0;
Void
A9079(A1718)
struct A561 *A1718;
{
if( A1718 "
10D2I2"11"
12D2I2"12"
7D27I27"11:
A9081(A1718,0);
A1022++"
32D2I23"18 = A1718->A562;
A1715"
11D11I2"18"
21D2I2"13"
12D2I2"14"
7D9I9"16: A1718"
15D11I10"18->A563;
"
19D2I2"15"
7D16I30"13:
A9079( A1718 ); goto A1716"
21D17I11"14:
A1022--"
22D7I67"12: ;
}
Void
A9081(A1718,A1709)
struct A561 *A1718;
A78 A1709;
{
A6"
13D40I18";
A40 A2118;
A5794"
45D40I37"7;
A4 A4015 = (A4) 0;
A48 A9092();
A2"
45D85I49"6[40];
A53 A9093 = A7188.A1181;
A7188.A1181 = 0;
"
95D7I108"== (((A78) 0x40|((A78) 0x80|(A78) 0x1000)|(A78) 0x100|(A78) 0x800|(A78) 0x200|(A78) 0x400) | (A78) 0x200000)"
18D2I2"11"
12D2I2"12"
7D2I53"11: A1079( "Infer ",(A49)( NULL )); A1709 = 0; 
A1712"
9D12I4"1718"
23D2I2"13"
12D2I2"14"
7D45I13"13:
A1732 = 0"
50D22I8"17:
if( "
28D70I32"<= A1022) goto A1715;
goto A1716"
75D4I23"20: A1732++;
goto A1717"
9D4I42"15:A1079( "   ",(A49)( NULL )); goto A1720"
9D6I45"16:
A2118 = A1718->A564;
if( A2118 & 0x100 ) "
14D2I14"21;
goto A1722"
7D54I36"21:
A4015 = (A4) 1;
A2118 &= ~0x100;"
59D79I67"2:
if( A2118 && A2118 != (0x400|19) ) goto A1723;
goto A1725;
A1723"
84D79I61"37 = A1610(A2118);
goto A1726;
A1725: A1737 = "";
A1726:
if(!"
84D94I82"7) goto A1727;
goto A1766;
A1727: switch( A2118 )
{
case (0x400|19):
A1737 = A1718"
99D309I9"6->A129;
"
317D2I54"67;
case (0x400|20):
A1079( "$s",(A49)( "a literal" ))"
12D51I48"67;
case (0x40|21):
A1079( "$s",(A49)( "CAST" ))"
61D53I49"67;
case (0x40|25):
A1079( "$s",(A49)( "CAST1" ))"
63D2I112"67;
case (0x400|18):
A1737 = "Function Call";
goto A1767;
case 0:
A1737 = "null";
goto A1767;
default:
A865(209)"
7D2I41"37 = "\?\?\?";
goto A1767;
}
A1767:
A1766"
8D107I6"*A1737"
118D2I2"68"
12D2I2"69"
7D64I29"68:A1079( "$s",(A49)( A1737 )"
69D42I59"769:
if( A4015 ) goto A1770;
goto A1771;
A1770:A1079( "$s","
49D6I32""=" ));
A1771:A1079( ", type=$s""
15D31I22"976( (A6) A1718->A567 "
37D19I7"sprintf"
24I23"36, ", z:%u, n:%u", A17"
6D2I25"70.A548, A1718->A570.A549"
7D18I16"1079( "$s",(A49)"
23D38I5"36 ))"
43D10I22"72: A1079( ", ",(A49)("
15D22I7" )); if"
29D28I37"->A570.A6232 ) goto A1775;
goto A1776"
33D96I30"75:A1079( "A" "=$l",(A49)( &( "
101D24I49"->A570.A6233) )); 
A1776:A1079( "(:$t)",(A49)( &("
34D11I78"70.A6232 ) )); 
A1773:if(0) goto A1772;
A1774: A1079( ", ",(A49)( NULL )); if("
21D45I8"70.A5661"
56D2I2"79"
12D2I2"80"
7D30I28"79:A1079( "B" "=$l",(A49)( &"
35D67I51"18->A570.A5662) )); 
A1780:A1079( "(:$t)",(A49)( &("
72D3I33"8->A570.A5661 ) )); 
A1777:if(0) "
11D1I1"7"
7D54I3"78:"
60D107I18"1718->A570.A552 )
"
115D2I2"81"
12D2I2"82"
7D39I64"81:A1079( ", pf = $s" ,(A49)( A9080(A1718->A570.A552) ));
A1782:"
45D58I4"1709"
69D2I2"83"
12D2I2"84"
7D8I39"83:A1079( ", etflags=$s" ,(A49)( A9092("
13D32I4") ))"
37D38I6"84:
if"
44D44
49D5I10"(0x400|27)"
16D2I2"85"
12D2I2"86"
7D17I53"85:
A1079( "\n",(A49)( NULL ));
A9082( A1718->A7443 )"
22D4I29"86:A1079( "\n",(A49)( NULL ))"
9D8I37"14:
A7188.A1181 = A9093;
}
A48
A9092("
13D203I5")
A78"
209D75I230";
{
return A9091( A1709, A9089, ((A72) sizeof(A9089) / (A72) sizeof(struct A9073)) );
}
A48
A9080(A1709)
A23 A1709;
{
return A9091( (A78) A1709, A9090, ((A72) sizeof(A9090) / (A72) sizeof(struct A9073)) );
}
A4 A2310();
Void
A7896"
81D19I2"8,"
24D11I99"7, A2119, A2120, A1718 )
A40 A2118;
A48 A2117;
A79 A2119; struct A553 *A2120;
struct A561 *A1718;
{"
18D127I8"119 != 4"
132D72I77"1718->A572 & ((A24) 0x20|(A24) 0x100) ||
A1484 || A2271 ) return;
A5667( 845,"
77D59I9"7, A1610("
64D100I32"), A1113(A2120) );
}
A5972
A1044"
105D20I18"18 )
struct A561 *"
25D98I3";
{"
106D59I12"18->A570.A54"
64D20I18"4 ) return -1;
if("
30D28I136"70.A549 == 4 ) return 1;
return 0;
}
Void
A7755( A2118, A7897 )
A40 A2118;
struct A561 **A7897;
{
struct A561 *A1718 = *A7897;
A58 A1740"
33D56I21"18->A563 = A1719.A599"
61D17I14"19.A599 = NULL"
22D42I4"40 ="
47D43
54D6I4"|0x4"
11D42I38"5) ? A1719.A592 : A1718->A567;
*A7897 "
48D1I1"9"
7D7I14"8, A1718, A174"
12D19I72"}
struct A561 *
A576( A2275 )
struct A588 *A2275;
{
struct A561 *A1718;
"
24D26I18"1718 = A2275->A599"
36D31I11"711;
A1718 "
37D21I32"9( (0x400|20), NULL, A2275->A592"
26D15I18"2275->A599 = A1718"
20D3I23"18->A571 = A2275->A594;"
9D13I22"2275->A593 & (A24) 0x1"
23D3I3"712"
12D21I11"713;
A1712:"
32D18I39"6 = A2275->A590;
A1713: ;
A1711:
return"
24D12I87";
}
A4
A1028( A1718 )
struct A561 *A1718;
{struct A147 *A2113;
struct A561 *A2114;
A40 "
17D23I75";
if( !A1718 ) return (A4) 0;
A2113 = &A1718->A570;
A2118 = A1718->A564;
if"
29D76I49"3->A548 == 4 || A2113->A549 == 4 ) return (A4) 1;"
81D50I1"("
62I6"200|0x"
5D46I5"7) ||"
51D102I57"8 == (0x200|0x40 | 8) || A2118 == (0x40 | 2))
&& (A2114 ="
112D86I139"62) )
return A1028(A2114) || A1028(A2114->A563);
return (A4) 0;
}
Void
A1029( A2118, A2275 )
A40 A2118;
struct A588 *A2275;
{
struct A561 *"
91D14I87";
struct A561 *A2276;
A1718 = A576( A2275 );
A2276 = A576( &A1719 );
if( A2276 != A1718"
24D3I3"711"
12D10I38"712;
A1711: A1718->A563 = A2276;
A1712"
15D38I23"19.A599 = A1039( A2118,"
44I26", A1719.A592 );
A1719.A599"
7D7I53"|= A1719.A594 & 0x200000;
if( A1719.A593 & (A24) 0x10"
17D3I3"713"
12D36I16"714;
A1713:
A580"
41D89I8"19.A599,"
94D20I101"9.A589 );
A1714: ;
}
Void
A2277( A2278, A1730, A1835 )
A42 A2278;
A7 A1730;
struct A561 *A1835;
{
A23"
27D175I6"= A183"
180D10I259"70.A552;
A23 A1732, A2279;
static A5794 const A2280[] = { "free", "delete", "delete[]" };
static A5794 const A2281[] = { "malloc", "new", "new[]",
"static", "auto", "member", "constant", "modified" };
int A2282;
A2 A2080[200];
static A23 A2283 = 0;
if( !A2283"
20D3I3"711"
12D10I10"712;
A1711"
15D16I11"32 = 1;
A17"
27D113I5"32 <="
122D2
9D3I3"713"
12D10I77"714;
A1716: A1732 <<= 1;
goto A1715;
A1713:
A2283 |= A1732; goto A1716;
A1714"
15D154I10"12:
switch"
159D111I60"33( A2278, (A46) A1730 ) )
{
case 0x2300: A2279 = 0x02; goto"
116D3I29"7;
case 0x2400: A2279 = 0x04;"
13D3I29"7;
case 0x400:
A2279 = 0x01; "
12D2I28"7;
default:
A2279 = A2283;
}"
7D2I18"7:
A1709 &= A2283;"
10D14I21"09 & ~(A2279 | 0x100)"
25D2I2"20"
12D2I2"21"
7D68I39"20:
{
A5794 A2284 = NULL;
A23 A2285 = 0"
73D4I15"32 = 1;
A1725:
"
11D14I10"32 < 0x100"
24D2I2"22"
12D2I2"23"
7D39I27"26: A1732 <<= 1;
goto A1725"
44D4I46"22:
if( A1709 & A1732 ) goto A1727;
goto A1766"
9D4I17"27:
A2285 = A1732"
9D26I68"66: goto A1726;
A1723:
A2080[0] = 0;
A1732 = 1, A2282 = 0;
A1769:
if"
31D165I10"32 < 0x100"
175D2I2"67"
12D2I2"68"
7D23I24"70: A1732 <<= 1, A2282++"
33D2I2"69"
7D31I6"67:
if"
36D133I11"32 == A2279"
144D2I2"71"
12D2I2"72"
7D47I45"71:
A2284 = A2280[A2282];
goto A1773;
A1772: "
52D44I12"1709 & A1732"
55D2I2"74"
12D2I2"75"
7D51I2"74"
58D29I12"2080[0] == 0"
40D2I2"76"
12D2I2"77"
7D31I35"76:
strcpy( A2080, A2281[A2282] );
"
39D14I2"78"
19D101I98"77:
sg_sfcat( A2080, (A1732 == A2285) ? " or " : ", ", 200 );
sg_sfcat( A2080, A2281[A2282], 200 )"
106D50I2"78"
57D2I2"75"
9D3I5"73: ;"
12D171I41"70;
A1768:
A900( A1709 & A2279 ? 673 : 42"
176D34I72"284, A2080 );
}
A1721: ;
}
A40
A2286(A1718)
struct A561 *A1718;
{
return"
39D101I9"8->A565 ?"
106D16I9"8->A565 :"
21I6"8->A56"
6D34I21"4
A7521( A2567, A2276"
51D18I43"2567, *A2276;
{
struct A561 *A1731, *A1749;"
23D6I14"A2567 == A2276"
15I7" (A4) 1"
6D5I43"!A2567 || !A2276 ) return (A4) 0;
if( A2567"
12D27I8"!= A2276"
32D200I10"4 ||
A2567"
205D50I10"6 != A2276"
55D13I193"6 ||
A2567->A567 != A2276->A567 ||
A2567->A572 != A2276->A572 ||
A2567->A571 != A2276->A571 ) return (A4) 0;
if( A2567->A572 & (A24) 0x10 &&
!A1109( &A2567->A570, &A2276->A570 ) )
return (A4) 0"
18D17I70"31 = A2567->A562, A1749 = A2276->A562;
A1713:
if(
A1731 && A1749) goto"
22D17I198"1;
goto A1712;
A1714:
A1731 = A1731->A563, A1749 = A1749->A563;
goto A1713;
A1711:
if( !A7521( A1731, A1749 ) ) return (A4) 0;
goto A1714;
A1712:
if( A1731 || A1749 ) return (A4) 0;
return (A4) 1;
}"
31I7"
A1030("
5D86I2")
"
95D58I4"61 *"
63D27I8";
{
if( "
32I110" ) goto A1711;
goto A1712;
A1711:
{
struct A561 *A2287;
A2287 = (struct A561 *) A1073((A41) 14);
A1119( &A2287"
6D17I3", &"
28D17I32" );
memcpy((A49)( A2287),(A49)( "
22D24I57"),(size_t)( sizeof(struct A561) ));
A2287->A562 = A1030( "
33D20I27"62 );
A2287->A563 = A1030( "
29D20I76"63 );
return A2287;
}
goto A1713;
A1712: return NULL;
A1713: ;
}
A17
A1031( "
25D24I23", A1709 )
struct A561 *"
29D24I101";
A17 A1709;
{
struct A561 *A2114, *A2115;
A17 A1754 = 0;
A17 A2288, A2289;
A81 A80;
A40 A2118;
if( !"
29D23I25" ) return A1754;
A2114 = "
32D19I12"62;
A2118 = "
28D66I2"64"
73D4I22"1709 & 0x2000 && A2118"
9D24I85"0x400|19) ) goto A1711;
goto A1712;
A1711: A1754 |= 0x2000;
A1712:
if( A1709 & 0x4000"
30D18I17"118 == (0x40 | 3)"
23D9I104"1031( A2114, 0x2000 ) ) goto A1713;
goto A1714;
A1713:
A1754 |= 0x4000;
A1714:
A1709 &= ~(0x2000|0x4000)"
16D9I39"2118 == (0x40|21) || A2118 == (0x40|25)"
19D254I57"A1031( A2114, A1709 );
if( A1709 & (0x01 | 0x08 | 0x40) )"
264D4I14"5;
goto A1716;"
9D92I11"5:
A2115 = "
97D10I16" ? A2114->A563 :"
17D29I3"if("
35D32I23" == (0x200|0x10 | 3) ||"
37D3I33"8 == (0x200|0x10|0x04 | 3) ) goto"
8D10I3"7;
"
18D14I2"20"
20I50"7:
if( A1709 & 0x01 ) goto A1721;
goto A1722;
A172"
5D5I33"288 = 0x02 | 0x20;
A2289 = A1031("
11D42I17", A2288 ) |
A1031"
48D42I32"5, A2288 );
if( A2288 == A2289 )"
51D44I4"23;
"
52D48I60"25;
A1723: A1754 |= 0x01;
A1725: ;
A1722:
if( A1709 & 0x08 )"
57D16I31"26;
goto A1727;
A1726:
A2288 = "
23D20I81"0x04;
A2289 = A1031( A2114, A2288 ) |
A1031( A2115, A2288 );
if( A2288 == A2289 )"
29D49I4"66;
"
57D46I60"67;
A1766: A1754 |= 0x08;
A1767: ;
A1727:
if( A1709 & 0x40 )"
55D52I4"68;
"
60D34I18"69;
A1768:
A2288 ="
39D1I84" | 0x04;
A2289 = A1031( A2114, A2288 ) |
A1031( A2115, A2288 );
if( A2288 == A2289 )"
10D42I4"70;
"
50D43I44"71;
A1770: A1754 |= 0x40;
A1771: ;
A1769: ;
"
51D10I31"72;
A1720: if( A2118 == (0x200|"
17D19I16"8) || A2118 == ("
24D1I12"|0x40 | 7) )"
10D43I4"73;
"
51D37I14"74;
A1773:
A17"
42D14I47"A1031( A2114, A1709 ) | A1031( A2115, A1709 );
"
22D55I36"75;
A1774: if( A2118 == (0x40 | 2) )"
64D58I4"76;
"
66D39I14"77;
A1776:
A17"
44D14I23"A1031( A2114, A1709 );
"
22D16I23"78;
A1777: if( A1709 & "
21D45I9"&& A1031("
50D62I8"8,0x04 )"
73D2I2"79"
12D2I2"80"
7D2I2"79"
10D21I2"|="
26D35
40D4I67"80: ;
A1778: ;
A1775: ;
A1772: ;
A1716:
if( A1709 & (0x04|0x800) ) "
12D24I4"81;
"
32D11I9"82;
A1781"
18D19I28"2118 == (0x400|19) && (A80 ="
24D3I11"8->A566) ) "
11D2I14"83;
goto A1784"
7D4I4"83:
"
9D11I14"80->A127 & (A2"
16D1I2"10"
13D2I2"85"
12D2I2"86"
7D4I44"85:
A1754 |= 0x04;
A1786: ;
A1784: ;
A1782:
"
9D18I21"1709 & 0x800 && A2114"
29D2I2"87"
12D2I2"88"
7D25I4"87:
"
30D13I26"2118 == (0x200 | 0x80 | 1)"
23D3I3"889"
12D45I44"890;
A1889:
A1754 |= A1031( A2114, 0x800 );
"
52D10I10"891;
A1890"
17D24I25"2118 == (0x200 | 0x80 | 3"
35D3I3"892"
12D39I27"893;
A1892:
A1754 |= A1031("
45D46
54D10I3"0x8"
18D27I3"893"
33D15I14"891: ;
A1788:
"
27D9I3"0x1"
22D3I3"894"
12D10I10"895;
A1894"
17I52"492( A1718->A567) == 33 && A1031( A1718, 0x04 )
||
A"
16D3I28"1) && A1031( A2114, 0x800 )
"
12D3I3"896"
12D10I10"897;
A1896"
21D19I35"0x1000;
A1897: ;
A1895:
if( A1709 &"
24D6I3" ) "
13D17I28"898;
goto A1899;
A1898:
if( "
29D7I1"4"
14D2I43") goto A1900;
goto A1901;
A1900:
if( A1031("
7D17I3"4, "
22D15I1")"
25D3I3"902"
12D10I50"903;
A1902: A1754 |= 0x20;
A1903: ;
A1901: ;
A1899"
18D54I33"709 & 0x02 && A1718->A571 & 0x001"
64D3I3"904"
12D10I10"905;
A1904"
21D42I13"0x02;
A1905:
"
47D30I14"1709 & 0x10 &&"
40D3I10"71 & 0x002"
13D3I3"906"
12D10I10"907;
A1906"
21D11I3"0x1"
16D57I7"907:
if"
62D32I13"09 & 0x80 && "
37D155I56"->A571 & 0x004 ) goto A1908;
goto A1909;
A1908:
A1754 |="
160D8I29";
A1909:
if( A1709 & 0x100 &&"
13D23I14"8 == (0x400|19"
34D3I3"910"
12D12I56"911;
A1910: A1754 |= 0x100; A575 = A1718->A566; 
A1911:
"
17D16I22"1709 & (0x200 | 0x400)"
26D3I3"912"
12D110I19"913;
A1912:
A2115 ="
117D32I22"? A2114->A563 : NULL;
"
37D2I98"1709 & 0x400 && A2118 == (0x200|0x40 | 14) &&
A1031( A2114, 0x04 ) && A2115 && A2115->A566 == A575"
12D3I3"914"
12D80I10"915;
A1914"
85D2I18"54 |= 0x400;
A1915"
9D1I11"1709 & 0x20"
6D46I6"(A2118"
51D10I71"0x200|0x40 | 14) || A2118 == (0x200|0x40 | 13)) &&
A1031( A2114, 0x02 )"
16D15I19"031( A2115, 0x100 )"
25D3I3"916"
12D38I55"917;
A1916:
A1754 |= 0x200;
A1917:
if( A1709 & 0x200 &&"
43D69I18"8 == (0x40 | 1) &&"
75D38I4" &&
"
43D191I78"->A564 == (0x200 | 0x80 | 1) ) goto A1918;
goto A1919;
A1918:
A1754 |= A1031( "
196D3I33"->A562, 0x200 );
A1919: ;
A1913:
"
9D39I20" A1754;
}
A79
A1032("
45D25I20"A1731)
struct A561 *"
30D7I15";
A87 *A1731;
{"
13D3I3"171"
37D31I1"
"
36D19I16"1718->A570.A6232"
52D21I9"
*A1731 ="
31D4I46"70.A6233;
return A1718->A570.A6232;
goto A1715"
18D19I15"1718->A570.A548"
31D1I1"6"
12D1I1"7"
7D28I38"6:
*A1731 = 0;
return A1718->A570.A548"
34D1I1"7"
9D17I97"5: ;
A1712:
return 0;
}
Void
A5671( A1718, A2313 )
struct A561 *A1718;
A79 A2313;
{
struct A561 *"
22I84", *A2115;
A81 A80;
struct A147 *A2318;
A21 A4221;
if( !A1718 ) return;
A2114 = A1718"
5D99
108D6I36"114 ) goto A1711;
goto A1712;
A1711:"
11I8"5 = A211"
6D25I3"3;
"
34D13I1"3"
19D22I15"2: A2115 = NULL"
27D57I44"13:
switch( A1718->A564 )
{
case (0x400|19):"
62D3I19"(A80 = A1718->A566)"
9D8I73"2318 = ( (A80)->A156 == (A41) 19 ? (A80)->A155.A148 : (struct A147 *) 0 )"
20D2I2"15"
12D2I2"16"
7D36I46"15:
A4221 = A748( A492( A780( A80->A130 ) ) );"
42D12I28"2318->A552 & 0x4000 && A2318"
17D1I12"61 <= A2313 "
11D2I2"17"
13D1I1"0"
6D23I44"17:
A2318->A5661 = 0;
A1115( &A2318->A5663 )"
29D57I1"0"
64D13I30"4221 & ((A21) 0x40 | (A21) 1) "
24D1I1"1"
11D2I2"22"
7D13I31"21:
if( A2318->A548 <= A2313 ) "
21D2I14"23;
goto A1725"
8D8I14"3: A2318->A548"
13D21I30" A1115( &A2318->A554 ); 
A1725"
28D18I20"2318->A549 <= A2313 "
28D2I2"26"
12D2I2"27"
7D74I88"26: A2318->A549 = 0; A1115( &A2318->A555 ); 
A1727: ;
A1722: ;
A1716:
goto A1714;
case ("
80D93I1"|"
98D4I80" | 1):
case (0x200 | 0x80 | 3):
case (0x200 | 0x80 | 2):
A5671( A2115, A2313 );
"
12D2I94"14;
case (0x200|0x20 | 1):
case (0x200|0x20 | 3):
A5671( A2114, A2313 );
A5671( A2115, A2313 )"
12D42I98"14;
case (0x40 | 9):
case (0x40 | 11):
case (0x40 | 10):
case (0x40 | 12):
A5671( A2114, A2313 );
"
50D34I13"14;
default:
"
42D23I98"14;
}
A1714: ;
}
Void
A5672( A1718, A2313 )
struct A561 *A1718;
A79 A2313;
{
if( !A1718 ) return;
"
28D14I24"1718->A564 == (0x400|19)"
19D19I25"492(A1718->A567) == 25 ) "
27D2I2"11"
12D2I2"12"
7D11I24"11:
A5671( A1718, A2313 "
17D18I26"12: ;
}
Void
A8401( A1718,"
23D1I101"6 )
struct A561 *A1718;
A17 A1836;
{ 
A1711:
if( !A1718 ) goto A1712;
A1718->A571 |= A1836;
if( A1718"
6D15I89"4 != (0x200|0x40 | 14) ) goto A1712;
A1718 = A1718->A562;
goto A1711;
A1712: ;
}
A4
A2290"
20D13I10"18, A2291,"
18D103I168"9 )
struct A561 *A1718;
A91 A2291;
A87 A2069;
{A79 A2292, A2293, A6256, A5697; A87 A6257, A5698; A23 A2296; struct A553 *A2297=0, *A2298=0, *A6258=0, *A5699=0, *A2300=0"
109D178I38"!A1718 ) return (A4) 0;
A2292 = (A1718"
184D176I1")"
181D61I16"; A2293 = (A1718"
67D12I22").A549; A6256 = (A1718"
18D71I1")"
77D9I16"; A6257 = (A1718"
15I1")"
6D50I16"; A5697 = (A1718"
56D13I23").A5661; A5698 = (A1718"
19D13I23").A5662; A2296 = (A1718"
19I86").A552; A2297 
= (A1718->A570).A554; A2298 = (A1718->A570).A555; A6258 = (A1718->A570)"
5D29I31"4; A5699 = (A1718->A570).A5663;"
34D55I26"0 = (A1718->A570).A557;
if"
60D26I70"91 == (A91) 0x10 )
return A2069 && A2292 == 4 || !A2069 && A2293 == 4;"
32D76I6"6256 !"
82D44I6"return"
50D23I25"0;
switch( A2291 )
{
case"
30D105I30"6: return A6257 <= A2069;
case"
112D36I180"4: return A6257 < A2069;
case (A91) 2: return A6257 >= A2069;
case (A91) 0: return A6257 > A2069;
case (A91) 1: return A6257 != A2069;
case (A91) 3: return A6257 == A2069;
default:"
45D2I74"11;
}
A1711:
return (A4) 0;
}
A17
A5512( A1718, A1709 )
struct A561 *A1718"
7D16I43" A1709;
{
struct A561 *A2114, *A2115 = NULL"
21D31I39" A1754 = 0;
A17 A5554;
A40 A2118;
if( !"
36D18I15" ) return A1754"
25D20I18"2114 = A1718->A562"
30D3I3"711"
12D186I16"712;
A1711:
A211"
191D10I9"2114->A56"
15D24I80"712:
A2118 = A1718->A564;
switch( A2118 )
{
case (0x400|19): A5554 = (A17) 0x40;"
32D22I26"713;
case (0x200|0x10 | 2)"
27D19I14"54 = (A17) 1; "
26D46I49"713;
case (0x200|0x10|0x04 | 1): A5554 = (A17) 2;"
54D42I11"713;
case ("
47D49I33"|0x10 | 1): A5554 = (A17) 4; goto"
54D21I48"3;
case (0x200|0x10|0x04 | 2): A5554 = (A17) 8; "
28D86I47"713;
case (0x200|0x10 | 3): A5554 = (A17) 0x10;"
94D5I53"713;
case (0x200|0x10|0x04 | 3): A5554 = (A17) 0x20; "
12D42I41"713;
case (0x40 | 1): A5554 = (A17) 0x80;"
50D5I43"713;
case (0x40 | 9): A5554 = (A17) 0x100; "
12D50I48"713;
case (0x40 | 10): A5554 = (A17) 0x100; goto"
55D22I41"3;
case (0x40 | 11): A5554 = (A17) 0x200;"
30D5I44"713;
case (0x40 | 12): A5554 = (A17) 0x200; "
12D65I56"713;
case 0x100|(0x200|0x20 | 1) : A5554 = (A17) 0x400 ;"
73D5I57"713;
case 0x100|(0x200|0x20 | 3) : A5554 = (A17) 0x800 ; "
12D36I63"713;
case 0x100|(0x200 | 0x80 | 1) : A5554 = (A17) 0x400 ; goto"
41D67I56"3;
case 0x100|(0x200 | 0x80 | 2) : A5554 = (A17) 0x800 ;"
75D5I63"713;
case (0x200|0x40 | 4): A5554 = (A17) 0x1000|(A17) 0x4000; "
12D11I39"713;
case (0x200|0x40 | 15): A5554 = 0;"
18D34I3"709"
39D7I7"17) 0x4"
20D3I3"714"
12D48I1"7"
54D15I81"714:
A1754 = A5512( A2114, (A17) 0x4000 ) |
A5512( A2115, (A17) 0x4000 );
A1715:
"
22D5I25"713;
default: A5554 = 0; "
12D10I12"713;
}
A1713"
17D19I12"5554 & A1709"
28D4I4"1716"
12D56I13"1717;
A1716: "
61D18I17"5554 == (A17) 0x4"
28D4I4"1720"
12D41I24"1721;
A1720: if( A5511 ="
47D55
60D26I1"6"
35D4I4"1722"
12D138I34"1723;
A1722: A1754 |= (A17) 0x40; "
143D4I13"5511 == A8770"
15D2I2"25"
12D2I2"26"
7D4I67"25: A8770 = NULL;
A1726: ; 
A1723: ; goto A1727;
A1721: if( A5512( "
9D48I7", (A17)"
53D1I2" )"
12D2I2"66"
12D2I2"67"
7D44I31"66: if( A1709 & (A17) 0x4000 &&"
49D50I4"4 ) "
58D35I4"68;
"
43D14I2"69"
19D23I35"68: A5512( A2114->A563, (A17) 0x400"
28D10I31"A1769: A1754 |= A5554; 
A1767: "
15D44I6"27: ; "
49D24I1"7"
31D6I12"1709 & (A17)"
12I1"0"
11D2I2"70"
12D2I2"71"
7D2I2"70"
12D25I14"8 == (0x40 | 2"
37D13I14"72;
goto A1773"
18D12I18"72: A1754 |= A5512"
18D12I9"4, (A17) "
17D45I28"0 );
goto A1774;
A1773: if( "
50D40I69"8 == (0x200|0x10 | 3) || A2118 == (0x200|0x10|0x04 | 3) ) && A2114 ) "
48D45I34"75;
goto A1776;
A1775:
if( A1031( "
50D8I23"->A563, 0x80 ) &&
A5512"
14D21I18"4, (A17) 0x40 ) ) "
29D16I3"77;"
25D2I2"78"
7D16I36"77:
A1754 |= (A17) 0x2000;
A1778: ;
"
24D14I2"79"
19D32I8"76: if( "
37D23I64" == (0x400|19) && (A5511 = A1718->A566) ) goto A1780;
goto A1781"
28D4I25"80:
A1754 |= (A17) 0x2000"
9D2I2"81"
9D2I2"79"
9D2I11"74: ;
A1771"
12D27I17"1754;
}
A81
A7522"
37D4I11"2114, A2128"
25D74I176", *A2114;
A78 A2128;
{
A81 A80; A81 A1942; A9070 A2307;
A2307 = A2128 &
((A78) 0x02 | (A78) 0x01 | (A78) 0x08 | (A78) 0x04 | (A78) 0x20) ?
(A27) 0x04 : (A27) 0x800;
A80 = A2114"
79D3I26"6; if( (A1309 > 0) ) goto "
8D1I21";
goto A1712;
A1711: "
6D15I16"80 && !A80->A160"
27D1I1"3"
12D1I1"4"
7D34I38"3: A1135( A80, (A27) 0x1000, 0, 0, 0 )"
40D37I18"4: if( !A80 ) goto"
42D42I34"5;
goto A1716;
A1715: A80 = A1041("
47D157I2"4 "
164D1I23"6: ; 
goto A1717;
A1712"
6D17I5" A80 "
27D2I2"20"
12D2I2"21"
7D42I73"20: A425 = A2307; A1135( A80, (A27) 0x1000, 0, 0, 0 ); return A80;
A1721:"
47D57I2"7:"
63D4I52"80 && A80->A127 & (A27) 0x02 ) return A80; if( A2307"
9D22I13"A27) 0x800 &&"
27D3I16"8->A567 != 24 ) "
11D2I14"22;
goto A1723"
7D54I62"22:
A1942 = A80 ? A80 : A7508( A2114 ); A895( 534, A1942 , 0 )"
60D63I28"23:
return A80; }
Void
A2301"
72D47I12"A2114, A2128"
52D20I18"02 )
struct A561 *"
27D48I17"*A2114;
A78 A2128"
53D2I103"02;
{
A70 A2060;
A78 A2303;
A81 A80;
A42 A2278;
A7 A1730;
A78 A2304;
A44 A4210 = 0; A4 A7898; A13 A2305"
7D24I61"06;
struct A561 *A1835;
A95 *A1748 = NULL;
A94 *A8294 = NULL;"
29D16I107"!A2114 ) return;
A7898 = A7757( A2114 ); A80 = A7522( A1718, A2114, A2128 );
A2278 = A1718->A568;
if( A2278"
27D2I2"11"
12D2I2"12"
7D43I34"11: A4210 = A2133( A2278, 0xF8 ); "
48D9I19"4210 & (A44) 0x0004"
20D2I2"13"
12D2I2"14"
7D10I24"13: A7847( (A44) 0x0004,"
16D69I8"->A569 )"
74D2I2"14"
9D17I19"4210 & (A44) 0x0010"
28D2I2"15"
12D2I2"16"
7D46I29"15:
A2302 |= (A78) 0x40000000"
51D85I4"16: "
90D71I29"12:
A2060 = A492( A2114->A567"
76D27I96"2303 = ( (A2060) == 28 || (A2060) == 35 ) ? (A78) 0x10 : (A78) 0x10|(A78) 0x02;
A2303 |= A2302;
"
32D13I40"2278 && A2114->A564 == (0x200|0x40 | 13)"
24D2I2"17"
12D2I2"20"
7D73I23"17:
A2114->A568 = A2278"
78D63I8"20:
A583"
69D63I24"4, A2303 );
A2306 = A227"
68D19I89"0x800 ? 2 : 1;
if( A80 && (A1288 > 0) ) goto A1721;
goto A1722;
A1721:
A1730 = 0, A1835 ="
24D177I1"4"
182D45I3"26:"
51D21I18"1835 = A1835->A563"
31D1I1"2"
12D2I2"25"
7D37I12"23:
++A1730;"
46D2I2"26"
7D98I33"25:
A1748 = A1116((A8198)A1730+1)"
103D45I13"22:
A2305 = 1"
50D180I3"67:"
185D109I14"A2305 <= A2306"
119D2I2"27"
12D2I2"66"
7D11I50"68: A2305++;
goto A1767;
A1727:
A1730 = 0;
A1835 ="
16D21I8"4;
A1771"
28D19I18"1835 = A1835->A563"
29D2I2"69"
12D2I2"70"
7D83I44"69:
{
A58 A1740;
A4 A2308 = (A4) 0;
++A1730;"
89D9I54"80 && A80->A127 & (A27) 0x200 && !(A1496||(A1266 > 0))"
20D2I2"72"
12D2I2"73"
7D17I18"72:
A2308 = (A4) 1"
22D2I2"73"
10D17I13"278 == 0x800 "
27D2I2"74"
12D2I2"75"
7D54I34"74:
if( A2305 == 1 && A1730 == 1 )"
63D18I34"71;
if( A2305 == 2 && A1730 > 1 ) "
26D12I3"70;"
21D25I2"76"
30D2I2"75"
10D14I37"278 == 0x1500 && A2273( A1835, 1 ) )
"
22D2I2"77"
12D2I2"78"
7D31I41"77:A865(432);
A1778:
A1776:
A1740 = A1835"
36D107I33"7;
A2060 = A492( A1740 );
A2304 ="
112D1I95"0 == 33 ? (A78) 0x02 | (A78) 0x800000 : (A78) 0x02;
A2304 = A2304 | A2302 |
A1988(A1740, (A4) 1"
6D13I17"08);
if( A2278 ) "
21D2I14"79;
goto A1780"
7D202I17"79: A2304 |= A104"
207D31I10"278, A1730"
36D10I16"1780:
A583( A183"
15D23I2"30"
28I12"if( A1748 ) "
8D55I4"81;
"
63D14I2"82"
19D76I39"81:
A1117( &A1748->A8277[A1730], &A1835"
82D10I50", A1835 );
if( A2304 & (A78) 0x800 || (A1252 <= 0)"
21D1I1"8"
12D1I1"8"
7D59I2"83"
64D22I26"48->A8277[A1730].A552 &= ~"
27D19I161";
A1784: ;
A1782:
if( A2304 & (A78) 0x10000 && A1835->A570.A548 &&
A2060 == 25 ) goto A1785;
goto A1786;
A1785:
A2110( A1835->A570.A548, A1835->A570.A554, A1730,"
25D35
40D43I81"1786:
if( A2304 & (A78) 0x100000 && A1835->A570.A6232 &&
A1835->A570.A6233 < 0
) "
51D48I34"87;
goto A1788;
A1787:
A1015( A183"
61D16I6", A183"
28D11I45"4, A1835->A570.A6233, A1730, A2114 );
A1788:
"
16D4I19"2304 & (A78) 0x2000"
14D3I3"889"
12D82I2"89"
87D19I31"889: A2277( A2278, A1730, A1835"
25D18I31"890:
if( A2304 & (A78) 0x40000 "
27D25I33"891;
goto A1892;
A1891:
if( A1835"
34D51I7"48 == 4"
61D2I2"89"
12D2I2"89"
7D2I2"89"
7D92I69"559.A1557 = (A4) 1;
A1894:
A1996( A1835, (A91) 0x10, (A87) 1, 4, NULL"
98D36I2"89"
44D4I20"2304 & (A78) 0x10000"
14D3I3"895"
12D3I79"896;
A1895:
A1996( A1835, (A91) 0x10, (A87) 1, 4, NULL );
A1896: ;
} goto A1771"
8D64I16"70: ;
goto A1768"
69D3I55"66:
A1748 = A1087( A80, A1748, A1718, (A4) 0, &A8294 );"
9D4I20"7898 && A80 && A1748"
14D3I3"897"
13D71I2"98"
76D4I143"97:
{
struct A149 *A1948 = ( ( A80 )->A156 == (A41) 20 ? ( A80 )->A155.A150 : (struct A149 *) 0 );
struct A5487 *A5585;
A81 A4855;
if( A1948 ) "
11D29I16"899;
goto A1900;"
34D67I32"9:
A5585 = A1948->A7653;
A1903:
"
73D4I12"585 && A1748"
13D3I3"901"
12D73I34"902;
A1904: A5585 = A5585->A5488;
"
80D50I45"903;
A1901:
A4855 = A5585->A5489;
if( !A4855 "
59D4I153"904;
A4855->A127 |= ((A27) 0x1000 | (A27) 0x2000000);
A1158(A4855);
A1748 = A1087( A4855, A1748, A1718, (A4) 1, &A8294 );
goto A1904;
A1902: ;
A1900: ;
}"
9D65I22"8:
A5545( A80, A7898 )"
72D4I26"80 && (A1256 > 0) && A1748"
14D3I3"905"
12D108I3"906"
114D35I1"5"
41D5I24"!(A2278 && A2136(A2278))"
17D1I1"7"
12D1I1"8"
7D35I16"7:
A1117( &A1718"
41D19I24", &A1748->A8277[0], A171"
24D7
12D4I10"80 == A415"
16D1I1"9"
11D2I2"10"
8D35I16"9: A1121( &A1718"
41D19I2", "
27D4I25"10: ;
A1908:
if( A8294 ) "
11D29I66"911;
goto A1912;
A1911:
A8413( A415, A80, A8294, A1718 );
A1912: ;"
34D8I8"6:
A1835"
15I26"4;
A1915:
if( A1835 = A183"
5D57I2"63"
67D2I2"13"
12D2I2"14"
7D23I19"13:
if( A1988( A183"
28D36I37"67, (A4) 1, (A4) 0 ) & (A78) 0x1000 )"
46D1I13"6;
goto A1917"
6D17I18"16:
A5672( A1718, "
26D18I5"7: ;
"
26D1I1"1"
7D78I12"14:
if(A2278"
89D1I1"8"
12D1I1"9"
7D63I29"8:
if( A4210 & (A44) 0x0008 )"
70D53I6"2330;
"
59D11I54"2331;
A2330:
A7847( (A44) 0x0008, A1718->A569 );
A2331"
18D4I19"4210 & (A44) 0x0800"
13D4I4"2332"
12D18I18"2333;
A2332:
A7756"
25I29" );
A2333:
A218( A1718, A2114"
5D41I2"78"
49D1I1"9"
7D5I57"(A7802 > 0) && A492( A1718->A567 ) == 25 && !A2136(A2278)"
14D4I4"2334"
12D20I102"2335;
A2334: A2798(A1718);
A2335: ; }
A5794
A1035( A1718 )
struct A561 *A1718;
{
struct A561 *A2114, *"
25D8I5";
A40"
13D44I33"8;
A5794 A2309 = "";
if( A1718 ) "
52D56I23"11;
goto A1712;
A1711:
"
61D6I46" = A1718->A562;
A2118 = A1718->A564;
if( A2118"
11D3I3"400"
12D4I4"1713"
12D18I52"1714;
A1713:
{
A87 A2070 = A1718->A570.A6233;
switch"
24D39I49"8 )
{
case (0x400|19):
A2309 = A1718->A566->A129;"
48D2I2"15"
13I22"if( A1718->A567 & 1 ) "
8D89I2"16"
97D4I4"1717"
9D16I28"16:
A2309 = A6237( A2070 );
"
22D5I64"1720;
A1717: A2309 = A6238( (A88) A2070 );
A1720: ;
}
A1715: ;
}"
12D59I15"1721;
A1714: if"
65D33I12"8 & 0x200 ) "
39D31I25"1722;
goto A1723;
A1722:
"
37D15I29"114 && (A2115 = A2114->A563) "
23D113I32"1725;
return "";
A1725:
{
switch"
119D46I5"8 )
{"
55I6"200|0x"
5D12I38"5):
A2309 = A866( "($s?$s:$s)", A1035("
17D28I35"),
A1035(A2115), A1035(A2115->A563)"
38D22I13"1726;
default"
27D27I69"09 = A866( "($s$s$s)",
A1035(A2114), A1610( A2118 ), A1035(A2115) );
"
33D5I18"1726;
}
A1726: ;
}"
12D75I23"1727;
A1723: if( A2114 "
83D57I4"1766"
65D104I55"1767;
A1766:
A2309 = A866( "$s$s", A1610(A2118), A1035("
109D208I7"), NULL"
213D53I4"1767"
58D12I7"1727: ;"
17D17I24"1: ;
A1712:
return A2309"
27D4I4"9135"
11D28
51D33I2"{
"
42D338I20"61 *A2114;
A40 A2118"
345D7
12D7
18I42"A2114 = A1718->A562;
A2118 = A1718->A564;
"
5D66I4"2118"
71D6I10"0x40 | 10)"
12D3I3"118"
8D15I18"0x40 | 9) ||
A2118"
20D16I19"0x40 | 12) || A2118"
21D20I9"0x40 | 11"
55D89I171"switch( A2114->A564 )
{
case (0x400|19):
case (0x200|0x40 | 13):
case (0x200|0x40 | 14):
case (0x200|0x40 | 22):
case (0x200|0x40 | 23):
case (0x40 | 1):
return;
default:
"
101D11I1"}"
18D10I32" ;
A1712:
A6172( A9169, "" );
}
"
18D149I12"561 *
A1034("
154D1I88"8, A1875 )
struct A561 *A1718;
int A1875;
{
struct A561 *A1731;
if( !A1718 ) return NULL"
6D4I16"31 = A1718->A562"
10D107I61"1:if( A1731 && A1875-- ) goto A1712;
goto A1713;
A1712: A1731"
113D19I194"31->A563; goto A1711;
A1713:
return A1731;
}
Void
A2311( A2118, A1718, A2291, A2069, A2312, A2313, A2314 )
A40 A2118;
struct A561 *A1718;
A91 A2291;
A87 A2069;
A87 A2312;
A79 A2313; struct A553 "
24D13I13"4;
{
A88 A184"
18D137I31"A88) A2312;
A88 A2070;
A91 A231"
142D107I20"A91) 0;
Void A2316()"
112D2I55"11: if(A2291==(A91) 0x10) goto A1714;
goto A1715;
A1714"
8D37I32"1=A2069?(A91) 3:(A91) 1; A2069=0"
43D2I12"15: ; 
A1712"
17D2I2"11"
7D58I55"13:
A2070 = (A88) A2069;
if( A2118 == (0x200|0x20 | 6) "
68D2I14"16;
goto A1717"
7D45I54"16: A2315 = (A91) 0x03; A1841 = ~A1841; A2070 = ~A2070"
51D7I25"17:
if( A2291 == (A91) 1 "
18D1I13"0;
goto A1721"
6D103I57"20:
A2316( A1718, ((A91) 0x40 | (A91) 0x3) ^ A2315, A1841"
108D2I2"07"
8D19I93"13, A2314 );
A2316( A1718, ((A91) 0x40 | (A91) 0x0) ^ A2315, A1841 & ~A2070, A2313, A2314 );
"
27D2I2"22"
7D45I25"21: if( A2291 == (A91) 3 "
56D1I13"3;
goto A1725"
7D31I1"3"
37D14I20"!!(~(A1841)&(A2070))"
25D4I21"26;
if( A2070 == 0 ) "
12D2I14"27;
goto A1766"
7D4I94"27:
A2316( A1718, ((A91) 0x40 | (A91) 0x2) ^ A2315, A1841, A2313, A2314 );
goto A1767;
A1766: "
9D25I20"231( A1841 ) == 1 ) "
33D2I2"68"
12D2I2"69"
7D43I22"68:
if( A1841 & A2070 "
54D9I2"0;"
19D1I1"1"
7D33I2"0:"
38D17I36"6( A1718, ((A91) 0x40 | (A91) 0x0) ^"
22D17I26"5, A1841, A2313, A2314 );
"
25D14I2"72"
19D18I10"71: A2316("
24D6I55", ((A91) 0x40 | (A91) 0x3) ^ A2315, A1841, A2313, A2314"
13D19I6"72: ;
"
27D2I2"73"
7D33I2"69"
40D22I13"1841 == A2070"
33D2I2"74"
12D2I2"75"
7D3I44"74:
A2316( A1718, ((A91) 0x40 | (A91) 0x1) ^"
8D10I24"5, A1841, A2313, A2314 )"
15D10I123"75: ;
A1773: ;
A1767: ;
A1726: ;
A1725: ;
A1722: ;
}
Void
A5307( A2118, A5308, A5309 )
A40 A2118;
A91 *A5308;
A87 *A5309;
{"
17D9I183"118 == (0x200|0x10 | 3) || A2118 == (0x200|0x10|0x04 | 3) || A2118 == (0x200|0x10 | 1) ||
A2118 == (0x200|0x10|0x04 | 2) || A2118 == (0x200|0x10 | 2) || A2118 == (0x200|0x10|0x04 | 1)"
20D16I4"11;
"
23D27I17"712;
A1711:
{
A91"
32D10I56"1 = *A5308;
A87 A2069 = *A5309;
if( A2310( A2291, A2069 "
21D3I3"713"
12D11I72"714;
A1713: *A5308 = (A91) 0x10; *A5309 = 1; 
goto A1715;
A1714: if( ((("
16D37I13"1)==(A91) 1||"
43D1I38"1)==(A91) 0x10) && ( A2069 )==(A87) 0)"
11D3I3"716"
12D49I43"717;
A1716: *A5308 = (A91) 0x10; *A5309 = 0"
54D27I3"717"
33D42I38"715: ;
}
A1712: ;
}
Void
A5700( A1718,"
47D8I10"1, A2069, "
13D35I33", A2314 )
struct A561 *A1718;
A91"
40D8I18"1;
A87 A2069;
A79 "
13D101I76"; struct A553 *A2314;
{
struct A561 *A2114, *A2115;
A40 A2118;
if( !A1718 ||"
106D11I94"1 == (A91) 0x20 ) return;
A1022++;
A2114 = A1718->A562;
A2118 = A1718->A564;
if( A2118 & 0x400"
21D3I3"711"
12D11I50"712;
A1711:
switch( A2118 )
{
case (0x400|19):
if("
16D44I15"1 != (A91) 0x20"
54D1I1"7"
12D1I1"7"
7D19I11"714:
A5673("
25D6I28", A2291, A2069, A2313, A2314"
12D20I5"715:
"
27D34I37"713;
case (0x400|18):
if( A2313 == 4 "
43D38I5"716;
"
45D5I59"717;
A1716:
A2115 = A2114;
A1722:
if( A2115 = A2115->A563) "
12D55I5"720;
"
62D44I10"721;
A1720"
49D2I65"96( A2115, (A91) 0x20, (A87) 0, A2313, A2314 ); goto A1722;
A1721"
7D28I8"17:
goto"
33D15I12"3;
default:
"
21D4I15"1713;
}
A1713: "
12D48I31"1723;
A1712: if( A2118 & 0x200 "
56D4I4"1725"
12D32I40"1726;
A1725:
if( A2114 && (A2115 = A2114"
37D21I5"3) ) "
29D16I21"27;
goto A2100;
A1727"
24D12I11"118 & 0x100"
21D4I4"1766"
12D34I57"1767;
A1766:
A5700( A2114, A2291, A2069, A2313, A2314 );
"
40D35I235"1768;
A1767:
{A79 A5701; struct A553 *A5702 = NULL; A79 A5703; struct A553 *A5704 = NULL;
A79 A5705; struct A553 *A5706 = NULL; A79 A5707; struct A553 *A5708 = NULL;
switch( A2118 )
{
case (0x200|0x40 | 4):
A5700( A2114, A2291, A2069, "
40D9I53", A2314 );
A5700( A2115, A2291, A2069, A2313, A2314 )"
17D13I29"1769;
case (0x200|0x40 | 5):
"
18D22I20"2114->A570.A549 == 4"
31D4I4"1770"
12D12I40"1771;
A1770:
A5700( A2115, A2291, A2069,"
17D26I31"3, A2314 );
goto A1772;
A1771: "
32D19I19"114->A570.A548 == 4"
28D4I4"1773"
12D16I32"1774;
A1773:
A5700( A2115->A563,"
21D5I10"1, A2069, "
10D4I25", A2314 );
A1774:
A1772:
"
10D32I64"1769;
case (0x200|0x40 | 15):
A1996( A2114, (A91) 0x20, (A87) 0,"
38D15
25D4I14"
A5700( A2115,"
9D4I26"1, A2069, A2313, A2314 );
"
10D6I114"1769;
case (0x200 | 0x80 | 1):
A1775: A5703 = A2115->A570.A6232 <= A2313 ? A2115->A570.A6232 : A2313; if( A5703 ) "
12D65I6"1778;
"
71D36I73"1779;
A1778: A1085(& A5704, A2115->A570.A6234 ); A1111( & A5704, A2314 );"
43D37I51"1780;
A1779: A1115( & A5704 );
A1780: ; 
A1776:if(0"
45D37I42"1775;
A1777: A5705 = A2114->A570.A5661 <= "
43D23I39"? A2114->A570.A5661 : A2313; if( A5705 "
31D28I6"1783;
"
34D22I74"1784;
A1783: A1085(& A5706, A2114->A570.A5663 ); A1111( & A5706, A2314 ); "
30D31I49"85;
A1784: A1115( & A5706 );
A1785: ; 
A1781:if(0"
39D6I25"1777;
A1782:
if( A5703 ) "
12D35I6"1786;
"
41D24I26"1787;
A1786: A5700( A2114,"
29D35I51"1, A2069-A2115->A570.A6233, A5703, A5704 );
A1787:
"
40D4I4"5705"
13D4I4"1788"
12D39I71"1889;
A1788: A1996( A2115, A2291, A2069-A2114->A570.A5662, A5705, A5706"
44D21I6"1889:
"
27D72I67"1769;
case (0x200 | 0x80 | 3):
A1890: A5701 = A2114->A570.A6232 <= "
78D1I38"? A2114->A570.A6232 : A2313; if( A5701"
10D4I4"1893"
12D55I73"1894;
A1893: A1085(& A5702, A2114->A570.A6234 ); A1111( & A5702, A2314 );"
62D11I36"1895;
A1894: A1115( & A5702 );
A1895"
17D4I4"1891"
17D13I77"1890;
A1892: A5707 = A2115->A570.A5661 <= A2313 ? A2115->A570.A5661 : A2313; "
18D10I4"5707"
19D4I4"1898"
12D38I73"1899;
A1898: A1085(& A5708, A2115->A570.A5663 ); A1111( & A5708, A2314 );"
45D35I12"1900;
A1899:"
44D15I25" A5708 );
A1900: ; 
A1896"
28D33I25"1892;
A1897:
if( A5707 ) "
39D35I6"1901;
"
41D24I26"1902;
A1901: A1996( A2114,"
29D35I51"1, A2069-A2115->A570.A5662, A5707, A5708 );
A1902:
"
40D4I4"5701"
13D4I4"1903"
12D39I71"1904;
A1903: A5700( A2115, A2291, A2069-A2115->A570.A5662, A5701, A5702"
44D21I6"1904:
"
27D72I67"1769;
case (0x200 | 0x80 | 2):
A1905: A5703 = A2115->A570.A6232 <= "
78D1I38"? A2115->A570.A6232 : A2313; if( A5703"
10D4I4"1908"
12D55I73"1909;
A1908: A1085(& A5704, A2115->A570.A6234 ); A1111( & A5704, A2314 );"
62D11I36"1910;
A1909: A1115( & A5704 );
A1910"
17D4I4"1906"
17D16I41"1905;
A1907: A5705 = A2114->A570.A5661 <="
23D4I38"? A2114->A570.A5661 : A2313; if( A5705"
13D4I4"1913"
12D22I47"1914;
A1913: A1085(& A5706, A2114->A570.A5663 )"
28D25I20"1( & A5706, A2314 );"
32D36I51"1915;
A1914: A1115( & A5706 );
A1915: ; 
A1911:if(0"
44D6I25"1907;
A1912:
if( A5703 ) "
12D39I6"1916;
"
45D6I94"1917;
A1916: A5700( A2114, A2291, A2069+A2115->A570.A6233, A5703, A5704 );
A1917:
if( A5705 ) "
12D56I6"1918;
"
62D14I81"1919;
A1918: A1996( A2115, A2291, A2114->A570.A5662-A2069, A5705, A5706 );
A1919:"
21D11I52"1769;
case (0x200|0x40 | 14):
case (0x200|0x40 | 13)"
18D9I18"2114->A571 & 0x001"
19D3I3"330"
12D25I40"331;
A2330:
A5700( A2115, A2291, A2069, "
30D4I18", A2314 );
A2331:
"
10D5I14"1769;
default:"
12D32I18"1769;
}
A1769:A111"
37D84I4"5702"
89D21I61"1115( &A5706 );
A1115( &A5704 );
A1115( &A5708 );
}
A1768: ;
"
28D34I22"332;
A1726: if( A2114 "
43D39I4"333;"
46D5I36"2334;
A2333:
switch( A1718->A564 )
{"
12D25I31"0x40 | 9):
A5700( A2114, A2291,"
30D10I19"9, A2313, A2314 );
"
17D23I33"335;
case (0x40 | 10):
A2336: if("
28D34I12"1==(A91) 0x1"
44D10I22"339;
goto A2340;
A2339"
16D41I35"1= A2069 ?(A91) 3:(A91) 1; A2069 =0"
46D3I13"340: ; 
A2337"
17D37I25"336;
A2338:
A5700( A2114,"
43D62I27", A2069+1, A2313, A2314 );
"
69D27I36"335;
case (0x40 | 11):
A5700( A2114,"
32D5I10"1, A2069, "
10D4I11", A2314 );
"
11D23I33"335;
case (0x40 | 12):
A2341: if("
28D45I13"1==(A91) 0x10"
54D3I3"344"
12D49I51"345;
A2344: A2291= A2069 ?(A91) 3:(A91) 1; A2069 =0"
54D3I13"345: ; 
A2342"
17D58I25"341;
A2343:
A5700( A2114,"
63D8I12"1, A2069-1, "
13D5I11", A2314 );
"
12D5I65"335;
case (0x40|21):
case (0x40|25):
if( A2310( A2291, A2069 ) ) "
12D55I5"346;
"
62D2I2"34"
7D20I56"346:
A5700( A2114, (A91) 0x10, (A87) 1, A2313, A2314 );
"
27D51I19"348;
A2347: if( ((("
57D4I3")=="
10D1I47"1||( A2291)==(A91) 0x10) && ( A2069 )==(A87) 0)"
11D2I2"34"
12D2I2"35"
7D8I39"349:
A5700( A2114, (A91) 0x10, (A87) 0,"
14D31I25", A2314 );
A2350:
A2348:
"
38D4I13"335;
default:"
12D19I80"335;
}
A2335: ;
A2334:
A2332:
A1723:
A2100:
A1022--;
}
Void
A2317( A1718, A2291,"
25D18I1","
24D15
24D60I14"
struct A561 *"
65D84I27";
A91 A2291;
A87 A1868;
A79"
90D11I77"; struct A553 *A2314;
{struct A147 *A2318;
A70 A2060;
A315 A1742;
A81 A80;
A4"
16D4I29"9 = (A4) 0;
A79 A2292, A2293,"
10D5I13", A5697; A87 "
10D47I12", A5698; A23"
52D46I100"6; struct A553 *A2297=0, *A2298=0, *A6258=0, *A5699=0, *A2300=0;
A79 A2320, A2321, A1870, A5709; A87"
51D87I93"9, A5710; A23 A2324; struct A553 *A2325=0, *A2326=0, *A6260=0, *A5711=0, *A2328=0;
A39 A2329;"
92D62I4"!(A8"
67D4I93"1718->A566) ) return;
if( A80->A128 & (A28) 0x800 ) return;
A2329 = A80->A168.A166;
if( A2329"
10D93I81"39) 1 || A2329 == (A39) 7 || A2329 == (A39) 15 ||
A2329 == (A39) 4 && (A5649 > 0)"
102D4I4"1711"
12D27I106"1712;
A1711:
A2318 = ( (A80)->A156 == (A41) 19 ? (A80)->A155.A148 : (struct A147 *) 0 );
if( !A2318 ) goto"
32D33I3"3;
"
39D129I49"1714;
A1713:
A2318 = (struct A147 *)
A1005( A2329"
135D102I68"39) 1 ? A1383 : A1384 );
A2318->A547 = A80->A170;
A1715: (A80)->A156"
108D26I46"1) 19; (A80)->A155.A148 = A2318; 
A1716:if(0) "
34D36I119"15;
A1717: ;
A1714:
A1742 = ( A7174 = ( A80->A130 ), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) );
"
43D36I302" A1742->A303;
A2320 = (*A2318).A548; A2321 = (*A2318).A549; A1870 = (*A2318).A6232; A6259 = (*A2318).A6233; A5709 = (*A2318).A5661; A5710 = (*A2318).A5662; A2324 = (*A2318).A552; A2325 = (*A2318).A554; A2326 = (*A2318
).A555; A6260 = (*A2318).A6234; A5711 = (*A2318).A5663; A2328 = (*A2318).A557;
A1720"
46D11I19"( A2320); A1085( & "
16I7", A2325"
6D4I4"1723"
17D11I11"1720;
A1725"
23D2I5"A2321"
7D3I3"085"
12D14I7", A2326"
20D4I4"1726"
17D16I69"1725;
A1727: A6256 = ( A1870); A1085( & A6258, A6260 ); 
A1766:if(0) "
22D16I87"1727;
A1767: A5697 = ( A5709); A1085( & A5699, A5711 ); 
A1768:if(0) goto A1767;
A1769:"
21D61I52"6 = ( A2324); A1085( & A2300, A2328 ); 
A1770:if(0) "
67D6I56"1769;
A1771: A6257 = A6259; A5698 = A5710; 
A1721:if(0) "
12D13I43"1720;
A1722:
switch(A2291)
{
case (A91) 1:
"
19D13I12"313 >= A6256"
22D4I4"1773"
12D52I13"1774;
A1773:
"
57D7I25"1025 && A1868 != A6257 )
"
13D4I4"1775"
12D58I47"1776;
A1775: A6256 = 0; A1115( &A6258 ); 
A1777"
71D2I21"1775;
A1778:
goto A17"
7D65I37"1776: A6257 = A1868; 
A1780: A6256 = "
70D2I35"; A1085( &A6258, A2314 ); if( A6256"
11D4I4"1783"
12D30I39"1784;
A1783:A1112( &A6258 , A1718->A569"
35D4I4"1784"
10D4I4"1781"
17D11I11"1780;
A1782"
17D11I8"1779: ;
"
17D27I13"1785;
A1774: "
32D8
13D11I2"&&"
16D11I10"7 != A1868"
20D4I4"1786"
12D11I41"1787;
A1786: A2319 = (A4) 1;
A1787:
A1785"
18D25I13"2060 == 25 ) "
31D6I18"1788;
if( A1868 ) "
12D54I6"1889;
"
60D32I13"1890;
A1889: "
42D18I9"< (A2313)"
27D4I4"1895"
12D20I12"1896;
A1895:"
25D22I46"3 = A2313; A1085( &A2298, A2314 ); if( A2293 )"
29D86I6"1899;
"
92D23I11"1900;
A1899"
33D3I3"229"
23D4I4"1900"
10D4I4"1897"
17D27I35"1895;
A1898: ;
A1896: ; 
A1893:if(0"
35D6I39"1889;
A1894: if( A2292 > ( 4-A2313 ) ) "
12D40I4"1903"
48D9I124"1904;
A1903: A2292 = ( 4-A2313 );
A1904: ; 
A1901:if(0) goto A1894;
A1902: ; 
A1891:if(0) goto A1889;
A1892:
goto A1905;
A18"
18D80I13"2292 < (A2313"
90D4I4"1910"
12D12I20"1911;
A1910: A2292 ="
17D26I39"3; A1085( &A2297, A2314 ); if( A2292 ) "
33D170I5"914;
"
176D6I65"1915;
A1914:A1112( &A2297 , A1718->A569 );
A1915: ; 
A1912:if(0) "
12D13I56"1910;
A1913: ;
A1911: ; 
A1908:if(0) goto A1890;
A1909: "
21D1I168"3 > ( 4-A2313 ) ) goto A1918;
goto A1919;
A1918: A2293 = ( 4-A2313 );
A1919: ; 
A1916:if(0) goto A1909;
A1917: ; 
A1906:if(0) goto A1890;
A1907:
A1905:
A1788:
if( A2329"
6D88I7"A39) 15"
93D15I48"1718->A570.A552 ) goto A2330;
goto A2331;
A2330:"
20D6I126"6 |= A1718->A570.A552;
if(A2296) goto A2332;
goto A2333;
A2332:A1112( &A2300, A1718->A569 );
A2333: ;
A2331:
goto A1772;
case "
12D30I67"3:
if( A2313 >= A6256 ) goto A2334;
goto A2335;
A2334:
if( A6257 =="
36D66
76D3I3"336"
12D12I12"337;
A2336: "
21D3I1"-"
12D13I6"337: ;"
20D37I13"2338;
A2335: "
42D4I22"6256 && A6257 == A1868"
14D3I3"339"
12D77I40"340;
A2339: A2319 = (A4) 1;
A2340:
A2338"
84D41I23"2060 != 25 && !A1868 ) "
48D3I3"341"
12D51I32"342;
A2341:
if( A2293 < (A2313) "
60D33I23"347;
goto A2348;
A2347:"
38D16I1"3"
21D122I3"313"
128D17I2"5("
23D26I60"8, A2314 ); if( A2293 ) goto A2351;
goto A2352;
A2351:A1112("
33D122I38" , A1718->A569 );
A2352: ; 
A2349:if(0"
131D5I36"347;
A2350: ;
A2348: ; 
A2345:if(0) "
12D2I2"34"
7D62I8"346: if("
67D10I8"2 > ( 4-"
15D33I35" ) ) goto A2355;
goto A2356;
A2355:"
38D18I8"2 = ( 4-"
23D74I163" );
A2356: ; 
A2353:if(0) goto A2346;
A2354: ; 
A2343:if(0) goto A2341;
A2344: ;
A2342:
goto A1772;
case (A91) 0x10:
if( A1868 ) goto A2357;
goto A2358;
A2357:
if("
79D2I44"3 < (A2313) ) goto A2363;
goto A2364;
A2363:"
8D37I37" = A2313; A1085( &A2298, A2314 ); if("
42D26I42"3 ) goto A2367;
goto A2368;
A2367:A1112( &"
31D189I2" ,"
200D11I3"9 )"
16D21I81"68: ; 
A2365:if(0) goto A2363;
A2366: ;
A2364: ; 
A2361:if(0) goto A2357;
A2362: "
27D89I16"292 > ( 4-A2313 "
99D3I3"237"
12D18I18"2372;
A2371: A2292"
23D77I31"4-A2313 );
A2372: ; 
A2369:if(0"
85D6I28"2362;
A2370: ; 
A2359:if(0) "
12D78I4"2357"
83D90I20"60:
if( A2060 != 25 "
98D90I28"2373;
goto A2374;
A2373:
if("
95D270I16"6 && A6257 == 0 "
278D69I6"2375;
"
75D11I11"2376;
A2375"
21D19I11"0; A1115( &"
24D7
13D4I4"2377"
17D69I33"2375;
A2378: ;
A2376: ;
A2374: ;
"
75D12I16"2379;
A2358:
if("
17D50I12"2 < (A2313) "
58D56I6"2384;
"
62D16I12"2385;
A2384:"
21D5I4"2 = "
10D1I35"; A1085( &A2297, A2314 ); if( A2292"
10D4I4"2388"
12D33I17"2389;
A2388:A1112"
40D22I39"7 , A1718->A569 );
A2389: ; 
A2386:if(0"
30D6I37"2384;
A2387: ;
A2385: ; 
A2382:if(0) "
12D63I37"2358;
A2383: if( A2293 > ( 4-A2313 ) "
71D37I6"2392;
"
43D16I12"2393;
A2392:"
21D3I3"3 ="
15D1I22";
A2393: ; 
A2390:if(0"
9D6I28"2383;
A2391: ; 
A2380:if(0) "
12D25I17"2358;
A2381:
if( "
31D23I5"== 4 "
31D28I6"2394;
"
34D62I52"2395;
A2394: A2296 = 0; A1115( &A2300 ); 
A2396:if(0"
70D23I18"2394;
A2397:
A2395"
30D31I10"2060 == 25"
40D4I4"2398"
12D29I39"2399;
A2398:
if( A6256 > ( 4-A2313 ) ) "
35D44I37"2402;
goto A2403;
A2402: A6256 = ( 4-"
49D36I24" );
A2403: ; 
A2400:if(0"
44D4I13"2398;
A2401: "
12D63I28"2404;
A2399:
if( A6257 == 0 "
71D23I4"2405"
31D11I11"2406;
A2405"
18D22I14"6256 < (A2313)"
31D4I4"2409"
12D12I20"2410;
A2409: A6256 ="
17D26I27"3; A1085( &A6258, A2314 ); "
31D36I4"6256"
45D4I4"2413"
12D21I27"2414;
A2413:A1112( &A6258 ,"
31D17I26"69 );
A2414: ; 
A2411:if(0"
25D6I37"2409;
A2412: ;
A2410: ; 
A2407:if(0) "
12D47I21"2405;
A2408: ; 
A2406"
52D4I13"2404: ;
A2379"
14D2I2"72"
15D1I15"6:
case (A91) 2"
8D22I10"2060 == 25"
31D4I4"2415"
12D32I52"2416;
A2415: A2292 = 0; A1115( &A2297 ); 
A2417:if(0"
40D6I73"2415;
A2418: A2293 = ( 4 ); A1112( & A2298 , A1718->A569 ); 
A2419:if(0) "
12D13I35"2418;
A2420: ; 
goto A2421;
A2416:
"
18D16I63"2291 == (A91) 6 && A1868 >= 0 ||
A2291 == (A91) 2 && A1868 <= 0"
25D4I4"2422"
12D24I26"2423;
A2422:
if( A2293 < ("
30D22I1" "
30D12I5"2428;"
19D12I20"2429;
A2428: A2293 ="
17D28I39"3; A1085( &A2298, A2314 ); if( A2293 ) "
34D67I10"2433;
goto"
72D3I127"4;
A2433:A1112( &A2298 , A1718->A569 );
A2434: ; 
A2431:if(0) goto A2428;
A2432: ;
A2429: ; 
A2426:if(0) goto A2422;
A2427: if("
8D71I15"2 > ( 4-A2313 )"
80D4I4"2437"
12D44I25"2438;
A2437: A2292 = ( 4-"
49D36I24" );
A2438: ; 
A2435:if(0"
44D6I28"2427;
A2436: ; 
A2424:if(0) "
12D63I70"2422;
A2425: ;
A2423: ;
A2421:
if( A2324 & 0x4000 && A2291 == (A91) 2 "
71D15I5"2439;"
23D12I12"440;
A2439:
"
17D17I17"2313 && A1870 && "
22D1I10"-1 < A6259"
11D35I5"441;
"
42D5I87"442;
A2441:
A6257 = A1868-1;
A2443: A6256 = A2313; A1085( &A6258, A2314 ); if( A6256 ) "
12D26I3"446"
35D114I10"447;
A2446"
124D4I4"6258"
24D3I3"447"
10D3I3"444"
17D10I40"443;
A2445: ;
A2442: ;
goto A2448;
A2440"
17D10I40"2313 > A6256 || A2313 == A6256 && !A6257"
20D3I3"449"
12D45I101"450;
A2449:
{
A87 A2430 = A2291 == (A91) 6 ? A1868+1 : A1868-1;
if( A1025 && A6256 && A6257 != A2430 "
54D42I4"451;"
49D14I28"2452;
A2451:
A2319 = (A4) 1;"
21D15I12"2453;
A2452:"
22D3I22"293 == 4 && A2430 == 0"
13D2I2"45"
12D2I2"45"
7D84I10"454:
A2430"
91D16I35"1 == (A91) 6 ? 1 : -1;
A2455:
A6257"
21D21I11"430;
A2456:"
27D18I37" = A2313; A1085( &A6258, A2314 ); if("
23D159I40"6 ) goto A2459;
goto A2460;
A2459:A1112("
166D88I2" ,"
94D2I162"->A569 );
A2460: ; 
A2457:if(0) goto A2456;
A2458:
if( A6256 > 2 ) goto A2461;
goto A2462;
A2461: A6256 = 2;
A2462: ;
A2453: ;
}
goto A2463;
A2450: if( A6256 && ("
7D48I33" == (A91) 6 && A6257 <= A1868 ||
"
53D16I64" == (A91) 2 && A6257 >= A1868 ) ) goto A2464;
goto A2465;
A2464:"
21D142I33"9 = (A4) 1;
A2465:
A2463:
A2448:
"
150D4I50"72;
case (A91) 4:
case (A91) 0:
if( A2060 == 25 ) "
10D60I24"2466;
goto A2467;
A2466:"
65D37I35"2 = 0; A1115( &A2297 ); 
A2468:if(0"
46D8I11"466;
A2469:"
13D38I27"3 = ( 4 ); A1112( & A2298 ,"
48D49I17"69 ); 
A2470:if(0"
58D23I24"469;
A2471: ; 
goto A247"
28D19I5"467: "
25D14I63"291 == (A91) 4 && A1868 > 0 ||
A2291 == (A91) 0 && A1868 < 0 )
"
20D3I3"247"
12D48I13"2474;
A2473: "
56D15I11"3 < (A2313)"
24D4I4"2479"
12D12I20"2480;
A2479: A2293 ="
17D7I15"3; A1085( &A229"
12D21
27D8I13" if( A2293 ) "
14D40I6"2483;
"
46D6I65"2484;
A2483:A1112( &A2298 , A1718->A569 );
A2484: ; 
A2481:if(0) "
12D35I56"2479;
A2482: ;
A2480: ; 
A2477:if(0) goto A2473;
A2478: "
41D17I18"292 > ( 4-A2313 ) "
25D4I4"2487"
12D48I25"2488;
A2487: A2292 = ( 4-"
53D10I25" );
A2488: ; 
A2485:if(0)"
17D20I28"2478;
A2486: ; 
A2475:if(0) "
26D57I27"2473;
A2476:
A2474:
A2472:
"
63D11I39"313 > A6256 || A2313 == A6256 && !A6257"
20D4I4"2489"
12D11I11"2490;
A2489"
18D32I25"1025 && A6257 != A1868 )
"
38D4I4"2491"
13D30I51"502;
A2491: A6256 = 0; A1115( &A6258 ); 
A2503:if(0"
38D5I12"2491;
A2504:"
12D26I16"2505;
A2502:
if("
31D26I23"3 == 4 && A1868 == 0 ) "
32D132I6"2506;
"
138D6I48"2507;
A2506: A6257 = A2291 == (A91) 4 ? 1 : -1; "
12D57I40"2508;
A2507: A6257 = A1868;
A2508: A6256"
62D18I19"313; A1085( &A6258,"
23D29I3"4 )"
36D4I4"6256"
13D4I4"2511"
12D73I64"2512;
A2511:A1112( &A6258 , A1718->A569 );
A2512: ; 
A2509:if(0)"
80D51I27"2508;
A2510:
if( A6256 > 2 "
59D89I6"2513;
"
95D4I40"2514;
A2513: A6256 = 2;
A2514: ;
A2505: "
12D73I101"2515;
A2490: if( A6256 && (A2291 == (A91) 4 && A6257 < A1868 ||
A2291 == (A91) 0 && A6257 > A1868 ) )"
80D53I6"2516;
"
59D30I54"2517;
A2516: A2319 = (A4) 1;
A2517:
A2515:
goto A1772;"
37D6I6"(A91) "
13D31I120"(A91) 0x3):
case ((A91) 0x40 | (A91) 0x0):
case ((A91) 0x40 | (A91) 0x2):
case ((A91) 0x40 | (A91) 0x1):
if( A6256 > 4 -"
37D1I11" && A6256 <"
6D18I38"3 ) goto A2518;
goto A2519;
A2518:
if("
24D39I147" == ((A91) 0x40 | (A91) 0x3) && (A6259 & A1868) != A1868 ||
A2291 == ((A91) 0x40 | (A91) 0x0) && A6259 & A1868 ||
A2291 == ((A91) 0x40 | (A91) 0x2)"
44D5I80"(A6259 & A1868) ||
A2291 == ((A91) 0x40 | (A91) 0x1) && (A6259 & A1868) == A1868"
14D4I4"2520"
12D22I89"2521;
A2520:
A6256 = 4 - A2313;
A2521: ;
A2519:
goto A1772;
default:
goto A1772;
}
A1772:"
30D41I3"319"
50D4I4"2522"
12D45I54"2523;
A2522: A6256 = 0; A1115( &A6258 ); 
A2524:if(0) "
51D13I20"2522;
A2525:
A2523:
"
18D10I31"6256 && A6257 < 0 && A623(A1718"
15D4I5"7) )
"
10D4I4"2526"
12D64I52"2527;
A2526: A6256 = 0; A1115( &A6258 ); 
A2528:if(0"
72D138I50"2526;
A2529:
A2527:(*A2318).A548 = A2292; (*A2318)"
145D50
55D123I114"3; (*A2318).A6232 = A6256; (*A2318).A6233 = A6257; (*A2318).A5661 = A5697; (*A2318).A5662 = A5698; (*A2318).A552 ="
128D45I161"6; A1081(&(*A2318).A554, &A2297); A1081
(&(*A2318).A555, &A2298); A1081(&(*A2318).A6234, &A6258); A1081(&(*A2318).A5663, &A5699); A1081(&(*A2318).A557, &A2300);
"
50D23I18"1742->A307 & 0x001"
32D4I4"2530"
12D47I19"2531;
A2530: A1121("
52D1I59"8, 2 );
A2531: ;
A1712: ;
}
Void
A5673( A1718, A2291, A1868"
7D27I34"3, A2314 )
struct A561 *A1718;
A91"
32D94I17"1;
A87 A1868;
A79"
100D2I15"; struct A553 *"
7D102I34";
{struct A147 *A2318;
A81 A80;
A4"
107D25I15"9 = (A4) 0;
A79"
30D8I124"2, A2293, A6256, A5697; A87 A6257, A5698; A23 A2296; struct A553 *A2297=0, *A2298=0, *A6258=0, *A5699=0, *A2300=0;
A79 A2320"
13D47I119"21, A1870, A5709; A87 A6259, A5710; A23 A2324; struct A553 *A2325=0, *A2326=0, *A6260=0, *A5711=0, *A2328=0;
A39 A2329;"
52D95I1"!"
101D106I57"|| !(A80 = A1718->A566) ) return;
A2329 = A80->A168.A166;"
114D7I89"29 == (A39) 1 || A2329 == (A39) 7 || A2329 == (A39) 15 ||
A2329 == (A39) 4 && (A5649 > 0)"
18D72I4"11;
"
79D5I101"712;
A1711:
A2318 = ( (A80)->A156 == (A41) 19 ? (A80)->A155.A148 : (struct A147 *) 0 );
if( !A2318 ) "
12D38I5"713;
"
45D95I74"714;
A1713:
A2318 = (struct A147 *)
A1005( A2329 == (A39) 1 ? A1383 : A138"
102D1I169"318->A547 = A80->A170;
A1715: (A80)->A156 = (A41) 19; (A80)->A155.A148 = A2318; 
A1716:if(0) goto A1715;
A1717: ;
A1714:A2320 = (*A2318).A548; A2321 = (*A2318).A549; A18"
6D161I87"(*A2318).A6232; A6259 = (*A2318).A6233; A5709 = (*A2318).A5661; A5710 = (*A2318).A5662;"
166D16I198"4 = (*A2318).A552; A2325 = (*A2318).A554; A2326 = 
(*A2318).A555; A6260 = (*A2318).A6234; A5711 = (*A2318).A5663; A2328 = (*A2318).A557;
A1720: A2292 = ( A2320); A1085( & A2297, A2325 ); 
A1723:if(0"
25D5I68"720;
A1725: A2293 = ( A2321); A1085( & A2298, A2326 ); 
A1726:if(0) "
12D136I66"725;
A1727: A6256 = ( A1870); A1085( & A6258, A6260 ); 
A1766:if(0"
145D5I68"727;
A1767: A5697 = ( A5709); A1085( & A5699, A5711 ); 
A1768:if(0) "
12D70I44"767;
A1769: A2296 = ( A2324); A1085( & A2300"
75D58I19"28 ); 
A1770:if(0) "
65D5I55"769;
A1771: A6257 = A6259; A5698 = A5710; 
A1721:if(0) "
11D3I3"172"
8D81I27"722: if( A2293 < (A2313) ) "
87D47I32"1776;
goto A1777;
A1776: A2293 ="
53I15"; A1085( &A2298"
10D15I13" if( A2293 ) "
24D38I3"0;
"
44D6I65"1781;
A1780:A1112( &A2298 , A1718->A569 );
A1781: ; 
A1778:if(0) "
12D79I35"1776;
A1779: ;
A1777: ; 
A1774:if(0"
87D6I39"1722;
A1775: if( A2292 > ( 4-A2313 ) ) "
12D10I22"1784;
goto A1785;
A178"
15D44I10"292 = ( 4-"
49D7
13D64I18"785: ; 
A1782:if(0"
74D27I24"75;
A1783: ; 
A1772:if(0"
35D23I41"1722;
A1773:
switch(A2291)
{
case (A91) 1"
31D17I12"313 >= A5697"
26D4I4"1787"
12D94I123"1788;
A1787:
if( A1025 && A5697 && A1868 != A5698 ) goto A1889;
goto A1890;
A1889:
A2319 = (A4) 1;
goto A1891;
A1890: A5698"
99D4I122"868; 
A1892: A5697 = A2313; A1085( &A5699, A2314 ); if( A5697 ) goto A1895;
goto A1896;
A1895:A1112( &A5699 , A1718->A569 "
9D72I20"896: ; 
A1893:if(0) "
78D11I42"1892;
A1894: ; 
A1891: ;
goto A1897;
A1788"
17D61I23"A5697 && A5698 != A1868"
70D4I4"1898"
12D11I41"1899;
A1898: A2319 = (A4) 1;
A1899:
A1897"
21D9I22"9 == (A39) 15 && A1718"
14D1I6"0.A552"
10D4I4"1900"
12D36I4"1901"
41D89I18"00:
A2296 |= A1718"
94D2I16"0.A552;
if(A2296"
10D4I4"1902"
12D36I4"1903"
41D44I29"02:A1112( &A2300, A1718->A569"
49D43I14"1903: ;
A1901:"
50D6I50"1786;
case (A91) 3:
if( A5697 && A5698 == A1868 ) "
12D87I4"1904"
95D47I16"1905;
A1904:
if("
53D25I12" >= A5697 ) "
32D60I22"906;
goto A1907;
A1906"
65D17I19" A5697 > (4-A2313) "
25D4I4"1910"
12D57I37"1911;
A1910: A5697 = (4-A2313);
A1911"
63D4I4"1908"
17D25I13"1906;
A1909:
"
31D5I44"1912;
A1907: A2319 = (A4) 1;
A1912: ;
A1905:"
12D25I75"1786;
case (A91) 6:
case (A91) 2:
case (A91) 4:
case (A91) 0:
{
A87 A2430 ="
31D49I59" == (A91) 6 ? A1868+1 :
A2291 == (A91) 2 ? A1868-1 : A1868;"
54D5I6"!A5697"
14D4I4"1913"
12D92I87"1914;
A1913: A5698 = A2430; 
A1915: A5697 = A2313; A1085( &A5699, A2314 ); if( A5697 ) "
99D84I5"918;
"
90D6I65"1919;
A1918:A1112( &A5699 , A1718->A569 );
A1919: ; 
A1916:if(0) "
12D13I45"1915;
A1917: ; 
goto A2330;
A1914: if( A5659("
18D54I14",A5698,A1868) "
64D10I3"31;"
16D4I22"1025 && A5698 != A2430"
15D2I2"32"
12D2I2"33"
7D63I30"32:
A2319 = (A4) 1;
goto A2334"
68D38I17"33:
A5698 = A2430"
43D46I31"35: A5697 = A2313; A1085( &A569"
51D32I19"314 ); if( A5697 ) "
38D58I6"2338;
"
66D14I2"39"
19D40I41"38:A1112( &A5699 , A1718->A569 );
A2339: "
46D12I2"36"
27D2I2"35"
7D4I4"37: "
9D4I10"5697 > (2)"
15D2I2"42"
12D2I2"43"
7D62I14"42: A5697 = (2"
68D14I17"43: ; 
A2340:if(0"
24D14I2"37"
19D63I4"41: "
68D14I25"34: ;
A2331: ;
A2330: ;
}"
24D55I12"6;
default:
"
61D6I28"1786;
}
A1786:;
if( A2319 ) "
14D2I14"44;
goto A2345"
7D40I30"44: A5697 = 0; A1115( &A5699 )"
46D12I2"46"
27D2I2"44"
7D59I25"47:
A2345:(*A2318).A548 ="
64D20I34"2; (*A2318).A549 = A2293; (*A2318)"
25D112I19"2 = A6256; (*A2318)"
118D136I73" = A6257; (*A2318).A5661 = A5697; (*A2318).A5662 = A5698; (*A2318).A552 ="
141D2I198"6; A1081(&(*A2318).A554, &A2297); A1081
(&(*A2318).A555, &A2298); A1081(&(*A2318).A6234, &A6258); A1081(&(*A2318).A5663, &A5699); A1081(&(*A2318).A557, &A2300);
A1712: ;
}
Void
A1996( A1718, A2291, "
7D17I51", A2313, A2314 )
struct A561 *A1718;
A91 A2291;
A87"
23D49I77";
A79 A2313; struct A553 *A2314;
{
struct A561 *A2114, *A2115;
A40 A2118;
int"
54D1I67"2 = 0;
A96 *A2323, *A2493, *A2070;
if( A1718 && A2291 != (A91) 0x20"
10D3I3"171"
12D44I20"1712;
A1711:
A1022++"
51D52I12"2069 == 0 &&"
60D1I2"=="
8D32I48"2 || A2291 == (A91) 4) &&
A623( A1718->A567 ) ) "
39D12I5"100;
"
17D60I33"2291 == (A91) 0x10 && !A1024 && ("
65D60I61" && A1718->A570.A549 == 4 || !A2069 && A1718->A570.A548 == 4)"
70D37I4"100;"
43D12I35" = A1718->A562;
A2118 = A1718->A564"
19D5I11"2118 & 0x40"
15D4I4"1713"
12D27I52"1714;
A1713:
switch( A2118 )
{
case (0x400|19):
if( "
33D1I2"!="
8D32I7"0x20 ) "
38D27I6"1716;
"
33D36I25"1717;
A1716: A2317( A1718"
50D60I24", A2313, A2314 );
A1717:"
69D2I2"15"
12D12I6"400|18"
21D3I8"313 == 4"
12D4I4"1720"
12D19I20"1721;
A1720:
A2115 ="
24D2I13"4;
A1725:
if("
7D17I4"5 = "
26D43I2"63"
51D4I4"1722"
12D18I18"1723;
A1722:
A1996"
24D40I28"5, (A91) 0x20, (A87) 0, A231"
45D92I6"314 );"
99D5I19"1725;
A1723:
A1721:"
12D18I59"1715;
default:
goto A1715;
}
A1715: ;
goto A1726;
A1714: if"
24D45I45"8 & 0x200 ) goto A1727;
goto A1766;
A1727:
if"
51D40I29"4 && (A2115 = A2114->A563) ) "
46D30I5"1767;"
37D27I11"2100;
A1767"
35D3I11"118 & 0x100"
12D4I4"1768"
12D18I18"1769;
A1768:
A1996"
24D7
23D17I5" A231"
22D4I30"314 );
goto A1770;
A1769:
{A79"
9D15I33"4; struct A553 *A2495 = NULL; A79"
20D1I69"6; struct A553 *A2497 = NULL;
if( A2118 & 0x10 && A2291 != (A91) 0x10"
10D4I4"1771"
12D18I18"1772;
A1771:
A5307"
27D7I1"&"
14I1"&"
5D2I19" );
A1772: A2494 = "
18D2I43"2 <= A2313 ? A2114->A570.A6232 : A2313; if("
8D1I41" ) goto A1775;
goto A1776;
A1775: A1085(&"
7I81", A2114->A570.A6234 ); A1111( & A2495, A2314 ); goto A1777;
A1776: A1115( & A2495"
5D72I19"1777: ; 
A1773:if(0"
80D31I20"1772;
A1774: A2496 ="
36D23I16"5->A570.A6232 <="
29D17I2" ?"
23D22I14"->A570.A6232 :"
28D11I14"; if( A2496 ) "
17D30I5"1780;"
40D54I70"1;
A1780: A1085(& A2497, A2115->A570.A6234 ); A1111( & A2497, A2314 );"
61D6I53"1782;
A1781: A1115( & A2497 );
A1782: ; 
A1778:if(0) "
12D12I67"1774;
A1779:
switch( A2118 )
{
case (0x200|0x40 | 4):
A1996( A2114,"
18D1I2", "
6D17I38", A2313, A2314 );
A1996( A2115, A2291,"
23D45I17", A2313, A2314 );"
52D34I18"313 == 4 && !A1974"
43D3I3"178"
12D12I23"1785;
A1784:
{
A81 A80;"
19D3I41"114->A571 & 0x001 &&
A2236( A2114->A567 )"
12D3I3"178"
12D20I26"1787;
A1786:
A1098( A2236("
25D16I42"->A567), 0 );
goto A1788;
A1787: if( A80 ="
21D48I7"4->A566"
57D4I4"1889"
12D61I52"1890;
A1889:
A1989( A1718, A80, 4, (A78) 0x01 );
if("
66D30I9"6 == 4 ) "
36D30I5"1891;"
38I82"892;
A1891: A2274( A2114, A2115 , 0 );
A1892: ;
A1890: ;
A1788: ;
}
A1785:
goto A1"
19D56I6"40 | 5"
65D17I19"114->A570.A549 == 4"
26D4I4"1893"
12D25I19"1894;
A1893:
A1996("
30D24I9"5, A2291,"
30D3I1","
9D3I11", A2314 );
"
9D6I41"1895;
A1894: if( A2114->A570.A548 == 4 ) "
12D56I6"1896;
"
62D44I19"1897;
A1896:
A1996("
54D22I34"63, A2291, A2069, A2313, A2314 );
"
28D6I44"1898;
A1897: if( A2290(A2115,A2291,A2069) ) "
12D13I25"1899;
goto A1900;
A1899:
"
33D1I4"0x10"
14D30I33"313, A2314 );
goto A1901;
A1900: "
36D18I4"290("
27D7I15"63,A2291,A2069)"
16D4I4"1902"
12D32I19"1903;
A1902:
A1996("
38D69
77D1I4"0x10"
9D15I15"1, A2313, A2314"
20D36I27"1903:
A1901:
A1898:
A1895:
"
42D25I30"1783;
case (0x200|0x40 | 15):
"
39D8
14D10I19"0x20, (A87) 0, A231"
15D30I3"314"
35D50
65D22I16"291, A2069, A231"
27D39I40"314 );
goto A1783;
case (0x200|0x40 | 8)"
46D49I4"2271"
58D4I4"1904"
12D79I72"1905;
A1904:
if( A2310(A2291,A2069) ) goto A1906;
goto A1907;
A1906: A23"
84D96I16"2;
A1907:
A1996("
102D14I15", A2291, A2069,"
20D2I17", A2314 );
A1996("
7D14I16"5, A2291, A2069,"
20D2I18", A2314 );
A1905:
"
8D3I8"313 != 4"
12D6I74"1783;
if( (((A2291)==(A91) 1||(A2291)==(A91) 0x10) && (A2069)==(A87) 0) ) "
12D26I36"1908;
goto A1909;
A1908:
if( A2493 ="
31D1I1"5"
6D33I3"4 )"
40D52I6"1910;
"
58D20I44"1911;
A1910:
A1103((A2493),(A6228)0);
A1996("
25D15I23"5, (A91) 0x10, (A87) 0,"
21D21I1","
26D6I35"4 );
A2070 = A1100();
A1101( A2070,"
11D4I56"3, 6 );
A1103((A2070),(A6228)0);
A1102(A2070);
A1911: ;
"
10D6I38"1912;
A1909: if( A2310(A2291,A2069) ) "
12D26I36"1913;
goto A1914;
A1913:
if( A2323 ="
37D33I3"4 )"
40D52I6"1915;
"
58D20I44"1916;
A1915:
A1103((A2323),(A6228)0);
A1996("
25D15I23"4, (A91) 0x10, (A87) 1,"
21D21I1","
26D3I29"4 );
A2323 = A1100();
A1916:
"
9D3I17"493 = A2115->A574"
12D4I4"1917"
12D26I44"1918;
A1917:
A1103((A2493),(A6228)0);
A1996("
32D28I21", (A91) 0x10, (A87) 1"
34D15I10"3, A2314 )"
20D43I42"93 = A1100();
A1918:
if( A2323 && A2493 )
"
49D87I6"1919;
"
94D3I86"330;
A1919:A1103(( A1101(A2323,A2493,7) ),(A6228)0);
A2330:
A1102(A2323);
A1102(A2493)"
12D25I18"331;
A1914: A1996("
30D29I22"4, (A91) 0x20, (A87) 0"
35D5I26"3, A2314 );
A2331:
A1912:
"
11D50I39"1783;
case (0x200|0x40 | 7):
if( A2271 "
59D24I5"332;
"
31D22I10"333;
A2332"
28D31I40"(((A2291)==(A91) 1||(A2291)==(A91) 0x10)"
38D24I13"069)==(A87) 0"
35D3I3"334"
12D10I28"335;
A2334: A2313 = 2;
A2335"
23D39I101"4, A2291, A2069, A2313, A2314 );
A1996( A2115, A2291, A2069, A2313, A2314 );
A2333:
if( A2313 != 4 ) "
45D13I6"1783;
"
19D5I53"310(A2291,A2069) ) goto A2336;
goto A2337;
A2336:
if("
10D51I15"3 = A2115->A574"
61D3I3"338"
12D11I36"339;
A2338:
A1103((A2493),(A6228)0);"
23D1I1"5"
20D13I14" 1, A2313, A23"
21D15I28"070 = A1100();
A1101( A2070,"
20D62I56"3, 6 );
A1103((A2070),(A6228)0);
A1102(A2070);
A2339: ;
"
69D38I27"340;
A2337: if( (((A2291)=="
44D6I36"1||(A2291)==(A91) 0x10) && (A2069)=="
11D19I6" 0) ) "
26D12I24"341;
goto A2342;
A2341:
"
18D61I17"323 = A2114->A574"
71D3I3"343"
12D11I36"344;
A2343:
A1103((A2323),(A6228)0);"
43D15I16" 0, A2313, A2314"
21D33I20"323 = A1100();
A2344"
43D59I15"3 = A2115->A574"
69D3I3"345"
12D11I36"346;
A2345:
A1103((A2493),(A6228)0);"
43D29I18" 0, A2313, A2314 )"
34D4I21"93 = A1100();
A2346:
"
10D5I6"323 &&"
10D54I4"3 )
"
61D2I2"34"
12D2I2"34"
7D52I43"347:A1103(( A1101(A2323,A2493,7) ),(A6228)0"
57D36I16"348:
A1102(A2323"
42D66I9"02(A2493)"
75D2I2"34"
7D21I68"342: A1996( A2114, (A91) 0x20, (A87) 0, A2313, A2314 );
A2349:
A2340"
46D10I7" | 0x80"
17D22
33D16I24" | 0x80 | 3):
A2350: if("
21D4I2"=="
14D1
10D3I3"353"
12D69I18"354;
A2353: A2291="
74D3I1"?"
9D4I2"3:"
10D22I57"1; A2069=0; 
A2354: ; 
A2351:if(0) goto A2350;
A2352:
if("
28D27
37D3I3"355"
12D10I10"356;
A2355"
18D6I12"A2114, A2291"
13D27I6"-A2115"
39D1
7D1I1"6"
7D1I1"7"
7D16I17"356:
if( A2494 ) "
23D29I4"357;"
36D29I33"2358;
A2357: A1996(A2115, A2291, "
34D15I64"-A2114->A570.A6233, A2494, A2495 );
A2358:
A2492 = 2;
goto A1783"
28D10I7" | 0x80"
17D4I35"case (0x200 | 0x80 | 4):
A2359: if("
9D4I2"=="
14D1
10D3I3"362"
12D69I18"363;
A2362: A2291="
74D3I1"?"
9D4I2"3:"
10D22I57"1; A2069=0; 
A2363: ; 
A2360:if(0) goto A2359;
A2361:
if("
28D27
37D3I3"364"
12D10I10"365;
A2364"
18D6I12"A2114, A2291"
13D27I6"+A2115"
39D1
7D1I1"6"
7D1I1"7"
7D16I17"365:
if( A2494 ) "
23D29I4"366;"
36D62I26"2367;
A2366: A1996(A2115, "
68I19" A2114->A570.A6233-"
5D4I36", A2494, A2495 );
A2367:
A2492 = 2;
"
10D6I58"1783;
case (0x200|0x20 | 1):
A2368: if(A2291==(A91) 0x10) "
13D26I36"371;
goto A2372;
A2371: A2291=A2069?"
32D31I43"3:(A91) 1; A2069=0; 
A2372: ; 
A2369:if(0) "
38D11I15"368;
A2370:
if("
16D14I4"6 ) "
20D80I6"2373;
"
87D24I12"374;
A2373: "
30D6I5"A2114"
20D6I17"-A2115->A570.A623"
11D25I4"496,"
30D14I24"7 );
A2374:
if( A2494 ) "
20D14I5"2375;"
21D18I57"2376;
A2375: A1996(A2115, A2291, A2069-A2114->A570.A6233,"
23D18I30"4, A2495 );
A2376:
A2492 = 2;
"
24D6I58"1783;
case (0x200|0x20 | 3):
A2377: if(A2291==(A91) 0x10) "
13D2I14"380;
goto A238"
7D20I64"380: A2291=A2069?(A91) 3:(A91) 1; A2069=0; 
A2381: ; 
A2378:if(0"
29D5I24"377;
A2379:
if( A2496 ) "
12D2I14"382;
goto A238"
7D5I5"382: "
11D1
8D25I29"A2291, A2069+A2115->A570.A623"
30D3I10"496, A2497"
8I50"2383:
if( A2494 ) goto A2384;
goto A2385;
A2384: A"
5D1
10D57I41"2291 ^ (A91) 4), A2114->A570.A6233-A2069,"
62D9I30"4, A2495 );
A2385:
A2492 = 2;
"
15D6I58"1783;
case (0x200|0x20 | 4):
A2386: if(A2291==(A91) 0x10) "
13D26I36"389;
goto A2390;
A2389: A2291=A2069?"
32D53I41"3:(A91) 1; A2069=0; 
A2390: ; 
A2387:if(0"
62D5I24"386;
A2388:
if( A2496 ) "
12D18I37"391;
goto A2392;
A2391:
{
A87 A1868 ="
24D1I80"->A570.A6233;
if( A1868<0 ) goto A2393;
goto A2394;
A2393: A1996(A2114, (A2291 ^"
8D80I24"4), A2069/A1868, A2496, "
85D13I1")"
22D10I10"395;
A2394"
17D4I6"1868>0"
14D3I3"396"
12D63I25"397;
A2396: A1996(A2114, "
69I1" "
5D1I60"/A1868, A2496, A2497 );
A2397: ;
A2395: ;
}
A2392:
if( A2494"
11D3I3"398"
12D18I25"399;
A2398:
{
A87 A1868 ="
24D39I28"->A570.A6233;
if( A1868<0 ) "
46D18I37"400;
goto A2401;
A2400: A1996(A2114, "
24D3I3" ^ "
9D28I4"4), "
33D14I23"/A1868, A2494, A2495);
"
21D5I26"402;
A2401: if( A1868>0 ) "
12D10I22"403;
goto A2404;
A2403"
18D1
8D18I4"A229"
23D32I10"069/A1868,"
37D20I48"4, A2495);
A2404: ;
A2402: ;
}
A2399:
A2492 = 2;"
27D4I4"1783"
16D34I23"0|0x20 | 7):
if( A2496 "
43D3I3"405"
12D11I32"406;
A2405: A2311( A2118, A2114,"
17D1I2", "
6D48I54",
A2115->A570.A6233, A2496, A2497 );
A2406:
if( A2494 "
57D15I44"407;
goto A2408;
A2407: A2311( A2118, A2115,"
21D65I2", "
70D23I2",
"
32D4I22"70.A6233, A2494, A2495"
9D13I63"2408:
case (0x200|0x20 | 5):
case (0x200|0x20 | 10):
if( A2310("
19D1
6D18I4") ) "
25D29I4"409;"
37D34I25"410;
A2409:
A1996( A2114,"
45D52I8", (A87) "
57D3I3"313"
9D7
12D19
30D11I2"5,"
18D10I13"0x10, (A87) 1"
28D7
14D3I40"411;
A2410: A2492 = 1;
A2411:
goto A1783"
13D14I63"200|0x20 | 6):
if( A2496 ) goto A2412;
goto A2413;
A2412: A2311"
20I7"8, A211"
16D5I17"
A2115->A570.A623"
10D7I33"496, A2497 );
A2413:
if( A2494 ) "
14D53I5"414;
"
60D23I32"415;
A2414: A2311( A2118, A2115,"
29D1I1","
7D2I59",
A2114->A570.A6233, A2494, A2495 );
A2415:
if( (((A2291)=="
8D2I12"1||(A2291)=="
8D3I10"0x10) && ("
8D26I12")==(A87) 0) "
35D10I22"416;
goto A2417;
A2416"
26D14I19"(A91) 0x10, (A87) 0"
32D30
41D15I22"5, (A91) 0x10, (A87) 0"
40D3I40"418;
A2417: A2492 = 1;
A2418:
goto A1783"
13D7I12"200|0x20 | 9"
12D3I3"419"
8D1
27D3I3"422"
12D10I10"423;
A2422"
18D1
6D1
24D1
8D3I3"423"
10D3I3"420"
17D25I15"419;
A2421:
if("
31D27I34" == (A91) 1 || A2291 == (A91) 3 ) "
34D35I22"424;
goto A2425;
A2424"
43D19I3"496"
29D3I3"426"
12D12I12"427;
A2426: "
26D18I4"A229"
23D14I61"069 ^ A2115->A570.A6233 , A2496, A2497 );
A2427:
if( A2494 ) "
21D19I37"428;
goto A2429;
A2428: A1996( A2115,"
25D38I1","
45D54I7"^ A2114"
59D20I44"0.A6233 , A2494, A2495 );
A2429:
A2492 = 2;
"
27D4I29"431;
A2425: A2492 = 1;
A2431:"
11D68I41"1783;
case (0x200|0x10|0x04 | 3):
A2069 ="
75D28I57"!A2069;
case (0x200|0x10 | 3):
if( A2291 == (A91) 0x10 ) "
35D36I4"432;"
44D20I10"433;
A2432"
28D66I3"271"
71D30I42"2118 == (0x200|0x10 | 3) && A2069 && A2313"
40D1I1"4"
12D1I1"4"
7D26I10"434:
if( ~"
31D2I33"->A570.A552 & A2115->A570.A552 ) "
9D32I5"436;
"
39D5I63"437;
A2436:
A2114->A570.A552 |= A2115->A570.A552;
if( !A2496 ) "
12D50I5"438;
"
57D38I74"439;
A2438: A1996( A2114, (A91) 1, (A87) 0, A2496, A2497 );
A2439: ;
A2437"
46D16I34"114->A570.A552 & ~A2115->A570.A552"
26D3I3"440"
12D11I49"441;
A2440:
A2115->A570.A552 |= A2114->A570.A552;"
16D9I6"!A2494"
19D3I3"442"
12D45I26"443;
A2442: A1996( A2115, "
51D7I109"1, (A87) 0, A2494, A2495 );
A2443: ;
A2441: ;
A2435:
if( A2496 ) goto A2444;
goto A2445;
A2444: A1996( A2114,"
14D15I2"? "
21D29I18"1 : (A91) 3, A2115"
37D13I39"6233 , A2496, A2497 );
A2445:
if( A2494"
23D3I3"446"
12D17I17"447;
A2446: A1996"
23D2I10"5, A2069 ?"
10D15I9" : (A91) "
20D32
43D45I39"6233 , A2494, A2495 );
A2447:
if( A492("
50D54I43"->A567) == 25 ||
A492(A2115->A567) == 25 ) "
61D80I5"448;
"
87D30I179"449;
A2448:
{A79 A2498; struct A553 *A5712 = NULL;
A79 A2499; struct A553 *A5713 = NULL;
A79 A2500; struct A553 *A5714 = NULL;
A79 A2501; struct A553 *A5715 = NULL;
A2450: A2498 ="
36D19I14"->A570.A548 <="
25D1I21" ? A2114->A570.A548 :"
6D19I3"3; "
24D3I3"249"
14D1I1"4"
12D1I1"4"
7D11I72"453: A1085(&A5712, A2114->A570.A554 ); A1111( &A5712, A2314 ); goto A245"
16D34I44"454: A1115( &A5712 );
A2455: ; 
A2451:if(0) "
41D38I11"450;
A2452:"
43D4I23"9 = A2114->A570.A549 <="
11D4I37"? A2114->A570.A549 : A2313; if( A2499"
14D3I3"458"
12D18I25"459;
A2458: A1085(&A5713,"
24D21I28"->A570.A555 ); A1111( &A5713"
27D8I37"4 ); goto A2460;
A2459: A1115( &A5713"
14D192I18"460: ; 
A2456:if(0"
200D6I87"2452;
A2457: A2500 = A2115->A570.A548 <= A2313 ? A2115->A570.A548 : A2313; if( A2500 ) "
12D57I6"2463;
"
63D6I71"2464;
A2463: A1085(&A5714, A2115->A570.A554 ); A1111( &A5714, A2314 ); "
12D173I50"2465;
A2464: A1115( &A5714 );
A2465: ; 
A2461:if(0"
181D6I87"2457;
A2462: A2501 = A2115->A570.A549 <= A2313 ? A2115->A570.A549 : A2313; if( A2501 ) "
12D23I6"2468;
"
29D43I32"2469;
A2468: A1085(&A5715, A2115"
49D10I65".A555 ); A1111( &A5715, A2314 ); goto A2470;
A2469: A1115( &A5715"
15D13I38"2470: ; 
A2466:if(0) goto A2462;
A2467"
21D16I3"069"
25D3I3"247"
12D89I30"2472;
A2471:
if( A2498 > A2500"
94D25I16"2498 >= A2501 &&"
30D8I25"98==4||A2498+A2501 <= 4) "
16D4I4"2473"
12D22I61"2474;
A2473:
A1996( A2115, (A91) 0x10, (A87)0, A2498, A5712 )"
30D82I13"2475;
A2474: "
87D2I62"2500 > A2498 && A2500 >= A2499 && (A2500==4||A2500+A2499 <= 4)"
11D3I3"247"
12D92I45"2477;
A2476:
A1996( A2114, (A91) 0x10, (A87)0"
97D34I26"00, A5714 );
A2477:
A2475:"
39D6I63"A2499 > A2501 && A2499 >= A2500 && (A2499==4||A2499+A2500 <= 4)"
15D4I4"2478"
12D95I18"2479;
A2478:
A1996"
101D14I165"5, (A91) 0x10, (A87)1, A2499, A5713 );
goto A2480;
A2479: if( A2501 > A2499 && A2501 >= A2498 && (A2501==4||A2501+A2498 <= 4) ) goto A2481;
goto A2482;
A2481:
A1996("
19D74I35"4, (A91) 0x10, (A87)1, A2501, A5715"
79D45I35"2482: ;
A2480: ;
goto A2483;
A2472:"
52D17I11"498 > A2501"
22D34I44"2498 >= A2500 && (A2498==4||A2498+A2500 <= 4"
44D4I4"2484"
12D105I18"2485;
A2484:
A1996"
111D79I61"5, (A91) 0x10, (A87)1, A2498, A5712 );
goto A2486;
A2485: if("
84D82I59"0 > A2499 && A2500 >= A2498 && (A2500==4||A2500+A2498 <= 4)"
91D4I4"2487"
12D26I19"2488;
A2487:
A1996("
32D49I150", (A91) 0x10, (A87)1, A2500, A5714 );
A2488: ;
A2486: ;
A2483:A1115( &A5712 );
A1115( &A5713 );
A1115( &A5714 );
A1115( &A5715 );
}
A2449:
A2492 = 2;
"
55D5I30"2489;
A2433: A2492 = 1;
A2489:"
14D84I37"83;
case (0x200|0x10|0x04 | 1):
A2069"
89D27I34"87) !A2069;
case (0x200|0x10 | 1):"
33D10I18"2291 == (A91) 0x10"
19D4I4"2490"
12D11I11"2491;
A2490"
17D6I5"A2496"
15D4I4"2502"
12D59I20"2503;
A2502: A1996( "
64D6I28", A2069 ? (A91) 6 : (A91) 0,"
11D39I88"5->A570.A6233 , A2496, A2497 );
A2503:
if( A2494 ) goto A2504;
goto A2505;
A2504: A1996("
44D38I84"5, A2069 ? (A91) 2 : (A91) 4, A2114->A570.A6233 , A2494, A2495 );
A2505:
A2492 = 2;
"
44D5I30"2506;
A2491: A2492 = 1;
A2506:"
14D24I75"83;
case (0x200|0x10 | 2):
A2069 = (A87) !A2069;
case (0x200|0x10|0x04 | 2)"
32D2I16"291 == (A91) 0x1"
12D4I4"2507"
12D34I12"2508;
A2507:"
39D29I5"A2496"
38D4I4"2509"
12D13I54"2510;
A2509: A1996( A2114, A2069 ? (A91) 4 : (A91) 2, "
23D51I32"0.A6233 , A2496, A2497 );
A2510:"
58D23I3"494"
32D4I4"2511"
12D11I11"2512;
A2511"
24D2I10"5, A2069 ?"
10D57I2" :"
64D22I35"6, A2114->A570.A6233 , A2494, A2495"
27D92I17"2512:
A2492 = 2;
"
98D5I30"2513;
A2508: A2492 = 1;
A2513:"
14D33I52"83;
case (0x200|0x08 | 1):
case (0x200|0x08 | 2):
if"
38D32I56"10(A2291,A2069) ) goto A2514;
goto A2515;
A2514: A1996( "
37D75I39", (A91) 0x10, (A87) 1, A2313, A2314 );
"
81D5I30"2516;
A2515: A2492 = 1;
A2516:"
14D16I54"83;
case (0x200|0x40 | 14):
case (0x200|0x40 | 13):
if"
23D34I17"->A571 & 0x001 ) "
40D13I25"2517;
goto A2518;
A2517:
"
24D61I31"5, A2291, A2069, A2313, A2314 )"
69D134I31"2519;
A2518: A2492 = 1;
A2519:
"
142D3I12"83;
default:"
12D57I39"83;
}
A1783:
if( A2492 && A2313 == 4 ) "
63D13I73"2520;
goto A2521;
A2520:
if( A2492 == 1 ) goto A2522;
goto A2523;
A2522:
"
35D1I1"2"
10D10I15"0, A2313, A2314"
16D96I3"996"
102D97I40"5, (A91) 0x20, (A87) 0, A2313, A2314 );
"
103D6I30"2524;
A2523:
if( A2496 != 4 ) "
12D27I4"2525"
35D12I19"2526;
A2525: A1996("
17D9I50"4, (A91) 0x20, (A87) 0, A2313, A2314 );
A2526:
if("
14D22I87"4 != 4 ) goto A2527;
goto A2528;
A2527: A1996( A2115, (A91) 0x20, (A87) 0, A2313, A2314"
27D24I12"2528: ;
A252"
29D12I119"A2521:A1115( &A2495 );
A1115( &A2497 );
}
A1770: ;
goto A2529;
A1766: if( A2114 ) goto A2530;
goto A2531;
A2530:
switch"
19D112I27"->A564 )
{
case (0x40 | 2):"
117D17I59"A2310(A2291,A2069) ) goto A2533;
goto A2534;
A2533: A1996( "
22D57I39", (A91) 0x10, (A87) 0, A2313, A2314 );
"
63D60I13"2535;
A2534: "
65D57I37"((A2291)==(A91) 1||(A2291)==(A91) 0x1"
63D100I18"(A2069)==(A87) 0) "
108D4I4"2536"
12D29I24"2537;
A2536: A1996( A211"
34D17I34"91) 0x10, (A87) 1, A2313, A2314 );"
24D4I48"2538;
A2537: A2492 = 1;
A2538:
A2535:
goto A2532"
14D20I36"20 | 8):
A2539: if(A2291==(A91) 0x10"
28D73I6"2542;
"
79D6I74"2543;
A2542: A2291=A2069?(A91) 3:(A91) 1; A2069=0; 
A2543: ; 
A2540:if(0) "
12D34I56"2539;
A2541:
if( A2291 == (A91) 1 || A2291 == (A91) 3 ) "
40D20I52"2544;
goto A2545;
A2544:
A2069 = A984( ~A2069, A492("
25D1I1"4"
7D82I50" ) );
A1996( A2114, A2291, A2069, A2313, A2314 );
"
88D5I30"2598;
A2545: A2492 = 1;
A2598:"
12D40I21"2532;
case (0x20 | 2)"
47D16I18"2291 == (A91) 0x10"
25D4I4"2599"
12D34I2"26"
39D11I11"2599: A1996"
17D20I28"4, A2291, A2069, A2313, A231"
31D11I75"2601;
A2600: A1996( A2114, (A2291 ^ (A91) 4), -A2069, A2313, A2314 );
A2601"
19D4I4"2532"
16D26I51" | 9):
A1996( A2114, A2291, A2069, A2313, A2314 );
"
32D6I54"2532;
case (0x40 | 10):
A2602: if( A2291==(A91) 0x10) "
12D42I5"2605;"
49D15I77"2606;
A2605: A2291= A2069 ?(A91) 3:(A91) 1; A2069 =0; 
A2606: ; 
A2603:if(0) "
21D38I18"2602;
A2604:
A1996"
44D12I35"4, A2291, A2069+1, A2313, A2314 );
"
18D27I29"2532;
case (0x40 | 11):
A1996"
34D28I32", A2291, A2069, A2313, A2314 );
"
34D21I31"2532;
case (0x40 | 12):
A2607: "
27D5I10"291==(A91)"
10D2
10D4I4"2610"
12D18I101"2611;
A2610: A2291= A2069 ?(A91) 3:(A91) 1; A2069 =0; 
A2611: ; 
A2608:if(0) goto A2607;
A2609:
A1996"
27D9I27"A2291, A2069-1, A2313, A231"
14D28
34D30I5"2532;"
39D82I7"40|21):"
91D43I7"40|25):"
50D17I19"310( A2291, A2069 )"
26D4I4"2612"
12D49I18"2613;
A2612:
A1996"
55D8I36"4, (A91) 0x10, (A87) 1, A2313, A2314"
18D53I85"2614;
A2613: if( ((( A2291)==(A91) 1||( A2291)==(A91) 0x10) && ( A2069 )==(A87) 0) ) "
59D15I47"2615;
goto A2616;
A2615:
if( A1718->A571 & (0x1"
20D56I4"080)"
65D3I3"261"
12D10I10"2629;
A261"
15D50I7"492 = 1"
58D34I18"2630;
A2629: A1996"
45D8I31"91) 0x10, (A87) 0, A2313, A2314"
13D49I6"2630: "
57D4I48"2631;
A2616: A2492 = 1;
A2631:
A2614:
goto A2532"
14D14I11"40 | 1):
if"
21D44I23"->A570.A552 & 0x4000 ) "
50D69I4"2632"
77D45I13"2633;
A2632:
"
50D4I39"5398 && A1559.A1553->A1542 & (A17) 0x01"
13D4I4"2634"
12D26I24"2635;
A2634:
A1559.A1553"
31D29I4"93 ="
35D132
140D30I24"2636;
A2635: if( !A5674("
35D16I4") ) "
22D103I4"2637"
111D38I51"2638;
A2637:
{
A4 A5378 = (A5682 > 0);
if( A5378 ) "
44D65I51"2639;
goto A2640;
A2639: ++A1025;
A2640:
if( A2310("
71D7I43"A2069) ) goto A2641;
goto A2642;
A2641:
if("
13D1I37" > 2 ) goto A2643;
goto A2644;
A2643:"
6D27I20"3 = 2;
A2644:
if( (("
33D118I3")=="
124D3I38"3 && !( A2069 ) || ( A2291)==(A91) 0x1"
8D5I42"( A2069 )) &&
!(A2114->A570.A552 & 0x8000)"
14D4I4"2645"
12D22I20"2646;
A2645:
A5700( "
27D37I55", (A91) 1, (A87)-2, A2313, A2314 );
goto A2647;
A2646: "
45D9I13"4->A570.A5661"
18D4I4"2648"
12D19I18"2649;
A2648:
A5700"
25D35I2"4,"
42D37I11"2, (A87)-1,"
42D28I1"3"
34D7
13D5I16"2649: ;
A2647: ;"
12D37I78"2650;
A2642: if( (((A2291)==(A91) 1||(A2291)==(A91) 0x10) && (A2069)==(A87) 0)"
46D4I4"2651"
12D20I19"2652;
A2651:
A5700("
26D7I48", (A91) 1, (A87)-1, A2313, A2314 );
A2652:
A2650"
14D18I5"5378 "
26D4I4"2653"
12D72I18"2654;
A2653: --A10"
77D11I33"2654: ;
}
A2638: ;
A2636: ;
A2633"
19D4I4"2532"
21D4I4"2532"
9D27I6"2532:
"
33D11I17"492 && A2313 == 4"
20D4I4"2655"
12D15I18"2656;
A2655: A1996"
22D45I69", (A91) 0x20, (A87) 0, A2313, A2314 );
A2656: ;
A2531:
A2529:
A1726:
"
50I9":
A1022--"
5D3I134"12: ;
}
Void
A1036( A1718, A1740, A1735, A80 )
struct A561 *A1718;
A58 A1740;
A6 A1735;
A81 A80;
{
A70 A1738 = A492(A1740);
A28 A5355;"
9D12I4"1735"
23D2I2"11"
12D2I2"12"
7D48I48"11:
{
A78 A2128 = (A78) 0x02;
if( A1738 == 33 ) "
56D2I14"13;
goto A1714"
7D79I41"13: A2128 = ((A78) 0x08|(A78) 0x80000000)"
84D124I15"14:
A583( A1718"
129D42I118"28 | (A78) 0x400000 | A1988( A1740, (A4) 0, (A4) 0 ) );
if( A1738 <= 23 || A1738 == 31 ||
A1738 == 26 || A1738 == 25 )"
51D1I13"15;
goto A171"
7D2I43"15:
if( A80 ) goto A1717;
goto A1720;
A1717"
7D11I31"22( A80, &A1718->A570, 0, A1718"
18D29I4"20: "
34D68I4"16:
"
74D3I16"128 & (A78) 0x08"
14D2I2"21"
12D2I2"22"
7D65I29"21: A5355 = (A28) 0x4000000;
"
73D2I2"23"
7D42I79"22: if( (A5535 <= 0) ||
(A5536 <= 0) && A1718->A572 & ((A24) 0x8 | (A24) 0x20)
"
52D2I14"25;
goto A1726"
7D160I15"25: A5355 = 0;
"
168D14I2"27"
19D14I72"26: A5355 = (A28) 0x8000000;
A1727:
A1723:
A5490( A80, A5355 );
}
A1712:"
20D42I2"80"
53D2I2"66"
12D2I2"67"
7D46I44"66:
A80->A170 = 4;
A80->A127 |= (A27) 0x8000"
51D24I83"67: ;
}
struct A561 *
A1033( A2546, A2547 )
struct A561 *A2546, *A2547;
{
if( !A254"
36D2I2"11"
11D3I3"712"
8D14I91"11: A2546 = A1039( 0, NULL, 0 );
A1712:
A2546->A563 = A2547;
return A2546;
}
Void
A577( A21"
19D75I10"1943 )
A40"
80D2I50"8;
A68 A1943;
{
struct A561 *A1718;
A1718 = A1039("
7D5I19"8, NULL, A1719.A592"
11D14I17"718->A569 = A1943"
19D49I22"18->A566 = A1719.A590;"
58D17I55"8 == (0x400|20) && A1719.A593 & ((A24) 0x10|(A24) 0x20)"
27D3I3"711"
12D17I104"712;
A1711:
A580( A1718, A1719.A589 );
A1712:
A1718->A571 = A1719.A594;
A1719.A599 = A1718;
}
Void
A2548"
23I14"8, A2114, A211"
5D50I9"128 )
A40"
55D58I24"8;
struct A561 *A2114, *"
63D14I66";
A78 A2128;
{
A4 A2501;
A96 *A2070, *A2323, *A2493, *A2549;
A5972"
19D41I2"0,"
46D20I26"1;
if( A2070 = A2114->A574"
30D3I3"711"
12D18I25"712;
A1711: A1102(A2070);"
24D58I23"->A574 = NULL; 
A1712:
"
64D4I6"070 = "
13D15I2"74"
25D3I3"713"
12D18I25"714;
A1713: A1102(A2070);"
23D68I106"5->A574 = NULL; 
A1714:A2501 = A1559.A1557; A1559.A1557 = (A4) 0;
A583( A2114, A2128 );
if( A1559.A1557 ) "
76D121I2"15"
131D25I9"16;
A1715"
31D5I6"!A2501"
15D3I3"717"
12D11I65"720;
A1717:A865(664);
A1720:
return;
A1716:
A2550 = A1044(A2114);"
18D14I14"118 == (0x200|"
21D23I20"7) && A2550 == -1 ||"
28D23I35"8 == (0x200|0x40 | 8) && A2550 == 1"
33D3I3"721"
12D32I30"722;
A1721:
return;
A1722:
if("
37D9I40"0 ) goto A1723;
goto A1725;
A1723:
A583("
15D45I10", A2128 );"
50D5I29"!A1044(A2115) && !A1559.A1557"
15D3I3"726"
12D11I73"727;
A1726:
A2115->A574 = A1100();
A1727:
return;
A1725:
A2323 = A1100();"
18D14I14"118 == (0x200|"
21I50"7) ) goto A1766;
goto A1767;
A1766: A1996( A2114, "
9D14I48"0, (A87) 1, 4, NULL );
goto A1768;
A1767: A1996("
20D22I124", (A91) 0x10, (A87) 0, 4, NULL );
A1768:A5491((A4) 0,(A28) 0x8000000|(A28) 0x4000000);
A583( A2115, A2128 );
if( A1559.A1557"
32D2I2"76"
12D2I2"77"
7D2I2"76"
7D49I26"493 = A1100();
A1101( A232"
56D8I4"3, 4"
14D51I3"102"
57D1I82"3 );
A2114->A574 = A2323;
A1103(( A2323 ),(A6228)0);
if( A2118 == (0x200|0x40 | 7)"
11D2I2"77"
12D2I2"77"
7D19I19"771: A1996( A2114, "
27D4I56"10, (A87) 0, 4, NULL );
goto A1773;
A1772: A1996( A2114,"
13D49I52"10, (A87) 1, 4, NULL );
A1773:
A1559.A1557 = A2501;
"
56D14I2"77"
19D10I18"770:
A2551 = A1044"
16D30I10"5 );
A2114"
35D22I25"4 = A2323;
A2493 = A1100("
27D13I24"103(( A2323 ),(A6228)0);"
20D3I23"118 == (0x200|0x40 | 7)"
13D2I2"77"
12D2I2"77"
7D19I19"775: A1996( A2114, "
27D4I56"10, (A87) 0, 4, NULL );
goto A1777;
A1776: A1996( A2114,"
13D77I28"10, (A87) 1, 4, NULL );
A177"
82D66I12"549 = A1100("
71D30I82"103(( A1101( A2549, A2493, 7 ) ),(A6228)0);
A1101( A2493, A2549, 6 );
if( A2118 =="
40D31
36D18I10"7) && A255"
23D7I22"-1 ||
A2118 == (0x200|"
14D11I32"8) && A2551 == 1 || A1559.A1557
"
20D3I3"778"
11D3I38"1779;
A1778: A1102( A2493 );
goto A178"
8D22I15"779: A2115->A57"
28D129I24"493;
A1780:
A1102( A2549"
134D6I104"1559.A1557 = A2501;
A1774: ;
}
Void
A1037( A1718, A2128 )
struct A561 *A1718;
A78 A2128;
{
struct A561 *"
13D22I1"*"
27D37I43";
A81 A80;
A40 A2118;
A58 A1740;
A78 A2304;"
42D5I76"!A1718 ) return;
A2114 = A1718->A562;
A2118 = A1718->A564;
if( A2118 & 0x400"
14D4I4"1711"
12D18I19"1712;
A1711:
switch"
24D88I33"8 )
{
case (0x400|19):
if( (A2128"
93D82I27"78) 0x04 ||
A2128 & ((A78) "
89D14I119"(A78) 0x800000) && A2128 & (A78) 0x400) &&
(A80 = A1718->A566) &&
(A80->A168.A166 != (A39) 7 || A2128 & (A78) 0x20000)
"
22D4I4"1714"
12D11I11"1715;
A1714"
16D4I70"4 = A235( A234, (A49) A80 );
A1715:
goto A1713;
case (0x400|18):
if( !"
9D23I21" ) goto A1713;
A1037("
28D27I13"4, (A78) 0x02"
33D5I37"115 = A2114->A563;
A1720:
if( A2115) "
13D39I4"16;
"
45D4I32"1717;
A1721: A2115 = A2115->A563"
12D4I32"1720;
A1716:
A1740 = A2115->A567"
9D2I106"04 = A1988( A1740, (A4) 1, (A4) 0 );
if( A2304 & ((A78) 0x80|(A78) 0x1000) ) goto A1722;
goto A1723;
A1722"
7D2I118"04 |= (A78) 0x400;
A1723:
if( A492(A1740) == 33 ) goto A1725;
goto A1726;
A1725: A2304 |= (A78) 0x800000;
A1726:
A1037"
8D55I20"5, (A78) 0x02 | A230"
60D7
15D2I21"21;
A1717:
goto A1713"
12D37I6"400|27"
45D18I11"1718->A7443"
27D4I4"1727"
12D53I32"1766;
A1727:
A3863( A1718->A7443"
58D4I4"1766"
14D2I2"13"
21D2I2"13"
9D44I2"13"
54D4I4"1767"
9D2I2"12"
12D1I9"8 & 0x200"
10D4I4"1768"
12D26I40"1769;
A1768:
if( A2114 && (A2115 = A2114"
31D28I34"3) ) goto A1770;
return;
A1770:
if"
34D46I12"8 & 0x100 ) "
52D28I30"1771;
goto A1772;
A1771:
A1037"
37D25I9"(A78) 0x0"
30I28"A1037( A2115, (A78) 0x02 );
"
6D5I30"1773;
A1772:
switch( A2118 )
{"
14I6"200|0x"
5D10I9"4):
A1037"
19D25I9"(A78) 0x0"
30I28"A1037( A2115, (A78) 0x02 );
"
6D3I3"177"
14D23I43"200|0x40 | 13):
A1037( A2114, (A78) 0x02 );"
29D49I18"2114->A571 & 0x001"
58D3I3"177"
12D18I49"1776;
A1775: A2128 |= (A78) 0x20000;
A1776:
A1037"
24D39I11"5, A2128 );"
46D14I52"1774;
case (0x200|0x40 | 24):
A1037( A2114, A2128 );"
21D43I28"1774;
case (0x200|0x40 | 14)"
48D4I68"37( A2114, A2128 );
if( A2114->A571 & 0x001 ) goto A1777;
goto A1778"
9D4I345"77:
A2128 |= (A78) 0x20000;
A1778:
A1037( A2115, A2128 );
goto A1774;
case (0x200|0x40 | 5):
A1037( A2114, (A78) 0x02 );
A1037( A2115, A2128 );
A1037( A2115->A563, A2128 );
goto A1774;
case (0x200|26):
A1037( A2114, (A78) 0x04 );
A1037( A2115, (A78) 0x02 );
goto A1774;
default:
A1037( A2114, (A78) 0x02 );
A1037( A2115, (A78) 0x02 );
goto A1774"
9D7I85"1774: ;
A1773: ;
goto A1779;
A1769: if( A2114 ) goto A1780;
goto A1781;
A1780:
switch"
14I455"->A564 )
{
case (0x40 | 3):
A1037( A2114, (A78) 0x08 | (A2128 & (((A78) 0x40|((A78) 0x80|(A78) 0x1000)|(A78) 0x100|(A78) 0x800|(A78) 0x200|(A78) 0x400) | (A78) 0x200000)) );
goto A1782;
case (0x40 | 1):
A1037( A2114, (A78) 0x02 );
goto A1782;
case (0x40 | 9):
case (0x40 | 10):
case (0x40 | 11):
case (0x40 | 12):
A1037( A2114, (A78) 0x04 );
goto A1782;
default:
A1037( A2114, A2128 );
goto A1782;
}
A1782: ;
A1781: ;
A1779: ;
A1767: ;
}
Void
A2316( A1718"
14I14", A2313, A2314"
45D13
19D53I3"313"
70D5I25"314;
{
struct A561 *A2114"
10D35I26"115;
A40 A2118;
A4 A2553()"
41D1
7D44I2"&&"
49D5I74"1 & (A91) 0x40 && A2552 ) goto A1711;
goto A1712;
A1711:
A1022++;
A2114 = "
14D19I12"62;
A2118 = "
28D20I154"64;
if( A2118 & 0x400 ) goto A1713;
goto A1714;
A1713:
switch( A2118 )
{
case (0x400|19):
if( A2291 != (A91) 0x20 ) goto A1716;
goto A1717;
A1716: A2317( "
25D72I1","
77D166I67"1, (A87) A2552, A2313, A2314 );
A1717:
goto A1715;
case (0x400|18):"
172D6I6"2313 ="
12D22I134"goto A1720;
goto A1721;
A1720:
A2115 = A2114;
A1725:
if( A2115 = A2115->A563) goto A1722;
goto A1723;
A1722:
A2316( A2115, (A91) 0x20,"
29D275I18"0, A2313, A2314 );"
284D2I49"25;
A1723:
A1721:
goto A1715;
default:
goto A1715"
10D88I24"5: ;
goto A1726;
A1714: "
93D15I7"2118 & "
21D62
72D2I2"27"
12D2I2"66"
7D2I2"27"
9D57I54"2114 && (A2115 = A2114->A563) ) goto A1767;
goto A2100"
62D40I6"67:
if"
47D1I48" & 0x100 ) goto A1768;
goto A1769;
A1768:
A2316("
10D18I60"2291, A2552, A2313, A2314 );
goto A1770;
A1769:
{A79 A2494; "
27D24I29"53 *A2495 = NULL; A79 A2496; "
33D9I16"53 *A2497 = NULL"
14D50I8"71: A249"
58D16I24"4->A570.A6232 <= A2313 ?"
22D49
54D14I51"0.A6232 : A2313; if( A2494 ) goto A1774;
goto A1775"
19D2I24"74: A1085(& A2495, A2114"
7D124I46"0.A6234 ); A1111( & A2495, A2314 ); goto A1776"
129D144I42"75: A1115( & A2495 );
A1776: ; 
A1772:if(0"
154D14I2"71"
19D87I17"73: A2496 = A2115"
92D119I80"0.A6232 <= A2313 ? A2115->A570.A6232 : A2313; if( A2496 ) goto A1779;
goto A1780"
124D70I24"79: A1085(& A2497, A2115"
78D7I43"6234 ); A1111( & A2497, A2314 ); goto A1781"
12D17I20"80: A1115( & A2497 )"
22D18I29"81: ; 
A1777:if(0) goto A1773"
23D157I4"78:
"
166D10I4"2118"
23D8I102"200|0x40 | 4):
A2316( A2114, A2291, A2552, A2313, A2314 );
A2316( A2115, A2291, A2552, A2313, A2314 );"
15D89I21"313 == 4 && !A1974 ) "
97D78I33"83;
goto A1784;
A1783:
{
A81 A80;"
85D17I33"114->A571 & 0x001 &&
A2236( A2114"
22D23I55"7 ) ) goto A1785;
goto A1786;
A1785:
A1098( A2236(A2114"
28D60I5"7), 0"
72D21I11"87;
A1786: "
26D12I56"80 = A2114->A566 ) goto A1788;
goto A1889;
A1788:
A1989("
18D35I41", A80, 4, (A78) 0x01 );
if( A2496 == 4 ) "
42D13I4"890;"
21D3I64"891;
A1890: A2274( A2114, A2115 , 0 );
A1891: ;
A1889: ;
A1787: "
10D86I38"84:
goto A1782;
case (0x200|0x40 | 5):"
92D74I20"2114->A570.A549 == 4"
84D3I3"892"
12D43I37"893;
A1892:
A2316( A2115, A2291, A255"
48D69I33"313, A2314 );
goto A1894;
A1893: "
74D24I20"2114->A570.A548 == 4"
34D3I3"895"
12D17I24"896;
A1895:
A2316( A2115"
22D55I42"3, A2291, A2552, A2313, A2314 );
goto A189"
60D36I15"896: if( A2553("
41D16I54",A2291,A2552) ) goto A1898;
goto A1899;
A1898:
A1996( "
23D10I56"(A91) 0x10, (A87) 0, A2313, A2314 );
goto A1900;
A1899: "
16I6"553(A2"
8D58I17"3,A2291,A2552) ) "
65D2I2"90"
12D2I2"90"
7D12I53"901:
A1996( A2114, (A91) 0x10, (A87) 1, A2313, A2314 "
17D172I26"902:
A1900:
A1897:
A1894:
"
180D2I121"82;
case (0x200|0x40 | 15):
A2316( A2114, (A91) 0x20, (A88) 0, A2313, A2314 );
A2316( A2115, A2291, A2552, A2313, A2314 )"
12D32I39"82;
case (0x200|0x20 | 7):
if( A2496 ) "
39D10I22"903;
goto A1904;
A1903"
17D23I76"2291 != ((A91) 0x40 | (A91) 0x1) || !(~((A88) A2115->A570.A6233)&(A2552)) ) "
30D2I2"90"
12D2I2"90"
7D12I72"905:
A2316( A2114, A2291, A2552 & (A88) A2115->A570.A6233, A2496, A2497 "
17D2I2"90"
7I19"A1904:
if( A2494 ) "
7D97I5"907;
"
104D50I10"908;
A1907"
57D4I74"2291 != ((A91) 0x40 | (A91) 0x1) || !(~((A88) A2114->A570.A6233)&(A2552)) "
13D3I3"909"
12D53I32"910;
A1909:
A2316( A2115, A2291,"
58D34I15"2 & (A88) A2114"
39D1I21"0.A6233, A2494, A2495"
7D144I14"910: ;
A1908:
"
152D4I39"82;
case (0x200|0x20 | 6):
if( A2496 ) "
11D59I3"911"
68D59I14"912;
A1911:
if"
64D1I51"91 != ((A91) 0x40 | (A91) 0x2) || !(A4)(((A88) A211"
6D30I51"70.A6233)&(A2552)) ) goto A1913;
goto A1914;
A1913:"
35D2I9"6( A2114,"
12D9I110"552 & ~(A88) A2115->A570.A6233, A2496, A2497 );
A1914: ;
A1912:
if( A2494 ) goto A1915;
goto A1916;
A1915:
if("
15D38I5" != ("
44D26I6"0x40 |"
33D20I179"0x2) || !(A4)(((A88) A2114->A570.A6233)&(A2552)) ) goto A1917;
goto A1918;
A1917:
A2316( A2115, A2291, A2552 & ~(A88) A2114->A570.A6233, A2494, A2495 );
A1918: ;
A1916:
goto A1782"
28I32"0x200|0x20 | 9):
if( A2291 == (("
5D25I6"0x40 |"
33D25I17"x3) || A2291 == ("
31D26I6"0x40 |"
33D26I66"0x0) ) goto A1919;
goto A2330;
A1919:
{
A91 A2554;
A2554 = A2291 ^"
35D136I4"03;
"
141D4I4"2496"
13D3I3"233"
12D51I54"2332;
A2331:
A2316( A2114, A2291, A2552 & ~(A88) A2115"
56I52"0.A6233 , A2496, A2497 );
A2316( A2114, A2554 , A255"
6D8I56"88) A2115->A570.A6233 , A2496, A2497 );
A2332:
if( A2494"
17D3I3"233"
12D118I54"2334;
A2333:
A2316( A2115, A2291, A2552 & ~(A88) A2114"
123D10I67"0.A6233 , A2494, A2495 );
A2316( A2115, A2554 , A2552 & (A88) A2114"
15D23I44"0.A6233 , A2494, A2495 );
A2334: ;
}
A2330:
"
31D4I39"82;
case (0x200|0x08 | 1):
if( A2496 ) "
10D26I66"2335;
goto A2336;
A2335: A2316( A2114, A2291, A2552 << (A88) A2115"
32I20".A6233, A2313, A2314"
5D55I6"2336:
"
63D4I39"82;
case (0x200|0x08 | 2):
if( A2496 ) "
10D32I4"2337"
40D36I91"2338;
A2337: A2316( A2114, A2291, A2552 >> (A88) A2115->A570.A6233, A2313, A2314 );
A2338:
"
44D79I51"82;
case (0x200|0x40 | 14):
case (0x200|0x40 | 13):"
85D4I18"2114->A571 & 0x001"
13D4I4"2339"
12D52I33"2340;
A2339:
A2316( A2115, A2291,"
57D14I122"2, A2313, A2314 );
A2340:
goto A1782;
default:
goto A1782;
}
A1782:A1115( &A2495 );
A1115( &A2497 );
}
A1770: ;
goto A2341"
19I58"66: if( A2114 ) goto A2342;
goto A2343;
A2342:
switch( A17"
6D9I57"64 )
{
case (0x20 | 8):
A2316( A2114, A2291 ^ (A91) 0x03,"
14D58I68"2, A2313, A2314 );
goto A2344;
case (0x40 | 9):
A2316( A2114, A2291,"
63D3I146"2, A2313, A2314 );
goto A2344;
case (0x40 | 11):
A2316( A2114, A2291, A2552, A2313, A2314 );
goto A2344;
case (0x40|21):
case (0x40|25):
if( A492("
12D18I17"67) <= 20 &&
A492"
24D37I129"->A567) <= 20 ) goto A2345;
goto A2346;
A2345:
A2316( A2114, A2291, A2552, A2313, A2314 );
A2346:
goto A2344;
default:
goto A2344"
42D66I58"2344: ;
A2343:
A2341:
A1726:
A2100:
A1022--;
A1712: ;
}
A4"
71D40I16"3( A1718, A2291,"
45D200I38"2 )
struct A561 *A1718;
A91 A2291;
A88"
205D69I138"2;
{
A88 A2070;
A79 A2292, A2293, A6256, A5697; A87 A6257, A5698; A23 A2296; struct A553 *A2297=0, *A2298=0, *A6258=0, *A5699=0, *A2300=0;"
74D74I366"!A1718 ) return (A4) 0;
A2292 = (A1718->A570).A548; A2293 = (A1718->A570).A549; A6256 = (A1718->A570).A6232; A6257 = (A1718->A570).A6233; A5697 = (A1718->A570).A5661; A5698 = (A1718->A570).A5662; A2296 = (A1718->A570).A552; A2297 
= (A1718->A570).A554; A2298 = (A1718->A570).A555; A6258 = (A1718->A570).A6234; A5699 = (A1718->A570).A5663; A2300 = (A1718->A570).A557;"
80D171I77"6256 != 4 ) return (A4) 0;
A2070 = (A88) A6257;
switch( A2291 )
{
case ((A91)"
177D46I52"| (A91) 0x3): return !(~(A2070)&(A2552));
case ((A91"
52D73I56" | (A91) 0x0): return !(A4)((A2070)&(A2552));
case ((A91"
79D24I43" | (A91) 0x2): return (A4)((A2070)&(A2552))"
31D20I18"((A91) 0x40 | (A91"
25D6I40"): return !!(~(A2070)&(A2552));
default:"
19D41I2"}
"
46D57I28":
return (A4) 0;
}
A4
A5674("
62D65I3"8 )"
79D8
13D2I3";
{"
19D17I3"46,"
22D2I2"47"
8D1
6D25
41D4I6" | 0x8"
9D5I13") &&
(A1746 ="
16D20I25"2) && (A1747 = A1746->A56"
63D41I55"47->A570.A6232 && A1747->A570.A6233 < 0 ) return (A4) 1"
47D29I1"2"
38D46I9"(A4) 0;
}"
60D41I15"
A1039( A2118, "
46D10I67", A1740 )
A40 A2118;
struct A561 *A2114;
A58 A1740;
{
struct A561 *"
15D39I6";
A171"
44D51I34"struct A561 *) A1073( (A41) 14 );
"
61D6I3"4 ="
11D4I16"8;
A1718->A562 ="
10D39
45D17I15"8->A567 = A1740"
23D7I30"8->A569 = A2146;
A1718->A572 ="
12D25I7"9.A593;"
30D2I16"8->A573 = A1217;"
11D3I3"171"
8D31I22"A4
A7183( A1718, A3973"
48D127I1"1"
133D6I17"58 *A3973;
{
A315"
11D1I56"2;
if( !A1718 ) return (A4) 0;
A1742 = ( A7174 = ( A1718"
6D80I69"7 ), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) )"
87D9I40"1742->A303 == 25 && A7175( A1742->A306 )"
42D6I9"
*A3973 ="
11D22I22"2->A306;
return (A4) 1"
30D1I1"
"
6D16I67"1718->A564 == (0x40|21) && !(A1718->A571 & 0x20000) )
return A7183("
21D13I86"8->A562, A3973 );
return (A4) 0;
}
Void
A7302( A1943 )
A68 A1943;
{
struct A561 *A1718"
19D49I1"8"
54D4I34"039( (0x400|20), NULL, A1719.A592 "
9D129I17"718->A569 = A1943"
135D17I16"8->A570.A548 = 4"
22D43I15"18->A570.A549 ="
48D107I18"1718->A570.A6232 ="
112D14I20"1718->A570.A5661 = 0"
19D19I8"14(A1718"
24D94I27"719.A599 = A1718;
}
A4
A227"
100D72I44"18, A2099 )
struct A561 *A1718;
int A2099;
{"
78D13I4"1718"
24D1I1"1"
12D1I1"1"
7D102I45"11: switch( A1718->A564 )
{
case (0x400|18):
"
108D6I89"099 == 1 && A1718->A568 == 0x1900 && A1718->A562 )
return A2273( A1718->A562->A563, 2 );
"
14D83I79"13;
case (0x200 | 0x80 | 3):
case (0x200 | 0x80 | 2):
case (0x200 | 0x80 | 1):
"
89D6I114"099 == 2 && A1718->A562 )
return A2273( A1718->A564 == (0x200 | 0x80 | 3) ?
A1718->A562 :
A1718->A562->A563, 3 );
"
14D2I77"13;
case (0x400|20):
if( A2099 == 3 && A1718->A570.A6233 == 1 ) return (A4) 1"
12D51I12"13;
default:"
60D11I96"13;
}
A1713:
A1712:
return (A4) 0;
}
A58
A8268( A1718, A2903 )
struct A561 *A1718;
A81 A2903;
{
"
16D9I74"1718->A564 == (0x40 | 3) && A1718->A562 &&
A1718->A562->A564 == (0x400|19)"
20D2I2"11"
12D2I2"12"
7D26I43"11:
{
A58 A8295 = A8268( A1718->A562, A2903"
31D33I61"1718->A567 = A530( 25, A8295 );
return A1718->A567;
}
A1712:
"
38D9I24"1718->A564 == (0x400|19)"
20D2I2"13"
12D2I2"14"
7D35I15"13:
A1718->A566"
40D15I3"903"
20D35I8"18->A567"
40D3I29"903->A130;
return A1718->A567"
8D163I12"14:
return 0"
173D69I20"7523( A2114, A2115 )"
84D13I68"2114, *A2115;
{
if( A2115->A568 != 0x800 ) return;
if( A7521( A2114,"
18D20I19"4(A2115,1) ) )
goto"
25D8I13"1;
goto A1712"
14D15I11"1:A865(698)"
21D16I87"2: ;
}
Void
A7756( A7899 )
struct A561 *A7899;
{
struct A561 *A1736; struct A561 *A1835"
21D17I58"36 = A7899->A563;
if( !A1736 )
return;
A1835 = A1736->A563"
23D17I36"3:
if( A1835) goto A1711;
goto A1712"
23D17I34"4: A1835 = A1835->A563;
goto A1713"
23D22I53"1:
if( A7521( A1736, A1835 ) )
goto A1715;
goto A1716"
28D39I10"5:A865(464"
46D8I9"6: ;
goto"
13D14I23"4;
A1712: ;
}
Void
A579"
61D11I15"806, *A2555;
if"
20D30I5" goto"
35D3I7"1;
goto"
8I22"2;
A1711:
A1806 = A171"
6D22I25"2;
A1715:
if( A1806) goto"
27D55I7"3;
goto"
60D29I23"4;
A1713:
A2555 = A1806"
34D31I35"3;
A579(A1806);
A1806 = A2555;
goto"
36I21"5;
A1714:
A1102( A171"
5D33I14"74 );
A1118( &"
38D23I23"->A570 );
A1074( (A49) "
28D24I36", (A41) 14 );
A1712: ;
}
Void
A8278("
30I107" )
struct A561 *A1718;
{
struct A561 *A2555;
A1711:if( A1718 ) goto A1712;
goto A1713;
A1712:
A2555 = A1718"
5D6I152"3;
A579(A1718);
A1718 = A2555;
goto A1711;
A1713: ;
}
Void
A578(A2275)
struct A588 *A2275;
{
A579( A2275->A599 );
A2275->A599 = NULL;
}
A4
A2310( A2291,"
11D94I59"9 )
A91 A2291;
A87 A2069;
{
switch( A2291 )
{
case (A91) 6:"
101D58
63D45I33"9 >= 0;
case (A91) 2: return A206"
51D9I194";
case (A91) 4: return A2069 > 0;
case (A91) 0: return A2069 < 0;
case (A91) 1: return A2069 != 0;
case (A91) 3: return A2069 == 0;
case (A91) 0x10: return A2069 != 0;
default: return (A4) 0;
}
"
14D12I48": ;
}
Void
A7182(A1718,A1948)
struct A561 *A1718"
17D8I17" A1948;
{
A4 A186"
17D7I6"0; if("
12D3I21"8 ) goto A1711;
goto "
8D16
22D1I1"1"
8D13I10"1718->A564"
18D17I24"0x400|20) || A1718->A572"
22D12I8"24) 0x10"
24D1I1"3"
12D1I1"4"
7D24I26"3:
A1868 = (A4) 1;
A1714: "
29D4I11"1948 & 0x01"
16D1I1"5"
12D1I1"6"
7D9I8"5: 
goto"
14D41I1"7"
47D17I44"6:
A1102( A1718->A574 ); A1718->A574 = NULL;"
22D46I6"!A1868"
79D24I19" A1118( &A1718->A57"
29I45"A1721: ; 
A1717:
A1718 = A1718->A562;
A1725:
"
5D23I4"1718"
53I40"6: A1718 = A1718->A563;
goto A1725;
A172"
5D40I31"182( A1718, A1948 ); goto A1726"
54D3I63"12: ;
}
Void
A580(A1718,A2556)
struct A561 *A1718;
A87 A2556;
{"
9D45I4"1718"
56D2I2"11"
12D2I2"12"
7D13I39"11:
A1118(&A1718->A570);
A1718->A570.A5"
18D28I36"A2556 == 0 ? 4 : 0;
A1718->A570.A549"
33D72I16"556 != 0 ? 4 : 0"
77D24I18"18->A570.A6232 = 4"
29D66I22"18->A570.A6233 = A2556"
71D23I30"18->A570.A552 = 0;
A1114(A1718"
29D51I21"18->A572 |= (A24) 0x1"
57D37I57"12: ;
}
A78
A1040(A2278,A1730)
A42 A2278;
A7 A1730;
{
A78"
43D4I111";
A44 A2557;
A2557 = A2133( A2278, (A46) A1730 );
switch( A2557 & 0x7F00 )
{
case 0x2300:
case 0x2400:
A2128 = "
12D3I38"2000; goto A1711;
case 0x400: A2128 = "
11D51I5"2000;"
60D4I38"11;
case 0x500: A2128 = (A78) 0x4000; "
12D17I54"11;
case 0x2900:
A2128 = (A78) 0;
if( A2557 & 1 ) goto"
22D18I1"2"
28D1I1"1"
7D7I3"12:"
14D3I3"|= "
11D31I27"10000;
A1713:
if( A2557 & 2"
42D1I1"1"
12D1I1"1"
7D52I3"14:"
59D4I3"|= "
12D3I71"400000;
A1715:
if( A2557 & 8 ) goto A1716;
goto A1717;
A1716: A2128 |= "
15D9I24"0000;
A1717:
if( A2557 &"
14D30
41D2I2"20"
12D2I2"21"
7D13I9"20: A2128"
19D2I2"78"
10I4"0000"
5D2I2"21"
8D1I46"A2557 & 0x40 ) goto A1722;
goto A1723;
A1722: "
7D3I3"|= "
11D10I23"400;
A1723:
if( A2557 &"
15D31
42D2I2"25"
12D2I2"26"
7D14I9"25: A2128"
20D10I11"78) 0x40000"
17D38I4"26:
"
46D4I41"11;
case 0x2000: A2128 = (A78) 0x100000; "
12D17I44"11;
case 0x1700: A2128 = (A78) 0x40000; goto"
22D80I15"1;
case 0x1900:"
87D21I1"="
30I15"2000 | (A78) 0x"
5D4I1";"
13D4I30"11;
default: A2128 = (A78) 0; "
12D33I19"11;
}
A1711:
return"
39D10I127";
}
struct A561 *
A1038( A1718 )
struct A561 *A1718;
{
struct A561 *A1731;
if( !A1718 ) return NULL;
if( A1718->A564 == (0x200|"
17D11I38"14) || A1718->A564 == (0x200|0x40 | 13"
23D2I2"11"
12D2I2"12"
7D34I4"11:
"
39D32I18"1731 = A1718->A562"
43D2I2"13"
11D3I3"714"
8D30I43"13: A1731 = A1731->A563;
A1714:
return A173"
35D49I69"712:
return NULL;
}
A4
A7757( A1718 )
struct A561 *A1718;
{
A4 A7898 "
54D28I5") 0;
"
36D13I75"561 *A2114;
switch( A1718->A564 )
{
case (0x200|0x40 | 13): A7898 = (A4) 1;"
21D23I49"711;
case (0x200|0x40 | 14):
A2114 = A1718->A562;"
30D3I26"114 && A2114->A571 & 0x800"
13D2I2"71"
12D2I2"71"
7D21I28"712:
A7898 = (A4) 1;
A1713:
"
28D4I13"711;
default:"
12D93I23"711;
}
A1711:
return A7"
98D19I187"}
Void
A2558( A5716, A1746, A2128 )
struct A561 *A5716, *A1746;
A78 A2128;
{
struct A561 *A1747;
A4 A2501;
A4 A2559, A2560;
A96 *A2295, *A2323, *A2493;
A96 *A5278;
A79 A5717, A5718;
A1747"
24D10I3"746"
15D20I99"3;
A583( A5716, (A78) 0x02 );
A5717 = A5716->A570.A549;
A5718 = A5716->A570.A548;
if( A5718 == 4 ) "
27D28I5"711;
"
35D3I32"712;
A1711: A583( A1747, A2128 )"
12D36I29"713;
A1712: if( A5717 == 4 ) "
43D3I80"714;
goto A1715;
A1714: A583( A1746, A2128 );
goto A1716;
A1715:
A2295 = A1100()"
8D70I39"96( A5716, (A91) 0x10, (A87) 1, 4, NULL"
78D6I18"A415 && A415->A163"
12D7I7"30) 0x1"
12D5I8"0 | (A30"
14D91I2"00"
102D3I3"717"
12D27I24"720;
A1717:
A1014( A5716"
33D20I64"720: A2501 = A1559.A1557; A1559.A1557 = (A4) 0;
A5491((A4) 0,(A2"
25D21I11"8000000|(A2"
26D87I1"4"
93D22I15");
A583( A1746,"
29D6I106");
A2559 = A1559.A1557; A1559.A1557 = (A4) 0;
A2323 = A1100();
A1103((A2295),(A6228)0);
A1996( A5716, (A91"
12I44", (A87) 0, 4, NULL );
A5491((A4) 0,(A28) 0x8"
6D52I6"|(A28)"
59D21I18"000);
A583( A1747,"
28D17I80");
A2560 = A1559.A1557; A1559.A1557 = (A4) 0;
A2493 = A1100();
if( A2559 && A256"
28D3I3"721"
12D51I46"722;
A1721:
A2501 = (A4) 1;
A2493 = A5272(A249"
57D37I38"101( A2493, A2323, 5 );
A5278 = A2493;"
45D3I3"723"
9D1I1"2"
9D16I3"559"
26D3I3"725"
12D34I72"726;
A1725:
A1101( A2493, A2323, 5 );
A5278 = A2493;
goto A1727;
A1726: "
40D16I3"560"
26D3I3"766"
12D31I34"767;
A1766:
A1101( A2323, A2493, 5"
36D25I12"5278 = A2323"
34D10I10"768;
A1767"
17D21I9"5717 == 3"
31D3I3"769"
12D36I2"77"
41D12I65"769:
A1101( A2323, A2493, 2 );
A5278 = A2323;
goto A1771;
A1770: "
17D57I9"5718 == 3"
67D3I3"772"
11D86I54"1773;
A1772:
A1101( A2493, A2323, 2 );
A5278 = A2493;
"
92D57I11"1774;
A1773"
63D1I217"1( A2323, A2493, 1 );
A5278 = A2323;
A1774:
A1771:
A1768:
A1727:
A1723:
A1559.A1557 = A2501;
A1103(( A1101( A5278, A2295, 3 ) ),(A6228)0);
A1102( A2295 );
A1102( A2323 );
A1102( A2493 );
A1716: ;
A1713: ;
}
Void
A2561"
6D99I97"30, A1943 )
A72 A1730;
A68 A1943;
{
A87 A2070 = (A87) A1730;
struct A561 *A1718;
A1718 = A1039( ("
104D105I26"|20), NULL, A1719.A592 );
"
110D198I16"->A569 = A1943;
"
203D22I368"->A570.A548 = 0;
A1718->A570.A549 = 4;
A1718->A570.A6232 = 0;
A1718->A570.A5661 = 4;
A1718->A570.A5662 = -A2070;
A1718->A570.A552 = 0x40|0x4000;
A1114(A1718);
A1719.A599 = A1718;
}
A81
A1041( A1718 )
struct A561 *A1718;
{
struct A561 *A1731 = A1038( A1718 );
return A1731 ? A1731->A566 : A1718 ? A1718->A566 : NULL;
}
A81
A7508( A1718 )
struct A561 *A1718;
{
A81 A1942"
28D2I134"A1942 = A1041( A1718 ) )
return A1942;
if( A1718->A564 == (0x40 | 1) )
return A1041( A1718->A562 );
return NULL;
}
Void
A2562( A1718, "
8D1I97")
struct A561 *A1718;
A78 A2128;
{
A81 A80 = A1718->A566;
A70 A2060;
A4 A2563, A1818;
A78 A2304 ="
9D43I76"; extern Void A2564();
if( (A1974 & ~(A17) 8) || !A80 ) return;
A2060 = A492"
48D16I5"->A13"
23D29I5"563 ="
46D2I62"02 && A2060 == 27;
if( A80->A127 & (A27) 0x100 && (A1299 <= 0)"
11D4I4"1711"
12D46I29"1712;
A1711: A1818 = (A4) 1;
"
52D41I20"1713;
A1712: A1818 ="
47D26I8"0;
A1713"
40D5I23"8.A166 == (A39) 7 && !("
26I1")"
9D4I4"1714"
12D31I12"1715;
A1714:"
39D3I10"1718->A571"
8D3I6"800000"
13D4I4"1716"
12D51I18"1717;
A1716: A7827"
56D33I28", A2128 ); 
A1717:
if( A2563"
42D4I4"1720"
12D11I87"1721;
A1720: A1105( A1718, A80->A130, A2563, A1818, (A4) 1, A80 );
A1721:
return;
A1715"
17D75I45"A2060 == 28 &&
A2128 & ((A78) 0x02|(A78) 0x08"
85D4I4"1722"
12D62I36"1723;
A1722:
A7621( A80, (A44) 0x004"
67D28
33D16I11"2128 & (A78"
26D14I1"0"
23D33I6"1725;
"
39D44I37"1726;
A1725:
A7621( A80, (A44) 0x0001"
49D4I20"7806 = (A4) 1;
A1726"
9D38I6"1723:
"
44I9"563 || A2"
7I1"("
8D1I19"8 | (A78) 0x800000)"
10D4I4"1727"
12D3I47"1766;
A1727:
{
A17 A7148 = 0; struct A147 *A211"
9D26I25"04 = A2128 & (A78) 0x4000"
32D33I11"if( A2128 &"
41D29I4"x800"
38D4I4"1767"
12D18I18"1768;
A1767: A1991"
27D1I31"4) 1 );
A1768:
if( A2128 & ((A7"
6D5I1"2"
10D1I1"7"
6D6I55"400) ) goto A1769;
goto A1770;
A1769: A1991( A80, (A4) "
12D24I9"1770:
if("
31D69
79D2I1"4"
13D4I4"1771"
12D26I19"1772;
A1771: A1993("
32D3
10D5
10D4I4"1772"
19I1"("
7D60I3"80|"
68D37I32"1000) && (A1231 <= 0) && !(A2128"
42D80I11"78) 0x20000"
90D4I4"1773"
12D13I63"1774;
A1773:
A1989( A1718, A80, 2, A2304 );
goto A1775;
A1774: "
34D3I6"40 | ("
11D2I2"80"
11D74I1"1"
80D48
56D4I4"1776"
12D61I18"1777;
A1776:
A1989"
72D112I28"0, 4, A2304 );
A1777:
A1775:"
117D138I77"A2128 & (((A78) 0x80|(A78) 0x1000) | (A78) 0x100 | (A78) 0x800 | (A78) 0x200)"
149D2I2"78"
12D2I2"79"
7D24I37"78:
A80->A127 |= (A27) 0x2000;
A1779:"
29D5I35"(A2128 & ((A78) 0x08 | (A78) 0x80))"
10D117I23"(A78) 0x08 | (A78) 0x80"
129D2I2"80"
12D2I2"81"
7D24I40"80:
A80->A5796 |= (A5793) 0x0200;
A1781:"
29D6I27"A2563 || A2128 & (A78) 0x08"
17D32I2"82"
42D2I2"83"
7D8I10"82:
A1105("
13D37I35"8, A80->A130, A2563, A1818, (A4) 0,"
42D1I28");
goto A1784;
A1783:
A1107("
7D21I1","
27D5I46"A2128 );
A1784:
if( A2128 & (A78) 0x1000000 ) "
13D71I74"85;
goto A1786;
A1785: A1990(A80);
A1786:
if( A2128 & ((A78) 0x40 | (A78) "
76D67I26") ) goto A1787;
goto A1788"
72D37I34"87: A7148 = 2; goto A1889;
A1788: "
42D31I35"2128 & ((A78) 0x80|(A78) 0x1000) ) "
38D84I137"890;
goto A1891;
A1890: A7148 = (A1231 > 0) ? 2 : 1;
A1891:
A1889: if( A7148 && (A2113 = ( (A80)->A156 == (A41) 19 ? (A80)->A155.A148 : ("
92D62I47"147 *) 0 )) ) goto A1892;
goto A1893;
A1892:
if"
68D33I87"3 ) goto A1894;
goto A1895;
A1894:
if( A7148 & 2 ) goto A1896;
goto A1897;
A1896: A2113"
38D16I21"61 = 0; A1115( &A2113"
21D1I69"63 ); 
A1898:if(0) goto A1896;
A1899: goto A1900;
A1897: A2113->A5661"
6D29I4"994["
34D23I44"3->A5661][ 0 ];
A1900: ; 
goto A1901;
A1895:"
29D22I8"7148 & 2"
32D3I3"902"
12D72I18"903;
A1902: A1119("
77D27I38"3, &A2272 );
goto A1904;
A1903: A1106("
32D12I57"3, &A2272 );
A1904: ;
A1901: ;
A1893:
A7827( A80, A2128 )"
18D11I130"(A2128 & ((A78) 0x200000|(A78) 0x20000|(A78) 0x80)) == ((A78) 0x200000|(A78) 0x20000|(A78) 0x80)
&& A415 && A684(A80) < A684(A415)"
21D3I3"905"
12D11I23"906;
A1905:
A904( 1536,"
16D78I12");
A1906:
if"
83D112I70"28 & (A78) 0x20000 && A2128 & ((A78) 0x80|(A78) 0x1000) &&
A2060 == 25"
122D3I3"907"
12D34I40"908;
A1907:
A80->A128 |= (A28) 0x1000000"
39D3I3"908"
11D9I12"563 && A2128"
14D2I2"78"
8I6"000000"
10D3I3"909"
12D67I48"910;
A1909:
A285(A80)->A552 |= 0x4000;
A1910:
if"
73D89I29"3 && A2128 & (A78) 0x20000000"
99D1I1"9"
12D1I1"9"
7D1I1"9"
6D4I54"285(A80)->A552 |= 0x8000;
A5672(A1718,3);
A1912:
A5490"
11D28I31"(A28) 0x4000000 );
}
goto A1913"
33D25I7"66: if("
32D59I35"& (A78) 0x02 ) goto A1914;
goto A19"
64D28I31"1914:
A1991( A80, (A4) 0 );
if("
45D30I48"04 ) goto A1916;
goto A1917;
A1916:
A1993( A80, "
37D9I21" );
A80->A127 |= (A27"
15D44I41"000;
goto A1918;
A1917: if( A1718->A571 &"
50D1I46"000 ) goto A1919;
goto A2330;
A1919:
A2304 |= "
12D13
18D4I29";
A2330:
A1918:
if( A2128 & ("
12D30I3"40|"
41D6I1"|"
14D4I6"1000)|"
12D61
66D1I86") goto A2331;
goto A2332;
A2331:
A1990(A80);
A2332:
A7827( A80, A2128 );
if( !(A2128 &"
10D1I1"8"
6D3I110"0) ) goto A2333;
goto A2334;
A2333: A80->A127 |= (A27) 0x2000;
A2334:
A1107( A1718, A80, A2128 );
if( A2128 & "
11D68
75D51I1"0"
60D4I4"2335"
12D11I45"2336;
A2335:
A285(A80)->A552 |= 0x4000;
A2336"
18D10I23"2128 & (A78) 0x20000000"
19D4I4"2337"
12D87I46"2338;
A2337:
A285(A80)->A552 |= 0x8000;
A5672("
92D40I18",3);
A2338:
if( !("
46D130I18"& (A78) 0x8000000)"
139D4I4"2339"
12D37I31"2340;
A2339:
A5490( A80, (A28) "
42D27I15"0000 );
A2340: "
35D43I16"2341;
A1915: if("
49D11I16" & (A78) 0x01 ) "
17D25I30"2342;
goto A2343;
A2342:
A1989"
32D28I10", A80, 4, "
36D3I20"01 );
if( !(A2128 & "
11D15I1"2"
26D4I4"2344"
12D31I28"2345;
A2344: A5490( A80, (A2"
38D1I49"00000 );
A2345: ;
goto A2346;
A2343: if( A2128 & "
11D54
63D4I4"2347"
12D28I57"2348;
A2347:
{
struct A149 *A1948;
A70 A9143;
if( A423 ) "
34D42I6"2349;
"
48D6I104"2350;
A2349:
A493( A423, A80, (A4) 1 );
A8207 = (A4) 1;
A2350:
if( A80->A160 && A2128 & (A78) 0x20000 ) "
12D26I4"2351"
34D124I28"2352;
A2351:
A274( A80->A130"
132D17I15"!(A264 & 0x002)"
26D4I4"2353"
12D33I28"2354;
A2353:
A2564( A268, A8"
39D4I13"2354: ;
A2352"
11D14I8"80->A163"
19D11I22"30) 0x40000000 && A415"
20D4I4"2355"
12D98I11"2356;
A2355"
104D19I76"(A1948 = ( (A80)->A156 == (A41) 20 ? (A80)->A155.A150 : (struct A149 *) 0 ))"
28D4I4"2357"
12D35I63"2358;
A2357:
A1576( ((struct A322 *) A386[A1948->A374]), 2, A80"
40D5I7"2358: ;"
12D23I13"2359;
A2356: "
28D3I40"80->A163 & ((A30) 0x400000|(A30) 0x8000)"
12D6I33"2360;
if( A415 && (A5251 <= 0) ) "
12D60I43"2361;
goto A2362;
A2361: A1575( A408, 2, A8"
66D6I39"2362:
A2360:
A2359:
A9143 = A492( A741("
14D37I41"567) );
if( A9143 != 33 && A9143 != 25 ) "
43D14I5"2363;"
21D16I49"2364;
A2363: A1718->A571 |= 0x800000; 
A2364: ;
}"
23D11I11"2365;
A2348"
20D10I15"28 & (A78) 0x04"
19D3I3"236"
12D12I85"2367;
A2366:
A80->A127 |= (A27) 0x80000;
A1991( A80, (A4) 0 );
A1993( A80, (A78) 0 );"
17D29I20"!(A2128 & (A78) 0x20"
39D66I6"2368;
"
72D49I28"2369;
A2368: A5490( A80, (A2"
54D8I11"4000000|(A2"
13D10I7"8000000"
15D38I11"2369:
A1107"
48D12I1"8"
18D14
22D3I56"367:
A2365:
A2346:
A2341:
A1913:
A5553( A80, A2304 );
if"
8D17I20"28 & (A78) 0x2000 ) "
23D72I6"2370;
"
78D30I60"2371;
A2370:
A1989( A1718, A80, 0, (A78) 0x2000 );
A2371:
if"
35D9I85"28 & (A78) 0x4000 ) goto A2372;
goto A2373;
A2372:
A1989( A1718, A80, 2, (A78) 0x2000"
14D26I5"2373:"
31D88I10"A415 && A4"
93D63I10"163 & (A30"
68D6I55"008 &&
A80->A168.A166 == (A39) 4 &&
!(A80->A127 & ((A27"
11D45I13"1|(A27) 0x80)"
55D4I4"2374"
12D43I15"2375;
A2374:
if"
48D4I6"28 & ("
14D3I1"|"
11D60I3"04|"
68D37I127"2000|(A78) 0x4000|(A78) 0x01) ||
(A2563 || A2128 & ((A78) 0x08|(A78) 0x800000)) &&
A2128 & ((A78) 0x40|(A78) 0x200|(A78) 0x400)"
46D4I4"2376"
12D23I116"2377;
A2376:
A904(1938,A415);
A2377: ;
A2375: ;
}
A5794
A8590( A1718, A8601 )
struct A561 *A1718;
char *A8601;
{
A40"
28D57I23"8, A8602;
struct A561 *"
62I85";
A81 A80;
A5794 A1741;
*A8601 = 0;
if( !A1718 ) return "vacuous tree";
A2118 = A1718"
5D38I20"4;
switch( A2118 )
{"
47D13I6"400|18"
18D2I2"11"
8D3I33"718->A562;
*A8601 = 'f';
A1712:if"
8D3I43"14 ) goto A1713;
goto A1714;
A1713:
A8602 ="
9D1I41"->A564;
if( A8602 == (0x400|19) &&
(A80 ="
6D31I28"4->A566) )
return A918( A80,"
42D20I62"8602 == (0x200|0x40 | 14) ||
A8602 == (0x200|0x40 | 13) ) goto"
25D10I3"5;
"
17D5I46"716;
A1715:
A2114 = A2114->A562;
if( !A2114 ) "
12D33I18"714;
A2114 = A2114"
38D66I12"3;
A1716: ;
"
73D4I11"712;
A1714:"
12D42I35"711;
case (0x400|19):
*A8601 = 's';"
48D4I10"80 = A1718"
11D37I25")
return A918( A80, 0 );
"
44D87I3"711"
97D49I7"40|21):"
58D21I101"40|25):
*A8601 = 'a';
return "cast";
case (0x400|20):
*A8601 = 'a';
return "constant";
default:
A8602"
26D11I41"718->A565;
A1741 = A1610( A8602 ? A8602 :"
16D30I1"8"
39D21I31"1741 && *A1741 ) return A1741;
"
28D59I49"711;
}
A1711:
return "indeterminate";
}
Void
A581"
65I7"8, A256"
5D79I9"566 )
A40"
84D4I26"8;
struct A588 *A2565, *A2"
9D48I35"{
struct A561 *A2567, *A2276;
A2567"
53D23I8"76( A256"
30D26I17"276 = A576( A2566"
31D3I64"2567->A563 = A2276;
A2276->A563 = A1719.A599;
A1719.A599 = A1039"
9D8I20"8, A2567, A1719.A592"
17D18I22"1719.A593 & (A24) 0x10"
28D3I3"711"
12D41I10"712;
A1711"
46D2I57"0( A1719.A599, A1719.A589 );
A1712: ;
}
Void
A582( A2927,"
7D25I64"8 )
struct A588 *A2927;
A40 A2118;
{
A81 A80;
if( A2927->A599 ) "
33D121I2"11"
131D43I28"12;
A1711: A80 = A2927->A599"
48D12I3"6;
"
19D28I50"713;
A1712: A80 = NULL;
A1713:
A2927->A599 = A1039"
34D53I26"8, A2927->A599, A2927->A59"
59D10I34"2927->A599->A571 = A2927->A594;
if"
16D41I6"8 == ("
48D10I5"9) ||"
15D19I19"8 == (0x40 | 11) ) "
27D70I2"14"
80D100I74"15;
A1714:
A2927->A599->A566 = A80;
A1715:
if( A2927->A593 & (A24) 0x10 ) "
108D86I4"16;
"
93D22I10"717;
A1716"
27D96I27"0( A2927->A599, A2927->A589"
102D40I117"717: ;
}
Void
A2274( A2567, A2276, A1709 )
struct A561 *A2567, *A2276;
A17 A1709;
{
A81 A80;
if( A80 = A2567->A566 ) "
48D84I2"11"
94D28I68"12;
A1711:
A1122( A80, &A2276->A570, A1709, A2276 );
A1712: ;
}
Void"
36I61"1718, A2128 )
struct A561 *A1718;
A78 A2128;
{
struct A561 *A"
6D11I46"*A2115;
A40 A2118, A2568;
A78 A2302 = A2128 & "
19D3I29"80000;
A78 A2569 = A2128 & (("
12D3I4"40|("
11D5I2"80"
17I2"0)"
9D1I1"1"
12D1I1"8"
12D7I4"200|"
15I15"400) | (A78) 0x"
8D27I2"| "
35D3I30"1000000);
A78 A2570 = A2128 & "
14D1I6"000|(("
9D6I4"40|("
14D2I1"8"
12D3I5"1000)"
12D1I1"1"
12D7I4"800|"
18D26I22"|(A78) 0x400) | (A78) "
31D86I6"000)|("
95D26I2"1|"
36D2I68"|(A78) 0x04|(A78) 0x08|(A78) 0x10|(A78
) 0x20)|(A78) 0x1000000);
A78"
7D5I43"4;
struct A561 *A5400 = A1023;
if( A1718 ) "
13D18I8"11;
goto"
23D31I1"2"
36D6I43"11:
{
A4 A9144 = (A4) 1;
if( A1718->A573 ) "
13D3I15"713;
goto A1714"
8D54I77"13:
( * ( ( *++ A936 == A1524 ) ? (A1521( (A1523 *)& A936 ), A936) : A936 ) ="
64D23I22"73 );
A1718->A573 = 0;"
31D26I5"1718,"
33D111I3");
"
121D24I48"3 = (*( A936 )--);
return;
A1714:
A1022++;
A1023"
29D17I5"718;
"
22I8" = A1718"
5D12I26"2;
A2118 = A1718->A564;
if"
18D14I12"8 & 0x400 ) "
21D4I41"715;
goto A1716;
A1715:
switch( A2118 )
{"
15D96I25"0|19):
if( A1718->A566 ) "
103D35I22"720;
goto A1721;
A1720"
44D4I4"7071"
23D51I9"6->A130 )"
57D26I63"( ( A7071 ) == 28 || ( A7071 ) == 35 ) && !(A2128 & (A78) 0x10)"
36D3I3"722"
12D10I10"723;
A1722"
16D64I1"!"
74D2
9D3I16"08) || (A2128 & "
11D15I1"8"
20D60I3"00)"
69D4I4"1725"
12D53I39"1726;
A1725:
A6172( A9131, "" );
A1726:"
58D36I38"!(A2128 & ((A78) 0x08|(A78) 0x800000))"
45D4I4"1727"
12D21I73"1766;
A1727:
A6172( A9132, "" );
A1766: ;
A1723: ;
}
A1721:
A2562( A1718,"
28D42I1")"
49D21I47"1718->A566 && A1718->A566->A168.A166 == (A39) 1"
30D4I4"1767"
12D31I31"1768;
A1767: A1718->A571 |= 0x8"
37D60I9" 
A1768:
"
66D24I50"1717;
case (0x400|18):
A2301( A1718, A2114, A2128,"
29D1I16"2 );
A1718->A571"
7D7I16"2114->A571 & 0x8"
12D33I2");"
41D3I3"717"
10D37I49"(0x400|20):
if( A1718->A571 & 0x001 && A2128 & (("
45D14I31"80|(A78) 0x1000)|(A78) 0x40) ) "
21D27I29"769;
goto A1770;
A1769:
if( ("
33D39I79"& (((A78) 0x80|(A78) 0x1000)|(A78) 0x40|(A78) 0x20)) ==
((A78) 0x40|(A78) 0x20)"
48D4I4"1771"
12D63I3"177"
69D26I41"71: A1990( NULL );
goto A1773;
A1772: if("
32D23I119" & (A78) 0x200000 ) goto A1774;
goto A1775;
A1774: A1990( NULL );
goto A1776;
A1775:
{
A315 A1742;
A1742 = ( A7174 = ( "
28D52I20"->A567 ), A7174 >= 0"
57D55I53"315) A387[A7174] : (A865(1232), (A315) A387[1]) );
if"
60D36I53"42->A303 == 25 ) goto A1777;
goto A1778;
A1777:
A1098"
41D4I36"42->A306, 0 );
A1778:
if( A415 && !("
10D25I99"& (A78) 0x2000) ) goto A1779;
goto A1780;
A1779:
A415->A163 |= (A30) 0x8000000;
A1780:
A1993( NULL,"
31D24I34" );
}
A1776: ;
A1773: ;
A1770:
if("
34D343I183"71 & 0x008 ) goto A1781;
goto A1782;
A1781:
A904( 553, A1718->A566 );
A1782:
goto A1717;
case (0x400|27):
if( A416 ) goto A1783;
goto A1784;
A1783:
A1570( 151, NULL, NULL, NULL, NULL,"
350D11I180", 0, 0 );
A1593( A1718->A7443 );
A1571( A1718, NULL );
A1784:
goto A1717;
default:
goto A1717;
}
A1717: ;
goto A1785;
A1716: if( A2118 & 0x200 ) goto A1786;
goto A1787;
A1786:
if( "
16D21I3" &&"
27I8"5 = A211"
5D19I115"63) ) goto A1788;
A1023 = A5400; --A1022; return; 
A1788:
if( A2118 & 0x100 ) goto A1889;
goto A1890;
A1889:
A583( "
24D24I109", A2128 & (A78) 0x02 | (A78) 0x04 | A2569 );
A583( A2115, (A78) 0x02 | A2302 );
A585( A1718, A2118 & ~0x100, "
29D24I25", A2115, A2128 );
A2274( "
29D24I155", A1718 , 0 );
goto A1891;
A1890:
{
A70 A9145;
A70 A9146;
switch( A2118 )
{
case (0x200|0x40 | 4):
if( (A5106 > 0) ) goto A1893;
goto A1894;
A1893:
A7523( "
29I133", A2115 );
A1894:
A2568 = A2115->A564;
if( (A2568==(0x200|0x40 | 5) || A2568==(0x200|0x40 | 8) || A2568==(0x200|0x40 | 7))
&& !(A2115"
5D19I270"1 & 0x200) ) goto A1895;
goto A1896;
A1895:
if( A2128 & ((A78) 0x01|(A78) 0x02|(A78) 0x04|(A78) 0x08|(A78) 0x10|(A78) 0x20) ) goto A1897;
goto A1898;
A1897:A865(821);
A1898: ;
A1896:
A583( A2115, (A78) 0x02 | (A78) 0x400000 |
A1988(A1718->A567, (A4) 0, (A4) 0) );
A583( "
24I33", (A78) 0x01 | A2302 );
if( A2114"
5D19I54"1 & 0x001 ) goto A1899;
goto A1900;
A1899:
if( A2236( "
28D19I52"67 ) ) goto A1901;
goto A1902;
A1901:
A1098( A2236( "
28D19I86"67 ) , 0 );
A1902: ;
A1900:
goto A1892;
case (0x200|0x40 | 13):
A2304 = A1042( A2128, "
24D24I164", A2115 );
A2304 = A1043( A2304, (A4) 0 );
if( A2128 & (A78) 0x10 && A1718->A568 ) goto A1903;
goto A1904;
A1903:
A2304 |= A1040( A1718->A568, 0xFC );
A1904:
A583( "
29I20", A2304 );
if( A2114"
5D19I78"1 & 0x001 ) goto A1905;
goto A1906;
A1905: A2128 |= (A78) 0x20000;
A1906:
if( "
28D84I11"66 &&
A2114"
89D20I21"6->A127 & (A27) 0x100"
30D3I3"907"
12D53I41"908;
A1907: A2128 |= (A78) 0x8000; 
A1908"
59D24I10"5->A571 |="
29D5I53"4->A571 & 0x800000;
A583( A2115, A2128 );
goto A1892;"
14I6"200|0x"
5D35I18"24):
A583( A2114, "
41D19I54");
goto A1892;
case (0x200|0x40 | 14):
A2304 = A1042( "
24D13I37", A2114, A2115 );
A583( A2114, A2304 "
21D13I10"2114->A571"
18D10I37"001 ) goto A1909;
goto A1910;
A1909:
"
16D1I2"|="
10D2I173"20000;
A1910:
A9145 = A492(A741(A2114->A567));
A9146 = A492(A2114->A567);
if( ( A2114->A566 &&
A2114->A566->A168.A166 == (A39) 1 ) ||
( ( ( A9146 ) == 28 || ( A9146 ) == 35 "
7D33I61"A9145 != 33 ) ||
( ( A2114->A571 & 0x800000 ) &&
A9145 != 33 "
44D3I3"911"
12D104I77"912;
A1911:
{
A70 A9147 = A492( A741( A2115->A567));
A2115->A571 |= 0x800000;"
109D70I26"A9147 == 33 ||
A9147 == 25"
80D3I3"913"
12D64I58"914;
A1913: A9144 = (A4) 0; 
A1914: ;
}
A1912:
A583( A2115"
71D72
83D13I11"28 & (A78) "
18D12I2"00"
22D3I3"915"
12D17I23"916;
A1915: A1718->A566"
24D1I1"5"
6D2I9"6;
A1916:"
10D19I50"892;
case (0x200|0x40 | 22):
A2304 = A5271( A2128,"
25D8I64", A2115 );
A2304 = A1043( A2304, (A4) 0 );
A583( A2114, A2304 );"
15D3I17"114->A571 & 0x001"
13D3I3"917"
12D59I48"918;
A1917: A2128 |= (A78) 0x20000;
A1918:
A583("
64D57I25"5, A2302 | (A78) 0x02 );
"
64D31I50"892;
case (0x200|0x40 | 23):
A2304 = A5271( A2128,"
36D23I1"4"
29D81I1"5"
86D21I56"583( A2114, A2304 );
A583( A2115, A2302 | (A78) 0x02 );
"
28D30I27"892;
case (0x200|0x40 | 16)"
37D4I18"492( A2114->A567 )"
11D15
24D3I3"919"
11D128I77"2330;
A1919:
A583( A2114, A2128 );
goto A2331;
A2330:
A583( A2114, (A78) 0x02"
134D97I32"331:
A583( A2115, (A78) 0x02 );
"
104D33I58"892;
case (0x200|0x40 | 5):
A2558( A2114, A2115, A2128 );
"
40D3I71"892;
case (0x200|0x40 | 15):
A583( A2114, A2302 );
A583( A2115, A2128 )"
12D63I101"892;
case (0x200|0x40 | 8):
case (0x200|0x40 | 7):
A2548( A2118, A2114, A2115, (A78) 0x02 | A2302 );
"
70D5I87"892;
case (0x200 | 0x80 | 1):
case (0x200 | 0x80 | 2):
if( A492( A2114->A567 ) == 27 ) "
11D65I6"2332;
"
71D53I74"2333;
A2332:
A583(
A2114,
A2570 | (A78) 0x08 | A2128 & (A78) 0x40000000
);"
60D4I87"2334;
A2333:
A583( A2114, A2570 );
A2334:
A583( A2115, A2302 | (A78) 0x02 );
goto A1892"
14D1I9"200 | 0x8"
10D107I4"583("
112D10I47"5, A2570 );
A583( A2114, A2302 | (A78) 0x02 );
"
17D52I4"892;"
59D59I71"0x200 | 0x80 | 4):
A583( A2114, A2570 & ~(((A78) 0x40|((A78) 0x80|(A78)"
64D75I33"00)|(A78) 0x100|(A78) 0x800|(A78)"
80D53I40"0|(A78) 0x400) | (A78) 0x200000) );
A583"
59D58I2"5,"
63D18I114"0 & ~(((A78) 0x40|((A78) 0x80|(A78) 0x1000)|(A78) 0x100|(A78) 0x800|(A78) 0x200|(A78) 0x400) | (A78) 0x200000) );
"
26D2I65"92;
case (0x200|26):
A1036( A2115, A2114->A567, -2, A2114->A566 )"
13D107I16"2;
default:
A583"
112D4I3"14,"
13D25I49"02 | A2302 );
A583( A2115, (A78) 0x02 | A2302 );
"
34D14I4"2;
}"
19D34I8"2:
A585("
40D10I33", A2118, A2114, A2115, A2128 );
}"
15D6I13"1:
if( A9144 "
14D23I4"2335"
31D26I18"2336;
A2335: A1718"
31D31I10"1 |= A2115"
36D60I24"1 & 0x800000; 
A2336: ;
"
66D125I23"2337;
A1787: if( A2114 "
133D31I4"2338"
39D44I20"2339;
A2338:
switch("
55D18I85"4 )
{
case (0x40 | 3):
A583( A2114, (A78) 0x08 | A2569 | A2128 & (A78) 0x40000000 );
"
24D39I50"2340;
case (0x40 | 1):
if( A2128 & (A78) 0x400000 "
47D4I4"2341"
12D26I12"2342;
A2341:"
36D47I33"71 |= 0x400;
A2342:
A2304 = A1043"
54D21I49", A621(A2114->A567) );
;
A583( A2114, A2304 );
;
"
27D4I110"2340;
case (0x40 | 9):
case (0x40 | 10):
case (0x40 | 11):
case (0x40 | 12):
A583( A2114, (A78) 0x04 | A2570 )"
12D56I69"2340;
case (0x40|21):
case (0x40|25):
{
A70 A2060 = A492( A1718->A567"
61D11I37"4 A6261 = A6235( A1718->A567 );
A2304"
16D29I5"128;
"
35D3I24"060 != 25 && A2060 != 33"
12D3I3"234"
12D63I39"2344;
A2343:
if( (A1308 > 0) && !A6261 "
71D64I6"2345;
"
70D6I135"2346;
A2345:
A2302 |= (A2128 & (((A78) 0x80|(A78) 0x1000)|(A78) 0x400000));
A2346:
A2304 = (A78) 0x02 | A2302;
if( A1718->A562->A566 ) "
12D27I38"2347;
goto A2348;
A2347:
A2060 = A492("
38D45I16"2->A566->A130 );"
52D24I3"060"
29D1I26"7 || A2060 == 25 && !A6261"
10D3I3"234"
14D53I2"50"
58D43I63"49:
A2304 |= A2128 & (A78) 0x1000 ? (A78) 0x1000 : (A78) 0x80;
"
48D4I21"2128 & (A78) 0x200000"
15D2I2"51"
12D2I2"52"
7D32I27"51: A2304 |= (A78) 0x400000"
37D29I4"52: "
34D26I4"50: "
31D43I13"48: ;
A2344:
"
48D4I17"2118 == (0x40|25)"
15D2I2"53"
12D2I2"54"
7D32I28"53: A2304 |= (A78) 0x2000000"
37D19I79"54:
A583( A2114, A2304 );
A1718->A570.A552 |= (A2114->A570.A552 & 0x200000);
}
"
27D31I11"40;
case 0:"
41D1I88"0;
default:
A583( A2114, (A78) 0x02 | A2302 );
goto A2340;
}
A2340:
A584( A1718, A2128 )"
7D23I57"9:
A2337:
A1785:
if( A1559.A1557 ) goto A2355;
goto A2356"
28D77I24"55: A1718->A571 |= 0x020"
82D18I52"56:
A1023 = A5400;
--A1022;
}
A1712: ;
}
Void
A5664("
24D6I139", A2128, A1954 )
struct A561 *A1718;
A78 A2128;
A61 A1954;
{( * ( ( *++ A942 == A1524 ) ? (A1521( (A1523 *)& A942 ), A942) : A942 ) = A1954"
11D53I4"583("
58D114
119D64I31"128 );
( A942 )--;
}
Void
A584("
70I69", A2128 )
struct A561 *A1718;
A78 A2128;
{
struct A561 *A2114 = A1718"
5D89I61"2;
struct A561 *A2571;
struct A561 *A2572;
A79 A2292, A2293, "
94D37I12", A5697; A87"
42D42I54"7, A5698; A23 A2296; struct A553 *A2297=0, *A2298=0, *"
47D74I60"=0, *A5699=0, *A2300=0;
A79 A2320, A2321, A1870, A5709; A87 "
82D82I9"5710; A23"
87D69I26"4; struct A553 *A2325=0, *"
74D83I37"=0, *A6260=0, *A5711=0, *A2328=0;
A70"
89D1I44";
A40 A2118;
A81 A1942;
A4 A4054;
A4 A5719 ="
8D48
53D3I81"20 = (A2114->A570).A548; A2321 = (A2114->A570).A549; A1870 = (A2114->A570).A6232;"
8I258"9 = (A2114->A570).A6233; A5709 = (A2114->A570).A5661; A5710 = (A2114->A570).A5662; A2324 = (A2114->A570).A552; A2325 
= (A2114->A570).A554; A2326 = (A2114->A570).A555; A6260 = (A2114->A570).A6234; A5711 = (A2114->A570).A5663; A2328 = (A2114->A570).A557;
A625"
6D59I31"
A6257 = 0;
A5697 = 0;
A5698 = "
64D44I38"296 = 0;
A2060 = A492( A1718->A567 );
"
49D4I10"2060 == 31"
13D4I4"1711"
12D28I33"1712;
A1711:
A2060 = A492( A8836("
38D1I2"7)"
6D37I3"171"
42D9I5"118 ="
14D2I26"8->A564;
switch( A2118 )
{"
16D86I31"1):
A2292 = 0;
A2293 = 0;
A4054"
93D16I15"28 & (A78) 0x20"
21D60I89"!(A2128 & (A78) 0x08);
if( A5709 && A2324 & 0x4000 && !(A2128 & (A78) 0x01) &&
(A5710 > 0"
65D7I87"5710 == 0 && A4054) ) goto A1714;
goto A1715;
A1714:
A1017( A5709, A5711, A2286(A1718),"
17D12I90"), A5710, A2128, A2324 );
A5719 = (A4) 1;
A1715:
if( (!A5719 || (A5106 > 0)) && A1870 && ("
18D15I6"> 0 ||"
20D3I56"9 == 0 && A4054) ) goto A1716;
goto A1717;
A1716:
A1017("
9D15
22D7I27", A2286(A1718), (0x40 | 1),"
12D61I11"9, A2128, 0"
66D49I66"1717:
A1018( A2320, A2325, A2321, A2326, "", A2286(A1718), A2114 )"
57D9I31"114->A564 == (0x200 | 0x80 | 1)"
18D3I3"172"
12D50I26"1721;
A1720: A2572 = A2114"
55D18I3"2;
"
24D51I20"1722;
A1721: A2572 ="
56D11I9"4;
A1722:"
18D11I3"572"
20D4I4"1723"
12D23I60"1725;
A1723:
{struct A147 *A2113 = &A2572->A570;
if( A416 &&"
28D1I1"3"
7D33I16"1 && A2113->A552"
43D25I8"&&
A2113"
30D16I9"62 == -1 "
24D43I6"1726;
"
49D38I33"1727;
A1726: A2292 = A2113->A5661"
49D11I18"2297, A2113->A5663"
20D4I4"2292"
13D4I4"1768"
12D11I11"1769;
A1768"
21D4I4"2297"
23D4I4"1769"
10D4I4"1766"
17D46I51"1726;
A1767: ;
A1727: ;
}
A1725:
if( A2060 == 27 ) "
52D64I6"1770;
"
70D39I50"1771;
A1770:
{
A87 A2091;
A315 A1742 = ( A7174 = ("
50D1I67"7 ), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1])"
7D60I36"091 = (A87) A1742->A314.A312;
A1772:"
65D34I19"3 = ( 4 ); A1112( &"
39D33I15"8 , A1718->A569"
39D3I3"177"
17D20I13"1772;
A1774:
"
25D4I4"2091"
9D12I4"1870"
21D3I3"177"
12D22I13"1776;
A1775:
"
27D1I8" = A1870"
12D3I3"625"
9D17I16"60 ); if( A6256 "
25D53I6"1779;
"
59D6I65"1780;
A1779:A1112( &A6258 , A1718->A569 );
A1780: ; 
A1777:if(0) "
12D50I75"1775;
A1778:
A6257 = A6259 * A2091;
A1776: ;
}
A1771:
if( A2324 & 0x200000 "
58D13I43"1781;
goto A1782;
A1781:
A2324 &= ~0x200000"
18D23I22"24 |= 0x400000;
A1783:"
28D21I1"6"
26D6I87"324; A1085( &A2300, A2328 ); if( A2296 ) goto A1786;
goto A1787;
A1786:A1112( &A2300 , "
15D20I135"69 );
A1787: ; 
A1784:if(0) goto A1783;
A1785: ;
A1782:
goto A1713;
case (0x40 | 3):
A2292 = 0;
A1788: A2293 = ( 4 ); A1112( & A2298 , "
29D66I46"69 ); 
A1889:if(0) goto A1788;
A1890:
if( A194"
71D27I131"2114->A566 ) goto A1891;
goto A1892;
A1891:
switch( A1942->A168.A166 )
{
case (A39) 1:
if( A492( A1942->A130 ) == 33 ) goto A1893;
"
32D1I284" = 0x10;
goto A1893;
case (A39) 4: A2296 = 0x08; goto A1893;
case (A39) 7: A2296 = 0x20; goto A1893;
default:
goto A1893;
}
A1893:
A1892:
if( A2114->A564 == (0x40 | 1) ) goto A1894;
goto A1895;
A1894:
if( A2571 = A2114->A562 ) goto A1896;
goto A1897;
A1896:
A2296 = (A2571->A570.A552)"
7D9I16"5( &A2300, A2571"
15D14I129".A557 ); 
A1898:if(0) goto A1896;
A1899:
if( A2128 & (A78) 0x2000000 || (A1230 > 0) ) goto A1900;
goto A1901;
A1900:
A6256 = ( 4 "
19D6I15"112( & A6258 , "
15D32I82"69 ); 
A1902:if(0) goto A1900;
A1903:
A6257 = -1;
goto A1904;
A1901:
A6257 = A2571"
38D1
6D9I37"3;
A1905: A6256 = ( A2571->A570.A6232"
16D9I17"5( & A6258, A2571"
15D1I61".A6234 ); 
A1906:if(0) goto A1905;
A1907:
A5698 = A2571->A570"
6D9I37"2;
A1908: A5697 = ( A2571->A570.A5661"
16D9I17"5( & A5699, A2571"
15D116I21".A5663 ); 
A1909:if(0"
124D4I31"1908;
A1910: ;
A1904: ;
A1897: "
12D47I36"1911;
A1895:
A6256 = ( 4 ); A1112( &"
52D32I30"8 , A1718->A569 ); 
A1912:if(0"
40D21I9"1895;
A19"
26D51I25"6257 = -1;
A1911:if(A2296"
59D35I29"1914;
goto A1915;
A1914:A1112"
40D73
79D19I64"1718->A569 );
A1915:
if( A2114->A567 == 21 || A2114->A567 == 22 "
27D54I25"1916;
goto A1917;
A1916:
"
60D54I68"|= 0x200000;
A1918: A2296 = A2324; A1085( &A2300, A2328 ); if( A2296"
64D2I2"33"
12D2I2"33"
7D59I31"331:A1112( &A2300 , A1718->A569"
65D9I20"332: ; 
A1919:if(0) "
16I28"918;
A2330: ;
A1917:
goto A1"
15D176I6" | 2):"
181D11I26"!( A2128 & (A78) 0x80000 )"
21D2I2"33"
12D2I2"33"
7D100I48"333:
A1019( A2320, A2325, A2321, A2326, 0, A2118"
106D3I10"334: A2292"
8D18I29"321; A1085( &A2297, A2326 ); "
24D9I3"292"
19D3I3"337"
12D37I32"338;
A2337:A1112( &A2297 , A1718"
42D2I1"9"
8D2I36"338: ; 
A2335:if(0) goto A2334;
A233"
9D5I4"3 = "
10D1
15D1I1"8"
12D11I10"if( A2293 "
20D34I28"341;
goto A2342;
A2341:A1112"
42D9I25" , A1718->A569 );
A2342: "
14D2I2"33"
17D10I10"336;
A2340"
18D9I3"114"
14D10I22"492(A2114->A567) == 25"
20D3I3"343"
12D10I10"344;
A2343"
17D4I12"2293 > A2292"
14D3I3"345"
12D26I11"346;
A2345:"
31D27I35"6 = A2320; A1085( &A6258, A2325 ); "
33D3I3"256"
13D3I3"349"
12D34I16"350;
A2349:A1112"
42D9I25" , A1718->A569 );
A2350: "
14D3I3"347"
17D11I23"345;
A2348: A6257 = 1; "
19D10I10"351;
A2346"
20D7I11"A2321; A108"
16D15I21", A2326 ); if( A6256 "
24D30I3"354"
39D51I2"35"
56D44I42"354:A1112( &A6258 , A1718->A569 );
A2355: "
49D3I3"352"
17D45I33"346;
A2353: A6257 = 0; 
A2351: ;
"
52D14I31"356;
A2344:
A6257 = (A87) !A625"
19D49I101"357: A6256 = A1870; A1085( &A6258, A6260 ); if( A6256 ) goto A2360;
goto A2361;
A2360:A1112( &A6258 ,"
60D67I1"9"
72D277I19"2361: ; 
A2358:if(0"
286D4I20"357;
A2359: ;
A2356:"
11D24I71"1713;
case (0x20 | 8):
A2362: A2292 = 0; A1115( &A2297 ); 
A2363:if(0) "
31D2I2"36"
7D10I10"364: A2293"
15D18I29"320; A1085( &A2298, A2325 ); "
23D24I3"229"
35D3I3"367"
12D2I73"368;
A2367:A1112( &A2298 , A1718->A569 );
A2368: ; 
A2365:if(0) goto A236"
7D33I17"366:
if( A1870 ) "
40D61I5"369;
"
68D39I2"37"
44D5I44"369:
A6256 = A1870; A1085( &A6258, A6260 ); "
10D13I4"6256"
23D3I3"373"
12D2I73"374;
A2373:A1112( &A6258 , A1718->A569 );
A2374: ; 
A2371:if(0) goto A236"
7D10I116"372:
A6257 = A984( ~A6259, A2060 );
A2370:
A9293( A2324, A2328, 0, NULL );
goto A1713;
case (0x20 | 2):
A2375: A2292"
15D4I4"2320"
16D11I11"2297, A2325"
18D3I3"376"
17D40I17"375;
A2377: A2293"
45D4I4"2321"
16D11I11"2298, A2326"
18D3I3"378"
17D11I76"377;
A2379:
A6257 = A223( (0x200|0x20 | 3), (A87) 0, A6259, A2060, (A4) 0 );"
17D17I14"5976.A5975 & 4"
27D3I3"380"
12D24I11"381;
A2380:"
29D7I35"6 = 0; A1115( &A6258 ); 
A2382:if(0"
16D4I11"380;
A2383:"
12D42I63"384;
A2381: A6256 = A1870; A1085( &A6258, A6260 ); if( A6256 ) "
49D2I14"387;
goto A238"
7D15I55"387:A1112( &A6258 , A1718->A569 );
A2388: ; 
A2385:if(0"
24D4I18"381;
A2386:
A2384:"
11D26I82"1713;
case (0x40 | 9):
case (0x40 | 10):
case (0x40 | 11):
case (0x40 | 12):
{
A87"
31D17I5"3;
A4"
22D6I129"4;
A2573 = (A2118 == (0x40 | 11) || A2118 == (0x40 | 12)) ? -1 : 1;
A2574 = A2118 == (0x40 | 10) || A2118 == (0x40 | 12);
A6257 ="
11D24I3"9 +"
29D28I58"3;
A2389: A6256 = A1870; A1085( &A6258, A6260 ); if( A6256"
38D3I3"392"
12D30I62"393;
A2392:A1112( &A6258 , A1718->A569 );
A2393: ; 
A2390:if(0"
39D5I41"389;
A2391:
A2292 = 0;
if( A2060 == 25 ) "
12D2I93"394;
goto A2395;
A2394:
A2293 = ( 4 ); A1112( & A2298 , A1718->A569 ); 
A2396:if(0) goto A239"
7D21I59"397:
A1018( A2320, A2325, A2321, A2326, "", A2118, A2114 );"
26D67I11"A2324 & 0x2"
79D23I5"398;
"
30D13I35"399;
A2398: A904( 810, A2114->A566 "
18D11I50"399:
A2296 |= 0x80 | A2324 & (0x4000 | 0x200000) ;"
17D4I15"2324 & 0x200000"
15D2I2"00"
12D2I2"01"
7D34I96"00: A1085( &A2300, A2328 ); 
A2401:A1112( &A2300 , A1718->A569 );
if( A2324 & 0x4000 && A5709 ) "
42D2I14"02;
goto A2403"
7D8I8"02: A569"
13D20I30"5709; A1085( &A5699, A5711 ); "
25D18I4"5697"
29D2I2"06"
12D2I2"07"
7D66I3"06:"
74D6I5"A5699"
23I9"
A2407: ;"
5D1I1"0"
17D1I1"0"
7D1I53"05: A5698 = A5710 + A2573; 
A2403: ;
goto A2408;
A239"
6D7
13D7I33"A2320; A1085( &A2298, A2325 ); if"
16D89
98D2I2"11"
12D2I2"12"
7D9I8"11:A1112"
14D3I17"298 , A1718->A569"
10D4I29"12: ; 
A2409:if(0) goto A2395"
9D25I2"10"
31D10I6"!A6257"
15D10I12"6256 > A2292"
21D2I2"15"
12D2I2"16"
7D2I2"15"
8D8I60"2 = (A6256); A1085( &A2297, A6258 ); 
A2417:if(0) goto A2415"
13D2I2"18"
7D14I30"16: if( A6257 && A6256 > A2293"
25D2I2"19"
11D3I3"420"
8D2I2"19"
8D10I10"3 = (A6256"
15D3I3"085"
8D17I10"298, A6258"
24D3I3"421"
18D18I18"19;
A2422:
A2420: "
23D9I25"6257 && A2292 > (4-A6256)"
19D3I3"423"
12D10I10"424;
A2423"
16D22I20"2 = 4-A6256;
A2424: "
27D3I3"413"
17D10I10"410;
A2414"
16D48I25"408:(A1718->A570).A548 = "
53D5I22"; (A1718->A570).A549 ="
11D18I23"; (A1718->A570).A6232 ="
24D69I24"; (A1718->A570).A6233 = "
74D11I80"; (A1718->A570).A5661 = A5697; (A1718->A570).A5662 = A5698; (A1718->A570).A552 ="
16D50I2"6
"
56D2I22"1(&(A1718->A570).A554,"
9D2I68"); A1081(&(A1718->A570).A555, &A2298); A1081(&(A1718->A570).A6234, &"
7D117
124D59I96"1(&(A1718->A570).A5663, &A5699); A1081(&(A1718->A570).A557, &A2300);
A2274( A2114, A1718 , 0 );
"
64D4I4"1870"
10D15I56"060 == 25 && !(A2324 & 0x4000) &&
A2573 > 0 && A6257 > 0"
25D3I3"425"
12D26I2"42"
31D18I76"425:
A1017( A1870, A6260, A2118, A2118, A6257, A2128, 0 );
A2426:
if( A2574 "
27D41I24"427;
goto A2428;
A2427:
"
46D22I67" = (A2320); A1085( &A2297, A2325 ); 
A2429:if(0) goto A2427;
A2431:"
28D145I10" = (A2321)"
151D22I2"5("
28D1I58"8, A2326 ); 
A2432:if(0) goto A2431;
A2433: A2296 = (A2324"
8D132I2"5("
139D44I101", A2328 ); 
A2434:if(0) goto A2433;
A2435:
A6257 = A6259;
A5698 = A5710;
A2428:
if( A2324 & 0x4000 &&"
51D52I111"& (A78) 0x800 && A5709 && A5698 >= 0 ) goto A2436;
goto A2437;
A2436:
A1017( A1870, A6260, A2118, A2118, A6257,"
58D3I79", A2324 );
A2437: ;
}
goto A1713;
case (0x40|21):
case (0x40|25):
{
A315 A2575;"
10D28I3"576"
34D3I20"6059;
A2575 = ( A717"
9D39I164"2114->A567), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) );
A2576 = A2575->A303;
if( A2576 == 33 ) goto A2438;
goto A2439;
A2438:
A2575 = ( A7174"
44D19I198"2575->A306), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) );
A2576 = A2575->A303;
A2439:
if( A2576 == 31 ) goto A2440;
goto A2441;
A2440:
A2576 = A492( A8836(A2114->A567) );
A2441:"
25D1I67" = (A2320); A1085( &A2297, A2325 ); 
A2442:if(0) goto A2441;
A2443:"
7D68I20" = (A2321); A1085( &"
73D37I1","
42D9I104"6 ); 
A2444:if(0) goto A2443;
A2445:
if( A2060 <= 20 && A2576 <= 20 ) goto A2446;
goto A2447;
A2446:
if("
15D12I48" ) goto A2448;
goto A2449;
A2448:
A6257 = A6039("
21D50I98"2576, A2060, &A6059 );
if( A6059 ) goto A2450;
goto A2451;
A2450: A6256 = (A1870); A1085( &A6258, "
55D144I26" ); 
A2452:if(0) goto A245"
149D82I23"453:
goto A2454;
A2451:"
87D1I149"6 = 0; A1115( &A6258 ); 
A2455:if(0) goto A2451;
A2456: ;
A2454: ;
A2449: ;
goto A2457;
A2447: if( A2060 == 25 ) goto A2458;
goto A2459;
A2458:
A2296"
7D75I20"324); A1085( &A2300,"
80I140"8 ); 
A2460:if(0) goto A2458;
A2461:
if( A2576 == 25 || A2576 == 27 ) goto A2462;
goto A2463;
A2462:
{
A72 A2577, A2578;
A315 A2579 = ( A717"
5D80I91" A1718->A567 ), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) );
A315 A258"
85D24I101" A7174 = ( A2579->A306 ), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) );
A315 A258"
29D25I125" A7174 = ( A2575->A306 ), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) );
A70 A8296 = A2581->A303; A4 A7303"
30D45I9"4) 0;
if("
50D1I185"0->A303 == 24 ) goto A2464;
goto A2465;
A2464: A2577 = 1;
goto A2466;
A2465: A2577 = A2580->A305;
A2466:
if( A8296 == 24 || A8296 == 43 ) goto A2467;
goto A2468;
A2467: A2578 = 1; A7303"
6D23I188"4) 1; 
goto A2469;
A2468: A2578 = A2581->A305;
A2469: if( A2577 != A2578 ) goto A2470;
goto A2471;
A2470: A2296 &= ~0x4000;
A2471:
if( A2296 & 0x4000 ) goto A2472;
goto A2473;
A2472: A5697"
28D24I91"5709); A1085( &A5699, A5711 ); 
A2474:if(0) goto A2472;
A2475: A5698 = A5710; 
A2473: A6256"
29D161I21"1870); A1085( &A6258,"
166D1I247"0 ); 
A2476:if(0) goto A2473;
A2477:
if( A2118 == (0x40|25) ) goto A2478;
goto A2479;
A2478:
if( A1870 && A6259 < -1 ) goto A2480;
goto A2481;
A2480:A865(1552);
A2481:
A6257 = -1;
goto A2482;
A2479: if( A2577 ) goto A2483;
goto A2484;
A2483:
A6257"
6D98I37"87) A2578 * A6259 / (A87) A2577;
if( "
104D5I4"&& !"
11D162I45"|| !A6256 && A2577 > A2578 && A2578 && !A7303"
171D4I4"2485"
12D54I11"2486;
A2485"
61D25I12"2324 & 0x800"
34D4I4"2487"
12D42I29"2488;
A2487:A865(433);
A2488:"
47D5I6"!A6256"
10D7I42"1150( A2579->A306,
A2575->A306, (A77) 0x0,"
12I21"& (A77) 0x04000000 ) "
6D24I5"2489;"
30D56I4"8296"
61D57I1"8"
66D47I34"2490;
A865(826);
A2490:
A2489:
if("
52D51
61D4I4"2491"
12D11I89"2502;
A2491: A6257 = -1;
A2502: ;
A2486: ;
goto A2503;
A2484: A6257 = A6259;
A2503:
A2482"
18D54I19"1718->A571 & 0x080 "
62D4I4"2504"
12D34I11"2505;
A2504"
41D23I8"2292 < 2"
32D4I4"2506"
12D55I71"2507;
A2506: A2292 = ( 2 ); A1112( & A2297 , A1718->A569 ); 
A2508:if(0"
63D6I134"2506;
A2509:
A2507:
A2293 = (( 2)<=( A2293 )?( 2):( A2293 ));
A6256 = (( 2)<=( A6256 )?( 2):( A6256 ));
A2296 &= ~0x200;
if(!(A2296)) "
12D76I38"2510;
goto A2511;
A2510: A1115( &A2300"
81D4I13"2511: ;
A2505"
10D25
31D6I45"2512;
A2463: if( A1870 == 4 && A2576 <= 20 ) "
12D32I6"2513;
"
38D6I54"2514;
A2513: A2296 = 0x40;
A2514:
A2512:
if( !A2296 ) "
12D36I4"2515"
44D29I72"2516;
A2515: A2296 = (0x100); A1112( &A2300 , A1718->A569 ); 
A2517:if(0"
37D6I37"2515;
A2518:
A2516:
if( A2320 == 4 ) "
12D79I6"2519;
"
85D23I11"2520;
A2519"
29D15I11"6 = 0; A111"
21D24I18"300 ); 
A2521:if(0"
32D5I43"2519;
A2522: ;
A2520: ;
A2459: ;
A2457: ;
}"
14D61I84"13;
default:
A2292 = 0; A2293 = 0;
}
A1713:
if( A6256 && A2060 != 25 && A2060 != 27 "
69D13I6"2523;
"
19D22I40"2524;
A2523:
if( !A6257 && A6256 > A2292"
31D4I4"2527"
12D11I11"2528;
A2527"
21D5I7"(A6256)"
23D18I19"6258 ); 
A2529:if(0"
26D6I49"2527;
A2530:
A2528: if( A6257 && A6256 > A2293 ) "
12D17I47"2531;
goto A2532;
A2531: A2293 = (A6256); A1085"
24D34I18"8, A6258 ); 
A2533"
47D31I32"2531;
A2534:
A2532: if( A6257 &&"
38D33I12"> (4-A6256) "
41D46I6"2535;
"
52D13I52"2536;
A2535: A2292 = 4-A6256;
A2536: ; 
A2525:if(0) "
19D59I41"2523;
A2526: ;
A2524:(A1718->A570).A548 ="
65D10I173"; (A1718->A570).A549 = A2293; (A1718->A570).A6232 = A6256; (A1718->A570).A6233 = A6257; (A1718->A570).A5661 = A5697; (A1718->A570).A5662 = A5698; (A1718->A570).A552 = A2296
"
16D2I22"1(&(A1718->A570).A554,"
9D266
273D2I22"1(&(A1718->A570).A555,"
8D58I1"8"
65D66I30"1(&(A1718->A570).A6234, &A6258"
73D2I59"1(&(A1718->A570).A5663, &A5699); A1081(&(A1718->A570).A557,"
9D45I15");;
}
Void
A585"
50D62I10"18, A1753,"
75D57I23", A2128 )
struct A561 *"
62D14I154", *A2114, *A2115;
A40 A1753;
A78 A2128;
{
A70 A2060;
A70 A2576, A2582, A2583;
A4 A2584 = (A4) 0;
A17 A7900 = 0; A4 A2585;
A4 A2586 = (A4) 0;
A4 A2587;
A79"
20D22I1","
28D23I1","
29D23I12", A5697; A87"
29D23I1","
28D52I6"8; A23"
58D31I15"; struct A553 *"
36D31I5"=0, *"
36D32I5"=0, *"
37D32I5"=0, *"
37D31I5"=0, *"
36D162I143"=0;
A79 A2320, A2321, A1870, A5709; A87 A6259, A5710; A23 A2324; struct A553 *A2325=0, *A2326=0, *A6260=0, *A5711=0, *A2328=0;
A79 A2588, A2589"
167D154I116"29, A5720; A87 A6262, A5721; A23 A2591; struct A553 *A2592=0, *A2593=0, *A6263=0, *A5722=0, *A2595=0;
A2320 = (A2114"
166D16I16"; A2321 = (A2114"
28D16I16"; A1870 = (A2114"
29D2I1";"
7D9I10"9 = (A2114"
22D16I16"; A5709 = (A2114"
29D16I16"; A5710 = (A2114"
29D16I16"; A2324 = (A2114"
28D24I17"; A2325 
= (A2114"
36D24I16"; A2326 = (A2114"
36D24I16"; A6260 = (A2114"
37D24I16"; A5711 = (A2114"
37D24I16"; A2328 = (A2114"
36D155
161D17I5"8 = ("
26D98I9"70).A548;"
103D177I51"9 = (A2115->A570).A549; A2129 = (A2115->A570).A6232"
182D136
141D10I78"(A2115->A570).A6233; A5720 = (A2115->A570).A5661; A5721 = (A2115->A570).A5662;"
15D35I164"1 = (A2115->A570).A552; A2592 
= (A2115->A570).A554; A2593 = (A2115->A570).A555; A6263 = (A2115->A570).A6234; A5722 = (A2115->A570).A5663; A2595 = (A2115->A570).A55"
40D14I20"292 = 0;
A2293 = 0;
"
22D32I156"0;
A6257 = 0;
A5697 = 0;
A5698 = 0;
A2296 = 0;
A2060 = (( A7174 = ( A1718->A567 ), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) )->A303);
"
37D4I10"2060 == 31"
13D4I4"1711"
12D75I33"1712;
A1711:
A2060 = A492( A8836("
85D37I2"7)"
42D19I37"1712:
if( A1753 == (0x200|0x40 | 13) "
28D63I5"713;
"
69D6I69"1714;
A1713:
{
A81 A80;
A4 A8225 = (A4) 1;
if( A1870 && A6259 >= 0 ) "
12D31I6"1715;
"
37D64I13"1716;
A1715:
"
69D4I118"6259 == 0 &&
(A2060 != 27 && A2128 & (A78) 0x08 ||
A2060 == 27 && !(A2128 & (((A78) 0x200|(A78) 0x400) | (A78) 0x40)))"
13D40I33"1717;
A1017( A1870, A6260, A2286("
45D6I25"), A1753, A6259, A2128, 0"
11D19I37"1717: ;
A1716:
if( A80 = A2115->A566 "
27D13I6"1720;
"
19D13I13"1721;
A1720:
"
18D5I54"80->A168.A166 != (A39) 7
&& A80->A168.A166 != (A39) 6
"
13D4I4"1722"
12D52I36"1723;
A1722: A8225 = (A4) 0;
A1723:
"
57D4I23"80->A163 & (A30) 0x0010"
13D3I3"172"
12D63I55"1726;
A1725: A8225 = (A4) 0;
A1726: ;
A1721:
if( A8225 "
71D13I6"1727;
"
19D52I114"1766;
A1727:
A1018( A2320, A2325, A2321, A2326, "left ",
A2286(A1718), A2114 );
A1766: ;
}
A1714:
if( A2060 <= 20 "
60D46I6"1767;
"
52D66I62"1768;
A1767:
if( !(A2060 & 1) ) goto A1769;
goto A1770;
A1769:"
71D31I21"6 = (A4) 1;
A1770: ;
"
37D6I31"1771;
A1768: if( A2060 <= 23 ) "
12D90I6"1772;
"
96D49I76"1773;
A1772:
switch( A1753 )
{
case (0x200|0x20 | 4):
A1775: if(A2588 > A232"
58D38I4"1778"
46D77I11"1779;
A1778"
83D19I38"2 = A2588; A1085( &A2297, A2592 ); if("
24D30I2"2 "
38D55I6"1782;
"
61D57I4"1783"
62D22I24"82:A1112( &A2297 , A1718"
27D71I65"9 );
A1783: ; 
A1780:if(0) goto A1778;
A1781: goto A1784;
A1779: "
76D41I4"2320"
50D4I4"1785"
12D18I18"1786;
A1785: A2292"
23D55I39"320; A1085( &A2297, A2325 ); if( A2292 "
63D124I6"1889;
"
130D6I65"1890;
A1889:A1112( &A2297 , A1718->A569 );
A1890: ; 
A1787:if(0) "
12D34I41"1785;
A1788: goto A1891;
A1786: A2292 = 0"
40D73
78D23I14"2297 ); 
A1892"
36D43I44"1786;
A1893: ;
A1891: ;
A1784: ; 
A1776:if(0"
51D5I12"1775;
A1777:"
12D95I76"1774;
case (0x200|0x20 | 5):
case (0x200|0x20 | 10):
A1894: A2292 = (A2320);"
102D70I30" &A2297, A2325 ); 
A1895:if(0)"
77D50I23"1894;
A1896:
if( A2588 "
58D82I6"1897;
"
88D5I112"1898;
A1897:
{
A67 A1730 = (( A2588)==4 ? 414 : ( A2588)>=2 ? 414 : 795 );
A884( A1730, A1113(A2592) );
}
A1898:"
12D23I88"1774;
case (0x200|0x40 | 4):
case (0x200|0x40 | 15):
A1899: A2292 = (A2588); A1085( &A22"
28D76I19"2592 ); 
A1900:if(0"
84D6I67"1899;
A1901: A2293 = (A2589); A1085( &A2298, A2593 ); 
A1902:if(0) "
12D50I65"1901;
A1903: A2296 = (A2591); A1085( &A2300, A2595 ); 
A1904:if(0"
58D6I45"1903;
A1905:
if( A1753 == (0x200|0x40 | 4) ) "
12D60I37"1906;
goto A1907;
A1906: A2274( A2114"
65D2I3"15 "
10D64I47"1907:
goto A1774;
default: goto A1774;
}
A1774:"
70D16I23"->A570).A548 = A2292; ("
25D19I24"70).A549 = A2293; (A1718"
25D89I23").A6232 = A6256; (A1718"
95I88").A6233 = A6257; (A1718->A570).A5661 = A5697; (A1718->A570).A5662 = A5698; (A1718->A570)"
6D126I1"="
132D28I11"
; A1081(&("
37D70I16"70).A554, &A2297"
75D14I6"081(&("
23D19I138"70).A555, &A2298); A1081(&(A1718->A570).A6234, &A6258); A1081(&(A1718->A570).A5663, &A5699); A1081(&(A1718->A570).A557, &A2300);;
return;
"
25D52I13"1908;
A1773: "
57D25I3"206"
30D84I2"27"
93D4I4"1909"
12D40I20"1910;
A1909:
A1105( "
45D22I1","
33D6I33"7, (A4) 1, (A4) 0,
A2128 & (A78) "
11D14I45"00 ? (A4) 0 : (A4) 1, A2115->A566 );
return;
"
20D80I13"1911;
A1910: "
85D3I69"2060 != 33 && A2060 != 25 &&
A1753 != (0x200|0x40 | 13) && A2060 != 2"
13D4I4"1912"
12D12I90"1913;
A1912:
(A1718->A570).A548 = A2292; (A1718->A570).A549 = A2293; (A1718->A570).A6232 ="
17D1I22"6; (A1718->A570).A6233"
8D215I4"7; ("
224D90I12"70).A5661 = "
95D38I23"; (A1718->A570).A5662 ="
43D34I30"8; (A1718->A570).A552 = A2296;"
39D16I30"1
(&(A1718->A570).A554, &A2297"
21D37I6"081(&("
46D31I83"70).A555, &A2298); A1081(&(A1718->A570).A6234, &A6258); A1081(&(A1718->A570).A5663,"
38D1I182"); A1081(&(A1718->A570).A557, &A2300);;
return;
A1913:
A1911:
A1908:
A1771:
A2576 = (( A7174 = ( A2114->A567 ), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) )->A303"
6D18I209"582 = (( A7174 = ( A2115->A567 ), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) )->A303);
A2583 = (( A2576)>( A2582 )?( A2576):( A2582 ));
A2587 = A2583 <= 20 && !(A2583 & 1);
if( A2583 <= 20 "
26D23I6"1914;
"
29D6I35"1915;
A1914:
if( !A1870 && A2320 ) "
12D20I39"1918;
goto A1919;
A1918: A1870 = A2320;"
27D25I72"= 0; A6260 = A2325; 
A1919: ; 
A1916:if(0) goto A1914;
A1917: if( !A2129"
30D31I4"2588"
41D2I2"33"
12D2I2"33"
7D53I4"332:"
58D2I29"9 = A2588; A6262 = 0; A6263 ="
7D10I43"2; 
A2333: ; 
A2330:if(0) goto A1917;
A2331"
15D9I5"1915:"
16I44"= A1870 <= A2129 ? A1870 : A2129; if( A6256 "
9D3I3"336"
12D27I25"337;
A2336: A1085(&A6258,"
32D18I58"0 ); A1111( &A6258, A6263 ); A1112( &A6258, A1718->A569 );"
26D5I51"338;
A2337: A1115( &A6258 );
A2338: ; 
A2334:if(0) "
11D48I20"1915;
A2335:
switch("
53D42I29")
{
case (0x200|0x20 | 1):
if"
48D10I38"6 ) goto A2340;
goto A2341;
A2340: if("
15I69" > A2321) goto A2344;
goto A2345;
A2344: A2293 = A2589; A1085( &A2298"
7D41I7" ); if("
46D54I34"3 ) goto A2348;
goto A2349;
A2348:"
62D6I5"A2298"
23D7I16"
A2349: ; 
A2346"
21D37I31"344;
A2347: goto A2350;
A2345: "
42D81I4"2321"
91D3I3"351"
12D103I10"352;
A2351"
118D11I16"; A1085( &A2298,"
16D9I3"6 )"
30D3I3"355"
12D18I18"356;
A2355:A1112( "
24D48I1" "
64I22"
A2356: ; 
A2353:if(0)"
8D11I41"351;
A2354: goto A2357;
A2352: A2293 = 0;"
28D16I7" 
A2358"
30D10I69"352;
A2359: ;
A2357: ;
A2350: ; 
A2342:if(0) goto A2340;
A2343:
A2341"
31D1I1"3"
6D15I12"360: A2292 ="
21I37" <= A2588 ? A2320 : A2588; if( A2292 "
9D2I2"36"
12D2I2"36"
7D19I4"363:"
26D1
11I24"325 ); A1111( &A2297, A2"
7D11I29"A1112( &A2297, A1718->A569 );"
19D28I17"365;
A2364: A1115"
37D14
19D3I3"365"
10D3I3"361"
17D12I39"360;
A2362:
A2584 = (A4) 1;
A7900 = 2;
"
19D53I76"339;
case (0x200 | 0x80 | 2):
A6262 = -A6262;
case (0x200 | 0x80 | 1):
A2366"
59D38I19"3 = ( 4 ); A1112( &"
43D2I30"8 , A1718->A569 ); 
A2367:if(0"
11D5I54"366;
A2368:
if( !A1870 && A2114->A564 == (0x40 | 1) ) "
12D64I5"369;
"
71D2I2"37"
7D4I188"369:
{
struct A561 *A2596;
A315 A1742;
A1742 = ( A7174 = ( A2114->A567 ), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) );
if( A1742->A303 == 27 && (A2596 = A2114->A562) )"
12D53I5"371;
"
60D2I88"372;
A2371:
A1870 = A2596->A570.A6232; A6260 = A2596->A570.A6234; 
A2373:if(0) goto A237"
7D36I114"374:
A6259 = A2596->A570.A6233 * (A87) A1742->A314.A312;
A2372: A6256 = A1870 <= A2129 ? A1870 : A2129; if( A6256 "
45D39I5"377;
"
47D74I10"78;
A2377:"
81D30I70"&A6258, A6260 ); A1111( &A6258, A6263 ); A1112( &A6258, A1718->A569 );"
38D2I2"37"
7D15I42"378: A1115( &A6258 );
A2379: ; 
A2375:if(0"
24D5I44"372;
A2376: ;
}
A2370:
if( A2324 & 0x4000 ) "
12D137I3"380"
147D50I61"81;
A2380:
A5697 = A5709 <= A2129 ? A5709 : A2129; if( A5697 "
59D3I3"384"
12D28I11"385;
A2384:"
35D13I36"&A5699, A5711 ); A1111( &A5699, A626"
18D12I29"A1112( &A5699, A1718->A569 );"
20D11I50"386;
A2385: A1115( &A5699 );
A2386: ; 
A2382:if(0)"
19D12I35"380;
A2383:
A5698 = A5710 + A6262;
"
17D4I38"5697 && A5698>0 && A2128 & (A78) 0x800"
14D3I3"387"
12D40I57"388;
A2387:
A1017( A5697, A5699, A2286(A1718), A1753, A56"
46D18I40"128, A2324 );
A2388: ;
A2381:
if( A6256 "
27D12I5"389;
"
19D51I49"390;
A2389:
A6257 = A6259 + A6262;
if( A6257 > 0 "
60D45I5"391;
"
52D85I2"39"
90D16I51"391:
A1017( A6256, A6258, A2286(A1718), A1753, A625"
21D63I6"128, 0"
69D115I20"392: ;
A2390:
A1018("
121D11I1","
16D11I49"5, A2321, A2326, "left ", A2286(A1718), A2114 );
"
16D4I46"1718->A564 & 0x100 && A2114->A570.A552 & 0x200"
14D3I3"393"
12D91I34"394;
A2393:
A904( 810, A2114->A566"
97D20I36"394:
if( A2114->A570.A552 & 0x800 )
"
27D26I3"395"
36D88I33"96;
A2395:A865( 815 );
A2396:
if("
93D16I26"4 & 0x100 && (A1273 <= 0) "
25D37I3"397"
47D50I71"98;
A2397: A2296 = (0x100); A1112( &A2300 , A1718->A569 ); 
A2399:if(0)"
58D57I12"397;
A2400:
"
64D11I142"401;
A2398: A2296 = (0x80); A1112( &A2300 , A1718->A569 ); 
A2402:if(0) goto A2398;
A2403:
A2401:
A2296 |= A2324 & (0x10|0x4000);
if( A2324 & "
16D71I6"000 ) "
78D11I33"404;
goto A2405;
A2404:
A2296 |= "
16D38I70"000;
A1085( &A2300, A2328 );
A1112( &A2300 , A1718->A569 );
A2405:
if("
43D10I4"6 &&"
17D42I61"< 0 && A1870 == 4 &&
A2324 & ((0x01 | 0x02 | 0x04) | (0x08 | "
49D25I72"0x20 | 0x40)) && !(A2324 & 0x80) ) goto A2406;
goto A2407;
A2406:
A1016("
30D17I2"6,"
22D3I16"8, A2286(A1718),"
9D18I29" );
A2407:
if( A1718->A565 !="
28D109I8"40 | 16)"
119D3I3"408"
12D24I46"409;
A2408:
A7900 = 2;
A2409:
goto A2339;
case"
31D44I23" | 0x80 | 4):
if( A6256"
54D3I3"410"
12D15I85"411;
A2410: A6257 = A6259 - A6262;
A2411:
A1018( A2320, A2325, A2321, A2326, "left ","
21D58I17", A2114 );
A1018("
63D22I9"8, A2592,"
27D17I36"9, A2593, "right ", A1753, A2115 );
"
24D5I97"339;
case (0x200 | 0x80 | 3):
A2412: A2293 = ( 4 ); A1112( & A2298 , A1718->A569 ); 
A2413:if(0) "
12D20I2"41"
25D3I3"414"
11D28I12"591 & 0x4000"
38D3I3"415"
12D24I24"416;
A2415:
A5697 = A187"
30D11I11"5720 ? A187"
16D4I4"5720"
11D4I4"5697"
14D3I3"419"
12D10I10"420;
A2419"
20D11I11"5699, A6260"
24D10I10"5699, A572"
24D4I4"5699"
28D10I10"421;
A2420"
21D4I4"5699"
10D3I3"421"
10D3I3"417"
17D34I10"415;
A2418"
39D32I5"A5697"
41D3I3"422"
12D11I19"423;
A2422: A5698 ="
16D36I18"9 + A5721;
A2423:
"
41D4I40"5697 && A5698 > 0 && A2128 & (A78) 0x800"
14D3I3"424"
12D23I58"425;
A2424:
A1017( A5697, A5699, A2286(A1718), A1753, A569"
28D19I2"12"
26D34I32"1 );
A2425: ;
A2416:
if( A6256 )"
42D51I5"426;
"
58D47I19"427;
A2426:
A6257 ="
52D12I14"9 + A6262;
if("
17D1I5"7 > 0"
11D3I3"428"
12D11I18"429;
A2428:
A1017("
17D38I1","
43D46
51D46I4"286("
51D42I25"), A1753, A6257, A2128, 0"
48D38I20"429: ;
A2427:
A1018("
43D1I62"8, A2592, A2589, A2593, "right ", A2286(A1718), A2115 );
A2296"
6D13I81"2591 & 0x100 && (A1273 <= 0)) ? 0x100 : 0x80;
A2296 |= A2591 & (0x4000|0x200000);"
19D9I7"2591 & "
14D15I3"000"
25D3I3"431"
12D67I24"432;
A2431: A1085( &A230"
72D34I30"595 ); 
A2432:A1112( &A2300 , "
39D25I35"->A569 );
if( A1870 && A6259 < 0 &&"
30D59I59"1 & ((0x01 | 0x02 | 0x04) | (0x08 | 0x10 | 0x20 | 0x40)) ) "
66D78I5"433;
"
85D4I62"434;
A2433:
A1016( A1870, A6260, A2286(A1718), A6259 );
A2434:"
12D24I9"339;
case"
34D12I65"20 | 4):
A2435: A2293 = A2321 <= A2589 ? A2321 : A2589; if( A2293"
22D1I1"4"
12D1I1"4"
7D1I1"4"
6D25I12"1085(&A2298,"
30D28I58"6 ); A1111( &A2298, A2593 ); A1112( &A2298, A1718->A569 );"
36D5I51"440;
A2439: A1115( &A2298 );
A2440: ; 
A2436:if(0) "
12D19I52"435;
A2437:
case (0x200|0x20 | 7):
A2441: if(A2588 >"
25D37
46D1I1"4"
12D1I1"4"
7D1I1"4"
6I15"2292 = A2588; A"
5D30I7" &A2297"
41D29I11"if( A2292 )"
37D51I5"448;
"
58D26I49"449;
A2448:A1112( &A2297 , A1718->A569 );
A2449: "
31D40I8"446:if(0"
49D5I12"444;
A2447: "
12D2I2"45"
7D12I8"445: if("
19D36
45D3I3"451"
12D11I26"452;
A2451: A2292 = A2320;"
18D6I7" &A2297"
17D53I11"if( A2292 )"
61D51I5"455;
"
58D26I49"456;
A2455:A1112( &A2297 , A1718->A569 );
A2456: "
31D40I8"453:if(0"
49D5I12"451;
A2454: "
12D2I2"45"
7D55I44"452: A2292 = 0; A1115( &A2297 ); 
A2458:if(0"
64D5I45"452;
A2459: ;
A2457: ;
A2450: ; 
A2442:if(0) "
12D2I2"44"
7D18I38"443:
A2584 = (A4) 1;
A7900 = 3; A9293("
23D17I7"4, A232"
24D35I12"1, A2595 );
"
42D16I80"339;
case (0x200|0x20 | 5):
case (0x200|0x20 | 10):
A2460: A2292 = (A2320); A108"
21D15I13"2297, A2325 )"
20D3I3"461"
17D11I15"460;
A2462:
if("
16D54I1"8"
64D2I2"46"
12D2I2"46"
7D4I21"463:
{
A67 A1730 = (("
9D50I15"8)==4 ? 414 : ("
55D138I33"8)>=2 ? 414 : 795 );
A884( A1730,"
143D41I48"3(A2592) );
}
A2464:
A2584 = (A4) 1;
A7900 = 1;
"
48D10I82"339;
case (0x200|0x20 | 6):
A2465: if(A2589 > A2321) goto A2468;
goto A2469;
A2468"
21D3I5"A2589"
8D7I6"085( &"
12D14I7", A2593"
21D2I2"47"
17D67I11"468;
A2471:"
75D5I24"472;
A2469: if( A2321 ) "
12D55I4"473;"
63D57I64"474;
A2473: A2293 = (A2321); A1085( &A2298, A2326 ); 
A2475:if(0"
66D5I12"473;
A2476: "
12D2I114"477;
A2474: A2293 = 0; A1115( &A2298 ); 
A2478:if(0) goto A2474;
A2479: ;
A2477: ;
A2472: ; 
A2466:if(0) goto A246"
7D11I12"467: A2292 ="
17D1I11" <= A2588 ?"
6D35I3"0 :"
41D58I12"; if( A2292 "
67D3I3"482"
12D28I11"483;
A2482:"
35D1
11I24"325 ); A1111( &A2297, A2"
7D13
20D11I50"484;
A2483: A1115( &A2297 );
A2484: ; 
A2480:if(0)"
19D14I44"467;
A2481:
A2584 = (A4) 1;
A7900 = 2;
A9293"
20D4I26"4, A2328, A2591, A2595 );
"
11D22I33"339;
case (0x200|0x20 | 9):
A2485"
32D1
6D17I11" <= A2588 ?"
22D16I21"0 : A2588; if( A2292 "
25D12I5"488;
"
19D30I18"489;
A2488: A1085("
36D16I34", A2325 ); A1111( &A2297, A2592 );"
24D28I34"490;
A2489: A1115( &A2297 );
A2490"
35D2I2"48"
17D2I2"48"
7D12I27"487:
A2584 = (A4) 1;
A9293("
17D12I2"4,"
17D23I19"8, A2591, A2595 );
"
30D23I74"339;
case (0x200|0x08 | 2):
case (0x200|0x08 | 1):
A2491: A2292 = (A2320);"
30I1" "
5D1I1"7"
7D28I17"5 ); 
A2502:if(0)"
36D51I71"491;
A2503:
A2584 = (A4) 1;
A7900 = 3;
A9293( A2324, A2328, 0, NULL );
"
58D21I51"339;
case (0x200|0x10 | 3): A2585 = A6259 == A6262;"
29D5I57"597;
case (0x200|0x10|0x04 | 3): A2585 = A6259 != A6262; "
12D11I49"597;
case (0x200|0x10 | 1):
A2585 = A2587 ? (A88)"
16D19I9"9 > (A88)"
25D19I16" : A6259 > A6262"
28D3I3"597"
19D40I75"10|0x04 | 2):
A2585 = A2587 ? (A88) A6259 >= (A88) A6262 : A6259 >= A6262;
"
47D3I85"597;
case (0x200|0x10 | 2):
A2585 = A2587 ? (A88) A6259 < (A88) A6262 : A6259 < A6262"
12D65I40"597;
case (0x200|0x10|0x04 | 1):
A2585 ="
70D56I38"7 ? (A88) A6259 <= (A88) A6262 : A6259"
61D22I13"6262;
A2597:
"
27D4I22"492(A2114->A567) == 25"
14D3I3"504"
12D58I77"505;
A2504:
if( A1753 == (0x200|0x10 | 3) || A1753 == (0x200|0x10|0x04 | 3) )"
66D51I5"506;
"
58D51I2"50"
56D57I40"506:
if( A1753 == (0x200|0x10|0x04 | 3) "
66D12I5"508;
"
19D12I35"509;
A2508: A2585 = !A2585;
A2509:
"
18D3I16"585 && A6256 > 2"
13D3I3"510"
12D2I20"511;
A2510: A6256 = "
7D36I8"511:
if("
41D16I27"0 > A6256 && A2588 > A6256 "
25D12I5"512;
"
19D51I62"513;
A2512: A6256 = A2320 <= A2588 ? A2320 : A2588; if( A6256 "
60D45I5"516;
"
52D23I88"517;
A2516: A1085(&A6258, A2325 ); A1111( &A6258, A2592 ); A1112( &A6258, A1718->A569 );"
31D5I51"518;
A2517: A1115( &A6258 );
A2518: ; 
A2514:if(0) "
12D17I17"512;
A2515: A2585"
22D40I51"4) 1; 
A2513:
if( A2320 > A6256 && A2589 > A6256 ) "
47D90I5"519;
"
97D2I2"52"
7D14I22"519: A6256 = A2320 <= "
19D2I60" ? A2320 : A2589; if( A6256 ) goto A2523;
goto A2524;
A2523:"
9D6I5"&A625"
11I24"325 ); A1111( &A6258, A2"
7D12I29"A1112( &A6258, A1718->A569 );"
20D33I16"525;
A2524: A111"
42D9I11" );
A2525: "
14D3I3"521"
17D39I17"519;
A2522: A2585"
44D29I4"4) 0"
34D8I40"520:
if( A2321 > A6256 && A2588 > A6256 "
17D2I14"526;
goto A252"
7D17I78"526: A6256 = A2321 <= A2588 ? A2321 : A2588; if( A6256 ) goto A2530;
goto A253"
22D21I4"530:"
28D7I30"&A6258, A2326 ); A1111( &A6258"
13D17I34"2 ); A1112( &A6258, A1718->A569 );"
25D12I51"532;
A2531: A1115( &A6258 );
A2532: ; 
A2528:if(0) "
19D9I48"526;
A2529: A2585 = (A4) 0; 
A2527:
if( A1753 =="
19D36I11"10|0x04 | 3"
47D2I2"53"
12D2I2"53"
7D3I47"533: A2585 = !A2585;
A2534: ;
goto A2535;
A2507"
9D1I1"8"
31D8I28""left ",
A2286(A1718), A2114"
13D57I17"1018( A2588, A259"
62D116I54"589, A2593, "right ",
A2286(A1718), A2115 );
A2535: ;
"
123D4I11"536;
A2505:"
10D9I58"1753 == (0x200|0x10 | 3) || A1753 == (0x200|0x10|0x04 | 3)"
19D3I3"537"
12D52I12"538;
A2537:
"
57D4I29"1753 == (0x200|0x10|0x04 | 3)"
14D3I3"539"
12D2I93"540;
A2539: A2585 = !A2585;
A2540:
if( A2320 > A6256 && A2588 > A6256 ) goto A2541;
goto A254"
7D82I10"541: A6256"
87D28I28"320 <= A2588 ? A2320 : A2588"
35D4I4"6256"
14D2I2"54"
12D11I59"598;
A2545: A1085(&A6258, A2325 ); A1111( &A6258, A2592 ); "
19D7I5"A6258"
23D22
30D36I20"599;
A2598: A1115( &"
41D21I24" );
A2599: ; 
A2543:if(0"
30D5I73"541;
A2544: A2585 = (A4) 1; 
A2542:
if( A2320 > A6256 && A2589 > A6256 ) "
12D19I23"600;
goto A2601;
A2600:"
24D39I46"6 = A2320 <= A2589 ? A2320 : A2589; if( A6256 "
48D26I23"604;
goto A2605;
A2604:"
33D30I70"&A6258, A2325 ); A1111( &A6258, A2593 ); A1112( &A6258, A1718->A569 );"
38D5I51"606;
A2605: A1115( &A6258 );
A2606: ; 
A2602:if(0) "
12D50I26"600;
A2603: A2585 = (A4) 0"
55D8I40"601:
if( A2321 > A6256 && A2588 > A6256 "
17D1I13"607;
goto A26"
7D9I9"607: A625"
15D28I28"321 <= A2588 ? A2321 : A2588"
35D3I3"625"
14D3I3"611"
12D11I59"612;
A2611: A1085(&A6258, A2326 ); A1111( &A6258, A2592 ); "
19D7I5"A6258"
23D22
30D65I3"613"
70D2I26"12: A1115( &A6258 );
A2613"
7I12"A2609:if(0) "
7D3I3"607"
8D4I28"10: A2585 = (A4) 0; 
A2608:
"
9D9I29"1753 == (0x200|0x10|0x04 | 3)"
19D3I3"614"
12D21I168"615;
A2614: A2585 = !A2585;
A2615: ;
A2538: ;
A2536:
A6257 = (A87) A2585;
if( A6256 <= 2 && !A2271 &&
!( A2114->A564 == (0x400|20) && A2115->A564 == (0x400|20) ) ) goto"
26D25I7"6;
goto"
30D21I15"7;
A2616: A2292"
26D3I25"2 ); A1112( & A2297 , A17"
9D21I23"69 ); 
A2629:if(0) goto"
26D21I14"6;
A2630: A229"
27D3I25"2 ); A1112( & A2298 , A17"
9D283I17"69 ); 
A2631:if(0"
292D60I10"630;
A2632"
67D8I49"617:
if( (A5106 > 0) && !(A2128 & (A78) 0x80000) "
17D64I5"633;
"
71D4I55"634;
A2633:
A5246( A6256, A6258, A6257, A1753 );
A2634:"
12D63I57"339;
case (0x200|0x40 | 7):
if( !(A2128 & (A78) 0x80000) "
72D2I14"635;
goto A263"
7D102I41"635:
A1019( A2320, A2325, A2321, A2326, 1"
107D8I2"53"
13D18I68"1019( A2588, A2592, A2589, A2593, 2, A1753 );
A2636: if(A2588 > A232"
28D2I14"639;
goto A264"
7D18I20"639: A2292 = (A2588)"
28D27I27"A2297, A2592 ); 
A2641:if(0"
36D5I12"639;
A2642: "
12D63I22"643;
A2640: if( A2320 "
72D10I22"644;
goto A2645;
A2644"
16D9I11"2 = (A2320)"
19D27I27"A2297, A2325 ); 
A2646:if(0"
36D13I1"6"
19D57I4"647:"
65D2I2"64"
7D33I31"645: A2292 = 0; A1115( &A2297 )"
38D3I3"649"
17D22I1"6"
28D37I36"650: ;
A2648: ;
A2643: ; 
A2637:if(0"
46D5I64"636;
A2638: A2293 = A2321 <= A2589 ? A2321 : A2589; if( A2293 ) "
12D61I3"653"
70D15I25"654;
A2653: A1085(&A2298,"
20D8I28"6 ); A1111( &A2298, A2593 );"
16D5I51"655;
A2654: A1115( &A2298 );
A2655: ; 
A2651:if(0) "
12D63I22"638;
A2652:
if(A6256) "
70D104I4"656;"
112D40I17"657;
A2656: A6257"
45D44I40"87) (A6259 && A6262);
A2657:
A7900 = 3;
"
51D64I57"339;
case (0x200|0x40 | 8):
if( !(A2128 & (A78) 0x80000) "
72D67I6"2658;
"
73D28I154"2659;
A2658:
A1019( A2320, A2325, A2321, A2326, 1, A1753 );
A1019( A2588, A2592, A2589, A2593, 2, A1753 );
A2659: A2292 = A2320 <= A2588 ? A2320 : A2588; "
33D125I4"2292"
134D4I4"2662"
12D101I59"2663;
A2662: A1085(&A2297, A2325 ); A1111( &A2297, A2592 );"
108D6I52"2664;
A2663: A1115( &A2297 );
A2664: ; 
A2660:if(0) "
12D42I66"2659;
A2661: if(A2589 > A2321) goto A2667;
goto A2668;
A2667: A229"
47D86I43"A2589); A1085( &A2298, A2593 ); 
A2669:if(0"
94D6I13"2667;
A2670: "
12D13I13"2671;
A2668: "
19D75I3"321"
84D4I4"2672"
12D131I18"2673;
A2672: A2293"
136D4I4"2321"
16D11I11"2298, A2326"
17D4I4"2674"
17D33I30"2672;
A2675: goto A2676;
A2673"
39D17I11"3 = 0; A111"
23D10I3"298"
16D4I4"2677"
17D11I63"2673;
A2678: ;
A2676: ;
A2671: ; 
A2665:if(0) goto A2661;
A2666"
18D47I4"6256"
56D26I6"2679;
"
32D30I18"2680;
A2679: A6257"
35D22I38"87) (A6259 || A6262);
A2680:
A7900 = 2"
30D25I12"2339;
case ("
30D32I18"|0x40 | 15):
A2681"
38D1I1"2"
7D94I41"588); A1085( &A2297, A2592 ); 
A2682:if(0"
102D6I67"2681;
A2683: A2293 = (A2589); A1085( &A2298, A2593 ); 
A2684:if(0) "
12D61I67"2683;
A2685: A6256 = (A2129); A1085( &A6258, A6263 ); 
A2686:if(0) "
68D75I48"685;
A2687:
A6257 = A6262;
A2688: A5697 = (A5720"
86D12I11"A5699, A572"
19D4I4"2689"
17D11I33"2688;
A2690:
A5698 = A5721;
A2691"
17D11I10"6 = (A2591"
22D6I5"A2300"
12D1I1"5"
7D4I4"2692"
17D69I13"2691;
A2693:
"
75D67I58"2339;
case (0x200|0x40 | 5):
if( !(A2128 & (A78) 0x80000) "
75D69I6"2694;
"
75D32I86"2695;
A2694:
A1019( A2320, A2325, A2321, A2326, 1, A1753 );
A2695:
{
struct A561 *A261"
37D17I146"2115->A563;
A79 A2621, A2622, A2801, A5723; A87 A6264, A5724; A23 A2624; struct A553 *A2625=0, *A2626=0, *A6265=0, *A5725=0, *A2628=0;
if( !A2618 "
25D19
25D48I17"if( A2321 == 4 ) "
55D13I4"696;"
21D14I52"697;
A2696: A2292 = A2588; A1085( & A2297, A2592 ); "
19D8I4"2292"
17D4I4"2702"
12D54I40"2703;
A2702:A1112( & A2297 , A1718->A569"
59D20I19"2703: ; 
A2700:if(0"
28D47I20"2696;
A2701: A2293 ="
52I16"9; A1085( & A229"
7D19I5"3 ); "
24D4I4"2293"
13D4I4"2706"
12D21I64"2707;
A2706:A1112( & A2298 , A1718->A569 );
A2707: ; 
A2704:if(0"
29D30I18"2701;
A2705: A6256"
35D10I13"129; A1085( &"
15D1I1"8"
7D20I5"3 ); "
25D17I7"6256 ) "
23D4I4"2710"
12D12I20"2711;
A2710:A1112( &"
17D30I34"8 , A1718->A569 );
A2711: ; 
A2708"
43D31I53"2705;
A2709: A5697 = A5720; A1085( & A5699, A5722 ); "
36D10I4"5697"
19D4I4"2714"
12D41I64"2715;
A2714:A1112( & A5699 , A1718->A569 );
A2715: ; 
A2712:if(0"
49D23I11"2709;
A2713"
29D11I9"6 = A2591"
21D27I27" A2300, A2595 ); if( A2296 "
35D49I6"2718;
"
55D6I66"2719;
A2718:A1112( & A2300 , A1718->A569 );
A2719: ; 
A2716:if(0) "
12D44I12"2713;
A2717:"
49D11I32"7 = A6262; A5698 = A5721; 
A2698"
24D18I33"2696;
A2699: ; 
goto A2720;
A2697"
25D25I9"2320 == 4"
34D3I3"272"
12D92I26"2722;
A2721:
A2621 = ( A26"
100I1" "
6D14I15"; A2622 = ( A26"
22I1" "
6D14I15"; A2801 = ( A26"
22I1" "
7D14I15"; A6264 = ( A26"
22I1" "
7D14I15"; A5723 = ( A26"
22I1" "
7D14I15"; A5724 = ( A26"
22I1" "
7D14I15"; A2624 = ( A26"
22I2" 
"
6D22I15"; A2625 = ( A26"
30I1" "
6D22I15"; A2626 = ( A26"
30I1" "
6D22I15"; A6265 = ( A26"
30I1" "
7D22I15"; A5725 = ( A26"
30I1" "
7D22I15"; A2628 = ( A26"
30I1" "
6D25I107";
A2723: A2292 = A2621; A1085( & A2297, A2625 ); if( A2292 ) goto A2728;
goto A2729;
A2728:A1112( & A2297 ,"
31D115
120D36I144"9 );
A2729: ; 
A2726:if(0) goto A2723;
A2727: A2293 = A2622; A1085( & A2298, A2626 ); if( A2293 ) goto A2732;
goto A2733;
A2732:A1112( & A2298 ,"
47D50I85"9 );
A2733: ; 
A2730:if(0) goto A2727;
A2731: A6256 = A2801; A1085( & A6258, A6265 );"
55D72I8"A6256 ) "
78D14I5"2736;"
21D15I125"2737;
A2736:A1112( & A6258 , A1718->A569 );
A2737: ; 
A2734:if(0) goto A2731;
A2735: A5697 = A5723; A1085( & A5699, A5725 ); "
20D109I53"5697 ) goto A2740;
goto A2741;
A2740:A1112( & A5699 ,"
115D98I30"->A569 );
A2741: ; 
A2738:if(0"
106D6I65"2735;
A2739: A2296 = A2624; A1085( & A2300, A2628 ); if( A2296 ) "
12D73I4"2744"
81D35I28"2745;
A2744:A1112( & A2300 ,"
40D3I33"8->A569 );
A2745: ; 
A2742:if(0) "
9D63I33"2739;
A2743: A6257 = A6264; A5698"
68D7I18"724; 
A2724:if(0) "
13D109I47"2723;
A2725: ;
goto A2746;
A2722:
A1115( &A6258"
118D21I113"2321 == 3 ) goto A2747;
goto A2748;
A2747:
A5676( &A1718->A570, &A2115->A570, &A2618->A570 );
goto A2749;
A2748: "
26D80I89"2320 == 3 ) goto A2750;
goto A2751;
A2750:
A5676( &A1718->A570, &A2618->A570, &A2115->A57"
85D21I83"goto A2752;
A2751:
A5675( &A1718->A570, &A2115->A570, &A2618->A570 );
A2752:
A2749:"
28D353I22";
A2746: ;
A2720: ;
}
"
359D21I32"2339;
case (0x200|0x40 | 4):
A51"
26D66I51"2292 = (A2588); A1085( &A2297, A2592 ); 
A5112:if(0"
74D6I67"5111;
A5113: A2293 = (A2589); A1085( &A2298, A2593 ); 
A5114:if(0) "
12D79I9"5113;
A51"
84D2I2"62"
7D101I29"(A2129); A1085( &A6258, A6263"
107D4I4"5116"
17D35I28"5115;
A5117:
A6257 = A6262;
"
40D15I125"415 && A415->A163 & ((A30) 0x0200|(A30) 0x0100) &&
A1031( A2114, 0x200 ) &&
A492( A575->A130 ) == 25 &&
A1031( A2115, 0x400 )"
24D4I4"5118"
12D137I100"5119;
A5118:
A892( A415->A163 & (A30) 0x0200 ? 1554 : 1555,
A575, A415, 0 );
A5119:
if( A2114->A566 "
145D15I5"5120;"
22D35I34"5121;
A5120:
{struct A147 *A2113;
"
40D13I93"2113 = ( ( A2114->A566 )->A156 == (A41) 19 ? ( A2114->A566 )->A155.A148 : (struct A147 *) 0 )"
22D4I4"5122"
12D29I69"5123;
A5122:
if( A2113->A552 & (0x01 | 0x02 | 0x04) && A2113->A552 & "
34D1I90"
&& A2113->A548 != 4 ) goto A5124;
goto A5125;
A5124:
A904( A2113->A552 & ((0x08 | 0x10 | "
8D50I107"0x40) | 0x100) ?
672 : 423, A2114->A566 );
A5125: ;
A5123: ;
}
A5121: A5697 = (A5720); A1085( &A5699, A5722"
56D4I4"5126"
17D12I88"5121;
A5127:
A5698 = A5721;
A5128: A2296 = (A2591); A1085( &A2300, A2595 ); 
A5129:if(0)"
19D107I66"5128;
A5130:
if( A2114->A566 && A2114->A566->A127 & (A27) 0x10000 "
115D62I6"5131;
"
67D31I12"2296 & 0x800"
40D4I4"5132"
12D34I65"5133;
A5132: A2296 = (A2296 & ~0x800) | 0x200;
goto A5134;
A5133:"
40D15I15"2296 & 0x200 ) "
21D4I4"5135"
12D29I31"5136;
A5135: A2296 = (A2296 & ~"
34D73I82") | 0x400;
A5136:
A5134:
A5131:
A2274( A2114, A2115, 0 );
if( A2128 & ~(A78) 0x02 "
81D13I6"5137;
"
19D27I77"5138;
A5137: A2562( A2114, A2128 | (A78) 0x8000000 );
A5138:
goto A2339;
case"
37D39I46"40 | 13):
case (0x200|0x40 | 14):
A5256: A2292"
45D10I28"2588); A1085( & A2297, A2592"
16D4I4"5727"
17D25I69"5256;
A5728: A2293 = ( A2589); A1085( & A2298, A2593 ); 
A5729:if(0) "
31D70I16"5728;
A5730: A62"
75D35I48"( A2129); A1085( & A6258, A6263 ); 
A5731:if(0) "
41D6I69"5730;
A5732: A5697 = ( A5720); A1085( & A5699, A5722 ); 
A5733:if(0) "
12D76I18"5732;
A5734: A2296"
82D10I28"2591); A1085( & A2300, A2595"
16D4I4"5735"
17D12I55"5734;
A5736: A6257 = A6262; A5698 = A5721; 
A5257:if(0)"
19D36I12"5256;
A5726:"
43D57I10"2339;
case"
67D72I34"40 | 23):
case (0x200|0x40 | 22):
"
78D42I14"2339;
default:"
49D50I15"2339;
}
A2339:
"
55D24I8"7900 & 1"
33D4I4"5737"
12D13I65"5738;
A5737: A7896( A1753, "left", A2320, A2325, A2114 );
A5738:
"
18D31I8"7900 & 2"
40D4I4"5739"
12D137I76"5740;
A5739: A7896( A1753, "right", A2588, A2592, A2115 );
A5740:
if( A6256 "
145D15I5"5741;"
22D34I21"5742;
A5741:
if(A2584"
42D4I4"5743"
12D16I121"5744;
A5743:
A6257 = A223( A1753, A6259, A6262, A2060, (A4) 0 );
if( A5976.A5975 & 4 )
goto A5745;
goto A5746;
A5745: A62"
21D101I16"0; A1115( &A6258"
107D4I4"5747"
17D16I49"5745;
A5748: ;
A5746: ;
A5744:
if( A2060 != 25 ) "
22D34I24"5749;
goto A5750;
A5749:"
39D14I23"!A6257 && A6256 > A2292"
23D3I3"578"
12D10I10"5783;
A578"
15D9I2"29"
14D63I28"A6256); A1085( &A2297, A6258"
69D3I3"578"
17D12I48"5782;
A6060:
A5783: if( A6257 && A6256 > A2293 )"
19D75I29"6061;
goto A6062;
A6061: A229"
80D12I28"A6256); A1085( &A2298, A6258"
18D4I4"6063"
17D60I18"6061;
A6091:
A6062"
67D30I24"6257 && A2292 > (4-A6256"
40D4I4"6092"
12D84I10"6093;
A609"
89D87I30"292 = 4-A6256;
A6093: ; 
A5751"
100D213I190"5749;
A5752: ;
A5750: ;
A5742:(A1718->A570).A548 = A2292; (A1718->A570).A549 = A2293; (A1718->A570).A6232 = A6256; (A1718->A570).A6233 = A6257; (A1718->A570).A5661 = A5697; (A1718->A570).A56"
218I369"A5698; (A1718->A570).A552 = A2296
; A1081(&(A1718->A570).A554, &A2297); A1081(&(A1718->A570).A555, &A2298); A1081(&(A1718->A570).A6234, &A6258); A1081(&(A1718->A570).A5663, &A5699); A1081(&(A1718->A570).A557, &A2300);
}
A5972
A7901( A1718, A1753, A1875, A1740 )
struct A561 *A1718;
A40 A1753;
A87 A1875;
A58 A1740;
{
if( !A1718 ) return 0;
switch( A1718->A564 )
{
case "
5D2I71" | 2): return A7901( A1718->A562, A1611(A1753), -A1875, A1740 );
case ("
9D67I80"8): if( (A1753 & 0x3) == 3 )
return A7901( A1718->A562, A1753, ~A1875, A1740 );
"
73D13I15"1711;
default:
"
19D26I26"1711;
}
A1711:
if( A1753 ="
37D2I70"10|0x04 | 3) || A1753 == (0x200|0x10 | 2) || A1753 == (0x200|0x10|0x04"
7D65I121" )
return -A7901( A1718, A6007(A1753), A1875, A1740 );
if( !A7759( 0, A1718, &A7768, A1740 ) ) return 0;
if( A1740 <= 16 "
73D24I5"1712;"
31D139I75"1713;
A1712:( A7769 = (A87) A1394, A7770 = (A87) ~ A1394, A7771 = A1396 );
"
145D50I13"1714;
A1713: "
55D4I10"1740 <= 18"
13D4I4"1715"
12D92I73"1716;
A1715:( A7769 = (A87) A1395, A7770 = (A87) ~ A1395, A7771 = A5987 )"
100D70I33"1717;
A1716: ( A7769 = (A87) A598"
75D4I65"770 = (A87) ~ A5988, A7771 = A5989 );
A1717:
A1714:
A7772 = A625("
12D69I94";
if( A7772 < 0 ) return 0;
if( A7768.A7765 & 1 )
return A7779( A7768.A7762, 'L', A7768.A7763,"
75D110I16", A1875, A1740 )"
118D49I29"768.A7766 & 1 )
return A7779("
54D49I25"8.A7762, 'R', A7768.A7764"
54D8I1"5"
13I7"875, A1"
14D49I5"0;
}
"
61D6I10" *
A8772( "
11D19I20", A4234, A5629 )
A40"
25I211";
struct A7758 *A4234;
struct A7758 *A5629;
{
A87 A1956; A87 A1957; struct A7758 A1754; struct A7758 *A2883 = &A1754;
struct A7758 *A8773;
memset((A49)(& A1754 ),0,(size_t)(sizeof( A1754 )));
if( ((A5629)->A7762"
14D3I8") ) goto"
8D23I3"1;
"
32D13I1"2"
19D8I16"1: A1957 = A5629"
15D2I53"; A8773 = A4234; if( A1753 == (0x200|0x20 | 1) ) goto"
7D19I30"3;
goto A1714;
A1713: if( A877"
26D20I3"2 ="
25D21I38"200|0x20 | 1) ) goto A1715;
goto A1716"
27D3I170"5: A1956 = A8773->A7763; 
A1717: A2883->A7762 = (0x200|0x20 | 1); A2883->A7765 = 1; A2883->A7763 = ( A1956+A1957 ); 
A1720:if(0) goto A1717;
A1721: ; 
goto A1722;
A1716: "
8D255I15"8773->A7765 & 1"
266D2I2"23"
12D2I2"25"
7D8I16"23: A1956 = A877"
15D23I1"3"
29D22I98"26: A2883->A7762 = (0x200|0x20 | 3); A2883->A7765 = 1; A2883->A7763 = ( A1956+A1957 ); 
A1727:if(0"
32D3I13"26;
A1766: ; "
12D2I2"67"
7D101I17"25: A1956 = A8773"
107D22I60"4; if( A1956 >= A1957 ) goto A1768;
goto A1769;
A1768: A2883"
28D10I29"2 = (0x200|0x20 | 3); A2883->"
15D7I11" = 1; A2883"
17D61I28"( A1956-A1957 ); 
A1770:if(0"
71D4I11"68;
A1771: "
12D1I1"7"
7D15I17"69:
A2883->A7762 "
33D43I7"; A2883"
49D61I50"5 = 1; A2883->A7763 = ( A1957-A1956 ); 
A1773:if(0"
71D14I2"69"
19D42I4"74: "
47D10I62"72: ; 
A1767: ;
A1722: ;
goto A1775;
A1714: if( A8773->A7762 ="
28D33I3" ) "
41D2I14"76;
goto A1777"
7D15I8"76: A195"
20D4I4"8773"
10D8I59"3; if( A1956 > A1957 )
goto A1778;
goto A1779;
A1778: A2883"
14D12I27"2 = (0x200|0x20 | 1); A2883"
18D9I12"5 = 1; A2883"
16D18I43" = ( A1956-A1957 ); 
A1780:if(0) goto A1778"
23D4I14"81: goto A1782"
9D85I8"79:
A288"
96D42
56D3I65"3); A2883->A7766 = 1; A2883->A7764 = ( A1957-A1956 ); 
A1783:if(0"
13D14I2"79"
19D2I33"84: ;
A1782: ; 
goto A1785;
A1777"
8D61I5"A8773"
67D15I5"5 & 1"
26D2I2"86"
12D2I2"87"
7D17I17"86: A1956 = A8773"
32D26I15"956 >= A1957 )
"
34D2I2"88"
11D3I3"889"
8D9I9"88: A2883"
15D36I27"2 = (0x200|0x20 | 3); A2883"
42D50I12"5 = 1; A2883"
56D16I32"3 = ( A1956-A1957 ); 
A1890:if(0"
26D13I1"8"
18D2I64"891: goto A1892;
A1889: A2883 = NULL;
A1892: ; 
goto A1893;
A178"
7D11I11"956 = A8773"
17D16I16"4; 
A1894: A2883"
23D13I1" "
29D41I9"3); A2883"
47D36I12"6 = 1; A2883"
42I128"4 = ( A1956+A1957 ); 
A1895:if(0) goto A1894;
A1896: ; 
A1893: ;
A1785: ;
A1775: ;
goto A1897;
A1712: A1957 = A4234->A7763; A877"
5D41I15"5629; if( A1753"
62D1I52") goto A1898;
goto A1899;
A1898: if( A8773->A7762 =="
16D4I80"1) ) goto A1900;
goto A1901;
A1900: A1956 = A8773->A7763; 
A1902: A2883->A7762 ="
23D66I47"A2883->A7765 = 1; A2883->A7763 = ( A1956+A1957 "
72D7I10"903:if(0) "
14D2I2"90"
7D58I35"904: ; 
goto A1905;
A1901: if( A877"
65D69
74D1
11D3I3"906"
12D17I25"907;
A1906: A1956 = A8773"
24D8I15"; 
A1908: A2883"
14D27I27"2 = (0x200|0x20 | 3); A2883"
33D10I12"5 = 1; A2883"
17D39I33" = ( A1956+A1957 ); 
A1909:if(0) "
46D54I15"908;
A1910: ; 
"
61D29I25"911;
A1907: A1956 = A8773"
35D18I24"4; if( A1956 >= A1957 ) "
25D17I29"912;
goto A1913;
A1912: A2883"
23D10I27"2 = (0x200|0x20 | 3); A2883"
16D15I12"6 = 1; A2883"
21D19I34"4 = ( A1956-A1957 ); 
A1914:if(0) "
26D9I45"912;
A1915: goto A1916;
A1913:
A2883->A7762 ="
24D9I9"1); A2883"
15D10I12"5 = 1; A2883"
17D32I33" = ( A1957-A1956 ); 
A1917:if(0) "
39D21I70"913;
A1918: ;
A1916: ; 
A1911: ;
A1905: ;
goto A1919;
A1899: if( A8773"
27D47I24"2 == (0x200|0x20 | 1) ) "
53D27I4"2330"
35D85I101"2331;
A2330: A1956 = A8773->A7763; if( A1957 >= A1956 )
goto A2332;
goto A2333;
A2332: A2883->A7762 ="
100D8I290"3); A2883->A7765 = 1; A2883->A7763 = ( A1957-A1956 ); 
A2334:if(0) goto A2332;
A2335: goto A2336;
A2333: A2883 = NULL;
A2336: ; 
goto A2337;
A2331: if( A8773->A7765 & 1 ) goto A2338;
goto A2339;
A2338: A1956 = A8773->A7763; if( A1956 >= A1957 )
goto A2340;
goto A2341;
A2340: A2883->A7762 ="
25D8I117"; A2883->A7766 = 1; A2883->A7764 = ( A1956-A1957 ); 
A2342:if(0) goto A2340;
A2343: goto A2344;
A2341:
A2883->A7762 ="
26D5I160" A2883->A7765 = 1; A2883->A7763 = ( A1957 - A1956 ); 
A2345:if(0) goto A2341;
A2346: ;
A2344: ; 
goto A2347;
A2339: A1956 = A8773->A7764; 
A2348: A2883->A7762 ="
20D3I235"3); A2883->A7765 = 1; A2883->A7763 = ( A1956+A1957 ); 
A2349:if(0) goto A2348;
A2350: ; 
A2347: ;
A2337: ;
A1919: ;
A1897:
if( A2883 ) goto A2351;
goto A2352;
A2351:
memcpy((A49)( A4234),(A49)( A2883),(size_t)( sizeof(struct A7758) ));"
11D41I26"A4234;
goto A2353;
A2352: "
48D247I16"NULL;
A2353: ;
}"
256I62"7758 *
A7759( A7902, A1718, A7903, A1740 )
A40 A7902;
struct A"
6D12I36"1718;
struct A7758 *A7903;
A58 A1740"
17D75I42"40 A1753; A40 A7904; struct A561 *A2114, *"
80D14I87"; struct A7758 A7905; struct A7758 *A4234, *A5629; A87 A1809; A40 A8676;
if( A7902 == 0"
49D50I29"7902 = A7760( A1718->A564 ); "
55D24I27"7902 ) return A7759( A7902,"
29D13I30"8, A7903, A1740 );
return NULL"
19D5I62"2:memset((A49)( A7903),0,(size_t)( sizeof(struct A7758) ));
A1"
11D27I27"A1718->A564;
if( A1753 == ("
32D56I52"|20) || A1718->A572 & (A24) 0x10 ) goto A1713;
goto "
61D1I87";
A1713:
A7903->A7763 = A1718->A570.A6233;
A7903->A7765 = 1;
A7903->A7762 = (0x400|20);"
10D25I97"7903;
A1714:
if( A7902 != A7760(A1753) ) return NULL;
A7904 = A7902 == 0x08 ? (0x400|20) : A7902;"
31D2I32" = A1718->A562; if( !A2114 || !("
8D26I2"= "
31D3I90"->A563) ) return NULL; A4234 = A7759( A7904, A2114, A7903, A1740 ); A5629 = A7759( A7904, "
8D92I30", &A7905, A1740 
); if( !A5629"
104D1I1"5"
12D1I1"6"
7D124I59"5:
A7903->A7762 = A1753; return A4234; 
A1716:
if( A7902 =="
130D50
61D1I1"7"
11D2I2"20"
8D65I217"7: { struct A7758 A1859;
memcpy((A49)( &A1859),(A49)( A5629),(size_t)( sizeof( struct A7758 ) )); A5629->A7763 = A1859.A7764; A5629->A7765 = A1859.A7766; A5629->A7764 = A1859.A7763; A5629->A7766 = A1859.A7765; }
A1720"
71D25I6"!A4234"
36D2I2"21"
12D2I2"22"
7D4I4"21: "
9D31I23"7902 == (0x200|0x20 | 1"
43D2I2"23"
13D1I1"5"
6D57I37"23:
if( A5629->A7762 != (0x400|20) ) "
64D104I6"NULL; "
109D74I22"1753 == (0x200|0x20 | "
87D2I2"26"
12D2I2"27"
7D6I53"26:
if( A1740 & 1 ) goto A1766;
goto A1767;
A1766: A1"
12D78I1"("
84D51I41"0x20 | 1); A5629->A7763 = -A5629->A7763; "
60D2I2"68"
7D67I96"67:
A5629->A7766 = A5629->A7765;
A5629->A7765 = 0;
A5629->A7764 = A5629->A7763;
A5629->A7763 = 0"
72D38I4"68: "
43D137I4"27: "
142D20I118"25:memcpy((A49)( A7903),(A49)( A5629),(size_t)( sizeof( struct A7758 ) )); A7903->A7762 = A1753; return A7903; 
A1722:"
26D17I24"7902 == (0x200|0x20 | 1)"
28D2I2"69"
12D2I2"70"
7D32I60"69: if( !(A1740 & 1) ) return A8772( A1753, A4234, A5629 ); "
37D17I25"5629->A7762 == (0x400|20)"
28D2I2"71"
12D2I2"72"
7D62I25"71: A1809 = A5629->A7763;"
68D17I24"1753 == (0x200|0x20 | 1)"
28D2I2"73"
12D2I2"74"
7D24I27"73: A4234->A7763 += A1809; "
32D2I2"75"
7D19I25"74: A4234->A7763 -= A1809"
24D120I7"75: ; 
"
128D14I2"76"
19D33I4"72: "
38D37I103"4234->A7762 == (0x400|20) ) goto A1777;
goto A1778;
A1777: A1809 = A4234->A7763; A8676 = A5629->A7762; "
42D3I3"175"
8D245I16"(0x200|0x20 | 1)"
256D2I2"79"
12D2I2"80"
7D24I37"79: A5629->A7763 += A1809; goto A1781"
29D32I203"80: A5629->A7763 = A1809 - A5629->A7763; A5629->A7762 = A8676 == (0x200|0x20 | 1) ? (0x200|0x20 | 3) : (0x200|0x20 | 1); memcpy((A49)( A4234),(A49)( A5629),(size_t)( sizeof( struct A7758 ) )); 
A1781: ;
"
40D14I2"82"
19D4I4"78: "
11D38I4"NULL"
43D4I11"82:
A1776: "
12D19I125"4234; 
A1770:
A7903->A7762 = A1753;
switch( A7902 )
{
case (0x200|0x20 | 4):
if( !(A4234->A7765 & 1) ) goto A1784;
goto A1785"
24D125I33"84:
A4234->A7763 = A5629->A7763;
"
133D14I2"86"
19D31I32"85:
A4234->A7763 *= A5629->A7763"
36D2I67"86:
A4234->A7765 |= A5629->A7765;
goto A1783;
case (0x200|0x20 | 7)"
8D27I18"!(A4234->A7765 & 1"
39D2I2"87"
12D2I2"88"
7D29I31"87:
A4234->A7763 = A5629->A7763"
38D3I3"889"
8D24I328"88:
A4234->A7763 &= A5629->A7763;
A1889:
A4234->A7765 |= A5629->A7765;
goto A1783;
case (0x200|0x20 | 6):
A4234->A7763 |= A5629->A7763;
A4234->A7765 |= A5629->A7765;
goto A1783;
case 0x08:
A4234->A7764 = A5629->A7763;
A4234->A7766 = A5629->A7765;
goto A1783;
default:
A4234 = NULL;
goto A1783;
}
A1783:
return A4234;
}
A40
A7760"
29D12I369"53 )
A40 A1753;
{
switch( A1753 )
{
case (0x200|0x20 | 1):
case (0x200|0x20 | 3):
return (0x200|0x20 | 1);
case (0x200|0x20 | 4):
return (0x200|0x20 | 4);
case (0x200|0x20 | 7):
return (0x200|0x20 | 7);
case (0x200|0x20 | 6):
return (0x200|0x20 | 6);
case (0x200|0x20 | 5):
case (0x200|0x20 | 10):
case (0x200|0x08 | 1):
case (0x200|0x08 | 2):
return 0x08;
default:
;
}"
17D1I1088"1:
return 0;
}
A78
A1042( A2128, A6064, A2115 )
A78 A2128;
struct A561 *A6064, *A2115;
{
A78 A2753 = (A78) 0x20 | (A2128 & ~((A78) 0x2000|(A78) 0x4000) );
if( A492( A2115->A567 ) == 27 ) goto A1711;
goto A1712;
A1711:
A2753 = A2753 & ~((A78) 0x02) | (A78) 0x08;
A1712:
if( A2128 & (A78) 0x10 ) goto A1713;
goto A1714;
A1713:
A2753 = (A78) 0x08 | A2128 & (A78) 0x40000000 |
A1988( A267(A2115->A567,0,0), (A4) 1, (A4) 0 );
A1714:
return A2753;
}
A78
A5271( A2128, A2114, A2115 )
A78 A2128;
struct A561 *A2114, *A2115;
{
A78 A2753 = (A78) 0x20 | (A2128 & ~((A78) 0x2000|(A78) 0x4000) );
if( A2128 & (A78) 0x10 ) goto A1711;
goto A1712;
A1711:
{
A315 A1742 = ( A7174 = ( A2115->A567 ), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) );
A2753 = (A78) 0x08 | A2128 & (A78) 0x40000000;
if( A1742->A303 == 25 ) goto A1713;
goto A1714;
A1713:
A2753 |= A1988( A267(A1742->A306,0,0), (A4) 1, (A4) 0 );
A1714:
if( A492( A2114->A567 ) == 25 ) goto A1715;
goto A1716;
A1715:
if( A2753 & ((A78) 0x80|(A78) 0x1000) ) goto A1717;
goto A1720;
A1717: A2753 |= (A78) 0x1000000;
A1720: ;
A1716"
7I2159"A1712:
return A2753;
}
A78
A1043( A2128, A2563 )
A78 A2128;
A4 A2563;
{
A78 A2302 = A2128 & (A78) 0x80000;
A78 A2753;
if( A2128 & (A78) 0x08 ||
A2128 & (A78) 0x02 && (A2128 & (A78) 0x800000 || A2563) ) goto A1711;
goto A1712;
A1711:
A2753 = A2128 & ((((A78) 0x40|((A78) 0x80|(A78) 0x1000)|(A78) 0x100|(A78) 0x800|(A78) 0x200|(A78) 0x400) | (A78) 0x200000) | (A78) 0x40000000);
goto A1713;
A1712: if( A2128 & ((A78) 0x02 | (A78) 0x04 ) ) goto A1714;
goto A1715;
A1714:
if( A2563 ) goto A1716;
goto A1717;
A1716: A2753 = A2128 & (((A78) 0x40|((A78) 0x80|(A78) 0x1000)|(A78) 0x100|(A78) 0x800|(A78) 0x200|(A78) 0x400) | (A78) 0x200000);
goto A1720;
A1717:
A2753 = (A78) 0;
if( A2128 & (A78) 0x02 ) goto A1721;
goto A1722;
A1721: A2753 = (A78) 0x200;
A1722:
if( A2128 & (A78) 0x04 ) goto A1723;
goto A1725;
A1723: A2753 |= (A78) 0x400;
A1725: ;
A1720: ;
goto A1726;
A1715: if( A2128 & (A78) 0x01 ) goto A1727;
goto A1766;
A1727: A2753 = (A78) 0x40;
goto A1767;
A1766: A2753 = (A78) 0;
A1767:
A1726:
A1713:
return (A78) 0x02 | A2302 | A2753;
}
A54
A5433( A1741, A2903 )
A5794 A1741;
A42 A2903;
{
if( !A5434 ) goto A1711;
goto A1712;
A1711: A5434 = A999( 4, 0 );
A1712:
if( A1010( A5434, A1741 ) ) return A1011;
if( A2903 == 1 ) return 0;
A997( A5434, A1741 );
return A1011;
}
A9036
A9039( A1741 )
A5794 A1741;
{
A7616 A7218;
A7218 = A5433( A1741, 2 );
return ((A9036) A996(A5434,(A54)( A7218 )));
}
A9150
A9178(A6 A1730)
{
A9150 A1875;
A9150 A1868 = (A9150) A1730;
A1875 = A1868 / 37;
A1875 |= ((A1868 & 0x5C) << 9);
return A1875;
}
A48
A7906( A2070 )
A87 A2070;
{
A48 A1730 = A6237( A2070 );
if( !A7895 ) goto A1711;
goto A1712;
A1711:
A7895 = A999( 4, 0 );
A1712:
if( A1010( A7895, A1730 ) ) goto A1713;
goto A1714;
A1713:
return (A48) A996( A7895, A1011 );
goto A1715;
A1714:
return A997( A7895, A1730 );
A1715: ;
}
Void
A7761( A1731, A2070 )
struct A1531 *A1731;
A87 A2070;
{
A49 A2829 = (A49) A7906( A2070 );
if( !(A1731->A7836) ) goto A1711;
goto A1712;
A1711:
A1731->A7836 = A999( 4, 0 );
A1712:
if( A1007( A1731->A7836, A2829 ) ) goto A1713;
goto A1714;
A1713:
A884( 142, A6237(A2070) );
goto A1715;
A1714:
A1012 = A2829;
A1005( A1731->A7836 );
A1715: ;
}
"
Fa5.c
209D4I7"7 A9235"
18D2I1"9"
12I16"A6 A10;
typedef "
291D20
27D4I8"32 A9069"
14I19"A9069 A24;
typedef "
10D4I2"25"
14D9I13"unsigned A890"
21D6I10"9069 A9150"
17D6I10"9069 A9070"
17D8I8"9070 A27"
18D12I9"A9070 A28"
22I21"A9070 A5793;
typedef "
10D4I2"29"
14D17
26D8I5"A6228"
19D6I8"9070 A30"
25D3I8"long A31"
13I17"A17 A32;
typedef "
11D1I1"3"
11D7I12"unsigned A34"
19D5I5"4 A35"
17D5I5"5 A36"
21D1I1"7"
17D1I1"8"
16D2I2"39"
18D1I1"0"
17D1I1"1"
17D1I1"2"
12D6I6"34 A43"
22D1I1"4"
17D1I1"5"
11D7I7"A42 A46"
17I17"int A47;
typedef "
342D2I4"9236"
17D4I2"63"
19D1I3"577"
18D1I1"4"
16D4I2"65"
20D2I2"19"
18D4I4"8258"
14I19"A54 A7616;
typedef "
138D6I3"A16"
60D13I3"A72"
122D6I5"A9069"
20D6I5"A9069"
1373I69"struct A9304
{
A17 A9305;
A5794 A9306;
};
extern struct A9304 A9307;
"
6D4I4"9308"
14D4I4"9309"
17D1I1"5"
11D4I4"5566"
14D4I4"5567"
14D3I17"7618();
Void A761"
8D13
19D3I17"5569();
Void A915"
8D9I10"Void A9152"
14D17I2"74"
22D1I15"0();
Void A7621"
10I41"6226();
A5794 A6227();
A81 A7622();
A58 A"
460D2I4"9070"
28D2I4"9070"
151I19"struct A114 A9153;
"
1389D2I2"92"
16D6I12"5794 A7637()"
15I16"A4 A202;
extern "
3337D2I4"9070"
159I11"A58 A9238; "
88D2I4"9070"
39D2I4"9070"
367I11"A17 A9071;
"
535I13"A9236 A9239;
"
1098D2I4"9070"
380D7I8"17 A9154"
24D1I1"1"
12D6I7"62 A442"
16I17"A4 A443 ;
extern "
150D3I4"9072"
14D10I9"Void A451"
22D9I9"5794 A452"
21D9I9"9036 A453"
29D1I1"4"
13D12
20D1I1"5"
12D9I22"A315 A456 ;
A5794 A457"
28D1I1"8"
18D4I3"459"
21D3I4"5268"
14D16
24D1I1"0"
12I16"A4 A461;
extern "
8D1I1"2"
12D8I11"Void A463()"
22D4I3"464"
13I18"A58 A8823;
extern "
1037D7I10"Void A9155"
18D9I7"A4 A504"
20I20"Void A505();
extern "
1042D2I4"9070"
1940D8I19"struct A640 * A9310"
24D4I3"663"
15D10I9"A48 A7505"
29D2I2"37"
19D3I4"7176"
14D7I9"Void A664"
22D4I3"665"
16D8I7"4 A4442"
19D6I6"A17 A5"
27D3I2"66"
21D2I3"031"
21D1I1"7"
20D1I1"8"
12I20"Void A669();
extern "
278D3I4"4476"
14D10I17"struct A640 *A675"
27D4I4"7719"
21D4I4"8914"
15D8I12"Void A7720()"
18D7I7"17 A933"
18D8I7"7 A5254"
18D2I2"81"
7D1I1"0"
11D2I2"17"
7D1I1"1"
11D1I2"35"
6D1I1"2"
11D1I2"92"
6D1I1"3"
11D2I1"7"
7D1I1"4"
11D8I7"4 A2145"
18D1I2"68"
6D1I1"6"
13D14I6"*A2147"
24D8I7"4 A2148"
18D7I16"2 A2149[M_TOKEN]"
17D2I2"87"
7D1I1"0"
11D2I1"4"
7D1I1"1"
15D4I4"2152"
14D2I2"36"
7D1I1"3"
11D27I7"35 A826"
38D1I2"17"
6D3I1"4"
13D10I28"7
A2155,
A2156,
A2157,
A6214"
19D4I2"A9"
9D1I1"8"
12D10I9"A17 A8825"
27D3I3"215"
15D3I4"Void"
8D1I1"0"
18D4I4"8209"
23D1I1"1"
12D3I4"Void"
8D1I1"2"
12D10I9"A35 A2163"
29D1I1"4"
12D5I4"Void"
10D1I1"0"
12D9I8"A35 A216"
22D7I10"9036 A8211"
24D4I4"5255"
15D4I2"A4"
9D11I16"6();
extern Void"
16I37"7();
extern Void A2168();
struct A216"
465I42"struct A9073
{
A48 A9074;
A9069 A9075;
};
"
422D6I7"8 A9076"
17D9I8"A42 A982"
20D8I9"long A983"
24D4I3"984"
16D8I8"87 A6039"
20D8I8"61 A7724"
19D9I9"A92 A7260"
20D8I9"long A985"
24D4I3"986"
16D9I8"34 A5670"
20I21"A5794 A987();
extern "
1045I7"9129,
A"
44D4I4"9156"
11I42"9157,
A9158,
A9159,
A9160,
A9161,
A8639,
A"
21D10I2"91"
15D2I2"91"
7I29"9164,
A6176, 
A7062,
A7063,
A"
91I21"9240,
A9241,
A9130,
A"
21I28"9165,
A9166,
A9167,
A9168,
A"
28I14"9292,
A9169,
A"
92I42"9242,
A9243,
A9131,
A9132,
A9133,
A9134,
A"
71I7"9170,
A"
307D4I4"9171"
21I42"9244();
extern Void A8266();
extern Void A"
8I80"extern Void A9172();
extern A4 A9173();
extern A4 A9174();
extern Void A9175();
"
746D9I7"4 A9176"
21D7I9"5794 A868"
19D6I6"7 A598"
25D1I1"0"
19D1I1"1"
13D10I7"61 A872"
22D7I10"5794 A6037"
19D10I7"61 A873"
22D7I10"5794 A8589"
20D5I6"8 A874"
16D9I7"A4 A875"
28D1I1"6"
20D1I1"7"
20D1I1"8"
19D2I2"79"
19D4I3"880"
21D4I4"6172"
21D3I4"9293"
20D4I4"9177"
21D4I4"8787"
23D1I1"1"
20D1I2"29"
18D4I4"7262"
23D1I1"2"
20D1I1"3"
20D2I2"48"
21D1I1"4"
20D1I1"5"
18D3I4"5667"
22D1I1"6"
19D2I2"87"
20D2I2"88"
20D2I2"89"
19D4I3"890"
21D4I3"891"
21D4I3"892"
21D4I4"7745"
24D1I1"6"
21D1I1"7"
20I1"4"
18D3I4"7748"
20D4I4"7749"
21D4I3"893"
23D1I1"4"
18D4I4"1857"
22D3I3"958"
22D1I1"5"
19D3I3"061"
20D3I4"5821"
20D4I3"896"
21D3I4"7507"
20D4I3"897"
21D4I4"5981"
23D1I1"8"
19D3I3"750"
20D3I4"8212"
20D3I3"899"
20D3I4"7177"
22D1I1"0"
18D4I3"901"
23D1I1"2"
20D1I1"3"
18D3I4"8944"
22D1I1"4"
18D4I3"905"
21D3I3"907"
21D4I4"9078"
23D1I1"7"
18D3I4"5077"
20D3I4"8267"
20D3I4"8830"
14D7I9"Void A908"
25D2I2"09"
13D9I9"Void A910"
28D1I1"1"
12D9I7"A4 A912"
20D16
24D1I1"3"
14D8I7"4 A5431"
19D11I9"Void A914"
22D10I9"Void A915"
22D11I6"7 A916"
27D2I2"17"
13D9I10"A5794 A918"
27D3I4"1739"
15D6I9"5794 A919"
24D4I3"920"
15D9I9"Void A921"
26D4I3"922"
15D20I14"A5794 A923();
"
31D4I3"924"
16D7I10"5794 A7263"
19D8I8"61 A5668"
19D7I12"Void A5669()"
16D18
26D13I12"7734 A7751; "
21D7I7"4 A7752"
18D18I10"A4 A5914()"
28D6I10"861 A926()"
16D8I6"4 A927"
18D6I8"4 A928()"
15D9I19"struct A849 *A929()"
19D6I9"61 A930()"
16D8I12"9236 A9245()"
18D6I12"9236 A9246()"
15D9I12"Void A9247()"
18D7I18"struct A144 *A5050"
17D8I6"7 A931"
18D6I8"61 *A932"
16D8I6"7 A933"
21D7I7"*A934;
"
14D18I7"A7 A935"
28D7I8"61 *A936"
16D18I7"A7 A937"
27D18I9"A61 *A938"
27D18I7"A7 A939"
28D9I8"61 *A940"
19D9I6"7 A941"
19D9I8"61 *A942"
19D12I10"61 A6038; "
19D11I18"struct A144 *A1696"
23D8I5" A943"
18D10I7"7 A9294"
19D11I18"struct A144 *A7178"
20D17
26D7I8"44 *A717"
17D7I18"struct A144 *A5432"
17D6I9"5794 A944"
15D17I10"A5794 A945"
26D20I12"A5794 A946;
"
27D4I5"A5794"
9D3I1"4"
19D6I4"7180"
15D12I11"A5794 A7227"
21D12I11"A5794 A7181"
22D7I10"5794 A5510"
17D8I7"68 A948"
17D18
26D10I9"114 *A949"
20D7I6"7 A950"
17D7I6"4 A951"
16D10I17"struct A114 *A952"
19D13I20"struct A144 *A7265; "
27D3I3"266"
15D7I10"5794 A1689"
24D4I4"7753"
15D18I10"Void A7754"
30D10I7"6 A1022"
20D10I8"81 A5511"
19D12I9"A81 A8770"
21D12I18"struct A561 *A1023"
21D12I8"A4 A1024"
22D10I7"7 A1025"
19D18I8"A4 A1026"
29D18I9"A49 A1027"
29D10I9"Void A775"
22D10I8"A4 A1028"
27D15I8"1029();
"
21D4I31"9079();
A48 A9080();
Void A9081"
15D21
38D1I1"0"
13D7I8"17 A1031"
18D18I9"A79 A1032"
35D4I4"5671"
15D8I10"Void A5672"
19D9I10"Void A8401"
21D8I8"17 A5512"
19D10I18"struct A561 *A1033"
21D9I10"Void A9135"
20D9I18"struct A561 *A1034"
21D7I10"5794 A1035"
18D47I10"Void A2317"
58D9I10"Void A5673"
20D9I10"Void A1036"
20D9I10"Void A1037"
20D11I18"struct A561 *A1038"
22D8I6"A4 A56"
21D9I18"struct A561 *A1039"
20D11I10"Void A7182"
22D18I10"A4 A7183()"
27D10I9"A58 A8268"
22D7I28"78 A1040();
extern Void A775"
12D6I49"extern A81 A1041();
extern A81 A7508();
extern A4"
11D3I49"7();
extern A5794 A8590();
struct A7758 *A7759();"
12D51I3"0()"
60D18I11"A78 A1042()"
28D8I10"78 A5271()"
18D8I10"78 A1043()"
18D8I12"5972 A1044()"
17D9I12"Void A2274()"
18D17I42"A54 A5433();
extern A9036 A9039();
extern "
26D106I9"44 *A5434"
116D7I12"9150 A9178()"
16D13I32"Void A7761();
extern A48 A7906()"
23D31I63"7758
{
A40 A7762;
A87 A7763, A7764;
A17 A7765, A7766;
A67 A7767"
43D21
29D11I10"7758 A7768"
20D79I9"A87 A7769"
88D12I9"A87 A7770"
21D12I9"A88 A7771"
21D12I9"A10 A7772"
21D43I17"const A88 A7773;
"
52D19I43"045
{
A18 A1046;
A72 A1047;
A7470 A1048;
A3"
24D2I58"49;
};
struct A1050
{
A18 A1051;
A17 A1052;
A5794 A1053;
}"
12D7I7"7 A3140"
17D34I14"81 A3143[20];
"
43D9I33"054
{
A54 A1055;
A55 A1056[25];
}"
19D8I9"55 *A3164"
19D11I19"struct A1054 *A7509"
20D78
86D209I12"144 *A7774;
"
217D10I51"7500
{
struct A7500 *A7775; A54 A7510; A42 A7511; }"
19D9I12"Void A1057()"
18D8I12"Void A1058()"
17D9I10"Void A1059"
20D8I10"Void A1060"
19D10I11"A5794 A1061"
21D22I18"struct A118 *A1062"
33D13I8" A1063;
"
20D13I8"A4 A7267"
26D4I4"7776"
14D10I8"63 A7777"
19D21
29D3I3"114"
8D2I2"64"
11I40"A81 A7512();
extern A49 A1073();
extern "
8D2I66"74();
extern A72 A1075[];
extern A9036 A1076();
extern A9036 A7778"
14D94I118"3097
{
A70 A3098; A72 A3099; A7468 A3100; A7468 A3101; A72 A3102; A72 A3103; A72 A3104; A7 A3105; A4 A3106; A7 A5282; "
100D5I85"283; A32 A5284; A74 A5966; A17 A6270; };
extern A81 A3107;
extern A315 A3108;
extern "
13D55I62"3097 A3109;
extern A58 A3110;
extern A4 A6067;
extern A72 A311"
60D10I14"extern A6 A311"
15D45
52D11I14"Void A1077();
"
19D7I21"48 strcat(), strcpy()"
17D9I14"48 strncpy(); "
16D11I13"int strncmp()"
24D4I4"1078"
15D8I7"2 A7268"
27D2I2"79"
13D12I18"struct A553 *A1080"
21I17"A7 A9295;
extern "
6D67I3"108"
72I66"struct A553
{
struct A553 *A1082;
A7 A1083;
struct A114 A1084;
};
"
15D81I1"8"
86D75I59"struct A5513
{
A81 A5514;
struct A147 *A5515;
};
A5972 A777"
80D39I10"A5972 A778"
44D17I10"A5972 A778"
22D16I10"A5972 A778"
21D16I10"A5972 A778"
21D16I10"A5972 A778"
21I15"A5972 A7785();
"
7D14I11"A74 A6242; "
21D12I8"A7 A1086"
21D12I8"A7 A7184"
21D12I11"A5794 A5248"
25D6I4"7185"
15D10I10"A95 *A1087"
27D4I4"1088"
21D4I4"1089"
21D4I4"7186"
21D3I3"109"
21D4I4"7187"
15D10I11"A5794 A1091"
21D9I10"Void A1092"
27D3I3"093"
20D4I4"8269"
20D3I3"094"
14D10I8"A4 A1095"
21D10I8"A4 A1096"
28D3I3"097"
20D4I4"1098"
16D10I7"4 A1099"
21D10I11"A94 * A5272"
21D9I10"A94 * A110"
21D10I11"A94 * A1101"
29D2I2"02"
19D4I4"1103"
15D11I10"Void A1104"
30D2I2"05"
21D2I2"06"
19D4I4"5675"
21D4I4"6243"
15D10I8"A4 A5518"
27D4I4"7786"
21D4I4"5516"
21D4I4"5517"
21D4I4"5519"
22D3I3"520"
14D18I12"Void A5521()"
27D17
23D4I4"5522"
15D10I9"A23 A7787"
21D8I10"Void A1107"
19D10I10"Void A1108"
22D10I7"4 A1109"
21D11I10"Void A1110"
22D11I10"Void A1111"
22D11I10"Void A1112"
22I21"Void A2942();
extern "
7D4I4"1113"
15D55I12"Void A2949()"
64D13I12"Void A7070()"
22D9I12"Void A1114()"
18D10I12"Void A1115()"
19D9I12"Void A7269()"
19D8I12"94 * A1116()"
17D9I12"Void A1117()"
18D18I12"Void A1118()"
27D18I12"Void A1119()"
27D26I12"Void A7788()"
35D8I12"Void A5676()"
17D18
26D2I2"20"
21D2I2"21"
21D2I2"22"
13D9I10"Void A8270"
26D4I4"5249"
15D10I18"struct A144 *A5523"
19I17"A7 A5822;
extern "
6D4I4"7789"
21D4I4"7790"
19D4I4"7791"
15D10I10"A94 *A7792"
21D10I11"A5794 A7793"
22D7I10"5794 A7794"
19D7I10"5794 A7795"
18D10I11"A5794 A7796"
22D8I10"5794 A7797"
20D2I4"5794"
7D3I45"8();
struct A5304 { A77 A3049; A5794 A1148; }"
12D12I13"A2 A1123[100]"
21D12I9"A17 A1124"
21D12I10"A13 *A1125"
21D12I9"A81 A1126"
23D9I7"8 A1127"
19D1I1"5"
6D4I2"28"
13D11I18"struct A144 *A1129"
20D11I18"struct A144 *A1130"
20D11I26"const struct A5304 A3050[]"
21D10I7"4 A1131"
20D17I8"38 A1132"
26D45I9"Void A113"
65D1I1"3"
21D1I1"3"
13D9I8"A17 A113"
29D1I1"3"
13D10I8"A4 A2979"
29D1I1"3"
19D3I3"917"
23D2I2"39"
13I19"A4 A1140();
extern "
8D1I1"4"
6D124I231"extern Void A5529();
extern A4 A5530();
extern A7 A5532();
extern Void A5533();
extern A66 A5534();
extern A66 A7799();
extern Void A5531();
extern Void A1142();
extern Void A1143();
extern Void A1144();
extern A50 A1145();
extern "
131D339I15"46();
extern A7"
344D13I118"47();
extern A48 A1148();
extern A48 A1149();
extern A77 A1150();
extern A58 *A5067, *A5068;
extern A17 *A8945, *A8946"
22D4I6"8271()"
15D5I193"53();
extern Void A1154();
extern Void A1155();
extern Void A1156();
extern Void A1157();
extern Void A5823();
extern Void A1158();
extern Void A1159();
extern Void A1160();
extern Void A1161()"
15D4I4"8402"
15D19
25D4I75"8403; A54 A8404; A13 *A8405; A7468 A8406; A72 A8407; A58 *A8408;
A58 *A8409"
19D52I1"6"
57D1I1"7"
6D56I4"63;
"
61D10I229"
A7132,
A7133,
A1164,
A1165,
A1166,
A1167,
A1168,
A1169,
A1170,
A1171,
A1172,
A1173;
A13 A1174[ (2000 / CHARLEN) ];
A18 A5435;
A17 A6040;
A13 A7800[ (2000 / CHARLEN) ];
A61 A6041;
A17 A6042;
} ;
extern A13 A9180[(2000 / CHARLEN)]"
20D4I4"9248"
14D88I6"9249; "
95D17I17"9296; A17 A9250; "
24D6I6"9251; "
13D6I19"9297; FILE *A9252; "
16D9I18"struct A9248 A9253"
18D127I14"Void A9254();
"
135D27I104"391
{
struct A633 *A1175;
struct A144 *A1176;
struct A144 *A1177;
struct A144 *A1178;
};
struct A1179
{
"
32D262I91"180;
A53 A1181;
A17 A1182;
A53 A1183;
A5794 A1184;
A5794 A1185;
};
struct A1186
{
struct A8"
267D31I5"187;
"
40D27
33D12I8"188;
};
"
21D18I6"189
{
"
26D71I105"640 *A1190;
A5794 A1191;
};
struct A1192
{
A17 A1193;
A9 A1194;
A70 A1195;
};
struct A1196 { A2 A1197[3];"
77I833" *A1198; };
struct A1199
{
A5794 A1200;
A35 A1201;
A42 A1202;
};
Void A1203();
Void A1204();
Void A1205();
struct A5677
{
A5794 A5678;
A42 A5679;
A5794 A5680;
A5794 A5681;
};
extern A17 A6244;
extern long A7418;
extern A49 *A1206;
extern A49 *A1207;
extern A2 A1208[ARG_LEN];
extern A42 A8197; extern A2 A3496[ARG_LEN];
extern struct A1196 A1209[];
extern const A6 A1210;
extern A7 A5406;
extern A7 A5407;
extern A7 A6210;
extern A42 A1211;
extern A4 A1212;
extern A72 A1213;
extern A72 A1214;
extern A18 A1215;
extern A18 A1216;
extern A4 A7228;
extern A61 A1217;
extern A61 A1218;
extern A67 A1219;
extern A13 *A6043;
extern A13 *A1220;
extern A13 *A1221;
extern struct A1162 A1222;
extern struct A144 *A1223;
extern struct A144 *A1224;
extern struct A144 *A1225;
extern A48 A1226;
extern A7 A1227;
extern A9070 A1228;
extern UFLAG"
1095I7"9298,
A"
2534D19
33D4I4"9255"
14D7I9"2 A7190[]"
16D8I18"struct A144 *A1398"
21D4I4"1399"
14D8I7"4 A7807"
18D7I6"7 A621"
21D7I6"9181; "
15I1"1"
6D1I1"0"
11D1I2"68"
6D1I1"1"
11D1I1"4"
6D1I2"2 "
11D1I1"7"
6D1I1"3"
10D4I2"A7"
9D3I1"4"
12D4I2"A7"
9D3I1"5"
12D4I2"A4"
9D3I1"6"
12D9I10"Void A1407"
20D9I10"Void A1408"
26D4I4"1409"
17D6I7"8 A1410"
17D10I9"A58 A1411"
21D8I10"Void A8257"
19D10I8"A4 A8411"
27D4I4"5063"
15D4I2"A6"
9D1I1"2"
12D2I4"Void"
7D1I1"3"
18D4I4"1414"
21D4I4"1415"
15D10I8"A4 A1416"
21D19I10"Void A5687"
36D4I4"5688"
15D10I10"Void A5689"
21D10I19"struct A5677 *A5690"
30D1I1"7"
12D10I10"A13 *A5396"
21D10I9"Void A141"
28D4I4"1419"
21D4I4"6052"
15D10I11"A5794 A7808"
30D1I1"4"
18D4I4"5545"
21D4I4"5546"
15D8I10"Void A5547"
19D2I4"Void"
7D1I1"0"
12D2I4"Void"
7D25I1"1"
36D9I7"A4 A624"
21D9I9"A48 A9182"
20D9I8"A4 A1422"
20D4I2"A4"
9D12I5"3();
"
26D5I6" A1424"
16D10I12"Void A3500()"
19D8I10"Void A1425"
19D8I9"int A3493"
19D10I9"int A3494"
27D4I4"1426"
15D10I19"struct A1189 *A1427"
21D12I10"A13 *A8273"
22D7I6"4 A599"
19D9I7"A4 A599"
21D8I10"Void A9311"
27D2I2"28"
13D12I10"Void A7191"
31D2I2"29"
13D8I10"Void A6080"
25D4I4"9183"
15D10I9"A54 A1430"
21D1I1"V"
6D4I4"1431"
15D10I8"A4 A7475"
30D1I1"2"
12D9I12"UFLAG *A1433"
29D1I1"4"
12D10I8"A4 A1435"
29D2I2"36"
13D1I1"v"
6D4I4"6246"
15D1I1"v"
6D4I4"7809"
21D4I4"1437"
23D2I2"38"
14D10I10"34 A5691()"
19D20
28D2I2"39"
19D4I4"1440"
15D10I12"Void A1441()"
19D17
26D1I1"2"
21D1I1"3"
12D11I10"Void A5773"
30D2I2"44"
13D12I11"A5794 A1445"
21I20"A5794 A1446;
extern "
6D4I4"1447"
21D4I4"3532"
15D12I10"A2 A3526[]"
21I17"A4 A3527;
extern "
6D2I2"14"
21D4I4"1449"
15D10I11"A5794 A1450"
30D1I1"1"
18D4I4"1452"
15D10I8"A4 A9184"
27D4I4"5274"
21D73I6"1453()"
82D19I12"Void A5651()"
28D20I12"Void A5548()"
29D20
26D4I130"3443();
extern Void A6072();
extern Void A1454();
extern Void A3363();
extern Void A1455();
extern Void A1456();
extern Void A5107"
17D89I65"065
{
A67 A1066;
A5794 A1067;
A5794 *A1068;
A17 A1069;
};
extern "
97D44I20"1065 *A1070;
extern "
52D40I53"1065 A1071[];
extern A67 A1072[];
extern Void A6209()"
53D12I85"
{
A79 A547;
A79 A548;
A79 A549;
A79 A6232;
A79 A5661;
A87 A6233;
A87 A5662;
A23 A552"
23D16I24"53 *A554, *A555, *A6234,"
21D1I12"63, *A557;
}"
11D29I14"93
{
A17 A8274"
34D35I21"98 A8275;
A8198 A8276"
50D44I10"8277[1];
}"
54D41I6"561
{
"
56D4I165"62;
struct A561 *A563;
A40 A564;
A40 A565;
A81 A566;
A58 A567;
A42 A568;
A68 A569;
struct A147 A570;
A17 A571;
A24 A572;
A61 A573;
A96 *A574;
struct A1537 * A7443;
}"
13D11I8"A81 A575"
20D9I17"struct A561 *A576"
28D1I1"7"
18D2I1"5"
22D2I2"79"
19D3I4"8278"
22D1I1"0"
20D1I1"1"
19D3I2"82"
22D9I1"3"
20D7I10"Void A5664"
18D19
27I65"4(), A585();
extern A4 A586();
extern A4 A5665();
extern Void A58"
1854I50"9136
{
struct A9136 *A9137; A17 A9138; };
struct A"
109D9I19"struct A9136 *A9139"
18D18
26D9I10"9136 A9140"
19D9I8"58 A7273"
18D4I3"A17"
9D3I1"4"
12D11I17"struct A588 A1719"
20D4I2"A2"
9D3I3"6[]"
20D2I2"77"
13D10I9"A89 A1978"
29D2I2"79"
19D4I4"1980"
21D4I4"7274"
24D1I1"1"
13D8I7"4 A9185"
19D18I8"A4 A9186"
35D4I4"5897"
24D1I1"2"
12D3I4"Void"
8D1I1"3"
12D10I9"A72 A1984"
21D10I18"struct A561 *A1985"
27D3I3"914"
23D2I2"86"
21D2I2"87"
13D27
33D26I4"9142"
37D10I9"A78 A1988"
27D4I4"1990"
21D4I4"1989"
21D4I4"1991"
15D8I10"Void A1992"
25D4I4"1993"
15I27"struct A144 *A7824; extern "
6D4I26"5553();
struct A147 *A7825"
23D2I2"26"
19D4I4"7827"
21D64I6"7828()"
73D8I10"Void A7829"
20D7I7"4 A7830"
18D9I12"Void A8412()"
18D9I12"Void A7831()"
18D9I12"Void A7832()"
18D19I12"Void A8413()"
28I14"Void A8414();
"
8D20I7"1457
{
"
26D12I4"58;
"
18D3I25"59;
A4 A1460;
A9 A1461;
}"
12D19I10"A9 A1461()"
28D18I10"A9 A1462()"
28D1I1"9"
6D1I1"3"
11D19I8"A4 A1464"
30D9I7"4 A1465"
19D20
28D11I10"83 **A5078"
21D9I18"struct A83 **A5079"
25D2I2"66"
13D9I7"4 A1467"
19D3I11"struct A144"
8D2I2"68"
12D11I18"struct A144 *A7476"
21D9I7"4 A1469"
19D10I19"struct A640 **A3651"
20D9I18"struct A640 **A365"
21D8I9"17 *A1470"
19D8I9"68 *A1471"
26D13I14"640 **A1472 ;
"
22D7I7"3 A1473"
18D11I7"4 A1474"
22D7I9"13 *A1475"
18D7I9"13 *A1476"
18D7I9"13 *A1477"
18D4I2"53"
9D2I2"78"
13D2I2"68"
7D2I2"79"
12D9I3"A17"
15D1I1"0"
12D1I2"57"
6D1I1"1"
11I19"A57 A3660 ;
extern "
17D3I4"5 ; "
11D10I8"57 A1482"
22D6I10"036 *A1483"
17D10I7"4 A1484"
20D18I8"A4 A8214"
29D8I7"4 A1485"
19D7I11"9036 *A1486"
18D7I9"81 *A1487"
17D8I16"const A81 *A1488"
19D7I7"6 A1489"
25D11I10"144 *A7276"
21D4I4"9036"
9D1I1"0"
11D17I8"A9 A1491"
27I21"A9036 A1492 ;
extern "
8D9I10"640 *A1493"
19D17I9"A63 A1494"
27D17I8"A4 A1495"
28D8I7"4 A1496"
22D4I4"5825"
18D4I5"1497 "
21D8I9"640 *A149"
19D12I12"A5794 A1499 "
21D12I18"struct A83 *A1500 "
21D10I18"struct A83 *A1501 "
19D13I18"struct A83 *A1502 "
22D10I18"struct A83 *A5080 "
20D9I9"53 A1503 "
18D12I9"A4 A1504 "
21D12I8"A4 A6247"
21I27"struct A83 *A6248 ;
extern "
6D4I4"9040"
23D2I2"05"
14D7I7"4 A1506"
18D10I11"A5794 A1507"
21D9I10"Void A7451"
20D10I8"A4 A7833"
22D8I7"4 A6249"
25D4I4"6250"
23D2I2"08"
13D8I10"Void A1509"
28D1I1"0"
12D4I2"A6"
9D1I1"1"
21D1I1"2"
12D10I9"A68 A1513"
21D7I9"Void A151"
20I203"81 A5692();
extern Void A8215();
extern Void A1515();
extern A4 A1516();
extern Void A1517();
extern Void A1518();
extern Void A1519();
extern Void A1520();
extern A4 A3738();
extern A4 A7834();
extern A"
561D1I1" "
11D1I1" "
11D1I1" "
10D1I1" "
10D1I1" "
10D1I1" "
848D4I4"9082"
15D19I10"Void A9083"
30D19I10"Void A9084"
30I21"Void A3863();
extern "
17D2I2"89"
13D10I19"struct A1537 *A1590"
21D10I19"struct A1537 *A1591"
27D2I2"71"
21D4I4"1592"
21D4I4"1593"
15D9I10"Void A7841"
29D1I1"2"
12D4I3"A74"
9D1I1"7"
18D4I4"7843"
21D4I4"8218"
15D9I10"Void A8219"
29D1I1"5"
13I1"7"
6D1I1"6"
12D3I4"Void"
8D1I1"7"
12D10I8"A4 A7848"
21D10I9"A74 A7849"
21D1I1"V"
8D24I4"94()"
33D9I4"void"
14D1I3"1()"
10D4I4"void"
9D9I17"2();
typedef A22*"
14I57"3;
extern const A51 A1524;
extern long A1525;
struct A152"
1445D10I8"A4 A9085"
27D4I4"3763"
15D9I10"Void A8835"
21D2I2"35"
7D1I3"4()"
10D11I3"A58"
16D1I1"5"
10D2I11"struct A147"
7D3I1"6"
12I19"A4 A3767();
extern "
2788D2I4"9070"
433D8I10"Void A9086"
19D9I9"A74 A9087"
28D1I1"6"
12D8I9"Void A737"
19D9I8"A4 A4551"
20D9I9"Void A738"
25D3I4"4724"
14D10I8"A58 A741"
29D1I2"77"
20D1I1"3"
18D4I3"744"
15I21"Void A8202();
extern "
1326D1I1" "
15D1I1" "
11D1I1" "
2390D2I4"9070"
215D2I4"9070"
12D1I2"72"
52D4I4"9088"
1870D1I8"
(A10) ("
21I1")"
82I6"(A72) "
244I6"(A72) "
21I6"(A72) "
21I6"(A72) "
23I6"(A72) "
23I6"(A72) "
23I6"(A72) "
23I6"(A72) "
23I6"(A72) "
41I6"(A72) "
24I6"(A72) "
24I6"(A72) "
23I6"(A72) "
32I6"(A72) "
24I6"(A72) "
23I6"(A72) "
23I6"(A72) "
23I6"(A72) "
23I6"(A72) "
23I6"(A72) "
23I6"(A72) "
23I6"(A72) "
24I6"(A72) "
23I6"(A72) "
23I6"(A72) "
24I6"(A72) "
23I6"(A72) "
23I6"(A72) "
33I6"(A72) "
24I6"(A72) "
23I6"(A72) "
23I6"(A72) "
24I6"(A72) "
27I6"(A72) "
23I6"(A72) "
24I6"(A72) "
24I6"(A72) "
23I6"(A72) "
23I6"(A72) "
24I6"(A72) "
24I6"(A72) "
24I6"(A72) "
24I6"(A72) "
23I6"(A72) "
24I6"(A72) "
24I6"(A72) "
24I6"(A72) "
24I6"(A72) "
24I6"(A72) "
24D15I6"(A72) "
22I45" struct A9136 ),
};
A49 A2880[ ((A72) sizeof("
7I6"(A72) "
27I6"(A72) "
14I6"(A72) "
32I1"2"
10I6"(A72) "
14I6"(A72) "
92D3I19"Void A9187();
A9070"
28298D8I8"48
A9091"
13D7I21"09, A2026, A2006 )
A7"
12D2I36"09;
struct A9073 *A2026;
A7470 A2006"
7D1I37"78 A1948;
static A2 A2080[ 100 ];
A48"
6D70I13"7;
A2080[0] ="
75D27I22"1948 = (A78) 1;
A1713:"
35D87I35"09 && A1948) goto A1711;
goto A1712"
92D23I22"14: A1948 <<= 1;
goto "
28I7";
A1711"
8D12I12"709 & A1948 "
23D1I1"5"
12D1I1"6"
7D30I40"5:
A1737 = A9076( A1948, A2026, A2006 );"
36D27I10"2080[0]==0"
39D1I1"7"
11D2I2"20"
8D31I23"7: strcpy( A2080, A1737"
43D2I2"21"
7D45I62"20:
sg_sfcat( A2080, "|", 100 );
sg_sfcat( A2080, A1737, 100 )"
50D18I28"21:
A1709 &= ~A1948;
A1716: "
28D2I2"14"
7D14I75"12:
return A2080;
}
A10
A2814( A1737 )
A48 A1737;
{
A6 A1732;
A48 A2815;
A2"
20D53I4";
A6"
58D34I5"6;
A6"
39D23I4"7=0,"
28D12I27"8=0;
A4 A2819 = (A4) 0;
A2 "
18I116"M_TOKEN];
A6 A2820;
if( A1737[0] == '0' &&
(A1737[1] == 'x' || A1737[1] == 'X') )
return A7305(A1737+2);
A2816 = 0;
"
5D3I11" = 0;
A2815"
8D15I3"737"
20D3I23"13:
if( A1833 = *A2815)"
13I12"1;
goto A171"
6D13I11"14: A2815++"
24D1I1"3"
7D23I2"1:"
29D13I27"1833 == 'e' || A1833 == 'E'"
24D2I2"15"
12D2I2"16"
7D2I2"15"
7D4I15"16 = (A6) A985("
9D9I7"5 + 1 )"
19D2I2"12"
7D80I3"16:"
86D8I11"1833 == '.'"
19D2I2"17"
12D2I2"20"
7D2I2"17"
7D10I11"19 = (A4) 1"
20D2I2"21"
7D11I73"20: if( '0' <= A1833 && A1833 <= '9' ) goto A1722;
goto A1723;
A1722:
if("
16D9I26"9 ) goto A1725;
goto A1726"
14D117I3"25:"
123D2I22"++;
goto A1727;
A1726:"
7D12I3"7++"
17D23I28"27:
A2812[A1732++] = A1833;
"
31D4I11"66;
A1723: "
12D2I2"12"
7D11I13"66: ;
A1721: "
21D2I2"14"
7D3I24"12:
A2812[A1732] = '\0';"
11D35I4"18 <"
40D8I5"16 ) "
16D2I14"67;
goto A1768"
7D20I27"67:
A2820 = A2817 + A2816;
"
28D14I2"69"
19D3I8"68:
{
A6"
8D37I5"1;
A6"
42D1I40"2;
A48 A2823;
A87 A2824;
A6 A1804;
A2821"
8D1I1"7"
8D20I2"6;"
29D7I132"1 < 0 ) goto A1770;
goto A1771;
A1770: A2823 = A2812;
goto A1772;
A1771: A2823 = A2812 + A2821;
A1772:
if( ((A72) strlen(A2823)) > 8"
30I46"A2824 = (A87) A985( A2823 );
if( A2824 == 0 ) "
13D70I55"1;
A2822 = A2818 - A2816;
A1804 = 0;
A1775:
if( A1804 <"
75D51I2"2)"
60D24I4"73;
"
32D9I7"74;
A17"
15D10I7"804++;
"
18D36I66"75;
A1773:
if( A2824 % 5 ) return (A10) 30000;
A2824 = A2824 / 5;
"
44D54I65"76;
A1774:
if( A2821 < 0 ) goto A1777;
goto A1778;
A1777: A2820 ="
59D26I60"8 - A2816;
goto A1779;
A1778: A2820 = A2818 + A2817;
A1779: "
32D70I8"769:
if("
75D122I69"0 > 900 ) return (A10) 30000;
return (A10) (A2820 * 10/3);
}
A4
A1026"
129D39I13", A2086 )
A48"
44D5I76"7;
A35 A2086;
{
A10 A2825;
A70 A1738;
switch( A2086 )
{
case 9: A1738 = 21; "
14D3I28"1;
case 7: A1738 = 22; goto "
8D25I101";
case 76: A1738 = 23; goto A1711;
default:
A865(260); A1738 = 21; goto A1711;
}
A1711:
A2825 = A1595"
30D5I120"8].A299 * A1390;
return A2814( A1737 ) < ((A2825-8)-1);
}
A10
A7305(A1737)
A5794 A1737;
{
A7 A1732;
A4 A5379=(A4) 0; A9 "
10D18I129"; A10 A2825 = 0; A17 A7306=0; A17 A7307=0; A17 A2069; A7 A7308=0; A7 A7309=0; A7 A7310=0; A17 A7311;
A18 A7312;
A1732 = 0;
A1713:"
23D62I12"A1737[A1732]"
73D1I1"1"
12D1I1"2"
7D24I12"4: A1732++;
"
33D13I1"3"
19D8I8"1:
A1833"
13D5I23"9)(A15)(A1737[A1732]);
"
11D47I10"= toupper("
52D15I2");"
20D5I61"( isdigit( A1833) || ('A' <= ( A1833 ) && ( A1833 ) <= 'F') )"
16D2I2"15"
12D2I2"16"
7D2I2"15"
8D6I14"isdigit(A1833)"
17D2I2"17"
13D1I1"0"
6D11I3"17:"
17D15I34" = (A17) (A1833 - '0');
goto A1721"
21D10I2"0:"
16D15I27" = (A17) (10 + A1833 - 'A')"
21D5I15"1:
if( A2069 ) "
14D1I13"2;
goto A1723"
6D20I14"22:
if( !A7306"
31D2I2"25"
12D2I2"26"
7D18I17"25:
A7306 = A2069"
23D2I2"08"
12D10I35"A1726:
A7307 = A2069;
A7309 = A1732"
15D4I6"23: ;
"
12D2I2"27"
7D15I23"16: if( A1833 == '.' ) "
23D2I14"66;
goto A1767"
7D23I16"66:
A5379 = (A4)"
31D77I11"0 = A1732;
"
86D3I10"8;
A1767: "
11D2I2"12"
8D10I3"8: "
15D40I16"27: ;
goto A1714"
45D2I2"12"
8D78I1"!"
84I58") return 1;
A7312 = (A18) (A7309 + 1 - A7308);
if( A5379 &"
5D2I27"08 < A7310 && A7310 < A7309"
13D13I4"69;
"
22D1I1"0"
6D2I2"69"
8D5I3"2--"
11D7I30"0:
A2825 = (A10) (A7312 * 4);
"
13D5I24"= 8;
A1773:
if( A7311 > "
17D1I1"1"
12D1I1"2"
7D1I1"4"
9D2I2">>"
16D1I1"3"
7D1I1"1"
11D1I1"6"
21D1I1"2"
21D1I1"4"
7D10I134"2:
A7311 = 1;
A1777:
if( A7311 < 0x10) goto A1775;
goto A1776;
A1778: A7311 <<= 1;
goto A1777;
A1775: if( A7307 & A7311 ) goto A1776;
"
15I35"--; goto A1778;
A1776:
return A2825"
251D3I6"size_t"
6331D1
2030D3I6"size_t"
1713D3I6"size_t"
4126I6"A49)(("
15D1I8"),(A49)("
17D1I11"),(size_t)("
35I1")"
10I6"A49)(("
23D1I8"),(A49)("
17D1I11"),(size_t)("
35I1")"
2378I6"A49)(("
15D1I8"),(A49)("
17D1I11"),(size_t)("
37I1")"
1042I6"A49)(("
15D1I8"),(A49)("
17D1I11"),(size_t)("
35I1")"
1521D3I6"size_t"
956I1"2"
123I6"(A72) "
74I6"(A72) "
19I6"(A72) "
1632D2I2"92"
11D7
23D10
47D4I4"1076"
25D7
14D7I12"5794
A7637( "
18D1I2"0 "
14D1I4";
A7"
6D15I10"0;
{
if( !"
20D37I10" ) return "
42D16I2";
"
23D13I83"A7778( A7630->A7626, A1737, A1730 );
}
A4
A240(A1737, A1736)
A5794 A1737, A1736;
{
"
18D2I29":if(*A1737) goto A1712;
goto "
7D2I34";
A1712:
if(*A1737++ != *A1736++) "
14I34"0; goto A1711;
A1713:
return (A4) "
997I7"((A72) "
13I1")"
265I7"((A72) "
13I1")"
1529I7"((A72) "
13I1")"
202I7"((A72) "
15I1")"
310I7"((A72) "
15I1")"
380I7"((A72) "
15I1")"
214I7"((A72) "
13I1")"
421I7"((A72) "
13I1")"
243I7"((A72) "
13I1")"
251I7"((A72) "
13I1")"
48I7"((A72) "
13I1")"
596I7"((A72) "
13I1")"
299I7"((A72) "
13I1")"
1711I6"(A72) "
12025I6"(A72) "
5610I6"(A72) "
701D3I6"size_t"
226D6I3"A72"
2165D11I11"9188, A9189"
46D5I15"8061, A8062; A4"
10D5I2"3,"
10D7
97D3I3"806"
70D1I1" "
43D1I1" "
16D6I6" A9188"
14D1I1" "
54D1I1" "
35D1I1" "
31D1I1" "
7D3I3"806"
26D4I4"9188"
15D3I3"806"
40D4I4"9188"
28D4I4"9188"
125D1I1" "
64D5I5" A806"
22I1" "
7D1I1" "
43D1I1" "
16D1I1" "
7D4I4"9188"
20D4I4"9189"
12D1I1" "
54D1I1" "
35D1I1" "
31D1I1" "
7D13I4"8062"
32D24I32"A9188 && !(A9181 && A9184(37270)"
47I44"9189 = (A81) *A8062++) ) goto A1717;
if( !(A"
11D4I4"9189"
28D4I4"9189"
203D1I1" "
59D1I1" "
103D1I1" "
59D1I1" "
7D4I4"9188"
37D1I1" "
16D4I4"9189"
10D1I1" "
26D4I4"9189"
37D1I1" "
16D4I4"9188"
10I12" goto A1775;"
8I28"A9187( A1732, A9188, A9189 )"
6D1I1"5"
8I9"72: ;
A17"
775D3I3"918"
14D11I11"8242, A8243"
30D14I11"8242, A8243"
36D52I11"9190, A9191"
96D4I4"9190"
15D4I4"8242"
13D5I1"1"
10D9I19"9191 = A7808( A8243"
18D19I35"0 );
A902( 863, A7918, A9190, A9191"
25D8I9"Void
A790"
14D16I49"32, A3688, A7917 )
A66 A1732;
A81 A3688;
A6 A7917"
21I229"81 A7918;
A5794 A6298;
A5794 A7919 = A7917 == 1 ? "modified" : "used";
A7918 = ((A81)((A7824)->A988)[ A1732 ]);
A6298 = A7808( A3688, A7918, A7917 );
A7745( 591, A7918, A7919, A3688, A6298 );
}
A81
A5267( A1741 )
A5794 A1741;
{
A"
Fa6.c
209D4I7"7 A9235"
18D2I1"9"
12I16"A6 A10;
typedef "
291D20
27D4I8"32 A9069"
14I19"A9069 A24;
typedef "
10D4I2"25"
14D9I13"unsigned A890"
21D6I10"9069 A9150"
17D6I10"9069 A9070"
17D8I8"9070 A27"
18D12I9"A9070 A28"
22I21"A9070 A5793;
typedef "
10D4I2"29"
14D17
26D8I5"A6228"
19D6I8"9070 A30"
25D3I8"long A31"
13I17"A17 A32;
typedef "
11D1I1"3"
11D7I12"unsigned A34"
19D5I5"4 A35"
17D5I5"5 A36"
21D1I1"7"
17D1I1"8"
16D2I2"39"
18D1I1"0"
17D1I1"1"
17D1I1"2"
12D6I6"34 A43"
22D1I1"4"
17D1I1"5"
11D7I7"A42 A46"
17I17"int A47;
typedef "
342D2I4"9236"
17D4I2"63"
19D1I3"577"
18D1I1"4"
16D4I2"65"
20D2I2"19"
18D4I4"8258"
14I19"A54 A7616;
typedef "
138D6I3"A16"
60D13I3"A72"
122D6I5"A9069"
20D6I5"A9069"
1373I69"struct A9304
{
A17 A9305;
A5794 A9306;
};
extern struct A9304 A9307;
"
6D4I4"9308"
14D4I4"9309"
17D1I1"5"
11D4I4"5566"
14D4I4"5567"
14D3I17"7618();
Void A761"
8D13
19D3I17"5569();
Void A915"
8D9I10"Void A9152"
14D17I2"74"
22D1I15"0();
Void A7621"
10I41"6226();
A5794 A6227();
A81 A7622();
A58 A"
460D2I4"9070"
28D2I4"9070"
151I19"struct A114 A9153;
"
1389D2I2"92"
16D6I12"5794 A7637()"
15I16"A4 A202;
extern "
3337D2I4"9070"
159I11"A58 A9238; "
88D2I4"9070"
39D2I4"9070"
367I11"A17 A9071;
"
535I13"A9236 A9239;
"
1098D2I4"9070"
380D7I8"17 A9154"
24D1I1"1"
12D6I7"62 A442"
16I17"A4 A443 ;
extern "
150D3I4"9072"
14D10I9"Void A451"
22D9I9"5794 A452"
21D9I9"9036 A453"
29D1I1"4"
13D12
20D1I1"5"
12D9I22"A315 A456 ;
A5794 A457"
28D1I1"8"
18D4I3"459"
21D3I4"5268"
14D16
24D1I1"0"
12I16"A4 A461;
extern "
8D1I1"2"
12D8I11"Void A463()"
22D4I3"464"
13I18"A58 A8823;
extern "
1037D7I10"Void A9155"
18D9I7"A4 A504"
20I20"Void A505();
extern "
1042D2I4"9070"
1940D8I19"struct A640 * A9310"
24D4I3"663"
15D10I9"A48 A7505"
29D2I2"37"
19D3I4"7176"
14D7I9"Void A664"
22D4I3"665"
16D8I7"4 A4442"
19D6I6"A17 A5"
27D3I2"66"
21D2I3"031"
21D1I1"7"
20D1I1"8"
12I20"Void A669();
extern "
278D3I4"4476"
14D10I17"struct A640 *A675"
27D4I4"7719"
21D4I4"8914"
15D8I12"Void A7720()"
18D7I7"17 A933"
18D8I7"7 A5254"
18D2I2"81"
7D1I1"0"
11D2I2"17"
7D1I1"1"
11D1I2"35"
6D1I1"2"
11D1I2"92"
6D1I1"3"
11D2I1"7"
7D1I1"4"
11D8I7"4 A2145"
18D1I2"68"
6D1I1"6"
13D14I6"*A2147"
24D8I7"4 A2148"
18D7I16"2 A2149[M_TOKEN]"
17D2I2"87"
7D1I1"0"
11D2I1"4"
7D1I1"1"
15D4I4"2152"
14D2I2"36"
7D1I1"3"
11D27I7"35 A826"
38D1I2"17"
6D3I1"4"
13D10I28"7
A2155,
A2156,
A2157,
A6214"
19D4I2"A9"
9D1I1"8"
12D10I9"A17 A8825"
27D3I3"215"
15D3I4"Void"
8D1I1"0"
18D4I4"8209"
23D1I1"1"
12D3I4"Void"
8D1I1"2"
12D10I9"A35 A2163"
29D1I1"4"
12D5I4"Void"
10D1I1"0"
12D9I8"A35 A216"
22D7I10"9036 A8211"
24D4I4"5255"
15D4I2"A4"
9D11I16"6();
extern Void"
16I37"7();
extern Void A2168();
struct A216"
465I42"struct A9073
{
A48 A9074;
A9069 A9075;
};
"
422D6I7"8 A9076"
17D9I8"A42 A982"
20D8I9"long A983"
24D4I3"984"
16D8I8"87 A6039"
20D8I8"61 A7724"
19D9I9"A92 A7260"
20D8I9"long A985"
24D4I3"986"
16D9I8"34 A5670"
20I21"A5794 A987();
extern "
1045I7"9129,
A"
44D4I4"9156"
11I42"9157,
A9158,
A9159,
A9160,
A9161,
A8639,
A"
21D10I2"91"
15D2I2"91"
7I29"9164,
A6176, 
A7062,
A7063,
A"
91I21"9240,
A9241,
A9130,
A"
21I28"9165,
A9166,
A9167,
A9168,
A"
28I14"9292,
A9169,
A"
92I42"9242,
A9243,
A9131,
A9132,
A9133,
A9134,
A"
71I7"9170,
A"
307D4I4"9171"
21I42"9244();
extern Void A8266();
extern Void A"
8I80"extern Void A9172();
extern A4 A9173();
extern A4 A9174();
extern Void A9175();
"
746D9I7"4 A9176"
21D7I9"5794 A868"
19D6I6"7 A598"
25D1I1"0"
19D1I1"1"
13D10I7"61 A872"
22D7I10"5794 A6037"
19D10I7"61 A873"
22D7I10"5794 A8589"
20D5I6"8 A874"
16D9I7"A4 A875"
28D1I1"6"
20D1I1"7"
20D1I1"8"
19D2I2"79"
19D4I3"880"
21D4I4"6172"
21D3I4"9293"
20D4I4"9177"
21D4I4"8787"
23D1I1"1"
20D1I2"29"
18D4I4"7262"
23D1I1"2"
20D1I1"3"
20D2I2"48"
21D1I1"4"
20D1I1"5"
18D3I4"5667"
22D1I1"6"
19D2I2"87"
20D2I2"88"
20D2I2"89"
19D4I3"890"
21D4I3"891"
21D4I3"892"
21D4I4"7745"
24D1I1"6"
21D1I1"7"
20I1"4"
18D3I4"7748"
20D4I4"7749"
21D4I3"893"
23D1I1"4"
18D4I4"1857"
22D3I3"958"
22D1I1"5"
19D3I3"061"
20D3I4"5821"
20D4I3"896"
21D3I4"7507"
20D4I3"897"
21D4I4"5981"
23D1I1"8"
19D3I3"750"
20D3I4"8212"
20D3I3"899"
20D3I4"7177"
22D1I1"0"
18D4I3"901"
23D1I1"2"
20D1I1"3"
18D3I4"8944"
22D1I1"4"
18D4I3"905"
21D3I3"907"
21D4I4"9078"
23D1I1"7"
18D3I4"5077"
20D3I4"8267"
20D3I4"8830"
14D7I9"Void A908"
25D2I2"09"
13D9I9"Void A910"
28D1I1"1"
12D9I7"A4 A912"
20D16
24D1I1"3"
14D8I7"4 A5431"
19D11I9"Void A914"
22D10I9"Void A915"
22D11I6"7 A916"
27D2I2"17"
13D9I10"A5794 A918"
27D3I4"1739"
15D6I9"5794 A919"
24D4I3"920"
15D9I9"Void A921"
26D4I3"922"
15D20I14"A5794 A923();
"
31D4I3"924"
16D7I10"5794 A7263"
19D8I8"61 A5668"
19D7I12"Void A5669()"
16D18
26D13I12"7734 A7751; "
21D7I7"4 A7752"
18D18I10"A4 A5914()"
28D6I10"861 A926()"
16D8I6"4 A927"
18D6I8"4 A928()"
15D9I19"struct A849 *A929()"
19D6I9"61 A930()"
16D8I12"9236 A9245()"
18D6I12"9236 A9246()"
15D9I12"Void A9247()"
18D7I18"struct A144 *A5050"
17D8I6"7 A931"
18D6I8"61 *A932"
16D8I6"7 A933"
21D7I7"*A934;
"
14D18I7"A7 A935"
28D7I8"61 *A936"
16D18I7"A7 A937"
27D18I9"A61 *A938"
27D18I7"A7 A939"
28D9I8"61 *A940"
19D9I6"7 A941"
19D9I8"61 *A942"
19D12I10"61 A6038; "
19D11I18"struct A144 *A1696"
23D8I5" A943"
18D10I7"7 A9294"
19D11I18"struct A144 *A7178"
20D17
26D7I8"44 *A717"
17D7I18"struct A144 *A5432"
17D6I9"5794 A944"
15D17I10"A5794 A945"
26D20I12"A5794 A946;
"
27D4I5"A5794"
9D3I1"4"
19D6I4"7180"
15D12I11"A5794 A7227"
21D12I11"A5794 A7181"
22D7I10"5794 A5510"
17D8I7"68 A948"
17D18
26D10I9"114 *A949"
20D7I6"7 A950"
17D7I6"4 A951"
16D10I17"struct A114 *A952"
19D13I20"struct A144 *A7265; "
27D3I3"266"
15D7I10"5794 A1689"
24D4I4"7753"
15D18I10"Void A7754"
30D10I7"6 A1022"
20D10I8"81 A5511"
19D12I9"A81 A8770"
21D12I18"struct A561 *A1023"
21D12I8"A4 A1024"
22D10I7"7 A1025"
19D18I8"A4 A1026"
29D18I9"A49 A1027"
29D10I9"Void A775"
22D10I8"A4 A1028"
27D15I8"1029();
"
21D4I31"9079();
A48 A9080();
Void A9081"
15D21
38D1I1"0"
13D7I8"17 A1031"
18D18I9"A79 A1032"
35D4I4"5671"
15D8I10"Void A5672"
19D9I10"Void A8401"
21D8I8"17 A5512"
19D10I18"struct A561 *A1033"
21D9I10"Void A9135"
20D9I18"struct A561 *A1034"
21D7I10"5794 A1035"
18D47I10"Void A2317"
58D9I10"Void A5673"
20D9I10"Void A1036"
20D9I10"Void A1037"
20D11I18"struct A561 *A1038"
22D8I6"A4 A56"
21D9I18"struct A561 *A1039"
20D11I10"Void A7182"
22D18I10"A4 A7183()"
27D10I9"A58 A8268"
22D7I28"78 A1040();
extern Void A775"
12D6I49"extern A81 A1041();
extern A81 A7508();
extern A4"
11D3I49"7();
extern A5794 A8590();
struct A7758 *A7759();"
12D51I3"0()"
60D18I11"A78 A1042()"
28D8I10"78 A5271()"
18D8I10"78 A1043()"
18D8I12"5972 A1044()"
17D9I12"Void A2274()"
18D17I42"A54 A5433();
extern A9036 A9039();
extern "
26D106I9"44 *A5434"
116D7I12"9150 A9178()"
16D13I32"Void A7761();
extern A48 A7906()"
23D31I63"7758
{
A40 A7762;
A87 A7763, A7764;
A17 A7765, A7766;
A67 A7767"
43D21
29D11I10"7758 A7768"
20D79I9"A87 A7769"
88D12I9"A87 A7770"
21D12I9"A88 A7771"
21D12I9"A10 A7772"
21D43I17"const A88 A7773;
"
52D19I43"045
{
A18 A1046;
A72 A1047;
A7470 A1048;
A3"
24D2I58"49;
};
struct A1050
{
A18 A1051;
A17 A1052;
A5794 A1053;
}"
12D7I7"7 A3140"
17D34I14"81 A3143[20];
"
43D9I33"054
{
A54 A1055;
A55 A1056[25];
}"
19D8I9"55 *A3164"
19D11I19"struct A1054 *A7509"
20D78
86D209I12"144 *A7774;
"
217D10I51"7500
{
struct A7500 *A7775; A54 A7510; A42 A7511; }"
19D9I12"Void A1057()"
18D8I12"Void A1058()"
17D9I10"Void A1059"
20D8I10"Void A1060"
19D10I11"A5794 A1061"
21D22I18"struct A118 *A1062"
33D13I8" A1063;
"
20D13I8"A4 A7267"
26D4I4"7776"
14D10I8"63 A7777"
19D21
29D3I3"114"
8D2I2"64"
11I40"A81 A7512();
extern A49 A1073();
extern "
8D2I66"74();
extern A72 A1075[];
extern A9036 A1076();
extern A9036 A7778"
14D94I118"3097
{
A70 A3098; A72 A3099; A7468 A3100; A7468 A3101; A72 A3102; A72 A3103; A72 A3104; A7 A3105; A4 A3106; A7 A5282; "
100D5I85"283; A32 A5284; A74 A5966; A17 A6270; };
extern A81 A3107;
extern A315 A3108;
extern "
13D55I62"3097 A3109;
extern A58 A3110;
extern A4 A6067;
extern A72 A311"
60D10I14"extern A6 A311"
15D45
52D11I14"Void A1077();
"
19D7I21"48 strcat(), strcpy()"
17D9I14"48 strncpy(); "
16D11I13"int strncmp()"
24D4I4"1078"
15D8I7"2 A7268"
27D2I2"79"
13D12I18"struct A553 *A1080"
21I17"A7 A9295;
extern "
6D67I3"108"
72I66"struct A553
{
struct A553 *A1082;
A7 A1083;
struct A114 A1084;
};
"
15D81I1"8"
86D75I59"struct A5513
{
A81 A5514;
struct A147 *A5515;
};
A5972 A777"
80D39I10"A5972 A778"
44D17I10"A5972 A778"
22D16I10"A5972 A778"
21D16I10"A5972 A778"
21D16I10"A5972 A778"
21I15"A5972 A7785();
"
7D14I11"A74 A6242; "
21D12I8"A7 A1086"
21D12I8"A7 A7184"
21D12I11"A5794 A5248"
25D6I4"7185"
15D10I10"A95 *A1087"
27D4I4"1088"
21D4I4"1089"
21D4I4"7186"
21D3I3"109"
21D4I4"7187"
15D10I11"A5794 A1091"
21D9I10"Void A1092"
27D3I3"093"
20D4I4"8269"
20D3I3"094"
14D10I8"A4 A1095"
21D10I8"A4 A1096"
28D3I3"097"
20D4I4"1098"
16D10I7"4 A1099"
21D10I11"A94 * A5272"
21D9I10"A94 * A110"
21D10I11"A94 * A1101"
29D2I2"02"
19D4I4"1103"
15D11I10"Void A1104"
30D2I2"05"
21D2I2"06"
19D4I4"5675"
21D4I4"6243"
15D10I8"A4 A5518"
27D4I4"7786"
21D4I4"5516"
21D4I4"5517"
21D4I4"5519"
22D3I3"520"
14D18I12"Void A5521()"
27D17
23D4I4"5522"
15D10I9"A23 A7787"
21D8I10"Void A1107"
19D10I10"Void A1108"
22D10I7"4 A1109"
21D11I10"Void A1110"
22D11I10"Void A1111"
22D11I10"Void A1112"
22I21"Void A2942();
extern "
7D4I4"1113"
15D55I12"Void A2949()"
64D13I12"Void A7070()"
22D9I12"Void A1114()"
18D10I12"Void A1115()"
19D9I12"Void A7269()"
19D8I12"94 * A1116()"
17D9I12"Void A1117()"
18D18I12"Void A1118()"
27D18I12"Void A1119()"
27D26I12"Void A7788()"
35D8I12"Void A5676()"
17D18
26D2I2"20"
21D2I2"21"
21D2I2"22"
13D9I10"Void A8270"
26D4I4"5249"
15D10I18"struct A144 *A5523"
19I17"A7 A5822;
extern "
6D4I4"7789"
21D4I4"7790"
19D4I4"7791"
15D10I10"A94 *A7792"
21D10I11"A5794 A7793"
22D7I10"5794 A7794"
19D7I10"5794 A7795"
18D10I11"A5794 A7796"
22D8I10"5794 A7797"
20D2I4"5794"
7D3I45"8();
struct A5304 { A77 A3049; A5794 A1148; }"
12D12I13"A2 A1123[100]"
21D12I9"A17 A1124"
21D12I10"A13 *A1125"
21D12I9"A81 A1126"
23D9I7"8 A1127"
19D1I1"5"
6D4I2"28"
13D11I18"struct A144 *A1129"
20D11I18"struct A144 *A1130"
20D11I26"const struct A5304 A3050[]"
21D10I7"4 A1131"
20D17I8"38 A1132"
26D45I9"Void A113"
65D1I1"3"
21D1I1"3"
13D9I8"A17 A113"
29D1I1"3"
13D10I8"A4 A2979"
29D1I1"3"
19D3I3"917"
23D2I2"39"
13I19"A4 A1140();
extern "
8D1I1"4"
6D124I231"extern Void A5529();
extern A4 A5530();
extern A7 A5532();
extern Void A5533();
extern A66 A5534();
extern A66 A7799();
extern Void A5531();
extern Void A1142();
extern Void A1143();
extern Void A1144();
extern A50 A1145();
extern "
131D339I15"46();
extern A7"
344D13I118"47();
extern A48 A1148();
extern A48 A1149();
extern A77 A1150();
extern A58 *A5067, *A5068;
extern A17 *A8945, *A8946"
22D4I6"8271()"
15D5I193"53();
extern Void A1154();
extern Void A1155();
extern Void A1156();
extern Void A1157();
extern Void A5823();
extern Void A1158();
extern Void A1159();
extern Void A1160();
extern Void A1161()"
15D4I4"8402"
15D19
25D4I75"8403; A54 A8404; A13 *A8405; A7468 A8406; A72 A8407; A58 *A8408;
A58 *A8409"
19D52I1"6"
57D1I1"7"
6D56I4"63;
"
61D10I229"
A7132,
A7133,
A1164,
A1165,
A1166,
A1167,
A1168,
A1169,
A1170,
A1171,
A1172,
A1173;
A13 A1174[ (2000 / CHARLEN) ];
A18 A5435;
A17 A6040;
A13 A7800[ (2000 / CHARLEN) ];
A61 A6041;
A17 A6042;
} ;
extern A13 A9180[(2000 / CHARLEN)]"
20D4I4"9248"
14D88I6"9249; "
95D17I17"9296; A17 A9250; "
24D6I6"9251; "
13D6I19"9297; FILE *A9252; "
16D9I18"struct A9248 A9253"
18D127I14"Void A9254();
"
135D27I104"391
{
struct A633 *A1175;
struct A144 *A1176;
struct A144 *A1177;
struct A144 *A1178;
};
struct A1179
{
"
32D262I91"180;
A53 A1181;
A17 A1182;
A53 A1183;
A5794 A1184;
A5794 A1185;
};
struct A1186
{
struct A8"
267D31I5"187;
"
40D27
33D12I8"188;
};
"
21D18I6"189
{
"
26D71I105"640 *A1190;
A5794 A1191;
};
struct A1192
{
A17 A1193;
A9 A1194;
A70 A1195;
};
struct A1196 { A2 A1197[3];"
77I833" *A1198; };
struct A1199
{
A5794 A1200;
A35 A1201;
A42 A1202;
};
Void A1203();
Void A1204();
Void A1205();
struct A5677
{
A5794 A5678;
A42 A5679;
A5794 A5680;
A5794 A5681;
};
extern A17 A6244;
extern long A7418;
extern A49 *A1206;
extern A49 *A1207;
extern A2 A1208[ARG_LEN];
extern A42 A8197; extern A2 A3496[ARG_LEN];
extern struct A1196 A1209[];
extern const A6 A1210;
extern A7 A5406;
extern A7 A5407;
extern A7 A6210;
extern A42 A1211;
extern A4 A1212;
extern A72 A1213;
extern A72 A1214;
extern A18 A1215;
extern A18 A1216;
extern A4 A7228;
extern A61 A1217;
extern A61 A1218;
extern A67 A1219;
extern A13 *A6043;
extern A13 *A1220;
extern A13 *A1221;
extern struct A1162 A1222;
extern struct A144 *A1223;
extern struct A144 *A1224;
extern struct A144 *A1225;
extern A48 A1226;
extern A7 A1227;
extern A9070 A1228;
extern UFLAG"
1095I7"9298,
A"
2534D19
33D4I4"9255"
14D7I9"2 A7190[]"
16D8I18"struct A144 *A1398"
21D4I4"1399"
14D8I7"4 A7807"
18D7I6"7 A621"
21D7I6"9181; "
15I1"1"
6D1I1"0"
11D1I2"68"
6D1I1"1"
11D1I1"4"
6D1I2"2 "
11D1I1"7"
6D1I1"3"
10D4I2"A7"
9D3I1"4"
12D4I2"A7"
9D3I1"5"
12D4I2"A4"
9D3I1"6"
12D9I10"Void A1407"
20D9I10"Void A1408"
26D4I4"1409"
17D6I7"8 A1410"
17D10I9"A58 A1411"
21D8I10"Void A8257"
19D10I8"A4 A8411"
27D4I4"5063"
15D4I2"A6"
9D1I1"2"
12D2I4"Void"
7D1I1"3"
18D4I4"1414"
21D4I4"1415"
15D10I8"A4 A1416"
21D19I10"Void A5687"
36D4I4"5688"
15D10I10"Void A5689"
21D10I19"struct A5677 *A5690"
30D1I1"7"
12D10I10"A13 *A5396"
21D10I9"Void A141"
28D4I4"1419"
21D4I4"6052"
15D10I11"A5794 A7808"
30D1I1"4"
18D4I4"5545"
21D4I4"5546"
15D8I10"Void A5547"
19D2I4"Void"
7D1I1"0"
12D2I4"Void"
7D25I1"1"
36D9I7"A4 A624"
21D9I9"A48 A9182"
20D9I8"A4 A1422"
20D4I2"A4"
9D12I5"3();
"
26D5I6" A1424"
16D10I12"Void A3500()"
19D8I10"Void A1425"
19D8I9"int A3493"
19D10I9"int A3494"
27D4I4"1426"
15D10I19"struct A1189 *A1427"
21D12I10"A13 *A8273"
22D7I6"4 A599"
19D9I7"A4 A599"
21D8I10"Void A9311"
27D2I2"28"
13D12I10"Void A7191"
31D2I2"29"
13D8I10"Void A6080"
25D4I4"9183"
15D10I9"A54 A1430"
21D1I1"V"
6D4I4"1431"
15D10I8"A4 A7475"
30D1I1"2"
12D9I12"UFLAG *A1433"
29D1I1"4"
12D10I8"A4 A1435"
29D2I2"36"
13D1I1"v"
6D4I4"6246"
15D1I1"v"
6D4I4"7809"
21D4I4"1437"
23D2I2"38"
14D10I10"34 A5691()"
19D20
28D2I2"39"
19D4I4"1440"
15D10I12"Void A1441()"
19D17
26D1I1"2"
21D1I1"3"
12D11I10"Void A5773"
30D2I2"44"
13D12I11"A5794 A1445"
21I20"A5794 A1446;
extern "
6D4I4"1447"
21D4I4"3532"
15D12I10"A2 A3526[]"
21I17"A4 A3527;
extern "
6D2I2"14"
21D4I4"1449"
15D10I11"A5794 A1450"
30D1I1"1"
18D4I4"1452"
15D10I8"A4 A9184"
27D4I4"5274"
21D73I6"1453()"
82D19I12"Void A5651()"
28D20I12"Void A5548()"
29D20
26D4I130"3443();
extern Void A6072();
extern Void A1454();
extern Void A3363();
extern Void A1455();
extern Void A1456();
extern Void A5107"
17D89I65"065
{
A67 A1066;
A5794 A1067;
A5794 *A1068;
A17 A1069;
};
extern "
97D44I20"1065 *A1070;
extern "
52D40I53"1065 A1071[];
extern A67 A1072[];
extern Void A6209()"
53D12I85"
{
A79 A547;
A79 A548;
A79 A549;
A79 A6232;
A79 A5661;
A87 A6233;
A87 A5662;
A23 A552"
23D16I24"53 *A554, *A555, *A6234,"
21D1I12"63, *A557;
}"
11D29I14"93
{
A17 A8274"
34D35I21"98 A8275;
A8198 A8276"
50D44I10"8277[1];
}"
54D41I6"561
{
"
56D4I165"62;
struct A561 *A563;
A40 A564;
A40 A565;
A81 A566;
A58 A567;
A42 A568;
A68 A569;
struct A147 A570;
A17 A571;
A24 A572;
A61 A573;
A96 *A574;
struct A1537 * A7443;
}"
13D11I8"A81 A575"
20D9I17"struct A561 *A576"
28D1I1"7"
18D2I1"5"
22D2I2"79"
19D3I4"8278"
22D1I1"0"
20D1I1"1"
19D3I2"82"
22D9I1"3"
20D7I10"Void A5664"
18D19
27I65"4(), A585();
extern A4 A586();
extern A4 A5665();
extern Void A58"
1854I50"9136
{
struct A9136 *A9137; A17 A9138; };
struct A"
109D9I19"struct A9136 *A9139"
18D18
26D9I10"9136 A9140"
19D9I8"58 A7273"
18D4I3"A17"
9D3I1"4"
12D11I17"struct A588 A1719"
20D4I2"A2"
9D3I3"6[]"
20D2I2"77"
13D10I9"A89 A1978"
29D2I2"79"
19D4I4"1980"
21D4I4"7274"
24D1I1"1"
13D8I7"4 A9185"
19D18I8"A4 A9186"
35D4I4"5897"
24D1I1"2"
12D3I4"Void"
8D1I1"3"
12D10I9"A72 A1984"
21D10I18"struct A561 *A1985"
27D3I3"914"
23D2I2"86"
21D2I2"87"
13D27
33D26I4"9142"
37D10I9"A78 A1988"
27D4I4"1990"
21D4I4"1989"
21D4I4"1991"
15D8I10"Void A1992"
25D4I4"1993"
15I27"struct A144 *A7824; extern "
6D4I26"5553();
struct A147 *A7825"
23D2I2"26"
19D4I4"7827"
21D64I6"7828()"
73D8I10"Void A7829"
20D7I7"4 A7830"
18D9I12"Void A8412()"
18D9I12"Void A7831()"
18D9I12"Void A7832()"
18D19I12"Void A8413()"
28I14"Void A8414();
"
8D20I7"1457
{
"
26D12I4"58;
"
18D3I25"59;
A4 A1460;
A9 A1461;
}"
12D19I10"A9 A1461()"
28D18I10"A9 A1462()"
28D1I1"9"
6D1I1"3"
11D19I8"A4 A1464"
30D9I7"4 A1465"
19D20
28D11I10"83 **A5078"
21D9I18"struct A83 **A5079"
25D2I2"66"
13D9I7"4 A1467"
19D3I11"struct A144"
8D2I2"68"
12D11I18"struct A144 *A7476"
21D9I7"4 A1469"
19D10I19"struct A640 **A3651"
20D9I18"struct A640 **A365"
21D8I9"17 *A1470"
19D8I9"68 *A1471"
26D13I14"640 **A1472 ;
"
22D7I7"3 A1473"
18D11I7"4 A1474"
22D7I9"13 *A1475"
18D7I9"13 *A1476"
18D7I9"13 *A1477"
18D4I2"53"
9D2I2"78"
13D2I2"68"
7D2I2"79"
12D9I3"A17"
15D1I1"0"
12D1I2"57"
6D1I1"1"
11I19"A57 A3660 ;
extern "
17D3I4"5 ; "
11D10I8"57 A1482"
22D6I10"036 *A1483"
17D10I7"4 A1484"
20D18I8"A4 A8214"
29D8I7"4 A1485"
19D7I11"9036 *A1486"
18D7I9"81 *A1487"
17D8I16"const A81 *A1488"
19D7I7"6 A1489"
25D11I10"144 *A7276"
21D4I4"9036"
9D1I1"0"
11D17I8"A9 A1491"
27I21"A9036 A1492 ;
extern "
8D9I10"640 *A1493"
19D17I9"A63 A1494"
27D17I8"A4 A1495"
28D8I7"4 A1496"
22D4I4"5825"
18D4I5"1497 "
21D8I9"640 *A149"
19D12I12"A5794 A1499 "
21D12I18"struct A83 *A1500 "
21D10I18"struct A83 *A1501 "
19D13I18"struct A83 *A1502 "
22D10I18"struct A83 *A5080 "
20D9I9"53 A1503 "
18D12I9"A4 A1504 "
21D12I8"A4 A6247"
21I27"struct A83 *A6248 ;
extern "
6D4I4"9040"
23D2I2"05"
14D7I7"4 A1506"
18D10I11"A5794 A1507"
21D9I10"Void A7451"
20D10I8"A4 A7833"
22D8I7"4 A6249"
25D4I4"6250"
23D2I2"08"
13D8I10"Void A1509"
28D1I1"0"
12D4I2"A6"
9D1I1"1"
21D1I1"2"
12D10I9"A68 A1513"
21D7I9"Void A151"
20I203"81 A5692();
extern Void A8215();
extern Void A1515();
extern A4 A1516();
extern Void A1517();
extern Void A1518();
extern Void A1519();
extern Void A1520();
extern A4 A3738();
extern A4 A7834();
extern A"
561D1I1" "
11D1I1" "
11D1I1" "
10D1I1" "
10D1I1" "
10D1I1" "
848D4I4"9082"
15D19I10"Void A9083"
30D19I10"Void A9084"
30I21"Void A3863();
extern "
17D2I2"89"
13D10I19"struct A1537 *A1590"
21D10I19"struct A1537 *A1591"
27D2I2"71"
21D4I4"1592"
21D4I4"1593"
15D9I10"Void A7841"
29D1I1"2"
12D4I3"A74"
9D1I1"7"
18D4I4"7843"
21D4I4"8218"
15D9I10"Void A8219"
29D1I1"5"
13I1"7"
6D1I1"6"
12D3I4"Void"
8D1I1"7"
12D10I8"A4 A7848"
21D10I9"A74 A7849"
21D1I1"V"
8D24I4"94()"
33D9I4"void"
14D1I3"1()"
10D4I4"void"
9D9I17"2();
typedef A22*"
14I57"3;
extern const A51 A1524;
extern long A1525;
struct A152"
1445D10I8"A4 A9085"
27D4I4"3763"
15D9I10"Void A8835"
21D2I2"35"
7D1I3"4()"
10D11I3"A58"
16D1I1"5"
10D2I11"struct A147"
7D3I1"6"
12I19"A4 A3767();
extern "
2788D2I4"9070"
433D8I10"Void A9086"
19D9I9"A74 A9087"
28D1I1"6"
12D8I9"Void A737"
19D9I8"A4 A4551"
20D9I9"Void A738"
25D3I4"4724"
14D10I8"A58 A741"
29D1I2"77"
20D1I1"3"
18D4I3"744"
15I21"Void A8202();
extern "
1326D1I1" "
15D1I1" "
11D1I1" "
2390D2I4"9070"
215D2I4"9070"
12D1I2"72"
52D4I4"9088"
1854I14"7 A9295 = 0;
A"
5415D3I6"size_t"
319D3I6"size_t"
1547D3I6"size_t"
3670D3I6"size_t"
4565I6"(A72) "
16I6"(A72) "
1518I6"(A72) "
16I6"(A72) "
3997I6"(A72) "
26D1
11I6"(A72) "
5183I6"(A72) "
26D1
11I6"(A72) "
9983D3I6"size_t"
745D3I6"size_t"
8602I2" ("
12D1
20D1
6I2") "
45D2I4" 4; "
7D7I5"3: A2"
19D6I12" 0; A1115( &"
16D6I17"55 ); 
A1714:if(0"
20D11I9"A1715: ; "
16D5I9"2:if( (A4"
15D16I9"==4 && A2"
23D26I3"549"
31I2") "
9D1I1"6"
12D1I1"7"
7D1I1"6"
12D20I19"549 = 4; 
A1720: A2"
28D11I16"48 = 0; A1115( &"
21D7I17"54 ); 
A1721:if(0"
17D12
19D6I20"22: ; 
A1717:if( (A4"
13D7I55"6232 ==4 && A2113-> A6232 ==3) ) goto A1723;
goto A1725"
13D1I130"3: A2113-> A6232 = 4;
A1725:if( (A4113-> A5661 ==4 && A2113-> A5661 ==3) ) goto A1726;
goto A1727;
A1726: A2113-> A5661 = 4;
A1727"
3457D3I6"size_t"
Fa7.c
209D4I7"7 A9235"
18D2I1"9"
12I16"A6 A10;
typedef "
291D20
27D4I8"32 A9069"
14I19"A9069 A24;
typedef "
10D4I2"25"
14D9I13"unsigned A890"
21D6I10"9069 A9150"
17D6I10"9069 A9070"
17D8I8"9070 A27"
18D12I9"A9070 A28"
22I21"A9070 A5793;
typedef "
10D4I2"29"
14D17
26D8I5"A6228"
19D6I8"9070 A30"
25D3I8"long A31"
13I17"A17 A32;
typedef "
11D1I1"3"
11D7I12"unsigned A34"
19D5I5"4 A35"
17D5I5"5 A36"
21D1I1"7"
17D1I1"8"
16D2I2"39"
18D1I1"0"
17D1I1"1"
17D1I1"2"
12D6I6"34 A43"
22D1I1"4"
17D1I1"5"
11D7I7"A42 A46"
17I17"int A47;
typedef "
342D2I4"9236"
17D4I2"63"
19D1I3"577"
18D1I1"4"
16D4I2"65"
20D2I2"19"
18D4I4"8258"
14I19"A54 A7616;
typedef "
138D6I3"A16"
60D13I3"A72"
122D6I5"A9069"
20D6I5"A9069"
1373I69"struct A9304
{
A17 A9305;
A5794 A9306;
};
extern struct A9304 A9307;
"
6D4I4"9308"
14D4I4"9309"
17D1I1"5"
11D4I4"5566"
14D4I4"5567"
14D3I17"7618();
Void A761"
8D13
19D3I17"5569();
Void A915"
8D9I10"Void A9152"
14D17I2"74"
22D1I15"0();
Void A7621"
10I41"6226();
A5794 A6227();
A81 A7622();
A58 A"
460D2I4"9070"
28D2I4"9070"
151I19"struct A114 A9153;
"
1389D2I2"92"
16D6I12"5794 A7637()"
15I16"A4 A202;
extern "
3337D2I4"9070"
159I11"A58 A9238; "
88D2I4"9070"
39D2I4"9070"
367I11"A17 A9071;
"
535I13"A9236 A9239;
"
1098D2I4"9070"
380D7I8"17 A9154"
24D1I1"1"
12D6I7"62 A442"
16I17"A4 A443 ;
extern "
150D3I4"9072"
14D10I9"Void A451"
22D9I9"5794 A452"
21D9I9"9036 A453"
29D1I1"4"
13D12
20D1I1"5"
12D9I22"A315 A456 ;
A5794 A457"
28D1I1"8"
18D4I3"459"
21D3I4"5268"
14D16
24D1I1"0"
12I16"A4 A461;
extern "
8D1I1"2"
12D8I11"Void A463()"
22D4I3"464"
13I18"A58 A8823;
extern "
1037D7I10"Void A9155"
18D9I7"A4 A504"
20I20"Void A505();
extern "
1042D2I4"9070"
1940D8I19"struct A640 * A9310"
24D4I3"663"
15D10I9"A48 A7505"
29D2I2"37"
19D3I4"7176"
14D7I9"Void A664"
22D4I3"665"
16D8I7"4 A4442"
19D6I6"A17 A5"
27D3I2"66"
21D2I3"031"
21D1I1"7"
20D1I1"8"
12I20"Void A669();
extern "
278D3I4"4476"
14D10I17"struct A640 *A675"
27D4I4"7719"
21D4I4"8914"
15D8I12"Void A7720()"
18D7I7"17 A933"
18D8I7"7 A5254"
18D2I2"81"
7D1I1"0"
11D2I2"17"
7D1I1"1"
11D1I2"35"
6D1I1"2"
11D1I2"92"
6D1I1"3"
11D2I1"7"
7D1I1"4"
11D8I7"4 A2145"
18D1I2"68"
6D1I1"6"
13D14I6"*A2147"
24D8I7"4 A2148"
18D7I16"2 A2149[M_TOKEN]"
17D2I2"87"
7D1I1"0"
11D2I1"4"
7D1I1"1"
15D4I4"2152"
14D2I2"36"
7D1I1"3"
11D27I7"35 A826"
38D1I2"17"
6D3I1"4"
13D10I28"7
A2155,
A2156,
A2157,
A6214"
19D4I2"A9"
9D1I1"8"
12D10I9"A17 A8825"
27D3I3"215"
15D3I4"Void"
8D1I1"0"
18D4I4"8209"
23D1I1"1"
12D3I4"Void"
8D1I1"2"
12D10I9"A35 A2163"
29D1I1"4"
12D5I4"Void"
10D1I1"0"
12D9I8"A35 A216"
22D7I10"9036 A8211"
24D4I4"5255"
15D4I2"A4"
9D11I16"6();
extern Void"
16I37"7();
extern Void A2168();
struct A216"
465I42"struct A9073
{
A48 A9074;
A9069 A9075;
};
"
422D6I7"8 A9076"
17D9I8"A42 A982"
20D8I9"long A983"
24D4I3"984"
16D8I8"87 A6039"
20D8I8"61 A7724"
19D9I9"A92 A7260"
20D8I9"long A985"
24D4I3"986"
16D9I8"34 A5670"
20I21"A5794 A987();
extern "
1045I7"9129,
A"
44D4I4"9156"
11I42"9157,
A9158,
A9159,
A9160,
A9161,
A8639,
A"
21D10I2"91"
15D2I2"91"
7I29"9164,
A6176, 
A7062,
A7063,
A"
91I21"9240,
A9241,
A9130,
A"
21I28"9165,
A9166,
A9167,
A9168,
A"
28I14"9292,
A9169,
A"
92I42"9242,
A9243,
A9131,
A9132,
A9133,
A9134,
A"
71I7"9170,
A"
307D4I4"9171"
21I42"9244();
extern Void A8266();
extern Void A"
8I80"extern Void A9172();
extern A4 A9173();
extern A4 A9174();
extern Void A9175();
"
746D9I7"4 A9176"
21D7I9"5794 A868"
19D6I6"7 A598"
25D1I1"0"
19D1I1"1"
13D10I7"61 A872"
22D7I10"5794 A6037"
19D10I7"61 A873"
22D7I10"5794 A8589"
20D5I6"8 A874"
16D9I7"A4 A875"
28D1I1"6"
20D1I1"7"
20D1I1"8"
19D2I2"79"
19D4I3"880"
21D4I4"6172"
21D3I4"9293"
20D4I4"9177"
21D4I4"8787"
23D1I1"1"
20D1I2"29"
18D4I4"7262"
23D1I1"2"
20D1I1"3"
20D2I2"48"
21D1I1"4"
20D1I1"5"
18D3I4"5667"
22D1I1"6"
19D2I2"87"
20D2I2"88"
20D2I2"89"
19D4I3"890"
21D4I3"891"
21D4I3"892"
21D4I4"7745"
24D1I1"6"
21D1I1"7"
20I1"4"
18D3I4"7748"
20D4I4"7749"
21D4I3"893"
23D1I1"4"
18D4I4"1857"
22D3I3"958"
22D1I1"5"
19D3I3"061"
20D3I4"5821"
20D4I3"896"
21D3I4"7507"
20D4I3"897"
21D4I4"5981"
23D1I1"8"
19D3I3"750"
20D3I4"8212"
20D3I3"899"
20D3I4"7177"
22D1I1"0"
18D4I3"901"
23D1I1"2"
20D1I1"3"
18D3I4"8944"
22D1I1"4"
18D4I3"905"
21D3I3"907"
21D4I4"9078"
23D1I1"7"
18D3I4"5077"
20D3I4"8267"
20D3I4"8830"
14D7I9"Void A908"
25D2I2"09"
13D9I9"Void A910"
28D1I1"1"
12D9I7"A4 A912"
20D16
24D1I1"3"
14D8I7"4 A5431"
19D11I9"Void A914"
22D10I9"Void A915"
22D11I6"7 A916"
27D2I2"17"
13D9I10"A5794 A918"
27D3I4"1739"
15D6I9"5794 A919"
24D4I3"920"
15D9I9"Void A921"
26D4I3"922"
15D20I14"A5794 A923();
"
31D4I3"924"
16D7I10"5794 A7263"
19D8I8"61 A5668"
19D7I12"Void A5669()"
16D18
26D13I12"7734 A7751; "
21D7I7"4 A7752"
18D18I10"A4 A5914()"
28D6I10"861 A926()"
16D8I6"4 A927"
18D6I8"4 A928()"
15D9I19"struct A849 *A929()"
19D6I9"61 A930()"
16D8I12"9236 A9245()"
18D6I12"9236 A9246()"
15D9I12"Void A9247()"
18D7I18"struct A144 *A5050"
17D8I6"7 A931"
18D6I8"61 *A932"
16D8I6"7 A933"
21D7I7"*A934;
"
14D18I7"A7 A935"
28D7I8"61 *A936"
16D18I7"A7 A937"
27D18I9"A61 *A938"
27D18I7"A7 A939"
28D9I8"61 *A940"
19D9I6"7 A941"
19D9I8"61 *A942"
19D12I10"61 A6038; "
19D11I18"struct A144 *A1696"
23D8I5" A943"
18D10I7"7 A9294"
19D11I18"struct A144 *A7178"
20D17
26D7I8"44 *A717"
17D7I18"struct A144 *A5432"
17D6I9"5794 A944"
15D17I10"A5794 A945"
26D20I12"A5794 A946;
"
27D4I5"A5794"
9D3I1"4"
19D6I4"7180"
15D12I11"A5794 A7227"
21D12I11"A5794 A7181"
22D7I10"5794 A5510"
17D8I7"68 A948"
17D18
26D10I9"114 *A949"
20D7I6"7 A950"
17D7I6"4 A951"
16D10I17"struct A114 *A952"
19D13I20"struct A144 *A7265; "
27D3I3"266"
15D7I10"5794 A1689"
24D4I4"7753"
15D18I10"Void A7754"
30D10I7"6 A1022"
20D10I8"81 A5511"
19D12I9"A81 A8770"
21D12I18"struct A561 *A1023"
21D12I8"A4 A1024"
22D10I7"7 A1025"
19D18I8"A4 A1026"
29D18I9"A49 A1027"
29D10I9"Void A775"
22D10I8"A4 A1028"
27D15I8"1029();
"
21D4I31"9079();
A48 A9080();
Void A9081"
15D21
38D1I1"0"
13D7I8"17 A1031"
18D18I9"A79 A1032"
35D4I4"5671"
15D8I10"Void A5672"
19D9I10"Void A8401"
21D8I8"17 A5512"
19D10I18"struct A561 *A1033"
21D9I10"Void A9135"
20D9I18"struct A561 *A1034"
21D7I10"5794 A1035"
18D47I10"Void A2317"
58D9I10"Void A5673"
20D9I10"Void A1036"
20D9I10"Void A1037"
20D11I18"struct A561 *A1038"
22D8I6"A4 A56"
21D9I18"struct A561 *A1039"
20D11I10"Void A7182"
22D18I10"A4 A7183()"
27D10I9"A58 A8268"
22D7I28"78 A1040();
extern Void A775"
12D6I49"extern A81 A1041();
extern A81 A7508();
extern A4"
11D3I49"7();
extern A5794 A8590();
struct A7758 *A7759();"
12D51I3"0()"
60D18I11"A78 A1042()"
28D8I10"78 A5271()"
18D8I10"78 A1043()"
18D8I12"5972 A1044()"
17D9I12"Void A2274()"
18D17I42"A54 A5433();
extern A9036 A9039();
extern "
26D106I9"44 *A5434"
116D7I12"9150 A9178()"
16D13I32"Void A7761();
extern A48 A7906()"
23D31I63"7758
{
A40 A7762;
A87 A7763, A7764;
A17 A7765, A7766;
A67 A7767"
43D21
29D11I10"7758 A7768"
20D79I9"A87 A7769"
88D12I9"A87 A7770"
21D12I9"A88 A7771"
21D12I9"A10 A7772"
21D43I17"const A88 A7773;
"
52D19I43"045
{
A18 A1046;
A72 A1047;
A7470 A1048;
A3"
24D2I58"49;
};
struct A1050
{
A18 A1051;
A17 A1052;
A5794 A1053;
}"
12D7I7"7 A3140"
17D34I14"81 A3143[20];
"
43D9I33"054
{
A54 A1055;
A55 A1056[25];
}"
19D8I9"55 *A3164"
19D11I19"struct A1054 *A7509"
20D78
86D209I12"144 *A7774;
"
217D10I51"7500
{
struct A7500 *A7775; A54 A7510; A42 A7511; }"
19D9I12"Void A1057()"
18D8I12"Void A1058()"
17D9I10"Void A1059"
20D8I10"Void A1060"
19D10I11"A5794 A1061"
21D22I18"struct A118 *A1062"
33D13I8" A1063;
"
20D13I8"A4 A7267"
26D4I4"7776"
14D10I8"63 A7777"
19D21
29D3I3"114"
8D2I2"64"
11I40"A81 A7512();
extern A49 A1073();
extern "
8D2I66"74();
extern A72 A1075[];
extern A9036 A1076();
extern A9036 A7778"
14D94I118"3097
{
A70 A3098; A72 A3099; A7468 A3100; A7468 A3101; A72 A3102; A72 A3103; A72 A3104; A7 A3105; A4 A3106; A7 A5282; "
100D5I85"283; A32 A5284; A74 A5966; A17 A6270; };
extern A81 A3107;
extern A315 A3108;
extern "
13D55I62"3097 A3109;
extern A58 A3110;
extern A4 A6067;
extern A72 A311"
60D10I14"extern A6 A311"
15D45
52D11I14"Void A1077();
"
19D7I21"48 strcat(), strcpy()"
17D9I14"48 strncpy(); "
16D11I13"int strncmp()"
24D4I4"1078"
15D8I7"2 A7268"
27D2I2"79"
13D12I18"struct A553 *A1080"
21I17"A7 A9295;
extern "
6D67I3"108"
72I66"struct A553
{
struct A553 *A1082;
A7 A1083;
struct A114 A1084;
};
"
15D81I1"8"
86D75I59"struct A5513
{
A81 A5514;
struct A147 *A5515;
};
A5972 A777"
80D39I10"A5972 A778"
44D17I10"A5972 A778"
22D16I10"A5972 A778"
21D16I10"A5972 A778"
21D16I10"A5972 A778"
21I15"A5972 A7785();
"
7D14I11"A74 A6242; "
21D12I8"A7 A1086"
21D12I8"A7 A7184"
21D12I11"A5794 A5248"
25D6I4"7185"
15D10I10"A95 *A1087"
27D4I4"1088"
21D4I4"1089"
21D4I4"7186"
21D3I3"109"
21D4I4"7187"
15D10I11"A5794 A1091"
21D9I10"Void A1092"
27D3I3"093"
20D4I4"8269"
20D3I3"094"
14D10I8"A4 A1095"
21D10I8"A4 A1096"
28D3I3"097"
20D4I4"1098"
16D10I7"4 A1099"
21D10I11"A94 * A5272"
21D9I10"A94 * A110"
21D10I11"A94 * A1101"
29D2I2"02"
19D4I4"1103"
15D11I10"Void A1104"
30D2I2"05"
21D2I2"06"
19D4I4"5675"
21D4I4"6243"
15D10I8"A4 A5518"
27D4I4"7786"
21D4I4"5516"
21D4I4"5517"
21D4I4"5519"
22D3I3"520"
14D18I12"Void A5521()"
27D17
23D4I4"5522"
15D10I9"A23 A7787"
21D8I10"Void A1107"
19D10I10"Void A1108"
22D10I7"4 A1109"
21D11I10"Void A1110"
22D11I10"Void A1111"
22D11I10"Void A1112"
22I21"Void A2942();
extern "
7D4I4"1113"
15D55I12"Void A2949()"
64D13I12"Void A7070()"
22D9I12"Void A1114()"
18D10I12"Void A1115()"
19D9I12"Void A7269()"
19D8I12"94 * A1116()"
17D9I12"Void A1117()"
18D18I12"Void A1118()"
27D18I12"Void A1119()"
27D26I12"Void A7788()"
35D8I12"Void A5676()"
17D18
26D2I2"20"
21D2I2"21"
21D2I2"22"
13D9I10"Void A8270"
26D4I4"5249"
15D10I18"struct A144 *A5523"
19I17"A7 A5822;
extern "
6D4I4"7789"
21D4I4"7790"
19D4I4"7791"
15D10I10"A94 *A7792"
21D10I11"A5794 A7793"
22D7I10"5794 A7794"
19D7I10"5794 A7795"
18D10I11"A5794 A7796"
22D8I10"5794 A7797"
20D2I4"5794"
7D3I45"8();
struct A5304 { A77 A3049; A5794 A1148; }"
12D12I13"A2 A1123[100]"
21D12I9"A17 A1124"
21D12I10"A13 *A1125"
21D12I9"A81 A1126"
23D9I7"8 A1127"
19D1I1"5"
6D4I2"28"
13D11I18"struct A144 *A1129"
20D11I18"struct A144 *A1130"
20D11I26"const struct A5304 A3050[]"
21D10I7"4 A1131"
20D17I8"38 A1132"
26D45I9"Void A113"
65D1I1"3"
21D1I1"3"
13D9I8"A17 A113"
29D1I1"3"
13D10I8"A4 A2979"
29D1I1"3"
19D3I3"917"
23D2I2"39"
13I19"A4 A1140();
extern "
8D1I1"4"
6D124I231"extern Void A5529();
extern A4 A5530();
extern A7 A5532();
extern Void A5533();
extern A66 A5534();
extern A66 A7799();
extern Void A5531();
extern Void A1142();
extern Void A1143();
extern Void A1144();
extern A50 A1145();
extern "
131D339I15"46();
extern A7"
344D13I118"47();
extern A48 A1148();
extern A48 A1149();
extern A77 A1150();
extern A58 *A5067, *A5068;
extern A17 *A8945, *A8946"
22D4I6"8271()"
15D5I193"53();
extern Void A1154();
extern Void A1155();
extern Void A1156();
extern Void A1157();
extern Void A5823();
extern Void A1158();
extern Void A1159();
extern Void A1160();
extern Void A1161()"
15D4I4"8402"
15D19
25D4I75"8403; A54 A8404; A13 *A8405; A7468 A8406; A72 A8407; A58 *A8408;
A58 *A8409"
19D52I1"6"
57D1I1"7"
6D56I4"63;
"
61D10I229"
A7132,
A7133,
A1164,
A1165,
A1166,
A1167,
A1168,
A1169,
A1170,
A1171,
A1172,
A1173;
A13 A1174[ (2000 / CHARLEN) ];
A18 A5435;
A17 A6040;
A13 A7800[ (2000 / CHARLEN) ];
A61 A6041;
A17 A6042;
} ;
extern A13 A9180[(2000 / CHARLEN)]"
20D4I4"9248"
14D88I6"9249; "
95D17I17"9296; A17 A9250; "
24D6I6"9251; "
13D6I19"9297; FILE *A9252; "
16D9I18"struct A9248 A9253"
18D127I14"Void A9254();
"
135D27I104"391
{
struct A633 *A1175;
struct A144 *A1176;
struct A144 *A1177;
struct A144 *A1178;
};
struct A1179
{
"
32D262I91"180;
A53 A1181;
A17 A1182;
A53 A1183;
A5794 A1184;
A5794 A1185;
};
struct A1186
{
struct A8"
267D31I5"187;
"
40D27
33D12I8"188;
};
"
21D18I6"189
{
"
26D71I105"640 *A1190;
A5794 A1191;
};
struct A1192
{
A17 A1193;
A9 A1194;
A70 A1195;
};
struct A1196 { A2 A1197[3];"
77I833" *A1198; };
struct A1199
{
A5794 A1200;
A35 A1201;
A42 A1202;
};
Void A1203();
Void A1204();
Void A1205();
struct A5677
{
A5794 A5678;
A42 A5679;
A5794 A5680;
A5794 A5681;
};
extern A17 A6244;
extern long A7418;
extern A49 *A1206;
extern A49 *A1207;
extern A2 A1208[ARG_LEN];
extern A42 A8197; extern A2 A3496[ARG_LEN];
extern struct A1196 A1209[];
extern const A6 A1210;
extern A7 A5406;
extern A7 A5407;
extern A7 A6210;
extern A42 A1211;
extern A4 A1212;
extern A72 A1213;
extern A72 A1214;
extern A18 A1215;
extern A18 A1216;
extern A4 A7228;
extern A61 A1217;
extern A61 A1218;
extern A67 A1219;
extern A13 *A6043;
extern A13 *A1220;
extern A13 *A1221;
extern struct A1162 A1222;
extern struct A144 *A1223;
extern struct A144 *A1224;
extern struct A144 *A1225;
extern A48 A1226;
extern A7 A1227;
extern A9070 A1228;
extern UFLAG"
1095I7"9298,
A"
2534D19
33D4I4"9255"
14D7I9"2 A7190[]"
16D8I18"struct A144 *A1398"
21D4I4"1399"
14D8I7"4 A7807"
18D7I6"7 A621"
21D7I6"9181; "
15I1"1"
6D1I1"0"
11D1I2"68"
6D1I1"1"
11D1I1"4"
6D1I2"2 "
11D1I1"7"
6D1I1"3"
10D4I2"A7"
9D3I1"4"
12D4I2"A7"
9D3I1"5"
12D4I2"A4"
9D3I1"6"
12D9I10"Void A1407"
20D9I10"Void A1408"
26D4I4"1409"
17D6I7"8 A1410"
17D10I9"A58 A1411"
21D8I10"Void A8257"
19D10I8"A4 A8411"
27D4I4"5063"
15D4I2"A6"
9D1I1"2"
12D2I4"Void"
7D1I1"3"
18D4I4"1414"
21D4I4"1415"
15D10I8"A4 A1416"
21D19I10"Void A5687"
36D4I4"5688"
15D10I10"Void A5689"
21D10I19"struct A5677 *A5690"
30D1I1"7"
12D10I10"A13 *A5396"
21D10I9"Void A141"
28D4I4"1419"
21D4I4"6052"
15D10I11"A5794 A7808"
30D1I1"4"
18D4I4"5545"
21D4I4"5546"
15D8I10"Void A5547"
19D2I4"Void"
7D1I1"0"
12D2I4"Void"
7D25I1"1"
36D9I7"A4 A624"
21D9I9"A48 A9182"
20D9I8"A4 A1422"
20D4I2"A4"
9D12I5"3();
"
26D5I6" A1424"
16D10I12"Void A3500()"
19D8I10"Void A1425"
19D8I9"int A3493"
19D10I9"int A3494"
27D4I4"1426"
15D10I19"struct A1189 *A1427"
21D12I10"A13 *A8273"
22D7I6"4 A599"
19D9I7"A4 A599"
21D8I10"Void A9311"
27D2I2"28"
13D12I10"Void A7191"
31D2I2"29"
13D8I10"Void A6080"
25D4I4"9183"
15D10I9"A54 A1430"
21D1I1"V"
6D4I4"1431"
15D10I8"A4 A7475"
30D1I1"2"
12D9I12"UFLAG *A1433"
29D1I1"4"
12D10I8"A4 A1435"
29D2I2"36"
13D1I1"v"
6D4I4"6246"
15D1I1"v"
6D4I4"7809"
21D4I4"1437"
23D2I2"38"
14D10I10"34 A5691()"
19D20
28D2I2"39"
19D4I4"1440"
15D10I12"Void A1441()"
19D17
26D1I1"2"
21D1I1"3"
12D11I10"Void A5773"
30D2I2"44"
13D12I11"A5794 A1445"
21I20"A5794 A1446;
extern "
6D4I4"1447"
21D4I4"3532"
15D12I10"A2 A3526[]"
21I17"A4 A3527;
extern "
6D2I2"14"
21D4I4"1449"
15D10I11"A5794 A1450"
30D1I1"1"
18D4I4"1452"
15D10I8"A4 A9184"
27D4I4"5274"
21D73I6"1453()"
82D19I12"Void A5651()"
28D20I12"Void A5548()"
29D20
26D4I130"3443();
extern Void A6072();
extern Void A1454();
extern Void A3363();
extern Void A1455();
extern Void A1456();
extern Void A5107"
17D89I65"065
{
A67 A1066;
A5794 A1067;
A5794 *A1068;
A17 A1069;
};
extern "
97D44I20"1065 *A1070;
extern "
52D40I53"1065 A1071[];
extern A67 A1072[];
extern Void A6209()"
53D12I85"
{
A79 A547;
A79 A548;
A79 A549;
A79 A6232;
A79 A5661;
A87 A6233;
A87 A5662;
A23 A552"
23D16I24"53 *A554, *A555, *A6234,"
21D1I12"63, *A557;
}"
11D29I14"93
{
A17 A8274"
34D35I21"98 A8275;
A8198 A8276"
50D44I10"8277[1];
}"
54D41I6"561
{
"
56D4I165"62;
struct A561 *A563;
A40 A564;
A40 A565;
A81 A566;
A58 A567;
A42 A568;
A68 A569;
struct A147 A570;
A17 A571;
A24 A572;
A61 A573;
A96 *A574;
struct A1537 * A7443;
}"
13D11I8"A81 A575"
20D9I17"struct A561 *A576"
28D1I1"7"
18D2I1"5"
22D2I2"79"
19D3I4"8278"
22D1I1"0"
20D1I1"1"
19D3I2"82"
22D9I1"3"
20D7I10"Void A5664"
18D19
27I65"4(), A585();
extern A4 A586();
extern A4 A5665();
extern Void A58"
1854I50"9136
{
struct A9136 *A9137; A17 A9138; };
struct A"
109D9I19"struct A9136 *A9139"
18D18
26D9I10"9136 A9140"
19D9I8"58 A7273"
18D4I3"A17"
9D3I1"4"
12D11I17"struct A588 A1719"
20D4I2"A2"
9D3I3"6[]"
20D2I2"77"
13D10I9"A89 A1978"
29D2I2"79"
19D4I4"1980"
21D4I4"7274"
24D1I1"1"
13D8I7"4 A9185"
19D18I8"A4 A9186"
35D4I4"5897"
24D1I1"2"
12D3I4"Void"
8D1I1"3"
12D10I9"A72 A1984"
21D10I18"struct A561 *A1985"
27D3I3"914"
23D2I2"86"
21D2I2"87"
13D27
33D26I4"9142"
37D10I9"A78 A1988"
27D4I4"1990"
21D4I4"1989"
21D4I4"1991"
15D8I10"Void A1992"
25D4I4"1993"
15I27"struct A144 *A7824; extern "
6D4I26"5553();
struct A147 *A7825"
23D2I2"26"
19D4I4"7827"
21D64I6"7828()"
73D8I10"Void A7829"
20D7I7"4 A7830"
18D9I12"Void A8412()"
18D9I12"Void A7831()"
18D9I12"Void A7832()"
18D19I12"Void A8413()"
28I14"Void A8414();
"
8D20I7"1457
{
"
26D12I4"58;
"
18D3I25"59;
A4 A1460;
A9 A1461;
}"
12D19I10"A9 A1461()"
28D18I10"A9 A1462()"
28D1I1"9"
6D1I1"3"
11D19I8"A4 A1464"
30D9I7"4 A1465"
19D20
28D11I10"83 **A5078"
21D9I18"struct A83 **A5079"
25D2I2"66"
13D9I7"4 A1467"
19D3I11"struct A144"
8D2I2"68"
12D11I18"struct A144 *A7476"
21D9I7"4 A1469"
19D10I19"struct A640 **A3651"
20D9I18"struct A640 **A365"
21D8I9"17 *A1470"
19D8I9"68 *A1471"
26D13I14"640 **A1472 ;
"
22D7I7"3 A1473"
18D11I7"4 A1474"
22D7I9"13 *A1475"
18D7I9"13 *A1476"
18D7I9"13 *A1477"
18D4I2"53"
9D2I2"78"
13D2I2"68"
7D2I2"79"
12D9I3"A17"
15D1I1"0"
12D1I2"57"
6D1I1"1"
11I19"A57 A3660 ;
extern "
17D3I4"5 ; "
11D10I8"57 A1482"
22D6I10"036 *A1483"
17D10I7"4 A1484"
20D18I8"A4 A8214"
29D8I7"4 A1485"
19D7I11"9036 *A1486"
18D7I9"81 *A1487"
17D8I16"const A81 *A1488"
19D7I7"6 A1489"
25D11I10"144 *A7276"
21D4I4"9036"
9D1I1"0"
11D17I8"A9 A1491"
27I21"A9036 A1492 ;
extern "
8D9I10"640 *A1493"
19D17I9"A63 A1494"
27D17I8"A4 A1495"
28D8I7"4 A1496"
22D4I4"5825"
18D4I5"1497 "
21D8I9"640 *A149"
19D12I12"A5794 A1499 "
21D12I18"struct A83 *A1500 "
21D10I18"struct A83 *A1501 "
19D13I18"struct A83 *A1502 "
22D10I18"struct A83 *A5080 "
20D9I9"53 A1503 "
18D12I9"A4 A1504 "
21D12I8"A4 A6247"
21I27"struct A83 *A6248 ;
extern "
6D4I4"9040"
23D2I2"05"
14D7I7"4 A1506"
18D10I11"A5794 A1507"
21D9I10"Void A7451"
20D10I8"A4 A7833"
22D8I7"4 A6249"
25D4I4"6250"
23D2I2"08"
13D8I10"Void A1509"
28D1I1"0"
12D4I2"A6"
9D1I1"1"
21D1I1"2"
12D10I9"A68 A1513"
21D7I9"Void A151"
20I203"81 A5692();
extern Void A8215();
extern Void A1515();
extern A4 A1516();
extern Void A1517();
extern Void A1518();
extern Void A1519();
extern Void A1520();
extern A4 A3738();
extern A4 A7834();
extern A"
561D1I1" "
11D1I1" "
11D1I1" "
10D1I1" "
10D1I1" "
10D1I1" "
848D4I4"9082"
15D19I10"Void A9083"
30D19I10"Void A9084"
30I21"Void A3863();
extern "
17D2I2"89"
13D10I19"struct A1537 *A1590"
21D10I19"struct A1537 *A1591"
27D2I2"71"
21D4I4"1592"
21D4I4"1593"
15D9I10"Void A7841"
29D1I1"2"
12D4I3"A74"
9D1I1"7"
18D4I4"7843"
21D4I4"8218"
15D9I10"Void A8219"
29D1I1"5"
13I1"7"
6D1I1"6"
12D3I4"Void"
8D1I1"7"
12D10I8"A4 A7848"
21D10I9"A74 A7849"
21D1I1"V"
8D24I4"94()"
33D9I4"void"
14D1I3"1()"
10D4I4"void"
9D9I17"2();
typedef A22*"
14I57"3;
extern const A51 A1524;
extern long A1525;
struct A152"
1445D10I8"A4 A9085"
27D4I4"3763"
15D9I10"Void A8835"
21D2I2"35"
7D1I3"4()"
10D11I3"A58"
16D1I1"5"
10D2I11"struct A147"
7D3I1"6"
12I19"A4 A3767();
extern "
2788D2I4"9070"
433D8I10"Void A9086"
19D9I9"A74 A9087"
28D1I1"6"
12D8I9"Void A737"
19D9I8"A4 A4551"
20D9I9"Void A738"
25D3I4"4724"
14D10I8"A58 A741"
29D1I2"77"
20D1I1"3"
18D4I3"744"
15I21"Void A8202();
extern "
1326D1I1" "
15D1I1" "
11D1I1" "
2390D2I4"9070"
215D2I4"9070"
12D1I2"72"
52D4I4"9088"
4416D2I4"9070"
1282D2I4"9070"
472D2I4"9070"
51D2I4"9070"
15D2I4"9070"
168D2I4"9070"
51D2I4"9070"
15D2I4"9070"
4956D2I9"(A77) 0x0"
168D5I5"
) | "
2612D2I4"9070"
49D2I4"9070"
214I6"(A49)("
6D1I8"),(A49)("
7D1I11"),(size_t)("
14I1")"
246D2I4"9070"
419D3I6"size_t"
3714D2I9"(A77) 0x0"
60D2I9"(A77) 0x0"
1099D2I4"9070"
45D2I4"9070"
85D2I4"9070"
2145D2I4"9070"
819D3I6"size_t"
822D2I4"9070"
59D2I4"9070"
4284D4I4"9094"
19D4I4"9095"
21D4I4"9096"
21D4I4"9097"
19D4I4"9098"
235D4I4"9099"
343I6"(A72) "
8D7I13"9099) / (A72)"
57D2I4"9070"
19D1
13D2I4"9070"
95D1
28D2I4"9070"
19D1
7D1
7D1
7D1
93D2I4"9070"
196D2I4"9070"
58D2I4"9070"
58D2I4"9070"
55D2I4"9070"
59D2I4"9070"
59D2I4"9070"
57D2I4"9070"
58D2I4"9070"
59D2I4"9070"
57D2I4"9070"
56D2I4"9070"
64D2I4"9070"
60D2I4"9070"
60D2I4"9070"
63D2I4"9070"
26I3"roj"
34D2I4"9070"
3906I6"(A72) "
16I6"(A72) "
34I6"(A72) "
16I6"(A72) "
8D2I4"9070"
128I6"(A72) "
16I6"(A72) "
201I6"(A72) "
16I6"(A72) "
34I6"(A72) "
16I6"(A72) "
8D2I4"9070"
150I6"(A72) "
16I6"(A72) "
34I6"(A72) "
16I6"(A72) "
8D2I4"9070"
25I1"2"
11I6"(A72) "
16I6"(A72) "
1206D38I58""",
};
const A7859*
A7993(A1737, A2026, A2006)
A5794 A1737"
49D7I90"854 *A2026;
A72 A2006;
{register A7 A1732, A1730;
register A72 A2085, A2024, A2025;
A4 A20"
12D86I33"2024 = 0;
A2085 = 0;
A2025 = A200"
91D71I14"009 = (A4) 0;
"
76D2I21":if( A2025 > A2024 ) "
14D44I10"goto A1713"
50D51I30"2:
A2085 = (A2024 + A2025) / 2"
56D23I44"30 = (A7) (A1737[0] - A2026[A2085].A7855[0])"
28D152I4"32 ="
157D2I3"0 ?"
7D13I43"0 : (A6) strcmp(A1737, A2026[A2085].A7855);"
24D3
13D2I2"14"
12D2I2"15"
7D3I7"14:
if("
9D4I7" > 0 ) "
12D2I14"16;
goto A1717"
7D32I23"16: A2024 = A2085 + 1;
"
41D1I1"0"
6D8I18"17: A2025 = A2085;"
15D6I3" ;
"
14D2I2"21"
7D4I30"15: A2009 = (A4) 1; goto A1713"
9D33I24"21: ;
goto A1711;
A1713:"
38D104I76"A2009 ) return A2026 + A2085;
return 0;
}
static A5794
A7939(A80)
A81 A80;
{"
110D19I212"80->A127 & (A27) 0x4000000 )
return A7985[1];
if( A80->A127 & (A27) 0x80 )
return A7985[2];
return A7985[3];
}
static A5794
A7940(A80)
A81 A80;
{
if( A80->A168.A166 == (A39) 10 )
return A7984[1];
if( (A1309 > 0) "
29D2I2"11"
12D2I2"12"
7D11I129"11:
if( A80->A160 )
return A7984[2];
if( A80->A161 || A80->A7145 == A431 ||
A80->A7145 == A433 )
return A7984[3];
return A7984[4]"
21D2I2"13"
7D120I3"12:"
125D56I62"A80->A127 & (A27) 0x4000000 )
return A7984[4];
return A7984[5]"
61D17I132"13: ;
}
static A5794
A7994( A4828, A4157 )
struct A7966 *A4828;
A5794 A4157;
{
static struct A7973 A7995={0};
A7873 *A1868 = A4828->"
22D78I59";
A7859 *A1859 = A1868->A7868;
A72 A1750;
A4 A3408 = (A4) 1"
84D31I12"!A7995.A7974"
42D2I2"11"
12D2I2"12"
7D2I2"11"
7D15I57"95.A7974 = A1670( (A72) ( M_NAME+2), (A72) ( sizeof(A2) )"
20D52I21"7995.A7975 = M_NAME+2"
57D7I52"12:
A7995.A7974[0] = '\0';
A7995.A7976 = 0;
A4157+=2"
12D2I13"50 = 0;
A1715"
9D54I19"1750 < A1868->A7869"
64D2I2"13"
12D2I2"14"
7D11I20"16: ++A1750, ++A1859"
21D2I2"15"
7D2I2"13"
8D21I70"A1859->A7856 & (A34)0x100 &&
A4828->A7972[A1859->A7858] & A1859->A7857"
32D16I2"17"
26D2I2"20"
7D23I39"17:
if( !A3408 ) goto A1721;
goto A1722"
28D32I128"21:
A7945( &A7995, A4157 );
A1722:
A7945( &A7995, A1859->A7855 );
A3408 = (A4) 0;
A1720: ;
goto A1716;
A1714:
return A7995.A7974"
43D33I58"A5794
A7941( A1859, A4828 )
A34 A1859;
struct A7966 *A4828"
38D89I250"5794 A2309;
A63 A1948 = A4828->A7968.A7969;
switch( A1859 )
{
case (A34)1u:
A2309 = A976( (A6) A1948 );
goto A1711;
case (A34)2u:
A2309 = A663( ((struct A633 *) A1206[A1948]) ,(A4) 0);
goto A1711;
default:
A865(1235);
A2309 = "";
goto A1711;
}
A1711:"
97D21I5"A2309"
32D160I70"A5794
A7942( A1859, A4828 )
A34 A1859;
struct A7966 *A4828;
{
A81 A173"
165D13I100"4828->A7968.A7971;
A5794 A2309;
switch( A1859 )
{
case (A34) 1u:
A2309 = A976( (A6) A1737->A131.A116"
26D87I31"1;
case (A34) 2u:
A2309 = A979("
92D119I16"7->A131.A115 );
"
131I36"case (A34) 3u:
A2309 = A1737->A129;
"
9D9I31"1;
case (A34) 4u:
A2309 = A979("
14D3I14"7->A168.A165 )"
14D3I41"1;
default:
A865(1238);
A2309 = "";
goto "
8D30I43";
}
A1711:
return A2309;
}
static A5794
A79"
35D95I79"1859, A4828 )
A34 A1859;
struct A7966 *A4828;
{
A81 A1737 = A4828->A7968.A7971;"
103D172I77"2309;
switch( A1859 )
{
case (A34) 1u:
A2309 = A976( (A6) A1737->A131.A116 );"
182D48I52"1;
case (A34) 3u:
A2309 = A979( A1737->A131.A115 );
"
56D2I43"11;
case (A34) 5u:
A2309 = A918( A1737, 0 )"
12D44I42"11;
case (A34) 4u:
A2309 = A7939( A1737 );"
53D31I43"11;
case (A34) 6u:
A2309 = A7940( A1737 );
"
39D2I52"11;
case (A34) 2u:
A2309 = A7983[ A1737->A168.A166 ]"
12D91I48"11;
case (A34) 7u:
A2309 = A976( (A6) A1737->A13"
96D9
18D2I49"1;
default:
A865(1237);
A2309 = "";
goto A1711;
}"
7D124I26"1:
return A2309;
}
static "
129D6I32"
A7944( A1859, A4828 )
A34 A1859"
17D134I95"966 *A4828;
{
A58 A1740 = A4828->A7968.A7970;
A5794 A2309;
switch( A1859 )
{
case (A34) 1u:
A23"
139D8I25"A976( (A6) A1740 );
goto "
13D21I55";
case (A34) 2u:
A2309 = A1153( A1740, (A6230) 0x04 );
"
30D1I48"1;
case (A34) 3u:
A2309 = A7986[ A492( A1740 ) ]"
12D2I49"1;
default:
A865(1236);
A2309 = "";
goto A1711;
}"
7D46I45"1:
return A2309;
}
static Void
A7945( A6162, "
51D37I29" )
struct A7973 *A6162;
A5794"
42D24I37"7;
{
const A72 A7996 = 1000000;
if( !"
29D57I9" ) return"
63D16I36"1:if( *A1737 && A6162->A7975 < A7996"
28D1I1"2"
12D1I1"3"
7D22I79"2:
A6162->A7974[A6162->A7976++] = *A1737++;
if( A6162->A7976 == A6162->A7975 ) "
30D2I14"14;
goto A1715"
8D16I103"4:
A6162->A7974 = A1027( A6162->A7974,
A6162->A7975, (A72)1,
A6162->A7975*2, (A4) 1);
A6162->A7975 *= 2"
21D2I2"15"
14D1I1"1"
8D101I36"3:
A6162->A7974[A6162->A7976] = '\0'"
113D67I8"4
A9094("
72D4I64"9 )
A7873 *A7989;
{
A2 A2096[MAXFNM+1];
A5794 A1841; FILE* A7320"
10D25I24"*A7989->A7863 == '\0' ) "
32D63I7"(A4) 0;"
68D28I54"*A7989->A7864 == '\0' ) goto A1711;
goto A1712;
A1711:"
36D9I14"(A4) 0;
A1712:"
14D10I21"A7320 = A7951( A7989 "
23D1I1"3"
12D1I1"4"
7D18I54"3:
A7989->A7866 |= (A17) 0x04;
(void) fclose( A7320 );"
26D114I6"(A4) 0"
120D36I173"4:
A1667(A943);
A1841 = A866( "[ program_info() was given 'output_prefix="
"\"$s\"', but \"$s\" could not be opened for writing. ]",
A7981, A2096, NULL );
A897( 72, A1841 );"
44D34I6"(A4) 1"
46D162I11"4
A9095()
{"
167D4I4"7614"
12D1I1"0"
11D8I2"81"
43D29I69"897( 72, "[ +program_info() needs the argument:"
" output_prefix=PATH"
34D25I10"_PREFIX ]""
31D20I24"614 = (A4) 1;
goto A1713"
28D49I36" if( !A7878 ) goto A1714;
goto A1715"
54D2I15"14:
{
A72 A1732"
8D19I27"struct A7966 A2309;
A7873 *"
24D31I19";
A2 A1829[ARG_LEN]"
36D39I2"20"
47D69I11"732 < A7982"
80D1I1"6"
11D2I2"17"
7D17I13"21: ++A1732;
"
26D13I1"0"
18D25I28"16:
A1868 = (&A7877[(A1732)]"
30D25I3"868"
30D1I65"66 &= ~(A17) 0x04;
A2309.A7967 = A1868;
A9097( A1829, A1868->A786"
7D83I56"1868->A7864 = A1076( A1344, A1829 );
A7955( &A2309 );
if"
88D75I1"6"
80D71I55"864 && *A1868->A7864 &&
!(A1868->A7866 & (A17) 0x02) ) "
79D71I2"22"
81D81I13"23;
A1722:
{
"
86D65I12" A7997;
A799"
70D3I39"866( "-program_info( $s=\"$s\" )",
A186"
8D30I174"862, A1868->A7864, NULL );
A887( 686,
A7997,
"missing field-specifier in a non-empty "
"format string [No data will be "
"generated for this category.]" );
}
A1723:
if( A9094"
35D61I7"68 ) ) "
69D51I2"25"
61D38I34"26;
A1725:
A7614 = (A4) 1;
A1726: "
48D53I41"21;
A1717: ;
}
A1715:
A1713:
if( A7614 ) "
61D35I2"27"
45D11I34"66;
A1727:
sys_exit( 1, 0 );
A1766"
20D16I109"(A4) 1;
}
Void
A9088( A3491, A3490 )
A4 A3491;
A48 *A3490;
{
A6 A1732;
A48 A7990[30+1];
A2 A7991[ARG_LEN+1];
"
21D6I49" A1835, A1818;
A9 A7992 = 0;
A1732 = 1;
A1713:
if"
11D49I49"35 = A3490[A1732]) goto A1711;
goto A1712;
A1714:"
54D107I3"2++"
118D57I3"3;
"
62D43I16":
if( !*A1835 ) "
52D42I73"4;
A243( A7991, A1835, ARG_LEN );
if( A994( A7990, 30, A7991, 0 ) > 30 ) "
51D40I1"5"
51D172I2"6;"
177D26I5"5:
{
"
31D162I174" A7102;
A7102 = A866( "[ Too many sub options in: '$s'."
"(Try splitting them into separate "
"-program_info() options.) ]",
A1835, NULL, NULL );
A884( 72, A7102 );
return;
}"
172D88I15"7;
A1716:
A1818"
94D21I27"90[0];
if( *A1818 == '-' ) "
29D35I2"20"
45D108I10"21;
A1720:"
113D32I40"2 = (A9)(A15)('-'); ++A1818; 
goto A1722"
37D3I4"21: "
10D27I10"818 == '+'"
38D2I2"23"
12D2I2"25"
7D44I116"23: A7992 = (A9)(A15)('+'); ++A1818; 
A1725:
A1722:
A9096( A7992, A1835, A1818, A7990 );
A1717: ;
goto A1714;
A1712:"
50D27I15"3491 && A9095()"
38D2I2"26"
12D2I2"27"
7D77I11"26:
A7878 ="
84D20
25D58I4"27: "
69D7I9"Void
A909"
13D39I34"92, A3518, A1818, A1872 )
A9 A7992"
48D17I107"3518, A1818;
A48 *A1872;
{
A34 A1875 = A986( A1818, A9099, A7962 );
A4 A7998 = (A4) 0;
A48 A1835 = A1872[1]"
23D64I6"!A1875"
98D174I20"{
A5794 A7102;
A7102"
186D26I70"Unrecognized sub-option name: '$s'."
"(Valid sub-option names are: "
""
39D56I88", format_foo, and "
"filter_foo where 'foo' is some "
"category of program information.)"
62D11I4"1818"
17I6", NULL"
6D2I2"84"
9D4I4"7102"
14D49I10";
}
A1712:"
54D6I27"A1875 & 0x100 ||
A1875 == 5"
18D1I1"3"
12D1I1"4"
7D108I25"3:
if( A1835 && *A1835 ) "
117D1I13"5;
goto A1716"
7D38I20"5:
A6080( A1835, 1 )"
44D44I15"6:
if( A1835 &&"
49D23I22"35 ) goto A1717;
goto "
28D38I2";
"
43D35
40D1I32"35 = A1076( A1344, A1835 );
A799"
6D152I25"A4) 1;
goto A1721;
A1720:"
157D60I19"strchr( A3518, '=' "
95D7I143"A7998 = (A4) 1;
A1723:
A1835 = "";
A1721:
if( A1875 & 0x100 ) goto A1725;
goto A1726;
A1725:
{
A7873 *A1868 = (&A7877[( A1875 & ~0x100 )]);
if("
12D46I34"8 ) goto A1727;
goto A1766;
A1727:"
58D3I68"5 = A1835;
A1766:
if( A7992 == '-' ) goto A1767;
goto A1768;
A1767:
"
14D170I18"6 &= ~(A17) 0x01;
"
178D14I2"69"
19D17I29"68:
A1868->A7866 |= (A17) 0x0"
23D5I7"69: ;
}"
14D2I2"70"
7D22I4"26: "
27D4I9"1875 == 5"
15D2I2"71"
12D2I2"72"
7D20I38"71:
if( A7998 ) goto A1773;
goto A1774"
25D60I68"73:
A7981 = A1835;
A1774: ;
A1772: ;
A1770: ;
goto A1775;
A1714: if("
65D45I42"5 & 0x200 ) goto A1776;
goto A1777;
A1776:"
55D9I44"59 = A1875 & ~0x200;
A7873 *A1868 = (&A7877["
14D59I36"59 )]);
const A7859 *A3858;
A6 A1732"
65D6I12"A1868->A7871"
17D2I2"78"
12D2I2"79"
7D266I19"78:
A1732 = 1;
A178"
276D25I17"35 = A1872[A1732]"
35D2I2"80"
12D2I2"81"
7D2I30"83: A1732++;
goto A1782;
A1780"
9D9I14"3858 = A7993( "
14I30", A1868->A7868, A1868->A7869 )"
11D2I2"84"
12D2I2"85"
7D28I2"84"
35D14I11"7992 == '+'"
25D2I2"86"
12D2I2"87"
7D2I2"86"
7D42I39"68->A7871[A3858->A7858] |= A3858->A7857"
52D2I2"88"
7D28I20"87: if( A7992 == '-'"
38D3I3"889"
12D33I10"890;
A1889"
38D36I42"68->A7871[A3858->A7858] &= ~A3858->A7857;
"
43D22I10"891;
A1890"
27D56I155"5794 A7102;
A7102 = A866( "[ Sub-option '$s' must be "
"preceded by either '+' "
"or '-'. ]" ,
A3518, NULL, NULL );
A884( 72, A7102 );
}
A1891: ;
A1788: ;
"
63D15I3"892"
20D19I139"85:
{
A5794 A7102;
A7102 = A866( "[ Unrecognized flag name: '$s'.  "
"(For a list of valid flag "
"names, refer to the documentation.) ]",
"
24I56", NULL, NULL );
A884( 72, A7102 );
}
A1892: ;
goto A1783"
5D23I17"81: ;
A1779: ;
}
"
30D15I3"893"
20D43I23"77: A865(1239);
A1893: "
48D37I2"75"
43D10I68"static Void
A9097( A1734, A2925 )
A48 A1734;
A5794 A2925;
{
A9 A1833"
15D4I3"11:"
11D7I24"33 = (A9)(A15)(*A2925++)"
18D2I2"12"
12D2I2"13"
7D2I2"12"
9D4I22"1833 == '\\' && *A2925"
15D2I2"14"
12D2I2"15"
7D11I40"14:
A1833 = (A9)(A15)(*A2925++);
switch("
16D30I29"3 )
{
case 'q': A1833 = '"'; "
38D30I28"16;
case '\\': A1833 = '\\';"
39D4I27"16;
case 's': A1833 = ' '; "
12D125I29"16;
case 'a': A1833 = '\007';"
134D4I28"16;
case 'b': A1833 = '\b'; "
12D32I13"16;
case 'f':"
37D17I9"3 = '\f';"
26D4I28"16;
case 'n': A1833 = '\n'; "
12D20I28"16;
case 't': A1833 = '\t'; "
28D9I22"16;
case 'X':
case 'x'"
16D52I25"9098( &A2925, &A1833 ) )
"
60D2I35"16;
default:
*A1734++ = (A2) ('\\')"
12D2I13"16;
}
A1716: "
7D23I29"15:
*A1734++ = (A2) (A1833);
"
31D14I2"11"
19D4I45"13:
*A1734 = '\0';
}
static A4
A9098( A1737, "
9D108I21" )
A5794 *A1737;
A9 *"
113D174I71";
{
A9 A7928 = (A9)(A15)( (*A1737)[0] ),
A7999 = (A9)(A15)( (*A1737)[1]"
179D38I174"7928 = toupper( A7928) ;
A7999 = toupper( A7999) ;
if( ( isdigit(A7928) || ('A' <= (A7928) && (A7928) <= 'F') ) && ( isdigit(A7999) || ('A' <= (A7999) && (A7999) <= 'F') ) ) "
45D2I14"711;
goto A171"
8D190I25"11:
if( isdigit(A7928) ) "
198D2I14"13;
goto A1714"
7D4I28"13:
A7928 -= '0';
goto A1715"
9D18I21"14: A7928 -= 'A' + 10"
23D23I62"15:
A7928 *= 0x10;
if( isdigit(A7999) ) goto A1716;
goto A1717"
28D76I28"16:
A7999 -= '0';
goto A1720"
82D58I20"7: A7999 -= 'A' + 10"
63D34I54"20:
*A1868 = A7928 + A7999;
*A1737+=2;
return (A4) 1;
"
42D14I2"21"
20D8I9"2:
*A1868"
21D51I158" *A1737[0] );
(*A1737)++;
return (A4) 0;
A1721: ;
}
static Void
A7953( A7989 )
A7873 *A7989;
{
if( A7989->A7866 & (A17) 0x01 &&
!(A7989->A7866 & (A17) 0x08) )"
61D28I3"1;
"
37D165I78"2;
A1711:
A7989->A7866 |= (A17) 0x08;
A1666( A7989->A7865 );
A1664( (A9)(A15)("
170D158I5" ) );"
163D69I3"2: "
80D2I4"Void"
7D53I109"4( A80 )
A81 A80;
{
struct A7966 A2309;
A2309.A7967 = (&A7877[(3u)]);
A2309.A7968.A7971 = A80;
A2309.A7972[0]"
59D28I34"070) ( A80->A127 );
A2309.A7972[1]"
34D19I95"070) ( A80->A128);
A2309.A7972[2] = (A9070) ( A80->A5796);
A2309.A7972[3] = (A9070) ( A80->A163"
26D21I116"55( &A2309 );
}
Void
A7874()
{
A63 A4677;
A58 A1740;
struct A7966 A2309;
A57 A7987;
FILE *A7988;
if( !A7878 ) return"
26D21I70"87 = A1649;
A7988 = A1657;
A1649 = A1656;
A2309.A7967 = (&A7877[(0u)])"
28D112I27"A1657 = A7952( A2309.A7967 "
149D43I37"A7953( A2309.A7967 );
A4677 = (A63) 1"
49D17I29"5:
if(
A4677 <= A1224->A991) "
26D3I8"3;
goto "
8D19
25D39I12"6:
++A4677;
"
48D13I1"5"
19D15I102"3:
A2309.A7968.A7969 = A4677;
A2309.A7972[0] = ((struct A633 *) A1206[ A4677 ])->A636;
A7955( &A2309 )"
25D2I2"16"
8D20I18"4: fclose( A1657 )"
25D64I25"17: { A6 A1732; A1732 = 0"
69D62I41"25:
if( A1732 < 4) goto A1722;
goto A1723"
68I111"6: A1732++;
goto A1725;
A1722: (A2309.A7972)[A1732] = 0uL; goto A1726;
A1723: ; } 
A1720:if(0) goto A1717;
A172"
5D44I36"A1712:
A2309.A7967 = (&A7877[(1u)]);"
49D56I30"(A1657 = A7952( A2309.A7967 ) "
68D2I2"27"
12D2I2"66"
7D2I2"27"
7D44I15"53( A2309.A7967"
50D24I7"740 = 1"
29D19I115"69:
if( A1740 <= A1398->A991) goto A1767;
goto A1768;
A1770: ++A1740;
goto A1769;
A1767:
A2309.A7968.A7970 = A1740;"
24D33I4"5( &"
38D1I46" );
goto A1770;
A1768: fclose( A1657 );
A1766:"
32I20"if( (A1657 = A7952( "
10D15I46"7 ) ) ) goto A1771;
goto A1772;
A1771:
A7953( "
24D24I1"6"
31I46"16( A1502, A7954 );
fclose( A1657 );
A1772:
A2"
7D28I41"67 = (&A7877[(2u)]);
if( (A1657 = A7952( "
37D29I47"67 ) ) ) goto A1773;
goto A1774;
A1773:
A7953( "
38D25I2"67"
30D64I18"216( A431, A7957 )"
69D57I49"49 *A2098;
A54 A1732;
A81 A80;
A1732=( 1);
A1777:"
63D4I53"2098 = ( A1389)->A988+ A1732, A1732 <= ( A1389)->A991"
15D2I2"75"
12D2I2"76"
7D8I3"78:"
14I14"++;
goto A1777"
5D12I1"7"
19D20I22"!(A80 = (A81) *A2098) "
30D2I16"78;
A7957( A80 )"
12D2I2"78"
7D23I23"76: ;
}
fclose( A1657 )"
28D30I11"74:
A1649 ="
35D20I39"7;
A1657 = A7988;
}
static Void
A7955( "
25I66" )
struct A7966 *A4828;
{
A5794 A1829, A8000;
A7873 *A7989 = A4828"
5D20I26"67;
A9 A1868;
if( A7878 ) "
29D1I13"1;
goto A1712"
7D6I26"1:
{
A72 A1732;
A1732 = 0;"
11D10I14"5:
if( A1732 <"
21D23I25"72) goto A1713;
goto A171"
29D2I30"16: A1732++;
goto A1715;
A1713"
7D32I78" (A4828->A7972[A1732] & A7989->A7871[A1732]) !=
A4828->A7972[A1732] )
return;
"
41D13I1"6"
18D1I12"14: ;
}
A171"
13D11I35"7989->A7864;
A8000 = A7989->A7864;
"
16D7
12D1I2"
("
7D7I22"= (A9)(A15)( *A1829 ))"
17D2I2"17"
13D1I1"0"
7D15I18"2:
A1829 = A8000;
"
24D13I1"1"
18D8I6"17:
if"
16D19I9"!= '%' ) "
27D4I9"23;
goto "
9D2I9";
A1723:
"
7D14I4"7878"
25D2I2"26"
12D2I2"27"
7D45I2"26"
65D2I2"27"
9D5I2"++"
15D2I2"66"
7D25I7"25: if("
31D22I13"[1] == '%' ) "
30D2I14"67;
goto A1768"
7D21I108"67:
if( A7878 ) goto A1769;
goto A1770;
A1769:A1664( A1868 );
A1770:
A8000 += 2;
goto A1771;
A1768:
A8000 = "
42D22I50";
A1771: ;
A1766: ;
goto A1722;
A1720: ;
}
static "
27I14"
A7956( A4828,"
6I35" )
struct A7966 *A4828;
A5794 A1829"
324I7"((A72) "
15I1")"
15I25"A2 A2080[200];
A6 A1875;
"
591D2I10"
A1875 = s"
11D11I4"2080"
29D1I18"if( A1875 >= 200 )"
14D33I10"goto A1771"
41D8I14"A882(200,90);
"
13I29":A1666( A2080 );
}
goto A1772"
6D20I31"4:
A1868->A7866 |= (A17) 0x02;
"
25I2": "
17D2I45"12:
if( A7878 ) goto A1774;
goto A1775;
A1774"
40D1I1"5"
9D1I1"3"
333I1" "
84I18"&&
A80->A168.A166 "
129D2I4"9070"
38D2I4"9070"
37D2I4"9070"
38D2I4"9070"
84D2I5"FILE*"
7D61I23"1( A7989 )
A7873 *A7989"
66D46I243"2 A2096[MAXFNM+1];
A243( A2096, A7981, MAXFNM );
sg_sfcat( A2096, A7989->A7863, MAXFNM );
return i_fopen( A2096, "w" );
}
static FILE*
A7952( A7989 )
A7873 *A7989;
{
if( A7989->A7867 ) return A7989->A7867;
if( A7989->A7866 & (A17) 0x04 ) goto "
51D65I7";
goto "
70D12I2";
"
17D2I49":
return ( A7989->A7867 = A7951( A7989 ) );
goto "
7D43
49D2I43"2: return NULL;
A1713: ;
}
static A4
A7958("
8D48I2", "
53D4I96", A8005 )
A48 A8001;
A5794 A1829;
A5794 *A8005;
{
A18 A1732 = 0;
A9 A1868 = (A9)(A15)( *A1829 );"
9D57I9"1: A8001["
62D56
111D1I1"1"
17D2I2"11"
7D21I2"13"
37D5I5"-' )
"
13D2I2"14"
12D2I2"15"
7D4I4"14: "
70D2I2"16"
17D2I2"14"
7D2I9"17:
A1715"
43I1" "
10D2I2"20"
12D2I2"21"
7D2I2"20"
70D2I2"22"
17D2I2"20"
7D5I3"23:"
14D2I2"15"
7D11I2"21"
27D1I1"."
13D2I2"25"
12D2I2"26"
7D2I2"25"
15D19I42"++] = (A2) (A1868); A1868 = (A9)(A15)( *++"
24D17I17" ); 
A1727:if(0) "
25D2I2"25"
7D10I27"66:
if( isdigit( A1868) && "
15I57" < M_STRING)
goto A1767;
goto A1768;
A1767: A8001[A1732++"
17D33I23" A1868 = (A9)(A15)( *++"
38D15I15" ); 
A1769:if(0"
25D14I2"67"
20D134I15"0: ; goto A1766"
139D31I92"68: ;
A1726:
if( A1868 == '[' ) goto A1771;
goto A1772;
A1771:
A8001[A1732] = '\0';
*A8005 ="
37D47I96";
return (A4) 1;
goto A1773;
A1772:
A8001[A1732] = (A2) (A1868);
A8001[A1732+1] = '\0';
*A8005 ="
53D36I49"+1;
if( !A7878 ) goto A1774;
goto A1775;
A1774:
{"
43D49I78"A7102;
A7102 = A866( "[ Invalid conversion specifier: $s ]",
A8001, NULL, NULL"
54D10I38"884( 72, A7102 );
}
A1775:
return (A4)"
17D3I24"73: ;
}
static A4
A7959("
9D48I2", "
53D4I163", A3858, A7989, A8006, A8003 )
A48 A4157;
A5794 A1829;
A7859 const **A3858;
A7873 *A7989;
A5794 *A8006;
A4 *A8003;
{
A9 A1868 = (A9)(A15)( *A1829 );
A18 A1732 = 0;"
9D42I26"1: A4157[A1732++] = (A2) ("
48D12I1";"
18D4I72" = (A9)(A15)( *++A1829 ); 
A1712:if(0) goto A1711;
A1713:
if( ( isupper("
10I29") || islower( A1868) || A1868"
1206D2I4"9070"
161D2I4"9070"
241D2I4"9070"
690D2I4"9070"
41D2I4"9070"
1060D3I6"size_t"
1309D1
8I6"(A49)("
6D1I8"),(A49)("
7D1I11"),(size_t)("
9I1")"
1895D80I69"Void
A9179( A1835, A3491 )
A5794 A1835;
A4 A3491;
{
if( A1835 ) goto "
85D15I2";
"
27D42
47D2I205":
{
A9 A1868 = (A9)(A15)(*A1835);
A4 A3514;
extern A67 A3455;
extern A4 A3453;
extern A13 *A3454;
if( ((A1868) == '?' || (char)(A1868) == aoc_quest) || ((A1868) == '*' || (char)(A1868) == aoc_star) ) goto "
7D18I7";
goto "
23D42
48D23I32"3: A3514 = (A4) 1; A3455 = 10000"
34D1I1"5"
7D27I197"4: A3514 = (A4) 0; A3455 = 2000; 
A1715: if( isdigit(A1868) || A3514 ) goto A1716;
goto A1717;
A1716:
A3453 = A3491;
A3454 = A9180;
A1447( A1835, (A4) 1, NULL, 0 );
A1717: ;
}
A1712: ;
}
A66
A5534("
32D25I9"7 )
A13 *"
30D9I3";
{"
19D20I25"7471 A1732=0;
A13 A3230;
"
27D6I12"04=0;
A1711:"
11I1"*"
8D6I22"goto A1712;
goto A1713"
11D68I15"12: ++A1732; ++"
73D22I28"; goto A1711;
A1713:
A3230 ="
31D22I6"A1714:"
27D8I86"(A3230 & 1) ) goto A1715;
goto A1716;
A1715: ++A1804; A3230 >>= 1; goto A1714;
A1716:
"
16D29I5"(A66)"
37D12I40") * A1732 + A1804;
}
Void
A1139( A1737, "
17D46
137D4I8"|= (A13)"
34D8I85"
A1140( A1737, A1875 )
register A13 *A1737;
register A66 A1875;
{
if( !A1737 ) return"
17D12I62"return (A1737[ A1875 / CHARLEN ] & (1 << (A1875 % CHARLEN))) !"
17D13I1"}"
18D40I60"
A1141( A1737, A1875)
register A13 *A1737;
register A66 A187"
45D63I19"if( !A1737 ) return"
68D27I128"37[ A1875 / CHARLEN ] &= ~(1 << (A1875 % CHARLEN));
}
A4 A7281 = (A4) 0;
A5794 A7282 = 0;
Void A7318();
Void A7319();
Void
A7284"
34D7I35" )
A5794 A1835;
{
A4 A1921 = (A4) 0"
15D3I13"835 && *A1835"
15D1I1"1"
12D1I1"2"
7D16I11"1:
{
FILE* "
21D24I11" = i_fopen("
30D20I21", "w" );
if( A1948 ) "
29D3I8"3;
goto "
8I94";
A1713:
(void)fclose(A1948);
A7282 = A1076( A1344, A1835 );
A1921 = (A4) 1;
goto A1715;
A1714"
228D5I6"*A9148"
12D13I3"2 ="
18D7I49"56 ?
&A1657 :
&std_err;
FILE *A9149 = *A9148;
A57"
12I19"2 = A1649;
A48 A732"
48D1
39D1I1"
"
9D5I21"i_fopen( A7282, "w" )"
34D21I6"*A9148"
77D1I1"2"
7D12I20"49;
*A9148 = A7320;
"
17D22
29D1I1"2"
27D3I6"size_t"
854D5I21"*A9148 = A9149;
A1649"
12D15
103D3I6"size_t"
1501D2I9"(A77) 0x0"
352D2I9"(A77) 0x0"
1114D2I9"(A77) 0x0"
8079D2I9"(A77) 0x0"
4736D2I9"(A77) 0x0"
1301D2I9"(A77) 0x0"
381D2I9"(A77) 0x0"
86D2I9"(A77) 0x0"
110D2I9"(A77) 0x0"
599D2I9"(A77) 0x0"
4728D2I4"9070"
2208D2I4"9070"
800D26I5"if( !"
31D14I25" ) goto A1770;
goto A1771"
19D4I28"70:A882(200,111);
goto A1772"
9D4I23"71:
A879( A1839, (A63) "
9D16I21", A1498->A645->A634 )"
21I48"72: ;
A1717: ;
A1715:
A1732++;
} goto A1711;
A17"
134D2I4"9070"
2870D2I4"9070"
13D2I4"9070"
43D2I4"9070"
96D2I4"9070"
476D2I4"9070"
Fa8.c
209D4I7"7 A9235"
18D2I1"9"
12I16"A6 A10;
typedef "
291D20
27D4I8"32 A9069"
14I19"A9069 A24;
typedef "
10D4I2"25"
14D9I13"unsigned A890"
21D6I10"9069 A9150"
17D6I10"9069 A9070"
17D8I8"9070 A27"
18D12I9"A9070 A28"
22I21"A9070 A5793;
typedef "
10D4I2"29"
14D17
26D8I5"A6228"
19D6I8"9070 A30"
25D3I8"long A31"
13I17"A17 A32;
typedef "
11D1I1"3"
11D7I12"unsigned A34"
19D5I5"4 A35"
17D5I5"5 A36"
21D1I1"7"
17D1I1"8"
16D2I2"39"
18D1I1"0"
17D1I1"1"
17D1I1"2"
12D6I6"34 A43"
22D1I1"4"
17D1I1"5"
11D7I7"A42 A46"
17I17"int A47;
typedef "
342D2I4"9236"
17D4I2"63"
19D1I3"577"
18D1I1"4"
16D4I2"65"
20D2I2"19"
18D4I4"8258"
14I19"A54 A7616;
typedef "
138D6I3"A16"
60D13I3"A72"
122D6I5"A9069"
20D6I5"A9069"
1373I69"struct A9304
{
A17 A9305;
A5794 A9306;
};
extern struct A9304 A9307;
"
6D4I4"9308"
14D4I4"9309"
17D1I1"5"
11D4I4"5566"
14D4I4"5567"
14D3I17"7618();
Void A761"
8D13
19D3I17"5569();
Void A915"
8D9I10"Void A9152"
14D17I2"74"
22D1I15"0();
Void A7621"
10I41"6226();
A5794 A6227();
A81 A7622();
A58 A"
460D2I4"9070"
28D2I4"9070"
151I19"struct A114 A9153;
"
1389D2I2"92"
16D6I12"5794 A7637()"
15I16"A4 A202;
extern "
3337D2I4"9070"
159I11"A58 A9238; "
88D2I4"9070"
39D2I4"9070"
367I11"A17 A9071;
"
535I13"A9236 A9239;
"
1098D2I4"9070"
380D7I8"17 A9154"
24D1I1"1"
12D6I7"62 A442"
16I17"A4 A443 ;
extern "
150D3I4"9072"
14D10I9"Void A451"
22D9I9"5794 A452"
21D9I9"9036 A453"
29D1I1"4"
13D12
20D1I1"5"
12D9I22"A315 A456 ;
A5794 A457"
28D1I1"8"
18D4I3"459"
21D3I4"5268"
14D16
24D1I1"0"
12I16"A4 A461;
extern "
8D1I1"2"
12D8I11"Void A463()"
22D4I3"464"
13I18"A58 A8823;
extern "
1037D7I10"Void A9155"
18D9I7"A4 A504"
20I20"Void A505();
extern "
1042D2I4"9070"
1940D8I19"struct A640 * A9310"
24D4I3"663"
15D10I9"A48 A7505"
29D2I2"37"
19D3I4"7176"
14D7I9"Void A664"
22D4I3"665"
16D8I7"4 A4442"
19D6I6"A17 A5"
27D3I2"66"
21D2I3"031"
21D1I1"7"
20D1I1"8"
12I20"Void A669();
extern "
278D3I4"4476"
14D10I17"struct A640 *A675"
27D4I4"7719"
21D4I4"8914"
15D8I12"Void A7720()"
18D7I7"17 A933"
18D8I7"7 A5254"
18D2I2"81"
7D1I1"0"
11D2I2"17"
7D1I1"1"
11D1I2"35"
6D1I1"2"
11D1I2"92"
6D1I1"3"
11D2I1"7"
7D1I1"4"
11D8I7"4 A2145"
18D1I2"68"
6D1I1"6"
13D14I6"*A2147"
24D8I7"4 A2148"
18D7I16"2 A2149[M_TOKEN]"
17D2I2"87"
7D1I1"0"
11D2I1"4"
7D1I1"1"
15D4I4"2152"
14D2I2"36"
7D1I1"3"
11D27I7"35 A826"
38D1I2"17"
6D3I1"4"
13D10I28"7
A2155,
A2156,
A2157,
A6214"
19D4I2"A9"
9D1I1"8"
12D10I9"A17 A8825"
27D3I3"215"
15D3I4"Void"
8D1I1"0"
18D4I4"8209"
23D1I1"1"
12D3I4"Void"
8D1I1"2"
12D10I9"A35 A2163"
29D1I1"4"
12D5I4"Void"
10D1I1"0"
12D9I8"A35 A216"
22D7I10"9036 A8211"
24D4I4"5255"
15D4I2"A4"
9D11I16"6();
extern Void"
16I37"7();
extern Void A2168();
struct A216"
465I42"struct A9073
{
A48 A9074;
A9069 A9075;
};
"
422D6I7"8 A9076"
17D9I8"A42 A982"
20D8I9"long A983"
24D4I3"984"
16D8I8"87 A6039"
20D8I8"61 A7724"
19D9I9"A92 A7260"
20D8I9"long A985"
24D4I3"986"
16D9I8"34 A5670"
20I21"A5794 A987();
extern "
1045I7"9129,
A"
44D4I4"9156"
11I42"9157,
A9158,
A9159,
A9160,
A9161,
A8639,
A"
21D10I2"91"
15D2I2"91"
7I29"9164,
A6176, 
A7062,
A7063,
A"
91I21"9240,
A9241,
A9130,
A"
21I28"9165,
A9166,
A9167,
A9168,
A"
28I14"9292,
A9169,
A"
92I42"9242,
A9243,
A9131,
A9132,
A9133,
A9134,
A"
71I7"9170,
A"
307D4I4"9171"
21I42"9244();
extern Void A8266();
extern Void A"
8I80"extern Void A9172();
extern A4 A9173();
extern A4 A9174();
extern Void A9175();
"
746D9I7"4 A9176"
21D7I9"5794 A868"
19D6I6"7 A598"
25D1I1"0"
19D1I1"1"
13D10I7"61 A872"
22D7I10"5794 A6037"
19D10I7"61 A873"
22D7I10"5794 A8589"
20D5I6"8 A874"
16D9I7"A4 A875"
28D1I1"6"
20D1I1"7"
20D1I1"8"
19D2I2"79"
19D4I3"880"
21D4I4"6172"
21D3I4"9293"
20D4I4"9177"
21D4I4"8787"
23D1I1"1"
20D1I2"29"
18D4I4"7262"
23D1I1"2"
20D1I1"3"
20D2I2"48"
21D1I1"4"
20D1I1"5"
18D3I4"5667"
22D1I1"6"
19D2I2"87"
20D2I2"88"
20D2I2"89"
19D4I3"890"
21D4I3"891"
21D4I3"892"
21D4I4"7745"
24D1I1"6"
21D1I1"7"
20I1"4"
18D3I4"7748"
20D4I4"7749"
21D4I3"893"
23D1I1"4"
18D4I4"1857"
22D3I3"958"
22D1I1"5"
19D3I3"061"
20D3I4"5821"
20D4I3"896"
21D3I4"7507"
20D4I3"897"
21D4I4"5981"
23D1I1"8"
19D3I3"750"
20D3I4"8212"
20D3I3"899"
20D3I4"7177"
22D1I1"0"
18D4I3"901"
23D1I1"2"
20D1I1"3"
18D3I4"8944"
22D1I1"4"
18D4I3"905"
21D3I3"907"
21D4I4"9078"
23D1I1"7"
18D3I4"5077"
20D3I4"8267"
20D3I4"8830"
14D7I9"Void A908"
25D2I2"09"
13D9I9"Void A910"
28D1I1"1"
12D9I7"A4 A912"
20D16
24D1I1"3"
14D8I7"4 A5431"
19D11I9"Void A914"
22D10I9"Void A915"
22D11I6"7 A916"
27D2I2"17"
13D9I10"A5794 A918"
27D3I4"1739"
15D6I9"5794 A919"
24D4I3"920"
15D9I9"Void A921"
26D4I3"922"
15D20I14"A5794 A923();
"
31D4I3"924"
16D7I10"5794 A7263"
19D8I8"61 A5668"
19D7I12"Void A5669()"
16D18
26D13I12"7734 A7751; "
21D7I7"4 A7752"
18D18I10"A4 A5914()"
28D6I10"861 A926()"
16D8I6"4 A927"
18D6I8"4 A928()"
15D9I19"struct A849 *A929()"
19D6I9"61 A930()"
16D8I12"9236 A9245()"
18D6I12"9236 A9246()"
15D9I12"Void A9247()"
18D7I18"struct A144 *A5050"
17D8I6"7 A931"
18D6I8"61 *A932"
16D8I6"7 A933"
21D7I7"*A934;
"
14D18I7"A7 A935"
28D7I8"61 *A936"
16D18I7"A7 A937"
27D18I9"A61 *A938"
27D18I7"A7 A939"
28D9I8"61 *A940"
19D9I6"7 A941"
19D9I8"61 *A942"
19D12I10"61 A6038; "
19D11I18"struct A144 *A1696"
23D8I5" A943"
18D10I7"7 A9294"
19D11I18"struct A144 *A7178"
20D17
26D7I8"44 *A717"
17D7I18"struct A144 *A5432"
17D6I9"5794 A944"
15D17I10"A5794 A945"
26D20I12"A5794 A946;
"
27D4I5"A5794"
9D3I1"4"
19D6I4"7180"
15D12I11"A5794 A7227"
21D12I11"A5794 A7181"
22D7I10"5794 A5510"
17D8I7"68 A948"
17D18
26D10I9"114 *A949"
20D7I6"7 A950"
17D7I6"4 A951"
16D10I17"struct A114 *A952"
19D13I20"struct A144 *A7265; "
27D3I3"266"
15D7I10"5794 A1689"
24D4I4"7753"
15D18I10"Void A7754"
30D10I7"6 A1022"
20D10I8"81 A5511"
19D12I9"A81 A8770"
21D12I18"struct A561 *A1023"
21D12I8"A4 A1024"
22D10I7"7 A1025"
19D18I8"A4 A1026"
29D18I9"A49 A1027"
29D10I9"Void A775"
22D10I8"A4 A1028"
27D15I8"1029();
"
21D4I31"9079();
A48 A9080();
Void A9081"
15D21
38D1I1"0"
13D7I8"17 A1031"
18D18I9"A79 A1032"
35D4I4"5671"
15D8I10"Void A5672"
19D9I10"Void A8401"
21D8I8"17 A5512"
19D10I18"struct A561 *A1033"
21D9I10"Void A9135"
20D9I18"struct A561 *A1034"
21D7I10"5794 A1035"
18D47I10"Void A2317"
58D9I10"Void A5673"
20D9I10"Void A1036"
20D9I10"Void A1037"
20D11I18"struct A561 *A1038"
22D8I6"A4 A56"
21D9I18"struct A561 *A1039"
20D11I10"Void A7182"
22D18I10"A4 A7183()"
27D10I9"A58 A8268"
22D7I28"78 A1040();
extern Void A775"
12D6I49"extern A81 A1041();
extern A81 A7508();
extern A4"
11D3I49"7();
extern A5794 A8590();
struct A7758 *A7759();"
12D51I3"0()"
60D18I11"A78 A1042()"
28D8I10"78 A5271()"
18D8I10"78 A1043()"
18D8I12"5972 A1044()"
17D9I12"Void A2274()"
18D17I42"A54 A5433();
extern A9036 A9039();
extern "
26D106I9"44 *A5434"
116D7I12"9150 A9178()"
16D13I32"Void A7761();
extern A48 A7906()"
23D31I63"7758
{
A40 A7762;
A87 A7763, A7764;
A17 A7765, A7766;
A67 A7767"
43D21
29D11I10"7758 A7768"
20D79I9"A87 A7769"
88D12I9"A87 A7770"
21D12I9"A88 A7771"
21D12I9"A10 A7772"
21D43I17"const A88 A7773;
"
52D19I43"045
{
A18 A1046;
A72 A1047;
A7470 A1048;
A3"
24D2I58"49;
};
struct A1050
{
A18 A1051;
A17 A1052;
A5794 A1053;
}"
12D7I7"7 A3140"
17D34I14"81 A3143[20];
"
43D9I33"054
{
A54 A1055;
A55 A1056[25];
}"
19D8I9"55 *A3164"
19D11I19"struct A1054 *A7509"
20D78
86D209I12"144 *A7774;
"
217D10I51"7500
{
struct A7500 *A7775; A54 A7510; A42 A7511; }"
19D9I12"Void A1057()"
18D8I12"Void A1058()"
17D9I10"Void A1059"
20D8I10"Void A1060"
19D10I11"A5794 A1061"
21D22I18"struct A118 *A1062"
33D13I8" A1063;
"
20D13I8"A4 A7267"
26D4I4"7776"
14D10I8"63 A7777"
19D21
29D3I3"114"
8D2I2"64"
11I40"A81 A7512();
extern A49 A1073();
extern "
8D2I66"74();
extern A72 A1075[];
extern A9036 A1076();
extern A9036 A7778"
14D94I118"3097
{
A70 A3098; A72 A3099; A7468 A3100; A7468 A3101; A72 A3102; A72 A3103; A72 A3104; A7 A3105; A4 A3106; A7 A5282; "
100D5I85"283; A32 A5284; A74 A5966; A17 A6270; };
extern A81 A3107;
extern A315 A3108;
extern "
13D55I62"3097 A3109;
extern A58 A3110;
extern A4 A6067;
extern A72 A311"
60D10I14"extern A6 A311"
15D45
52D11I14"Void A1077();
"
19D7I21"48 strcat(), strcpy()"
17D9I14"48 strncpy(); "
16D11I13"int strncmp()"
24D4I4"1078"
15D8I7"2 A7268"
27D2I2"79"
13D12I18"struct A553 *A1080"
21I17"A7 A9295;
extern "
6D67I3"108"
72I66"struct A553
{
struct A553 *A1082;
A7 A1083;
struct A114 A1084;
};
"
15D81I1"8"
86D75I59"struct A5513
{
A81 A5514;
struct A147 *A5515;
};
A5972 A777"
80D39I10"A5972 A778"
44D17I10"A5972 A778"
22D16I10"A5972 A778"
21D16I10"A5972 A778"
21D16I10"A5972 A778"
21I15"A5972 A7785();
"
7D14I11"A74 A6242; "
21D12I8"A7 A1086"
21D12I8"A7 A7184"
21D12I11"A5794 A5248"
25D6I4"7185"
15D10I10"A95 *A1087"
27D4I4"1088"
21D4I4"1089"
21D4I4"7186"
21D3I3"109"
21D4I4"7187"
15D10I11"A5794 A1091"
21D9I10"Void A1092"
27D3I3"093"
20D4I4"8269"
20D3I3"094"
14D10I8"A4 A1095"
21D10I8"A4 A1096"
28D3I3"097"
20D4I4"1098"
16D10I7"4 A1099"
21D10I11"A94 * A5272"
21D9I10"A94 * A110"
21D10I11"A94 * A1101"
29D2I2"02"
19D4I4"1103"
15D11I10"Void A1104"
30D2I2"05"
21D2I2"06"
19D4I4"5675"
21D4I4"6243"
15D10I8"A4 A5518"
27D4I4"7786"
21D4I4"5516"
21D4I4"5517"
21D4I4"5519"
22D3I3"520"
14D18I12"Void A5521()"
27D17
23D4I4"5522"
15D10I9"A23 A7787"
21D8I10"Void A1107"
19D10I10"Void A1108"
22D10I7"4 A1109"
21D11I10"Void A1110"
22D11I10"Void A1111"
22D11I10"Void A1112"
22I21"Void A2942();
extern "
7D4I4"1113"
15D55I12"Void A2949()"
64D13I12"Void A7070()"
22D9I12"Void A1114()"
18D10I12"Void A1115()"
19D9I12"Void A7269()"
19D8I12"94 * A1116()"
17D9I12"Void A1117()"
18D18I12"Void A1118()"
27D18I12"Void A1119()"
27D26I12"Void A7788()"
35D8I12"Void A5676()"
17D18
26D2I2"20"
21D2I2"21"
21D2I2"22"
13D9I10"Void A8270"
26D4I4"5249"
15D10I18"struct A144 *A5523"
19I17"A7 A5822;
extern "
6D4I4"7789"
21D4I4"7790"
19D4I4"7791"
15D10I10"A94 *A7792"
21D10I11"A5794 A7793"
22D7I10"5794 A7794"
19D7I10"5794 A7795"
18D10I11"A5794 A7796"
22D8I10"5794 A7797"
20D2I4"5794"
7D3I45"8();
struct A5304 { A77 A3049; A5794 A1148; }"
12D12I13"A2 A1123[100]"
21D12I9"A17 A1124"
21D12I10"A13 *A1125"
21D12I9"A81 A1126"
23D9I7"8 A1127"
19D1I1"5"
6D4I2"28"
13D11I18"struct A144 *A1129"
20D11I18"struct A144 *A1130"
20D11I26"const struct A5304 A3050[]"
21D10I7"4 A1131"
20D17I8"38 A1132"
26D45I9"Void A113"
65D1I1"3"
21D1I1"3"
13D9I8"A17 A113"
29D1I1"3"
13D10I8"A4 A2979"
29D1I1"3"
19D3I3"917"
23D2I2"39"
13I19"A4 A1140();
extern "
8D1I1"4"
6D124I231"extern Void A5529();
extern A4 A5530();
extern A7 A5532();
extern Void A5533();
extern A66 A5534();
extern A66 A7799();
extern Void A5531();
extern Void A1142();
extern Void A1143();
extern Void A1144();
extern A50 A1145();
extern "
131D339I15"46();
extern A7"
344D13I118"47();
extern A48 A1148();
extern A48 A1149();
extern A77 A1150();
extern A58 *A5067, *A5068;
extern A17 *A8945, *A8946"
22D4I6"8271()"
15D5I193"53();
extern Void A1154();
extern Void A1155();
extern Void A1156();
extern Void A1157();
extern Void A5823();
extern Void A1158();
extern Void A1159();
extern Void A1160();
extern Void A1161()"
15D4I4"8402"
15D19
25D4I75"8403; A54 A8404; A13 *A8405; A7468 A8406; A72 A8407; A58 *A8408;
A58 *A8409"
19D52I1"6"
57D1I1"7"
6D56I4"63;
"
61D10I229"
A7132,
A7133,
A1164,
A1165,
A1166,
A1167,
A1168,
A1169,
A1170,
A1171,
A1172,
A1173;
A13 A1174[ (2000 / CHARLEN) ];
A18 A5435;
A17 A6040;
A13 A7800[ (2000 / CHARLEN) ];
A61 A6041;
A17 A6042;
} ;
extern A13 A9180[(2000 / CHARLEN)]"
20D4I4"9248"
14D88I6"9249; "
95D17I17"9296; A17 A9250; "
24D6I6"9251; "
13D6I19"9297; FILE *A9252; "
16D9I18"struct A9248 A9253"
18D127I14"Void A9254();
"
135D27I104"391
{
struct A633 *A1175;
struct A144 *A1176;
struct A144 *A1177;
struct A144 *A1178;
};
struct A1179
{
"
32D262I91"180;
A53 A1181;
A17 A1182;
A53 A1183;
A5794 A1184;
A5794 A1185;
};
struct A1186
{
struct A8"
267D31I5"187;
"
40D27
33D12I8"188;
};
"
21D18I6"189
{
"
26D71I105"640 *A1190;
A5794 A1191;
};
struct A1192
{
A17 A1193;
A9 A1194;
A70 A1195;
};
struct A1196 { A2 A1197[3];"
77I833" *A1198; };
struct A1199
{
A5794 A1200;
A35 A1201;
A42 A1202;
};
Void A1203();
Void A1204();
Void A1205();
struct A5677
{
A5794 A5678;
A42 A5679;
A5794 A5680;
A5794 A5681;
};
extern A17 A6244;
extern long A7418;
extern A49 *A1206;
extern A49 *A1207;
extern A2 A1208[ARG_LEN];
extern A42 A8197; extern A2 A3496[ARG_LEN];
extern struct A1196 A1209[];
extern const A6 A1210;
extern A7 A5406;
extern A7 A5407;
extern A7 A6210;
extern A42 A1211;
extern A4 A1212;
extern A72 A1213;
extern A72 A1214;
extern A18 A1215;
extern A18 A1216;
extern A4 A7228;
extern A61 A1217;
extern A61 A1218;
extern A67 A1219;
extern A13 *A6043;
extern A13 *A1220;
extern A13 *A1221;
extern struct A1162 A1222;
extern struct A144 *A1223;
extern struct A144 *A1224;
extern struct A144 *A1225;
extern A48 A1226;
extern A7 A1227;
extern A9070 A1228;
extern UFLAG"
1095I7"9298,
A"
2534D19
33D4I4"9255"
14D7I9"2 A7190[]"
16D8I18"struct A144 *A1398"
21D4I4"1399"
14D8I7"4 A7807"
18D7I6"7 A621"
21D7I6"9181; "
15I1"1"
6D1I1"0"
11D1I2"68"
6D1I1"1"
11D1I1"4"
6D1I2"2 "
11D1I1"7"
6D1I1"3"
10D4I2"A7"
9D3I1"4"
12D4I2"A7"
9D3I1"5"
12D4I2"A4"
9D3I1"6"
12D9I10"Void A1407"
20D9I10"Void A1408"
26D4I4"1409"
17D6I7"8 A1410"
17D10I9"A58 A1411"
21D8I10"Void A8257"
19D10I8"A4 A8411"
27D4I4"5063"
15D4I2"A6"
9D1I1"2"
12D2I4"Void"
7D1I1"3"
18D4I4"1414"
21D4I4"1415"
15D10I8"A4 A1416"
21D19I10"Void A5687"
36D4I4"5688"
15D10I10"Void A5689"
21D10I19"struct A5677 *A5690"
30D1I1"7"
12D10I10"A13 *A5396"
21D10I9"Void A141"
28D4I4"1419"
21D4I4"6052"
15D10I11"A5794 A7808"
30D1I1"4"
18D4I4"5545"
21D4I4"5546"
15D8I10"Void A5547"
19D2I4"Void"
7D1I1"0"
12D2I4"Void"
7D25I1"1"
36D9I7"A4 A624"
21D9I9"A48 A9182"
20D9I8"A4 A1422"
20D4I2"A4"
9D12I5"3();
"
26D5I6" A1424"
16D10I12"Void A3500()"
19D8I10"Void A1425"
19D8I9"int A3493"
19D10I9"int A3494"
27D4I4"1426"
15D10I19"struct A1189 *A1427"
21D12I10"A13 *A8273"
22D7I6"4 A599"
19D9I7"A4 A599"
21D8I10"Void A9311"
27D2I2"28"
13D12I10"Void A7191"
31D2I2"29"
13D8I10"Void A6080"
25D4I4"9183"
15D10I9"A54 A1430"
21D1I1"V"
6D4I4"1431"
15D10I8"A4 A7475"
30D1I1"2"
12D9I12"UFLAG *A1433"
29D1I1"4"
12D10I8"A4 A1435"
29D2I2"36"
13D1I1"v"
6D4I4"6246"
15D1I1"v"
6D4I4"7809"
21D4I4"1437"
23D2I2"38"
14D10I10"34 A5691()"
19D20
28D2I2"39"
19D4I4"1440"
15D10I12"Void A1441()"
19D17
26D1I1"2"
21D1I1"3"
12D11I10"Void A5773"
30D2I2"44"
13D12I11"A5794 A1445"
21I20"A5794 A1446;
extern "
6D4I4"1447"
21D4I4"3532"
15D12I10"A2 A3526[]"
21I17"A4 A3527;
extern "
6D2I2"14"
21D4I4"1449"
15D10I11"A5794 A1450"
30D1I1"1"
18D4I4"1452"
15D10I8"A4 A9184"
27D4I4"5274"
21D73I6"1453()"
82D19I12"Void A5651()"
28D20I12"Void A5548()"
29D20
26D4I130"3443();
extern Void A6072();
extern Void A1454();
extern Void A3363();
extern Void A1455();
extern Void A1456();
extern Void A5107"
17D89I65"065
{
A67 A1066;
A5794 A1067;
A5794 *A1068;
A17 A1069;
};
extern "
97D44I20"1065 *A1070;
extern "
52D40I53"1065 A1071[];
extern A67 A1072[];
extern Void A6209()"
53D12I85"
{
A79 A547;
A79 A548;
A79 A549;
A79 A6232;
A79 A5661;
A87 A6233;
A87 A5662;
A23 A552"
23D16I24"53 *A554, *A555, *A6234,"
21D1I12"63, *A557;
}"
11D29I14"93
{
A17 A8274"
34D35I21"98 A8275;
A8198 A8276"
50D44I10"8277[1];
}"
54D41I6"561
{
"
56D4I165"62;
struct A561 *A563;
A40 A564;
A40 A565;
A81 A566;
A58 A567;
A42 A568;
A68 A569;
struct A147 A570;
A17 A571;
A24 A572;
A61 A573;
A96 *A574;
struct A1537 * A7443;
}"
13D11I8"A81 A575"
20D9I17"struct A561 *A576"
28D1I1"7"
18D2I1"5"
22D2I2"79"
19D3I4"8278"
22D1I1"0"
20D1I1"1"
19D3I2"82"
22D9I1"3"
20D7I10"Void A5664"
18D19
27I65"4(), A585();
extern A4 A586();
extern A4 A5665();
extern Void A58"
1854I50"9136
{
struct A9136 *A9137; A17 A9138; };
struct A"
109D9I19"struct A9136 *A9139"
18D18
26D9I10"9136 A9140"
19D9I8"58 A7273"
18D4I3"A17"
9D3I1"4"
12D11I17"struct A588 A1719"
20D4I2"A2"
9D3I3"6[]"
20D2I2"77"
13D10I9"A89 A1978"
29D2I2"79"
19D4I4"1980"
21D4I4"7274"
24D1I1"1"
13D8I7"4 A9185"
19D18I8"A4 A9186"
35D4I4"5897"
24D1I1"2"
12D3I4"Void"
8D1I1"3"
12D10I9"A72 A1984"
21D10I18"struct A561 *A1985"
27D3I3"914"
23D2I2"86"
21D2I2"87"
13D27
33D26I4"9142"
37D10I9"A78 A1988"
27D4I4"1990"
21D4I4"1989"
21D4I4"1991"
15D8I10"Void A1992"
25D4I4"1993"
15I27"struct A144 *A7824; extern "
6D4I26"5553();
struct A147 *A7825"
23D2I2"26"
19D4I4"7827"
21D64I6"7828()"
73D8I10"Void A7829"
20D7I7"4 A7830"
18D9I12"Void A8412()"
18D9I12"Void A7831()"
18D9I12"Void A7832()"
18D19I12"Void A8413()"
28I14"Void A8414();
"
8D20I7"1457
{
"
26D12I4"58;
"
18D3I25"59;
A4 A1460;
A9 A1461;
}"
12D19I10"A9 A1461()"
28D18I10"A9 A1462()"
28D1I1"9"
6D1I1"3"
11D19I8"A4 A1464"
30D9I7"4 A1465"
19D20
28D11I10"83 **A5078"
21D9I18"struct A83 **A5079"
25D2I2"66"
13D9I7"4 A1467"
19D3I11"struct A144"
8D2I2"68"
12D11I18"struct A144 *A7476"
21D9I7"4 A1469"
19D10I19"struct A640 **A3651"
20D9I18"struct A640 **A365"
21D8I9"17 *A1470"
19D8I9"68 *A1471"
26D13I14"640 **A1472 ;
"
22D7I7"3 A1473"
18D11I7"4 A1474"
22D7I9"13 *A1475"
18D7I9"13 *A1476"
18D7I9"13 *A1477"
18D4I2"53"
9D2I2"78"
13D2I2"68"
7D2I2"79"
12D9I3"A17"
15D1I1"0"
12D1I2"57"
6D1I1"1"
11I19"A57 A3660 ;
extern "
17D3I4"5 ; "
11D10I8"57 A1482"
22D6I10"036 *A1483"
17D10I7"4 A1484"
20D18I8"A4 A8214"
29D8I7"4 A1485"
19D7I11"9036 *A1486"
18D7I9"81 *A1487"
17D8I16"const A81 *A1488"
19D7I7"6 A1489"
25D11I10"144 *A7276"
21D4I4"9036"
9D1I1"0"
11D17I8"A9 A1491"
27I21"A9036 A1492 ;
extern "
8D9I10"640 *A1493"
19D17I9"A63 A1494"
27D17I8"A4 A1495"
28D8I7"4 A1496"
22D4I4"5825"
18D4I5"1497 "
21D8I9"640 *A149"
19D12I12"A5794 A1499 "
21D12I18"struct A83 *A1500 "
21D10I18"struct A83 *A1501 "
19D13I18"struct A83 *A1502 "
22D10I18"struct A83 *A5080 "
20D9I9"53 A1503 "
18D12I9"A4 A1504 "
21D12I8"A4 A6247"
21I27"struct A83 *A6248 ;
extern "
6D4I4"9040"
23D2I2"05"
14D7I7"4 A1506"
18D10I11"A5794 A1507"
21D9I10"Void A7451"
20D10I8"A4 A7833"
22D8I7"4 A6249"
25D4I4"6250"
23D2I2"08"
13D8I10"Void A1509"
28D1I1"0"
12D4I2"A6"
9D1I1"1"
21D1I1"2"
12D10I9"A68 A1513"
21D7I9"Void A151"
20I203"81 A5692();
extern Void A8215();
extern Void A1515();
extern A4 A1516();
extern Void A1517();
extern Void A1518();
extern Void A1519();
extern Void A1520();
extern A4 A3738();
extern A4 A7834();
extern A"
561D1I1" "
11D1I1" "
11D1I1" "
10D1I1" "
10D1I1" "
10D1I1" "
848D4I4"9082"
15D19I10"Void A9083"
30D19I10"Void A9084"
30I21"Void A3863();
extern "
17D2I2"89"
13D10I19"struct A1537 *A1590"
21D10I19"struct A1537 *A1591"
27D2I2"71"
21D4I4"1592"
21D4I4"1593"
15D9I10"Void A7841"
29D1I1"2"
12D4I3"A74"
9D1I1"7"
18D4I4"7843"
21D4I4"8218"
15D9I10"Void A8219"
29D1I1"5"
13I1"7"
6D1I1"6"
12D3I4"Void"
8D1I1"7"
12D10I8"A4 A7848"
21D10I9"A74 A7849"
21D1I1"V"
8D24I4"94()"
33D9I4"void"
14D1I3"1()"
10D4I4"void"
9D9I17"2();
typedef A22*"
14I57"3;
extern const A51 A1524;
extern long A1525;
struct A152"
1445D10I8"A4 A9085"
27D4I4"3763"
15D9I10"Void A8835"
21D2I2"35"
7D1I3"4()"
10D11I3"A58"
16D1I1"5"
10D2I11"struct A147"
7D3I1"6"
12I19"A4 A3767();
extern "
2788D2I4"9070"
433D8I10"Void A9086"
19D9I9"A74 A9087"
28D1I1"6"
12D8I9"Void A737"
19D9I8"A4 A4551"
20D9I9"Void A738"
25D3I4"4724"
14D10I8"A58 A741"
29D1I2"77"
20D1I1"3"
18D4I3"744"
15I21"Void A8202();
extern "
1326D1I1" "
15D1I1" "
11D1I1" "
2390D2I4"9070"
215D2I4"9070"
12D1I2"72"
52D4I4"9088"
2825D4I4"9259"
12D7
22D1I1"3"
28D4I4"3134"
31D3I3"802"
12I7"atic st"
12D13I10"5442 ARB;
"
27D8I4"7774"
31D4I4"8023"
12I7"atic st"
15D1I1"5"
9D7
13D8I9"144 *A313"
30D10I9"83 *A7326"
18I7"atic st"
7D2I1"4"
9D1I1"8"
7D14
31D2I2"39"
8I14"A7 A3140 = 0;
"
18D1I1"1"
7D20
38D1I1"2"
7I20"A81 A3143[20] ARBA;
"
18D1I1"4"
25D1I1"5"
25D1I1"6"
25D1I1"7"
22D4I4"3148"
25D4I4"5443"
25D8I4"9260"
25D4I4"7509"
28D1I1"4"
25D1I1"5"
25D1I1"6"
25D1I1"7"
7D10I19"struct A1054 *A8028"
18D16I17"ruct A1054 *A8029"
22I40"A81 *A3149 ARB;
static A5774 A3150 ARB;
"
2216D4I2"(f"
17I9"(size_t)("
6D8I10"),(size_t)"
18I23"!= (size_t)( (A72) 1)) "
8028I6"(A72) "
2072I6"(A72) "
191I6"(A72) "
340D1I1"
"
31D1
8I6"(A49)("
6D1I8"),(A49)("
15D1I11"),(size_t)("
22I1")"
201I6"(A72) "
55I6"(A72) "
297I6"(A72) "
48I6"(A72) "
255I6"(A72) "
305I6"(A72) "
221I6"(A72) "
46I6"(A72) "
45I6"(A72) "
329I8"(A7470) "
1031I6"(A72) "
1154I6"(A72) "
300I6"(A72) "
97D59I5"3152("
64D25I66"1, A2882, A1730 )
A49 A1731;
A72 A2882;
A7470 A1730;
{
A7470 A1875"
31D45I19"!A1730 || !A2882 ) "
55D80I25"875 = (A1240 > 0) ? A3210"
86D47I9"1, A2882,"
52D56I18"0, A3115 ) :
A3191"
61D15I98"31, A2882, A1730, A3115 );
if( A1875 != A1730 ) goto A1711;
goto A1712;
A1711: A884( 304, A1061(1)"
20D25I14"1712: ;
}
Void"
33D36I44"A1731, A2882, A1730 )
A49 A1731;
A72 A2882;
"
41D40
45D3I30"0;
{
A4 A3270;
if( !A1731 || !"
8D2I5" || !"
9D49I7" return"
55D35
47D1I40") goto A1711;
goto A1712;
A1711: A3270 ="
6D1I1"1"
31D8I38";
goto A1713;
A1712: A3270 = sys_write"
24I6"(A72) "
12D3I10") ;
A1713:"
9D12I3"327"
25D1I1"4"
12D1I1"5"
7D1I1"4"
8D15I9"316,A1332"
22D19I31"5:
A3121 += (A18) ( (A72)(A13)("
24D8I6"[0]) *"
15D16I1"+"
22D7I82" );
}
struct A144 *
A3271( A1709 )
A17 A1709;
{
struct A144 *A2091;
A54 A1759;
A54"
12D20I37"2;
register A49 *A2092;
register A49 "
25D5I6";
A72 "
10D69I66";
short A2118;
A81 A80;
struct A322 *A2061;
A8 A1808;
struct A1045"
74D59I177"2;
struct A633 *A1819;
struct A83 *A1724;
struct A149 *A1948;
struct A189 **A3273;
A58 A5020;
struct A1613 *A5140;
struct A151 *A3982;
A3154( &A3272, 0xF1 );
A2091 = A999( (A54)"
64D61I8"2.A1048,"
66D26I9"2.A1049 )"
31D19I89"59 = (A54) (A3272.A1048-1);
A2091->A991 = A1759;
A2092 = A2091->A988;
A2882 = A3272.A1047"
24D43I18"32 = 0;
A1713:
if("
48D80I4"2 <="
86D6I35") goto A1711;
goto A1712;
A1714: ++"
13D58I33"goto A1713;
A1711:
A3152( (A49) &"
63D211I30", (A72) sizeof(A2118), (A7470)"
216D46I39"if( A2118 == 1 ) goto A1715;
goto A1716"
51D28I42"15:
goto A1717;
A1716: if( A2118 == 2 && !"
38D10I34"2 ) goto A1720;
goto A1721;
A1720:"
16D37I1"["
42D4I36"] = (A49) A3161( A3116 );
goto A1722"
9D4I4"21: "
9D13I10"2118 == 2 "
23D2I2"23"
12D2I2"25"
7D31I33"23:
A1731 = A1073( A2091->A992 );"
39D27I12"A1731, A2882"
41D86I30"A2092[A1732] = A1731;
switch( "
99D44I20"
{
case (A41) 1:
A80"
49D3I22"81) A1731;
A80->A129 ="
10D1
6D4I76");
if( ( (A80)->A156 == (A41) 20 ? (A80)->A155.A150 : (struct A149 *) 0 ) ) "
13D1I13"7;
goto A1766"
7D42I18"7:
A1948 = A3158()"
47D9I46"67: ( A80)->A156 = (A41) 20; ( A80)->A155.A150"
14D103I88"948 ; 
A1768:if(0) goto A1767;
A1769: ;
goto A1770;
A1766: if( A7267 && ( (A80)->A156 =="
110D53I4"25 ?"
64D26
31D1I1"2"
14D6I5"51 *)"
20D2I2"71"
12D2I2"72"
7D16I16"71:
A3982 = A803"
24D2I2"73"
26D1I1"5"
19D9I9"2 = A3982"
16D2I2"74"
17D2I2"73"
7D2I2"75"
15D1I1"6"
6D2I2"72"
8D9
32D2I2"37"
18D21I13"7499 : (A81) "
26D1I1"
"
10D1I1"7"
12D1I1"8"
7D25I1"7"
48D2I2"48"
18D11I14"7501 = A7544()"
19D1I1"9"
17D1I1"7"
6D5I3"80:"
14D2I2"81"
8D1I1"8"
7D7I3"A80"
14D13I32") goto A1782;
goto A1783;
A1782:"
24D55I8"6 = 0; ("
64D43I13"5.A141 = NULL"
49D2I2"84"
17D2I2"82"
8D8I10"5:
A1783:
"
13D1I1":"
6D3I10"6:
A1770:
"
8I19"1709 & (A17) 1 && A"
7D1I6"5.A142"
13D1I1"6"
12D1I1"7"
7D8I6"6:
A80"
13D17
22D10I31"2 = A3161( A3116 );
goto A1788;"
15D6I23"7: if( A1709 & (A17) 2 "
15D38I22"889;
goto A1890;
A1889"
45D19
26D6I6"9.A158"
16D3I3"891"
12D11I70"892;
A1891:
A1731 = A1073( (A41) 1 );
A3152( A1731, A2882, (A7470)1 );"
20D6I50"9.A158 = (A81) A1731;
A80 = (A81) A1731;
A80->A129"
15D1
6D1
11D4I20"889;
A1892: ;
A1890:"
9D25I3"8:
"
32D74I17"726;
case (A41) 2"
79D29I19"24 = (struct A83 *)"
35D79I13";
A1724->A173"
85D11I27"36;
if( A1724->A183.A129 ) "
19D2I14"93;
goto A1894"
8D10I1"3"
15D8I42"24->A183.A129 = A3161( A3116 );
A1894:
if("
13D51
56D32I2"84"
44D1I1"5"
12D1I1"6"
7D1I1"5"
13D6I1"4"
29D7I12"6:
A3273 = &"
16D3I21"90;
A1899:
if( *A3273"
14D1I1"7"
12D1I45"8;
A1900: A3273 = &(*A3273)->A250;
goto A1899"
7D40I27"7:
{
struct A246 **A3274;
*"
48D37I7"(struct"
42D22I34" *) A1005( A3129 );
A3152( (A49) *"
27D24I21", (A72) sizeof(struct"
29D26I15"),
(A7470)1 );
"
31D2I5" = &("
8D47I19")->A254;
A1903:
if("
53D36I34"4) goto A1901;
goto A1902;
A1904: "
51D1I1"4"
6D4I9"47;
goto "
9D6I9";
A1901:
"
12D33I49" = (struct A246 *) A1005( A3130 );
A3152( (A49) *"
38D4I43", (A72) sizeof( struct A246 ), (A7470)1 );
"
17D1I18"9 = A3161( A3116 )"
12D1I1"4"
7D133I7"2: ;
} "
142D23
482I6"(A72) "
43I6"(A72) "
866I6"(A72) "
503D2I4"9070"
164I30"struct A196 *A8417;
A7 A9100;
"
421I6"(A72) "
481D32I7"8417 = "
41D12I4"97; "
21D12I19"97 = NULL; A9100 = "
20D17I5"7472;"
22D28I20"4->A7472 = 0; A3153("
34D6I21", A2882, (A7470)1 );
"
11I69"->A174 = A2897; A1724->A187 = A3276; A1724->A194 = A3278; A1724->A197"
5D10I26"417; A1724->A7472 = A9100;"
19D21I16"25;
case (A41) 1"
26I31" = (A81) A1731;
if( A1724 = A80"
8I44") goto A1770;
goto A1771;
A1770:
A80->A7145 "
244D2I4"9070"
1092I6"(A72) "
163I6"(A72) "
233D22
111I6"(A72) "
530I6"(A72) "
318I6"(A72) "
190I6"(A72) "
396I6"(A72) "
177I6"(A72) "
976D2I4"9070"
297D2I4"9070"
90D2I4"9070"
118D2I4"9070"
172D26I18"2591->A635 == A390"
60I33"(*A3164( A3141, A3287 )) = (A55) "
11D10I88";
goto A1727;
A1726: if( A3284 & (A9070) 0x10 && A3287 ) goto A1766;
goto A1767;
A1766:
"
15I21"->A635 = A1430( A2591"
101D2I2"67"
9I9"27: ;
A17"
2156I6"(A72) "
636I6"(A72) "
54I6"(A72) "
166I6"(A72) "
98I6"(A72) "
88I18"9259 = A3271(0);
A"
223I39"13( A9259, A3156 ); A1000( A9259 ); A10"
2069I6"(A72) "
434I6"(A72) "
52I6"(A72) "
340I6"(A72) "
55I6"(A72) "
34I35"A7325 = (A41) 4;
A3275( A9255, 0);
"
157I6"(A72) "
499I6"(A72) "
160I6"(A72) "
474I6"(A72) "
1689I6"(A72) "
156I6"(A72) "
418D3I6"size_t"
508I6"(A72) "
109I6"(A72) "
474I6"(A72) "
319I6"(A72) "
123I6"(A72) "
422D3I6"size_t"
430D3I6"size_t"
53I6"(A72) "
70D3I6"size_t"
47I6"(A72) "
474I42"9260 = A3169( (A54) (A9259->A991 + 1) );
A"
59I6"(A72) "
1488I16"3170( A9260 );
A"
48I6"(A72) "
236D2I4"9070"
13D2I4"9070"
86I6"(A72) "
302D16
366D1I21"
A1948 = A3982->A1628"
121I16"3165( A1948 );
A"
200D7
17D4I10";
A2037 = "
14D31I9"4;
A1769:"
41D53
1167D1I1"7"
24D2I4"9070"
218I42"&& A1709 & (A27) 0x20 )
return;
if( A7267 "
169I6"(A72) "
893I54"struct A149 *A1948 = NULL;
struct A151 *A3982 = NULL;
"
56I8"return;
"
11D22
239D42I8"(A1948 ="
109I1")"
12D1I1"2"
12D1I1"3"
7D1I1"2"
52D66I5"A1948"
74D1I1"4"
17D1I1"2"
7D2I14"5:
goto A1716;"
7D6I24"3: if( A7267 && (A3982 ="
72D3I4") ) "
11D2I2"17"
13D1I1"0"
6D4I4"17:
"
53D65I5"A3982"
73D1I1"1"
16D2I2"17"
8D3I23"2:
A1948 = A3982->A1628"
9D4I2"0:"
9D2I18"6:
A3165( A1948 );"
154D1I1"3"
12D1I1"5"
7D1I1"3"
149D1I1"6"
11D2I2"27"
8D1I1"6"
41D2I2"27"
51D3I6"size_t"
34D1I1"5"
168D1I1"6"
12D1I1"7"
7D1I1"6"
63D1I1"7"
24D1I1"8"
11D2I2"69"
8D1I1"8"
81D1I1"0"
12D1I1"1"
7D1I1"0"
66D1I1"2"
17D1I1"0"
7D1I1"3"
7D1I1"1"
89D1I1"4"
12D1I1"5"
7D1I1"4"
41D1I1"5"
8D2I2"69"
1649I6"(A72) "
374I7"((A72) "
13I1")"
86I6"(A72) "
309I6"(A72) "
204D3I6"size_t"
873I6"(A72) "
816I6"(A72) "
478I6"(A72) "
623I6"(A72) "
360D3I6"size_t"
93I6"(A72) "
1251I6"(A72) "
186I6"(A72) "
535I6"(A72) "
157I6"(A72) "
2072D19I46"A9236
A9261( A2499 )
A9236 A2499;
{
A62 A9262;"
28D22I131"322 *A9263, *A9264;
A9235 A1808, A1732;
A54 *A2563;
A54 A9265;
if( A2499 == 0 ) return 0;
A9262 = (*A3164(A9260,A2499));
if( A9262 "
54D11I129" return A9262; 
A1712:
A9263 = (struct A322 *) (( A9259 )->A988)[A2499];
A1808 = A9263->A324;
A2563 = (A54 *) (A9263->A323);
A926"
16D18I9"511(A1808"
23D141I15"732 = 0;
A1715:"
147D5I12"1732 < A1808"
35D24I22"6: A1732++;
goto A1715"
30D3I63"3:
A9265 = A2563[A1732];
if( A9265 > 0 ) goto A1717;
goto A1720"
9D138I8"7: A9265"
149D14I24" A5443, A9265 ));
A1720:"
20D4I4"9265"
15D1I1"2"
12D1I1"2"
7D29I26"21: A512( A9264, A9265 );
"
37D14I2"23"
19D35I25"22: A517( A9264 ); return"
43D16I16"23: ;
goto A1716"
22D80I22"4:
A9262 = A9245( A926"
85D33I99"(*A3164(A9260, A2499 )) = A9262;
return A9262;
}
Void
A3165( A1948 )
struct A149 *A1948;
{
if(A1948"
44D1I1"1"
12D1I1"2"
7D36I4"1:
{"
45D38I36"118 *A9192 = A1948->A373;
A1948->A37"
43D131I16"3167( A1948->A37"
138D3I183"948->A7655 = (*A3164( A5443, A1948->A7655 ));
A1948->A7656 = (*A3164( A5443, A1948->A7656 ));
A1948->A7657 = (*A3164( A5443, A1948->A7657 ));
if( A7267 ) goto A1713;
goto A1714;
A1713"
8D24I16"55( A1948->A7504"
29D3I59"1714:
if( A9192 ) goto A1715;
goto A1716;
A1715:
A9192->A12"
8D46I65"3167( A9192->A122 );
A3166( &A9192->A120 );
A3166( &A9192->A123 )"
55D9I119"A1948->A9239 = A9261( A1948->A9239 );
}
A1712: ;
}
A54
A3310( A3311 )
A54 A3311;
{
struct A1613 *A1731;
A54 A3312;
A58 "
14D41I6";
A90 "
46D100I7";
A5794"
105D46I6"1;
if("
53D12I7"== 0 ) "
19I3"0;
"
5D14I28" = (*A3164(A3148,A3311));
if"
19D75I2"12"
109D87I3"if("
92D14I71"2 == (A54)(~0) ) goto A1713;
goto A1714;
A1713: A884( 304, A1061(27) );"
19D28I45"2 = 0; 
A1714:
return A3312;
A1712:
A1731 = ("
36D15I120"1613 *) (( A3134 )->A988)[A3311];
A1740 = A3168( A1731->A1614 );
if( A1741 = (A5794) A1731->A5108 ) goto A1715;
goto A17"
20D8I57"1715:
{
A58 A5020 = (A58) A1731->A1615;
struct A83 *A1724"
15D180I2"80"
187D4I38"5020 && (A1724 = A506( A3168(A5020) ))"
16D13I1"7"
18D107I9"24 = A431"
113D22I1"7"
29D35I18"1731->A5109 & 0x80"
46D2I2"20"
12D2I2"21"
7D65I25"20:
A1724 = A211( A1724 )"
70D25I15"21:
A80 = A213("
30D29
34D7I6"741, 2"
12D18I54"3312 = A5105( A1740, A80, A1731->A5109 );
}
goto A1722"
24D1I1"6"
8D8I15"492(A1740) == 4"
21D1I1"3"
12D1I1"5"
7D7I70"3:
A2069 = (A87) A3168( (A58) A1731->A1615 );
goto A1726;
A1725: A2069"
13D34I9"31->A1615"
40D1I1"6"
6D86I38"12 = A8283( A1740, A2069, A1731->A5109"
91D103I28"1722:(*A3164(A3148, A3311 ))"
109D9I24"12;
return A3312;
}
Void"
14D18I26"3( A3304 )
struct A83 **A3"
23D49I31"{
struct A83 *A1724;
A58 A1797;"
57D8I11"24 = *A3304"
19D2I2"11"
12D2I2"12"
7D25I8"11:
A179"
31D17I4"168("
22D13I38"4->A183.A130 );
*A3304 = A506( A1797 )"
18D37I24"12: ;
}
A58
A3314( A1740"
42D13I15"15 )
A58 A1740,"
18D2I9"5;
{
A315"
7D2I44"2;
A58 A3305;
struct A83 *A1724, *A3316;
A60"
7D69I26"7;
A81 A2971;
A315 A3318;
"
77D4I109"3097 A3319;
A70 A2060=0;
A58 A3320;
A4 A3321 = (A4) 0;
struct A189 *A3277;
Void A3322();
A3323:
A1742 = (A315"
12D1I1"1"
11D14I5"1740]"
19D26I15"05 = A1742->A30"
34D10I4"3315"
21D2I2"11"
12D2I2"12"
7D30I107"11: A3318 = ( A7174 = (A3315), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) );
goto A1713"
35D11I16"12: A3318 = NULL"
16D41I69"13:
if( A3320 = (*A3164(A3147, (A55) A3305)) ) goto A1714;
goto A1715"
46D50I65"14:
{
A315 A3324;
if( A3320 == (A54)(~0) ) goto A1716;
goto A1717"
55D27I25"16:
if( A3315 == 0 ) goto"
32D19I13"0;
goto A1721"
25D30I22"0: A884(304, A1061(21)"
38D44I15"1:
return A3315"
49D18I25"17:
if( A3315 == 0 ) goto"
23D91I26"2;
goto A1723;
A1722:
A438"
104D48I27"7;
return A530( 37, A3320 )"
53D30I93"23:
A3324 = ( A7174 = (A3320), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1])"
36D9I108"318 = ( A7174 = (A3315), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) );
A3318->A306 = A33"
14D59I16"306;
A3318->A304"
64D41I22"324->A304;
A3318->A305"
46D95I1"3"
100D15I11"305;
return"
20D20I34"5;
}
A1715:
if( A1742->A307 ) goto"
25D25I3"5;
"
33D13I1"2"
19D8I25"25:
{
A58 A3307;
if( A330"
13D17I14"3306(A1742) ) "
25D2I14"27;
goto A1766"
7D3I19"27:
A3168( A3307 );"
8D66I53"(*A3164(A3147, A3305)) )
return A3314( A1740, A3315 )"
71D61I21"66: ;
}
A1726:(*A3164"
67D31I23"7, A3305 )) = (A54)(~0)"
36D40I51"24 = (struct A83 *) ((A3133)->A988)[A3305];
--A3126"
45D97I27"13( &A1724->A174 );
++A3126"
106D16I15"24->A187 ) goto"
21D15I7"7;
goto"
20D16I2"8;"
21D38I29"7: A216( A1724->A187, A3308 )"
43D20I29"68:
--A3126;
A1724->A183.A160"
27D19I19"8( A1724->A183.A160"
26D15I21"24->A183.A161 = A3168"
20D52I23"24->A183.A161 );
++A312"
58D174I9"24->A183."
182D1I1"6"
7D53I27"67( A1724->A183.A140.A136 )"
58D20I9"24->A7171"
26D23I16"67( A1724->A7171"
29D24I15"724->A8822.A882"
30D3I135"168( A1724->A8822.A8820 );
A1724->A7243 = A3168( A1724->A7243 );
memcpy((A49)( &A3319),(A49)( &A3109),(size_t)( sizeof(struct A3097) ))"
10D69I41"A2060 = A1742->A303) != 31 && A2060 != 41"
79D3I3"769"
12D84I35"770;
A1769:
A3111( 1, A2060, (A7468"
89D34I21";
A3277 = A1724->A190"
40D1I1"3"
8D26I4"3277"
35D3I3"771"
12D23I17"772;
A1774: A3277"
28D22I21"277->A250;
goto A1773"
27D8I152"71:
A3277->A252 = A3168( A3277->A252 );
A3111( 6, A3277->A252, (A7468) 0 );
goto A1774;
A1772: ;
A1770: A3317 = A1724->A176;
A1777:
if( A3317 && ( A2971"
13D113I3"81)"
119D5I13"->A173->A988["
10D2I4"7 ])"
11D3I3"775"
12D36I11"776;
A1778:"
41D83I22"7 = A2971->A159.A157;
"
90D14I2"77"
19D3I3"775"
10D3I319"2971->A130 || A2971->A160 || A2971->A161 ) goto A1779;
goto A1780;
A1779:
{
A58 A3325;
A315 A3326;
A39 A1761 = A2971->A168.A166;
if( A3140 < 20 ) goto A1781;
goto A1782;
A1781: A3143[A3140] = A2971;
A1782:
A3140++;
A3325 = A3168( A2971->A130 );
A2971->A160 = A3168( A2971->A160 );
A2971->A161 = A3168( A2971->A161 );
if"
8D283I75"61 == (A39) 5 || A1761 == (A39) 6 || A1761 == (A39) 14 ||
A1761 == (A39) 18"
293D3I3"783"
12D23I28"784;
A1783:
A2971->A140.A136"
29D95I20"67( A2971->A140.A136"
101D30I16"784:
A3140--;
if"
35D48I31"61 == (A39) 7 && A2060 != 31 ) "
55D9I21"785;
goto A1786;
A178"
16D93I16"7 = A2971;
A3326"
109D3I3"325"
79D2I2"26"
7D16I7"3 == 26"
26D3I3"787"
12D17I28"788;
A1787:
A2971->A140.A133"
24D1I40"1( 3,
A3326->A306, (A7468) A3326->A305 )"
10D36I28"889;
A1788:
A2971->A140.A133"
43D7I5"1( 4,"
12D131I12"5, (A7468) 0"
136D20I4"1889"
26D9I16"786:
A2971->A130"
15D32I1"2"
39D20I70"( (A2971)->A156 == (A41) 20 ? (A2971)->A155.A150 : (struct A149 *) 0 )"
30D3I3"890"
12D24I89"891;
A1890: A3165( ( (A2971)->A156 == (A41) 20 ? (A2971)->A155.A150 : (struct A149 *) 0 )"
29D38I19"1891: ;
}
A1780: ;
"
45D5I45"778;
A1776:
if( A2060 != 31 && A2060 != 41 ) "
12D31I3"892"
40D2I2"89"
7D32I16"892:
A1742->A305"
37D125I8"111( 2, "
130D62I51"7468) 0 );
A1742->A304 = (A13) A3109.A3103;
memcpy("
67D13I106"( &A3109),(A49)( &A3319),(size_t)( sizeof(struct A3097) ));
A1893:
A3316 = A434;
A434 = A1724;
if( A3318 )"
21D27I48"894;
goto A1895;
A1894:
{
struct A83 *A1798;
if("
32D15I68"8->A306 && (A1798 = A507(A3318))
&& A1798->A183.A127 & (A27) 0x08 &&"
20D102I40"0 != 41 ) goto A1896;
goto A1897;
A1896:"
108D62I291"545( A1742, A3318, (A17) 1|(A17) 8 ) & (((A77) 0x1 | ((A77) 0x8000 | (A77) 0x20000000) | ((A77) 0x2 | (A77) 0x10000 | (A77) 0x20000 | (A77) 0x100000 | (A77) 0x80000) | (A77) 0x4000 | (A77) 0x10) | 
(A77) 0x01000000 | (A77) 0x02000000 | (A77) 0x10000000 | (A77) 0x04000000 | (A77) 0x08000000)"
72D3I3"898"
12D37I81"899;
A1898:
{
A81 A1942 = A3149[A1740];
A897( 126, A1942 ? A1942->A129 : "" );
}
"
44D3I47"900;
A1899: A543( A507(A3318), A1724 );
A1900: "
12D32I37"901;
A1897: A544( A1742, A3318, A3315"
40D5I10"1 = (A4) 1"
10D74I19"901: ;
}
goto A1902"
79I7"95:
A31"
8D49I35"42;
A3110 = 0;
A1013( A1398, A3112 "
57D28I4"3110"
38D3I3"903"
12D16I107"904;
A1903:
A3318 = ( A7174 = (A3110), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) );
if"
21D47I24"18->A307 == A1742->A307 "
56D3I3"905"
12D22I25"906;
A1905: A3315 = A3110"
31D45I50"907;
A1906: (*A3164( A3147, A3305 )) = A3110; goto"
50D63I29"3; 
A1907:
A543( A507(A3318),"
68D1I3"4 )"
10D11I65"908;
A1904:
A3318 = A527(A1742->A303);
A3315 = (A58) A1011;
A544("
16D46I2"2,"
51D14I8"8, A3315"
19D5I75"3321 = (A4) 1;
A1908: ;
A1902:
A434 = A3316;
(*A3164(A3147,A3305)) = A3315;"
11D4I19"3321 && A2060 != 41"
14D3I3"909"
12D15I16"910;
A1909:
A332"
21D13I45"18 );
A3277 = A1724->A190;
A1913:
if( A3277) "
20D49I5"911;
"
56D2I2"91"
7D5I24"914: A3277 = A3277->A250"
14D28I60"913;
A1911:
{
struct A246 *A3280;
A3280 = A3277->A254;
A1917"
35D12I4"3280"
21D3I3"915"
12D19I31"916;
A1918: A3280 = A3280->A247"
28D49I56"917;
A1915:
A1001( A3130, A1007( A3130, (A49) A3280 ) );"
57D5I59"918;
A1916:
A1001( A3129, A1007( A3129, (A49) A3277 ) );
} "
12D2I2"91"
7D18I39"912: ;
A1910:
return A3315;
}
A62
A3167"
23D28I29"61 )
A62 A2061;
{
A50 *A2563,"
34D7I136";
A8 A1808, A1732;
A62 A3327;
struct A322 *A1752, *A3328;
A58 A1740;
if( A2061 == 0 ) return 0;
A3327 = (*A3164(A3146,A2061));
if( A3327"
18D2I2"11"
12D2I2"12"
7D42I2"11"
49D4I17"3327 == (A54)(~0)"
15D2I2"13"
12D2I2"14"
7D9I27"13: A884( 304, A1061(22) );"
14D22I27"7 = 0; 
A1714:
return A3327"
27D10I96"12:
A1752 = (struct A322 *) (( A3132 )->A988)[A2061];
A1808 = A1752->A324;
A2563 = A1752->A323;
"
16D57
62D1I81"1(A1808);
if( A1808 > 0 && A2563[0] == A411 ) goto A1715;
goto A1716;
A1715:
A512"
8D105I10", A411 );
"
110D163I4" = 1"
168D13I2"21"
28D4I4"1808"
15D1I1"7"
11D2I2"20"
7D2I2"22"
9D2I5" += 2"
12D2I2"21"
8D7I23"7:
{
A50 A1863 = A2563["
12D19I47"];
A512( A3328, A1863 );
A2099 = A2563[A1732+1]"
27D18I14"863 == (A56) 1"
29D2I2"23"
12D2I2"25"
7D91I26"23: A1740 = A3168( A2099 )"
101D2I2"26"
7D30I3"25:"
37D18I1"="
23D12I16"0( (A54) A2099 )"
17D23I7"26:
if("
28D27I47"0 ) goto A1727;
goto A1766;
A1727: A512( A3328,"
34D6I36");
goto A1767;
A1766: A517( A3328 );"
14D57I14"0; 
A1767: ;
}"
66D2I11"22;
A1720: "
12D2I2"68"
8I18"6:
A1732 = 0;
A177"
8D18I12"1732 < A1808"
28D2I2"69"
12D2I2"70"
7D58I23"72: A1732++;
goto A1771"
63D3I25"69:
A2099 = A2563[A1732];"
9D28I8"2099 > 0"
39D2I2"73"
12D2I2"74"
7D4I47"73: A2099 = A3168( A2099 );
goto A1775;
A1774: "
9D79I11"2099 > A412"
90D2I2"76"
12D2I2"77"
7D29I28"76: A2099 = -A3168( -A2099 )"
34D2I2"77"
7D98I3"75:"
104D112I4"2099"
123D2I2"78"
12D2I2"79"
7D45I36"78: A512( A3328, A2099 );
goto A1780"
50D63I38"79: A517( A3328 ); return 0; 
A1780: ;"
72D2I2"72"
7D44I4"70: "
49D7I41"68:
A3327 = A516( A3328 );
(*A3164(A3146,"
12D79I4"1 ))"
85D187I53"27;
return A3327;
}
A5794
A1061(A2118)
A6 A2118;
{
A4"
192D2I50"29;
A6 A1883, A1732;
A81 A1942;
A1883 = 149;
A3329"
7D13I63"670( (A72) ( A1883+1), (A72) ( 1 ) );
A3329[0] = '\0';
sg_sfcat"
18D32I59"29, "code " , A1883);
sg_sfcat( A3329, A976(A2118) , A1883)"
37D1I12"32 = 0;
A171"
9D21I113"1732 < A3140) goto A1711;
goto A1712;
A1714: A1732++;
goto A1713;
A1711:
if( A1732 >= 20 ) goto A1712;
if( A1942 "
26D101I9"43[A1732]"
112D1I1"1"
12D1I1"1"
7D19I12"15:
sg_sfcat"
24D61I36"29, ", symbol = " , A1883);
sg_sfcat"
66D3I23"29, A1942->A129 , A1883"
9D12I1"1"
25D2I2"14"
7D21I4"12:
"
28I60"A3329;
}
A58
A3168( A1740 )
A58 A1740;
{
A58 A3315;
A70 A206"
6D3I51" A3330;
A58 A2970;
A315 A1742;
A7 A3331;
A62 A2061;"
9D46I3"174"
51D38I26"0 ) return A1740;
A3331 = "
45D7
18D12I22" (*A3164(A3144,A1740))"
23D4I27"11;
goto A1712;
A1711:
if( "
11D33I14"= (A54)(~0) ) "
41D2I14"13;
goto A1714"
7D7I25"13: A884(304, A1061(23));"
15D28I25" 24; 
A1714:
return A3315"
33D26I7"12:
if("
35D25I24"(*A3164(A3145,A1740)) ) "
33D61I26"15;
goto A1716;
A1715:
if("
66D3I16"1 <= 0 ) return "
8D53I23";
(*A3164(A3144,A1740))"
58D20I15"315;
A1716:
if("
25D57I10"0 <= 24 ) "
65D41I28"17;
goto A1720;
A1717: A3315"
48D34I1"0"
44D58I11"21;
A1720:
"
63D64I95" = (A315) ((A3131)->A988)[A1740];
A2060 = A1742->A303;
A3330 = A1742->A307;
A2970 = A1742->A306"
70D34
39D29I111" & ( (0x001 | 0x002) | (0x004 | 0x008 | 0x010) | (0x040 | 0x020 | 0x080)) && !(A3330 & 0x400) && A2060 != 27 ) "
37D30I35"22;
goto A1723;
A1722:
{
A58 A1796;"
40D25I3"529"
31D12I8"0, A3131"
17D3I4"1796"
8I23"168( A2970 );
A438 = A3"
19D15I14"32, A1796 );
}"
24D39I13"25;
A1723: if"
46D11I9" <= 24 ) "
19D45I22"26;
goto A1727;
A1726:"
54D19I5"0 == "
30D3I3"766"
12D16I51"767;
A1766: A884( 304, A1061(24) );
A1767:
if( A438"
21D21I3"330"
32D25I23"68;
goto A1769;
A1768: "
39D8I14"32, (A58) A206"
22D2I68"0;
A1769: A3315 = A2060;
A1770: ;
goto A1771;
A1727: switch(A2060)
{"
8D50I45"30:
case 29:
case 31:
case 41:
{
A58 A3305 = "
59D26I8"06;
if( "
33D23I6"= 0 ) "
32D37I1"3"
48D84I2"4;"
89D67I21"3:
if( A2060 == 31 &&"
73D2I45" <= A3128 ||
A2060 != 31 && A3331 <= A3127 ) "
9D40I41"0;
(*A3164(A3144,A1740)) = (A54)(~0);
if("
45D39I9"0 && A330"
51D2I2"75"
12D2I2"76"
7D14I71"75:
{
A58 A3307;
if( A3307 = A529(A1740,A3131) ) goto A1777;
goto A1778"
19D113I16"77:
A3168( A3307"
118D13I41"1778: ;
}
A1776: ;
goto A1779;
A1774: if("
18D3I9"1 <= 0 ) "
10D19I12"0;
A1779:
if"
24D37I137"05 ) goto A1780;
goto A1781;
A1780:
if( A2060 == 31 ) goto A1782;
goto A1783;
A1782: --A3126;
A1783:
if( A3315 == A431->A195 ) goto A1784"
42D2I2"15"
8D8I38"14( A1740, A3315 );
A1784: ;
goto A178"
13D99I7"781:
if"
104D81I5"15 =="
94D2I2"86"
12D2I2"87"
7D4I4"86: "
9D5I3"304"
13D4I27"25) ); A3315 = 24; 
A1787: "
9D67I77"85: ;
}
goto A1772;
case 25:
case 33:
A3126--;
A2970 = A3168( A2970 );
A438 ="
72D9I16"0;
A3315 = A530("
15D79I11", A2970 );
"
87D23I46"72;
case 27:
{
A2970 = A3168( A2970 );
A437 = "
28D110I19"->A314.A312;
A438 ="
115D58I1"0"
63D1I1"1"
11D9I56"27, A2970 );
}
goto A1772;
case 26:
A2970 = A3168( A2970"
14D42I5"437 ="
53D14I25"5;
A3315 = A530( 26, A297"
19D28
36D2I99"72;
case 28:
A3126--;
A2970 = A3168( A2970 );
if( A2061 = A1742->A314.A310 ) goto A1788;
goto A1889"
7D123I23"88:
A439 = A3167(A2061)"
129D36I5"!A439"
47D13I1"7"
18D22I15"889:
A438 = A33"
27D47I69"3315 = A530( 28, A2970 );
goto A1772;
case 39:
case 35:
case 34:
A297"
52D20I74"3168(A2970);
A440 = A3168( A1742->A314.A313 );
A438 = A3330;
A3315 = A530("
26D39I11", A2970 );
"
47D22I19"72;
case 40:
A438 ="
27D32I33"0;
A3315 = A530( A2060, A2970 );
"
40D4I77"72;
case 42:
A3126--;
A2970 = A3168( A2970 );
if( A2061 = A1742->A314.A310 ) "
11D67I3"890"
76D68I16"891;
A1890:
A439"
75D13I114"7(A2061);
if( !A439 ) goto A1772;
A1891:
A438 = A3330;
A3315 = A530( 42, A2970 );
goto A1772;
case 45:
A2970 = A31"
18D11I4"2970"
16D121I21"5420 = (*A3164(A5443,"
126D7I20"->A314.A5418));
A438"
12D74I35"330;
A3315 = A530( A2060, A2970 );
"
82D2I38"72;
case 43:
A3315 = A530( 43, A2970 )"
12D18I38"72;
case 46:
A3315 = A530( 46, A2970 )"
28D2I45"72;
default:
A884(304, A1061(26) );
}
A1772: "
7D29I35"71: ;
A1725: ;
A1721:(*A3164(A3144,"
34D1I119")) = A3315;
A3126 = A3331;
return A3315;
}
struct A1054 *
A3169(A3332)
A54 A3332;
{
struct A1054 *A3333;
if( A3332 < 25"
13D1I1"1"
12D1I1"2"
7D104I13"1: A3332 = 25"
110D12I141"2:
A3333 = (struct A1054 *) A1670( (A72) ( ((A72) sizeof( struct A1054 ) + (A72) sizeof(A55) * (A7)(1+A3332-25))), (A72) ( 1 ) );
A3333->A105"
17D72I32"3332;
return A3333;
}
Void
A3170"
77D53I58"33 )
struct A1054 *A3333;
{
A54 A3332;
A3332 = A3333->A105"
58D100I113"671( (A49) A3333, (A72) ( ((A72) sizeof( struct A1054 ) + (A72) sizeof(A55) * (A7)(1+A3332-25)) ));
}
A55 *
A3164"
105D52I48"33, A1732 )
struct A1054 *A3333;
A54 A1732;
{
if"
57D11I55"32 > A3333->A1055 || A1732 < 0 ) goto A1711;
goto A1712"
16D4I26"11:
A884( 304 , A1061(4) )"
9D4I6"32 = 0"
9D43I41"12:
return (A55 *) (A3333->A1056) + A1732"
54D23I26"171( A3334, A1797, A2060 )"
29D13I38"3334;
A58 A1797;
A70 A2060;
{
A315 A17"
18D1I2"58"
6D9I1"5"
14D15I3"11:"
20D13I5"3334 "
24D1I1"2"
12D1I1"3"
7D2I45"2:
A1742 = (A315) ((A3131)->A988)[A3334];
if("
7D5I34"2->A303 == A2060 && A1742->A307 ) "
14D1I13"4;
goto A1715"
7D1I1"4"
7I8"A3335 = "
12D8I7"4,A3334"
22D8I50"6;
A438 = A1742->A307;
A3335 = A530( 32, A1797 );
"
13D18I22":(*A3164(A3145,A3334))"
23D60I3"335"
65D18I31"71( A1742->A308, A3335, A2060 )"
23D13I35"15:
A3334 = A1742->A309;
goto A1711"
18D13I48"13: ;
}
Void
A3173(A1826)
A81 A1826;
{
A58 A1796"
18D46I34"5 A2575;
A81 A1827;
A70 A2060;
A62"
51D115I31"8;
A39 A1761 = A1826->A168.A166"
122D20I60"1761 != (A39) 7 && A1761 != (A39) 8 ) goto A1711;
goto A1712"
25D52I9"11:
A1796"
57D9I9"826->A130"
14D16I34"75 = (A315) ((A3131)->A988)[A1796]"
22D28I71"(A2060 = A2575->A303) == 29 || A2060 == 30
|| A2060 == 31 || A2060 == 4"
41D13I9"3;
return"
19D19I1"3"
26D12I33"3338 = A3167( A1826->A140.A136 ) "
23D1I1"4"
12D1I1"5"
7D45I8"4:
A1827"
50D49I71"78(
A432, A1826->A129, 0, A3338, NULL, 2,
1 );
goto A1716;
A1715:
A1827"
54D12I26"13( A432, A1826->A129, 2 )"
17D1I14"16:
A1827->A13"
6D63I50"3168(A1796);
A3768( A1826, A1827 );
A7173( A1827 )"
69D6I133"2: ;
}
Void
A3297()
{
A49 *A2026;
A54 A1740, A1808;
A70 A2060;
A58 A3305;
A58 A3315;
A315 A3318;
A315 A1742;
A2026 = A3131->A988;
A17"
12D11I23", A1808 = ( A3131)->A99"
17D4I4"13:
"
10D14I12"740 <= A1808"
25D2I2"11"
12D2I2"12"
7D27I3"14:"
33D3I2"++"
13D2I2"13"
7D4I4"11:
"
11D35I18"42 = (A315) A2026["
40D2I1"]"
13D2I2"15"
12D2I2"16"
7D94I2"15"
100D36I72"(A2060 = A1742->A303) == 29 ||
A2060 == 30 || A2060 == 31 || A2060 == 41"
47D1I1"1"
12D2I2"20"
7D29I56"17:
if( (A3305 = A1742->A306) && (*A3164(A3147,A3305)) )"
38D11I2"21"
21D2I2"22"
7D20I2"21"
27D12I32"3315 = (*A3164( A3145, A1740 )) "
22D2I2"23"
12D2I2"25"
7D12I119"23:
A3318 = ( A7174 = (A3315), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) );
if( A3318->A306 == 0 )"
21D2I14"26;
goto A1727"
7D42I72"26: A3314( A1740, A3315 );
A1727: ;
A1725: ;
A1722: ;
A1720: ;
A1716: ;
"
50D45I2"14"
50D18I77"12: ;
}
Void
A3298(A3296)
A54 A3296;
{
A58 A1740;
A81 A1942;
A7 A3331 = A3126"
23D9I13"40 = 1;
A1713"
16D10I13"1740 <= A3296"
20D2I2"11"
12D2I2"12"
7D13I11"14: A1740++"
23D2I2"13"
7D11I7"11:
if("
20I59"A3145, A1740)) ) goto A1715;
goto A1716;
A1715:
if( A1942 ="
5D17I33"9[A1740] ) goto A1717;
goto A1720"
22D47I33"17:
A3143[0] = A1942;
A3140 = 1;
"
55D13I1"2"
19D16I12"20: A3140 = "
22D2I34"21:
A3126 = 1;
A3168(A1740);
A1716"
14D2I2"14"
7D25I17"12:
A3126 = A3331"
34D2I2"51"
10D7I7"1 )
A62"
12D1I1"1"
7D16I26"0 *A2563, A2099;
A8 A1808,"
24I20"struct A322 *A1752;
"
5I13"1754=0;
A55 A"
6D18
23D7I48"2061 == 0 ) return 1;
A1752 = (struct A322 *) (("
12D7I95"2 )->A988)[A2061];
A1808 = A1752->A324;
A2563 = A1752->A323;
if( A1808 > 0 && A2563[0] == A411 "
37D3I3"1:
"
8D14I4" = 1"
20D1I1"5"
7D14
19D3I8" < A1808"
14D15I3"3;
"
24D8I3"4;
"
13D2I19": A1732 += 2;
goto "
7D26I20";
A1713:
{
A50 A1863"
31D42I4"563["
47D26I57"];
struct A1613 *A1731;
A58 A1740;
A2099 = A2563[A1732+1]"
31D35I31"40 = A2099 > 0 ? (A58) A2099 : "
42D13I6"!A1740"
24D2I2"17"
13D1I1"0"
6D11I3"17:"
17I16" = 1;
goto A1721"
6D14I26"0: if( A1863 == (A56) 1 ) "
22D2I14"22;
goto A1723"
7D45I3"22:"
50D12I40"0 = (*A3164( A3142, A1740 ));
goto A1725"
17D24I4"23: "
30D11I43"731 = (struct A1613 *) A996( A3134, A1740 )"
22D2I2"26"
12D2I2"27"
7D2I62"26:
A3340 = (*A3164( A3142, A1731->A1614 ));
goto A1766;
A1727"
8D9I5"0 = 1"
14D12I41"66:
A1725:
A1721:
if( !A3340 ) return 0;
"
17D4I12"3340 > A1754"
15D2I14"67;
goto A1768"
7D3I11"67: A1754 ="
8D25I74"0;
A1768: ;
} goto A1716;
A1714: ;
goto A1769;
A1712:
A1732 = 0;
A1772:
if"
30D151I33"32 < A1808) goto A1770;
goto A177"
157D137I13"73: A1732++;
"
145D14I2"72"
19D3I25"70:
A2099 = A2563[A1732];"
11D26I6"99 > 0"
37D22I3"74;"
28D21I11"2099 > A412"
32D2I2"75"
12D2I2"76"
7D31I18"75: A2099 = -A2099"
36D29I9"76:
A1774"
37D21I7"099 <= "
33D2I2"77"
12D2I2"78"
7D4I4"77: "
12D12I21"1;
goto A1779;
A1778:"
18D82I33" = (*A3164( A3142, (A54) A2099 ))"
87D4I27"79:
if( !A3340 ) return 0;
"
12D20I9"0 > A1754"
31D2I2"80"
12D2I2"81"
7D4I12"80: A1754 = "
9D91
96D4I16"81: ;
goto A1773"
9D2I2"71"
9D42I23"69:
return A1754;
}
A55"
47D39I54"1( A2069 )
A55 A2069;
{
A55 A1754 = 0;
A54 A1732;
A55 "
44D111I46";
A1732 = 1;
A1713:
if( A1732 <= A3131->A991) "
123D143
152D59I19"2;
A1714: A1732++;
"
67D14I2"13"
19D111I32"11:
if( (*A3164(A3142,A1732)) ) "
120D42I15"4;
if( A2069 ) "
51D11I2"5;"
21D4I2"6;"
9D37I18"5:
(*A3164( A3142,"
42D48I14"2 )) = A2069;
"
57D13I1"4"
19D16I51"6:
if( A3340 = A5139(A1732) ) goto A1717;
goto A172"
23D24I48"7:
(*A3164( A3142, A1732 )) = A3340;
if( A3340 >"
29D7I34"4 ) goto A1721;
goto A1722;
A1721:"
12D27I48"4 = A3340;
A1722: ;
A1720: ;
goto A1714;
A1712:
"
38D58I9"4;
}
Void"
63D12I16"4()
{
A55 A1875,"
17D20I28"4;
A3344 = 0;
A1711:
A1875 ="
25D74I6"1( 0 )"
81D23I12"1875 > A3344"
35D1I1"4"
12D1I1"5"
7D45I16"4: A3344 = A1875"
51D41I41"5: ;
A1712:if( A1875 ) goto A1711;
A1713:"
46D20I2"1("
25D104I44"4+1 );
}
A55
A5139( A1740 )
A58 A1740;
{
A55"
109D47I67"0=1;
A315 A1742;
struct A83 *A1724;
A62 A2061;
A55 A1841;
A58 A2968"
53D21I30"3;
A55 A5142, A5143;
A58 A2970"
27D47I17"!A1740 ) return 1"
52D31I142"42 = (A315) A3131->A988[A1740];
A2970 = A1742->A306;
switch( A1742->A303 )
{
case 31:
case 29:
case 30:
if( A1724 = A3163(A1742->A306) ) goto "
36D50I90";
goto A1713;
A1712:
if( A2061 = A1724->A183.A140.A136 ) goto A1714;
goto A1715;
A1714:
if"
55D163I44"41 = A5141( A2061 ) ) goto A1716;
goto A1717"
169D22I20"6: A3340 = A1841+1;
"
30D14I2"20"
20D22I12"7: A3340 = 0"
27D1I72"20: ;
A1715:
if( A2968 = A1724->A183.A160 ) goto A1721;
goto A1722;
A172"
6D134I96"340 = (!(A5142 = ( A3340)) || !(A5143 = ( A5139(A2968) )) ? 0 : A5142 > A5143 ? A5142 : A5143);
"
142D2I2"23"
7D90I13"22: if( A3343"
95D28I15"724->A183.A161 "
38D2I2"25"
12D2I2"26"
7D36I100"25:
A3340 = (!(A5142 = ( A3340)) || !(A5143 = ( A5139(A3343) )) ? 0 : A5142 > A5143 ? A5142 : A5143)"
41D23I4"26: "
28D73I4"23: "
79D14I3"3:
"
23D1I50"1;
case 25:
case 33:
case 27:
A3340 = A5139(A2970)"
12D30I126"1;
case 28:
A3340 = (!(A5142 = ( A5139(A2970))) || !(A5143 = ( A5141(A1742->A314.A310) )) ? 0 : A5142 > A5143 ? A5142 : A5143)"
41D61I143"1;
case 39:
case 35:
case 34:
A3340 = (!(A5142 = ( A5139(A2970))) || !(A5143 = ( A5139(A1742->A314.A313) )) ? 0 : A5142 > A5143 ? A5142 : A5143"
72D2I82"11;
case 42:
A3340 = A5141( A1742->A314.A310 );
if( A3340 ) goto A1727;
goto A1766"
7D91I102"27: A3340 = (!(A5142 = ( A5139(A2970))) || !(A5143 = ( A3340+1 )) ? 0 : A5142 > A5143 ? A5142 : A5143)"
96D15I4"66:
"
27I39"case 45:
A3340 = A5139( A1742->A306 );
"
9D2I25"1;
default:
goto A1711;
}"
7D25I90"1:
return A3340;
}
static Void
A3345( A1731, A1750 )
A54 *A1731;
A54 A1750;
{
if( A1750 ) "
34D1I13"1;
goto A1712"
9D226I16" *A1731 = A1750;"
231D31I68"2: ;
}
static A60
A3346( A1750 )
A60 A1750;
{
A81 A80;
if( !A1750 ) "
37I2029" A1750;
A80 = (A81) A3118[A1750];
return A80->A169;
}
static A6
A3175(A3347)
A49 A3347;
{
A81 A80 = (A81) A3347;
A81 A2827;
A2827 = A213( A1388, A80->A129, 2 );
A80->A169 = A2827->A169;
if( A2827->A130 && A80->A130 ) goto A1711;
goto A1712;
A1711:
(*A3164( A3144, A80->A130 )) = A2827->A130;
A1712:
return 0;
}
static A6
A3176(A3347)
A49 A3347;
{
A81 A80 = (A81) A3347;
A81 A2827;
A2827 = (A81) A3117[ A80->A169 ];
A3345( &A2827->A130, A3168( A80->A130 ) );
A1449( A2827, A3346( A80->A140.A134 ) );
A3345( &A2827->A155.A146, A3346( A80->A155.A146 ) );
if( A80->A127 & (A27) 0x08 ) goto A1711;
goto A1712;
A1711: A2827->A127 |= (A27) 0x08;
A1712:
A2827->A128 |= A80->A128;
return 0;
}
Void
A8041( A1819 )
struct A633 *A1819;
{
A7 A1730;
A7 A1732;
struct A7671 *A3269, **A8066;
A3152( (A49) &( A1730 ), (A72) sizeof( A1730 ), (A7470)1 ); A8066 = &A1819->A7672; A1732 = 0;
A1713:
if( A1732 < A1730) goto A1711;
goto A1712;
A1714: A1732++;
goto A1713;
A1711:
A3269 = (struct A7671 *) A1005( A8021 );
A3152( (A49) &( *A3269 ), (A72) sizeof( *A3269 ), (A7470)1 );
*A8066 = A3269; A8066 = &A3269->A7696; goto A1714;
A1712: ;
}
Void
A8042( A1819 )
struct A633 *A1819;
{
struct A7671 *A3269;
A7 A1730 = 0;
A3269 = A1819->A7672;
A1713:
if( A3269) goto A1711;
goto A1712;
A1714: A3269 = A3269->A7696;
goto A1713;
A1711:
A1730++;
goto A1714;
A1712:A3153( (A49) &(A1730), (A72) sizeof(A1730), (A7470)1 );
A3269 = A1819->A7672;
A1717:
if( A3269) goto A1715;
goto A1716;
A1720: A3269 = A3269->A7696;
goto A1717;
A1715:
A3153( (A49) A3269, (A72) sizeof(struct A7671), (A7470)1 );
goto A1720;
A1716: ;
}
Void
A8043( A1819 )
struct A633 *A1819;
{
struct A7671 *A3269;
A3269 = A1819->A7672;
A1713:
if( A3269) goto A1711;
goto A1712;
A1714: A3269 = A3269->A7696;
goto A1713;
A1711:
switch( A3269->A7697 )
{
case 1:
A3269->A8913.A8911.A7595 = A3168( A3269->A8913.A8911.A7595 );
A3269->A8913.A8911.A8910 = A3168( A3269->A8913.A8911.A8910 );
goto A1715;
case 2:
goto A1715;
default:
A882(200,43);
goto A5288;
}
A1715: ;
goto A1714;
A1712:
A5288:
return"
Fa9.c
209D4I7"7 A9235"
18D2I1"9"
12I16"A6 A10;
typedef "
291D20
27D4I8"32 A9069"
14I19"A9069 A24;
typedef "
10D4I2"25"
14D9I13"unsigned A890"
21D6I10"9069 A9150"
17D6I10"9069 A9070"
17D8I8"9070 A27"
18D12I9"A9070 A28"
22I21"A9070 A5793;
typedef "
10D4I2"29"
14D17
26D8I5"A6228"
19D6I8"9070 A30"
25D3I8"long A31"
13I17"A17 A32;
typedef "
11D1I1"3"
11D7I12"unsigned A34"
19D5I5"4 A35"
17D5I5"5 A36"
21D1I1"7"
17D1I1"8"
16D2I2"39"
18D1I1"0"
17D1I1"1"
17D1I1"2"
12D6I6"34 A43"
22D1I1"4"
17D1I1"5"
11D7I7"A42 A46"
17I17"int A47;
typedef "
342D2I4"9236"
17D4I2"63"
19D1I3"577"
18D1I1"4"
16D4I2"65"
20D2I2"19"
18D4I4"8258"
14I19"A54 A7616;
typedef "
138D6I3"A16"
60D13I3"A72"
122D6I5"A9069"
20D6I5"A9069"
1373I69"struct A9304
{
A17 A9305;
A5794 A9306;
};
extern struct A9304 A9307;
"
6D4I4"9308"
14D4I4"9309"
17D1I1"5"
11D4I4"5566"
14D4I4"5567"
14D3I17"7618();
Void A761"
8D13
19D3I17"5569();
Void A915"
8D9I10"Void A9152"
14D17I2"74"
22D1I15"0();
Void A7621"
10I41"6226();
A5794 A6227();
A81 A7622();
A58 A"
460D2I4"9070"
28D2I4"9070"
151I19"struct A114 A9153;
"
1389D2I2"92"
16D6I12"5794 A7637()"
15I16"A4 A202;
extern "
3337D2I4"9070"
159I11"A58 A9238; "
88D2I4"9070"
39D2I4"9070"
367I11"A17 A9071;
"
535I13"A9236 A9239;
"
1098D2I4"9070"
380D7I8"17 A9154"
24D1I1"1"
12D6I7"62 A442"
16I17"A4 A443 ;
extern "
150D3I4"9072"
14D10I9"Void A451"
22D9I9"5794 A452"
21D9I9"9036 A453"
29D1I1"4"
13D12
20D1I1"5"
12D9I22"A315 A456 ;
A5794 A457"
28D1I1"8"
18D4I3"459"
21D3I4"5268"
14D16
24D1I1"0"
12I16"A4 A461;
extern "
8D1I1"2"
12D8I11"Void A463()"
22D4I3"464"
13I18"A58 A8823;
extern "
1037D7I10"Void A9155"
18D9I7"A4 A504"
20I20"Void A505();
extern "
1042D2I4"9070"
1940D8I19"struct A640 * A9310"
24D4I3"663"
15D10I9"A48 A7505"
29D2I2"37"
19D3I4"7176"
14D7I9"Void A664"
22D4I3"665"
16D8I7"4 A4442"
19D6I6"A17 A5"
27D3I2"66"
21D2I3"031"
21D1I1"7"
20D1I1"8"
12I20"Void A669();
extern "
278D3I4"4476"
14D10I17"struct A640 *A675"
27D4I4"7719"
21D4I4"8914"
15D8I12"Void A7720()"
18D7I7"17 A933"
18D8I7"7 A5254"
18D2I2"81"
7D1I1"0"
11D2I2"17"
7D1I1"1"
11D1I2"35"
6D1I1"2"
11D1I2"92"
6D1I1"3"
11D2I1"7"
7D1I1"4"
11D8I7"4 A2145"
18D1I2"68"
6D1I1"6"
13D14I6"*A2147"
24D8I7"4 A2148"
18D7I16"2 A2149[M_TOKEN]"
17D2I2"87"
7D1I1"0"
11D2I1"4"
7D1I1"1"
15D4I4"2152"
14D2I2"36"
7D1I1"3"
11D27I7"35 A826"
38D1I2"17"
6D3I1"4"
13D10I28"7
A2155,
A2156,
A2157,
A6214"
19D4I2"A9"
9D1I1"8"
12D10I9"A17 A8825"
27D3I3"215"
15D3I4"Void"
8D1I1"0"
18D4I4"8209"
23D1I1"1"
12D3I4"Void"
8D1I1"2"
12D10I9"A35 A2163"
29D1I1"4"
12D5I4"Void"
10D1I1"0"
12D9I8"A35 A216"
22D7I10"9036 A8211"
24D4I4"5255"
15D4I2"A4"
9D11I16"6();
extern Void"
16I37"7();
extern Void A2168();
struct A216"
465I42"struct A9073
{
A48 A9074;
A9069 A9075;
};
"
422D6I7"8 A9076"
17D9I8"A42 A982"
20D8I9"long A983"
24D4I3"984"
16D8I8"87 A6039"
20D8I8"61 A7724"
19D9I9"A92 A7260"
20D8I9"long A985"
24D4I3"986"
16D9I8"34 A5670"
20I21"A5794 A987();
extern "
1045I7"9129,
A"
44D4I4"9156"
11I42"9157,
A9158,
A9159,
A9160,
A9161,
A8639,
A"
21D10I2"91"
15D2I2"91"
7I29"9164,
A6176, 
A7062,
A7063,
A"
91I21"9240,
A9241,
A9130,
A"
21I28"9165,
A9166,
A9167,
A9168,
A"
28I14"9292,
A9169,
A"
92I42"9242,
A9243,
A9131,
A9132,
A9133,
A9134,
A"
71I7"9170,
A"
307D4I4"9171"
21I42"9244();
extern Void A8266();
extern Void A"
8I80"extern Void A9172();
extern A4 A9173();
extern A4 A9174();
extern Void A9175();
"
746D9I7"4 A9176"
21D7I9"5794 A868"
19D6I6"7 A598"
25D1I1"0"
19D1I1"1"
13D10I7"61 A872"
22D7I10"5794 A6037"
19D10I7"61 A873"
22D7I10"5794 A8589"
20D5I6"8 A874"
16D9I7"A4 A875"
28D1I1"6"
20D1I1"7"
20D1I1"8"
19D2I2"79"
19D4I3"880"
21D4I4"6172"
21D3I4"9293"
20D4I4"9177"
21D4I4"8787"
23D1I1"1"
20D1I2"29"
18D4I4"7262"
23D1I1"2"
20D1I1"3"
20D2I2"48"
21D1I1"4"
20D1I1"5"
18D3I4"5667"
22D1I1"6"
19D2I2"87"
20D2I2"88"
20D2I2"89"
19D4I3"890"
21D4I3"891"
21D4I3"892"
21D4I4"7745"
24D1I1"6"
21D1I1"7"
20I1"4"
18D3I4"7748"
20D4I4"7749"
21D4I3"893"
23D1I1"4"
18D4I4"1857"
22D3I3"958"
22D1I1"5"
19D3I3"061"
20D3I4"5821"
20D4I3"896"
21D3I4"7507"
20D4I3"897"
21D4I4"5981"
23D1I1"8"
19D3I3"750"
20D3I4"8212"
20D3I3"899"
20D3I4"7177"
22D1I1"0"
18D4I3"901"
23D1I1"2"
20D1I1"3"
18D3I4"8944"
22D1I1"4"
18D4I3"905"
21D3I3"907"
21D4I4"9078"
23D1I1"7"
18D3I4"5077"
20D3I4"8267"
20D3I4"8830"
14D7I9"Void A908"
25D2I2"09"
13D9I9"Void A910"
28D1I1"1"
12D9I7"A4 A912"
20D16
24D1I1"3"
14D8I7"4 A5431"
19D11I9"Void A914"
22D10I9"Void A915"
22D11I6"7 A916"
27D2I2"17"
13D9I10"A5794 A918"
27D3I4"1739"
15D6I9"5794 A919"
24D4I3"920"
15D9I9"Void A921"
26D4I3"922"
15D20I14"A5794 A923();
"
31D4I3"924"
16D7I10"5794 A7263"
19D8I8"61 A5668"
19D7I12"Void A5669()"
16D18
26D13I12"7734 A7751; "
21D7I7"4 A7752"
18D18I10"A4 A5914()"
28D6I10"861 A926()"
16D8I6"4 A927"
18D6I8"4 A928()"
15D9I19"struct A849 *A929()"
19D6I9"61 A930()"
16D8I12"9236 A9245()"
18D6I12"9236 A9246()"
15D9I12"Void A9247()"
18D7I18"struct A144 *A5050"
17D8I6"7 A931"
18D6I8"61 *A932"
16D8I6"7 A933"
21D7I7"*A934;
"
14D18I7"A7 A935"
28D7I8"61 *A936"
16D18I7"A7 A937"
27D18I9"A61 *A938"
27D18I7"A7 A939"
28D9I8"61 *A940"
19D9I6"7 A941"
19D9I8"61 *A942"
19D12I10"61 A6038; "
19D11I18"struct A144 *A1696"
23D8I5" A943"
18D10I7"7 A9294"
19D11I18"struct A144 *A7178"
20D17
26D7I8"44 *A717"
17D7I18"struct A144 *A5432"
17D6I9"5794 A944"
15D17I10"A5794 A945"
26D20I12"A5794 A946;
"
27D4I5"A5794"
9D3I1"4"
19D6I4"7180"
15D12I11"A5794 A7227"
21D12I11"A5794 A7181"
22D7I10"5794 A5510"
17D8I7"68 A948"
17D18
26D10I9"114 *A949"
20D7I6"7 A950"
17D7I6"4 A951"
16D10I17"struct A114 *A952"
19D13I20"struct A144 *A7265; "
27D3I3"266"
15D7I10"5794 A1689"
24D4I4"7753"
15D18I10"Void A7754"
30D10I7"6 A1022"
20D10I8"81 A5511"
19D12I9"A81 A8770"
21D12I18"struct A561 *A1023"
21D12I8"A4 A1024"
22D10I7"7 A1025"
19D18I8"A4 A1026"
29D18I9"A49 A1027"
29D10I9"Void A775"
22D10I8"A4 A1028"
27D15I8"1029();
"
21D4I31"9079();
A48 A9080();
Void A9081"
15D21
38D1I1"0"
13D7I8"17 A1031"
18D18I9"A79 A1032"
35D4I4"5671"
15D8I10"Void A5672"
19D9I10"Void A8401"
21D8I8"17 A5512"
19D10I18"struct A561 *A1033"
21D9I10"Void A9135"
20D9I18"struct A561 *A1034"
21D7I10"5794 A1035"
18D47I10"Void A2317"
58D9I10"Void A5673"
20D9I10"Void A1036"
20D9I10"Void A1037"
20D11I18"struct A561 *A1038"
22D8I6"A4 A56"
21D9I18"struct A561 *A1039"
20D11I10"Void A7182"
22D18I10"A4 A7183()"
27D10I9"A58 A8268"
22D7I28"78 A1040();
extern Void A775"
12D6I49"extern A81 A1041();
extern A81 A7508();
extern A4"
11D3I49"7();
extern A5794 A8590();
struct A7758 *A7759();"
12D51I3"0()"
60D18I11"A78 A1042()"
28D8I10"78 A5271()"
18D8I10"78 A1043()"
18D8I12"5972 A1044()"
17D9I12"Void A2274()"
18D17I42"A54 A5433();
extern A9036 A9039();
extern "
26D106I9"44 *A5434"
116D7I12"9150 A9178()"
16D13I32"Void A7761();
extern A48 A7906()"
23D31I63"7758
{
A40 A7762;
A87 A7763, A7764;
A17 A7765, A7766;
A67 A7767"
43D21
29D11I10"7758 A7768"
20D79I9"A87 A7769"
88D12I9"A87 A7770"
21D12I9"A88 A7771"
21D12I9"A10 A7772"
21D43I17"const A88 A7773;
"
52D19I43"045
{
A18 A1046;
A72 A1047;
A7470 A1048;
A3"
24D2I58"49;
};
struct A1050
{
A18 A1051;
A17 A1052;
A5794 A1053;
}"
12D7I7"7 A3140"
17D34I14"81 A3143[20];
"
43D9I33"054
{
A54 A1055;
A55 A1056[25];
}"
19D8I9"55 *A3164"
19D11I19"struct A1054 *A7509"
20D78
86D209I12"144 *A7774;
"
217D10I51"7500
{
struct A7500 *A7775; A54 A7510; A42 A7511; }"
19D9I12"Void A1057()"
18D8I12"Void A1058()"
17D9I10"Void A1059"
20D8I10"Void A1060"
19D10I11"A5794 A1061"
21D22I18"struct A118 *A1062"
33D13I8" A1063;
"
20D13I8"A4 A7267"
26D4I4"7776"
14D10I8"63 A7777"
19D21
29D3I3"114"
8D2I2"64"
11I40"A81 A7512();
extern A49 A1073();
extern "
8D2I66"74();
extern A72 A1075[];
extern A9036 A1076();
extern A9036 A7778"
14D94I118"3097
{
A70 A3098; A72 A3099; A7468 A3100; A7468 A3101; A72 A3102; A72 A3103; A72 A3104; A7 A3105; A4 A3106; A7 A5282; "
100D5I85"283; A32 A5284; A74 A5966; A17 A6270; };
extern A81 A3107;
extern A315 A3108;
extern "
13D55I62"3097 A3109;
extern A58 A3110;
extern A4 A6067;
extern A72 A311"
60D10I14"extern A6 A311"
15D45
52D11I14"Void A1077();
"
19D7I21"48 strcat(), strcpy()"
17D9I14"48 strncpy(); "
16D11I13"int strncmp()"
24D4I4"1078"
15D8I7"2 A7268"
27D2I2"79"
13D12I18"struct A553 *A1080"
21I17"A7 A9295;
extern "
6D67I3"108"
72I66"struct A553
{
struct A553 *A1082;
A7 A1083;
struct A114 A1084;
};
"
15D81I1"8"
86D75I59"struct A5513
{
A81 A5514;
struct A147 *A5515;
};
A5972 A777"
80D39I10"A5972 A778"
44D17I10"A5972 A778"
22D16I10"A5972 A778"
21D16I10"A5972 A778"
21D16I10"A5972 A778"
21I15"A5972 A7785();
"
7D14I11"A74 A6242; "
21D12I8"A7 A1086"
21D12I8"A7 A7184"
21D12I11"A5794 A5248"
25D6I4"7185"
15D10I10"A95 *A1087"
27D4I4"1088"
21D4I4"1089"
21D4I4"7186"
21D3I3"109"
21D4I4"7187"
15D10I11"A5794 A1091"
21D9I10"Void A1092"
27D3I3"093"
20D4I4"8269"
20D3I3"094"
14D10I8"A4 A1095"
21D10I8"A4 A1096"
28D3I3"097"
20D4I4"1098"
16D10I7"4 A1099"
21D10I11"A94 * A5272"
21D9I10"A94 * A110"
21D10I11"A94 * A1101"
29D2I2"02"
19D4I4"1103"
15D11I10"Void A1104"
30D2I2"05"
21D2I2"06"
19D4I4"5675"
21D4I4"6243"
15D10I8"A4 A5518"
27D4I4"7786"
21D4I4"5516"
21D4I4"5517"
21D4I4"5519"
22D3I3"520"
14D18I12"Void A5521()"
27D17
23D4I4"5522"
15D10I9"A23 A7787"
21D8I10"Void A1107"
19D10I10"Void A1108"
22D10I7"4 A1109"
21D11I10"Void A1110"
22D11I10"Void A1111"
22D11I10"Void A1112"
22I21"Void A2942();
extern "
7D4I4"1113"
15D55I12"Void A2949()"
64D13I12"Void A7070()"
22D9I12"Void A1114()"
18D10I12"Void A1115()"
19D9I12"Void A7269()"
19D8I12"94 * A1116()"
17D9I12"Void A1117()"
18D18I12"Void A1118()"
27D18I12"Void A1119()"
27D26I12"Void A7788()"
35D8I12"Void A5676()"
17D18
26D2I2"20"
21D2I2"21"
21D2I2"22"
13D9I10"Void A8270"
26D4I4"5249"
15D10I18"struct A144 *A5523"
19I17"A7 A5822;
extern "
6D4I4"7789"
21D4I4"7790"
19D4I4"7791"
15D10I10"A94 *A7792"
21D10I11"A5794 A7793"
22D7I10"5794 A7794"
19D7I10"5794 A7795"
18D10I11"A5794 A7796"
22D8I10"5794 A7797"
20D2I4"5794"
7D3I45"8();
struct A5304 { A77 A3049; A5794 A1148; }"
12D12I13"A2 A1123[100]"
21D12I9"A17 A1124"
21D12I10"A13 *A1125"
21D12I9"A81 A1126"
23D9I7"8 A1127"
19D1I1"5"
6D4I2"28"
13D11I18"struct A144 *A1129"
20D11I18"struct A144 *A1130"
20D11I26"const struct A5304 A3050[]"
21D10I7"4 A1131"
20D17I8"38 A1132"
26D45I9"Void A113"
65D1I1"3"
21D1I1"3"
13D9I8"A17 A113"
29D1I1"3"
13D10I8"A4 A2979"
29D1I1"3"
19D3I3"917"
23D2I2"39"
13I19"A4 A1140();
extern "
8D1I1"4"
6D124I231"extern Void A5529();
extern A4 A5530();
extern A7 A5532();
extern Void A5533();
extern A66 A5534();
extern A66 A7799();
extern Void A5531();
extern Void A1142();
extern Void A1143();
extern Void A1144();
extern A50 A1145();
extern "
131D339I15"46();
extern A7"
344D13I118"47();
extern A48 A1148();
extern A48 A1149();
extern A77 A1150();
extern A58 *A5067, *A5068;
extern A17 *A8945, *A8946"
22D4I6"8271()"
15D5I193"53();
extern Void A1154();
extern Void A1155();
extern Void A1156();
extern Void A1157();
extern Void A5823();
extern Void A1158();
extern Void A1159();
extern Void A1160();
extern Void A1161()"
15D4I4"8402"
15D19
25D4I75"8403; A54 A8404; A13 *A8405; A7468 A8406; A72 A8407; A58 *A8408;
A58 *A8409"
19D52I1"6"
57D1I1"7"
6D56I4"63;
"
61D10I229"
A7132,
A7133,
A1164,
A1165,
A1166,
A1167,
A1168,
A1169,
A1170,
A1171,
A1172,
A1173;
A13 A1174[ (2000 / CHARLEN) ];
A18 A5435;
A17 A6040;
A13 A7800[ (2000 / CHARLEN) ];
A61 A6041;
A17 A6042;
} ;
extern A13 A9180[(2000 / CHARLEN)]"
20D4I4"9248"
14D88I6"9249; "
95D17I17"9296; A17 A9250; "
24D6I6"9251; "
13D6I19"9297; FILE *A9252; "
16D9I18"struct A9248 A9253"
18D127I14"Void A9254();
"
135D27I104"391
{
struct A633 *A1175;
struct A144 *A1176;
struct A144 *A1177;
struct A144 *A1178;
};
struct A1179
{
"
32D262I91"180;
A53 A1181;
A17 A1182;
A53 A1183;
A5794 A1184;
A5794 A1185;
};
struct A1186
{
struct A8"
267D31I5"187;
"
40D27
33D12I8"188;
};
"
21D18I6"189
{
"
26D71I105"640 *A1190;
A5794 A1191;
};
struct A1192
{
A17 A1193;
A9 A1194;
A70 A1195;
};
struct A1196 { A2 A1197[3];"
77I833" *A1198; };
struct A1199
{
A5794 A1200;
A35 A1201;
A42 A1202;
};
Void A1203();
Void A1204();
Void A1205();
struct A5677
{
A5794 A5678;
A42 A5679;
A5794 A5680;
A5794 A5681;
};
extern A17 A6244;
extern long A7418;
extern A49 *A1206;
extern A49 *A1207;
extern A2 A1208[ARG_LEN];
extern A42 A8197; extern A2 A3496[ARG_LEN];
extern struct A1196 A1209[];
extern const A6 A1210;
extern A7 A5406;
extern A7 A5407;
extern A7 A6210;
extern A42 A1211;
extern A4 A1212;
extern A72 A1213;
extern A72 A1214;
extern A18 A1215;
extern A18 A1216;
extern A4 A7228;
extern A61 A1217;
extern A61 A1218;
extern A67 A1219;
extern A13 *A6043;
extern A13 *A1220;
extern A13 *A1221;
extern struct A1162 A1222;
extern struct A144 *A1223;
extern struct A144 *A1224;
extern struct A144 *A1225;
extern A48 A1226;
extern A7 A1227;
extern A9070 A1228;
extern UFLAG"
1095I7"9298,
A"
2534D19
33D4I4"9255"
14D7I9"2 A7190[]"
16D8I18"struct A144 *A1398"
21D4I4"1399"
14D8I7"4 A7807"
18D7I6"7 A621"
21D7I6"9181; "
15I1"1"
6D1I1"0"
11D1I2"68"
6D1I1"1"
11D1I1"4"
6D1I2"2 "
11D1I1"7"
6D1I1"3"
10D4I2"A7"
9D3I1"4"
12D4I2"A7"
9D3I1"5"
12D4I2"A4"
9D3I1"6"
12D9I10"Void A1407"
20D9I10"Void A1408"
26D4I4"1409"
17D6I7"8 A1410"
17D10I9"A58 A1411"
21D8I10"Void A8257"
19D10I8"A4 A8411"
27D4I4"5063"
15D4I2"A6"
9D1I1"2"
12D2I4"Void"
7D1I1"3"
18D4I4"1414"
21D4I4"1415"
15D10I8"A4 A1416"
21D19I10"Void A5687"
36D4I4"5688"
15D10I10"Void A5689"
21D10I19"struct A5677 *A5690"
30D1I1"7"
12D10I10"A13 *A5396"
21D10I9"Void A141"
28D4I4"1419"
21D4I4"6052"
15D10I11"A5794 A7808"
30D1I1"4"
18D4I4"5545"
21D4I4"5546"
15D8I10"Void A5547"
19D2I4"Void"
7D1I1"0"
12D2I4"Void"
7D25I1"1"
36D9I7"A4 A624"
21D9I9"A48 A9182"
20D9I8"A4 A1422"
20D4I2"A4"
9D12I5"3();
"
26D5I6" A1424"
16D10I12"Void A3500()"
19D8I10"Void A1425"
19D8I9"int A3493"
19D10I9"int A3494"
27D4I4"1426"
15D10I19"struct A1189 *A1427"
21D12I10"A13 *A8273"
22D7I6"4 A599"
19D9I7"A4 A599"
21D8I10"Void A9311"
27D2I2"28"
13D12I10"Void A7191"
31D2I2"29"
13D8I10"Void A6080"
25D4I4"9183"
15D10I9"A54 A1430"
21D1I1"V"
6D4I4"1431"
15D10I8"A4 A7475"
30D1I1"2"
12D9I12"UFLAG *A1433"
29D1I1"4"
12D10I8"A4 A1435"
29D2I2"36"
13D1I1"v"
6D4I4"6246"
15D1I1"v"
6D4I4"7809"
21D4I4"1437"
23D2I2"38"
14D10I10"34 A5691()"
19D20
28D2I2"39"
19D4I4"1440"
15D10I12"Void A1441()"
19D17
26D1I1"2"
21D1I1"3"
12D11I10"Void A5773"
30D2I2"44"
13D12I11"A5794 A1445"
21I20"A5794 A1446;
extern "
6D4I4"1447"
21D4I4"3532"
15D12I10"A2 A3526[]"
21I17"A4 A3527;
extern "
6D2I2"14"
21D4I4"1449"
15D10I11"A5794 A1450"
30D1I1"1"
18D4I4"1452"
15D10I8"A4 A9184"
27D4I4"5274"
21D73I6"1453()"
82D19I12"Void A5651()"
28D20I12"Void A5548()"
29D20
26D4I130"3443();
extern Void A6072();
extern Void A1454();
extern Void A3363();
extern Void A1455();
extern Void A1456();
extern Void A5107"
17D89I65"065
{
A67 A1066;
A5794 A1067;
A5794 *A1068;
A17 A1069;
};
extern "
97D44I20"1065 *A1070;
extern "
52D40I53"1065 A1071[];
extern A67 A1072[];
extern Void A6209()"
53D12I85"
{
A79 A547;
A79 A548;
A79 A549;
A79 A6232;
A79 A5661;
A87 A6233;
A87 A5662;
A23 A552"
23D16I24"53 *A554, *A555, *A6234,"
21D1I12"63, *A557;
}"
11D29I14"93
{
A17 A8274"
34D35I21"98 A8275;
A8198 A8276"
50D44I10"8277[1];
}"
54D41I6"561
{
"
56D4I165"62;
struct A561 *A563;
A40 A564;
A40 A565;
A81 A566;
A58 A567;
A42 A568;
A68 A569;
struct A147 A570;
A17 A571;
A24 A572;
A61 A573;
A96 *A574;
struct A1537 * A7443;
}"
13D11I8"A81 A575"
20D9I17"struct A561 *A576"
28D1I1"7"
18D2I1"5"
22D2I2"79"
19D3I4"8278"
22D1I1"0"
20D1I1"1"
19D3I2"82"
22D9I1"3"
20D7I10"Void A5664"
18D19
27I65"4(), A585();
extern A4 A586();
extern A4 A5665();
extern Void A58"
1854I50"9136
{
struct A9136 *A9137; A17 A9138; };
struct A"
109D9I19"struct A9136 *A9139"
18D18
26D9I10"9136 A9140"
19D9I8"58 A7273"
18D4I3"A17"
9D3I1"4"
12D11I17"struct A588 A1719"
20D4I2"A2"
9D3I3"6[]"
20D2I2"77"
13D10I9"A89 A1978"
29D2I2"79"
19D4I4"1980"
21D4I4"7274"
24D1I1"1"
13D8I7"4 A9185"
19D18I8"A4 A9186"
35D4I4"5897"
24D1I1"2"
12D3I4"Void"
8D1I1"3"
12D10I9"A72 A1984"
21D10I18"struct A561 *A1985"
27D3I3"914"
23D2I2"86"
21D2I2"87"
13D27
33D26I4"9142"
37D10I9"A78 A1988"
27D4I4"1990"
21D4I4"1989"
21D4I4"1991"
15D8I10"Void A1992"
25D4I4"1993"
15I27"struct A144 *A7824; extern "
6D4I26"5553();
struct A147 *A7825"
23D2I2"26"
19D4I4"7827"
21D64I6"7828()"
73D8I10"Void A7829"
20D7I7"4 A7830"
18D9I12"Void A8412()"
18D9I12"Void A7831()"
18D9I12"Void A7832()"
18D19I12"Void A8413()"
28I14"Void A8414();
"
8D20I7"1457
{
"
26D12I4"58;
"
18D3I25"59;
A4 A1460;
A9 A1461;
}"
12D19I10"A9 A1461()"
28D18I10"A9 A1462()"
28D1I1"9"
6D1I1"3"
11D19I8"A4 A1464"
30D9I7"4 A1465"
19D20
28D11I10"83 **A5078"
21D9I18"struct A83 **A5079"
25D2I2"66"
13D9I7"4 A1467"
19D3I11"struct A144"
8D2I2"68"
12D11I18"struct A144 *A7476"
21D9I7"4 A1469"
19D10I19"struct A640 **A3651"
20D9I18"struct A640 **A365"
21D8I9"17 *A1470"
19D8I9"68 *A1471"
26D13I14"640 **A1472 ;
"
22D7I7"3 A1473"
18D11I7"4 A1474"
22D7I9"13 *A1475"
18D7I9"13 *A1476"
18D7I9"13 *A1477"
18D4I2"53"
9D2I2"78"
13D2I2"68"
7D2I2"79"
12D9I3"A17"
15D1I1"0"
12D1I2"57"
6D1I1"1"
11I19"A57 A3660 ;
extern "
17D3I4"5 ; "
11D10I8"57 A1482"
22D6I10"036 *A1483"
17D10I7"4 A1484"
20D18I8"A4 A8214"
29D8I7"4 A1485"
19D7I11"9036 *A1486"
18D7I9"81 *A1487"
17D8I16"const A81 *A1488"
19D7I7"6 A1489"
25D11I10"144 *A7276"
21D4I4"9036"
9D1I1"0"
11D17I8"A9 A1491"
27I21"A9036 A1492 ;
extern "
8D9I10"640 *A1493"
19D17I9"A63 A1494"
27D17I8"A4 A1495"
28D8I7"4 A1496"
22D4I4"5825"
18D4I5"1497 "
21D8I9"640 *A149"
19D12I12"A5794 A1499 "
21D12I18"struct A83 *A1500 "
21D10I18"struct A83 *A1501 "
19D13I18"struct A83 *A1502 "
22D10I18"struct A83 *A5080 "
20D9I9"53 A1503 "
18D12I9"A4 A1504 "
21D12I8"A4 A6247"
21I27"struct A83 *A6248 ;
extern "
6D4I4"9040"
23D2I2"05"
14D7I7"4 A1506"
18D10I11"A5794 A1507"
21D9I10"Void A7451"
20D10I8"A4 A7833"
22D8I7"4 A6249"
25D4I4"6250"
23D2I2"08"
13D8I10"Void A1509"
28D1I1"0"
12D4I2"A6"
9D1I1"1"
21D1I1"2"
12D10I9"A68 A1513"
21D7I9"Void A151"
20I203"81 A5692();
extern Void A8215();
extern Void A1515();
extern A4 A1516();
extern Void A1517();
extern Void A1518();
extern Void A1519();
extern Void A1520();
extern A4 A3738();
extern A4 A7834();
extern A"
561D1I1" "
11D1I1" "
11D1I1" "
10D1I1" "
10D1I1" "
10D1I1" "
848D4I4"9082"
15D19I10"Void A9083"
30D19I10"Void A9084"
30I21"Void A3863();
extern "
17D2I2"89"
13D10I19"struct A1537 *A1590"
21D10I19"struct A1537 *A1591"
27D2I2"71"
21D4I4"1592"
21D4I4"1593"
15D9I10"Void A7841"
29D1I1"2"
12D4I3"A74"
9D1I1"7"
18D4I4"7843"
21D4I4"8218"
15D9I10"Void A8219"
29D1I1"5"
13I1"7"
6D1I1"6"
12D3I4"Void"
8D1I1"7"
12D10I8"A4 A7848"
21D10I9"A74 A7849"
21D1I1"V"
8D24I4"94()"
33D9I4"void"
14D1I3"1()"
10D4I4"void"
9D9I17"2();
typedef A22*"
14I57"3;
extern const A51 A1524;
extern long A1525;
struct A152"
1445D10I8"A4 A9085"
27D4I4"3763"
15D9I10"Void A8835"
21D2I2"35"
7D1I3"4()"
10D11I3"A58"
16D1I1"5"
10D2I11"struct A147"
7D3I1"6"
12I19"A4 A3767();
extern "
2788D2I4"9070"
433D8I10"Void A9086"
19D9I9"A74 A9087"
28D1I1"6"
12D8I9"Void A737"
19D9I8"A4 A4551"
20D9I9"Void A738"
25D3I4"4724"
14D10I8"A58 A741"
29D1I2"77"
20D1I1"3"
18D4I3"744"
15I21"Void A8202();
extern "
1326D1I1" "
15D1I1" "
11D1I1" "
2390D2I4"9070"
215D2I4"9070"
12D1I2"72"
52D4I4"9088"
1788D4I4"9312"
14I14"9313();
Void A"
1606D4I4"9314"
10D3I10"Project";
"
17D4I4"9315"
10D3I12"ItemGroup";
"
17D4I4"9316"
10D3I12"ClCompile";
"
17D4I4"9317"
10I7"Include"
11D10I10"7615 A5181"
15D38I4"""; "
46D10I10"7615 A5182"
15D38I4"""; "
46D10I10"7615 A5898"
15D1I16"""; static A7615"
6D2I22"6[] = "";
static A5794"
7D2I7"7[] = {"
7D1I1"0"
6D2I16"47, A5448, A5449"
28D2I2"58"
27D1I1"2"
33D3I3"459"
12D9I2"45"
14D2I2"45"
7D3I10"453, A5455"
28D3I3"460"
12D9I2"45"
14D2I2"45"
7D3I10"454, A5455"
30D1I1"3"
32D2I2"78"
29D1I1"4"
33D1I1"9"
28D1I1"5"
33D1I1"4"
28D1I1"6"
33D1I1"6"
25D4I4"5187"
33D3I3"516"
31D1I1"8"
32D9I2"62"
33D4I4"7486"
33D11I4"7485"
37D2I2"89"
41D1I1"8"
28D1I1"0"
39D2I2"80"
27D3I3"191"
40D3I3"172"
30D1I1"2"
39D2I2"73"
27D3I3"758"
40D3I3"757"
30D1I1"3"
40D1I1"7"
28D1I1"4"
32D2I9"71, A5168"
29D1I1"5"
18D9I2"60"
14D2I2"61"
8D1I8"1, A5163"
26D3I3"196"
20D9I2"60"
14D2I2"61"
7D9I2"80"
34D3I3"197"
26D3I3"456"
16D8I1"9"
33D3I3"934"
49D1I1"9"
28D1I1"5"
45D10I3"180"
35D3I3"199"
47D10I3"177"
37D1I1"6"
52D3I3"179"
27D4I4"5937"
57D8I1"8"
32D9I9"5938[] = "
55D10I3"933"
36D7I7"19[] = "
61D2I2"73"
14D23I5"atic "
30D27I4"8520"
33D41I55" A5159, A5174, A5898, A5175, A5176, A5932, A5171, A5178"
47D1I1" "
6D16I16"atic A5794 A8521"
22D88I54" A5159, A5174, A5898, A5175, A5176, A5932, A5171, A518"
95D1I1" "
6I61"atic A5794 A9318[] = { A9314, A9315, A9316, A9317, NULL };
st"
10I5"
{
A9"
5D1I37"1;
A5794 A5202;
};
struct A5200 A5203"
9D1I1"1"
6D6I29"UNICODE;UNICODE",
'2', "_MBCS"
37D1I1"4"
9D1I1"0"
6D24I7"MT",
'1"
29D3I22"MT;_DEBUG",
'2', "_MT;"
10I39"'3', "_MT;_DEBUG;_DLL",
'5', "_DEBUG",
"
11I134"struct A5200 A5205[] =
{
'2', "_WINDLL",
0, NULL
};
struct A5200 A5206[] =
{
'1', "_ATL_STATIC_REGISTRY",
'2', "_ATL_DLL",
0, NULL
};
"
652I8"(A7470) "
441I123"NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
"=== Multiple Modules: " ,
"=== Pattern file: " ,
"=== SLN file: " ,
"
170D2I4"9070"
100D2I4"9070"
117I27"16:
case 17:
case 18:
case "
702I27"case 16:
case 17:
case 18:
"
1803D2I4"9070"
34D2I4"9070"
12D2I4"9070"
12D2I4"9070"
80D2I4"9070"
55D2I4"9070"
26D2I4"9070"
96D2I4"9070"
98D2I4"9070"
12D2I4"9070"
1182D5I9"nsigned32"
395I33"9070 A4348;
A6 A9291; A4 A4467;
A"
24D5I6"!A1819"
38D52I24" A882(200,101); return; "
57D68I10"2:
A4348 ="
79D5I144"6;
A9291 = A4348 & (A9070) 0x20000000 ? 16 :
A4348 & (A9070) 0x10000000 ? 17 :
A4348 & (A9070) 0x40000000 ? 0 : 3;
if( A4348 & (A9070) 0x2000000"
18D1I1"3"
12D1I1"4"
7D29I29"3: A4467 = (A4) 0;
goto A1715"
35D8I28"4: A4467 = (A4) 1;
A1715:
if"
13D27I3"36 "
38D1I1"6"
11D2I2"17"
8D26I20"6:
if( A9291 ) goto "
31D21I43";
goto A1721;
A1720: A1414( A9291, 0, A1886"
27D92I17"721:
if( A4467 ) "
101D1I13"2;
goto A1723"
6D29I18"22:
A1330 = (A4) 1"
38D7I2"09"
19D1I1"5"
12D1I1"6"
7D12I10"5: ++A1232"
18D2I26"6:
pipe_out( 'M', A1886 );"
8D15I15"1819->A635 == 0"
27D1I1"7"
11D1I1"6"
8D12I29"7:
A1819->A635 = A1430(A1819)"
17D16I3"66:"
21D20I3"1( "
25D43I8"->A635 )"
49I1"("
6I4"> 0)"
10D1I1"6"
13D1I1"8"
6D11I25"67: A1013( A1389, A3373 )"
17D22I22"8:
A1013( A1129, A3373"
28D32I92"512( A1886 );
A1156();
A474( A1819->A635 );
A8257();
A1212 = (A4) 1;
A1013( A1398, A3372 );
"
41D13I1"9"
18D25I18"23:
A1517( A1886 )"
30D51I5"69: ;"
60D12
19D73I48"17:
{
A7 A3374;
A3374 = A1376;
if( A1376 == 1 ) "
85D17I10"goto A1772"
26D56I5"A1376"
63D22I139"1772:
if( A7188.A1180 >= 2 ) goto A1773;
goto A1774;
A1773: A1377 = 2;
A1774:
A1517(NULL);
if( A4467 ) goto A1775;
goto A1776;
A1775:
A3362"
27D10I4"1508"
15D17I43"1157(A1819);
A1776:
A1212 = (A4) 0;
A1376 ="
22D24I74"4;
A1377 = 0;
if( A9291 ) goto A1777;
goto A1778;
A1777: A1414( -A9291, 0,"
29D68I10" );
A1778:"
74D27I28"4467 ) goto A1779;
goto A178"
32D23I4"779:"
29D26I29"1309 ) goto A1781;
goto A1782"
31D11I49"81: --A1232;
A1782:
pipe_out( 'E', NULL );
A1780:"
17D52I100"7189 ) goto A1783;
goto A1784;
A1783:
{
struct A1162 *A1731;
A1731 = (struct A1162 *) A996( A7178, 1"
60D25I167"A1731 )
goto A1785;
goto A1786;
A1785:memcpy((A49)( &A1222),(A49)( A1731),(size_t)( sizeof( struct A1162 ) ));
goto A1787;
A1786:
A865(1233);
A1787: ;
}
A1784:
A1330 ="
34D114I41"}
A1770:
A3367 = A422 = A3368 = 0;
A728 ="
121D2I108"5794 A3375();
A5794 A3376();
A48 A5054();
A9036 A3377();
static A17 *A3378 = NULL;
static A17 *A3379 ARB;
A4"
7D91I44"0()
{
A5794 A1850, A1851;
A36 A1753;
if( A21"
96D9I46"!= 21 ) return (A4) 0;
A1850 = A3375( A3376() "
17D42I26"2142 != 11 ) return (A4) 0"
47D4I16"53 = A2153;
if( "
11D51I9" != 21 ) "
58D76I32"(A4) 0;
A1851 = A3375( A3376() )"
82D15I16"!A1850 || !A1851"
24D17I8" (A4) 0;"
22D190I26"A5299(A1850,A1851) == 0 ) "
196D11I225" A1753 == (A36) 10 ? (A4) 1 : (A4) 0;
return A1753 == (A36) 11 ? (A4) 1 : (A4) 0;
}
A48
A3381()
{(void) ((A1463=(A9)(A15)(*A1492++)) ? ((A1463 == (A9)(A15)('\\'))?A1462():A1463) : A1461() );
A2161();
if( A1095( 8 ,(A35) 0) ) "
20D3I8"1;
goto "
8D47
52D16I13"11:
A2161();
"
25D13I1"3"
18D23I25"12: strcpy( A2149 , "?" )"
29D3I56"3:
return A2149;
}
Void
A3382( A1737 )
A48 A1737;
{
A48 "
8D6I12";
A9 A1833;
"
11D40I3" = "
45D54
60D6I15"*++A2070 != '('"
15D30I17";
++A2070;
A1713:"
35D89I8"*A2070 !"
94D1
31D80I55"4: A2070++;
goto A1713;
A1711:
A1833 = (A9)(A15)(*A2070"
87D6I85"((islower(A1833) || isupper(A1833)) || isdigit(A1833) || (A1833)=='_') ) goto A1715;
"
12D15
21D10I39"5: ;
goto A1714;
A1712:
*A2070 = '%';
*"
15D92I33" = '%';
A2070 = A1737 + 1;
A1720:"
97D28I6"*A2070"
39D1I1"6"
12D1I1"7"
6D95I11"21: A2070++"
105D2I2"20"
8D35I23"6:
A2070[0] = A2070[1];"
44D14I2"21"
20D43I133"7: ;
}
A5794
A3375(A1737)
A5794 A1737;
{
A2 A3295[50];
A81 A80;
A72 A1883;
if( !A1737 ) return A1737;
A1883 = ((A72) strlen(A1737));
"
49D12I48"883 > (50-3) ) return A1737;
if( A1737[0] == '$'"
18D3I13"737[1] == '('"
9D10I18"737[A1883-1] == ')"
23D1I1"1"
11D2I2"12"
8D114I82"1:
strcpy( A3295, A1737 );
A3295[A1883-1] = '\0';
A80 = A213( A1502, A3295+2, 1 );"
120D37I25"80 ) return A80->A155.A14"
43D12I128"12:
return A1737;
}
A4
A3383(A3295)
A48 A3295;
{
return strcmp(A2149,A3295) == 0;
}
Void
A3384()
{
A9 A3385;
if( A2142 == 17 && "
17I54" == '"' ) goto A1711;
goto A1712;
A1711:(void) ((A1463"
80D7I10"goto A1713"
13D2I59"2: if( A2142 == 21 || A2142 == 15 ) goto A1714;
goto A1715;"
7D15I2"4:"
20D37I48"5 = A2142 == 21 ? '"' : '\'';
A1716:if( A1463 !="
42D135I27"5 && A1463 && A1463 != '\n'"
147D1I1"7"
11D2I2"20"
8D19I114"7:(void) ((A1463=(A9)(A15)(*A1492++)) ? ((A1463 == (A9)(A15)('\\'))?A1462():A1463) : A1461() ); goto A1716;
A1720:"
24D49I15"A1463 == A3385 "
59D2I2"21"
12D2I2"22"
7D23I95"21:(void) ((A1463=(A9)(A15)(*A1492++)) ? ((A1463 == (A9)(A15)('\\'))?A1462():A1463) : A1461() )"
28D102I4"22: "
108D2I64"5:
A1713:A2161();
}
A4
A3386(A3295)
A48 A3295;
{
A3384();
return"
7D1I79"3(A3295);
}
Void
A3387( A3388 )
A48 A3388;
{
A5794 A1737;
A5794 A1859;
A4 A3047"
9D3I51"0;
A4 A3389 = (A4) 0;
A2161();
if( A2161() == 21 ) "
11D2I14"11;
goto A1712"
7D9I42"11:
A1737 = A3376();
if( !A1737 ) return;
"
16D6I25" A1737;
A1715:
if( *A1859"
16D2I2"13"
12D2I2"14"
7D16I3"16:"
22D2I14"++;
goto A1715"
7D32I2"13"
38D45I69"(*A1859==' '||*A1859=='\t'||*A1859=='\n'||*A1859=='\f'||*A1859=='\r')"
56D2I2"17"
13D1I1"0"
6D9I9"17: A3389"
20D19
28D13I1"1"
19D16I45"0: if( *A1859 == '$' ) goto A1722;
goto A1723"
21D23I3"22:"
28D17I36"2( (A48) A1859 );
A1723: ;
A1721: ;
"
25D14I2"16"
19D36I3"14:"
41D5I45"*A3388 == 'd' && strcmp(A1737,"_AFXEXT") == 0"
16D2I2"25"
12D2I2"26"
7D25I3"25:"
32I27"= (A4) 1;
A1726:
if( A3047 "
10D2I2"27"
12D2I2"66"
7D2I2"27"
11D24I3"/* "
32D9I24"66:A1664( '-' );
A1666( "
15D41I15");
if( A3389 ) "
49D2I2"67"
12D2I2"68"
7D2I2"67"
7D45I5"4('"'"
51D2I2"68"
7D11I24"6( A1737 );
if( A3389 ) "
19D2I14"69;
goto A1770"
7D4I22"69:A1664('"');
A1770:
"
9D10I4"3047"
22D1I1"1"
12D1I1"2"
7D17I2"1:"
24D5I26"" -- purposely omitted */""
11D13I4"772:"
18D5I6"*A3388"
10D5I37"d' && strcmp(A1737,"_AFXDLL") == 0 )
"
14D1I1"3"
12D1I1"4"
7D3I60"3:A1666( " /* which then implies */ -d_MT -d_DLL " );
A1774:"
11D1I2"\n"
6D92I10"goto A1775"
97D3I4"12: "
8D73I10"2142 == 12"
84D2I2"76"
12D2I2"77"
7D10I52"76:
A1664( '-' );
A1666( A3388 );
A1666( A2149 );
if"
18D14I53"== '=' ) goto A1778;
goto A1779;
A1778:
A1664( '=' );"
111D3I6"780:if"
11D3I71"&& !(A1463==' '||A1463=='\t'||A1463=='\n'||A1463=='\f'||A1463=='\r') ) "
12D29I1"1"
40D17I16"2;
A1781:
switch"
26D22I14"
{
case '\\':
"
116I16"A1664( A1463 );
"
9D18I52"3;
case '$':
A1666( A3381() );
goto A1783;
default:
"
25D6I133"A1463 );
goto A1783;
}
A1783:(void) ((A1463=(A9)(A15)(*A1492++)) ? ((A1463 == (A9)(A15)('\\'))?A1462():A1463) : A1461() );
goto A1780"
11D2I2"82"
10I30"9:A1664( '\n' );
A1777: ;
A177"
407I6"(A72) "
8363I6"(A72) "
4667I16"9151( A5586 );
A"
18553I6"(A72) "
906D21I49"9151( A5586 )
struct A5543 *const A5586;
{
const "
26D27I50"1730 = A5586->A5562;
A54 A1732;
A81 A80;
struct A1"
33D16I2"94"
21D136I15"732 = 0;
A1713:"
141D41I79"A1732 < A1730) goto A1711;
goto A1712;
A1714: A1732++;
goto A1713;
A1711:
if( ("
46D18I47"=((A81)((A8737)->A988)[ A1732])) && ( A1948 =( "
23D14I22")->A156 == (A41) 20 ? "
19D82I16")->A155.A150 : ("
90D78
83D44I47") 0 ))) ) goto A1715;
goto A1716;
A1715:
A9152("
50D11I60"->A7659, A5586, A1948 );
A9152( A1948->A7661, A5586, A1948 )"
16D6I16"16: ;
goto A1714"
12D2I106"2: ;
}
Void
A9152( A9193, A5586, A1948 )
A74 A9193;
struct A5543 *const A5586;
struct A149 *const A1948;
{"
8D12I5"9193 "
42D2I14"1:
{
const A54"
7D60I21"0 = A5586->A5562;
A74"
65D71I23"1;
A54 A1732;
A81 A80;
"
84D8I39"A2591;
A1731 = A9193;
A1715:
if( *A1731"
19I12"3;
goto A171"
5D47I14"716: A1731++;
"
59D10I26"A1713:
{
A4 A2009 = (A4) 0"
15D131I18"32 = 0;
A1721:
if("
138D1I1"<"
6D18I25"0) goto A1717;
goto A1720"
24D14I2"2:"
19D3I5"2++;
"
11D14I2"21"
19D45I13"17:
if( ((A80"
68D6I5"A1732"
14D17I12"A2591=( (A80"
40D6I3"A80"
54D2I21"3;
goto A1725;
A1723:"
8D26I13"2591 == A1948"
38D1I1"6"
12D1I1"7"
7D35I22"6: goto A1722;
A1727:
"
41D12I54"07(A2591->A7659, *A1731) ||
A107(A2591->A7661, *A1731)"
23D1I1"6"
12D1I1"6"
7D34I30"66:
A2009 = (A4) 1;
goto A1720"
39D6I5"67: ;"
34D3I14"
if( !A2009 ) "
12D1I13"8;
goto A1769"
6D30I78"68:
{
A5794 A1844 = A918((A81) *A1731, 0);
A6172( A9162, A1844 );
}
A1769: ;
}"
39D14I2"16"
19D20I40"14: ;
}
A1712: ;
}
Void
A5581( A2918, A4"
25D94
100D159I39"2918, A4084;
{
A49 A1824;
A49 *A1859 = "
164D1
7D18I87";
A1824 = A1859[A2918];
A1859[A2918] = A1859[A4084];
A1859[A4084] = A1824;
}
Void
A7619"
23D55I94"83 )
struct A5543 *A8083;
{
struct A5543 *A8084;
if( !A7806 ) return;
A1377 = 5;
A8084 = A5583"
60D38I18"83->A5562 );
A5584"
43D60I69"84, 1 );
A5570( A8084 );
A8069( A8083, A8084 );
A8075( A8084 );
A1377"
66D142I54"}
Void
A8069(A8083,A8084)
struct A5543 *A8083, *A8084;"
147D26I1"4"
31D22I70"2, A1804; A54 A2955; A81 A8078, A8079; struct A149 *A3746, *A8080; A54"
27D37I39"0 = A8083->A5562; A44 A1948; A74 A7920;"
42D49I5"2 = 0"
54D1I1"1"
9D32I12"1732 < A1730"
42D2I2"11"
12D2I2"12"
7D21I23"14: A1732++;
goto A1713"
26D96I10"11: if( !("
101D132I11"78=((A81)(("
137D58I9")->A988)["
64D6I102"])) && ( A3746 =( ( A8078)->A156 == (A41) 20 ? ( A8078)->A155.A150 : (struct A149 *) 0 ))) ) goto A171"
11D8I2"94"
13D10I61"3746->A7654; if( A1948 & (A44) 0x0001 ) goto A1715;
goto A171"
15D29I132"715: A7845( A8078, A3746 ); A7920 = A7846( A8078, A8084, 'N' ); A8219( 847, A8078, A8078, A7920, 0 ); A2955 = A1948 & (A44) 0x0080 ?"
34D61I17"2 : A1732+1; A180"
66D40I4"2955"
45D13I2"21"
21D3I3"804"
22D1I1"7"
11D2I2"20"
7D9I9"22: A1804"
21D2I2"21"
8D46I137"7: if( !(( A8079=((A81)((A8737)->A988)[ A1804])) && ( A8080 =( ( A8079)->A156 == (A41) 20 ? ( A8079)->A155.A150 : (struct A149 *) 0 ))) )"
55D28I3"22;"
34D12I27"8080->A7654 & (A44) 0x0001 "
22D2I2"23"
12D2I2"25"
8D2I38"3: A7841(A8078,A8079,A8083,A8084); if("
8D4I12" != A1804 ) "
12D1I13"26;
goto A172"
7D13I34"26: A7841(A8079,A8078,A8083,A8084)"
19D22I15"7: ; 
A1725: ;
"
31D1I10"2;
A1720: "
11D2I2"66"
7D32I4"16: "
38D26I18"948 & (A44) 0x0040"
37D2I2"67"
12D2I2"68"
7D44I23"67:
A7842( A8078, A8084"
51D2I11"68: ;
A1766"
14D2I2"14"
7D1I1"1"
6D42I58"}
Void
A8603( A5586 )
struct A5543 *A5586;
{
A81 A80;
A54 "
47D16I5";
A54"
21D3I50"0 = A5586->A5562;
A1377 = 6;
A1732 = 0;
A1713:
if("
8I8"2 < A173"
11D2I2"11"
12D2I2"12"
7D2I2"14"
21D2I2"13"
7D2I2"11"
8D13I31"( A80 = ((A81)((A8737)->A988)[ "
18D72I10" ]) ) &&
!"
77D47I55"->A163 & ((A30) 0x0008|(A30) 0x0010|(A30) 0x0400) ) &&
"
52D22I38"->A5796 & (A5793) 0x200000 ) &&
( A741"
27D37I17"->A130 ) == 24 )
"
47D2I2"15"
12D2I2"16"
7D21I50"15: {
A7 A8604 = 0;
A7 A8605;
A50 A2099;
A8605 = 0"
26D14I48"21:
if(
!A8604 && (A2099 = A4303( A80, A8605 )))"
23D2I14"17;
goto A1720"
7D37I62"22:
A8605++;
goto A1721;
A1717:
{
A58 A1818 = (A58) A2099;
A70"
42D86I1"8"
92D25I57"A2099 >= 0 &&
( A1738 = A492(A1818) ) &&
( A1738 == 25 ||"
30D6I49"8 == 33 ||
A1738 == 27 ) ) goto A1723;
goto A1725"
11D1I1"2"
9D53I31"7815( A1818, (A4) 0 ) == (A4) 0"
64D2I2"26"
12D2I2"27"
7D23I21"26: A8604++; 
A1727: "
28D2I25"25: ;
} goto A1722;
A1720"
8D100I10"A8604 == 0"
111D2I2"66"
12D2I2"67"
7D80I82"66:
{
A5794 A8606 = A1792( A80, 0 );
A6172( A8575, A8606 );
}
A1767: ;
}
A1716: ;
"
92D94I143"A1712:
A1377 = 0;
}
Void
A5567()
{
A5565( "Functions defined", (A7) A8737->A991 );
}
Void
A5570( A5586 )
struct A5543 *A5586;
{
A66 A1732, A180"
99D9I8"3 **A186"
15D3I3"586"
8D87I15"56;
A13 **A2309"
92D102I15"586->A5558;
A66"
111D5I11"(A66) A5586"
15D15I52"7471 A1883 = A5586->A5563;
A13 *A5614 = A5586->A5559"
24D7
27D43I10";
A1732 = "
48D157I8"713:
if("
162D31I3"2 <"
36D8
70D34I13"A5531( A2309["
40D87I24", A1868[A1732], A1883 );"
97D13I1"4"
19D17I3"2:
"
22D22
31D2I2"17"
10D3I3"732"
22D1I1"5"
11D2I2"16"
8D8I8"0: A1732"
20D2I2"17"
8D1I19"5:
A1804 = 0;
A1723"
9D15I44"804 < A1730) goto A1721;
goto A1722;
A1725: "
20D34I39"++;
goto A1723;
A1721:
if( A1140( A2309"
41D84I8", A1732 "
97D1I1"6"
12D1I1"7"
7D36I43"6:
A1144( A2309[A1804], A2309[A1732], A1883"
41D41I4"1727"
54D1I1"5"
7D23I29"2: ;
goto A1720;
A1716:
A1142"
29D1I8"4, A1883"
6D277I8"1732 = 0"
282D6I23"68:
if( A1732 < A1730) "
14D2I14"66;
goto A1767"
7D13I23"69: A1732++;
goto A1768"
28D11I18"140( A2309[A1732],"
16D1I4"2 ) "
11D2I2"70"
12D2I2"71"
7D31I26"70:
A1139( A5614, A1732 );"
69D2I2"32"
99D2I2"72"
12D2I2"73"
7D17I9"72:
A1948"
22D64I7"02 |= 4"
70D27I13"3: ;
A1771: ;"
36D14I2"69"
19D23I106"67: ;
}
A81
A5582()
{
A49 *A2098; A54 A1732;
A72 A5608, A5615=0;
A81 A80, A5616 = NULL;
struct A149 *A5413"
28D3I18" A1948, A5617 = 0;"
8D64I24"!A912(974) ) return NULL"
69D2I14"32=( 0);
A1713"
8D17I10"A2098 = ( "
29D32I24"+ A1732, A1732 <= ( A873"
37D61I3"991"
72D2I2"11"
12D2I2"12"
7D76I23"14: A1732++;
goto A1713"
81D75I12"11:
if( (A80"
80D174I72"81) *A2098) && (A5413 = ( (A80)->A156 == (A41) 20 ? (A80)->A155.A150 : ("
182D58I35"149 *) 0 )) ) goto A1715;
goto A171"
63D9I10"715:
A1948"
14D3I3"413"
8D113I2"02"
120D9I8"1948 & 8"
18D19I5" A80;"
25D12I19"5617 & (0x20|0x40) "
23D3I29"4;
if( A1948 & (0x20|0x40) ) "
12D1I13"7;
goto A1720"
7D10I29"7:
A5616 = A80;
A5617 = A1948"
21D1I1"4"
6D9I28"20:
A5608 = A5413->A5501;
if"
14D19I26"08 > A5615 || A5615 == 0 )"
28D2I14"21;
goto A1722"
7D33I30"21:
A5616 = A80;
A5615 = A5608"
38D23I15"22: ;
A1716: ;
"
32D13I1"4"
18D53I64"12:
return A5616;
}
Void
A7618(A1731)
struct A5543 *A1731;
{
A54"
58D3I3"0 ="
8D33I13"1->A5562;
A54"
39D33I14", A1804;
A81 A"
38D30I67"1827;
struct A149 *A1948, *A2591;
A74 A5618;
A13 **A5619;
A13 *A562"
35D16I157"3 *A7915, *A7916; A54 A4858; A72 A4745; A13 *A5643; A66 A1750, A8085;
A4858 = A7824->A991; A4745 = ((A7468) A4858 / (A7469) CHARLEN)+1; A5569(A1731);
A5619 ="
21D24I7"1->A555"
30D23I6"32 = 0"
28D2I2"13"
10D26I11"732 < A1730"
36D2I2"11"
12D2I2"12"
7D17I4"14: "
22D33I2"++"
43D2I2"13"
7D52I2"11"
58I30"(( A80=((A81)((A8737)->A988)[ "
5D8I87"])) && ( A1948 =( ( A80)->A156 == (A41) 20 ? ( A80)->A155.A150 : (struct A149 *) 0 ))) "
18D2I2"15"
12D2I2"16"
7D4I18"15:
A5620 = A5619["
9D14I26"];
A5618 = NULL;
A1804 = 0"
19D2I52"21:
if( A1804 < A1730) goto A1717;
goto A1720;
A1722"
7D36I6"04++;
"
44D2I2"21"
7D2I2"17"
10D38I149"140(A5620,(A66)A1804) && ((A1827=((A81)((A8737)->A988)[A1804])) && (A2591=( (A1827)->A156 == (A41) 20 ? (A1827)->A155.A150 : (struct A149 *) 0 ))) ) "
47D1I13"3;
goto A1725"
6D83I76"23:
A5618 = A108( A5618, A2591->A7659 );
A5618 = A108( A5618, A2591->A7661 )"
88D111I25"25: ;
goto A1722;
A1720:
"
116D134
139D9I17"62 = A5493( A5618"
14D14I124"7915 = (A13 *) A1670( (A72) ( A4745), (A72) ( 1 ) );
A7831( A7915, A1948->A7658 );
A7831( A7915, A1948->A7660 );
A1948->A766"
20D100I1"9"
105D6I141"7916 = (A13 *) A1670( (A72) ( A4745), (A72) ( 1 ) );
A7831( A7916, A1948->A7659 );
A7831( A7916, A1948->A7661 );
A1948->A7664 = A7916;
A112()"
12D85I41"6: ;
goto A1714;
A1712:
A1750 = 0;
A1766:"
91D83I18"1750 < (A66) A1730"
93D2I2"26"
12D2I2"27"
7D24I22"67: A1750++;
goto A176"
30D65I109"26:
if( (( A80=((A81)((A8737)->A988)[ A1750])) && ( A1948 =( ( A80)->A156 == (A41) 20 ? ( A80)->A155.A150 : ("
73D158I12"149 *) 0 )))"
169D2I2"68"
12D2I2"69"
7D2I93"68:
A5643 = A1731->A5558[A1750];
A7915 = A1948->A7663;
A7916 = A1948->A7664;
A8085 = 0;
A1772"
9D44I42"8085 < (A66) A1730) goto A1770;
goto A1771"
49D123I22"73: A8085++;
goto A177"
129D125I3"70:"
132D10I37"140( A5643, A8085 ) && A1750 != A8085"
21D2I2"74"
12D2I2"75"
7D2I2"74"
8D9I127"(( A1827=((A81)((A8737)->A988)[ A8085])) && ( A2591 =( ( A1827)->A156 == (A41) 20 ? ( A1827)->A155.A150 : (struct A149 *) 0 )))"
20D2I2"76"
12D2I2"77"
7D23I37"76:
A1144( A7915, A2591->A7663, A4745"
29D21I53"144( A7916, A2591->A7664, A4745 );
A1777: ;
A1775: ;
"
29D14I2"73"
19D25I4"71: "
30D20I6"69: ;
"
28D14I2"67"
20D22I59"7:
A7823.A7821 = (A13 *) A1670( (A72) ( A4745), (A72) ( 1 )"
27D72I55"7823.A7822 = (A13 *) A1670( (A72) ( A4745), (A72) ( 1 )"
77D26I276"7823.A7820 = A4745;
A7823.A7819 = (A66) A4858;
}
Void
A5569( A5586 )
struct A5543 *A5586;
{
A66 A1732, A1804;
A13 **A5621 = A5586->A5556;
A13 **A5619 = A5586->A5557;
A66 A1730 = (A66) A5586->A5562;
A7471 A1883 = A5586->A5563;
A13 *A4080 = A5586->A5560;
A7 A2091, A1868, A1808;"
32D33I18"5822 == 0 ) return"
38D25I6"32 = 0"
30D2I2"13"
10D8I11"732 < A1730"
18D2I2"11"
12D2I2"12"
7D25I23"14: A1732++;
goto A1713"
30D19I33"11: A1139( A5619[A1732], A1732 );"
28D14I2"14"
19D9I44"12:
A1808 = (A7) A1730;
A2091 = 1;
A1717:
if"
14D34I10"91 < A5822"
44D2I2"15"
12D2I2"16"
7D25I23"20: A2091++;
goto A1717"
30D4I13"15:
A1732 = 0"
10D22I1"3"
29D11I12"1732 < A1730"
21D2I2"21"
12D2I2"22"
7D59I12"25: A1732++;"
68D89I2"23"
94D31I70"21:
A5531( A4080, A5619[A1732], A1883 );
A1804 = 0;
A1766:
if( A1804 <"
36D75I2"0)"
84D54I4"26;
"
62D14I2"27"
19D2I30"67: A1804++;
goto A1766;
A1726"
10D7I25"140( A4080, (A66) A1804 )"
18D2I2"68"
12D2I2"69"
7D23I44"68:
A1144( A5619[A1732], A5621[A1804], A1883"
30D20I6"69: ;
"
28D2I11"67;
A1727: "
12D2I2"25"
7D25I13"22:
A1868 = 0"
30D2I13"32 = 0;
A1772"
10D8I11"732 < A1730"
18D1I1"7"
12D1I1"7"
7D25I23"73: A1732++;
goto A1772"
30D1I59"70: A1868 += A5532( A5619[A1732], A1883 ); goto A1773;
A177"
10D10I38"808 == A1868 ) return;
A1808 = A1868;
"
19D13I1"0"
18D25I83"16: ;
}
A74
A7620( A3491, A80 )
A74 A3491;
A81 A80;
{
struct A149 *A1948;
A81 A4573"
30D24I27" A8077;
struct A8393 A8421;"
31D70I72"07( A3491, (A49) A80 ) ) return A3491;
A3491 = A235( A3491, (A49) A80 );"
81D3I72"= ( ( A80 )->A156 == (A41) 20 ? ( A80 )->A155.A150 : (struct A149 *) 0 )"
14D2I2"11"
12D2I2"12"
7D37I25"11:
(void) A7639( &A8421,"
43D29I16"->A7652 , NULL )"
34D32I2"15"
39D9I37"4573 = A7639( &A8421, NULL, & A8077 )"
19D2I2"13"
12D2I2"14"
7D25I45"13:
A3491 = A7620( A3491, A4573 );
goto A1715"
30D2I2"14"
9D24I86"12:
return A3491;
}
Void
A7621( A80, A1836 )
A81 A80;
A44 A1836;
{
struct A149 *A5413;"
30D65I12"80 && (A5413"
70D24I22"(A80)->A156 == (A41) 2"
30D66I40"80)->A155.A150 : (struct A149 *) 0 )) ) "
78D1I11"goto A1712;"
8I30"
A5413->A7654 |= A1836;
A1712:"
5D101
113D14I14"390();
static "
19D51I15"391();
typedef "
56D15I52"3392;
struct A3393
{
int A3394;
int A3395;
int A3396"
23D41I32"*A3397;
A4 *A3398;
} A3399;
Void"
46D117I52"0( A2076, A2882 )
A48 A2076;
A72 A2882;
{static A72 "
125D48I2"0;"
54D27I8"2076[0] "
57D2I6"1:
if("
7D15I41"5 == A2882 ) return;
strcat( A2076, " " )"
21D21I8"2:
A2285"
26D71I57"882;
strcat( A2076, A979( (A18) A2882 ) );
}
Void
A5312( "
76D48I13", A2076 )
A48"
54D3I102", A2076;
{
struct A1192 A3402;
A17 A1948;
A2076[0] = '\0';
A1450( A1737, &A3402 );
switch( A3402.A1194"
14D1I1"b"
13D1I1"1"
9D40I1"p"
45D26I38"948 = A3402.A1193;
if( A1948 & 0x10 ) "
35D11I2"2;"
21D4I2"3;"
9D5I19"2:
if( A1948 & 2 ) "
13D2I14"14;
goto A1715"
8D20I46"4: A3400( A2076, A1371 );
A1715:
if( A1948 & 1"
31D2I2"16"
12D2I2"17"
7D29I25"16: A3400( A2076, A1369 )"
34D25I41"17:
if( A1948 & 8 ) goto A1720;
goto A172"
31D36I33"20: A3400( A2076, A1372 );
A1721:"
43D3I7"948 & 4"
15D1I1"2"
12D1I1"3"
7D9I55"2: A3400( A2076, A1370 );
A1723: ;
goto A1725;
A1713:
i"
14D45I10"948 & 2 ) "
57D27I10"goto A1727"
35D17I23" A3400( A2076, A1363 );"
22D37I2"7:"
44D34I7"948 & 1"
45D2I2"66"
13D1I1"7"
6D1I31"66: A3400( A2076, A1361 );
A176"
9D4I8"1948 & 8"
16D1I1"8"
12D1I1"9"
7D45I24"8: A3400( A2076, A1364 )"
51D12I19"9:
if( A1948 & 4 ) "
20D2I14"70;
goto A1771"
7D43
48D33I20"3400( A2076, A1362 )"
42I30";
A1725:
goto A1711;
default:
"
5D13I10"3402.A1195"
25D1I1"2"
12D1I1"3"
7D17I58"2:
A3400( A2076, (A72) A1595[ A3402.A1195 ].A300 );
A1773:"
26D58I5"11;
}"
63D68I79"1: ;
} 
Void
A3401( A1737, A2076 )
A5794 A1737;
A48 A2076;
{
struct A1192 A3402"
73D37I111" A1948;
A2076[0] = '\0';
A1450( A1737, &A3402 );
switch( A3402.A1194 )
{
case 'b':
A3400( A2076, (A72) A1390 );"
46D4I54"11;
case 'p':
A1948 = A3402.A1193;
if( A1948 & 0x10 ) "
12D2I14"12;
goto A1713"
7D39I20"12:
if( A1948 & 2 ) "
47D2I14"14;
goto A1715"
7D33I33"14: A3400( A2076, A1367 );
A1715:"
38D6I9"A1948 & 1"
17D2I2"16"
12D2I2"17"
7D23I33"16: A3400( A2076, A1365 );
A1717:"
29D26I8"1948 & 8"
37D2I2"20"
12D2I2"21"
7D35I33"20: A3400( A2076, A1368 );
A1721:"
40D13I9"A1948 & 4"
24D2I2"22"
12D2I2"23"
7D68I34"22: A3400( A2076, A1366 );
A1723: "
78D52I27"25;
A1713:
if( A1948 & 2 ) "
60D12I3"26;"
21D25I2"27"
30D21I47"26: A3400( A2076, A1359 );
A1727:
if( A1948 & 1"
32D2I2"66"
12D2I2"67"
7D29I25"66: A3400( A2076, A1357 )"
34D19I49"67:
if( A1948 & 8 ) goto A1768;
goto A1769;
A1768"
24D2I18"00( A2076, A1360 )"
7D36I3"69:"
43D3I7"948 & 4"
13D3I3"770"
12D77I2"77"
82D23I24"770: A3400( A2076, A1358"
29D21I13"771: ;
A1725:"
29D12I14"711;
default:
"
17D33I10"3402.A1195"
43D3I3"772"
12D41I3"773"
46D4I171"72:
A3400( A2076, ( A7174 = ( A3402.A1195 ), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) )->A305 );
A1773:
goto A1711;
}
A1711: ;
}
Void
A1420(A1730)
A6"
9D71I10"0;
{
A5794"
76D82I99"7, A2285;
A6 A3403;
A6 A3404, A3405, A3406;
A6 A1875, A3407;
static A4 A3408 = (A4) 1;
A4 A3409;
A2"
87D3I7"0[133],"
8D3I10"1[133];
A4"
8D28I60"2 = (A4) 0;
int A2282, A3413 = 0;
A3392 A2049;
A2 A3414[40];"
33D38I16"!A3408 ) return;"
43D2I19"8 = (A4) 0;
scr_n ="
7D98I36"0;
A3403 = scr_wth;
A3405 = 2;
A3404"
103D43I6"3403 -"
48D4I24"5) / 2;
A3406 = (A3403 -"
9D24I8"5) - A34"
29D11
16D31I49"= NULL;
A2049 = (A3392) 1;
A2282 = A3359();
A1713"
38D29I27"1737 = (sys_odesc[A2282-1])"
39D49I4"11;
"
56D3I19"712;
A1714: A2282++"
12D31I24"713;
A1711:
A3399.A3397["
36D26I56"] = A2049;
A3399.A3398[A2282] = (A4) 0;
A3412 = !A3412;
"
32I28"= (A4) 0;
if( *A1737 == '.' "
9D3I3"715"
12D41I20"716;
A1715:
switch( "
46D56I18"[1] )
{
case 'n':
"
64D3I13"14;
case 'C':"
8D9I16"9.A3398[A2282] ="
16D9I38";
case 'c':
A1737 += 3;
A3409 = (A4) 1"
18D24I14"717;
default:
"
31D3I14"717;
}
A1717: "
12D45I29"720;
A1716: if( *A1737 == 'f'"
56D80I4"21;
"
88D23I82"22;
A1721:
{
A2 *A1758;
UFLAG *A1749;
A1758 = A3412 ? A3410 : A3411;
A1749 = A1433"
30D19I32"+1, A1209, A1210 );
if( A1749 ) "
26D2I14"723;
goto A172"
7D6I11"723: sprint"
11D53I4"758,"
59D17I34", *A1749 > 0 ? "(ON)" : "(OFF)" );"
25D18I41"726;
A1725: strcpy( A1758, "?" );
A1726:
"
23D117I2" ="
122D18I19"8;
}
A1722:
A1720:
"
23D19I30" = (A6) ((A72) strlen(A1737));"
26D11I35"875 == 0 || A1875 > A3406 || A3409 "
21D2I2"27"
12D2I2"66"
7D13I16"27:
if( A2285 ) "
21D2I14"67;
goto A1768"
7D4I83"67:
A2285 = NULL;
A3399.A3397[A2282] = ++A2049;
A1768:
++A2049;
goto A1769;
A1766: "
9D51I7"2285 ) "
59D2I14"70;
goto A1771"
7D56I50"70: A2285 = NULL; ++A2049; 
goto A1772;
A1771: if("
61D19I10"5 <= A3404"
30D2I2"73"
12D2I2"74"
7D48I19"73: A2285 = A1737;
"
56D14I2"75"
19D23I11"74: ++A2049"
28D16I4"75: "
21D23I33"72: ;
A1769: ;
goto A1714;
A1712:"
33D1I4"8[1]"
6D48I73"4) 1;
A2285 = NULL;
A2282 = A3359(); goto A1776;
A1778: A2282++;
A1776:
i"
55D13
19D62I26"4 ) goto A1779;
goto A1780"
67D39I39"79:
A2285 = NULL;
A2282 = A3359() - 1;
"
47D14I2"78"
19D48I47"80:
A1737 = (sys_odesc[A2282-1]);
if( !A1737 ) "
56D2I14"81;
goto A1782"
7D3I27"81:
scr_need( scr_ht );
if("
8D11I48"0( " ", (A4) 1, A2282 ) ) goto A1778;
goto A1777"
16D43I41"82:
A3412 = !A3412;
A3409 = (A4) 0;
if( *"
48D22I48" == '.' ) goto A1783;
goto A1784;
A1783:
switch("
28D59I27"[1] )
{
case 'n':
scr_need("
67D25I18"985( A1737+2 ) );
"
33D1I49"78;
case 'C':
case 'c':
A1737 += 3;
A3409 = (A4) "
12D30I13"85;
default:
"
38D2I13"85;
}
A1785: "
12D2I2"86"
7D23I46"84: if( *A1737 == 'f' ) goto A1787;
goto A1788"
28D50I29"87:
{
A2 *A1758;
UFLAG *A1749"
55D64I2"58"
69D34I19"412 ? A3410 : A3411"
39D23I10"49 = A1433"
28D28I130"37+1, A1209, A1210 );
if( A1749 ) goto A1889;
goto A1890;
A1889: sprintf( A1758, A1737, *A1749 > 0 ? "(ON)" : "(OFF)" );
goto A189"
33D69I73"890: strcpy( A1758, "?" );
A1891:
A1737 = A1758;
}
goto A1892;
A1788: if("
74D100I11"7[0] == '-'"
105D26I71"1737[1] == 's' ) goto A1893;
goto A1894;
A1893:
{
A48 A1758=NULL;
A5794"
31D1I1"1"
6D41I4"31 ="
46D4I21"7+2;
A1897:
if( *A173"
9D28I13"*A1731 != ' '"
37D3I3"895"
12D21I21"896;
A1898: A1731++;
"
28D9I9"897;
A189"
16D5I51"*A1731 == '#' ) goto A1899;
goto A1900;
A1899:
A175"
13D42I25"2 ? A3410 : A3411;
A1900:"
50D5I24"898;
A1896:
if( A1758 ) "
12D19I3"901"
28D2I2"90"
7D7I10"901:
A3401"
13D22I20"7+1, A3414 );
sprint"
27D11I11"758, A1737,"
16D86I3"4 )"
91D40I2"37"
46D43I80"58;
A1902: ;
}
A1894:
A1892:
A1786:
A1875 = (A6) ((A72) strlen(A1737));
if( A187"
48D3I129"0 || A1875 > A3406 || A3409 ) goto A1903;
goto A1904;
A1903:
if( A2285 ) goto A1905;
goto A1906;
A1905:
if( A3390( A2285, (A4) 1,"
8D184I32"3 ) ) goto A1778;
A1906:
A2285 ="
189D3I268";
A1904:
if( A1875 == 0 ) goto A1907;
goto A1908;
A1907: A3390(A1737,(A4) 1,A2282);
goto A1909;
A1908: if( A3409 ) goto A1910;
goto A1911;
A1910:
A3407 = (A3403 - (A6) ((A72) strlen(A1737))) / 2;
A3407 -= A3407 / 5;
if( A3391( A3407, A2282 ) ) goto A1778;
A3390( A1737"
8D104I122") 1, A2282 );
goto A1912;
A1911: if( A2285 ) goto A1913;
goto A1914;
A1913:
if( A3390( A2285, (A4) 0, A3413 ) ) goto A1778"
109D57I62"07 = (A3404 + A3405) - (A6) ((A72) strlen( A2285 ));
if( A3391"
62D17I146"07, A2282 ) ) goto A1778;
A2285 = NULL;
A3390( A1737 ,(A4) 1, A2282 );
goto A1915;
A1914: if( A1875 <= A3404 ) goto A1916;
goto A1917;
A1916: A228"
23D65I173"737; A3413 = A2282; 
goto A1918;
A1917: A3390(A1737,(A4) 1,A2282);
A1918: ;
A1915: ;
A1912: ;
A1909: ;
goto A1778;
A1777: ;
}
static A4
A3391(A1730,A1750)
A6 A1730;
int A175"
70D10I155"A6 A1732;
A4 A1875;
A1732 = 0;
A1713:
if( A1732 < A1730) goto A1711;
goto A1712;
A1714: A1732++;
goto A1713;
A1711:
if( A1875 = A3390( " ", (A4) 0, A1750 )"
19D302I8" A1875;
"
311D8I3"4;
"
13D2I86":
return (A4) 0;
}
static int
A3359()
{
int A1732;
int A1873;
if( !A3399.A3397 ) goto "
7D94
105D1I1"2"
7D18I14"1:
A1732 = 1; "
23D97I26"5:
if((sys_odesc[A1732-1])"
108D1I1"3"
12D1I1"4"
7D9I22"6: A1732++;
goto A1715"
15D28I41"3:
; goto A1716;
A1714:
A1873 = A1732 - 1"
33D2I8"99.A3397"
7D33I53"3392 *) A1670( (A72) ( A1873 + 2), (A72) ( sizeof( A3"
38D27I40" ) );
A3399.A3398 = (A4 *) A1670( (A72) "
32D31I58"73 + 2), (A72) ( sizeof( A4 ) ) );
A1712:
A3399.A3395 = 0;"
36D86I11"A3399.A3394"
98D1I1"7"
11D2I2"20"
8D35I57"7:
A3399.A3396 = A3399.A3394;
A3399.A3394 = 0;
goto A1721"
40D179I66"20: A3399.A3396 = 1;
A1721:
return A3399.A3396;
}
static A4
A3390("
184D6I9"7, A2499,"
11D215I88"0 )
A5794 A1737;
A4 A2499;
int A1750;
{
int A2847;
A2847 = scr_out( A1737, (int) A2499 )"
221D11I10"A2847 == 0"
45D105I16"if( !A3399.A3396"
138D30I20" A3399.A3396 = A1750"
40D4I10"3399.A3395"
9D9I30"750;
return (A4) 0;
goto A1715"
14D38I3"12:"
44D9I10"2847 == -1"
21D1I1"6"
12D1I1"7"
7D22I41"6:
A3399.A3394 = A3360( A3399.A3396, -1 )"
32D2I2"20"
8D13I34"7:
A3399.A3394 = A3360( A1750, 1 )"
18D11I15"20:
return (A4)"
18D79I69"15: ;
}
static int
A3360( A3415, A1925 )
int A3415;
int A1925;
{
int "
87D14I48"A3415;
int A3416 = 0;
A3392 A3417 = A3399.A3397["
19D69I28"];
A3392 A2049;
A3392 A3418;"
75D16I24"1925 == 1 && A3399.A3398"
26D22I12"return A1732"
27D4I38"11:
A2049 = A3399.A3397[A1732];
A1713:"
9D22I39"1732 > 1 && A3399.A3397[A1732] >= A2049"
33D2I2"14"
12D2I2"15"
7D2I30"14: --A1732; goto A1713;
A1715"
8D10I53"(A3418 = A3417 - A3399.A3397[A1732]) > (A3392) scr_ht"
21D2I2"16"
12D2I2"17"
7D12I6"16:
++"
18D1I1"
"
9D2I2"12"
7D20I2"17"
28D7I9"732 <= 1 "
17D3I52"12;
if( A1925 == 1 && A3418 > (A3392) (scr_ht / 2) )"
12D20I29"12;
if( A3399.A3398[A1732] ) "
28D2I14"20;
goto A1721"
7D20I2"20"
28D13I49"925 == 1 ) return A1732;
A3416 = A1732;
A1721: ;
"
21D14I2"11"
19D35I10"12:
return"
40D112I115"5 == 1 ? A3415 : A3416 ? A3416 : A1732;
}
Void
A3419(A3420)
struct A391 *A3420;
{
A3420->A1176 = A999( 200, (A41) 1"
117D176I31"3420->A1177 = A999( 40, (A41) 1"
181D115I31"3420->A1178 = A999( 40, (A41) 2"
121D18I86"661( NULL, 2, (A41) 31, A1378 );
}
A54
A1430(A1819)
register struct A633 *A1819;
{
A54"
23D1I68"1;
register struct A391 *A3420;
A3420 = (struct A391 *) A1005( A1333"
6D16I34"3421 = A1011;
A3419( A3420 );
A342"
21D5I77"175 = A1819;
return A3421;
}
Void
A1431(A3420)
register struct A391 *A3420;
{"
10D56I23"!A3420 ) return;
A1000("
61D55
60D11I82"176);
A3420->A1176 = NULL;
A1000( A3420->A1177);
A3420->A1177 = NULL;
A1667( A1378"
17D120I17"000( A3420->A1178"
125D111I3"342"
116D72I5"178 ="
77D62I134";
}
Void
A3361( A3421 )
A5774 A3421;
{register struct A391 *A3420;
A390 = A3421;
A3420 = ((struct A391 *) A1207[ A3421 ]);
A392 = A342"
70D8I3"342"
13D17I3"177"
52D15I10"1009( A342"
20D8I7"177 , 0"
13D95I4"009("
100D126
131D18I21"176 , 0);
A1009( A342"
23D10I26"178 , 0);
A1667( A1378 );
"
22D10I21"A1712: A3419( A3420 )"
18I77" ;
}
Void
A3362()
{
A3366 = (A4) 1;
A216( A431, A3364 );
A216( A433, A3365 );"
6D12I10"1340 & 0x2"
25D1I1"1"
12D1I1"2"
7D37I8"1: A458("
44D33I173"2:
A216( A431->A188, A3364 );
A3366 = (A4) 0;
A431->A188 = NULL;
A1431( A392 );
A392 = NULL;
}
Void
A3422( A1826, A1827 )
A81 A1826, A1827;
{
if( !A1826 || !A1827 ) return;
"
39D21I53"826->A127 & (A27) 0x08 &&
!(A1827->A127 & (A27) 0x08)"
32D2I2"11"
12D2I2"12"
7D52I36"11:
A894( 1770, A1826, A1827->A129 )"
57D233
241D125I94"Void
A1432()
{
A3422( A710, A711 );
A3422( A711, A710 );
A3422( A712, A713 );
A3422( A713, A71"
130D66I67"}
A5794 A9319;
A5794 A9320();
A4 A9321();
A4 A9322();
Void A9323();"
76D9I9"44 *A9324"
19D8I129"9304 A9307;
Void
A9325( A2097, A2038, A1830, A1831, A1832 )
A9 A2097;
A5794 A2038;
A5794 A1830, A1831, A1832;
{
A5794 A1334;
A133"
13D16I120"866( A2038, A1830, A1831, A1832 );
if( A2097 == 'e' ) goto A1711;
goto A1712;
A1711:
goto A1713;
A1712:
A884( 852, A1334"
21D44I73"1713: ;
}
Void
A9308(A1835)
A48 A1835;
{
A48 A1748[20];
A48 A3557;
A6 A17"
49D65I7"9 A1833"
70D37I23" A1836;
A5972 A3491 = 0"
42D8I38"30 = A994( A1748, 19, A1835, 0 ); A355"
13D12I76"1748[0]; if( !A3557 ) return; A1833 = (A9)(A15)(*A3557); if( A1833 == '-' ) "
21D1I13"1;
goto A1712"
7D50I23"1: A3557++; A3491 = -1;"
60D13I1"3"
19D56I22"2: if( A1833 == '+' ) "
68D11
20D1I1"5"
10D3I20"A3557++; A3491 = 1; "
8D280I10"5:
A1713: "
286D47I8"730 == 1"
59D1I1"6"
12D1I1"7"
7D20I13"6: A1836 = 0;"
25D34I34"(strcmp( A3557, "overwrite" ) == 0"
46D2I2"20"
12D2I2"21"
7D2I48"20: A1836 = 1;
goto A1722;
A1721: A1418();
A1722"
8D27I5"A1836"
38D2I2"23"
12D2I2"25"
7D33I4"23:
"
38D17I8"3491 >= "
29D2I2"26"
13D1I1"7"
6D73I26"26: A9307.A9305 |= A1836;
"
81D14I2"66"
20D12I24"7: A9307.A9305 &= ~A1836"
17D6I5"66: ;"
11D15I5"5: ;
"
23D14I2"67"
19D122I11"17:
A1418()"
127D35I314"67: ;
}
Void
A9309(A1886)
struct A640 *A1886;
{
struct A633 *A1819;
A5794 A3267;
lnt_option( "-save", 0 ); lnt_option( "-e16", 0 ); lnt_option( "-e10", 0 ); lnt_option( "-e122", 0 ); A1415( A1886, (A4) 1 );
A7635( " " );
gfl_di = 1; A1652 = A1655;
A9324 = A999( 4, 0 );
(void) ((A1463=(A9)(A15)(*A1492++)) ? ((A146"
40D60I63"(A9)(A15)('\\'))?A1462():A1463) : A1461() );
A9319 = NULL;
A181"
65D14I21"1886->A645;
if( A1819"
25D2I2"11"
12D2I2"12"
7D70I41"11:
A3267 = A1076( A1344, A663(A1819,(A4)"
75I1";"
7D4I4"1713"
9D88I29"12:
A882(200,104);
A3267 = """
93D19I98"13:
A9307.A9306 = A3267;
A9319 = A7633(
"\nrem Batch file generated from file: " , A3267, "\n\n" )"
24D2I57"14:if( A9322( "Project" ) ) goto A1715;
goto A1716;
A1715"
8D73I11"!A9321() )
"
81D2I2"16"
12D2I2"14"
7D31I38"16:
if( A9319 ) goto A1717;
goto A1720"
36D26I61"17:
A1666( A9319 );
A1720:
A7636();
lnt_option( "-restore_", "
32D64I57"1415( A1886, (A4) 0 );
}
A4
A9321()
{
A5794 A1737;
A2163("
71D42I15"!A835( 8, 5, 0 "
52D16I4"9326"
21D25I3"11:"
30D25I38"2142 != 4 && A2142 != 12 && A2142 != 1"
36D2I2"12"
12D2I2"13"
7D16I24"12:
A2165(0);
goto A1711"
21D4I4"13:
"
9D25I9"2142 != 4"
34D6I33"9326;
A2163();
if( A2142 != 21 ) "
12D3I3"932"
9D48I13"37 = A9320();"
53D88I9"!last_ext"
93D20I38"37, ext_TEST, ".vcproj" ) &&
!last_ext"
25D21I29"37, ext_TEST, ".vcxproj" ) )
"
27D64I25"9326;
A9323(A1737);
A9326"
74D129I18"9322( "EndProject""
135D15I39"A4
A9322( A8509 )
A5794 A8509;
{
A1711:"
20D39I26"2142 != 1 && !(A2142 == 12"
44D23I25"strcmp(A8509,A2149) == 0)"
36D1I1"2"
12D1I1"3"
7D52I23"2:
A2165(0); goto A1711"
58D124I41"3:
return A2142 == 1 ? (A4) 0 : (A4) 1;
}"
130D34I8"
A9320()"
40D31I540" A1871 = A1649;
A5794 A1737 = NULL;
if( A2142 == 21 ) goto A1711;
goto A1712;
A1711:
A1649 = A1378;
A1668();
A1713:if( A1463 != '"' && A1463 != EOF ) goto A1714;
goto A1715;
A1714:
A1664( A1463 );
(void) ((A1463=(A9)(A15)(*A1492++)) ? ((A1463 == (A9)(A15)('\\'))?A1462():A1463) : A1461() );
goto A1713;
A1715:A1664( '\0' );
A1737 = A1669();
A1649 = A1871;
(void) ((A1463=(A9)(A15)(*A1492++)) ? ((A1463 == (A9)(A15)('\\'))?A1462():A1463) : A1461() );
A1712:
return A1737;
}
Void
A9323( A1741 )
A5794 A1741;
{
A2 A9327[ARG_LEN];
A5794 A9274;
"
39D524I11"640 *A1886;"
532D14I1"9"
19D58I462"if( !A1741 ) return;
if( A8705( A9324, A1741 ) ) return;
A997( A9324, A1741 );
A1886 = A9310(A1741);
if( !A1886 ) goto A1711;
goto A1712;
A1711:
A9325( 'i',
"project file named '$s' could not be opened",
A1741, NULL, NULL );
return;
A1712:
A9328 = A663( A1886->A645 ,(A4) 1);
A243( A9327, A9328, ARG_LEN );
last_ext( A9327, ext_REP, ".lnt" );
if( A9310( A9327 ) &&
!(A9307.A9305 & 1) ) goto A1713;
goto A1714;
A1713:
A9325( 'i',
"file '$s' already exists",
A9327"
63D472I14"ln(overwrite)""
478D10I112" );
A1714:
A9274 = A866( "lint-nt -os($s) \"$s\" ", A9327, A1741, NULL );
A9319 = A7633( A9319, A9274, "\n" );
}"
17D10I17"1448( A2897, A184"
15D74I41"60 A2897;
A7 A1843;
{register A81 A80;
A5"
79D75I7"32;
A54"
80D18I214"9;
A49 *A2092;
struct A144 *A2091;
A6 A1875;
A6 A1804;
static A9069 A1928;
A54 A2285=0;
A9069 A3423;
A6 A2305;
static A2 A3424[2] = "|";
static A2 A3425[2] = "+";
static A2 A3426[2] = "-";
static A2 A3427[2] = "|";"
23D5I11"(A1258 > 0)"
38D29I83"
A3424[0] = (A2) 179;
A3425[0] = (A2) 192;
A3426[0] = (A2) 196;
A3427[0] = (A2) 195"
37D63
68D15I35"A1843 == 0 ) goto A1713;
goto A1714"
20D23I31"13:
A1928 = 0;
A7187( (A5) 1, 0"
30D26I65"14:
A2091 = A1388->A173;
A1759 = A2091->A991;
A2092 = A2091->A988"
34D12I8"843 >= 0"
24D1I1"5"
12D1I1"6"
7D65I20"5: A3423 = 1 << A184"
77D1I1"7"
7D17I12"6: A3423 = 0"
23D17I116"7:
A2305 = 1;
A1722:
if( A2305 <= 2) goto A1720;
goto A1721;
A1723: A2305++;
goto A1722;
A1720:
A1732 = 1;
A1727:
if"
22D10I5"32 <="
15D50I77"9) goto A1725;
goto A1726;
A1766: ++A1732;
goto A1727;
A1725:
if( A80 = (A81)"
55D66I2"2["
71D53I4"] ) "
61D2I2"67"
12D2I2"68"
7D21I2"67"
28D53I22"80->A140.A134 == A2897"
64D2I2"69"
12D2I2"70"
7D30I2"69"
37D19I9"2305 == 1"
30D2I2"71"
12D2I2"72"
7D18I29"71: A2285 = A1732; goto A1766"
23D16I13"72:
A1804 = 0"
21D4I19"75:
if( A1804 < 2) "
12D2I14"73;
goto A1774"
7D16I13"76: A1804++;
"
24D14I2"75"
19D24I1"7"
29D59I6"875 = "
64D51I4"779:"
56D7I13"A1875 < A1843"
17D2I2"77"
12D2I2"78"
7D13I23"80: A1875++;
goto A1779"
18D77I29"77:
if( A1928 & (1 << A1875) "
87D2I2"81"
12D2I2"82"
7D13I38"81:
A1089( "  $s", A3424 );
goto A1783"
18D2I52"82:
A1089( "   ", NULL );
A1783: ;
goto A1780;
A1778"
10D11I26"804 >= 1 || A1400 & 0x200 "
21D4I14"74;
if(A1843) "
12D2I14"84;
goto A1785"
7D11I28"84: A1089( "  $s\n", A3424 )"
21D2I2"86"
7D2I51"85: A1089( "\n", NULL );
A1786: ;
goto A1776;
A1774"
10D13I3"843"
24D2I2"87"
12D2I2"88"
7D23I49"87:
A1089( "  $s", A1732 == A2285 ? A3425 : A3427"
30D39I76"88:
A1089( "$s ", A3426 );
A1089( "$s\n", A80->A129 );
if( A1732 != A2285 ) "
46D2I14"889;
goto A189"
7D78I21"889: A1928 |= A3423;
"
85D15I63"891;
A1890: A1928 &= ~A3423;
A1891:
A1448( A80->A169, A1843+1 )"
20D43I4"70: "
48D36I48"68: ;
goto A1766;
A1726: ;
goto A1723;
A1721:
if"
41D52I7"43 == 0"
62D3I3"892"
12D59I28"893;
A1892:
A7187( (A5) 0, 0"
65D3I3"893"
17D3I3"227"
8D7
19D21I56"{
A58 A1868 = ((A80)->A160 ? (A80)->A160 : (A80)->A161);"
29D9I16"1741 = A80->A129"
15D4I49"A1868 )
return A866( "$s::$s", A1153(A1868,(A6230"
10D46I43"), A1741, NULL );
return A1741;
}
A81
A7622"
53I66"
A81 A80;
{
A81 A8086 = A80;
if( A80 && A80->A127 & (A27) 0x4000 )"
10D1I1"1"
12D1I1"2"
7D16I15"1:
A8086 = A526"
29D18I5"134 )"
24D118I5"2:
if"
123D38I126"86 ) return A8086;
return A80;
}
Void
A1449( A80, A1750 )
A81 A80;
A60 A1750;
{
A60 A3428;
A60 A2996;
A60 A1732;
A81 A1942;
A8"
43D15I42"7622(A80);
if( !A80 ) return;
if( A1750 ) "
23D2I14"11;
goto A1712"
7D4I23"11:
A3428 = A80->A169;
"
9D4I21"2996 = A80->A140.A134"
15D2I2"13"
12D2I2"14"
7D23I47"13:
if( A2996 != A1750 ) goto A1715;
goto A1716"
28D2I55"15: A894( 635, A80, A526(A2996)->A129 );
A1716: ;
A1714"
7D4I53"32 = A1750;
A1717:if( A1732 && A1732 != A3428 ) goto "
9D143I20";
goto A1721;
A1720:"
148D34I19"A1942 = A526(A1732)"
45D2I2"22"
12D2I2"23"
7D42I40"22: A1732 = A1942->A140.A134;
goto A1725"
47D18I46"23: goto A1721;
A1725: ;
goto A1717;
A1721:
if"
23D114I11"32 == A3428"
125D2I2"26"
12D2I2"27"
7D14I62"26: A894( 138, A80, A526(A1750)->A129 );
goto A1766;
A1727: A8"
19D12I15"40.A134 = A1750"
17D53I4"66: "
59D66I136"2: ;
}
A81
A8988( A8989 )
A81 A8989;
{
A81 A2100 = NULL;
A81 A2897 = NULL;
A2100 = A213(
A1388,
A1153( A8989->A130, (A6230) 0x01 ),
2 );"
71D54I27"!(A2100->A127 & (A27) 0x08)"
66D1I1"1"
12D1I1"2"
6D41I6"11:
{
"
49D31I156"189 *A3277;
struct A83 *A1724 = A506( A8989->A130 );
A2100->A128 |= A1228;
A2100->A130 = A8989->A130;
A2100->A127 |= ((A27) 0x08 | (A27) 0x1000000);
A3277 ="
36D13I7"4->A190"
18D2I2"15"
8D54I5"A3277"
64D1I1"1"
12D2I2"14"
7D46I35"16: A3277 = A3277->A250;
goto A1715"
51D15I52"13:
{
A81 A8990 = A5269( A3277->A252 );
if( A8990 ) "
23I12"17;
goto A17"
8D7I61"7:
A2897 = A8988( A8990 );
A1449( A2100, A2897->A169 );
goto "
12D69
74D156I144"20: ;
} goto A1716;
A1714: ;
}
A1712:
return A2100;
}
A58
A6226( A8991, A1740 )
A81 A8991; A58 A1740; {
A81 A4325; A81 A8992 = NULL; A42 A4046 ="
161D7I144"8 ? 2 : 1; A58 A4326; A5794 A1741 = A6227(A8991); A315 A1742 = ( A7174 = (A1740), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1])"
12D18I20"81 A8989 = NULL;
if("
23D205I39"8 & (A9070) 0x8000 && A8991->A127 & (A2"
210D25I89"200 ) goto A1711;
goto A1712;
A1711:
A4046 = 1;
A1712:
if( A4325 = A213( A1388, A1741, A4"
30D13I57" ) goto A1713;
goto A1714;
A1713:
if( !(A4325->A127 & (A2"
19D40I150"8) ) goto A1715;
goto A1716;
A1715: A4325->A128 |= A1228;
A1716: if( A4326 = A4325->A130 ) goto A1717;
goto A1720;
A1717:
if( A1150( A4326, A1740, (A7"
46D41I13", 0 ) & ~((A7"
46D38I60"800 | (A77) 0x200000) ) goto A1721;
goto A1722;
A1721: A4326"
45D86I89"1722: ; 
A1720:
if( A4326 ) goto A1723;
goto A1725;
A1723: A1740 = A4326; A1742 = ( A7174"
93D272I81"40), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) ); goto A1726"
277D17I23"25: if( (A1259 > 0) &&
"
22D10I92"42->A303 == 29 || A1742->A303 == 30 ) &&
!(A1742->A307 & 0x400) &&
(A8989 = A5269( A1740 )) "
20D2I2"27"
12D2I2"66"
7D31I27"27:
A8992 = A8988( A8989 );"
36D10I35"(strcmp( A8991->A129, A8989->A129 )"
15D3I4") )
"
9D16I4"5288"
21D25I92"66:
A438 = 0x400; if( A4325->A128 & ((A9070) 0x1000|(A9070) 0x0800) ) goto A1767;
goto A1768"
30D82I19"67:
A438 |= 0x10000"
87D329I2"68"
335D6I71"(A1259 > 0) && ( A8992 ||
A1742->A307 & 0x400 &&
(A8992=A525(A1740)) ) "
16D2I2"69"
12D2I2"70"
7D13I31"69:
A1449( A4325, A8992->A169 )"
18D86I2"70"
91D112I13"40 = A530( 32"
117D13I150"40 ); A4325->A130 = A1740; A4325->A127 |= ((A27) 0x08 | (A27) 0x1000000); if( A4325->A128 & ((A9070) 0x1000 | (A9070) 0x0800) ) goto A1771;
goto A1772"
18D80I16"71: A605 = A1740"
85D12I38"72: if( A4325->A128 & (A9070) 0x0800 )"
21D11I2"73"
21D2I2"74"
7D111I25"73: A606 = A1740;
A1774: "
116D23I25"4325->A127 & (A27) 0x4000"
34D2I2"75"
12D2I2"76"
7D2I47"75: A7622(A4325)->A130 = A1740;
A1776: ; 
A1726"
8D28I17"A1742->A303 == 31"
39D2I2"77"
12D2I2"78"
7D37I26"77: A536( NULL, A1740, 3 )"
42D21I61"78:
if( ( ( A1742->A303 ) == 28 || ( A1742->A303 ) == 35 ) ) "
29D2I14"79;
goto A1780"
7D47I19"79: A8991->A130 = 0"
52D19I33"80: ; 
A1714:
A5288:
return A1740"
29D4I4"1451"
10D27I125"510 = A1659("tmp");
A1661( NULL, 2, (A41) 10, A510 );
A509 = A999( 20, (A41) 1 );
A508 = A999( 5, (A41) 2 );
}
Void
A1452()
{"
33D39I69"3368 || A728 || A398 ) return;
if( A508 && (A508->A991 | A508->A990) "
69D22I52"1:
A1009( A508, 0 );
A1009( A509, 0 );
A1667( A510 )"
28D89
96D49I20"extern struct A144 *"
56D33I1"*"
40D33I1"*"
40D158I1"*"
163D93I1";"
102D93I15"72 A3468; 
char"
98D23I56"3[10] = "(null)"; 
struct A144 *A5336;
A5794 A5316;
Void"
30D34I15");
struct A5317"
39D43I239"794 A5318;
int *A5319;
};
const struct A5317 A5320[] =
{
"-ansi", (int *) &ansi_flag,
"-background", (int *) &A5305,
"-linebuf", (int *) &A1489,
"-macro", (int *) &A1075[(A41) 31],
"-tab", (int *) &A1503,
"-limit", (int *) &A1216,
"-maxope"
48D49I251"int *) &A660,
"-overload", (int *) &A8804,
"-specific_climit", (int *) &A1379,
"-specific_wlimit", (int *) &A1381,
"-specific_retry", (int *) &A1380,
"-tr_limit", (int *) &A5101,
"-template", (int *) &A1638,
"-static_depth", (int *) &A5822,
"-c_versio"
54D55I62"int *) &A5406,
"-cpp_version", (int *) &A5407,
};
struct A5326"
60D364I185"794 A5327;
A5794 A5328;
A42 A5329;
A7 A5372;
};
struct A5326 A5330[] =
{
"-strong", "-strong", 4, 2,
"-parent", "-parent", 5, 2,
"-father", "-father", 6, 2,
"-index", "-index", 7, 3,
"-"
370D121I5"", "-"
127D152I38"", 8, 2,
"-scanf", "-scanf", 9, 2,
"-w"
158I369"", "-wprintf", 10, 2,
"-wscanf", "-wscanf", 11, 2,
"-printf_code", "-printf_code", 12, 2,
"-scanf_code", "-scanf_code", 13, 2,
"-function", "-function", 14, 2,
"-sem", "-sem", 15, 1,
"-rw_asgn", "-rw_asgn", 18, 2,
"-ppw_asgn", "-ppw_asgn", 19, 2,
"-stack", "-stack", 20, 0,
"-deprecate", "-deprecate", 21, 3,
NULL, NULL, 0, 0
}; 
Void
A3429( A1833 )
A9 A1833;
{
fprintf"
10D3I1"c"
8D50I5"833 )"
61D2I2"62"
7D34I37"741, A2069 )
A5794 A1741;
A5794 A2069"
39D7I11"5332(A1741)"
13I36"2(A2069);
A5332("~~~~");
}
Void
A533"
6D21I19"58 )
A5794 A1758;
{"
29D14I3"58 "
44D22I31"1: fprintf( A656, "%s", A1758 )"
28D40I17"2: ;
}
Void
A5373"
45D43I6"7)
A48"
48D33I52"7;
{
A48 A1731, A1749;
A2 A1833;
if( !A1737 ) return"
38D15I24"31 = strchr( A1737, '(' "
21D3I48"49 = strrchr( A1737, ')' );
if( A1731 && A1749 )"
13D3I8"1;
goto "
8D33I39";
A1711:
A1833 = *A1749; *A1749 = '\0';"
38D36I30"1( A1731+1 );
*A1749 = A1833;
"
45D8I3"3;
"
13D7
13D8I8"1( A1737"
16D52I12"3: ;
}
Void
"
59D166I22"A1758 )
A5794 A1758;
{"
171D9I23"1( A1758 ); A3429( '\n'"
14I1" "
9D6I25"74( A2091, A1741, A5375 )"
15D3I3"144"
9D36I59"1;
A48 A1741;
A48 A5375;
{
A54 A1732;
A49 *A2098;
A48 A1758"
45D19I9"A1741 );
"
27D42I4"1 )
"
51D1I1"1"
12D1I1"2"
7D8I24"1: A1732=( 1);
A1715:
if"
14D79I52"8 = ( A2091)->A988+ A1732, A1732 <= ( A2091)->A991 )"
89D26I3"3;
"
38D25I16"A1716: A1732++;
"
34D30I36"5;
A1713:
if( A1758 = (A48) *A2098 )"
40D9I20"7;
goto A1720;
A1717"
18D11I18"A1758 );
A1720: ;
"
20D33I3"6;
"
38D31I2":
"
39D31I22"21;
A1712: if( A5375 )"
40D13I4"22;
"
21D25I2"23"
30D2I32"22: A5331( A5375 );
A1723:
A1721"
22D1
8D26I171"3430( A1741, A1731 )
A48 A1741;
A13 *A1731;
{
int A3431 = 2000;
int A1732;
int A3432;
if( !A1731 ) goto A1711;
goto A1712;
A1711: A3431 = 0;
A1712:
A3432 = A3431 / CHARLEN"
44D44I5"%s %d"
49D103I54"741, A3431 );
if(A1731) goto A1713;
goto A1714;
A1713:"
109D19I4" = 0"
25D2I3"7:
"
7D18I12"1732 < A3432"
29D1I1"5"
12D1I1"6"
6D2I30"20: A1732++;
goto A1717;
A1715"
8D23
28D9I10" % 20 == 0"
20D2I2"21"
12D2I2"22"
7D29I23"21: fprintf( A656, "\n""
36D11I37"22:
fprintf( A656, "%02x", *A1731++ )"
21D2I2"20"
8D15I28"6:
A1714:
fprintf( A656, "\n"
29D54I10"651(A1730)"
59D48I7"1730;
{"
54D17I3"656"
50D16I38" fprintf( A656, "nmodules=%d\n", A1730"
21D23
28D18I71" ;
}
static A17 A6068;
Void
A3433( A1850, A1851 )
A5794 A1850, A1851;
{"
24D19I14"1850 && A1851 "
30D1I1"1"
12D1I1"2"
7D22I52"1:
fprintf( A656, "\"%s\" \"%s\",\n", A1850, A1851 )"
28D2I81"2: ;
}
A5794
A6069( A80, A1961 )
A81 A80;
struct A849 *A1961;
{
A5794 A2100 = "";"
7D13I20"(A17) 0x010 == A6068"
25D1I1"1"
11D2I2"12"
8D19I1"1"
26D12I3"80 "
22D2I2"13"
12D2I2"14"
7D11I36"13: A2100 = A6037( A80->A140.A6021 )"
21D2I2"15"
7D26I16"14: if ( A1961 )"
35D2I14"16;
goto A1717"
7D4I33"16: A2100 = A6037( A1961->A6035 )"
9D18I13"17: ;
A1715: "
28D2I2"20"
8D23I11"2: if ( A80"
35D1I1"1"
12D1I1"2"
7D16I27"1: A2100 = A80->A155.A142;
"
24D2I2"23"
8D99I3"2: "
104D11I5"1961 "
21D2I2"25"
12D2I2"26"
7D23I23"25: A2100 = A1961->A851"
28D146I11"26:
A1723:
"
151D43I142":
return A2100;
}
Void
A3434( A80 )
A81 A80;
{
A42 A1875 = ((A17) 0x02 == A6068 ? 6 :
(A17) 0x04 == A6068 ? 86 :
(A17) 0x08 == A6068 ? 19 : 0)"
51D4I32"1875 || A1875 == (A42) A80->A130"
16D48I3"1;
"
56D14I2"12"
19D29I40"11:
A3433( A80->A129, A6069( A80, NULL )"
36D3I120"12: ;
}
Void
A3435( A1741, A1800 )
A48 A1741;
struct A1186 *A1800;
{
struct A144 *A2091;
fprintf( A656, "%s\n", A1741 );"
9D11I11"1800->A1187"
22D2I2"11"
12D2I2"12"
7D23I31"11:
A216( A1800->A1187, A3434 )"
28D6I31"12:
if( A2091 = A1800->A1188 ) "
15D1I13"3;
goto A1714"
6D4I47"13:
{
A49 *A2098;
A54 A1732;
struct A849 *A3436"
9D31I7"32=( 0)"
37D202I2"7:"
208D4I53"2098 = ( A2091)->A988+ A1732, A1732 <= ( A2091)->A991"
16D1I1"5"
12D1I1"6"
6D18I13"20: A1732++;
"
27D1I1"7"
7D22I1"5"
27D9I27"36 = (struct A849 *) *A2098"
16D20I4"3436"
31D3I22"21;
goto A1722;
A1721:"
8D12I53"!A6068 || A6068 & A3436->A852 ||
(A17) 0x010 == A6068"
23D2I2"23"
12D2I2"25"
7D28I46"23:
A3433( A3436->A850, A6069( NULL, A3436 ) )"
33D23I15"25: ;
A1722: ;
"
35D39I10"A1716: ;
}"
44D51I70"4:
fprintf( A656, "~~~~\n" );
}
Void
A6070( A3518, A6071 )
A5794 A3518"
56D14I134" A6071;
{
fprintf( A656, "%s\n%u\n~~~~\n", A3518, A6071 );
}
Void
A3437()
{
A6068 = 0;
fprintf( A656, "-w %d -wlib %d\n", A1403, A1404"
19D66I29"6070( "+efreeze", A1222.A6040"
71D66I30"6070( "++efreeze", A1222.A6042"
71D66I23"3430( "-e", A1222.A1174"
71D66I20"3430( "-elib", A1220"
71D67I24"3430( "+typename", A6043"
72D67I23"3430( "-elibsym", A1221"
72D67I32"3430( "-etemplate", A5396(A1218)"
72D68I31"3430( "-elibcall", A5396(A6038)"
73D68I43"6068 = (A17) 0x010; A3435( "-ecall", &A6046"
73D17I105"6068 = (A17) 0x02; A3435( "-esym", &A1323 );
A6068 = (A17) 0x08; A3435( "-efile", &A1323 );
A6068 = (A17)"
22D69I27"; A3435( "-estring", &A1323"
74D120I8"6068 = 0"
126D15I19"5( "-etype", &A6047"
20D9I23"3435( "-emacro", &A1324"
17D2I19"5( "-efunc", &A1325"
7D59I41"6068 = (A17) 0x02; A3435( "+esym", &A5984"
64D169I42"6068 = (A17) 0x08; A3435( "+efile", &A5984"
174D67I44"6068 = (A17) 0x04; A3435( "+estring", &A5984"
72D20I117"6068 = 0;
A3435( "+etype", &A6048 );
A3435( "+emacro", &A5985 );
A3435( "+efunc", &A5986 );
}
Void
A3438()
{
A6 A1732"
38D18I29"-f " );
A1732 = 0;
A1713:
if("
23D97I69"2 < A1210) goto A1711;
goto A1712;
A1714: A1732++;
goto A1713;
A1711:"
102D118I15"A1732 % 20 == 0"
130D1I1"5"
12D1I1"6"
7D23I22"5: fprintf( A656, "\n""
31D3I117"6:
fprintf( A656, "f%s%d ", A1209[A1732].A1197, *A1209[A1732].A1198 );
goto A1714;
A1712:
fprintf( A656, "\n~~~~\n" )"
13D179I116"5333( A1868 )
A9 A1868; 
{static A5794 const A3440 =
"bo c lc s i l ll f d ld pND pNP pFD pFP mpD mpNP mpFP w b";
A2"
184D1I69"6[10];
A2 A3441[10];
A5794 A1731;
int A1732;
void ( *A5334 )();
A5334"
6D89I24"868 == 's' ? A3401 : A53"
94D4I64"3429( '-' ); A3429( A1868 ); A3429( '\n' );
A1731 = A3440;
A1713"
10D72I6"*A1731"
83D1I1"1"
12D1I1"2"
7D24I12"1:
A1732 = 0"
29D51I3"36["
56D54I11"2++ ] = 's'"
60D26I49"4:if( *A1731 != ' ' && *A1731 ) goto A1715;
goto "
31D2
8D37I2"5:"
42D28I79"6[A1732++] = *A1731++; goto A1714;
A1716:
A1736[A1732] = '\0';
(*A5334)( A1736,"
33D152I45"1 );
fprintf( A656, "%s%s ", A1736+1, A3441 )"
158D62I36"7:if( *A1731 == ' ' || *A1731 == 'b'"
67D24I13"5334 == A5312"
35D2I2"20"
12D2I2"21"
7D18I23"20: A1731++; goto A1717"
23D35I6"21: ;
"
44D77I1"3"
83D13I108"2:
fprintf( A656, "\n~~~~\n" );
}
Void
A5274( A1948, A3195 )
FILE *A1948;
A48 A3195;
{
FILE *A5288;
A9 A1833"
20D43I24"5288 = fopen(A3195,"r") "
53D2I2"11"
12D2I2"12"
7D170I3"11:"
175D23I28"(A1833 = getc(A5288)) != EOF"
34D2I2"13"
12D2I2"14"
7D27I37"13:
fputc( A1833, A1948 );
goto A1711"
32D13I19"14:
fclose( A5288 )"
23D1I1"1"
8D3I118"2: printf( "unable to open file %s\n", A3195 );
A1715:
fclose( A1948 );
}
Void
A5335()
{
A72 A1732;
A1732 = 0;
A1713:
"
10D51I49"32 < ((A72) sizeof(A5320)/(A72) sizeof(A5320[0]))"
61D27I4"11;
"
35D14I2"12"
19D46I13"14: A1732++;
"
54D14I2"13"
19D50I84"11:
fprintf( A656, "%s %d\n", A5320[A1732].A5318, *(A5320[A1732].A5319)); goto A1714"
55D315I46"12: ;
}
Void
A5376()
{
A5374( A658, "-i", NULL"
320D151I35"5374( A3451, "-cpp", ".cpp\n.cxx\n""
156D260I35"5374( A3463, "-lnt", ".lnt\n.vac\n""
265D220I32"5374( A4440, "-headerwarn", NULL"
225D70I26"5374( A4436, "+libh", NULL"
75D125I26"5374( A4437, "-libh", NULL"
130D22I203"5374( A4438, "+libdir", NULL );
A5374( A4439, "-libdir", NULL );
A5374( A3464, "-header", NULL );
A5374( A7476, "-d", NULL );
A5374( A1468, "-d", NULL );
}
Void
A5337()
{
extern A42 A1211;
A5331( "-c " )"
30D40I3"211"
50D31I5"711;
"
38D14I2"71"
19D40I39"711: fprintf( A656, "-c%s\n", A5316 );
"
47D5I261"713;
A1712: A5332( "NONE" );
A1713: ;
}
Void
A5338()
{
A5332( "-size" );
fprintf( A656, "STATIC %lu\n", (unsigned long) A1214 );
fprintf( A656, "AUTO %lu\n", (unsigned long) A1213 );
A5332( "~~~~" );
}
Void
A5339()
{
A54 A1732 = 0;
A5332( "-ext" );
if( A1223 ) "
12D10I38"711;
goto A1712;
A1711:
A1732=0;
A1715"
16D59I19"A1732 < A1223->A989"
68D3I3"713"
12D15I11"714;
A1716:"
20D43I4"2++;"
51D5I37"715;
A1713:
if( A1223->A988[A1732] ) "
12D32I3"717"
41D46I50"720;
A1717:
A5332( A1223->A988[A1732] );
A1720: ; "
53D3I12"716;
A1714: "
12D2I2"72"
7D49I3"712"
55D75I21"default_ext[A1732] ) "
82D2I2"72"
12D2I2"72"
7D44I52"722:
fprintf( A656, "%s\n", default_ext[A1732++] ); "
51D36I197"712;
A1723:
A1721:
A5332( "~~~~" );
}
Void
A5340()
{
A5332( "-passes" );
fprintf( A656, "%d\n", A1337 );
A5332(A1342);
A5332(A1343);
A5332( "~~~~" );
}
Void
A5341()
{
A5331( "-zero " );
if ( !A1406"
46D3I3"711"
12D37I44"712;
A1711: fprintf( A656, "%u\n", A1219 );
"
44D5I157"713;
A1712: A5332( "ZERO" );
A1713: ;
}
Void
A5342( A1868 , A1731 )
A14 A1868;
A48 A1731;
{
A9 A1732;
A5331( A1731 );
A1732=0;
A1713:
if( A1732 < NUM_CHARS) "
12D34I3"711"
43D10I38"712;
A1714: A1732++;
goto A1713;
A1711"
16D25I21"A3355[A1732] == A1868"
30D10I32"isupper(A1732) && !islower(A1732"
15D20I34"!isdigit(A1732) && A1732 != '_' ) "
27D3I3"715"
12D30I23"716;
A1715: A3429(A1732"
35D74I5"716: "
81D5I84"714;
A1712:
A3429( '\n' );
}
Void
A5343()
{
A5332( "-libclass" );
if (A657 & 0x001) "
12D29I36"711;
goto A1712;
A1711: A5332( "all""
35D52I45"712:
if (A657 & 0x002) goto A1713;
goto A1714"
57D4I20"13: A5332( "angle" )"
9D6I27"14:
if (A657 & 0x004) goto "
11D90I11";
goto A171"
95D77I20"715: A5332( "ansi" )"
82D81I20"16:
if (A657 & 0x008"
92D1I1"7"
11D2I2"20"
8D12I20"7: A5332( "foreign" "
18D25I119"20:
A5332( "~~~~" );
}
Void
A5344()
{
struct A953 *A2092;
A72 A2282 = 0;
A2092 = A3450.A956;
A5332( "-pragma" );
A1711:"
30D17I42"2092[ A2282 ].A954 && *A2092[ A2282 ].A954"
29D1I1"2"
12D1I1"3"
7D21I93"2:
A5332( A2092[ A2282 ].A954 );
switch( A3450.A956[A2282++].A955 )
{
case 5: A5332( "OFF" );"
31D3I26"4;
case 6: A5332( "ON" ); "
12D71I27"4;
case 7: A5332( "ONCE" );"
81D3I31"4;
case 8: A5332( "MESSAGE" ); "
11D88I29"14;
case 9: A5332( "MACRO" );"
97D4I29"14;
case 10: A5332( "PPW" ); "
12D41I33"14;
case 11: A5332( "OPTIONS" ); "
49D2I86"14;
case 12: A5332( "FMACRO" ); goto A1714;
default: goto A1714;
}
A1714: ;
goto A1711"
7D81I251"13:
A5332( "~~~~" );
} 
Void
A5345()
{
A5332( "-idlen" );
fprintf( A656, "X %d\n", A431->A185);
fprintf( A656, "C %d\n", A1327);
fprintf( A656, "P %d\n", A1328);
A5332( "~~~~" );
}
Void
A5346()
{
extern struct A1162 A1222;
int A1732=0;
A5332( "-etd" )"
86D2I57"11:if( A3050[A1732].A1148 ) goto A1712;
goto A1713;
A1712"
10D6I9" A1222.A1"
12D84I23"A3050[A1732].A3049 ) ) "
92D2I2"14"
12D2I2"15"
7D21I29"14:
A5332( A3050[A1732].A1148"
28D11I2"15"
16D26I4"32++"
36D2I2"11"
8D2I136"3:
A5332( "~~~~" );
}
Void
A5377( A2026, A5378 )
A48 *A2026;
struct A5326 *A5378;
{
A7 A5379 = A5378->A5372;
A7 A1732, A1804;
A48 A2067;"
8D54I18"5378->A5329 == 15 "
64D34I4"11;
"
42D14I2"12"
19D31I44"11:
A5373( A2026[1] );
A3429( '\n' );
return"
36D4I13"12:
A1732 = 1"
9D4I52"15:
if( A2067 = A2026[A1732]) goto A1713;
goto A1714"
9D136I31"16: A1732++;
goto A1715;
A1713:"
142D44I12"1732 > A5379"
56D1I1"7"
11D2I2"20"
8D24I12"7:
A1804 = 1"
29D124I3"23:"
129D121I13"A1804 < A5379"
131D1I1"2"
12D1I1"2"
7D16I13"25: A1804++;
"
24D14I2"23"
19D27I27"21:
A5332( A2026[A1804] ); "
35D1I1"2"
7D24I4"22: "
29D4I30"20:
A5332( A2067 );
goto A1716"
10D1I87"4:
if( A1732++ <= A5379 ) goto A1726;
goto A1727;
A1726: A5332( "" ); goto A1714;
A1727"
13D94I68"5380()
{
A54 A1732;
struct A5326 *A5378;
A48 *A2092;
A48 A2067;
A537"
99D9I12"5330;
A1713:"
15D16I11"5378->A5328"
46D18I10"4: A5378++"
36D3I26"1:
A5332( A5378->A5328 );
"
8D16I4"5336"
28D1I1"5"
12D1I1"6"
7D30I30"5:
A2092 = (A48 *) A5336->A988"
35D4I13"32 =0;
A1717:"
9D19I18"1732 < A5336->A991"
30D31I4"20;
"
40D1I32"1;
A1720:
A2067 = A2092[++A1732]"
7D16I6"!A2067"
27D2I2"17"
8D17I38"strcmp( A2067+1, A5378->A5327+1 ) == 0"
32D28
41D26I41"1722:
A5377( A2092+A1732, A5378 );
A1723:"
31D48I12"A2092[A1732]"
81D30I9" ++A1732;"
40D1I10"3;
A1726: "
11D2I2"17"
8D117I3"1: "
122D23I31"16:
A5332( "~~~~" );
goto A1714"
28D3I203"12: ;
}
Void
A5357()
{
A5374( A5369, "+rw", NULL );
A5374( A5370, "+ppw", NULL );
} 
Void
A5359()
{
A5332( "-specific" );
A5332( A1445 );
A5332( A1446 );
A5332( "~~~~" );
} 
Void
A3442()
{
A5331( "-v ");"
8D107I5"A1402"
118D2I2"11"
12D2I2"12"
7D3I71"11: A3429( '+' ); goto A1713;
A1712: A3429( '-' );
A1713:
A3429( 'v' );"
11D114I2"00"
119D4I11"04 && A1401"
15D52I3"14;"
59D19I10"400 & 0x02"
30D31I4"15;
"
39D14I2"16"
19D78I14"15: A3429( 'f'"
90D2I2"17"
7D24I15"16: if( A1400 &"
29D49
60D2I2"20"
12D2I2"21"
7D21I14"20: A3429( 'm'"
28D24I37"21:
A1717:
A1714:
if( A1400 & 0x20 ) "
32D2I14"22;
goto A1723"
8D3I24"2: A3429( 's' );
A1723:
"
9D32I10"400 & 0x08"
43D2I2"25"
12D2I2"26"
7D25I24"25: A3429( 'o' );
A1726:"
32D2I2"40"
11D23
33D2I2"27"
12D2I2"66"
7D12I15"27: A3429( 'i' "
18D2I2"66"
8D56I12"A1400 & 0x40"
67D2I2"67"
12D2I2"68"
7D21I14"67: A3429( '#'"
28D2I2"68"
10D38I10"400 & 0x80"
49D2I2"69"
12D2I2"70"
7D17I24"69: A3429( 'h' );
A1770:"
22D69I11"A1400 & 0x2"
82D2I14"71;
goto A1772"
7D95I24"71: A3429( '-' );
A1772:"
100D16I12"A1400 & 0x80"
28D2I2"73"
11D3I3"774"
8D21I14"73: A3429( 'c'"
27D5I47"774:
if( A1400 & 0x400 ) goto A1775;
goto A1776"
10D29I16"75: A3429( 'd' )"
34D33I2"76"
40D40I13"1400 & 0x1000"
50D3I3"777"
12D55I32"778;
A1777: A3429( 't' );
A1778:"
60D128I15"A1400 & 0x4000 "
137D3I3"779"
12D28I22"780;
A1779: A3429( 'w'"
34D16I55"780:
if( A1400 & 0x04 && A1401 ) goto A1781;
goto A1782"
21D4I32"81:
fprintf( A656, "%u", A1401 )"
9D49I17"82:
A3429( '\n' )"
62D82I23"3( A1737 )
A48 A1737;
{"
87D249I58"!A656 ) return;
fprintf( A656, "OPTIONS %s BEGIN\n", A1737"
256D94I43"37();
A5333( 's' );
A5333( 'a' );
A3438( );"
99D303I56"2();
fprintf( A656, "-p %d \n", A1346 ? (int) A3468 : -1"
308D195I169"5341();
A5335();
A5359();
A5338();
A5345();
A5340();
A5342(A3355['a'], "-ident ");
A5342(4, "-ident1 ");
A5376();
A5339();
A5346();
A5343();
A5331( "-m " ); A5332( A5313"
200D40I230"5337();
A5380(); 
A5357(); 
A5344(); 
A5622( "-format_stack", A5510 );
A5622( "-ok", A5541 );
fprintf( A656, "OPTIONS %s END\n", A1737 );
}
Void
A3443(A80, A1757, A3444 )
A81 A80;
A67 A1757;
A4 A3444;
{
A39 A1761 = A80->A168.A166;"
45D5I119"!(A80->A127 & (A27) 0x2000) &&
A622(A80->A130) &&
A1761 != (A39) 18 &&
(A3444 || A1761 == (A39) 4 ||
A1761 == (A39) 1) "
15D2I2"11"
12D2I2"12"
7D35I26"11:
A895( A1757, A80 , 0 )"
40D6I190"12: ;
}
Void
A6072( A80, A6073, A6074 )
A81 A80;
A67 A6073, A6074;
{
A58 A1740 = A80->A130; A315 A1742 = ( A7174 = (A1740), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) ); "
11D26I41"1738 = A1742->A303; A27 A1709 = A80->A127"
32D92I27"!(A80->A127 & (A27) 0x10000"
104D2I2"11"
12D2I2"12"
7D52I81"11:
if( (A5106 > 0) && !(A1709 & (A27) 0x100000) && !A620(A1740) &&
A1738 != 33 )"
61D2I14"13;
goto A1714"
7D4I25"13:A895( A6073, A80 , 0 )"
10D58I2"4:"
65D10I38"5106 > 0) && !(A1709 & (A27) 0x200000)"
15D20I31"1738 == 25 &&
!A620(A1742->A306"
33D1I1"5"
12D1I1"6"
7D73I24"5:A895( A6074, A80 , 0 )"
79D69I3"6: "
75D17I97"2: ;
}
Void
A1454(A80)
A81 A80;
{
A67 A1730;
A9070 A1709;
A39 A2329;
A81 A3446;
A4 A5360 = (A4) 0"
23D31I101"( ( A7878 && (&A7877[(2u)])->A7866 & (A17) 0x04 && !(A80->A5796 & (A5793) 0x800000) ) && A7876(A80) )"
43D1I1"1"
12D1I1"2"
7D23I3"1: "
28D64I46"2:
A1709 = A80->A127;
A2329 = A80->A168.A166;
"
69D10I32"415 && A415->A163 & (A30) 0x0020"
21D2I2"13"
12D2I2"14"
7D158I26"13: A5360 = (A4) 1;
A1714:"
163D37I24"A80->A163 & (A30) 0x0400"
48D4I56"15;
if( A80->A128 & ((A28) 0x10|(A28) 0x8|(A28) 0x20) ) "
12D2I14"16;
goto A1717"
7D41I16"16:
A3364(A80);
"
46D3I3"113"
8D24I35"3
&& !(A80->A163 & (A30) 0x800000)
"
34D2I2"20"
12D2I2"21"
7D65I198"20:
A3446 = A213( A280(A721), A80->A129, 4 );
A3446->A127 |= A80->A127 &
(((A27) 0x1000 | (A27) 0x2000000) | (A27) 0x2000 | (A27) 0x80 | (A27) 0x100000 | (A27) 0x200000);
if( A3446->A170 < A80->A170"
76D2I14"22;
goto A1723"
7D4I27"22:
A3446->A170 = A80->A170"
9D3I5"23: ;"
8D9I16"1: ;
goto A1725;"
14D14I92"7: if( A1709 & (A27) 0x100 && A2156 || A1709 & (A27) 0x10000 ) goto A1726;
if( A2329 != (A39"
19D110I23" goto A1727;
goto A1766"
115D3I4"27:
"
8D27I34"2329 == (A39) 10 && A80->A155.A143"
38D2I2"67"
12D2I2"68"
7D28I50"67:
A1102( A80->A155.A143 );
A80->A155.A143 = NULL"
33D10I66"68:
if( !(A1709 & (A27) 0x1000) ) goto A1769;
goto A1770;
A1769:
i"
16D77I15"09 & (A27) 0x10"
89D2I2"71"
12D2I2"72"
7D22I15"71: A1730 = 715"
32D2I2"73"
7D28I4"72: "
33D11I26"80->A5796 & (A5793) 0x0002"
22D2I2"74"
12D2I2"75"
7D36I2"74"
42D12I11"(A5106 > 0)"
23D2I2"76"
12D2I2"77"
7D27I53"76: A5958( 1788, A80, A920(A80),
A1153(A80->A130,0) )"
32D9I33"77:
A1730 = 0;
goto A1778;
A1775:"
14D68I33"0 = A2329 == (A39) 10 ? 563 : 529"
73D30I10"78:
A1773:"
35D54I5"A1730"
65D2I2"79"
12D2I2"80"
7D14I25"79:A895( A1730, A80 , 0 )"
19D36I16"80: ;
goto A1781"
41D10I30"70: if( A2329 == (A39) 10 && !"
16D56I57" & (A27) 0x08) )
goto A1782;
goto A1783;
A1782:A895( 107,"
61D42I83", 0 );
goto A1784;
A1783:
A3363( A80, 0, (A4) 0 );
if( A1709 & (A27) 0x100 && A492("
50D77I74"30 ) == 27 ) goto A1785;
A3443( A80, 550, (A4) 0 );
A1785: ;
A1784:
A1781:"
82D5I11"(A1309 > 0)"
10D144I120"1709 & (A27) 0x100 &&
!(A1709 & ((A27) 0x8000|(A27) 0x80000)) && !A5360 &&
A2236( A80->A130 ) &&
A492( A80->A130 ) != 33"
155D2I2"86"
12D2I2"87"
7D40I30"86:
A892( 1746, A80, A415, 0 )"
45D4I4"87:
"
10D18I14"329 == (A39) 1"
29D2I2"88"
11D3I3"889"
8D65I151"88: A1566( A80 );
A1889:
{
A58 A1740 = A80->A130;
A315 A1742 = ( A7174 = (A1740), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) );
A70"
70D3I63"8 = A1742->A303;
if( A1709 & (A27) 0x10000 || A2329 == (A39) 10"
13D5I31"890;
if( A1709 & (A27) 0x100 ) "
12D37I4"891;"
45D37I43"892;
A1891:
if( !(A80->A128 & (A28) 0x20000"
48D3I3"893"
12D190I9"894;
A189"
197D12I59"!(A1709 & ((A27) 0x8000 | (A27) 0x80000 | (A27) 0x200000)) "
21D3I3"895"
12D11I15"896;
A1895:
if("
16D4I43"8 == 33 && !A620( A1742->A306 ) && !A5360 )"
12D21I5"897;
"
28D185I2"89"
190D4I46"897:A895( 1764, A80 , 0 );
goto A1899;
A1898: "
10D21I28"738 != 33 && !A620(A1740) )
"
28D3I3"900"
12D10I56"901;
A1900:A895( 952, A80 , 0 );
A1901: ;
A1899: ;
A1896"
16D4I33"!(A1709 & (A27) 0x200000) && A173"
9D8I37"25 &&
!A5360 && !A620(A1742->A306) )
"
15D3I3"902"
12D36I29"903;
A1902:A895( 818, A80 , 0"
42D12I14"903: ;
A1894: "
21D105I69"904;
A1892: if( A1709 & (A27) 0x1000 ) goto A1905;
goto A1906;
A1905:"
110D92I18"A1709 & (A27) 0x01"
102D3I3"907"
12D10I53"908;
A1907:
A6072( A80, 843, 844 );
goto A1909;
A1908"
16D64I65"!(A1709 & (A27) 0x100000) && !A620(A1740) &&
A492(A1740) != 33 )
"
71D3I3"910"
12D143I1"9"
149D3I31"910:A895( 953, A80 , 0 );
A1911"
9D15I65"!(A1709 & (A27) 0x200000) && A1738 == 25 && !A620(A1742->A306) )
"
22D3I3"912"
12D36I21"913;
A1912:A895( 954,"
41D52I61", 0 );
A1913: ;
A1909: ;
A1906: ;
A1904: ;
A1890: ;
}
A1766: "
57D131I4"26: "
137D172I3"5: "
177D59I15"15: ;
}
static "
65D88I89"3364(A80)
A81 A80;
{
A9070 A3037, A1709;
A39 A2329;
A2329 = A80->A168.A166;
A1132 = A2329"
93D37I61"A39) 9 ? 2 :
A2329 == (A39) 8 ? 6 :
A2329 == (A39) 14 ? 7 :
3"
42D13I83"09 = A80->A127;
A3037 = A80->A128;
if( A3037 & ((A28) 0x10|(A28) 0x8|(A28) 0x20) ) "
22D1I13"1;
goto A1712"
7D16I12"1: A1154(A80"
23D5I49"2:
if( !A3366 ) return;
if( A1709 & (A27) 0x80 ) "
14D1I13"3;
goto A1714"
9D26I1"
"
31D10I11"1340 & 0x20"
22D1I1"5"
12D1I1"6"
7D1I1"5"
6D16I23"68( A80, A1709, A2329 )"
22D59I2"6:"
64D146I20"A1709 & (A27) 0x1000"
158D1I1"7"
11D2I2"20"
8D50I26"7:
A3363( A80, 728, (A4) 1"
55D68I23"3443(A80, 551, (A4) 0);"
73D13I18"!(A1709&(A27) 0x08"
25D1I1"2"
12D1I1"2"
7D21I21"21:A895( 402, A80 , 0"
28D25I6"22: ;
"
33D14I2"23"
19D23I81"20: if( (A1709 & ((A27) 0x08|(A27) 0x200)) == (A27) 0x08 ) goto A1725;
goto A1726"
28D2I2"25"
8D17I98"!(A80->A163 & ((A30) 0x800000|(A30) 0x4000)) &&
!( A80->A128 & (A28) 0x40 &&
A2329 == (A39) 5 ) )
"
25D2I2"27"
12D1I1"6"
7D21I21"27:A895( 528, A80 , 0"
28D47I4"66: "
52D24I3"26:"
29D120I45"3:
A6072( A80, 843, 844 );
goto A1767;
A1714:"
126D14I54"1709 & (A27) 0x1000000
&& !(A80->A163 & (A30) 0x0800)
"
24D4I34"68;
if( A1709 & (A27) 0x2000000 ) "
12D2I14"69;
goto A1770"
7D39I31"69:
A80->A128 |= (A28) 0x800000"
44D73I4"70: "
78D2I11"68: ;
A1767"
7D35I60"->A127 &= ~((A27) 0x1000000|(A27) 0x2000000|(A27) 0x20000000"
44D40I60"5796 &= ~(A5793) 0x0004;
}
static Void
A3365(A80)
A81 A80;
{"
46D19I43"80->A128 & ((A28) 0x10|(A28) 0x8|(A28) 0x20"
32D1I1"1"
11D2I2"12"
8D46I25"1:
A1132 = 4;
A1154(A80);"
51D75I123"2:
A80->A127 &= ~(A27) 0x1000;
}
Void
A3363(A80, A1757, A3444 )
A81 A80;
A67 A1757;
A4 A3444;
{
A39 A1761 = A80->A168.A166;"
80D35I119"!(A80->A170) && A622(A80->A130) &&
A1761 != (A39) 18 &&
A1761 != (A39) 1 && !(A80->A128 & ((A28) 0x1000 | (A28) 0x2000)"
47D2I2"11"
12D2I2"12"
7D43I16"11:
if( A3444 ) "
51D2I14"13;
goto A1714"
7D25I27"13:A895( A1757, A80 , 0 );
"
33D14I2"15"
19D38I24"14: A1991( A80, (A4) 0 )"
43D37I4"15: "
42D25I125"12: ;
}
Void
A1456(A80)
A81 A80;
{
A39 A2329;
A30 A3447 = A80->A163;
A9070 A1948;
A2329 = A80->A168.A166;
A1948 = A80->A127;
"
30D13I15"2329 == (A39) 9"
24D1I1"1"
12D1I1"1"
7D31I14"11: A1161( A80"
38D40
48D1I1"1"
7D1I1"1"
9D13I16"2329 == (A39) 14"
24D1I1"1"
12D1I1"1"
7D16I21"14: A1161( A80, 7 );
"
24D14I2"16"
19D64I1"1"
72D13I19"3447 & (A30) 0x0800"
24D22I3"17;"
28D4I19"3447 & (A30) 0x4000"
15D4I27"20;
if( A2329 == (A39) 8 ) "
12D74I4"21;
"
79D13I16"2329 == (A39) 18"
24D22I3"22;"
28D4I20"1948 & (A27) 0x10000"
15D4I87"23;
A5268( A80, A1948, A2329 );
if( (A1948 & ((A27) 0x08|(A27) 0x200)) == (A27) 0x08 ) "
12D2I14"25;
goto A1726"
7D67I4"25:
"
72D13I22"1335 > 1 && !A80->A161"
23D3I3"727"
12D11I45"766;
A1727:
{
A9070 A3081;
A3081 = A80->A128;"
16D29I38"(A3081 & ((A28) 0x40 | (A28) 0x800000)"
34D4I13"(A28) 0x40 )
"
11D3I3"767"
12D185I2"76"
190D3I31"767:A895( 759, A80 , 0 );
A1768"
9D15I107"!(A3081 & (A28) 0x800000)
&& !(A1948 & ((A27) 0x01|(A27) 0x80|(A27) 0x400000|(A27) 0x800000))
&& !A80->A161"
25D2I2"76"
12D2I2"77"
7D54I5"769:
"
59D13I125"1422( A80->A129 ) ||
( A7174 = ( A80->A130 ), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) )->A307 & 0x1000"
23D22I52"771;
A895( 765, A80 , 0 );
A1771: ;
A1770: ;
}
A1766"
29D14I20"1948 & (A27) 0x10000"
24D5I32"772;
if( A1948 & (A27) 0x1000 ) "
12D40I3"773"
49D33I90"774;
A1773:
A3363( A80, 729, (A4) 1 );
A3443( A80, 552, (A4) 1 );
A6072( A80, 843, 844 );
"
40D22I10"775;
A1774"
28D15I70"!(A1948 & ((A27) 0x01|(A27) 0x80|(A27) 0x400000)) &&
!A1422(A80->A129)"
25D3I3"776"
12D29I29"777;
A1776:A895( 714, A80 , 0"
35D3I21"777: ;
A1775: ;
A1772"
14D10I10"778;
A1726"
17D12I32"1948 & ((A27) 0x1000|(A27) 0x200"
23D3I3"779"
12D11I33"780;
A1779:
{
struct A118 *A2054;"
17D35I34"1340 & 0x10 && A1948 & (A27) 0x200"
45D3I3"781"
12D61I20"782;
A1781: A460(A80"
66D7I68"782:
if( !(A1948 & ((A27) 0x200|(A27) 0x80)) &&
A2329 != (A39) 18 ) "
14D33I5"783;
"
40D22I38"784;
A1783:A895( 526, A80 , 0 );
A1784"
29D14I39"1948 & (A27) 0x1000 && A2329 == (A39) 5"
24D3I3"785"
11D43I105"1786;
A1785:
{
A315 A1742;
if( (A2054 = A284(A80)) && A2054->A121 & (A27) 0x08 ||
A1948 & (A27) 0x4000 ) "
49D31I126"1787;
A1742 = ( A7174 = ( A80->A130 ), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) );
if( !A1742->A314.A310"
40D4I4"1788"
12D28I64"1889;
A1788:A895( 628, A80 , 0 );
A1889: ;
A1787: ;
}
A1786: ;
}"
35D13I44"1890;
A1780: A1161( A80, 3 );
A1890:
A1778:
"
18D13I40"2329 == (A39) 5 && A731( A80->A129 ) & 4"
22D4I4"1891"
12D118I97"1892;
A1891:
{
A62 A2061;
struct A322 *A1752;
A58 A1740;
if( (A2061 = A274( A80->A130 )) &&
(A175"
123D7I89"(struct A322 *) A386[A2061])) &&
A1752->A324 == 2 &&
(A1740 = A2236( A1752->A323[0] ))
) "
13D34I6"1893;
"
40D79I29"1894;
A1893: A738( A80, A1740"
84D108I68"1894: ;
}
A1892: ;
A1723: ;
A1722: ;
A1721: ;
A1720: ;
A1717: ;
A171"
113D10I60"A1713: ;
}
Void
A1455(A80)
A81 A80;
{
A9070 A1709;
A39 A2329"
15D4I40"29 = A80->A168.A166;
A1709 = A80->A127;
"
9D13I37"2329 == (A39) 4 && A1709 & (A27) 0x80"
22D4I4"1711"
12D11I11"1712;
A1711"
17D58I58"(A1709 & ((A27) 0x1000000|(A27) 0x200)) == (A27) 0x1000000"
67D4I4"1713"
12D70I13"1714;
A1713:
"
75D13I19"1709 & (A27) 0x1000"
22D4I4"1715"
12D20I29"1716;
A1715:
A3363( A80, 728,"
26D131I20"1 );
A3443(A80, 551,"
137D31I149"0);
A1716: ;
A1714:
A80->A127 &= ~(A27) 0x1000000;
A1712:
A3364(A80);
}
Void
A3448(A80)
A81 A80;
{
A31 A1948;
struct A83 *A1724;
struct A189 *A3277;
"
36D11I22"1724 = A506( A80->A130"
22D3I3"171"
12D12I33"1712;
A1711:
A1948 = A1724->A191;"
17D38I18"A1948 & (A31) 0x10"
47D3I3"171"
12D35I58"1714;
A1713:
if( (A1948 & ((A31) 2|(A31) 4) ) == (A31) 2 )"
42D34I6"1715;
"
40D4I42"1716;
A1715:A895( 1512, A80 , 0 );
A1716: "
12D138I11"1717;
A1714"
144D17I115"(A1948 & (A31) 0x200 || A1948 & (A31) 4 && !A1724->A190) &&
!(A1948 & (A31) 0x400) &&
!(A80->A127 & (A27) 0x200) )
"
23D4I4"1720"
12D11I75"1721;
A1720:A895( 1711, A80 , 0 );
A1721:
A1717:
A3277 = A1724->A190;
A1725"
18D24I4"3277"
32D4I4"1722"
12D26I34"1723;
A1726: A3277 = A3277->A250;
"
32D6I148"1725;
A1722:
{
A70 A7071 = A492( A3277->A252 );
if( (A3277->A251 & (0x01 | 0x04)) == 0x01 &&
!( (A7071) == 42 || (A7071) == 45 || (A7071) == 40 ) ) "
12D86I4"1727"
94D33I61"1766;
A1727:
A886( 1749, A688(A3277->A252), A80 );
A1766: ;
}"
40D24I77"1726;
A1723: ;
A1712: ;
}
Void
A5207()
{
A5158 = A1493->A642;
(void) A2161();"
29D5I12"(A2142 == 11"
10D22I21"2153 == ( (A36) 22 ))"
31D4I4"1711"
12D12I53"1712;
A1711:
(void) A2161();
(void) A2161();
A5145();"
17D19I13"1( (A36) 22 )"
27D11I11"1713;
A1712"
17D13I36"(A2142 == 11 && A2153 == ( (A36) 7 )"
23D4I4"1714"
12D198I4"1715"
203D4I80"14:
(void) A2161();
if( strcmp(( *(A5153) ),A2149) == 0 ) goto A1716;
goto A1717"
9D4I23"16: A5149();
goto A1720"
9D4I35"17: A887( 94, A2149, ( *(A5153) ) )"
9D10I1"2"
15D9I5"goto "
14D10I167";
A1715: if( A2142 == 12 ) goto A1722;
goto A1723;
A1722:
(*(((A49)*++ A5153 == ((A49) &A1525)) ? (A1521((A1523 *)& A5153), A5153) : A5153 ) = A1076( A1378, A2149 ) );"
15D91I39"6( A5179, "" );
(void) A2161();
A5145()"
97D105I39"(A2142 == 11 && A2153 == ( (A36) 7 )) )"
114D59I4"25;
"
67D72I28"26;
A1725: A5149();
A1726: ;"
81D36I49"27;
A1723: if( A2142 == 11 && A2153 == (A36) 14 )"
45D31I4"66;
"
39D47I2"67"
52D34I67"66:
(void) A2161(); 
A1768:if( !(A2142 == 11 && A2153 == (A36) 8) )"
43D2I2"66"
7D25I4"69: "
30D65I17"67:
A1727:
A1721:"
70D17I129"3:
A5151( (A36) 8 );
}
Void
A5208( A8680 )
A5794 A8680;
{
A2 A1736[200];
A48 A1731;
A48 A2556;
A7 A1883;
A2556 = ((A48)( A8680 ))"
23D3I2"1:"
8D4I27"1731 = A5094( "\n", A2556 )"
16D1I1"2"
11D2I2"13"
8D14I27"2: *A1731 = '.'; goto A1711"
19D9I11"13:
sprintf"
15D12I64"6, " //%4u: %.40s = \"%.100s\" ",
A5158, ( *(A5153) ), A2556 );
"
17D4I8"1649 < 0"
15D2I2"14"
12D2I2"15"
7D15I34"14: A1883 = (A7) A1654;
goto A1716"
20D33I28"15: A1883 = A5916();
A1716:
"
38D4I11"1883 > 30-1"
15D2I2"17"
13D1I1"0"
6D25I4"17: "
40I19"A1883 = 0; 
A1720:
"
5D4I11"1883++ < 30"
16D1I1"1"
12D1I1"2"
7D26I26"1:A1664( ' ' );
goto A1720"
32D26I8"2:A1666("
31D13I21"6 );
}
Void
A5209()
{"
21D30I4"3295"
35D47I17"076( A1378, A2149"
52D4I28"48 A1737;
A17 A1709=0;
A5158"
9D3I133"493->A642;
if( (strcmp( A3295, "AdditionalIncludeDirectories" ) == 0) ) goto A1711;
goto A1712;
A1711:
A1709 |= 1;
A1712:(void) A2161"
8D34I39"5151( (A36) 18 );
A1737 = A5150(A1709);"
39D31I20"6( A3295, A1737 );
}"
37D83I20"
A5144()
{
A81 A80;
"
88D63I129"80 = A213(A1502, "Configuration", 1) )
return A80->A155.A142;
return NULL;
}
A4
A5941(A2556)
A5794 A2556;
{
A5794 A1737 = A5144()"
70D13I153"1737 && A240( A1737, A2556 ) ) return (A4) 1;
return (A4) 0;
}
A7
A8993( A1737, A1859 )
A5794 A1737;
A48 A1859;
{
A7 A1875 = 0;
if( A240( "amp;", A1737 )"
25D1I1"1"
12D1I1"2"
7D8I3"1: "
16D51I18"4; *A1859 = '&'; 
"
60D13I1"3"
19D20I29"2: if( A240( "lt;", A1737 ) )"
33D21I5"goto "
26D45
50D29I40"14: A1875 = 3; *A1859 = '<'; 
goto A1716"
34D3I4"15: "
8D37I18"240( "gt;", A1737 "
49D2I2"17"
13D1I1"0"
6D22I30"17: A1875 = 3; *A1859 = '>'; 
"
31D1I1"1"
7D22I3"0: "
27D77I21"240( "quot;", A1737 )"
89D1I1"2"
12D1I1"3"
7D67I57"2: A1875 = 5; *A1859 = '"'; 
A1723:
A1721:
A1716:
A1713:
"
74D19I80"A1875;
}
A4
A5210( A1960 )
A5794 A1960[];
{
A5794 *A2970 = A5152+1;
A7 A1732;
A7"
24D60I15"1=0;
A861 A1841"
65D32I6"32 = 0"
37D21I2"13"
28D47I13"1960[A1732]) "
59D17
26D1I1"2"
7D9I109"4: A1732++;
goto A1713;
A1711: ++A5211; goto A1714;
A1712:
A1841 = A5148( A2970, (A7) (A5153 - A5152), A1960,"
14D3I20"1 );
return A1841 =="
11D1I10"1 ? (A4) 1"
6D6I4"4) 0"
17D12I77"212( A2026, A1833 )
struct A5200 *A2026;
A9 A1833;
{
A9 A1868;
A1711:if( A186"
17D119I163"2026->A5201 ) goto A1712;
goto A1713;
A1712:
if( A1868 == A1833 ) goto A1714;
goto A1715;
A1714: A5147( 'd', A2026->A5202 );
A1715:
++A2026;
goto A1711;
A1713: ;
}"
125D113I43"
A5213()
{
A7 A1732=0;
A7 A1759 = M_TOKEN -"
118D51I35"81 A80;
A2149[A1732++] = (A2) A1463"
57D5I38"((A1463=(A9)(A15)(*A1492++)) ? ((A1463"
11D5I48"9)(A15)('\\'))?A1462():A1463) : A1461() ) == '('"
39D94I68"if( A1732 < A1759 && A1463 != EOF && A1463 != '"' && A1463 != ')' ) "
106D127
139I130"A1713:
A2149[A1732++] = (A2) A1463;
(void) ((A1463=(A9)(A15)(*A1492++)) ? ((A1463 == (A9)(A15)('\\'))?A1462():A1463) : A1461() );
"
9D1I1"1"
10D62I24"if( A1463 == ')' ) goto "
67D27I44";
goto A1716;
A1715:
A2149[A1732] = '\0';
if"
32D31I54" = A213( A1502, A2149+2, 1 ) ) goto A1717;
goto A1720;"
36D49I120"7:
(void) ((A1463=(A9)(A15)(*A1492++)) ? ((A1463 == (A9)(A15)('\\'))?A1462():A1463) : A1461() );
return A80->A155.A142;
"
57D14I2"21"
19D113I173"20:
A2149[1] = '%';
A2149[A1732++] = '%';
A2149[A1732] = '\0';
(void) ((A1463=(A9)(A15)(*A1492++)) ? ((A1463 == (A9)(A15)('\\'))?A1462():A1463) : A1461() );
return A2149 + 1"
118D6I150"21: ;
A1716: ;
A1712:
A2149[A1732] = '\0';
return A2149;
}
Void
A5214()
{
A1711:if( A2142 != 1 ) goto A1712;
goto A1713;
A1712:
if( (A2142 == 11 && A2"
11I313"= ( (A36) 12 )) ) goto A1714;
goto A1715;
A1714: A5207();
goto A1716;
A1715: (void) A2161();
A1716: ;
goto A1711;
A1713: ;
}
Void
A5145()
{
A1711:if( A2142 == 12 ) goto A1712;
goto A1713;
A1712: A5209(); goto A1711;
A1713: ;
}
Void
A5146( A3295, A2556 )
A5794 A3295;
A48 A2556;
{
if( !A2556 ) return;
(*(((A49)*++"
5D10I40"3 == ((A49) &A1525)) ? (A1521((A1523 *)&"
15D15I274"3), A5153) : A5153 ) = A3295 );
A5157 = A2556;
if( A5436 == (A42) 2 ) goto A1711;
goto A1712;
A1711: A9313( A2556 );
goto A1713;
A1712: if( A5436 == (A42) 4 ) goto A1714;
goto A1715;
A1714: A9312( A2556 );
goto A1716;
A1715: A5445( A2556 );
A1716:
A1713:( A5153 )--;
A5157 ="
20D447
458D20I24"445( A2556 )
A5794 A2556"
29D11I11"5210( A5457"
46D13I19" A5147( 'f', A2556 "
22D101
107D25I13"5210( A5458 )"
37D1I1"3"
12D1I1"4"
7D70I23"3: A5147( 'd', A2556 );"
75D2I3"4:
"
7D29I13"5210( A5459 )"
41D1I1"5"
12D1I1"6"
7D3I31"5: A5147( 'd', A2556 );
A1716:
"
8D11I13"5210( A5460 )"
23D1I1"7"
11D2I2"20"
8D25I24"7: A5147( 'i', A2556 );
"
30D9I41": ;
}
Void
A9312( A2556 )
A5794 A2556;
{
"
14D11I13"5210( A9318 )"
22D1I1"1"
12D1I1"1"
7D70I23"11: A5147( 'f', A2556 )"
75D4I122"12: ;
}
Void
A9313( A2556 )
A48 A2556;
{
A81 A80;
static A5794 A5942;
static A4 A5943 = (A4) 0;
static A4 A8522 = (A4) 0;
"
9D24I13"5210( A5183 )"
35D2I2"11"
12D2I2"12"
7D12I16"11: if( !A5154 )"
21D2I14"13;
goto A1714"
7D27I73"13: { A5794 A1737 = A5144();
if( !A1737 && A2556 ) goto A1715;
goto A1716"
32D30I83"15:
A80 = A213( A1502, "Configuration", 2 );
A80->A155.A142 = A1076( A1344, A2556 )"
35D18I93"16:
if( A2556 && A5941(A2556) ) goto A1717;
goto A1720;
A1717: A5154 = (A4) 1; A5155 = (A4) 1"
24D97I16"20: ;
}
A1714: ;"
106D2I2"21"
7D1I1"1"
9D40I11"5210( A5184"
53D2I2"22"
12D2I2"23"
7D111I46"22:
if( A5155 && (strcmp(A2556,"TRUE") == 0) )"
120D2I14"25;
goto A1726"
7D122I32"25:
A5147( 'd', "_ATL_MIN_CRT" )"
127D4I16"26: ;
goto A1727"
10D6I24"3: if( A5210( A5188 ) ) "
14D2I14"66;
goto A1767"
7D49I3"66:"
55D11I4"5155"
22D2I2"68"
12D2I2"69"
7D10I46"68: A5212( A5203, (A9)(A15)(*A2556) );
A1769: "
21D1I1"0"
6D96I47"67: if( A5210( A5186 ) ) goto A1771;
goto A1772"
102D33I3693"1:
A80 = A213( A1502, "IntDir", 2 );
A80->A155.A142 = A9038( A1344, A2556 );
goto A1773;
A1772: if( A5210( A5195 ) ) goto A1774;
goto A1775;
A1774:
if( A5155 ) goto A1776;
goto A1777;
A1776: A5212( A5204, (A9)(A15)(*A2556) );
A1777: ;
goto A1778;
A1775: if( A5210( A5185 ) ) goto A1779;
goto A1780;
A1779:
if( A5155 ) goto A1781;
goto A1782;
A1781: A5212( A5205, (A9)(A15)(*A2556) );
A1782: ;
goto A1783;
A1780: if( A5210( A5187 ) ) goto A1784;
goto A1785;
A1784:
if( A5155 ) goto A1786;
goto A1787;
A1786: A5212( A5206, (A9)(A15)(*A2556) );
A1787: ;
goto A1788;
A1785: if( A5210( A5189 ) ) goto A1889;
goto A1890;
A1889:
if( A5155 && A5299( A2556, A5170 ) == 0 ) goto A1891;
goto A1892;
A1891:
A5156 = (A4) 1;
A1892: ;
goto A1893;
A1890: if( A5210( A5190 ) ) goto A1894;
goto A1895;
A1894:
A5156 = (A4) 0;
goto A1896;
A1895: if( A5210( A5191 ) ) goto A1897;
goto A1898;
A1897:
if( A5156 && *A2556 ) goto A1899;
goto A1900;
A1899: A5147( 'd', A2556 );
A1900: ;
goto A1901;
A1898: if( A5210( A5192 ) ) goto A1902;
goto A1903;
A1902:
if( A5156 && *A2556 ) goto A1904;
goto A1905;
A1904: A5147( 'i', A2556 );
A1905: ;
goto A1906;
A1903: if( A5210( A5758 ) ) goto A1907;
goto A1908;
A1907:
if( A5156 && *A2556 ) goto A1909;
goto A1910;
A1909: A5147( 'o', A2556 );
A1910: ;
goto A1911;
A1908: if( A5210( A5193 ) ) goto A1912;
goto A1913;
A1912:
if( A5156 && (strcmp(A2556,"TRUE") == 0) ) goto A1914;
goto A1915;
A1914:
A1666( "+fwc " );
A5147( 'd', "_WCHAR_T_DEFINED" );
A1915: ;
goto A1916;
A1913: if( A5210( A5194 ) ) goto A1917;
goto A1918;
A1917:
if( A5156 && *A2556 ) goto A1919;
goto A2330;
A1919: A5147( 'u', A2556 );
A2330: ;
goto A2331;
A1918: if( A5210( A5196 ) ) goto A2332;
goto A2333;
A2332: A5155 = (A4) 0;
goto A2334;
A2333: if( A5210( A5197 ) ) goto A2335;
goto A2336;
A2335: A5155 = (A4) 0;
goto A2337;
A2336: if( A5210( A5934 ) ) goto A2338;
goto A2339;
A2338:
A5942 = NULL;
A8522 = (A4) 0;
goto A2340;
A2339: if( A5210( A5935 ) ) goto A2341;
goto A2342;
A2341:
if( A5942 ) goto A2343;
goto A2344;
A2343:A1666( A5942 );
A2344:
A5942 = NULL;
if( A8522 ) goto A2345;
goto A2346;
A2345:
A1666( "-restore_i\n" );
A8522 = (A4) 0;
A2346: ;
goto A2347;
A2342: if( A5210( A5199 ) ) goto A2348;
goto A2349;
A2348:
if( *A2556 && (last_ext(A2556,ext_TEST,dot_c) || A1416(A2556)) ) goto A2350;
goto A2351;
A2350:
A5942 = A5931( 'f', A2556 );
A2351: ;
goto A2352;
A2349: if( A5210( A5936 ) ) goto A2353;
goto A2354;
A2353: A5943 = (A4) 0;
goto A2355;
A2354: if( A5210( A5937 ) ) goto A2356;
goto A2357;
A2356:
if( A5941(A2556) ) goto A2358;
goto A2359;
A2358: A5943 = (A4) 1;
A2359: ;
goto A2360;
A2357: if( A5210( A5938 ) ) goto A2361;
goto A2362;
A2361:
if( (A5299( A2556, "TRUE" ) == 0) && A5943 ) goto A2363;
goto A2364;
A2363:
A5942 = NULL;
A2364: ;
goto A2365;
A2362: if( A5210( A7486 ) ) goto A2366;
goto A2367;
A2366:
if( A5155 && (strcmp( A2556, "2" ) == 0) ) goto A2368;
goto A2369;
A2368:
A5147( 'd', "_AFXDLL" );
A2369: ;
goto A2370;
A2367: if( A5210( A8519 ) ) goto A2371;
goto A2372;
A2371:
if( A5943 && A5156 && *A2556 ) goto A2373;
goto A2374;
A2373:
if( !A8522 ) goto A2375;
goto A2376;
A2375:
A8522 = (A4) 1;
A1666( "-save_i\n" );
A2376:
A5147( 'i', A2556 );
A2374: ;
goto A2377;
A2372: if( A5210( A8520 ) ) goto A2378;
goto A2379;
A2378:
if( A5943 && A5299(A2556,A5170) == 0 ) goto A2380;
goto A2381;
A2380:
A5156 = (A4) 1;
A2381: ;
goto A2382;
A2379: if( A5210( A8521 ) ) goto A2383;
goto A2384;
A2383:
A5156 = (A4) 0;
A2384: ;
A2382: ;
A2377: ;
A2370: ;
A2365: ;
A2360: ;
A2355: ;
A2352: ;
A2347: ;
A2340: ;
A2337: ;
A2334: ;
A2331: ;
A1916: ;
A1911: ;
A1906: ;
A1901: ;
A1896: ;
A1893: ;
A1788: ;
A1783: ;
A1778: ;
A1773: ;
A1770: ;
A1727: ;
A1721: ;
}
Void
A5147( A3388,"
39D14I2710" )
A9 A3388;
A5794 A1737;
{
A4 A2015 = (A4) 0;
A5794 A2959 = NULL;
A72 A1883;
if( !A1737 ) return;
switch( A3388 )
{
case 'i': A1666( "-i" ); A2959 = strchr( A1737, ';' ); A2015 = (A4) 1; goto A1711;
case 'd': A1666( "-D" ); A2959 = strchr( A1737, ';' ); goto A1711;
case 'f':
if( last_ext( A1737, ext_TEST, dot_c ) || A1416( A1737 ) )
goto A1711;
return;
case 'u': A1666( "-U" ); goto A1711;
case 'o': return;
default: goto A1711;
}
A1711:
if( A2959 ) goto A1712;
goto A1713;
A1712: A1883 = (A72) (A2959 - A1737); goto A1714;
A1713: A1883 = ((A72) strlen(A1737));
A1714: if( A8713( A1737, ' ', (A7) A1883 ) ) goto A1715;
goto A1716;
A1715: A2015 = (A4) 1;
A1716: if( A2015 ) goto A1717;
goto A1720;
A1717:A1664( '"' );
A1720: A8712( A1737, A1883 ); if( A2015 ) goto A1721;
goto A1722;
A1721:A1664( '"' );
A1722: A5208( A5157 ? A5157 : "" ); if( A2959 ) goto A1723;
goto A1725;
A1723: A5157 = NULL; 
A1725:A1664( '\n' ); if( A2959 ) goto A1726;
goto A1727;
A1726: A5147( A3388, A2959+1 );
A1727: ; }
A5794
A5931( A3388, A1737 )
A9 A3388;
A5794 A1737;
{
A5794 A2100;
A57 A1871 = A1649;
A1649 = A943;
A1668();
A5147( A3388, A1737 );
A2100 = A1669();
A1649 = A1871;
return A2100;
}
A861
A5148( A5215, A5216, A5217, A5218 )
A5794 *A5215;
A7 A5216;
A5794 *A5217;
A7 A5218;
{
A5794 A5219, A5220;
A861 A1875;
A1711:if( A5218 ) goto A1712;
goto A1713;
A1712:
A5220 = *A5217++; --A5218;
if( A5220 == A5182 ) goto A1714;
goto A1715;
A1714:
if( (A1875 = A5148( A5215, A5216, A5217, A5218 )) == (A861) 0 ) goto A1716;
goto A1717;
A1716: A5215++; A5216--; goto A1714;
A1717:
return A1875;
A1715:
if( A5220 == A5898 ) goto A1720;
goto A1721;
A1720: A5220 = *A5217++; --A5218;
A1722:if( A5216 && (strcmp( A5220, *A5215 ) == 0) ) goto A1723;
goto A1725;
A1723: A5215++; --A5216; goto A1722;
A1725:
goto A1711;
A1721:
if( A5216 == 0 ) return (A861) (-1);
A5219 = *A5215++; --A5216;
if( A5220 == A5456 ) goto A1726;
goto A1727;
A1726:
A5220 = *A5217++; --A5218;
if( !(strcmp( A5220, A5219 ) == 0) ) return (A861) 0;
A1766:if( A5216 && (strcmp( A5220, *A5215 ) == 0) ) goto A1767;
goto A1768;
A1767: ++A5215; --A5216; goto A1766;
A1768:
goto A1711;
A1727:
if( A5220 == A5181 || strcmp( A5220, A5219 ) == 0 )
goto A1711;
return (A861) 0;
goto A1711;
A1713:
return A5216 ? (A861) 0 : (A861) 1;
}
Void
A5149()
{
A5158 = A1493->A642;
A5146( A5180, "" );
( A5153 )--;
(void) A2161();
}
Void
A5107(A1886,A1948)
struct A640 *A1886;
A9070 A1948;
{
A5794 A5221;
lnt_option( "+linebuf", 0 );
lnt_option( "+linebuf", 0 );
A5436 = A1948 & (A9070) 0x20000 ? (A42) 3 :
A1948 & (A9070) 0x80000000 ? (A42) 4 :
(A42) 2;
A1415( A1886, (A4) 1 );
A655 = A1657;
A1666( "/* " );
if( A5436 == (A42) 2 ) goto A1711;
goto A1712;
A1711:
A1666( "-dConfigur"
19I2721"=" );
A5221 = A5144();
A1666( A5221 ? A5221 : " ... none provided " );
goto A1713;
A1712: if( A5436 == (A42) 4 ) goto A1714;
goto A1715;
A1714:
goto A1716;
A1715:
{
static A2 A5462[] = "C:\\program files\\borland\\cbuilder6";
A81 A80 = A213( A1502, "BCB", 2 );
if( !A80->A155.A142 ) goto A1717;
goto A1720;
A1717:
A1666( "Assumed: " );
A80->A155.A142 = A9038( A1344, A5462 );
A1720:A1666( "-d\"BCB=" ); A5695( A80->A155.A142 ); A1666( "\"" );
}
A1716:
A1713:A1666( " */\n" );
A1491 = '\0';
{ if( !A5152 ) goto A1721;
goto A1722;
A1721: A1522( (A1523 *) &A5152, (A1523 *) &A5153, 20, (A72) sizeof( A48)); A5152[ 20] = ( A48)(((A49) &A1525)); goto A1723;
A1722: A5153 = A5152; 
A1723: A5152[0] = ( A48) ( NULL); };
lnt_option( "-save", 0 );
lnt_option( "-e27", 0 );
lnt_option( "-e122", 0 );
lnt_option( "-e435", 0 );
lnt_option( "-e606", 0 );
lnt_option( "-e793", 0 );
lnt_option( "-e799", 0 );
lnt_option( "-e620", 0 );
lnt_option( "-e783", 0 );
(void) ((A1463=(A9)(A15)(*A1492++)) ? ((A1463 == (A9)(A15)('\\'))?A1462():A1463) : A1461() );
(void) A2161();
A5214();
A1491 = '#';
A655 = NULL;
lnt_option( "-restore_", 0 );
A1415( A1886, (A4) 0 );
A5436 = 0;
}
Void
A5151(A1753)
A36 A1753;
{
if( A1094( A1753 ) ) goto A1711;
goto A1712;
A1711:(void) A2161();
A1712: ;
}
A48
A5150(A1709)
A17 A1709;
{
A57 A1871 = A1649;
A48 A1737 = NULL;
A9 A3385;
A7 A1875;
A2 A1868;
if( A2142 == 21 || A2142 == 15 ) goto A1711;
goto A1712;
A1711: { A7 A7426 = 0;
A3385 = (A9)(A15)(*A2149); A1649 = A1378; A1668(); 
A1713:if( A1463 != A3385 && A1463 != EOF ) goto A1714;
goto A1715;
A1714: if( A1463 == '$' ) goto A1716;
goto A1717;
A1716:A1666( A5213() ); goto A1720;
A1717: if( A1463 == '&' ) goto A1721;
goto A1722;
A1721: A1875 = A8993( A1492, &A1868 ); if( A1875 ) goto A1723;
goto A1725;
A1723: if( A1709 & 1 && A1868 == '"' ) goto A1726;
goto A1727;
A1726: A7426++; goto A1766;
A1727: A1664((A9)(A15)(A1868));
A1766: A1492 += A1875; goto A1767;
A1725: A1664( A1463 ); 
A1767:(void) ((A1463=(A9)(A15)(*A1492++)) ? ((A1463 == (A9)(A15)('\\'))?A1462():A1463) : A1461() ); 
goto A1768;
A1722: if( A1463 == ',' && A1709 & 1 && !( A7426 % 2 ) ) goto A1769;
goto A1770;
A1769: A1664( ';' ); (void) ((A1463=(A9)(A15)(*A1492++)) ? ((A1463 == (A9)(A15)('\\'))?A1462():A1463) : A1461() ); goto A1771;
A1770: A1664( A1463 ); (void) ((A1463=(A9)(A15)(*A1492++)) ? ((A1463 == (A9)(A15)('\\'))?A1462():A1463) : A1461() ); 
A1771: ;
A1768: ;
A1720: ; 
goto A1713;
A1715:A1664( '\0' );
A1737 = A1669();
A1649 = A1871;
if( A1463 == EOF ) goto A1772;
goto A1773;
A1772:A865(2);
goto A1774;
A1773: (void) ((A1463=(A9)(A15)(*A1492++)) ? ((A1463 == (A9)(A15)('\\'))?A1462():A1463) : A1461() );
A1774:(void) A2161();
}
A1712:
return A1737;
}
/*  Obfuscation"
Fa10.c
209D4I7"7 A9235"
18D2I1"9"
12I16"A6 A10;
typedef "
291D20
27D4I8"32 A9069"
14I19"A9069 A24;
typedef "
10D4I2"25"
14D9I13"unsigned A890"
21D6I10"9069 A9150"
17D6I10"9069 A9070"
17D8I8"9070 A27"
18D12I9"A9070 A28"
22I21"A9070 A5793;
typedef "
10D4I2"29"
14D17
26D8I5"A6228"
19D6I8"9070 A30"
25D3I8"long A31"
13I17"A17 A32;
typedef "
11D1I1"3"
11D7I12"unsigned A34"
19D5I5"4 A35"
17D5I5"5 A36"
21D1I1"7"
17D1I1"8"
16D2I2"39"
18D1I1"0"
17D1I1"1"
17D1I1"2"
12D6I6"34 A43"
22D1I1"4"
17D1I1"5"
11D7I7"A42 A46"
17I17"int A47;
typedef "
342D2I4"9236"
17D4I2"63"
19D1I3"577"
18D1I1"4"
16D4I2"65"
20D2I2"19"
18D4I4"8258"
14I19"A54 A7616;
typedef "
138D6I3"A16"
60D13I3"A72"
122D6I5"A9069"
20D6I5"A9069"
1373I69"struct A9304
{
A17 A9305;
A5794 A9306;
};
extern struct A9304 A9307;
"
6D4I4"9308"
14D4I4"9309"
17D1I1"5"
11D4I4"5566"
14D4I4"5567"
14D3I17"7618();
Void A761"
8D13
19D3I17"5569();
Void A915"
8D9I10"Void A9152"
14D17I2"74"
22D1I15"0();
Void A7621"
10I41"6226();
A5794 A6227();
A81 A7622();
A58 A"
460D2I4"9070"
28D2I4"9070"
151I19"struct A114 A9153;
"
1389D2I2"92"
16D6I12"5794 A7637()"
15I16"A4 A202;
extern "
3337D2I4"9070"
159I11"A58 A9238; "
88D2I4"9070"
39D2I4"9070"
367I11"A17 A9071;
"
535I13"A9236 A9239;
"
1098D2I4"9070"
380D7I8"17 A9154"
24D1I1"1"
12D6I7"62 A442"
16I17"A4 A443 ;
extern "
150D3I4"9072"
14D10I9"Void A451"
22D9I9"5794 A452"
21D9I9"9036 A453"
29D1I1"4"
13D12
20D1I1"5"
12D9I22"A315 A456 ;
A5794 A457"
28D1I1"8"
18D4I3"459"
21D3I4"5268"
14D16
24D1I1"0"
12I16"A4 A461;
extern "
8D1I1"2"
12D8I11"Void A463()"
22D4I3"464"
13I18"A58 A8823;
extern "
1037D7I10"Void A9155"
18D9I7"A4 A504"
20I20"Void A505();
extern "
1042D2I4"9070"
1940D8I19"struct A640 * A9310"
24D4I3"663"
15D10I9"A48 A7505"
29D2I2"37"
19D3I4"7176"
14D7I9"Void A664"
22D4I3"665"
16D8I7"4 A4442"
19D6I6"A17 A5"
27D3I2"66"
21D2I3"031"
21D1I1"7"
20D1I1"8"
12I20"Void A669();
extern "
278D3I4"4476"
14D10I17"struct A640 *A675"
27D4I4"7719"
21D4I4"8914"
15D8I12"Void A7720()"
18D7I7"17 A933"
18D8I7"7 A5254"
18D2I2"81"
7D1I1"0"
11D2I2"17"
7D1I1"1"
11D1I2"35"
6D1I1"2"
11D1I2"92"
6D1I1"3"
11D2I1"7"
7D1I1"4"
11D8I7"4 A2145"
18D1I2"68"
6D1I1"6"
13D14I6"*A2147"
24D8I7"4 A2148"
18D7I16"2 A2149[M_TOKEN]"
17D2I2"87"
7D1I1"0"
11D2I1"4"
7D1I1"1"
15D4I4"2152"
14D2I2"36"
7D1I1"3"
11D27I7"35 A826"
38D1I2"17"
6D3I1"4"
13D10I28"7
A2155,
A2156,
A2157,
A6214"
19D4I2"A9"
9D1I1"8"
12D10I9"A17 A8825"
27D3I3"215"
15D3I4"Void"
8D1I1"0"
18D4I4"8209"
23D1I1"1"
12D3I4"Void"
8D1I1"2"
12D10I9"A35 A2163"
29D1I1"4"
12D5I4"Void"
10D1I1"0"
12D9I8"A35 A216"
22D7I10"9036 A8211"
24D4I4"5255"
15D4I2"A4"
9D11I16"6();
extern Void"
16I37"7();
extern Void A2168();
struct A216"
465I42"struct A9073
{
A48 A9074;
A9069 A9075;
};
"
422D6I7"8 A9076"
17D9I8"A42 A982"
20D8I9"long A983"
24D4I3"984"
16D8I8"87 A6039"
20D8I8"61 A7724"
19D9I9"A92 A7260"
20D8I9"long A985"
24D4I3"986"
16D9I8"34 A5670"
20I21"A5794 A987();
extern "
1045I7"9129,
A"
44D4I4"9156"
11I42"9157,
A9158,
A9159,
A9160,
A9161,
A8639,
A"
21D10I2"91"
15D2I2"91"
7I29"9164,
A6176, 
A7062,
A7063,
A"
91I21"9240,
A9241,
A9130,
A"
21I28"9165,
A9166,
A9167,
A9168,
A"
28I14"9292,
A9169,
A"
92I42"9242,
A9243,
A9131,
A9132,
A9133,
A9134,
A"
71I7"9170,
A"
307D4I4"9171"
21I42"9244();
extern Void A8266();
extern Void A"
8I80"extern Void A9172();
extern A4 A9173();
extern A4 A9174();
extern Void A9175();
"
746D9I7"4 A9176"
21D7I9"5794 A868"
19D6I6"7 A598"
25D1I1"0"
19D1I1"1"
13D10I7"61 A872"
22D7I10"5794 A6037"
19D10I7"61 A873"
22D7I10"5794 A8589"
20D5I6"8 A874"
16D9I7"A4 A875"
28D1I1"6"
20D1I1"7"
20D1I1"8"
19D2I2"79"
19D4I3"880"
21D4I4"6172"
21D3I4"9293"
20D4I4"9177"
21D4I4"8787"
23D1I1"1"
20D1I2"29"
18D4I4"7262"
23D1I1"2"
20D1I1"3"
20D2I2"48"
21D1I1"4"
20D1I1"5"
18D3I4"5667"
22D1I1"6"
19D2I2"87"
20D2I2"88"
20D2I2"89"
19D4I3"890"
21D4I3"891"
21D4I3"892"
21D4I4"7745"
24D1I1"6"
21D1I1"7"
20I1"4"
18D3I4"7748"
20D4I4"7749"
21D4I3"893"
23D1I1"4"
18D4I4"1857"
22D3I3"958"
22D1I1"5"
19D3I3"061"
20D3I4"5821"
20D4I3"896"
21D3I4"7507"
20D4I3"897"
21D4I4"5981"
23D1I1"8"
19D3I3"750"
20D3I4"8212"
20D3I3"899"
20D3I4"7177"
22D1I1"0"
18D4I3"901"
23D1I1"2"
20D1I1"3"
18D3I4"8944"
22D1I1"4"
18D4I3"905"
21D3I3"907"
21D4I4"9078"
23D1I1"7"
18D3I4"5077"
20D3I4"8267"
20D3I4"8830"
14D7I9"Void A908"
25D2I2"09"
13D9I9"Void A910"
28D1I1"1"
12D9I7"A4 A912"
20D16
24D1I1"3"
14D8I7"4 A5431"
19D11I9"Void A914"
22D10I9"Void A915"
22D11I6"7 A916"
27D2I2"17"
13D9I10"A5794 A918"
27D3I4"1739"
15D6I9"5794 A919"
24D4I3"920"
15D9I9"Void A921"
26D4I3"922"
15D20I14"A5794 A923();
"
31D4I3"924"
16D7I10"5794 A7263"
19D8I8"61 A5668"
19D7I12"Void A5669()"
16D18
26D13I12"7734 A7751; "
21D7I7"4 A7752"
18D18I10"A4 A5914()"
28D6I10"861 A926()"
16D8I6"4 A927"
18D6I8"4 A928()"
15D9I19"struct A849 *A929()"
19D6I9"61 A930()"
16D8I12"9236 A9245()"
18D6I12"9236 A9246()"
15D9I12"Void A9247()"
18D7I18"struct A144 *A5050"
17D8I6"7 A931"
18D6I8"61 *A932"
16D8I6"7 A933"
21D7I7"*A934;
"
14D18I7"A7 A935"
28D7I8"61 *A936"
16D18I7"A7 A937"
27D18I9"A61 *A938"
27D18I7"A7 A939"
28D9I8"61 *A940"
19D9I6"7 A941"
19D9I8"61 *A942"
19D12I10"61 A6038; "
19D11I18"struct A144 *A1696"
23D8I5" A943"
18D10I7"7 A9294"
19D11I18"struct A144 *A7178"
20D17
26D7I8"44 *A717"
17D7I18"struct A144 *A5432"
17D6I9"5794 A944"
15D17I10"A5794 A945"
26D20I12"A5794 A946;
"
27D4I5"A5794"
9D3I1"4"
19D6I4"7180"
15D12I11"A5794 A7227"
21D12I11"A5794 A7181"
22D7I10"5794 A5510"
17D8I7"68 A948"
17D18
26D10I9"114 *A949"
20D7I6"7 A950"
17D7I6"4 A951"
16D10I17"struct A114 *A952"
19D13I20"struct A144 *A7265; "
27D3I3"266"
15D7I10"5794 A1689"
24D4I4"7753"
15D18I10"Void A7754"
30D10I7"6 A1022"
20D10I8"81 A5511"
19D12I9"A81 A8770"
21D12I18"struct A561 *A1023"
21D12I8"A4 A1024"
22D10I7"7 A1025"
19D18I8"A4 A1026"
29D18I9"A49 A1027"
29D10I9"Void A775"
22D10I8"A4 A1028"
27D15I8"1029();
"
21D4I31"9079();
A48 A9080();
Void A9081"
15D21
38D1I1"0"
13D7I8"17 A1031"
18D18I9"A79 A1032"
35D4I4"5671"
15D8I10"Void A5672"
19D9I10"Void A8401"
21D8I8"17 A5512"
19D10I18"struct A561 *A1033"
21D9I10"Void A9135"
20D9I18"struct A561 *A1034"
21D7I10"5794 A1035"
18D47I10"Void A2317"
58D9I10"Void A5673"
20D9I10"Void A1036"
20D9I10"Void A1037"
20D11I18"struct A561 *A1038"
22D8I6"A4 A56"
21D9I18"struct A561 *A1039"
20D11I10"Void A7182"
22D18I10"A4 A7183()"
27D10I9"A58 A8268"
22D7I28"78 A1040();
extern Void A775"
12D6I49"extern A81 A1041();
extern A81 A7508();
extern A4"
11D3I49"7();
extern A5794 A8590();
struct A7758 *A7759();"
12D51I3"0()"
60D18I11"A78 A1042()"
28D8I10"78 A5271()"
18D8I10"78 A1043()"
18D8I12"5972 A1044()"
17D9I12"Void A2274()"
18D17I42"A54 A5433();
extern A9036 A9039();
extern "
26D106I9"44 *A5434"
116D7I12"9150 A9178()"
16D13I32"Void A7761();
extern A48 A7906()"
23D31I63"7758
{
A40 A7762;
A87 A7763, A7764;
A17 A7765, A7766;
A67 A7767"
43D21
29D11I10"7758 A7768"
20D79I9"A87 A7769"
88D12I9"A87 A7770"
21D12I9"A88 A7771"
21D12I9"A10 A7772"
21D43I17"const A88 A7773;
"
52D19I43"045
{
A18 A1046;
A72 A1047;
A7470 A1048;
A3"
24D2I58"49;
};
struct A1050
{
A18 A1051;
A17 A1052;
A5794 A1053;
}"
12D7I7"7 A3140"
17D34I14"81 A3143[20];
"
43D9I33"054
{
A54 A1055;
A55 A1056[25];
}"
19D8I9"55 *A3164"
19D11I19"struct A1054 *A7509"
20D78
86D209I12"144 *A7774;
"
217D10I51"7500
{
struct A7500 *A7775; A54 A7510; A42 A7511; }"
19D9I12"Void A1057()"
18D8I12"Void A1058()"
17D9I10"Void A1059"
20D8I10"Void A1060"
19D10I11"A5794 A1061"
21D22I18"struct A118 *A1062"
33D13I8" A1063;
"
20D13I8"A4 A7267"
26D4I4"7776"
14D10I8"63 A7777"
19D21
29D3I3"114"
8D2I2"64"
11I40"A81 A7512();
extern A49 A1073();
extern "
8D2I66"74();
extern A72 A1075[];
extern A9036 A1076();
extern A9036 A7778"
14D94I118"3097
{
A70 A3098; A72 A3099; A7468 A3100; A7468 A3101; A72 A3102; A72 A3103; A72 A3104; A7 A3105; A4 A3106; A7 A5282; "
100D5I85"283; A32 A5284; A74 A5966; A17 A6270; };
extern A81 A3107;
extern A315 A3108;
extern "
13D55I62"3097 A3109;
extern A58 A3110;
extern A4 A6067;
extern A72 A311"
60D10I14"extern A6 A311"
15D45
52D11I14"Void A1077();
"
19D7I21"48 strcat(), strcpy()"
17D9I14"48 strncpy(); "
16D11I13"int strncmp()"
24D4I4"1078"
15D8I7"2 A7268"
27D2I2"79"
13D12I18"struct A553 *A1080"
21I17"A7 A9295;
extern "
6D67I3"108"
72I66"struct A553
{
struct A553 *A1082;
A7 A1083;
struct A114 A1084;
};
"
15D81I1"8"
86D75I59"struct A5513
{
A81 A5514;
struct A147 *A5515;
};
A5972 A777"
80D39I10"A5972 A778"
44D17I10"A5972 A778"
22D16I10"A5972 A778"
21D16I10"A5972 A778"
21D16I10"A5972 A778"
21I15"A5972 A7785();
"
7D14I11"A74 A6242; "
21D12I8"A7 A1086"
21D12I8"A7 A7184"
21D12I11"A5794 A5248"
25D6I4"7185"
15D10I10"A95 *A1087"
27D4I4"1088"
21D4I4"1089"
21D4I4"7186"
21D3I3"109"
21D4I4"7187"
15D10I11"A5794 A1091"
21D9I10"Void A1092"
27D3I3"093"
20D4I4"8269"
20D3I3"094"
14D10I8"A4 A1095"
21D10I8"A4 A1096"
28D3I3"097"
20D4I4"1098"
16D10I7"4 A1099"
21D10I11"A94 * A5272"
21D9I10"A94 * A110"
21D10I11"A94 * A1101"
29D2I2"02"
19D4I4"1103"
15D11I10"Void A1104"
30D2I2"05"
21D2I2"06"
19D4I4"5675"
21D4I4"6243"
15D10I8"A4 A5518"
27D4I4"7786"
21D4I4"5516"
21D4I4"5517"
21D4I4"5519"
22D3I3"520"
14D18I12"Void A5521()"
27D17
23D4I4"5522"
15D10I9"A23 A7787"
21D8I10"Void A1107"
19D10I10"Void A1108"
22D10I7"4 A1109"
21D11I10"Void A1110"
22D11I10"Void A1111"
22D11I10"Void A1112"
22I21"Void A2942();
extern "
7D4I4"1113"
15D55I12"Void A2949()"
64D13I12"Void A7070()"
22D9I12"Void A1114()"
18D10I12"Void A1115()"
19D9I12"Void A7269()"
19D8I12"94 * A1116()"
17D9I12"Void A1117()"
18D18I12"Void A1118()"
27D18I12"Void A1119()"
27D26I12"Void A7788()"
35D8I12"Void A5676()"
17D18
26D2I2"20"
21D2I2"21"
21D2I2"22"
13D9I10"Void A8270"
26D4I4"5249"
15D10I18"struct A144 *A5523"
19I17"A7 A5822;
extern "
6D4I4"7789"
21D4I4"7790"
19D4I4"7791"
15D10I10"A94 *A7792"
21D10I11"A5794 A7793"
22D7I10"5794 A7794"
19D7I10"5794 A7795"
18D10I11"A5794 A7796"
22D8I10"5794 A7797"
20D2I4"5794"
7D3I45"8();
struct A5304 { A77 A3049; A5794 A1148; }"
12D12I13"A2 A1123[100]"
21D12I9"A17 A1124"
21D12I10"A13 *A1125"
21D12I9"A81 A1126"
23D9I7"8 A1127"
19D1I1"5"
6D4I2"28"
13D11I18"struct A144 *A1129"
20D11I18"struct A144 *A1130"
20D11I26"const struct A5304 A3050[]"
21D10I7"4 A1131"
20D17I8"38 A1132"
26D45I9"Void A113"
65D1I1"3"
21D1I1"3"
13D9I8"A17 A113"
29D1I1"3"
13D10I8"A4 A2979"
29D1I1"3"
19D3I3"917"
23D2I2"39"
13I19"A4 A1140();
extern "
8D1I1"4"
6D124I231"extern Void A5529();
extern A4 A5530();
extern A7 A5532();
extern Void A5533();
extern A66 A5534();
extern A66 A7799();
extern Void A5531();
extern Void A1142();
extern Void A1143();
extern Void A1144();
extern A50 A1145();
extern "
131D339I15"46();
extern A7"
344D13I118"47();
extern A48 A1148();
extern A48 A1149();
extern A77 A1150();
extern A58 *A5067, *A5068;
extern A17 *A8945, *A8946"
22D4I6"8271()"
15D5I193"53();
extern Void A1154();
extern Void A1155();
extern Void A1156();
extern Void A1157();
extern Void A5823();
extern Void A1158();
extern Void A1159();
extern Void A1160();
extern Void A1161()"
15D4I4"8402"
15D19
25D4I75"8403; A54 A8404; A13 *A8405; A7468 A8406; A72 A8407; A58 *A8408;
A58 *A8409"
19D52I1"6"
57D1I1"7"
6D56I4"63;
"
61D10I229"
A7132,
A7133,
A1164,
A1165,
A1166,
A1167,
A1168,
A1169,
A1170,
A1171,
A1172,
A1173;
A13 A1174[ (2000 / CHARLEN) ];
A18 A5435;
A17 A6040;
A13 A7800[ (2000 / CHARLEN) ];
A61 A6041;
A17 A6042;
} ;
extern A13 A9180[(2000 / CHARLEN)]"
20D4I4"9248"
14D88I6"9249; "
95D17I17"9296; A17 A9250; "
24D6I6"9251; "
13D6I19"9297; FILE *A9252; "
16D9I18"struct A9248 A9253"
18D127I14"Void A9254();
"
135D27I104"391
{
struct A633 *A1175;
struct A144 *A1176;
struct A144 *A1177;
struct A144 *A1178;
};
struct A1179
{
"
32D262I91"180;
A53 A1181;
A17 A1182;
A53 A1183;
A5794 A1184;
A5794 A1185;
};
struct A1186
{
struct A8"
267D31I5"187;
"
40D27
33D12I8"188;
};
"
21D18I6"189
{
"
26D71I105"640 *A1190;
A5794 A1191;
};
struct A1192
{
A17 A1193;
A9 A1194;
A70 A1195;
};
struct A1196 { A2 A1197[3];"
77I833" *A1198; };
struct A1199
{
A5794 A1200;
A35 A1201;
A42 A1202;
};
Void A1203();
Void A1204();
Void A1205();
struct A5677
{
A5794 A5678;
A42 A5679;
A5794 A5680;
A5794 A5681;
};
extern A17 A6244;
extern long A7418;
extern A49 *A1206;
extern A49 *A1207;
extern A2 A1208[ARG_LEN];
extern A42 A8197; extern A2 A3496[ARG_LEN];
extern struct A1196 A1209[];
extern const A6 A1210;
extern A7 A5406;
extern A7 A5407;
extern A7 A6210;
extern A42 A1211;
extern A4 A1212;
extern A72 A1213;
extern A72 A1214;
extern A18 A1215;
extern A18 A1216;
extern A4 A7228;
extern A61 A1217;
extern A61 A1218;
extern A67 A1219;
extern A13 *A6043;
extern A13 *A1220;
extern A13 *A1221;
extern struct A1162 A1222;
extern struct A144 *A1223;
extern struct A144 *A1224;
extern struct A144 *A1225;
extern A48 A1226;
extern A7 A1227;
extern A9070 A1228;
extern UFLAG"
1095I7"9298,
A"
2534D19
33D4I4"9255"
14D7I9"2 A7190[]"
16D8I18"struct A144 *A1398"
21D4I4"1399"
14D8I7"4 A7807"
18D7I6"7 A621"
21D7I6"9181; "
15I1"1"
6D1I1"0"
11D1I2"68"
6D1I1"1"
11D1I1"4"
6D1I2"2 "
11D1I1"7"
6D1I1"3"
10D4I2"A7"
9D3I1"4"
12D4I2"A7"
9D3I1"5"
12D4I2"A4"
9D3I1"6"
12D9I10"Void A1407"
20D9I10"Void A1408"
26D4I4"1409"
17D6I7"8 A1410"
17D10I9"A58 A1411"
21D8I10"Void A8257"
19D10I8"A4 A8411"
27D4I4"5063"
15D4I2"A6"
9D1I1"2"
12D2I4"Void"
7D1I1"3"
18D4I4"1414"
21D4I4"1415"
15D10I8"A4 A1416"
21D19I10"Void A5687"
36D4I4"5688"
15D10I10"Void A5689"
21D10I19"struct A5677 *A5690"
30D1I1"7"
12D10I10"A13 *A5396"
21D10I9"Void A141"
28D4I4"1419"
21D4I4"6052"
15D10I11"A5794 A7808"
30D1I1"4"
18D4I4"5545"
21D4I4"5546"
15D8I10"Void A5547"
19D2I4"Void"
7D1I1"0"
12D2I4"Void"
7D25I1"1"
36D9I7"A4 A624"
21D9I9"A48 A9182"
20D9I8"A4 A1422"
20D4I2"A4"
9D12I5"3();
"
26D5I6" A1424"
16D10I12"Void A3500()"
19D8I10"Void A1425"
19D8I9"int A3493"
19D10I9"int A3494"
27D4I4"1426"
15D10I19"struct A1189 *A1427"
21D12I10"A13 *A8273"
22D7I6"4 A599"
19D9I7"A4 A599"
21D8I10"Void A9311"
27D2I2"28"
13D12I10"Void A7191"
31D2I2"29"
13D8I10"Void A6080"
25D4I4"9183"
15D10I9"A54 A1430"
21D1I1"V"
6D4I4"1431"
15D10I8"A4 A7475"
30D1I1"2"
12D9I12"UFLAG *A1433"
29D1I1"4"
12D10I8"A4 A1435"
29D2I2"36"
13D1I1"v"
6D4I4"6246"
15D1I1"v"
6D4I4"7809"
21D4I4"1437"
23D2I2"38"
14D10I10"34 A5691()"
19D20
28D2I2"39"
19D4I4"1440"
15D10I12"Void A1441()"
19D17
26D1I1"2"
21D1I1"3"
12D11I10"Void A5773"
30D2I2"44"
13D12I11"A5794 A1445"
21I20"A5794 A1446;
extern "
6D4I4"1447"
21D4I4"3532"
15D12I10"A2 A3526[]"
21I17"A4 A3527;
extern "
6D2I2"14"
21D4I4"1449"
15D10I11"A5794 A1450"
30D1I1"1"
18D4I4"1452"
15D10I8"A4 A9184"
27D4I4"5274"
21D73I6"1453()"
82D19I12"Void A5651()"
28D20I12"Void A5548()"
29D20
26D4I130"3443();
extern Void A6072();
extern Void A1454();
extern Void A3363();
extern Void A1455();
extern Void A1456();
extern Void A5107"
17D89I65"065
{
A67 A1066;
A5794 A1067;
A5794 *A1068;
A17 A1069;
};
extern "
97D44I20"1065 *A1070;
extern "
52D40I53"1065 A1071[];
extern A67 A1072[];
extern Void A6209()"
53D12I85"
{
A79 A547;
A79 A548;
A79 A549;
A79 A6232;
A79 A5661;
A87 A6233;
A87 A5662;
A23 A552"
23D16I24"53 *A554, *A555, *A6234,"
21D1I12"63, *A557;
}"
11D29I14"93
{
A17 A8274"
34D35I21"98 A8275;
A8198 A8276"
50D44I10"8277[1];
}"
54D41I6"561
{
"
56D4I165"62;
struct A561 *A563;
A40 A564;
A40 A565;
A81 A566;
A58 A567;
A42 A568;
A68 A569;
struct A147 A570;
A17 A571;
A24 A572;
A61 A573;
A96 *A574;
struct A1537 * A7443;
}"
13D11I8"A81 A575"
20D9I17"struct A561 *A576"
28D1I1"7"
18D2I1"5"
22D2I2"79"
19D3I4"8278"
22D1I1"0"
20D1I1"1"
19D3I2"82"
22D9I1"3"
20D7I10"Void A5664"
18D19
27I65"4(), A585();
extern A4 A586();
extern A4 A5665();
extern Void A58"
1854I50"9136
{
struct A9136 *A9137; A17 A9138; };
struct A"
109D9I19"struct A9136 *A9139"
18D18
26D9I10"9136 A9140"
19D9I8"58 A7273"
18D4I3"A17"
9D3I1"4"
12D11I17"struct A588 A1719"
20D4I2"A2"
9D3I3"6[]"
20D2I2"77"
13D10I9"A89 A1978"
29D2I2"79"
19D4I4"1980"
21D4I4"7274"
24D1I1"1"
13D8I7"4 A9185"
19D18I8"A4 A9186"
35D4I4"5897"
24D1I1"2"
12D3I4"Void"
8D1I1"3"
12D10I9"A72 A1984"
21D10I18"struct A561 *A1985"
27D3I3"914"
23D2I2"86"
21D2I2"87"
13D27
33D26I4"9142"
37D10I9"A78 A1988"
27D4I4"1990"
21D4I4"1989"
21D4I4"1991"
15D8I10"Void A1992"
25D4I4"1993"
15I27"struct A144 *A7824; extern "
6D4I26"5553();
struct A147 *A7825"
23D2I2"26"
19D4I4"7827"
21D64I6"7828()"
73D8I10"Void A7829"
20D7I7"4 A7830"
18D9I12"Void A8412()"
18D9I12"Void A7831()"
18D9I12"Void A7832()"
18D19I12"Void A8413()"
28I14"Void A8414();
"
8D20I7"1457
{
"
26D12I4"58;
"
18D3I25"59;
A4 A1460;
A9 A1461;
}"
12D19I10"A9 A1461()"
28D18I10"A9 A1462()"
28D1I1"9"
6D1I1"3"
11D19I8"A4 A1464"
30D9I7"4 A1465"
19D20
28D11I10"83 **A5078"
21D9I18"struct A83 **A5079"
25D2I2"66"
13D9I7"4 A1467"
19D3I11"struct A144"
8D2I2"68"
12D11I18"struct A144 *A7476"
21D9I7"4 A1469"
19D10I19"struct A640 **A3651"
20D9I18"struct A640 **A365"
21D8I9"17 *A1470"
19D8I9"68 *A1471"
26D13I14"640 **A1472 ;
"
22D7I7"3 A1473"
18D11I7"4 A1474"
22D7I9"13 *A1475"
18D7I9"13 *A1476"
18D7I9"13 *A1477"
18D4I2"53"
9D2I2"78"
13D2I2"68"
7D2I2"79"
12D9I3"A17"
15D1I1"0"
12D1I2"57"
6D1I1"1"
11I19"A57 A3660 ;
extern "
17D3I4"5 ; "
11D10I8"57 A1482"
22D6I10"036 *A1483"
17D10I7"4 A1484"
20D18I8"A4 A8214"
29D8I7"4 A1485"
19D7I11"9036 *A1486"
18D7I9"81 *A1487"
17D8I16"const A81 *A1488"
19D7I7"6 A1489"
25D11I10"144 *A7276"
21D4I4"9036"
9D1I1"0"
11D17I8"A9 A1491"
27I21"A9036 A1492 ;
extern "
8D9I10"640 *A1493"
19D17I9"A63 A1494"
27D17I8"A4 A1495"
28D8I7"4 A1496"
22D4I4"5825"
18D4I5"1497 "
21D8I9"640 *A149"
19D12I12"A5794 A1499 "
21D12I18"struct A83 *A1500 "
21D10I18"struct A83 *A1501 "
19D13I18"struct A83 *A1502 "
22D10I18"struct A83 *A5080 "
20D9I9"53 A1503 "
18D12I9"A4 A1504 "
21D12I8"A4 A6247"
21I27"struct A83 *A6248 ;
extern "
6D4I4"9040"
23D2I2"05"
14D7I7"4 A1506"
18D10I11"A5794 A1507"
21D9I10"Void A7451"
20D10I8"A4 A7833"
22D8I7"4 A6249"
25D4I4"6250"
23D2I2"08"
13D8I10"Void A1509"
28D1I1"0"
12D4I2"A6"
9D1I1"1"
21D1I1"2"
12D10I9"A68 A1513"
21D7I9"Void A151"
20I203"81 A5692();
extern Void A8215();
extern Void A1515();
extern A4 A1516();
extern Void A1517();
extern Void A1518();
extern Void A1519();
extern Void A1520();
extern A4 A3738();
extern A4 A7834();
extern A"
561D1I1" "
11D1I1" "
11D1I1" "
10D1I1" "
10D1I1" "
10D1I1" "
848D4I4"9082"
15D19I10"Void A9083"
30D19I10"Void A9084"
30I21"Void A3863();
extern "
17D2I2"89"
13D10I19"struct A1537 *A1590"
21D10I19"struct A1537 *A1591"
27D2I2"71"
21D4I4"1592"
21D4I4"1593"
15D9I10"Void A7841"
29D1I1"2"
12D4I3"A74"
9D1I1"7"
18D4I4"7843"
21D4I4"8218"
15D9I10"Void A8219"
29D1I1"5"
13I1"7"
6D1I1"6"
12D3I4"Void"
8D1I1"7"
12D10I8"A4 A7848"
21D10I9"A74 A7849"
21D1I1"V"
8D24I4"94()"
33D9I4"void"
14D1I3"1()"
10D4I4"void"
9D9I17"2();
typedef A22*"
14I57"3;
extern const A51 A1524;
extern long A1525;
struct A152"
1445D10I8"A4 A9085"
27D4I4"3763"
15D9I10"Void A8835"
21D2I2"35"
7D1I3"4()"
10D11I3"A58"
16D1I1"5"
10D2I11"struct A147"
7D3I1"6"
12I19"A4 A3767();
extern "
2788D2I4"9070"
433D8I10"Void A9086"
19D9I9"A74 A9087"
28D1I1"6"
12D8I9"Void A737"
19D9I8"A4 A4551"
20D9I9"Void A738"
25D3I4"4724"
14D10I8"A58 A741"
29D1I2"77"
20D1I1"3"
18D4I3"744"
15I21"Void A8202();
extern "
1326D1I1" "
15D1I1" "
11D1I1" "
2390D2I4"9070"
215D2I4"9070"
12D1I2"72"
52D4I4"9088"
2260I6"(A72) "
18I6"(A72) "
2011I15"mm", 120 },
{ ""
737I16"ln", 121 },
{ "s"
702D10I16"v10_feature",119"
27D8I9"idth", 31"
25D10I7"lib", 4"
16D10I1"4"
21D4I5"print"
9D1I1"3"
26D8I11"wscanf", 54"
13D1I10"2000 | 0x1"
11I24"xml", 75 | 0x4000 },
{ ""
33I6"(A72) "
16I6"(A72) "
390I3",
0"
136I3",
0"
154I6",
1024"
87D1I1"7"
10I6"(A72) "
16I6"(A72) "
797I14"Void A9101();
"
83D15I30"earch_actively_including_stack"
24D1I1"5"
12D7I11"alt_keyword"
17I29"2 },
{ "std_digraphs", (A34) "
26I6"(A72) "
16I6"(A72) "
634D1I11"(size_t)(8)"
9528I9"(size_t)("
10I1")"
602D28I12"8
A9182()
{
"
39D16I8"1736[25]"
22D37I11"(A1309 > 0)"
71D35I35"sprintf( A1736, "C++ %d", A5407 );
"
47D10I38"A1712:
sprintf( A1736, "C %d", A5406 )"
19D7I55"return A1736;
}
A4
A1422(A1741)
A5794 A1741;
{static A2"
13D13I58"[10] = { 0 };
if( !A1741 ) return (A4) 0;
if( !A3487[0] ) "
22D1I13"1;
goto A1712"
7D1I67"1:
if( A213( A1502, "_UNICODE", 1 ) ) goto A1713;
goto A1714;
A1713"
19I1"w"
9I5"goto "
5D2
8D16I9"4:
strcpy"
25I48""main" );
A1715: ;
A1712:
return strcmp( A3487, "
100D2I4"9070"
212D2I4"9070"
181D2I4"9070"
1219D6I9"(size_t)("
20I1")"
4437I148"(A34) 5:
if( A3491 ) goto A1784;
goto A1785;
A1784:
A6244 |= (A17) 0x8;
gfl_di = 1;
goto A1786;
A1785:
A6244 &= ~(A17) 0x8;
A1786:
goto A1715;
case "
229D13I143"9311( A6010, A6011, A1806, A2067, A1875, A3495, A1741 )
struct A1186 *A6010;
struct A1186 *A6011;
A48 A1806;
A48 A2067;
A42 A1875;
UFLAG A3495;"
21D4I4"1741"
9D31I20"4 A6084;
A17 A6083 ="
36D13I138"7 A1804;
struct A1186 *A1800;
struct A849 *A1961 = NULL;
A48 A3505 = NULL;
A5794 A3267;
A81 A80 = NULL;
A48 A1801;
A57 A1824;
A2 A9329[20]"
19D6I11"A1875 == 19"
40D63I75"if( (strcmp( A2067, "all standard headers" ) == 0) ) goto A1713;
goto A1714"
69D52I26"3:
strcpy( A9329, "**SH**""
57D69I84"2067 = A9329;
goto A1715;
A1714: sys_fnmap( A2067, 0 );
A1715: ;
goto A1716;
A1712: "
74D18I3"187"
23D27I55"6 && (strcmp(A1806,"1024") == 0) ) goto A1717;
if( A187"
32D55I31"86 ) goto A1720;
A3469( A2067 )"
60D18I28"20:
A1717:
A1716:
if( !(A608"
23D82I38"928( A2067 )) ) goto A1721;
goto A1722"
87D59I22"21:
A6083 |= 2 | 8 | 4"
64D2I58"22:
A6080( A2067, A6083 );
A1804 = 0, A1800 = A6011;
A1726"
11D20I6"04 < 2"
30D2I2"23"
12D1I1"2"
7D2I45"27: A1804++, A1800 = A6010;
goto A1726;
A1723"
8D64I6"!A1800"
75D1I1"6"
12D1I1"6"
7D2I22"66: 
goto A1768;
A1767"
9D7I3"608"
19D2I2"69"
12D2I2"70"
7D29I24"69:
if( !A1800->A1188 ) "
37D1I13"71;
goto A177"
7D63I37"71:
A1800->A1188 = A999( 4, (A41) 18)"
68D2I2"72"
8D9I13"!A5914(A2067)"
20D2I2"73"
12D2I2"74"
7D18I23"73: A1418(); goto A1725"
23D25I41"74:
A1961 = A929( A1800->A1188, A2067 );
"
30D8I23"3495 < 0 && A1875 == 37"
19D2I2"75"
12D2I2"76"
7D85I28"75:
A1961->A852 |= (A17) 0x0"
91D8I1"7"
13D18I129"961->A852 |= 6 == A1875 ? (A17) 0x02 :
86 == A1875 ? (A17) 0x04 :
19 == A1875 ? (A17) 0x08 : 0 ;
A3505 = ((A48)( A1961->A851 ));
"
26D9I4"77;
"
14I44":
if( !A1800->A1187 ) goto A1778;
goto A1779"
5D26I98"78:
A1800->A1187 = (struct A83 *) A1073((A41) 2);
A210( A1800->A1187, A1741, A1130, A1344, NULL, 0"
33D74I18"9:
A3267 = A2067;
"
81D22I39"75 == 19 && (strcmp( A3267, "." ) == 0)"
33D2I2"80"
12D2I2"81"
7D3I33"80:
A3267 = A7505();
if( !A3267 )"
12D2I2"27"
7D12I51"81:
A80 = A213( A1800->A1187, A3267, 2 );
A80->A130"
17D29I76"58) A1875;
A3505 = ((A48)( A80->A155.A142 ));
if( A3495 < 0 && A1875 == 37 )"
38D2I14"82;
goto A1783"
7D121I27"82:
A80->A127 |= (A27) 0x80"
127D10I4"83: "
15D3I33"77:
A1801 = A874( A3505, A1806 );"
11D22I15"04==0 && A1801 "
32D2I2"84"
12D2I2"85"
7D30I2"84"
36D28I23"*A1801 != ' ' && *A1801"
39D2I2"86"
12D2I2"87"
7D20I20"86: *A1801++ = ' '; "
28D2I2"84"
7D137I4"87:
"
146D16I1"5"
21D32I2"85"
39D152I51"1804 == 1 && A1801 == NULL ) goto A1788;
goto A1889"
157D2I31"88:
{extern Void A8089();
A1824"
7D10I10"649;
A1649"
15D22I11"344;
A1668("
29D104I5"A3505"
114D3I3"890"
12D2I37"891;
A1890: A7241( A3505 );
goto A189"
7D2I2"89"
7D23I59"664( ' ' );
A1892:
A8089(A1806);
A1664( ' ' );
A1664('\0');"
30D12I4"961 "
21D2I2"89"
12D2I2"89"
7D30I2"89"
35D3I239"961->A851 = A1669();
goto A1895;
A1894: if( A80 ) goto A1896;
goto A1897;
A1896:
A80->A155.A142 = A1669();
A1897:
A1895:
A1649 = A1824;
}
A1889: ;
A1768: ;
goto A1727;
A1725: ;
}
Void
A8298( A8299 )
A5794 A8299;
{
A13 *A8300 = A3454;
A3527"
8D15I20"4) 1;
A3453 = (A4) 1"
22D262I8"A8273 ) "
271D1I13"1;
goto A1712"
7D58I26"1:
A8273 = (A13 *) A1670( "
63D26I34" ( (2000 / CHARLEN)), (A72) ( 1 ) "
31D68I62"712:
A3454 = A8273;
A3532( A3526, A8299, ((A72) strlen(A8299))"
73D9I68"3454 = A8300;
}
A5794
A6076( A3491, A3495 )
A4 A3491;
UFLAG A3495;
{"
15D29I110"3491 ) return A3495 == 1 ? "++" : "+";
return A3495 == -1 ? "--" : "-";
}
Void
A6080( A1809, A1709 )
A48 A1809"
34D43I105" A1709;
{
A48 A1734 = A1809;
A48 A2925 = A1809;
A9 A1833;
A4 A6081 = (A4) 0; A2 A6082[3]; A6082[2] = '\0'"
49D14I2"1:"
20D3I25"833 = (A9)(A15)(*A2925++)"
15D1I1"2"
12D1I1"3"
7D44I37"2:
if( A1833 == '`' && *A2925 ) goto "
49D7I175";
goto A1715;
A1714:
if( *A2925 == '?' || *A2925 == '*' || *A2925 == '[' || *A2925 == ']' ) goto A1716;
goto A1717;
A1716:
if( A1709 & 4 ) goto A1720;
goto A1721;
A1720: A6081"
15D158I151"1;
A1721: ;
goto A1722;
A1717: if( *A2925 == '"' || *A2925 == '`' ) goto A1723;
goto A1725;
A1723:
if( A1709 & 2 ) goto A1726;
goto A1727;
A1726: A6081"
166D19I86"1;
A1727: ;
goto A1766;
A1725: if( A1709 & 8 ) goto A1767;
goto A1768;
A1767:
A6082[0]"
24D128I60"2) (A1833); A6082[1] = *A2925;
A887(686,A1226, A6082);
A6081"
133D23I26"4) 1;
A1768:
A1766:
A1722:"
30D10I4"6081"
21D2I2"69"
12D2I2"70"
7D74I27"69:
*A1734++ = (A2) (A1833)"
79D16I55"70: *A1734++ = (A2) (*A2925); A2925++; A6081 = (A4) 0; "
25D2I2"71"
8D1I1"5"
8D4I4"1833"
9D2I16""' && A1709 & 1 "
12D2I2"72"
12D2I2"73"
7D17I4"72: "
25D2I2"74"
7D21I27"73: *A1734++ = (A2) (A1833)"
26D3I26"74: ;
A1771: ; goto A1711;"
8D46I30"3:
*A1734 = '\0';
}
A4
A5990( "
51D8I9" )
A5794 "
13D15I51";
{
A5794 A1731;
A9 A1833;
A4 A4598 = (A4) 0;
if( !"
20D8I38" ) return (A4) 0;
A1731 = A1737;
A1713"
14D7I25"A1833 = (A9)(A15)(*A1731)"
17D2I2"11"
12D2I2"12"
7D67I23"14: A1731++;
goto A1713"
72D66I75"11:
if( A1833 == '[' || A1833 == ']' ) goto A1715;
goto A1716;
A1715: A4598"
77D144
152D13I1"1"
19D86I9"16: if( ("
91D52I147"33) == '*' || (char)(A1833) == aoc_star) || ((A1833) == '?' || (char)(A1833) == aoc_quest) || isdigit((A9)(A15)(A1833))) ) goto A1720;
return (A4) "
58D8I4"20: "
13D2I23"17: ;
goto A1714;
A1712"
9D40I55"4598 ) return !A5991(A1737);
return (A4) 0;
}
A4
A5991("
45D27I54"7 )
A5794 A1737;
{
A5794 A1731;
A5794 A4675;
A9 A1833;"
32D15I80"!A1737 || !*A1737 ) return (A4) 0;
A1731 = A1737;
A4675 = A1737 + (((A72) strlen"
20D110I7"7))-1);"
115D50I18"*A1731 == '(' && *"
57D6I82"= ')' ||
*A1731 == '{' && *A4675 == '}' ||
*A1731 == aoc_lp && *A4675 == aoc_rp ) "
14D2I14"11;
goto A1712"
7D15I30"11: A1731++; A4675--; 
A1712:
"
20D5I13"1731 <= A4675"
15D2I2"13"
12D2I2"14"
7D17I23"15: ++A1731;
goto A1712"
22D16I28"13:
A1833 = (A9)(A15)(*A1731"
23D8I263"!(((A1833) == '*' || (char)(A1833) == aoc_star) || ((A1833) == '?' || (char)(A1833) == aoc_quest) || isdigit((A9)(A15)(A1833))) && !((A1833) == ',' || (char)(A1833) == aoc_cm) && !(A1833==' '||A1833
=='\t'||A1833=='\n'||A1833=='\f'||A1833=='\r') )
return (A4) 0;
"
16D14I2"15"
19D16I93"14:
return (A4) 1;
}
Void
A1425()
{memset((A49)( &A1222),0,(size_t)( sizeof( struct A1162 ) )"
21D8I103"222.A1163 = (~(A77) 0x0);
sys_option( "-e9?\?", 0 );
sys_option( "-e19?\?", 0 );
A1403 = 3;
if( A1220 )"
17D2I14"11;
goto A1712"
7D210I61"11: A1142( A1220, (A7471)(2000 / CHARLEN) );
A1712:
A1404 = 4"
218D12I3"221"
24D1I1"3"
12D1I1"4"
7D60I44"3: A1142( A1221, (A7471)(2000 / CHARLEN) );
"
65D135I181":
A1402 = (A4) 0; A1400 = 0x01; A1401 = 0;
A3483();
A3451 = NULL;
A1009( A7476, 0 );
A1009( A1468, 0 );
A1223 = NULL;
A3464 = NULL;
A1009( A658, 0 );
A1009( A659, 0 );
A1329 = (A4) "
140D4I175"216 = 0;
A7228 = (A4) 0;
A3463 = NULL;
A1403 = 3;
A1404 = 4;
}
Void
A8089( A1737 )
A48 A1737;
{static A13 *A1174 = NULL;
A66 A7999, A7928; A9 A8090 = (A9)(A15)(*A1737), A8091;"
9D13I11"!A1222.A604"
26D1I1"1"
11D2I2"12"
8D20I32"1: A1666(A1737); return; 
A1712:"
26D4I11"8090 == '{'"
14D2I2"13"
12D2I2"14"
7D42I17"13: A8091 = '}';
"
50D13I1"1"
19D35I4"14: "
40D11I11"8090 == '('"
21D1I1"1"
12D1I1"1"
7D49I15"16: A8091 = ')'"
59D2I2"20"
7D4I37"17: A8090 = A8091 = 0;
A1720:
A1715:
"
9D21I4"8090"
32D2I2"21"
12D2I2"22"
7D17I4"21:
"
22D3I63"[((A72) strlen(A1737))-1] = '\0'; ++A1737; 
A1722:
if( !A1174 )"
13D1I13"3;
goto A1725"
6D42I68"23: A1174 = (A13 *) A1670( (A72) ( (2000 / CHARLEN)), (A72) ( 1 ) );"
47D46I89"5:
A1142( A1174 , (A7471)(2000 / CHARLEN) );
A3454 = A1174;
A3453 = (A4) 1;
A3452 = (A4) "
51D42I107"447( A1737, (A4) 1, NULL, (A17) 0x01 );
A7999 = A7799( A1174, 0, 2000, (A4) 1 );
A7928 = A7999 + 1; 
A1766:"
47D6I12"A7999 < 2000"
16D2I2"26"
12D2I2"27"
7D45I44"67: A7999 = A7799( A1174, A7928, 2000, (A4) "
50D7
15D62I132"66;
A1726:
{
A48 A2126 = A979((A18)A7999);
A48 A4675 = A2126 + ((A72) strlen(A2126));
A66 A1730;
A1730 = 100;
A1770:
if( A1730 > 0) "
70D60I2"68"
70D54I2"69"
59D6I27"71: A1730 /= 10;
goto A1770"
11D2I2"68"
8D20I98"( !( (A7999) % (A1730) ) ) &&
(A7928 = A7799( A1174, A7999, A7999+A1730, (A4) 0 )) == A7999+A1730 "
30D2I2"69"
13D1I1"1"
6D13I24"69:
if( (A1730 /= 10) ) "
22D1I13"2;
goto A1773"
7D28I19"2: *--A4675 = '?';
"
36D2I2"69"
8D47I26"3:A1664(' '); if( A8090 ) "
56D24I3"4;
"
33D13I1"5"
19D67I36"4:A1664( A8090 );
A1775:A1666( A2126"
76D7I4"8091"
18D2I2"76"
12D2I2"77"
7D30I15"76:A1664( A8091"
37D2I2"77"
7D1I1" "
9D2I2"67"
7D44I64"27: ;
}
A2 A7190[] = "erawtfoSlepmiG1";
int
A3493( A1875, A1835,"
49D63I2"1,"
68D13I26"5, A3490 )
A42 A1875;
A48 "
18D11I125";
A4 A3491;
UFLAG A3495;
A48 *A3490;
{
int A2948 = 0;
A6 A1732;
A2 A1868;
A9070 A1709;
A81 A80;
A44 A3573;
if( A1875 & 0x4000"
22D2I2"11"
12D2I2"12"
7D4I27"11:
A1875 &= ~0x4000;
if( !"
10D25I8"&& A1317"
36D2I2"13"
12D2I2"14"
7D49I51"13: A2948 = 2;
A1714: ;
A1712:
if( A1875 & 0x2000 )"
57D30I5"715;
"
37D55I2"71"
61D17I51"15:
if( (A1285 > 0) ) return A2948;
A1875 &= ~0x200"
23D20I25"16:
if( A1875 & 0x1000 ) "
28D33I4"17;
"
40D5I41"720;
A1717:
A1875 &= ~0x1000;
if( A656 ) "
12D2I14"721;
goto A172"
7D31I43"721:
{
A48 A1737; A7 A1804=0;
if( !A5336 ) "
39D26I4"23;
"
33D5I61"725;
A1723: A5336 = A999( 200, 0 );
A1725:
if( A1875 == 49 ) "
12D23I5"726;
"
31D40I23"27;
A1726:
A997( A5336,"
47D5I28"0] );
A997( A5336, A3496 );
"
12D14I2"76"
19D26I16"727: if( A1737 ="
33D17I7"A1804++"
28D2I2"76"
12D2I2"76"
7D55I27"767: A997( A5336, A1737 ); "
63D22I79"27;
A1768:
A1766:
A1012 = NULL;
A1005( A5336 );
}
A1722: ;
A1720:
if( !A2948 ) "
30D22I2"69"
33D2I27"0;
A1769: switch( A1875 )
{"
8D11I27"57:
A5305 = 1;
if( !A656 ) "
20D23I3"2;
"
30D4I64"773;
A1772: background( A3495 > 0 ? 2 : A3491 ? 1 : -1 );
A1773:"
12D27
32D7
12D24I53"33:
A3488( &A3451, A3490, A3491, dot_cpp, dot_cxx );
"
31D3I61"771;
case 40:
A3488( &A3463, A3490, A3491, dot_vac, dot_lnt )"
12D75
85D11I24"38:
A3488( &A1223, NULL,"
18D2I60", NULL, NULL );
A1732 = 1;
A1776:
if( A1835 = A3490[A1732]) "
11D69I3"4;
"
76D14I21"775;
A1777: A1732++;
"
23D12I19"6;
A1774:
sys_fnmap"
17D10I10"35, 'c' );"
18D30I26"777;
A1775:
A3488( &A1223,"
36D28I20", (A4) 1, NULL, NULL"
39D70
80D36I2"36"
48D14
23D2I2"77"
12D2I2"77"
7D14I88"778:
{extern A48 A1936();
default_ext[1] = A1076( A1344, A1936(A1835) );
if( A3490[2] ) "
21D28I5"780;
"
35D4I52"781;
A1780:
A887( 660, A1226, A3490[2] );
A1781: ;
}"
12D10I10"782;
A1779"
15D41I12"18();
A1782:"
49D12I14"771;
case 50:
"
17D10I7"3490[2]"
20D3I3"783"
12D33I37"784;
A1783:
{
A72 A2847 = (A72) A985("
38D12I32"0[2] );
if( !A1835 || !*A1835 ) "
19D32I5"785;
"
39D27I11"786;
A1785:"
33D14I21" = "sa";
A1786:
if( *"
19D10
19D4I4"1787"
12D88I22"1788;
A1787:
switch( *"
93D26I31"++ )
{
case 's': A1214 = A2847;"
33D6I31"1889;
case 'a': A1213 = A2847; "
12D42I24"1889;
default: A1418(); "
48D36I13"1889;
}
A1889"
46D3I3"178"
8D3I26"788: ;
}
goto A1890;
A1784"
8D11I45"18();
A1890:
goto A1771;
case 12:
A459();
if("
17D57
66D4I4"1891"
12D50I25"1892;
A1891: aoc_plus = *"
55D19I8";
A1892:"
27D19
29D1I1"6"
8D5I6"!A1835"
14D4I4"1893"
12D78I23"1894;
A1893: A1337 = 1;"
85D40
47D40I9"1894:
A13"
45I22"(A7) A985(A1835);
if( "
8D34
43D4I4"1895"
12D39I62"1896;
A1895:
A1342 = A1076( A1344, A3490[2] );
if( A3490[3] ) "
45D49I6"1897;
"
55D5I62"1898;
A1897: A1343 = A1076( A1344, A3490[3] );
A1898: ;
A1896:"
12D36I21"1771;
case 62:
A1434("
45D50I26"1771;
case 11:
A1317 = 1;
"
56D4I20"1771;
case 1:
A667()"
12D39I26"1771;
case 2:
if( A1330 ) "
45D53I6"1899;
"
59D6I21"1900;
A1899: ++A916; "
12D39I42"1771;
A1900:
case 42:
A917();
if( A1330 ) "
45D51I6"1901;
"
57D4I26"1902;
A1901:
A915( A7178 )"
12D34I23"1903;
A1902:
A915( A717"
39I7"A1903:
"
6D49I31"1771;
case 98:
A7189 = (A4) 1;
"
55D6I72"1771;
case 58:
case 59:
A459();
if( A3490[1] && A3490[2] && !A3490[3] ) "
12D40I15"1904;
A1418(); "
46D50I28"1771;
A1904:
if( A1875 == 58"
59D4I4"1905"
12D36I53"1906;
A1905:
A1437( A3490[1], A3490[2], &A2253, A3465"
46D52I64"1907;
A1906:
A1437( A3490[1], A3490[2], &A3449, A3466 );
A1907:
"
58D6I75"1771;
case 7:
case 13:
A459();
A1732 = 1;
A1910:
if( A1835 = A3490[A1732]) "
12D38I4"1908"
46D11I86"1909;
A1911: A1732++;
goto A1910;
A1908:
if( A3495 < 0 ) goto A1912;
goto A1913;
A1912"
16D107I8"41(
A187"
112D19I29"13 ? A3466 : A3465, A1835 );
"
25D6I31"1914;
A1913: if( A1875 == 13 ) "
12D20I4"1915"
28D17I18"1916;
A1915: A1439"
23D2I2"49"
11D20I15"A3491, A3466 );"
28D108I29"917;
A1916: if( *A1835 == '*'"
118D20I27"918;
goto A1919;
A1918:
if("
26D16I13"[1] == 'm' &&"
22D18I10"[2] == 's'"
29D2I2"30"
12D2I2"31"
7D66I9"30:
A3467"
71D3I43"491;
A1438( 2 );
A1438( 2 | 0 );
goto A2332"
8D6I15"31: if( (strcmp"
11D29I25"35, "*type_traits" ) == 0"
41D2I2"33"
12D2I2"34"
7D8I9"33: A3467"
13D3I29"491; A1438( 27 ); 
goto A2335"
8D45I31"34: A1418();
A2335: ;
A2332: ;
"
53D14I47"36;
A1919: A1439( &A2253, A1835, A3491, A3465 )"
19D23I16"36:
A1917:
A1914"
30D9I12"656 && !A349"
21D2I2"37"
12D2I2"38"
7D28I9"37:
A5548"
39D6I46"7 ? &A5369 : &A5370, A1835, A3491 );
A2338: ;
"
12D5I12"1911;
A1909:"
12D33I13"1771;
case 51"
40D11I4"3491"
22D2I2"39"
12D2I2"40"
7D25I29"39:
{
A48 A1737;
A5794 A1748;"
33D1I1"3"
6D3I24"NULL || A3490[2] == NULL"
14D2I2"41"
12D2I2"42"
7D17I23"41: A1418(); goto A1771"
22D3I52"42:
A1748 = A1076( A1344, A1835 );
A1737 = A3490[2];"
8D11I28"(strcmp( A1737, "on" ) == 0)"
22D2I2"43"
12D2I2"44"
7D17I40"43: A972( &A3450, A1748, 6 );
goto A2345"
22D17I40"44: if( (strcmp( A1737, "off" ) == 0) ) "
23D60I4"2346"
68D56I4"2347"
61D15I26"46: A972( &A3450, A1748, 5"
27D2I2"48"
7D26I41"47: if( (strcmp( A1737, "once" ) == 0) ) "
32D31I4"2349"
39D29I35"2350;
A2349: A972( &A3450, A1748, 7"
39D24I3"235"
30D28I42"50: if( (strcmp( A1737, "message" ) == 0) "
38D1I1"5"
12D1I1"5"
7D11I28"52: A972( &A3450, A1748, 8 )"
21D1I1"5"
7D36I1"5"
43D15I31"(strcmp( A1737, "macro" ) == 0)"
26D2I2"55"
12D2I2"56"
7D26I30"55: A972( &A3450, A1748, 9 );
"
34D2I2"57"
7D2I2"56"
8D22I29"(strcmp( A1737, "ppw" ) == 0)"
33D2I2"58"
11D3I3"359"
8D55I30"58: A972( &A3450, A1748, 10 );"
62D24I50"2360;
A2359: if( (strcmp( A1737, "options" ) == 0)"
34D2I2"36"
12D2I2"36"
7D11I29"361: A972( &A3450, A1748, 11 "
21D2I2"36"
7D49I44"362: if( (strcmp( A1737, "fmacro" ) == 0) ) "
55D28I6"2364;
"
35D14I2"36"
19D34I30"364: A972( &A3450, A1748, 12 )"
42D101I13"2366;
A2365: "
112D2I56"366: ;
A2363: ;
A2360: ;
A2357: ;
A2354: ;
A2351: ;
A234"
7I11"A2345: ;
}
"
7D54I10"367;
A2340"
86D20
29D3I3"368"
12D10I10"369;
A2368"
20D1I1"
"
7I61"2370;
A2369: A972( &A3450, A1835, 0 );
A2370: ;
A2367:
goto A"
6D6I87"case 8:
case 65:
case 9:
case 10:
case 101:
case 109:
case 73:
case 103:
{
A5794 A3504;"
11D6I11"(A1270 > 0)"
15D6I70"1771;
A459();
A3504 = A1835 ? A1076( A1344, A1835 ) : "";
if( A3504 ) "
13D213I23"371;
goto A2372;
A2371:"
220D8I18"875 == 8 && *A3504"
18D3I3"373"
12D72I33"374;
A2373: A944 = A3504;
A2374:
"
78D8I31"875 == 9 && ( *A3504 || *A946 )"
18D3I3"375"
12D44I30"376;
A2375:
A945 = A3504;
A237"
53D33I30"875 == 10 && ( *A3504 || *A945"
45D14I5"377;
"
20D34I30"2378;
A2377:
A946 = A3504;
A23"
45D1I1"7"
6D24I2"65"
34D3I3"379"
12D21I53"380;
A2379: A7180 = A3504;
A2380:
if( A1875 == 101 ) "
28D2I14"381;
goto A238"
7D10I29"381: A7181 = A3504;
A2382:
if"
15D33I12"75 == 109 ) "
39I209"2383;
goto A2384;
A2383: A7264 = A3504;
A2384:
if( A1875 == 103 ) goto A2385;
goto A2386;
A2385: A7227 = A3504;
A2386:
if( A1875 == 73 ) goto A2387;
goto A2388;
A2387: A5510 = A3504;
A2388: ;
A2372: ;
}
goto A"
11D14I40"28:
sys_include( A1835, NULL, 0 );
A1329"
22D112I74"1;
goto A1771;
case 120:
A9253.A9250 &= ~(A17) 0x04; A1732 = 1;
A2391:
if("
119D17I1"="
23D31I1"["
36D36
46D3I3"389"
12D10I10"390;
A2392"
28D34I86"391;
A2389: A9254( A1835 ); goto A2392;
A2390: goto A1771;
case 121:
A1732 = 1;
A2395:"
39D66I7"A1835 ="
71D6I8"0[A1732]"
15D3I3"393"
12D46I2"39"
51D49I14"396: A1732++;
"
56D16I27"395;
A2393: A9308( A1835 );"
24D5I12"396;
A2394: "
11D97I33"1771;
case 3:
A917();
if( A1330 )"
105D24I5"397;
"
30D18I28"2398;
A2397:
A914( A7178 );
"
25D4I33"399;
A2398:
A914( A7179 );
A2399:"
11D45I29"1771;
case 117:
A8523( (A5) 1"
55D4I64"1771;
case 118:
A8523( (A5) 0 );
goto A1771;
case 102:
A1732 = 1"
9D38I52"02:
if( A1835 = A3490[A1732]) goto A2400;
goto A2401"
43D48I12"03: A1732++;"
55D17I18"2402;
A2400: A7753"
26I1";"
9D14I2"03"
19D18I48"01: if( !A3491 && A3495 ) goto A2404;
goto A2405"
23D48I45"04: A7751.A7735 = (A4) 0; goto A2406;
A2405: "
53D16I9"3491 || !"
22D27I6"A1732]"
38D1I1"0"
12D1I1"0"
7D13I56"07: A7751.A7735 = (A4) 1; A1400 |= 0x01; 
A2408:
A2406:
"
25D23I6"case 4"
29D12I7"!A1330 "
22D1I1"0"
12D1I1"1"
7D11I11"09: A3482()"
21D1I1"1"
7D242I37"10: A1581( A1590( 4 ) );
A2411:
A1338"
250D72I14"1;
goto A1771;"
78D35I3"70:"
40D30I6"!A1330"
41D2I2"12"
12D2I2"13"
7D18I11"12: A3482()"
23D1I36"13:
A2154 |= 0x20;
goto A1771;
case "
9D19I4"1835"
30D2I2"14"
12D2I2"15"
7D20I3"14:"
26D8I24"1219 = (A67) A985(A1835)"
19D2I20"16;
A1418();
A2416: "
12D2I2"17"
7D58I27"15: A1406 = (A4) 1;
A2417:
"
64D6I67"1771;
case 64:
if( A1835 == NULL || A3490[2] == NULL || A3490[3] ) "
14D2I14"18;
goto A2419"
7D24I23"18: A1418(); goto A1771"
29D33I3"19:"
40D3I3"505"
15D2I2"20"
12D2I2"21"
7D28I30"20:
A5050 = A999( 20, (A41) 43"
35D26I186"21:
{
struct A5046 *A1731;
A48 A1748[4];
A6 A1730;
A1731 = (struct A5046 *) A1005( A5050 );
A1731->A5049 = A1076( A1344, A3490[2] );
A1730 = A994( A1748, 3, A1835, 0 );
if( A1730 == 2 ) "
34D62I4"22;
"
70D45I52"23;
A2422: A1731->A5048 = A1076( A1344, A1748[1] );
"
53D44I27"24;
A2423: if( A1730 == 0 )"
53D45I4"25;
"
53D14I2"26"
19D74I12"25: A1418();"
81D16I4"1771"
21D53I11"26:
A2424:
"
59D25I35"731->A5047 = (A67) A985( A1748[0] )"
36D21I12"27;
A1418();"
28D27I4"1771"
32D15I26"27: ;
}
goto A1771;
case 7"
22D15I16"A1835 == NULL ||"
22D9I10"2] == NULL"
20D2I2"28"
12D2I2"29"
7D22I23"28: A1418();
goto A2431"
27D10I17"29: A5763( A1835,"
17D4
9D4I7"3490[3]"
9D47I6"2431:
"
53D32I196"1771;
case 84:
{
A4 A8092 = (A4) 0;
const A7471 A1883 = (2000 / CHARLEN);
static A13 A8093[ (2000 / CHARLEN) ];
A5794 A1748; const A5794 *A1872 = A1835 ?
(const A5794 *) A3490 : A8087;
A1142(A8093"
37D22I14"83);
A1732 = 1"
27D2I2"34"
9D5I19"1748 = A1872[A1732]"
15D2I2"32"
12D2I2"33"
7D24I13"35: A1732++;
"
32D14I2"34"
19D45I26"32:
{
A7 A8094;
A17 A8095;"
50D20I76"*A1748++ != 'w' || (A8094 = (A7) A985(A1748) ) > 4 ||
A8094 < 0 || A3495 < 0"
31D2I2"36"
12D2I2"37"
7D2I2"36"
13I16"A8092 = (A4) 1; "
8D2I2"33"
7D47I3"37:"
52I56"(A8095 = 0x01 << A8094) & A1222.A6042 ) goto A2435;
if( "
6D19
29D2I2"38"
12D2I2"39"
7D14I14"38: A1222.A604"
19D10I5"A8095"
15D135I60"39:
A1222.A6040 |= A8095;
A3481( A8093 , (A4) 0, A8094 );
} "
143D1I1"3"
7D2I2"33"
8D13I5"A8092"
22D6I18"1771;
if( A3491 ) "
14D2I14"40;
goto A2441"
7D15I111"40: A1144( A1222.A7800, A8093, A1883 );
goto A2442;
A2441: A5533( A1222.A7800, A8093, A1883 );
A2442:
A1222.A60"
21D88I16"7724( A1222.A780"
93D12I4"883 "
17D28I20"goto A1771;
case 86:"
36D39I2"35"
50D2I2"43"
12D2I2"44"
7D44I18"43:
A8298( A1835 )"
49D14I50"44:
case 6:
case 19:
case 37:
case 48:
case 91:
if"
19D86I13"35 == NULL ||"
91D20I29"0[2] == NULL ||
!A5991(A1835)"
31D2I2"45"
12D2I2"46"
7D28I23"45: A1418(); goto A1771"
33D4I13"46:
A1732 = 2"
9D33I3"49:"
39D17I11"3490[A1732]"
27D2I2"47"
12D2I2"48"
7D34I13"50: A1732++;
"
42D14I2"49"
19D83I26"47:
{
struct A1186 *A6010 "
89D76I48", *A6011 = NULL, *A6012;
A4 A2810;
A48 A1806;
A2"
81D97I23"6[50];
A2810 = (A4) 0;
"
102D28I76" = ((A48)( A1835 ));
switch(A1875)
{
case 37:
A6010 = &A1324;
A6011 = &A5985"
34D5I30"*A1835 == '(' || *A1835 == '{'"
16D2I2"52"
11D3I3"453"
8D46I27"52: A2810 = (A4) 1;
A2453:
"
51D2I19"2810 || A969 == '{'"
12D2I2"45"
12D2I2"45"
7D69I38"454:
A3506[0] = '\0';
if( A3495 < 0 ) "
77D2I14"56;
goto A2457"
7D7I57"56: strcpy( A3506, "-" ); A3495 = 0; 
A2457:
if( !A2810 )"
16D10I3"58;"
17D80I58"2459;
A2458: strcat( A3506, "{" );
A2459:
sg_sfcat( A3506,"
86D45I18", 50 );
if( !A2810"
55D3I3"460"
12D30I2"46"
35D76I29"460: sg_sfcat( A3506, "}", 50"
81D2I69"2461:
A1806 = A3506;
A2455:
goto A2451;
case 6:
case 86:
case 19:
A60"
7D84I23"&A1323; A6011 = &A5984;"
92D5I46"451;
case 48:
A6010 = &A1325; A6011 = &A5986; "
12D21I46"451;
case 91:
A6010 = &A6047; A6011 = &A6048; "
28D66I33"451;
default:
A865(288);
}
A2451:"
71D24I5"A3491"
34D2I2"46"
12D2I2"46"
7D2I2"46"
8D36I84"12 = A6010; A6010 = A6011; A6011 = A6012;
A9179( A1835, A3491 );
A2463:
A9311( A6010"
41D17I52"11, A1806, A3490[A1732], A1875, A3495, A3490[0] );
}"
25D4I11"450;
A2448:"
11D12I76"1771;
case 88:
{
A48 A4694; A61 A1710; A61 (*A6085)() = A3491 ? A871 : A873;"
17D12I50"A1835 == NULL || A3490[2] == NULL ||
!A5991(A1835)"
22D3I3"464"
12D72I20"465;
A2464: A1418();"
79D6I181"1771;
A2465:
{
struct A322 *A1824 = A511(1);
A1447( A1835, (A4) 0, A1824, (A17) 0x01 );
A1710 = A871( A930( A1824 ), A1222.A6041 );
}
A1732 = 2;
A2468:
if( (A4694 = A3490[A1732]) ) "
13D21I5"466;
"
28D56I19"467;
A2469: A1732++"
65D11I66"468;
A2466:
{
A17 A6083 = 1;
A4 A6084;
A54 *A3578;
A3469( A4694 );"
17D11I23"(A6084 = A928( A4694 ))"
21D3I3"470"
12D10I10"471;
A2470"
15D60I30"83 |= 2 | 8 | 4;
A2471:
A6080("
69D44I10"6083 );
if"
49I44"84 ) goto A2472;
goto A2473;
A2472:
if( !A60"
7D72I3"8 )"
80D15I4"474;"
22D121I22"2475;
A2474:
A6046.A11"
127D52I26"999( 4, (A41) 18);
A2475:
"
58D4I11"5914(A4694)"
14D3I3"476"
12D90I20"477;
A2476: A1418();"
98D42I2"46"
47D62I19"477:
A3578 = &(A929"
67D10I24"46.A1188, A4694 )->A6035"
20D2I2"47"
7D22I3"473"
28D54I12"!A6046.A1187"
64D2I2"47"
12D2I2"48"
7D125I47"479:
A6046.A1187 = (struct A83 *) A1073((A41) 2"
130D69I2"10"
74D90I38"46.A1187, A4694, A1130, A1344, NULL, 0"
95D41I103"480:
A3578 = &(A213( A6046.A1187, A4694, 2 )->A140.A6021);
A2478:
*A3578 = (*A6085)( *A3578, A1710 );
}"
49D4I15"469;
A2467: ;
}"
11D62I30"1771;
case 92:
{
A7 A6086; A48"
67D82I36"8; A2 A1736[30]; A5794 A6087 = A6076"
89D38I44", A3495 );
A49 *A2098; A54 A3715;
A5794 A608"
43D21I65"1076( A1344, A1226 ); A17 A6089 = A1400;
A1400 = 0; if( !A6075 ) "
28D52I4"481;"
59D13I64"2482;
A2481: A6075 = A999( 4, (A41) 0 );
A2482:
A6086 = 1;
A2485"
19D7I20"A1748 = A3490[A6086]"
16D3I3"483"
12D59I21"484;
A2486: A6086++;
"
66D14I2"48"
19D32I11"483:
sprint"
37D6I64"736, "%semacro(%s,&lib)", A6087, A1748 );
A997( A6075, A1736 );
"
13D43I21"486;
A2484: A3715=( 0"
48D24I3"489"
31D4I53"2098 = ( A6075)->A988+ A3715, A3715 <= ( A6075)->A991"
14D3I3"487"
12D24I21"488;
A2490: A3715++;
"
31D5I52"489;
A2487:
{
A48 A3518 = (A48) *A2098;
if( A3518 ) "
12D19I3"491"
28D2I56"502;
A2491: lnt_option( A3518, 0 );
A2502: ;
} goto A249"
7D44I62"488:
A1400 = A6089;
A1226 = (A48) A6088;
A1009( A6075, 0 );
}
"
50D56
67D1I80"63:
{
struct A322 *A1745;
A61 A1710;
int A2282;
A1745 = A511(1);
A2282 = 1;
A250"
14I14"= A3490[A2282]"
9D3I3"503"
12D24I21"504;
A2506: A2282++;
"
31D26I19"505;
A2503:
A1447( "
31D2I31", (A4) 0, A1745, (A17) 0x01 ); "
9D1I1"5"
7D34I60"504:
A1710 = A871( A930( A1745 ), A1222.A6041 );
if( A3491 )"
42D12I3"507"
21D8I8"508;
A25"
14D13I27"218 = A871( A1218, A1710 );"
20I60"2509;
A2508: A1218 = A873( A1218, A1710 );
A2509: ;
}
goto A"
11D2I2"32"
8D5I6"!A3464"
15D3I3"510"
12D1I79"511;
A2510: A3464 = A999( 4, 0 );
A2511:
if( A3495 == -1 ) goto A2512;
goto A25"
7D1I1"5"
7D16I28"009( A3464, 0 );
A2513:
if( "
21D3I3" ) "
10D63I5"514;
"
70D4I40"515;
A2514: A997( A3464, A1835 );
A2515:"
11D12I18"1771;
case 27:
if("
19D26
35D3I3"516"
12D25I14"517;
A2516:
if"
33D36I1")"
44D42I5"518;
"
49D3I19"519;
A2520: ++A1835"
12D66I2"51"
71D42I44"518:
A3355[(A9)(A15)(*A1835)] = A3355['a']; "
49D48I12"520;
A2519: "
57D3I38"521;
A2517: A1418();
A2521:
goto A1771"
10D5I15"45:
if( A1835 )"
12D24I6"2522;
"
31D16I24"523;
A2522:
if( *A1835) "
23D12I3"524"
21D34I20"525;
A2526: ++A1835;"
41D43I42"2522;
A2524:
A3355[(A9)(A15)(*A1835)] = 4;"
51D3I12"526;
A2525: "
12D10I10"527;
A2523"
21I7"A2527:
"
6D45
56D20I2"14"
32D14
23D3I3"528"
12D10I10"529;
A2528"
17D2I19" = (A6) A985(A1835)"
11D18I35"530;
A2529: A1732 = 0;
A2530:
if( ("
23D6I2" ="
11D20I15"0[2]) == NULL )"
28D11I4"531;"
18D36I12"2532;
A2531:"
45D6I18""cpx";
A2532:
if( "
11D1I1" "
10D3I3"533"
12D11I62"534;
A2533:
A2535:
switch( *A1835++ )
{
case 'x': A431->A185 ="
17D4I2"; "
11D84I3"537"
91D8I9"'p':
A132"
13D48I18"1732;
if( A1502 ) "
54D60I6"2538;
"
67D5I45"539;
A2538:
A1502->A185 = A1328;
if( A1501 ) "
12D19I3"540"
28D2I2"54"
7D86I2"54"
91D24I8"501->A18"
29D13I22"1328;
A2541: ;
A2539:
"
20D23I22"537;
case 'c':
A1327 ="
29D2I20";
A433->A185 = A1327"
11D54I15"537;
case '\0':"
61D13I24"3507;
default: A1418(); "
19I86"2537;
}
A2537: ;
goto A2535;
A2536: ;
goto A2542;
A2534: A1418();
A2542:
A3507:
goto A"
13D18I8"6:
if( !"
23D37I18"[1] || A3490[2] ) "
43I85"2543;
goto A2544;
A2543: A1418();
goto A2545;
A2544: A8226( A3490[1] );
A2545:
goto A"
11D31I3"81:"
46D2I2"00"
37D3I3"598"
12D3I3"599"
8D2I2"01"
21D36I16"00;
A2598:
A668("
42D4I31", 'd', A3491, &A5811, &A5812 );"
13D3I10"01;
A2599:"
10D4I24"1771;
case 79:
A1732 = 1"
9D23I6"04:
if"
31D8I7"= A3490"
15D11I2") "
19D1I13"02;
goto A260"
7D10I4"05: "
15D19I2"++"
29D2I2"04"
7D18I21"02:
A668( A1835, 'h',"
23D14I31"1, &A5809, &A5810 ); goto A2605"
19D30I4"03:
"
36D4I70"1771;
case 80:
A5808 = A5666( A3490, (0x001 | 0x002 | 0x004 | 0x008) )"
12D4I25"1771;
case 112:
A1732 = 1"
9D4I22"08:
if( A1835 = A3490["
9D4I3"]) "
12D2I14"06;
goto A2607"
7D2I30"09: A1732++;
goto A2608;
A2606"
46D21
30D3I10"09;
A2607:"
10D4I25"1771;
case 110:
A1732 = 1"
9D39I3"12:"
45D4I12"1835 = A3490"
11D1
11D1I1"1"
12D1I1"1"
7D34I23"13: A1732++;
goto A2612"
39D4I57"10:
A668( A1835, 'h', A3491, &A7706, &A7707 ); goto A2613"
9D5I3"11:"
12D23
36D16I16"1:
A7705 = A5666"
23D48I37", (0x001 | 0x002 | 0x004 | 0x008) );
"
54D16I52"1771;
case 115:
{
A4 A5846[30]; A48 A7368;
A1732 = 1"
21D4I22"16:
if( A1835 = A3490["
9D4I3"]) "
12D2I14"14;
goto A2615"
7D9I57"17: A1732++;
goto A2616;
A2614:
if( A7368 = A5094( "(*)","
15D50I2" )"
61D2I2"29"
12D2I2"30"
7D36I30"29:
*A7368 = '\0';
A239( A1835"
41D6I20"5846[A1732] = (A4) 1"
16D2I2"31"
7D3I35"30: A5846[A1732] = (A4) 0;
A2631: ;"
10D29I26"2617;
A2615:
A3573 = A8088"
36D57I3" );"
72D2I2"34"
38D2I2"32"
12D2I2"33"
7D2I2"35"
21D2I2"34"
7D2I2"32"
31D3I3"770"
8D7I28"7709 );
if( A3491 && A1011 )"
16D10I3"36;"
17D24I4"2637"
29D3I39"36:
A971( (A22) A1011, A3573, &A7722 );"
9D12I4"5846"
19I1" "
10D2I2"38"
12D2I2"39"
7D23I34"38:
A971( (A22) A1011, 1, &A7723 )"
28D57I4"39: "
62D3I5"37: ;"
10I23"2635;
A2633: ;
}
goto A"
11D3I28"113:
A3573 = A8088( A3490 );"
18D2I2"42"
38D2I2"40"
12D2I2"41"
7D2I2"43"
21D2I2"42"
7D2I2"40"
18D1I1"h"
13D15I36"7706, &A7707 );
if( A3491 && A1011 )"
24D10I3"44;"
17I83"2645;
A2644:
A971( (A22) A1011, A3573, &A7721 );
A2645: ;
goto A2643;
A2641:
goto A"
12D7I9"14:
A7710"
76D2I20"17:
A1732 = 1;
A2648"
8D7I20"A1835 = A3490[A1732]"
17D2I2"46"
12D2I2"47"
7D11I37"49: A1732++;
goto A2648;
A2646:
A668("
17D36I6", 'd',"
41D7I20"1, &A4438, &A4439 );"
16D3I10"49;
A2647:"
10D4I24"1771;
case 15:
A1732 = 1"
9D27I30"52:
if( A1835 = A3490[A1732]) "
33D44I4"2650"
52D28I22"2651;
A2653: A1732++;
"
36D14I2"52"
19D13I8"50:
A668"
22D36I30"'h', A3491, &A4436, &A4437 ); "
44D2I2"53"
7D23I4"51:
"
40D35I20"93:
A1732 = 1;
A2656"
42D18I6"1835 ="
23D2I8"0[A1732]"
10D27I6"2654;
"
35D14I2"55"
19D21I11"57: A1732++"
31D2I2"56"
7D7I22"54:
A668( A1835, 'm', "
12D1I19", &A6028, &A6029 );"
9D4I11"657;
A2655:"
11D100
111D2I79"16:
A657 = A5666( A3490, (0x001 | 0x002 | 0x004 | 0x008) );
goto A1771;
case 34"
8D14I6"!A7228"
24D3I3"658"
12D53I19"659;
A2658:
A1216 ="
60I46"? (A18) A985(A1835) : 0;
A2659:
if( A3495 > 0 "
9D3I3"660"
12D17I17"661;
A2660: A7228"
22D15I12"4) 1;
A2661:"
22D47I46"1771;
case 44:
A1053 = A1076( A1344, A1835 );
"
53D6I28"1771;
case 105:
if( A1835 ) "
13D99I5"662;
"
106D3I64"663;
A2662:
sys_fnmap( A1835, 0 );
A7703 = A1076( A1344, A1835 )"
12D71I137"664;
A2663: A7703 = "";
A2664: goto A1771;
case 60:
A9040( 2 );
goto A1771;
case 47:
if( A8197 == (A42) 1 && A3491 ) goto A1771;
if( A232"
78D36I47"31] ) goto A2665;
goto A2666;
A2665: A884( 75, "
41D62I3" );"
70D37I22"667;
A2666:
if(A3491) "
43D27I6"2668;
"
34D3I33"669;
A2668: A1075[ (A41) 31] *= 2"
12D65I2"67"
70D21I44"669: A1075[ (A41) 31] /= 2;
A2670: ;
A2667:
"
27D6I36"1771;
case 83:
if( A232[(A41) 15] ) "
13D24I3"671"
33D27I30"672;
A2671: A884( 75, A1226 );"
34D21I17"2673;
A2672:
if( "
26D9I3" ) "
15D103I25"2674;
goto A2675;
A2674: "
111D14I10"(A6) A985("
19D17I3");
"
24D22I10"676;
A2675"
29D21I11" = 0;
A2676"
27D6I9"A1732 > 0"
16D3I3"677"
12D33I75"678;
A2677:
{
A72 A1883;
A1883 = ( (A72)A1732 + (CHARLEN-1) ) / CHARLEN;
if"
38D42I25"83 % (A72) sizeof(A49) ) "
49D107I5"679;
"
114D30I68"680;
A2679: A1883 = (A1883/(A72) sizeof(A49) + 1) * (A72) sizeof(A49"
35D68I20"680:
A1075[(A41) 15]"
74D65I95"83;
A5866 = A1883;
sprintf(A1226, "%s(%lu)", A3490[0],
(unsigned long) A5866 * CHARLEN - 1);
}
"
72D4I36"681;
A2678: A1418();
A2681: ;
A2673:"
11D19I63"1771;
case 52:
if( A1835 ) goto A2682;
goto A2683;
A2682: A1732"
24D138I8"6) A985("
143D17I3");
"
24D21I9"684;
A268"
29D21I11" = 0;
A2684"
27D6I9"A1732 > 3"
16D3I3"685"
12D95I24"686;
A2685: A660 = A1732"
104D50I2"68"
55D2I2"68"
16D8I4"687:"
26D26I10"94:
A8266("
31D3I1","
8D9I3");
"
15D25I103"1771;
case 89:
{
struct A322 *A6090;
A61 (*A6085)() = A3491 ? A871 : A873;
A61 A1824;
A6090 = A511(1);
"
30D4I39" = 1;
A2690:
if( A1835 = A3490[A1732]) "
11D38I5"688;
"
45D3I19"689;
A2691: A1732++"
12D10I10"690;
A2688"
16D14I1"*"
19D1
11D3I3"692"
12D24I80"693;
A2692:
A3452 = (A4) 0;
A1447( A1835, (A4) 0, A6090, (A17) 0x01 );
A2693: ;
"
31D23I40"691;
A2689:
A1824 = A871( A930( A6090 ),"
31D15I59"6041 );
A6038 = (*A6085)( A6038, A1824 );
if( A1732 <= 1 ) "
22D42I3"694"
51D10I10"695;
A2694"
23D12I3"695"
17D1I1"
"
7D19
30D38I3"18:"
44D2I2"41"
9D30I31"90:
{
A13 **A3509;
A3509 = A187"
35D24I56"18 ? &A1220 :
A1875 == 41 ? &A1221 : &A6043;
if( !*A3509"
34D3I3"696"
12D43I16"697;
A2696:
*A35"
48D12I92"(A13 *) A1670( (A72) ( (2000 / CHARLEN)), (A72) ( 1 ) );
A2697:
A3454 = *A3509;
A3453 = A187"
17D8I43"90 ? A3491 : !A3491;
A1732 = 1;
A2700:
if( "
15D6I13" A3490[A1732]"
15D3I3"698"
11D4I4"2699"
9D4I37"01: A1732++;
goto A2700;
A2698:
if( *"
9D43
52D3I3"270"
12D29I121"2703;
A2702:
A3452 = (A4) 0;
A1447( A1835, (A4) 1, NULL, A1875 == 90 ? 0 : (A17) 0x01 );
A2703: ;
goto A2701;
A2699:
if( "
35D28I5"<= 1 "
36D3I3"270"
12D21I32"2705;
A2704: A1418();
A2705: ;
}"
28D35I32"1771;
case 20:
A1732 = 1;
A2708:"
43D18I17"35 = A3490[A1732]"
26D4I4"2706"
12D85I20"2707;
A2709: A1732++"
93D29I38"2708;
A2706:
{
A77 A1948;
if( *A1835 )"
36D31I6"2710;
"
37D30I39"2711;
A2710:
if( A1948 = A1146(A1835) )"
37D35I6"2712;
"
41D46I15"2713;
A2712:
if"
52D40I3"1 )"
47D12I5"2714;"
19D44I35"2715;
A2714: A1222.A1163 |= A1948;
"
50D4I43"2716;
A2715: A1222.A1163 &= ~A1948;
A2716: "
12D11I11"2717;
A2713"
22I20"A2717: ;
A2711: ;
} "
6D18I39"2709;
A2707:
goto A1771;
case 26:
A1428"
23D31
40D13I3" );"
31D2I29"22:
case 23:
case 53:
case 54"
9D9I16"1835 == NULL || "
15D2I10"2] == NULL"
11D4I4"2718"
12D46I21"2719;
A2718: A1418();"
53D6I61"1771;
A2719:
A1709 = 0;
if( *A1835 == 'w' || *A1835 == 'W' ) "
12D40I39"2720;
goto A2721;
A2720: A1835++; A1709"
45D6I7" 
A2721"
12I10"!isdigit(*"
5D15I2") "
23D4I4"2722"
12D13I29"2723;
A2722: A1418();
A2723:
"
18D4I31" = 2;
A2726:
if( A3490[A1732]) "
10D29I6"2724;
"
35D13I22"2725;
A2727: A1732++;
"
19D14I35"2726;
A2724:
{
A44 A2086;
A6 A1730;"
22D10I17"75 != 22 && A1709"
19D4I4"2728"
12D11I11"2729;
A2728"
21D39I14"
A2729:
switch"
44D16I47"75 )
{
case 22:
A2086 = A1709 ? 0x300 : 0x200;
"
22D6I30"2730;
case 23: A2086 = 0x100; "
12D31I30"2730;
case 53: A2086 = 0x2600;"
38D6I31"2730;
case 54: A2086 = 0x2700; "
12D11I54"2730;
default: A2086 = 0; A1418(); goto A2730;
}
A2730"
16D70I15"30 = (A6) A985("
75D27I54");
A2132( A3490[A1732], 0xFF, A2086 + (A44) A1730 );
}"
34D13I1"2"
19D29I5"2725:"
36D13I24"1771;
case 55:
case 56:
"
20D9I10"35 == NULL"
18D4I4"2731"
12D35I20"2732;
A2731: A1418()"
43D15I18"2733;
A2732: A1579"
20D12I54"75 == 55 ? &A1386 : &A1387,
A1835, A3490[2] );
A2733:
"
18D6I40"1771;
case 72:
if( A3491 || !A3490[1] ) "
12D35I4"2734"
43D11I29"2735;
A2734: A5575 = 2;
A2735"
17D12I9"!A3490[1]"
21D4I4"2736"
12D11I33"2737;
A2736: A5546( NULL );
A2737"
16D40I15"32 = 1;
A2740:
"
47D10I17"35 = A3490[A1732]"
18D1I1"2"
12D1I1"2"
7D4I4"2741"
9D18I4"32++"
26D1I1"2"
7D8I11"2738: A5546"
13D11I5"35 );"
18D1I1"2"
6I7"A2739: "
6D1I42"1771;
case 24:
if( A1835 == NULL ) goto A2"
6D31
37D1I1"2"
7D1I1"2"
6I9"A1418(); "
6D8I8"1771;
A2"
14D34I20"1709 = 0;
A2744:if( "
43D2
7D2I5"++ ) "
8D13I4"2745"
21D13I13"2746;
A2745:
"
27D1I1"A"
11D4I4"2747"
12D11I11"2748;
A2747"
25D2I4"9070"
8D7I9"01|(A9070"
13D32I57"02|(A9070) 0x0004|(A9070) 0x0008);
A1868 = *A1835;
A2749:"
37D12I12"A1868 == 'i'"
21D4I4"2751"
12D11I11"2752;
A2751"
19D25I43"&= ~(A9070) 0x0001;
goto A5111;
A2752: if( "
32D31I4"= 'p"
42D3I3"112"
12D10I10"113;
A5112"
24D2I4"9070"
8D2I2"08"
11D10I10"114;
A5113"
38D3I3"115"
12D10I10"116;
A5115"
24D2I4"9070"
8D2I2"02"
10D11I11"5117;
A5116"
27D1I1"a"
11D4I4"5118"
12D11I11"5119;
A5118"
25D12I12"9070) 0x0004"
20D11I11"5120;
A5119"
27D1I1"c"
11D3I3"512"
12D40I56"5122;
A5121: A1709 |= (A9070) 0x0010;
goto A5123;
A5122:"
45D12I12"A1868 == 'z'"
21D4I4"5124"
12D18I18"5125;
A5124: A1709"
24D2I4"9070"
11D28I1";"
35D31I12"5126;
A5125:"
38D4I64"2750;
A5126:
A5123:
A5120:
A5117:
A5114:
A5111:
A1868 = *++A1835"
12D34I13"2749;
A2750: "
42D11I11"5127;
A2748"
27D1I1"J"
11D4I4"5128"
12D13I13"5129;
A5128:
"
23D3I36"(A9070) 0x0080|(A9070) 0x0040|(A9070"
11D3I39"|(A9070) 0x100000);
if( (A7473 <= 0) ) "
9D32I6"5130;
"
38D23I11"5131;
A5130"
36D7I9"9070) 0x8"
12D50I8"
A5131:
"
57D8I19" *A1835;
A5132:
if("
19D1I1"e"
11D4I4"5134"
12D11I11"5135;
A5134"
19D24
30D13I13"9070) 0x0080;"
20D11I11"5136;
A5135"
27D1I1"r"
11D4I4"5137"
12D11I11"5138;
A5137"
24D30I13"A9070) 0x0040"
38D12I31"5256;
A5138: if( A1868 == 'm' )"
20D84I3"257"
94D11I37"26;
A5257: A1709 &= ~(A9070) 0x100000"
19D4I4"5727"
9D1I1"2"
18D1I1"o"
11D4I4"5728"
12D54I44"5729;
A5728: { A9070 A1948 = (A9070) 0x2000;"
59D28I12"(A7474 <= 0)"
37D4I4"5730"
12D18I18"5731;
A5730: A1948"
24D22I11"9070) 0x100"
27I26"A5731: A1709 &= ~A1948; }
"
6D11I11"5732;
A5729"
27D17I1"c"
27D4I4"5733"
12D11I11"5734;
A5733"
24D7I9"9070) 0x4"
18D11I11"5735;
A5734"
27D17I1"z"
27D4I4"5736"
12D13I58"5737;
A5736: A1709 |= (A9070) 0x20000;
goto A5738;
A5737: "
27D1I1"n"
11D4I4"5739"
12D11I11"5740;
A5739"
24D30I14"9070) 0x40000;"
37D40I21"&= ~(A9070) 0x80000; "
47D11I11"5741;
A5740"
27D1I17"-' || A1868 == 'a"
11D4I4"5742"
12D23I66"5743;
A5742: A1709 |= (A9070) 0x80000; A1709 &= ~(A9070) 0x40000; "
30D11I11"5744;
A5743"
27D1I1"d"
11D4I4"5745"
12D22I58"5746;
A5745: A1709 &= ~((A9070) 0x80000 | (A9070) 0x40000)"
30D83I4"5747"
89D5I3"6: "
14D2I58"3;
A5747:
A5744:
A5741:
A5738:
A5735:
A5732:
A5727:
A5256:"
12D20I9"868 = *++"
25D17I2";
"
23D4I13"5132;
A5133: "
12D22I32"5748;
A5129: if( A1868 == 'X' ) "
28D66I6"5749;
"
72D4I36"5750;
A5749: A1709 |= (A9070) 0x0020"
12D46I11"5751;
A5750"
53D13I27"1868 == 'C' || A1868 == 'c'"
22D4I4"5752"
12D26I12"5782;
A5752:"
33D1I34"|= (A9070) 0x0010 | (A9070) 0x4000"
9D11I11"5783;
A5782"
18D20I27"1868 == 'l' || A1868 == 'L'"
29D75I6"5784;
"
82D2I34"060;
A5784: A1709 |= (A9070) 0x800"
12D2I2"06"
7D78I5"060: "
84D8I26"868 == 'b' || A1868 == 'B'"
18D3I3"062"
12D10I10"063;
A6062"
18D3I10"868 == 'b'"
13D3I3"091"
12D19I11"092;
A6091:"
25I18" |= (A9070) 0x1000"
9D24I44"093;
A6092: A1709 |= (A9070) 0x1000 | (A9070"
29D2I2"80"
7D13I6"093: ;"
20D24I13"6094;
A6063: "
31D24I9"68 == 'f'"
34D3I3"095"
12D64I18"096;
A6095: A608 |"
69D7I19"goto A6097;
A6096: "
14D17I10"68 == 'F' "
26D3I3"098"
12D19I21"099;
A6098: A608 |= 1"
28D26I93"100;
A6099: A1418();
A6100: ;
A6097: ;
A6094: ;
A6061: ;
A5783: ;
A5751: ;
A5748: ;
A5127: ;
"
32D31I13"2744;
A2746:
"
36D34I12" = 2;
A6103:"
42D9I17"35 = A3490[A1732]"
18D3I3"101"
12D45I19"102;
A6104: A1732++"
54D16I65"103;
A6101:
A80 = NULL;
if( (strcmp( A1835, "*builtin" ) == 0) ) "
23D27I4"105;"
34D15I48"6106;
A6105: A5392( A1709 );
goto A6107;
A6106: "
20I7"5404( A"
5D23I1")"
33D3I3"108"
12D25I26"109;
A6108: A5391( A1835, "
31D13I12");
goto A611"
18D4I5"109: "
9D8I6"7811( "
13D2I9", A1709 )"
12D5I74"111;
A80 = A213( A1388, A3490[A1732], 2 );
A6111:
A6110:
A6107:
if( A80 ) "
12D31I5"112;
"
38D23I24"113;
A6112:
A80->A128 |="
29I11";
A80->A127"
7D1I1"7"
6D3I10"8;
A6113: "
12D12I12"104;
A6102:
"
18D10I8"732 == 2"
20D3I3"114"
12D11I15"115;
A6114: if("
18D17I2") "
24D37I3"116"
46D91I26"117;
A6116: A1228 = A1709;"
99D4I52"118;
A6117: A1228 = (A9070) 0x0010;
A6118: ; 
A6115:"
11D22I58"1771;
case 39:
case 30:
if( A1835 && *A1835 && A3490[2] ) "
29D90I2"11"
100D16I103"120;
A6119:
{
A4 A9102 = A1875 == 39;
A5794 A9103 = A1835;
A1732 = 2;
A6123:
if( A1835 = A3490[A1732]) "
23D27I4"121;"
34D12I38"6122;
A6215: A1732++;
goto A6123;
A612"
19D11I7"!*A1835"
20D9I19"6215;
A9101( A9103,"
15D14I11", A9102 );
"
21D4I15"215;
A6122: ;
}"
12D37I53"216;
A6120: A1418();
A6216:
goto A1771;
case 25:
if( "
42D14I3" &&"
24I12"&& A3490[3] "
9D3I3"217"
12D23I30"218;
A6217:
{
A81 A3511;
A1709"
28D9I33"9070) 0x0100;
A6219:if( A1868 = *"
14D12I5"++ ) "
19D27I4"220;"
34D13I11"6221;
A6220"
19D6I12"A1868 == 'c'"
16D3I3"222"
12D84I56"223;
A6222: A1709 |= (A9070) 0x0200;
goto A6278;
A6223: "
91D33I9"68 == 'd'"
43D3I3"279"
12D68I37"280;
A6279: A1709 |= (A9070) 0x0400;
"
75D22I10"281;
A6280"
33I18"A6281: ;
A6278: ;
"
7D2I2"21"
7D25I37"221:
A3511 = A213( A1388, A3490[2], 2"
30D10
15D8I36"= 3;
A6284:
if( A1835 = A3490[A1732]"
17D3I3"282"
12D45I21"283;
A6285: A1732++;
"
52D53I2"28"
58D77I32"282:
A80 = A213( A1388, A1835, 2"
82D6I47"80->A128 |= A1709;
A80->A155.A146 = A3511->A169"
15D2I2"28"
7D20I8"283: ;
}"
27I35"6287;
A6218: A1418();
A6287:
goto A"
12D1I1"1"
7D16I11"(A1270 > 0)"
25D6I29"1771;
if( A1835 = A3490[1] ) "
13D39I3"288"
48D53I37"289;
A6288:
A7188.A1181 = (A53) A985("
58I12");
if( A1835"
9D1I1"2"
12D3I3"290"
12D23I23"291;
A6290:
A7188.A1183"
28D2I2"53"
7D3I2"5("
8D21I12");
A6291: ;
"
29D3I26"18;
A6289: A1418();
A6318:"
10D4I50"1771;
case 43:
if( !A1220 ) goto A6319;
goto A6320"
9D30I67"19:
A1220 = (A13 *) A1670( (A72) ( (2000 / CHARLEN)), (A72) ( 1 ) )"
35D4I4"20:
"
9D10I35"1835 && isdigit( (A9)(A15)(*A1835))"
21D2I2"21"
12D2I2"22"
7D21I60"21:
A1732 = (A6) A985(A1835);
if( A1732 < 0 || A1732 >= 5 ) "
29D2I14"23;
goto A6324"
7D17I23"23: A1418();
goto A6325"
22D4I26"24:
A6052( A1220, (A5) 1 )"
9D8I23"26:if( A1732 > A1404 ) "
16D2I14"27;
goto A6328"
7D20I37"27:
A3481( A1220, (A4) 1, ++A1404 ); "
26D35I33"6326;
A6328:
if( A1732 < A1404 ) "
41D58I6"6329;
"
66D14I2"30"
19D52I36"29:
A3481( A1220, (A4) 0, A1404-- );"
61D14I2"28"
19D2I54"30:
A6052( A1220, (A5) 0 );
A6325: ;
goto A6331;
A6322"
7D28I3"18("
34D11I2"31"
30D2I2"35"
14I11"= A3490[1] "
10D1I1"3"
12D1I1"3"
7D9I9"32:
A8804"
14D2I2"17"
7D2I3"3( "
7I1" "
11D1I1"3"
7D1I1"3"
16D1I1"3"
21D2I2"46"
14I11"= A3490[1] "
10D1I1"3"
12D1I1"3"
7D9I15"35:
{
A17 A1948"
14D2I2"17"
7D2I3"3( "
7D3I21" );
if( A3495 == 1 ) "
11D2I14"37;
goto A6338"
7D19I19"37: A1638 |= A1948;"
26D15I13"6339;
A6338: "
20D4I10"3495 == -1"
15D2I2"40"
12D2I2"41"
7D29I19"40: A1638 &= ~A1948"
39D2I2"42"
7D11I17"41: A1638 = A1948"
16D3I16"42: ;
A6339: ;
}"
10D24I4"6343"
29D30I20"36: A1418();
A6343:
"
36D4I33"1771;
case 49:
A1429(A1835,A3490)"
12D22I58"1771;
case 68:
A1445 = NULL;
A1446 = NULL;
if( A3490[1] ) "
30D2I14"44;
goto A6345"
7D18I52"44:
A1445 = A1076( A1344, A3490[1] );
if( A3490[2] )"
27D10I3"46;"
17D49I4"6347"
54D46I1"4"
52D3I28"46 = A1076( A1344, A3490[2] "
9D2I11"47: ;
A6345"
21D2I2"66"
10D8I3"835"
17D28I6"6348;
"
36D13I1"4"
19D26I23"48: A1379 = (A54) A985("
31D2I13");
goto A6350"
7D29I19"49: A1418();
A6350:"
47D3I2"67"
11D8I3"835"
17D20I4"6351"
28D19I32"6352;
A6351: A1381 = (A54) A985("
24D3I3");
"
10D4I27"353;
A6352: A1418();
A6353:"
11D24I19"1771;
case 69:
if( "
29D10I3" ) "
16D28I6"6354;
"
35D3I37"355;
A6354: A1380 = (A54) A985(A1835)"
12D22I27"356;
A6355: A1418();
A6356:"
29D25I37"1771;
case 71:
A1732 = 1;
A6359:
if( "
30D15I15" = A3490[A1732]"
24D3I3"357"
12D110I19"358;
A6360: A1732++"
119D24I18"359;
A6357:
A664( "
29D15I3" );"
23D4I11"360;
A6358:"
11D11I13"1771;
case 74"
17D19I6"A1835 "
28D3I3"361"
12D52I2"36"
57D10I10"361: A5101"
16D1
16D21
27I35"6363;
A6362: A1418();
A6363:
goto A"
11D37I3"75:"
42D19I10"A1227 >= 2"
28D6I28"1771;
if( A1835 && *A1835 ) "
13D59I3"364"
67I83"6365;
A6364: A5248 = A1076( A1344, A1835 );
A6365:
xmlout_tag( 1 );
++A5252;
goto A"
6D5I8"case 100"
12D64I9"1227 >= 2"
80D65I15"7191( A3490 );
"
71D6I27"1771;
case 82:
if( A1835 ) "
13D70I35"366;
goto A6367;
A6366: sys_putenv("
78D119I7"A6367:
"
125D6I28"1771;
case 85:
if( !A1835 ) "
13D2I14"368;
goto A636"
7D23I16"368: A5959 = 0;
"
30D24I12"370;
A6369: "
29D30I29"strcmp(A1835,"push") == 0) ) "
37D3I3"371"
12D2I121"372;
A6371:( * ( ( *++ A5960 == ((unsigned) -2) ) ? (A1521( (A1523 *)& A5960 ), A5960) : A5960 ) = ( A5959 ) );
goto A637"
7D19I37"372: if( (strcmp(A1835,"pop") == 0) )"
27D12I3"374"
21D30I37"375;
A6374:
if( !((A5961)==(A5960))) "
37D3I3"376"
12D34I2"37"
39D38I36"376:
A5959 = (*(A5960)--);
A6377: ;
"
45D4I59"378;
A6375: A5959 = (A72) A985(A1835);
A6378:
A6373:
A6370:"
11D83I31"1771;
case 87: 
{
struct A2258 "
88D14I39";
A57 A1824;
if( !A1835 || !A1835[0] ) "
21D2I14"379;
goto A638"
7D78I53"379:
A887(686, "-message", "a lack of an argument") ;"
91D7I5"A6380"
14D32I37"3495 == -1 && !( A719 && ( A719->A162"
37D6I22"!(A719->A1626 & 1) ) )"
15D6I72"1771;
A1824 = A1649;
A1649 = A1212 ? A1482 : A510;
A1668();
if( A1212 ) "
13D2I14"381;
goto A638"
7D11I9"381:
{
A9"
16D39I24"3;
A2160( &A3924, (A5) 1"
44D30I19"1492 = A9038(A1378,"
36I119");
(void) ((A1463=(A9)(A15)(*A1492++)) ? ((A1463 == (A9)(A15)('\\'))?A1462():A1463) : A1461() );
A6383:if( A2163() != 1"
10D3I3"384"
12D47I2"38"
52D21I23"384:
if( A2142 == 21 ) "
27D36I4"6386"
44D12I10"6387;
A638"
19D11I31"(A1833 = A2158('"',0)) != -1 )
"
18D3I3"388"
12D74I2"38"
79D19I19"388:A1664( A1833 );"
27D3I12"386;
A6389: "
12D30I29"390;
A6387: if( A2142 == 15 )"
38D2I14"391;
goto A639"
7D21I16"391:A1666(A2149)"
30D2I2"39"
7D59I18"392:
A1666(A2149);"
65D11I12"1463 == ' ' "
20D2I2"39"
12D2I2"39"
7D12I46"394:A1664( A1463 );
A6395: ; 
A6393: ;
A6390: "
21D2I48"383;
A6385:
A2160( &A3924, (A5) 0 );
}
goto A639"
7D79I17"382: A1666( A1835"
84D17I36"6396:A1664('\0');
A884( 865, A1669()"
23D27I14"649 = A1824;
}"
34D35
46D56I3"77:"
63D11I8"227 >= 2"
20D6I28"1771;
if( A1835 && *A1835 ) "
13D24I14"397;
goto A639"
29D25I10"397: A5819"
32D2I1","
9D8I41"2], A3490[2] ? A3490[3] : NULL );
A6398:
"
14D6I27"1771;
case 76: if( A1835 ) "
13D19I3"399"
29D18I29"00;
A6399: A5822 = (A7) A985("
23D4I3");
"
12D2I2"01"
7D18I19"00: A1418();
A6401:"
31D2
7D10I18"95:
A6277( A3491, "
15D31I4" );
"
37D6I30"1771;
case 96:
if( A3490[1] ) "
14D2I14"02;
goto A6403"
7D37I15"02:
if( (strcmp"
49D19I18""clean" ) == 0) ) "
25D32I6"6404;
"
38D21I15"6405;
A6404:
if"
27D12I7"0[2] ) "
18D59I6"6406;
"
67D14I2"07"
19D18I33"06:
A6272( A3490[2] );
goto A6408"
23D13I11"07:
A1418()"
18D30I6"08: ;
"
38D14I2"09"
19D4I41"05:
{
struct A144 *A6286 = A999( 4, 0 );
"
9D14I4" = 1"
19D4I4"12:
"
9D5I11"3490[A1732]"
15D2I2"10"
12D2I2"11"
7D18I13"13: A1732++;
"
26D14I2"12"
19D18I38"10:
(void) A997( A6286, A3490[A1732] )"
28D2I2"13"
7D31I22"11:
A1013( A6286, A627"
37D13I47"216( A6248, A6274 );
A1009( A6286, 0 );
}
A6409"
25D2I2"14"
7D2I18"03:
A1418();
A6414"
16D2
7D24I77"97:
{
A7 A2008 = (A7)(A1331 - A1319) + 1, A7143 = A1405;
if( A1405 > A2008 ) "
30D13I23"6415;
goto A6416;
A6415"
18D13I17"05 = A2008;
A6416"
18D37I18"32 = 1;
A6419:
if("
43D1I2" ="
6D21I40"0[A1732]) goto A6417;
goto A6418;
A6420:"
26D2I30"2++;
goto A6419;
A6417:
A1426("
8D4I91" ); goto A6420;
A6418:
A1405 = A7143;
goto A1771;
}
case 104:
if( !A3490[1] || !A3490[2] ||"
9D8I72"0[3] ) goto A6421;
goto A6422;
A6421: A1418();
goto A6423;
A6422: A7809("
13D8I6"0[1], "
13D53I133"[2] );
A6423:
goto A1771;
case 99:
A7190[14] = '1'; goto A1771;
case 106:
A9088( A3491, A3490 );
goto A1771;
case 107: {static A4 A75"
58D11I45"(A4) 1; if( !A3490[1] ) goto A6424;
goto A642"
16I27"424: A7548 = (A4) 0;
A6425:"
5D43I32"2 = 1;
A6428:
if( A1835 = A3490["
48D84I3"]) "
90D38I6"6426;
"
44D4I20"6427;
A6429: A1732++"
12D47I25"6428;
A6426: if( A7548 ) "
53D48I6"6430;
"
54D6I27"6431;
A6430: if( !*A1835 ) "
12D36I4"6432"
44D36I28"6433;
A6432: A7548 = (A4) 0;"
43D4I61"6434;
A6433: A5548( &A7506, A1835, (A4) 1 );
A6434: ;
A6431: "
12D37I12"6429;
A6427:"
46D21I28"71;
}
case 108:
A7284( A3490"
26D1I2";
"
9D2I28"71;
case 119:
A9183( A1835 )"
12D22I78"71;
default: A1418();
}
A1771:
A1770:
return A2948;
}
int
A3494( A1731, A1835,"
27D37I21"1, A3495, A3490 )
A48"
42D17I12"1, A1835;
A4"
22D75I8"1;
UFLAG"
80D2I135"5;
A48 *A3490;
{
UFLAG *A1749;
A9 A1868, A1956;
A72 A2835;
int A2948 = 0;
A42 A1875;
A6 A1730;
A4 A3514;
A81 A80;
extern A9 A1703;
int "
7D5I84";
struct A144 *A2093;
switch( *A1731 )
{
case '$':
A459();
A3355['$'] = A3355['a'];
"
13D14I36"11;
case ':':
++A1731;
if( *A1731 ) "
22D2I14"12;
goto A1713"
7D44I29"12: A1703 = (A9)(A15)(*A1731)"
49D16I4"13:
"
24D4I46"11;
case 'a':
case 'A':
if( A1731[1] == '#' ) "
12D2I14"14;
goto A1715"
7D20I27"14:
A1505( A1731+2, A1835 )"
30D2I2"16"
7D65I25"15: if( A1731[1] && A1835"
77D22I3"7;
"
30D14I2"20"
19D23I29"17:
A1505( A1731+1, A1835 );
"
31D1I1"2"
7D19I9"20: if( !"
24D22I3"[1]"
33D23I14"22;
goto A1723"
28D44I10"22:
A459()"
51D9I7"3490[1]"
20D1I1"2"
12D1I1"2"
7D1I1"2"
6D17I7"732 = 1"
22D4I4"67:
"
9D12I11"3490[A1732]"
22D2I2"27"
12D2I2"66"
7D1I1"6"
6D5I5"732++"
15D2I2"67"
7D22I26"27: A5405( A3490[A1732] );"
31D3I13"68;
A1766: ; "
12D2I2"69"
7D24I52"26: ansi_flag = 1;
A1244 = 1; A3355['@'] = 1;
A1769:"
31D10I3"212"
21D2I2"70"
12D2I2"71"
7D20I22"70: A1510();
A1771: ;
"
28D14I2"72"
19D29I9"23: {
A17"
35D4I50";
struct A1192 A3402;
A5794 A2126;
if( (A1285 > 0)"
15D4I23"11;
A459();
if( A443 ) "
12D2I14"73;
goto A1774"
7D17I33"73: A884( 75, A1226 ); goto A1711"
22D3I35"74:
A2126 = A1450( A1731, &A3402 );"
8D9I6"!A2126"
19D15I3"711"
20D12I46"68 = A3402.A1194;
A1730 = (A6) A985( A2126 );
"
17D8I15" = (A72) A1730;"
15D7I8"730 <= 0"
17D3I3"775"
12D46I3"776"
51D20I13"75: A1418();
"
27D5I31"777;
A1776: if( A1868 == 'b' ) "
12D50I5"778;
"
57D3I19"779;
A1778: A1418()"
12D34I12"780;
A1779: "
40D7I10"868 == 'p'"
17D3I3"781"
12D38I12"782;
A1781:
"
44D3I31"= A3402.A1193;
if( A1948 & 0x10"
13D3I3"783"
12D55I3"784"
61D3I3"3:
"
8D10I8"1948 & 2"
20D3I3"785"
12D31I19"786;
A1785: A1371 ="
37D20
26D3I41"6:
if( A1948 & 8 ) goto A1787;
goto A1788"
8D29I42"87: A1372 = A2835;
A1788:
if( A1948 & 1 ) "
36D49I5"889;
"
56D5I50"890;
A1889: A1369 = A2835;
A1890:
if( A1948 & 4 ) "
12D44I5"891;
"
51D3I34"892;
A1891: A1370 = A2835;
A1892: "
12D56I28"893;
A1784:
if( A1948 & 2 ) "
63D40I5"894;
"
47D5I50"895;
A1894: A1363 = A2835;
A1895:
if( A1948 & 8 ) "
12D23I5"896;
"
30D18I3"897"
23D33I25"96: A1364 = A2835;
A1897:"
40D3I7"948 & 1"
13D3I3"898"
12D10I32"899;
A1898: A1361 = A2835;
A1899"
17D3I8"1948 & 4"
14D2I2"00"
12D2I2"01"
7D70I37"00: A1362 = A2835;
A1901: ;
A1893: ;
"
78D4I29"02;
A1782: if( A3402.A1195 ) "
12D2I14"03;
goto A1904"
7D9I30"03: A1409( A3402.A1195, A2835 "
14D5I5"904: "
10D39I47"02: ;
A1780: ;
A1777: ;
}
A1772:
A1721:
A1716:
"
46D5I49"711;
case 'b':
if( A1731[1] && A1731[1] != 'v' ) "
13D2I14"05;
goto A1906"
7D53I11"05: A1418()"
58D4I4"06:
"
9D9I7"3495 > "
19D4I4"1907"
12D56I56"1908;
A1907: A5063( A1656, (A9)(A15)(A1731[1]) );
A1908:"
63D27I38"1711;
case 'c':
if( !*++A1731 && A1317"
36D4I4"1909"
12D18I18"1910;
A1909: A2948"
23D66I25" goto A1711;
A1910:
A459("
71D24I2"87"
29D43I4"986("
48D5I31"1, A3512, A3513 );
if( A1875 ) "
11D11I23"1911;
goto A1912;
A1911"
17D27I4"A656"
36D4I4"1913"
12D76I5"1914;"
81D7I42"3: A5316 = A1076( A1344, A1731 ); 
A1914:
"
14D6I11" A1875;
if("
11D6I1"2"
15D4I4"1915"
12D75I4"1916"
81D8I7"5:
A472"
13D6I50"1510();
A1916:
A1440( (A4) 1 );
if( A1211 == 11 ) "
13D74I5"917;
"
80D4I50"1918;
A1917:
A1439( &A3449, "asm", (A4) 1, A3466 )"
12D4I53"1919;
A1918: if( A1211 == 20 ) goto A2330;
goto A2331"
9D67I67"30:
A1439( &A3449, "cinclude", (A4) 1, A3466 );
goto A2332;
A2331: "
73D32I8"211 == 2"
43D2I2"33"
12D2I2"34"
7D36I92"33:
A1233 = 1;
A1232 = 1;
A972( &A3450, "once", 7 );
A972( &A3450, "message", 8 );
A1732 = 1"
41D10I13"37:
if( A1835"
15D3I34"490[A1732]) goto A2335;
goto A2336"
8D2I30"38: A1732++;
goto A2337;
A2335"
8D15I27"(strcmp(A1835, "clr") == 0)"
26D1I1"3"
12D1I1"4"
7D38I33"39:
A8738 |= (A17) 0x1;
A2340: ;
"
46D14I2"38"
19D40I4"36: "
45D43I18"34:
A2332:
A1919:
"
49D13I8"211 == 2"
19D31I7"211 == "
43D2I2"41"
12D2I2"42"
7D40I54"41:
A1638 |= 0x200;
lnt_option( "+e1942", 0 );
A2342: "
50D2I18"43;
A1912: A1418()"
7D8I35"43:
goto A1711;
case 'f':
++A1731;
"
15D11I34" A1433( A1731, A1209, A1210 );
if("
18D10
20D2I2"44"
12D2I2"45"
7D62I36"44:
{
UFLAG A3515;
A3515 = A3495 ? *"
68I35"+ A3495 : (UFLAG) A3491;
if( A1749 "
6D2I21"305 || A1749 == &A130"
14D2I2"46"
12D2I2"47"
7D17I24"46: A522( A1749, A3515 )"
27D2I2"48"
7D8I5"47: *"
15I26" A3515;
A2348:
if( A1749 ="
6D1I1"9"
13D2I2"49"
12D2I2"50"
7D13I38"49:
A1731 += 2;
if( isdigit(*A1731) ) "
21D2I14"51;
goto A2352"
7D26I30"51: A1399 = (A6) A985(A1731);
"
34D14I2"53"
19D22I24"52: A1399 = 0;
A2353: ;
"
30D14I2"54"
19D24I64"50: if( A1749 == &A1243 || A1749 == &A1290 || A1749 == &A1244 ) "
32D2I14"55;
goto A2356"
7D23I52"55:
A413 = A502();
A5393( "char", A413 );
goto A2357"
28D4I67"56: if( A1749 == &A1300 || A1749 == &A1301 ) goto A2358;
goto A2359"
9D4I49"58:
A8504();
A5393( "wchar_t", A414 );
goto A2360"
9D4I48"59: if( A1749 == &A1246 ) goto A2361;
goto A2362"
10D3I28"1: A427 = (A4) 1;
goto A2363"
9D3I47"2: if( A1749 == &A1276 ) goto A2364;
goto A2365"
8D4I23"64: A2131();
goto A2366"
9D8I26"65: if( A1749 == &A5867 ) "
16D2I14"67;
goto A2368"
7D20I22"67:
if( (A5867 > 0) ) "
26D34I6"2369;
"
40D85I33"2370;
A2369: A3356[28] |= 0x400;
"
91D27I99"2371;
A2370: A3356[28] &= ~0x400;
A2371: ;
A2368: ;
A2366: ;
A2363: ;
A2360: ;
A2357: ;
A2354: ;
}
"
33D4I39"2372;
A2345: A1418();
A2372:
goto A1711"
12D31I21"h':
if( (A1270 > 0) )"
38D5I63"1711;
A459();
A1376 = 0;
A1730 = 0;
A3517:
switch( *++A1731 )
{"
12D3I26"s':
A1376 = 1; goto A3517;"
10D21I13"S':
A1376 = 2"
41D1I11"a':
case 'A"
19D4I1"1"
24D1I11"b':
case 'B"
16D4I5"&= ~1"
24D1I1"c"
19D1I4"0x40"
21D11I1"f"
29D1I1"4"
21D11I1"F"
29D4I1"2"
24D1I11"r':
case 'R"
19D4I13"8; goto A3517"
12D25I34"e':
case 'E':
A7188.A1182 |= 0x80;"
32D25I16"3517;
case 'M':
"
37D29I19"|= 0x20;
case 'm':
"
34I2"++"
10D1I1"n"
14D1I1"4"
12D1I1"5"
7D1I1"4"
15D6I7"&= ~0x1"
18D1I1"6"
7D1I1"5"
18D1I1"c"
13D2I2"77"
12D2I2"78"
7D47I35"77: A7188.A1182 |= 0x40;
goto A2379"
52D19I9"78: if( *"
24D3I2" ="
20D1I1"0"
12D1I1"1"
7D8I30"0:
{
char A1736[75 + 1];
char "
13D25I11";
A1732 = 0"
31D11I33"2:if( (A1833 = *++A1731) != '/' )"
21I12"3;
goto A238"
7D1I1"3"
7D11I6"!A1833"
23D23I3"5;
"
32D13I1"6"
19D20I30"5: A1418(); goto A2384;
A2386:"
27D10I9"732 == 75"
22D3I23"4;
if( A1833 == '\\' ) "
11D2I14"87;
goto A2388"
8D3I3"7:
"
11D37I13"*++A1731;
if("
43D2I10" == 's' ) "
11D1I13"9;
goto A2390"
7D1I30"9: A1833 = ' ';
A2390: ;
A2388"
14D21I3"++]"
26D12I24"833;
goto A2382;
A2384:
"
17D2I14"[A1732] = '\0'"
14I37"5 = A1076( A1344, A1736 );
A7188.A118"
8936D2I17"g' && (A8947 > 0)"
35D1I1"
"
9D37
42D50I2"00"
75D8
13D1I7" == '*'"
34D20I103" A2552 = (0x01|0x02|0x20|0x08|0x400|0x10|0x40|0x800|0x1000|0x2000|0x4000|0x80|0x8000|0x20000|0x40000);
"
33D37I24"2656: if( isdigit(A1868)"
71D8I31"if( A1400 & 0x04 ) goto A2660;
"
14D1I26"= (A68) A985( A1731 );
if("
8D51I2") "
60D1I13"1;
goto A2662"
6D11I57"61:
A1401 = A8450 ? A8450 : 1;
A2552 = 0x02 | 0x01 | 0x04"
17D2I25"2: ;
A2660: ;
goto A2663;"
7D1I17"9: A1418();
A2663"
7D1I1"7"
6D2I2"54"
7D2I2"51"
8D1I1"8"
6D2I2"43"
7D2I2"40"
8D1I1"7"
6D2I2"34"
7D2I2"31"
8D1I1"7"
6D2I2"14"
7D2I2"11"
8I14"8:
A2605:
A260"
155D1I1"4"
12D1I1"5"
7D1I1"4"
184D1I1"8"
30D1I1"6"
12D1I1"7"
7D1I1"9"
21D1I1"8"
7D1I1"6"
41D1I1"9"
7D1I1"7"
493D2I2"70"
12D2I2"71"
7D2I2"70"
70D2I2"72"
13D1I1"3"
6D2I2"72"
23D1I1"3"
10D2I2"71"
22D1I1"5"
112D1I1"4"
12D1I1"5"
7D1I1"4"
30D1I1"5"
63D1I1"6"
12D1I1"7"
7D1I1"6"
27D1I1"7"
38D3I13"(size_t)( 8 )"
71D1I1"8"
12D1I1"9"
7D1I1"8"
30D2I2"80"
12D2I2"81"
7D2I2"80"
55D2I2"82"
59D1I1"3"
12D1I1"4"
7D1I1"3"
20D2I2"82"
8D1I1"4"
32D1I1"5"
12D1I1"6"
7D1I1"5"
11I7"((A72) "
13I1")"
39D1I1"7"
12D1I1"8"
7D1I1"7"
44D1I1"8"
9D1I1"6"
10D2I2"81"
73D1I1"9"
11D2I2"90"
8D1I1"9"
22D2I2"90"
14D2I2"91"
8D1I1"9"
48D2I2"92"
41D1I1"5"
12D1I1"6"
7D1I1"5"
23D1I1"6"
22D1I1"7"
41D1I1"8"
12D1I1"9"
7D1I1"8"
21D1I1"7"
7D1I1"9"
45D3I3"700"
12D10I10"701;
A2700"
31D3I3"701"
54D3I3"702"
14D8I8"3;
A2702"
28D1I1"3"
9D1I1"3"
22D2I2"92"
8D1I1"4"
10D2I2"91"
125D1I1"4"
12D1I1"5"
7D1I1"4"
38D1I1"5"
34D1I1"6"
12D1I1"7"
7D1I1"6"
30D1I1"7"
25D1I1"8"
12D1I1"9"
7D1I1"8"
97D1I1"9"
87D2I2"10"
12D2I2"11"
7D2I2"10"
62D2I2"12"
13D1I1"3"
6D2I2"12"
55D1I1"4"
7D1I1"3"
8D1I1"4"
12D1I1"5"
6D2I2"11"
87D1I1"6"
12D1I1"7"
7D1I1"6"
55D1I1"8"
7D1I1"7"
8D1I1"8"
9D1I1"5"
97D1I1"9"
11D2I2"20"
8D1I1"9"
29D2I2"20"
31D2I2"21"
12D2I2"22"
7D2I2"21"
31D1I1"3"
12D1I1"4"
7D1I1"3"
62D1I1"5"
7D1I1"4"
25D1I1"5"
14D1I1"6"
6D2I2"22"
67D1I1"7"
12D1I1"8"
7D1I1"7"
28D1I1"8"
59D1I1"6"
142D1I1"9"
11D2I2"30"
8D1I1"9"
65D2I2"31"
12D2I2"32"
7D2I2"31"
16D2I2"32"
30D1I1"3"
6D2I2"30"
65D1I1"4"
12D1I1"5"
7D1I1"4"
66D1I1"6"
12D1I1"7"
7D1I1"6"
16D1I1"7"
23D1I1"8"
7D1I1"5"
16D1I1"8"
7D1I1"3"
1263D23I31"Void
A9101( A9103, A9104, A9102"
33D11I27"9103;
A5794 A9104;
A4 A9102"
16I239"81 A4906;
A81 A80;
A4906 = A213( A1388, A9103, 2 );
A80 = A213( A1388, A9104, 2 );
A1449( A80, A4906->A169 );
if( A9102 ) goto A1711;
goto A1712;
A1711: A80->A127 |= (A27) 0x800;
A1712: ;
}
A17
A9043( A1850, A1851 )
A5794 A1850, A1851;
{
A"
882I9"(size_t)("
14I1")"
1497D2I4"9070"
1888D50I342"A9150 const A9194[] =
{
37270, 13067, 928,
32794,
4172,
2138,
13347,
32992,
33565,
657,
13251,
10690,
47504,
2802,
47220,
44051,
58,
12465,
301,
39868,
15313,
41391,
9092,
33614,
47660,
15409,
45812,
5155,
11199,
1069,
39897,
2757,
33171,
47376,
14641,
222,
14949,
4633,
10940,
4979,
0
};
A9150 A9195[(sizeof(A9194) / sizeof(A9194[0]))] = {0}"
56D27I41"9181;
A4
A9184( A2847 )
A9150 A2847;
{
A7"
32D26I20"2 = 0;
A9150 A9196;
"
31D2I30":if( A9196 = A9195[A1732++] ) "
14D52
70D21I37"
if( A9196 == A2847 ) return (A4) 1;
"
30D13I1"1"
19D57I3"3:
"
63D67I121" (A4) 0;
}
Void
A9183( A1835 )
A5794 A1835;
{
static int A9197 = 0;
A9150 A9196, A1868;
A6 A1837 = (A6) A985( A1835 );
A7"
72D11I74"2 = 0;
A7 A9198 = (A7) (sizeof(A9194) / sizeof(A9194[0]));
A9181 = (A4) 1;"
16D40I43"A9197 > 10 ) return;
A9196 = A9178( A1837 )"
45D32I3"11:"
38D8I20"868 = A9194[A1732++]"
19D2I2"12"
12D2I2"13"
7D38I4"12:
"
44D9I12"868 == A9196"
20D2I2"14"
12D2I2"15"
7D17I31"14:
if( A9184( A1868 ) ) return"
22D3I7"32 = 0;"
8D11I6"0:
if("
16D13I11"2 < A9198-1"
23D45I14"16;
goto A1717"
50D16I13"21: A1732++;
"
24D14I2"20"
19D50I24"16:
if( !A9195[A1732] ) "
58D2I14"22;
goto A1723"
10D8I33"
A9195[A1732] = A1868;
goto A1717"
13D4I68"23: ;
goto A1721;
A1717:
return;
A1715: ;
goto A1711;
A1713:
++A9197"
15D59I43"405(A1737)
A48 A1737;
{
A7 *A5410;
A7 A1730"
66D6I13"556 = (A4) 0;"
11D7I41"strncmp( A1737, "C++",(size_t)( 3 )) == 0"
41D21I55"A3556 = (A4) 1; A5410 = &A5407; A1737 += 3; 
goto A1713"
29D10I18" if( *A1737 == 'C'"
22D1I1"4"
12D1I1"5"
7D25I28"4: A5410 = &A5406; A1737++; "
35D1I1"6"
7D26I20"5: A1418(); return; "
31D1I530"6:
A1713:
if( *A1737 == '=' ) goto A1717;
goto A1720;
A1717: A1737++;
A1720:
if( isdigit(*A1737) ) goto A1721;
goto A1722;
A1721:
A1730 = (A7) A985( A1737 );
if( A1730 < 70 ) goto A1723;
goto A1725;
A1723: A1730 += 2000;
goto A1726;
A1725: if( A1730 < 100 ) goto A1727;
goto A1766;
A1727: A1730 += 1900;
A1766:
A1726:
*A5410 = A1730;
if( A3556 ) goto A1767;
A6050 = ( *A5410 < 1999 ) ? A5899 : A5900;
A1767:
if( A1212 ) goto A1768;
goto A1769;
A1768: A5895 = (A1309 > 0) ? A6051 : A6050;
A1769: ;
goto A1770;
A1722: A1418();
A1770"
7I275"Void
A5548( A3489, A2067, A3491 )
struct A144 **A3489;
A5794 A2067;
A4 A3491;
{
if( !*A3489 ) goto A1711;
goto A1712;
A1711: *A3489 = A999( 4, 0 );
A1712:
if( A3491 ) goto A1713;
goto A1714;
A1713: A997( *A3489, A2067 );
goto A1715;
A1714: A2104( *A3489, A2067 );
A1715: ;
}
"
Fa11.c
209D4I7"7 A9235"
18D2I1"9"
12I16"A6 A10;
typedef "
291D20
27D4I8"32 A9069"
14I19"A9069 A24;
typedef "
10D4I2"25"
14D9I13"unsigned A890"
21D6I10"9069 A9150"
17D6I10"9069 A9070"
17D8I8"9070 A27"
18D12I9"A9070 A28"
22I21"A9070 A5793;
typedef "
10D4I2"29"
14D17
26D8I5"A6228"
19D6I8"9070 A30"
25D3I8"long A31"
13I17"A17 A32;
typedef "
11D1I1"3"
11D7I12"unsigned A34"
19D5I5"4 A35"
17D5I5"5 A36"
21D1I1"7"
17D1I1"8"
16D2I2"39"
18D1I1"0"
17D1I1"1"
17D1I1"2"
12D6I6"34 A43"
22D1I1"4"
17D1I1"5"
11D7I7"A42 A46"
17I17"int A47;
typedef "
342D2I4"9236"
17D4I2"63"
19D1I3"577"
18D1I1"4"
16D4I2"65"
20D2I2"19"
18D4I4"8258"
14I19"A54 A7616;
typedef "
138D6I3"A16"
60D13I3"A72"
122D6I5"A9069"
20D6I5"A9069"
1373I69"struct A9304
{
A17 A9305;
A5794 A9306;
};
extern struct A9304 A9307;
"
6D4I4"9308"
14D4I4"9309"
17D1I1"5"
11D4I4"5566"
14D4I4"5567"
14D3I17"7618();
Void A761"
8D13
19D3I17"5569();
Void A915"
8D9I10"Void A9152"
14D17I2"74"
22D1I15"0();
Void A7621"
10I41"6226();
A5794 A6227();
A81 A7622();
A58 A"
460D2I4"9070"
28D2I4"9070"
151I19"struct A114 A9153;
"
1389D2I2"92"
16D6I12"5794 A7637()"
15I16"A4 A202;
extern "
3337D2I4"9070"
159I11"A58 A9238; "
88D2I4"9070"
39D2I4"9070"
367I11"A17 A9071;
"
535I13"A9236 A9239;
"
1098D2I4"9070"
380D7I8"17 A9154"
24D1I1"1"
12D6I7"62 A442"
16I17"A4 A443 ;
extern "
150D3I4"9072"
14D10I9"Void A451"
22D9I9"5794 A452"
21D9I9"9036 A453"
29D1I1"4"
13D12
20D1I1"5"
12D9I22"A315 A456 ;
A5794 A457"
28D1I1"8"
18D4I3"459"
21D3I4"5268"
14D16
24D1I1"0"
12I16"A4 A461;
extern "
8D1I1"2"
12D8I11"Void A463()"
22D4I3"464"
13I18"A58 A8823;
extern "
1037D7I10"Void A9155"
18D9I7"A4 A504"
20I20"Void A505();
extern "
1042D2I4"9070"
1940D8I19"struct A640 * A9310"
24D4I3"663"
15D10I9"A48 A7505"
29D2I2"37"
19D3I4"7176"
14D7I9"Void A664"
22D4I3"665"
16D8I7"4 A4442"
19D6I6"A17 A5"
27D3I2"66"
21D2I3"031"
21D1I1"7"
20D1I1"8"
12I20"Void A669();
extern "
278D3I4"4476"
14D10I17"struct A640 *A675"
27D4I4"7719"
21D4I4"8914"
15D8I12"Void A7720()"
18D7I7"17 A933"
18D8I7"7 A5254"
18D2I2"81"
7D1I1"0"
11D2I2"17"
7D1I1"1"
11D1I2"35"
6D1I1"2"
11D1I2"92"
6D1I1"3"
11D2I1"7"
7D1I1"4"
11D8I7"4 A2145"
18D1I2"68"
6D1I1"6"
13D14I6"*A2147"
24D8I7"4 A2148"
18D7I16"2 A2149[M_TOKEN]"
17D2I2"87"
7D1I1"0"
11D2I1"4"
7D1I1"1"
15D4I4"2152"
14D2I2"36"
7D1I1"3"
11D27I7"35 A826"
38D1I2"17"
6D3I1"4"
13D10I28"7
A2155,
A2156,
A2157,
A6214"
19D4I2"A9"
9D1I1"8"
12D10I9"A17 A8825"
27D3I3"215"
15D3I4"Void"
8D1I1"0"
18D4I4"8209"
23D1I1"1"
12D3I4"Void"
8D1I1"2"
12D10I9"A35 A2163"
29D1I1"4"
12D5I4"Void"
10D1I1"0"
12D9I8"A35 A216"
22D7I10"9036 A8211"
24D4I4"5255"
15D4I2"A4"
9D11I16"6();
extern Void"
16I37"7();
extern Void A2168();
struct A216"
465I42"struct A9073
{
A48 A9074;
A9069 A9075;
};
"
422D6I7"8 A9076"
17D9I8"A42 A982"
20D8I9"long A983"
24D4I3"984"
16D8I8"87 A6039"
20D8I8"61 A7724"
19D9I9"A92 A7260"
20D8I9"long A985"
24D4I3"986"
16D9I8"34 A5670"
20I21"A5794 A987();
extern "
1045I7"9129,
A"
44D4I4"9156"
11I42"9157,
A9158,
A9159,
A9160,
A9161,
A8639,
A"
21D10I2"91"
15D2I2"91"
7I29"9164,
A6176, 
A7062,
A7063,
A"
91I21"9240,
A9241,
A9130,
A"
21I28"9165,
A9166,
A9167,
A9168,
A"
28I14"9292,
A9169,
A"
92I42"9242,
A9243,
A9131,
A9132,
A9133,
A9134,
A"
71I7"9170,
A"
307D4I4"9171"
21I42"9244();
extern Void A8266();
extern Void A"
8I80"extern Void A9172();
extern A4 A9173();
extern A4 A9174();
extern Void A9175();
"
746D9I7"4 A9176"
21D7I9"5794 A868"
19D6I6"7 A598"
25D1I1"0"
19D1I1"1"
13D10I7"61 A872"
22D7I10"5794 A6037"
19D10I7"61 A873"
22D7I10"5794 A8589"
20D5I6"8 A874"
16D9I7"A4 A875"
28D1I1"6"
20D1I1"7"
20D1I1"8"
19D2I2"79"
19D4I3"880"
21D4I4"6172"
21D3I4"9293"
20D4I4"9177"
21D4I4"8787"
23D1I1"1"
20D1I2"29"
18D4I4"7262"
23D1I1"2"
20D1I1"3"
20D2I2"48"
21D1I1"4"
20D1I1"5"
18D3I4"5667"
22D1I1"6"
19D2I2"87"
20D2I2"88"
20D2I2"89"
19D4I3"890"
21D4I3"891"
21D4I3"892"
21D4I4"7745"
24D1I1"6"
21D1I1"7"
20I1"4"
18D3I4"7748"
20D4I4"7749"
21D4I3"893"
23D1I1"4"
18D4I4"1857"
22D3I3"958"
22D1I1"5"
19D3I3"061"
20D3I4"5821"
20D4I3"896"
21D3I4"7507"
20D4I3"897"
21D4I4"5981"
23D1I1"8"
19D3I3"750"
20D3I4"8212"
20D3I3"899"
20D3I4"7177"
22D1I1"0"
18D4I3"901"
23D1I1"2"
20D1I1"3"
18D3I4"8944"
22D1I1"4"
18D4I3"905"
21D3I3"907"
21D4I4"9078"
23D1I1"7"
18D3I4"5077"
20D3I4"8267"
20D3I4"8830"
14D7I9"Void A908"
25D2I2"09"
13D9I9"Void A910"
28D1I1"1"
12D9I7"A4 A912"
20D16
24D1I1"3"
14D8I7"4 A5431"
19D11I9"Void A914"
22D10I9"Void A915"
22D11I6"7 A916"
27D2I2"17"
13D9I10"A5794 A918"
27D3I4"1739"
15D6I9"5794 A919"
24D4I3"920"
15D9I9"Void A921"
26D4I3"922"
15D20I14"A5794 A923();
"
31D4I3"924"
16D7I10"5794 A7263"
19D8I8"61 A5668"
19D7I12"Void A5669()"
16D18
26D13I12"7734 A7751; "
21D7I7"4 A7752"
18D18I10"A4 A5914()"
28D6I10"861 A926()"
16D8I6"4 A927"
18D6I8"4 A928()"
15D9I19"struct A849 *A929()"
19D6I9"61 A930()"
16D8I12"9236 A9245()"
18D6I12"9236 A9246()"
15D9I12"Void A9247()"
18D7I18"struct A144 *A5050"
17D8I6"7 A931"
18D6I8"61 *A932"
16D8I6"7 A933"
21D7I7"*A934;
"
14D18I7"A7 A935"
28D7I8"61 *A936"
16D18I7"A7 A937"
27D18I9"A61 *A938"
27D18I7"A7 A939"
28D9I8"61 *A940"
19D9I6"7 A941"
19D9I8"61 *A942"
19D12I10"61 A6038; "
19D11I18"struct A144 *A1696"
23D8I5" A943"
18D10I7"7 A9294"
19D11I18"struct A144 *A7178"
20D17
26D7I8"44 *A717"
17D7I18"struct A144 *A5432"
17D6I9"5794 A944"
15D17I10"A5794 A945"
26D20I12"A5794 A946;
"
27D4I5"A5794"
9D3I1"4"
19D6I4"7180"
15D12I11"A5794 A7227"
21D12I11"A5794 A7181"
22D7I10"5794 A5510"
17D8I7"68 A948"
17D18
26D10I9"114 *A949"
20D7I6"7 A950"
17D7I6"4 A951"
16D10I17"struct A114 *A952"
19D13I20"struct A144 *A7265; "
27D3I3"266"
15D7I10"5794 A1689"
24D4I4"7753"
15D18I10"Void A7754"
30D10I7"6 A1022"
20D10I8"81 A5511"
19D12I9"A81 A8770"
21D12I18"struct A561 *A1023"
21D12I8"A4 A1024"
22D10I7"7 A1025"
19D18I8"A4 A1026"
29D18I9"A49 A1027"
29D10I9"Void A775"
22D10I8"A4 A1028"
27D15I8"1029();
"
21D4I31"9079();
A48 A9080();
Void A9081"
15D21
38D1I1"0"
13D7I8"17 A1031"
18D18I9"A79 A1032"
35D4I4"5671"
15D8I10"Void A5672"
19D9I10"Void A8401"
21D8I8"17 A5512"
19D10I18"struct A561 *A1033"
21D9I10"Void A9135"
20D9I18"struct A561 *A1034"
21D7I10"5794 A1035"
18D47I10"Void A2317"
58D9I10"Void A5673"
20D9I10"Void A1036"
20D9I10"Void A1037"
20D11I18"struct A561 *A1038"
22D8I6"A4 A56"
21D9I18"struct A561 *A1039"
20D11I10"Void A7182"
22D18I10"A4 A7183()"
27D10I9"A58 A8268"
22D7I28"78 A1040();
extern Void A775"
12D6I49"extern A81 A1041();
extern A81 A7508();
extern A4"
11D3I49"7();
extern A5794 A8590();
struct A7758 *A7759();"
12D51I3"0()"
60D18I11"A78 A1042()"
28D8I10"78 A5271()"
18D8I10"78 A1043()"
18D8I12"5972 A1044()"
17D9I12"Void A2274()"
18D17I42"A54 A5433();
extern A9036 A9039();
extern "
26D106I9"44 *A5434"
116D7I12"9150 A9178()"
16D13I32"Void A7761();
extern A48 A7906()"
23D31I63"7758
{
A40 A7762;
A87 A7763, A7764;
A17 A7765, A7766;
A67 A7767"
43D21
29D11I10"7758 A7768"
20D79I9"A87 A7769"
88D12I9"A87 A7770"
21D12I9"A88 A7771"
21D12I9"A10 A7772"
21D43I17"const A88 A7773;
"
52D19I43"045
{
A18 A1046;
A72 A1047;
A7470 A1048;
A3"
24D2I58"49;
};
struct A1050
{
A18 A1051;
A17 A1052;
A5794 A1053;
}"
12D7I7"7 A3140"
17D34I14"81 A3143[20];
"
43D9I33"054
{
A54 A1055;
A55 A1056[25];
}"
19D8I9"55 *A3164"
19D11I19"struct A1054 *A7509"
20D78
86D209I12"144 *A7774;
"
217D10I51"7500
{
struct A7500 *A7775; A54 A7510; A42 A7511; }"
19D9I12"Void A1057()"
18D8I12"Void A1058()"
17D9I10"Void A1059"
20D8I10"Void A1060"
19D10I11"A5794 A1061"
21D22I18"struct A118 *A1062"
33D13I8" A1063;
"
20D13I8"A4 A7267"
26D4I4"7776"
14D10I8"63 A7777"
19D21
29D3I3"114"
8D2I2"64"
11I40"A81 A7512();
extern A49 A1073();
extern "
8D2I66"74();
extern A72 A1075[];
extern A9036 A1076();
extern A9036 A7778"
14D94I118"3097
{
A70 A3098; A72 A3099; A7468 A3100; A7468 A3101; A72 A3102; A72 A3103; A72 A3104; A7 A3105; A4 A3106; A7 A5282; "
100D5I85"283; A32 A5284; A74 A5966; A17 A6270; };
extern A81 A3107;
extern A315 A3108;
extern "
13D55I62"3097 A3109;
extern A58 A3110;
extern A4 A6067;
extern A72 A311"
60D10I14"extern A6 A311"
15D45
52D11I14"Void A1077();
"
19D7I21"48 strcat(), strcpy()"
17D9I14"48 strncpy(); "
16D11I13"int strncmp()"
24D4I4"1078"
15D8I7"2 A7268"
27D2I2"79"
13D12I18"struct A553 *A1080"
21I17"A7 A9295;
extern "
6D67I3"108"
72I66"struct A553
{
struct A553 *A1082;
A7 A1083;
struct A114 A1084;
};
"
15D81I1"8"
86D75I59"struct A5513
{
A81 A5514;
struct A147 *A5515;
};
A5972 A777"
80D39I10"A5972 A778"
44D17I10"A5972 A778"
22D16I10"A5972 A778"
21D16I10"A5972 A778"
21D16I10"A5972 A778"
21I15"A5972 A7785();
"
7D14I11"A74 A6242; "
21D12I8"A7 A1086"
21D12I8"A7 A7184"
21D12I11"A5794 A5248"
25D6I4"7185"
15D10I10"A95 *A1087"
27D4I4"1088"
21D4I4"1089"
21D4I4"7186"
21D3I3"109"
21D4I4"7187"
15D10I11"A5794 A1091"
21D9I10"Void A1092"
27D3I3"093"
20D4I4"8269"
20D3I3"094"
14D10I8"A4 A1095"
21D10I8"A4 A1096"
28D3I3"097"
20D4I4"1098"
16D10I7"4 A1099"
21D10I11"A94 * A5272"
21D9I10"A94 * A110"
21D10I11"A94 * A1101"
29D2I2"02"
19D4I4"1103"
15D11I10"Void A1104"
30D2I2"05"
21D2I2"06"
19D4I4"5675"
21D4I4"6243"
15D10I8"A4 A5518"
27D4I4"7786"
21D4I4"5516"
21D4I4"5517"
21D4I4"5519"
22D3I3"520"
14D18I12"Void A5521()"
27D17
23D4I4"5522"
15D10I9"A23 A7787"
21D8I10"Void A1107"
19D10I10"Void A1108"
22D10I7"4 A1109"
21D11I10"Void A1110"
22D11I10"Void A1111"
22D11I10"Void A1112"
22I21"Void A2942();
extern "
7D4I4"1113"
15D55I12"Void A2949()"
64D13I12"Void A7070()"
22D9I12"Void A1114()"
18D10I12"Void A1115()"
19D9I12"Void A7269()"
19D8I12"94 * A1116()"
17D9I12"Void A1117()"
18D18I12"Void A1118()"
27D18I12"Void A1119()"
27D26I12"Void A7788()"
35D8I12"Void A5676()"
17D18
26D2I2"20"
21D2I2"21"
21D2I2"22"
13D9I10"Void A8270"
26D4I4"5249"
15D10I18"struct A144 *A5523"
19I17"A7 A5822;
extern "
6D4I4"7789"
21D4I4"7790"
19D4I4"7791"
15D10I10"A94 *A7792"
21D10I11"A5794 A7793"
22D7I10"5794 A7794"
19D7I10"5794 A7795"
18D10I11"A5794 A7796"
22D8I10"5794 A7797"
20D2I4"5794"
7D3I45"8();
struct A5304 { A77 A3049; A5794 A1148; }"
12D12I13"A2 A1123[100]"
21D12I9"A17 A1124"
21D12I10"A13 *A1125"
21D12I9"A81 A1126"
23D9I7"8 A1127"
19D1I1"5"
6D4I2"28"
13D11I18"struct A144 *A1129"
20D11I18"struct A144 *A1130"
20D11I26"const struct A5304 A3050[]"
21D10I7"4 A1131"
20D17I8"38 A1132"
26D45I9"Void A113"
65D1I1"3"
21D1I1"3"
13D9I8"A17 A113"
29D1I1"3"
13D10I8"A4 A2979"
29D1I1"3"
19D3I3"917"
23D2I2"39"
13I19"A4 A1140();
extern "
8D1I1"4"
6D124I231"extern Void A5529();
extern A4 A5530();
extern A7 A5532();
extern Void A5533();
extern A66 A5534();
extern A66 A7799();
extern Void A5531();
extern Void A1142();
extern Void A1143();
extern Void A1144();
extern A50 A1145();
extern "
131D339I15"46();
extern A7"
344D13I118"47();
extern A48 A1148();
extern A48 A1149();
extern A77 A1150();
extern A58 *A5067, *A5068;
extern A17 *A8945, *A8946"
22D4I6"8271()"
15D5I193"53();
extern Void A1154();
extern Void A1155();
extern Void A1156();
extern Void A1157();
extern Void A5823();
extern Void A1158();
extern Void A1159();
extern Void A1160();
extern Void A1161()"
15D4I4"8402"
15D19
25D4I75"8403; A54 A8404; A13 *A8405; A7468 A8406; A72 A8407; A58 *A8408;
A58 *A8409"
19D52I1"6"
57D1I1"7"
6D56I4"63;
"
61D10I229"
A7132,
A7133,
A1164,
A1165,
A1166,
A1167,
A1168,
A1169,
A1170,
A1171,
A1172,
A1173;
A13 A1174[ (2000 / CHARLEN) ];
A18 A5435;
A17 A6040;
A13 A7800[ (2000 / CHARLEN) ];
A61 A6041;
A17 A6042;
} ;
extern A13 A9180[(2000 / CHARLEN)]"
20D4I4"9248"
14D88I6"9249; "
95D17I17"9296; A17 A9250; "
24D6I6"9251; "
13D6I19"9297; FILE *A9252; "
16D9I18"struct A9248 A9253"
18D127I14"Void A9254();
"
135D27I104"391
{
struct A633 *A1175;
struct A144 *A1176;
struct A144 *A1177;
struct A144 *A1178;
};
struct A1179
{
"
32D262I91"180;
A53 A1181;
A17 A1182;
A53 A1183;
A5794 A1184;
A5794 A1185;
};
struct A1186
{
struct A8"
267D31I5"187;
"
40D27
33D12I8"188;
};
"
21D18I6"189
{
"
26D71I105"640 *A1190;
A5794 A1191;
};
struct A1192
{
A17 A1193;
A9 A1194;
A70 A1195;
};
struct A1196 { A2 A1197[3];"
77I833" *A1198; };
struct A1199
{
A5794 A1200;
A35 A1201;
A42 A1202;
};
Void A1203();
Void A1204();
Void A1205();
struct A5677
{
A5794 A5678;
A42 A5679;
A5794 A5680;
A5794 A5681;
};
extern A17 A6244;
extern long A7418;
extern A49 *A1206;
extern A49 *A1207;
extern A2 A1208[ARG_LEN];
extern A42 A8197; extern A2 A3496[ARG_LEN];
extern struct A1196 A1209[];
extern const A6 A1210;
extern A7 A5406;
extern A7 A5407;
extern A7 A6210;
extern A42 A1211;
extern A4 A1212;
extern A72 A1213;
extern A72 A1214;
extern A18 A1215;
extern A18 A1216;
extern A4 A7228;
extern A61 A1217;
extern A61 A1218;
extern A67 A1219;
extern A13 *A6043;
extern A13 *A1220;
extern A13 *A1221;
extern struct A1162 A1222;
extern struct A144 *A1223;
extern struct A144 *A1224;
extern struct A144 *A1225;
extern A48 A1226;
extern A7 A1227;
extern A9070 A1228;
extern UFLAG"
1095I7"9298,
A"
2534D19
33D4I4"9255"
14D7I9"2 A7190[]"
16D8I18"struct A144 *A1398"
21D4I4"1399"
14D8I7"4 A7807"
18D7I6"7 A621"
21D7I6"9181; "
15I1"1"
6D1I1"0"
11D1I2"68"
6D1I1"1"
11D1I1"4"
6D1I2"2 "
11D1I1"7"
6D1I1"3"
10D4I2"A7"
9D3I1"4"
12D4I2"A7"
9D3I1"5"
12D4I2"A4"
9D3I1"6"
12D9I10"Void A1407"
20D9I10"Void A1408"
26D4I4"1409"
17D6I7"8 A1410"
17D10I9"A58 A1411"
21D8I10"Void A8257"
19D10I8"A4 A8411"
27D4I4"5063"
15D4I2"A6"
9D1I1"2"
12D2I4"Void"
7D1I1"3"
18D4I4"1414"
21D4I4"1415"
15D10I8"A4 A1416"
21D19I10"Void A5687"
36D4I4"5688"
15D10I10"Void A5689"
21D10I19"struct A5677 *A5690"
30D1I1"7"
12D10I10"A13 *A5396"
21D10I9"Void A141"
28D4I4"1419"
21D4I4"6052"
15D10I11"A5794 A7808"
30D1I1"4"
18D4I4"5545"
21D4I4"5546"
15D8I10"Void A5547"
19D2I4"Void"
7D1I1"0"
12D2I4"Void"
7D25I1"1"
36D9I7"A4 A624"
21D9I9"A48 A9182"
20D9I8"A4 A1422"
20D4I2"A4"
9D12I5"3();
"
26D5I6" A1424"
16D10I12"Void A3500()"
19D8I10"Void A1425"
19D8I9"int A3493"
19D10I9"int A3494"
27D4I4"1426"
15D10I19"struct A1189 *A1427"
21D12I10"A13 *A8273"
22D7I6"4 A599"
19D9I7"A4 A599"
21D8I10"Void A9311"
27D2I2"28"
13D12I10"Void A7191"
31D2I2"29"
13D8I10"Void A6080"
25D4I4"9183"
15D10I9"A54 A1430"
21D1I1"V"
6D4I4"1431"
15D10I8"A4 A7475"
30D1I1"2"
12D9I12"UFLAG *A1433"
29D1I1"4"
12D10I8"A4 A1435"
29D2I2"36"
13D1I1"v"
6D4I4"6246"
15D1I1"v"
6D4I4"7809"
21D4I4"1437"
23D2I2"38"
14D10I10"34 A5691()"
19D20
28D2I2"39"
19D4I4"1440"
15D10I12"Void A1441()"
19D17
26D1I1"2"
21D1I1"3"
12D11I10"Void A5773"
30D2I2"44"
13D12I11"A5794 A1445"
21I20"A5794 A1446;
extern "
6D4I4"1447"
21D4I4"3532"
15D12I10"A2 A3526[]"
21I17"A4 A3527;
extern "
6D2I2"14"
21D4I4"1449"
15D10I11"A5794 A1450"
30D1I1"1"
18D4I4"1452"
15D10I8"A4 A9184"
27D4I4"5274"
21D73I6"1453()"
82D19I12"Void A5651()"
28D20I12"Void A5548()"
29D20
26D4I130"3443();
extern Void A6072();
extern Void A1454();
extern Void A3363();
extern Void A1455();
extern Void A1456();
extern Void A5107"
17D89I65"065
{
A67 A1066;
A5794 A1067;
A5794 *A1068;
A17 A1069;
};
extern "
97D44I20"1065 *A1070;
extern "
52D40I53"1065 A1071[];
extern A67 A1072[];
extern Void A6209()"
53D12I85"
{
A79 A547;
A79 A548;
A79 A549;
A79 A6232;
A79 A5661;
A87 A6233;
A87 A5662;
A23 A552"
23D16I24"53 *A554, *A555, *A6234,"
21D1I12"63, *A557;
}"
11D29I14"93
{
A17 A8274"
34D35I21"98 A8275;
A8198 A8276"
50D44I10"8277[1];
}"
54D41I6"561
{
"
56D4I165"62;
struct A561 *A563;
A40 A564;
A40 A565;
A81 A566;
A58 A567;
A42 A568;
A68 A569;
struct A147 A570;
A17 A571;
A24 A572;
A61 A573;
A96 *A574;
struct A1537 * A7443;
}"
13D11I8"A81 A575"
20D9I17"struct A561 *A576"
28D1I1"7"
18D2I1"5"
22D2I2"79"
19D3I4"8278"
22D1I1"0"
20D1I1"1"
19D3I2"82"
22D9I1"3"
20D7I10"Void A5664"
18D19
27I65"4(), A585();
extern A4 A586();
extern A4 A5665();
extern Void A58"
1854I50"9136
{
struct A9136 *A9137; A17 A9138; };
struct A"
109D9I19"struct A9136 *A9139"
18D18
26D9I10"9136 A9140"
19D9I8"58 A7273"
18D4I3"A17"
9D3I1"4"
12D11I17"struct A588 A1719"
20D4I2"A2"
9D3I3"6[]"
20D2I2"77"
13D10I9"A89 A1978"
29D2I2"79"
19D4I4"1980"
21D4I4"7274"
24D1I1"1"
13D8I7"4 A9185"
19D18I8"A4 A9186"
35D4I4"5897"
24D1I1"2"
12D3I4"Void"
8D1I1"3"
12D10I9"A72 A1984"
21D10I18"struct A561 *A1985"
27D3I3"914"
23D2I2"86"
21D2I2"87"
13D27
33D26I4"9142"
37D10I9"A78 A1988"
27D4I4"1990"
21D4I4"1989"
21D4I4"1991"
15D8I10"Void A1992"
25D4I4"1993"
15I27"struct A144 *A7824; extern "
6D4I26"5553();
struct A147 *A7825"
23D2I2"26"
19D4I4"7827"
21D64I6"7828()"
73D8I10"Void A7829"
20D7I7"4 A7830"
18D9I12"Void A8412()"
18D9I12"Void A7831()"
18D9I12"Void A7832()"
18D19I12"Void A8413()"
28I14"Void A8414();
"
8D20I7"1457
{
"
26D12I4"58;
"
18D3I25"59;
A4 A1460;
A9 A1461;
}"
12D19I10"A9 A1461()"
28D18I10"A9 A1462()"
28D1I1"9"
6D1I1"3"
11D19I8"A4 A1464"
30D9I7"4 A1465"
19D20
28D11I10"83 **A5078"
21D9I18"struct A83 **A5079"
25D2I2"66"
13D9I7"4 A1467"
19D3I11"struct A144"
8D2I2"68"
12D11I18"struct A144 *A7476"
21D9I7"4 A1469"
19D10I19"struct A640 **A3651"
20D9I18"struct A640 **A365"
21D8I9"17 *A1470"
19D8I9"68 *A1471"
26D13I14"640 **A1472 ;
"
22D7I7"3 A1473"
18D11I7"4 A1474"
22D7I9"13 *A1475"
18D7I9"13 *A1476"
18D7I9"13 *A1477"
18D4I2"53"
9D2I2"78"
13D2I2"68"
7D2I2"79"
12D9I3"A17"
15D1I1"0"
12D1I2"57"
6D1I1"1"
11I19"A57 A3660 ;
extern "
17D3I4"5 ; "
11D10I8"57 A1482"
22D6I10"036 *A1483"
17D10I7"4 A1484"
20D18I8"A4 A8214"
29D8I7"4 A1485"
19D7I11"9036 *A1486"
18D7I9"81 *A1487"
17D8I16"const A81 *A1488"
19D7I7"6 A1489"
25D11I10"144 *A7276"
21D4I4"9036"
9D1I1"0"
11D17I8"A9 A1491"
27I21"A9036 A1492 ;
extern "
8D9I10"640 *A1493"
19D17I9"A63 A1494"
27D17I8"A4 A1495"
28D8I7"4 A1496"
22D4I4"5825"
18D4I5"1497 "
21D8I9"640 *A149"
19D12I12"A5794 A1499 "
21D12I18"struct A83 *A1500 "
21D10I18"struct A83 *A1501 "
19D13I18"struct A83 *A1502 "
22D10I18"struct A83 *A5080 "
20D9I9"53 A1503 "
18D12I9"A4 A1504 "
21D12I8"A4 A6247"
21I27"struct A83 *A6248 ;
extern "
6D4I4"9040"
23D2I2"05"
14D7I7"4 A1506"
18D10I11"A5794 A1507"
21D9I10"Void A7451"
20D10I8"A4 A7833"
22D8I7"4 A6249"
25D4I4"6250"
23D2I2"08"
13D8I10"Void A1509"
28D1I1"0"
12D4I2"A6"
9D1I1"1"
21D1I1"2"
12D10I9"A68 A1513"
21D7I9"Void A151"
20I203"81 A5692();
extern Void A8215();
extern Void A1515();
extern A4 A1516();
extern Void A1517();
extern Void A1518();
extern Void A1519();
extern Void A1520();
extern A4 A3738();
extern A4 A7834();
extern A"
561D1I1" "
11D1I1" "
11D1I1" "
10D1I1" "
10D1I1" "
10D1I1" "
848D4I4"9082"
15D19I10"Void A9083"
30D19I10"Void A9084"
30I21"Void A3863();
extern "
17D2I2"89"
13D10I19"struct A1537 *A1590"
21D10I19"struct A1537 *A1591"
27D2I2"71"
21D4I4"1592"
21D4I4"1593"
15D9I10"Void A7841"
29D1I1"2"
12D4I3"A74"
9D1I1"7"
18D4I4"7843"
21D4I4"8218"
15D9I10"Void A8219"
29D1I1"5"
13I1"7"
6D1I1"6"
12D3I4"Void"
8D1I1"7"
12D10I8"A4 A7848"
21D10I9"A74 A7849"
21D1I1"V"
8D24I4"94()"
33D9I4"void"
14D1I3"1()"
10D4I4"void"
9D9I17"2();
typedef A22*"
14I57"3;
extern const A51 A1524;
extern long A1525;
struct A152"
1445D10I8"A4 A9085"
27D4I4"3763"
15D9I10"Void A8835"
21D2I2"35"
7D1I3"4()"
10D11I3"A58"
16D1I1"5"
10D2I11"struct A147"
7D3I1"6"
12I19"A4 A3767();
extern "
2788D2I4"9070"
433D8I10"Void A9086"
19D9I9"A74 A9087"
28D1I1"6"
12D8I9"Void A737"
19D9I8"A4 A4551"
20D9I9"Void A738"
25D3I4"4724"
14D10I8"A58 A741"
29D1I2"77"
20D1I1"3"
18D4I3"744"
15I21"Void A8202();
extern "
1326D1I1" "
15D1I1" "
11D1I1" "
2390D2I4"9070"
215D2I4"9070"
12D1I2"72"
52D4I4"9088"
2169I1"("
6D2I5" 0x0)"
363D2I4"9070"
14I45"A13 A9180[ (2000 / CHARLEN) ] = { (A13) 0 };
"
3009I20"9255;
struct A144 *A"
250D2I2"10"
2460I6"(A72) "
16I6"(A72) "
1965D2I2"39"
4028I35""__address_specifier", 189, 0 },
{ "
249D1I1"3"
13D10I8"A6 A5222"
28D1I1"3"
13D7I8"34 A5064"
19D8I8"46 A3531"
21D7I6" A8096"
18D19
61I19"extern A4 A9266();
"
1370I8"(A7470) "
3476D6I9"(size_t)("
18I1")"
1975I6"(A72) "
3500D2I3"036"
5998D6I3" ++"
11D9I1";"
16D21
1622D7
470I23"9255 = A999( 80, 0 );
A"
1904I6"(A72) "
258I6"(A72) "
230I6"(A72) "
250I6"(A72) "
208I6"(A72) "
218I6"(A72) "
698I16"A9139 = &A9140;
"
3831D8I163"struct A9248 A9253 =
{
"mm/",
"+fdi -imm -ffn --ffn -libdir(mm)",
(A17) 0x01|(A17) 0x04,
NULL,
NULL,
NULL
} ;
enum A9267 { A9268, A9269, A9270, A9271 };
Void
A9272"
13D45I16"FILE *A1948;
if("
50D46I15"8 = A9253.A9252"
80D54I7"fclose("
59D38I3"8 )"
44D29I121"2:
A9253.A9252 = NULL;
}
enum A9267
A9273( A1737 )
A5794 A1737;
{
A5794 A9274;
enum A9267 A1868;
A5794 A3195;
A5794 A1334"
35D3I4"*A17"
9D1I60"'@' ) return A9271;
A9274 = A7634( &A1737, ' ' );
if( !A9274"
13D1I1"1"
12D1I1"2"
7D12I28"1: A1868 = A9268;
goto A1713"
18D5I47"2: if( (strcmp( A9274, "module" ) == 0) ) goto "
10D2I12";
goto A1715"
8D303I28"4: A1868 = A9269;
goto A1716"
308D9I65"15: if( (strcmp( A9274, "header" ) == 0) ) goto A1717;
goto A1720"
14D6I29"17: A1868 = A9270;
goto A1721"
11I36"20: A1868 = A9268;
A1721:
A1716:
A17"
8D13I7"!A1868 "
23D2I2"22"
12D2I2"23"
7D23I153"22:
A884( 164, "A line was found that starts with a \"@\" but is " "neither a \"@@\" comment nor a \"@module\" nor a \"@header\" command" );
return A1868"
28D7I70"23:
A9272(); 
A1725:if( *A1737 == ' ' ) goto A1726;
goto A1727;
A1726:"
12D68I4"7++;"
77D14I2"25"
19D62I8"27: A239"
68D7I11"7 ); A7172("
12D47I29"7, ':' ); A9253.A9297 = A9237"
53D11I34"7 );
if( A9253.A9250 & (A17) 0x01 "
21D2I2"66"
12D2I2"67"
7D2I42"66: {
A7 A1732;
A9 A1833;
A1732 = 0;
A1770"
10D20I29"833 = (A9)(A15)(A1737[A1732])"
30D2I2"68"
12D2I2"69"
7D2I2"71"
7D17I4"32++"
27D2I2"70"
7D29I94"68:
if( ((islower(A1833) || isupper(A1833)) || isdigit(A1833) || (A1833)=='_') || A1833 == '.'"
40D2I2"72"
13D1I1"9"
6D24I4"72: "
34D2I2"71"
8D35I15"9:
if( A1833 ) "
43D2I14"73;
goto A1774"
7D64I110"73: A1334 = A866(
"character '$s' (hex code $x) is not permitted in a file name",
A975(A1833), (A5794) &A1833,"
69I112" );
A884( 164, A1334 );
A9253.A9250 |= (A17) 0x02;
A9253.A9252 = NULL;
A9253.A9251 = "bad attempt";
return A9271"
6D4I6"4: ;
}"
9D42I27"7:
A3195 = A7633( A9253.A92"
47D39I68"1737, NULL );
A9253.A9251 = A3195;
A9253.A9252 = fopen( A3195, "w" )"
45D23I12"!A9253.A9252"
34D2I2"75"
12D2I2"76"
7D45I146"75:
A1334 = A866( "file \"$s\" could not be opened for writing",
A3195, NULL, NULL );
A884( 164, A1334 );
A9253.A9250 |= (A17) 0x02;
A1868 = A9271"
50D7I54"76:
return A1868;
}
Void
A9254(A1835)
A48 A1835;
{
A48"
12D34I36"8[20];
A48 A3557;
A6 A1730;
A9 A1833"
39D45I23" A1836;
A5972 A3491 = 0"
50D84I20"30 = A994( A1748, 19"
89D3I47"35, 0 ); A3557 = A1748[0]; if( !A3557 ) return;"
8D46I26"3 = (A9)(A15)(*A3557); if("
51D103I8"3 == '-'"
138D11I17"3557++; A3491 = -"
30D40I2"2:"
46D19I11"1833 == '+'"
31D1I1"4"
12D1I1"5"
7D1I36"4: A3557++; A3491 = 1; 
A1715:
A1713"
7D27I10"A1730 == 1"
38D2I2"16"
12D2I2"17"
7I81"16: A1836 = 0;
if( (strcmp( A3557, "secure" ) == 0) ) goto A1720;
goto A1721;
A17"
5D4I4"1836"
9D21I10"17) 0x01;
"
29D2I2"22"
11D1I39"if( (strcmp( A3557, "options" ) == 0) )"
11D10I3"3;
"
18D2I2"25"
8D5I23"3: A1836 = (A17) 0x04;
"
13D2I2"26"
7D14I36"25: A1418();
A1726:
A1722:
if( A1836"
26D1I1"7"
11D2I2"66"
8D1I1"7"
8D52I34"3491 >= 0 ) goto A1767;
goto A1768"
57D4I36"67: A9253.A9250 |= A1836;
goto A1769"
9D18I20"68: A9253.A9250 &= ~"
23D3I20";
A1769: ;
A1766: ;
"
11D14I2"70"
19D9I85"17:
if( (strcmp( A3557, "prefix" ) == 0) ) goto A1771;
goto A1772;
A1771:
A9253.A9249"
28D3I6"748[1]"
10D75I76"72:
if( (strcmp( A3557, "options" ) == 0) ) goto A1773;
goto A1774;
A1773:
{"
84D85I30"737;
A9253.A9250 |= (A17) 0x04"
91D90I25"A3491 > 0 && A9253.A9296 "
100D2I2"75"
12D2I2"76"
7D34I3"75:"
39D9I60"7 = A866( "$s $s", A9253.A9296,
A1748[1], NULL );
goto A1777"
14D7I3"76:"
12D32I12"7 = A1748[1]"
37D3I31"77: A9253.A9296 = A1076( A1344,"
8D4I6"7 );
}"
13D2I2"78"
7D54I11"74: A1418()"
59D36I4"78: "
41D1I1"7"
6D125I19"}
Void
A9275(A1886)"
134D34I43"640 *A1886;
{
FILE *A1948;
enum A9267 A1868"
43D39I18"9276 = NULL;
A5794"
44D11I148"7;
A7 A9277 = 0; lnt_option( "-save", 0 ); A1415( A1886, (A4) 1 );
A7635( " " );
A9253.A9252 = NULL;
A9253.A9251 = NULL;
A9253.A9250 &= ~(A17) 0x02;"
17D19I23"9253.A9250 & (A17) 0x04"
31D1I1"1"
12D1I1"2"
7D1I74"1: A9276 = A9253.A9296;
A1712: if( A9266() ) goto A1713;
goto A1714;
A1713"
7D53I18"A1490[0] == '@' ) "
62I12"5;
goto A171"
9I71"
A1737 = A9237( A1490 );
A1868 = A9273( A1737+1 );
if( A1868 == A9269 )"
10D10I1"7"
20D2I2"20"
8D67I52"7:
A9276 = A7633( A9276, " ", A9253.A9297 );
A9277++"
72D10I16"20: ;
goto A1721"
16D1I1"6"
9D10I18"948 = A9253.A9252 "
20D2I2"22"
12D2I2"23"
7D11I25"22:
fputs( A1490, A1948 )"
21D2I2"25"
7D4I4"23: "
9D34I10"9253.A9251"
45D2I2"26"
12D2I2"27"
7D17I52"26:
goto A1766;
A1727:
A1737 = A9237( A1490 );
A239("
22D49I18"7 );
if( *A1737 ) "
57D2I14"67;
goto A1768"
7D59I185"67:
A884( 164, "an extraneous line was found that was not part " "of any subfile and not a @command or @@comment" );
A1768: ;
A1766: ;
A1725: ;
A1721: ;
goto A1712;
A1714:
A9272();
A927"
64D2I3"107"
7D45I75"344, A9276 );
A7636();
lnt_option( "-restore_", 0 ); A1415( A1886, (A4) 0 )"
52D2I278"9277 && !(A9253.A9250 & (A17) 0x02) ) goto A1769;
goto A1770;
A1769:
A3500( A9276 );
goto A1771;
A1770: if( !A9277 ) goto A1772;
goto A1773;
A1772:
A884( 164, "Warning - no valid @module command found" );
A1773: ;
A1771: ;
}
A4
A9266()
{
struct A640 *A1886;
A68 A1943;
if( !(A18"
8D20I21"1493) || !A1886->A641"
30D5I6"(A4) 0"
11D32I75"!sys_fgets( A1490, (unsigned) A1489, A1886->A641,
(int *) &A1886->A654 ) )
"
39D5I54"(A4) 0;
A1943 = ++A1886->A642;
A948 = 0;
A1492 = A1490"
12D31I60"1943 == 1 ) goto A1711;
goto A1712;
A1711: A7451(); 
A1712:
"
38D136I122"(A4) 1;
}
A7
A7229()
{
static A7 A7237 = 0;
static A7 A7488 = 0;
A81 A1942;
A5794 A4515;
if( A7237 == 0 && A7488++ < 10 ) "
148D32
41D131I3"2;
"
136D50I77":
if( (A1942 = A213( A1502, "_MSC_VER", 1 )) &&
(A4515 = A1942->A155.A142) ) "
59D98I1"3"
109D37I55"4;
A1713: A7237 = (A7) A985( A4515 );
if( A7237 == 0 ) "
46D23I1"5"
34D90I2"6;"
95D100I12"5: A7237 = 1"
105D10I4"16: "
16D5I36"4: ;
A1712:
return A7237;
}
A4
A7475"
11D40I6"0 )
A7"
45D51I52"0;
{
A7 A2070 = A7229();
return A2070 > 0 && A2070 <"
57D10I111"0 * 100;
}
Void
A7210()
{
A1230 = 1; A1308 = 0; A5538=1; ++A5395; A2779 = (A4) 1; A865(1235); }
UFLAG *
A1433( "
15D20I22", A2092, A2006 )
A5794"
26D31I57";
struct A1196 *A2092;
A7 A2006;
{
UFLAG *A1749;
A7 A1732"
36D23I9"49 = NULL"
28D2I13"32 = 0;
A1713"
8D35I13"A1732 < A2006"
45D1I1"1"
12D1I1"1"
7D3I35"14: ++A1732;
goto A1713;
A1711:
if("
9D25I67"[0] == A2092[A1732].A1197[0] &&
A1731[1] == A2092[A1732].A1197[1] )"
34D4I9"15;
goto "
9D20I64";
A1715:
A1749 = A2092[A1732].A1198;
A1716: ;
goto A1714;
A1712:"
26D79I10"1731[2] &&"
84D13I36"1[2] != ' ' ) goto A1717;
goto A1720"
18D15I2"17"
22D54I14"1731[2] == 'c'"
64D1I1"2"
12D1I1"2"
7D29I1"2"
40D17I17"9 == &A1222.A1169"
28D2I2"23"
12D2I2"25"
7D7I3"23:"
12D16I18"9 = &A1222.A1173;
"
24D2I2"26"
7D16I6"25: if"
21D4I43"49 == &A1222.A1171 ) goto A1727;
goto A1766"
9D40I24"27: A1749 = &A1222.A1172"
50D2I2"67"
7D72I36"66: A1749 = NULL;
A1767: ;
A1726: ;
"
80D14I2"68"
19D13I26"22: if( A1749 != &A1296 ) "
21D2I14"69;
goto A1770"
7D157I16"69: A1749 = NULL"
162D102I4"70: "
107D43I4"68: "
48D91I72"20:
return A1749;
}
A72
A3570( A1749, A2903 )
A17 A1749;
A4 A2903;
{
A72"
99D92I51"if( A1749 & (0x040 | 0x080) ) goto A1711;
goto A171"
99D12I39"1:
A2882 = A2903 ? A1358 : A1360;
goto "
17D2I169";
A1712: if( A1749 & 0x020 ) goto A1714;
goto A1715;
A1714:
A2882 = A2903 ? A1357 : A1359;
goto A1716;
A1715: A2882 = A2903 ? *A1348 : *A1347;
A1716:
A1713:
return A2882"
14D18I135"39( A2092, A1844, A1836, A3571 )
struct A196 *A2092;
A5794 A1844;
A4 A1836;
struct A1199 *A3571;
{
struct A1199 *A1731;
A4 A2009 = (A4)"
23D15I93"35 A2069 = 0;
A5794 A3572;
if( A1836 ) goto A1711;
goto A1712;
A1711: A1731 = A3571; goto A17"
20D26I157"1715: A1731++;
A1713: A2069 = A1731->A1201; if( A3572 = A1731->A1200 ) goto A1716;
goto A1717;
A1716: if( strcmp( A3572, A1844 ) == 0 ) goto A1720;
goto A172"
31D91I106"720: A2009 = (A4) 1; A1844 = A3572; goto A1714;
A1721: ; goto A1722;
A1717: goto A1714;
A1722: ; goto A171"
96D187I39"714: if( !A2009 ) goto A1723;
goto A172"
192D235I4"723:"
240D44I53"A986( A1844, (*A2092) .A956, (*A2092) .A957) ) return"
49D29I4"25: "
37D30I45"
if( !A2009 && A1836 ) goto A1726;
goto A1727"
35D33I9"26: A1844"
38D61I19"076( A1344, A1844 )"
66D19I267"27:
A972( A2092, A1844, A2069 );
}
Void
A1437( A1828, A3242, A2092, A3571 )
A5794 A1828, A3242;
struct A196 *A2092;
struct A1199 *A3571;
{
A34 A2086;
struct A5759 *A1731;
if( (A2086 = A986( A3242, (*A2092) .A956, (*A2092) .A957)) ||
(A2086 = A5064( A3242, A3571 ))
) "
28D1I13"1;
goto A1712"
7D29I31"1:
A1828 = A1076( A1344, A1828 "
35D131I18"31 = A5761;
A1715:"
136D20I12"A1731->A2860"
31D1I1"3"
11D2I2"14"
8D16I10"6: A1731++"
26D2I2"15"
7D31I54"13:
if( A1731->A5760 == A2086 ) goto A1717;
goto A1720"
36D89I55"17: A1731->A2861 = A1828; goto A1714;
A1720: ;
goto A17"
94D45I35"1714:
A972( A2092, A1828, A2086 );
"
54D13I1"1"
18D17I12"12: A1418();"
22D111I3"1: "
116D8I8"34
A5064"
13D32I60"41, A3571 )
A5794 A1741;
struct A1199 *A3571;
{
struct A1199"
38D11I30"1;
A5794 A3572;
A1731 = A3571;"
24D17I5"A1713"
23D1I1"1"
9D1I1"1"
7D30I20"A3572 = A1731->A1200"
42D1I1"4"
12D1I1"5"
7D15I58"4:
if( (strcmp( A3572, A1741 ) == 0) ) return A1731->A1201"
26D1I1"6"
7D39I2"5:"
49D1I10"2;
A1716: "
12D1I1"3"
7D27I67"2:
return 0;
}
Void
A1438( A3573 )
A42 A3573;
{
struct A1199 *A1731"
32D63I10"31 = A3465"
68D18I22"13:
if( A1731->A1200) "
26D2I14"11;
goto A1712"
7D26I13"14: A1731++;
"
34D14I2"13"
19D22I6"11:
if"
28D5I34"1->A1202 == A3573 || A3573 == 0 ) "
13D2I14"15;
goto A1716"
7D81I17"15:
A972( &A2253,"
86D16I18"1->A1200, (A3467 ?"
21D22I77"1->A1201 : 0) );
A1716: ;
goto A1714;
A1712: ;
}
A34
A5691(A1741)
A5794 A1741"
27D123I8"34 A2086"
130D121I61"2086 = A986( A1741, A2253 .A956, A2253 .A957) ) return A2086;"
127D44I44"2086 = A5670( A1741, A2256 ) ) return A2086;"
49D9I225"A2086 = A5670( A1741, A8200 ) ) return A2086;
if( A2086 = A5670( A1741, A3946 ) ) return A2086;
return A5064( A1741, A3465 );
}
Void
A1440(A1836)
A4 A1836;
{
A3467 = A1836;
switch( A1211 )
{
case 22:
A1438( 2 );
A1438( 22 );
"
18D1I33"1;
case 4:
A1438( 2 );
A1438( 4 )"
12D80I2"1;"
86D24I118"21:
A1438( 2 );
sys_option( "-rw(_interrupt)", 0 );
sys_option( "+rw(_export)", 0 );
sys_option( "+rw(_loadds)", 0 );
"
33D1I1"1"
8D24I43"2:
A1438( 2 );
A1438( 2 | 0 );
A1438( 2 );
"
33D1I1"1"
8D24I92"17:
A1438( 2 );
A1438( 17 );
sys_option( "-rw(_huge)", 0 );
sys_option( "+rw(inline)", 0 );
"
33D1I1"1"
8D24I29"20:
A1438( 2 );
A1438( 20 );
"
33D23I25"1;
case 23:
A1438( 23 );
"
32D25I44"1;
case 25:
sys_option( "+rw(__null)", 0 );
"
34D10I22"1;
default:
A1438( 2 )"
21D2I4"1;
}"
7D15I100"1: ;
}
Void
A1441( A2026, A1741 )
struct A1199 *A2026;
A5794 A1741;
{
struct A1199 *A1731;
A35 A3574"
20D4I19"31 = A2026;
A1713:
"
10D47I10"731->A1200"
57D1I1"1"
12D1I1"1"
7D26I12"14: A1731++;"
35D1I1"1"
7D58I5"11: ;"
67D14I2"14"
19D37I24"12:
A3574 = A1731->A1201"
42D4I19"31 = A2026;
A1717:
"
10D47I10"731->A1200"
57D2I2"15"
12D2I2"16"
7D26I12"20: A1731++;"
35D2I2"17"
7D56I42"15:
if( strcmp( A1731->A1200, A1741 ) == 0"
67D2I2"21"
12D2I2"22"
7D40I25"21: A1731->A1201 = A3574;"
45D10I10"2: ; goto "
15D38I212";
A1716: ;
}
Void
A1443()
{
if( A443 ) return;
A1407();
A5773();
A443 = (A4) 1;
}
Void
A5773()
{
A49 *A2098;
A54 A1732;
A315 A1742;
A1732=( 24);
A1713:
if( A2098 = ( A1398)->A988+ A1732, A1732 <= ( A1398)->A991 )"
47D26I4"11;
"
34D26I20"12;
A1714: A1732++;
"
34D25I38"13;
A1711:
if( A1742 = (A315) *A2098 )"
34D26I4"15;
"
34D25I34"16;
A1715:
if( A1742->A303 != 25 )"
34D53I15"14;
A1742->A305"
58D4I59"074( A1732 );
A1742->A304 = (A13) A4075( A1732 );
A1716: ;
"
12D25I78"14;
A1712: ;
}
Void
A1444( A1863, A2882 )
A70 A1863;
A72 A2882;
{
if( !A1863 )"
34D25I4"11;
"
33D24I20"12;
A1711: A1418();
"
32D24I99"13;
A1712:
( A7174 = (A1863), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) )->A30"
29D19I13"2882;
if( 1 <"
25D15I140"3 && A1863 <= 19 )
goto A1714;
goto A1715;
A1714:( A7174 = (A1863+1), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) )->A305"
21D92I10"82;
A1715:"
98D41I9"1863 == 3"
53D1I1"6"
12D1I1"7"
7D53I191"6:
( A7174 = (5), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) )->A305 = A2882;
( A7174 = (6), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) )->A305 = A2882"
59D44I10"7:
A1442()"
50D239I84"3: ;
}
Void
A1442()
{
A88 A6013 = 0;
A88 A6014 = ~A6013;
A88 A6015 = ~A226;
A87 A845"
244D295I98"374 = ( A7174 = (15), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) )->A305;
A137"
300D15I419" A7174 = (17), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) )->A305;
A6049 = ( A7174 = (19), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) )->A305;
A1375 = ( A7174 = (13), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) )->A305;
A1356 = ( A7174 = (3), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) )->A305;
A1307 = A1374 == A1373;
A1391 = A1390 * A1374"
21D85I22"(A10) A1391 >= A228 ) "
97D115
124D17I3"2;
"
22D3I28": A1394 = A6015;
goto A1713;"
8D90I32"2: A1394 = ~(A6014 << (A1391-1))"
95D71I49"13:
A1396 = ~(~A1394 << 1);
A1392 = A1390 * A1373"
77D17I19"(A10) A1392 >= A228"
29D1I1"4"
12D1I1"5"
7D14I28"4: A1395 = A6015;
goto A1716"
20D60I30"5: A1395 = ~(~0L << (A1392-1))"
66D24I24"6:
A5987 = ~(~A1395 << 1"
29D33I150"393 = A1390 * ( A7174 = (19), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) )->A305;
if( (A10) A1393 >= A228 ) goto A1717;
goto A1720"
38D10I29"17: A5988 = A6015;
goto A1721"
15D81I31"20: A5988 = ~(~0L << (A1393-1))"
86D60I136"21:
A5989 = ~(~A5988 << 1);
A293 = A6049 <= SZ_MAX_INT ? 20 :
A1373 <= SZ_MAX_INT ? 18 :
16;
A8451 = (A87) A226; if( (A88) A8451 != A226"
72D1I1"2"
12D1I1"3"
7D11I16"2: A882(200,1); "
16D2I157"3:
A1595[ 10 ].A299 = ((( 16-1)+(A7468) A1390 )/ A1390 );
A1595[ 12 ].A299 = ((( 32-1)+(A7468) A1390 )/ A1390 );
}
A46
A3531( A1737 )
A48 A1737;
{
A46 A2282;"
7D4
9D3I1"7"
8D36I3"\''"
47D2I2"11"
12D2I2"12"
7D18I11"11: A1737++"
23D2I2"12"
8D5
10D3I1"7"
8D1I1"r"
6D8
13D31I1"7"
36D12I71"R' ) goto A1713;
goto A1714;
A1713: A2282 = 0xFE;
goto A1715;
A1714: if"
19D39I11"7 == 't' ||"
45D18I8"7 == 'T'"
29D2I2"16"
12D2I2"17"
7D20I28"16: A2282 = 0xFC;
goto A1720"
25D22I41"17: if( *A1737 == 'f' || *A1737 == 'F' ) "
30D2I14"21;
goto A1722"
7D29I18"21: A2282 = 0xF8;
"
38D13I1"3"
19D32I25"2: if( isdigit(*A1737) ) "
40D2I14"25;
goto A1726"
7D30I43"25: A2282 = (A46) A985( A1737 );
goto A1727"
35D117I130"26: A1418(); A2282 = 0; 
A1727:
A1723:
A1720:
A1715:
return A2282;
}
A5794
A1450( A1737, A3575 )
A5794 A1737;
struct A1192 *A3575;"
122D15I216"7 A2858 = 1 | 2 | 4 | 8;
A9 A1868;
A70 A3576 = 0;
A9 A1956;
A1868 = (A9)(A15)( *++A1737 ); A1868 = tolower(A1868);
++A1737;
if( A1868 == 'm' ) goto A1711;
goto A1712;
A1711:
A2858 |= 0x10;
A1868 = (A9)(A15)( *A1737++"
21D18I19"868 = tolower(A1868"
23D126I4"712:"
131D6I12"A1868 == 'p'"
18D1I1"3"
12D1I1"4"
7D8I52"3:
if( *A1737 ) goto A1715;
goto A1716;
A1715:
A1956"
13D51I15"9)(A15)( *A1737"
57D34I68"956 = toupper(A1956);
switch( A1956 )
{
case 'D': A2858 &= ~(1 | 4);"
44D3I32"7;
case 'P': A2858 &= ~(2 | 8); "
12D19I32"7;
case 'F': A2858 &= ~(2 | 1); "
28D30I29"7;
case 'N': A2858 &= ~(8 | 4"
42D2I36"7;
default: A1956 = 0; goto A1717;
}"
7D22I1"7"
28D12I7"!A1956 "
23I9"6;
++A173"
11D2I2"13"
7D11I4"16: "
22D1I1"0"
7D63I3"4: "
70D17I46"68 == 'l' && (*A1737 == 'd' || *A1737 == 'D') "
28D1I1"1"
12D1I1"2"
7D11I25"1: A1868 = 'D'; ++A1737; "
21D1I1"3"
7D25I57"2: if( A1868 == 'l' && (*A1737 == 'l' || *A1737 == 'L') )"
35D1I13"5;
goto A1726"
9D40I34" A1868 = 'L'; ++A1737; 
goto A1727"
45D109I4"26: "
115D65I47"868 == 'l' && (*A1737 == 'c' || *A1737 == 'C') "
75D2I2"66"
12D2I2"67"
7D31I48"66: A1868 = 'w'; ++A1737; 
goto A1768;
A1767: if"
36D102I70"68 == 'b' && (*A1737 == 'o' || *A1737 == 'O') ) goto A1769;
goto A1770"
107D91I40"69: A1868 = 'o'; ++A1737; 
A1770:
A1768:"
96D376I1"7"
381D48I47"23:
A1720:
switch(A1868)
{
case 'c': A3576 = 3;"
57D4I26"71;
case 's': A3576 = 13; "
12D143I25"71;
case 'i': A3576 = 15;"
152D4I26"71;
case 'l': A3576 = 17; "
12D20I26"71;
case 'f': A3576 = 21; "
28D38I24"71;
case 'd': A3576 = 22"
48D15I26"71;
case 'D': A3576 = 23; "
23D35I27"71;
case 'w': A3576 = A414;"
44D4I26"71;
case 'L': A3576 = 19; "
12D78I24"71;
case 'o': A3576 = 1;"
87D4I24"71;
default: A3576 = 0; "
12D50I47"71;
}
A1771:
A3575->A1195 = A3576;
A3575->A1194"
55D254I1"8"
259D6I110"3575->A1193 = A2858;
return A1737;
}
Void
A3532( A3577, A2099, A3550 ) 
A48 A3577;
A5794 A2099;
A72 A3550; 
{
"
11D35I41"3577 - A3526 > 4 ) return;
if( A3550 == 0"
46D2I2"11"
12D2I2"12"
7D27I32"11:
*A3577 = '\0'; 
if( A3527 ) "
35D2I14"13;
goto A1714"
7D39I43"13: A3547( A3526, ((A72) strlen(A3526)) );
"
47D14I2"15"
19D22I52"14: A3551( A3526, ((A72) strlen(A3526)) );
A1715: ;
"
30D14I2"16"
19D25I84"12: if( (( *A2099 ) == '*' || (char)( *A2099 ) == aoc_star) ) goto A1717;
goto A1720"
30D22I81"17:
A3532( A3577, A2099+1, A3550-1 ); 
*A3577++='?';
A3532( A3577, A2099, A3550 )"
32D2I2"21"
7D137I4"20: "
142D9I70"( *A2099 ) == '?' || (char)( *A2099 ) == aoc_quest) || isdigit( *A2099"
21D2I2"22"
12D2I2"23"
7D16I52"22:
*A3577++ = *A2099++;
A3532( A3577, A2099, A3550-"
21D10I7"A1723: "
15D19I4"21: "
24D3I127"16: ;
}
Void
A6052( A1737, A2091 )
A13* A1737;
A5 A2091;
{static A13 A8097[ (2000 / CHARLEN) ];
A7471 A1883 = (2000 / CHARLEN);"
8D8I85"!A1222.A6040 ) return;
switch( A2091 )
{
case (A5) 1:
A5531( A8097 , A1737, A1883 );
"
16D2I117"11;
case (A5) 0:
A5533( A1737, A1222.A7800, A1883 );
A5529( A8097, A1222.A7800, A1883 );
A1144( A1737, A8097, A1883 )"
12D28I12"11;
default:"
37D15I100"11;
}
A1711: ;
}
Void
A1447( A2099, A2091, A3578, A5792 )
A5794 A2099;
A4 A2091; 
struct A322 *A3578"
20D6I97" A5792;
{
A5794 A1731;
A72 A3579 = 0;
A72 A3550 = 0; 
A4 A3580 = (A4) 1;
if( !A2099 || !*A2099 ) "
14D2I14"11;
goto A1712"
7D16I15"11: A2099 = "0""
21D29I30"12:
if( !A3578 && A5792 & (A17"
34I25"1 ) goto A1713;
goto A171"
6D41I26"13:
A6052( A3454, (A5) 1 )"
47D24I25"4:
A3525 = A3578;
A3527 ="
29D7I10"1;
A1731 ="
12D65I1"9"
70D60I89"15:if( *A1731 && !( *A1731 == '*' && *(A1731+1) == '/' ) ) goto A1716;
goto A1717;
A1716:"
65D72I51"!(( *A1731 ) == '*' || (char)( *A1731 ) == aoc_star"
84D2I2"20"
12D2I2"21"
7D27I19"20: A3579++;
A1721:"
34D33I50"( *A1731 ) == '?' || (char)( *A1731 ) == aoc_quest"
45D2I2"22"
12D2I2"23"
7D154I16"22: A3580 = (A4)"
161D61I2"23"
67D71I155"!((( *A1731 ) == '*' || (char)( *A1731 ) == aoc_star) || (( *A1731 ) == '?' || (char)( *A1731 ) == aoc_quest) || isdigit((A9)(A15)( *A1731 ))) || A3579 > 4"
83D1I1"5"
12D1I1"6"
7D33I19"5:
A1418(); 
return"
39D3I19"6:
A3550++;
A1731++"
23D34I48"
if( A3580 && A3550 < 4 ) goto A1727;
goto A1766"
39D39I64"27:
A3532( A3526, "*", (A72)1 );
goto A1767;
A1766: A3532(A3526,"
44D60I2"9,"
65D26I10"0);
A1767:"
31D32I28"!A3525 && A5792 & (A17) 0x01"
43D2I2"68"
12D2I2"69"
7D25I26"68:
A6052( A3454, (A5) 0 )"
30D40I206"69: ;
}
Void
A5224()
{
A1414( 4, 0, NULL );
A1013( A1398, A5097 );
A1013( A1389, A5223 );
A1013( A1129, A5223 );
A1013( A1326, A5222 );
}
Void
A1434()
{static A13 *A3581 = NULL;
A67 A1732, A1875;
if( !A3581"
52D1I1"1"
12D1I1"2"
7D24I66"1:
A3581 = (A13 *) A1670( (A72) ( (2000 / CHARLEN)), (A72) ( 1 ) )"
29D21I9"32 = 200;"
26D3I25"5:
if( A1732 < 400) goto "
8D213I2";
"
222D13I1"4"
19D27I10"6: A1732++"
38D1I1"5"
10D13I33"A1139( A3581, A1732 ); goto A1716"
22D6I19"A1732 = 1200;
A1721"
13D46I11"1732 < 1400"
57D1I1"7"
11D2I2"20"
7D13I23"22: A1732++;
goto A1721"
19D130I16"7: A1139( A3581,"
135D89I45"2 ); goto A1722;
A1720:
A1732 = 0;
A1726:
if("
94D257I1"5"
262D2I61"072[A1732]) goto A1723;
goto A1725;
A1727: A1732++;
goto A172"
7D61I18"723:
A1139( A3581,"
66D27I4"5 );"
36D14I2"27"
19D19I41"25:
A1143( A3581, (A7471)(2000 / CHARLEN)"
29D71I6"
A1144"
77D3I117"2.A1174, A3581, (A7471)(2000 / CHARLEN) );
}
A4
A1435(A1835)
A48 A1835;
{static A7 A3582 = 0;
if( A1227 >= 2 && A3582"
8D4I43"227 && A1423(A1835)
&& A8096( A1835, 'f' )
"
15D1I1"1"
12D1I1"2"
7D5I66"1:
A3582 = A1227;
A3500( A5045( A1835 ) );
A3500( "++fpx" );
A3500"
10D31I66"43 );
A3500( "-passlate" );
A3500( A1342 );
--A1285;
return (A4) 1"
37D10I89"2:
return (A4) 0;
}
A6
A5222(A3095)
A49 A3095;
{
struct A83 *A1724 = (struct A83 *) A3095"
15D12I198"24->A183.A163 &= ~(A30) 0x2000;
return 0;
}
A6
A5223(A5225)
A49 A5225;
{
A81 A80 = (A81) A5225;
A80->A163 &= ~(A30) 0x2000;
return 0;
}
Void
A1436(A1731)
A48 A1731;
{
A9070 A1709;
struct A640 *A1886"
18D10I49"!A8096( A1731, 'f' ) ) return;
A913();
if( !A1330"
21D2I2"11"
12D2I2"12"
7D8I29"11: A1498 = NULL;
A1712: A170"
13D144I50"A7)(A1331 - A1319) >= A1405 ? (A9070) 0x10000 : 0;"
150D9I28"1886 = A675( A1731, A1709 ) "
19D2I2"13"
12D2I2"14"
7D31I30"13:
A1709 = A1886->A645->A636;"
37D37I19"1709 & (A9070) 0x40"
48D2I2"15"
12D1I1"1"
7D24I9"15:
{
A67"
29D41I83"0;
A1309 = 1;
A2257( (A4) 1 );
A1517(NULL);
A390 = 0;
A1057( A1731, A1886, (A4) 1 )"
46D23I19"30 = 755;
A1721:
if"
29D12I10"0 <= 755) "
20D11I2"17"
22D1I1"0"
7D14I12"2: A1730++;
"
22D6I16"21;
A1717:
A1139"
12D8I17"2.A1174, A1730 );"
17D14I2"22"
19D2I25"20: ;
}
goto A1723;
A1716"
10D84I18"709 & (A9070) 0x80"
95D2I2"25"
12D2I2"26"
7D30I71"25:
{
struct A1189 *A1887;
A1886->A645->A636 |= (A9070) 0x04;
if( A1330"
41D2I2"27"
12D2I2"66"
7D11I29"27:
A1886->A652 |= (A17) 0x10"
16D53I125"66:
A1887 = A1427( A1886, NULL );
(*(((A49)*++ A1331 == ((A49) &A1525)) ? (A1521((A1523 *)& A1331), A1331) : A1331 ) = A1887 "
58D15I38"886->A642 = 1;
A1414( 6, 0, A1886 );
}"
24D2I2"67"
7D26I4"26: "
31D7I22"1709 & (A9070) 0x01 ) "
15D2I2"68"
12D2I2"69"
7D75I1"6"
80D38I14"417( A1886 );
"
47D12
18D46I2"69"
54D7I57"709 & ((A9070) 0x2000|(A9070) 0x20000|(A9070) 0x80000000)"
18D2I2"71"
12D2I2"72"
7D25I37"71:
A5107( A1886, A1709 );
goto A1773"
30D11I4"72: "
17D7I23"709 & (A9070) 0x2000000"
19D1I1"7"
12D1I1"7"
7D13I30"74:
A9275( A1886 );
goto A1776"
18D4I4"75: "
10D8I24"709 & (A9070) 0x40000000"
19D2I2"77"
12D2I2"78"
7D13I30"77:
A9309( A1886 );
goto A1779"
18D23I4"78: "
29D18I26"7)(A1331 - A1319) >= A1405"
30D1I1"0"
10D3I3"781"
9D20I71"0:
if( A1886->A641 ) goto A1782;
goto A1783;
A1782: fclose( A1886->A641"
26D101I25"783:
A1886->A641 = NULL;
"
108D14I25"784;
A1781:
A5772 = (A4) "
19D4I40"309 = 0;
A7419 = 0;
A1886->A652 |= 0x20;"
11D17I18"709 & (A9070) 0x02"
27D3I3"785"
12D73I48"786;
A1785: A1309 = 1;
A1786:
if( (A1309 > 0) ) "
80D3I75"787;
goto A1788;
A1787: A2257( (A4) 1 );
goto A1889;
A1788: A2257( (A4) 0 )"
8D110I2"89"
118D10I3"346"
22D1I1"0"
12D1I1"1"
7D15I43"0:
if( (A7419 > 0) ) goto A1892;
A498(A1886"
22D45I150"2: ;
goto A1893;
A1891: A1413(A1886);
A1893:
A1886->A645->A636 |= (A9070) 0x04;
A1784:
A1779:
A1776:
A1773:
A1770:
A1767:
A1723:
A1266 = 0;
A1714:
A91"
50D52I129"}
void
A6246( A2096 )
A48 A2096;
{
A9070 A1709;
struct A640 *A1886;
A913();
A7137();
A1498 = NULL;
A1709 = (A7)(A1331 - A1319) >="
57D2I682"5 ? (A9070) 0x10000 : (A9070) 0;
if( (A1886 = A675( A2096, A1709 )) &&
!A1140( A1475, (A66)(A52) A1886->A644 ) ) goto A1711;
goto A1712;
A1711:
A1415( A1886, (A4) 1 );
if( !(A1886->A645->A636 & (A9070) 0x40000) ) goto A1713;
goto A1714;
A1713: {
A34 A1859;
A1886->A645->A636 |= (A9070) 0x40000;
(void) ((A1463=(A9)(A15)(*A1492++)) ? ((A1463 == (A9)(A15)('\\'))?A1462():A1463) : A1461() );
A2154 = 0;
A1715:if( (A1859 = A2161()) != 1 ) goto A1716;
goto A1717;
A1716:
if( A1859 == 12 &&
!A986( A2149, A2253.A956,
A2253.A957) &&
!A6249( A2149 ) ) goto A1720;
goto A1721;
A1720:
(void) A213( A6248, A2149, 2 );
A1721: ;
goto A1715;
A1717: ;
}
A1714:
A1415( A1886, (A4) 0 );
A1712:
A913("
7I3640"A7 A7804 = 0;
Void
A7809( A2096, A302 )
A5794 A2096;
A5794 A302;
{
A7 A2948 = A7804; A5794 A3557 = A1076( A1344, A1226 );
if( (strcmp( A302, "options" ) == 0) ) goto A1711;
goto A1712;
A1711: A7804 = 2;
goto A1713;
A1712: if( (strcmp( A302, "modules" ) == 0) ) goto A1714;
goto A1715;
A1714: A7804 = 3;
goto A1716;
A1715: A1418(); return; 
A1716:
A1713:
A1426( A2096 ); A7804 = A2948; A1226 = (A48) A3557; }
A4
A8096( A1835, A2097 )
A5794 A1835;
A9 A2097;
{
switch( A7804 )
{
case 0: return (A4) 1;
case 1: return (A4) 0;
case 2:
if( A2097 == 'f' && A1423(A1835) ) goto A1712;
goto A1713;
A1712:
A7804 = 1;
return (A4) 0;
goto A1714;
A1713: return (A4) 1;
A1714:
case 3:
if( A2097 == 'o' ) return (A4) 0;
if( A1423(A1835) ) goto A1715;
goto A1716;
A1715:
A7804 = 0;
A1716:
return (A4) 1;
default: ;
A865(1236);
}
A1711:
return (A4) 0;
}
Void
sys_main(A3545,A3546)
int A3545;
A48 *A3546;
{register A48 A1731;
int A3236;
extern Void A3448();
extern Void A2078();
extern A6 A3583();
A18 A3584;
A57 A1871;
A5106 = 1;
A215();
sys_fnmap( dot_c, 'c' );
sys_fnmap( dot_h, 'c' );
sys_fnmap( dot_cpp, 'c' );
sys_fnmap( dot_cxx, 'c' );
sys_fnmap( dot_lnt, 'c' );
sys_fnmap( dot_lob, 'c' );
sys_fnmap( dot_lph, 'c' );
sys_fnmap( dot_vac, 'c' );
A3354();
A1662();
A1649 = A1656;
A1652 = A1656;
A1651 = A1656;
A1650 = A1656;
A7168 = A1656;
if( A1871 = A3544( A3545, A3546 ) ) goto A1711;
goto A1712;
A1711:
A5063( A1871, 0 );
A1712: A924( (A72)300 );
A3562();
A3520 = (A6) A3545;
A3521 = A3546;
A1713:if( A1227++ < A1337 ) goto A1714;
goto A1715;
A1714:
if( A1337 > 1 ) goto A1716;
goto A1717;
A1716: A5224();
A1717: A1410(0);
if( A1227 == 2 ) goto A1720;
goto A1721;
A1720:
A3519 = (struct A1162 *) A1073( (A41) 16 );
memcpy((A49)( A3519),(A49)( &A1222),(size_t)( sizeof(struct A1162) ));
A1721:
A1425();
A670();
A3236 = 1;
A1725:
if( A3236 <= 2) goto A1722;
goto A1723;
A1726: A3236++;
goto A1725;
A1722:
if( A3236 == 2 && A3545 <= 1 && A1227 == 1 ) goto A1727;
goto A1766;
A1727: A1420(1);
A1766:
if( A1731 = A1410(A3236) ) goto A1767;
goto A1768;
A1767:
A1498 = NULL;
A3528( A1731, A3236 );
goto A1766;
A1768: ;
goto A1726;
A1723:
if( A656 ) goto A1715;
if( A1227 == 1 ) goto A1769;
goto A1770;
A1769: if( A1337 > 1 || A912(974) || A5575 >= 1 || A5540 || A7806 || A7649 || A912(1960) || A912(960) || A912(961) || A8207 ) goto A1771;
goto A1772;
A1771: A5544();
A1772: if( !A7807 ) goto A1773;
goto A1774;
A1773:
A7786();
A1774:
if( A8207 ) goto A1775;
goto A1776;
A1775: A8208();
A1776: ;
A1770: ;
goto A1713;
A1715:
A1335 = 0;
A1336 = 0;
if( A3519 )
goto A1777;
goto A1778;
A1777:memcpy((A49)( &A1222),(A49)( A3519),(size_t)( sizeof(struct A1162) ));
A1778:
A1013( A1224, A3583 );
if( A1335 == 0 ) goto A1779;
goto A1780;
A1779:
A1341 = NULL;
A1340 = 0;
goto A1781;
A1780: if( A1335 > 1 ) goto A1782;
goto A1783;
A1782:
A1517(NULL);
A390 = 0;
A1783:
A1781:
if( A1336 == 0 ) goto A1784;
goto A1785;
A1784: A1280 = 1;
A1785:
if( A1376 == 1 ) goto A1786;
goto A1787;
A1786: A1376 = 0;
A1787:
A1377 = 3;
A458();
if( (A1313 > 0) || A1340 ) goto A1788;
goto A1889;
A1788:
A216( A431, A2078 );
A1889:
A216( A431, A1456 );
A216( A433, A3448 );
A1432();
A1160();
A7874();
A5566();
if( (A1313 > 0) ) goto A1890;
goto A1891;
A1890:
if( A1215 == 0 || A1406 ) goto A1892;
goto A1893;
A1892:
last_ext( A1332, ext_REP, dot_lob );
A1058( A1332, (A4) 1 );
goto A1894;
A1893: A7186( "\n--- Requested .lob file not produced because of messages and no -zero\n" , NULL);
A1894: ;
A1891:
if( A1400 & 0x80 ) goto A1895;
goto A1896;
A1895: A1448( 0, 0 );
A1896:
A3584 = A1215;
A882(900, (A6) A1215);
A7283();
A5651( A5650 + A1335 );
sys_exit( (int) A3584, (int) A1406 );
}
"
Fa12.c
209D4I7"7 A9235"
18D2I1"9"
12I16"A6 A10;
typedef "
291D20
27D4I8"32 A9069"
14I19"A9069 A24;
typedef "
10D4I2"25"
14D9I13"unsigned A890"
21D6I10"9069 A9150"
17D6I10"9069 A9070"
17D8I8"9070 A27"
18D12I9"A9070 A28"
22I21"A9070 A5793;
typedef "
10D4I2"29"
14D17
26D8I5"A6228"
19D6I8"9070 A30"
25D3I8"long A31"
13I17"A17 A32;
typedef "
11D1I1"3"
11D7I12"unsigned A34"
19D5I5"4 A35"
17D5I5"5 A36"
21D1I1"7"
17D1I1"8"
16D2I2"39"
18D1I1"0"
17D1I1"1"
17D1I1"2"
12D6I6"34 A43"
22D1I1"4"
17D1I1"5"
11D7I7"A42 A46"
17I17"int A47;
typedef "
342D2I4"9236"
17D4I2"63"
19D1I3"577"
18D1I1"4"
16D4I2"65"
20D2I2"19"
18D4I4"8258"
14I19"A54 A7616;
typedef "
138D6I3"A16"
60D13I3"A72"
122D6I5"A9069"
20D6I5"A9069"
1373I69"struct A9304
{
A17 A9305;
A5794 A9306;
};
extern struct A9304 A9307;
"
6D4I4"9308"
14D4I4"9309"
17D1I1"5"
11D4I4"5566"
14D4I4"5567"
14D3I17"7618();
Void A761"
8D13
19D3I17"5569();
Void A915"
8D9I10"Void A9152"
14D17I2"74"
22D1I15"0();
Void A7621"
10I41"6226();
A5794 A6227();
A81 A7622();
A58 A"
460D2I4"9070"
28D2I4"9070"
151I19"struct A114 A9153;
"
1389D2I2"92"
16D6I12"5794 A7637()"
15I16"A4 A202;
extern "
3337D2I4"9070"
159I11"A58 A9238; "
88D2I4"9070"
39D2I4"9070"
367I11"A17 A9071;
"
535I13"A9236 A9239;
"
1098D2I4"9070"
380D7I8"17 A9154"
24D1I1"1"
12D6I7"62 A442"
16I17"A4 A443 ;
extern "
150D3I4"9072"
14D10I9"Void A451"
22D9I9"5794 A452"
21D9I9"9036 A453"
29D1I1"4"
13D12
20D1I1"5"
12D9I22"A315 A456 ;
A5794 A457"
28D1I1"8"
18D4I3"459"
21D3I4"5268"
14D16
24D1I1"0"
12I16"A4 A461;
extern "
8D1I1"2"
12D8I11"Void A463()"
22D4I3"464"
13I18"A58 A8823;
extern "
1037D7I10"Void A9155"
18D9I7"A4 A504"
20I20"Void A505();
extern "
1042D2I4"9070"
1940D8I19"struct A640 * A9310"
24D4I3"663"
15D10I9"A48 A7505"
29D2I2"37"
19D3I4"7176"
14D7I9"Void A664"
22D4I3"665"
16D8I7"4 A4442"
19D6I6"A17 A5"
27D3I2"66"
21D2I3"031"
21D1I1"7"
20D1I1"8"
12I20"Void A669();
extern "
278D3I4"4476"
14D10I17"struct A640 *A675"
27D4I4"7719"
21D4I4"8914"
15D8I12"Void A7720()"
18D7I7"17 A933"
18D8I7"7 A5254"
18D2I2"81"
7D1I1"0"
11D2I2"17"
7D1I1"1"
11D1I2"35"
6D1I1"2"
11D1I2"92"
6D1I1"3"
11D2I1"7"
7D1I1"4"
11D8I7"4 A2145"
18D1I2"68"
6D1I1"6"
13D14I6"*A2147"
24D8I7"4 A2148"
18D7I16"2 A2149[M_TOKEN]"
17D2I2"87"
7D1I1"0"
11D2I1"4"
7D1I1"1"
15D4I4"2152"
14D2I2"36"
7D1I1"3"
11D27I7"35 A826"
38D1I2"17"
6D3I1"4"
13D10I28"7
A2155,
A2156,
A2157,
A6214"
19D4I2"A9"
9D1I1"8"
12D10I9"A17 A8825"
27D3I3"215"
15D3I4"Void"
8D1I1"0"
18D4I4"8209"
23D1I1"1"
12D3I4"Void"
8D1I1"2"
12D10I9"A35 A2163"
29D1I1"4"
12D5I4"Void"
10D1I1"0"
12D9I8"A35 A216"
22D7I10"9036 A8211"
24D4I4"5255"
15D4I2"A4"
9D11I16"6();
extern Void"
16I37"7();
extern Void A2168();
struct A216"
465I42"struct A9073
{
A48 A9074;
A9069 A9075;
};
"
422D6I7"8 A9076"
17D9I8"A42 A982"
20D8I9"long A983"
24D4I3"984"
16D8I8"87 A6039"
20D8I8"61 A7724"
19D9I9"A92 A7260"
20D8I9"long A985"
24D4I3"986"
16D9I8"34 A5670"
20I21"A5794 A987();
extern "
1045I7"9129,
A"
44D4I4"9156"
11I42"9157,
A9158,
A9159,
A9160,
A9161,
A8639,
A"
21D10I2"91"
15D2I2"91"
7I29"9164,
A6176, 
A7062,
A7063,
A"
91I21"9240,
A9241,
A9130,
A"
21I28"9165,
A9166,
A9167,
A9168,
A"
28I14"9292,
A9169,
A"
92I42"9242,
A9243,
A9131,
A9132,
A9133,
A9134,
A"
71I7"9170,
A"
307D4I4"9171"
21I42"9244();
extern Void A8266();
extern Void A"
8I80"extern Void A9172();
extern A4 A9173();
extern A4 A9174();
extern Void A9175();
"
746D9I7"4 A9176"
21D7I9"5794 A868"
19D6I6"7 A598"
25D1I1"0"
19D1I1"1"
13D10I7"61 A872"
22D7I10"5794 A6037"
19D10I7"61 A873"
22D7I10"5794 A8589"
20D5I6"8 A874"
16D9I7"A4 A875"
28D1I1"6"
20D1I1"7"
20D1I1"8"
19D2I2"79"
19D4I3"880"
21D4I4"6172"
21D3I4"9293"
20D4I4"9177"
21D4I4"8787"
23D1I1"1"
20D1I2"29"
18D4I4"7262"
23D1I1"2"
20D1I1"3"
20D2I2"48"
21D1I1"4"
20D1I1"5"
18D3I4"5667"
22D1I1"6"
19D2I2"87"
20D2I2"88"
20D2I2"89"
19D4I3"890"
21D4I3"891"
21D4I3"892"
21D4I4"7745"
24D1I1"6"
21D1I1"7"
20I1"4"
18D3I4"7748"
20D4I4"7749"
21D4I3"893"
23D1I1"4"
18D4I4"1857"
22D3I3"958"
22D1I1"5"
19D3I3"061"
20D3I4"5821"
20D4I3"896"
21D3I4"7507"
20D4I3"897"
21D4I4"5981"
23D1I1"8"
19D3I3"750"
20D3I4"8212"
20D3I3"899"
20D3I4"7177"
22D1I1"0"
18D4I3"901"
23D1I1"2"
20D1I1"3"
18D3I4"8944"
22D1I1"4"
18D4I3"905"
21D3I3"907"
21D4I4"9078"
23D1I1"7"
18D3I4"5077"
20D3I4"8267"
20D3I4"8830"
14D7I9"Void A908"
25D2I2"09"
13D9I9"Void A910"
28D1I1"1"
12D9I7"A4 A912"
20D16
24D1I1"3"
14D8I7"4 A5431"
19D11I9"Void A914"
22D10I9"Void A915"
22D11I6"7 A916"
27D2I2"17"
13D9I10"A5794 A918"
27D3I4"1739"
15D6I9"5794 A919"
24D4I3"920"
15D9I9"Void A921"
26D4I3"922"
15D20I14"A5794 A923();
"
31D4I3"924"
16D7I10"5794 A7263"
19D8I8"61 A5668"
19D7I12"Void A5669()"
16D18
26D13I12"7734 A7751; "
21D7I7"4 A7752"
18D18I10"A4 A5914()"
28D6I10"861 A926()"
16D8I6"4 A927"
18D6I8"4 A928()"
15D9I19"struct A849 *A929()"
19D6I9"61 A930()"
16D8I12"9236 A9245()"
18D6I12"9236 A9246()"
15D9I12"Void A9247()"
18D7I18"struct A144 *A5050"
17D8I6"7 A931"
18D6I8"61 *A932"
16D8I6"7 A933"
21D7I7"*A934;
"
14D18I7"A7 A935"
28D7I8"61 *A936"
16D18I7"A7 A937"
27D18I9"A61 *A938"
27D18I7"A7 A939"
28D9I8"61 *A940"
19D9I6"7 A941"
19D9I8"61 *A942"
19D12I10"61 A6038; "
19D11I18"struct A144 *A1696"
23D8I5" A943"
18D10I7"7 A9294"
19D11I18"struct A144 *A7178"
20D17
26D7I8"44 *A717"
17D7I18"struct A144 *A5432"
17D6I9"5794 A944"
15D17I10"A5794 A945"
26D20I12"A5794 A946;
"
27D4I5"A5794"
9D3I1"4"
19D6I4"7180"
15D12I11"A5794 A7227"
21D12I11"A5794 A7181"
22D7I10"5794 A5510"
17D8I7"68 A948"
17D18
26D10I9"114 *A949"
20D7I6"7 A950"
17D7I6"4 A951"
16D10I17"struct A114 *A952"
19D13I20"struct A144 *A7265; "
27D3I3"266"
15D7I10"5794 A1689"
24D4I4"7753"
15D18I10"Void A7754"
30D10I7"6 A1022"
20D10I8"81 A5511"
19D12I9"A81 A8770"
21D12I18"struct A561 *A1023"
21D12I8"A4 A1024"
22D10I7"7 A1025"
19D18I8"A4 A1026"
29D18I9"A49 A1027"
29D10I9"Void A775"
22D10I8"A4 A1028"
27D15I8"1029();
"
21D4I31"9079();
A48 A9080();
Void A9081"
15D21
38D1I1"0"
13D7I8"17 A1031"
18D18I9"A79 A1032"
35D4I4"5671"
15D8I10"Void A5672"
19D9I10"Void A8401"
21D8I8"17 A5512"
19D10I18"struct A561 *A1033"
21D9I10"Void A9135"
20D9I18"struct A561 *A1034"
21D7I10"5794 A1035"
18D47I10"Void A2317"
58D9I10"Void A5673"
20D9I10"Void A1036"
20D9I10"Void A1037"
20D11I18"struct A561 *A1038"
22D8I6"A4 A56"
21D9I18"struct A561 *A1039"
20D11I10"Void A7182"
22D18I10"A4 A7183()"
27D10I9"A58 A8268"
22D7I28"78 A1040();
extern Void A775"
12D6I49"extern A81 A1041();
extern A81 A7508();
extern A4"
11D3I49"7();
extern A5794 A8590();
struct A7758 *A7759();"
12D51I3"0()"
60D18I11"A78 A1042()"
28D8I10"78 A5271()"
18D8I10"78 A1043()"
18D8I12"5972 A1044()"
17D9I12"Void A2274()"
18D17I42"A54 A5433();
extern A9036 A9039();
extern "
26D106I9"44 *A5434"
116D7I12"9150 A9178()"
16D13I32"Void A7761();
extern A48 A7906()"
23D31I63"7758
{
A40 A7762;
A87 A7763, A7764;
A17 A7765, A7766;
A67 A7767"
43D21
29D11I10"7758 A7768"
20D79I9"A87 A7769"
88D12I9"A87 A7770"
21D12I9"A88 A7771"
21D12I9"A10 A7772"
21D43I17"const A88 A7773;
"
52D19I43"045
{
A18 A1046;
A72 A1047;
A7470 A1048;
A3"
24D2I58"49;
};
struct A1050
{
A18 A1051;
A17 A1052;
A5794 A1053;
}"
12D7I7"7 A3140"
17D34I14"81 A3143[20];
"
43D9I33"054
{
A54 A1055;
A55 A1056[25];
}"
19D8I9"55 *A3164"
19D11I19"struct A1054 *A7509"
20D78
86D209I12"144 *A7774;
"
217D10I51"7500
{
struct A7500 *A7775; A54 A7510; A42 A7511; }"
19D9I12"Void A1057()"
18D8I12"Void A1058()"
17D9I10"Void A1059"
20D8I10"Void A1060"
19D10I11"A5794 A1061"
21D22I18"struct A118 *A1062"
33D13I8" A1063;
"
20D13I8"A4 A7267"
26D4I4"7776"
14D10I8"63 A7777"
19D21
29D3I3"114"
8D2I2"64"
11I40"A81 A7512();
extern A49 A1073();
extern "
8D2I66"74();
extern A72 A1075[];
extern A9036 A1076();
extern A9036 A7778"
14D94I118"3097
{
A70 A3098; A72 A3099; A7468 A3100; A7468 A3101; A72 A3102; A72 A3103; A72 A3104; A7 A3105; A4 A3106; A7 A5282; "
100D5I85"283; A32 A5284; A74 A5966; A17 A6270; };
extern A81 A3107;
extern A315 A3108;
extern "
13D55I62"3097 A3109;
extern A58 A3110;
extern A4 A6067;
extern A72 A311"
60D10I14"extern A6 A311"
15D45
52D11I14"Void A1077();
"
19D7I21"48 strcat(), strcpy()"
17D9I14"48 strncpy(); "
16D11I13"int strncmp()"
24D4I4"1078"
15D8I7"2 A7268"
27D2I2"79"
13D12I18"struct A553 *A1080"
21I17"A7 A9295;
extern "
6D67I3"108"
72I66"struct A553
{
struct A553 *A1082;
A7 A1083;
struct A114 A1084;
};
"
15D81I1"8"
86D75I59"struct A5513
{
A81 A5514;
struct A147 *A5515;
};
A5972 A777"
80D39I10"A5972 A778"
44D17I10"A5972 A778"
22D16I10"A5972 A778"
21D16I10"A5972 A778"
21D16I10"A5972 A778"
21I15"A5972 A7785();
"
7D14I11"A74 A6242; "
21D12I8"A7 A1086"
21D12I8"A7 A7184"
21D12I11"A5794 A5248"
25D6I4"7185"
15D10I10"A95 *A1087"
27D4I4"1088"
21D4I4"1089"
21D4I4"7186"
21D3I3"109"
21D4I4"7187"
15D10I11"A5794 A1091"
21D9I10"Void A1092"
27D3I3"093"
20D4I4"8269"
20D3I3"094"
14D10I8"A4 A1095"
21D10I8"A4 A1096"
28D3I3"097"
20D4I4"1098"
16D10I7"4 A1099"
21D10I11"A94 * A5272"
21D9I10"A94 * A110"
21D10I11"A94 * A1101"
29D2I2"02"
19D4I4"1103"
15D11I10"Void A1104"
30D2I2"05"
21D2I2"06"
19D4I4"5675"
21D4I4"6243"
15D10I8"A4 A5518"
27D4I4"7786"
21D4I4"5516"
21D4I4"5517"
21D4I4"5519"
22D3I3"520"
14D18I12"Void A5521()"
27D17
23D4I4"5522"
15D10I9"A23 A7787"
21D8I10"Void A1107"
19D10I10"Void A1108"
22D10I7"4 A1109"
21D11I10"Void A1110"
22D11I10"Void A1111"
22D11I10"Void A1112"
22I21"Void A2942();
extern "
7D4I4"1113"
15D55I12"Void A2949()"
64D13I12"Void A7070()"
22D9I12"Void A1114()"
18D10I12"Void A1115()"
19D9I12"Void A7269()"
19D8I12"94 * A1116()"
17D9I12"Void A1117()"
18D18I12"Void A1118()"
27D18I12"Void A1119()"
27D26I12"Void A7788()"
35D8I12"Void A5676()"
17D18
26D2I2"20"
21D2I2"21"
21D2I2"22"
13D9I10"Void A8270"
26D4I4"5249"
15D10I18"struct A144 *A5523"
19I17"A7 A5822;
extern "
6D4I4"7789"
21D4I4"7790"
19D4I4"7791"
15D10I10"A94 *A7792"
21D10I11"A5794 A7793"
22D7I10"5794 A7794"
19D7I10"5794 A7795"
18D10I11"A5794 A7796"
22D8I10"5794 A7797"
20D2I4"5794"
7D3I45"8();
struct A5304 { A77 A3049; A5794 A1148; }"
12D12I13"A2 A1123[100]"
21D12I9"A17 A1124"
21D12I10"A13 *A1125"
21D12I9"A81 A1126"
23D9I7"8 A1127"
19D1I1"5"
6D4I2"28"
13D11I18"struct A144 *A1129"
20D11I18"struct A144 *A1130"
20D11I26"const struct A5304 A3050[]"
21D10I7"4 A1131"
20D17I8"38 A1132"
26D45I9"Void A113"
65D1I1"3"
21D1I1"3"
13D9I8"A17 A113"
29D1I1"3"
13D10I8"A4 A2979"
29D1I1"3"
19D3I3"917"
23D2I2"39"
13I19"A4 A1140();
extern "
8D1I1"4"
6D124I231"extern Void A5529();
extern A4 A5530();
extern A7 A5532();
extern Void A5533();
extern A66 A5534();
extern A66 A7799();
extern Void A5531();
extern Void A1142();
extern Void A1143();
extern Void A1144();
extern A50 A1145();
extern "
131D339I15"46();
extern A7"
344D13I118"47();
extern A48 A1148();
extern A48 A1149();
extern A77 A1150();
extern A58 *A5067, *A5068;
extern A17 *A8945, *A8946"
22D4I6"8271()"
15D5I193"53();
extern Void A1154();
extern Void A1155();
extern Void A1156();
extern Void A1157();
extern Void A5823();
extern Void A1158();
extern Void A1159();
extern Void A1160();
extern Void A1161()"
15D4I4"8402"
15D19
25D4I75"8403; A54 A8404; A13 *A8405; A7468 A8406; A72 A8407; A58 *A8408;
A58 *A8409"
19D52I1"6"
57D1I1"7"
6D56I4"63;
"
61D10I229"
A7132,
A7133,
A1164,
A1165,
A1166,
A1167,
A1168,
A1169,
A1170,
A1171,
A1172,
A1173;
A13 A1174[ (2000 / CHARLEN) ];
A18 A5435;
A17 A6040;
A13 A7800[ (2000 / CHARLEN) ];
A61 A6041;
A17 A6042;
} ;
extern A13 A9180[(2000 / CHARLEN)]"
20D4I4"9248"
14D88I6"9249; "
95D17I17"9296; A17 A9250; "
24D6I6"9251; "
13D6I19"9297; FILE *A9252; "
16D9I18"struct A9248 A9253"
18D127I14"Void A9254();
"
135D27I104"391
{
struct A633 *A1175;
struct A144 *A1176;
struct A144 *A1177;
struct A144 *A1178;
};
struct A1179
{
"
32D262I91"180;
A53 A1181;
A17 A1182;
A53 A1183;
A5794 A1184;
A5794 A1185;
};
struct A1186
{
struct A8"
267D31I5"187;
"
40D27
33D12I8"188;
};
"
21D18I6"189
{
"
26D71I105"640 *A1190;
A5794 A1191;
};
struct A1192
{
A17 A1193;
A9 A1194;
A70 A1195;
};
struct A1196 { A2 A1197[3];"
77I833" *A1198; };
struct A1199
{
A5794 A1200;
A35 A1201;
A42 A1202;
};
Void A1203();
Void A1204();
Void A1205();
struct A5677
{
A5794 A5678;
A42 A5679;
A5794 A5680;
A5794 A5681;
};
extern A17 A6244;
extern long A7418;
extern A49 *A1206;
extern A49 *A1207;
extern A2 A1208[ARG_LEN];
extern A42 A8197; extern A2 A3496[ARG_LEN];
extern struct A1196 A1209[];
extern const A6 A1210;
extern A7 A5406;
extern A7 A5407;
extern A7 A6210;
extern A42 A1211;
extern A4 A1212;
extern A72 A1213;
extern A72 A1214;
extern A18 A1215;
extern A18 A1216;
extern A4 A7228;
extern A61 A1217;
extern A61 A1218;
extern A67 A1219;
extern A13 *A6043;
extern A13 *A1220;
extern A13 *A1221;
extern struct A1162 A1222;
extern struct A144 *A1223;
extern struct A144 *A1224;
extern struct A144 *A1225;
extern A48 A1226;
extern A7 A1227;
extern A9070 A1228;
extern UFLAG"
1095I7"9298,
A"
2534D19
33D4I4"9255"
14D7I9"2 A7190[]"
16D8I18"struct A144 *A1398"
21D4I4"1399"
14D8I7"4 A7807"
18D7I6"7 A621"
21D7I6"9181; "
15I1"1"
6D1I1"0"
11D1I2"68"
6D1I1"1"
11D1I1"4"
6D1I2"2 "
11D1I1"7"
6D1I1"3"
10D4I2"A7"
9D3I1"4"
12D4I2"A7"
9D3I1"5"
12D4I2"A4"
9D3I1"6"
12D9I10"Void A1407"
20D9I10"Void A1408"
26D4I4"1409"
17D6I7"8 A1410"
17D10I9"A58 A1411"
21D8I10"Void A8257"
19D10I8"A4 A8411"
27D4I4"5063"
15D4I2"A6"
9D1I1"2"
12D2I4"Void"
7D1I1"3"
18D4I4"1414"
21D4I4"1415"
15D10I8"A4 A1416"
21D19I10"Void A5687"
36D4I4"5688"
15D10I10"Void A5689"
21D10I19"struct A5677 *A5690"
30D1I1"7"
12D10I10"A13 *A5396"
21D10I9"Void A141"
28D4I4"1419"
21D4I4"6052"
15D10I11"A5794 A7808"
30D1I1"4"
18D4I4"5545"
21D4I4"5546"
15D8I10"Void A5547"
19D2I4"Void"
7D1I1"0"
12D2I4"Void"
7D25I1"1"
36D9I7"A4 A624"
21D9I9"A48 A9182"
20D9I8"A4 A1422"
20D4I2"A4"
9D12I5"3();
"
26D5I6" A1424"
16D10I12"Void A3500()"
19D8I10"Void A1425"
19D8I9"int A3493"
19D10I9"int A3494"
27D4I4"1426"
15D10I19"struct A1189 *A1427"
21D12I10"A13 *A8273"
22D7I6"4 A599"
19D9I7"A4 A599"
21D8I10"Void A9311"
27D2I2"28"
13D12I10"Void A7191"
31D2I2"29"
13D8I10"Void A6080"
25D4I4"9183"
15D10I9"A54 A1430"
21D1I1"V"
6D4I4"1431"
15D10I8"A4 A7475"
30D1I1"2"
12D9I12"UFLAG *A1433"
29D1I1"4"
12D10I8"A4 A1435"
29D2I2"36"
13D1I1"v"
6D4I4"6246"
15D1I1"v"
6D4I4"7809"
21D4I4"1437"
23D2I2"38"
14D10I10"34 A5691()"
19D20
28D2I2"39"
19D4I4"1440"
15D10I12"Void A1441()"
19D17
26D1I1"2"
21D1I1"3"
12D11I10"Void A5773"
30D2I2"44"
13D12I11"A5794 A1445"
21I20"A5794 A1446;
extern "
6D4I4"1447"
21D4I4"3532"
15D12I10"A2 A3526[]"
21I17"A4 A3527;
extern "
6D2I2"14"
21D4I4"1449"
15D10I11"A5794 A1450"
30D1I1"1"
18D4I4"1452"
15D10I8"A4 A9184"
27D4I4"5274"
21D73I6"1453()"
82D19I12"Void A5651()"
28D20I12"Void A5548()"
29D20
26D4I130"3443();
extern Void A6072();
extern Void A1454();
extern Void A3363();
extern Void A1455();
extern Void A1456();
extern Void A5107"
17D89I65"065
{
A67 A1066;
A5794 A1067;
A5794 *A1068;
A17 A1069;
};
extern "
97D44I20"1065 *A1070;
extern "
52D40I53"1065 A1071[];
extern A67 A1072[];
extern Void A6209()"
53D12I85"
{
A79 A547;
A79 A548;
A79 A549;
A79 A6232;
A79 A5661;
A87 A6233;
A87 A5662;
A23 A552"
23D16I24"53 *A554, *A555, *A6234,"
21D1I12"63, *A557;
}"
11D29I14"93
{
A17 A8274"
34D35I21"98 A8275;
A8198 A8276"
50D44I10"8277[1];
}"
54D41I6"561
{
"
56D4I165"62;
struct A561 *A563;
A40 A564;
A40 A565;
A81 A566;
A58 A567;
A42 A568;
A68 A569;
struct A147 A570;
A17 A571;
A24 A572;
A61 A573;
A96 *A574;
struct A1537 * A7443;
}"
13D11I8"A81 A575"
20D9I17"struct A561 *A576"
28D1I1"7"
18D2I1"5"
22D2I2"79"
19D3I4"8278"
22D1I1"0"
20D1I1"1"
19D3I2"82"
22D9I1"3"
20D7I10"Void A5664"
18D19
27I65"4(), A585();
extern A4 A586();
extern A4 A5665();
extern Void A58"
1854I50"9136
{
struct A9136 *A9137; A17 A9138; };
struct A"
109D9I19"struct A9136 *A9139"
18D18
26D9I10"9136 A9140"
19D9I8"58 A7273"
18D4I3"A17"
9D3I1"4"
12D11I17"struct A588 A1719"
20D4I2"A2"
9D3I3"6[]"
20D2I2"77"
13D10I9"A89 A1978"
29D2I2"79"
19D4I4"1980"
21D4I4"7274"
24D1I1"1"
13D8I7"4 A9185"
19D18I8"A4 A9186"
35D4I4"5897"
24D1I1"2"
12D3I4"Void"
8D1I1"3"
12D10I9"A72 A1984"
21D10I18"struct A561 *A1985"
27D3I3"914"
23D2I2"86"
21D2I2"87"
13D27
33D26I4"9142"
37D10I9"A78 A1988"
27D4I4"1990"
21D4I4"1989"
21D4I4"1991"
15D8I10"Void A1992"
25D4I4"1993"
15I27"struct A144 *A7824; extern "
6D4I26"5553();
struct A147 *A7825"
23D2I2"26"
19D4I4"7827"
21D64I6"7828()"
73D8I10"Void A7829"
20D7I7"4 A7830"
18D9I12"Void A8412()"
18D9I12"Void A7831()"
18D9I12"Void A7832()"
18D19I12"Void A8413()"
28I14"Void A8414();
"
8D20I7"1457
{
"
26D12I4"58;
"
18D3I25"59;
A4 A1460;
A9 A1461;
}"
12D19I10"A9 A1461()"
28D18I10"A9 A1462()"
28D1I1"9"
6D1I1"3"
11D19I8"A4 A1464"
30D9I7"4 A1465"
19D20
28D11I10"83 **A5078"
21D9I18"struct A83 **A5079"
25D2I2"66"
13D9I7"4 A1467"
19D3I11"struct A144"
8D2I2"68"
12D11I18"struct A144 *A7476"
21D9I7"4 A1469"
19D10I19"struct A640 **A3651"
20D9I18"struct A640 **A365"
21D8I9"17 *A1470"
19D8I9"68 *A1471"
26D13I14"640 **A1472 ;
"
22D7I7"3 A1473"
18D11I7"4 A1474"
22D7I9"13 *A1475"
18D7I9"13 *A1476"
18D7I9"13 *A1477"
18D4I2"53"
9D2I2"78"
13D2I2"68"
7D2I2"79"
12D9I3"A17"
15D1I1"0"
12D1I2"57"
6D1I1"1"
11I19"A57 A3660 ;
extern "
17D3I4"5 ; "
11D10I8"57 A1482"
22D6I10"036 *A1483"
17D10I7"4 A1484"
20D18I8"A4 A8214"
29D8I7"4 A1485"
19D7I11"9036 *A1486"
18D7I9"81 *A1487"
17D8I16"const A81 *A1488"
19D7I7"6 A1489"
25D11I10"144 *A7276"
21D4I4"9036"
9D1I1"0"
11D17I8"A9 A1491"
27I21"A9036 A1492 ;
extern "
8D9I10"640 *A1493"
19D17I9"A63 A1494"
27D17I8"A4 A1495"
28D8I7"4 A1496"
22D4I4"5825"
18D4I5"1497 "
21D8I9"640 *A149"
19D12I12"A5794 A1499 "
21D12I18"struct A83 *A1500 "
21D10I18"struct A83 *A1501 "
19D13I18"struct A83 *A1502 "
22D10I18"struct A83 *A5080 "
20D9I9"53 A1503 "
18D12I9"A4 A1504 "
21D12I8"A4 A6247"
21I27"struct A83 *A6248 ;
extern "
6D4I4"9040"
23D2I2"05"
14D7I7"4 A1506"
18D10I11"A5794 A1507"
21D9I10"Void A7451"
20D10I8"A4 A7833"
22D8I7"4 A6249"
25D4I4"6250"
23D2I2"08"
13D8I10"Void A1509"
28D1I1"0"
12D4I2"A6"
9D1I1"1"
21D1I1"2"
12D10I9"A68 A1513"
21D7I9"Void A151"
20I203"81 A5692();
extern Void A8215();
extern Void A1515();
extern A4 A1516();
extern Void A1517();
extern Void A1518();
extern Void A1519();
extern Void A1520();
extern A4 A3738();
extern A4 A7834();
extern A"
561D1I1" "
11D1I1" "
11D1I1" "
10D1I1" "
10D1I1" "
10D1I1" "
848D4I4"9082"
15D19I10"Void A9083"
30D19I10"Void A9084"
30I21"Void A3863();
extern "
17D2I2"89"
13D10I19"struct A1537 *A1590"
21D10I19"struct A1537 *A1591"
27D2I2"71"
21D4I4"1592"
21D4I4"1593"
15D9I10"Void A7841"
29D1I1"2"
12D4I3"A74"
9D1I1"7"
18D4I4"7843"
21D4I4"8218"
15D9I10"Void A8219"
29D1I1"5"
13I1"7"
6D1I1"6"
12D3I4"Void"
8D1I1"7"
12D10I8"A4 A7848"
21D10I9"A74 A7849"
21D1I1"V"
8D24I4"94()"
33D9I4"void"
14D1I3"1()"
10D4I4"void"
9D9I17"2();
typedef A22*"
14I57"3;
extern const A51 A1524;
extern long A1525;
struct A152"
1445D10I8"A4 A9085"
27D4I4"3763"
15D9I10"Void A8835"
21D2I2"35"
7D1I3"4()"
10D11I3"A58"
16D1I1"5"
10D2I11"struct A147"
7D3I1"6"
12I19"A4 A3767();
extern "
2788D2I4"9070"
433D8I10"Void A9086"
19D9I9"A74 A9087"
28D1I1"6"
12D8I9"Void A737"
19D9I8"A4 A4551"
20D9I9"Void A738"
25D3I4"4724"
14D10I8"A58 A741"
29D1I2"77"
20D1I1"3"
18D4I3"744"
15I21"Void A8202();
extern "
1326D1I1" "
15D1I1" "
11D1I1" "
2390D2I4"9070"
215D2I4"9070"
12D1I2"72"
52D4I4"9088"
1941I5"863, "
3442D5I27""Duplicated type-specifier""
1790I29""Non-standard syntax: '%s'",
"
2366D2I145" %s",
"'%s' detected while pattern matching using pattern ( %s ) in subject string %s at cursor position %s",
"While processing a .mm file, '%s'""
1154I31""Attempt to use bad key '%s'",
"
3709I63""Language feature '%s%s' is not officially supported in '%s'",
"
13474I38""While processing a .sln file -- %s",
"
70D37I2""V"
50D63I34"is modified through the call chain"
68D160I38"" " and is referenced through the chai"
167D93I61" " but the calls have no guaranteed execution order", "Expres"
98D11I68"involving variable '%s' possibly depends on order of evaluation"
,
""
17D152I27"Unusual use of '%s' in argu"
157D16I121"to sizeof",
};
static A5794 A3642[] =
{
"Successful completion, %d messages produced",
A3628,
A3628,
A3628,
"Return state"
21D41I10"before end"
54D27I66"'%s'",
"Non-literal format specifier used (with arguments)",
A3628"
50D13I31"to 'void *' from type '%s' (%s)"
26D19
30I27"from 'void *' to type '%s' "
8D23I24"Implicit conversion from"
36D15I16"Implicit convers"
24D2I9"from 0 to"
10D1
14D6I6"expres"
11D6I15"promotion from "
14D109I43"",
"Implicit binary conversion from %s to %"
114D31I85"Implicit adjustment of expected argument type from %s to %s",
"Implicit adjustment of"
41D6I49"return value from %s to %s",
"Implicit conversion"
11D16I21" %s to %s",
"Implicit"
25D12I18"assignment convers"
24D41I18"Prototype coercion"
46D189I2" %"
194D120I2"%s"
125D44I73"rototype coercion (%s) of pointers",
"Implicit conversion (%s) (%s to %s)"
51D56I101"1,
A3621,
A3621,
A3621,
A3621,
A3621,
A3621,
A3621,
A3621,
A3621,
A3621,
"Both sides have side effect"
61D79I12"Passing near"
87D33I48" to library function '(%s)' (%s)",
"Passing near"
41D13I61" to far function (%s)",
"Taking address of near auto variable"
19D64I19"(%s)",
"int within "
70D1I46"",
"old-style function definition for function"
10D26I43"old-style function declaration for function"
31D27I5"",
"p"
41D13I14"not explicitly"
22D18I44"",
"return type defaults to int for function"
23D32I99"",
"omitted braces within an initializer",
"Result 0 due to operand(s) equaling 0 in operation '%s'"
38D14I77"ssibly truncated addition promoted to float",
A3627,
"%sargument for operator"
20D25I107"always evaluates to %s%s",
"Undefined struct used with extern",
"Relational or subtract operator applied to"
31D66I56"ers",
"Subtract operator applied to pointers",
"Operator"
71D1I33" always evaluates to %s%s",
A3628"
7I22"-ANSI reserved word or"
6D42I5"ruct:"
51D8I26"Pointer to incomplete type"
14D36I21"employed in operation"
42D164I41"rameter '%s' (%s) could be declared const"
169D88I7"ariable"
94D57I25"(%s) could be declared as"
63D63I18"",
"Pointer variab"
71D27I97"(%s) could be declared as pointing to const",
"Parameter name missing from prototype for function"
36D74I49"Non const, non volatile static or external variab"
81D19I12"",
"Function"
24D96I24" defined without a proto"
101D11I134"in scope",
"Padding of %d byte(s) is required to align %s on %d byte boundary",
"Nominal struct size (%d bytes) is not an even multipl"
16D87I132"the maximum member alignment (%d bytes)",
"Violates MISRA Required Rule %s, %s%s%s", 
"Violates MISRA Advisory Rule %s, %s%s%s", 
"M"
97D36I35"defined identically at another loca"
41D106I46"(%s)",
"Qualifier const or volatile %s a type;"
111D15I37"%s to reverse the test",
"Header file"
21D25I27"not directly used in module"
30I43"",
"Violates CERT C coding guideline %s, %s"
5D40I31""Indirectly included header fil"
47D48I3"not"
54D38I39"by module '%s'",
"Header file '%s' does"
43D10I4"have"
16D127I59"ndard include guard",
A3628,
A3628,
"Use of modifier or typ"
134D95I27"outside of a typedef",
"Use"
100D8I75"char' without 'signed' or 'unsigned'",
A3628,
"Unary operator in macro '%s'"
13D22I122"parenthesized",
"Worst case function for stack usage: %s See +stack for a full report.",
"Unrecognized pragma '%s' will be"
32D9I30"
"Potential use of null pointe"
16D40I16"in %sargument to"
49D85
90D22I46"%s",
};
static A5794 A3643[] =
{
A3628,
"Scope"
27D20I20" must be a struct or"
28D13I35"ame",
"'this' must be used in class"
29D20I14"",
"'this' may"
25D4I6"be use"
9I108"a static member function",
"Expected a pointer to member after .* or ->*",
"Destructor declaration requires "
9D6I16"Language feature"
12D2I3"not"
8D44I13"rted",
"Pure "
54D60
76D25I42"' requires a virtual function",
"In declar"
31D3I2"of"
8D97I52", did not expect '= %s'; " "text ignored", "operator"
103D65I134"not redefinable",
"Expected a type or an operator",
"Conversion Type Name too long",
"Type not needed before 'operator type'",
"Symbol"
70D30I22" not a member of class"
35D35I25"",
"Explicit storage clas"
41D8I26"needed for member function"
13D11I10"",
"Symbol"
16D49I29" not found in class",
"Symbol"
54D70I62" is supposed to denote a class",
"conflicting access-specifier"
75D56I30"",
"Expected a type after 'new"
61D49I24"Could not find match for"
62I2"%s"
5D14I27"template specialization for"
20D67I6"declar"
78D25I33"a 'template<>' prefix",
A3628,
"F"
32D7I12": '%s()' mus"
12D17I7"a class"
24I8"",
"Call"
9D30I26"ambiguous;  candidates: %s"
36D15I30" %s has same argument count as"
20D89
95D33I46"No %s matches invocation '%s'%s",
"Undominated"
42D24
30D21I16"does not dominat"
26D23I12"' on call to"
28D25I49"",
"Non-consecutive default arguments in function"
30D18I28", assumed 0",
"Last argument"
23D15I33"default in first instance of func"
20D35
49D10I44"0",
"Default argument repeated in function '"
17D115I58"Not all arguments after arg no. %s are default in function"
120D10I26"",
"Local variable '%s' us"
18D1I79"default argument expression",
"Member '%s' cannot be called without object",
"S"
7I7"member "
8D50I7"s canno"
55D100I24"virtual",
"Static member"
109D15I6"global"
20D59
69D18I30"redefined",
"Non-static member"
23D10I53" cannot initialize a default argument",
"ambiguous re"
18D7I92"to constructor; candidates: %s",
"ambiguous reference to conversion function; candidates: %s"
12D38I26"ype '%s' not found, nested"
43D5I9" '%s::%s'"
16D30I12""Symbol '%s'"
39D18I2" m"
24I24"of class '%s'",
"Symbol "
5D14I26"is not a legal declaration"
19D53I8"in class"
58D8
18D12I7"declare"
17D5I20", assumed 'operator "
12D4I110"At least one class-like operand is required with %s",
"Attempting to 'delete' a non-pointer",
A3628,
A3628,
"M"
14D43I24", referenced in a static"
52D72I26", requires an object",
"a "
81I12"declaration "
8D25I49"made at file scope",
"expected a constant express"
32D1I19"Too many template a"
8D30I18"s",
A3628,
"Symbol"
36D20I32"is both a function and a variabl"
25D37I40"a type was expected, 'class' assumed",
""
42D30I28"cannot be distinguished from"
35D4I46", type difference is '%s'",
"template variable"
11D80I1"a"
85D39I25"expects a type, int assum"
44D12I30"A3618,
"assignment from void *"
21D20I23"llowed in C++",
"Member"
25I84" cannot be used without an object",
"%sInitializing a non-const reference '%s' with "
6D32I18"Can't convert from"
37D36I29" to '%s'",
"%s member '%s' is"
41D38I58"accessible to non-member non-friend functions",
"%s member"
44I61"is not accessible through non-public inheritance",
"template "
8D57I60"either a class or a function",
"Argument to copy constructor"
62D64I22"class '%s' should be a"
74D10I40"",
"Template paramater list for template"
16D5I25"inconsistent with %s",
"S"
15D51
56D35I30"declared as \"C\" %s",
"Symbol"
40D9I55" declared as \"C\" %s",
"invalid prototype for function"
14D7I19"",
"Symbol '%s' can"
12D14I35"be overloaded",
"Symbol '%s' is not"
27D13I40" of class '%s'%s",
"No scope in which to"
19D80I6"symbol"
85D3I36"",
"Constructors and destructors can"
8D6I14"have return ty"
12D50I9"Reference"
59D10I60" '%s' must be initialized",
"Insufficient number of template"
20I1"s"
5D1I64"'%s'; %s assumed",
"Expected a namespace identifier",
"Ambiguous"
13D25I1"o"
32I21" '%s' and symbol '%s'"
5D82I5"nonym"
87D5I57"nion assumed to be 'static'",
"Could not evaluate default"
14D24I10" parameter"
29D41I9"",
"class"
46D28I39" should not have itself as a base class"
34D47I68"uld not find '>' or ',' to terminate default template parameter at %"
52D16I6"Defini"
21D2I9"for class"
8D59I52"is not in scope",
"Object parameter does not contain"
64D25I91"address of a variable",
"Object parameter for a reference type should be an external symbol"
30D43I72"mbiguous conversion between 2nd and 3rd operands of conditional operator"
48D13I40"mbiguous use of template-id for instanti"
19D44I41"of '%s'; candidates: %s",
"Invalid defini"
49D15I8"of '%s';"
24D7I1" "
15D25I62"undefined",
"Compound literals may be used only in C99 program"
30D8I9"Previous "
20D97I2"of"
103I36"(%s) is incompatible with '%s' (%s) "
10D66I62"introduced by the current using-declaration",
"A using-declara"
71D33I128"must name a qualified-id",
"A using-declaration must not name a namespace",
"A using-declaration must not name a template-id",
""
38D75I22"is not a base class of"
80D71I20"%s",
"A using-declar"
76D16I25" that names a class membe"
26D152I17"a member-declarat"
157D18I7"
"A pur"
25D5I23"fier was given for func"
15D3I8"which wa"
9D12I57"virtual",
"Could not find ')' or ',' to terminate default"
22I50"argument at %s",
"Effective type '%s' of non-type "
8D43I52" parameter #%s " "(corresponding to argument express"
51D93I21") " "depends on an un"
102I41"ed parameter of this " "partial specializ"
5D65I21"", "A target ctor mus"
70D20I13"the only mem-"
31D37I167" in the "
"mem-initializer-list of a delegating ctor", "Delegating ctor delegates directly to itself, "
"causing infinite recursion", "Function template specialization"
43D44I3"doe"
50D60I29"match "
"any function templat"
66D21I13"mbiguous func"
26D19I23"template specialization"
24D24I19"; "
"candidate func"
29I29"templates: %s", "Declaration "
8D55I36"does not declare an explicit "
"spec"
60D8I58"ation, explicit instantiation or friend", "Type of variabl"
15D19
29D50I40"deduced from its "
"initializer", "auto "
55I54"deduced inconsistently: '%s' for '%s' "
"but '%s' for "
8D72I4"Type"
78D51I63"is not allowed as an enum-base; ISO C++ "
"requires an integral"
56D33I31"", "A reference to enumeration "
38D3I14"should not use"
8D87I21"",
"Use of ref qualif"
98D6I87"'%s' inconsistent with overloaded function '%s' (%s)",
"Initializing value '%s' of enum"
12D46I33" '%s' cannot be "
"represented by"
51D128I32"enumeration's underlying " "type"
133D46I76"", "Mixing two different kinds of string literals",
"Use of deleted function"
52D31I17"defined at %s",
""
36D50I9"overrides"
57D5I13"ut the return"
10D148I14"s of these "
""
156D7I11"functions ("
12D24I3"and"
29D27I90", respectively) are " "neither identical nor covariant", "Cycle detected: explicit applica"
32D65I57"of %s::operator-> "
"causes infinite implicit application"
70I108"the same " "operator", "ISO C++ requires an explicit %s to appear at "
"namespace scope", "In %s, the form '"
5D109I55"D(parms)->type' "
"(where D is either %s or a parenthes"
116D7I105"gion) " "is the only valid way to use a trailing-return-type." };
static A5794 A3644[] =
{
A3628,
"member"
13D16I8"(%s) not"
27D10I26"d by constructor",
"member"
15D25I5" (%s)"
41D15I24"",
"member '%s' (%s) not"
26D75I1"d"
81D5I9"leting an"
13D5
18D23I122"before type is defined",
"Header <typeinfo> must be included before typeid is used",
A3628,
A3628,
A3628,
A3628,
A3628,
"M"
28D19I81" with different signature hides virtual member '%s' (%s)",
"Reference member '%s'"
27D83I9"initializ"
89D16
30D111I78"is returning a temporary via a reference",
"Assigning address of auto variable"
117D56I4"to m"
62D5I21"of this",
"Pointer to"
10D14I9"POD class"
20I24"passed to function '%s' "
8D25I26"An uninitialized reference"
31D7I67"is being used to initialize reference '%s'",
"reference member '%s'"
12D100I14"initialized by"
113D17I59"initializer list",
};
static A5794 A3645[] =
{
A3628,
"data"
29D45I32" has zero size",
"defined object"
51D68I7"of type"
73D21I77" has no nonstatic data members",
"a tagged union is not anonymous",
"useless "
27D13I45" declaration",
"no access specifier provided,"
18D10I36" assumed",
"Call to virtual function"
16D45I8"within a"
58D36I2"or"
50I35""attempting to 'delete' an array",
"
8D15I31"base class destructor for class"
21D4I2"is"
9D24I21"virtual",
"base class"
30D33I31"has no destructor",
"Member hid"
38D25I16"n-virtual member"
30D10I34" (%s)",
"destructor for base class"
16D64
69D66I2"is"
71D73I7"virtual"
79D13I49"orage class ignored",
"Creating temporary to copy"
19D81I2"to"
86D39I26" (context: %s)",
"Default "
44D30I24"ructor not available for"
46D10I41"Member declaration hides inherited member"
16D28I58"(%s)",
A3628,
A3628,
A3628,
"Multiple assignment operators"
34I23"lass '%s'",
"Multiple c"
15D10I11"s for class"
15D59I10"",
"Symbol"
65D35I49"is an array of empty objects",
A3628,
"new in con"
43D10I10" for class"
16D36I24"which has no explicit de"
47I7"A3628,
"
8I9"function "
10D22I9"not defin"
28D1I8"static m"
17D22I9"not defin"
28D16I42"call to %s does not match function templat"
22D66I10"",
"Symbol"
72D29I58"not first checking for assignment to this",
A3628,
"Symbol"
39D29I62" should have compared argument against sizeof(class)",
"Symbol"
35D32I17"not checking argu"
37D47I35"for NULL",
"Repeated friend declara"
52D17I10"for symbol"
22D16I19"",
"static variable"
22D20I19"found within inline"
30I53"in header",
"Exposing low access data through member "
8D9I26"Exposing low access member"
14D10I9"",
"const"
20I47"returns pointer data member '%s'",
"base class "
5D16I24"absent from initializer "
21D11I30"for copy constructor",
"member"
16D32I59" (%s) not assigned by assignment operator",
"Pointer member"
38D2I32"(%s) neither freed nor zeroed by"
13I10"",
"Member"
5D65I37" (%s) possibly not initialized by con"
71I12"or",
"Member"
6D50I39"(%s) possibly not initialized",
"Member"
60D33I46" possibly not initialized",
"Value of variable"
39D24I65"(%s) indeterminate (order of initialization)",
"Value of variable"
29D5I45" used previously to initialize '%s' (%s)",
"d"
11D22I18"throw of exception"
35D6I20"destructor '%s'",
"A"
17D8I68"f array to pointer to base class (%s)",
"Exception specification for"
13D36I2" %"
41D12I9"exception"
18D3
9D100
106D15I17"-list of function"
24D9
24D7
12D8I4"n by"
22D24I29" is not on throw-list of func"
29D53I12"'%s'",
"Func"
58D9I15"may throw excep"
14D4
10D17I12"n destructor"
22D86I22"",
"Converting pointer"
91D15I44"rray-of-derived to pointer to base",
"struct"
21D51I50"declared as extern \"C\" contains C++ substructure"
61D120I33"",
"Direct pointer copy of member"
126D41I24"within copy constructor:"
46D15I33"",
"Direct pointer copy of member"
20D12I33" within copy assignment operator:"
17D23I53"",
"'new Type(integer)' is suspicious",
"const member"
29D20I6"is not"
32D55I19"",
"virtual coupled"
61D75I54"inline is an unusual combination",
"Uncaught exception"
80D30I28" may be thrown in destructor"
35D8I67"",
"Uncaught exception '%s' not on throw-list of function '%s'",
"R"
17D9I1"i"
17D82I1"a"
87D8I75"causes loss of const/volatile integrity (%s)",
"Exception specification for"
13D48I19" is not a subset of"
53D11I58" (%s)",
"Suspicious third argument to ?: operator",
"Assig"
16D69I43"a non-zero-one constant to a bool",
"member"
74D39I5" (%s)"
44D39I23"assigned by initializer"
48D9I10"",
"member"
19D28I21" might have been init"
33D1I21"ed by a separate func"
6D50I67"but no '-sem(%s,initializer)' was seen",
"Initialization of variabl"
61D18I37" is indeterminate as it uses variable"
24I37"through calls: '%s'",
"Variable '%s' "
5D62I17"accesses variable"
68D149I47"before the latter is initialized through calls:"
158D51I12"Initializing"
61D8I90"reference with a temporary.",
"Initializing a reference class member with an auto variable"
17D8I26"Returning an auto variable"
14D97I39"via a reference type",
"Initializing a "
104D68I18"reference variable"
74D76I16"an auto variable"
81D4I44"",
"Name of generic function template '%s'%s"
14D22I36"in "
"namespace associated with type"
27D18I85"%s", "Returning the address of an auto variable indirectly through reference variable"
26D6I10"A3628,
"Ex"
13D60I10"specializa"
65D5I3"doe"
11D25I39"occur in the same file as corresponding"
34D65I9" template"
70I5" (%s)"
7D36I26"tial or explicit specializ"
41D29I5" does"
34D27I42"occur in the same file as primary template"
37D26I11"",
"Pointer"
34D9
20D13I151"either freed nor zeroed by cleanup function",
"Pointer member '%s' (%s) might have been freed by a separate function but no '-sem(%s,cleanup)' was seen"
20D53I139"8,
"Unused temporary object created here;" " object has type '%s'", };
static A5794 A3646[] =
{
A3628,
"redundant access-specifier '%s'",
""
62D76
81D49I28"is both an ordinary function"
55D59I21"and a member function"
64D49I12"",
"Function"
99D19I1"C"
30D10
15D6I60"has private access specification",
"static class members may"
11D20I87"ccessed by the scoping operator",
"Declaration with scope operator is unusual within a "
25D7I36"",
"static assumed for %s",
"typedef"
13D14I24"not declared as \"C\" %s"
19D41I6"ypedef"
46D10I18" declared as \"C\""
15D52I25"",
"An implicit 'typename"
58D28I21"assumed",
"class '%s'"
33D151
156D32I95"a virtual function but is not inherited, so none of its functions need to be virtual",
"default"
45I12"not defined "
14D67I58"",
"Parentheses have inconsistent interpretation",
"Member"
76D1
6D20I37" (%s) not referenced",
"static member"
26D51I51"(%s) not referenced",
"Virtual member function '%s'"
56D28I74" not referenced",
A3629,
"expression within brackets ignored",
"assignment"
38D27I75"for class '%s 'has non-reference parameter",
"assignment operator for class"
33D24I8"has non-"
29D5I9" paramete"
10D7
16I14"=() for class "
5D57I2"is"
62D35I16"assignment opera"
42D6I29"assignment operator for class"
12D16I4"does"
21D36I39"return a reference to class",
"Template"
42D42I83"arbitrarily selected.  Refer to Error %s",
"Parameter to copy constructor for class"
48D36I37"should be a const reference",
"class "
48D13I80"is a reference",
"taking address of overloaded function name '%s'",
"inline '%s'"
18D49I28"previously defined inline at"
54D57I10"",
"Symbol"
63D11I82"was previously defined inline at (%s)",
"Initializer inversion detected for member"
16D14I68"",
"class/struct inconsistency for symbol '%s' (%s)",
A3628,
"new in"
20D29I16"ructor for class"
35D21I32"which has no assignment operator"
26D15I21"ew in constructor for"
27D23I76"which has no copy constructor",
"Had difficulty compiling template function:"
32D10I16"Virtual function"
16D8I66"has default parameter",
"Redundant access specifier (%s)",
"Symbol"
14D37I49"hides global operator new",
"non copy constructor"
43I113"used to initialize copy constructor",
"Binary operator '%s' should be non-member function",
"pointer member '%s' "
9D39I70"directly freed or zeroed by destructor",
"member '%s' (%s) conceivably"
44D42I35"initialized by constructor",
"membe"
48D19I43" (%s) conceivably not initialized",
"member"
25D54
59D12I25"conceivably not initializ"
17D92I6""membe"
99D62I61"(%s) possibly not initialized by private constructor",
"membe"
69D41I61"(%s) not assigned by private assignment operator",
"parameter"
47D36I7"in func"
41D12
17D60
79D19I29" reference",
"binary operator"
25D46I13"returning a r"
54D10I26"",
"non-virtual base class"
16D73I23"included twice in class"
78D58I4"",
""
69D22I7"'%s' of"
34D30I37"need not be virtual",
"local template"
36D102I4"(%s)"
109D118I16"ferenced",
A3628"
127D9I11"parameter i"
15D9I78"a reference",
"Overloading special operator '%s'",
"Expected symbol '%s' to be"
19D49I43"for class '%s'",
"global template '%s' (%s)"
54D146I10"referenced"
157D1I92"Discarded instance of post decrement/increment",
"Prefix increment/decrement operator '%s' r"
6D15I8"s a non-"
24D26
31D17I50"ostfix increment/decrement operator '%s' returns a"
27D10I22"",
"Redundant template"
16D69I52"defined identically at %s",
"Declaration of function"
75D69I25"hides overloaded function"
75D81I1"("
88D127I15"Member function"
133D10I38"could be made const",
"Member function"
15D26I9" marked a"
33D43I48" indirectly modifies class",
"Reference paramete"
50D16I22"(%s) could be declared"
22D20I45" ref",
A3628,
A3628,
A3628,
"Virtual function"
30D68I29"an access (%s) different from"
73D41I14"access (%s) in"
46D25I39"base class (%s)",
"Member or base class"
31D10I7"has no "
15D11I31"ructor",
"function '%s' defined"
16D20I8"out func"
25D10I16"'%s'",
"function"
16D45I47"replaces global function",
"Assignment operator"
51D121I2"is"
126D88I109"returning *this",
"Attempt to cast away const (or volatile)",
"Could use dynamic_cast to downcast polymorphic"
102D42I45"catch block does not catch any declared excep"
49D46I40""Converting a string literal to %s is no"
53D26I113" safe (%s)",
"Template recursion limit (%d) reached, use -tr_limit(n)",
"Assignment of string literal to variable"
31I23" (%s) is not const safe"
11D39I51"Returning address of reference to a const parameter"
48D107I38"Passing address of reference parameter"
113D23I4"into"
28D14I59"er address space",
"Assigning address of reference paramete"
21D10I107"to a static variable",
"Uninitialized object created by new",
"Symbol '%s' previously declared as \"C\", %s"
24D8
19D71I11"rom Boolean"
77D3I166"(%s to %s)",
"Implicit conversion to Boolean (%s) (%s to %s)",
"Access declarations are deprecated in favor of using declarations",
"Variable '%s' (%s) (type '%s') is"
14D88I62" only by its constructor or destructor",
"Template constructor"
93D36I43" cannot be a copy constructor",
"Base class"
42D53I148"has no non-destructor virtual functions",
"No token on this line follows the 'return' keyword",
A3628,
"%sInitializing the implicit object parameter"
59D58I10"(a "
"non-"
64D34I50"reference) with %s", "Using-declaration introduces"
40D33I45"(%s), which has the " "same parameter list as"
38I109" (%s), which was also " "introduced here by previous " "using-declaration '%s' (%s)"
, "Template '%s' (%s) wa"
5D32I23"ined but not instantiat"
37D7I78"A3628,
A3628,
};
static A5794 A3647[] =
{
A3628,
"Creating a temporary of type"
12D35I43"",
"useless ';' follows '}' in function def"
40D10I31"on",
A3628,
"Old-style C commen"
15D33I16"implicit default"
46D28I19"generated for class"
33D63I22"",
A3628,
"implicit de"
72D14I7"generat"
21D29
39D40I5"",
"'"
47D14I43"' assumed for destructor '~%s()' (inherited"
20D17I41"base class %s)",
"'virtual' assumed, see:"
26D18
24D20I90"(%s)",
A3628,
"Implicit call of constructor '%s' (see text)",
"Implicit call of conversion"
29D30I5" from"
37D7
12D11I7"to type"
16D37I29"",
A3628,
"Default constructo"
45I8"%s) not "
9I88"d",
A3628,
"Ellipsis encountered",
A3629,
A3629,
"Multiple assignment operators for clas"
6D1I26"",
"Casting to a reference"
6D14I5"ymbol"
20D31I53"not checking argument against sizeof(class)",
"Symbol"
37D28I83"not checking argument for NULL",
"macro '%s' could become const variable",
"C-style"
33D43I10"",
"Symbol"
49D64I33"is a public data member",
"Symbol"
69D18I9"s default"
24D39I34"ructor implicitly called",
"Symbol"
45D24I124"did not appear in the constructor initializer list",
"Symbol '%s' did not appear in the constructor initializer list",
"func"
29D23I122"'%s' returning a reference",
"Conversion operator '%s' found",
"Constructor '%s' can be used for implicit conversions",
"B"
32D196
202D18I14"is not abstrac"
23D16I27"Call to unqualified virtual"
31D24I27"from non-static member func"
32D52I208"Shift operator '%s' should be non-member function",
"Dynamic initialization for class object '%s' (references '%s')",
"Dynamic initialization for scalar '%s' (references '%s')",
"Static variable '%s' has a de"
58D15I9"or",
"Con"
21D30I289"or '%s' accesses global data",
"Down cast detected",
"Address of reference parameter '%s' transferred outside of function",
"Assignment operator for class '%s' does not return a const reference to class",
"Unqualified name '%s' subject to misinterpretation "
"owing to dependent base class"
36I455"28,
A3628,
A3628,
A3628,
A3628,
A3628,
A3628,
A3628,
A3628,
A3628,
A3628,
A3628,
A3628,
A3628,
A3628,
A3628,
A3628,
"Violates MISRA C++ 2008 Required Rule %s, %s%s%s",
"virtual member function '%s' could be made const",
"Non-const member function '%s' contains a deep modification",
"Violates MISRA C++ 2008 Advisory Rule %s, %s%s%s",
A3628,
"Violates CERT C++ coding guideline %s, %s%s",
};
struct A1065 *A1070;
struct A1065 A1071[] =
{
{ 0, "Error", A36"
676I2"%s"
58I2"%s"
77I2"%s"
58I2"%s"
Fa13.c
209D4I7"7 A9235"
18D2I1"9"
12I16"A6 A10;
typedef "
291D20
27D4I8"32 A9069"
14I19"A9069 A24;
typedef "
10D4I2"25"
14D9I13"unsigned A890"
21D6I10"9069 A9150"
17D6I10"9069 A9070"
17D8I8"9070 A27"
18D12I9"A9070 A28"
22I21"A9070 A5793;
typedef "
10D4I2"29"
14D17
26D8I5"A6228"
19D6I8"9070 A30"
25D3I8"long A31"
13I17"A17 A32;
typedef "
11D1I1"3"
11D7I12"unsigned A34"
19D5I5"4 A35"
17D5I5"5 A36"
21D1I1"7"
17D1I1"8"
16D2I2"39"
18D1I1"0"
17D1I1"1"
17D1I1"2"
12D6I6"34 A43"
22D1I1"4"
17D1I1"5"
11D7I7"A42 A46"
17I17"int A47;
typedef "
342D2I4"9236"
17D4I2"63"
19D1I3"577"
18D1I1"4"
16D4I2"65"
20D2I2"19"
18D4I4"8258"
14I19"A54 A7616;
typedef "
138D6I3"A16"
60D13I3"A72"
122D6I5"A9069"
20D6I5"A9069"
1373I69"struct A9304
{
A17 A9305;
A5794 A9306;
};
extern struct A9304 A9307;
"
6D4I4"9308"
14D4I4"9309"
17D1I1"5"
11D4I4"5566"
14D4I4"5567"
14D3I17"7618();
Void A761"
8D13
19D3I17"5569();
Void A915"
8D9I10"Void A9152"
14D17I2"74"
22D1I15"0();
Void A7621"
10I41"6226();
A5794 A6227();
A81 A7622();
A58 A"
460D2I4"9070"
28D2I4"9070"
151I19"struct A114 A9153;
"
1389D2I2"92"
16D6I12"5794 A7637()"
15I16"A4 A202;
extern "
3337D2I4"9070"
159I11"A58 A9238; "
88D2I4"9070"
39D2I4"9070"
367I11"A17 A9071;
"
535I13"A9236 A9239;
"
1098D2I4"9070"
380D7I8"17 A9154"
24D1I1"1"
12D6I7"62 A442"
16I17"A4 A443 ;
extern "
150D3I4"9072"
14D10I9"Void A451"
22D9I9"5794 A452"
21D9I9"9036 A453"
29D1I1"4"
13D12
20D1I1"5"
12D9I22"A315 A456 ;
A5794 A457"
28D1I1"8"
18D4I3"459"
21D3I4"5268"
14D16
24D1I1"0"
12I16"A4 A461;
extern "
8D1I1"2"
12D8I11"Void A463()"
22D4I3"464"
13I18"A58 A8823;
extern "
1037D7I10"Void A9155"
18D9I7"A4 A504"
20I20"Void A505();
extern "
1042D2I4"9070"
1940D8I19"struct A640 * A9310"
24D4I3"663"
15D10I9"A48 A7505"
29D2I2"37"
19D3I4"7176"
14D7I9"Void A664"
22D4I3"665"
16D8I7"4 A4442"
19D6I6"A17 A5"
27D3I2"66"
21D2I3"031"
21D1I1"7"
20D1I1"8"
12I20"Void A669();
extern "
278D3I4"4476"
14D10I17"struct A640 *A675"
27D4I4"7719"
21D4I4"8914"
15D8I12"Void A7720()"
18D7I7"17 A933"
18D8I7"7 A5254"
18D2I2"81"
7D1I1"0"
11D2I2"17"
7D1I1"1"
11D1I2"35"
6D1I1"2"
11D1I2"92"
6D1I1"3"
11D2I1"7"
7D1I1"4"
11D8I7"4 A2145"
18D1I2"68"
6D1I1"6"
13D14I6"*A2147"
24D8I7"4 A2148"
18D7I16"2 A2149[M_TOKEN]"
17D2I2"87"
7D1I1"0"
11D2I1"4"
7D1I1"1"
15D4I4"2152"
14D2I2"36"
7D1I1"3"
11D27I7"35 A826"
38D1I2"17"
6D3I1"4"
13D10I28"7
A2155,
A2156,
A2157,
A6214"
19D4I2"A9"
9D1I1"8"
12D10I9"A17 A8825"
27D3I3"215"
15D3I4"Void"
8D1I1"0"
18D4I4"8209"
23D1I1"1"
12D3I4"Void"
8D1I1"2"
12D10I9"A35 A2163"
29D1I1"4"
12D5I4"Void"
10D1I1"0"
12D9I8"A35 A216"
22D7I10"9036 A8211"
24D4I4"5255"
15D4I2"A4"
9D11I16"6();
extern Void"
16I37"7();
extern Void A2168();
struct A216"
465I42"struct A9073
{
A48 A9074;
A9069 A9075;
};
"
422D6I7"8 A9076"
17D9I8"A42 A982"
20D8I9"long A983"
24D4I3"984"
16D8I8"87 A6039"
20D8I8"61 A7724"
19D9I9"A92 A7260"
20D8I9"long A985"
24D4I3"986"
16D9I8"34 A5670"
20I21"A5794 A987();
extern "
1045I7"9129,
A"
44D4I4"9156"
11I42"9157,
A9158,
A9159,
A9160,
A9161,
A8639,
A"
21D10I2"91"
15D2I2"91"
7I29"9164,
A6176, 
A7062,
A7063,
A"
91I21"9240,
A9241,
A9130,
A"
21I28"9165,
A9166,
A9167,
A9168,
A"
28I14"9292,
A9169,
A"
92I42"9242,
A9243,
A9131,
A9132,
A9133,
A9134,
A"
71I7"9170,
A"
307D4I4"9171"
21I42"9244();
extern Void A8266();
extern Void A"
8I80"extern Void A9172();
extern A4 A9173();
extern A4 A9174();
extern Void A9175();
"
746D9I7"4 A9176"
21D7I9"5794 A868"
19D6I6"7 A598"
25D1I1"0"
19D1I1"1"
13D10I7"61 A872"
22D7I10"5794 A6037"
19D10I7"61 A873"
22D7I10"5794 A8589"
20D5I6"8 A874"
16D9I7"A4 A875"
28D1I1"6"
20D1I1"7"
20D1I1"8"
19D2I2"79"
19D4I3"880"
21D4I4"6172"
21D3I4"9293"
20D4I4"9177"
21D4I4"8787"
23D1I1"1"
20D1I2"29"
18D4I4"7262"
23D1I1"2"
20D1I1"3"
20D2I2"48"
21D1I1"4"
20D1I1"5"
18D3I4"5667"
22D1I1"6"
19D2I2"87"
20D2I2"88"
20D2I2"89"
19D4I3"890"
21D4I3"891"
21D4I3"892"
21D4I4"7745"
24D1I1"6"
21D1I1"7"
20I1"4"
18D3I4"7748"
20D4I4"7749"
21D4I3"893"
23D1I1"4"
18D4I4"1857"
22D3I3"958"
22D1I1"5"
19D3I3"061"
20D3I4"5821"
20D4I3"896"
21D3I4"7507"
20D4I3"897"
21D4I4"5981"
23D1I1"8"
19D3I3"750"
20D3I4"8212"
20D3I3"899"
20D3I4"7177"
22D1I1"0"
18D4I3"901"
23D1I1"2"
20D1I1"3"
18D3I4"8944"
22D1I1"4"
18D4I3"905"
21D3I3"907"
21D4I4"9078"
23D1I1"7"
18D3I4"5077"
20D3I4"8267"
20D3I4"8830"
14D7I9"Void A908"
25D2I2"09"
13D9I9"Void A910"
28D1I1"1"
12D9I7"A4 A912"
20D16
24D1I1"3"
14D8I7"4 A5431"
19D11I9"Void A914"
22D10I9"Void A915"
22D11I6"7 A916"
27D2I2"17"
13D9I10"A5794 A918"
27D3I4"1739"
15D6I9"5794 A919"
24D4I3"920"
15D9I9"Void A921"
26D4I3"922"
15D20I14"A5794 A923();
"
31D4I3"924"
16D7I10"5794 A7263"
19D8I8"61 A5668"
19D7I12"Void A5669()"
16D18
26D13I12"7734 A7751; "
21D7I7"4 A7752"
18D18I10"A4 A5914()"
28D6I10"861 A926()"
16D8I6"4 A927"
18D6I8"4 A928()"
15D9I19"struct A849 *A929()"
19D6I9"61 A930()"
16D8I12"9236 A9245()"
18D6I12"9236 A9246()"
15D9I12"Void A9247()"
18D7I18"struct A144 *A5050"
17D8I6"7 A931"
18D6I8"61 *A932"
16D8I6"7 A933"
21D7I7"*A934;
"
14D18I7"A7 A935"
28D7I8"61 *A936"
16D18I7"A7 A937"
27D18I9"A61 *A938"
27D18I7"A7 A939"
28D9I8"61 *A940"
19D9I6"7 A941"
19D9I8"61 *A942"
19D12I10"61 A6038; "
19D11I18"struct A144 *A1696"
23D8I5" A943"
18D10I7"7 A9294"
19D11I18"struct A144 *A7178"
20D17
26D7I8"44 *A717"
17D7I18"struct A144 *A5432"
17D6I9"5794 A944"
15D17I10"A5794 A945"
26D20I12"A5794 A946;
"
27D4I5"A5794"
9D3I1"4"
19D6I4"7180"
15D12I11"A5794 A7227"
21D12I11"A5794 A7181"
22D7I10"5794 A5510"
17D8I7"68 A948"
17D18
26D10I9"114 *A949"
20D7I6"7 A950"
17D7I6"4 A951"
16D10I17"struct A114 *A952"
19D13I20"struct A144 *A7265; "
27D3I3"266"
15D7I10"5794 A1689"
24D4I4"7753"
15D18I10"Void A7754"
30D10I7"6 A1022"
20D10I8"81 A5511"
19D12I9"A81 A8770"
21D12I18"struct A561 *A1023"
21D12I8"A4 A1024"
22D10I7"7 A1025"
19D18I8"A4 A1026"
29D18I9"A49 A1027"
29D10I9"Void A775"
22D10I8"A4 A1028"
27D15I8"1029();
"
21D4I31"9079();
A48 A9080();
Void A9081"
15D21
38D1I1"0"
13D7I8"17 A1031"
18D18I9"A79 A1032"
35D4I4"5671"
15D8I10"Void A5672"
19D9I10"Void A8401"
21D8I8"17 A5512"
19D10I18"struct A561 *A1033"
21D9I10"Void A9135"
20D9I18"struct A561 *A1034"
21D7I10"5794 A1035"
18D47I10"Void A2317"
58D9I10"Void A5673"
20D9I10"Void A1036"
20D9I10"Void A1037"
20D11I18"struct A561 *A1038"
22D8I6"A4 A56"
21D9I18"struct A561 *A1039"
20D11I10"Void A7182"
22D18I10"A4 A7183()"
27D10I9"A58 A8268"
22D7I28"78 A1040();
extern Void A775"
12D6I49"extern A81 A1041();
extern A81 A7508();
extern A4"
11D3I49"7();
extern A5794 A8590();
struct A7758 *A7759();"
12D51I3"0()"
60D18I11"A78 A1042()"
28D8I10"78 A5271()"
18D8I10"78 A1043()"
18D8I12"5972 A1044()"
17D9I12"Void A2274()"
18D17I42"A54 A5433();
extern A9036 A9039();
extern "
26D106I9"44 *A5434"
116D7I12"9150 A9178()"
16D13I32"Void A7761();
extern A48 A7906()"
23D31I63"7758
{
A40 A7762;
A87 A7763, A7764;
A17 A7765, A7766;
A67 A7767"
43D21
29D11I10"7758 A7768"
20D79I9"A87 A7769"
88D12I9"A87 A7770"
21D12I9"A88 A7771"
21D12I9"A10 A7772"
21D43I17"const A88 A7773;
"
52D19I43"045
{
A18 A1046;
A72 A1047;
A7470 A1048;
A3"
24D2I58"49;
};
struct A1050
{
A18 A1051;
A17 A1052;
A5794 A1053;
}"
12D7I7"7 A3140"
17D34I14"81 A3143[20];
"
43D9I33"054
{
A54 A1055;
A55 A1056[25];
}"
19D8I9"55 *A3164"
19D11I19"struct A1054 *A7509"
20D78
86D209I12"144 *A7774;
"
217D10I51"7500
{
struct A7500 *A7775; A54 A7510; A42 A7511; }"
19D9I12"Void A1057()"
18D8I12"Void A1058()"
17D9I10"Void A1059"
20D8I10"Void A1060"
19D10I11"A5794 A1061"
21D22I18"struct A118 *A1062"
33D13I8" A1063;
"
20D13I8"A4 A7267"
26D4I4"7776"
14D10I8"63 A7777"
19D21
29D3I3"114"
8D2I2"64"
11I40"A81 A7512();
extern A49 A1073();
extern "
8D2I66"74();
extern A72 A1075[];
extern A9036 A1076();
extern A9036 A7778"
14D94I118"3097
{
A70 A3098; A72 A3099; A7468 A3100; A7468 A3101; A72 A3102; A72 A3103; A72 A3104; A7 A3105; A4 A3106; A7 A5282; "
100D5I85"283; A32 A5284; A74 A5966; A17 A6270; };
extern A81 A3107;
extern A315 A3108;
extern "
13D55I62"3097 A3109;
extern A58 A3110;
extern A4 A6067;
extern A72 A311"
60D10I14"extern A6 A311"
15D45
52D11I14"Void A1077();
"
19D7I21"48 strcat(), strcpy()"
17D9I14"48 strncpy(); "
16D11I13"int strncmp()"
24D4I4"1078"
15D8I7"2 A7268"
27D2I2"79"
13D12I18"struct A553 *A1080"
21I17"A7 A9295;
extern "
6D67I3"108"
72I66"struct A553
{
struct A553 *A1082;
A7 A1083;
struct A114 A1084;
};
"
15D81I1"8"
86D75I59"struct A5513
{
A81 A5514;
struct A147 *A5515;
};
A5972 A777"
80D39I10"A5972 A778"
44D17I10"A5972 A778"
22D16I10"A5972 A778"
21D16I10"A5972 A778"
21D16I10"A5972 A778"
21I15"A5972 A7785();
"
7D14I11"A74 A6242; "
21D12I8"A7 A1086"
21D12I8"A7 A7184"
21D12I11"A5794 A5248"
25D6I4"7185"
15D10I10"A95 *A1087"
27D4I4"1088"
21D4I4"1089"
21D4I4"7186"
21D3I3"109"
21D4I4"7187"
15D10I11"A5794 A1091"
21D9I10"Void A1092"
27D3I3"093"
20D4I4"8269"
20D3I3"094"
14D10I8"A4 A1095"
21D10I8"A4 A1096"
28D3I3"097"
20D4I4"1098"
16D10I7"4 A1099"
21D10I11"A94 * A5272"
21D9I10"A94 * A110"
21D10I11"A94 * A1101"
29D2I2"02"
19D4I4"1103"
15D11I10"Void A1104"
30D2I2"05"
21D2I2"06"
19D4I4"5675"
21D4I4"6243"
15D10I8"A4 A5518"
27D4I4"7786"
21D4I4"5516"
21D4I4"5517"
21D4I4"5519"
22D3I3"520"
14D18I12"Void A5521()"
27D17
23D4I4"5522"
15D10I9"A23 A7787"
21D8I10"Void A1107"
19D10I10"Void A1108"
22D10I7"4 A1109"
21D11I10"Void A1110"
22D11I10"Void A1111"
22D11I10"Void A1112"
22I21"Void A2942();
extern "
7D4I4"1113"
15D55I12"Void A2949()"
64D13I12"Void A7070()"
22D9I12"Void A1114()"
18D10I12"Void A1115()"
19D9I12"Void A7269()"
19D8I12"94 * A1116()"
17D9I12"Void A1117()"
18D18I12"Void A1118()"
27D18I12"Void A1119()"
27D26I12"Void A7788()"
35D8I12"Void A5676()"
17D18
26D2I2"20"
21D2I2"21"
21D2I2"22"
13D9I10"Void A8270"
26D4I4"5249"
15D10I18"struct A144 *A5523"
19I17"A7 A5822;
extern "
6D4I4"7789"
21D4I4"7790"
19D4I4"7791"
15D10I10"A94 *A7792"
21D10I11"A5794 A7793"
22D7I10"5794 A7794"
19D7I10"5794 A7795"
18D10I11"A5794 A7796"
22D8I10"5794 A7797"
20D2I4"5794"
7D3I45"8();
struct A5304 { A77 A3049; A5794 A1148; }"
12D12I13"A2 A1123[100]"
21D12I9"A17 A1124"
21D12I10"A13 *A1125"
21D12I9"A81 A1126"
23D9I7"8 A1127"
19D1I1"5"
6D4I2"28"
13D11I18"struct A144 *A1129"
20D11I18"struct A144 *A1130"
20D11I26"const struct A5304 A3050[]"
21D10I7"4 A1131"
20D17I8"38 A1132"
26D45I9"Void A113"
65D1I1"3"
21D1I1"3"
13D9I8"A17 A113"
29D1I1"3"
13D10I8"A4 A2979"
29D1I1"3"
19D3I3"917"
23D2I2"39"
13I19"A4 A1140();
extern "
8D1I1"4"
6D124I231"extern Void A5529();
extern A4 A5530();
extern A7 A5532();
extern Void A5533();
extern A66 A5534();
extern A66 A7799();
extern Void A5531();
extern Void A1142();
extern Void A1143();
extern Void A1144();
extern A50 A1145();
extern "
131D339I15"46();
extern A7"
344D13I118"47();
extern A48 A1148();
extern A48 A1149();
extern A77 A1150();
extern A58 *A5067, *A5068;
extern A17 *A8945, *A8946"
22D4I6"8271()"
15D5I193"53();
extern Void A1154();
extern Void A1155();
extern Void A1156();
extern Void A1157();
extern Void A5823();
extern Void A1158();
extern Void A1159();
extern Void A1160();
extern Void A1161()"
15D4I4"8402"
15D19
25D4I75"8403; A54 A8404; A13 *A8405; A7468 A8406; A72 A8407; A58 *A8408;
A58 *A8409"
19D52I1"6"
57D1I1"7"
6D56I4"63;
"
61D10I229"
A7132,
A7133,
A1164,
A1165,
A1166,
A1167,
A1168,
A1169,
A1170,
A1171,
A1172,
A1173;
A13 A1174[ (2000 / CHARLEN) ];
A18 A5435;
A17 A6040;
A13 A7800[ (2000 / CHARLEN) ];
A61 A6041;
A17 A6042;
} ;
extern A13 A9180[(2000 / CHARLEN)]"
20D4I4"9248"
14D88I6"9249; "
95D17I17"9296; A17 A9250; "
24D6I6"9251; "
13D6I19"9297; FILE *A9252; "
16D9I18"struct A9248 A9253"
18D127I14"Void A9254();
"
135D27I104"391
{
struct A633 *A1175;
struct A144 *A1176;
struct A144 *A1177;
struct A144 *A1178;
};
struct A1179
{
"
32D262I91"180;
A53 A1181;
A17 A1182;
A53 A1183;
A5794 A1184;
A5794 A1185;
};
struct A1186
{
struct A8"
267D31I5"187;
"
40D27
33D12I8"188;
};
"
21D18I6"189
{
"
26D71I105"640 *A1190;
A5794 A1191;
};
struct A1192
{
A17 A1193;
A9 A1194;
A70 A1195;
};
struct A1196 { A2 A1197[3];"
77I833" *A1198; };
struct A1199
{
A5794 A1200;
A35 A1201;
A42 A1202;
};
Void A1203();
Void A1204();
Void A1205();
struct A5677
{
A5794 A5678;
A42 A5679;
A5794 A5680;
A5794 A5681;
};
extern A17 A6244;
extern long A7418;
extern A49 *A1206;
extern A49 *A1207;
extern A2 A1208[ARG_LEN];
extern A42 A8197; extern A2 A3496[ARG_LEN];
extern struct A1196 A1209[];
extern const A6 A1210;
extern A7 A5406;
extern A7 A5407;
extern A7 A6210;
extern A42 A1211;
extern A4 A1212;
extern A72 A1213;
extern A72 A1214;
extern A18 A1215;
extern A18 A1216;
extern A4 A7228;
extern A61 A1217;
extern A61 A1218;
extern A67 A1219;
extern A13 *A6043;
extern A13 *A1220;
extern A13 *A1221;
extern struct A1162 A1222;
extern struct A144 *A1223;
extern struct A144 *A1224;
extern struct A144 *A1225;
extern A48 A1226;
extern A7 A1227;
extern A9070 A1228;
extern UFLAG"
1095I7"9298,
A"
2534D19
33D4I4"9255"
14D7I9"2 A7190[]"
16D8I18"struct A144 *A1398"
21D4I4"1399"
14D8I7"4 A7807"
18D7I6"7 A621"
21D7I6"9181; "
15I1"1"
6D1I1"0"
11D1I2"68"
6D1I1"1"
11D1I1"4"
6D1I2"2 "
11D1I1"7"
6D1I1"3"
10D4I2"A7"
9D3I1"4"
12D4I2"A7"
9D3I1"5"
12D4I2"A4"
9D3I1"6"
12D9I10"Void A1407"
20D9I10"Void A1408"
26D4I4"1409"
17D6I7"8 A1410"
17D10I9"A58 A1411"
21D8I10"Void A8257"
19D10I8"A4 A8411"
27D4I4"5063"
15D4I2"A6"
9D1I1"2"
12D2I4"Void"
7D1I1"3"
18D4I4"1414"
21D4I4"1415"
15D10I8"A4 A1416"
21D19I10"Void A5687"
36D4I4"5688"
15D10I10"Void A5689"
21D10I19"struct A5677 *A5690"
30D1I1"7"
12D10I10"A13 *A5396"
21D10I9"Void A141"
28D4I4"1419"
21D4I4"6052"
15D10I11"A5794 A7808"
30D1I1"4"
18D4I4"5545"
21D4I4"5546"
15D8I10"Void A5547"
19D2I4"Void"
7D1I1"0"
12D2I4"Void"
7D25I1"1"
36D9I7"A4 A624"
21D9I9"A48 A9182"
20D9I8"A4 A1422"
20D4I2"A4"
9D12I5"3();
"
26D5I6" A1424"
16D10I12"Void A3500()"
19D8I10"Void A1425"
19D8I9"int A3493"
19D10I9"int A3494"
27D4I4"1426"
15D10I19"struct A1189 *A1427"
21D12I10"A13 *A8273"
22D7I6"4 A599"
19D9I7"A4 A599"
21D8I10"Void A9311"
27D2I2"28"
13D12I10"Void A7191"
31D2I2"29"
13D8I10"Void A6080"
25D4I4"9183"
15D10I9"A54 A1430"
21D1I1"V"
6D4I4"1431"
15D10I8"A4 A7475"
30D1I1"2"
12D9I12"UFLAG *A1433"
29D1I1"4"
12D10I8"A4 A1435"
29D2I2"36"
13D1I1"v"
6D4I4"6246"
15D1I1"v"
6D4I4"7809"
21D4I4"1437"
23D2I2"38"
14D10I10"34 A5691()"
19D20
28D2I2"39"
19D4I4"1440"
15D10I12"Void A1441()"
19D17
26D1I1"2"
21D1I1"3"
12D11I10"Void A5773"
30D2I2"44"
13D12I11"A5794 A1445"
21I20"A5794 A1446;
extern "
6D4I4"1447"
21D4I4"3532"
15D12I10"A2 A3526[]"
21I17"A4 A3527;
extern "
6D2I2"14"
21D4I4"1449"
15D10I11"A5794 A1450"
30D1I1"1"
18D4I4"1452"
15D10I8"A4 A9184"
27D4I4"5274"
21D73I6"1453()"
82D19I12"Void A5651()"
28D20I12"Void A5548()"
29D20
26D4I130"3443();
extern Void A6072();
extern Void A1454();
extern Void A3363();
extern Void A1455();
extern Void A1456();
extern Void A5107"
17D89I65"065
{
A67 A1066;
A5794 A1067;
A5794 *A1068;
A17 A1069;
};
extern "
97D44I20"1065 *A1070;
extern "
52D40I53"1065 A1071[];
extern A67 A1072[];
extern Void A6209()"
53D12I85"
{
A79 A547;
A79 A548;
A79 A549;
A79 A6232;
A79 A5661;
A87 A6233;
A87 A5662;
A23 A552"
23D16I24"53 *A554, *A555, *A6234,"
21D1I12"63, *A557;
}"
11D29I14"93
{
A17 A8274"
34D35I21"98 A8275;
A8198 A8276"
50D44I10"8277[1];
}"
54D41I6"561
{
"
56D4I165"62;
struct A561 *A563;
A40 A564;
A40 A565;
A81 A566;
A58 A567;
A42 A568;
A68 A569;
struct A147 A570;
A17 A571;
A24 A572;
A61 A573;
A96 *A574;
struct A1537 * A7443;
}"
13D11I8"A81 A575"
20D9I17"struct A561 *A576"
28D1I1"7"
18D2I1"5"
22D2I2"79"
19D3I4"8278"
22D1I1"0"
20D1I1"1"
19D3I2"82"
22D9I1"3"
20D7I10"Void A5664"
18D19
27I65"4(), A585();
extern A4 A586();
extern A4 A5665();
extern Void A58"
1854I50"9136
{
struct A9136 *A9137; A17 A9138; };
struct A"
109D9I19"struct A9136 *A9139"
18D18
26D9I10"9136 A9140"
19D9I8"58 A7273"
18D4I3"A17"
9D3I1"4"
12D11I17"struct A588 A1719"
20D4I2"A2"
9D3I3"6[]"
20D2I2"77"
13D10I9"A89 A1978"
29D2I2"79"
19D4I4"1980"
21D4I4"7274"
24D1I1"1"
13D8I7"4 A9185"
19D18I8"A4 A9186"
35D4I4"5897"
24D1I1"2"
12D3I4"Void"
8D1I1"3"
12D10I9"A72 A1984"
21D10I18"struct A561 *A1985"
27D3I3"914"
23D2I2"86"
21D2I2"87"
13D27
33D26I4"9142"
37D10I9"A78 A1988"
27D4I4"1990"
21D4I4"1989"
21D4I4"1991"
15D8I10"Void A1992"
25D4I4"1993"
15I27"struct A144 *A7824; extern "
6D4I26"5553();
struct A147 *A7825"
23D2I2"26"
19D4I4"7827"
21D64I6"7828()"
73D8I10"Void A7829"
20D7I7"4 A7830"
18D9I12"Void A8412()"
18D9I12"Void A7831()"
18D9I12"Void A7832()"
18D19I12"Void A8413()"
28I14"Void A8414();
"
8D20I7"1457
{
"
26D12I4"58;
"
18D3I25"59;
A4 A1460;
A9 A1461;
}"
12D19I10"A9 A1461()"
28D18I10"A9 A1462()"
28D1I1"9"
6D1I1"3"
11D19I8"A4 A1464"
30D9I7"4 A1465"
19D20
28D11I10"83 **A5078"
21D9I18"struct A83 **A5079"
25D2I2"66"
13D9I7"4 A1467"
19D3I11"struct A144"
8D2I2"68"
12D11I18"struct A144 *A7476"
21D9I7"4 A1469"
19D10I19"struct A640 **A3651"
20D9I18"struct A640 **A365"
21D8I9"17 *A1470"
19D8I9"68 *A1471"
26D13I14"640 **A1472 ;
"
22D7I7"3 A1473"
18D11I7"4 A1474"
22D7I9"13 *A1475"
18D7I9"13 *A1476"
18D7I9"13 *A1477"
18D4I2"53"
9D2I2"78"
13D2I2"68"
7D2I2"79"
12D9I3"A17"
15D1I1"0"
12D1I2"57"
6D1I1"1"
11I19"A57 A3660 ;
extern "
17D3I4"5 ; "
11D10I8"57 A1482"
22D6I10"036 *A1483"
17D10I7"4 A1484"
20D18I8"A4 A8214"
29D8I7"4 A1485"
19D7I11"9036 *A1486"
18D7I9"81 *A1487"
17D8I16"const A81 *A1488"
19D7I7"6 A1489"
25D11I10"144 *A7276"
21D4I4"9036"
9D1I1"0"
11D17I8"A9 A1491"
27I21"A9036 A1492 ;
extern "
8D9I10"640 *A1493"
19D17I9"A63 A1494"
27D17I8"A4 A1495"
28D8I7"4 A1496"
22D4I4"5825"
18D4I5"1497 "
21D8I9"640 *A149"
19D12I12"A5794 A1499 "
21D12I18"struct A83 *A1500 "
21D10I18"struct A83 *A1501 "
19D13I18"struct A83 *A1502 "
22D10I18"struct A83 *A5080 "
20D9I9"53 A1503 "
18D12I9"A4 A1504 "
21D12I8"A4 A6247"
21I27"struct A83 *A6248 ;
extern "
6D4I4"9040"
23D2I2"05"
14D7I7"4 A1506"
18D10I11"A5794 A1507"
21D9I10"Void A7451"
20D10I8"A4 A7833"
22D8I7"4 A6249"
25D4I4"6250"
23D2I2"08"
13D8I10"Void A1509"
28D1I1"0"
12D4I2"A6"
9D1I1"1"
21D1I1"2"
12D10I9"A68 A1513"
21D7I9"Void A151"
20I203"81 A5692();
extern Void A8215();
extern Void A1515();
extern A4 A1516();
extern Void A1517();
extern Void A1518();
extern Void A1519();
extern Void A1520();
extern A4 A3738();
extern A4 A7834();
extern A"
561D1I1" "
11D1I1" "
11D1I1" "
10D1I1" "
10D1I1" "
10D1I1" "
848D4I4"9082"
15D19I10"Void A9083"
30D19I10"Void A9084"
30I21"Void A3863();
extern "
17D2I2"89"
13D10I19"struct A1537 *A1590"
21D10I19"struct A1537 *A1591"
27D2I2"71"
21D4I4"1592"
21D4I4"1593"
15D9I10"Void A7841"
29D1I1"2"
12D4I3"A74"
9D1I1"7"
18D4I4"7843"
21D4I4"8218"
15D9I10"Void A8219"
29D1I1"5"
13I1"7"
6D1I1"6"
12D3I4"Void"
8D1I1"7"
12D10I8"A4 A7848"
21D10I9"A74 A7849"
21D1I1"V"
8D24I4"94()"
33D9I4"void"
14D1I3"1()"
10D4I4"void"
9D9I17"2();
typedef A22*"
14I57"3;
extern const A51 A1524;
extern long A1525;
struct A152"
1445D10I8"A4 A9085"
27D4I4"3763"
15D9I10"Void A8835"
21D2I2"35"
7D1I3"4()"
10D11I3"A58"
16D1I1"5"
10D2I11"struct A147"
7D3I1"6"
12I19"A4 A3767();
extern "
2788D2I4"9070"
433D8I10"Void A9086"
19D9I9"A74 A9087"
28D1I1"6"
12D8I9"Void A737"
19D9I8"A4 A4551"
20D9I9"Void A738"
25D3I4"4724"
14D10I8"A58 A741"
29D1I2"77"
20D1I1"3"
18D4I3"744"
15I21"Void A8202();
extern "
1326D1I1" "
15D1I1" "
11D1I1" "
2390D2I4"9070"
215D2I4"9070"
12D1I2"72"
52D4I4"9088"
2030D7
4974D2I4"9070"
15D2I4"9070"
15D2I4"9070"
1090D2I4"9070"
15D2I4"9070"
136D2I4"9070"
50D2I4"9070"
5267D2I4"9070"
776D2I4"9070"
256D2I4"9070"
15D2I4"9070"
152D2I4"9070"
420I12"(A7) ((A72) "
13I1")"
149D2I4"9070"
41D2I4"9070"
237I7"((A72) "
13I1")"
504D2I4"9070"
99D2I4"9070"
123D2I4"9070"
14D2I4"9070"
19D2I4"9070"
14D2I4"9070"
373D2I4"9070"
50D2I4"9070"
58D2I4"9070"
14D2I4"9070"
19D2I4"9070"
14D2I4"9070"
27D2I4"9070"
176D2I4"9070"
157D2I4"9070"
1577D8I3"A72"
17I7"((A72) "
13I1")"
6131I6"(A72) "
6215D80
85D28I29"7238 && !(A1496||(A1266 > 0))"
40D1I1"0"
12D1I1"1"
7D11I111"0: A9155( A2807 ); 
A1781:
A3711 = A3688->A155.A142 != NULL;
A1649 = A3711 ? A1482 : A3660;
A1668();
A1782:if( "
16D26I11" == ' ' || "
35D44I6"'\t' )"
54D1I13"3;
goto A1784"
7D7I11"3:(void) (("
12D11I11"=(A9)(A15)("
17D9I62"++)) ? ((A1463 == (A9)(A15)('\\'))?A1462():A1463) : A1461() );"
19D8I3"2;
"
13D17I23":
if( A1463 == '=' && *"
22D13I33" != '=' ) goto A1785;
goto A1786;"
18D1I35"5: A1499 = A1492; A865(723); 
A1786"
162D1I1"7"
12D1I1"8"
7D1I1"7"
40D3I3"889"
12D10I10"890;
A1889"
30D3I3"890"
56D1I1"8"
73D1I1"&"
22D2I2"91"
13D1I1"2"
6D2I2"91"
43D1I1"3"
12D1I1"4"
7D1I1"3"
23D1I1"4"
54D1I1"2"
30D1I1"5"
12D1I1"6"
7D1I1"5"
48D1I1"9"
33D1I1"7"
12D8I8"8;
A1900"
28D1I1"9"
7D1I1"7"
129D3I3"901"
14D8I8"2;
A1901"
50D1I1"3"
12D1I1"4"
7D1I1"3"
23D1I1"4"
51D1I1"2"
14D3I3"900"
9D1I1"8"
9D1I1"6"
24D1I1"5"
12D1I1"6"
7D1I1"5"
53D1I1"7"
12D1I1"8"
7D1I1"7"
20D1I1"8"
9D1I1"6"
23D1I1"9"
47D2I2"11"
13D1I1"2"
6D2I2"11"
119D1I1"9"
7D1I1"2"
32D1I1"3"
12D1I1"4"
7D1I1"3"
119D1I1"5"
7D1I1"4"
48D1I1"6"
12D1I1"7"
7D1I1"6"
19D1I1"7"
23D1I1"5"
58D1I1"8"
12D1I1"9"
7D1I1"8"
20D1I1"9"
73D4I4"2331"
15D8I8"2;
A2331"
51D1I1"9"
12D1I1"3"
7D1I1"2"
22D1I1"3"
9D4I4"2330"
87D1I1"4"
12D1I1"5"
7D1I1"4"
39D1I1"6"
12D1I1"7"
7D1I1"6"
25D1I1"8"
7D1I1"7"
24D1I1"9"
11D2I2"40"
8D1I1"9"
24D2I2"41"
7D2I2"40"
87D1I1"2"
12D1I1"3"
7D1I1"2"
23D1I1"3"
8D2I2"41"
8D1I1"8"
81D1I1"4"
7D1I1"5"
24D1I1"5"
12D1I1"6"
7D1I1"5"
46D1I1"7"
12D1I1"8"
7D1I1"7"
23D1I1"9"
7D1I1"8"
37D2I2"50"
12D2I2"51"
7D2I2"50"
44D1I1"2"
12D1I1"3"
7D1I1"2"
56D1I1"3"
8D2I2"51"
10D1I1"9"
9D1I1"6"
22D1I1"4"
9D4I4"2330"
60D1I1"4"
12D1I1"5"
7D1I1"4"
70D1I1"8"
24D1I1"6"
12D1I1"7"
7D1I1"9"
21D1I1"8"
7D1I1"6"
65D2I2"60"
12D2I2"61"
7D2I2"60"
32D1I1"7"
6D2I2"61"
13D1I1"9"
7D1I1"7"
25D1I1"5"
29D1I1"2"
12D1I1"3"
7D1I1"2"
22D1I1"3"
9D4I4"2330"
59D1I1"4"
12D1I1"5"
7D1I1"4"
39D1I1"6"
12D1I1"7"
7D1I1"6"
33D1I1"8"
12D1I1"9"
7D1I1"8"
28D1I1"9"
102D1I1"9"
7D1I1"7"
28D2I2"70"
8D1I1"5"
30D2I2"71"
13D1I1"2"
6D2I2"71"
69D1I1"3"
12D1I1"4"
7D1I1"3"
28D1I1"9"
7D1I1"4"
9D1I1"2"
6D2I2"70"
34D1I1"5"
12D1I1"6"
7D1I1"5"
28D1I1"6"
65D1I1"9"
73D1I1"7"
194D1I1"9"
11D2I2"80"
8D1I1"9"
29D2I2"81"
75D1I1"2"
12D1I1"3"
7D1I1"2"
38D1I1"4"
12D1I1"5"
7D1I1"4"
89D1I1"6"
12D1I1"7"
7D1I1"6"
22D1I1"7"
14D1I1"8"
7D1I1"5"
21D1I1"8"
104D2I2"81"
8D1I1"3"
39D1I1"7"
48D1I1"9"
11D2I2"90"
8D1I1"9"
44D2I2"91"
13D1I1"2"
6D2I2"91"
76D1I1"7"
7D1I1"2"
8D2I2"90"
17D1I1"3"
6D2I2"80"
45D1I1"4"
12D1I1"5"
7D1I1"4"
26D1I1"8"
7D1I1"5"
7D1I1"3"
65D1I1"6"
12D1I1"7"
7D1I1"6"
39D1I1"7"
16D1I1"7"
7D1I1"8"
9D4I4"2330"
54D4I4"2330"
53D4I4"2330"
37D4I4"2330"
9D4I4"2330"
36D1I1"8"
12D1I1"9"
7D1I1"8"
26D1I1"9"
71D3I3"400"
12D10I10"401;
A2400"
54D1I1"2"
12D1I1"3"
7D1I1"2"
23D1I1"3"
7D3I3"401"
30D2I2"10"
13D1I1"9"
6D2I2"10"
25D1I1"4"
12D1I1"5"
7D1I1"4"
24D1I1"5"
40D1I1"6"
12D1I1"7"
7D1I1"6"
24D1I1"8"
12D1I1"9"
7D1I1"8"
20D1I1"9"
27D2I2"10"
12D2I2"11"
7D2I2"10"
66D2I2"11"
10D1I1"7"
82D1I1"2"
12D1I1"3"
7D1I1"2"
109D1I1"4"
12D1I1"5"
7D1I1"4"
85D1I1"6"
12D1I1"7"
7D1I1"6"
59D1I1"8"
12D1I1"9"
7D1I1"8"
43D2I2"20"
8D1I1"9"
29D2I2"20"
15D2I2"21"
8D1I1"7"
47D1I1"2"
12D1I1"3"
7D1I1"2"
30D1I1"3"
6D2I2"21"
67D1I1"4"
7D1I1"5"
24D1I1"5"
12D1I1"6"
7D1I1"5"
47D1I1"7"
12D1I1"8"
7D1I1"7"
19D1I1"8"
121D1I1"9"
11D2I2"31"
8D1I1"9"
30D2I2"31"
12D1I1"6"
9D1I1"4"
15D2I2"32"
8D1I1"3"
32D2I2"32"
60D1I1"3"
12D1I1"4"
7D1I1"3"
79D1I1"5"
12D1I1"6"
7D1I1"5"
33D1I1"6"
8D1I1"4"
24D1I1"7"
12D1I1"8"
7D1I1"7"
20D1I1"8"
33D1I1"9"
11D2I2"40"
8D1I1"9"
20D2I2"40"
6976I7"((A72) "
15I1")"
3129I6"(A72) "
658I6"(A72) "
229I6"(A72) "
224I6"(A72) "
257I6"(A72) "
232I6"(A72) "
240I6"(A72) "
258I6"(A72) "
219I6"(A72) "
231I6"(A72) "
253I6"(A72) "
3592D78I10"10:
*A8229"
84D11I67"17)0x01;
*A1859 = A986( A2149, A3449 .A956, A3449 .A957);
return;
}"
16D2I31"1: if( !(( *(A1470) ) & 0x01) )"
9D5I23"5288;
switch( A5969 )
{"
11D1I1"7"
7D29I20"A1495 && A1493->A645"
40D2I2"17"
13D1I1"0"
6D11I39"17:
A1493->A645->A636 |= (A9070) 0x8000"
17D1I1"0"
12D1I1"6"
8D19I1"8"
25D65I29"( *(A1470) ) & 0x01 && !A1346"
77D1I1"1"
12D1I1"2"
7D16I9"1:
A3680("
21D64I3"722"
75D1I1"6"
8D13I44"9:
case 12:
case 11:
if( A5088( A5969 == 9 ?"
19D106I43" 4 :
A5969 == 12 ? (A17) 0x10 : (A17) 8) ) "
114D45I2"23"
55D29I23"25;
A1723:
A846( (A4) 0"
34D4I4"1484"
12D2I54"0;
A1469 = (A4) 0;
*A8229 |= (A17)0x02;
return;
A1725:"
12D58I18"6;
case 13:
A7336("
63D4I23"7() );
A7338 = (A4) 0;
"
12D2I45"16;
case 14:
A7335( A7337() );
A7338 = (A4) 0"
12D63I49"16;
default:
A897( 975, A2149 );
A8102 = (A4) 1;
"
71D48I10"16;
}
A171"
55I33"( *(A1470) ) & 0x01 && (A3648 || "
5I10")
&& A7338"
11D2I2"26"
12D2I2"27"
7D15I11"26:
{
A5794"
20D1I26"7 = A1507( (A17) 2, A510 )"
9D1I1"6"
15D1I1"6"
11D2I2"67"
8D13I20"6: sys_pragma( A3747"
20D71I2"67"
78D4I4"1346"
15D2I2"68"
12D2I2"69"
7D37I21"68:
{extern A72 A3748"
44D4I4"3748"
16D1I1"0"
12D1I1"1"
7D9I14"0: A671( "\n" "
16D1I59"1:
A671( "#pragma " );
A671( A3747 );
A671( "\n" );
}
A1769"
7D46I48"A1727:
A5288:
if( A8102 ) goto A1772;
goto A1773"
51D25I20"72:
A5057( 122, 960 "
30D18I98"773:
A8228();
if( A8102 ) goto A1774;
goto A1775;
A1774:
A5058();
A1775: ;
}
Void
A8215()
{
A9036 "
23D26I15";
struct A2258 "
31D9I30";
A17 A8230;
A35 A5016;
A2163("
14D6I18"093( 8 ,(A34) 0);
"
11I56" = A8211( A510 );
A2160( &A3924, (A5) 1 );
A1492 = A4540"
543I19"A4 A9105 = (A4) 0;
"
229I16"A9105 = (A4) 1; "
830D2I4"9070"
142D2I4"9070"
108D2I4"9070"
455I7"((A72) "
16I1")"
345I7"((A72) "
15I1")"
6846D3I6"size_t"
140D2I4"9070"
11D2I4"9070"
11D2I4"9070"
11D2I4"9070"
105D2I4"9070"
273D32I12"if( A9105 ) "
39D34I5"436;
"
43D12
23D19I35"5057( 960, 961 );
A5057( 1963, 0 );"
28D25I43"1886 = A6125( A1859, &A3739 );
if( A9105 ) "
32D37I3"438"
46I44"439;
A2438:
A5058();
A5058();
A2439:
goto A2"
10D43I24"1:
if( A395 & (A85) 1 ) "
50D37I3"440"
46I73"441;
A2440:
A6172( A6194, "" ); 
A2441:
A3707( (A27) 0, (A4) 1 );
goto A2"
11D9I11"4:
A6224 = "
15I8";
A2163("
20D10I19"(15 | 32):
A6224 = "
16D1I16";
A3739 = (A4) 0"
20D38I29"16:
A1485 = (A4) 1;
A2164();
"
45D3I27"369;
case 17:
A3684((A4) 1)"
12D16I19"369;
case 18:
A3684"
26D54
66D7I7"case 24"
12D25I29" A5088((A17) 4 | (A17) 0x20) "
36D1I1"2"
12D1I1"3"
7D10I62"2:
A846((A4) 0);
A1484 = (A4) 0; A1469 = (A4) 0;
return (A4) 1"
16D7I8"3:
goto "
12I9";
default"
5D10
19D3I16"1 && A2142 != 83"
14D1I1"4"
12D1I1"5"
7D19I9"4:A865(16"
26D33I13"5: ;
}
A2369:"
39D14I19"3739 && A2142 != 83"
26D1I1"6"
12D1I1"7"
7D17I62"6:A1095( 1 ,(A35) 0);
A2447: A7833( A7683, NULL );
A8228();
if"
22D4I5"16( &"
9D24I5" ) ) "
33D1I13"8;
goto A2449"
7D6I25"8:
A7754();
A1057( A7704,"
12D3I24", (A4) 0 );
A7777 = 0; 
"
11D14I2"50"
20D1I44"9:
if( A1886 ) goto A2451;
goto A2452;
A2451"
100D2I2"53"
64D1I1"6"
12D1I1"7"
7D1I1"6"
68D1I1"7"
10D1I1"4"
16D2I2"53"
8D1I1"5"
99D1I1"8"
12D1I1"9"
7D1I1"8"
15D1I1"9"
32D2I2"60"
12D2I2"61"
7D2I2"60"
35D2I2"61"
9D2I2"52"
7D2I2"50"
1726D2I4"9070"
87D2I4"9070"
14D2I4"9070"
87D2I4"9070"
87D2I4"9070"
Fa14.c
209D4I7"7 A9235"
18D2I1"9"
12I16"A6 A10;
typedef "
291D20
27D4I8"32 A9069"
14I19"A9069 A24;
typedef "
10D4I2"25"
14D9I13"unsigned A890"
21D6I10"9069 A9150"
17D6I10"9069 A9070"
17D8I8"9070 A27"
18D12I9"A9070 A28"
22I21"A9070 A5793;
typedef "
10D4I2"29"
14D17
26D8I5"A6228"
19D6I8"9070 A30"
25D3I8"long A31"
13I17"A17 A32;
typedef "
11D1I1"3"
11D7I12"unsigned A34"
19D5I5"4 A35"
17D5I5"5 A36"
21D1I1"7"
17D1I1"8"
16D2I2"39"
18D1I1"0"
17D1I1"1"
17D1I1"2"
12D6I6"34 A43"
22D1I1"4"
17D1I1"5"
11D7I7"A42 A46"
17I17"int A47;
typedef "
342D2I4"9236"
17D4I2"63"
19D1I3"577"
18D1I1"4"
16D4I2"65"
20D2I2"19"
18D4I4"8258"
14I19"A54 A7616;
typedef "
138D6I3"A16"
60D13I3"A72"
122D6I5"A9069"
20D6I5"A9069"
1373I69"struct A9304
{
A17 A9305;
A5794 A9306;
};
extern struct A9304 A9307;
"
6D4I4"9308"
14D4I4"9309"
17D1I1"5"
11D4I4"5566"
14D4I4"5567"
14D3I17"7618();
Void A761"
8D13
19D3I17"5569();
Void A915"
8D9I10"Void A9152"
14D17I2"74"
22D1I15"0();
Void A7621"
10I41"6226();
A5794 A6227();
A81 A7622();
A58 A"
460D2I4"9070"
28D2I4"9070"
151I19"struct A114 A9153;
"
1389D2I2"92"
16D6I12"5794 A7637()"
15I16"A4 A202;
extern "
3337D2I4"9070"
159I11"A58 A9238; "
88D2I4"9070"
39D2I4"9070"
367I11"A17 A9071;
"
535I13"A9236 A9239;
"
1098D2I4"9070"
380D7I8"17 A9154"
24D1I1"1"
12D6I7"62 A442"
16I17"A4 A443 ;
extern "
150D3I4"9072"
14D10I9"Void A451"
22D9I9"5794 A452"
21D9I9"9036 A453"
29D1I1"4"
13D12
20D1I1"5"
12D9I22"A315 A456 ;
A5794 A457"
28D1I1"8"
18D4I3"459"
21D3I4"5268"
14D16
24D1I1"0"
12I16"A4 A461;
extern "
8D1I1"2"
12D8I11"Void A463()"
22D4I3"464"
13I18"A58 A8823;
extern "
1037D7I10"Void A9155"
18D9I7"A4 A504"
20I20"Void A505();
extern "
1042D2I4"9070"
1940D8I19"struct A640 * A9310"
24D4I3"663"
15D10I9"A48 A7505"
29D2I2"37"
19D3I4"7176"
14D7I9"Void A664"
22D4I3"665"
16D8I7"4 A4442"
19D6I6"A17 A5"
27D3I2"66"
21D2I3"031"
21D1I1"7"
20D1I1"8"
12I20"Void A669();
extern "
278D3I4"4476"
14D10I17"struct A640 *A675"
27D4I4"7719"
21D4I4"8914"
15D8I12"Void A7720()"
18D7I7"17 A933"
18D8I7"7 A5254"
18D2I2"81"
7D1I1"0"
11D2I2"17"
7D1I1"1"
11D1I2"35"
6D1I1"2"
11D1I2"92"
6D1I1"3"
11D2I1"7"
7D1I1"4"
11D8I7"4 A2145"
18D1I2"68"
6D1I1"6"
13D14I6"*A2147"
24D8I7"4 A2148"
18D7I16"2 A2149[M_TOKEN]"
17D2I2"87"
7D1I1"0"
11D2I1"4"
7D1I1"1"
15D4I4"2152"
14D2I2"36"
7D1I1"3"
11D27I7"35 A826"
38D1I2"17"
6D3I1"4"
13D10I28"7
A2155,
A2156,
A2157,
A6214"
19D4I2"A9"
9D1I1"8"
12D10I9"A17 A8825"
27D3I3"215"
15D3I4"Void"
8D1I1"0"
18D4I4"8209"
23D1I1"1"
12D3I4"Void"
8D1I1"2"
12D10I9"A35 A2163"
29D1I1"4"
12D5I4"Void"
10D1I1"0"
12D9I8"A35 A216"
22D7I10"9036 A8211"
24D4I4"5255"
15D4I2"A4"
9D11I16"6();
extern Void"
16I37"7();
extern Void A2168();
struct A216"
465I42"struct A9073
{
A48 A9074;
A9069 A9075;
};
"
422D6I7"8 A9076"
17D9I8"A42 A982"
20D8I9"long A983"
24D4I3"984"
16D8I8"87 A6039"
20D8I8"61 A7724"
19D9I9"A92 A7260"
20D8I9"long A985"
24D4I3"986"
16D9I8"34 A5670"
20I21"A5794 A987();
extern "
1045I7"9129,
A"
44D4I4"9156"
11I42"9157,
A9158,
A9159,
A9160,
A9161,
A8639,
A"
21D10I2"91"
15D2I2"91"
7I29"9164,
A6176, 
A7062,
A7063,
A"
91I21"9240,
A9241,
A9130,
A"
21I28"9165,
A9166,
A9167,
A9168,
A"
28I14"9292,
A9169,
A"
92I42"9242,
A9243,
A9131,
A9132,
A9133,
A9134,
A"
71I7"9170,
A"
307D4I4"9171"
21I42"9244();
extern Void A8266();
extern Void A"
8I80"extern Void A9172();
extern A4 A9173();
extern A4 A9174();
extern Void A9175();
"
746D9I7"4 A9176"
21D7I9"5794 A868"
19D6I6"7 A598"
25D1I1"0"
19D1I1"1"
13D10I7"61 A872"
22D7I10"5794 A6037"
19D10I7"61 A873"
22D7I10"5794 A8589"
20D5I6"8 A874"
16D9I7"A4 A875"
28D1I1"6"
20D1I1"7"
20D1I1"8"
19D2I2"79"
19D4I3"880"
21D4I4"6172"
21D3I4"9293"
20D4I4"9177"
21D4I4"8787"
23D1I1"1"
20D1I2"29"
18D4I4"7262"
23D1I1"2"
20D1I1"3"
20D2I2"48"
21D1I1"4"
20D1I1"5"
18D3I4"5667"
22D1I1"6"
19D2I2"87"
20D2I2"88"
20D2I2"89"
19D4I3"890"
21D4I3"891"
21D4I3"892"
21D4I4"7745"
24D1I1"6"
21D1I1"7"
20I1"4"
18D3I4"7748"
20D4I4"7749"
21D4I3"893"
23D1I1"4"
18D4I4"1857"
22D3I3"958"
22D1I1"5"
19D3I3"061"
20D3I4"5821"
20D4I3"896"
21D3I4"7507"
20D4I3"897"
21D4I4"5981"
23D1I1"8"
19D3I3"750"
20D3I4"8212"
20D3I3"899"
20D3I4"7177"
22D1I1"0"
18D4I3"901"
23D1I1"2"
20D1I1"3"
18D3I4"8944"
22D1I1"4"
18D4I3"905"
21D3I3"907"
21D4I4"9078"
23D1I1"7"
18D3I4"5077"
20D3I4"8267"
20D3I4"8830"
14D7I9"Void A908"
25D2I2"09"
13D9I9"Void A910"
28D1I1"1"
12D9I7"A4 A912"
20D16
24D1I1"3"
14D8I7"4 A5431"
19D11I9"Void A914"
22D10I9"Void A915"
22D11I6"7 A916"
27D2I2"17"
13D9I10"A5794 A918"
27D3I4"1739"
15D6I9"5794 A919"
24D4I3"920"
15D9I9"Void A921"
26D4I3"922"
15D20I14"A5794 A923();
"
31D4I3"924"
16D7I10"5794 A7263"
19D8I8"61 A5668"
19D7I12"Void A5669()"
16D18
26D13I12"7734 A7751; "
21D7I7"4 A7752"
18D18I10"A4 A5914()"
28D6I10"861 A926()"
16D8I6"4 A927"
18D6I8"4 A928()"
15D9I19"struct A849 *A929()"
19D6I9"61 A930()"
16D8I12"9236 A9245()"
18D6I12"9236 A9246()"
15D9I12"Void A9247()"
18D7I18"struct A144 *A5050"
17D8I6"7 A931"
18D6I8"61 *A932"
16D8I6"7 A933"
21D7I7"*A934;
"
14D18I7"A7 A935"
28D7I8"61 *A936"
16D18I7"A7 A937"
27D18I9"A61 *A938"
27D18I7"A7 A939"
28D9I8"61 *A940"
19D9I6"7 A941"
19D9I8"61 *A942"
19D12I10"61 A6038; "
19D11I18"struct A144 *A1696"
23D8I5" A943"
18D10I7"7 A9294"
19D11I18"struct A144 *A7178"
20D17
26D7I8"44 *A717"
17D7I18"struct A144 *A5432"
17D6I9"5794 A944"
15D17I10"A5794 A945"
26D20I12"A5794 A946;
"
27D4I5"A5794"
9D3I1"4"
19D6I4"7180"
15D12I11"A5794 A7227"
21D12I11"A5794 A7181"
22D7I10"5794 A5510"
17D8I7"68 A948"
17D18
26D10I9"114 *A949"
20D7I6"7 A950"
17D7I6"4 A951"
16D10I17"struct A114 *A952"
19D13I20"struct A144 *A7265; "
27D3I3"266"
15D7I10"5794 A1689"
24D4I4"7753"
15D18I10"Void A7754"
30D10I7"6 A1022"
20D10I8"81 A5511"
19D12I9"A81 A8770"
21D12I18"struct A561 *A1023"
21D12I8"A4 A1024"
22D10I7"7 A1025"
19D18I8"A4 A1026"
29D18I9"A49 A1027"
29D10I9"Void A775"
22D10I8"A4 A1028"
27D15I8"1029();
"
21D4I31"9079();
A48 A9080();
Void A9081"
15D21
38D1I1"0"
13D7I8"17 A1031"
18D18I9"A79 A1032"
35D4I4"5671"
15D8I10"Void A5672"
19D9I10"Void A8401"
21D8I8"17 A5512"
19D10I18"struct A561 *A1033"
21D9I10"Void A9135"
20D9I18"struct A561 *A1034"
21D7I10"5794 A1035"
18D47I10"Void A2317"
58D9I10"Void A5673"
20D9I10"Void A1036"
20D9I10"Void A1037"
20D11I18"struct A561 *A1038"
22D8I6"A4 A56"
21D9I18"struct A561 *A1039"
20D11I10"Void A7182"
22D18I10"A4 A7183()"
27D10I9"A58 A8268"
22D7I28"78 A1040();
extern Void A775"
12D6I49"extern A81 A1041();
extern A81 A7508();
extern A4"
11D3I49"7();
extern A5794 A8590();
struct A7758 *A7759();"
12D51I3"0()"
60D18I11"A78 A1042()"
28D8I10"78 A5271()"
18D8I10"78 A1043()"
18D8I12"5972 A1044()"
17D9I12"Void A2274()"
18D17I42"A54 A5433();
extern A9036 A9039();
extern "
26D106I9"44 *A5434"
116D7I12"9150 A9178()"
16D13I32"Void A7761();
extern A48 A7906()"
23D31I63"7758
{
A40 A7762;
A87 A7763, A7764;
A17 A7765, A7766;
A67 A7767"
43D21
29D11I10"7758 A7768"
20D79I9"A87 A7769"
88D12I9"A87 A7770"
21D12I9"A88 A7771"
21D12I9"A10 A7772"
21D43I17"const A88 A7773;
"
52D19I43"045
{
A18 A1046;
A72 A1047;
A7470 A1048;
A3"
24D2I58"49;
};
struct A1050
{
A18 A1051;
A17 A1052;
A5794 A1053;
}"
12D7I7"7 A3140"
17D34I14"81 A3143[20];
"
43D9I33"054
{
A54 A1055;
A55 A1056[25];
}"
19D8I9"55 *A3164"
19D11I19"struct A1054 *A7509"
20D78
86D209I12"144 *A7774;
"
217D10I51"7500
{
struct A7500 *A7775; A54 A7510; A42 A7511; }"
19D9I12"Void A1057()"
18D8I12"Void A1058()"
17D9I10"Void A1059"
20D8I10"Void A1060"
19D10I11"A5794 A1061"
21D22I18"struct A118 *A1062"
33D13I8" A1063;
"
20D13I8"A4 A7267"
26D4I4"7776"
14D10I8"63 A7777"
19D21
29D3I3"114"
8D2I2"64"
11I40"A81 A7512();
extern A49 A1073();
extern "
8D2I66"74();
extern A72 A1075[];
extern A9036 A1076();
extern A9036 A7778"
14D94I118"3097
{
A70 A3098; A72 A3099; A7468 A3100; A7468 A3101; A72 A3102; A72 A3103; A72 A3104; A7 A3105; A4 A3106; A7 A5282; "
100D5I85"283; A32 A5284; A74 A5966; A17 A6270; };
extern A81 A3107;
extern A315 A3108;
extern "
13D55I62"3097 A3109;
extern A58 A3110;
extern A4 A6067;
extern A72 A311"
60D10I14"extern A6 A311"
15D45
52D11I14"Void A1077();
"
19D7I21"48 strcat(), strcpy()"
17D9I14"48 strncpy(); "
16D11I13"int strncmp()"
24D4I4"1078"
15D8I7"2 A7268"
27D2I2"79"
13D12I18"struct A553 *A1080"
21I17"A7 A9295;
extern "
6D67I3"108"
72I66"struct A553
{
struct A553 *A1082;
A7 A1083;
struct A114 A1084;
};
"
15D81I1"8"
86D75I59"struct A5513
{
A81 A5514;
struct A147 *A5515;
};
A5972 A777"
80D39I10"A5972 A778"
44D17I10"A5972 A778"
22D16I10"A5972 A778"
21D16I10"A5972 A778"
21D16I10"A5972 A778"
21I15"A5972 A7785();
"
7D14I11"A74 A6242; "
21D12I8"A7 A1086"
21D12I8"A7 A7184"
21D12I11"A5794 A5248"
25D6I4"7185"
15D10I10"A95 *A1087"
27D4I4"1088"
21D4I4"1089"
21D4I4"7186"
21D3I3"109"
21D4I4"7187"
15D10I11"A5794 A1091"
21D9I10"Void A1092"
27D3I3"093"
20D4I4"8269"
20D3I3"094"
14D10I8"A4 A1095"
21D10I8"A4 A1096"
28D3I3"097"
20D4I4"1098"
16D10I7"4 A1099"
21D10I11"A94 * A5272"
21D9I10"A94 * A110"
21D10I11"A94 * A1101"
29D2I2"02"
19D4I4"1103"
15D11I10"Void A1104"
30D2I2"05"
21D2I2"06"
19D4I4"5675"
21D4I4"6243"
15D10I8"A4 A5518"
27D4I4"7786"
21D4I4"5516"
21D4I4"5517"
21D4I4"5519"
22D3I3"520"
14D18I12"Void A5521()"
27D17
23D4I4"5522"
15D10I9"A23 A7787"
21D8I10"Void A1107"
19D10I10"Void A1108"
22D10I7"4 A1109"
21D11I10"Void A1110"
22D11I10"Void A1111"
22D11I10"Void A1112"
22I21"Void A2942();
extern "
7D4I4"1113"
15D55I12"Void A2949()"
64D13I12"Void A7070()"
22D9I12"Void A1114()"
18D10I12"Void A1115()"
19D9I12"Void A7269()"
19D8I12"94 * A1116()"
17D9I12"Void A1117()"
18D18I12"Void A1118()"
27D18I12"Void A1119()"
27D26I12"Void A7788()"
35D8I12"Void A5676()"
17D18
26D2I2"20"
21D2I2"21"
21D2I2"22"
13D9I10"Void A8270"
26D4I4"5249"
15D10I18"struct A144 *A5523"
19I17"A7 A5822;
extern "
6D4I4"7789"
21D4I4"7790"
19D4I4"7791"
15D10I10"A94 *A7792"
21D10I11"A5794 A7793"
22D7I10"5794 A7794"
19D7I10"5794 A7795"
18D10I11"A5794 A7796"
22D8I10"5794 A7797"
20D2I4"5794"
7D3I45"8();
struct A5304 { A77 A3049; A5794 A1148; }"
12D12I13"A2 A1123[100]"
21D12I9"A17 A1124"
21D12I10"A13 *A1125"
21D12I9"A81 A1126"
23D9I7"8 A1127"
19D1I1"5"
6D4I2"28"
13D11I18"struct A144 *A1129"
20D11I18"struct A144 *A1130"
20D11I26"const struct A5304 A3050[]"
21D10I7"4 A1131"
20D17I8"38 A1132"
26D45I9"Void A113"
65D1I1"3"
21D1I1"3"
13D9I8"A17 A113"
29D1I1"3"
13D10I8"A4 A2979"
29D1I1"3"
19D3I3"917"
23D2I2"39"
13I19"A4 A1140();
extern "
8D1I1"4"
6D124I231"extern Void A5529();
extern A4 A5530();
extern A7 A5532();
extern Void A5533();
extern A66 A5534();
extern A66 A7799();
extern Void A5531();
extern Void A1142();
extern Void A1143();
extern Void A1144();
extern A50 A1145();
extern "
131D339I15"46();
extern A7"
344D13I118"47();
extern A48 A1148();
extern A48 A1149();
extern A77 A1150();
extern A58 *A5067, *A5068;
extern A17 *A8945, *A8946"
22D4I6"8271()"
15D5I193"53();
extern Void A1154();
extern Void A1155();
extern Void A1156();
extern Void A1157();
extern Void A5823();
extern Void A1158();
extern Void A1159();
extern Void A1160();
extern Void A1161()"
15D4I4"8402"
15D19
25D4I75"8403; A54 A8404; A13 *A8405; A7468 A8406; A72 A8407; A58 *A8408;
A58 *A8409"
19D52I1"6"
57D1I1"7"
6D56I4"63;
"
61D10I229"
A7132,
A7133,
A1164,
A1165,
A1166,
A1167,
A1168,
A1169,
A1170,
A1171,
A1172,
A1173;
A13 A1174[ (2000 / CHARLEN) ];
A18 A5435;
A17 A6040;
A13 A7800[ (2000 / CHARLEN) ];
A61 A6041;
A17 A6042;
} ;
extern A13 A9180[(2000 / CHARLEN)]"
20D4I4"9248"
14D88I6"9249; "
95D17I17"9296; A17 A9250; "
24D6I6"9251; "
13D6I19"9297; FILE *A9252; "
16D9I18"struct A9248 A9253"
18D127I14"Void A9254();
"
135D27I104"391
{
struct A633 *A1175;
struct A144 *A1176;
struct A144 *A1177;
struct A144 *A1178;
};
struct A1179
{
"
32D262I91"180;
A53 A1181;
A17 A1182;
A53 A1183;
A5794 A1184;
A5794 A1185;
};
struct A1186
{
struct A8"
267D31I5"187;
"
40D27
33D12I8"188;
};
"
21D18I6"189
{
"
26D71I105"640 *A1190;
A5794 A1191;
};
struct A1192
{
A17 A1193;
A9 A1194;
A70 A1195;
};
struct A1196 { A2 A1197[3];"
77I833" *A1198; };
struct A1199
{
A5794 A1200;
A35 A1201;
A42 A1202;
};
Void A1203();
Void A1204();
Void A1205();
struct A5677
{
A5794 A5678;
A42 A5679;
A5794 A5680;
A5794 A5681;
};
extern A17 A6244;
extern long A7418;
extern A49 *A1206;
extern A49 *A1207;
extern A2 A1208[ARG_LEN];
extern A42 A8197; extern A2 A3496[ARG_LEN];
extern struct A1196 A1209[];
extern const A6 A1210;
extern A7 A5406;
extern A7 A5407;
extern A7 A6210;
extern A42 A1211;
extern A4 A1212;
extern A72 A1213;
extern A72 A1214;
extern A18 A1215;
extern A18 A1216;
extern A4 A7228;
extern A61 A1217;
extern A61 A1218;
extern A67 A1219;
extern A13 *A6043;
extern A13 *A1220;
extern A13 *A1221;
extern struct A1162 A1222;
extern struct A144 *A1223;
extern struct A144 *A1224;
extern struct A144 *A1225;
extern A48 A1226;
extern A7 A1227;
extern A9070 A1228;
extern UFLAG"
1095I7"9298,
A"
2534D19
33D4I4"9255"
14D7I9"2 A7190[]"
16D8I18"struct A144 *A1398"
21D4I4"1399"
14D8I7"4 A7807"
18D7I6"7 A621"
21D7I6"9181; "
15I1"1"
6D1I1"0"
11D1I2"68"
6D1I1"1"
11D1I1"4"
6D1I2"2 "
11D1I1"7"
6D1I1"3"
10D4I2"A7"
9D3I1"4"
12D4I2"A7"
9D3I1"5"
12D4I2"A4"
9D3I1"6"
12D9I10"Void A1407"
20D9I10"Void A1408"
26D4I4"1409"
17D6I7"8 A1410"
17D10I9"A58 A1411"
21D8I10"Void A8257"
19D10I8"A4 A8411"
27D4I4"5063"
15D4I2"A6"
9D1I1"2"
12D2I4"Void"
7D1I1"3"
18D4I4"1414"
21D4I4"1415"
15D10I8"A4 A1416"
21D19I10"Void A5687"
36D4I4"5688"
15D10I10"Void A5689"
21D10I19"struct A5677 *A5690"
30D1I1"7"
12D10I10"A13 *A5396"
21D10I9"Void A141"
28D4I4"1419"
21D4I4"6052"
15D10I11"A5794 A7808"
30D1I1"4"
18D4I4"5545"
21D4I4"5546"
15D8I10"Void A5547"
19D2I4"Void"
7D1I1"0"
12D2I4"Void"
7D25I1"1"
36D9I7"A4 A624"
21D9I9"A48 A9182"
20D9I8"A4 A1422"
20D4I2"A4"
9D12I5"3();
"
26D5I6" A1424"
16D10I12"Void A3500()"
19D8I10"Void A1425"
19D8I9"int A3493"
19D10I9"int A3494"
27D4I4"1426"
15D10I19"struct A1189 *A1427"
21D12I10"A13 *A8273"
22D7I6"4 A599"
19D9I7"A4 A599"
21D8I10"Void A9311"
27D2I2"28"
13D12I10"Void A7191"
31D2I2"29"
13D8I10"Void A6080"
25D4I4"9183"
15D10I9"A54 A1430"
21D1I1"V"
6D4I4"1431"
15D10I8"A4 A7475"
30D1I1"2"
12D9I12"UFLAG *A1433"
29D1I1"4"
12D10I8"A4 A1435"
29D2I2"36"
13D1I1"v"
6D4I4"6246"
15D1I1"v"
6D4I4"7809"
21D4I4"1437"
23D2I2"38"
14D10I10"34 A5691()"
19D20
28D2I2"39"
19D4I4"1440"
15D10I12"Void A1441()"
19D17
26D1I1"2"
21D1I1"3"
12D11I10"Void A5773"
30D2I2"44"
13D12I11"A5794 A1445"
21I20"A5794 A1446;
extern "
6D4I4"1447"
21D4I4"3532"
15D12I10"A2 A3526[]"
21I17"A4 A3527;
extern "
6D2I2"14"
21D4I4"1449"
15D10I11"A5794 A1450"
30D1I1"1"
18D4I4"1452"
15D10I8"A4 A9184"
27D4I4"5274"
21D73I6"1453()"
82D19I12"Void A5651()"
28D20I12"Void A5548()"
29D20
26D4I130"3443();
extern Void A6072();
extern Void A1454();
extern Void A3363();
extern Void A1455();
extern Void A1456();
extern Void A5107"
17D89I65"065
{
A67 A1066;
A5794 A1067;
A5794 *A1068;
A17 A1069;
};
extern "
97D44I20"1065 *A1070;
extern "
52D40I53"1065 A1071[];
extern A67 A1072[];
extern Void A6209()"
53D12I85"
{
A79 A547;
A79 A548;
A79 A549;
A79 A6232;
A79 A5661;
A87 A6233;
A87 A5662;
A23 A552"
23D16I24"53 *A554, *A555, *A6234,"
21D1I12"63, *A557;
}"
11D29I14"93
{
A17 A8274"
34D35I21"98 A8275;
A8198 A8276"
50D44I10"8277[1];
}"
54D41I6"561
{
"
56D4I165"62;
struct A561 *A563;
A40 A564;
A40 A565;
A81 A566;
A58 A567;
A42 A568;
A68 A569;
struct A147 A570;
A17 A571;
A24 A572;
A61 A573;
A96 *A574;
struct A1537 * A7443;
}"
13D11I8"A81 A575"
20D9I17"struct A561 *A576"
28D1I1"7"
18D2I1"5"
22D2I2"79"
19D3I4"8278"
22D1I1"0"
20D1I1"1"
19D3I2"82"
22D9I1"3"
20D7I10"Void A5664"
18D19
27I65"4(), A585();
extern A4 A586();
extern A4 A5665();
extern Void A58"
1854I50"9136
{
struct A9136 *A9137; A17 A9138; };
struct A"
109D9I19"struct A9136 *A9139"
18D18
26D9I10"9136 A9140"
19D9I8"58 A7273"
18D4I3"A17"
9D3I1"4"
12D11I17"struct A588 A1719"
20D4I2"A2"
9D3I3"6[]"
20D2I2"77"
13D10I9"A89 A1978"
29D2I2"79"
19D4I4"1980"
21D4I4"7274"
24D1I1"1"
13D8I7"4 A9185"
19D18I8"A4 A9186"
35D4I4"5897"
24D1I1"2"
12D3I4"Void"
8D1I1"3"
12D10I9"A72 A1984"
21D10I18"struct A561 *A1985"
27D3I3"914"
23D2I2"86"
21D2I2"87"
13D27
33D26I4"9142"
37D10I9"A78 A1988"
27D4I4"1990"
21D4I4"1989"
21D4I4"1991"
15D8I10"Void A1992"
25D4I4"1993"
15I27"struct A144 *A7824; extern "
6D4I26"5553();
struct A147 *A7825"
23D2I2"26"
19D4I4"7827"
21D64I6"7828()"
73D8I10"Void A7829"
20D7I7"4 A7830"
18D9I12"Void A8412()"
18D9I12"Void A7831()"
18D9I12"Void A7832()"
18D19I12"Void A8413()"
28I14"Void A8414();
"
8D20I7"1457
{
"
26D12I4"58;
"
18D3I25"59;
A4 A1460;
A9 A1461;
}"
12D19I10"A9 A1461()"
28D18I10"A9 A1462()"
28D1I1"9"
6D1I1"3"
11D19I8"A4 A1464"
30D9I7"4 A1465"
19D20
28D11I10"83 **A5078"
21D9I18"struct A83 **A5079"
25D2I2"66"
13D9I7"4 A1467"
19D3I11"struct A144"
8D2I2"68"
12D11I18"struct A144 *A7476"
21D9I7"4 A1469"
19D10I19"struct A640 **A3651"
20D9I18"struct A640 **A365"
21D8I9"17 *A1470"
19D8I9"68 *A1471"
26D13I14"640 **A1472 ;
"
22D7I7"3 A1473"
18D11I7"4 A1474"
22D7I9"13 *A1475"
18D7I9"13 *A1476"
18D7I9"13 *A1477"
18D4I2"53"
9D2I2"78"
13D2I2"68"
7D2I2"79"
12D9I3"A17"
15D1I1"0"
12D1I2"57"
6D1I1"1"
11I19"A57 A3660 ;
extern "
17D3I4"5 ; "
11D10I8"57 A1482"
22D6I10"036 *A1483"
17D10I7"4 A1484"
20D18I8"A4 A8214"
29D8I7"4 A1485"
19D7I11"9036 *A1486"
18D7I9"81 *A1487"
17D8I16"const A81 *A1488"
19D7I7"6 A1489"
25D11I10"144 *A7276"
21D4I4"9036"
9D1I1"0"
11D17I8"A9 A1491"
27I21"A9036 A1492 ;
extern "
8D9I10"640 *A1493"
19D17I9"A63 A1494"
27D17I8"A4 A1495"
28D8I7"4 A1496"
22D4I4"5825"
18D4I5"1497 "
21D8I9"640 *A149"
19D12I12"A5794 A1499 "
21D12I18"struct A83 *A1500 "
21D10I18"struct A83 *A1501 "
19D13I18"struct A83 *A1502 "
22D10I18"struct A83 *A5080 "
20D9I9"53 A1503 "
18D12I9"A4 A1504 "
21D12I8"A4 A6247"
21I27"struct A83 *A6248 ;
extern "
6D4I4"9040"
23D2I2"05"
14D7I7"4 A1506"
18D10I11"A5794 A1507"
21D9I10"Void A7451"
20D10I8"A4 A7833"
22D8I7"4 A6249"
25D4I4"6250"
23D2I2"08"
13D8I10"Void A1509"
28D1I1"0"
12D4I2"A6"
9D1I1"1"
21D1I1"2"
12D10I9"A68 A1513"
21D7I9"Void A151"
20I203"81 A5692();
extern Void A8215();
extern Void A1515();
extern A4 A1516();
extern Void A1517();
extern Void A1518();
extern Void A1519();
extern Void A1520();
extern A4 A3738();
extern A4 A7834();
extern A"
561D1I1" "
11D1I1" "
11D1I1" "
10D1I1" "
10D1I1" "
10D1I1" "
848D4I4"9082"
15D19I10"Void A9083"
30D19I10"Void A9084"
30I21"Void A3863();
extern "
17D2I2"89"
13D10I19"struct A1537 *A1590"
21D10I19"struct A1537 *A1591"
27D2I2"71"
21D4I4"1592"
21D4I4"1593"
15D9I10"Void A7841"
29D1I1"2"
12D4I3"A74"
9D1I1"7"
18D4I4"7843"
21D4I4"8218"
15D9I10"Void A8219"
29D1I1"5"
13I1"7"
6D1I1"6"
12D3I4"Void"
8D1I1"7"
12D10I8"A4 A7848"
21D10I9"A74 A7849"
21D1I1"V"
8D24I4"94()"
33D9I4"void"
14D1I3"1()"
10D4I4"void"
9D9I17"2();
typedef A22*"
14I57"3;
extern const A51 A1524;
extern long A1525;
struct A152"
1445D10I8"A4 A9085"
27D4I4"3763"
15D9I10"Void A8835"
21D2I2"35"
7D1I3"4()"
10D11I3"A58"
16D1I1"5"
10D2I11"struct A147"
7D3I1"6"
12I19"A4 A3767();
extern "
2788D2I4"9070"
433D8I10"Void A9086"
19D9I9"A74 A9087"
28D1I1"6"
12D8I9"Void A737"
19D9I8"A4 A4551"
20D9I9"Void A738"
25D3I4"4724"
14D10I8"A58 A741"
29D1I2"77"
20D1I1"3"
18D4I3"744"
15I21"Void A8202();
extern "
1326D1I1" "
15D1I1" "
11D1I1" "
2390D2I4"9070"
215D2I4"9070"
12D1I2"72"
52D4I4"9088"
6323D3I6"size_t"
7150I1"!"
5D16
31D1I1"0"
9D20I14"718->A570.A548"
28D4I25"return (A4) 1;
if( A1032("
9D3I19"8, &A2070 ) == 4 ) "
12I12"1;
goto A171"
115I1"!"
5D16
31D1I1"0"
9D20I14"718->A570.A549"
28D4I25"return (A4) 1;
if( A1032("
9D3I19"8, &A2070 ) == 4 ) "
12I12"1;
goto A171"
1100D97
128I53"memset((A49)(& A1719 ),0,(size_t)(sizeof( A1719 )));
"
13D15I13"A1719.A599 )
"
27D3I10"1;
A1712:
"
15D23
731D3I6"size_t"
4774D2I4"9070"
2216D2I4"9070"
11D2I4"9070"
61D2I4"9070"
14D2I4"9070"
29D2I4"9070"
14D2I4"9070"
11D2I4"9070"
32D2I4"9070"
14D2I4"9070"
14D2I4"9070"
23D2I4"9070"
14D2I4"9070"
26D2I4"9070"
14D2I4"9070"
15D2I4"9070"
14D2I4"9070"
13D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
20D2I5"9070
"
13D2I4"9070"
10D1
18D2I4"9070"
11D2I4"9070"
14D2I4"9070"
13D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
20D2I4"9070"
13D4I7"9070) 
"
27D2I4"9070"
14D2I4"9070"
11D2I4"9070"
13D2I4"9070"
13D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
28D2I4"9070"
14D2I4"9070"
12D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
29D2I4"9070"
14D2I4"9070"
16D2I4"9070"
13D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
29D2I4"9070"
14D2I4"9070"
14D2I4"9070"
13D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
20D2I4"9070"
13D2I5"9070
"
28D2I4"9070"
16D2I4"9070"
13D2I4"9070"
15D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
35D2I4"9070"
14D2I4"9070"
14D2I4"9070"
13D2I4"9070"
15D2I4"9070"
14D2I4"9070"
12D2I4"9070"
27D2I4"9070"
14D2I4"9070"
18D2I4"9070"
13D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
20D2I4"9070"
13D2I5"9070
"
27D2I4"9070"
14D2I4"9070"
17D2I4"9070"
13D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
20D2I4"9070"
13D2I5"9070
"
27D2I4"9070"
14D2I4"9070"
18D2I4"9070"
13D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
20D2I4"9070"
13D2I5"9070
"
28D2I4"9070"
16D2I4"9070"
13D2I4"9070"
15D2I4"9070"
14D2I4"9070"
24D2I4"9070"
16D2I4"9070"
13D2I4"9070"
15D2I4"9070"
15D2I4"9070"
12D2I4"9070"
16D2I4"9070"
24D2I4"9070"
16D2I4"9070"
13D2I4"9070"
15D2I4"9070"
14D2I4"9070"
24D2I4"9070"
16D2I4"9070"
13D2I4"9070"
15D2I4"9070"
15D2I4"9070"
12D2I4"9070"
34D2I4"9070"
16D2I4"9070"
13D2I4"9070"
15D2I4"9070"
15D2I4"9070"
12D2I4"9070"
28D2I4"9070"
16D2I4"9070"
13D2I4"9070"
15D2I4"9070"
15D2I4"9070"
12D2I4"9070"
28D2I4"9070"
16D2I4"9070"
13D2I4"9070"
15D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
36D2I4"9070"
16D2I4"9070"
13D2I4"9070"
15D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
36D2I4"9070"
16D2I4"9070"
13D2I4"9070"
15D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
36D2I4"9070"
16D2I4"9070"
13D2I4"9070"
15D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
36D2I4"9070"
16D2I4"9070"
13D2I4"9070"
15D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
36D2I4"9070"
16D2I4"9070"
13D2I4"9070"
15D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
20I6"| 0x2 "
16D2I4"9070"
16D2I4"9070"
13D2I4"9070"
15D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
20I6"| 0x2 "
16D2I4"9070"
16D2I4"9070"
12D2I4"9070"
16D2I4"9070"
12D2I4"9070"
13D2I4"9070"
18D2I4"9070"
13D2I4"9070"
27D2I4"9070"
12D2I4"9070"
18D2I4"9070"
13D2I4"9070"
15D2I4"9070"
16D2I4"9070"
12D2I4"9070"
16D2I4"9070"
12D2I4"9070"
13D2I4"9070"
16D2I4"9070"
24D2I4"9070"
14D2I4"9070"
13D2I4"9070"
16D2I4"9070"
14D2I4"9070"
12D2I4"9070"
16D2I4"9070"
12D2I4"9070"
26D2I4"9070"
12D2I4"9070"
14D2I4"9070"
13D2I4"9070"
16D2I4"9070"
14D2I4"9070"
12D2I4"9070"
16D2I4"9070"
12D2I4"9070"
27D2I4"9070"
14D2I4"9070"
13D2I4"9070"
15D2I4"9070"
12D2I4"9070"
16D2I4"9070"
12D2I4"9070"
26D2I4"9070"
14D2I4"9070"
13D2I4"9070"
15D2I4"9070"
12D2I4"9070"
16D2I4"9070"
12D2I4"9070"
58D2I4"9070"
14D2I4"9070"
16D2I4"9070"
13D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
20D2I4"9070"
13D2I5"9070
"
14D2I4"9070"
11D1
16D2I4"9070"
14D2I4"9070"
11D2I4"9070"
13D2I4"9070"
13D2I4"9070"
16D2I4"9070"
27D2I4"9070"
14D2I4"9070"
12D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
28D2I4"9070"
14D2I4"9070"
16D2I4"9070"
13D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
29D2I4"9070"
14D2I4"9070"
13D2I4"9070"
13D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
30D2I4"9070"
13D2I4"9070"
23D2I4"9070"
14D2I4"9070"
14D2I4"9070"
13D2I4"9070"
15D2I4"9070"
26D2I4"9070"
14D2I4"9070"
18D2I4"9070"
13D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
20D2I4"9070"
13D2I5"9070
"
27D2I4"9070"
14D2I4"9070"
17D2I4"9070"
13D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
20D2I4"9070"
13D2I5"9070
"
27D2I4"9070"
14D2I4"9070"
18D2I4"9070"
13D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
20D2I4"9070"
13D2I5"9070
"
28D2I4"9070"
13D2I4"9070"
25D2I4"9070"
13D2I4"9070"
25D2I4"9070"
13D2I4"9070"
25D2I4"9070"
13D2I4"9070"
25D2I4"9070"
13D2I4"9070"
25D2I4"9070"
13D2I4"9070"
25D2I4"9070"
14D2I4"9070"
13D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
30D2I4"9070"
14D2I4"9070"
13D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
30D2I4"9070"
14D2I4"9070"
13D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
30D2I4"9070"
14D2I4"9070"
13D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
30D2I4"9070"
14D2I4"9070"
13D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
30D2I4"9070"
13D2I4"9070"
24D2I4"9070"
13D2I4"9070"
24D2I4"9070"
13D2I4"9070"
24D2I4"9070"
13D2I4"9070"
24D2I4"9070"
13D2I4"9070"
24D2I4"9070"
13D2I4"9070"
8I6", 0x2 "
16D2I4"9070"
13D2I4"9070"
8I6", 0x2 "
15D2I4"9070"
13D2I4"9070"
16D2I4"9070"
24D2I4"9070"
13D2I4"9070"
16D2I4"9070"
24D2I4"9070"
13D2I4"9070"
16D2I4"9070"
24D2I4"9070"
13D2I4"9070"
16D2I4"9070"
25D2I4"9070"
14D2I4"9070"
13D2I4"9070"
24D2I4"9070"
13D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
153D2I4"9070"
55D2I4"9070"
15D2I4"9070"
14D2I4"9070"
25D2I4"9070"
146D2I4"9070"
204D2I4"9070"
201D2I4"9070"
17D2I4"9070"
73D2I4"9070"
12D2I4"9070"
16D2I4"9070"
12D2I4"9070"
13D2I4"9070"
18D2I4"9070"
13D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I5"9070
"
16D2I4"9070"
12D1
9D2I4"9070"
13D2I4"9070"
16D2I4"9070"
2387D2I4"9070"
23D2I4"9070"
509D2I4"9070"
17D2I4"9070"
231D2I4"9070"
12D2I4"9070"
16D2I4"9070"
12D2I4"9070"
13D2I4"9070"
18D2I4"9070"
13D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I5"9070
"
17D2I4"9070"
12D7I8"| (A9070"
25D2I4"9070"
13D2I4"9070"
16D2I4"9070"
266D2I4"9070"
182D2I4"9070"
30D8
18D1I7"3 & 0x4"
34D21I38"
A5667( 586, "format specifier",
A975("
29D2I7", "" );"
16D18
33D1I25"2 &&
!A6245( 1999, 2010 )"
38D7I34"8( 465, "format specifier ",
A975("
15I11", A9182() )"
14D41I19"1948 & A3746->A3832"
87D7I14"82( 566, A3837"
19D7I21"if( A3836 == 0x300 &&"
19D22I3"3 &"
27D66I72") goto A1773;
goto A1774;
A1773:
A882( 642, A3837 );
A1774:
if( A3836 =="
71I114"0 && A1833 == 'X' &&
A7475(9) ) goto A1775;
goto A1776;
A1775: A2167(2); A865( 412 ); 
A1776:
A1754 = A3746->A3831"
5D8I22"1948 & (((((A9070) 0x1"
13D14I4"9070"
22D1I1")"
6D11I9"9070) 0x2"
16D12I10"9070) 0x4)"
17D19I4"9070"
27D2
7D10I12"((A9070) 0x1"
16D11I10"9070) 0x20"
16D2I36"9070) 0x8 | (A9070) 0x40000 | (A9070"
10D21I11"0 | (A9070
"
27D23I86"0000 | (A9070) 0x80000 | (A9070) 0x200000) | ( (A9070) 0x80 | (A9070) 0x40 )) | (A9070"
29I62"00 ));
if( A1948 & (A9070) 0x10 && A3746->A3831 & (A9070) 0x10"
12D1I1"7"
12D1I1"8"
7D1I1"7"
15D2I4"9070"
21D2I4"9070"
18D1I1"8"
17D2I4"9070"
28D2I4"9070"
19D1I1"9"
11D2I2"80"
8D1I1"9"
15D2I4"9070"
20D2I4"9070"
17D2I2"80"
76D2I4"9070"
12D2I4"9070"
16D2I4"9070"
12D2I4"9070"
13D2I4"9070"
18D2I4"9070"
13D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I5"9070
"
16D2I4"9070"
12D1
9D2I4"9070"
13D2I4"9070"
16D2I4"9070"
58D2I4"9070"
420D2I8"(A9070)0"
257D2I4"9070"
196D2I4"9070"
230D2I4"9070"
98D2I4"9070"
100D2I4"9070"
92D2I4"9070"
29D2I4"9070"
142D2I4"9070"
108D2I4"9070"
13D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
111D2I4"9070"
77D2I4"9070"
197D2I4"9070"
13D2I4"9070"
13D2I4"9070"
12D2I4"9070"
16D2I4"9070"
16D2I4"9070"
17D2I4"9070"
16D2I4"9070"
18D2I4"9070"
141D2I4"9070"
85D2I4"9070"
177D2I4"9070"
83D2I4"9070"
99D2I4"9070"
87D2I4"9070"
167D2I4"9070"
87D2I4"9070"
1143D2I4"9070"
360I7"((A72) "
13I1")"
1008I31"struct A3828 *A3746;
A9 A1833;
"
363D11I58"if( (strcmp( A2556, "deprecate" ) == 0) ) goto A1717;
goto"
16D29I15"0;
A1717:
A3746"
34D127I36"724 == A1386 ? A3834 : A3835;
A1723:"
132D7I33"A1833 = (A9)(A15)( A3746->A3829 )"
17D1I1"2"
12D1I1"2"
7D1I29"25: A3746++;
goto A1723;
A172"
9D17I45"1833 == (A9)(A15)(*A1741) && A1741[1] == '\0'"
28D2I2"26"
12D2I2"27"
7D14I63"26:
A3746->A3833 |= 0x4;
return;
A1727: ;
goto A1725;
A1722:
A8"
19I25"213( A1724, A1741, 2 );
A"
6D46I30"28 |= (A28) 0x20000000;
return"
51D8I6"20:
A8"
13D6I24"213( A1724, A1741, 2 );
"
21D1I132"= A1076( A1344, A2556 );
}
static Void
A3783( A80 )
A81 A80;
{static struct A3828 A3852 = { '&', 0, (A9070) 0x400, 0, 0 };
A58 A1740"
9D4I4"3839"
16D1I1"1"
11D2I2"12"
8D25I13"1:
if( A3849("
33D19I42"29 ) ) goto A1713;
goto A1714;
A1713:
if( "
26D12I41"28 & (A28) 0x20000000 ) goto A1715;
goto "
17D50
56D3I50"5:
A5667( 586, "format specifier",
A80->A129, "" )"
9D106I70"6:
if( !(A1740 = A80->A130) && A80->A155.A142 ) goto A1717;
goto A1720"
111D130I33"17:
A1740 = A3753( A80->A155.A142"
140D135I4"1740"
146D1I1"2"
12D1I1"2"
7D47I70"21: A1740 = 15; A884( 154, A80->A155.A142 ); 
A1722:
A80->A130 = A1740"
52D32I52"20:
A3852.A3830 = A1740;
A3839 = &A3852;
A3837 = '&'"
43D12
19D12I15";
}
Void
A5624("
17D45I9"6, A2547,"
53D5I47"A3805 )
struct A561 *A2546, *A2547, *A3805;
A74"
10D28I14"5;
{
A81 A5626"
33D50
56D25I1","
31D2I44";
struct A1531 *A1731;
A2624 = A5512( A3805,"
32D9
17D1I5"0x200"
10D15I9"0x800) | "
23D6I67"1000 );
if( !A2624 ) return;
A5626 = A5511;
A2591 = A5512( A2547, ("
12D9I79"4 | (A17) 8)|((A17) 1 | (A17) 2)|(A17) 0x40|(A17) 0x80 );
if( A2591 && A5626 ) "
17D2I2"11"
12D2I2"12"
7D37I3"11:"
46D24I10"1 != A5626"
35D2I2"13"
12D2I2"14"
7D7I21"13:
A892( 440, A5511,"
13D12I16", 0 );
A1714: ;
"
20D14I2"15"
19D21I7"12: if("
27D5I34" && A2547 ) goto A1716;
goto A1717"
10D10I1"1"
17D5I113"!A107( A5625, (A49) A5626 ) ) goto A1720;
goto A1721;
A1720: A904( 441, A5626 );
A1721: ;
A1717:
A1715:
if( A2591"
10D1
6D5I1"4"
14D8I13"8) && A2624 &"
18D1I1"1"
14D4I34"400) || A2591 & ((A17) 1 | (A17) 2"
10D36I37"2624 & ((A17) 0x200 | (A17) 0x800) )
"
44D2I2"22"
12D2I2"23"
7D3I37"22:A865( 442 );
A1723:
A8770 = A5626;"
19D1I1"6"
11D1I1"4"
7D18
28D2I2"25"
12D2I2"26"
7D14I7"25:
if("
21D1I33"&& A8770 ) goto A1727;
goto A1766"
6D4I32"27:
A892( 443, A5511, A5626, 0 )"
10D22I3"6: "
27D46I2"26"
53D4I105"2624 & (((A17) 0x100 | (A17) 0x400) | ((A17) 0x200 | (A17) 0x800)) && A3805 &&
A492( A3805->A567 ) == 25 "
14D2I2"67"
12D2I2"68"
7D43I2"67"
50D17I27"5512( A2547, (A17) 0x2000 )"
22D11I4"5511"
31D2I2"69"
13D1I1"0"
6D8I40"69:
A904( 444, A5626 );
A1770: ;
A1768:
"
13D32I14" = A1559.A1553"
37D14I11"31->A5550 ="
20D8I2";
"
13I8" = A1731"
5D22I2"32"
28D14I14"3:
if( A1731) "
23D3I8"1;
goto "
8D96
101I7"74: A17"
7D10I30"731->A1532;
goto A1773;
A1771:"
20I13"->A1533 == 36"
5D16
27D1I9" == A5626"
12D2I2"75"
12D2I2"76"
7D28I12"75:
if( A173"
35D9I84"0 ) goto A1777;
goto A1778;
A1777: A894( 445, A5626,
A923( A1731->A1540->A569, A1494"
14D37
42I44"1778: ;
A1776: ;
goto A1774;
A1772: ;
}
A4 A"
15I94"Void
A5627( A3971 )
struct A1537 *A3971;
{
A81 A80;
struct A1531 *A1731;
A1731 = A1559.A1553;
"
6D20I35"731 && A3971 && (A80 = A1731->A5550"
33D1I1"1"
12D1I1"2"
7D31I45"1:
A234 = NULL;
A8592( A3971->A1548, (A4) 0, "
37D10I106"8607 = (A4) 1;
A3863( A3971->A1548 );
A8607 = (A4) 0;
if( A107( A234, (A49) A80 ) ) goto A1713;
goto A1714"
15D4I8"13:
{
A2"
12I49" A8595( A80->A130 );
A5794 A1737;
A1737 = A2097 ="
5526D125I117"9171( A9199, A9200, A1753 )
struct A588 *A9199;
struct A588 *A9200;
A36 A1753;
{extern Void A9201();
A4 A9202;
switch"
130D32I250"53 )
{
case (A36) 16:
case (A36) 18:
case (A36) 37:
case (A36) 32:
case (A36) 38:
case (A36) 10:
case (A36) 0x1000:
case (A36) 11:
case (A36) 31:
case (A36) 39:
return;
case (A36) 22:
case (A36) 25:
case (A36) 26:
case (A36) 14:
A9202 = (A4) 1;
goto "
37D12I16";
default:
A9202"
17D86I6"4) 0;
"
95D14I4"1;
}"
19D1I1"1"
7D11I5"A9199"
23D1I1"2"
12D1I1"3"
7D19I29"2:
A9201( A9199, A9202, A1753"
32D1I1"4"
7D112I15"3:
A882(200,93)"
118D43I2"4:"
49D26I2"92"
40D1I1"5"
12D1I1"6"
7D21I31"5:
A9201( A9200, A9202, A1753 )"
27D2I83"6: ;
}
Void
A9201( A2927, A9203, A1753 )
struct A588 *A2927;
A4 A9203;
A36 A1753;
{"
8D4I66"2927->A592 == 2 ||
A2927->A593 & (A24) 0x40 ||
( (A2927->A600 > 0)"
10D5I8"(( A7174"
11D65I14"58) A2927->A60"
70D6I90"7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) )->A307 & 0x10000) != 0 ) ) "
17D1I1"1"
12D1I1"2"
7D29I25"1:
if( A9203 == (A4) 0 ) "
38D1I13"3;
goto A1714"
13D107I141"48 A6276 = A866("'$s'",
A1609[A1753].A1602,
NULL,
NULL );
A6276 = A1076( A1378, A6276 );
A6172( A9167,
A6276 );
}
A1714: ;
goto A1715;
A1712:"
112D39I5"A9203"
51D1I1"6"
11D2I2"17"
8D1I1"6"
6D24I21"5794 A4709;
A48 A6276"
31D35I9"606 == 15"
47D1I1"0"
12D1I1"1"
7D33I90"0:
A4709 = "; the -strong(B,...) option can "
"help provide Boolean-by-enforcement";
goto "
38D5I1";"
10D74I27"1: A4709 = ""; 
A1722:
A627"
79D168I104"866("'$s'$s", A1609[A1753].A1602,
A4709, NULL );
A6276 = A1076( A1378, A6276 );
A6172( A9168, A6276 );
}"
173D31I3"7: "
37D2I48"5: ;
}
Void
A3784( A1806 ) 
enum A6173 A1806;
{
"
7D18I10"2142 != 20"
30D1I1"1"
12D1I1"2"
7D54I21"1:
A6172( A1806, "" )"
60D7I126"2: ;
}
Void
A9172( A9199, A9200, A1753 )
const struct A588 *const A9199;
const struct A588 *const A9200;
A36 A1753;
{
A58 A179"
12D3I11"9199 ? A919"
8D14I133"052 : 0;
A58 A1797 = A9200 ? A9200->A7052 : 0;
A58 A9204 = (!((A1300 > 0) || A1300 > -1 && (A1309 > 0)) ? A414 : (A1301 > 0) ? 8 : 7)"
19D57I11" A1709 = 0;"
63D4I46"1796 == A413 || A1797 == A413 ||
( (A1309 > 0)"
12D22I31"796 == A9204 || A1797 == A9204 "
36D2I2"11"
12D2I2"12"
7D12I4"11: "
21D2I2"13"
7D155I19"12: return; 
A1713:"
166D2I2"75"
13D126I9"(A36) 18:"
132D33I208"(A36) 0x1000:
case (A36) 32:
case (A36) 31:
case (A36) 38:
case (A36) 39:
case (A36) 37:
case (A36) 16:
return;
case (A36) 10:
case (A36) 11:
case (A36) 22:
A1709 |= 0x1 |
0x2 |
0x4;
goto A1714;
case (A36) 2:"
39D11I20"9173( A9199, A9200 )"
16D11I20"9173( A9200, A9199 )"
22D2I2"15"
12D2I2"16"
7D16I26"15: A1709 |= 0x4; 
A1716:
"
24D4I83"14;
case (A36) 4:
if( A9200 && A9200->A593 & (A24) 0x10000 &&
A9200->A589 == '0' ) "
12D2I14"17;
goto A1720"
7D19I25"17: A1709 |= 0x4; 
A1720:"
28D2I90"14;
case (A36) 9:
case (A36) 13:
if( A9174( A9199, A9200, A1753 ) ) goto A1721;
goto A1722"
7D28I25"21: A1709 |= 0x4; 
A1722:"
37D32I11"14;
default"
42D39I2"14"
46D2I2"14"
9D22I10"1709 & 0x1"
33D2I2"23"
12D2I2"25"
7D58I2"23"
65D14I13"1796 != A1797"
25D2I2"26"
12D2I2"27"
7D4I4"26: "
12D4I4"9157"
11I17" 
A1727: ;
A1725:"
5D34I13"!(A1709 & 0x2"
46D2I2"66"
12D2I2"67"
7D2I70"66:
if( A1796 == A413 || A1797 == A413 ) goto A1768;
goto A1769;
A1768"
12D8I28"9158,
A242( A2240( A1753 ) )"
16D2I2"69"
9D70I2"67"
76D98I15"!(A1709 & 0x4) "
108D2I2"70"
12D2I2"71"
7D40I42"70:
A6172( A9159, A242( A2240( A1753 ) ) )"
45D3I117"71: ;
}
A4
A9173( A9199, A9200 )
const struct A588 *const A9199;
const struct A588 *const A9200;
{
A4 A2850 = (A4) 0;"
9D23I11"9199 && A92"
37D1I1"1"
12D1I1"2"
7D1I1"1"
8D9I9"9199->A59"
15D10I33"24) 0x10000 &&
A9199->A589 == '0'"
22D1I1"3"
11D2I2"14"
8D51I199"3:
{
A58 A1797 = A9200->A592;
A4 A9205 = (A9200->A593 & (A24) 0x10) &&
(A1797 <= 20) &&
(A9200->A589 >= 0) &&
(A9200->A589 <= 9);
A81 A1827 = A9200->A590;
struct A147 *A2113 = A1827 ? ( (A1827)->A156"
57D4I188"41) 19 ? (A1827)->A155.A148 : (struct A147 *) 0 ) : NULL;
A4 A9206 = A1827 &&
(A1797 <= 20) &&
A2113 &&
(A2113->A6232 == 4) &&
(A2113->A6233 >= 0) &&
(A2113->A6233 <= 9);
if( A9205 || A920"
16D2I2"15"
12D2I2"16"
7D22I18"15: A2850 = (A4) 1"
28D18
24D5I2"}
"
10I14": ;
goto A1717"
9D119I14"A882(200,95); "
124D39I227"7:
return A2850;
}
A4
A9174( A9199, A9200, A1753 )
const struct A588 *const A9199;
const struct A588 *const A9200;
A36 A1753;
{
A4 A2850 = (A4) 0;
A87 A9207;
A87 A9208;
switch( A1753 )
{
case (A36) 9:
A9207 = '9';
A9208 = '0';
"
48D1I42"1;
case (A36) 13:
A9207 = '0';
A9208 = '9'"
12D2I61"1;
default:
A9207 = 0;
A9208 = 0;
A882(200,97);
goto A1711;
}"
7D12I24"1:
if( A9199 && A9200 ) "
21D3I8"2;
goto "
8D43I8";
A1712:"
50D38I51"A9199->A593 & (A24) 0x10000 && A9199->A589 == A9207"
46D38I51"A9200->A593 & (A24) 0x10000 && A9200->A589 == A9208"
52D1I1"4"
11D2I2"15"
8D27I26"4:
A2850 = (A4) 1;
A1715: "
37D2I2"16"
7D89I16"13:
A882(200,96)"
94D30I280"16:
return A2850;
}
Void
A9244( A9278, A9279, A5486 )
A54 A9278;
A54 A9279;
A5794 A5486;
{
struct A322 *A9280 = ((struct A322 *) A1006( A9255, A9278 ));
struct A322 *A9281 = ((struct A322 *) A1006( A9255, A9279 ));
A8 A1808;
A8 A1750;
A54 A9282;
A54 A9283;
if( !A9280 || !A9281 ) "
38D2I14"11;
goto A1712"
7D55I25"11:
A882(200,102);
return"
60D36I76"12:
A1808 = (( A9280->A324)<=( A9281->A324 )?( A9280->A324):( A9281->A324 ))"
41D30I6"50 = 0"
35D48I22"15:
if( A1750 < A1808)"
58D3I8"3;
goto "
8D14
20D17I22"6: A1750++;
goto A1715"
22D3I71"13:
A9282 = (A54) A9280->A323[A1750];
A9283 = (A54) A9281->A323[A1750];"
9D3I12"9282 != A928"
15D2I2"17"
12D2I2"20"
7D14I133"17:
{
A9036 A9284 = ((A9036) A996(A5434,(A54)( A9282 )));
A9036 A9285 = ((A9036) A996(A5434,(A54)( A9283 )));
if( !A9284 || !A9285 ) "
22D2I14"21;
goto A1722"
7D53I33"21:
A882(200,103);
return;
A1722:"
58D4I58"!(strcmp( A9284, "" ) == 0) && !(strcmp( A9285, "" ) == 0)"
15D2I2"23"
12D2I2"25"
7D30I33"23:
A6172( A9243, A5486 );
return"
35D17I17"25: ;
}
A1720: ;
"
26D8I3"6;
"
13D40I2": "
50D55I45"9175(A80, A1806)
A81 A80;
enum A6173 A1806;
{"
60D26I3"A80"
65D19I14"80->A9153.A116"
52D23I36"
if( A80->A9153.A116 != A396.A116 ) "
35D27I10"goto A1716"
35D3I6" A9177"
8D17I12"06, A80 ); 
"
22I2": "
18D35I24"4:
A921( &(A80->A9153) )"
43D33I1" "
42D21
31D51I47"8588( A1740 )
A58 A1740;
{
A7 A8610 = 0;
A1711:"
56D48I94" A7174 = (A1740), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) )->A303 == 25"
60D1I1"2"
12D1I1"3"
7D46I21"2:
if( ++A8610 > 2 ) "
55D1I13"4;
goto A1715"
7D12I28"4:
A6172( A8577, "" );
goto "
17D64
70D13I121"5:
A1740 = ( A7174 = (A1740), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) )->A306;
goto A1711;
A1713: "
23D4I4"8716"
9D132I62"A81 A4032;
A60 A3317;
if( A434->A191 & (A31) 0x10000000 ) goto"
137D103I39"1;
goto A1712;
A1711:
A3317 = A434->A17"
108D19I4"715:"
24D36I104"A3317 && ( A4032 = ((A81) ((( A434)->A173)->A988)[ A3317 ]), A4032 ? (void) 0 : A865(280), A4032 )) goto"
41D15I13"3;
goto A1714"
20D1I8"16: A331"
6D4I4"4032"
9D2I18"9.A157;
goto A1715"
16D4I27"4032->A168.A166 == (A39) 7 "
15D1I1"7"
11D2I2"20"
8D43I31"7:
{
A32 A4029 = A684( A4032 );"
49D23I35"4029 == (A32) 6 ||
A4029 == (A32) 2"
34D2I2"21"
12D2I2"22"
7D24I50"21: A6172( A8720, A4032->A129 ); 
A1722: ;
}
A1720"
37D1I1"6"
7D37I3"4: "
43D113I43"2: ;
}
Void
A3785()
{
A9 A1833;
A5794 A1736"
118D22I10"490; A5794"
27D33I82"1; A4 A8654 = (A4) 0;
A4 A8655 = (A4) 0;
A4 A8656 = (A4) 0;
A4 A8657 = (A4) 1;
int"
38D36I21"0 = 0; int A8658 = 0;"
42D11I3"828"
16D30I4"4801"
41D2I2"11"
12D2I2"12"
7D113I49"11: { struct A786 *A1749 = A4801;
A1713:if( A1749"
118D58I12"749->A788 ) "
66D11I2"14"
21D2I2"15"
7D4I33"14: if( A1749->A790 == (A42) 2 ) "
12D85I2"16"
95D13I32"17;
A1716: A1736 = A1749->A791; "
21D4I34"15;
A1717: ; goto A1713;
A1715: ; "
9D1I1"1"
6D3I33"731 = A1736;
A1722:
if( A8657 && "
8D104I15"33 = (A9)(A15)("
109D12I4"1) )"
23D2I2"20"
12D2I2"21"
7D2I30"23: A1731++;
goto A1722;
A1720"
8D28I74"( A1833 ==' '|| A1833 =='\t'|| A1833 =='\n'|| A1833 =='\f'|| A1833 =='\r')"
39D2I2"25"
12D2I2"26"
7D60I11"25:
A8658++"
70D2I2"27"
7D56I57"26:
{
A9 A8659;
switch( A1833 )
{
case ';':
if( A1730 > 0"
67D2I2"67"
12D2I2"68"
7D32I21"67: A8656 = (A4) 1; 
"
40D14I2"69"
19D2I2"68"
8D18I23"0++;
A8658 = 0;
A1769:
"
26D2I100"66;
case '/':
A8659 = (A9)(A15)(A1731[1]);
if( A8659 == '/' ||
A8659 == '*' ) goto A1770;
goto A1771"
7D39I7"70:
if("
44D1I26"0 ) goto A1772;
goto A1773"
6D4I30"72:
A8654 = (A4) 1;
goto A1774"
9D4I18"73:
A8655 = (A4) 1"
9D148I6"74: ;
"
156D14I2"75"
19D46I18"71: A8656 = (A4) 1"
51D159I4"75:
"
167D1I26"66;
default:
A8656 = (A4) "
12D54I2"66"
59D31I72"1766:
if( A8654 || A8655 || A8656 ) goto A1776;
goto A1777;
A1776: A8657"
41D145I40" 
A1777: ;
}
A1727: ;
goto A1723;
A1721:"
150D19I15"A8657 == (A4) 0"
30D2I2"78"
12D2I2"79"
7D48I88"78:
A6172( A8643, "" );
if( A8656 || A8655 || (A8654 && !A8658) ) goto A1780;
goto A1781"
53D22I32"80: A6172( A8644, "" ); 
A1781: "
27D47I49"79: ;
}
Void
A8715()
{
A81 A4032;
A60 A3317;
A331"
52D10I17"434->A176;
A1713:"
15D26I98"A3317 && ( A4032 = ((A81) ((( A434)->A173)->A988)[ A3317 ]), A4032 ? (void) 0 : A865(280), A4032 )"
37D1I1"1"
12D1I1"2"
7D10I33"4: A3317 = A4032->A159.A157;
goto"
15D18I1"3"
24D24I41"1:
if( A4032->A163 & (A30) 0x0100 ) goto "
29D35I20";
goto A1716;
A1715:"
41D10I25"4032->A163 & (A30) 0x0400"
22D1I1"7"
11D2I2"20"
8D16I25"7: goto A1712;
goto A1721"
21D23I2"20"
30D4I24"684( A4032 ) == (A32) 6 "
15D1I1"2"
12D1I1"3"
7D36I23"2: A6172( A8717, "" ); "
41D31I23"3: ;
A1721: ;
A1716: ;
"
39D14I2"14"
19D24I100"12: ;
}
Void
A8266(A1835,A3490)
A5794 A1835;
A48 *A3490;
{
A7 A1732;
A4 A8303 = (A4) 1;
if( A1835 ) "
32D2I14"11;
goto A1712"
7D2I20"11:
A1732 = 1;
A1715"
10D4I10"490[A1732]"
14D2I2"13"
12D2I2"14"
7D26I23"16: A1732++;
goto A1715"
31D12I45"13:
{
A5794 A8301 = NULL;
A5794 A8302 = NULL;"
17D25I38"(A5299( A3490[A1732], "CinC++" ) == 0)"
36D1I1"1"
12D2I2"20"
7D12I29"17:
A6210 |= 0x10;
goto A1721"
17D232I46"20: if( (A5299( A3490[A1732], "C++inC" ) == 0)"
243D2I2"22"
12D2I2"23"
7D16I19"22:
A6210 |= 0x20;
"
24D14I2"25"
19D79I2"23"
85D27I107"( strncmp( A3490[A1732], "C++",(size_t)( 3 )) == 0 ) ||
( strncmp( A3490[A1732], "c++",(size_t)( 3 )) == 0 "
39D2I2"26"
12D2I2"27"
7D12I40"26:
A8302 = A3490[A1732] + 3;
goto A1766"
17D42I63"27: if( ( *(A3490[A1732]) == 'C' ) ||
( *(A3490[A1732]) == 'c' "
54D2I2"67"
12D2I2"68"
7D17I30"67:
A8301 = A3490[A1732] + 1;
"
25D13I1"6"
19D40I2"68"
46D42I21"isdigit(*A3490[A1732]"
54D2I2"70"
12D2I2"71"
7D18I36"70:
A8301 = A3490[A1732];
goto A1772"
23D1I36"71:
A8303 = (A4) 0;
goto A1714;
A177"
7D50I55"69:
A1766:
A1725:
A1721:
A8303 = A8265(A8301, A8302);
}"
59D2I11"16;
A1714: "
12D2I2"73"
7D102I17"12:
A8303 = (A4) "
108D23I38"73:
if( A8303 ) goto A1774;
goto A1775"
29D42I49"4: A6209(); 
goto A1776;
A1775: A1418(); 
A1776: "
47D135I26"58
A3857()
{
A58 A3858 = 0"
142D16I3"415"
51D7I22"3858 = A741( A415->A13"
18D102I84"
if( !A3858 ) goto A1713;
goto A1714;
A1713: A3858 = 15;
A1714:
return A3858;
}
Void"
107D27I126"1(A1859)
struct A1537 *A1859;
{
struct A1537 *A2285;
if( !A1859 ) return;
if( A1569 ) goto A1711;
goto A1712;
A1711:
if( A2285"
33D8I2"69"
13D9I48"63 ) goto A1713;
goto A1714;
A1713: A2285->A1549"
14D37I36"859;
goto A1715;
A1714: A1569->A1562"
42D73I3"859"
79D2I3"5:
"
7D13I11"1859->A1549"
25D1I1"6"
12D1I1"7"
7D86I24"6: A1859 = A1859->A1549;"
96D8I3"5;
"
13I34":
A1569->A1563 = A1859;
goto A1720"
6D122I17"2: A1592(A1859);
"
127D2I119": ;
}
Void
A7838()
{
struct A1537 *A1859;
if( !A1569 ) return;
if( (A1859 = A1569->A1562) && A1859->A1545 == (A43) 9 ) "
10D2I14"11;
goto A1712"
7D26I43"11:
A7755( (0x200|0x40 | 15), &A1859->A1547"
38D2I2"13"
7D34I1"1"
39D19I7"582();
"
24I64": ;
}
Void
A1582()
{
A1581( A1589( (A43) 9, A1719.A599, NULL ) )"
6D137I8"9.A599 ="
142I80";
}
Void
A1580()
{
struct A1560 *A3859;
A3859 = (struct A1560 *) A1073( (A41) 39"
5D28I53"3859->A1561 = A1569;
A1569 = A3859;
}
struct A1537 *
"
35D118I25"A2118, A1718 )
A43 A2118;"
127D11I9"561 *A171"
35D14I48", *A1850, *A1851, *A1737, *A2285, *A3860, *A1806"
24D14I13"A1587(A2118);"
19I1"!"
5D6I30" ) return NULL;
A1859->A1547 ="
11D13I15"8;
A2285 = NULL"
18D3I4"37 ="
9D8
14D8I3"8;
"
13D2I18":
if( A1737) goto "
7D11I2";
"
20D1I1"2"
7D1I42"4: A1737 = A1737->A1549;
goto A1713;
A1711"
9D7I22"737->A1545 != (A43) 24"
40D7I6" A2285"
12D28I3"737"
39D78I18"goto A1714;
A1712:"
83D31I60"A2285 ) goto A1717;
goto A1720;
A1717: A3860 = A3788( &A2285"
37D4I67"9 );
goto A1721;
A1720: A3860 = NULL;
A1721:
switch( A2118 )
{
case"
11D17I11"14:
A1737 ="
30D3I8";
A1726:"
10D22I3"737"
32D2I2"23"
12D2I2"25"
7D9I9"27: A1737"
14D3I3"737"
9D22I13"9;
goto A1726"
27D91I80"23:
if( A1737->A1549 && A1737->A1549->A1545 == (A43) 25 ) goto A1766;
goto A1767"
96D38I32"66:
A1806 = A3788( &A1737->A1549"
43D50I7"3787( &"
55D14I48"->A1548 );
A1851 = A3788( &A1806->A1549 );
A1592"
19D19I14"06 );
A1850 = "
24D95
101D24I15"8;
A1850->A1549"
31D8I1"1"
13D10I10"87( &A1850"
16D78I1"9"
90D2I42"25;
A1767: ;
goto A1727;
A1725:
goto A1722"
16D1I1"9"
15D26I56"1:
case (A43) 13:
case (A43) 7:
A3787( &A1859->A1548 );
"
34D9I55"22;
default:
goto A1722;
}
A1722:
A1581( A1859 );
A1581"
15D31I93"0 );
return A1859;
}
struct A1537 *
A7445()
{
struct A1537 *A2285 = NULL;
struct A1537 *A1737"
38D16I4"1569"
28D1I1"1"
12D1I1"2"
7D15I12"1:
if( A1569"
20D6I26"62 == A1569->A1563 ) goto "
11D1I1";"
11D16I2"4;"
21D58I16"3:
A2285 = A1569"
63D2I38"63;
A1569->A1563 = A1569->A1562 = NULL"
13D1I1"5"
9D17I56" if( (A2285 = A1569->A1563) &&
(A1737 = A1569->A1562) ) "
26D9I2"6;"
19D78I38"7;
A1716:
if( A1737->A1549 != A2285 ) "
86D76I2"20"
86D31I32"21;
A1720:
A1737 = A1737->A1549;"
41D4I93"6;
A1721:
A1737->A1549 = NULL;
A1569->A1563 = A1737;
A1717: ;
A1715: ;
A1712:
return A2285;
}"
13D19I32"1537 *
A1587(A2118)
A43 A2118;
{"
28D24I18"1537 *A1754 = NULL"
34D47I122"1560 *A1859;
if( !A1569 ) return NULL;
if( A2118 ) goto A1711;
goto A1712;
A1711:
A1754 = A1589( A2118, NULL, A1569->A1562"
53D40I40"712:
A1859 = A1569;
A1569 = A1859->A1561"
45D59I115"74( (A49) A1859, (A41) 39 );
return A1754;
}
struct A1537 *
A7839(A2118)
A43 A2118;
{
if( A1569 && !A1569->A1562 ) "
71D4I26"goto A1712;
A1711:
A2118 ="
11D153I59"0;
A1712:
return A1587(A2118);
}
A4
A3861()
{
A70 A1738;
A4"
158D78I45"2 = (A4) 0;
register struct A1531 *A1731;
A58"
83D55I59"7, A1740;
A50 A2077;
struct A561 *A1718;
struct A3771 A3877"
60D9I10"12( &A3877"
14D48I27"2163();
A1093( 8 ,(A34) 0);"
56D3I16"810( &A3877, 1 )"
18D12I61"goto A1712;
A1711:
A1979( 0, (A20) 0x8|(A20) 0x10, (A19) 0x80"
17D82I24"1712:
A1718 = A1719.A599"
87D23I27"19.A599 = NULL;
A583( A1718"
40D33I6"2077 ="
38D17I7"9.A600;"
24D4I23"2077 || (( A2077 ) < 0)"
16D17I13"3;
goto A1714"
22D30I24"13: A1740 = A1719.A592;
"
38D13I1"1"
19D35I51"14: A1740 = (A58) A2077;
A1715:
A1738 = A492( A1740"
41D21I27"797 = 0;
if( A1738 == 31 ) "
29D10I3"16;"
20D25I2"7;"
30D81I8"6:
A3797"
86D19I88"740;
A1731 = A1559.A1553;
A1722:
if( A1731) goto A1720;
goto A1721;
A1723: A1731 = A1731"
24D50I2"32"
60D17I9"22;
A1720"
24D12I4"1731"
18D1I10"4 == A1740"
12D2I2"25"
12D2I2"26"
7D2I41"25: A3797 = 0;
A1726: ;
goto A1723;
A1721"
10D17I3"797"
28D2I2"27"
12D2I2"66"
7D7I6"27: A5"
13D15I12"797, 0, NULL"
21D30I5"766: "
36D33I35"7:
if( A1738 > 20 && A1738 != 31 ) "
41D12I3"67;"
21D42I38"68;
A1767:A865(130);
A1768:
A2157 = 0;"
47D141I2"0("
146D3I102"093( 5 ,(A34) 0);
A3784( A8645 ); 
A1570( 47, NULL, NULL, NULL, A1718, (A4) 0, 0, A1740 );
A1559.A1553"
9D23I1"4"
28D5I73"797;
A1559.A1556 = (A4) 1;
A448( (A17)0 );
A1583( (A43) 17, A1718 );
if( "
10D29
34D11I98"559.A1553 ) goto A1769;
goto A1770;
A1769:
if( A3797 ) goto A1771;
goto A1772;
A1771: A537( A3797,"
17D112
118D18I59"2 & (A17) 0x02 ? -2 : -1, NULL );
goto A1773;
A1772: if( !("
23D50I46"->A1542 & (A17) 0x04) ) goto A1774;
goto A1775"
55D50I27"74:A865(764);
A1775:
A1773:"
55D5I28"!(A1731->A1542 & (A17) 0x02)"
16D2I2"76"
12D2I2"77"
7D31I2"76"
37D5I7"!A3797 "
15D2I2"78"
12D2I2"79"
7D23I21"78:A865(744);
A1779: "
33D2I2"80"
7D26I53"77: if( A1559.A1556 && !(A1731->A1542 & (A17) 0x01) )"
35D2I14"81;
goto A1782"
7D24I18"81: A3862 = (A4) 1"
29D13I56"82:
A1780: if( (A6)( A1731->A5896) > A5895[(int) A5888] "
23D2I2"85"
12D2I2"86"
7D26I93"85: A890( 793, A6036( A5895[ A5888] ), "", "case labels in switch" ); 
A1786: ; 
A1783:if(0) "
34D2I2"80"
7D37I23"84:
A1571( NULL, NULL )"
42D43I71"70:
A3813( &A3877 );
A2168(2);
return A3862;
}
A4
A5992(A80)
A81 A80;
{"
52D16I3"322"
21D56I9"61;
A96 *"
63D73I15"*A2323, *A2493,"
78D10I61"49;
A4 A5365 = (A4) 0;
A4 A3862;
A4 A8611;
A1580();
A2163();
"
15D4I16"80 && A2142 == 6"
16D1I1"1"
12D1I1"2"
7D22I12"1: A693( A80"
27D18I74"1712:A1095( 20 ,(A35) 0);
A1570( 117, NULL, NULL, NULL, NULL, (A4) 0, 0, 0"
23D12I10"1559.A1553"
18D32I10"1 = A511(2"
37D2I115"584((A4) 0,(A20) 0x80);
A2061 = A1559.A1553->A1541;
A3862 = A1559.A1556;
A1571( NULL, NULL );
A2493 = A1100();
A254"
7D16I57"5272( A1100() );
A1104();
A2323 = A1100();
A8611 = (A4) 0"
24D89
94D4I13"2142 == (90 )"
16D1I1"4"
12D1I1"5"
7D44I74"4:
A1103((A2323),(A6228)0);
A5491((A4) 0,(A28) 0x8000000|(A28) 0x4000000);"
50D44I3"861"
57D1I1"6"
12D1I1"7"
7D21I23"6: A6172( A8587, "" ); "
26D126I31"7:
A8611 = A3780(A2061,&A5365);"
131D123I34"2 &= A1559.A1556;
A2070 = A1100();"
130D24I10"559.A1556 "
34D2I2"20"
12D2I2"21"
7D11I28"20: A1101( A2549, A2070, 5 )"
21D2I2"22"
7D3I97"21: A1101( A2549, A2070, 1 );
A1722:
A1102( A2070 );
goto A1713;
A1715: A1101( A2493, A2549, 7 );"
10D76I3"061"
87D2I2"23"
12D2I2"25"
7D2I2"23"
10D13I9"061->A324"
24D2I2"26"
13D1I1"7"
6D19I27"26:
A1576( A2061, 4, NULL )"
25D47I16"7:
A517( A2061 )"
53D252I110"5: A1583( (A43) 18, NULL );
A1103((A2493),(A6228)0);
A1102(A2323);
A1102(A2493);
A1102(A2549);
return A3862;
}"
261D238I312"953 A9106[] =
{
{ "break", (A43) 1 },
{ "case", (A43) 2 },
{ "catch", (A43) 3 },
{ "continue", (A43) 4 },
{ "default", (A43) 6 },
{ "do", (A43) 7 },
{ "except", (A43) 8 },
{ "expr stmt", (A43) 9 },
{ "for", (A43) 11 },
{ "goto", (A43) 12 },
{ "if else", (A43) 14 },
{ "if", (A43) 13 },
{ "label", (A43) 15 },
{ ""
244D106I244"", (A43) 16 },
{ "switch", (A43) 17 },
{ "try", (A43) 18 },
{ "while", (A43) 19 },
{ "leave", (A43) 20 },
{ "asm", (A43) 21 },
{ "try-finally", (A43) 22 },
{ "try-except", (A43) 23 },
{ "{}", (A43) 5 },
{ "Option", (A43) 24 }
};
const A72 A9107"
111D4I214"72) sizeof( A9106 ) / (A72) sizeof( struct A953 );
A5794
A9108( A2118 )
A43 A2118;
{
return A981( A2118, A9106, A9107 );
}
Void
A9084( A7211 )
struct A1537 *A7211;
{
A6 A2008 = A1022;
extern Void A9082();
A1022 = 0"
10D12I5"A7211"
24D1I1"1"
12D1I1"2"
7D17I57"1:
A1079( "\n",(A49)( NULL ));
A9082( A7211 );
goto A1713"
23D12I3"2: "
18D8I2"56"
20D2I2"14"
12D2I2"15"
7D9I100"14:
A1079( "\ntree empty, but g_sac contains:\n",(A49)( NULL ));
A7211 = A1589( (A43) 5, NULL, A1569"
14D112I50"62 );
A9084(A7211);
A1074( (A49) A7211, (A41) 40 )"
117D18I172"15:
A1713:
A1022 = A2008;
}
Void
A9082(A7211)
struct A1537 *A7211;
{
struct A1537 *A1859;
struct A561 *A1718;
Void A9083();
Void A9079();
if( A7211 ) goto A1711;
goto A1712"
23D47I16"11:
A9083( A7211"
52D52I6"1022++"
57D30I9"18 = A721"
37D16I9"7;
A1715:"
22D5I4"1718"
15D2I2"13"
12D2I2"14"
7D13I49"16: A1718 = A1718->A563;
goto A1715;
A1713:
A9079"
18D20I5"18 );"
29D14I2"16"
19D32I16"14:
A1859 = A721"
38D14I2"48"
19D6I15"21:
if( A1859) "
14D2I14"17;
goto A1720"
7D22I26"22: A1859 = A1859->A1549;
"
30D13I1"2"
19D21I18"17:
A9082(A1859); "
29D1I1"2"
7D16I11"20:
A1022--"
21D10I51"12: ;
}
Void
A9083(A7211)
struct A1537 *A7211;
{
A6"
15D50I1"2"
57D4I4"7211"
15D2I2"11"
12D2I2"12"
7D88I13"11:
A1732 = 0"
93D4I46"15:
if( A1732 <= A1022) goto A1713;
goto A1714"
9D2I130"16: A1732++;
goto A1715;
A1713:A1079( "   ",(A49)( NULL ));
goto A1716;
A1714:A1079( "$s\n",(A49)( A9108( A7211->A1545 ) ));
A1712"
8D38I16"Void
A3787(A2098"
54I24"*A2098;
{
struct A1537 *"
7D101I14"A7 A1808 = 0;
"
106D34I9" = *A2098"
39D4I19"13:
if( A1859) goto"
9D37I7"1;
goto"
42D21I1"2"
26D2I9"14: A1859"
7D43I3"859"
48D10I14"49;
goto A1713"
15D25I17"11:
++A1808; goto"
30D16I23"4;
A1712:
if( A1808 > 1"
28D1I1"5"
12D1I1"6"
7D12I74"5:
*A2098 = A1589( (A43) 5, NULL, *A2098 );
A1716: ;
}
struct A561 *
A7840"
19D9I39" )
struct A1537 *A1859;
{
struct A561 *"
14D41I42"=NULL;
if( !A1859 ) return NULL;
if( A1859"
47D41I34"5 == (A43) 5 )
return A7840( A1859"
47D61I7"8 );
if"
74D29I59"5 == (A43) 9 ) goto A1711;
goto A1712;
A1711:
A1718 = A1859"
35D38I8"7;
A1859"
44D22I23"7 = NULL;
A1712:
return"
27D13I76"8;
}
struct A1537 *
A1588( A2927 )
struct A588 *A2927;
{
struct A1537 *A1859"
19D32I76"9.A592 = 24;
A1029( (0x200|26), A2927 );
A1859 = A1589( (A43) 9, A1719.A599,"
37D6
18D4I4"1859"
14D3I3"386"
79D61
71D121
142D7I12"if( A8607 &&"
20D126I16" & 0x20 )
return"
194D49
78D3I39"9:
A1037( A3864, (A78) 0 );
goto A1711;"
15D1I2"13"
14D17I27"14:
if( !A3864 || !A3794 ) "
26D35I46"1;
A1037( A3864, (A78) 0x02 );
A3863( A3794 );"
41D11I16"2118 == (A43) 14"
23D1I1"2"
12D1I1"3"
7D81I15"2: A3863( A3794"
86D2I2"49"
10D20I14"3:
goto A1711;"
32D1
6D6I4"716:"
13D27I3"794"
37D2I2"14"
12D2I2"15"
7D14I17"17: A3794 = A3794"
19D16I3"49;"
25D2I56"16;
A1714:
A3863( A3794 );
goto A1717;
A1715:
goto A1711"
15I1"1"
5D101I11"037( A3864,"
112D28I2" |"
36D12I14"x80000 );
A386"
17D32I7"794 );
"
40D2I76"11;
case (A43) 7:
A3863( A3794 );
A1037( A3864, (A78) 0x02 | (A78) 0x80000 )"
12D32I24"11;
case (A43) 11:
if( !"
37D24
35D22I26"11;
{
struct A561 *A2546 ="
27D127I20"4;
struct A561 *A254"
132D4I120"2546->A563;
struct A561 *A3805 = A2547->A563;
A1037( A2546, (A78) 0 );
A1037( A2547, (A78) 0x02 | (A78) 0x80000 );
A1037"
9D1I45"05, (A78) 0x02 | (A78) 0x80000 );
A3863( A379"
6D12I2"}
"
20D118I8"11;
case"
126D4I119":
case (A43) 4:
case (A43) 20:
case (A43) 12:
case (A43) 15:
case (A43) 6:
case (A43) 2:
case (A43) 21:
case (A43) 24:
"
12D2I45"11;
case (A43) 16:
A1037( A3864, (A78) 0x02 )"
12D15I51"11;
case (A43) 17:
A1037( A3864, (A78) 0x02 );
A386"
23D44I2" )"
54D81I24"11;
case (A43) 22:
if( !"
88I11" goto A1711"
5D60I36"63( A3794 );
A3863( A3794->A1549 );
"
68D4I32"11;
case (A43) 23:
if( !A3794 ) "
12D10I3"11;"
15D29I61"3( A3794 );
A3794 = A3794->A1549;
if( A3794 && A3794->A1545 ="
34D27I93"3) 8 ) goto A1720;
goto A1721;
A1720:
A1037( A3794->A1547, (A78) 0x02 );
A3863( A3794->A1548 "
32D51I37"721:
goto A1711;
case (A43) 18:
if( !"
56D9I13" ) goto A1711"
14D36I19"63( A3794 );
A1722:"
42D15I21"794 = A3794->A1549 ) "
23D2I2"23"
12D2I2"25"
7D46I59"23:
A1037( A3794->A1547, (A78) 0x02 );
A3863( A3794->A1548 "
57D2I2"22"
7D16I4"25:
"
24D3I12"11;
default:"
12D34I169"11;
}
A1711: ;
}
A74
A6302( A1859 )
struct A1537 *A1859;
{
struct A561 *A3864, *A3867;
A234 = A110();
switch( A1859->A1545 )
{
case (A43) 7:
case (A43) 19:
A3863( A1859 "
45D11I19"11;
case (A43) 11:
"
18D2I17"64 = A1859->A1547"
13D29I14"12;
goto A1713"
34D1I58"12:
if( A3867 = A3864->A563 ) goto A1714;
goto A1715;
A171"
6D3I65"037( A3867, (A78) 0x02 );
A1037( A3867->A563, (A78) 0x02 );
A1715"
8D2I2"13"
8D16I17"3( A1859->A1548 )"
26D108I13"11;
default:
"
116D14I145"11;
}
A1711:
return A234;
}
struct A1537 *
A1589( A2118, A3675, A3865 )
A43 A2118;
struct A561 *A3675;
struct A1537 *A3865;
{
struct A1537 *A1731"
19D18I38"31 = (struct A1537 *) A1073( (A41) 40 "
23D38I18"731->A1545 = A2118"
43D4I17"31->A1547 = A3675"
9D113I8"31->A154"
120D21I9"65;
A1731"
27D122I1"1"
127D20I82"217;
return A1731;
}
struct A1537 *
A1590( A1836 )
A17 A1836;
{
struct A1537 *A173"
25D46I12"731 = A1589("
53D11I3"24,"
16D7I22", NULL );
A1731->A1546"
12D48I121"836;
return A1731;
}
Void
A7193( A7211, A1948 )
struct A1537 *A7211;
A17 A1948;
{
struct A1537 *A1859;
struct A561 *A1718"
55D16I3"721"
27D3I3"711"
12D28I52"712;
A1711:
A1718 = A7211->A1547;
A1715:
if( A1718) "
36D27I4"13;
"
34D3I31"714;
A1716: A1718 = A1718->A563"
12D2I2"71"
7D47I27"713:
A7182( A1718, A1948 );"
55D2I2"71"
7D112I5"714:
"
117D147I8" = A7211"
153D12I14"8;
A1721:
if( "
17D19I23") goto A1717;
goto A172"
24D57I49"722: A1859 = A1859->A1549;
goto A1721;
A1717:
A71"
62D64I14"1859, A1948 );"
72D136I5"722;
"
141D22I27": ;
A1712: ;
}
Void
A6301( "
27I85", A2070 )
struct A1537 *A1859;
A96 *A2070;
{
if( !A1859 ) return;
A6242 = A6302(A1859"
5D44I23"103( A2070, (A6228) 0x8"
49D16I72"}
Void
A1592( A1859 )
struct A1537 *A1859;
{
struct A1537 *A2555;
A1711:"
22D60I3"859"
70D3I3"712"
12D118I24"713;
A1712:
A1592( A1859"
124D18I97"8 );
A8278( A1859->A1547 );
A2555 = A1859->A1549;
A1074( (A49) A1859, (A41) 40 );
A1859 = A2555;
"
25D37I2"71"
42D10I95"713: ;
}
Void
A5766( A1859, A3807 )
struct A1537 *A1859;
A5972 A3807;
{
if( !A1859 ) return;
if"
15D12I5"07 ) "
20D35I4"11;
"
42D61I26"712;
A1711: A1859->A1546 |"
66D3I136"07 > 0 ? 1 : 2;
A1712:
if( A1559.A1553 && A1559.A1553->A1542 & (A17) 0x01 ) goto A1713;
goto A1714;
A1713:
A1859->A1546 |= 8;
A1714: ;
}"
12D25I21"1537 *
A3788( A2098 )"
34D31I52"1537 **A2098;
{
struct A1537 *A1731 = *A2098;
*A2098"
40D32I27"return A1731;
}
Void
A3866("
37D18I16")
struct A1537 *"
23D21I95";
{
A74 A6303;
A81 A1942;
struct A147 *A2113;
A7 A1732;
A6303 = A6302(A1859);
A1732 = 0;
A1713:"
26D13I26"A1942 = (A81) A6303[A1732]"
22D3I3"711"
12D42I20"712;
A1714: A1732++;"
50D71I11"713;
A1711:"
77D17I77"2113 = ( (A1942)->A156 == (A41) 19 ? (A1942)->A155.A148 : (struct A147 *) 0 )"
27D3I3"715"
12D43I10"716;
A1715"
50D19I14"2113->A548 > 3"
29D255I14"717;
goto A172"
260D77I28"717: A2113->A548 = 3;
A1720:"
83D47I14"2113->A549 > 3"
57D3I3"721"
12D88I34"722;
A1721: A2113->A549 = 3;
A1722"
95D8I15"2113->A6232 > 3"
18D3I3"723"
12D17I1"7"
23D5I53"723: A2113->A6232 = 3;
A1725:
if( A2113->A5661 > 3 ) "
14D60I1"6"
71D60I44"7;
A1726: A2113->A5661 = 3;
A1727: ;
A1716: "
70D32I17"14;
A1712: ;
}
A4"
37D1I97"8(A1859, A3798)
A35 A1859;
struct A561 *A3798;
{register struct A1531 *A1731;
A17 A1948;
A4 A3869"
9D30I49"0;
A4 A3870 = (A4) 1;
A1731 = A1559.A1553;
A1711:"
35D4I4"1731"
9D3I17"1731->A1533 != 47"
13D3I3"712"
11D11I11"1713;
A1712"
16D12I29"31 = A1731->A1532;
goto A1711"
17D17I3"13:"
22D11I82"!A1731 ) return (A4) 1;
A1948 = A1731->A1542;
if( A1948 & ((A17) 0x100|(A17) 0x80)"
20D4I4"1714"
12D18I18"1715;
A1714:
A3869"
23D27I25"4) 1;
if( !A1559.A1558 ) "
33D18I30"1716;
goto A1717;
A1716: A3870"
23D2I91"4) 0;
A1717: ;
A1715:
if( A1859 == 29 ) goto A1720;
goto A1721;
A1720:
A1731->A1542 |= (A17"
8D30I4";
if"
36D24I102"9 && A1948 & (A17) 0x80 ) goto A1722;
{
A96 *A2070;
if( A3869 ) goto A1723;
goto A1725;
A1723: A3870 ="
30D9I51"1;
A1725:
A2070 = A1572( A1731, A1591( A1731->A1538"
16D22I9"3778( A20"
29D58I24"1102( A2070 );
}
A1722: "
69D17I59"6;
A1721:
{
A96 *A2070, *A2323;
A1731->A1542 |= (A17) 0x04;"
26D39I1"9"
48D4I4"1727"
12D24I29"1766;
A1727:
if( A1565( A1731"
29D33I14"40, A3798 ) ) "
41D16I20"67;
goto A1768;
A176"
22D17I54"70 = (A4) 1;
A1103(( A1731->A1536 ),(A6228)0);
A1768: "
27D45I29"69;
A1766:
if( A1559.A1558 ) "
53D44I2"70"
54D24I24"71;
A1770: A2070 = A1100"
36D55I18"72;
A1771: A2070 ="
60D49I39";
A1772:A1103(( A1731->A1536 ),(A6228)0"
54D48I10"792( A1731"
54D45I2"0,"
50D30I17"8 );
if( A2070 ) "
38D32I4"73;
"
40D53I25"74;
A1773:
A2323 = A1100("
58D42I5"103(("
47D96I28"1(A2070,A2323,1)),(A6228)0);"
101D36I7"2(A2323"
41D9I103"102(A2070);
A1774: ;
A1769: ;
}
A1726:
return !A3870;
}
A4
A3871(A1859)
struct A1537 *A1859;
{
A4 A3862"
20D12I85"register struct A1531 *A1731;
A58 A1740;
struct A561 *A1718;
A87 A2069;
A1718 = A1859"
18D1I26"7;
A583( A1718, (A78) 0x02"
6D76I4"1740"
81D4I64"718->A567;
A1570( 47, NULL, NULL, NULL, A1718, (A4) 0, 0, A1740 "
9D138I18"731 = A1559.A1553;"
145D3I91"1731 ) return A3862;
A1731->A1538 = A1859;
A1731->A1544 = 0;
if( A1032( A1718, &A2069 ) == "
15D61I25"11;
goto A1712;
A1711:
if"
67D110I8"3( A1859"
116D1I10"8, A1718 )"
10D4I4"1713"
12D71I18"1714;
A1713:
A1731"
77D29I41"2 |= (A17) 0x80;
goto A1715;
A1714:
A1731"
35D14I34"2 |= (A17) 0x100;
A1715: ;
A1712:
"
25I32" = (A4) 1;
A1593( A1859->A1548 )"
6D1
13I74"&& A1731->A1542 & ((A17) 0x02|(A17) 0x80)
&& !(A1731->A1542 & (A17) 0x01) "
8D4I4"1716"
12D89I164"1717;
A1716: A3862 = (A4) 1;
A1717:
A1571( NULL, NULL );
return A3862;
}
Void
A1593( A1859 )
struct A1537 *A1859;
{
struct A561 *A3864;
struct A1537 *A3794;
A58 A17"
94D12I96"70 A1738;
A78 A2128;
A81 A80;
A4 A3862 = (A4) 0;
A43 A2118;
A5972 A3807;
A4 A3806;
A96 *A2323, *"
17D67I79", *A2549;
A4 A3872, A3873;
A24 A3037;
struct A144 *A3874;
A54 A2008;
A17 A1709;"
72I1"!"
5I24" ) return;
A1709 = A1859"
7D4I49";
A1559.A1558 = !A1338 && !A1559.A1556;
if( A1338"
13D4I4"1711"
12D18I24"1712;
A1711: A1559.A1556"
26D77I10"0;
A1712:
"
83D13I17"= (A4) 0;
A3864 ="
24D25I22"47;
A3794 = A1859->A15"
31D48I5"118 ="
54D44I6"->A154"
51D9I141"A1559.A1556 ) goto A1713;
goto A1714;
A1713:
switch( A2118 )
{
case (A43) 15:
case (A43) 5:
case (A43) 2:
case (A43) 6:
goto A1715;
default:
"
15D6I17";
}
A1715:
A1714:"
12D8
17D17I114"51 ) goto A1716;
goto A1717;
A1716:( * ( ( *++ A932 == A1524 ) ? (A1521( (A1523 *)& A932 ), A932) : A932 ) = A1859"
22D87I58"51 );
A1717:
switch( A2118 )
{
case (A43) 15:
A1104();
if("
92D222I27"4 && (A80 = A3864->A566) ) "
230D1I1"2"
12D1I1"2"
7D34I25"21:
A3778( A80->A155.A143"
41D4I29"22:
goto A1720;
case (A43) 9:"
15D26I10"7 = (A4) 0"
34D3I34"859->A1546 & 0x10 && !A1859->A1549"
14D1I1"2"
12D2I2"25"
7D15I9"23:
A2128"
20D4I20"78) 0x02;
goto A1726"
9D8I8"25:
A212"
14D1I2"78"
8D82I25"726:
A583( A3864, A2128 )"
98D1I1"3"
12D2I2"27"
12D1I1"6"
7D49I57"27:
A1559.A1553->A7444 = A3864;
A1766:
if( A1559.A1557 ) "
55D42I4"1767"
52D2I44"68;
A1767: A3862 = (A4) 1;
A1768:
goto A1720"
9D32I9"(A43) 13:"
38D2I8"(A43) 14"
8D54I16"!A3864 || !A3794"
65D33I67"20;
A583( A3864, (A78) 0x02 );
A3807 = A1044( A3864 );
if( A3807 ) "
41D32I13"69;
goto A177"
38D32I3"69:"
38D32I9"3807 == 1"
43D2I2"71"
12D2I2"72"
7D15I20"71: A1593( A3794 );
"
23D13I1"7"
19D9I15"72: if( A2118 ="
14D25I30"3) 14 ) goto A1774;
goto A1775"
30D25I23"74: A1593( A3794->A1549"
30D12I44"1775:
A1773:
A3862 = A1559.A1556;
goto A1720"
17D21I143"70:
A2323 = A1100();
A1996( A3864, (A91) 0x10, (A87) 1, 4, NULL );
A1593( A3794 );
A3872 = !A1559.A1556;
A2493 = A1100();
if( A2118 == (A43) 14"
32D1I1"7"
12D1I1"7"
7D61I43"76:
A3862 = A1559.A1556;
A1559.A1556 = (A4)"
67D60I28"103((A2323),(A6228)0);
A1996"
65D37I34"64, (A91) 0x10, (A87) 0, 4, NULL )"
42I32"93( A3794->A1549 );
A3873 = !A15"
7D67I17"6;
A2549 = A1100("
75D6I16"3872 && A3873 )
"
14D2I2"78"
13D1I1"9"
6D23I58"78:A1103(( A1101( A2493, A2549, 1 ) ),(A6228)0);
goto A178"
28D7I5"779: "
12D9I4"3872"
20D1I1"8"
12D1I1"8"
7D80I40"81:A1103(( A2493 ),(A6228)0);
goto A1783"
85D13I4"82: "
18D9I4"3873"
20D47I29"84;
A1103(( A2323 ),(A6228)0)"
52D18I26"84:
A1783:
A1780:
A3862 &="
29D4I3"6;
"
12D13I1"8"
20D2I48"7:
A2549 = NULL;
A1103((A2323),(A6228)0);
A1996("
7D53I25"4, (A91) 0x10, (A87) 0, 4"
63D31I12"if( A3872 ) "
39D2I150"86;
goto A1787;
A1786:
A2549 = A1100();
A1103(( A1101(A2493,A2549,1) ),(A6228)0);
A1787: ;
A1785:
A1102(A2323); A1102(A2493); A1102(A2549);
goto A1720"
10D27I275"A43) 5:
A3874 = (A418 ? A418->A364 : A1339);
A2008 = A3874->A990;
A216( A1859->A1550, A496 );
A1890:
if( A3794) goto A1788;
goto A1889;
A1891: A3794 = A3794->A1549;
goto A1890;
A1788:
A1593( A3794 );
A3862 = A1559.A1556;
goto A1891;
A1889:
A1009( A3874, A2008+1 );
goto A1720"
34D375
381D14I11"19:
A2493 ="
19D27I60";
A2323 = A1100();
A583( A3864, (A78) 0x02 | (A78) 0x80000 )"
35D9I16"044(A3864) == -1"
19D3I3"892"
12D42I25"893;
A1892:
A1102( A2323 "
53D86I10"20;
A1893:"
93D54I7"709 & 8"
64D3I3"894"
12D89I27"895;
A1894: ++A1025;
A1895:"
94D18I19"A3806 = A3809(A3864"
29D39I23"896;
A1996( A3864, (A91"
45D15I18", (A87) 0, 4, NULL"
20D11I4"2493"
16D117I4"100("
122D29I40"896:A1103((A2323),(A6228)0);
A1102(A2323"
35D23I60"66(A1859);
A5664( A3864, (A78) 0x02 | (A78) 0x80000, A5668()"
28D14I13"1024 = (A4) 1"
24D4I4"3864"
39D5I7"1024 = "
11D32I129";
A3807 = A1859->A1546 & 1 ? 1 :
A1859->A1546 & 2 ? -1 : 0;
A1570( 51, NULL, A3864, A2493, NULL, A3806, A3807, 0 );
A1593( A3794 "
40D25I49"3807 == 1 && !( A1559.A1553->A1542 & (A17) 0x01 )"
35D3I3"897"
12D2I109"898;
A1897:
A3862 = (A4) 1;
A1898:
A1571( NULL, NULL );
if( A1709 & 8 ) goto A1899;
goto A1900;
A1899: --A102"
7D12I42"900:
goto A1720;
case (A43) 7:
A3866(A1859"
17D14I47"570( 30, NULL, NULL, NULL, NULL, (A4) 0, 0, 0 )"
19D61I11"93( A3794 )"
68D10I61"1559.A1556 && !(A1559.A1553->A1542 & ((A17) 0x01|(A17) 0x20))"
20D3I3"901"
12D34I20"902;
A1901:
A3862 = "
39D6I69"1;
A1902:
A3037 = A3864->A572;
if( A3037 & (A24) 0x10 && A3037 & (A24"
12D12I7"0 &&
!("
22D35I22"3->A1542 & (A17) 0x01)"
45D3I3"903"
12D10I33"904;
A1903: A3862 = (A4) 1;
A1904"
15D46I9"71( A3864"
52D29I68" );
goto A1720;
case (A43) 11:
if( A1709 & 8 ) goto A1905;
goto A190"
34D45I12"905: ++A1025"
50D34I109"06:
{
struct A561 *A2546 = A3864;
struct A561 *A2547 = A2546->A563;
struct A561 *A3805 = A2547->A563;
A2493 ="
39I22";
A583( A2546, (A78) 0"
5D53I55"3807 = A1859->A1546 & 1 ? 1 :
A1859->A1546 & 2 ? -1 : 0"
59D11I12"!A2547->A564"
21D3I3"909"
12D39I11"910;
A1909:"
44D9I27"6 = (A4) 1; A3866(A1859); 
"
16D29I25"911;
A1910:
A2323 = A1100"
34D34
39D55I34"A2547, (A78) 0x02 | (A78) 0x80000 "
63D13I11"1044(A2547)"
29D3I3"912"
12D25I24"913;
A1912:
A1102(A2323)"
34D12I12"908;
A1913:
"
19D5I4"06 ="
10D6I8"9(A2547)"
16D32I51"914;
A1996( A2547, (A91) 0x10, (A87) 0, 4, NULL );
"
37D64I10" = A1100()"
69D3I27"14:A1103((A2323),(A6228)0);"
8D15I21"2(A2323);
A3866(A1859"
20D23I65"664( A2547, (A78) 0x02 | (A78) 0x80000, A5668() );
A1024 = (A4) 1"
28D38I57"96( A2547, (A91) 0x10, (A87) 1, 4, NULL );
A1024 = (A4) 0"
43D10I28"11:
A1570( 36, NULL, A2547, "
16D44I43" A3805, A3806, A3807, 0 );
A1593( A3794 );
"
51D2I45"07 == 1 && !(A1559.A1553->A1542 & (A17) 0x01)"
13D2I2"15"
12D2I2"16"
7D1I24"15:
A3862 = (A4) 1;
A191"
6D46I21"571( NULL, NULL );
} "
53D60I16"if(0) goto A1906"
69D71I16"if( A1709 & 8 ) "
79D23I4"17;
"
32D13I1"8"
19D43I10"7: --A1025"
49D9I19"8:
goto A1720;
case"
17D8I14":
A1593( A3794"
13D39I28"3801( 25 );
A3862 = (A4) 1;
"
46D3I62"720;
case (A43) 4:
A1593( A3794 );
A3801( 28 );
A3862 = (A4) 1"
12D25I48"720;
case (A43) 20:
A3801( 140 );
A3862 = (A4) 1"
34D3I62"720;
case (A43) 16:
if( A3864 && A415 ) goto A1919;
goto A2330"
9D25I17"9:
A1740 = A3857("
30D3I21"738 = A492(A1740);
if"
8D52I53"38 == 33 ) goto A2331;
goto A2332;
A2331: A2128 = (A7"
57D1I14"08 | (A78) 0x2"
6D5I32";
goto A2333;
A2332: A2128 = (A7"
10D1I14"02 | (A78) 0x2"
6D23I13";
A2333:
A583"
28D5I136"64, A2128 | A1988( A1740, (A4) 0, (A4) 0 ) );
A1120( A415, &A3864->A570 );
A2330:
A1593( A3794 );
A1594();
A3801( 42 );
A3862 = (A4) 1;
"
12D5I70"720;
case (A43) 12:
if( A3864 && (A80 = A3864->A566) && A1559.A1558 ) "
11D37I4"2334"
45D35I35"2335;
A2334:
A3779( &A80->A155.A143"
40D2I45"2335:
A3862 = (A4) 1;
goto A1720;
case (A43) "
7D54I21"3862 = A3871(A1859);
"
61D3I44"720;
case (A43) 6:
A3862 = A3868( 29, NULL )"
12D50I47"720;
case (A43) 2:
A3862 = A3868( 26, A3864 );
"
56D4I28"1720;
case (A43) 21:
A1104()"
12D136I4"1720"
143D63I23"(A43) 22:
if( !A3794 ) "
71D131I14"20;
A1570( 141"
143I26", NULL, NULL, (A4) 0, 0, 0"
7D2I2"93"
8D8I26"4 );
A3801( 134 );
A3862 ="
21D38I50"&& !(A1559.A1553->A1542 & (A17) 0x40);
A1559.A1556"
46D16I41"0;
A1593( A3794->A1549 );
A1571(NULL,NULL"
27D2I2"20"
9D46I70"(A43) 23:
if( !A3794 ) goto A1720;
A1570( 141, NULL, NULL, NULL, NULL,"
53D50I24", 0, 0 );
A1593( A3794 )"
55D2I31"62 = A1559.A1556;
A2493 = A1100"
7D52I19"3794 = A3794->A1549"
58D19I32"A3794 && A3794->A1545 == (A43) 8"
55D58I37"104();
A583( A3794->A1547, (A78) 0x02"
63D35I10"1559.A1556"
40D66I100"4) 0;
A1593( A3794->A1548 );
A3862 &= A1559.A1556;
if( !A1559.A1556 ) goto A2338;
goto A2339;
A2338:"
71D1I1"9"
6D20
28D37I12"1101( A2493,"
42D117I24"9, 1 );
A1102( A2549 );
"
122D12I2": "
18D83I9"7:A1103(("
88D18I26"),(A6228)0);
A1102(A2493);"
23D28I2"1("
33D35
42D31I88"goto A1720;
case (A43) 18:
if( !A3794 ) goto A1720;
A1570( 117, NULL, NULL, NULL, NULL, "
38D76I5" 0, 0"
82D56I10"593( A3794"
61D46I87"3862 = A1559.A1556;
A1571(NULL,NULL);
A2493 = A1100();
A1104();
A2323 = A1100();
A2340:"
51D25I19"3794 = A3794->A1549"
58D45I22"
A1103((A2323),(A6228)"
50D89I13"1559.A1556 = "
95D83I3";
A"
88D15I24"A3794->A1547, (A78) 0x02"
20D18I4"1593"
24D10I32"4->A1548 );
A3862 &= A1559.A1556"
16D16I1"!"
26D22I1"6"
34D1I1"3"
12D1I1"4"
7D45I17"3:
A2549 = A1100("
50D6I20"101( A2493, A2549, 1"
11D26I23"1102( A2549 );
A2344: ;"
33D34I4"2340"
39D11I25"42:A1103((A2493),(A6228)0"
18D64I2"2("
69D33
38D58I38"102(A2493);
goto A1720;
case (A43) 24:"
65D27I3"859"
33D30I6"6 & 4 "
41D1I1"5"
11D2I2"46"
8D8I8"5: A1338"
22D1I54"46:
goto A1720;
default:
A865(296);
goto A1720;
}
A172"
7D104I8"59.A1556"
109D145I12"338 || A3862"
152D21I4"1859"
26D16I2"51"
27D2I2"47"
12D2I2"48"
7D18I13"47:( A932 )--"
23D39I27"48: ;
}
struct A1537 *
A159"
44D57I5"859 )"
66D33I27"1537 *A1859;
{
struct A1537"
38D4I23"75;
if( !A1859 ) return"
11D18I86"if( A3875 = A1859->A1548 )
return A3875->A1548;
return NULL;
}
Void
A1584(A7051,A4399)"
23D30I36"7051;
A20 A4399;
{register A35 A3876"
36D33I11"3862;
A96 *"
38D9I3", *"
14D17I35"; A96 *A2549, *A5278;
struct A3771 "
22D2I91";
A5972 A2111();
struct A1537 *A3799 = NULL;
struct A561 *A1718;
A7 A3878 = A931 ; A931 = 0"
7D33I11"62 = (A4) 0"
40D12I47"1495 && A415 && !(A415->A163 & (A30) 0x0800) )
"
18D4I4"1711"
12D48I43"1712;
A1711:A1139( A1125, (A66) (A52) A1494"
53D16I57"1712:;
A1559.A1558 = !A1338 && !A1559.A1556;
if( A1338 ) "
22D30I6"1713;
"
36D104I32"1714;
A1713: A1559.A1556 = (A4) "
109D167I10"714:
A1338"
175D18I1"0"
23D24I85"2();
memset((A49)( &A419),0,(size_t)( sizeof( struct A344 ) ));
A3879:
A424 = (A4) 0;"
29D19I11"A1559.A1556"
28D4I4"1715"
12D198I58"1716;
A1715:
switch( A2142 )
{
case 12:
case 26:
case 29:
"
204D4I42"3880;
case 51:
case 30:
case 36: A865(827)"
12D20I118"1717;
case 3:
A897( 527, ";" ); goto A3880;
case 25:
if( A1559.A1553 && A1559.A1553->A1533 == 47 &&
A1559.A1557 ) goto"
25D31I67"7;
default:
A897( 527, A2149 );
goto A1717;
}
A1717:
A1559.A1556 = "
37D5I68";
A1716:
A3880:
A1559.A1557 = (A4) 0;
if( A6245(1999,0) && A539((A33"
11D91
101D5I24"1720;
goto A1721;
A1720:"
10D18I5"!A461"
26D4I4"1722"
12D29I17"1723;
A1722:
A461"
41D36I8"463( (A4"
41D3
12D125I15"1723:
A540( 0x1"
130D6I7"(A33) 0"
11D58I11"477((A17) 1"
63D66I22"725: if( ( A931)+A3878"
75D4I4"1766"
12D71I40"1767;
A1766:A1204( ( A931)+A3878, & A932"
76D32I27"7) 2 ); A931 = 0; A3878 = 0"
37D11I91"67: ; 
A1726:if(0) goto A1725;
A1727:
return;
A1721:
switch( A3876 = A2142 )
{
case 12:
A42"
17I164"4) 1;
A1559.A1557 = (A4) 0;
A3774 = 522;
A1979( 0 , (A20) 0x20|(A20) 0x40|A4399, 0 );
if( A424 ) goto A1769;
goto A1770;
A1769:
A1559.A1556 = (A4) 0;
A1104();
if( A"
8D106I1"0"
115D4I4"1771"
12D29I41"1772;
A1771:
A3778( A1719.A590->A155.A143"
34D15I41"1581( A1589( (A43) 15, A1719.A599, NULL )"
20D69I12"1772:
A2163("
85D17I1"2"
26D5I26"1768;
A6172( A6202, "" ); "
12D28I23"3879;
goto A1773;
A1770"
41D9
14D4I10"1559.A1557"
13D4I4"1774"
12D11I11"1775;
A1774"
16D4I9"62 = (A4)"
9D69I46"1775:
A3799 = A1589( (A43) 9, A1719.A599, NULL"
74D33I20"1581(A3799);
A2168(3"
38D47I5"773:
"
53D67I17"1768;
case (114 |"
72D343I17"00):
A882(200,25)"
350D23I2"8:"
29D2I2"11"
10D217I2"5:"
223D27I248"21:
case 7:
case 9:
case 76:
case 10:
case 52:
case 22:
case 67:
case 68:
case 23:
case 132:
case 133:
case (92 ):
case (95 ):
case 110:
case (101):
case (96):
case 116:
case 119:
case 120:
case 121:
case 122:
case 148:
case 44:
case 187:
case 155:"
38I144"A3774 = 522;
A1979(
0,
(A20) 0x20|(A20) 0x40|( A4399 & (A20) 0x200 ),
0 );
A3799 = A1589( (A43) 9, A1719.A599, NULL );
A1581(A3799);
A2157 = 0;
"
5D6I10"1559.A1557"
15D4I4"1776"
12D44I46"1777;
A1776: A3862 = (A4) 1;
A1777:
A2168(3);
"
50D56I85"1768;
case 38:
{
A4 A2590, A3872, A3873;
A5972 A3807=0;
A4 A3881 = (A4) 0;
Void A1014"
65D9I55"1569 && A1569->A1563 &&
A1569->A1563->A1545 == (A43) 25"
18D3I3"177"
12D10I10"1779;
A177"
16D10I42"81 = (A4) 1;
A1779:
A3812( &A3877 );
A3853"
15D31I5"2163("
36D16I16"093( 8 ,(A34) 0)"
22D11I19"!A3810( &A3877, 1 )"
20D3I3"178"
12D18I60"1781;
A1780:
A1979( 0 , (A20) 0x10 | (A20) 0x1, 0 );
A1781:
"
24D2I1"="
7D91
96D36I66"9;
if( A415 && A415->A163 & ((A30) 0x1000000 | (A30) 0x2000000) ) "
42D40I4"1782"
48D32I4"1783"
37D68I10"82:
A1014("
74D7
13D10I28"783:
A583( A1718, (A78) 0x02"
15D10I43"3807 = A2111( A1718, "if" );
A2323 = A1100("
15D16I40"996( A1718, (A91) 0x10, (A87) 1, 4, NULL"
21D17I43"5491((A4) 0,(A28) 0x8000000|(A28) 0x4000000"
25D9
14D4I20"== 5 && A1463 == ';'"
13D4I4"1784"
12D96I12"1785;
A1784:"
101D2I2"72"
7D4I22"1785:
A2157 = 0;
A1580"
12D9I10"3( 5 ,(A34"
16D1I20"3784( A6185 ); 
A259"
8D77I7"42 == 3"
84D21I10"3807 == -1"
30D4I4"1786"
12D40I93"1787;
A1786: A5669();
A1787:
A1584((A4) 0,(A20) 0x80);
A3872 = !A1559.A1556;
A2493 = A1100();"
45D15I11"A2142 == 32"
24D4I4"1788"
12D20I19"1889;
A1788:
A1567("
25D9I22"3854();
A3853();
A1581"
14I39"89((A43) 25, NULL, NULL) );
A3862 = A15"
7D73I17"6;
A1559.A1556 = "
78D16I26"0;
A1103(( A2323 ),(A6228)"
21D8I22"1996( A1718, (A91) 0x1"
13D5I14"87) 0, 4, NULL"
10D85I5"5491("
90D5I63"0,(A28) 0x8000000|(A28) 0x4000000);
A2163();
if( A2142 != 38 ) "
12D47I3"890"
56D32I35"891;
A1890: A3784( A6185 ); 
A1891:"
37D54I10"A3807 == 1"
63D4I4"1892"
12D12I119"1893;
A1892: A5669();
A1893:
A1584((A4) 0,(A20) 0x80);
A1583( (A43) 14, A1718 );
A3873 = !A1559.A1556;
A2549 = A1100();"
17D24I23"A3873 && A3807 == -1 ) "
30D4I4"1894"
12D51I27"1895;
A1894: A5278 = A2549;"
58D6I39"1896;
A1895: if( A3872 && A3807 == 1 ) "
12D65I4"1897"
74D31I25"898;
A1897: A5278 = A2493"
40D44I33"899;
A1898: if( A3872 && A3873 ) "
51D29I3"900"
38D194I9"901;
A190"
199D21I33"101(A2493,A2549,1);
A5278 = A2493"
29D10I10"1902;
A190"
18D11I4"3872"
20D3I3"190"
12D23I188"1904;
A1903:
A1101(A2493,A2549,5);
A5278 = A2493;
goto A1905;
A1904: if( A3873 ) goto A1906;
goto A1907;
A1906:
A1101(A2549,A2493,5);
A5278 = A2549;
goto A1908;
A1907:
A2549 = A5272( A2549"
28D16I70"1101(A2549,A2493,5);
A5278 = A2549;
A1908:
A1905:
A1902:
A1899:
A1896:"
23I1"&"
13D53
58D42I6"67( 4 "
54D25
31D97I13"1909;
A1889:
"
102D11I4"3881"
20D4I4"1910"
12D85I4"1911"
90D11I42"10:
A6172( A6186, "" ); 
A8787( A8782 , """
17D5I21"911: A1583( (A43) 13,"
10D85
91D36I11"2549 = NULL"
43D10I18"3872 && A3807 == 1"
19D4I4"1912"
12D37I26"1913;
A1912: A5278 = A2493"
45D44I11"1914;
A1913"
50D70
75D2I2"32"
18D41I34"996( A1718, (A91) 0x10, (A87) 0, 4"
51D43I76"A5491((A4) 0,(A28) 0x8000000|(A28) 0x4000000);
A2549 = A1100();
if( A3872 ) "
50D52I3"915"
61D21I35"916;
A1915: A1101( A2549, A2493, 1 "
31D21I35"917;
A1916: A1101( A2549, A2493, 5 "
26D27I25"917:
A5278 = A2549;
A1914"
32D25I16"67( 4 );
A3854()"
32D26I3"259"
36D4I4"1918"
12D85I46"1919;
A1918:A865(548);
A1919: ;
A1909:
if( A52"
97D3I3"330"
12D40I163"331;
A2330:A1103(( A1101( A5278, A2323, 3 ) ),(A6228)0);
A2331:
A1102(A2323); A1102(A2493); A1102(A2549);
A3813( &A3877 );
}
goto A1768;
case 20:
A1567( 0 );
A448("
46D49I36"0 );
A2168(2);
A3862 = A1559.A1556;
"
55D242I61"1768;
case 3:
A1567(1);
if( !(A2154 & 0x40) && A1486 == A1483"
251D4I4"2332"
12D54I83"2333;
A2332: A3785();
A2333:
A3799 = A1589( (A43) 9, NULL, NULL );
A1581( A3799 );
"
59D28I10"1559.A1556"
37D4I4"2334"
12D22I18"2335;
A2334: A3862"
27D15I22"4) 1;
A2335: A2162();
"
23D4I204"68;
case 51:
{
struct A561 *A2547;
A4 A3882;
A4 A3806 = (A4) 0;
A5972 A3807 = 0;
A4 A8238 = (A4) 0;
A2493 = NULL;
A3853();
A2163();
A3812( &A3877 );
A1580();
A1093( 8 ,(A34) 0);
if( !A3810( &A3877, 1 ) ) "
10D65I84"2336;
goto A2337;
A2336:
A1979( 0, (A20) 0x10 | (A20) 0x1 | (A20) 0x4, (A19) 0x10000"
71D52I26"2337:
A3807 = A610( &A1719"
57D52I83"3882 = (A1719.A593 & ((A24) 0x10|(A24) 0x800)) == ((A24) 0x10|(A24) 0x800);
A2547 ="
57D147I12"9.A599;
A232"
152D32I95"1100();
A5491((A4) 0,(A28) 0x4000000);;
A5664( A2547, (A78) 0x02|(A78) 0x80000, A867(845,0) );
"
38D26I22"806 = A3809(A1719.A599"
36D24I5"2338;"
30D21I16"3808(A1719.A599)"
30D4I4"2339"
12D122I21"2340;
A2339:
A865(681"
128D122I100"38 = (A4) 1;
A2340:
A1996( A2547, (A91) 0x10, (A87) 0, 4, NULL );
A2493 = A1100();
A2338:
A1570( 51,"
127D109I1"3"
114D4I38"47, A2493, NULL, A3882 || A3806, A3807"
12D33I9"5628(NULL"
38D196I112"103((A2323),(A6228)0);
A5491((A4) 0,(A28) 0x4000000);;
A1104();
A5664( A2547, (A78) 0x02 | (A78) 0x80000, A870()"
202D138I3"024"
143D71I43"4) 1;
A1996( A2547, (A91) 0x10, (A87) 1, 4,"
76D65I9" );
A1024"
70D30I34"4) 0;
A5491((A4) 0,(A28) 0x8000000"
37D96I27"A2142 == 5 && A1463 == ';' "
104D3I3"234"
12D22I90"2342;
A2341:A865(722);
A2342:
A2157 = 0;
A1093( 5 ,(A34) 0);
A3784( A6184 ); 
if( A8238 ) "
28D59I6"2343;
"
65D6I75"2344;
A2343: A5057( 676, 0 );
A2344:
A1584((A4) 0,(A20) 0x80);
if( A8238 ) "
12D12I111"2345;
goto A2346;
A2345: A5058();
A2346:
A3799 = A1583( (A43) 19, A2547 );
A5628(A3799);
A5766( A3799, A3807 );"
17D59I27"A3807 == 1 && !(A1559.A1553"
64D3I56"42 & (A17) 0x01) ) goto A2347;
goto A2348;
A2347:
A3862 "
8D90I18") 1;
A2348:
A1571("
95D21I51", A3799 );
A1567( 4 );
A3854();
A3813( &A3877 );
}
"
29D93I38"68;
case 30:
{
A4 A3882;
A3853();
A232"
99D24I4"100("
29D4I167"104();
A5491((A4) 0,(A28) 0x8000000|(A28) 0x4000000);;
A1570( 30, A2323, NULL, NULL, NULL, (A4) 0, 0, 0 );
A1580();
A2163();
A3784( A6184 ); 
A1584((A4) 0,(A20) 0x80);"
10D28I64"1559.A1556 &&
!( A1559.A1553->A1542 & ((A17) 0x01|(A17) 0x20) )
"
36D4I4"2349"
12D47I43"2350;
A2349: A3862 = (A4) 1;
A2350:
A1567(0"
52D5I88"093( 51 ,(A34) 0);
A1093( 8 ,(A34) 0);
A1979( 0, (A20) 0x10 | (A20) 0x1 | (A20) 0x2, 0 )"
10D125I2"18"
130D23I39"719.A599;
A3799 = A1583( (A43) 7, A1718"
28D5I102"5628(NULL);
A5628(A3799);
A3882 = (A1719.A593 & ((A24) 0x10|(A24) 0x800)) == ((A24) 0x10|(A24) 0x800);"
11D27I42"3882 && !(A1559.A1553->A1542 & (A17) 0x01)"
36D4I4"2351"
12D47I64"2352;
A2351: A3862 = (A4) 1;
A2352:
A2157 = 0;
A1093( 5 ,(A34) 0"
52D78I42"571( A1718, A3799 );
A2168(3);
A3854();
}
"
86D224I14"68;
case 36:
{"
233D11I3"561"
16D63I49"46 = NULL, *A2547 = NULL, *A3805 = NULL;
A4 A3882"
68D72I15"4) 0;
A4 A3806 "
77D153I30") 0;
A5972 A3807 = 0;
A4 A8238"
158D13I121"4) 0; A74 A5625 = NULL;
A2323 = NULL;
A2493 = NULL;
A3812( &A3877 );
A3853();
A2163();
A1093( 8 ,(A34) 0);
if( A2142 == 5"
22D4I4"2353"
12D110I69"2354;
A2353:
A887( 150, A2149, ", ';;)' assumed" );
A2323 = A1100();
"
116D5I12"2355;
A2354:"
12D19I8"142 == 3"
28D4I4"2356"
12D29I57"2357;
A2356: A2163();
goto A2358;
A2357: if( A3811( &A387"
34D66I8"251 ) ) "
72D62I17"2359;
A3774 = 520"
67D105I16"79( 0, (A20) 0x2"
110D1I13"0) 0x40, (A19"
10D65I11" );
A2546 ="
70D3I71"9.A599;
A1093(3,(A34) 0);
A2359:
A2358:
if( A2142 == 3 || A2142 == 5 ) "
9D24I46"2360;
goto A2361;
A2360:
A3882 = (A4) 1;
A2323"
29D167I34"100();
A1104();
goto A2362;
A2361:"
174D57I17"3810( &A3877, 1 )"
66D4I4"2363"
12D43I77"2364;
A2363:
A1979( 0, (A20) 0x10 | (A20) 0x1, (A19) 0x100000 );
A2364:
A3882"
48D19I102"1719.A593 & ((A24) 0x10|(A24) 0x800))
== ((A24) 0x10|(A24) 0x800);
A3807 = A610( &A1719 );
if( A2547 ="
24D3I9"9.A599 ) "
9D62I4"2365"
70D19I20"2366;
A2365:
A5625 ="
24D124I109"9.A595;
A2323 = A1100();
A5491((A4) 0,(A28) 0x4000000);
A5664( A2547, (A78) 0x02|(A78) 0x80000, A867(845,0) )"
130D23I40"A3806 = A3809(A1719.A599) ) goto A2367;
"
28D21I16"3808(A1719.A599)"
30D4I4"2368"
12D333I28"2369;
A2368:
A865(681);
A823"
338D142I65"A4) 1;
A2369:
A1996( A2547, (A91) 0x10, (A87) 0, 4, NULL );
A2493"
147D82I136"100();
A2367:A1103((A2323),(A6228)0);
A5491((A4) 0,(A28) 0x4000000);;
A1104();
A5664( A2547, (A78) 0x02 | (A78) 0x80000, A870() );
A1024"
88D74I40") 1;
A1996( A2547, (A91) 0x10, (A87) 1, "
81D10I36" );
A1024 = (A4) 0;
A2366: ;
A2362:
"
15D30I31"1095(3,(A35) 0) && A2163() != 5"
39D4I4"2370"
12D4I108"2371;
A2370:
{
A70 A1738;
A3774 = 521;
A1979(0, (A20) 0x20 | (A20) 0x10, (A19) 0x10000 );
A3805 = A1719.A599"
9D38I167"38 = ( A7174 = (A1719.A592), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) )->A303;
if( A1738 >= 21 && A1738 <= 23 ) goto A2372;
goto A2373;
A2372:
A6"
44D9I8"6181, """
14D48I15"8787( A8781, """
53D60I72"2373: ;
}
A2371: ;
A2355:A5491((A4) 0,(A28) 0x8000000|(A28) 0x4000000);
"
65D4I25"2142 == 5 && A1463 == ';'"
13D4I4"2374"
12D115I50"2375;
A2374:A865(722);
A2375:
A2157 = 0;
A1580();
"
120D31I4"3882"
40D4I4"2376"
12D41I94"2377;
A2376: A3807 = 1;
A2377:
A1570( 36, A2323, A2547, A2493, A3805, A3882 || A3806, A3807, 0"
46D16I32"5624( A2546, A2547, A5625, A3805"
22D48I91"093( 5 ,(A34) 0);
A3784( A6184 ); 
if( A8238 ) goto A2378;
goto A2379;
A2378: A5057( 676, 0"
53D41I44"2379:
A1584((A4) 0,(A20) 0x80);
if( A8238 ) "
47D49I103"2380;
goto A2381;
A2380: A5058();
A2381:
A3799 = A1583( (A43) 11, A1033( A2546, A1033( A2547, A3805 ) )"
54D156I22"5766( A3799, A3807 );
"
161D21I42"3882 && !(A1559.A1553->A1542 & (A17) 0x01)"
30D3I3"238"
12D43I114"2383;
A2382: A3862 = (A4) 1;
A2383:
A5627( A3799 );
A1571( NULL, A3799 );
A3813( &A3877 );
A1567( 4 );
A3854();
}
"
51D33I293"68;
case 28:
A6172( A6183, "" );
case 25:
case 140:
A1567(1);
A3799 = A7852( A3876 );
A1593( A3799 );
A3801(A3876);
A3799 = A1589(
A3876 == 25 ? (A43) 1 :
A3876 == 28 ? (A43) 4 :
(A43) 20 , NULL, A3799 );
A1581(A3799);
A2163();
A2168(3);
A3862 = (A4) 1;
goto A1768;
case 42:
{
A58 A3858;
A9070"
38D57I11"8;
A1567(1)"
64D35I5"7834("
45D4I4"2384"
12D46I41"2385;
A2384:A865(1791);
A2385:
if( !A7051"
55D4I4"2386"
12D13I48"2387;
A2386: A904( 904, A415 );
A2387: A2163();
"
20D75I7"42 != 3"
84D45I76"2388;
goto A2389;
A2388:
A3858 = A3857();
A1981( 0, 0, A3858, 0, -3, NULL );"
50D48
53D18I27"1719.A599;
if( A3858 == 24 "
26D21I23"2390;
goto A2391;
A2390"
27D20I43"!A1718 || A1718->A567 != 24 || !(A1309 > 0)"
29D4I4"2392"
12D82I46"2393;
A2392:A865(82);
A2393:
A1948 = A1719.A59"
87D4I31"24 ? (A27) 0x800 : (A27) 0x04;
"
10D4I40"2394;
A2391: A1948 = (A27) 0x04;
A2394: "
12D4I32"2395;
A2389:
A1948 = (A27) 0x800"
9D49I126"18 = NULL;
A2395:
A3799 = A7851(A429,NULL);
A3799 = A1589( (A43) 16, A1718, A3799 );
A1593( A3799 );
A1581(A3799);
A1137( A415"
55D40I26"8 );
A2157 = 0;
A2168(3);
"
45D20I18"7051 && A2142 != 2"
29D4I4"2396"
12D39I54"2397;
A2396: A904(904,A415);
A2397: A3862 = (A4) 1;
}
"
48D44I20"8;
case 37:
{
A81 A8"
49D101I8"567(1);
"
106D5I12"801);
A2163("
10D89I103"095(12,(A35) 0);
A80 = A213( A430, A2149, 2 );
A504( A80, (A39) 10, (A4) 0 );
A80->A127 |= (A27) 0x1000"
96D50I215"80->A127 & (A27) 0x08 ) goto A2398;
goto A2399;
A2398: A6172( A8672, "" ); 
A2399:
if( !A80->A131.A115 ) goto A2400;
goto A2401;
A2400: A922(A80);
A2401:;
if( A1559.A1558 ) goto A2402;
goto A2403;
A2402: A3779( &A80"
55D28
33D41I29"3 );
A2403:A5491((A4) 1,(A28)"
49D9I113"00);
A2220( A80, (A17) 1 );
A3799 = A1589( (A43) 12, A1719.A599, NULL );
A1581(A3799);
A2163();
A2168(3);
A3862 ="
18D214I96"}
goto A1768;
case 47:
A3853();
A3862 = A3861();
A3854();
goto A1768;
case 29:
case 26:
A1567(0)"
220D64I86"A1559.A1558 &&
A1559.A1555 != 26 && A1559.A1555 != 29 ) goto A2404;
goto A2405;
A2404:"
70D97I23"(A2154 & (4 | 0x20)) )
"
103D4I4"2406"
12D39I28"2407;
A2406:A865(616);
A2407"
45D42I18"!(A2154 & 0x20) )
"
48D4I4"2408"
12D141I67"2409;
A2408:A865(825);
A2409: ;
A2405:
A3796( A3876 );
A2168( 6 );
"
149D2I30"68;
case 74:
A1567(1);
A1564()"
12D30I43"68;
case (84 | 0x1000):
A1567(1);
A3789();
"
38D2I28"68;
case (100):
A762(NULL,0)"
12D111I20"68;
case 141:
A3853("
116D4I114"580();
A2163();
A1095( 20 ,(A35) 0);
A1570( 141, NULL, NULL, NULL, NULL, (A4) 0, 0, 0 );
A1584((A4) 0,(A20) 0x80);"
9D28I18"!A1095( 134, 135 )"
37D4I4"2410"
12D66I57"2411;
A2410:
A1583( (A43) 18, NULL );
goto A2412;
A2411: "
71D11I11"2142 == 134"
20D4I4"2413"
12D84I50"2414;
A2413:
A3801( 134 );
A3853();
A2163();
A3862"
89D24I61"559.A1556 &&
!(A1559.A1553 && A1559.A1553->A1542 & (A17) 0x40"
29D40I80"559.A1556 = (A4) 0;
A1584((A4) 0,(A20) 0x80);
A3854();
A1583( (A43) 22, NULL );
"
46D30I32"2415;
A2414:
{
A96 *A2070;
A3862"
35D23I50"559.A1556;
A2493 = A1100();
A2549 = A5272( A1100()"
28D32I23"2416:if( A2142 == 135 )"
39D4I115"2417;
goto A2418;
A2417:
A1104();
A5491((A4) 0,(A28) 0x8000000|(A28) 0x4000000);
A3853();
A2163();
A1979( 0, 0, 0 )"
10D101I27"8 = A1719.A599;
A1559.A1556"
106D159I103"4) 0;
A1580();
A1584((A4) 0,(A20) 0x80);
A1583( (A43) 8, A1718 );
A3862 &= A1559.A1556;
A2070 = A1100()"
165D165I12"A1559.A1556 "
173D4I4"2419"
12D20I37"2420;
A2419: A1101( A2549, A2070, 5 )"
28D184I71"2421;
A2420: A1101( A2549, A2070, 1 );
A2421:
A1102( A2070 );
A3854();
"
190D14I2"24"
19D47I28"2418: A1101( A2493, A2549, 7"
53D30I66"103((A2493),(A6228)0);
A1102(A2493);
A1102(A2549);
A1583( (A43) 23"
36D13I47" );
}
A2415:
A2412:
A1571(NULL,NULL);
A3854();
"
21D2I51"68;
case 117:
A3853();
A3862 = A5992(NULL);
A3854()"
12D28I104"68;
case 128:
A4329();
goto A1768;
default:
A865(42);
A1097(3);
goto A1768;
}
A1768:
A1559.A1556 = A1338"
33D4I24"3862;
if( A3799 && A4399"
9D2I2"20"
7D23I41"00 ) goto A2422;
goto A2423;
A2422:
A3799"
28D88I64"46 |= 0x10;
A2423:
A1559.A1555 = A3876;
A2424: if( ( A931)+A3878"
97D4I4"2427"
12D59I96"2428;
A2427:A1204( ( A931)+A3878, & A932, (A17) 2 ); A931 = 0; A3878 = 0;
A2428: ; 
A2425:if(0) "
65D58I15"2424;
A2426: ;
"
66D8I29"7841(A8107,A8108,A8083,A8084)"
15D13I10"107, A8108"
23D76I188"5543 *A8083, *A8084;
{
A74 A3404, A3071, A8106, A2493; A74 A3553; A81 A7918; A74 A5595, A5596; A74 A2324, A2591;
A3404 = A7849( A8107, A8084, 'W', 'N' ); if( A3404 ) goto A1711;
goto A1712"
81D19I54"11:
A2493 = A7849( A8108, A8083, 'U', '*' ); if( A3553"
24D47I27"871( A3404, A2493 ) ) goto "
52I19";
goto A1714;
A1713"
7D12I22"7918 = (A81) *A3553++ "
23D1I1"5"
12D1I1"6"
7D10I164"5:
A5595 = A8217( A8107, A8084, 'W', 'N', A7918, (A74) 0 );
A5596 = A8217( A8108, A8083, 'U', '*', A7918, (A74) 0 );
A8218( 457, A5595, A8107, A5596, A8108, A7918 )"
28D85I3"6: "
91D15I3"4: "
21D5I87"2:
A3071 = A7849( A8107, A8084, 'U', 'N' ); A8106 = A5954( A3071, A3404 ); if( A8106 ) "
14D1I13"7;
goto A1720"
7I3559"7:
A2493 = A7849( A8108, A8083, 'W', '*' ); if( A3553 = A2871( A8106, A2493 ) ) goto A1721;
goto A1722;
A1721:
if( A7918 = (A81) *A3553++ ) goto A1723;
goto A1725;
A1723:
A5595 = A8217( A8107, A8084, 'U', 'N', A7918, A3404 );
A5596 = A8217( A8108, A8083, 'W', '*', A7918, (A74) 0 );
A8218( 458, A5595, A8107, A5596, A8108, A7918 );
goto A1721;
A1725: ;
A1722: ;
A1720:
A2324 = A7846( A8107, A8084, 'N' );
if( A2324 ) goto A1726;
goto A1727;
A1726:
A2591 = A7846( A8108, A8083, '*' );
A8219( 460, A8107, A8108, A2871( A2324, A2591 ), 0 );
A8103( A8107, A8108, A2324, A2591 );
A1727: ;
}
Void
A7842(A2903,A8084)
A81 A2903;
struct A5543 *A8084;
{
A74 A2829;
A2829 = A7849( A2903, A8084, 'U', 'N' ); if( A2829 ) goto A1711;
goto A1712;
A1711:
A8219( 459, A2903, A2903, A2829, 1 );
A1712: ;
}
A74
A8217(A3688,A1731,A4054,A8120,A7918,A8239)
A81 A3688; struct A5543 *A1731; A9 A4054, A8120; A81 A7918;
A74 A8239;
{
A66 A1730 = (A66) A1731->A5562; A66 A1732; A66 A1875; struct A149 *A1948; A74 A7920 = NULL; A74 A5633; A13 *A5643; A81 A80;
if( !A3688 ) return NULL;
A1875 = (A66) A1007( A8737, (A49) A3688 );
if( !A1875 || !A1731 ) return NULL;
A5643 = A1731->A5558[A1875];
A1732 = 0;
A1713:
if( A1732 < A1730) goto A1711;
goto A1712;
A1714: A1732++;
goto A1713;
A1711:
if( A1140( A5643, A1732 ) || A1732 == A1875 ) goto A1715;
goto A1716;
A1715:
if( (( A80=((A81)((A8737)->A988)[ A1732])) && ( A1948 =( ( A80)->A156 == (A41) 20 ? ( A80)->A155.A150 : (struct A149 *) 0 ))) ) goto A1717;
goto A1720;
A1717:
A5633 = NULL;
if( A4054 == 'W' ) goto A1721;
goto A1722;
A1721:
if( A8120 == 'P' || A8120 == '*' ) goto A1723;
goto A1725;
A1723:
A5633 = A108( A5633, A1948->A7660 );
A1725:
if( A8120 == 'N' || A8120 == '*' ) goto A1726;
goto A1727;
A1726:
A5633 = A108( A5633, A1948->A7658 );
A1727: ;
A1722:
if( A4054 == 'U' ) goto A1766;
goto A1767;
A1766:
if( A8120 == 'P' || A8120 == '*' ) goto A1768;
goto A1769;
A1768:
A5633 = A108( A5633, A1948->A7661 );
A1769:
if( A8120 == 'N' || A8120 == '*' ) goto A1770;
goto A1771;
A1770:
A5633 = A108( A5633, A1948->A7659 );
A1771: ;
A1767:
if( A107( A5633, (A49) A7918 ) &&
!A107( A8239, (A49) A7918 ) ) goto A1772;
goto A1773;
A1772:
A7920 = A235( A7920, (A49) A80 );
A1773: ;
A1720: ;
A1716: goto A1714;
A1712:
return A7920;
}
Void
A8103( A8107, A8108, A8109, A8110 )
A81 A8107, A8108;
A74 A8109, A8110;
{
A81 A1826, A1827;
A74 A8111;
struct A149 *A2324, *A2591;
A7616 A7071;
if( !A8109 || !A8110 ) return;
A1711:if( A1826 = (A81) * A8109++ ) goto A1712;
goto A1713;
A1712:
A2324 = ( (A1826)->A156 == (A41) 20 ? (A1826)->A155.A150 : (struct A149 *) 0 );
if( !A2324 ) goto A1711;
A7071 = A2324->A7655;
if( !A7071 ) goto A1711;
A8111 = A8110;
A1716:
if( A1827 = (A81) * A8111++ ) goto A1714;
goto A1715;
A1714:
A2591 = ( ( A1827 )->A156 == (A41) 20 ? ( A1827 )->A155.A150 : (struct A149 *) 0 );
if( !A2591 ) goto A1716;
if( A2591->A7655 == A7071 ) goto A1717;
goto A1720;
A1717:
A7747( 461, A8107, A1826,
((A9036) A996(A5434,(A54)(A7071))), A8108, A1827 );
A1720: ;
goto A1716;
A1715: ;
goto A1711;
A1713: ;
}
Void
A7843()
{
A81 A1942;
A1942 = A3959( "Lock State" ); A1942 = A3958( A429, A1942 ); if( !A1942 ) return;
A1942->A127 |= (A27) 0x1000|(A27) 0x100000; A1942->A163 |= (A30) 0x0400; A1942->A130 = 24; if( A418 ) goto A1711;
goto A1712;
A1711: A418->A7651 = A1942;
A1712: ; }
Void
A8218( A4277, A8240, A8107, A8241, A8108, A7918 )
A67 A4277;
A74 A8240, A8241;
A81 A8107, A8108;
A81 A7918;
{
A81 A8242, A8243;
A74 A8244 = A8241;
if( !A8240 || !A8241 ) return;
A1711:if( A8242 = (A81) *A8240++ ) goto A1712;
goto A1713;
A171"
5D108I4000"241 = A8244;
A1714:if( A8243 = (A81) *A8241++ ) goto A1715;
goto A1716;
A1715:
A8212( A4277, A8242, A8107, A7918, A8243, A8108 );
goto A1714;
A1716: ;
goto A1711;
A1713: ;
}
Void
A8219( A4277, A8107, A8108, A5633, A1709 )
A67 A4277;
A81 A8107, A8108;
A74 A5633;
A17 A1709;
{
A81 A7918;
if( !A5633 ) return;
A1711:if( A7918 = (A81) *A5633++ ) goto A1712;
goto A1713;
A1712:
{
A58 A1740;
A1740 = A7918->A130;
if( A1709 & 1 &&
A620(A1740) && !A8213(A1740) )
goto A1711;
A7748( A4277, A8107, A7918, A8108 );
} goto A1711;
A1713: ;
}
Void
A8112(A8113,A8114,A80)
A81 A8113; struct A149 *A8114; A81 A80;
{
struct A149 *A1948; A7616 A8115; A7616 A8116; A48 A8117; A48 A8118; A48 A8119;
A48 A1758;
A1948 = ( ( A80 )->A156 == (A41) 20 ? ( A80 )->A155.A150 : (struct A149 *) 0 );
if( !A1948 ) return;
if( !(A1948->A7654 & (A44) 0x0400) )
return;
A8116 = A1948->A7657;
A8115 = A1948->A7656;
if( A8116 ) goto A1711;
goto A1712;
A1711:
A8118 = (A48) ((A9036) A996(A5434,(A54)( A8116 ))); A8119 = A866( ",$s,", A8114->A5504, NULL, NULL ); if( A8118 && strstr( A8118, A8119 ) ) goto A1713;
goto A1714;
A1713:
A8118 = A1076( A943, A8118+1 );
A7172( A8118, ',' );
A1758 = A866( "thread_not($s)", A8118, NULL, NULL );
A7746( 462, A8113, A80, A1758 );
A1714: ;
goto A1715;
A1712: if( A8115 ) goto A1716;
goto A1717;
A1716:
A8117 = (A48) ((A9036) A996(A5434,(A54)( A8115 ))); A8119 = A866( ",$s,", A8114->A5504, NULL, NULL ); if( A8117 && !strstr( A8117, A8119 ) ) goto A1720;
goto A1721;
A1720:
A8117 = A1076( A943, A8117+1 );
A7172( A8117, ',' );
A1758 = A866( "thread_only($s)", A8117, NULL, NULL );
A7746( 462, A8113, A80, A1758 );
A1721: ;
goto A1722;
A1717:
A7746( 462, A8113, A80, "thread_not" );
A1722: ;
A1715: ;
}
Void
A7845(A8113,A8114)
A81 A8113; struct A149 *A8114; {
A74 A7920;
A81 A1942;
A7920 = A7620( NULL, A8113 ); if( !A7920 ) return; 
A1711:if( A1942 = (A81) *A7920++ ) goto A1712;
goto A1713;
A1712: A8112( A8113, A8114, A1942 ); goto A1711;
A1713: ; }
Void
A7847( A4210, A1943 )
A44 A4210;
A68 A1943;
{
A81 A1942;
struct A147 *A2113;
if( A4210 & ((A44) 0x0004 | (A44) 0x0008) ) goto A1711;
goto A1712;
A1711: if( A418 && (A1942 = A418->A7651) ) goto A1713;
goto A1714;
A1713: if( A2113 = ( (A1942)->A156 == (A41) 19 ? (A1942)->A155.A148 : (struct A147 *) 0 ) ) goto A1715;
A2113 = (struct A147 *)A1005( A1383 ); 
A1716: ( A1942)->A156 = (A41) 19; ( A1942)->A155.A148 = A2113 ; 
A1717:if(0) goto A1716;
A1720: ; 
A1715:
if( A4210 & (A44) 0x0004 ) goto A1721;
goto A1722;
A1721: A2113->A552 |= 0x40000; A2949( &A2113->A557, A1943 ); if( A2113->A6232 == 0 ) goto A1723;
goto A1725;
A1723:
A2113->A6232 = 4;
A1725:
A1112( &A2113->A6234, A1943 );
++A2113->A6233;
goto A1726;
A1722: if( A2113->A552 & 0x40000 ) goto A1727;
goto A1766;
A1727: if( --A2113->A6233 <= 0 ) goto A1767;
goto A1768;
A1767: A2113->A552 &= ~0x40000;
A1768: ; 
goto A1769;
A1766: if( !(A5962( A415, 0xF8 ) & (A44) 0x0008) ) goto A1770;
goto A1771;
A1770:A865( 455 );
A1771: ;
A1769: ; 
A1726: ;
A1714: ;
A1712: ;
}
A4
A7848( )
{
A81 A1942;
struct A147 *A2113;
if( A418 && (A1942 = A418->A7651) &&
(A2113 = ( (A1942)->A156 == (A41) 19 ? (A1942)->A155.A148 : (struct A147 *) 0 )) &&
A2113->A552 & 0x40000
) return (A4) 1;
return (A4) 0;
}
A74
A7849(A3688,A1731,A4054,A8120)
A81 A3688; struct A5543 *A1731; A9 A4054, A8120; {
A66 A1730 = (A66) A1731->A5562; A66 A1732; A66 A1875; struct A149 *A1948; A74 A5633 = NULL; A13 *A5643; A81 A80;
if( !A3688 ) return NULL;
A1875 = (A66) A1007( A8737, (A49) A3688 );
if( !A1875 || !A1731 ) return NULL;
A5643 = A1731->A5558[A1875];
A1732 = 0;
A1713:
if( A1732 < A1730) goto A1711;
goto A1712;
A1714: A1732++;
goto A1713;
A1711:
if( A1140( A5643, A1732 ) || A1732 == A1875 ) goto A1715;
goto A1716;
A1715:
if( (( A80=((A81)((A8737)->A988)[ A1732])) && ( A1948 =( ( A80)->A156 == (A41) 20 ? ( A80)->A155.A150 : (struct A149 *) 0 ))) ) goto A1717;
goto A1720;
A1717:
if( A4054 == 'W' ) goto A1721;
goto A1722;
A1721:
if( A8120 == 'P' || A8120 == '*' ) goto A1723;
goto A1725;
A1723:
A5633 = A108( "
108I2112"A5633, A1948->A7660 );
A1725:
if( A8120 == 'N' || A8120 == '*' ) goto A1726;
goto A1727;
A1726:
A5633 = A108( A5633, A1948->A7658 );
A1727: ;
A1722:
if( A4054 == 'U' ) goto A1766;
goto A1767;
A1766:
if( A8120 == 'P' || A8120 == '*' ) goto A1768;
goto A1769;
A1768:
A5633 = A108( A5633, A1948->A7661 );
A1769:
if( A8120 == 'N' || A8120 == '*' ) goto A1770;
goto A1771;
A1770:
A5633 = A108( A5633, A1948->A7659 );
A1771: ;
A1767: ;
A1720: ;
A1716: goto A1714;
A1712:
return A5633;
}
A74
A7846(A3688,A1731,A8120)
A81 A3688; struct A5543 *A1731; A9 A8120; {
A66 A1730 = (A66) A1731->A5562; A66 A1732; A66 A1875; struct A149 *A1948; A74 A7920 = NULL; A13 *A5643; A81 A80; A81 A4573; A17 A4210; struct A149 *A1946; struct A8393 A8421;
if( !A3688 ) return NULL; A1875 = (A66) A1007( A8737, (A49) A3688 ); if( !A1875 || !A1731 ) return NULL; A5643 = A1731->A5558[A1875]; A1732 = 0;
A1713:
if( A1732 < A1730) goto A1711;
goto A1712;
A1714: A1732++;
goto A1713;
A1711:
if( (A1732==A1875 || A1140( A5643, A1732 )) && (( A80=((A81)((A8737)->A988)[ A1732])) && ( A1948 =( ( A80)->A156 == (A41) 20 ? ( A80)->A155.A150 : (struct A149 *) 0 ))) ) goto A1715;
goto A1716;
A1715: (void) A7639( &A8421, A1948->A7652 , NULL );
A1721:
if( A4573 = A7639( &A8421, NULL, & A4210 )) goto A1717;
goto A1720;
A1717: if( (A8120 == '*' || A4210 & (A17) 0x2) && (A1946 = ( (A4573)->A156 == (A41) 20 ? (A4573)->A155.A150 : (struct A149 *) 0 )) && A1946->A7654 & (A44) 0x0200 ) goto A1722;
goto A1723;
A1722:
A7920 = A235( A7920, (A49) A4573 ); 
A1723: ;
goto A1721;
A1720: ; 
A1716: ; goto A1714;
A1712: return A7920; }
Void
A1594()
{
A81 A80;
A49 *A2026;
struct A144 *A2975;
A54 A1732, A2976;
A39 A1761;
A2975 = (A418 ? A418->A364 : A1339);
A1761 = (A39) 1;
A2976 = A2975->A991 + 1;
A2026 = A2975->A988;
A1732 = 0;
A1713:
if( A1732 < A2976) goto A1711;
goto A1712;
A1714: A1732++;
goto A1713;
A1711:
if( (A80 = (A81) A2026[A1732]) && A80->A168.A166 == A1761 ) goto A1715;
goto A1716;
A1715:
A1566( A80 );
A1716: ;
goto A1714;
A1712:
A8414();
}
/*  Obfuscation by "The C Shroud" 
    Gimpel Software -- Collegeville, PA, USA  (610) 584-4261 */
"
Fa15.c
209D4I7"7 A9235"
18D2I1"9"
12I16"A6 A10;
typedef "
291D20
27D4I8"32 A9069"
14I19"A9069 A24;
typedef "
10D4I2"25"
14D9I13"unsigned A890"
21D6I10"9069 A9150"
17D6I10"9069 A9070"
17D8I8"9070 A27"
18D12I9"A9070 A28"
22I21"A9070 A5793;
typedef "
10D4I2"29"
14D17
26D8I5"A6228"
19D6I8"9070 A30"
25D3I8"long A31"
13I17"A17 A32;
typedef "
11D1I1"3"
11D7I12"unsigned A34"
19D5I5"4 A35"
17D5I5"5 A36"
21D1I1"7"
17D1I1"8"
16D2I2"39"
18D1I1"0"
17D1I1"1"
17D1I1"2"
12D6I6"34 A43"
22D1I1"4"
17D1I1"5"
11D7I7"A42 A46"
17I17"int A47;
typedef "
342D2I4"9236"
17D4I2"63"
19D1I3"577"
18D1I1"4"
16D4I2"65"
20D2I2"19"
18D4I4"8258"
14I19"A54 A7616;
typedef "
138D6I3"A16"
60D13I3"A72"
122D6I5"A9069"
20D6I5"A9069"
1373I69"struct A9304
{
A17 A9305;
A5794 A9306;
};
extern struct A9304 A9307;
"
6D4I4"9308"
14D4I4"9309"
17D1I1"5"
11D4I4"5566"
14D4I4"5567"
14D3I17"7618();
Void A761"
8D13
19D3I17"5569();
Void A915"
8D9I10"Void A9152"
14D17I2"74"
22D1I15"0();
Void A7621"
10I41"6226();
A5794 A6227();
A81 A7622();
A58 A"
460D2I4"9070"
28D2I4"9070"
151I19"struct A114 A9153;
"
1389D2I2"92"
16D6I12"5794 A7637()"
15I16"A4 A202;
extern "
3337D2I4"9070"
159I11"A58 A9238; "
88D2I4"9070"
39D2I4"9070"
367I11"A17 A9071;
"
535I13"A9236 A9239;
"
1098D2I4"9070"
380D7I8"17 A9154"
24D1I1"1"
12D6I7"62 A442"
16I17"A4 A443 ;
extern "
150D3I4"9072"
14D10I9"Void A451"
22D9I9"5794 A452"
21D9I9"9036 A453"
29D1I1"4"
13D12
20D1I1"5"
12D9I22"A315 A456 ;
A5794 A457"
28D1I1"8"
18D4I3"459"
21D3I4"5268"
14D16
24D1I1"0"
12I16"A4 A461;
extern "
8D1I1"2"
12D8I11"Void A463()"
22D4I3"464"
13I18"A58 A8823;
extern "
1037D7I10"Void A9155"
18D9I7"A4 A504"
20I20"Void A505();
extern "
1042D2I4"9070"
1940D8I19"struct A640 * A9310"
24D4I3"663"
15D10I9"A48 A7505"
29D2I2"37"
19D3I4"7176"
14D7I9"Void A664"
22D4I3"665"
16D8I7"4 A4442"
19D6I6"A17 A5"
27D3I2"66"
21D2I3"031"
21D1I1"7"
20D1I1"8"
12I20"Void A669();
extern "
278D3I4"4476"
14D10I17"struct A640 *A675"
27D4I4"7719"
21D4I4"8914"
15D8I12"Void A7720()"
18D7I7"17 A933"
18D8I7"7 A5254"
18D2I2"81"
7D1I1"0"
11D2I2"17"
7D1I1"1"
11D1I2"35"
6D1I1"2"
11D1I2"92"
6D1I1"3"
11D2I1"7"
7D1I1"4"
11D8I7"4 A2145"
18D1I2"68"
6D1I1"6"
13D14I6"*A2147"
24D8I7"4 A2148"
18D7I16"2 A2149[M_TOKEN]"
17D2I2"87"
7D1I1"0"
11D2I1"4"
7D1I1"1"
15D4I4"2152"
14D2I2"36"
7D1I1"3"
11D27I7"35 A826"
38D1I2"17"
6D3I1"4"
13D10I28"7
A2155,
A2156,
A2157,
A6214"
19D4I2"A9"
9D1I1"8"
12D10I9"A17 A8825"
27D3I3"215"
15D3I4"Void"
8D1I1"0"
18D4I4"8209"
23D1I1"1"
12D3I4"Void"
8D1I1"2"
12D10I9"A35 A2163"
29D1I1"4"
12D5I4"Void"
10D1I1"0"
12D9I8"A35 A216"
22D7I10"9036 A8211"
24D4I4"5255"
15D4I2"A4"
9D11I16"6();
extern Void"
16I37"7();
extern Void A2168();
struct A216"
465I42"struct A9073
{
A48 A9074;
A9069 A9075;
};
"
422D6I7"8 A9076"
17D9I8"A42 A982"
20D8I9"long A983"
24D4I3"984"
16D8I8"87 A6039"
20D8I8"61 A7724"
19D9I9"A92 A7260"
20D8I9"long A985"
24D4I3"986"
16D9I8"34 A5670"
20I21"A5794 A987();
extern "
1045I7"9129,
A"
44D4I4"9156"
11I42"9157,
A9158,
A9159,
A9160,
A9161,
A8639,
A"
21D10I2"91"
15D2I2"91"
7I29"9164,
A6176, 
A7062,
A7063,
A"
91I21"9240,
A9241,
A9130,
A"
21I28"9165,
A9166,
A9167,
A9168,
A"
28I14"9292,
A9169,
A"
92I42"9242,
A9243,
A9131,
A9132,
A9133,
A9134,
A"
71I7"9170,
A"
307D4I4"9171"
21I42"9244();
extern Void A8266();
extern Void A"
8I80"extern Void A9172();
extern A4 A9173();
extern A4 A9174();
extern Void A9175();
"
746D9I7"4 A9176"
21D7I9"5794 A868"
19D6I6"7 A598"
25D1I1"0"
19D1I1"1"
13D10I7"61 A872"
22D7I10"5794 A6037"
19D10I7"61 A873"
22D7I10"5794 A8589"
20D5I6"8 A874"
16D9I7"A4 A875"
28D1I1"6"
20D1I1"7"
20D1I1"8"
19D2I2"79"
19D4I3"880"
21D4I4"6172"
21D3I4"9293"
20D4I4"9177"
21D4I4"8787"
23D1I1"1"
20D1I2"29"
18D4I4"7262"
23D1I1"2"
20D1I1"3"
20D2I2"48"
21D1I1"4"
20D1I1"5"
18D3I4"5667"
22D1I1"6"
19D2I2"87"
20D2I2"88"
20D2I2"89"
19D4I3"890"
21D4I3"891"
21D4I3"892"
21D4I4"7745"
24D1I1"6"
21D1I1"7"
20I1"4"
18D3I4"7748"
20D4I4"7749"
21D4I3"893"
23D1I1"4"
18D4I4"1857"
22D3I3"958"
22D1I1"5"
19D3I3"061"
20D3I4"5821"
20D4I3"896"
21D3I4"7507"
20D4I3"897"
21D4I4"5981"
23D1I1"8"
19D3I3"750"
20D3I4"8212"
20D3I3"899"
20D3I4"7177"
22D1I1"0"
18D4I3"901"
23D1I1"2"
20D1I1"3"
18D3I4"8944"
22D1I1"4"
18D4I3"905"
21D3I3"907"
21D4I4"9078"
23D1I1"7"
18D3I4"5077"
20D3I4"8267"
20D3I4"8830"
14D7I9"Void A908"
25D2I2"09"
13D9I9"Void A910"
28D1I1"1"
12D9I7"A4 A912"
20D16
24D1I1"3"
14D8I7"4 A5431"
19D11I9"Void A914"
22D10I9"Void A915"
22D11I6"7 A916"
27D2I2"17"
13D9I10"A5794 A918"
27D3I4"1739"
15D6I9"5794 A919"
24D4I3"920"
15D9I9"Void A921"
26D4I3"922"
15D20I14"A5794 A923();
"
31D4I3"924"
16D7I10"5794 A7263"
19D8I8"61 A5668"
19D7I12"Void A5669()"
16D18
26D13I12"7734 A7751; "
21D7I7"4 A7752"
18D18I10"A4 A5914()"
28D6I10"861 A926()"
16D8I6"4 A927"
18D6I8"4 A928()"
15D9I19"struct A849 *A929()"
19D6I9"61 A930()"
16D8I12"9236 A9245()"
18D6I12"9236 A9246()"
15D9I12"Void A9247()"
18D7I18"struct A144 *A5050"
17D8I6"7 A931"
18D6I8"61 *A932"
16D8I6"7 A933"
21D7I7"*A934;
"
14D18I7"A7 A935"
28D7I8"61 *A936"
16D18I7"A7 A937"
27D18I9"A61 *A938"
27D18I7"A7 A939"
28D9I8"61 *A940"
19D9I6"7 A941"
19D9I8"61 *A942"
19D12I10"61 A6038; "
19D11I18"struct A144 *A1696"
23D8I5" A943"
18D10I7"7 A9294"
19D11I18"struct A144 *A7178"
20D17
26D7I8"44 *A717"
17D7I18"struct A144 *A5432"
17D6I9"5794 A944"
15D17I10"A5794 A945"
26D20I12"A5794 A946;
"
27D4I5"A5794"
9D3I1"4"
19D6I4"7180"
15D12I11"A5794 A7227"
21D12I11"A5794 A7181"
22D7I10"5794 A5510"
17D8I7"68 A948"
17D18
26D10I9"114 *A949"
20D7I6"7 A950"
17D7I6"4 A951"
16D10I17"struct A114 *A952"
19D13I20"struct A144 *A7265; "
27D3I3"266"
15D7I10"5794 A1689"
24D4I4"7753"
15D18I10"Void A7754"
30D10I7"6 A1022"
20D10I8"81 A5511"
19D12I9"A81 A8770"
21D12I18"struct A561 *A1023"
21D12I8"A4 A1024"
22D10I7"7 A1025"
19D18I8"A4 A1026"
29D18I9"A49 A1027"
29D10I9"Void A775"
22D10I8"A4 A1028"
27D15I8"1029();
"
21D4I31"9079();
A48 A9080();
Void A9081"
15D21
38D1I1"0"
13D7I8"17 A1031"
18D18I9"A79 A1032"
35D4I4"5671"
15D8I10"Void A5672"
19D9I10"Void A8401"
21D8I8"17 A5512"
19D10I18"struct A561 *A1033"
21D9I10"Void A9135"
20D9I18"struct A561 *A1034"
21D7I10"5794 A1035"
18D47I10"Void A2317"
58D9I10"Void A5673"
20D9I10"Void A1036"
20D9I10"Void A1037"
20D11I18"struct A561 *A1038"
22D8I6"A4 A56"
21D9I18"struct A561 *A1039"
20D11I10"Void A7182"
22D18I10"A4 A7183()"
27D10I9"A58 A8268"
22D7I28"78 A1040();
extern Void A775"
12D6I49"extern A81 A1041();
extern A81 A7508();
extern A4"
11D3I49"7();
extern A5794 A8590();
struct A7758 *A7759();"
12D51I3"0()"
60D18I11"A78 A1042()"
28D8I10"78 A5271()"
18D8I10"78 A1043()"
18D8I12"5972 A1044()"
17D9I12"Void A2274()"
18D17I42"A54 A5433();
extern A9036 A9039();
extern "
26D106I9"44 *A5434"
116D7I12"9150 A9178()"
16D13I32"Void A7761();
extern A48 A7906()"
23D31I63"7758
{
A40 A7762;
A87 A7763, A7764;
A17 A7765, A7766;
A67 A7767"
43D21
29D11I10"7758 A7768"
20D79I9"A87 A7769"
88D12I9"A87 A7770"
21D12I9"A88 A7771"
21D12I9"A10 A7772"
21D43I17"const A88 A7773;
"
52D19I43"045
{
A18 A1046;
A72 A1047;
A7470 A1048;
A3"
24D2I58"49;
};
struct A1050
{
A18 A1051;
A17 A1052;
A5794 A1053;
}"
12D7I7"7 A3140"
17D34I14"81 A3143[20];
"
43D9I33"054
{
A54 A1055;
A55 A1056[25];
}"
19D8I9"55 *A3164"
19D11I19"struct A1054 *A7509"
20D78
86D209I12"144 *A7774;
"
217D10I51"7500
{
struct A7500 *A7775; A54 A7510; A42 A7511; }"
19D9I12"Void A1057()"
18D8I12"Void A1058()"
17D9I10"Void A1059"
20D8I10"Void A1060"
19D10I11"A5794 A1061"
21D22I18"struct A118 *A1062"
33D13I8" A1063;
"
20D13I8"A4 A7267"
26D4I4"7776"
14D10I8"63 A7777"
19D21
29D3I3"114"
8D2I2"64"
11I40"A81 A7512();
extern A49 A1073();
extern "
8D2I66"74();
extern A72 A1075[];
extern A9036 A1076();
extern A9036 A7778"
14D94I118"3097
{
A70 A3098; A72 A3099; A7468 A3100; A7468 A3101; A72 A3102; A72 A3103; A72 A3104; A7 A3105; A4 A3106; A7 A5282; "
100D5I85"283; A32 A5284; A74 A5966; A17 A6270; };
extern A81 A3107;
extern A315 A3108;
extern "
13D55I62"3097 A3109;
extern A58 A3110;
extern A4 A6067;
extern A72 A311"
60D10I14"extern A6 A311"
15D45
52D11I14"Void A1077();
"
19D7I21"48 strcat(), strcpy()"
17D9I14"48 strncpy(); "
16D11I13"int strncmp()"
24D4I4"1078"
15D8I7"2 A7268"
27D2I2"79"
13D12I18"struct A553 *A1080"
21I17"A7 A9295;
extern "
6D67I3"108"
72I66"struct A553
{
struct A553 *A1082;
A7 A1083;
struct A114 A1084;
};
"
15D81I1"8"
86D75I59"struct A5513
{
A81 A5514;
struct A147 *A5515;
};
A5972 A777"
80D39I10"A5972 A778"
44D17I10"A5972 A778"
22D16I10"A5972 A778"
21D16I10"A5972 A778"
21D16I10"A5972 A778"
21I15"A5972 A7785();
"
7D14I11"A74 A6242; "
21D12I8"A7 A1086"
21D12I8"A7 A7184"
21D12I11"A5794 A5248"
25D6I4"7185"
15D10I10"A95 *A1087"
27D4I4"1088"
21D4I4"1089"
21D4I4"7186"
21D3I3"109"
21D4I4"7187"
15D10I11"A5794 A1091"
21D9I10"Void A1092"
27D3I3"093"
20D4I4"8269"
20D3I3"094"
14D10I8"A4 A1095"
21D10I8"A4 A1096"
28D3I3"097"
20D4I4"1098"
16D10I7"4 A1099"
21D10I11"A94 * A5272"
21D9I10"A94 * A110"
21D10I11"A94 * A1101"
29D2I2"02"
19D4I4"1103"
15D11I10"Void A1104"
30D2I2"05"
21D2I2"06"
19D4I4"5675"
21D4I4"6243"
15D10I8"A4 A5518"
27D4I4"7786"
21D4I4"5516"
21D4I4"5517"
21D4I4"5519"
22D3I3"520"
14D18I12"Void A5521()"
27D17
23D4I4"5522"
15D10I9"A23 A7787"
21D8I10"Void A1107"
19D10I10"Void A1108"
22D10I7"4 A1109"
21D11I10"Void A1110"
22D11I10"Void A1111"
22D11I10"Void A1112"
22I21"Void A2942();
extern "
7D4I4"1113"
15D55I12"Void A2949()"
64D13I12"Void A7070()"
22D9I12"Void A1114()"
18D10I12"Void A1115()"
19D9I12"Void A7269()"
19D8I12"94 * A1116()"
17D9I12"Void A1117()"
18D18I12"Void A1118()"
27D18I12"Void A1119()"
27D26I12"Void A7788()"
35D8I12"Void A5676()"
17D18
26D2I2"20"
21D2I2"21"
21D2I2"22"
13D9I10"Void A8270"
26D4I4"5249"
15D10I18"struct A144 *A5523"
19I17"A7 A5822;
extern "
6D4I4"7789"
21D4I4"7790"
19D4I4"7791"
15D10I10"A94 *A7792"
21D10I11"A5794 A7793"
22D7I10"5794 A7794"
19D7I10"5794 A7795"
18D10I11"A5794 A7796"
22D8I10"5794 A7797"
20D2I4"5794"
7D3I45"8();
struct A5304 { A77 A3049; A5794 A1148; }"
12D12I13"A2 A1123[100]"
21D12I9"A17 A1124"
21D12I10"A13 *A1125"
21D12I9"A81 A1126"
23D9I7"8 A1127"
19D1I1"5"
6D4I2"28"
13D11I18"struct A144 *A1129"
20D11I18"struct A144 *A1130"
20D11I26"const struct A5304 A3050[]"
21D10I7"4 A1131"
20D17I8"38 A1132"
26D45I9"Void A113"
65D1I1"3"
21D1I1"3"
13D9I8"A17 A113"
29D1I1"3"
13D10I8"A4 A2979"
29D1I1"3"
19D3I3"917"
23D2I2"39"
13I19"A4 A1140();
extern "
8D1I1"4"
6D124I231"extern Void A5529();
extern A4 A5530();
extern A7 A5532();
extern Void A5533();
extern A66 A5534();
extern A66 A7799();
extern Void A5531();
extern Void A1142();
extern Void A1143();
extern Void A1144();
extern A50 A1145();
extern "
131D339I15"46();
extern A7"
344D13I118"47();
extern A48 A1148();
extern A48 A1149();
extern A77 A1150();
extern A58 *A5067, *A5068;
extern A17 *A8945, *A8946"
22D4I6"8271()"
15D5I193"53();
extern Void A1154();
extern Void A1155();
extern Void A1156();
extern Void A1157();
extern Void A5823();
extern Void A1158();
extern Void A1159();
extern Void A1160();
extern Void A1161()"
15D4I4"8402"
15D19
25D4I75"8403; A54 A8404; A13 *A8405; A7468 A8406; A72 A8407; A58 *A8408;
A58 *A8409"
19D52I1"6"
57D1I1"7"
6D56I4"63;
"
61D10I229"
A7132,
A7133,
A1164,
A1165,
A1166,
A1167,
A1168,
A1169,
A1170,
A1171,
A1172,
A1173;
A13 A1174[ (2000 / CHARLEN) ];
A18 A5435;
A17 A6040;
A13 A7800[ (2000 / CHARLEN) ];
A61 A6041;
A17 A6042;
} ;
extern A13 A9180[(2000 / CHARLEN)]"
20D4I4"9248"
14D88I6"9249; "
95D17I17"9296; A17 A9250; "
24D6I6"9251; "
13D6I19"9297; FILE *A9252; "
16D9I18"struct A9248 A9253"
18D127I14"Void A9254();
"
135D27I104"391
{
struct A633 *A1175;
struct A144 *A1176;
struct A144 *A1177;
struct A144 *A1178;
};
struct A1179
{
"
32D262I91"180;
A53 A1181;
A17 A1182;
A53 A1183;
A5794 A1184;
A5794 A1185;
};
struct A1186
{
struct A8"
267D31I5"187;
"
40D27
33D12I8"188;
};
"
21D18I6"189
{
"
26D71I105"640 *A1190;
A5794 A1191;
};
struct A1192
{
A17 A1193;
A9 A1194;
A70 A1195;
};
struct A1196 { A2 A1197[3];"
77I833" *A1198; };
struct A1199
{
A5794 A1200;
A35 A1201;
A42 A1202;
};
Void A1203();
Void A1204();
Void A1205();
struct A5677
{
A5794 A5678;
A42 A5679;
A5794 A5680;
A5794 A5681;
};
extern A17 A6244;
extern long A7418;
extern A49 *A1206;
extern A49 *A1207;
extern A2 A1208[ARG_LEN];
extern A42 A8197; extern A2 A3496[ARG_LEN];
extern struct A1196 A1209[];
extern const A6 A1210;
extern A7 A5406;
extern A7 A5407;
extern A7 A6210;
extern A42 A1211;
extern A4 A1212;
extern A72 A1213;
extern A72 A1214;
extern A18 A1215;
extern A18 A1216;
extern A4 A7228;
extern A61 A1217;
extern A61 A1218;
extern A67 A1219;
extern A13 *A6043;
extern A13 *A1220;
extern A13 *A1221;
extern struct A1162 A1222;
extern struct A144 *A1223;
extern struct A144 *A1224;
extern struct A144 *A1225;
extern A48 A1226;
extern A7 A1227;
extern A9070 A1228;
extern UFLAG"
1095I7"9298,
A"
2534D19
33D4I4"9255"
14D7I9"2 A7190[]"
16D8I18"struct A144 *A1398"
21D4I4"1399"
14D8I7"4 A7807"
18D7I6"7 A621"
21D7I6"9181; "
15I1"1"
6D1I1"0"
11D1I2"68"
6D1I1"1"
11D1I1"4"
6D1I2"2 "
11D1I1"7"
6D1I1"3"
10D4I2"A7"
9D3I1"4"
12D4I2"A7"
9D3I1"5"
12D4I2"A4"
9D3I1"6"
12D9I10"Void A1407"
20D9I10"Void A1408"
26D4I4"1409"
17D6I7"8 A1410"
17D10I9"A58 A1411"
21D8I10"Void A8257"
19D10I8"A4 A8411"
27D4I4"5063"
15D4I2"A6"
9D1I1"2"
12D2I4"Void"
7D1I1"3"
18D4I4"1414"
21D4I4"1415"
15D10I8"A4 A1416"
21D19I10"Void A5687"
36D4I4"5688"
15D10I10"Void A5689"
21D10I19"struct A5677 *A5690"
30D1I1"7"
12D10I10"A13 *A5396"
21D10I9"Void A141"
28D4I4"1419"
21D4I4"6052"
15D10I11"A5794 A7808"
30D1I1"4"
18D4I4"5545"
21D4I4"5546"
15D8I10"Void A5547"
19D2I4"Void"
7D1I1"0"
12D2I4"Void"
7D25I1"1"
36D9I7"A4 A624"
21D9I9"A48 A9182"
20D9I8"A4 A1422"
20D4I2"A4"
9D12I5"3();
"
26D5I6" A1424"
16D10I12"Void A3500()"
19D8I10"Void A1425"
19D8I9"int A3493"
19D10I9"int A3494"
27D4I4"1426"
15D10I19"struct A1189 *A1427"
21D12I10"A13 *A8273"
22D7I6"4 A599"
19D9I7"A4 A599"
21D8I10"Void A9311"
27D2I2"28"
13D12I10"Void A7191"
31D2I2"29"
13D8I10"Void A6080"
25D4I4"9183"
15D10I9"A54 A1430"
21D1I1"V"
6D4I4"1431"
15D10I8"A4 A7475"
30D1I1"2"
12D9I12"UFLAG *A1433"
29D1I1"4"
12D10I8"A4 A1435"
29D2I2"36"
13D1I1"v"
6D4I4"6246"
15D1I1"v"
6D4I4"7809"
21D4I4"1437"
23D2I2"38"
14D10I10"34 A5691()"
19D20
28D2I2"39"
19D4I4"1440"
15D10I12"Void A1441()"
19D17
26D1I1"2"
21D1I1"3"
12D11I10"Void A5773"
30D2I2"44"
13D12I11"A5794 A1445"
21I20"A5794 A1446;
extern "
6D4I4"1447"
21D4I4"3532"
15D12I10"A2 A3526[]"
21I17"A4 A3527;
extern "
6D2I2"14"
21D4I4"1449"
15D10I11"A5794 A1450"
30D1I1"1"
18D4I4"1452"
15D10I8"A4 A9184"
27D4I4"5274"
21D73I6"1453()"
82D19I12"Void A5651()"
28D20I12"Void A5548()"
29D20
26D4I130"3443();
extern Void A6072();
extern Void A1454();
extern Void A3363();
extern Void A1455();
extern Void A1456();
extern Void A5107"
17D89I65"065
{
A67 A1066;
A5794 A1067;
A5794 *A1068;
A17 A1069;
};
extern "
97D44I20"1065 *A1070;
extern "
52D40I53"1065 A1071[];
extern A67 A1072[];
extern Void A6209()"
53D12I85"
{
A79 A547;
A79 A548;
A79 A549;
A79 A6232;
A79 A5661;
A87 A6233;
A87 A5662;
A23 A552"
23D16I24"53 *A554, *A555, *A6234,"
21D1I12"63, *A557;
}"
11D29I14"93
{
A17 A8274"
34D35I21"98 A8275;
A8198 A8276"
50D44I10"8277[1];
}"
54D41I6"561
{
"
56D4I165"62;
struct A561 *A563;
A40 A564;
A40 A565;
A81 A566;
A58 A567;
A42 A568;
A68 A569;
struct A147 A570;
A17 A571;
A24 A572;
A61 A573;
A96 *A574;
struct A1537 * A7443;
}"
13D11I8"A81 A575"
20D9I17"struct A561 *A576"
28D1I1"7"
18D2I1"5"
22D2I2"79"
19D3I4"8278"
22D1I1"0"
20D1I1"1"
19D3I2"82"
22D9I1"3"
20D7I10"Void A5664"
18D19
27I65"4(), A585();
extern A4 A586();
extern A4 A5665();
extern Void A58"
1854I50"9136
{
struct A9136 *A9137; A17 A9138; };
struct A"
109D9I19"struct A9136 *A9139"
18D18
26D9I10"9136 A9140"
19D9I8"58 A7273"
18D4I3"A17"
9D3I1"4"
12D11I17"struct A588 A1719"
20D4I2"A2"
9D3I3"6[]"
20D2I2"77"
13D10I9"A89 A1978"
29D2I2"79"
19D4I4"1980"
21D4I4"7274"
24D1I1"1"
13D8I7"4 A9185"
19D18I8"A4 A9186"
35D4I4"5897"
24D1I1"2"
12D3I4"Void"
8D1I1"3"
12D10I9"A72 A1984"
21D10I18"struct A561 *A1985"
27D3I3"914"
23D2I2"86"
21D2I2"87"
13D27
33D26I4"9142"
37D10I9"A78 A1988"
27D4I4"1990"
21D4I4"1989"
21D4I4"1991"
15D8I10"Void A1992"
25D4I4"1993"
15I27"struct A144 *A7824; extern "
6D4I26"5553();
struct A147 *A7825"
23D2I2"26"
19D4I4"7827"
21D64I6"7828()"
73D8I10"Void A7829"
20D7I7"4 A7830"
18D9I12"Void A8412()"
18D9I12"Void A7831()"
18D9I12"Void A7832()"
18D19I12"Void A8413()"
28I14"Void A8414();
"
8D20I7"1457
{
"
26D12I4"58;
"
18D3I25"59;
A4 A1460;
A9 A1461;
}"
12D19I10"A9 A1461()"
28D18I10"A9 A1462()"
28D1I1"9"
6D1I1"3"
11D19I8"A4 A1464"
30D9I7"4 A1465"
19D20
28D11I10"83 **A5078"
21D9I18"struct A83 **A5079"
25D2I2"66"
13D9I7"4 A1467"
19D3I11"struct A144"
8D2I2"68"
12D11I18"struct A144 *A7476"
21D9I7"4 A1469"
19D10I19"struct A640 **A3651"
20D9I18"struct A640 **A365"
21D8I9"17 *A1470"
19D8I9"68 *A1471"
26D13I14"640 **A1472 ;
"
22D7I7"3 A1473"
18D11I7"4 A1474"
22D7I9"13 *A1475"
18D7I9"13 *A1476"
18D7I9"13 *A1477"
18D4I2"53"
9D2I2"78"
13D2I2"68"
7D2I2"79"
12D9I3"A17"
15D1I1"0"
12D1I2"57"
6D1I1"1"
11I19"A57 A3660 ;
extern "
17D3I4"5 ; "
11D10I8"57 A1482"
22D6I10"036 *A1483"
17D10I7"4 A1484"
20D18I8"A4 A8214"
29D8I7"4 A1485"
19D7I11"9036 *A1486"
18D7I9"81 *A1487"
17D8I16"const A81 *A1488"
19D7I7"6 A1489"
25D11I10"144 *A7276"
21D4I4"9036"
9D1I1"0"
11D17I8"A9 A1491"
27I21"A9036 A1492 ;
extern "
8D9I10"640 *A1493"
19D17I9"A63 A1494"
27D17I8"A4 A1495"
28D8I7"4 A1496"
22D4I4"5825"
18D4I5"1497 "
21D8I9"640 *A149"
19D12I12"A5794 A1499 "
21D12I18"struct A83 *A1500 "
21D10I18"struct A83 *A1501 "
19D13I18"struct A83 *A1502 "
22D10I18"struct A83 *A5080 "
20D9I9"53 A1503 "
18D12I9"A4 A1504 "
21D12I8"A4 A6247"
21I27"struct A83 *A6248 ;
extern "
6D4I4"9040"
23D2I2"05"
14D7I7"4 A1506"
18D10I11"A5794 A1507"
21D9I10"Void A7451"
20D10I8"A4 A7833"
22D8I7"4 A6249"
25D4I4"6250"
23D2I2"08"
13D8I10"Void A1509"
28D1I1"0"
12D4I2"A6"
9D1I1"1"
21D1I1"2"
12D10I9"A68 A1513"
21D7I9"Void A151"
20I203"81 A5692();
extern Void A8215();
extern Void A1515();
extern A4 A1516();
extern Void A1517();
extern Void A1518();
extern Void A1519();
extern Void A1520();
extern A4 A3738();
extern A4 A7834();
extern A"
561D1I1" "
11D1I1" "
11D1I1" "
10D1I1" "
10D1I1" "
10D1I1" "
848D4I4"9082"
15D19I10"Void A9083"
30D19I10"Void A9084"
30I21"Void A3863();
extern "
17D2I2"89"
13D10I19"struct A1537 *A1590"
21D10I19"struct A1537 *A1591"
27D2I2"71"
21D4I4"1592"
21D4I4"1593"
15D9I10"Void A7841"
29D1I1"2"
12D4I3"A74"
9D1I1"7"
18D4I4"7843"
21D4I4"8218"
15D9I10"Void A8219"
29D1I1"5"
13I1"7"
6D1I1"6"
12D3I4"Void"
8D1I1"7"
12D10I8"A4 A7848"
21D10I9"A74 A7849"
21D1I1"V"
8D24I4"94()"
33D9I4"void"
14D1I3"1()"
10D4I4"void"
9D9I17"2();
typedef A22*"
14I57"3;
extern const A51 A1524;
extern long A1525;
struct A152"
1445D10I8"A4 A9085"
27D4I4"3763"
15D9I10"Void A8835"
21D2I2"35"
7D1I3"4()"
10D11I3"A58"
16D1I1"5"
10D2I11"struct A147"
7D3I1"6"
12I19"A4 A3767();
extern "
2788D2I4"9070"
433D8I10"Void A9086"
19D9I9"A74 A9087"
28D1I1"6"
12D8I9"Void A737"
19D9I8"A4 A4551"
20D9I9"Void A738"
25D3I4"4724"
14D10I8"A58 A741"
29D1I2"77"
20D1I1"3"
18D4I3"744"
15I21"Void A8202();
extern "
1326D1I1" "
15D1I1" "
11D1I1" "
2390D2I4"9070"
215D2I4"9070"
12D1I2"72"
52D4I4"9088"
3290I6"(A72) "
3050I6"(A72) "
16I6"(A72) "
22I6"(A72) "
16I6"(A72) "
152I6"(A72) "
16I6"(A72) "
22I6"(A72) "
16I6"(A72) "
5740I6"(A72) "
16I6"(A72) "
22I6"(A72) "
16I6"(A72) "
18434D3I13"(size_t)( 5 )"
5454I6"(A72) "
18I6"(A72) "
29I6"(A72) "
18I6"(A72) "
202I6"(A72) "
18I6"(A72) "
29I6"(A72) "
18I6"(A72) "
427I6"(A72) "
14I6"(A72) "
6609I6"(A72) "
18I6"(A72) "
2515I6"(A72) "
14I6"(A72) "
26I6"(A72) "
14I6"(A72) "
1423I24""Return type", 0, 0, 0,
"
204D15I10"lass", (91"
24D1
11D29I17"onst_cast", 119 }"
34D5I6"delete"
10D10I2"2 "
19D5I7"dynamic"
14D2I2"20"
9D17I27"explicit", (125 | 0x4000) }"
22D32I5"expor"
37D3I2"54"
8D1I1"1"
12D12I12"friend", (93"
17D1I1"4"
7I1" "
5D6I6"inline"
11D1I1"4"
19D5I6"mutabl"
10D2I3"126"
14D1
6D31
563D15I16"char16_t", ( 185"
24D3I5" ) } "
8I67"char32_t", ( 186 | 0x8000 ) } ,
{ "decltype", (142 | 0x8000) },
{ ""
941D2I2"10"
268D2I2"10"
150I9"0,0,0},
{"
5D35I1"6"
40I38"Disallowed use of non-character value "
11D6I6"5-0-11"
20D2I1"0"
11D1I1"6"
6D26I48"Plain char mixed with type other than plain char"
37D6I6"5-0-11"
20D2I1"0"
11D52I48"6.1","Plain char used with prohibited operator: "
57D15I5"0,0,0"
21I19"0,0,0},
{0,0,0},
{1"
5D41I62"4-5-3","Plain char used with prohibited operator: "}},
{{0,0,0"
50D6I35"6.1","Disallowed cast of plain char"
11D15I5"0,0,0"
21I9"0,0,0},
{"
5D68I42"6.2","Disallowed use of non-numeric value "
73I1"1"
5D3I6"5-0-12"
8D4I5"},
{{"
9D5I37"19","Octal constant used"},
{960,"7.1"
10D16I4",
{1"
21D2I32"2-13-2",""}},
{{0,0,""},
{960,"7"
7D32I26"Octal escape sequence used"
37D3I13"1960,"2-13-2""
9D1
19D39I52"8.5","no object/function definitions in header files"
44D3I12"1960,"3-1-1""
9D13I2"
{"
19D60I38"68","function not declared at file sco"
67D1
6D5I3"8.6"
10D16I4",
{1"
21D78I5"3-1-2"
85D9I51"
{{961,"22","could define variable at block scope: "
19D53I6"8.7",""
58D12I3"0,0"
18D9I62"
{{961,"27","object/function previously declared in location: "
19D60I6"8.8",""
71D5I5"3-2-3"
12D1
8D6I15"0},
{0,0,0},
{1"
11D51I53"3-2-3","type previously declared in location: "}},
{{"
56D5I81"32","'=' should initialize either all enum members or only the first"},
{960,"9.3"
10I19",
{1960,"8-5-3",""}"
28I11"Prohibited "
9D1I1"C"
10D30I2": "
35D1I23"0,0,""}}, 
{{0,0,""},
{"
6D8I18"10.2","Prohibited "
17D1I1"C"
10D29I12": "},
{0,0,""
55D1I1"1"
24D10I15"from integer to"
26D10I4"type"
25D1I31"5",""}}, 
{{0,0,""},
{960,"10.2"
24D2I4"from"
18D30I15"to integer type"
35I1"1"
5D52I21"5-0-5",""}}, 
{{0,0,""
57D1
6D29I22"10.1","Implicit conver"
34D31I26"of integer to smaller type"
36I1"1"
5D56I21"5-0-6",""}}, 
{{0,0,""
61D1
6D37I22"10.2","Implicit conver"
42D7I26"of floating point to small"
16I19",
{1960,"5-0-6",""}"
24D41I19"1","Implicit conver"
46D14I18"changes signedness"
29D59I4"4",""
85D8I23"1","Implicit conversion"
20I8"integer "
10D36
51D25I19"3","Implicit conver"
30D4I2"of"
13D22I17"cvalue expression"
48D8I23"2","Implicit conversion"
20I15"floating point "
10D36
51D25I19"3","Implicit conver"
30D4I2"of"
20D15I17"cvalue expression"
41D79I48"3","Cast of complex expression changes signednes"
95D5I48"9","Cast of cvalue expression changes signedness"
13D8I3"0,0"
17D10I59"0,"10.3","Cast of complex integer expression to larger type"
18D1I1"0"
7D37I26"8","Cast of integer cvalue"
49D16I27"to larger type"}}, 
{{0,0,""
27D6I62"0.4","Cast of complex floating point expression to larger type"
19D12I78"0-8","Cast of floating point cvalue expression to larger type"}}, 
{{0,0,""},
"
18D53I69"10.3","Cast of complex expression from integer to floating point type"
58I1"1"
5D5I80"5-0-7","Cast of cvalue expression from integer to floating point type"}}, 
{{0,0"
12D1
6D21I69"10.4","Cast of complex expression from floating point to integer type"
26I1"1"
5D16I100"5-0-7","Cast of cvalue expression from floating point to integer type"}}, 
{{0,0,""},
{960,"10.5","O"
23D18I35"s '~' and '<<' require recasting to"
34D2I17" for sub-integers"
17D2I2"10"
29D38I7"0.6","U"
46D17I37"integer literals require a 'U' suffix"
22D12I3"0,0"
18D4I24"
{{0,0,""},
{0,0,""},
{1"
9D56I75"2-13-3","Unsigned octal and hexadecimal literals require a 'U' suffix"}},
{"
67D22
28D26I69"1.5","attempt to cast away const/volatile from a pointer or reference"
39D4I3"2-5"
11I1" "
5D52I8"1,"47",""
59D7I7"1,"12.1"
15D3I12"1963,"5-0-2""
9D1
6D44I52"1,"40","'sizeof' used on expression with side effect"
49D3I10"960,"12.3""
10D3I12"1960,"5-3-4""
12D10
15D43I53"33","side effects on right hand of logical operator: "
48D1
6D5I4"12.4"
10D5I4",
{1"
11D35I14"-14-1",""}},
{"
41D7I54"34","non-primary expression used with logical operator"
12D1
6D5I4"12.5"
10D4I2",
"
12D3I26"},
{{0,0,""},
{0,0,""},
{1"
8D63I57"5-2-1","non-postfix expression used with logical operator"
70D5I63"961,"36","boolean expression used with non-permitted operator: "
12D40I10"1,"12.6",""
51D3I3"4-5"
17D25I33"1,"36","boolean expression requir"
32D27I10"operator: "
34D59I10"1,"12.6",""
70D1I1"5"
15I10"0,0,""},
{"
5D56I59"12.7","Bitwise operator applied to signed underlying type: "
61I1"1"
5D2I34"5-0-21",""}}, 
{{0,0,""},
{960,"12"
7D35I57"Prohibited operator applied to unsigned underlying type: "
46D5I5"5-3-2"
12I1" "
5D24I35"0,"42","comma operator used outside"
29D20I14"for' expressio"
26D11I3"0,0"
18D12I3"0,0"
18D48I8"
{{0,0,""
59D6I26"2.10","comma operator used"
17D5I6"5-18-1"
20D9I19"16","bit representa"
14D32I29"of a floating point type used"
43D3I4"2.12"
17D5I5"3-9-3"
15D12I63"0,0,""},
{961,"12.13","increment or decrement combined with ano"
17D55I8"operator"
60D13I13"1963,"5-2-10""
22D10
15D44I49"65","floating point variable used as loop counter"
49I17"960,"13.4",""},
{"
9D12I3" 
{"
18D19I19"54","null statement"
24D7I17"in line by itself"
12D12I13"0,0,""},
{0,0"
21I10"0,0,""},
{"
5D22I11"14.3","null"
32D32I22" not in line by itself"
37D17
23D6I5"6-2-3"
13D1
9D51I32"57","continue statement detected"
58D7I7"0,"14.5"
21D6I5"6-6-3"
16I10"0,0,""},
{"
5D51I44"14.6","more than one 'break' terminates loop"
56D9I11"1960,"6-6-4"
14I59"},
{{0,0,""},
{960,"14.8","left brace expected for switch"}"
6D58I11"0,"6-3-1",""
70D33I56"59","left brace expected for if, else, for, do and while"
44D6I55"4.8","left brace expected for while, do...while and for"
17D6I5"6-3-1"
21D34I56"59","left brace expected for if, else, for, do and while"
45D6I41"4.9","left brace expected for if and else"
17D6I5"6-4-1"
21D8I21"60","no 'else' at end"
13D22I21"if ... else if' chain"
33D3I4"4.10"
17D6I5"6-4-2"
13I1" "
5D57I39"1,"63","boolean value in switch express"
71D4I3"5.4"
18D6I5"6-4-7"
13D9I54"
{{960,"69","function has variable number of arguments"
16D31I10"0,"16.1",""
39D9I8"0,"8-4-1"
24D57I67"73","either all parameters or no parameters should have identifiers"
62D11I3"0,0"
18D13I3"0,0"
22I10"0,0,""},
{"
5D20I17"16.3","all parame"
25D35I22"shall have identifiers"
47D10
15D10
15D37I59"74","function parameter list differs from prior declaration"
42I17"960,"16.4",""},
{"
38D35I44"8-4-2","function parameter list differs from"
53D11
16D29I7"16.9",""
38I16"identifier used "
8D23I45"'&' or parenthisized parameter list"},
{0,0,""
53D75I14"0,"8-4-4","fun"
81D6I10"identifier"
11I56" without '&' or parenthisized parameter list"}},
{{0,0,""
7D1I1"0"
6D4I53"4","pointer arithmetic other than array indexing used"
20D1I1"5"
21D11
17D66I65"7.4","pointer arithmetic by increment or decrement used"},
{0,0,""
83D11
16D47I31"18.4","unions shall not be used"
52D10
16D3I3"9-5"
8D18
25D21
26D40I64"87","only preprocessor statements and comments before '#include'"
45D3I10"961,"19.1""
16D39I27"16-0-1",""}}, 
{{960,"88",""
50D12I35" name with non-standard character: "
17D3I10"961,"19.2""
16D45I9"16-2-4",""
52D21
26D55I51"88","header file name with non-standard character: "
60D3I10"961,"19.2""
13D18I23"3,"16-2-5","header file"
23D15I30" with non-standard character: "
22D21
26D39I27"91","'#undef' used within a"
47D8I13",
{960,"19.5""
15D10
17D38I8"6-0-2",""
47D28I10"0,"91","'#"
34D1I21"' used within a block"
8D1I1"0"
6D1I1"5"
20D1I1"2"
11D5I40"961,"92","use of '#undef' is discouraged"
10D3I10"960,"19.6""
13D37I12"0,"16-0-3",""
44D21
26D4I70"98","Multiple use of '#/##' operators in macro definition"},
{960,"19."
9D61
66D10
16D54I14"16-3-1",""}}, "
67D5I33"961,"19.13","'#/##' operator used"
13D7I7"3,"16-3"
12D41
50D42I60"0,"100","Non-standard use of 'defined' preprocessor operator"
47D3I11"960,"19.14""
10D3I13"1960,"16-1-1""
14D36I19"0,"115","Re-use of "
41D3I10"960,"20.2""
10D3I13"1960,"17-0-2""
14D34I63"0,"8","Multibyte characters and wide string literals prohibited"
58D32I2"
{"
43D12
17D21I32"4.1","Prohibited escape sequence"
38D2I4"},
{"
10D5I14",
{0,0,""},
{1"
10D34I42"2-13-4","Lower case literal suffix: "}},
{"
52D22
28D36I31"0,"0-1-8","Void return type for"
46D12I29"without external side-effects"
44D40I29"3,"2-5-1","Possible digraph: "
47D5I56"961,"102","More than two pointer indirection levels used"
10D3I10"961,"17.5""
16D41I9"5-0-19",""
75D3I3"4-8"
8D69I18"Explicit specializ"
75I1804"of overloaded function templates: "}},
{{0,0,""},
{0,0,""},
{1960,"5-3-3","Unary operator & overloaded"}},
{{0,0,""},
{0,0,""},
{1960,"7-3-1","Global declaration"}},
{{0,0,""},
{0,0,""},
{1960,"7-3-4","Using-directive used"}},
{{0,0,""},
{0,0,""},
{1960,"7-3-6","Using-directive/declaration in header file"}},
{{0,0,""},
{0,0,""},
{1960,"8-0-1","Multiple declarators in a declaration"}},
{{0,0,""},
{0,0,""},
{1960,"7-3-2","Non-global function, main, declared"}},
{{0,0,""},
{0,0,""},
{1960,"7-3-3","Unnamed namespace in header"}},
{{0,0,""},
{0,0,""},
{1960,"15-1-3","Empty throw outside of a catch block"}},
{{0,0,""},
{0,0,""},
{1960,"15-3-7","Catch handler after catch(...)"}},
{{961,"93","Function-like macro defined"},
{961,"19.7",""},
{1960,"16-0-4",""}},
{{0,0,""},
{0,0,""},
{1963,"15-0-2","Pointer expression thrown"}},
{{0,0,""},
{0,0,""},
{1960,"5-2-12","Array type passed to function expecting a pointer"}},
{{0,0,""},
{0,0,""},
{1960,"6-6-2","Goto jumps to an earlier point in the code"}},
{{0,0,""},
{0,0,""},
{1960,"12-8-2","Public copy constructor in abstract class"}},
{{961,"18","Numerical constant requires suffix"},
{0,0,""},
{0,0,""}},
{{961,"28","'register' class discouraged"},
{0,0,""},
{0,0,""}},
{{961,"44","redundant explicit casting"},
{0,0,""},
{0,0,""}}, 
{{961,"55","non-case label"},
{0,0,""},
{0,0,""}},
{{960,"58","non-switch break used"},
{0,0,""},
{0,0,""}},
{{960,"110","bitfields inside union: "},
{0,0,""},
{0,0,""}},
{{0,0,""},
{0,0,""},
{1963,"14-8-2","Viable set contains both function and template: "}},
{{0,0,""},
{0,0,""},
{1960,"9-6-4","Signed bit field is too small"}},
{{0,0,""},
{0,0,""},
{1960,"15-1-2","Explicit throw of the NULL macro"}},
{{0,0,""},
{0,0,""},
{1960,"11-0-1","Non-private data member within a non-POD structure: "}}
};
/*  Obfuscation "
Fa16.c
209D4I7"7 A9235"
18D2I1"9"
12I16"A6 A10;
typedef "
291D20
27D4I8"32 A9069"
14I19"A9069 A24;
typedef "
10D4I2"25"
14D9I13"unsigned A890"
21D6I10"9069 A9150"
17D6I10"9069 A9070"
17D8I8"9070 A27"
18D12I9"A9070 A28"
22I21"A9070 A5793;
typedef "
10D4I2"29"
14D17
26D8I5"A6228"
19D6I8"9070 A30"
25D3I8"long A31"
13I17"A17 A32;
typedef "
11D1I1"3"
11D7I12"unsigned A34"
19D5I5"4 A35"
17D5I5"5 A36"
21D1I1"7"
17D1I1"8"
16D2I2"39"
18D1I1"0"
17D1I1"1"
17D1I1"2"
12D6I6"34 A43"
22D1I1"4"
17D1I1"5"
11D7I7"A42 A46"
17I17"int A47;
typedef "
342D2I4"9236"
17D4I2"63"
19D1I3"577"
18D1I1"4"
16D4I2"65"
20D2I2"19"
18D4I4"8258"
14I19"A54 A7616;
typedef "
138D6I3"A16"
60D13I3"A72"
122D6I5"A9069"
20D6I5"A9069"
1373I69"struct A9304
{
A17 A9305;
A5794 A9306;
};
extern struct A9304 A9307;
"
6D4I4"9308"
14D4I4"9309"
17D1I1"5"
11D4I4"5566"
14D4I4"5567"
14D3I17"7618();
Void A761"
8D13
19D3I17"5569();
Void A915"
8D9I10"Void A9152"
14D17I2"74"
22D1I15"0();
Void A7621"
10I41"6226();
A5794 A6227();
A81 A7622();
A58 A"
460D2I4"9070"
28D2I4"9070"
151I19"struct A114 A9153;
"
1389D2I2"92"
16D6I12"5794 A7637()"
15I16"A4 A202;
extern "
3337D2I4"9070"
159I11"A58 A9238; "
88D2I4"9070"
39D2I4"9070"
367I11"A17 A9071;
"
535I13"A9236 A9239;
"
1098D2I4"9070"
380D7I8"17 A9154"
24D1I1"1"
12D6I7"62 A442"
16I17"A4 A443 ;
extern "
150D3I4"9072"
14D10I9"Void A451"
22D9I9"5794 A452"
21D9I9"9036 A453"
29D1I1"4"
13D12
20D1I1"5"
12D9I22"A315 A456 ;
A5794 A457"
28D1I1"8"
18D4I3"459"
21D3I4"5268"
14D16
24D1I1"0"
12I16"A4 A461;
extern "
8D1I1"2"
12D8I11"Void A463()"
22D4I3"464"
13I18"A58 A8823;
extern "
1037D7I10"Void A9155"
18D9I7"A4 A504"
20I20"Void A505();
extern "
1042D2I4"9070"
1940D8I19"struct A640 * A9310"
24D4I3"663"
15D10I9"A48 A7505"
29D2I2"37"
19D3I4"7176"
14D7I9"Void A664"
22D4I3"665"
16D8I7"4 A4442"
19D6I6"A17 A5"
27D3I2"66"
21D2I3"031"
21D1I1"7"
20D1I1"8"
12I20"Void A669();
extern "
278D3I4"4476"
14D10I17"struct A640 *A675"
27D4I4"7719"
21D4I4"8914"
15D8I12"Void A7720()"
18D7I7"17 A933"
18D8I7"7 A5254"
18D2I2"81"
7D1I1"0"
11D2I2"17"
7D1I1"1"
11D1I2"35"
6D1I1"2"
11D1I2"92"
6D1I1"3"
11D2I1"7"
7D1I1"4"
11D8I7"4 A2145"
18D1I2"68"
6D1I1"6"
13D14I6"*A2147"
24D8I7"4 A2148"
18D7I16"2 A2149[M_TOKEN]"
17D2I2"87"
7D1I1"0"
11D2I1"4"
7D1I1"1"
15D4I4"2152"
14D2I2"36"
7D1I1"3"
11D27I7"35 A826"
38D1I2"17"
6D3I1"4"
13D10I28"7
A2155,
A2156,
A2157,
A6214"
19D4I2"A9"
9D1I1"8"
12D10I9"A17 A8825"
27D3I3"215"
15D3I4"Void"
8D1I1"0"
18D4I4"8209"
23D1I1"1"
12D3I4"Void"
8D1I1"2"
12D10I9"A35 A2163"
29D1I1"4"
12D5I4"Void"
10D1I1"0"
12D9I8"A35 A216"
22D7I10"9036 A8211"
24D4I4"5255"
15D4I2"A4"
9D11I16"6();
extern Void"
16I37"7();
extern Void A2168();
struct A216"
465I42"struct A9073
{
A48 A9074;
A9069 A9075;
};
"
422D6I7"8 A9076"
17D9I8"A42 A982"
20D8I9"long A983"
24D4I3"984"
16D8I8"87 A6039"
20D8I8"61 A7724"
19D9I9"A92 A7260"
20D8I9"long A985"
24D4I3"986"
16D9I8"34 A5670"
20I21"A5794 A987();
extern "
1045I7"9129,
A"
44D4I4"9156"
11I42"9157,
A9158,
A9159,
A9160,
A9161,
A8639,
A"
21D10I2"91"
15D2I2"91"
7I29"9164,
A6176, 
A7062,
A7063,
A"
91I21"9240,
A9241,
A9130,
A"
21I28"9165,
A9166,
A9167,
A9168,
A"
28I14"9292,
A9169,
A"
92I42"9242,
A9243,
A9131,
A9132,
A9133,
A9134,
A"
71I7"9170,
A"
307D4I4"9171"
21I42"9244();
extern Void A8266();
extern Void A"
8I80"extern Void A9172();
extern A4 A9173();
extern A4 A9174();
extern Void A9175();
"
746D9I7"4 A9176"
21D7I9"5794 A868"
19D6I6"7 A598"
25D1I1"0"
19D1I1"1"
13D10I7"61 A872"
22D7I10"5794 A6037"
19D10I7"61 A873"
22D7I10"5794 A8589"
20D5I6"8 A874"
16D9I7"A4 A875"
28D1I1"6"
20D1I1"7"
20D1I1"8"
19D2I2"79"
19D4I3"880"
21D4I4"6172"
21D3I4"9293"
20D4I4"9177"
21D4I4"8787"
23D1I1"1"
20D1I2"29"
18D4I4"7262"
23D1I1"2"
20D1I1"3"
20D2I2"48"
21D1I1"4"
20D1I1"5"
18D3I4"5667"
22D1I1"6"
19D2I2"87"
20D2I2"88"
20D2I2"89"
19D4I3"890"
21D4I3"891"
21D4I3"892"
21D4I4"7745"
24D1I1"6"
21D1I1"7"
20I1"4"
18D3I4"7748"
20D4I4"7749"
21D4I3"893"
23D1I1"4"
18D4I4"1857"
22D3I3"958"
22D1I1"5"
19D3I3"061"
20D3I4"5821"
20D4I3"896"
21D3I4"7507"
20D4I3"897"
21D4I4"5981"
23D1I1"8"
19D3I3"750"
20D3I4"8212"
20D3I3"899"
20D3I4"7177"
22D1I1"0"
18D4I3"901"
23D1I1"2"
20D1I1"3"
18D3I4"8944"
22D1I1"4"
18D4I3"905"
21D3I3"907"
21D4I4"9078"
23D1I1"7"
18D3I4"5077"
20D3I4"8267"
20D3I4"8830"
14D7I9"Void A908"
25D2I2"09"
13D9I9"Void A910"
28D1I1"1"
12D9I7"A4 A912"
20D16
24D1I1"3"
14D8I7"4 A5431"
19D11I9"Void A914"
22D10I9"Void A915"
22D11I6"7 A916"
27D2I2"17"
13D9I10"A5794 A918"
27D3I4"1739"
15D6I9"5794 A919"
24D4I3"920"
15D9I9"Void A921"
26D4I3"922"
15D20I14"A5794 A923();
"
31D4I3"924"
16D7I10"5794 A7263"
19D8I8"61 A5668"
19D7I12"Void A5669()"
16D18
26D13I12"7734 A7751; "
21D7I7"4 A7752"
18D18I10"A4 A5914()"
28D6I10"861 A926()"
16D8I6"4 A927"
18D6I8"4 A928()"
15D9I19"struct A849 *A929()"
19D6I9"61 A930()"
16D8I12"9236 A9245()"
18D6I12"9236 A9246()"
15D9I12"Void A9247()"
18D7I18"struct A144 *A5050"
17D8I6"7 A931"
18D6I8"61 *A932"
16D8I6"7 A933"
21D7I7"*A934;
"
14D18I7"A7 A935"
28D7I8"61 *A936"
16D18I7"A7 A937"
27D18I9"A61 *A938"
27D18I7"A7 A939"
28D9I8"61 *A940"
19D9I6"7 A941"
19D9I8"61 *A942"
19D12I10"61 A6038; "
19D11I18"struct A144 *A1696"
23D8I5" A943"
18D10I7"7 A9294"
19D11I18"struct A144 *A7178"
20D17
26D7I8"44 *A717"
17D7I18"struct A144 *A5432"
17D6I9"5794 A944"
15D17I10"A5794 A945"
26D20I12"A5794 A946;
"
27D4I5"A5794"
9D3I1"4"
19D6I4"7180"
15D12I11"A5794 A7227"
21D12I11"A5794 A7181"
22D7I10"5794 A5510"
17D8I7"68 A948"
17D18
26D10I9"114 *A949"
20D7I6"7 A950"
17D7I6"4 A951"
16D10I17"struct A114 *A952"
19D13I20"struct A144 *A7265; "
27D3I3"266"
15D7I10"5794 A1689"
24D4I4"7753"
15D18I10"Void A7754"
30D10I7"6 A1022"
20D10I8"81 A5511"
19D12I9"A81 A8770"
21D12I18"struct A561 *A1023"
21D12I8"A4 A1024"
22D10I7"7 A1025"
19D18I8"A4 A1026"
29D18I9"A49 A1027"
29D10I9"Void A775"
22D10I8"A4 A1028"
27D15I8"1029();
"
21D4I31"9079();
A48 A9080();
Void A9081"
15D21
38D1I1"0"
13D7I8"17 A1031"
18D18I9"A79 A1032"
35D4I4"5671"
15D8I10"Void A5672"
19D9I10"Void A8401"
21D8I8"17 A5512"
19D10I18"struct A561 *A1033"
21D9I10"Void A9135"
20D9I18"struct A561 *A1034"
21D7I10"5794 A1035"
18D47I10"Void A2317"
58D9I10"Void A5673"
20D9I10"Void A1036"
20D9I10"Void A1037"
20D11I18"struct A561 *A1038"
22D8I6"A4 A56"
21D9I18"struct A561 *A1039"
20D11I10"Void A7182"
22D18I10"A4 A7183()"
27D10I9"A58 A8268"
22D7I28"78 A1040();
extern Void A775"
12D6I49"extern A81 A1041();
extern A81 A7508();
extern A4"
11D3I49"7();
extern A5794 A8590();
struct A7758 *A7759();"
12D51I3"0()"
60D18I11"A78 A1042()"
28D8I10"78 A5271()"
18D8I10"78 A1043()"
18D8I12"5972 A1044()"
17D9I12"Void A2274()"
18D17I42"A54 A5433();
extern A9036 A9039();
extern "
26D106I9"44 *A5434"
116D7I12"9150 A9178()"
16D13I32"Void A7761();
extern A48 A7906()"
23D31I63"7758
{
A40 A7762;
A87 A7763, A7764;
A17 A7765, A7766;
A67 A7767"
43D21
29D11I10"7758 A7768"
20D79I9"A87 A7769"
88D12I9"A87 A7770"
21D12I9"A88 A7771"
21D12I9"A10 A7772"
21D43I17"const A88 A7773;
"
52D19I43"045
{
A18 A1046;
A72 A1047;
A7470 A1048;
A3"
24D2I58"49;
};
struct A1050
{
A18 A1051;
A17 A1052;
A5794 A1053;
}"
12D7I7"7 A3140"
17D34I14"81 A3143[20];
"
43D9I33"054
{
A54 A1055;
A55 A1056[25];
}"
19D8I9"55 *A3164"
19D11I19"struct A1054 *A7509"
20D78
86D209I12"144 *A7774;
"
217D10I51"7500
{
struct A7500 *A7775; A54 A7510; A42 A7511; }"
19D9I12"Void A1057()"
18D8I12"Void A1058()"
17D9I10"Void A1059"
20D8I10"Void A1060"
19D10I11"A5794 A1061"
21D22I18"struct A118 *A1062"
33D13I8" A1063;
"
20D13I8"A4 A7267"
26D4I4"7776"
14D10I8"63 A7777"
19D21
29D3I3"114"
8D2I2"64"
11I40"A81 A7512();
extern A49 A1073();
extern "
8D2I66"74();
extern A72 A1075[];
extern A9036 A1076();
extern A9036 A7778"
14D94I118"3097
{
A70 A3098; A72 A3099; A7468 A3100; A7468 A3101; A72 A3102; A72 A3103; A72 A3104; A7 A3105; A4 A3106; A7 A5282; "
100D5I85"283; A32 A5284; A74 A5966; A17 A6270; };
extern A81 A3107;
extern A315 A3108;
extern "
13D55I62"3097 A3109;
extern A58 A3110;
extern A4 A6067;
extern A72 A311"
60D10I14"extern A6 A311"
15D45
52D11I14"Void A1077();
"
19D7I21"48 strcat(), strcpy()"
17D9I14"48 strncpy(); "
16D11I13"int strncmp()"
24D4I4"1078"
15D8I7"2 A7268"
27D2I2"79"
13D12I18"struct A553 *A1080"
21I17"A7 A9295;
extern "
6D67I3"108"
72I66"struct A553
{
struct A553 *A1082;
A7 A1083;
struct A114 A1084;
};
"
15D81I1"8"
86D75I59"struct A5513
{
A81 A5514;
struct A147 *A5515;
};
A5972 A777"
80D39I10"A5972 A778"
44D17I10"A5972 A778"
22D16I10"A5972 A778"
21D16I10"A5972 A778"
21D16I10"A5972 A778"
21I15"A5972 A7785();
"
7D14I11"A74 A6242; "
21D12I8"A7 A1086"
21D12I8"A7 A7184"
21D12I11"A5794 A5248"
25D6I4"7185"
15D10I10"A95 *A1087"
27D4I4"1088"
21D4I4"1089"
21D4I4"7186"
21D3I3"109"
21D4I4"7187"
15D10I11"A5794 A1091"
21D9I10"Void A1092"
27D3I3"093"
20D4I4"8269"
20D3I3"094"
14D10I8"A4 A1095"
21D10I8"A4 A1096"
28D3I3"097"
20D4I4"1098"
16D10I7"4 A1099"
21D10I11"A94 * A5272"
21D9I10"A94 * A110"
21D10I11"A94 * A1101"
29D2I2"02"
19D4I4"1103"
15D11I10"Void A1104"
30D2I2"05"
21D2I2"06"
19D4I4"5675"
21D4I4"6243"
15D10I8"A4 A5518"
27D4I4"7786"
21D4I4"5516"
21D4I4"5517"
21D4I4"5519"
22D3I3"520"
14D18I12"Void A5521()"
27D17
23D4I4"5522"
15D10I9"A23 A7787"
21D8I10"Void A1107"
19D10I10"Void A1108"
22D10I7"4 A1109"
21D11I10"Void A1110"
22D11I10"Void A1111"
22D11I10"Void A1112"
22I21"Void A2942();
extern "
7D4I4"1113"
15D55I12"Void A2949()"
64D13I12"Void A7070()"
22D9I12"Void A1114()"
18D10I12"Void A1115()"
19D9I12"Void A7269()"
19D8I12"94 * A1116()"
17D9I12"Void A1117()"
18D18I12"Void A1118()"
27D18I12"Void A1119()"
27D26I12"Void A7788()"
35D8I12"Void A5676()"
17D18
26D2I2"20"
21D2I2"21"
21D2I2"22"
13D9I10"Void A8270"
26D4I4"5249"
15D10I18"struct A144 *A5523"
19I17"A7 A5822;
extern "
6D4I4"7789"
21D4I4"7790"
19D4I4"7791"
15D10I10"A94 *A7792"
21D10I11"A5794 A7793"
22D7I10"5794 A7794"
19D7I10"5794 A7795"
18D10I11"A5794 A7796"
22D8I10"5794 A7797"
20D2I4"5794"
7D3I45"8();
struct A5304 { A77 A3049; A5794 A1148; }"
12D12I13"A2 A1123[100]"
21D12I9"A17 A1124"
21D12I10"A13 *A1125"
21D12I9"A81 A1126"
23D9I7"8 A1127"
19D1I1"5"
6D4I2"28"
13D11I18"struct A144 *A1129"
20D11I18"struct A144 *A1130"
20D11I26"const struct A5304 A3050[]"
21D10I7"4 A1131"
20D17I8"38 A1132"
26D45I9"Void A113"
65D1I1"3"
21D1I1"3"
13D9I8"A17 A113"
29D1I1"3"
13D10I8"A4 A2979"
29D1I1"3"
19D3I3"917"
23D2I2"39"
13I19"A4 A1140();
extern "
8D1I1"4"
6D124I231"extern Void A5529();
extern A4 A5530();
extern A7 A5532();
extern Void A5533();
extern A66 A5534();
extern A66 A7799();
extern Void A5531();
extern Void A1142();
extern Void A1143();
extern Void A1144();
extern A50 A1145();
extern "
131D339I15"46();
extern A7"
344D13I118"47();
extern A48 A1148();
extern A48 A1149();
extern A77 A1150();
extern A58 *A5067, *A5068;
extern A17 *A8945, *A8946"
22D4I6"8271()"
15D5I193"53();
extern Void A1154();
extern Void A1155();
extern Void A1156();
extern Void A1157();
extern Void A5823();
extern Void A1158();
extern Void A1159();
extern Void A1160();
extern Void A1161()"
15D4I4"8402"
15D19
25D4I75"8403; A54 A8404; A13 *A8405; A7468 A8406; A72 A8407; A58 *A8408;
A58 *A8409"
19D52I1"6"
57D1I1"7"
6D56I4"63;
"
61D10I229"
A7132,
A7133,
A1164,
A1165,
A1166,
A1167,
A1168,
A1169,
A1170,
A1171,
A1172,
A1173;
A13 A1174[ (2000 / CHARLEN) ];
A18 A5435;
A17 A6040;
A13 A7800[ (2000 / CHARLEN) ];
A61 A6041;
A17 A6042;
} ;
extern A13 A9180[(2000 / CHARLEN)]"
20D4I4"9248"
14D88I6"9249; "
95D17I17"9296; A17 A9250; "
24D6I6"9251; "
13D6I19"9297; FILE *A9252; "
16D9I18"struct A9248 A9253"
18D127I14"Void A9254();
"
135D27I104"391
{
struct A633 *A1175;
struct A144 *A1176;
struct A144 *A1177;
struct A144 *A1178;
};
struct A1179
{
"
32D262I91"180;
A53 A1181;
A17 A1182;
A53 A1183;
A5794 A1184;
A5794 A1185;
};
struct A1186
{
struct A8"
267D31I5"187;
"
40D27
33D12I8"188;
};
"
21D18I6"189
{
"
26D71I105"640 *A1190;
A5794 A1191;
};
struct A1192
{
A17 A1193;
A9 A1194;
A70 A1195;
};
struct A1196 { A2 A1197[3];"
77I833" *A1198; };
struct A1199
{
A5794 A1200;
A35 A1201;
A42 A1202;
};
Void A1203();
Void A1204();
Void A1205();
struct A5677
{
A5794 A5678;
A42 A5679;
A5794 A5680;
A5794 A5681;
};
extern A17 A6244;
extern long A7418;
extern A49 *A1206;
extern A49 *A1207;
extern A2 A1208[ARG_LEN];
extern A42 A8197; extern A2 A3496[ARG_LEN];
extern struct A1196 A1209[];
extern const A6 A1210;
extern A7 A5406;
extern A7 A5407;
extern A7 A6210;
extern A42 A1211;
extern A4 A1212;
extern A72 A1213;
extern A72 A1214;
extern A18 A1215;
extern A18 A1216;
extern A4 A7228;
extern A61 A1217;
extern A61 A1218;
extern A67 A1219;
extern A13 *A6043;
extern A13 *A1220;
extern A13 *A1221;
extern struct A1162 A1222;
extern struct A144 *A1223;
extern struct A144 *A1224;
extern struct A144 *A1225;
extern A48 A1226;
extern A7 A1227;
extern A9070 A1228;
extern UFLAG"
1095I7"9298,
A"
2534D19
33D4I4"9255"
14D7I9"2 A7190[]"
16D8I18"struct A144 *A1398"
21D4I4"1399"
14D8I7"4 A7807"
18D7I6"7 A621"
21D7I6"9181; "
15I1"1"
6D1I1"0"
11D1I2"68"
6D1I1"1"
11D1I1"4"
6D1I2"2 "
11D1I1"7"
6D1I1"3"
10D4I2"A7"
9D3I1"4"
12D4I2"A7"
9D3I1"5"
12D4I2"A4"
9D3I1"6"
12D9I10"Void A1407"
20D9I10"Void A1408"
26D4I4"1409"
17D6I7"8 A1410"
17D10I9"A58 A1411"
21D8I10"Void A8257"
19D10I8"A4 A8411"
27D4I4"5063"
15D4I2"A6"
9D1I1"2"
12D2I4"Void"
7D1I1"3"
18D4I4"1414"
21D4I4"1415"
15D10I8"A4 A1416"
21D19I10"Void A5687"
36D4I4"5688"
15D10I10"Void A5689"
21D10I19"struct A5677 *A5690"
30D1I1"7"
12D10I10"A13 *A5396"
21D10I9"Void A141"
28D4I4"1419"
21D4I4"6052"
15D10I11"A5794 A7808"
30D1I1"4"
18D4I4"5545"
21D4I4"5546"
15D8I10"Void A5547"
19D2I4"Void"
7D1I1"0"
12D2I4"Void"
7D25I1"1"
36D9I7"A4 A624"
21D9I9"A48 A9182"
20D9I8"A4 A1422"
20D4I2"A4"
9D12I5"3();
"
26D5I6" A1424"
16D10I12"Void A3500()"
19D8I10"Void A1425"
19D8I9"int A3493"
19D10I9"int A3494"
27D4I4"1426"
15D10I19"struct A1189 *A1427"
21D12I10"A13 *A8273"
22D7I6"4 A599"
19D9I7"A4 A599"
21D8I10"Void A9311"
27D2I2"28"
13D12I10"Void A7191"
31D2I2"29"
13D8I10"Void A6080"
25D4I4"9183"
15D10I9"A54 A1430"
21D1I1"V"
6D4I4"1431"
15D10I8"A4 A7475"
30D1I1"2"
12D9I12"UFLAG *A1433"
29D1I1"4"
12D10I8"A4 A1435"
29D2I2"36"
13D1I1"v"
6D4I4"6246"
15D1I1"v"
6D4I4"7809"
21D4I4"1437"
23D2I2"38"
14D10I10"34 A5691()"
19D20
28D2I2"39"
19D4I4"1440"
15D10I12"Void A1441()"
19D17
26D1I1"2"
21D1I1"3"
12D11I10"Void A5773"
30D2I2"44"
13D12I11"A5794 A1445"
21I20"A5794 A1446;
extern "
6D4I4"1447"
21D4I4"3532"
15D12I10"A2 A3526[]"
21I17"A4 A3527;
extern "
6D2I2"14"
21D4I4"1449"
15D10I11"A5794 A1450"
30D1I1"1"
18D4I4"1452"
15D10I8"A4 A9184"
27D4I4"5274"
21D73I6"1453()"
82D19I12"Void A5651()"
28D20I12"Void A5548()"
29D20
26D4I130"3443();
extern Void A6072();
extern Void A1454();
extern Void A3363();
extern Void A1455();
extern Void A1456();
extern Void A5107"
17D89I65"065
{
A67 A1066;
A5794 A1067;
A5794 *A1068;
A17 A1069;
};
extern "
97D44I20"1065 *A1070;
extern "
52D40I53"1065 A1071[];
extern A67 A1072[];
extern Void A6209()"
53D12I85"
{
A79 A547;
A79 A548;
A79 A549;
A79 A6232;
A79 A5661;
A87 A6233;
A87 A5662;
A23 A552"
23D16I24"53 *A554, *A555, *A6234,"
21D1I12"63, *A557;
}"
11D29I14"93
{
A17 A8274"
34D35I21"98 A8275;
A8198 A8276"
50D44I10"8277[1];
}"
54D41I6"561
{
"
56D4I165"62;
struct A561 *A563;
A40 A564;
A40 A565;
A81 A566;
A58 A567;
A42 A568;
A68 A569;
struct A147 A570;
A17 A571;
A24 A572;
A61 A573;
A96 *A574;
struct A1537 * A7443;
}"
13D11I8"A81 A575"
20D9I17"struct A561 *A576"
28D1I1"7"
18D2I1"5"
22D2I2"79"
19D3I4"8278"
22D1I1"0"
20D1I1"1"
19D3I2"82"
22D9I1"3"
20D7I10"Void A5664"
18D19
27I65"4(), A585();
extern A4 A586();
extern A4 A5665();
extern Void A58"
1854I50"9136
{
struct A9136 *A9137; A17 A9138; };
struct A"
109D9I19"struct A9136 *A9139"
18D18
26D9I10"9136 A9140"
19D9I8"58 A7273"
18D4I3"A17"
9D3I1"4"
12D11I17"struct A588 A1719"
20D4I2"A2"
9D3I3"6[]"
20D2I2"77"
13D10I9"A89 A1978"
29D2I2"79"
19D4I4"1980"
21D4I4"7274"
24D1I1"1"
13D8I7"4 A9185"
19D18I8"A4 A9186"
35D4I4"5897"
24D1I1"2"
12D3I4"Void"
8D1I1"3"
12D10I9"A72 A1984"
21D10I18"struct A561 *A1985"
27D3I3"914"
23D2I2"86"
21D2I2"87"
13D27
33D26I4"9142"
37D10I9"A78 A1988"
27D4I4"1990"
21D4I4"1989"
21D4I4"1991"
15D8I10"Void A1992"
25D4I4"1993"
15I27"struct A144 *A7824; extern "
6D4I26"5553();
struct A147 *A7825"
23D2I2"26"
19D4I4"7827"
21D64I6"7828()"
73D8I10"Void A7829"
20D7I7"4 A7830"
18D9I12"Void A8412()"
18D9I12"Void A7831()"
18D9I12"Void A7832()"
18D19I12"Void A8413()"
28I14"Void A8414();
"
8D20I7"1457
{
"
26D12I4"58;
"
18D3I25"59;
A4 A1460;
A9 A1461;
}"
12D19I10"A9 A1461()"
28D18I10"A9 A1462()"
28D1I1"9"
6D1I1"3"
11D19I8"A4 A1464"
30D9I7"4 A1465"
19D20
28D11I10"83 **A5078"
21D9I18"struct A83 **A5079"
25D2I2"66"
13D9I7"4 A1467"
19D3I11"struct A144"
8D2I2"68"
12D11I18"struct A144 *A7476"
21D9I7"4 A1469"
19D10I19"struct A640 **A3651"
20D9I18"struct A640 **A365"
21D8I9"17 *A1470"
19D8I9"68 *A1471"
26D13I14"640 **A1472 ;
"
22D7I7"3 A1473"
18D11I7"4 A1474"
22D7I9"13 *A1475"
18D7I9"13 *A1476"
18D7I9"13 *A1477"
18D4I2"53"
9D2I2"78"
13D2I2"68"
7D2I2"79"
12D9I3"A17"
15D1I1"0"
12D1I2"57"
6D1I1"1"
11I19"A57 A3660 ;
extern "
17D3I4"5 ; "
11D10I8"57 A1482"
22D6I10"036 *A1483"
17D10I7"4 A1484"
20D18I8"A4 A8214"
29D8I7"4 A1485"
19D7I11"9036 *A1486"
18D7I9"81 *A1487"
17D8I16"const A81 *A1488"
19D7I7"6 A1489"
25D11I10"144 *A7276"
21D4I4"9036"
9D1I1"0"
11D17I8"A9 A1491"
27I21"A9036 A1492 ;
extern "
8D9I10"640 *A1493"
19D17I9"A63 A1494"
27D17I8"A4 A1495"
28D8I7"4 A1496"
22D4I4"5825"
18D4I5"1497 "
21D8I9"640 *A149"
19D12I12"A5794 A1499 "
21D12I18"struct A83 *A1500 "
21D10I18"struct A83 *A1501 "
19D13I18"struct A83 *A1502 "
22D10I18"struct A83 *A5080 "
20D9I9"53 A1503 "
18D12I9"A4 A1504 "
21D12I8"A4 A6247"
21I27"struct A83 *A6248 ;
extern "
6D4I4"9040"
23D2I2"05"
14D7I7"4 A1506"
18D10I11"A5794 A1507"
21D9I10"Void A7451"
20D10I8"A4 A7833"
22D8I7"4 A6249"
25D4I4"6250"
23D2I2"08"
13D8I10"Void A1509"
28D1I1"0"
12D4I2"A6"
9D1I1"1"
21D1I1"2"
12D10I9"A68 A1513"
21D7I9"Void A151"
20I203"81 A5692();
extern Void A8215();
extern Void A1515();
extern A4 A1516();
extern Void A1517();
extern Void A1518();
extern Void A1519();
extern Void A1520();
extern A4 A3738();
extern A4 A7834();
extern A"
561D1I1" "
11D1I1" "
11D1I1" "
10D1I1" "
10D1I1" "
10D1I1" "
848D4I4"9082"
15D19I10"Void A9083"
30D19I10"Void A9084"
30I21"Void A3863();
extern "
17D2I2"89"
13D10I19"struct A1537 *A1590"
21D10I19"struct A1537 *A1591"
27D2I2"71"
21D4I4"1592"
21D4I4"1593"
15D9I10"Void A7841"
29D1I1"2"
12D4I3"A74"
9D1I1"7"
18D4I4"7843"
21D4I4"8218"
15D9I10"Void A8219"
29D1I1"5"
13I1"7"
6D1I1"6"
12D3I4"Void"
8D1I1"7"
12D10I8"A4 A7848"
21D10I9"A74 A7849"
21D1I1"V"
8D24I4"94()"
33D9I4"void"
14D1I3"1()"
10D4I4"void"
9D9I17"2();
typedef A22*"
14I57"3;
extern const A51 A1524;
extern long A1525;
struct A152"
1445D10I8"A4 A9085"
27D4I4"3763"
15D9I10"Void A8835"
21D2I2"35"
7D1I3"4()"
10D11I3"A58"
16D1I1"5"
10D2I11"struct A147"
7D3I1"6"
12I19"A4 A3767();
extern "
2788D2I4"9070"
433D8I10"Void A9086"
19D9I9"A74 A9087"
28D1I1"6"
12D8I9"Void A737"
19D9I8"A4 A4551"
20D9I9"Void A738"
25D3I4"4724"
14D10I8"A58 A741"
29D1I2"77"
20D1I1"3"
18D4I3"744"
15I21"Void A8202();
extern "
1326D1I1" "
15D1I1" "
11D1I1" "
2390D2I4"9070"
215D2I4"9070"
12D1I2"72"
52D4I4"9088"
6202I7"((A72) "
13I1")"
1966D3I6"size_t"
1005D2I4"9070"
756D32I39"static Void
A9286( A80, A4982, A4332 )
"
37D5I35"80;
struct A344 *A4982;
A7 A4332;
{"
11D125I35"9287 = 1 | 0x1000 | 0x2000 | 0x4000"
138D24I35"if( !A4982 ) goto A1711;
goto A1712"
29D44I103"11: A882(200,62); return; 
A1712:
if( !(A4982->A350 & (A25) 0x200000) || A4332 ) goto A1713;
goto A1714"
49D157I3"13:"
163D13I2"80"
25D1I1"5"
12D1I1"6"
7D80I43"5:
A887( 1112, "a declaration", "a name" );"
90D13I1"7"
19D75I38"6: A887( 1112, "a type-id", "empty" );"
80D18I3"7: "
24D56I10"4:
A2163()"
61D4I29"40 = A445( A9287, (A33) 0 );
"
9D8I4"1740"
43D9
14D3I12"9238 = A1740"
25D11I44"884( 98, "Malformed trailing-return-type " )"
19D75I61" ;
}
A7
A500( A3688, A3078, A4982, A4332 )
register A81 A3688"
80D63I47" A3078;
struct A344 *A4982;
A7 A4332;
{
A4 A396"
68D56I4"3078"
61D121I102"? (A4) 1 : (A4) 0;
register A81 A80;
A82 *A3961;
A7 A3962;
struct A328 A3963;
struct A322 *A2061;
A58 "
126I22";
A58 A3964;
A58 A3965"
6D35I47"A17 A1709;
A4 A3966 = (A4) 1;
A4 A8660 = (A4) 1"
40D63I43" A3968;
extern Void A3969();
A4 A3970;
A315"
68D9I150"2;
struct A83 *A1724;
struct A1616 **A7551 = NULL;
A65 A7552;
A4 A7553 = (A4) 0;
A4 A9288 = (A4) 0;
A3962 = 0;
A420.A338 = NULL;
if( A3960 && A3688 ) "
17D2I14"11;
goto A1712"
7D104I3"11:"
109D12I74"!( (A3688)->A156 == (A41) 20 ? (A3688)->A155.A150 : (struct A149 *) 0 ) )
"
20D2I2"13"
12D2I2"14"
7D23I89"13: ( A3688)->A156 = ( (A41) 20 ); ( A3688)->A155.A141 = A1073( (A41) 20 ); 
A1715:if(0) "
31D1I1"1"
7D16I47"16:
A1714:
A8125( A3688 );
A3961 = &A420.A338;
"
24D14I2"17"
19D23I20"12: if( A3078 & 4 ) "
31D2I14"20;
goto A1721"
7D14I34"20:
A3961 = &A420.A338;
goto A1722"
19D4I16"21: A3961 = NULL"
9D27I11"22:
A1717:
"
33D3I84"= 8 | A420.A339 & 0x2000;
A2061 = NULL;
A7551 = &(A420.A7503);
A1723:
if( A2142 == 5"
14D54I23"25;
++A3962;
A80 = NULL"
60I44"(A3970 = A539((A33) 0x400|(A33) 0x4000)) ||
"
10I47"2 && ( A1709 & 1 || (A1309 > 0) ) ||
A2142 == 1"
5I1"("
15D3I24"5 || A2153 == (A36) 16)
"
13D2I2"26"
12D2I2"27"
7D26I15"26:
{
A17 A3330"
31D39I10" A9289 = 0"
44D3I7"40 = 0;"
8D2I5"!A397"
14D2I2"66"
12D2I2"67"
7D20I22"66:
if( A2142 == 11 ) "
28D2I14"68;
goto A1769"
7D17I37"68: A865(145); A1740 = 24; 
goto A177"
23D66I13"69: A865(49);"
76D1I14"0x40; 
A1770: "
6D3I62"67:
A540( 0x800|0x40|0x200|0x1000, (A33) 0x800|(A33) 0x4000 );"
8D1
21D2I2"71"
12D2I2"72"
7D36I4"71: "
45D3I31"419.A346;
goto A1773;
A1772:
if"
10D25I25" ) goto A1774;
goto A1775"
30D16I16"74: A419.A346 = "
21D79I20";
goto A1776;
A1775:"
84D28I56"0 = 15;
A1776: ;
A1773:
A3330 = A419.A347;
if( A1709 & 2"
38D3I3"777"
12D71I3"778"
76D22I33"77:A865(101);
A1778:
A328( &A3963"
30D11I11"A2142 == 11"
17D10I15"153 == (A36) 18"
20D3I3"779"
12D25I2"78"
30D3I78"779: A80 = NULL;
goto A1781;
A1780: A80 = A444( (A39) 11 , 1, (A33) 0 );
A1781"
10D99I2"80"
109D3I3"782"
12D2I37"783;
A1782:
A8660 = (A4) 0;
goto A178"
7D3I26"783: A3966 = (A4) 0;
A1784"
9D12I12"!A80 && A492"
20I6"!= 24 "
9D2I2"78"
12D2I2"78"
7D2I2"78"
8D74
80D2I9"4;
A1786:"
9D4I8"419.A346"
14D2I2"78"
12D2I2"78"
7D19I27"787: A495( &A419, A80, 601 "
24D7I17"788:
A1740 = A538"
13I144"0, A3330, &A9289 );
A478( &A3963 );
A1742 = ( A7174 = (A1740), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) );
if( A80 && A174"
12D1I16"7 && A1742->A305"
12D1I1"8"
11D2I2"89"
8D6I77"89:
A80->A128 |= (A28) 0x80000;
A1890:
A3964 = A497( A1740, 4 );
A1740 = A497"
12D20I42"4, 16|2 );
if( (A1309 > 0) && A2237(A1740)"
30D2I2"89"
12D2I2"89"
7D15I5"891:
"
26D40I2"20"
45D12I3"892"
18D13I30"A3078 & 4 &&
!(A748( A492(A174"
18I68"& (((((A21) 0x40 | (A21) 1) | (A21) 8) | (A21) 2) | (A21) 0x10) ) ) "
7D3I3"893"
12D10I10"894;
A1893"
17D8I18"1724 = A506(A1740)"
18D3I3"895"
12D10I10"896;
A1895"
15D47I45"24->A191 |= (A31) 0x2000000;
A1896:A865( 1752"
53D4I31"894:
A3965 = A1740;
A1709 |= 1;"
9D32I6"!A2061"
42D3I3"897"
12D9I33"898;
A1897: A2061 = A511(2);
A189"
16D11I17"A1742->A303 == 24"
21D3I3"899"
13D9I9"00;
A1899"
16D30
35I19"!= 1 || A2142 != 5 "
10D2I2"01"
12D2I2"02"
7D4I14"01: A865(66); "
15D2I15"40; 
goto A1903"
7D2I37"02: A1709 |= 1 | 0x20;
A1903: ;
A1900"
9D9I14"(A1709 & 0x20)"
20D1I1"0"
12D1I1"0"
7D21I42"04:
if( A419.A355 ) goto A1906;
goto A1907"
26D33I27"06: A1740 = (A58) A419.A355"
38D26I23"07:
A512( A2061, A1740 "
32D2I2"05"
9D2I31"2142 == 11 && A2153 == (A36) 18"
13D2I2"08"
12D2I2"09"
7D73I3"08:"
78D4I11"(A1309 > 0)"
16D1I1"0"
9D4I4"1911"
10D101I45"0:
if( A420.A342 && A420.A341 + 1 != A3962 ) "
107D80I4"1912"
88D4I4"1913"
9D21I24"12:
A1709 |= 0x80;
A1913"
27D5I10"!A420.A342"
14D4I4"1914"
12D125I3"191"
130D23I50"914: A420.A342 = A3962;
A1915:
A420.A341 = A3962;
"
29D6I55"1916;
A1911: A884(149,"default arg");
A1916:
if( A80 ) "
12D32I6"1917;
"
38D63I21"1918;
A1917: A80->A13"
68D19I45"1740; A80->A168.A166 = (A39) 1; 
A1918:
A2220"
24D35I1","
41D36I11"if( A464 ) "
42D31I6"1919;
"
39D3I108"30;
A1919:
{
struct A114 A2946;
A921( &A2946 );
A7552 = A833( 0x200,
NULL,
1094,
&A2946
);
A7553 = (A4) 1;
}"
12D2I2"31"
7D27I73"30:
{extern Void A7554();
A2163();
A7552 = 0;
A7554( A1740 );
}
A2331: ;
"
35D4I42"32;
A1909: A7552 = 0; 
A2332:
if( A7553 ) "
12D1I13"33;
goto A233"
7D34I94"33:
*A7551 = (struct A1616 *) A1005( A723 );
(*A7551)->A1618 = A7552;
A7551 = &(*A7551)->A1617"
39D11I18"34: ;
}
goto A2335"
16D12I4"27: "
17D36I13"2142 == 12 ) "
44D2I2"36"
12D2I2"37"
7D18I1"3"
25I2"!("
9I1")"
11D2I2"38"
12D2I2"39"
7D23I31"38:
A1709 |= 2;
A904(936,A3688)"
28D90I22"39:
A80 = A3959( A2149"
95D4I102"922( A80 );
A450( A80, A429, 2, 0x02, (A58) 0 );
A1740 = 15;
A3964 = A1740;
A2163();
goto A2340;
A2337"
11D13I10"2142 == 75"
24D2I2"41"
12D2I2"42"
7D38I3"41:"
44D17I14"(A3078 & (2|4)"
29D2I2"43"
12D2I2"44"
7D17I34"43:
A6172( A6188, "" );
A865(1916)"
22D29I13"44:
--A3962;
"
35D1I43"|= 0x10;
if( A3965 && A3965 != A497( A3965,"
6I2")
"
8D2I2"45"
12D2I2"46"
7D2I2"45"
8D15I4"579)"
20D4I4"46:
"
28D2I2"47"
12D2I2"48"
7D2I2"47"
8D3I2"80"
14D2I2"49"
7D13I39"48:
if( !A2061 ) goto A2350;
goto A2351"
18D3I21"50: A2061 = A511(1); "
8D16I22"1:
A512( A2061, A408 )"
21D4I25"49:
if( A3688 && A3960 ) "
10D4I16"2352;
goto A2353"
9D14I15"52: A420.A340 ="
19D26I1"2"
31D3I12"53:
A2163();"
10D2I17"1095( 5 ,(A35) 0)"
13D2I2"54"
12D2I2"55"
7D70I16"54: A1709 |= 0x4"
76D2I23"55: ;
goto A2356;
A2342"
9D22I8"1709 & 1"
33D109I22"57;
goto A2358;
A2357:"
114D39I5"49);
"
47D13I1"5"
19D29I42"58: if( A1709 & 2 ) goto A2360;
goto A2361"
35D40I23"0:A865(101);
goto A2362"
46D3I12"1: A865(102)"
9D20I32"2:
A2359:
A1709 |= 0x40;
A2356:
"
32I14"A2340:
A2335:
"
5D10I4"3961"
21D2I2"63"
12D2I2"64"
7D2I2"63"
9D11I3"A80"
22D2I2"65"
12D2I2"66"
7D31I28"65:
A80 = A3959( A976(A3962)"
36D38I8"922( A80"
43D4I32"80->A127 |= (A27) 0x10000;
A2366"
11D9I22"80->A127 & (A27) 0x100"
20D22I50"67;
A80->A127 |= ((A27) 0x100);
A80->A130 = A3964;"
27D6I95"( A7174 = (A3964), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) )->A303 == 27"
17D2I2"68"
12D2I2"69"
7D7I42"68:
A80->A127 |= (A27) 0x2000;
A2369:
*A39"
13D46I27"80;
A3961 = &A80->A159.A158"
51D23I11"67: ;
A2364"
30D39I9"2142 == 5"
48D24I4"1725"
31D14I10"2142 == 75"
25D1I1"7"
12D1I1"7"
7D38I2"70"
44D10I12"!(A1309 > 0)"
21D1I1"7"
12D1I1"7"
7D10I32"72: A884( 10, "comma (assumed)" "
16D79I6"73: ;
"
87D14I2"74"
19D39I17"71: A1093( 4, 5 )"
44D2I2"74"
17D48I1"5"
59D2I2"75"
12D2I2"76"
7D20I3"75:"
25D17I6"!A2061"
28D2I2"77"
12D2I2"78"
7D41I59"77: A2061 = A511(1); 
A2378:
A512( A2061, A408 );
A865(562)"
46D18I23"76: ;
goto A1723;
A1725"
25D11I39"3966 || A1709 & 0x20 || A3078 & (2 | 4)"
22D4I46"79;
A6172( A8647, "" );
if( A8660 == (A4) 0 ) "
12D1I13"80;
goto A238"
7D47I38"80:
A6172( A8646, "" );
A2381: ;
A2379"
53D1
10D30I1"5"
41D1I1"8"
12D1I1"8"
7D15I4"82: "
26D13I41"383:
A420.A336 = A2061 ? A516(A2061) : 0;"
30I20"&& (A3968 = A475()) "
10D1I1"8"
12D1I1"8"
7D2I46"84:
*A394++ = (A72) A3968;
*A394++ = 38;
A2385"
17D1I25"11 &&
( A2153 == (A36) 25"
8D8I16"53 == (A36) 16 )"
19D1I1"8"
12D1I1"8"
7D4I4"86:
"
18D21I3"0;
"
26D17I16"2153 == (A36) 25"
28D2I2"88"
11D3I3"389"
8D18I56"88:
*A394++ = (A72) 0x80000;
*A394++ = 38;
A2389:
A2163("
23D10I3"387"
17D5I15"(A3078 & (4|2))"
15D3I3"390"
12D10I10"391;
A2390"
17D8I11"2142 == 116"
18D55I5"392;
"
62D8I20"393;
A2392: A3969();"
15D7I66"|= A420.A339 & 0x800; 
A2393:
if( A2142 == 11 && A2153 == (A36) 31"
17D3I3"394"
12D40I92"395;
A2394:
A9286( A3688, A4982, A4332 );
A9288 = (A4) 1;
A2395: ;
A2391:
if( (A1309 > 0) ) "
47D2I14"396;
goto A239"
7D5I5"396:
"
10D13I9"2142 == 6"
18D12I9"2142 == 2"
23D2I2"39"
12D2I2"39"
7D41I21"398: A1709 |= 0x400;
"
49D1I1"0"
6D2I2"39"
9D14I18"A1709 & 4 && A3688"
25D1I1"0"
12D1I1"0"
7D52I19"01: A904(955,A3688)"
57D28I21"02:
A2400:
if( !A2061"
39D2I2"03"
12D2I2"04"
7D136I2"03"
142D12I9"A3078 & 2"
23D4I16"05;
if( A9288 ) "
12D31I2"06"
38D40I42"3688 && A3688->A129 && *A3688->A129 == '~'"
51D22I3"07;"
27D39I13"A1709 & 0x400"
50D2I2"08"
12D2I2"09"
7D91I32"08: A884( 1917, "definition" );
"
100D1I1"0"
6D13I4"09: "
18I18"395 & (A85) 4 || A"
7D10I6"0x2000"
21D2I2"11"
12D2I2"12"
7D19I50"11: A884( 1918, "member declaration" ); goto A2413"
24D7I48"12: if( !A721 && !A677 ) goto A2414;
goto A2415;"
12D14I205"4: A884( 1717, "function declaration" ); goto A2416;
A2415: if( (A5106 > 0) && !A677 ) goto A2417;
goto A2418;
A2417: A884( 1917, "namespace declaration" );
A2418:
A2416:
A2413:
A2410:
A2407:
A2406:
A2405:"
20D83I128" |= 1 | 0x20;
A420.A336 = A441;
A2404: ;
A2397:
if( !(A1309 > 0) ) goto A2419;
goto A2420;
A2419:
{
struct A322 *A1752;
if( A175"
88D36I14"(struct A322 *"
41D64I13"6[A420.A336])"
73D3I3"242"
12D39I11"2422;
A2421"
45D5I39"(A6)( A1752->A324) > A5895[(int) A5880]"
14D4I4"2425"
12D135I131"2426;
A2425: A890( 793, A6036( A5895[ A5880] ), "", "function parameters" ); 
A2426: ; 
A2423:if(0) goto A2421;
A2424: ;
A2422:
if("
141D60I12" & 4 && A368"
70D4I4"2427"
12D44I57"2428;
A2427: A904(955,A3688);
A2428: ;
}
A2420:
A420.A339"
50D33I79"09;
return A3962;
}
A58
A503( A3330, A1740 )
A17 A3330;
A58 A1740;
{
A315 A1742"
38D31I89"42 = ( A7174 = (A1740), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) );"
38D11I15"742->A303 == 33"
23D1I1"1"
11D2I2"12"
8D9I8"1: A1740"
15D32I8"42->A306"
37D6I16"12:
if( A3330 ) "
15D3I8"3;
goto "
8D2
8D1I49"3:
A438 = A3330;
A1740 = A530( 32, A1740 );
A1714"
10D4I17"A530( 25, A1740 )"
10D47I18"794
A2058( A2858 )"
52D187I68"*A2858;
{register A17 A1709;
register A17 A1836;
struct A5759 *A1731"
194D2I12"1709 = *A285"
40D2I2"31"
7D15I3"761"
21D74I2"5:"
79D100I157"A1836 = A1731->A2860) goto A1713;
goto A1714;
A1716: A1731++;
goto A1715;
A1713:
if( A1836 & A1709 ) goto A1717;
goto A1720;
A1717:
*A2858 = A1709 & ~A1836;
"
107D7I50"A1731->A2861;
A1720: ;
goto A1716;
A1714: ;
A1712:"
15D19I16"NULL;
}
A58
A501"
25D1I8"3, A1740"
7D7I13"4 )
A58 A3973"
13D2I6"0;
A17"
7D6I8"4;
{
A31"
12D6I102"5;
A3975 = ( A7174 = (A3973), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) );
A438 ="
11D16I123"5->A307 & ((0x040 | 0x020 | 0x080) | (0x001 | 0x002)) & ~A3974;
if( A438 ) goto A1711;
goto A1712;
A1711:
A1740 = A530( 32,"
21D123I5"0 );
"
128D20I2":
"
26D9I65" A1740;
}
A4
A3767(A1740)
A58 A1740;
{
A1740 = (A58) A542(A1740);"
15D52I8" A7174 ="
58D1I68"0), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) )"
6D74
80D53I47"400 ) return (A4) 1;
return (A4) 0;
}
Void
A505"
60D77I34", A3977, A80 , A1742, A3978 )
A35 "
82D15I111";
A85 A3977;
A81 A80;
A315 A1742;
struct A344 *A3978;
{extern A4 A3979;
register A39 A1761;
A4 A2903;
A81 A3082"
24D16I105"NULL;
if( !A80 ) goto A1711;
goto A1712;
A1711: A865(224); return; 
A1712:
if( (A1309 > 0) && A704( A3976"
21D13I122" ) ) return;
A2903 = ( (A1742->A303) == 28 || (A1742->A303) == 35 );
if( (A1309 > 0) && !A2903 && A1742->A307 & 0x002 && !"
20D33I52"60 ) goto A1713;
goto A1714;
A1713:
if( A3976==0 && "
40D63I49"68.A166==0 && !(A395&(A85) 1) ) goto A1715;
goto "
68D35I9";
A1715:
"
42D5I4" (45"
14D139I27";
A428 = A213( A746(NULL), "
147D3I20"9, 2 );
A80->A127 |="
14D5I17";
memcpy((A49)( &"
12D32I64"31),(A49)( &A396),(size_t)( sizeof( struct A114 ) ));
A80 = A428"
37D8I4"16:
"
15D14I15"63 |= (A30) 0x8"
19D35I1";"
41D4I48"3976 == (34 | 0x100) &&
A2142 != 3 && A2142 != 4"
15D2I2"17"
13D1I1"0"
6D91I18"17: A3979 = (A4) 0"
97D42I3"0: "
47D2I2"14"
8D5I82"(A3976 == 0 || A3976 == (34 | 0x100)) &&
A80->A127 & (A27) 0x01 && !A80->A168.A166"
16D2I2"21"
12D2I2"22"
7D31I8"21:
if( "
41D2I1"&"
11D37I11"10000000 ) "
45D4I9"23;
goto "
9D21
26D37I2"23"
59D2I2"26"
12D2I2"27"
7D95I28"26:
A428 = A278(
A746(NULL),"
103D11I45"29, A80->A130,
A80->A140.A136, NULL, 2, 0 );
"
19D13I1"6"
19D3I68"27: A428 = A213( A746(NULL), A80->A129, 2 );
A1766:
if( !A428 ) goto"
8D12I1"7"
22D2I2"68"
7D48I23"67: A865(225); return; "
53D20I59"8:
A80->A127 |= (A27) 0x20;
A80 = A428;
A895( 839, A80, 0 )"
30D1I1"6"
7D6I47"25: A895( 512, A80, 0 );
A1769: ;
A1722:
switch"
12D12I23"6 )
{
case 0:
if( A2903"
23D2I2"71"
12D2I2"72"
7D21I55"71:
if( (A719 && (!A719->A1625 || A719->A1626 & 1) ) ) "
29D2I14"73;
goto A1774"
7D2I61"73:
if( A730( A80->A130 ) & 1 ) goto A1775;
goto A1776;
A1775"
19I13"4;
goto A1777"
5D3I20"76: A1761 = (A39) 5;"
8D2I4"7: ;"
12D22I55"8;
A1774:
A1761 = (A39) 5;
A1778: ;
goto A1779;
A1772: "
27D42I15"3977 == (A85) 0"
54D1I1"0"
12D1I1"1"
7D34I20"0: A1761 = (A39) 4;
"
43D13I1"2"
19D22I3"1: "
30D8
14D23I1"1"
29D12I45"2:
A1779:
goto A1770;
case (45 | 0x100):
if( "
19D5I24"68.A166 && !(A80->A127 &"
16D22I1")"
34D1I1"3"
12D1I1"4"
7D1I1"3"
7D5I24"(A1309 > 0) && A80->A160"
15D3I3"785"
12D12I12"786;
A1785:
"
18D3I4"1034"
12I35"A1761 = A2903 ? (A39) 5 : (A39) 4;
"
7D10I19"770;
A1786: ;
A1784"
33D2I2"80"
9D3I15"3977 == (A85) 1"
13D3I3"787"
12D3I46"788;
A1787:
if( A2903 ) goto A1889;
goto A1890"
8D23I31"89: A904( 629, A80 );
goto A189"
30D2I27"0:
A80->A127 |= (A27) 0x01;"
8D56I3"418"
68D1I1"2"
12D1I1"3"
7D20I23"2: A418->A5387 = (A4) 1"
26D31I1"3"
38D4I56"1495 && A415 && A415->A163 & (A30) 0x0800
&& !A415->A160"
16D1I1"4"
12D1I1"5"
7D29I13"4:
A904( 1534"
34D59I2" )"
65D45I3"5: "
51D1I22"1: ;
goto A1896;
A1788"
8D21I38"2903 ) goto A1897;
goto A1898;
A1897:
"
26I26" = A278(
(A280(A721)), A80"
5D21I63"9, A80->A130,
A80->A140.A136, NULL, 2, 0 );
goto A1899;
A1898: "
26I55" = A213( (A280(A721)), A80->A129, 2 );
A1899:
if( A3082"
5D1I23"8.A166 && !(A3082->A127"
6I31"27) 0x01) &&
!(A3082->A163 & (A"
185D3I6"size_t"
6297D3I6"size_t"
757D4I12"7267 && A434"
9D1I42"2 & 0x1000 &&
A434->A183.A131.A117 == A390"
34I29"
{
struct A83 *A2897 = A7502("
5I52" );
if( A2897 ) goto A1722;
goto A1723;
A1722:
A2897"
5D10I3"8 ="
15D21I12";
goto A1725"
27I141"3:
A884( 98,
"Could not resolve symbols with internal "
"linkage during PCH absorption -- shutting down" );
sys_exit( 1, 0 );
A1725: ;
}
A172"
17D1I1"4"
13D1I1"6"
12D1I1"7"
7D14I7"6: A434"
19D1I21"4 =
A1076( A434->A175"
6D2I8"85->A184"
10D1I1"7"
8D16I10"3985->A187"
27D2I2"66"
12D2I2"67"
7D4I4"66:
"
15D26I7"->A187,"
31D15I3"2 )"
29D8I54"2575->A303 == 41 ) goto A1768;
goto A1769;
A1768: A216"
13D15I36"85, A1059 ); return; 
A1769: A3991 ="
21D1
6D10I13"6;
A1772:
if("
17D3I4"&& ("
10I51"= ((A81) ((( A3985)->A173)->A988)[ A3991 ]), A3990 "
41D2I2"70"
12D2I2"71"
7D2I2"73"
38D2I2"72"
7D2I2"70"
179D2I2"74"
13D1I1"5"
6D2I2"74"
93D1I1"6"
7D1I1"5"
43D1I1"6"
33D1I1"7"
12D1I1"8"
7D1I1"7"
24D1I1"9"
11D2I2"80"
8D1I1"9"
28D2I2"81"
12D2I2"82"
7D2I2"81"
29D2I2"82"
54D2I2"83"
7D2I2"80"
18D2I2"83"
10D1I1"8"
46D2I2"84"
13D1I1"5"
6D2I2"84"
24D2I2"71"
8D1I1"5"
203D1I1"6"
12D1I1"7"
7D1I1"6"
26D1I1"7"
76D3I6"size_t"
51D1I1"8"
10D3I3"889"
9D1I1"8"
106D3I3"890"
12D10I10"891;
A1890"
69D3I3"892"
17D17I17"890;
A1893:
A1891"
39D2I2"94"
13D1I1"5"
6D2I2"94"
140D1I1"6"
12D1I1"7"
7D1I1"6"
61D1I1"8"
17D1I1"6"
7D1I1"9"
7D1I1"7"
94D3I3"900"
12D10I10"901;
A1900"
68D3I3"902"
17D10I10"900;
A1903"
16D3I3"901"
13D1I1"5"
55D10I10"904;
A1889"
45D1I1"5"
12D1I1"6"
7D1I1"5"
74D1I1"7"
17D1I1"5"
7D1I1"8"
9D1I1"6"
7D3I3"904"
17D2I2"73"
7D2I2"71"
2569D2I9"(A77) 0x0"
447D2I9"(A77) 0x0"
2792D3I6"size_t"
268D3I6"size_t"
1476I15"5057(1057,0);
A"
291D1I8"
A5058()"
1230D2I9"(A77) 0x0"
431D2I4"9070"
156D3I6"size_t"
755D3I6"size_t"
9828D3I6"size_t"
1217D3I6"size_t"
2254D3I6"size_t"
3180I12"goto A2416;
"
6D14
20D2I8"2142 == "
15D1I1"7"
12D1I1"8"
7D26I39"7:
A396 = A4026.A3755;
A9175(A80, A9164"
33D2I27"8:
A2416:
A2413:
A1726: if("
8D31
39D4I16"2421;
goto A2422"
9D23I24"21: A1204( A933, & A934,"
29I89"A2422: A933 = A3878; A3878 = 0; 
A2419:if(0) goto A1726;
A2420:
A5298( &A5362, (A5) 0 );
"
1927D2I4"9070"
79D10I50"A17 A9289 = 0;
if( (A2142 == 137 || A2142 == 189 )"
43D1I22"
A9072();
A1775:
if( !"
7D31
72D2I9"A419.A346"
15D24I6"!A4031"
57D13I19" A4031 = 15;
A1779:"
38D30I4"1000"
64D7I5"{
A58"
15I57"if( A419.A350 & (A25) 0x2000 &&
(A9001 = A8999(A4032)) ) "
12D32I10"goto A1783"
40D24I16"
A4031 = A9001;
"
33D12
24D3I10"95( &A419,"
11D16I3"601"
26D13I14" ;
}
A1781:
if"
19D7I63"7 ) goto A1785;
goto A1786;
A1785: A450( A4032, A429, 2, 0x02, "
13D14I5"1786:"
19I54"3 = A538( A4031, A3330, &A9289 );
A478( &A3963 );
A403"
158D1I1"7"
12D1I1"8"
7D1I1"7"
29D1I1"8"
116D3I3"889"
12D10I10"890;
A1889"
46D3I3"890"
51D2I2"91"
13D1I1"2"
6D2I2"91"
61D1I1"2"
92D1I1"3"
12D1I1"4"
7D1I1"3"
133D1I1"5"
12D1I1"6"
7D1I1"5"
35D1I1"7"
12D1I1"8"
7D1I1"7"
23D1I1"8"
41D1I1"9"
10D3I3"900"
9D1I1"9"
26D3I3"900"
14D3I3"901"
9D1I1"6"
46D3I3"901"
55I16"A9247( A4032 );
"
52D1I1"2"
12D1I1"3"
7D1I1"2"
28D1I1"3"
24D1I1"4"
12D1I1"5"
7D1I1"4"
37D1I1"5"
34D1I1"6"
12D1I1"7"
7D1I1"6"
37D1I1"7"
62D1I1"8"
12D1I1"9"
7D1I1"8"
42D1I1"9"
63D2I2"10"
12D2I2"11"
7D2I2"10"
36D2I2"11"
44D1I1"2"
12D1I1"3"
7D1I1"2"
36D1I1"3"
86D1I1"4"
12D1I1"5"
7D1I1"4"
178D1I1"6"
12D1I1"7"
7D1I1"6"
49D1I1"8"
12D1I1"9"
7D1I1"8"
28D1I1"9"
42D4I4"2330"
12D11I11"2331;
A2330"
35D4I4"2331"
12D1I1"7"
14D1I1"2"
7D1I1"5"
45D1I1"3"
12D1I1"4"
7D1I1"3"
79D1I1"5"
12D1I1"6"
7D1I1"5"
42D1I1"7"
7D1I1"6"
47D1I1"8"
12D1I1"9"
7D1I1"8"
28D1I1"9"
9D1I1"7"
13D2I2"40"
8D1I1"4"
36D2I2"40"
8D1I1"2"
35D2I2"41"
13D1I1"2"
6D2I2"41"
43D1I1"3"
7D1I1"2"
33D1I1"3"
24D1I1"4"
12D1I1"5"
7D1I1"4"
30D1I1"5"
60D1I1"6"
12D1I1"7"
7D1I1"6"
104D1I1"8"
12D1I1"9"
7D1I1"8"
19D1I1"9"
56D2I4"9070"
84D2I2"50"
12D2I2"51"
7D2I2"50"
21D2I2"51"
39D1I1"2"
12D1I1"3"
7D1I1"2"
31D1I1"4"
12D1I1"5"
7D1I1"4"
64D1I1"5"
9D1I1"3"
29D1I1"6"
12D1I1"7"
7D1I1"6"
16D1I1"7"
57D2I4"9070"
20D1I1"8"
7D1I1"7"
28D1I1"8"
34D1I1"9"
11D2I2"60"
8D1I1"9"
60D2I2"60"
30D2I2"61"
8D1I1"4"
187D1I1"2"
12D1I1"3"
7D1I1"2"
37D1I1"3"
35D1I1"4"
12D1I1"5"
7D1I1"4"
37D1I1"5"
73D1I1"6"
12D1I1"7"
7D1I1"6"
28D1I1"8"
7D1I1"7"
51D1I1"9"
11D2I2"70"
8D1I1"9"
103D2I2"70"
10D1I1"8"
8D2I2"61"
47D2I2"71"
13D1I1"2"
6D2I2"71"
42D1I1"2"
98D1I1"3"
12D1I1"4"
7D1I1"3"
64D1I1"5"
12D1I1"6"
7D1I1"5"
30D1I1"6"
28D1I1"7"
7D1I1"4"
31D1I1"8"
12D1I1"9"
7D1I1"8"
146D2I2"80"
12D2I2"81"
7D2I2"80"
39D2I2"81"
31D1I1"2"
12D1I1"3"
7D1I1"2"
45D1I1"4"
12D1I1"5"
7D1I1"4"
44D1I1"6"
7D1I1"5"
45D1I1"7"
12D1I1"8"
7D1I1"7"
39D1I1"8"
7D1I1"6"
93D1I1"9"
11D2I2"90"
8D1I1"9"
27D2I2"90"
91D2I2"91"
13D1I1"2"
6D2I2"91"
51D1I1"2"
66D1I1"3"
12D1I1"4"
7D1I1"3"
36D1I1"4"
34D1I1"5"
12D1I1"6"
7D1I1"5"
36D1I1"6"
43D1I1"7"
12D1I1"8"
7D1I1"7"
40D1I1"8"
9D1I1"3"
45D1I1"9"
10D3I3"400"
9D1I1"9"
18D3I3"400"
28D3I3"401"
9D1I1"9"
148D1I1"2"
12D1I1"3"
7D1I1"2"
22D1I1"3"
9D3I3"401"
9D1I1"7"
25D1I1"4"
12D1I1"5"
7D1I1"4"
28D1I1"5"
51D1I1"6"
12D1I1"7"
7D1I1"6"
29D1I1"7"
24D1I1"8"
29D1I1"9"
11D2I2"10"
8D1I1"9"
91D2I2"11"
13D1I1"2"
6D2I2"11"
88D1I1"3"
29D1I1"4"
12D1I1"5"
7D1I1"4"
67D1I1"6"
7D1I1"5"
31D1I1"7"
12D1I1"8"
7D1I1"7"
30D1I1"9"
45D2I2"20"
23D2I2"20"
10D1I1"9"
9D1I1"8"
7D1I1"6"
7D1I1"3"
23D2I2"21"
13D1I1"2"
6D2I2"21"
27D1I1"2"
11D1I1"2"
88D1I1"3"
12D1I1"4"
7D1I1"3"
17D1I1"4"
125D1I1"5"
12D1I1"6"
7D1I1"5"
29D1I1"7"
12D1I1"8"
7D1I1"7"
28D1I1"8"
55D1I1"9"
11D2I2"31"
8D1I1"9"
16D2I2"31"
10D1I1"6"
74D2I2"32"
13D1I1"3"
6D2I2"32"
48D1I1"3"
30D1I1"4"
12D1I1"5"
7D1I1"4"
77D1I1"6"
29D1I1"7"
12D1I1"8"
7D1I1"7"
36D1I1"9"
7D1I1"8"
34D1I1"9"
7D1I1"6"
31D2I2"40"
12D2I2"41"
7D2I2"40"
41D2I2"41"
17D1I1"2"
7D1I1"5"
40D1I1"3"
12D1I1"4"
7D1I1"3"
27D1I1"4"
7D1I1"2"
114D1I1"5"
12D1I1"6"
7D1I1"5"
56D1I1"7"
12D1I1"8"
7D1I1"7"
23D1I1"8"
25D2I4"9070"
46D2I4"9070"
13D1I1"6"
16D1I1"9"
6D2I2"10"
81D2I2"50"
12D2I2"51"
7D2I2"50"
36D1I1"2"
12D1I1"3"
7D1I1"2"
38D1I1"3"
25D2I4"9070"
51D2I4"9070"
18D1I1"4"
6D2I2"51"
62D1I1"5"
12D1I1"6"
7D1I1"5"
45D1I1"7"
12D1I1"8"
7D1I1"7"
17D1I1"8"
114D1I1"9"
11D2I2"60"
8D1I1"9"
27D2I2"60"
10D1I1"6"
38D2I2"61"
13D1I1"2"
6D2I2"61"
26D2I4"9070"
17D1I1"2"
62D1I1"3"
12D1I1"4"
7D1I1"3"
36D2I4"9070"
13D1I1"4"
9D1I1"4"
7D1I1"9"
7D1I1"8"
38D1I1"5"
60D1I1"8"
12D1I1"9"
7D1I1"8"
70D1I1"9"
10D1I1"6"
17D1I1"5"
7D1I1"7"
1605D1I1"
"
13I27"&&
!(A1742->A314.A311 & 1) "
33I33"{
struct A189 *A3277;
A81 A4913;
"
342D1I1"
"
72D1I1"
"
36D23
28D11I67"(A4913 = A5269( A4032->A130 )) &&
A4913->A5796 & (A5793) 0x20000000"
46D21I9"533( A491"
35D10I6"} goto"
15D1I25"1;
A1717:
if( A1724->A187"
34D8I6"
A216("
18D2I10"87, A533 )"
7I28"68:
A3277 = A1724->A190;
A17"
9D4I4"3277"
38D12I12"3277 = A3277"
17D1I1"0"
22D5I10"if( (A4913"
11D2I9"69( A3277"
7D13I41"2 )) &&
A4913->A5796 & (A5793) 0x20000000"
46D27I12"
A533( A4913"
37D13I3" ;
"
22D13I1"2"
19D44
49D43I43"}
A1715:
if( A1724 ) goto A1775;
goto A1776"
48D45I12"75: A5292 = "
50D1I14"->A194;
A1779:"
7D5I4"5292"
15D2I2"77"
12D2I2"78"
7D7I47"80: A5292 = A5292->A255;
goto A1779;
A1777:
A19"
12D83I11"A5292->A257"
89D72I6"!A1942"
83D2I2"81"
12D2I2"82"
7D13I9"81: A1942"
18D9I36"269( A5292->A256 );
A1782:
if( A1942"
20D2I2"83"
12D2I2"84"
7D20I29"83: A3951( A1942 );
A1784: ;
"
28D13I1"8"
19D23I4"78: "
28D8I24"76: ;
}
Void
A546(A1740,"
13D51I11")
A58 A1740"
56D3I87" A1709;
{
A315 A1742;
A70 A1738;
struct A83 *A1724;
if( A1740 ) goto A1711;
goto A1712;"
8D11I197"1:
A1742 = ( A7174 = (A1740), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) );
if( (A1738 = A1742->A303) == 29 || A1738 == 30 ||
A1738 == 31 || A1738 == 41 ) goto A1713;
goto A1714"
16D6I47"13:
if( A1724 = A507(A1742) ) goto A1715;
goto "
11D2
8D3I41"5:
if( A1709 & 1 ) goto A1717;
goto A1720"
9D26I10"7: A1158(&"
31D34I33"->A183);
A1720:
if( A1709 & 4 && "
39D66I6"->A182"
71D1I1"2"
13D1I1"2"
12D1I1"2"
7D1I1"2"
6D19I13"719.A592 = 15"
24D38I4"22: "
44D29I3"6: "
34D28I4"14: "
34D1I1"2"
7D15I16"Void
A8835( A180"
21D47I11"24, A5021 )"
55D32I120"806;
struct A83 *A1724;
struct A465 *A5021;
{
A58 A8794 = A5021->A8789;
if( A5021->A3756 & 0x10 ) goto A1711;
goto A1712"
37D111I1"1"
116D120I40"806->A314.A311 |= 4;
A1712:
if( A8794 ) "
129D88I3"3;
"
97D8I3"4;
"
13I28":
A1724->A8822.A8821 = A8794"
5D51I28"24->A191 |= (A31) 0x40000000"
57D110I105"4: ;
}
A72
A3111( A4046, A1740, A1883 )
A6 A4046;
A58 A1740;
A7468 A1883;
{
A315 A1742;
A72 A3535, A2882,"
119D23I1"0"
28D12I138"42 = ( A7174 = (A1740), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) );
switch(A4046)
{
case 1:
A1443();
memset((A49)( &"
17I46"),0,(size_t)( sizeof( struct A3097 ) ));
A3109"
5D42I45"8 = (A70) A1740;
A3109.A3099 = 0;
A111( 1 );
"
51D38I9"1;
case 2"
43D16I25"11( 5, 0, (A7468) 0 );
if"
25D43I11"3103 > 1 &&"
52D3I17"099 % A3109.A3103"
14D2I2"12"
12D2I2"13"
7D10I19"12:
A883( 959, (A6)"
19D7I10"099, (A6) "
17D22I3"3 )"
27D25I56"13:
A1408( &A3109.A3099, A3109.A3103, "end of struct" );"
31D4I16"3109.A3098 == 30"
15D2I2"14"
12D1I1"1"
7D3I11"14: A1754 ="
14D10I13"4;
goto A1716"
15D62I2"15"
67D10I24"54 = A3109.A3099;
A1716:"
15D5I11"(A1309 > 0)"
10D12I9"1754 == 0"
23D2I2"17"
13D1I1"0"
6D17I13"17: A1754 = 1"
23D8I3"0:
"
15D32I13"5966 = A5493("
40D8I42"5966 );
A111( -1 );
goto A1711;
case 5:
if"
22D28I2") "
36D2I2"21"
12D2I2"22"
7D26I22"21:
A3948( A3109.A3102"
31D7
16D19I7"1 = 0;
"
27D22I7"100 = 0"
27D17I25"22:
return A1754;
case 3:"
23D18I4"1883"
29D2I2"23"
12D2I2"25"
7D4I4"23: "
14D10I10"6 = (A4) 1"
15D64I76"25:
A2882 = A1742->A305;
A3535 = (A72) (A395 & (A85) 0x20 ? 1 : A1742->A304)"
71D16I21"5959 && A3535 > A5959"
27D2I2"26"
12D2I2"27"
7D29I25"26: A3535 = A5959;
A1727:"
34I1"("
10D3I29"2 != A2882 || A1883 == 0 ) &&"
12D36I8"101
||
("
47D15I52"1 + A1883 > A2882 * A1390 ) )
goto A1766;
goto A1767"
20D2I35"66: A3111( 5, 0, (A7468) 0 );
A1767"
12D7I51"102 = A2882;
A1408( &A3109.A3099, A3535, "member" )"
12D23I17"54 = A3109.A3099;"
28D13I19"A3109.A3103 < A3535"
24D2I2"68"
12D2I2"69"
7D36I4"68:
"
46D1I44"3 = A3535 ;
A1769:
A3109.A3100 = A3109.A3101"
6D13I24"09.A3101 = A3109.A3101 +"
19D2
8D51I16"A3109.A3098 == 3"
64D1I1"0"
12D1I1"1"
7D24I1"0"
29I30"11( 5, 0, (A7468) 0 );
if( A31"
7D20I15"4 < A3109.A3099"
32D1I1"2"
12D1I1"3"
7D1I1"2"
10D12I6"3104 ="
20D20I4"3099"
26D6I19"3:
A3109.A3099 = 0;"
11D1I1"1"
20D1I1"6"
7D14I16"!A7280(A1740) ) "
22D2I2"74"
12D2I2"75"
7D4I49"74: {
struct A83 *A1724;
A4 A4047 = A3109.A3106;
"
11D64I2"4,"
69D7I9"0, A1883 "
14D5I21"(A1724 = A506(A1740))"
10D12I26"1724->A191 & (A31) 0x10000"
23D2I2"76"
12D2I2"77"
7D17I18"76:
A4047 = (A4) 1"
22D12I4"77:
"
20D43I11"106 = A4047"
49D65I5"A1724"
76D7I22"78;
goto A1779;
A1778:"
15D45I12"5966 = A108("
53D13I20"5966, A1724->A5953 )"
18D2I33"79: ;
}
A1775:
goto A1711;
case 4"
8D29I14"A3109.A3101 )
"
38D1I1"0"
12D1I1"1"
7D2I88"0: A3111( 5, 0, (A7468) 0 );
A1781:
A3535 = (A72) (A395 & (A85) 0x20 ? 1 : A1742->A304);"
7D6I5"A5959"
12D52I11"535 > A5959"
64D1I1"2"
10D3I3"783"
9D2I85"2: A3535 = A5959;
A1783:
A1408( &A3109.A3099, A3535, "member" );
A1754 = A3109.A3099;"
7I19"(A1309 > 0) && ( ( "
12D8I12") == 28 || ("
19D32I10"3 ) == 35 "
43D23I4"711;"
35D14I12"3103 < A3535"
24D3I3"784"
12D29I12"785;
A1784: "
36D17I55"3103 = A3535 ;
A1785:
if( (A2882 = A1742->A305) == 0 ) "
24D69I3"786"
78D3I3"787"
9D2I16"6:
if( !A1063 &&"
7D62I50"7 && !(A719 && (!A719->A1625 || A719->A1626 & 1) )"
72D3I3"788"
13D9I9"89;
A1788"
16D24I63"1742->A303 == 27 && A1742->A307 & 0x100000 &&
A6245(1999,30000)"
36D1I1"0"
12D1I1"1"
7D2I6"0:
if("
10D18I39"6270 & (A17) 1 ) goto A1892;
goto A1893"
24D1I18"2:A865(157);
A1893"
10D16I16"6270 |= (A17) 1;"
24D46I44"894;
A1891:
A904( (A1309 > 0) ? 1501 : 43 , "
52D240I21");
A1894: ;
A1889: ;
"
247D15I3"895"
20D20I48"87: A3109.A3106 = (A4) 1;
A1895:
A3948( A2882 );"
26D1I15"3109.A3098 == 3"
12D3I3"896"
12D31I44"897;
A1896:
if( A3109.A3104 < A3109.A3099 ) "
38D104I5"898;
"
111D4I69"899;
A1898: A3109.A3104 = A3109.A3099;
A1899:
A3109.A3099 = 0;
A1897:"
14D2I36"1;
default:
A865(279); goto A1711;
}"
7D7I8"1:
A3107"
16D57I51"return A1754;
}
A84
A541( A4048, A80, A2975, A1871,"
64D39I87")
struct A144 *A4048;
A81 A80;
struct A144 *A2975;
A57 A1871;
A70 A2060;
{
struct A83 *"
47D87I58"NULL;
struct A83 *A1724;
A54 A3305;
A5794 A1741;
A58 A1740"
94D12I11"1740 = A436"
23D2I2"11"
12D2I2"12"
7D16I12"11: A436 = 0"
21D6I14"12:
if( A80 ) "
14D2I14"13;
goto A1714"
7D14I11"13: A1741 ="
22D20I4"29;
"
28D14I2"15"
19D29I14"14: A1741 = """
34D2I2"15"
8D43I53"4 = (struct A83 *) A1005( A4048 );
A3305 = A1011;
if("
49D27I7" = A435"
38D2I2"16"
12D2I2"17"
7D22I27"16: A435 = NULL;
goto A1720"
27D57I54"17: if( (A1309 > 0) && A80 && A80->A160 && A2060 != 41"
68D2I2"21"
12D2I2"22"
7D3I144"21:
A2897 = ((A395 & (A85) 4 && (A1277>=2 || A1309>0 && (A1277>=1||A1311<=0))) ? A469(A464) : A429);
if( A2897 == A429 ) goto A1723;
goto A1725;"
8D14I15"3: A2897 = NULL"
20D19I15"5: ;
goto A1726"
24D18I27"22: if( A80 && A80->A161 &&"
31D33
43D2I2"27"
12D2I2"66"
7D25I29"27:
A2897 = A506( A80->A161 )"
30D2I2"66"
8D9I22"6:
A1720: A210( A1724,"
14D1I31"1, A2975, A1871, A2897, A1327 )"
8D10I11"1063 && A80"
21D2I2"67"
12D2I2"68"
7D3I66"67: A1064 = &A80->A131;
A1768:
A922( &A1724->A183 );
A1064 = NULL;"
14D8I7"== A508"
19D2I2"69"
13D1I1"0"
6D13I22"69:
A1724->A182 |= 0x4"
18D17I29"24->A183.A160 = A464;
A1770:
"
22D26I9"->A182 |="
36D2I35"41 ? 0x800 : 0x200;
if( (A1309 > 0)"
14D1I1"1"
12D1I1"2"
7D3I3"1: "
20D2I1"8"
11D2I23"2:
A1724->A195 = A1740;"
8D28I10"2060 == 41"
39D2I2"73"
12D2I2"74"
7D35I47"73:
if( A4048 != A1326 ) goto A1775;
goto A1776"
40D4I13"75:A865(1222)"
10D24I15"6:
(void) A211("
30D93I14" );
goto A1777"
98D26I7"74:
if("
32D95I31" == 31 ) goto A1778;
goto A1779"
100D125I4"78:
"
130D75I16"->A182 |= 0x4000"
81D14I3"79:"
20D8I3"395"
13D10I20"85) 1 && (A1309 > 0)"
21D2I2"80"
12D2I2"81"
7D18I35"80:
A1724->A191 |= (A31) 0x20000000"
23D55I4"81: "
60D160I25"77:
A1011 = A3305;
return"
165D1I94"4;
}
static Void
A3949(A1731)
struct A465 *A1731;
{
A2 A2086[M_TOKEN];
register A81 A80 = NULL"
6D23I10" A3039 = 0"
28D70I11" A5971;
A70"
76D17I95";
struct A83 *A4049;
A4 A4050 = (A4) 0;
A4 A4051 = (A4) 0;
A4 A4052 = (A4) 0;
A4 A4053 = (A4) 0"
22D4I229" A1709 = 0;
A32 A4054;
A42 A4055 = 0;
A4 A4056 = (A4) 0;
extern A81 A4057();
A31 A4059 = (A31) 0;
A58 A4008 = 0;
struct A83 *A1724;
memset((A49)( &A2209),0,(size_t)( sizeof( struct A2198 ) )); A1731->A8789 = 0;
A1731->A3756 = 0;
"
9D21I23"419.A351 & (A29) 0x0400"
32D2I2"11"
12D2I2"12"
7D26I18"11: A4051 = (A4) 1"
31D38I3"12:"
45D16
37D3I33") goto A1713;
goto A1714;
A1713:
"
10D1
15D28I35";
A4054 = (A32) 1;
A4056 = (A4) 1;
"
36D14I2"15"
19D13I4"14: "
18D16I19"2142 != (57 | 0x800"
29D2I2"16"
12D2I2"17"
7D16I30"16:
A4054 = (A32) 6;
goto A172"
22D18I23"17: A4054 = A3109.A5284"
23D30I9"20:
A1715"
46D3I2"46"
24D2I2"21"
12D2I2"22"
7D11I26"21: A2060 = 29;
goto A1723"
16D4I4"22: "
9D20I11"2142 == (49"
25D6I4"8000"
18D2I2"25"
12D2I2"26"
7D16I16"25: A2060 = 30;
"
24D14I2"27"
19D26I14"26: A2060 = 31"
31D3I19"27:
A1723:
A2163();"
9D18I88"2060 == 31 &&
(A2142 == (91 | 0x8000) || A2142 == (46 | 0x8000)) &&
A6245( 30000, 2010 )"
29D2I2"66"
12D2I2"67"
7D15I39"66:
A2163();
if( A1095( 12 ,(A35) 0) ) "
23D1I13"68;
goto A176"
7D13I17"68:
A1709 |= 0x10"
18D4I18"31->A3756 |= A1709"
9D4I14"31->A8789 = 15"
9D54I12"69: ;
A1767:"
68D100I13"(114 | 0x8000"
112D1I1"7"
12D1I1"7"
7D2I18"70:
A2163();
A1771"
9D10I32"419.A349 & ( 0x20000 | 0x40000 )"
21D1I1"7"
12D1I1"7"
7D15I3"72:"
20D55I5"!A719"
66D1I1"7"
12D1I1"7"
7D49I12"74:A865( 215"
61D1I1"7"
7D69I30"75:
if( A419.A349 & 0x20000 ) "
77D2I14"77;
goto A1778"
7D75I15"77:
A4055 = 1;
"
83D13I1"7"
19D55I87"78: A4055 = 2;
A1779: ;
A1776: ;
A1773:
A5971 = A475() | A419.A348;
A921( &A1731->A3755"
64D2I75"2142 == 12 || A2142 == 110 || A2142 == 20 &&
(((A1309 > 0) && (A1311 <= 0))"
7D8I3"395"
13D11I21"85) 4 || (A1242 > 0))"
21D2I2"78"
12D2I2"78"
7D43I3"780"
50D24I9"2142 == 2"
35D3I3"782"
12D72I22"783;
A1782:
A1709 |= 2"
79D2I13"395 & (A85) 4"
7D17I36"434 && ((A1309 > 0) && (A1311 <= 0))"
27D3I3"784"
12D2I70"785;
A1784:
sprintf( A2086, " <%s>", A976( ++A434->A186 ) );
goto A178"
7D60I70"785: A662( A2086, M_TOKEN, "___", (A5774) 0, A1494, A2146 );
A1786: ;
"
67D22I10"787;
A1783"
27D67I3"17 "
73D38I56"= 0x200|0x08|0x200000;
strcpy( A2086, A2149 );
if( A4051"
48D3I3"788"
12D31I62"889;
A1788:
A80 = A2214( (A281(A721)), A1948 | 0x4000 | 0x2000"
36D7
12D9I31"80 && A80->A163 & (A30) 0x40000"
19D3I3"890"
12D16I16"891;
A1890: A170"
21D5I55"1;
A1891: ;
goto A1892;
A1889:
if( A4055 || A419.A349 &"
11D16I48" ) goto A1893;
goto A1894;
A1893: A1948 |= 0x100"
22D17I53"894:
A80 = A2214( A429, A1948 | 0x8000 );
if( A80 && "
27D99I8"4 & 0x10"
109D3I3"895"
12D36I2"89"
41D3I26"895: A4052 = (A4) 1;
A1896"
10D3I24"80 && A2209.A2204 & 0x08"
13D3I3"897"
12D56I36"898;
A1897:
{
A315 A1742;
A81 A8614;"
61D16I10"3 = (A4) 1"
22D9I30"(A8614 = A2209.A8597) &&
A1948"
17I31"00 &&
A8614->A131.A116 != A1494"
10D3I3"899"
14D1I32"0;
A1899:
A895( 1577, A8614, 0 )"
7D26I2"0:"
32D16I9"4055 == 1"
27D2I2"01"
12D2I2"02"
7D15I9"01:
A4059"
27D3I19"1000000 | (A31) 0x4"
9D4I96"742 = ( A7174 = (A2209.A2203), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) );"
11D11I23"742->A303 == 42 && A719"
22D2I2"03"
12D2I2"04"
7D16I29"03:
A719->A6253 = A1742->A306"
21D4I37"04:
if( A719 ) goto A1905;
goto A1906"
10D3I18"5: A719->A1620 = 1"
9D33I45"6: ;
goto A1907;
A1902:
A4059 |= (A31) 0x800;"
39D48I16"419.A349 & 0x100"
59D2I2"08"
12D2I2"09"
7D9I30"08:
A4059 |= (A31) 0x20000;
if"
14D4I39"24 = A745(A80) ) goto A1910;
goto A1911"
10D1I38"0:
A1724->A191 |= (A31) 0x20000;
A1911"
8D24I12"1638 & 0x400"
36D1I1"2"
12D1I1"3"
7D17I15"2:
A8936( A80 )"
23I49"3: ;
A1909: ;
A1907: ;
}
A1898: ;
A1892: ;
}
A178"
7D4I10"A2142 == 6"
10D9I33"060 == 31 &&
A6245( 30000, 2010 )"
21D2I44"4;
goto A1915;
A1914:
A8857( A1731 );
A1915:"
8D9
17D37I16"20 || A2142 == 6"
49D1I1"6"
9D4I4"1917"
10D14I8"6:
A4050"
19D6I12"4) 1;
A1917:"
11D5I19"!A80 && A2209.A2203"
14D6I68"1918;
if( A4050 || A2142 == 3 && !A80 &&
!( A419.A349 & 0x80000 ) ) "
12D33I4"1919"
44D14I20"0;
A1919:
{
A39 A232"
19I101"A39) 9;
if( A4051 ) goto A2331;
goto A2332;
A2331: A4049 = (A281(A721));
goto A2333;
A2332:
A4049 = ("
2914D2I2"10"
720D35I16"A80 && A80->A129"
68I26" A9155(A80->A129); 
A2396:"
5D1I15"(A1309 > 0) && "
10D29I11"82 & 0x800)"
63I6"if( !("
11D2I1"&"
19D14I4") &&"
20I23" goto A2399;
goto A2400"
6D1I60"9:
A429->A191 |= (A31) 0x20000000;
A8556( A429, A80 );
A2400"
9D1I1"8"
2210D3I6"size_t"
706D14
29D37
54D1
25I2"( "
14D5I22"(( A2897->A173)->A988)"
15I40", A5466 ? (A4) 1 : (A865(206), (A4) 0) )"
135D2
Fa17.c
209D4I7"7 A9235"
18D2I1"9"
12I16"A6 A10;
typedef "
291D20
27D4I8"32 A9069"
14I19"A9069 A24;
typedef "
10D4I2"25"
14D9I13"unsigned A890"
21D6I10"9069 A9150"
17D6I10"9069 A9070"
17D8I8"9070 A27"
18D12I9"A9070 A28"
22I21"A9070 A5793;
typedef "
10D4I2"29"
14D17
26D8I5"A6228"
19D6I8"9070 A30"
25D3I8"long A31"
13I17"A17 A32;
typedef "
11D1I1"3"
11D7I12"unsigned A34"
19D5I5"4 A35"
17D5I5"5 A36"
21D1I1"7"
17D1I1"8"
16D2I2"39"
18D1I1"0"
17D1I1"1"
17D1I1"2"
12D6I6"34 A43"
22D1I1"4"
17D1I1"5"
11D7I7"A42 A46"
17I17"int A47;
typedef "
342D2I4"9236"
17D4I2"63"
19D1I3"577"
18D1I1"4"
16D4I2"65"
20D2I2"19"
18D4I4"8258"
14I19"A54 A7616;
typedef "
138D6I3"A16"
60D13I3"A72"
122D6I5"A9069"
20D6I5"A9069"
1373I69"struct A9304
{
A17 A9305;
A5794 A9306;
};
extern struct A9304 A9307;
"
6D4I4"9308"
14D4I4"9309"
17D1I1"5"
11D4I4"5566"
14D4I4"5567"
14D3I17"7618();
Void A761"
8D13
19D3I17"5569();
Void A915"
8D9I10"Void A9152"
14D17I2"74"
22D1I15"0();
Void A7621"
10I41"6226();
A5794 A6227();
A81 A7622();
A58 A"
460D2I4"9070"
28D2I4"9070"
151I19"struct A114 A9153;
"
1389D2I2"92"
16D6I12"5794 A7637()"
15I16"A4 A202;
extern "
3337D2I4"9070"
159I11"A58 A9238; "
88D2I4"9070"
39D2I4"9070"
367I11"A17 A9071;
"
535I13"A9236 A9239;
"
1098D2I4"9070"
380D7I8"17 A9154"
24D1I1"1"
12D6I7"62 A442"
16I17"A4 A443 ;
extern "
150D3I4"9072"
14D10I9"Void A451"
22D9I9"5794 A452"
21D9I9"9036 A453"
29D1I1"4"
13D12
20D1I1"5"
12D9I22"A315 A456 ;
A5794 A457"
28D1I1"8"
18D4I3"459"
21D3I4"5268"
14D16
24D1I1"0"
12I16"A4 A461;
extern "
8D1I1"2"
12D8I11"Void A463()"
22D4I3"464"
13I18"A58 A8823;
extern "
1037D7I10"Void A9155"
18D9I7"A4 A504"
20I20"Void A505();
extern "
1042D2I4"9070"
1940D8I19"struct A640 * A9310"
24D4I3"663"
15D10I9"A48 A7505"
29D2I2"37"
19D3I4"7176"
14D7I9"Void A664"
22D4I3"665"
16D8I7"4 A4442"
19D6I6"A17 A5"
27D3I2"66"
21D2I3"031"
21D1I1"7"
20D1I1"8"
12I20"Void A669();
extern "
278D3I4"4476"
14D10I17"struct A640 *A675"
27D4I4"7719"
21D4I4"8914"
15D8I12"Void A7720()"
18D7I7"17 A933"
18D8I7"7 A5254"
18D2I2"81"
7D1I1"0"
11D2I2"17"
7D1I1"1"
11D1I2"35"
6D1I1"2"
11D1I2"92"
6D1I1"3"
11D2I1"7"
7D1I1"4"
11D8I7"4 A2145"
18D1I2"68"
6D1I1"6"
13D14I6"*A2147"
24D8I7"4 A2148"
18D7I16"2 A2149[M_TOKEN]"
17D2I2"87"
7D1I1"0"
11D2I1"4"
7D1I1"1"
15D4I4"2152"
14D2I2"36"
7D1I1"3"
11D27I7"35 A826"
38D1I2"17"
6D3I1"4"
13D10I28"7
A2155,
A2156,
A2157,
A6214"
19D4I2"A9"
9D1I1"8"
12D10I9"A17 A8825"
27D3I3"215"
15D3I4"Void"
8D1I1"0"
18D4I4"8209"
23D1I1"1"
12D3I4"Void"
8D1I1"2"
12D10I9"A35 A2163"
29D1I1"4"
12D5I4"Void"
10D1I1"0"
12D9I8"A35 A216"
22D7I10"9036 A8211"
24D4I4"5255"
15D4I2"A4"
9D11I16"6();
extern Void"
16I37"7();
extern Void A2168();
struct A216"
465I42"struct A9073
{
A48 A9074;
A9069 A9075;
};
"
422D6I7"8 A9076"
17D9I8"A42 A982"
20D8I9"long A983"
24D4I3"984"
16D8I8"87 A6039"
20D8I8"61 A7724"
19D9I9"A92 A7260"
20D8I9"long A985"
24D4I3"986"
16D9I8"34 A5670"
20I21"A5794 A987();
extern "
1045I7"9129,
A"
44D4I4"9156"
11I42"9157,
A9158,
A9159,
A9160,
A9161,
A8639,
A"
21D10I2"91"
15D2I2"91"
7I29"9164,
A6176, 
A7062,
A7063,
A"
91I21"9240,
A9241,
A9130,
A"
21I28"9165,
A9166,
A9167,
A9168,
A"
28I14"9292,
A9169,
A"
92I42"9242,
A9243,
A9131,
A9132,
A9133,
A9134,
A"
71I7"9170,
A"
307D4I4"9171"
21I42"9244();
extern Void A8266();
extern Void A"
8I80"extern Void A9172();
extern A4 A9173();
extern A4 A9174();
extern Void A9175();
"
746D9I7"4 A9176"
21D7I9"5794 A868"
19D6I6"7 A598"
25D1I1"0"
19D1I1"1"
13D10I7"61 A872"
22D7I10"5794 A6037"
19D10I7"61 A873"
22D7I10"5794 A8589"
20D5I6"8 A874"
16D9I7"A4 A875"
28D1I1"6"
20D1I1"7"
20D1I1"8"
19D2I2"79"
19D4I3"880"
21D4I4"6172"
21D3I4"9293"
20D4I4"9177"
21D4I4"8787"
23D1I1"1"
20D1I2"29"
18D4I4"7262"
23D1I1"2"
20D1I1"3"
20D2I2"48"
21D1I1"4"
20D1I1"5"
18D3I4"5667"
22D1I1"6"
19D2I2"87"
20D2I2"88"
20D2I2"89"
19D4I3"890"
21D4I3"891"
21D4I3"892"
21D4I4"7745"
24D1I1"6"
21D1I1"7"
20I1"4"
18D3I4"7748"
20D4I4"7749"
21D4I3"893"
23D1I1"4"
18D4I4"1857"
22D3I3"958"
22D1I1"5"
19D3I3"061"
20D3I4"5821"
20D4I3"896"
21D3I4"7507"
20D4I3"897"
21D4I4"5981"
23D1I1"8"
19D3I3"750"
20D3I4"8212"
20D3I3"899"
20D3I4"7177"
22D1I1"0"
18D4I3"901"
23D1I1"2"
20D1I1"3"
18D3I4"8944"
22D1I1"4"
18D4I3"905"
21D3I3"907"
21D4I4"9078"
23D1I1"7"
18D3I4"5077"
20D3I4"8267"
20D3I4"8830"
14D7I9"Void A908"
25D2I2"09"
13D9I9"Void A910"
28D1I1"1"
12D9I7"A4 A912"
20D16
24D1I1"3"
14D8I7"4 A5431"
19D11I9"Void A914"
22D10I9"Void A915"
22D11I6"7 A916"
27D2I2"17"
13D9I10"A5794 A918"
27D3I4"1739"
15D6I9"5794 A919"
24D4I3"920"
15D9I9"Void A921"
26D4I3"922"
15D20I14"A5794 A923();
"
31D4I3"924"
16D7I10"5794 A7263"
19D8I8"61 A5668"
19D7I12"Void A5669()"
16D18
26D13I12"7734 A7751; "
21D7I7"4 A7752"
18D18I10"A4 A5914()"
28D6I10"861 A926()"
16D8I6"4 A927"
18D6I8"4 A928()"
15D9I19"struct A849 *A929()"
19D6I9"61 A930()"
16D8I12"9236 A9245()"
18D6I12"9236 A9246()"
15D9I12"Void A9247()"
18D7I18"struct A144 *A5050"
17D8I6"7 A931"
18D6I8"61 *A932"
16D8I6"7 A933"
21D7I7"*A934;
"
14D18I7"A7 A935"
28D7I8"61 *A936"
16D18I7"A7 A937"
27D18I9"A61 *A938"
27D18I7"A7 A939"
28D9I8"61 *A940"
19D9I6"7 A941"
19D9I8"61 *A942"
19D12I10"61 A6038; "
19D11I18"struct A144 *A1696"
23D8I5" A943"
18D10I7"7 A9294"
19D11I18"struct A144 *A7178"
20D17
26D7I8"44 *A717"
17D7I18"struct A144 *A5432"
17D6I9"5794 A944"
15D17I10"A5794 A945"
26D20I12"A5794 A946;
"
27D4I5"A5794"
9D3I1"4"
19D6I4"7180"
15D12I11"A5794 A7227"
21D12I11"A5794 A7181"
22D7I10"5794 A5510"
17D8I7"68 A948"
17D18
26D10I9"114 *A949"
20D7I6"7 A950"
17D7I6"4 A951"
16D10I17"struct A114 *A952"
19D13I20"struct A144 *A7265; "
27D3I3"266"
15D7I10"5794 A1689"
24D4I4"7753"
15D18I10"Void A7754"
30D10I7"6 A1022"
20D10I8"81 A5511"
19D12I9"A81 A8770"
21D12I18"struct A561 *A1023"
21D12I8"A4 A1024"
22D10I7"7 A1025"
19D18I8"A4 A1026"
29D18I9"A49 A1027"
29D10I9"Void A775"
22D10I8"A4 A1028"
27D15I8"1029();
"
21D4I31"9079();
A48 A9080();
Void A9081"
15D21
38D1I1"0"
13D7I8"17 A1031"
18D18I9"A79 A1032"
35D4I4"5671"
15D8I10"Void A5672"
19D9I10"Void A8401"
21D8I8"17 A5512"
19D10I18"struct A561 *A1033"
21D9I10"Void A9135"
20D9I18"struct A561 *A1034"
21D7I10"5794 A1035"
18D47I10"Void A2317"
58D9I10"Void A5673"
20D9I10"Void A1036"
20D9I10"Void A1037"
20D11I18"struct A561 *A1038"
22D8I6"A4 A56"
21D9I18"struct A561 *A1039"
20D11I10"Void A7182"
22D18I10"A4 A7183()"
27D10I9"A58 A8268"
22D7I28"78 A1040();
extern Void A775"
12D6I49"extern A81 A1041();
extern A81 A7508();
extern A4"
11D3I49"7();
extern A5794 A8590();
struct A7758 *A7759();"
12D51I3"0()"
60D18I11"A78 A1042()"
28D8I10"78 A5271()"
18D8I10"78 A1043()"
18D8I12"5972 A1044()"
17D9I12"Void A2274()"
18D17I42"A54 A5433();
extern A9036 A9039();
extern "
26D106I9"44 *A5434"
116D7I12"9150 A9178()"
16D13I32"Void A7761();
extern A48 A7906()"
23D31I63"7758
{
A40 A7762;
A87 A7763, A7764;
A17 A7765, A7766;
A67 A7767"
43D21
29D11I10"7758 A7768"
20D79I9"A87 A7769"
88D12I9"A87 A7770"
21D12I9"A88 A7771"
21D12I9"A10 A7772"
21D43I17"const A88 A7773;
"
52D19I43"045
{
A18 A1046;
A72 A1047;
A7470 A1048;
A3"
24D2I58"49;
};
struct A1050
{
A18 A1051;
A17 A1052;
A5794 A1053;
}"
12D7I7"7 A3140"
17D34I14"81 A3143[20];
"
43D9I33"054
{
A54 A1055;
A55 A1056[25];
}"
19D8I9"55 *A3164"
19D11I19"struct A1054 *A7509"
20D78
86D209I12"144 *A7774;
"
217D10I51"7500
{
struct A7500 *A7775; A54 A7510; A42 A7511; }"
19D9I12"Void A1057()"
18D8I12"Void A1058()"
17D9I10"Void A1059"
20D8I10"Void A1060"
19D10I11"A5794 A1061"
21D22I18"struct A118 *A1062"
33D13I8" A1063;
"
20D13I8"A4 A7267"
26D4I4"7776"
14D10I8"63 A7777"
19D21
29D3I3"114"
8D2I2"64"
11I40"A81 A7512();
extern A49 A1073();
extern "
8D2I66"74();
extern A72 A1075[];
extern A9036 A1076();
extern A9036 A7778"
14D94I118"3097
{
A70 A3098; A72 A3099; A7468 A3100; A7468 A3101; A72 A3102; A72 A3103; A72 A3104; A7 A3105; A4 A3106; A7 A5282; "
100D5I85"283; A32 A5284; A74 A5966; A17 A6270; };
extern A81 A3107;
extern A315 A3108;
extern "
13D55I62"3097 A3109;
extern A58 A3110;
extern A4 A6067;
extern A72 A311"
60D10I14"extern A6 A311"
15D45
52D11I14"Void A1077();
"
19D7I21"48 strcat(), strcpy()"
17D9I14"48 strncpy(); "
16D11I13"int strncmp()"
24D4I4"1078"
15D8I7"2 A7268"
27D2I2"79"
13D12I18"struct A553 *A1080"
21I17"A7 A9295;
extern "
6D67I3"108"
72I66"struct A553
{
struct A553 *A1082;
A7 A1083;
struct A114 A1084;
};
"
15D81I1"8"
86D75I59"struct A5513
{
A81 A5514;
struct A147 *A5515;
};
A5972 A777"
80D39I10"A5972 A778"
44D17I10"A5972 A778"
22D16I10"A5972 A778"
21D16I10"A5972 A778"
21D16I10"A5972 A778"
21I15"A5972 A7785();
"
7D14I11"A74 A6242; "
21D12I8"A7 A1086"
21D12I8"A7 A7184"
21D12I11"A5794 A5248"
25D6I4"7185"
15D10I10"A95 *A1087"
27D4I4"1088"
21D4I4"1089"
21D4I4"7186"
21D3I3"109"
21D4I4"7187"
15D10I11"A5794 A1091"
21D9I10"Void A1092"
27D3I3"093"
20D4I4"8269"
20D3I3"094"
14D10I8"A4 A1095"
21D10I8"A4 A1096"
28D3I3"097"
20D4I4"1098"
16D10I7"4 A1099"
21D10I11"A94 * A5272"
21D9I10"A94 * A110"
21D10I11"A94 * A1101"
29D2I2"02"
19D4I4"1103"
15D11I10"Void A1104"
30D2I2"05"
21D2I2"06"
19D4I4"5675"
21D4I4"6243"
15D10I8"A4 A5518"
27D4I4"7786"
21D4I4"5516"
21D4I4"5517"
21D4I4"5519"
22D3I3"520"
14D18I12"Void A5521()"
27D17
23D4I4"5522"
15D10I9"A23 A7787"
21D8I10"Void A1107"
19D10I10"Void A1108"
22D10I7"4 A1109"
21D11I10"Void A1110"
22D11I10"Void A1111"
22D11I10"Void A1112"
22I21"Void A2942();
extern "
7D4I4"1113"
15D55I12"Void A2949()"
64D13I12"Void A7070()"
22D9I12"Void A1114()"
18D10I12"Void A1115()"
19D9I12"Void A7269()"
19D8I12"94 * A1116()"
17D9I12"Void A1117()"
18D18I12"Void A1118()"
27D18I12"Void A1119()"
27D26I12"Void A7788()"
35D8I12"Void A5676()"
17D18
26D2I2"20"
21D2I2"21"
21D2I2"22"
13D9I10"Void A8270"
26D4I4"5249"
15D10I18"struct A144 *A5523"
19I17"A7 A5822;
extern "
6D4I4"7789"
21D4I4"7790"
19D4I4"7791"
15D10I10"A94 *A7792"
21D10I11"A5794 A7793"
22D7I10"5794 A7794"
19D7I10"5794 A7795"
18D10I11"A5794 A7796"
22D8I10"5794 A7797"
20D2I4"5794"
7D3I45"8();
struct A5304 { A77 A3049; A5794 A1148; }"
12D12I13"A2 A1123[100]"
21D12I9"A17 A1124"
21D12I10"A13 *A1125"
21D12I9"A81 A1126"
23D9I7"8 A1127"
19D1I1"5"
6D4I2"28"
13D11I18"struct A144 *A1129"
20D11I18"struct A144 *A1130"
20D11I26"const struct A5304 A3050[]"
21D10I7"4 A1131"
20D17I8"38 A1132"
26D45I9"Void A113"
65D1I1"3"
21D1I1"3"
13D9I8"A17 A113"
29D1I1"3"
13D10I8"A4 A2979"
29D1I1"3"
19D3I3"917"
23D2I2"39"
13I19"A4 A1140();
extern "
8D1I1"4"
6D124I231"extern Void A5529();
extern A4 A5530();
extern A7 A5532();
extern Void A5533();
extern A66 A5534();
extern A66 A7799();
extern Void A5531();
extern Void A1142();
extern Void A1143();
extern Void A1144();
extern A50 A1145();
extern "
131D339I15"46();
extern A7"
344D13I118"47();
extern A48 A1148();
extern A48 A1149();
extern A77 A1150();
extern A58 *A5067, *A5068;
extern A17 *A8945, *A8946"
22D4I6"8271()"
15D5I193"53();
extern Void A1154();
extern Void A1155();
extern Void A1156();
extern Void A1157();
extern Void A5823();
extern Void A1158();
extern Void A1159();
extern Void A1160();
extern Void A1161()"
15D4I4"8402"
15D19
25D4I75"8403; A54 A8404; A13 *A8405; A7468 A8406; A72 A8407; A58 *A8408;
A58 *A8409"
19D52I1"6"
57D1I1"7"
6D56I4"63;
"
61D10I229"
A7132,
A7133,
A1164,
A1165,
A1166,
A1167,
A1168,
A1169,
A1170,
A1171,
A1172,
A1173;
A13 A1174[ (2000 / CHARLEN) ];
A18 A5435;
A17 A6040;
A13 A7800[ (2000 / CHARLEN) ];
A61 A6041;
A17 A6042;
} ;
extern A13 A9180[(2000 / CHARLEN)]"
20D4I4"9248"
14D88I6"9249; "
95D17I17"9296; A17 A9250; "
24D6I6"9251; "
13D6I19"9297; FILE *A9252; "
16D9I18"struct A9248 A9253"
18D127I14"Void A9254();
"
135D27I104"391
{
struct A633 *A1175;
struct A144 *A1176;
struct A144 *A1177;
struct A144 *A1178;
};
struct A1179
{
"
32D262I91"180;
A53 A1181;
A17 A1182;
A53 A1183;
A5794 A1184;
A5794 A1185;
};
struct A1186
{
struct A8"
267D31I5"187;
"
40D27
33D12I8"188;
};
"
21D18I6"189
{
"
26D71I105"640 *A1190;
A5794 A1191;
};
struct A1192
{
A17 A1193;
A9 A1194;
A70 A1195;
};
struct A1196 { A2 A1197[3];"
77I833" *A1198; };
struct A1199
{
A5794 A1200;
A35 A1201;
A42 A1202;
};
Void A1203();
Void A1204();
Void A1205();
struct A5677
{
A5794 A5678;
A42 A5679;
A5794 A5680;
A5794 A5681;
};
extern A17 A6244;
extern long A7418;
extern A49 *A1206;
extern A49 *A1207;
extern A2 A1208[ARG_LEN];
extern A42 A8197; extern A2 A3496[ARG_LEN];
extern struct A1196 A1209[];
extern const A6 A1210;
extern A7 A5406;
extern A7 A5407;
extern A7 A6210;
extern A42 A1211;
extern A4 A1212;
extern A72 A1213;
extern A72 A1214;
extern A18 A1215;
extern A18 A1216;
extern A4 A7228;
extern A61 A1217;
extern A61 A1218;
extern A67 A1219;
extern A13 *A6043;
extern A13 *A1220;
extern A13 *A1221;
extern struct A1162 A1222;
extern struct A144 *A1223;
extern struct A144 *A1224;
extern struct A144 *A1225;
extern A48 A1226;
extern A7 A1227;
extern A9070 A1228;
extern UFLAG"
1095I7"9298,
A"
2534D19
33D4I4"9255"
14D7I9"2 A7190[]"
16D8I18"struct A144 *A1398"
21D4I4"1399"
14D8I7"4 A7807"
18D7I6"7 A621"
21D7I6"9181; "
15I1"1"
6D1I1"0"
11D1I2"68"
6D1I1"1"
11D1I1"4"
6D1I2"2 "
11D1I1"7"
6D1I1"3"
10D4I2"A7"
9D3I1"4"
12D4I2"A7"
9D3I1"5"
12D4I2"A4"
9D3I1"6"
12D9I10"Void A1407"
20D9I10"Void A1408"
26D4I4"1409"
17D6I7"8 A1410"
17D10I9"A58 A1411"
21D8I10"Void A8257"
19D10I8"A4 A8411"
27D4I4"5063"
15D4I2"A6"
9D1I1"2"
12D2I4"Void"
7D1I1"3"
18D4I4"1414"
21D4I4"1415"
15D10I8"A4 A1416"
21D19I10"Void A5687"
36D4I4"5688"
15D10I10"Void A5689"
21D10I19"struct A5677 *A5690"
30D1I1"7"
12D10I10"A13 *A5396"
21D10I9"Void A141"
28D4I4"1419"
21D4I4"6052"
15D10I11"A5794 A7808"
30D1I1"4"
18D4I4"5545"
21D4I4"5546"
15D8I10"Void A5547"
19D2I4"Void"
7D1I1"0"
12D2I4"Void"
7D25I1"1"
36D9I7"A4 A624"
21D9I9"A48 A9182"
20D9I8"A4 A1422"
20D4I2"A4"
9D12I5"3();
"
26D5I6" A1424"
16D10I12"Void A3500()"
19D8I10"Void A1425"
19D8I9"int A3493"
19D10I9"int A3494"
27D4I4"1426"
15D10I19"struct A1189 *A1427"
21D12I10"A13 *A8273"
22D7I6"4 A599"
19D9I7"A4 A599"
21D8I10"Void A9311"
27D2I2"28"
13D12I10"Void A7191"
31D2I2"29"
13D8I10"Void A6080"
25D4I4"9183"
15D10I9"A54 A1430"
21D1I1"V"
6D4I4"1431"
15D10I8"A4 A7475"
30D1I1"2"
12D9I12"UFLAG *A1433"
29D1I1"4"
12D10I8"A4 A1435"
29D2I2"36"
13D1I1"v"
6D4I4"6246"
15D1I1"v"
6D4I4"7809"
21D4I4"1437"
23D2I2"38"
14D10I10"34 A5691()"
19D20
28D2I2"39"
19D4I4"1440"
15D10I12"Void A1441()"
19D17
26D1I1"2"
21D1I1"3"
12D11I10"Void A5773"
30D2I2"44"
13D12I11"A5794 A1445"
21I20"A5794 A1446;
extern "
6D4I4"1447"
21D4I4"3532"
15D12I10"A2 A3526[]"
21I17"A4 A3527;
extern "
6D2I2"14"
21D4I4"1449"
15D10I11"A5794 A1450"
30D1I1"1"
18D4I4"1452"
15D10I8"A4 A9184"
27D4I4"5274"
21D73I6"1453()"
82D19I12"Void A5651()"
28D20I12"Void A5548()"
29D20
26D4I130"3443();
extern Void A6072();
extern Void A1454();
extern Void A3363();
extern Void A1455();
extern Void A1456();
extern Void A5107"
17D89I65"065
{
A67 A1066;
A5794 A1067;
A5794 *A1068;
A17 A1069;
};
extern "
97D44I20"1065 *A1070;
extern "
52D40I53"1065 A1071[];
extern A67 A1072[];
extern Void A6209()"
53D12I85"
{
A79 A547;
A79 A548;
A79 A549;
A79 A6232;
A79 A5661;
A87 A6233;
A87 A5662;
A23 A552"
23D16I24"53 *A554, *A555, *A6234,"
21D1I12"63, *A557;
}"
11D29I14"93
{
A17 A8274"
34D35I21"98 A8275;
A8198 A8276"
50D44I10"8277[1];
}"
54D41I6"561
{
"
56D4I165"62;
struct A561 *A563;
A40 A564;
A40 A565;
A81 A566;
A58 A567;
A42 A568;
A68 A569;
struct A147 A570;
A17 A571;
A24 A572;
A61 A573;
A96 *A574;
struct A1537 * A7443;
}"
13D11I8"A81 A575"
20D9I17"struct A561 *A576"
28D1I1"7"
18D2I1"5"
22D2I2"79"
19D3I4"8278"
22D1I1"0"
20D1I1"1"
19D3I2"82"
22D9I1"3"
20D7I10"Void A5664"
18D19
27I65"4(), A585();
extern A4 A586();
extern A4 A5665();
extern Void A58"
1854I50"9136
{
struct A9136 *A9137; A17 A9138; };
struct A"
109D9I19"struct A9136 *A9139"
18D18
26D9I10"9136 A9140"
19D9I8"58 A7273"
18D4I3"A17"
9D3I1"4"
12D11I17"struct A588 A1719"
20D4I2"A2"
9D3I3"6[]"
20D2I2"77"
13D10I9"A89 A1978"
29D2I2"79"
19D4I4"1980"
21D4I4"7274"
24D1I1"1"
13D8I7"4 A9185"
19D18I8"A4 A9186"
35D4I4"5897"
24D1I1"2"
12D3I4"Void"
8D1I1"3"
12D10I9"A72 A1984"
21D10I18"struct A561 *A1985"
27D3I3"914"
23D2I2"86"
21D2I2"87"
13D27
33D26I4"9142"
37D10I9"A78 A1988"
27D4I4"1990"
21D4I4"1989"
21D4I4"1991"
15D8I10"Void A1992"
25D4I4"1993"
15I27"struct A144 *A7824; extern "
6D4I26"5553();
struct A147 *A7825"
23D2I2"26"
19D4I4"7827"
21D64I6"7828()"
73D8I10"Void A7829"
20D7I7"4 A7830"
18D9I12"Void A8412()"
18D9I12"Void A7831()"
18D9I12"Void A7832()"
18D19I12"Void A8413()"
28I14"Void A8414();
"
8D20I7"1457
{
"
26D12I4"58;
"
18D3I25"59;
A4 A1460;
A9 A1461;
}"
12D19I10"A9 A1461()"
28D18I10"A9 A1462()"
28D1I1"9"
6D1I1"3"
11D19I8"A4 A1464"
30D9I7"4 A1465"
19D20
28D11I10"83 **A5078"
21D9I18"struct A83 **A5079"
25D2I2"66"
13D9I7"4 A1467"
19D3I11"struct A144"
8D2I2"68"
12D11I18"struct A144 *A7476"
21D9I7"4 A1469"
19D10I19"struct A640 **A3651"
20D9I18"struct A640 **A365"
21D8I9"17 *A1470"
19D8I9"68 *A1471"
26D13I14"640 **A1472 ;
"
22D7I7"3 A1473"
18D11I7"4 A1474"
22D7I9"13 *A1475"
18D7I9"13 *A1476"
18D7I9"13 *A1477"
18D4I2"53"
9D2I2"78"
13D2I2"68"
7D2I2"79"
12D9I3"A17"
15D1I1"0"
12D1I2"57"
6D1I1"1"
11I19"A57 A3660 ;
extern "
17D3I4"5 ; "
11D10I8"57 A1482"
22D6I10"036 *A1483"
17D10I7"4 A1484"
20D18I8"A4 A8214"
29D8I7"4 A1485"
19D7I11"9036 *A1486"
18D7I9"81 *A1487"
17D8I16"const A81 *A1488"
19D7I7"6 A1489"
25D11I10"144 *A7276"
21D4I4"9036"
9D1I1"0"
11D17I8"A9 A1491"
27I21"A9036 A1492 ;
extern "
8D9I10"640 *A1493"
19D17I9"A63 A1494"
27D17I8"A4 A1495"
28D8I7"4 A1496"
22D4I4"5825"
18D4I5"1497 "
21D8I9"640 *A149"
19D12I12"A5794 A1499 "
21D12I18"struct A83 *A1500 "
21D10I18"struct A83 *A1501 "
19D13I18"struct A83 *A1502 "
22D10I18"struct A83 *A5080 "
20D9I9"53 A1503 "
18D12I9"A4 A1504 "
21D12I8"A4 A6247"
21I27"struct A83 *A6248 ;
extern "
6D4I4"9040"
23D2I2"05"
14D7I7"4 A1506"
18D10I11"A5794 A1507"
21D9I10"Void A7451"
20D10I8"A4 A7833"
22D8I7"4 A6249"
25D4I4"6250"
23D2I2"08"
13D8I10"Void A1509"
28D1I1"0"
12D4I2"A6"
9D1I1"1"
21D1I1"2"
12D10I9"A68 A1513"
21D7I9"Void A151"
20I203"81 A5692();
extern Void A8215();
extern Void A1515();
extern A4 A1516();
extern Void A1517();
extern Void A1518();
extern Void A1519();
extern Void A1520();
extern A4 A3738();
extern A4 A7834();
extern A"
561D1I1" "
11D1I1" "
11D1I1" "
10D1I1" "
10D1I1" "
10D1I1" "
848D4I4"9082"
15D19I10"Void A9083"
30D19I10"Void A9084"
30I21"Void A3863();
extern "
17D2I2"89"
13D10I19"struct A1537 *A1590"
21D10I19"struct A1537 *A1591"
27D2I2"71"
21D4I4"1592"
21D4I4"1593"
15D9I10"Void A7841"
29D1I1"2"
12D4I3"A74"
9D1I1"7"
18D4I4"7843"
21D4I4"8218"
15D9I10"Void A8219"
29D1I1"5"
13I1"7"
6D1I1"6"
12D3I4"Void"
8D1I1"7"
12D10I8"A4 A7848"
21D10I9"A74 A7849"
21D1I1"V"
8D24I4"94()"
33D9I4"void"
14D1I3"1()"
10D4I4"void"
9D9I17"2();
typedef A22*"
14I57"3;
extern const A51 A1524;
extern long A1525;
struct A152"
1445D10I8"A4 A9085"
27D4I4"3763"
15D9I10"Void A8835"
21D2I2"35"
7D1I3"4()"
10D11I3"A58"
16D1I1"5"
10D2I11"struct A147"
7D3I1"6"
12I19"A4 A3767();
extern "
2788D2I4"9070"
433D8I10"Void A9086"
19D9I9"A74 A9087"
28D1I1"6"
12D8I9"Void A737"
19D9I8"A4 A4551"
20D9I9"Void A738"
25D3I4"4724"
14D10I8"A58 A741"
29D1I2"77"
20D1I1"3"
18D4I3"744"
15I21"Void A8202();
extern "
1326D1I1" "
15D1I1" "
11D1I1" "
2390D2I4"9070"
215D2I4"9070"
12D1I2"72"
52D4I4"9088"
2322D3I6"size_t"
3799D2I9"(A77) 0x0"
66D2I9"(A77) 0x0"
2778I6"(A72) "
2212D2I4"9070"
72D2I9"(A77) 0x0"
2526D2I15"1826;
A81 A1827"
90D2I4"1827"
24D35I31"1827 ) return (A4) 0;
if( A1827"
40D1I1"8"
6D52I16"9070) 0x40000 ) "
61D1I13"4;
goto A1715"
7D24I11"4: A1826 = "
29D20I23" A2918 ); if( !A1826 ) "
28D53I9"A4) 0; if"
58D2I109"26->A128 & (A9070) 0x200000 ) return (A4) 1; 
A1715:
if( A4090 && ((A1257 <= 0) || A1827->A127 & (A27) 0x800)"
7D37I48"turn (A4) 0;
A4084 = A1827->A140.A134;
goto A171"
43D54I3"13:"
62D66I28"(A4) 0;
}
A81
A526(A1750)
A6"
71D37I117"50;
{
return ((A81) ((( A1388)->A173)->A988)[ A1750 ]);
}
A315
A527( A1859 )
register A70 A1859;
{register A315 A1731"
42D48I1"3"
53D32
39D53I19"1005( A1398 );
A173"
62D1I20" (A13) A1859;
return"
6D6I64"1;
}
Void
A3322(A1742)
A315 A1742;
{
A315 A4091;
A58 A2926;
A70 "
13D36I49" A1742->A303;
A2926 = A1742->A308;
A1711:if(A2926"
47D1I1"2"
12D1I1"3"
7D1I1"2"
8D18I92" = ( A7174 = (A2926), A7174 >= 0 ? (A315) A387[A7174] : (A865(1232), (A315) A387[1]) );
if( "
28D2I3"3 ="
7D9I82"38 &&
(A1738 == 29 || A1738 == 30 || A1738 == 31) ) goto A1714;
goto A1715;
A1714:"
19D2I25"14.A311 |= 1;
A4091->A306"
15D1I1"6"
13D1I1"5"
14D7I3"5;
"
17I31"4 = A1742->A304;
if( A4091->A30"
2127I4" = 0"
113I10"A4 A9209;
"
287I39"A9209 = !!(A9154 & (A17)1); A9154 = 0;
"
732D3I6"size_t"
935D3I6"size_t"
2698I24"if( A9209 )
goto A4100;
"
87D3I6"size_t"
4362D2I9"(A77) 0x0"
140I1"
"
13D1
189I1"
"
76I7", A9289"
25I12"A17 *A9289;
"
464D32I10"47:
*A9289"
41D2I6"0x01;
"
10I24"
A4103 = (A58) *--A4104;"
19D1I1"2"
30D8I9"8 |= (A17"
37D18I4"36:
"
24D1I40"= (A70) *--A4104; A439 = (A62) *--A4104;"
10D4I35"15;
case 27:
case 44:
if( !A1738 ) "
13I12"1;
goto A172"
3432D3I6"size_t"
93D3I6"size_t"
515D2I4"9070"
13D2I4"9070"
1357D3I6"size_t"
4365D28
35D1I2"!="
13D3I15") && ( A1948 & "
13D5I50") ) goto A2339;
goto A2340;
A2339:
if( ( A1948 == "
14D2I19"2 && ( A419.A350 & "
10D7I22"400 ) ) ||
( A1948 != "
17D71I28" && ( A419.A350 & A1948 ) ) "
81D2I2"41"
13D1I1"2"
6D33I11"41:
A865(29"
40I9"2: ;
A234"
29D2I1">"
8D1I1" "
10D3
10D3I21"40 &&
A419.A350 & ((("
11D7I3"08|"
15D3I7"10) | ("
12D5I2"2|"
13D7I6"04) | "
15D3I7"200 | ("
11I11"01|(A25) 0x"
21D26
38D1I1"3"
12D1I1"4"
7D1I1"3"
15D7I6"follow"
12D1I1"-"
13D1I1"4"
7I31"(A5106 > 0) && (A7271 <= 0) &&
"
9I3"((("
8D60I2"8|"
68D106I7"10) | ("
115D8I2"2|"
16D15I5"04) |"
26D12I4"0 | "
38I1")"
13D3I4") &&"
11D40I18"50 & (A25) 0x40
) "
49D1I1"5"
12D1I1"6"
7D12I32"5: A887( 963, "precedes", "+fqb""
20D1I1"6"
8D70I29"1948 & (A25) 0x02 & A419.A350"
82D1I1"7"
11D2I2"48"
8D24I39"7:
A419.A350 |= (A25) 0x400;
goto A2349"
29D44I22"48: A419.A350 |= A1948"
49D11I182"49:
A4109 |= A4070;
A4110 |= A4071;
switch( A1948 )
{
case (A25) 0x01:
case (A25) 0x40000:
A4109 |= (A25) 0x20;
A4110 |= (((A25) 0x01|(A25) 0x40000) | (A25) 0x200);
A419.A346 = A4072"
17D16I24"(A1309 > 0) && A701() )
"
25D1I1"1"
12D1I1"2"
7D32I14"1:A865( 1071 )"
38D21I81"2:
if( A2142 == (114 | 0x8000) && (A719 && (!A719->A1625 || A719->A1626 & 1) ) ) "
30D10I1"3"
21D1I1"4"
7D3I17"3:
A882(200,27);
"
16D3I21"5:if( A2142 == 110 ) "
11D2I205"56;
goto A2357;
A2356:
A2163();
if( A2142 == (96) ) goto A2358;
goto A2359;
A2358: A707(NULL,(A4) 0);
goto A2360;
A2359: A2163();
A2360: ;
goto A2355;
A2357: ;
goto A2361;
A2354: A2163();
A2361:
goto A2350"
80D3I6"size_t"
86D3I6"size_t"
61D2I2"50"
72D2I2"50"
9D2I2"50"
16D2I2"62"
39D2I2"63"
13D1I1"4"
6D2I2"63"
76D1I1"5"
7D1I1"4"
77D1I1"6"
12D1I1"7"
7D1I1"6"
21D1I1"8"
7D1I1"7"
33D1I1"9"
11D2I2"70"
8D1I1"9"
32D2I2"71"
7D2I2"70"
100D2I2"72"
12D2I2"73"
7D2I2"72"
64D1I1"4"
12D1I1"5"
7D1I1"4"
16D1I1"5"
14D1I1"6"
6D2I2"73"
20D1I1"6"
6D2I2"71"
8D1I1"8"
7D1I1"5"
6D2I2"62"
142D1I1"7"
12D1I1"8"
7D1I1"7"
65D1I1"9"
11D2I2"80"
8D1I1"9"
23D2I2"81"
7D2I2"80"
37D2I2"82"
12D2I2"83"
7D2I2"82"
20D2I2"83"
9D2I2"81"
10D1I1"8"
43D1I1"4"
12D1I1"5"
7D1I1"4"
60D1I1"6"
12D1I1"7"
7D1I1"6"
32D1I1"8"
12D1I1"9"
7D1I1"8"
22D2I2"90"
8D1I1"9"
33D2I2"91"
12D2I2"92"
7D2I2"91"
21D2I2"93"
7D2I2"92"
17D2I2"93"
9D2I2"90"
10D1I1"7"
37D1I1"4"
12D1I1"5"
7D1I1"4"
32D1I1"6"
12D1I1"7"
7D1I1"6"
23D1I1"8"
7D1I1"7"
34D1I1"9"
28D3I3"400"
12D10I10"401;
A2400"
28D10I10"402;
A2401"
24D3I3"402"
11D1I1"9"
9D1I1"8"
9D1I1"5"
45D3I3"403"
14D8I8"4;
A2403"
24D1I1"4"
60D1I1"5"
12D1I1"6"
7D1I1"5"
34D1I1"7"
12D1I1"8"
7D1I1"7"
110D1I1"9"
11D2I2"10"
8D1I1"9"
18D2I2"10"
14D2I2"11"
8D1I1"8"
43D2I2"12"
12D2I2"13"
7D2I2"12"
25D1I1"4"
6D2I2"13"
45D1I1"5"
12D1I1"6"
7D1I1"5"
24D1I1"7"
7D1I1"6"
17D1I1"7"
9D1I1"4"
8D2I2"11"
10D1I1"6"
60D1I1"8"
12D1I1"9"
7D1I1"8"
33D2I2"20"
12D2I2"21"
7D2I2"20"
24D2I2"22"
7D2I2"21"
45D2I2"23"
13D1I1"4"
6D2I2"23"
23D1I1"5"
7D1I1"4"
17D1I1"5"
8D2I2"22"
10D1I1"9"
26D1I1"5"
38D1I1"6"
12D1I1"7"
7D1I1"6"
65D1I1"7"
3882D2I4"9070"
254D2I4"9070"
Fa18.c
209D4I7"7 A9235"
18D2I1"9"
12I16"A6 A10;
typedef "
291D20
27D4I8"32 A9069"
14I19"A9069 A24;
typedef "
10D4I2"25"
14D9I13"unsigned A890"
21D6I10"9069 A9150"
17D6I10"9069 A9070"
17D8I8"9070 A27"
18D12I9"A9070 A28"
22I21"A9070 A5793;
typedef "
10D4I2"29"
14D17
26D8I5"A6228"
19D6I8"9070 A30"
25D3I8"long A31"
13I17"A17 A32;
typedef "
11D1I1"3"
11D7I12"unsigned A34"
19D5I5"4 A35"
17D5I5"5 A36"
21D1I1"7"
17D1I1"8"
16D2I2"39"
18D1I1"0"
17D1I1"1"
17D1I1"2"
12D6I6"34 A43"
22D1I1"4"
17D1I1"5"
11D7I7"A42 A46"
17I17"int A47;
typedef "
342D2I4"9236"
17D4I2"63"
19D1I3"577"
18D1I1"4"
16D4I2"65"
20D2I2"19"
18D4I4"8258"
14I19"A54 A7616;
typedef "
138D6I3"A16"
60D13I3"A72"
122D6I5"A9069"
20D6I5"A9069"
1187D2I4"9070"
28D2I4"9070"
151I19"struct A114 A9153;
"
1389D2I2"92"
16D6I12"5794 A7637()"
15I16"A4 A202;
extern "
2757D2I4"9070"
1940D8I19"struct A640 * A9310"
24D4I3"663"
15D10I9"A48 A7505"
29D2I2"37"
19D3I4"7176"
14D7I9"Void A664"
22D4I3"665"
16D8I7"4 A4442"
19D6I6"A17 A5"
27D3I2"66"
21D2I3"031"
21D1I1"7"
20D1I1"8"
12I20"Void A669();
extern "
278D3I4"4476"
14D10I17"struct A640 *A675"
27D4I4"7719"
21I21"8914();
extern Void A"
754D9I7"4 A9176"
21D7I9"5794 A868"
19D6I6"7 A598"
25D1I1"0"
19D1I1"1"
13D10I7"61 A872"
22D7I10"5794 A6037"
19D10I7"61 A873"
22D7I10"5794 A8589"
20D5I6"8 A874"
16D9I7"A4 A875"
28D1I1"6"
20D1I1"7"
20D1I1"8"
19D2I2"79"
19D4I3"880"
21D4I4"6172"
21D3I4"9293"
20D4I4"9177"
21D4I4"8787"
23D1I1"1"
20D1I2"29"
18D4I4"7262"
23D1I1"2"
20D1I1"3"
20D2I2"48"
21D1I1"4"
20D1I1"5"
18D3I4"5667"
22D1I1"6"
19D2I2"87"
20D2I2"88"
20D2I2"89"
19D4I3"890"
21D4I3"891"
21D4I3"892"
21D4I4"7745"
24D1I1"6"
21D1I1"7"
20I1"4"
18D3I4"7748"
20D4I4"7749"
21D4I3"893"
23D1I1"4"
18D4I4"1857"
22D3I3"958"
22D1I1"5"
19D3I3"061"
20D3I4"5821"
20D4I3"896"
21D3I4"7507"
20D4I3"897"
21D4I4"5981"
23D1I1"8"
19D3I3"750"
20D3I4"8212"
20D3I3"899"
20D3I4"7177"
22D1I1"0"
18D4I3"901"
23D1I1"2"
20D1I1"3"
18D3I4"8944"
22D1I1"4"
18D4I3"905"
21D3I3"907"
21D4I4"9078"
23D1I1"7"
18D3I4"5077"
20D3I4"8267"
20D3I4"8830"
14D7I9"Void A908"
25D2I2"09"
13D9I9"Void A910"
28D1I1"1"
12D9I7"A4 A912"
20D16
24D1I1"3"
14D8I7"4 A5431"
19D11I9"Void A914"
22D10I9"Void A915"
22D11I6"7 A916"
27D2I2"17"
13D9I10"A5794 A918"
27D3I4"1739"
15D6I9"5794 A919"
24D4I3"920"
15D9I9"Void A921"
26D4I3"922"
15D20I14"A5794 A923();
"
31D4I3"924"
16D7I10"5794 A7263"
19D8I8"61 A5668"
19D7I12"Void A5669()"
16D18
26D13I12"7734 A7751; "
21D7I7"4 A7752"
18D18I10"A4 A5914()"
28D6I10"861 A926()"
16D8I6"4 A927"
18D6I8"4 A928()"
15D9I19"struct A849 *A929()"
19D6I9"61 A930()"
16D8I12"9236 A9245()"
18D6I12"9236 A9246()"
15D9I12"Void A9247()"
18D7I18"struct A144 *A5050"
17D8I6"7 A931"
18D6I8"61 *A932"
16D8I6"7 A933"
21D7I7"*A934;
"
14D18I7"A7 A935"
28D7I8"61 *A936"
16D18I7"A7 A937"
27D18I9"A61 *A938"
27D18I7"A7 A939"
28D9I8"61 *A940"
19D9I6"7 A941"
19D9I8"61 *A942"
19D12I10"61 A6038; "
19D11I18"struct A144 *A1696"
23D8I5" A943"
18D10I7"7 A9294"
19D11I18"struct A144 *A7178"
20D17
26D7I8"44 *A717"
17D7I18"struct A144 *A5432"
17D6I9"5794 A944"
15D17I10"A5794 A945"
26D20I12"A5794 A946;
"
27D4I5"A5794"
9D3I1"4"
19D6I4"7180"
15D12I11"A5794 A7227"
21D14I57"A5794 A7181;
extern A5794 A5510;
extern A68 A948;
extern "
22D18I35"114 *A949;
extern A7 A950;
extern A"
23D6I10"1;
extern "
15D16I2"14"
21D36I10"2;
extern "
44D95I12"144 *A7265; "
102D7I12"Void A7266()"
17D6I12"5794 A1689()"
15D8I12"Void A7753()"
17I14"Void A7754();
"
9D17I28"53
{
A48 A954;
A34 A955;
};
"
25D18I6"196
{
"
27D57I43"53 *A956;
A72 A957;
A72 A958;
A17 A959;
};
"
65D12I135"960
{
A22 A961;
A22 A962;
};
struct A963
{
struct A960 *A964;
A72 A965;
A72 A966;
A17 A967;
};
struct A9073
{
A48 A9074;
A9069 A9075;
}"
21D11I7"A4 A968"
20D12I7"A9 A969"
22D9I7"7 A970 "
18D12I19"struct A963 A7721; "
19D12I19"struct A963 A7722; "
19D11I17"struct A963 A7723"
20D9I9"Void A971"
20D9I9"Void A972"
20D8I18"struct A196 *A2020"
19D8I9"Void A973"
19D10I10"Void A2078"
23D6I6"8 A974"
17D9I8"A48 A975"
21D7I7"48 A976"
19D8I8"48 A6237"
20D8I8"48 A8827"
20D8I8"48 A6238"
19D9I8"A48 A979"
21D7I7"92 A980"
19D8I9"5794 A981"
20D9I8"48 A9076"
20D12I8"A42 A982"
23D12I9"long A983"
23D29
34D8I36"984();
extern A87 A6039();
extern A6"
14D52I20"4();
extern A92 A726"
57D27I29"extern long A985();
extern A3"
32D34I3"6()"
44D8I10"34 A5670()"
17D17I12"A5794 A987()"
26D7I12"Void *memcpy"
18D9I12"Void *memset"
20D100I14"int memcmp();
"
108D21I33"7725
{
A87 A7726; A81 A7727; };
v"
26D3I40"7728();
struct A7725 *A7729();
void A773"
8I68"struct A144
{
A49 *A988;
A54 A989;
A54 A990;
A54 A991;
A41 A992;
};
"
7D12I9"A54 A2090"
21D10I17"struct A144 *A993"
19D10I7"A6 A994"
21D10I9"A87 A6239"
26D4I3"996"
16D8I9"9036 A997"
24D4I4"7731"
15D9I10"Void A7732"
20D10I8"A54 A998"
21D8I17"struct A144 *A999"
19D7I9"Void A100"
19D8I10"Void A1001"
20D1
6D2I4"02()"
11D18
24D4I4"1003"
23D2I2"04"
13D10I9"A49 A1005"
21D10I9"A49 A1006"
21D10I9"A54 A1007"
21D10I9"A49 A1008"
29D2I2"09"
13D10I8"A4 A2104"
21D4I2"A4"
9D1I1"0"
12D10I8"A4 A8705"
21D12I9"A54 A1011"
21I18"A49 A1012;
extern "
6D4I4"8736"
23D2I2"13"
7I231"xtern Void A7733();
extern Void A1014();
extern Void A5056();
extern Void A1015();
extern Void A1016();
extern Void A1017();
extern Void A1018();
extern Void A1019();
extern Void A5246();
extern Void A1020();
extern Void A1021();
e"
45I7"9129,
A"
44D4I4"9156"
11I42"9157,
A9158,
A9159,
A9160,
A9161,
A8639,
A"
21D10I2"91"
15D2I2"91"
7I29"9164,
A6176, 
A7062,
A7063,
A"
91I21"9240,
A9241,
A9130,
A"
21I28"9165,
A9166,
A9167,
A9168,
A"
28I14"9292,
A9169,
A"
92I42"9242,
A9243,
A9131,
A9132,
A9133,
A9134,
A"
71I7"9170,
A"
307D4I4"9171"
21D4I4"9244"
15D8I12"Void A8266()"
17D9I12"Void A8588()"
18D9I12"Void A9172()"
18D18I10"A4 A9173()"
31D4I6"9174()"
13D8I12"Void A9175()"
18D1I1"6"
6D3I1"2"
13D10I8"81 A5511"
19D12I9"A81 A8770"
21I27"struct A561 *A1023;
extern "
7D3I1"4"
12D4I2"A7"
9D3I1"5"
12D18I8"A4 A1026"
30D8I8"49 A1027"
19D9I10"Void A7755"
20D10I8"A4 A1028"
27D15I8"1029();
"
21D3I30"9079();
A48 A9080();
Void A908"
15D20
37D1I1"0"
12D18I9"A17 A1031"
30D4I2"79"
9D1I1"2"
18D4I4"5671"
24D1I1"2"
18D4I4"8401"
15D10I9"A17 A5512"
38D1I1"3"
12D8I10"Void A9135"
36D1I1"4"
12D10I11"A5794 A1035"
21D8I10"Void A2317"
19D9I10"Void A5673"
20D9I10"Void A1036"
26D4I4"1037"
15D9I18"struct A561 *A1038"
21D8I7"4 A5674"
19D8I18"struct A561 *A1039"
19D47I10"Void A7182"
59D8I7"4 A7183"
20D8I8"58 A8268"
27D1I1"0"
12D11I10"Void A7756"
22D10I9"A81 A1041"
22D8I8"81 A7508"
20D10I7"4 A7757"
21I15"A5794 A8590();
"
8D10I26"7758 *A7759();
A40 A7760()"
19D10I9"A78 A1042"
22D8I8"78 A5271"
20D22I8"78 A1043"
33D10I11"A5972 A1044"
21D32I8"Void A22"
38D65
73D7I8"54 A5433"
19D7I10"9036 A9039"
26D26I85"144 *A5434;
extern A9150 A9178();
extern Void A7761();
extern A48 A7906();
extern A49"
31D5I57"0();
Void A1671();
extern Void A1672();
extern A73 A1673 "
22D18I7"8 A1674"
36D14I96"NT
Void A5826();
Void A5827();
#endif
#if OS_POSIX
extern A4 A7290();
extern A7 A7291();
extern "
22D11I53"7257 *
A7292();
#endif
A73 A1673 = 0;
#if OS_DOSCO
A4"
16D6I59"6();
A4 A4117();
#endif
#if os_DOS | os_DOSX
struct A4118
{"
15I16"19[21];
char A41"
2266I7"((A72) "
13I1")"
2008I7"((A72) "
14I1")"
140I7"((A72) "
13I1")"
866I13"(int) ((A72) "
15I1")"
4803I10" (size_t) "
6I10" (size_t) "
5I1" "
Fa19.c
209D4I7"7 A9235"
18D2I1"9"
12I16"A6 A10;
typedef "
291D20
27D4I8"32 A9069"
14I19"A9069 A24;
typedef "
10D4I2"25"
14D9I13"unsigned A890"
21D6I10"9069 A9150"
17D6I10"9069 A9070"
17D8I8"9070 A27"
18D12I9"A9070 A28"
22I21"A9070 A5793;
typedef "
10D4I2"29"
14D17
26D8I5"A6228"
19D6I8"9070 A30"
25D3I8"long A31"
13I17"A17 A32;
typedef "
11D1I1"3"
11D7I12"unsigned A34"
19D5I5"4 A35"
17D5I5"5 A36"
21D1I1"7"
17D1I1"8"
16D2I2"39"
18D1I1"0"
17D1I1"1"
17D1I1"2"
12D6I6"34 A43"
22D1I1"4"
17D1I1"5"
11D7I7"A42 A46"
17I17"int A47;
typedef "
342D2I4"9236"
17D4I2"63"
19D1I3"577"
18D1I1"4"
16D4I2"65"
20D2I2"19"
18D4I4"8258"
14I19"A54 A7616;
typedef "
138D6I3"A16"
60D13I3"A72"
122D6I5"A9069"
20D6I5"A9069"
1373I69"struct A9304
{
A17 A9305;
A5794 A9306;
};
extern struct A9304 A9307;
"
6D4I4"9308"
14D4I4"9309"
17D1I1"5"
11D4I4"5566"
14D4I4"5567"
14D3I17"7618();
Void A761"
8D13
19D3I17"5569();
Void A915"
8D9I10"Void A9152"
14D17I2"74"
22D1I15"0();
Void A7621"
10I41"6226();
A5794 A6227();
A81 A7622();
A58 A"
460D2I4"9070"
28D2I4"9070"
151I19"struct A114 A9153;
"
1389D2I2"92"
16D6I12"5794 A7637()"
15I16"A4 A202;
extern "
3337D2I4"9070"
159I11"A58 A9238; "
88D2I4"9070"
39D2I4"9070"
367I11"A17 A9071;
"
535I13"A9236 A9239;
"
1098D2I4"9070"
380D7I8"17 A9154"
24D1I1"1"
12D6I7"62 A442"
16I17"A4 A443 ;
extern "
150D3I4"9072"
14D10I9"Void A451"
22D9I9"5794 A452"
21D9I9"9036 A453"
29D1I1"4"
13D12
20D1I1"5"
12D9I22"A315 A456 ;
A5794 A457"
28D1I1"8"
18D4I3"459"
21D3I4"5268"
14D16
24D1I1"0"
12I16"A4 A461;
extern "
8D1I1"2"
12D8I11"Void A463()"
22D4I3"464"
13I18"A58 A8823;
extern "
1037D7I10"Void A9155"
18D9I7"A4 A504"
20I20"Void A505();
extern "
1042D2I4"9070"
1940D8I19"struct A640 * A9310"
24D4I3"663"
15D10I9"A48 A7505"
29D2I2"37"
19D3I4"7176"
14D7I9"Void A664"
22D4I3"665"
16D8I7"4 A4442"
19D6I6"A17 A5"
27D3I2"66"
21D2I3"031"
21D1I1"7"
20D1I1"8"
12I20"Void A669();
extern "
278D3I4"4476"
14D10I17"struct A640 *A675"
27D4I4"7719"
21D4I4"8914"
15D8I12"Void A7720()"
18D7I7"17 A933"
18D8I7"7 A5254"
18D2I2"81"
7D1I1"0"
11D2I2"17"
7D1I1"1"
11D1I2"35"
6D1I1"2"
11D1I2"92"
6D1I1"3"
11D2I1"7"
7D1I1"4"
11D8I7"4 A2145"
18D1I2"68"
6D1I1"6"
13D14I6"*A2147"
24D8I7"4 A2148"
18D7I16"2 A2149[M_TOKEN]"
17D2I2"87"
7D1I1"0"
11D2I1"4"
7D1I1"1"
15D4I4"2152"
14D2I2"36"
7D1I1"3"
11D27I7"35 A826"
38D1I2"17"
6D3I1"4"
13D10I28"7
A2155,
A2156,
A2157,
A6214"
19D4I2"A9"
9D1I1"8"
12D10I9"A17 A8825"
27D3I3"215"
15D3I4"Void"
8D1I1"0"
18D4I4"8209"
23D1I1"1"
12D3I4"Void"
8D1I1"2"
12D10I9"A35 A2163"
29D1I1"4"
12D5I4"Void"
10D1I1"0"
12D9I8"A35 A216"
22D7I10"9036 A8211"
24D4I4"5255"
15D4I2"A4"
9D11I16"6();
extern Void"
16I37"7();
extern Void A2168();
struct A216"
465I42"struct A9073
{
A48 A9074;
A9069 A9075;
};
"
422D6I7"8 A9076"
17D9I8"A42 A982"
20D8I9"long A983"
24D4I3"984"
16D8I8"87 A6039"
20D8I8"61 A7724"
19D9I9"A92 A7260"
20D8I9"long A985"
24D4I3"986"
16D9I8"34 A5670"
20I21"A5794 A987();
extern "
1045I7"9129,
A"
44D4I4"9156"
11I42"9157,
A9158,
A9159,
A9160,
A9161,
A8639,
A"
21D10I2"91"
15D2I2"91"
7I29"9164,
A6176, 
A7062,
A7063,
A"
91I21"9240,
A9241,
A9130,
A"
21I28"9165,
A9166,
A9167,
A9168,
A"
28I14"9292,
A9169,
A"
92I42"9242,
A9243,
A9131,
A9132,
A9133,
A9134,
A"
71I7"9170,
A"
307D4I4"9171"
21I42"9244();
extern Void A8266();
extern Void A"
8I80"extern Void A9172();
extern A4 A9173();
extern A4 A9174();
extern Void A9175();
"
746D9I7"4 A9176"
21D7I9"5794 A868"
19D6I6"7 A598"
25D1I1"0"
19D1I1"1"
13D10I7"61 A872"
22D7I10"5794 A6037"
19D10I7"61 A873"
22D7I10"5794 A8589"
20D5I6"8 A874"
16D9I7"A4 A875"
28D1I1"6"
20D1I1"7"
20D1I1"8"
19D2I2"79"
19D4I3"880"
21D4I4"6172"
21D3I4"9293"
20D4I4"9177"
21D4I4"8787"
23D1I1"1"
20D1I2"29"
18D4I4"7262"
23D1I1"2"
20D1I1"3"
20D2I2"48"
21D1I1"4"
20D1I1"5"
18D3I4"5667"
22D1I1"6"
19D2I2"87"
20D2I2"88"
20D2I2"89"
19D4I3"890"
21D4I3"891"
21D4I3"892"
21D4I4"7745"
24D1I1"6"
21D1I1"7"
20I1"4"
18D3I4"7748"
20D4I4"7749"
21D4I3"893"
23D1I1"4"
18D4I4"1857"
22D3I3"958"
22D1I1"5"
19D3I3"061"
20D3I4"5821"
20D4I3"896"
21D3I4"7507"
20D4I3"897"
21D4I4"5981"
23D1I1"8"
19D3I3"750"
20D3I4"8212"
20D3I3"899"
20D3I4"7177"
22D1I1"0"
18D4I3"901"
23D1I1"2"
20D1I1"3"
18D3I4"8944"
22D1I1"4"
18D4I3"905"
21D3I3"907"
21D4I4"9078"
23D1I1"7"
18D3I4"5077"
20D3I4"8267"
20D3I4"8830"
14D7I9"Void A908"
25D2I2"09"
13D9I9"Void A910"
28D1I1"1"
12D9I7"A4 A912"
20D16
24D1I1"3"
14D8I7"4 A5431"
19D11I9"Void A914"
22D10I9"Void A915"
22D11I6"7 A916"
27D2I2"17"
13D9I10"A5794 A918"
27D3I4"1739"
15D6I9"5794 A919"
24D4I3"920"
15D9I9"Void A921"
26D4I3"922"
15D20I14"A5794 A923();
"
31D4I3"924"
16D7I10"5794 A7263"
19D8I8"61 A5668"
19D7I12"Void A5669()"
16D18
26D13I12"7734 A7751; "
21D7I7"4 A7752"
18D18I10"A4 A5914()"
28D6I10"861 A926()"
16D8I6"4 A927"
18D6I8"4 A928()"
15D9I19"struct A849 *A929()"
19D6I9"61 A930()"
16D8I12"9236 A9245()"
18D6I12"9236 A9246()"
15D9I12"Void A9247()"
18D7I18"struct A144 *A5050"
17D8I6"7 A931"
18D6I8"61 *A932"
16D8I6"7 A933"
21D7I7"*A934;
"
14D18I7"A7 A935"
28D7I8"61 *A936"
16D18I7"A7 A937"
27D18I9"A61 *A938"
27D18I7"A7 A939"
28D9I8"61 *A940"
19D9I6"7 A941"
19D9I8"61 *A942"
19D12I10"61 A6038; "
19D11I18"struct A144 *A1696"
23D8I5" A943"
18D10I7"7 A9294"
19D11I18"struct A144 *A7178"
20D17
26D7I8"44 *A717"
17D7I18"struct A144 *A5432"
17D6I9"5794 A944"
15D17I10"A5794 A945"
26D20I12"A5794 A946;
"
27D4I5"A5794"
9D3I1"4"
19D6I4"7180"
15D12I11"A5794 A7227"
21D12I11"A5794 A7181"
22D7I10"5794 A5510"
17D8I7"68 A948"
17D18
26D10I9"114 *A949"
20D7I6"7 A950"
17D7I6"4 A951"
16D10I17"struct A114 *A952"
19D13I20"struct A144 *A7265; "
27D3I3"266"
15D7I10"5794 A1689"
24D4I4"7753"
15D18I10"Void A7754"
30D10I7"6 A1022"
20D10I8"81 A5511"
19D12I9"A81 A8770"
21D12I18"struct A561 *A1023"
21D12I8"A4 A1024"
22D10I7"7 A1025"
19D18I8"A4 A1026"
29D18I9"A49 A1027"
29D10I9"Void A775"
22D10I8"A4 A1028"
27D15I8"1029();
"
21D4I31"9079();
A48 A9080();
Void A9081"
15D21
38D1I1"0"
13D7I8"17 A1031"
18D18I9"A79 A1032"
35D4I4"5671"
15D8I10"Void A5672"
19D9I10"Void A8401"
21D8I8"17 A5512"
19D10I18"struct A561 *A1033"
21D9I10"Void A9135"
20D9I18"struct A561 *A1034"
21D7I10"5794 A1035"
18D47I10"Void A2317"
58D9I10"Void A5673"
20D9I10"Void A1036"
20D9I10"Void A1037"
20D11I18"struct A561 *A1038"
22D8I6"A4 A56"
21D9I18"struct A561 *A1039"
20D11I10"Void A7182"
22D18I10"A4 A7183()"
27D10I9"A58 A8268"
22D7I28"78 A1040();
extern Void A775"
12D6I49"extern A81 A1041();
extern A81 A7508();
extern A4"
11D3I49"7();
extern A5794 A8590();
struct A7758 *A7759();"
12D51I3"0()"
60D18I11"A78 A1042()"
28D8I10"78 A5271()"
18D8I10"78 A1043()"
18D8I12"5972 A1044()"
17D9I12"Void A2274()"
18D17I42"A54 A5433();
extern A9036 A9039();
extern "
26D106I9"44 *A5434"
116D7I12"9150 A9178()"
16D13I32"Void A7761();
extern A48 A7906()"
23D31I63"7758
{
A40 A7762;
A87 A7763, A7764;
A17 A7765, A7766;
A67 A7767"
43D21
29D11I10"7758 A7768"
20D79I9"A87 A7769"
88D12I9"A87 A7770"
21D12I9"A88 A7771"
21D12I9"A10 A7772"
21D43I17"const A88 A7773;
"
52D19I43"045
{
A18 A1046;
A72 A1047;
A7470 A1048;
A3"
24D2I58"49;
};
struct A1050
{
A18 A1051;
A17 A1052;
A5794 A1053;
}"
12D7I7"7 A3140"
17D34I14"81 A3143[20];
"
43D9I33"054
{
A54 A1055;
A55 A1056[25];
}"
19D8I9"55 *A3164"
19D11I19"struct A1054 *A7509"
20D78
86D209I12"144 *A7774;
"
217D10I51"7500
{
struct A7500 *A7775; A54 A7510; A42 A7511; }"
19D9I12"Void A1057()"
18D8I12"Void A1058()"
17D9I10"Void A1059"
20D8I10"Void A1060"
19D10I11"A5794 A1061"
21D22I18"struct A118 *A1062"
33D13I8" A1063;
"
20D13I8"A4 A7267"
26D4I4"7776"
14D10I8"63 A7777"
19D21
29D3I3"114"
8D2I2"64"
11I40"A81 A7512();
extern A49 A1073();
extern "
8D2I66"74();
extern A72 A1075[];
extern A9036 A1076();
extern A9036 A7778"
14D94I118"3097
{
A70 A3098; A72 A3099; A7468 A3100; A7468 A3101; A72 A3102; A72 A3103; A72 A3104; A7 A3105; A4 A3106; A7 A5282; "
100D5I85"283; A32 A5284; A74 A5966; A17 A6270; };
extern A81 A3107;
extern A315 A3108;
extern "
13D55I62"3097 A3109;
extern A58 A3110;
extern A4 A6067;
extern A72 A311"
60D10I14"extern A6 A311"
15D45
52D11I14"Void A1077();
"
19D7I21"48 strcat(), strcpy()"
17D9I14"48 strncpy(); "
16D11I13"int strncmp()"
24D4I4"1078"
15D8I7"2 A7268"
27D2I2"79"
13D12I18"struct A553 *A1080"
21I17"A7 A9295;
extern "
6D67I3"108"
72I66"struct A553
{
struct A553 *A1082;
A7 A1083;
struct A114 A1084;
};
"
15D81I1"8"
86D75I59"struct A5513
{
A81 A5514;
struct A147 *A5515;
};
A5972 A777"
80D39I10"A5972 A778"
44D17I10"A5972 A778"
22D16I10"A5972 A778"
21D16I10"A5972 A778"
21D16I10"A5972 A778"
21I15"A5972 A7785();
"
7D14I11"A74 A6242; "
21D12I8"A7 A1086"
21D12I8"A7 A7184"
21D12I11"A5794 A5248"
25D6I4"7185"
15D10I10"A95 *A1087"
27D4I4"1088"
21D4I4"1089"
21D4I4"7186"
21D3I3"109"
21D4I4"7187"
15D10I11"A5794 A1091"
21D9I10"Void A1092"
27D3I3"093"
20D4I4"8269"
20D3I3"094"
14D10I8"A4 A1095"
21D10I8"A4 A1096"
28D3I3"097"
20D4I4"1098"
16D10I7"4 A1099"
21D10I11"A94 * A5272"
21D9I10"A94 * A110"
21D10I11"A94 * A1101"
29D2I2"02"
19D4I4"1103"
15D11I10"Void A1104"
30D2I2"05"
21D2I2"06"
19D4I4"5675"
21D4I4"6243"
15D10I8"A4 A5518"
27D4I4"7786"
21D4I4"5516"
21D4I4"5517"
21D4I4"5519"
22D3I3"520"
14D18I12"Void A5521()"
27D17
23D4I4"5522"
15D10I9"A23 A7787"
21D8I10"Void A1107"
19D10I10"Void A1108"
22D10I7"4 A1109"
21D11I10"Void A1110"
22D11I10"Void A1111"
22D11I10"Void A1112"
22I21"Void A2942();
extern "
7D4I4"1113"
15D55I12"Void A2949()"
64D13I12"Void A7070()"
22D9I12"Void A1114()"
18D10I12"Void A1115()"
19D9I12"Void A7269()"
19D8I12"94 * A1116()"
17D9I12"Void A1117()"
18D18I12"Void A1118()"
27D18I12"Void A1119()"
27D26I12"Void A7788()"
35D8I12"Void A5676()"
17D18
26D2I2"20"
21D2I2"21"
21D2I2"22"
13D9I10"Void A8270"
26D4I4"5249"
15D10I18"struct A144 *A5523"
19I17"A7 A5822;
extern "
6D4I4"7789"
21D4I4"7790"
19D4I4"7791"
22D7I10"5794 A7794"