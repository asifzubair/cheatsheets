
An Overview of C++ Function and Class Templates 
Steve Jacobson
Version 0.2


Introduction:
-------------

Templatized functions and classes in C++ provide a mechanism for the types of
the parameter and return values to be specified as parameters to the template.
This allows software to be written with a greater level of abstraction than
before, a process sometimes referred to as generic programming.  Templates
permit writing code that is a little like a C macro, but which makes full use
of the strong type checking of C++.

Templates started turning up in C++ reference books around 1989.  They are
described in the second edition of Stroustrup's "The C++ Programming Language"
(1991), but not in the first edition (1986).  They are present in the 1996
ANSI draft standard and the 1998 ISO/ANSI C++ standard.

Yet templates are considered a relatively recent addition to the C++ language;
why?  It took a few years for templates to migrate into most compilers, and
five years or more for subtle features to be generally implemented.


Motivation:
-----------

Programming with generic types in C often involves using the void * type.
Many students who have used void * pointers in the CS107 darray project have
found themselves thinking there must be a better way.  Some have expressed
this thought in far more colorful language.

Templatized classes are used extensively in the C++ STL (standard template
library).  While beyond the scope of CS106, the STL is a highly successful
example of generic programming.


Simple Template Function:
-------------------------

C++ templates allow a body of code to be defined without specifying type
information until the template is instantiated.  Here is an example of a
simple template function:
```cpp
template <class Type>
Type Multiply (Type op1, Type op2)
{
    return op1 * op2;
}
```
The keywords "template" and "class" are required, as are the angle brackets.
The template parameter "Type" is a made up name, just like the name of any
parameter.

Looking past the syntax, it can be seen that the template will multiply
two operands of type "Type" and return a result of type "Type".

Note that a template is a pattern for code to be generated, and not exactly a
definition in the sense of concrete code.  It is a way to tell the compiler
how to generate an actual definition when the template is instantiated.  These
subtleties should be clarified by the actual code example in the next section.

An aside about the class keyword in the template pattern:  A recent addition
to the C++ language permits keyword "typename" to be used instead of "class"
in this context.  It may be clearer to use typename when you are specifying
a type in a template.  Keep in mind that older compilers will not support the
typename keyword, and older C++ code does not use it.


Simple Template Function Code Example:
--------------------------------------

Here is a C++ program that uses the template Multiply function.  First, it
instantiates Multiply with integer parameters, and then with doubles.
```cpp
//
// File:  temp-ex1.cpp
//

#include <iostream>

template <class Type>
Type Multiply (Type op1, Type op2)
{
    return op1 * op2;
}

int main ()
{
    int ival1;
    double dval1;

    ival1 = Multiply(3, 5);
    dval1 = Multiply(3.1, 5.25);

    cout << "ival1 = " << ival1 << ", dval1 = " << dval1 << endl;

    return(0);
}
```
Compiling and linking:
```shell
g++ -g   -Wall -c -o temp-ex1.o temp-ex1.cpp
g++ -g -Wall temp-ex1.o -o temp-ex1
```

Let's jump into `gdb` and see what really happens.

The first time we step into Multiply, we see "Multiply<int>" called with
integer parameters.  The second time, we see "Multiply<double>" with double
parameters.  What is going on here?

The truth is that the compiler has instantiated separate int and double
versions of Multiply, and compiled them separately into two pieces of object
code.  The first call to Multiply uses the int object code; the second call
uses the double object code.

Here's a quick refresher if you're rusty on running gdb in line mode:  "break
main" causes a breakpoint to be set on the first line of main().  "run" causes
the program to execute until the breakpoint is hit.  "s" single steps one C++
statement, and will step into called functions.  "l" lists a few lines of code
surrounding the current line to be executed.  "c" continues execution from the
current line.  While single stepping,  a numbered line prints on the screen
after each step; this indicates the line which will be executed next.

```shell
elaine22:~/cpp_info/test> gdb temp-ex1
GNU gdb 5.0 ...
(gdb) break main
Breakpoint 1 at 0x17254: file temp-ex1.cpp, line 18.
(gdb) run
Starting program: /afs/ir.stanford.edu/users/s/j/sjac3/cpp_info/test/temp-ex1 

Breakpoint 1, main () at temp-ex1.cpp:18
18          ival1 = Multiply(3, 5);
(gdb) s
int Multiply<int> (op1=3, op2=5) at temp-ex1.cpp:10
10          return op1 * op2;
(gdb) l
7       template <class Type> 
8       Type Multiply (Type op1, Type op2)
9       {
10          return op1 * op2;
11      }
(gdb) s
10          return op1 * op2;
(gdb) s
main () at temp-ex1.cpp:19
19          dval1 = Multiply(3.1, 5.25);
(gdb) s
double Multiply<double> (op1=3.1000000000000001, op2=5.25) at temp-ex1.cpp:10
10          return op1 * op2;
(gdb) s
10          return op1 * op2;
(gdb) s
main () at temp-ex1.cpp:21
21          cout << "ival1 = " << ival1 << ", dval1 = " << dval1 << endl;
(gdb) c
Continuing.
ival1 = 15, dval1 = 16.275

Program exited normally.
(gdb) 
```

