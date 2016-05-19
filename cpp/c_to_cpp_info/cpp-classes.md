
An Overview of C++ Classes and Objects
Steve Jacobson
Version 0.4


Introduction:
-------------

Bjarne Stroustrup developed C++ mainly because he wanted to add classes
to C.  He borrowed the class concept from Simula67.


Simple Classes:
---------------

In their simplest form, C++ classes are essentially the same as structures.
For example,
```cpp
class NumPair {
    int num1;
    int num2;
};
```
is almost the same as:
```c
struct NumPair {
    int num1;
    int num2;
};
```
So, it seems like the following small C++ program should work, right?
```cpp
class Square {
    int num;
    int squareOfNum;
};

int main ()
{
    Square sq;

    sq.num = 2;
    return(0);
}
```
Well, almost.  The compiler generates an error, complaining that
`Square::num` is inaccessible.  Why?  It turns out that C++ classes have the
notion of access controls, or private and public regions, and the data is
in a private region by default.  If the definition of the class is changed to:
```cpp
class Square {
  public:
    int num;
    int squareOfNum;
};
```
Then the program compiles and works as expected.  By default, all class data
is private, so the original class definition is equivalent to:
```cpp
class Square {
  private:
    int num;
    int squareOfNum;
};
```
Now, using the definition of class Square with public data, we can store a
number and its square in an instance of the class:
```cpp
class Square {
  public:
    int num;
    int squareOfNum;
};

int main ()
{
    Square sq;

    sq.num = 2;
    sq.squareOfNum = 5;
    return(0);
}
```
Umm... Wait a minute!  Our intrepid programmer seems a bit mathematically
challenged.  This simple class doesn't care what data is stored into it any
more than a structure does.  The coder can store data which violates the
intent of the class with impunity.  This leads us into what classes are
really all about.


Classes Revisited:
------------------

A class is an abstract data type which can be user-defined.  It contains
data and class-specific functions for operating on that data.  The data
are known as member data, and the functions are called member functions or
methods.

There are good reasons for separating the implementation and data in a type
or class from the abstraction that the user sees.  As we have just seen, we
must impose some restrictions on data access if we are to control data
consistency.  By using data hiding and restricting data access to a specific
set of access functions, we can have the compiler help us check for illegal
accesses to that data.

Data hiding is the protection of member data from direct access.  Data
which is protected by the "private:" access control can be accessed only
by member functions.  This means that the only way to read or write private
data from outside the class is through public member functions.  As shown
below, the member functions are able to access private member data directly.

Note that private member functions can also be defined.  Private member
functions can only be called by other member functions within the class.

An object is an instantiation of a class in a program.  In the example
below, object sq is an instantiation of class Square.

In the Square class, we must control how data is stored if we are to maintain
the relationship between the number and its square.  So, the class has now
been augmented with public member functions.  Because "private:" was added,
the data can no longer be accessed directly.  The private member variables can
only be read by calling accessor functions getNum() or getSquare().  More
importantly, the data can only be set by calling enterNumAndSquare(); so, if
the coder implemented that member function correctly, then num and squareOfNum
will always be set in a consistent manner.

Note that the syntax for invoking member functions involves a ".", very much
like accessing an element of a structure declared on the stack.  In main(),
the statement:
```cpp
    sq.enterNumAndSquare(2);
```
makes it clear that enterNumAndSquare() is a member of Square, the class that
sq instantiates.  And, it should be clear that enterNumAndSquare() is being
invoked on this particuar instance of Square only.
```cpp
#include <cstdio>

class Square {
  private:
    int num;
    int squareOfNum;
  public:
    void enterNumAndSquare (int n)
    {
        num = n;
        squareOfNum = n * n;
    }
    int getNum (void)
    {
        return num;
    }
    int getSquare (void)
    {
        return squareOfNum;
    }
    void printValues (void)
    {
        printf("Square:  num = %d, squareOfNum = %d\n", num, squareOfNum);
    }
};

int main ()
{
    Square sq;

    // Call the member function which prints member data directly
    // Data has not yet been initialized
    sq.printValues();

    sq.enterNumAndSquare(5);

    // Read the member data through accessor functions and print them
    printf("main:  num = %d, squareOfNum = %d\n", sq.getNum(), sq.getSquare());

    // Call the member function which prints member data directly
    sq.printValues();

    return(0);
}
```
When run, the program generates the following output:
```shell
Square:  num = 4, squareOfNum = -4261764
main:  num = 5, squareOfNum = 25
Square:  num = 5, squareOfNum = 25
```
Note that the first line prints garbage from uninitialized member variables


