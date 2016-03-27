## Union-Find ##

**Dynamic Connectivity**

* union command : connect two objects  
* find/connected query - is there a path connecting the two objects ?  

We are **only** trying to ask the question whether objects/nodes are connected and not interested in the path. Of course, a connection is equivalence - reflexive, symmetric and transitive. 

JAVA model

```java
public class UF
	UF(int N) 
	void union(int p, int q)
	bool connected(int p, int q)
```

dynaimic-connectivity client
```java
public static void main(String[] args) {
	int N = StdIn.readInt();
	UF uf = new UF(N);

	while (!StdIn.isEmpty()) {
		int p = StdInt.readInt();
		int q = StdInt.readint();

		if (!uf.connected(p,q)) {
			uf.union(p,q);
			StdOut.println(p + " " + q);
		}
	}
}
```

### Quick-find ###

greedy algorithm

**data structure**

- `int` arrary `id[]` of size `N`.  
- `p` and `q` are connected iff they have the same id.  

`union(p,q)` means that the `id` of p and q and all elements connected to them to the same `id`.  

**java implementation**

```java
public class QuickFindUF {
	private int[] id;

	public QuickFindUF(int N) {
		id = new int[N];
		for (int i = 0; i < N; i++)
			id[i] = i;
	}

	public boolean connected(int p, int q) {
		return id[p] == id[q];
	}

	public void union(int p, int q) {
		\\ store ids before re-setting. 
		int pid = id[p];
		int qid = id[q];
		for (int i = 0; i < id.length; i++){
			if (id[i] == pid) id[i] = qid;
		}
	}
}
```

however, `quick-find` is rather slow, becasue union is too expensive. (worst case N^2)

### Quick-Union ###

lazy approach. 


```java
public class QuickUnionUF {
	private int[] id;

	public QuickFindUF(int N) {
		id = new int[N];
		for (int i = 0; i < N; i++) id[i] = i;
	}

	private int root(int i) {
		while (i != id[i]) i = id[i]
		return i;
	}

	public boolean connected(int p, int q) {
		return root(p) == root(q);
	}

	public void union(int p, int q) {
		int i = root(p);
		int q = root(q);
		id[i] = j;
	}
}
```

this approach suffers in the **find** operation, the trees might get really big and then to **find** if two nodes are connected might take linear time. so, basically, we are going for sub-linear time. 

### Quick-Union Improvements ###

a qucik improvement would be to not let the trees get very deep. use a **weighted** algorithm to move the smaller tree - this way not item is too far from the tree. this improvement is really effective for large number of nodes. 

```java
publlic class QuickUnionUF {
	private int[] id;
	private int[] sz;

	public QuicUnionUF(int N) {
		id = new int[N];
		for(int i = 0; i < N; i++) {
			id[i] = i;
			sz[i] = 1;
		} 
	}

	private int root(int i) {
		while(i != id[i]) i = id[i];
		return i;
	}

	public boolean connected(int p, int q) {
		return root(p) == root(q);
	}

	public void union(int p, int q) {
		int i = root(p);
		int j = root(q);
		if(i == j) return;
		if (sz[i] < sz[j]) {
			id[i] = j; 
			sz[j] += sz[i];
		} else {
			id[j] = i; 
			sz[i] += sz[j];
		}
	}
}
```

another improvement is **path compression**

**two-pass variant:** add second loop to `root()` to set the `id[]` of each examined note to the root.  
**one-pass variant:** make every other node in path point to its grandparent (thereby halving path length).

```java
// one pass-variant
private int root(int i) {
	while (i != id[i]) {
		id[i] = id[id[i]];
		i = id[i];
	}
	return i;
}
```

wow ! learnt a new function today `lg*`, number of times to take log of some number to get 1, typically can think of it as a number less than 5 - becasue if `N = 2^65536` then `lg*N = 5`.  

So, the **weighted quick-union with path compression** algorithm is a simple one with fascinating mathematics.  

**algorithm design enables quicker solution**

### Union-Find Applications ###

* percolation  
* dynamic connectivity  
* **kruskal's** minimum spanning tree algorithm
...
