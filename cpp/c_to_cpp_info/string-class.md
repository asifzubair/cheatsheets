
An Overview of the C++ String Class
Steve Jacobson
Version 0.2


Introduction:
-------------

The C++ string class was standardized in 1997-1998.  Books written prior
to that time (and some written after) frequently contain a non-standard
"string class" written as examples.  Many books contain documentation
of "C-style" or "classic" char * based strings.  A book must be examined
carefully to determine if it describes the standard C++ string class at all.

The string class is based on the basic_string template class.  You don't
need to know what that means to understand the string class or use it
successfully.  It's helpful to remember that string class documentation
can be found under basic_string in various places, including the SGI
STL web page.
 
The C++ string class does much the same thing as Eric Roberts' string
typedef and strlib.h library.  The data representation is hidden from
the user and useful string manipulation functions are provided.

It's unclear whether we would want to use the C++ string class in our
dialect of C++, though it appears that we could do so with a minimum of
pain and disruption.  This monograph attempts to demonstrate that a
powerful, standard C++ class exists, and is available as a resource.

The first code example demonstrates many of the capabilities of the string
class.  The second example is a quick port of the 106 strlib library to
the C++ string class.


Overview:
---------

The C++ string class is complicated; only a subset of the possible
functionality is described here.  A number of variants exist for each
function, especially the constructors.  Consult the resources at the end
of this monograph, particularly the web sites, for more details.

A number of the string functions consider a substring of a string.  If a
start value is given, the substring extends from position <start>, inclusive,
to the end of the string.  If a start and a length are given, the substring
begins at <start> and extends for <length> characters.

Many of the functions are member functions, of the form str1.function(str2).
Others are global functions, such as str1 == str2.  The type of function is
a minor point, since they all work as expected, but understanding the
terminology may help clarify the syntax of the call.

The C++ string header file must be included when using the C++ string class.
Note the absence of a .h suffix in modern C++ include statements.
```cpp
#include <string>
```
C++ declarations may use either of the following style of initializers.
Knowing this may make the plethora of string class constructors seem a
bit more regular.
```cpp
    int i(10);
    int i = 10;
```
There is an additional difference between the string class and C-style
strings:  The string class may contain the NUL character ('\0') within
a string, and C-style strings may not.  When a NUL-containing string is
converted to a C-style string, the NUL will terminate the latter.  This
is demonstrated in the first example code.


A Quick Word About C++ Standard Output:
---------------------------------------

C++ can use the facilities defined in stdio.h, such as printf.  But,
in some cases, it's quicker to use the iostream.h facility.  The C++
standard output is easier to use for output with minimal formatting.
When outputting a variable or a class, the compiler automatically
determines the type so you don't have to worry about it.  The following
example code uses both C++ and C output.

To include the C stdio facility, the following syntax is used in modern
C++ compilers.  Use <stdio.h> instead for older compilers.
```
#include <cstdio>
```
To include the C++ stdio facility:
```
#include <iostream>
```
C++ standard output uses cout instead of printf.  The symbol << can be
thought of as directing information to be printed into cout.  It is 
customary to output endl instead of "\n" to generate a newline.  To
output integer i, the following would work:
```
    cout << i << endl;
```
To output integers i and j, with descriptive text:
```
    cout << "i = " << i << "j = " << j << endl;
```
To output string s, with additional text:
```
    cout << "s = " << s << endl;
```
Note that no format specifiers need to be given, as long as the default
formatting is considered acceptable.  Type detection is automatic.