Function Overloading:
---------------------

C++ allows more than one function to have the same name, as long as their
parameter lists differ in type and/or number of parameters.  Return types
are not considered.

So, the following prototypes (and the corresponding functions) could all
coexist within the same C++ program:
```cpp
    int foo(int abc);
    int foo(int abc, int xyz);
    int foo(double abc);
```
The following would generate a conflict with the first prototype, above,
since both have the parameter footprint "<disregarded return type> foo(int)":
```cpp
    double foo(int baz);
```
The C++ compiler generates unique symbol names for each function by
name mangling, which encodes information about the parameter types into
the resulting name.  The linker can then select the correct overloaded
function to match the parameter list passed by the caller.

Member functions within a class can be overloaded in the same way,
subject to the same restrictions.

Function overloading is also known as function polymorphism, a term that
can contribute to dazzling cocktail party conversation.


Constructors:
-------------

Generally, you want to initialize variables in an object instantiated from a
class before you use it.  Perhaps you want to dynamically allocate memory as
well.  A class constructor member function is the tool to use for these jobs.
A constructor is called automatically whenever a class is instantiated.

A default constructor is provided for you which does nothing.  You will have
to write your own constructor if you want to do any useful initialization.

A constructor always has the same name as the class of which it is a member.
So, if we insert the following function in the public section of the Square
class, it will replace the default constructor:
```cpp
    Square ()
    {
        printf("Square:  Constructor called\n");
        
        num = 0;
        squareOfNum = 0;
    }
```
We will discover that our constructor is called before any of the member
functions which generate output.  We can now rely on the fact that the member
variables of any Square object are initialized to 0 before use.

We can manually invoke a different constructor instead, if we want to.  Here
is a constructor which incorporates the functionality of enterNumAndSquare(),
initializing the values within an instantiated Square class based on user
supplied data:
```cpp
    Square (int n)
    {
        printf("Square:  Second constructor called\n");
        
        num = n;
        squareOfNum = n * n;
    }
```
If we add the constructor to the public region of Square, and the following
test code to main():
```cpp
    Square *square = new Square(3);
    square->printValues();
```
We will get the following output:
```shell
Square:  Constructor called
Square:  num = 0, squareOfNum = 0
main:  num = 5, squareOfNum = 25
Square:  num = 5, squareOfNum = 25
Square:  Second constructor called
Square:  num = 3, squareOfNum = 9
```
The added test code invokes new to dynamically allocate a new Square object in
the heap, and then calls our newly-written constructor to initialize it.  square
is assigned a pointer to that object.

Now, we need to use "->" to call the member function printValues().  This is
directly analogous to structure element access:  If you need to dereference,
use an arrow; otherwise, use a dot.

Note that there is no hidden significance to the name square.  As in C, C++
is case sensitive; square is different than Square, so there is no implied
connection between the two other than evocative naming.


Destructors:
------------

A class destructor is useful for cleaning up an object before it is destroyed.
In particular, it's a good place to free any memory which the programmer
explicitly allocated within the class.

A default destructor is provided for you which does nothing.  You need to
write your own destructor to do any meaningful cleanup.

A destructor always has the same name as the class of which it is a member,
prepended by a ~ (tilde).  For instance, if we add the following function
to the public section of the Square class, it will replace the default
destructor:
```cpp
    ~Square ()
    {
        printf("Square:  Destructor called\n");
    }
```
This destructor does nothing useful; we have no dynamic memory to deallocate,
so there's really nothing that needs to be done.