So, you may ask yourself, "Can I instantiate Multiply with a parameter more
complicated than an int or a double?"  The answer is yes; we will revisit this
idea later.


Simple Template Class Example:
------------------------------

Templatized classes can be specified in much the same way as templatized
functions, and with much the same effect.

As with templatized functions, a templatized class is a pattern for code to be
generated.  It tells the compiler how to generate an actual class definition
when the template is instantiated.

Here is a trivial template function, which can contain four values of type
Object.  As with Type in the Multiply example, Object is a made up name for
the template type parameter.
```cpp
//
// File:  FourArr.h
//

template <class Object>
class FourArr {
  private:
    Object arr[4];
  public:
    /*
     * Constructor
     */
    FourArr (Object val1, Object val2, Object val3, Object val4)
    {
        arr[0] = val1;
        arr[1] = val2;
        arr[2] = val3;
        arr[3] = val4;
    }
    void printValues ()
    {
        cout << "Values = " << arr[0] << ", " << arr[1] << ", "
             << arr[2] << ", " << arr[3] << endl;
    }
};
```

Note that the methods are in the .h file, along with the rest of the template
definition.  Since the methods are not compiled until after the template class
is instantiated, putting methods in a .cpp file in the usual way will not work.
(workarounds exist, to be discussed later).


Simple Template Class Code Example:
-----------------------------------

This example instantiates the FourArr class several times with different types.

The scariest part of this example may be the declarations that instantiate the
FourArr class.  First, we'll look at the declaration of arr0, which isn't too
bad:
```cpp
    FourArr<float> arr0(1.25, 2.35, 3.45, 4.55);
```
arr0 is the name of the object; its type is FourArr<float>, which means its
an instantiation of class FourArr with type float.  The numbers in parentheses
are the initialization values required by the FourArr constructor.  (Note that 
object arr0 will exist on the stack; we will not be instantiating objects on
the stack in CS106.)

Second, let's look at the declaration of arr1:
```cpp
    FourArr<float> *arr1 = new (FourArr<float>)(5.2, 6.3, 7.4, 8.5);
```
arr1 is a pointer to an object of type FourArr<float>.  It will be instantiated
on the heap by the keyword "new" (this is the way we will teach students to
instantiate objects in CS106).  "(FourArr<float>)" is a cast necessitated by
the strong type checking of C++.

Instantiating class FourArr with types "float" and "short" seems pretty old
hat, but the declaration for arr3 is a bit different.  We are instantiating
class FourArr with a type of string, another class.  The output shows that
this works just as we might expect.

```cpp
//
// File:  temp-ex2.cpp
//

#include <iostream>
#include <string>
#include "FourArr.h"

int main ()
{
    FourArr<float> arr0(1.25, 2.35, 3.45, 4.55);
    FourArr<float> *arr1 = new (FourArr<float>)(5.2, 6.3, 7.4, 8.5);

    FourArr<short> *arr2 = new (FourArr<short>)(99, 55, 33, 42);
    FourArr<string> *arr3 = new (FourArr<string>)(string("CS106"),
                                                  string("in"),
                                                  string("C++"),
                                                  string("Rocks!"));

    arr0.printValues();
    arr1->printValues();
    arr2->printValues();
    arr3->printValues();

    delete arr1;
    delete arr2;
    delete arr3;

    return(0);
}

Program output:

Values = 1.25, 2.35, 3.45, 4.55
Values = 5.2, 6.3, 7.4, 8.5
Values = 99, 55, 33, 42
Values = CS106, in, C++, Rocks!
```

Second Template Class Code Example:
-----------------------------------

Why don't we push the envelope a bit and combine the template FourArr class
with the template Multiply function?  Geek fun at its finest!
```cpp
//
// File:  temp-ex3.cpp
//

#include <iostream>
#include "FourArr.h"

template <class Type>
Type Multiply (Type op1, Type op2)
{
    return op1 * op2;
}

int main ()
{
    FourArr<float> *arr1(2.2, 3.3, 4.4, 5.5);
    FourArr<float> *arr2(6.4, 7.5, 8.6, 9.7);

    arr1.printValues();

    FourArr<float> arr3 = Multiply(arr1, arr2);
    arr1.printValues();
    arr2.printValues();
    arr3.printValues();

    return(0);
}
```
Oh no, when we try to compile temp-ex3.cpp, we get this horrible error message:
```shell
g++ -g   -Wall -c -o temp-ex3.o temp-ex3.cpp
temp-ex3.cpp: In function `class FourArr<float> Multiply<FourArr<float>
    >(FourArr<float>, FourArr<float>)':
temp-ex3.cpp:21:   instantiated from here
temp-ex3.cpp:11: no match for `FourArr<float> & * FourArr<float> &'
temp-ex3.cpp:11: warning: control reaches end of non-void function
    `Multiply<FourArr<float> >(FourArr<float>, FourArr<float>)'