First Example:
--------------
```cpp
//
// File str-ex4.cc
//

#include <cstdio>
#include <iostream>
#include <string>

int main ()
{
    // ------------------- string constructors ----------------

    string emp("");              // constructs the "empty string"
    string emp2;                 // constructs another "empty string"
    string spc(" ");             // constructs string containing " "
    string sstr("Some string");  // string containing "Some string"
    char frob[] = "Frobnitz";
    string sfrob(frob);          // constructs a C++ string containing
                                 //   "Frobnitz" from a C-style string
    string bar = "foobar";       // string containing "foobar"

    // ------------------- stdout, c_str() --------------------

    // c_str() extracts a C-style string from the string object
    printf("stdio:     sstr = \"%s\"\n", sstr.c_str());

    // cout figures out how to print string object sstr
    cout << "iostream:  sstr = \"" << sstr << "\"" << endl;

    // ----------------------- append() -----------------------

    string x = sstr;                // create copy of sstr
    x += spc;                       // appends spc to x
                                    //   (concatenates "Some string" and " ")
    x.append(bar);                  // appends "foobar" to "Some string "

    cout << "x = " << x << endl; // output x, containing the result

    //
    // Append to y a substring of <first parameter>, starting at position
    // <second parameter> for length <third parameter>
    //
    string y;                       // create empty string named y
    y.append(sstr, 7, 4);           // "ring"
    y.append(sstr, 4, 1);           // "ring "
    y.append(sstr, 2, 4);           // "ring me s"
    y.append(sstr, 1, 4);           // "ring me some "
    y.append(sstr, 6, 1);           // "ring me some t"
    y.append(sstr, 8, 1);           // "ring me some ti"
    y.append(sstr, 2, 2);           // "ring me some time"

    cout << "y = " << y << endl;    // output y, containing the result

    // ----------------------- substr() -----------------------

    //
    // Extract a substring from this object, starting at position
    // <first parameter> for length <second parameter>
    //
    cout << sfrob.substr(0, 1000) << endl;   // legal, extracts everything
                                             //   contained in sfrob
    // cout << sfrob.substr(-1, 2) << endl;  // illegal, causes abort
    cout << sfrob.substr(1, 3) << endl;      // "rob"
    cout << sfrob.substr(4, 4) << endl;      // "nitz"
    cout << sfrob.substr(3, 0) << endl;      // ""

    unsigned size = 6;
    cout << y.substr(10, size) << endl;      // "me tim"

    // -------------------------- [] --------------------------

    string t("ABwDE");
    char ch = t[1];                 // extract char 'B' from string t
    printf("t[1] = %c\n", ch);

    t[2] = 'C';                     // t now "ABCDE"
    cout << "t = " << t << endl;

    //
    // Expose a difference between the C class and C-style strings
    // '\0' is allowed as a character within a C++ string, but it
    // terminates a C-style string.
    //
    t[2] = '\0';                          // t now "AB'\0'DE"
    cout << "t = " << t << endl;          // prints as ABDE
    cout << "t = " << t.c_str() << endl;  // prints as AB

    // ---------------------- compare() -----------------------

    //
    // Perform a three way lexicographical comparison between this string
    // and another.  Similar to strcmp() in the C standard library.
    // returns negative value if this string comes before the other,
    // returns        0       if both strings are exactly equal
    // returns positive value if this string comes after the other,
    //
    string aa("abcd"), bb("abcd"), cc("abce"), dd("abcc");

    cout << "compare aa, bb " << aa.compare(bb) << endl;              // 0
    cout << "compare aa, cc " << aa.compare(cc) << endl;              // -1
    cout << "compare aa, dd " << aa.compare(dd) << endl;              // 1
    cout << "compare aa, \"abcde\" " << aa.compare("abcde") << endl;  // -1
    cout << "compare aa, \"abcde\" " << aa.compare("abcde") << endl;  // -1

    //
    // Compare a substring of g with string cc
    //
    string g = "dcbabcddcba";
    cout << "~ compare g, cc " << g.compare(bb, 3, 4) << endl;   // 0
    cout << "~ compare g, cc " << g.compare(cc, 3, 4) << endl;   // -1
    cout << "~ compare g, cc " << g.compare(dd, 3, 4) << endl;   // 1
    
    // ----------------- boolean comparisons ------------------

    //
    // Global comparison functions which return a bool
    //
    printf("aa == bb?  %s\n", (aa == bb) ? "TRUE" : "FALSE");    // TRUE
    printf("aa == cc?  %s\n", (aa == cc) ? "TRUE" : "FALSE");    // FALSE
    printf("aa == dd?  %s\n", (aa == dd) ? "TRUE" : "FALSE");    // FALSE

    printf("aa != bb?  %s\n", (aa != bb) ? "TRUE" : "FALSE");    // FALSE
    printf("aa != cc?  %s\n", (aa != cc) ? "TRUE" : "FALSE");    // TRUE
    printf("aa != dd?  %s\n", (aa != dd) ? "TRUE" : "FALSE");    // TRUE

    printf("aa < bb?  %s\n", (aa < bb) ? "TRUE" : "FALSE");      // FALSE
    printf("aa < cc?  %s\n", (aa < cc) ? "TRUE" : "FALSE");      // TRUE
    printf("aa < dd?  %s\n", (aa < dd) ? "TRUE" : "FALSE");      // FALSE

    printf("aa > bb?  %s\n", (aa > bb) ? "TRUE" : "FALSE");      // FALSE
    printf("aa > cc?  %s\n", (aa > cc) ? "TRUE" : "FALSE");      // FALSE
    printf("aa > dd?  %s\n", (aa > dd) ? "TRUE" : "FALSE");      // TRUE

    // ----------------------- find() -------------------------

    //
    // Attempt to find a character or another string within this string.
    // If found, return the position of the first match else string::npos.
    //
    string w = "pqrstuvwxyz";

    cout << "w = " << w << ", string::npos = " << string::npos << endl;

    cout << w.find('s') << endl;       // 3
    cout << w.find('a') << endl;       // 4294967295

    cout << w.find("uvw") << endl;     // 5
    cout << w.find("a") << endl;       // 4294967295
    cout << w.find("uvv") << endl;     // 4294967295

    string zzz("vwx");
    cout << "find \"vwx\" in string w:  " << w.find(zzz) << endl;      // 6

    //
    // Attempt to find a match as before, but don't start looking
    // until position <second argument> of this string
    //
    cout << "find \"uvw\" in w from 4:  "<< w.find("uvw", 4) << endl;  // 5
    cout << "find \"uvw\" in w from 5:  "<< w.find("uvw", 5) << endl;  // 5
    cout << "find \"uvw\" in w from 6:  "<< w.find("uvw", 6) << endl;  // npos

    //
    // Find as before, but only compare first <third argument> characters
    // of the other string
    //
    cout << "find \"uvwa\" in w from 4:  "<< w.find("uvwa", 4) << endl;// npos
    cout << "find first 3 of \"uvwa\" in w from 4:  "
         << w.find("uvwa", 4, 3) << endl;                              // 5

    // ----------------------- rfind() ------------------------

    //
    // Like find, but search backwards, starting at the end of the string
    // Other variants exist, as in find
    //
    string v = "abcdabcdabcd", ab = "abcd";
    cout << "v = " << v << endl;

    cout << "find \"abcd\" in v:  "<< v.find(ab) << endl;    // 5
    cout << "rfind \"abcd\" in v:  "<< v.rfind(ab) << endl;  // 5

    // ------------------- find_first_of() --------------------

    //
    // find the first character in this string that matches any
    // character in some other string.
    //
    string u = "jklmnopqrstuvwxyzAzyxwvu", p = "agxb";
    cout << "u = " << u << endl;

    cout << "find first of any char of " << p << " in u:  "
         << u.find_first_of(p) << endl;                      // 14
    cout << "find first of any char of \"dcbA25\" in u:  "
         << u.find_first_of("dcbA25") << endl;               // 17

    cout << "find first of any char in first 3 of \"dcbA25\" in u:  "
         << u.find_first_of("dcbA25", 0, 3) << endl;         // 4294967295
    cout << "find first of 'z' in u:  "
         << u.find_first_of('z') << endl;                    // 16
    cout << "find first of 'w', starting at 16 in u:  "
         << u.find_first_of('w', 16) << endl;                // 16

    // -------------------- find_last_of() --------------------

    //
    // find the last character in this string that matches any
    // character in some other string.  Other variants exist.
    //
    cout << "find last of any char of " << p << " in u:  "
         << u.find_last_of(p) << endl;                       // 14

    // ----------------- find_first_not_of() ------------------

    //
    // find the first character in this string that does not match
    // any character in some other string.  Variants exist.
    //
    cout << "find first of any char of u not in \"ponmlkj\":  "
         << u.find_first_not_of("ponmlkj") << endl;          // 7

    // ------------------ find_last_not_of() ------------------

    //
    // find the first character in this string that does not match
    // any character in some other string.  Variants exist.
    //
    cout << "find last of any char of u not in \"ponmlkj\":  "
         << u.find_last_not_of("ponmlkj") << endl;          // 7

    // ----------------------- insert() -----------------------

    //
    // insert some string into this string at the specified position.
    // Other variants exist.
    //
    cout << "y = " << y << endl;    // output y

    cout << y.insert(7, "tal bells") << endl;

    // ----------------------- replace() ----------------------

    //
    // replace part of this string with some string.
    // Many variants exist.
    //
    string rr = "C++ Sucks!";
    cout << "rr = " << rr << endl;

    cout << rr.replace(4, 2, "Ro") << endl;

    return(0);
}
```
```
Example output:

stdio:     sstr = "Some string"
iostream:  sstr = "Some string"
x = Some string foobar
y = ring me some time
Frobnitz
rob
nitz

me tim
t[1] = B
t = ABCDE
t = ABDE
t = AB
compare aa, bb 0
compare aa, cc -1
compare aa, dd 1
compare aa, "abcde" -1
compare aa, "abcde" -1
~ compare g, cc 0
~ compare g, cc -1
~ compare g, cc 1
aa == bb?  TRUE
aa == cc?  FALSE
aa == dd?  FALSE
aa != bb?  FALSE
aa != cc?  TRUE
aa != dd?  TRUE
aa < bb?  FALSE
aa < cc?  TRUE
aa < dd?  FALSE
aa > bb?  FALSE
aa > cc?  FALSE
aa > dd?  TRUE
w = pqrstuvwxyz, string::npos = 4294967295
3
4294967295
5
4294967295
4294967295
find "vwx" in string w:  6
find "uvw" in w from 4:  5
find "uvw" in w from 5:  5
find "uvw" in w from 6:  4294967295
find "uvwa" in w from 4:  4294967295
find first 3 of "uvwa" in w from 4:  5
v = abcdabcdabcd
find "abcd" in v:  0
rfind "abcd" in v:  8
u = jklmnopqrstuvwxyzAzyxwvu
find first of any char of agxb in u:  14
find first of any char of "dcbA25" in u:  17
find first of any char in first 3 of "dcbA25" in u:  4294967295
find first of 'z' in u:  16
find first of 'w', starting at 16 in u:  21
find last of any char of agxb in u:  20
find first of any char of u not in "ponmlkj":  7
find last of any char of u not in "ponmlkj":  23
y = ring me some time
ring metal bells some time
rr = C++ Sucks!
C++ Rocks!
```

