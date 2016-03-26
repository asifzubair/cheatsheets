# Algorithms I #

## Introduction ##

Bad programmers worry about the code. Good programmers worry about data structures and their relationships. - Linus Torvalds.  
Algorithms + Data Sturctures = Programs - Niklaus Wirth. also, should check out his [book](http://www.amazon.com/Algorithms-Structures-Prentice-Hall-Automatic-Computation/dp/0130224189/ref=asap_bc?ie=UTF8).  

## Union-Find ##

**Dynamic Connectivity**

* union command : connect two objects  
* find/connected query - is there a path connecting the two objects ?  

We are **only** trying to ask the question whether objects/nodes are connected and not interested in the path. Of course, a connection is equivalence - reflexive, symmetric and transitive. 

JAVA model

```java
public class UF
	UF(int N) 
	void union(int p, int q)
	bool connected(int p, int q)
```

dynaimic-connectivity client
```java
public static void main(String[] args) {
	int N = StdIn.readInt();
	UF uf = new UF(N);

	while (!StdIn.isEmpty()) {
		int p = StdInt.readInt();
		int q = StdInt.readint();

		if (!uf.connected(p,q)) {
			uf.union(p,q);
			StdOut.println(p + " " + q);
		}
	}
}
```

### Quick-find ###

greedy algorithm

**data structure**

- `int` arrary `id[]` of size `N`.  
- `p` and `q` are connected iff they have the same id.  

`union(p,q)` means that the `id` of p and q and all elements connected to them to the same `id`.  

**java implementation**

```java
public class QuickFindUF {
	private int[] id;

	public QuickFindUF(int N) {
		id = new int[N];
		for (int i = 0; i < N; i++)
			id[i] = i;
	}

	public boolean connected(int p, int q) {
		return id[p] == id[q];
	}

	public void union(int p, int q) {
		\\ store ids before re-setting. 
		int pid = id[p];
		int qid = id[q];
		for (int i = 0; i < id.length; i++){
			if (id[i] == pid) id[i] = qid;
		}
	}
}
```

however, `quick-find` is rather slow, becasue union is too expensive. (worst case N^2)

### Quick-Union ###

lazy approach. 


```java
public class QuickUnionUF {
	private int[] id;

	public QuickFindUF(int N) {
		id = new int[N];
		for (int i = 0; i < N; i++) id[i] = i;
	}

	private int root(int i) {
		while (i != id[i]) i = id[i]
		return i;
	}

	public boolean connected(int p, int q) {
		return root(p) == root(q);
	}

	public void union(int p, int q) {
		int i = root(p);
		int q = root(q);
		id[i] = j;
	}
}
```

this approach suffers in the **find** operation, the trees might get really big and then to **find** if two nodes are connected might take linear time. so, basically, we are going for sub-linear time. 

### Quick-Union Improvements ###

a qucik improvement would be to not let the trees get very deep. use a **weighted** algorithm to move the smaller tree - this way not item is too far from the tree. this improvement is really effective for large number of nodes. 

```java
publlic class QuickUnionUF {
	private int[] id;
	private int[] sz;

	public QuicUnionUF(int N) {
		id = new int[N];
		for(int i = 0; i < N; i++) {
			id[i] = i;
			sz[i] = 1;
		} 
	}

	private int root(int i) {
		while(i != id[i]) i = id[i];
		return i;
	}

	public boolean connected(int p, int q) {
		return root(p) == root(q);
	}

	public void union(int p, int q) {
		int i = root(p);
		int j = root(q);
		if(i == j) return;
		if (sz[i] < sz[j]) {
			id[i] = j; 
			sz[j] += sz[i];
		} else {
			id[j] = i; 
			sz[i] += sz[j];
		}
	}
}
```

another improvement is **path compression**

**two-pass variant:** add second loop to `root()` to set the `id[]` of each examined note to the root.  
**one-pass variant:** make every other node in path point to its grandparent (thereby halving path length).

```java
// one pass-variant
private int root(int i) {
	while (i != id[i]) {
		id[i] = id[id[i]];
		i = id[i];
	}
	return i;
}
```

wow ! learnt a new function today `lg*`, number of times to take log of some number to get 1, typically can think of it as a number less than 5 - becasue if `N = 2^65536` then `lg*N = 5`.  

So, the **weighted quick-union with path compression** algorithm is a simple one with fascinating mathematics.  

**algorithm design enables quicker solution**

### Union-Find Applications ###

* percolation  
* dynamic connectivity  
* **kruskal's** minimum spanning tree algorithm
...

## PA1: Percolation ##

percolation can be used as a model for electricity, fluid flow and social networks ! wow!  

for a random percolator, if we chose a site being open with some probability - then at intermediates probabilities, it is still open to find out if a system percolates or not. this can be answered using computational simulations.  

a **brute-force** solution would be to say that the system percolates iff any site on bottom row is connected to site on top row - this will have `N^2` calls to `connected()`. an ingenious solution is to create a two virtual sites connected to top row and bottom row respectively and then simply check if those two are connected.  

* open site is connected to all its adjacent open sites.  

### assignement ###

while this is a great exercise - i think i will read a few notes from stanford's [cs108](http://web.stanford.edu/class/cs108) - to get my programming style in order. 

The programming assignment is [here](http://coursera.cs.princeton.edu/algs4/assignments/percolation.html) and 
instructions are [here](https://class.coursera.org/algs4partI-010/assignment/view?assignment_id=1). There is a useful checklist [here](http://coursera.cs.princeton.edu/algs4/checklists/percolation.html).

Check out the case study for percolation on the booksites 
for [algorithms](http://algs4.cs.princeton.edu/15uf) and [java](http://introcs.cs.princeton.edu/java/24percolation). 

instructions on using the `algs4` library is [here](http://algs4.cs.princeton.edu/mac).

Two useful resources/programs are [checkstyle](http://checkstyle.sourceforge.net) and [findbugs](http://findbugs.sourceforge.net).

**trouble shooting and notes**  

this forum [post](https://class.coursera.org/algs4partI-010/forum/thread?thread_id=413) gave me a better handle on how to get the `Percolation` class and `WeightedQuickUnionUF` class to play together.  

## Analysis of Algorithms ##

### Memory ###

- 1byte - 8bits
- 1MB - 2^20 bytes
- 1GB - 2^30 bytes
- 32-bit machine - 4 byte pointers
- 64-bit machine - 8 byte pointers

|type|bytes|
|:--:|:---:|
|boolean|1|
|byte|1|
|char|2|
|int|4|
|float|4|
|long|8|
|double|8|
|`char[]`|2N+24|
|`int[]`|4N+24|
|`double[]`|8N+24|
|`char[][]`|~2MN|
|`int[][]`|~4MN|
|`double[][]`|~8MN|

- array: 24bytes + memory for each array entry

objects in JAVA

- object overhead 16 bytes
- reference 8 bytes
- padding each object uses a multiple of 8 bytes

ex:
```java
public class Date
{
	private int day;
	private int month;
	private int year;
		...
} // will take 32 bytes

public class String
{
	private char[] value; // reference to array 8bytes & 2N+24 bytes for the char[] array
	private int offset;
	private int count;
	private int hash;
		...
} // a virgin string of length N uses ~2N bytes of memory
```

## Stacks and Queues ##

modular programming:
- separate interface and implementation.
- the details of the implementation should be completely separated from the client.
- __also__, implementation can't know details of client needs => many clients can re-use the same implementation.
- design: allows modular reusable libraries.
- performance: use optimized implementation where it matters.

### Stacks ###

test client:
```java
public static void main(String[] args)
{
	StackOfStrings stack = new StackOFStrings();
	while (!StdIN.isEmpty())
	{
		String s = StdIn.readString();
		if(s.equals("-")) StdOut.print(stack.pop());
		else			  stack.push(s);
	}
}
```

stack implementation using linked lists:
```java
public class LinkedStackOfStrings{
	private Node first = null;
	
	private class Node
	{
		String item;
		Node next; // references another object of node class.
	}
	
	public boolean isEmpty()
	{ return first == null; }
	
	public void push(String item)
	{
		Node oldfirst = first;
		first = new Node();
		first.item = item;
		first.next = oldfirst;
	}
	
	public String pop()
	{
		String item = first.item;
		first = first.next;
		return item;
	}
}
```

to delete last element in a null-terminated linked-list:
```java
Node x = first;
while(x.next.next != null){
	x = x.next;
}
x.next = null;
```

array implementation:
```java
public class FixedCapacityStackOfStrings
{
	private String[] s;
	private int N = 0;
	
	public FixedCapacityStackOfStrings(int capacity)
	{ s = new String[capacity]; }

	public boolean isEmpty()
	{ return N == 0; }
	
	public void push(String item)
	{ s[N++] = item; } // use to index into the array; then increment N
	
	public String pop()
	{ return s[--N]; } // decrement N; then use to index into array
}
```

considerations:
- underflow: pop from empty stack 
- overflow: can use resizing array for array implementation
- null items: we allow nnull items to be inserted
- loitering: holding reference to an object when it is no longer needed
```java
// to prevent loitering
public String pop()
{ return s[--N]; }

// should be
public String pop()
{
	String item = s[--N];
	s[N] = null;
	return item;
}
```

### Resizing arrays ###

```java
public ResizingArrayStackOfStrings()
{ s = new String[1]; }

public void push(String item)
{
	if (N == s.length) resize(2 * s.length);
	s[N++] = item;
}

public String pop()
{
	String item = s[--N];
	S[N] = null;
	if (N > 0 && N == s.length/4) resize(s.length/2);
	return item;
}

private void resize(int capacity)
{
	String[] copy = new String[capacity];
	for(int i = 0; i < N; i++)
		copy[i] = c[i]
	s = copy;
}
```

### Queues ###

```java
public class LinkedQueueOfStrings
{
	private Node first, last;
	
	private class Node
	{
		String item;
		Node next;
	}
	
	public boolean isEmpty()
	{ return first == null; }
	
	public void enqueue(String item)
	{
		Node oldlast = last;
		last = new Node();
		last.item = item;
		last.next = null;
		if (isEmpty()) first = last;
		else		   oldlast.next = last;
	}

	public String dequeue()
	{
		String item = first.item;
		first = first.next;
		if (isEmpty()) last = null;
		return item;
	}
}
```

#### queues using resizing arrays ####

```cpp
public class FixedCapacityQueue
{
	
}
```

### Generics ###

how to implement a parameterized stack - with different data types: `StackOfURLs`, `StackOfInts`, `StackOfVans` ...

Use Java Generics!
```java
Stack<Apple> s = new Stack<Apple>();
Apple a  = new Apple();
Orange b = new Orange();
s.push(a);
// pushing an orange will throw a compiler error
// s.push(b);
a = s.pop();
```

generic implementation using linked list:
```java
public class Stack<Item>
{
	private Node first = null;
	
	public class Node
	{
		Item item;
		Node next;
	}
	
	public boolean isEmpty()
	{ retrun first == null; }
	
	public void push (Item item)
	{
		Node oldfirst = first;
		first = new Node();
		first.item = item;
		first.next = oldfirst;
	}

	public Item pop()
	{
		Item item = first.item;
		first = first.next;
		return item;
	}
}
```

generic implementation using arrays:
```java
public class FixedCapacityStack<Item>
{
	private Item[] s;
	private int N = 0;
	
	// need a cast here as
	// JAVA doesn't allow generic arrays!!
	public FixedCapacityStack(int capacity)
	{ s = (Item[]) new Object[capacity]; }
	
	public boolean isEmpty()
	{ return N == 0; }
	
	public void push(Item item)
	{ s[N++] = item }
	
	public Item pop()
	{ return s[--N]; }
}
```
__Sedgewick__ says: Good code should have zero cast! 

### Iterators ###

Support to iterate over stack items by client, without revealing internal representation of the stack.  
to do this, Make the stack implement `Iterable` interface!

iterable:
```java
// has a method that returns an Iterator
public interface Iterable<item>
{
	Iterator<Item> iterator();
}
```

iterator interface:
```java
public interface Iterator<Item>
{	
	// should have the following functions
	boolean hasNext();
	Item next();
	
	// can optionally have remove
	// be careful with this!
	void remove();
}
```

this allows very compact `foreach` client code
```java
for (String s: stack)
	StdOut.println(s);

// as opposed to 
// equivalent longhand code

Iterator<String> i = stack.iterator();
while (i.hasNext())
{
	String s = i.next();
	StdOut.println(s);
}
```

Stack Iterator:
```java
import java.util.Iterator;

public class Stack<Item> implements Iterable<Item>
{
	...
	public Iterator<Item> Iterator() { return new ListIterator(); }
	
	private class ListIterator implements Iterator<Item>
	{
		private Node current = first;
		
		public boolean hasNext() { return current != null; }
		public void remove() { /* not supported */ }
		public Item next()
		{
			Item item = current.item;
			current = current.next;
			return item;
		}
	}
}
```

array implementation:
```java
import java.util.Iterator;

public class Stack<Item> implements Iterable<Item>
{
	...
	public Iterator<Item> iterator()
	{ return new ReverseArrayIterator(); }
	
	private class ReverseArrayIterator implemenets Iterator<Item>
	{
		private int i = N;
		
		public boolean hasNext() { return i > 0; }
		public void remove() { /* not supported */ }
		public Item next() { return s[--i]; }
	}
}
```

__bag API__: adding items to a collection and iterating (order doesn't matter)
```java
public class Bag<item> implements Iterable<item>

					Bag()
			void	add(Item x)
			int 	size()
	Iterable<Item>	iterator()
```
implementation: Stack (without pop) or queue (without dequeue)

### Stack and Queue Applications ###

JAVA collections library

__List interface:__ `java.util.list` is API for a sequence of items.
```java
public interface List<Item> implements Iterable<Item>
					List()
			boolean	isEmpty()
			int		size()
			void	add(Item item)
			Item	get(int index)
			Item	remove(int index)
			boolean	contains(Item item)
	Iterator<Item> 	iterator()
	...
```
__implementations:__ `java.util.ArrayList` uses resizing array; `java.util.LinkedList` uses linked list. __note:__ only some operations are efficient.

not always efficient to use native implementations
- `java.util.Stack`: bloated and poorly-designed API
- `java.util.Queue`: an interface, not implementation of queue
so, __DO NOT__ use a library until you understand its API!

Stack applications:
- parsing in a compiler
- java virtual machine
- undo in a word processor
- implementing function calls in a compiler
	- function call: `push` local env and return address
	- return: `pop` return address and local env
	...

__Dijkstra's two stack algorithm__ for computing an arithmetic expression:
```java
pulic class Evaluate
{
	public static void main(String[] args)
	{
		Stack<String> ops = new Stack<String>();
		Stack<Double> vals = new Stack<Double>();
		while (!Std.In.IsEmpty()) {
			String s = StdIn.readString();
			if		(s.equals("("))			       ;
			else if	(s.equals("+"))		ops.push(s);
			else if	(s.equals("*"))		ops.push(s);
			else if	(s.equals(")"))
			{
				String op = ops.pop();
				if		(op.equals("+")) vals.push(vals.pop() + vals.pop());
				else if	(op.equals("*")) vals.push(vals.pop() * vals.pop());
			}
			else vals.push(Double.parseDouble(s));
		}
		StdOut.println(vals.pop());
	}
}
// % java Evaluate ( 1 + ( ( 2 + 3 ) * ( 4 * 5 ) ) )
// 101.0
```

## PA2: Randomized Queues and Deques ##

The assignment is [here](https://class.coursera.org/algs4partI-010/assignment/view?assignment_id=3). The assignment specifcation is [here](http://coursera.cs.princeton.edu/algs4/assignments/queues.html) and a useful checklist [here](http://coursera.cs.princeton.edu/algs4/checklists/queues.html).
