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
