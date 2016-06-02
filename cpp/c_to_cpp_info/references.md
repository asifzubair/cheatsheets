
An Overview of C++ References
Steve Jacobson
Version 0.1


Introduction:
-------------

C++ includes all standard pointer operations from C.  In addition, C++ adds
the concept of a reference, which has different syntax and behavior.

Most of the time, C++ references are used for passing arguments by reference
to methods and functions.  The bulk of this monograph is dedicated to
pass-by-reference.  Additional information is included to shed further light
on the subtleties of references.

A C++ reference declaration establishes a name which is an alias for an
existing variable.  That relationship is established once, when the reference
is declared, and can never be changed for as long as that code remains in scope.

Unlike a pointer, a C++ reference can never be dereferenced.  References seem
to have much in common with pointers, but the actual workings remain "under
the covers," and the programmer never needs to worry about them.

A reference declaration creates an alias to an existing variable.  A reference
cannot be declared without making an alias assignment.  This means that a
reference can never have an unassigned value.  For this reason, setting a
reference to NULL is not possible, and the idea of checking a reference for
an unassigned value is not meaningful.


Function Reference Parameters:
------------------------------

The most important use of C++ references is for "pass-by-reference" function
and method parameters.  Passing an argument by reference means that the
function or method is permitted to (and is capable of) modifying the actual
argument.  This implies that the argument must be an expression (lvalue) that
can reasonably be modified.

In C, Pass-by-reference is simulated by passing the address of a variable (a
pointer) and dereferencing that address within the function to read or write
the actual variable.  This will be referred to as "C style pass-by-reference."

Examples of pass-by-reference in other languages include subroutine dummy
arguments in Fortran and any Pascal formal parameter prepended with "var".

The following program demonstrates pass-by-value (`function ValTest()`), C style
pass-by-reference (`function PtrTest()`) and C++ style pass-by-reference
(`function RefTest()`).

```cpp
//
// File:  ref-ex1.cpp
//

#include <iostream>

void ValTest (int parm1, int parm2)
{
    parm1 = 33;
    parm2 = 44;
}

void PtrTest (int *parm1, int *parm2)
{
    *parm1 = 55;
    *parm2 = 66;
}

// Parameters are passed by reference
void RefTest (int &parm1, int &parm2)
{
    parm1 = 77;
    parm2 = 88;
}

int main ()
{
    int val1 = 0, val2 = 0;
    int val3 = 0, val4 = 0;
    int val5 = 0, val6 = 0;

    ValTest(val1, val2);
    cout << "val1 = " << val1 << ", val2 = " << val2 << endl;

    PtrTest(&val3, &val4);
    cout << "val3 = " << val3 << ", val4 = " << val4 << endl;

    RefTest(val5, val6);
    cout << "val5 = " << val5 << ", val6 = " << val6 << endl;

    return(0);
}
```
```shell
Program Output:

val1 = 0, val2 = 0
val3 = 55, val4 = 66
val5 = 77, val6 = 88
```

All experienced C programmers know that when arguments are passed by value,
they are copied when the function is called.  function `ValTest()` modifies the
copies of its arguments, but not the originals.  Likewise, they know that when
a pointer to a variable is passed as an argument, the called function can
modify the variable by dereferencing that pointer.  This is illustrated by
function `PtrTest()`.

C++ style pass-by-reference involves syntax not seen in the C language.  The
use of the ampersand (`&`) for declaring a C++ reference is unfortunate, as &
has other meanings already known to C programmers.  The definition of function
`RefTest()` is an example of C++ pass-by-reference syntax.

The only syntactic difference between `ValTest()` and `RefTest()` is the inclusion
of `&` before the parameters.  There is no difference in the syntax of the
calling program.  In some ways this is good, since new students of programming
need not place `*` in front of every use of a parameter within a function.  Also,
struct member access does not need to change from `.` to `->`.  Unfortunately,
references adds additional syntax, which may take some getting used to.

Experienced C programmers may miss the "tells" of C style pass-by-reference.
In C, you knew when a non-pointer variable was passed as an argument, if it
was not prefaced by `&`, it would not be modified.  Likewise, a variable
prefaced by `*` was clearly being dereferenced.

Teaching both C and C++ styles of pass-by-reference is likely to confuse
students more than necessary.  Since the syntax of C++ style pass-by-reference
is simpler, it has been decided that the CS106 dialect of C++ will teach the
C++ pass-by-reference variant only.


Methods With Complex Reference Parameters:
------------------------------------------

Method reference parameters behave exactly the same as function reference
parameters.  In addition, passing complex data types such as structs works
the same for methods and functions.

