
Some Differences Between C and C++
Steve Jacobson
Version 0.4

Updated and much improved as a result of Eric Albert's extensive feedback.

Introduction:
-------------

C++ was developed by Bjarne Stroustrup at Bell Labs, starting in 1979.
It was known as "C with classes" until the term "C++" was coined in 1983.

With few exceptions, any reasonable C program is a legal C++ program.  So,
congratulations are in order; you already know an important subset of C++!


Structures:
-----------

In C, a non-typedef structure definition often looks like this:

    struct frobnitz {
        int foo;
        int bar;
    };

    struct frobnitz frob;

In C++, the following can create an instance of a structure variable
without requiring the keyword "struct":

    struct frobnitz {
        int foo;
        int bar;
    };

    frobnitz frob;

Note that structure definitions using typedef, as taught in CS106,
works just as well in C++ as it does in C.


Enums:
------

In C, one of the following two forms is required:

    enum color {
        Red, Yellow, Green
    };

    enum color myColor;

or:

    typedef enum {
        Red, Yellow, Green
    } color;

    color yourColor;

In C++, an instance of the enum color can be defined and declared as
follows without a typedef:

    enum color {
        Red, Yellow, Green
    };

    color someColor;

In C, an enum is basically a way to alias names to integers.  This does
not lead to improved type checking.  In C++, an enum defines an actual
type, which results in strong type checking.  So:

    someColor = 1;

will generate a warning in C++ but not in C.


Function Prototyping:
---------------------

Many C compilers do not require prototypes for functions defined in
other files.  For instance, gcc permits this without warning or error
unless certain compile flags are turned on.  C++ does not permit this.

Also, a prototype of the following form:

bar(<some type or types>);

is assumed by ANSI-compliant C compilers to mean:

int bar(<some type or types>);

and 

<some type> bar();

tells an ANSI C compiler that you are refusing to give any information
about the arguments, such as type or quantity.  The return type is the
type specified in place of <some type>.

When empty parentheses are specified, C++ assumes a void argument type
instead.  C++ expects you to specify the return type in all cases, even
if it is int or void.  Naturally, explicit prototyping is best in
all cases, even if not required by a particular compiler.


Promotion of Void Pointers:
---------------------------

One manifestation of stricter type checking in C++ involves promotion
of the void * type, which happens automatically in C.  In C for instance:

    frobnitz *frob_ptr;
    frob_ptr = malloc(sizeof(frobnitz));

does not require a cast, since the void * is automatically promoted to
a frobnitz * in the assignment.  Note that it is customary in some
academic classes (and in some shops in industry) to use a cast anyway.

In C++:

    frobnitz *frob_ptr;
    frob_ptr = (frobnitz *)malloc(sizeof(frobnitz));

the cast is required in C++ because of stronger type checking.


New and Delete Instead of Malloc and Free:
------------------------------------------

Bjarne Stroustrup advocates using the new and delete operators in C++ code.
instead of malloc() and free().

Note that malloc() and free() work the same in C++ as they did in C.  
We may choose to use malloc/free in our 106 C++ dialect.

There are two forms of new and delete, one for scalar types and one
for arrays.  The type of delete must match the type of new, or you
will get undefined results.

    int *foo = new int;        // allocates memory for one int
     . . .

    delete foo;                // deletes memory pointed to by foo

    int *baz = new int[100];   // allocates memory for 100 int array
     . . .

    delete [] baz;             // deletes memory pointed to by baz

Delete with [] indicates that the entire array should be deleted, not
just a single element.

Note that new and delete are operators, not functions, so they do not
require type casting.

The following variant of new initializes the entire allocated array
to zeroes:

    float * arr = new float [200] (0.0);  // allocates and zeroes

As we all know, malloc returns a NULL pointer if there is not enough 
memory to honor the request.  In C++, new throws a bad_alloc exception
in modern implementations.  This exception can be caught by a user
supplied try block and exception handler.  If the exception is not
caught, the default behavior is to abort the program.

Note that new in Visual C++ 6.0 indicates a lack of memory by returning
NULL instead of throwing an exception.  This behavior is incompatible with
other modern C++ compilers, and is not standards-compliant.

As with free(), passing a null pointer to delete is harmless.