Second Example:  A Quick Strlib Port:
-------------------------------------

A few of the comments have slight changes in meaning due to the string class
port.  The original comments have not been altered.  The section 5 code has
not been ported, as it is not really relevant to the string class.

```cpp
/*
 * File:  strlib_hacked.cc
 * Based on strlib.h written by Eric Roberts
 */

#include <string>
#include <iostream>
#include "strlib_hacked.h"

/* Section 1 -- Basic string operations */

/*
 * Function: Concat
 * Usage: s = Concat(s1, s2);
 * --------------------------
 * This function concatenates two strings by joining them end
 * to end.  For example, Concat("ABC", "DE") returns the string
 * "ABCDE".
 */
string Concat (string s1, string s2)
{
    return(s1 + s2);
}

/*
 * Function: IthChar
 * Usage: ch = IthChar(s, i);
 * --------------------------
 * This function returns the character at position i in the
 * string s.  It is included in the library to make the type
 * string a true abstract type in the sense that all of the
 * necessary operations can be invoked using functions. Calling
 * IthChar(s, i) is like selecting s[i], except that IthChar
 * checks to see if i is within the range of legal index
 * positions, which extend from 0 to StringLength(s).
 * IthChar(s, StringLength(s)) returns the null character
 * at the end of the string.
 */
char IthChar (string s, int i)
{
    if (i < 0 || (unsigned)i >= s.length()) {
        // Fixme -- is this the expected out-of-range behavior?
        return('\0');
    }
    return(s[i]);
}

/*
 * Function: SubString
 * Usage: t = SubString(s, p1, p2);
 * --------------------------------
 * SubString returns a copy of the substring of s consisting
 * of the characters between index positions p1 and p2,
 * inclusive.  The following special cases apply:
 *
 * 1. If p1 is less than 0, it is assumed to be 0.
 * 2. If p2 is greater than the index of the last string
 *    position, which is StringLength(s) - 1, then p2 is
 *    set equal to StringLength(s) - 1.
 * 3. If p2 < p1, SubString returns the empty string.
 */
string SubString (string s, int p1, int p2)
{
    int size;

    if (p1 > ((int)s.size() - 1)) {
        return s.substr(0, 0);  // return empty string
    }
    if (p1 < 0) {
        p1 = 0;
    }
    if (p2 < p1) {
        size = 0;
    } else {
        size = p2 - p1 + 1;
    }

    return s.substr(p1, size);
}

/*
 * Function: CharToString
 * Usage: s = CharToString(ch);
 * ----------------------------
 * This function takes a single character and returns a
 * one-character string consisting of that character.  The
 * CharToString function is useful, for example, if you
 * need to concatenate a string and a character.  Since
 * Concat requires two strings, you must first convert
 * the character into a string.
 */
string CharToString (char ch)
{
    string str(1, ch);
    return str;
}

/*
 * Function: StringLength
 * Usage: len = StringLength(s);
 * -----------------------------
 * This function returns the length of s.
 */
int StringLength (string s)
{
    return s.length();
}

/*
 * Function: CopyString
 * Usage: newstr = CopyString(s);
 * ------------------------------
 * CopyString copies the string s into dynamically allocated
 * storage and returns the new string.  This function is not
 * ordinarily required if this package is used on its own,
 * but is often necessary when you are working with more than
 * one string package.
 */
string CopyString (string s)
{
    string str = s;
    return str;
}

/* Section 2 -- String comparison functions */

/*
 * Function: StringEqual
 * Usage: if (StringEqual(s1, s2)) ...
 * -----------------------------------
 * This function returns TRUE if the strings s1 and s2 are
 * equal.  For the strings to be considered equal, every
 * character in one string must precisely match the
 * corresponding character in the other.  Uppercase and
 * lowercase characters are considered to be different.
 */
bool StringEqual (string s1, string s2)
{
    return s1 == s2;
}

/*
 * Function: StringCompare
 * Usage: if (StringCompare(s1, s2) < 0) ...
 * -----------------------------------------
 * This function returns a number less than 0 if string s1
 * comes before s2 in alphabetical order, 0 if they are equal,
 * and a number greater than 0 if s1 comes after s2.  The
 * ordering is determined by the internal representation used
 * for characters, which is usually ASCII.
 */
int StringCompare (string s1, string s2)
{
    return s1.compare(s2);
}

/* Section 3 -- Search functions */

/*
 * Function: FindChar
 * Usage: p = FindChar(ch, text, start);
 * -------------------------------------
 * Beginning at position start in the string text, this
 * function searches for the character ch and returns the
 * first index at which it appears or -1 if no match is
 * found.
 */
int FindChar (char ch, string text, int start)
{
    if (start < 0) {
        start = 0;
    }

    size_t index = text.find(ch, start);

    if (index == string::npos) {
        return -1;
    } else {
        return index;
    }
}

/*
 * Function: FindString
 * Usage: p = FindString(str, text, start);
 * ----------------------------------------
 * Beginning at position start in the string text, this
 * function searches for the string str and returns the
 * first index at which it appears or -1 if no match is
 * found.
 */
int FindString (string str, string text, int start)
{
    if (start < 0) {
        start = 0;
    }

    size_t index = text.find(str, start);

    if (index == string::npos) {
        return -1;
    } else {
        return index;
    }
}

/* Section 4 -- Case-conversion functions */

/*
 * Function: ConvertToLowerCase
 * Usage: s = ConvertToLowerCase(s);
 * ---------------------------------
 * This function returns a new string with all
 * alphabetic characters converted to lower case.
 * Would be cleaner if isupper() and tolower() were used.
 */
string ConvertToLowerCase (string s)
{
    string str = s;

    for (unsigned i=0; i < str.length(); i++) {
        if (str[i] >= 'A' && str[i] <= 'Z') {
            str[i] = str[i] - 'A' + 'a';
        }
    }
    return str;
}

/*
 * Function: ConvertToUpperCase
 * Usage: s = ConvertToUpperCase(s);
 * ---------------------------------
 * This function returns a new string with all
 * alphabetic characters converted to upper case.
 * Would be cleaner if islower() and toupper() were used.
 */
string ConvertToUpperCase (string s)
{
    string str = s;

    for (unsigned i=0; i < str.length(); i++) {
        if (str[i] >= 'a' && str[i] <= 'z') {
            str[i] = str[i] - 'a' + 'A';
        }
    }
    return str;
}

/* Section 5 -- Functions for converting numbers to strings (removed) */


/*
 * File:  strlib_hacked.h
 * Based on strlib.h written by Eric Roberts
 */

// Added to include C++ string class
#include <string>

#ifndef _strlib_h
#define _strlib_h

// Main change -- remove include of genlib.h
// This gets rid of the string and the bool typedefs
// #include "genlib.h"

// Comments ripped out to save space

string Concat(string s1, string s2);
char IthChar(string s, int i);
string SubString(string s, int p1, int p2);
string CharToString(char ch);
int StringLength(string s);
string CopyString(string s);
bool StringEqual(string s1, string s2);
int StringCompare(string s1, string s2);
int FindChar(char ch, string text, int start);
int FindString(string str, string text, int start);
string ConvertToLowerCase(string s);
string ConvertToUpperCase(string s);
string IntegerToString(int n);
int StringToInteger(string s);
string RealToString(double d);
double StringToReal(string s);

#endif
```