```cpp
//
// File:  ref-ex2.cpp
//

#include <iostream>

struct pairStruct {
    int first;
    int second;
};

class TestClass {
  public:
    void ValMethod (int p1, pairStruct p2)
    {
        p1 = 111;
        p2.first  = 122;
        p2.second = 133;
    }
    void PtrMethod (int *p1, pairStruct *p2)
    {
        *p1 = 244;
        p2->first  = 255;
        p2->second = 266;
    }
    void RefMethod (int &p1, pairStruct &p2)
    {
        p1 = 377;
        p2.first  = 388;
        p2.second = 399;
    }
};

int main ()
{
    int num = 0;
    pairStruct pair;
    TestClass *test = new TestClass;

    pair.first  = 0;
    pair.second = 0;

    test->ValMethod(num, pair);
    cout << "num = " << num << ", pair = " << pair.first << ", "
         << pair.second << endl;

    test->PtrMethod(&num, &pair);
    cout << "num = " << num << ", pair = " << pair.first << ", "
         << pair.second << endl;

    test->RefMethod(num, pair);
    cout << "num = " << num << ", pair = " << pair.first << ", "
         << pair.second << endl;

    delete test;
    return(0);
}
```
```shell
Program Output:

num = 0, pair = 0, 0
num = 244, pair = 255, 266
num = 377, pair = 388, 399
```

As before, arguments passed by value are not modified by the called method.
C style pass-by-reference arguments are modified, as are C++ style
pass-by-reference arguments.  Note that the C++ style syntax is more regular;
the student no longer has to switch between `.` and `->` notation for the value
and reference passing cases.

For large structures or objects passed into a function or method, a reference
is sometimes used to avoid the expense of a copy operation, even though the
structure or object is not modifed.  This has practical importance, but is not,
to us, of pedagogical interest.


Methods With Pointer and Object Parameters:
-------------------------------------------

Pointers can be passed in the same way as other arguments.  Consider passing
a pointer to a linked list into a function.  How would you append to this list
if the list is empty (the pointer is NULL)?  Typically in C you need to pass a
pointer to a pointer, which gets pretty messy.

As you might expect, an object argument can be modified under the same
circumstances as a struct argument.

```cpp
//
// File:  ref-ex3.cpp
//

#include <iostream>

class SecondClass {
  private:
    int private1, private2;
  public:
    SecondClass ()
    {
        private1 = private2 = 0;
    }
    void SetPrivate (int p1, int p2)
    {
        private1 = p1;
        private2 = p2;
    }
    void PrintPrivate ()
    {
        cout << "private1 = " << private1
             << ", private2 = " << private2 << endl;
    }
};

class FirstClass {
  public:
    void ValMod (int *ptr, SecondClass secCl)
    {
        ptr++;
        secCl.SetPrivate(1234, 2345);
    }
    void PtrMod (int **ptr, SecondClass *secCl)
    {
        (*ptr)++;
        secCl->SetPrivate(3456, 4567);
    }
    void RefMod (int *&ptr, SecondClass &secCl)
    {
        ptr++;
        secCl.SetPrivate(5678, 6789);
    }
};

int main ()
{
    int array[4] = { 111, 222, 333, 444 };
    int *iptr = &array[1];
    FirstClass *first = new FirstClass;
    SecondClass second;

    cout << "*iptr = " << *iptr << endl;
    second.PrintPrivate();

    first->ValMod(iptr, second);
    cout << "*iptr = " << *iptr << endl;
    second.PrintPrivate();

    first->PtrMod(&iptr, &second);
    cout << "*iptr = " << *iptr << endl;
    second.PrintPrivate();

    first->RefMod(iptr, second);
    cout << "*iptr = " << *iptr << endl;
    second.PrintPrivate();

    delete first;
    return(0);
}
```

```shell
Program Output:

*iptr = 222
private1 = 0, private2 = 0
*iptr = 222
private1 = 0, private2 = 0
*iptr = 333
private1 = 3456, private2 = 4567
*iptr = 444
private1 = 5678, private2 = 6789
```

Method `ValMod()` passes `iptr` by value.  Even though iptr is a pointer, the
contents of iptr (which happens to be an address) is copied to parameter
`ptr` in the stack frame for `ValMod()`.  So, `ValMod()` increments a copy of `iptr`,
and does not modify the original.

`PtrMod()` uses C style pass-by-reference to pass the address of `iptr`.  Since
`PtrMod()` has the address of `iptr`, it can modify iptr by dereferencing `ptr` in
the usual way.  The output shows that `iptr`, pointed to by `ptr`, is indeed
incremented.

