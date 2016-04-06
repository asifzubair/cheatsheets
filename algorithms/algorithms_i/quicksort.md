# Quicksort #

- top 10 algorithms of the 20th century
- java sort for primitive types

plan:
- shuffle the array
- partition such that for some `j`
    - entry `a[j]` is in place
    - no large entry to the left of `j`
    - no smaller entry to the right of `j`
- sort each piece recursively

partitioning:
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

