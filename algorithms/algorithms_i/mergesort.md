# Mergesort #

- critical components in the world's computational infrstructure.
- jave sort for objects.

algorithm
- divide arrays into two halves
- recursively sort each half
- merge two halves

merging implementation:
```java
private static void merge(Comparable[] a, Comparable[] aux, int lo, int mid, int hi)
{
    // assert is 
    assert isSorted(a, lo, mid);   // precondition: a[lo...mid]   sorted
    assert isSorted(a, mid+1, hi); // precondition: a[mid+1...hi] sorted
    
    for (int k = lo; k <= hi; k++)
        aux[k] = a[k]
    
    int i = lo, j = mid+1;
    for (int k = lo; k <= hi; k++)
    {
        if      (i > mid)               a[k] = aux[i++];
        else if (j > hi)                a[k] = aux[j++];
        else if (less(aux[j], aux[i]))  a[k] = aux[j++];
        else                            a[k] = aux[i++];
    }
    assert isSorted(a, lo, hi); // postcondition: a[lo...hi] sorted
}
```

assertions:
```
java -ea MyProgram // enable assertions
java -da MyProgram // disable assertions (default)
```
- don't use assertions for checking external arguments

sort:
```java
public class Merge
{
    private static void merge(...)
    { /* as before */ }
    
    private static void sort(Comparable[] a, Comparable[] aux, int lo, int hi)
    {
        if (hi <= lo) return;
        int mid = lo + (hi - lo) / 2;
        sort(a, aux, lo, mid);
        sort(a, aux, mid+1, hi);
        merge(a, aux, lo, mid, hi);
    }
    
    public static void sort(Comparable[] a)
    {
        aux = new Comparable[a.length];
        sort(a, aux, 0, a.length - 1);
    }
}
```

- `mergesort` will take 18 min when working on a billion items. 
- it uses at most `NlgN` compares and `6NlgN` array accesses to sort any array of size `N`
- can use _recurrence relation_ to compute time complexity

some imporvement:  
- cutoff to insertion sort for smaller number of items
```java
private static void sort(Comparable[] a, Comaparable[] aux, int lo, int hi)
{
    if (hi <- lo + CUTOFF - 1)
    {
        Insertion.sort(a, lo, hi);
        return;
    }
    int mid = lo + (hi - lo)/2;
    sort (a, aux, lo, mid);
    sort ( a, aux, mid+1, hi);
    merge(a, aux, lo, mid, hi);
}
```
- stop if already sorted
    - is biggest item in first half `<=` smallest item in second half
```java
private static void sort(Comparable[] a, Comparable[] aux, int lo, int hi)
{
    if (hi <= lo) return;
    int mid = lo + (hi - lo)/2;
    sort (a, aux, lo, mid);
    sort (a, aux, mid+1, hi);
    if (!less(a[mid+1], a[mid])) return;
    merge(a, aux, lo, mid, hi);
}
```
- eliminate the copy to the auxiliary array
```java
private static void merge(Comparable[] a, Comparable[] aux, int lo, int mid, int hi)
{
    int i = lo, j = mid+1;
    for(int k = lo; k <= hi; k++)
    {
        if      (i > mid)           aux[k] = a[j++];
        else if (j > hi)            aux[k] = a[i++];
        else if (less(a[j], a[i]))  aux[k] = a[j++]; // merge from a[] to aux[]
        else                        aux[k] = a[i++];
    }
}

private static void sort(Comparable[] a, Comparable[] aux, int lo, int hi)
{
    if (hi <= lo) return;
    int mid = lo + (hi - lo)/2;
    sort (aux, a, lo, mid);
    sort (aux, a, mid+1, hi);   // sort(a) initializes aux[] and sets aux[i] = a[i] for each i 
    merge (a, aux, lo, mid, hi); // switch roles of aux[] and a[]
}
```

## Bottom-up Mergesort ##

- pass through array, merging subarrays of size 1
- repeat for subarrays of size 2, 4, 8, 16 ...

