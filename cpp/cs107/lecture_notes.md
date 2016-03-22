# CS 107 #

Stanford's [programming paradigms](https://see.stanford.edu/Course/CS107) class by [Jerry Cain](https://twitter.com/jerrycainjr)

Advanced memory management features of C and C++; the differences between imperative and object-oriented paradigms. The functional paradigm (using LISP) and concurrent programming (using C and C++). Brief survey of other modern languages such as Python, Objective C, and C#.

## Data Types ##

* `bool`    :    1 byte
* `char`    :    2 bytes
* `short`    :    4 bytes
* `int`    :    4 bytes
* `long`    :    4 bytes
* `float`    :    4 bytes
* `double`    :    8 bytes

__data type manipulations__

```
char ch = "A";
short s = ch;
cout << s << endl; //65
```

```
short s = 67;
char ch = s;
cout << ch << endl; //"c"
```

```
short s = pow(2,10) + pow(2,3) + pow(2,0);
int i = s;
```

```
int i = pow(2,23) + pow(2,21) + pow(2,15) + 7;
short s = i;
```

__pointer manipulation__

```
int i = 37;
float f = *(float *)&i; //0.00
```

```
float f = 7.0;
short s = *(short *)&f;
```

## Generics in C ##

__swapping two ints:__

```cpp
void swap(int *ap, int *bp)
{
	int temp = *ap;
	*ap = *bp;
	*bp = temp;
};
```

__generic swap:__

```cpp
void swap(void *vp1, void *vp2, int size)
{
	char buffer[size];
	memcpy(buffer, vp1, size);
	memcpy(vp1, vp2, size);
	memcpy(vp2, buffer, size);
}

int x = 17, y = 37;
swap(&x, &y, sizeof(int))

double d = 3.17, e = 2.78;
swap(&d, &e, sizeof(double))

// swapping for char ptr 
char *husband = strdup("Fred");
char *wife = strdup("Wilma");
swap(&husband, &wife, sizeof(char *));
```

__generic lsearch:__

```cpp
void * lsearch(void *key, void *base, int n, int elemSize, int (*cmpfn)(void *, void *))
{
	for (int i=0; i<n; i++)
	{
		void * elemAddr = (char *)base + i*elemSize; // void * hack
		if (cmpfn(key, elemAddr) == 0)
			return elemAddr;
	}
	return NULL;
}

// example search - int
int array[] = {4, 2, 3, 7, 11, 6};
int number = 7;
int * found = lsearch(&number, array, 6, sizeof(int), intCmp);

// int compare function
int intCmp(void *elem1, void *elem2)
{
	int *ip1 = elem1;
	int *ip2 = elem2;
	return *ip1 - *ip2;
}

// example search - str
char *notes = {"Ab", "F#", "B", "Gb", "D"};
char *favoriteNote = "Eb";
char **found = lsearch(&favoriteNote, notes, 5, sizeof(char *), StrCmp);

// string compare function
int StrCmp(void *vp1, void *vp2)
{
	char *s1 = *(char **)vp1;
	char *s2 = *(char **)vp2;
	return *sp1 - *sp1;
}
```

## Preprocessing Commands ##

```cpp
#define kWidth 40
#define kHeight 80
#define kPerimeter 2*(kWidth + kHeight)

// inline functionality - called macros
#define MAX(a,b) (((a) > (b)) ? (a) : (b))

// bad max call
int larger = MAX(m++, n++);
// this evaluates to the following call
int larger = ((m++) > (n++)) ? (m++) : (n++) // increments twice ! 

// something one would like to write to macro
#define NthElemAddr(base, elemSize, index) \
		((char *)base + index*elemSize)

// example usage
void *VectorNth(vector *v, int postion)
{
	// asserts are also macros 
	// can be stripped out of the final code that you ship out
	assert(position >= 0);
	assert(position < v->loglength);
	return NthElemAddr(v->elems, v->elemSize, position);
}
```

what are `asserts` under the hood:
```cpp
#ifdef NDEBUG
	#define assert(cond) (void) 0
#else
	#define assert(cond) (cond) ? ((void) 0) : fprintf(stderr, "..."); exit(0)
#endif
```
this way you can turn off all `assert` statements when using in production code. 

## Compilaton process ##

```cpp
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

// only commenting out assert.h  
// affects at the linking phase
// commenting out stdio, stdlib 
// will not affect compilation and execution
int main()
{
	void *mem = malloc(400);
	assert(mem != NULL);
	printf("yay!");
	free(mem);
	return 0;
}
```
__Note:__ when a function type is inferred, the return value is assumed to be `int`.
```cpp
int main()
{
	int num = 65;
	// strlen call without prototype
	// also, strlen should have one arg
	int length = strlen((char *)&num, num); 
	printf("Length = %d\n", length);
	return 0;
}
```
also, we can manually prototype `int strlen(char *s, int len);` in the beginning of the program if we don't want to inlcude the big header file. 
