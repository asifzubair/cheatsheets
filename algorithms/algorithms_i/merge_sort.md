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

