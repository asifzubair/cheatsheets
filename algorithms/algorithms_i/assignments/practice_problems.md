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
    - Version 4: 2 eggs and ≤c√T tosses for some fixed constant c.