Never use delete on a block of memory allocated by malloc().  Also, never
call free() on memory allocated by new.  Otherwise, malloc() and free()
can coexist in the same program with new/delete.


A Note on Type Casting:
-----------------------

You might see an unusual form of type casting in some C++ code.
This is permitted by the current C++ standard:

    foo = (float)bar;  // Normal C-style cast
    foo = float(bar);  // In the C++ standard
    baz = (int)foo;    // Normal C-style cast
    baz = int(foo);    // In the C++ standard

Normal C-style type casting works in C++, and seems to be more common.

Other, more exotic type casts exist in C++.  Those will be discussed
another day.


C++ Comments:
-------------

C++ comments are line oriented.  They begin with two forward slashes
(//) and cause the balance of the line to be ignored by the compiler.

They can coexist with C style comments (/* */).  One advantage of C++
comments is that they nest correctly, unlike C comments.  The following
is legal, and can be useful during code development:

//    foo += bar;    /* offset foo to the next row */

As a trivia note the // comment form originated with BCPL, the predecessor
to the C programming language.


Defines:
--------

Bjarne Stroustrup recommends not using #define in C++ code.  Instead,
he suggests use of const and enum for data values, and inline functions
instead of macros.

Note that #define works in C++ in exactly the same way as in C.  We may
well decide to use #defines in our 106 C++ dialect.

#defines are preprocessor directives, which instruct the preprocessor
to perform pattern substitution before compilation.  C++ Const variables
follow the same scoping rules as other variables.

In a pure C++ style program, the following:

#define FOO 16

might be replaced with:

const int foo = 16;

Note that foo cannot be changed after initialization.

There are advantages to the C++ approach:  It provides type checking,
and can be seen and examined by a symbolic debugger.  It has the
disadvantage of consuming space in memory.

A constant of this type can be use everywhere, except as an lvalue.

Note that a global const value specified within a C++ source file has
file scope only.  To make it visible to other files, use

extern const int foo = 16;

Another source file (or a header file) could then specify:

extern const int foo;

to have access to the constant foo.

It is also permissible (and probably simpler) to declare:

     const int foo = 16;

in a header file.


Name Mangling:
--------------

In C++, the linker mangles the names of functions, in part so it can
keep track of overloaded functions.  Don't worry about why for now.
A mangled function name has seemingly nonsensical characters added
to the function name, which can be perplexing when debugging.

Name mangling can lead to strange error messages when a referenced
function is not implemented, or a needed file is not linked.  Also,
problems can occur when C and C++ files are linked together as
mentioned below.

Historically, name mangling caused problems with some symbolic debuggers,
though modern debuggers should have this well in hand.  gdb is known to
handle mangled names transparently.

Incidentally, the c++filt program on the Leland servers can be used to
demangle function names if necessary.


Linking C and C++ files (or Libraries):
---------------------------------------

Because of name mangling, the linker can be confused when C files
(or libraries) are linked with C++ files.  The compiler generates
mangled names for the C functions, leading to error messages about
unresolved references to very strange function names.  To alleviate
this, a C linkage specifier must be used:

extern "C" {
    int baz(int x);
}

Tells the compiler that the name of C function baz must not be mangled.

The following form prevents warnings when the C library functions bzero
and bcopy are called:

extern "C" void bzero(void *, unsigned int);
extern "C" void bcopy(const void *, void *, unsigned int);

Note that the prototypes do not exactly match the standard prototypes;
however these are working examples extracted from the Nachos code.


References:
-----------

Moving from C to C++
The Ins and Outs of Object-Oriented Programming
Greg Perry
(c) 1992
ISBN 0-672-30080-X

Note:  The preceding book is based on AT&T C++ 3.0,
which predates ANSI C++.

The C++ Programming Language
Bjarne Stroustrup
(c) 1986

Note:  The preceding book is very much out of date,
but contains interesting historical information.
Modern editions exist.

C++ Primer Plus, Fourth Edition
Stephen Prata
(c) 2002
ISBN 0-672-32223-4

Note:  The preceding book describes the ISO/ANSI C++ standard from 1998.

CS 140 Nachos source code

CS 143 source code

Bjarne Stroustrup's C++ FAQ
http://www.research.att.com/~bs/bs_faq.html

C++ Effective Object-Oriented Software Construction
Kayshav Dattatri
(c) 1997
ISBN 0-13-104118-5

