## Elementary Sorts ##

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
