# CPP #

Notes taken from Lynda's Essential Training course

## Data Types ##
```cpp
Integer types	
    char
	short int
	int
	long int
	long long int
Floating point
    float
	double
	long double
Boolean	
    bool 
	Values: true false
Arrays	
Structure and classes	
    Classes - a type of structure
Unions	
Pointers	
    Reference to a value - int *
References	
    int &
```
No Strings! 

__Statements and expressions__

Identifiers 
- `_` used for _private_identifier  
- `__` reserved for __system_use_only  

Identifier scope and storage class
- Storage class and scope are different
- Storage - auto, static, register, extern

__Pointers__ 

Example in C
```cpp
int x = 7; int y = x; 
int * ip;  // integer pointer
ip = &x;    //reference operator or "address of"
int y = *ip;
```

`*` - value of (pointer)  
`&` - address of (variable)

Arrays with pointers
```cpp
int  ia[5];
ia[0] = 0;
int * ip  = ia; 

*ip = 1;
ip++;
*ip=2;
*(++ip) = 3;
```

Strings are actually character arrays.
```cpp
int main(int arg c, char ** argv ){
	char s[] = "string";
	printf("string is: %s\n", s);
	
	for( char * cp = s; *cp; ++cp){
		printf("char is: %c\n", *cp);
	}
	
	return 0;
}
```

## C preprocessor ##

Preprocessor -- > Compiler --> Optimizer --> Linker
```cpp
// notice no semicolon in the end because it is used by preprocessor
#include < … > // file inclusion, directives
#define CONST 1 // string substitution as opposed to - const int iOne = 1;
#define MAX(a,b) ( (a) > (b) ? (a) : (b) ) // more common in C and less in CPP - called a MACRO
#include <stdio.h> // system header location
#include "preproc.h" // specific to projects with " " 
```

preprocessor conditionals : 
```cpp
#if 
#ifdef 
#ifndef
```

__Strings__

- array of characters terminated with an `int 0`
- `char cstring[] = "String";`  
	
`string cppstring = "This is a C++ string.";`  
In CPP, string is actually an object.
Can use functions like:
```cpp
cppstring.begin()
cppstring.end()
cppstring.size()
```	

__qualifiers:__ like - `const static int i = 42;`  
- storage class
    - static
	- register
	- extern
- type qualifiers
	- const
	- volatile
	- mutable

```cpp	
for(int i =0; i < 5; i++){
	static int j = 12;
	j += i;
	printf(" i is %d, j is %d\n", i, j);
}
```

__References:__
```cpp
int i = 5;
int & ir = i;
ir = 10;
printf("i is %d\n", i);
```

structures are data structures and not classes
```cpp
struct employee {
	int id;
	const char * name;
	const char * role;
};

struct employee joe = { 42, "Joe", "Boss" };
struct employee * ep = &joe;
printf("%s is the %s and has id %d\n", ep->name, ep->role, ep->id);
```

```cpp
// bitfields: 1
struct preferences {
	bool likesMusic : 1;
	bool hasHair : 1;
	bool hasInternet : 1;
	bool hasDinosaur : 1;
	unsigned int numberOfChildren: 4;
}; // specifies size

//ternary conditional operator
i > j ? "yes" : "no"
```

__keywords/operators:__ 

- `typedef // for quick initialisation of structures`
- `enum`
- `void` pointer - polymorphic pointer
```cpp
void * func(void *vp){
	return vp;
}
const char * cp = "1234";
int * vp = (int *) func( (void *) cp ); //casting
```	
- `auto`
```cpp
vector<int> i = {1,2,3,4,5};
//either
//for(vector::iterator it=i.begin(); it != i.end; ++it)
//or 
for(auto it = i.begin(); it !=i.end;++it){
	cout << it << endl;
}
```
- `sizeof`
- `typeid`
- `cast`
```cpp
printf("value is %d\n", (int) sizeof(int)); 
printf("value is %d\n", int (sizeof(int)));
```
- `new, delete`
    - every time you use `new`, use `delete`
	- `int * ip = new (nothrow) int [count]`
- `explicit`
- `malloc` and `free`, `calloc`

__Defining functions__

arguments are passed "call by value"
call by reference - need to do it intentionally
```cpp
void f(int *p){
    ++(*p);
}
int a = 1;	
f(&a);
printf("a is %d\n", a);

void f(int &p){
    ++p;
}// call by reference type
int a = 1;	
f(a);
printf("a is %d\n", a);
```
__overloading functions:__ functions can have the same name. compiler calls based on the function signature.

