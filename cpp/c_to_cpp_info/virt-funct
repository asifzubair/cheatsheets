Virtual Functions in C++
Pete Belknap
Version 0.2

This version incorporates feedback from Eric Albert.


The Long Description
-----------------------------------
In C++ you're allowed to declare a member function 'virtual', which,
like most things in C and C++, has a meaning far from that of the word
itself.  Suppose you've graduated, and sold out to work for the krispy
kreme corporation.  You've got a donut class where you've implemented
all the functionality common to all donuts.  Your donut class looks like...

<<donut.h>>

#include <string>

class Donut {
     public:
         Donut();
         ~Donut();
         long getCalories();
         void eatDonut(Person *p);

     protected:
         long calories;
         string description;

};

(Don't forget that last semicolon!) And the eatDonut function, in
donut.cpp, looks like

void Donut::eatDonut(Person *p) {
     p->metabolize(calories);
     cout << "mmm...  donut" << endl;
}

Now, since you have to implement all donuts,  maybe you want to support
those hot glazed donuts they give you for free,  and you want to change
the eatDonut message printed.  So you'll want to create a subclass of
Donut to leverage its functionality, and you'll write a class like

class HotGlazedDonut: public Donut {
     public:
         HotGlazedDonut();
         ~HotGlazedDonut();
         void eatDonut(Person *p);
};

And you'll implement it as:

void HotGlazedDonut::eatDonut(Person *p) {
     p->metabolize(calories);
     cout << "hot gooey donuts are the best" << endl;
}

So here comes the interesting part.  Suppose you have the following code
somewhere else in your program:

Donut *donuts[50];
Person *p = new Person();

readDonutsFromFile(donuts);
for (i = 0; i < 50; i++) donuts[i]->eatDonut(p);

The trick is that some of the donuts are just regular Donuts, and some
are HotGlazedDonuts.  If you're a java baby, you'll expect that either
way, the right thing happens -- if it's a Donut, it prints "mmm..
donut", and if it's a HotGlazedDonut, it prints "hot gooey donuts are
the best".  However, no such luck.  You run this program and for every
donut it prints "mmm... donut".   To get it to print "hot gooey donuts
are the best" you'll need to declare the function virtual in both .h
files (not the .cpp's), such as 'public virtual void eatDonut (Person
*p);'  Otherwise C++ always calls the method in the compile-time type of
your variable (in this case, Donut and not HotGlazedDonut).

The Short Answer
-------------------
Always declare your functions virtual in the superclass if you intend on
overriding it in a subclass.  Just declaring it virtual in the subclass
won't work - it needs to be done in the superclass.

The Implementation Details
------------------
You might think that C++'s default behavior here is a bit dumb.  The
reason it does this is if you don't declare a function virtual the
compiler can figure out the address to jump to at compile time, but if
it is virtual, it needs to wait until runtime to figure out what code to
jump to.  Java doesn't care about the inefficiency in the latter, so it
implements all methods (except final and static methods) as virtual.
An important design goal was to make C++ about as fast as C, so the extra
inefficiency wasn't acceptable.

You might wonder how the compiler finds the right eatDonut() to call at
runtime if the function is virtual.  In a typical implementation (the
details vary from compiler to compiler) the object contains a vtable,
which is a table of function (method) pointers.  This table lists each
virtual method along with the address of its compiled code.  So every
call to a virtual method requires dereferencing the object pointer,
dereferencing a pointer to the vtable, and then doing a lookup in the
vtable, which was just way too slow to do on every function call back
in the day.

Note that any object which has no virtual methods has no vtable.  This
streamlines the method calls by eliminating the vtable lookup and pointer
dereference.