```java
public class MergeBU
{
    private static Comparable[] aux;
    
    private static void merge(Comparable[] 1, int lo, int mid, int hi)
    { /* as before */ }
    
    public static void sort(Comparable[] a)
    {
        int N = a.length;
        aux = new Comparable[N];
        for (int sz = 1; sz < N; sz = sz+sz)
            for (int lo = 0; lo < N-sz; lo += sz+sz)
                merge(a, lo, lo+sz-1, Math.min(lo+sz+sz-1, N-1));
    }
}
```
concise industrial-strength code, if you hav space! 

## Sorting Complexity ##

- Any compare-based sorting algorithm must use at least `lg(N!) ~ NlgN` compares in the worst case.
- this means the lower bound is `Nlg(N)`.
- this means that mergesort is optimal with respect to # compares but __not__ optimal with respect to space.

however, lower bound assumes we don't know the initial order of the input. partially sorted arrays can be sorted faster than `NlgN` by just using insertion sort.

## Comparators ##

Earlier we used JAVA's __comparable interface__, but another interface is the __comparator interface:__ helps us sort using an alternate order. The requirement is that is must be a __total order__.

JAVA system sort:
- create `Comparator` object
- pass a second argument to `Arrays.sort()`

for our `sort` implementations, we can support `Comparator` by:
- using `Object` instead of `Comparable`
- pass `Comparator` to `sort()` and `less()` and use it in `less()`

insertion sort using comparator:
```java
public static void sort(Object[] a, Comparator comparator)
{
    int N = a.length;
    for (int i = 0; i < N; i++)
        for (int j = i; j > 0 && less(comparator, a[j], a[j-1]; j--)
            exch(a, j, j-1);
}

private static boolean less(Comparator c, Object v, Object w)
{ return c.compare(v, w) < 0; }

private static void ech(Object[] a, int i, int j)
{ Object swap = a[i]; a[i] = a[j]; a[j] = swap; }
```

to implement a comparator:
- define a (nested) class that implements the `Comparator` interface.
- implement the `compare()` method
```java
public class Student
{
    // use of static keyword ensures that there is on Comparator for the class
    public static final Comparator<Student> BY_NAME     = new ByName();
    public static final Comparator<Student> BY_SECTION  = new BySection();
    private final String name;
    private final int section;
    ...
    
    private static class ByName implements Comparator<Student>
    {
        public int compare(Student v, Student w)
        { return v.name.compareTo(w.name); }
    }
    
    private static class BySection implements Comparator<Student>
    {
        public int compare(Student v, Student w)
        { return v.section - w.section; } // this technique works because these is no danger of overflow
    }
}
/* Arrays.sort(a, Student.BY_NAME);
   Arrays.sort(a, Student.BY_SECTION); */
```

polar order:
```java
public class Point2D
{
    // one Comparator for each point (not static)
    public final Comparator<Point2D> POLAR_ORDER = new PolarOrder();
    private final double s, y;
    ...
    
    private static int ccw(Point2D a, Point2D b, Point2D c)
    { /* as seen previously */ }
    
    private class PolarOrder implements Comparator<Point2D>
    {
        public int compare(Point2D q1, Point2D q2)
        {
            double dy1 = q1.y - y;
            double dy2 = q2.y - y;
            
            if      (df1 == 0 && dy2 == 0) { ... }      // p, q1, q2 horizontal
            else if (dy1 >= 0 && dy2 < 0) return -1;    // q1 above p; q2 below p
            else if (dy2 >= 0 && dy1 < 0) return +1;    // q1 below p; q2 above p
            else return -ccw(Point2D.this, q1, q2);    // both above or below p
            // 'this' accesses invoking point from within inner class
        }
    }
}
```

## Stability ##

- kinda like multiple-index sort in pandas.
- sort by one field and then another
- entries must remain sorted after second sort with respect to first field  

examining sorting algorithms:  
- insertion sort is stable
    - equal items never move past each other
- selection sort is __not__ stable
    - long-distance exchange might move an item past some equal item
- shell sort is __not__ stable
    - long distance exchange
- mergesort is stable
    - as long as merge operation is stable



