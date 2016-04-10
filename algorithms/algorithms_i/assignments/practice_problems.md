## Union-Find ##

1. __Social network connectivity.__ Given a social network containing `N` members and a log file containing `M` timestamps at which times pairs of members formed friendships, design an algorithm to determine the earliest time at which all members are connected (i.e., every member is a friend of a friend of a friend ... of a friend). Assume that the log file is sorted by timestamp and that friendship is an equivalence relation. The running time of your algorithm should be `MlogN` or better and use extra space proportional to `N`.

2. __Union-find with specific canonical element.__ Add a method `find()` to the union-find data type so that `find(i)` returns the largest element in the connected component containing `i`. The operations, `union()`, `connected()`, and `find()` should all take logarithmic time or better. For example, if one of the connected components is `{1,2,6,9}`, then the `find()` method should return 9 for each of the four elements in the connected components because 9 is larger 1, 2, and 6.

3. __Successor with delete.__ Given a set of `N` integers `S={0,1,...,N−1}` and a sequence of requests of the following form:

    - Remove x from S
    - Find the successor of x: the smallest y in S such that `y≥x`.  
Design a data type so that all operations (except construction) should take logarithmic time or better.

4. __Union-by-size.__ Develop a union-find implementation that uses the same basic strategy as weighted quick-union but keeps track of tree height and always links the shorter tree to the taller one. Prove a `lgN` upper bound on the height of the trees for `N` sites with your algorithm.

## Analysis of Algorithms ##

1. __3-SUM in quadratic time.__ Design an algorithm for the 3-SUM problem that takes time proportional to N2 in the worst case. You may assume that you can sort the N integers in time proportional to N2 or better.

2. __Search in a bitonic array.__ An array is bitonic if it is comprised of an increasing sequence of integers followed immediately by a decreasing sequence of integers. Write a program that, given a bitonic array of N distinct integer values, determines whether a given integer is in the array.  

    - Standard version: Use ∼3lgN compares in the worst case.
    - Signing bonus: Use ∼2lgN compares in the worst case (and prove that no algorithm can guarantee to perform fewer than ∼2lgN compares in the worst case).

3. __Egg drop.__ Suppose that you have an N-story building (with floors 1 through N) and plenty of eggs. An egg breaks if it is dropped from floor T or higher and does not break otherwise. Your goal is to devise a strategy to determine the value of T given the following limitations on the number of eggs and tosses:

    - Version 0: 1 egg, ≤ T tosses.
    - Version 1: ∼1lgN eggs and ∼1lgN tosses.
    - Version 2: ∼lgT eggs and ∼2lgT tosses.
    - Version 3: 2 eggs and ∼2√N tosses.
    - Version 4: 2 eggs and ≤ c√T tosses for some fixed constant c.

## Stacks and Queues ##

1. __Queue with two stacks.__ Implement a queue with two stacks so that each queue operations takes a constant amortized number of stack operations.

2. __Stack with max.__ Create a data structure that efficiently supports the stack operations (push and pop) and also a return-the-maximum operation. Assume the elements are reals numbers so that you can compare them.

3. __Java generics.__ Explain why Java prohibits generic array creation.

4. __Detect cycle in a linked list.__ A singly-linked data structure is a data structure made up of nodes where each node has a pointer to the next node (or a pointer to null). Suppose that you have a pointer to the first node of a singly-linked list data structure:
    - Determine whether a singly-linked data structure contains a cycle. You may use only two pointers into the list (and no other variables). The running time of your algorithm should be linear in the number of nodes in the data structure.
    - If a singly-linked data structure contains a cycle, determine the first node that participates in the cycle. you may use only a constant number of pointers into the list (and no other variables). The running time of your algorithm should be linear in the number of nodes in the data structure.
You may not modify the structure of the linked list.

5. __Clone a linked structure with two pointers per node.__ Suppose that you are given a reference to the first node of a linked structure where each node has two pointers: one pointer to the next node in the sequence (as in a standard singly-linked list) and one pointer to an arbitrary node.  
    ```java
    private class Node {
        private String item;
        private Node next;
        private Node random;
    }
    ```  
Design a linear-time algorithm to create a copy of the doubly-linked structure. You may modify the original linked structure, but you must end up with two copies of the original.

## Elementary Sorts ##

1. __Intersection of two sets.__ Given two arrays `a[]` and `b[]`, each containing N distinct 2D points in the plane, design a subquadratic algorithm to count the number of points that are contained both in array `a[]` and array `b[]`.

2. __Permutation.__ Given two integer arrays of size N, design a subquadratic algorithm to determine whether one is a permutation of the other. That is, do they contain exactly the same entries but, possibly, in a different order.

3. __Dutch national flag.__ Given an array of N buckets, each containing a red, white, or blue pebble, sort them by color. The allowed operations are:
    - `swap(i,j)`: swap the pebble in bucket `i` with the pebble in bucket `j`.
    - `color(i)`: color of pebble in bucket `i`.  
The performance requirements are as follows:  
    - At most N calls to `color()`.
    - At most N calls to `swap()`.
Constant extra space.

## Mergesort ##

1. __Merging with smaller auxiliary array.__ Suppose that the subarray `a[0]` to `a[N-1]` is sorted and the subarray `a[N]` to `a[2*N-1]` is sorted. How can you merge the two subarrays so that `a[0]` to `a[2*N-1]` is sorted using an auxiliary array of size N (instead of 2N)?

2. __Counting inversions.__ An inversion in an array `a[]` is a pair of entries `a[i]` and `a[j]` such that `i<j` but `a[i]>a[j]`. Given an array, design a linearithmic algorithm to count the number of inversions.

3. __Shuffling a linked list.__ Given a singly-linked list containing N items, rearrange the items uniformly at random. Your algorithm should consume a logarithmic (or constant) amount of extra memory and run in time proportional to `NlogN` in the worst case.

## Quicksort ##

1. __Nuts and bolts.__ A disorganized carpenter has a mixed pile of N nuts and N bolts. The goal is to find the corresponding pairs of nuts and bolts. Each nut fits exactly one bolt and each bolt fits exactly one nut. By fitting a nut and a bolt together, the carpenter can see which one is bigger (but the carpenter cannot compare two nuts or two bolts directly). Design an algorithm for the problem that uses NlogN compares (probabilistically).

2. __Selection in two sorted arrays.__ Given two sorted arrays `a[]` and `b[]`, of sizes N1 and N2, respectively, design an algorithm to find the kth largest key. The order of growth of the worst case running time of your algorithm should be `logN`, where `N=N1+N2`.
    - Version 1: N1=N2 and k=N/2
    - Version 2: k=N/2
    - Version 3: no restrictions

3. __Decimal dominants.__ Given an array with N keys, design an algorithm to find all values that occur more than N/10 times. The expected running time of your algorithm should be linear.
