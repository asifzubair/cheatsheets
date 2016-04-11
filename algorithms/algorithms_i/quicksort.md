# Quicksort #

- top 10 algorithms of the 20th century
- java sort for primitive types
- recursion based, but does recursion after it does the work 

plan:
- shuffle the array
- partition such that for some `j`
    - entry `a[j]` is in place
    - no large entry to the left of `j`
    - no smaller entry to the right of `j`
- sort each piece recursively

partitioning code:
```java
private static int partition(Comparable[] a, int lo, int hi)
{
    int i = lo, j = hi + 1;
    while(True)
    {
        // find item on left to swap
        while (less(a[++i], a[lo]))
            if (i == hi) break; 
        
        // find item on the right to swap
        while (less(a[lo], a[--j]))
            if (j == lo) break;
        
        if (i >= j) break; // check if pointers cross
        exch(a, i, j); // swap
    }
    
    exch(a, lo, j); // swap with partitioning item
    return j; // return index of item now known to be in place
}
```

quick sort:
```java
public class Quick
{
    private static int partition(Comparable[] a, int lo, int hi)
    { /* as above */ }
    
    public static void sort(Comparable[] a)
    {
        // shuffle needed for performance guarantee
        Std.Random.shuffle(a);
        sort(a, 0, a.length - 1);
    }
    
    private static void sort(Comparable[] a, int lo, int hi)
    {
        if (hi <= lo) return;
        int j = partition(a, lo, hi);
        sort(a, lo, j-1);
        sort(a, j+1, hi);
    }
}
```

- partitions in-place: thus doesn't take extra space
- terminating loops: can be tricky to test whether the pointer cross
- staying in bounds: the `j == lo` test is redundant, but `i == hi` is not
- shuffling is __needed__ for performance guarantee
- equal keys: when duplicates present, it is better to stop on keys equal to the patitioning item's key. 

time complexity:
- best case: `NlgN` 
- worst case: `(1/2)*N^2`
- but faster than mergesort because of less data movement
- lots of duplicates might imply quadratic time
- not stable: partioning does long range exchanges

practical improvements:
- cutoff to insertion sort for ~10 items
```java
private static void sort(Comparable[] a, int lo, int hi)
{
    if ( hi <= lo + CUTOFF - 1)
    {
        Insertion.sort(a, lo, hi);
        return;
    }
    int j = partition(a, lo, hi);
    sort(a, lo, j-1);
    sort(a, j+1, hi);
}
```
- estimate partioning element to be near the middle
    - median-of-3 (random) items
```java
private static void sort(Comparable[] a, int lo, int hi)
{
    if (hi <= lo) return;
    
    int m = medianOf3(a, lo, lo + (hi - lo)/2, hi);
    swap(a, lo, m);
    
    int j = partition(a, lo, hi);
    sort(a, lo, j-1);
    sort(a, j+1, hi);
}
```

## Selection ##

Given an array of N items, find the kth largest. 

partition array:
- entry a[j] is in place
- no larger entry in the left of `j`
- no smaller entry to the right of `j`

repeat only __one__ subarray, depending on j, finshed when j equals k.
```java
public static Comparable select(Comparable[] a, int k)
{
    StdRandom.shuffle(a);
    int lo = 0, hi = a.length - 1;
    while(hi > lo)
    {
        int j = partition(a, lo, hi);
        if      (j < k) lo = j + 1;
        else if (j > k) hi = j - 1;
        else            return a[k];
    }
    return a[k];
}
```

- Quick-select takes __linear__ time on average. And is quadratic in the worst case.
- an select algorithm where worst case is linear exists, but is impractable as the constants are too high.

## Duplicate Keys ##

- mergesort with equal keys: always between `1/2NlgN` and `NlgN` compares.
- quicksort algorithm goes __quadratic__ unless partitioning stops on equal keys.
- if you put all items equal to the partitioning item on one side, then in case of equal keys , partitioning item will be way too side.
- however, most desirable is to put all items equal to the partitioning item in place, 3-way partioning

3-way partitioning:
- entries between `lt` and `gt` equal to partition item `v`
- no larger entries to left of `lt`
- no smaller entries to the right of `gt`

scheme:
- let `v` be partitioning item `a[lo]`
- scan `i` from left to right
    -  `(a[i] < v)`: exchange `a[lt]` with `a[i]`; increment both `lt` and `i`
    -  `(a[i] > v)`: exchange `a[gt]` with `a[i]`; decrement `gt`
    -  `(a[i] == v)`: increment `i`
```java
private static void sort(Comparable[] a, int lo, int hi)
{
    if (hi <= lo) return;
    int lt = lo, gt = hi;
    Comparable v = a[lo];
    int i = lo;
    while ( i <= gt)
    {
        int cmp = a[i].compareTo(v);
        if      (cmp < 0) exch(a, lt++, i++);
        else if (cmp > 0) exch(a, i, gt--);
        else              i++;
    }
    
    sort(a, lo, lt - 1);
    sort(a, gt + 1, hi);
}
```
## System Sorts ##

use sorting to make problem easy:
- finding duplicates
- identify statistical outliers
- binary search in a database
non-obvious applicaitons:
- data compression
- computer graphics
- load balancing on a parallel computer

java system sort, `Arrays.sort()`:
- has different method for each primitive type
- has a method for data types that implement Comparable
- has a method that uses a comparator
- has tuned quicksort for primitive types; tuned mergesort for objects
    - The Java API for `Arrays.sort()` for reference types requires that it is stable and that it offers guaranteed `NlogN` performance. Neither of these are properties of standard quicksort.
    - Quicksort uses less memory and is faster in practice on typical inputs (and is typically used by `Arrays.sort()` when sorting primitive types, where stability is not relevant).
```java
import java.util.Arrays;

public class StringSort
{
    public static void man(String[] args)
    {
        String[] a = StdIn.readStrings();
        Arrays.sort(a);
        for (int i = 0; i < N; i++)
            StdOut.println(a[i]);
    }
}
```

Tukey's ninther: Median of 3 samples, each 3 entries.
- approximates the median of 9.
- uses at most 12 compares.
- used for partitioning in large arrays in system sorts

Applications have diverse attributes:
- stability
- parallel computaitons
- deterministic
- keys all different
- multiple key types
- linked list or arrays
- large or small items
- is array randomly ordered
- need guaranteed performance