## Classes and Objects ##

- class	
    - based on struct
- object (or instance) 	
    - instance of a class
- members	
    - defaults to private
    - data members / properties
	-  function members / methods
- constructor	
- destructor	
- getters/setters	

classes & objects used to define Data types.
`const safe` - I am not going to do anything that is not `const` safe in this function. `const` objects can only use `const` safe functions in a class.
`this` - gives a pointer to the current object.

__Constructors & Destructors__

__Rule of 3:__ if you overload one of the default functions - you might want to overload all three
to disallow default constructor - make it private, i.e. declare it in private
```cpp
explicit //do not understand
// useful for std::cout
std::ostream & operator << (std::ostream & o, const Rational & r) {
	return o << r.numerator() << '/' << r.denominator();
```

operator overload
```cpp
Rational::operator std::string () const {
	const static int maxstring =64;
	char s[maxstring];
	snprintf(s,maxstring, "%d, %d", _n, _d);
	return std::string(s);
}
```
function object
```cpp
class MultBy {
	int mult;
public:
	MultBy(int n) : mult(n) {}
	int operator () ( int n ) { return mult * n; }
};
```
__Class Inheritance__
- base class	
    - derived class
    - can overload some behaviours
- public 
- protected 
- private
```cpp
class Cat : public Animal, public Fur{
	int petted;
public:
	Cat( string n ) : Animal(n, "cat", "meow"), petted(0) {};
	int pet() { return ++petted; }
};
protected:
	// protected constructor for use by derived classes
	Animal ( const string & n, const string & t, const string & s ) 
	    : _name(n), _type(t), _sound(s) {}

friend class Dog;
friend class Cat;
friend class Pig; // gives derived classes access to private functions - friendship

string Pig::latin() const{
	return string(Animal::name() + "-ay");
}

class Fur {
	string _type;
	Fur(){}  // so that default constructor is not used
protected:
	Fur(const std::string & f) : _type(f) {}
public:
	const string & type() const {return _type;}
};
```
Method overloading and Polymorphism - `virtual`

```cpp
//namespace - sample code
//typically defined in the header files with the class 
//definitions that use them
#include <iostream>

namespace BWString {
    const std::string bws = "This is BWString::string";
    class string {
	    std::string s;
        public:
	        string ( void ) : s(bws) {};
	        string ( const std::string & _s ) : s(bws) {};
	        operator std::string & ( void ) { return s; };
    };
};	// namespace BWString

BWString::string s1("This is a string");
int main( int argc, char ** argv ) {
	std::string s = s1;
	std::cout << s << std::endl;
	return 0;
}
```

```cpp
// a simple class
class ClassR {
	int i;
    public:
	    void setValue( int, double);
	    int getValue();
}; // normally in ClassR.h

// normally in ClassR.cpp
void ClassR::setValue( int value) {
	i = value; 
}

int ClassR::getValue(){
	return i;
}
```

## Templates ##
supports generic programming
```cpp
template <typename T>
T maxof (T a, T b){
	return ( a > b ? a : b);
}
```
__specialization__  
used with `containers`
- caveats
    - may lead to longer build times
	- consufing error messages
template class commonly used to operate on containers.

STD C Library
- file I/O
- strings
- memory allocation
- date and time
- error handling
- other utilities

date and time
```cpp
time_t
*gmtime(& t)
*localtime(& t)
```

```cpp
// join.cpp by Bill Weinman <http://bw.org/>
#include <iostream>
#include <vector>
using namespace std;

template<typename cT, typename retT = cT, typename sepT = decltype(cT::value_type)>
retT joinContainer(const cT & o, const sepT & sep) {
	retT out;
	auto it = o.begin();
	while(it != o.end()) {
		out += *it;
		if(++it != o.end()) out += sep;
	}
	return out;
}

int main( int argc, char ** argv ) {
	string s1("This is a string");
	string s2("This is also a string");
	string s3("Yet another string");

	// join the characters of a string
	cout << joinContainer(s1, ':') << endl;

	// join strings from a vector, returning a string
	vector<string> vs({s1, s2, s3});
	cout << joinContainer<vector<string>, string>(vs, ", ");
	return 0;
}
```