For objects instantiated as stack variables in a function, the destructor is
called automatically when the function goes out of scope (returns).  For
objects created by new, the programmer must explicitly call delete on the
object to cause the destructor to be called.


Updated Square Example:
-----------------------
```cpp
#include <cstdio>

class Square {
  private:
    int num;
    int squareOfNum;
  public:
    Square ()
    {
        printf("Square:  Constructor called\n");
        num = 0;
        squareOfNum = 0;
    }
    Square (int n)
    {
        printf("Square:  Second constructor called\n");
        num = n;
        squareOfNum = n * n;
    }
    void enterNumAndSquare (int n)
    {
        num = n;
        squareOfNum = n * n;
    }
    int getNum (void)
    {
        return num;
    }
    int getSquare (void)
    {
        return squareOfNum;
    }
    void printValues (void)
    {
        printf("Square:  num = %d, squareOfNum = %d\n", num, squareOfNum);
    }
    ~Square ()
    {
        printf("Square:  Destructor called:  num = %d, square = %d\n",
             num, squareOfNum);
    }
};

int main ()
{
    Square sq;

    sq.printValues();
    sq.enterNumAndSquare(5);

    // Read the member data through accessor functions and print them
    printf("main:  num = %d, squareOfNum = %d\n", sq.getNum(), sq.getSquare());

    // Call the member function which prints member data directly
    sq.printValues();

    Square *square = new Square(3);
    square->printValues();

    // Manually delete square, cause destructor to be called
    delete square;

    return(0);
}
```
Running this program generates the following output:
```shell
Square:  Constructor called
Square:  num = 0, squareOfNum = 0
main:  num = 5, squareOfNum = 25
Square:  num = 5, squareOfNum = 25
Square:  Second constructor called
Square:  num = 3, squareOfNum = 9
Square:  Destructor called:  num = 3, square = 9
Square:  Destructor called:  num = 5, square = 25
```
The destructor is never called on square unless we force it to be called
with the delete operator.  delete invokes the destructor (which in this
case is instructive, but pointless) and then frees the dynamic memory
associated with the actual square object.


Default Arguments:
------------------

C++ allows default values to be assigned to some or all of the parameters of
a function or a class member function.  In short, zero or more of the
contiguous, rightmost parameters may have default arguments.  Then, some number
of the rightmost arguments may be omitted when the function or class member
function is called.

For example, consider the prototype for the following function, which has two
default arguments:
```cpp
    int foo(int x, int y = 4, int z = 10);
```
Default arguments are specified by following a variable name with "= <value>"
in the function or member function prototype.  The value represented by
"<value>" is assigned to the parameter if an argument is not provided in some
call to that function.

Any of the following calls are permissible:
```cpp
    baz = foo(3, 14, 15);
    baz = foo(3, 11);      // Same as foo(3, 11, 10);
    baz = foo(2);          // Same as foo(2, 4, 10);
```
These calls are not permissible:
```cpp
    baz = foo(6, , 42);    // Illegal, can only omit rightmost argument(s)
    baz = foo();           // Illegal, first parameter has no default
```

Yet Another Square Example:
---------------------------

Different constructors are called in the two cases where the Square class is
instantiated.  When object sq is created on the stack, the constructor which
matches the default constructor prototype is used.  When object square is
dynamically allocated by new, the constructor used has the prototype with a
single int argument.  We can cause a constructor taking arguments to become
the default constructor if we provide default values for all the arguments.

The previous Square example has been modified by giving a default value to
the parameter of the second constructor.  The first constructor then had to be
removed; the compiler generated an error when confronted with two reasonable
default constructors.