`RefMod()` employs C++ style pass-by-reference to pass a reference to a pointer.
The syntax of the first parameter of `RefMod()` is a bit mind-bending, but all
it means is that a reference to an integer pointer is to be passed.  `RefMod()`
uses the reference to increment `iptr`, as seen in the output.

Passing objects follows the pattern for passing structs.  `ValMod()` calls
`SetPrivate()` on a copy of object second, so the original is never modified.
C and C++ style pass-by-reference are used to successfully modify object
second in `PtrMod()` and `RefMod()`.


C++ References as Return Values:
--------------------------------

This is beyond the scope of material to be taught in CS106, but still worth
knowing.  Students with C++ experience may return references from functions
or methods, and might not do so correctly.  Function `getClass1()`, below contains
an egregious error.

```cpp
//
// File:  ref-ex4.cpp
//

#include <iostream>

class SomeClass {
  private:
    int private1, private2;
  public:
    SomeClass ()
    {
        private1 = private2 = 0;
    }
    void PrintPrivate ()
    {
        cout << "private1 = " << private1
             << ", private2 = " << private2 << endl;
    }
};

SomeClass &getClass1()
{
    SomeClass second;
    return second;
}

SomeClass &getClass2()
{
    SomeClass *second = new SomeClass;
    return *second;
}

int main ()
{
    SomeClass &sc1 = getClass1();
    sc1.PrintPrivate();
    SomeClass &sc2 = getClass2();
    sc1.PrintPrivate();
    sc2.PrintPrivate();

    delete &sc2;
    return(0);
}
```

```shell
Warning Generated During Compile:

ref-ex4.cpp: In function `class SomeClass & getClass1()':
ref-ex4.cpp:29: warning: reference to local variable `second' returned

Program Output:

private1 = 0, private2 = 0
private1 = 0, private2 = 253608
private1 = 0, private2 = 0
```

`getClass1()` returns a reference to an object declared on the stack; the object
is a local variable of that function.  When `getClass1()` returns, the local
variables are invalidated and the stack space they occupied is reclaimed.  This
error is analogous to returning a pointer to a function's local variable.

Note that sc1 attribute private2 is corrupt after the call to `getClass2()`.
Since `sc1` is a dangling reference, this is not surprising.  In addition to
data corruption, use of a dangling reference may cause program or system
crashes.

Because of the risk of misuse, some experts recommend never returning a
reference from a function or method.

Function `getClass2` correctly returns a reference to a dynamic object, allocated
on the heap by new.  The function has to return a reference to what second 
points to, an odd bit of syntax.  The programmer has to remember to free the
returned object with delete when done with it.  Also, delete requires the
address of `sc2`, more unusual syntax.


Obscure Uses For C++ References:
--------------------------------

This material is beyond the scope of CS106, but is included here to demonstrate
additional properties of C++ references.  In practice, references are seldom
used for anything but pass-by-reference function and method parameters.

Declaring a reference establishes a new name as an alias for an existing
variable.  In the example below, `ref1` is declared to be a reference to foo,
then ref2 is declared to be a reference to ref1.  This means that the three
names, `foo`, `ref1` and `ref2` all refer to the same variable.

```cpp
//
// File:  ref-ex6.cpp
//

#include <iostream>

int main ()
{
    int val2 = 0;

    int foo = 999;
    int &ref1 = foo;
    cout << "foo = " << foo << ", ref1 = " << ref1 << endl;

    ref1++;
    cout << "foo = " << foo << ", ref1 = " << ref1 << endl;

    int &ref2 = ref1;
    ref2++;
    cout << "foo = " << foo << ", ref1 = " << ref1
         << ", ref2 = " << ref2 << endl;
    cout << "&foo = " << &foo << ", &ref1 = " << &ref1
         << ", &ref2 = " << &ref2 << ", &val2 = " << &val2 << endl;

    // What do you get if you try to reassign a reference?
    ref1 = val2;

    ref1++;
    cout << "foo = " << foo << ", ref1 = " << ref1
         << ", ref2 = " << ref2 << ", val2 = " << val2 << endl;
    cout << "&foo = " << &foo << ", &ref1 = " << &ref1
         << ", &ref2 = " << &ref2 << ", &val2 = " << &val2 << endl;
}
```

```shell
Program Output:

foo = 999, ref1 = 999
foo = 1000, ref1 = 1000
foo = 1001, ref1 = 1001, ref2 = 1001
&foo = 0xffbef9e8, &ref1 = 0xffbef9e8, &ref2 = 0xffbef9e8, &val2 = 0xffbef9ec
foo = 1, ref1 = 1, ref2 = 1, val2 = 0
&foo = 0xffbef9e8, &ref1 = 0xffbef9e8, &ref2 = 0xffbef9e8, &val2 = 0xffbef9ec
```