## File I/O ##
```cpp
const char * fn = "text.file";
FILE * fw = fopen(fn, "w");
	fputs(str,fw);
fclose(fw);

FILE * fr = fopen(fn, "r");
	fgets(buf, maxString, fr);
	print(buf);
fclose(fr);

const char * fn2 = "file2";
rename(fn,fn2);
remove(fn2);

const int buffsize = 128;
char os[1024];
snprintf(os, buffsize, "i is %d", i);
puts(os);

strncpy(sd1, s1, maxBuf);	// strncpy -- copy a string
strncat(sd1, " - ", maxBuf - strlen(sd1) - 1);	// strncat -- concatenate string
printf("length of sd1 is %ld\n", strlen(sd1));	// strlen -- get length of string
i = strcmp(sd1, sd2);	// strcmp -- compare strings
cp = strchr(sd1, c);	// strchr -- find a char in string
cp = strstr(sd1, s2);	// strstr -- find a string in string
perror("Couldn't erase file"); //
strerror(errno);
struct stat // data on file. 
```

## Standard Template Library ##
provide containers:
- `vectors`	
    - queue and stack
- `list`	
    - string
- `set`
    - I/O streams
- `map`
    - algorithms
```cpp
// range based iterator
for(int & v : vi1){
	cout << v << " ";
}

// pairs and tuples
pair<int, string> p( 42, "forty-two" );
cout << p.first << " " << p.second << endl;

p = make_pair<int, string>(112, "one-one-two");
cout << p.first << " " << p.second << endl;

tuple<string, string, string> t1( "one", "two", "three" );
cout << get<0>(t1) << " " << get<1>(t1) << " " << get<2>(t1) << endl;

string a, b, c;
tie(a, b, c) = t1;
cout << a << " " << b << " " << c << endl;

// iterator
vector<int> vi1 = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
vector<int>::iterator it;	// vector iterator
vector<int>::iterator beginning = vi1.begin(); // save for later - can also use auto

// input iterator
for(it = vi1.begin(); it < vi1.end(); it++) {
	cout << *it << " ";
}
cout << endl;

// forward iterator allows re-iteration of same set with same results
// use beginning value saved before previous iteration
for(it = beginning; it < vi1.end(); it++) {
	cout << *it << " ";
}
cout << endl;

// bidirectional iterator -- iterate backwards
// allows it--
for(it -= 1; it >= beginning; it--) {
	cout << *it << " ";
}
cout << endl;

// list 
	
cout << "list of ints from initializer list (C++11): " << endl;
list<int> li1 = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
cout << "size: " << li1.size() << endl;
cout << "front: " << li1.front() << endl;
cout << "back: " << li1.back() << endl;

cout << "push_back 47: " << endl;
li1.push_back(47);
cout << "size: " << li1.size() << endl;
cout << "back() " << li1.back() << endl;
```
```cpp
// File Operations

#include <iostream>
#include <iomanip>
#include <fstream>
#include <string>

cout << hex << i; // prints in hex format

string lineno () {
	static int lineint; // declaring static makes sure that the value is incremented in every call
	static char linestr[3];
	if(lineint >= 99) lineint = 0;
	sprintf(linestr, "%02d", ++lineint);
	return string(linestr);
} // function for printing line numbers

const char * filename = "test.txt";
string buffer;	// for reads

// write a file
cout << "write the file:" << endl;
ofstream ofile(filename);
ofile << lineno() << " " << "This is the test file." << endl;
ofile.close();

// read a file
cout << "read the file:" << endl;
ifstream infile(filename);
while (infile.good()) {
	getline(infile, buffer);
	cout << buffer << endl;
}
infile.close();

// append a file
cout << "open file for append:" << endl;
fstream afile(filename, fstream::in | fstream::out | fstream::app );
if(!afile.good()) {
	cout << "failed to open" << endl;
	return 0;
}
cout << "current contents:" << endl;
afile.seekg (0, fstream::beg);	// seek to beginning of file
while (afile.good()) {
	getline(afile, buffer);
	cout << buffer << endl;
}
afile.clear();	// clear error flags after reading to eof

cout << "append lines:" << endl;
afile << lineno() << " " << "This is the test file." << endl;
afile << lineno() << " " << "This is the test file." << endl;
afile << lineno() << " " << "This is the test file." << endl;

cout << "content after append:" << endl;
afile.seekg (0, fstream::beg);	// seek to beginning of file
while (afile.good()) {
	getline(afile, buffer);
	cout << buffer << endl;
}
afile.close();

// delete file
cout << "delete file." << endl;
remove(filename);
```