For the sake of variety, num is initialized to -1 by the constructor by
default.  Note that passing an explicit value (such as 3) to the constructor
when square is created overrides the default.
```cpp
#include <cstdio>

class Square {
  private:
    int num;
    int squareOfNum;
  public:
    Square (int n = -1)
    {
        printf("Square:  Second constructor called\n");
        num = n;
        squareOfNum = n * n;
    }
    void enterNumAndSquare (int n)
    {
        num = n;
        squareOfNum = n * n;
    }
    int getNum (void)
    {
        return num;
    }
    int getSquare (void)
    {
        return squareOfNum;
    }
    void printValues (void)
    {
        printf("Square:  num = %d, squareOfNum = %d\n", num, squareOfNum);
    }
    ~Square ()
    {
        printf("Square:  Destructor called:  num = %d, square = %d\n",
             num, squareOfNum);
    }
};

int main ()
{
    Square sq;

    sq.printValues();
    sq.enterNumAndSquare(5);

    // Read the member data through accessor functions and print them
    printf("main:  num = %d, squareOfNum = %d\n", sq.getNum(), sq.getSquare());

    // Call the member function which prints member data directly
    sq.printValues();

    Square *square = new Square(3);
    square->printValues();

    // Manually delete square, cause destructor to be called
    delete square;

    return(0);
}
```
The following output is generated when this program runs:
```shell
Square:  Second constructor called
Square:  num = -1, squareOfNum = 1
main:  num = 5, squareOfNum = 25
Square:  num = 5, squareOfNum = 25
Square:  Second constructor called
Square:  num = 3, squareOfNum = 9
Square:  Destructor called:  num = 3, square = 9
Square:  Destructor called:  num = 5, square = 25
```

Separating Class Declaration From Class Definitions:
----------------------------------------------------

C++ classes are typically divided into a class declaration in a header file
and class definitions in a .cc (or .cpp) source file.

The class declaration specifies class variables and prototypes of class
member functions.  In some cases, typically very small cases, these prototypes
contain code, in which case they are considered inline member functions.
getBase() and getPowers() in Power.h, below, are examples of inline
declarations.

The class definitions consist of the actual member functions which are not
inline.  The class name and scope operator (::) are inserted after the
return type (if any) and immediately in front of the member function name.
This makes it known to which class the member functions belong.  Examples
can be seen in Power.cc, below.


A Slightly More Involved Example:
---------------------------------

This example is cleanly partitioned with  the class declaration in file
Power.h, the class definitions in Power.cc, and the test code in Power_test.cc.

The constructor allocates dynamic memory; the destructor is used to free it
when the object is destroyed.  Also, ComputeOnePower(), a private member
function, is declared.  Any attempt to call ComputeOnePower() from outside
the class will result in an error such as:
`int Power::ComputeOnePower(int, int)' is private.

The Power class computes a range of powers of a base value, starting with
the 0th power.  As the number of powers to compute is not known until the
constructor is called, a dynamic array is allocated to hold the powers.
```cpp
//
// File:  Power.h
//

class Power {
  private:
    int baseNum;
    int numPowers;
    int *powerArr;
    int ComputeOnePower(int base, int power);
  public:
    Power(int base = 2, int powers = 10);
    int getBase (void)    { return baseNum; }
    int getPowers (void)  { return numPowers; }
    int lookupBaseToPower(int power);
    void printPowers(void);
    ~Power();
};


//
// File:  Power.cc
//

#include <cstdio>
#include "Power.h"

int Power::ComputeOnePower (int base, int power)
{
    int result = 1;

    for (int i=1; i <= power; i++) {
        result *= base;
    }
    return result;
}

Power::Power (int base, int powers)
{
    baseNum = base;
    numPowers = powers;
    // Rely on default behavior:  If new fails, exception aborts program
    powerArr = new int[numPowers];

    for (int i=0; i < numPowers; i++) {
        powerArr[i] = ComputeOnePower(baseNum, i);
    }

    printf("Power:  Constructor called:  baseNum = %d, numPowers = %d\n",
         baseNum, numPowers);
}

int Power::lookupBaseToPower (int power)
{
    if (power > -1 && power < numPowers) {
        return powerArr[power];
    }
    return -1;
}

void Power::printPowers (void)
{
    printf("Power:  baseNum = %d, numPowers = %d\n    powers:",
         baseNum, numPowers);
    for (int i=0; i < numPowers; i++) {
        printf("  %d", powerArr[i]);
    }
    printf("\n");
}