make: *** [temp-ex3.o] Error 1
```
What does it mean?  The first line 11 error message is trying to tell us that
the multiply operator (*) is not defined for class FourArr.  Uh oh, there's
a digression coming on...


An Aside About Defining Class Operators:
----------------------------------------

This topic is beyond the scope of CS106, so feel free to ignore it.

The multiply operator is defined within C++ for intrinsic types like int and
double.  But what does it mean to multiply two objects together?  C++ has no
way to know unless we tell it.

We can decide that the result of multiplying two FourArr objects together
should be to multiply the first elements, the second elements, ...  Adding the
following method to FourArr.h will do just that:
```cpp
    FourArr operator* (const FourArr& rightMult) const
    {
        return(FourArr(arr[0] * rightMult.arr[0], arr[1] * rightMult.arr[1],
                       arr[2] * rightMult.arr[2], arr[3] * rightMult.arr[3]));
    }
```
So what's with the syntax of the first line?  The short answer is that a
reference book says that operator syntax must look like this, and we can
just copy the book.

To dig a little deeper, "operator*" says that we are defining (and in this
case overloading) the operator "*".  The parameter list shows that the right
hand operand to "*" is being passed in.  Let's leave the discussion of the
"const"s until another day.

The code shows that arr[0] belonging to this object (the left hand operand)
is being multiplied by arr[0] of the right hand operand, etc.  The results
are being returned in another FourArr object.


Corrected Template Class Code Example:
--------------------------------------
```cpp
//
// File:  FourArr.h
//

template <class Object>
class FourArr {
  private:
    Object arr[4];
  public:
    /*
     * Constructor
     */
    FourArr (Object val1, Object val2, Object val3, Object val4)
    {
        arr[0] = val1;
        arr[1] = val2;
        arr[2] = val3;
        arr[3] = val4;
    }
    void printValues ()
    {
        cout << "Values = " << arr[0] << ", " << arr[1] << ", "
             << arr[2] << ", " << arr[3] << endl;
    }
    FourArr operator* (const FourArr& rightMult) const
    {
        return(FourArr(arr[0] * rightMult.arr[0], arr[1] * rightMult.arr[1],
                       arr[2] * rightMult.arr[2], arr[3] * rightMult.arr[3]));
    }
};

//
// File:  temp-ex3.cpp
//

#include <iostream>
#include "FourArr.h"

template <class Type>
Type Multiply (Type op1, Type op2)
{
    return op1 * op2;
}

int main ()
{
    FourArr<float> arr1(2.2, 3.3, 4.4, 5.5);
    FourArr<float> arr2(6.4, 7.5, 8.6, 9.7);

    arr1.printValues();

    FourArr<float> arr3 = Multiply(arr1, arr2);
    arr1.printValues();
    arr2.printValues();
    arr3.printValues();

    FourArr<float> arr4 = arr1.operator*(arr2);
    arr4.printValues();

    return(0);
}
```
Program output:
```shell
Values = 2.2, 3.3, 4.4, 5.5
Values = 2.2, 3.3, 4.4, 5.5
Values = 6.4, 7.5, 8.6, 9.7
Values = 14.08, 24.75, 37.84, 53.35
Values = 14.08, 24.75, 37.84, 53.35
```

From a template point of view, the important thing is that our Multiply
template function can be happily instantiated with class FourArr, as
long as we define the needed "operator*" in FourArr.

To see how the overloading of operator "*" works, the program output is
instructive.  When the contents of arr3 are printed, the values are indeed
the products of the values from arr1 and arr2.  Note that neither arr1 nor
arr2 are modified.

Object arr4 is initialized using the syntax that the compiler actually
substitutes for arr1 * arr2.  This may help tie the overloaded "*" operator
back to the syntax of FourArr's "operator*" method.


Separating Template Class Methods:
----------------------------------

The methods in the contained examples are in the .h file along with the rest
of the template class definition.  As the methods are not compiled until after
the template class is instantiated, putting methods in a .cpp file in the
normal way doesn't work.

One common workaround is to place the methods into a .cpp file, and then
`#include` the `.cpp` into the header file.

Another strategy is to use the `extern` "extern" keyword, which is not presently
supported by all compilers.  gcc 2.95.3 does not support extern.


Miscellaneous Information:
--------------------------

Since the compiler generates object code each time a template class or function 
is instantiated with a new type, growth in object size can be an issue.

Template classes and functions can be instantiated with an explicit type, if
needed.  This may be necessary if the compiler cannot determine if you wish
to use int or short variants, for instance.  The following:
```cpp
    dval1 = Multiply<int>(3.1, 5.25);
```
forces integer object code to be used, so the answer produced is 15.


References:
-----------
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
(c) 1986

Note:  The preceding book is very much out of date,
but contains interesting historical information.

Bjarne Stroustrup
The C++ Programming Language
Second Edition
(c) 1991

Note:  The preceding book is also out of date.  Refer to the third
edition for current information.

ANSI DRAFT: 2 December 1996 standard at:
ftp://ftp.research.att.com/dist/c++std/WP/CD2/

