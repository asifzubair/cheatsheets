# Stacks and Queues #

modular programming:
- separate interface and implementation.
- the details of the implementation should be completely separated from the client.
- __also__, implementation can't know details of client needs => many clients can re-use the same implementation.
- design: allows modular reusable libraries.
- performance: use optimized implementation where it matters.

## Stacks ##

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

## Resizing arrays ##

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

## Queues ##

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

### queues using resizing arrays ###

```cpp
public class FixedCapacityQueue
{
	
}
```

## Generics ##

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

## Iterators ##

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

## Stack and Queue Applications ##

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