Power::~Power ()
{
    printf("Power:  Destructor called:  baseNum = %d, numPowers = %d\n",
         baseNum, numPowers);

    // Free dynamically allocated powerArr array
    delete [] powerArr;
}


//
// File:  Power_test.cc
//

#include <cstdio>
#include "Power.h"

int main ()
{
    Power pwrStack;

    pwrStack.printPowers();

    printf("main:  base = %d, num powers = %d; %d ^ 9 = %d\n",
         pwrStack.getBase(), pwrStack.getPowers(),
         pwrStack.getBase(), pwrStack.lookupBaseToPower(9));

    Power *pwrHeap = new Power(3, 12);
    pwrHeap->printPowers();

    printf("main:  base = %d, num powers = %d; %d ^ 6 = %d\n",
         pwrHeap->getBase(), pwrHeap->getPowers(),
         pwrHeap->getBase(), pwrHeap->lookupBaseToPower(6));

    // This generates a compile error, since the method is private
    // pwrHeap->ComputeOnePower(4, 8);

    // Manually delete pwrHeap, cause destructor to be called
    delete pwrHeap;

    return(0);
}
```
The following output is generated when the program is run:
```shell
Power:  Constructor called:  baseNum = 2, numPowers = 10
Power:  baseNum = 2, numPowers = 10
    powers:  1  2  4  8  16  32  64  128  256  512
main:  base = 2, num powers = 10; 2 ^ 9 = 512
Power:  Constructor called:  baseNum = 3, numPowers = 12
Power:  baseNum = 3, numPowers = 12
    powers:  1  3  9  27  81  243  729  2187  6561  19683  59049  177147
main:  base = 3, num powers = 12; 3 ^ 6 = 729
Power:  Destructor called:  baseNum = 3, numPowers = 12
Power:  Destructor called:  baseNum = 2, numPowers = 10
```

(Maybe you thought with a name like Power(), that this class would help end
the California energy crisis or something; perhaps by using some miraculous
concept like polymorphism.  The only way that's going to work is if you turn
off your computer NOW, go outside, sit under a tree and read a good book.
Preferably one which does not contain the word "polymorphism.")


Building and Testing Programs:
------------------------------

These programs were compiled and tested on the Leland systems, using the g++
compiler.  Here is output from the hacked makefile:
```shell
make cl-ex4
g++ -Wall cl-ex4.cc   -o cl-ex4

make Power
g++ -g   -Wall -c -o Power_test.o Power_test.cc
g++ -g   -Wall -c -o Power.o Power.cc
g++ -o Power Power_test.o Power.o
```
The first example is typical of all of the smaller test programs.  The
multi-file Power example is shown after.

All programs were also compiled using the very strict Comeau C++ compiler at:

http://www.comeaucomputing.com/tryitout/


References:
-----------

Moving from C to C++
The Ins and Outs of Object-Oriented Programming
Greg Perry
C 1992
ISBN 0-672-30080-X

Note:  The preceding book is based on AT&T C++ 3.0,
which book predates ANSI C++.

The C++ Programming Language
Bjarne Stroustrup
(C) 1986

Note:  The preceding book is very much out of date,
but contains interesting historical information.

Bjarne Stroustrup
The C++ Programming Language
Second Edition
(c) 1991

Note:  The preceding book is also out of date.  Refer to the third
edition for current information.

C++ Primer Plus, Fourth Edition
Stephen Prata
(c) 2002
ISBN 0-672-32223-4

Note:  The preceding book describes the ISO/ANSI C++ standard from 1998.

CS 140 Nachos source code

CS 143 source code

C++ Effective Object-Oriented Software Construction
Kayshav Dattatri
(c) 1997
ISBN 0-13-104118-5

Class notes for Berkeley Extension class:
"An Object-Oriented Programming Approach to C++"
Summer 1997
Kayshav Dattatri
(c) 1991-1997

Programming Abstractions in C
A Second Course in Computer Science
Eric S. Roberts
(c) 1998
ISBN 0-201-54541-1

C++ For Programmers, Third Edition
Leen Ammeraal
(C) 2000
ISBN 0-471-60697-9