The following statement might seem to be redirecting `ref1` to be an alias for
`val2`.  The code compiles and runs; so what is happening?

```cpp
    ref1 = val2;
```

The program output shows that `foo`, `ref1` and `ref2` still refer to the same
address, a different address than `val2`.  

The statement actually causes the variable referred to by `ref1` to be assigned
the value contained in `val2`.  The output shows that none of the addresses have
changed, and that the variable aliased by `foo`, `ref1` and `ref2` now contains
`(the contents of val2) + 1`.

So, an assignment through a reference can be made as many times as necessary,
but a reference relationship can only be established once while the relevant
code is in scope.


Very Obscure C++ References Example:
------------------------------------

This material is way beyond the scope of CS106, but contains stuff you might
see in a student's code some day.  Pay particular attention if you plan on
entering the obfuscated C++ code competition.

```cpp
//
// File:  ref-ex5.cpp
//

#include <iostream>

void Swap (int &p1, int &p2)
{
    int temp;

    temp = p1;
    p1 = p2;
    p2 = temp;
}

int &Reftest1 (int &parm)
{
    return(parm);
}

int main ()
{
    int val1 = 0, val2 = 0;
    int val3 = 33, val4 = 44;
    int val5 = 1818, val6 = 3636;
    short val7 = 2718, val8 = 3141;

    Swap(val5, val6);
    cout << "val5 = " << val5 << ", val6 = " << val6 << endl;

    // Complains about having to use temporary variables
    // Swap(val7, val8);
    // cout << "val7 = " << val7 << ", val8 = " << val8 << endl;

    // Works without complaint, but does not perform swap!
    cout << "val7 = " << val7 << ", val8 = " << val8 << endl;
    Swap((int)val7, (int)val8);
    cout << "val7 = " << val7 << ", val8 = " << val8 << endl;

    // Simply copies the parameter
    val1 = Reftest1(val4);
    cout << "val1 = " << val1 << ", val2 = " << val2 << endl;

    // Yes, this actually works!
    Reftest1(val2) = val3;
    cout << "val1 = " << val1 << ", val2 = " << val2 << endl;

    return(0);
}
```

```shell
val5 = 3636, val6 = 1818
val7 = 2718, val8 = 3141
val7 = 2718, val8 = 3141
val1 = 44, val2 = 0
val1 = 44, val2 = 33
```

Function `Swap()` simply exchanges the contents of two integer variables.  So,
```cpp
    Swap(val5, val6);
```
works exactly as you would expect.  But what is the problem with the following?
```cpp
    Swap(val7, val8);
```
In order to pass short integers `val7` and `val8`, the compiler would need to copy
the arguments to anonymous integer variables and pass those by reference.  The
copies would be swapped, but not the originals.  What happens if we decide we
are smarter than the compiler?
```cpp
    Swap((int)val7, (int)val8);
```
Exactly what was described above; copies are made and exchanged, but not the
originals.  The C++ compiler is delighted to allow the programmer to shoot
himself in the foot; what caliber would you like, sir?

Function `Reftest1()` just copies the value of the parameter to the return value.
Why is this legal syntax?
```cpp
    Reftest1(val2) = val3;
```
Note that the function returns a reference to the argument, in this case `val2`.
Since a reference is a legal lvalue, assignment to it is permitted.  So, the
effect of this statement is to assign the value of `val3` to `val2`.


Reference Documents:
--------------------

Moving from C to C++
The Ins and Outs of Object-Oriented Programming
Greg Perry
(c) 1992
ISBN 0-672-30080-X

Note:  The preceding book refers to AT&T C++ 3.0, which predates ANSI C++.

C++ Primer Plus, Fourth Edition
Stephen Prata
(c) 2002
ISBN 0-672-32223-4

Note:  The preceding book describes the ISO/ANSI C++ standard from 1998.

C++ (The Nitty Gritty)
Till Jeske
(c) 2000, 2002
ISBN 0-201-75879-2

The C++ Programming Language
Bjarne Stroustrup
Second Edition
(c) 1991

Note:  The preceding book is out of date.  Refer to the third
edition for more current information.

ANSI DRAFT: 2 December 1996 standard at:
ftp://ftp.research.att.com/dist/c++std/WP/CD2/

The very strict Comeau C++ compiler at:
http://www.comeaucomputing.com/tryitout/

Pascal:  User Manual and Report
Second Edition
Kathleen Jensen
Niklaus Wirth
(c) 1974
ISBN 0-387-90144-2

A Simplified Guide to Fortran Programming
Daniel D. McCracken
(c) 1974
ISBN 0-471-58292-1

