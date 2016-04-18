
Porting Notes
Steve Jacobson
version 0.1


This is a quick sketch of things I had to do to port
Boggle to C++.  I used Visual Studio 6.0.

The cs106 assignment wizard worked correctly for me.  The
cs106lib.lib also worked correctly.  It also located the
cs106 include file directory I had earlier downloaded (more
about this later).

I needed to hack the standard 106 header files, so I moved
the original 106 library include file directory to a new
place (I will redownload the header files to the original
place before I grade any more programs).  To tell VS 6.0
about this, go to tools / options / directories and modify
the cs106inc include path.  This is (I believe)  the MSVC
include directory menu.

The include files all needed to be hacked.  Most had a
section near the top that looked like:
```cpp
#ifdef __cplusplus
#pragma "whine about being compiled in C++ mode"
#endif
```
This should be #ifdefed out or removed.

All the prototypes in the header need to be surrounded with
an 'extern "C"' block.  The following is what I did:
```cpp
#ifdef __cplusplus
extern "C" {
#endif
. . .
<prototypes>
. . .
#ifdef __cplusplus
}
#endif
```
extern "C" tells the compiler not to "mangle" the names of
the library functions.  Name mangling makes sense for C++
files, but confuses the linker when compiled C files (such
as cs106lib.lib) are linked.

Also, genlib.h had to be modified to hack out the string and
bool typedefs.  I decided against removing this header file
from the build because the boggle solution file required the
Error function prototype.

All string parameters in all prototypes had to be converted to
char *, at least for now.


I changed all .c files included in the project (in this case,
gboggle.c and boggleSoln.c) to have .cpp filename extensions.
This enables the files to be compiled as C++ files by Visual
Studio.

In the .cpp files, I had to look at all string references and
decide what to do with each one.  If it remained a C-style string,
I changed the type from "string" to "char *".  If it was to be
converted to a C++ std::string, I left the type as "string" and
carefully ported the associated code, line-by-line.  Confusing, eh?

The compiler began complaining of undefined string type.  The
easiest way around this was as follows:  First, the #include of
string needs to be near the top of the list of #includes, and
above all of the 106 library includes.  Then, "using namespace std;"
(no quotes) needs to be placed after the string include, and before
the 106 library includes.  So, the #include structure looked something
like this:
```cpp
#include <cstdio>
#include <iostream>
#include <string>

using namespace std;

#include "genlib.h"
. . .
```
This is because C++ software can be divided up into separate namespaces.
The C++ string library lives in namespace std, but your program lives
in some other namespace.  The "using" statement allows the std namespace
to be pulled into your program so you don't need to explicitly state
"std::string" each time instead of "string".

Within the C++ files, all references to TRUE need to be converted
to true, and every FALSE must be changed to false.

Be aware that when a C++ string (not string *) is passed into a
function, it is copied by default.  If the string is modified within
the function, only the local copy is modified.  You may find this
counterintuitive if you are accustomed to the behavior of C arrays. 

One way to cause the function to modify the original string instead
of a copy is to pass the string as a C++ reference.  This is unique
to C++, and is different than C "pass by reference."  Here is an
example:
```cpp
// string str is copied; the original is not modified.
void MungeArray(string str)
{
    str[0] = "M";
}

// string str is passed as a reference; the original is modified.
void MungeArray(string &str)
{
    str[0] = "M";
}
```
Note that using C++ references may not be the recommended thing
to do in in our dialect of C++.  Instead, we may be better off
restructuring the code so that functions are not expected to
modify string parameters.