Building the Example Code:
--------------------------

The example and test code was built and run on a leland machine, using
g++ 2.95.3.
```shell
make str-ex4
g++   -g -Wall  str-ex4.cc   -o str-ex4
make str-ex3

g++ -g   -Wall -c -o str-ex3.o str-ex3.cc
g++ -g   -Wall -c -o strlib_hacked.o strlib_hacked.cc
g++ -g -Wall str-ex3.o strlib_hacked.o -o str-ex3

g++ -v
Reading specs from /usr/pubsw/lib/gcc-lib/sparc-sun-solaris2.8/2.95.3/specs
gcc version 2.95.3 20010315 (release)
```

References:
-----------

Exhaustive coverage of the string class prototypes with terse descriptions:

http://www.sgi.com/tech/stl/basic_string.html

An overview of the string class, with examples:

http://www.msoe.edu/eecs/cese/resources/stl/string.htm

http://wwwinfo.cern.ch/asd/lhc++/RW/stdlibcr/bas_0007.htm

C++ Primer Plus, Fourth Edition
Stephen Prata
(c) 2002
ISBN 0-672-32223-4

C++ For Programmers, Third Edition
Leen Ammeraal
(c) 2000
ISBN 0-471-60697-9

The following is a bit old, but has great string class test code:

C++ I/O Streams, Containers, and Standard Classes
Scott Robert Ladd
(c) 1996
ISBN 1-55851-463-5

