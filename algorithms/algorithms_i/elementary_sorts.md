# Elementary Sorts #

we want to sort __any__ kind of data. Client might have various types of data.

sort client 1:
```java
public class Experiment
{
	public static void main(String[] args)
	{
		int N = Integer.parseInt(args[0]);
		Double[] a = new Double[N];
		for (int i = 0; i < N; i++)
			a[i] = StdRandom.uniform();
		Insertion.sort(a);
		for (int i = 0; i < N; i++)
			StdOut.println(a[i]);
	}
}
```
sort client 2:
```java
public class StringSorter
{
	public static void main(String[] args)
	{
		String[] a = in.readStrings(args[0]);
		Insertion.sort(a);
		for (int i = 0; i < a.length; i++)
			StdOut.println(a[i]);
	}
}
```
sort client 3:
```java
import java.io.File;
public class FileSorter
{
	public static void main(String[] args)
	{
		File directory = new File(args[0]);
		File[] files = directory.listFiles();
		Insertion.sort(files);
		for (int i = 0; i < files.length; i++)
			StdOut.println(files[i].getName());
	}
}
```

if we use the `Callback` mechanism, a reference to executable code, we can sort any type of data.
- client passes array of objects to `sort()` function
- the `sort()` function calls back objects compareTo() method as needed

implementing callbacks:
- java: `interfaces`
- C: function pointers
- C++: class-type functions
- C#: delegates
- python, perl, ml, javascript: first-class functions

comparable interace - java built-in
```java
public interface Comparable<Item>
{
	public int compareTo(Item that);
}

// if we want to sort files using callback,
// this interface should be implemented by the class
public class File
implements Comparable<File>
{
	...
	public int compareTo(File b)
	{
		...
		return -1;
		...
		retunr +1;
		...
		return 0;
	}
}
```
java built-in types generally implement comparable. 

## Selection Sort ##

- in iteration i, find index min of smallest remaining entry
- swap a[i] and a[min]
```java 
public class Selection
{
	public class void sort(Comaparable[] a)
	{
		int N = a.length
		for (int i = 0; i < N; i++)
		{
			int min = i;
			for (int j = i+1; j < N; j++)
				if (less(a[j], a[min]))
					min = j;
			exch(a, i, min);
		}
	}
	
	private static boolean less(Comparable v, Comparable w)
	{ /* as before */ }
	private static void exch(Comparable[] a, int i, int j)
	{ /* as before */ }
}
```
time complexity is `O(N^2)`, even if input is sorted!

## Insertion Sort ##

i think this is similar to __bubble sort__. 
- in iteration `i`, swap `a[i]` with each larger entry to its left
```java
public class Insertion
{
	public static void sort(Comparable[] a)
	{
		int N = a.length;
		for (int i = 0; i < N; i++)
			for (int j = i; j > 0; j--)
				if (less(a[j], a[j-i]))
					exch(a, j, j-1);
				else break;
	}
	
	private static boolean less (Comparable v, Comparable w)
	{ /* as before */ }
	
	private static void exch(Comparable[] a, int i, int j)
	{ /* as before */ }
}
```
__Note:__ for partially sorted arrays, insertion sort takes linear time.

## Shellsort ##

- move entries more than one position at a time by __h-sorting__ the array.
- to __h-sort__ an array, we use insertion sort with stride length _h_.

__proposition:__ a g-sorted array remains g-sorted after h-sorting it.

what should be the increment sequence?
- powers of two: does not work
- powers of two minus one: maybe
- knuth: `3x + 1`
- sedgewick: 1, 5, 19, 41, 109, 209, 505 - tough to beat in empirical studies
	- merging of `(9*4^i) - (9*2^i) + 1` and `4^i - (3*2^i) + 1`

```java
public class Shell
{
	public static void sort(Comparable[] a)
	{
		int N = a.length;
		
		int h = 1;
		while (h < N/3) h = 3*h +1;
		
		while (h >= 1)
		{ // h-sort the array
			for (int i = h; i < N; i++)
			{
				// cool 'for loop' 
				for (int j = i; j >= h && less(a[j], a[j-h]); j -= h)
					exch(a, j, j-h);
			}
			
			h = h/3;
		}
	}
	
	private static boolean less(Comparable v, Comparable w)
	{ /* as before */}
	private static void exch(Comparable[] a, int i, int j)
	{ /* as before */}
}
```

## Shuffling ##

one way:
- generate a random real number for each array entry
- sort the array

knuth shuffle:
- in iteration `i`, pick integer r between `0` and `i` uniformly at random.
- swap `a[i]` and `a[r]`
```java
public class StdRandom
{
	...
	public static void shuffle(Object[] a)
	{
		int N = a.length;
		for (int i = 0; i < N; i++)
		{
			int r = StdRandom.uniform(i + 1);
			exch(a, i , r);
		}
	}
}
```

## Covex Hull ##

convex hull of a set of N points is the smallest perimeter fence enclosing the points.  
- We can use the __Graham scan__ algorithm to figre out the convex hull.
- this invloves defining what is a counter clockwise algorithm
```java
public class Point2D
{
	private final double x;
	private final double y;
	
	public Point2D(double x, double y)
	{
		this.x = x;
		this.y = y;
	}
	...
	public static int ccw(Point2D a, Point2D b, Point2D c)
	{
		double area2 = (b.x-a.x)*(c.y-a.y) - (b.y-a.y)*(c.x-a.x); 
		// be careful: danger of floating point round-off error in (b.y-a.y)*(c.x-a.x)
		if		(area2 < 0) return -1 // clockwise
		else if	(area2 > 0) return +1 // counter-clockwise
		else				return 0; // collinear
	}
}
```
Using `ccw` method, we can implement the Graham scan:
```java
Stack<Point2D> hull = new Stack<Point2D>();

Arrays.sort(p, Point2D.Y_ORDER); // p[0] is point wiht lowest y-coordinate
Arrays.sort(p, p[0].BY_POLAR_ORDER); // sort by polar angle with respect to p[0]

hull.push(p[0]); // definitely on hull
hull.push(p[1]);

for (int i = 2; i < N; i++){
	Point2D top = hull.pop();
	while (Point2D.ccw(hull.peek(), top, p[i] <= 0)
		top = hull.pop();
	hull.push(top);
	hull.push(p[i]);
}
```
