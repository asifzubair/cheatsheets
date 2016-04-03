# CS 107 #

Stanford's [programming paradigms](https://see.stanford.edu/Course/CS107) class by [Jerry Cain](https://twitter.com/jerrycainjr)

Advanced memory management features of C and C++; the differences between imperative and object-oriented paradigms. The functional paradigm (using LISP) and concurrent programming (using C and C++). Brief survey of other modern languages such as Python, Objective C, and C#.

## L2/3 - Data Types ##

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

## L4/5 - Generics in C ##

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

## L12 - Preprocessing Commands ##

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

## L13 - Compilaton process ##

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
```c
// this code can be evaluated by 
// considering how the stack is populated
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

slightly complicated version of `while(True)`:
```c
int main()
{
	int i;
	int array[4];
	for (i=0; i<=4; i++){
		array[i] = 0;
	}
	return 0;
}
```
the following code will decrement the `saved PC` by 4:
```c
void foo()
{
	int array[4];
	int i;
	for (i=0; i<=4; i++){
		array[i] -= 4;
	}
}
```
because of the decrement, it will call `foo` again.

## L14 - printf ##

```c
int main( int argc, char *argv[])
{
	DeclareAndInitArray();
	PrintArray();
}

void DeclareAndInitArray()
{
	int array[100];
	int i;
	for (i=0; i<100; i++)
		array[i]=i;
}

void PrintArray()
{
	// naming array as in decalare function will not be helpful
	// however, how it is called in main()
	// printarray will still print out 0-99
	int array[100];
	int i;
	for(i=0; i<100; i++)
		printf("%d\n", array[i]);
}
```

```c
int printf(const char * control, ...);

printf("Hello\n");
printf("%d + %d = %d\n", 4, 4, 8); //2
```
in 2 above, `printf` will look above the stack and infer the types based on what information is passed. 

## L14/15 - Sequential to Concurrent ##

selling airline tickets:
```c
// agents sell tickets
void SellTickets (int agent ID, int numTicketsToSell)
{
	while (numTicketsToSell > 0){
		printf("Agent %d sells a ticket\n", agentNo);
		numTicketsToSell--;
	}
	printf (Agent %d: All done!\', agentNo)
}
```

```c
// called in simple for loop
int main()
{
	int numAgents = 10;
	int numTickets = 150;
	
	for (int agent = 1; agent <= numAgents; agent++){
		SellTickets(agent, numTickets/numAgents);
	}
	
	return 0;
}
```

we can use threading to simultaneously sell tickets:
```c
void SellTickets (int agent ID, int numTicketsToSell)
{
	while (numTicketsToSell > 0){
		printf("Agent %d sells a ticket\n", agentNo);
		numTicketsToSell--;
		// with some randomization, some threads are made to sleep
		if(RandomChance(0.1)) ThreadSleep(1000);
	}
	printf (Agent %d: All done!\', agentNo)
}
```

```c
int main()
{
	int numAgents = 10;
	int numThreads = 150;
	
	initThreadPackage(false);
	for (int agent; agent <= numAgents; agent++){
		char name[32];
		sprintf(name, "Agent %d Thread", agent);
		ThreadNew(name, SellTickets, 2, agent, numTickets/numAgents);
	}
	RunAllThreads();
	return 0;
}
```
