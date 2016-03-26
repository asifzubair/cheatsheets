import edu.princeton.cs.algs4.StdRandom;
import edu.princeton.cs.algs4.StdStats;
import edu.princeton.cs.algs4.WeightedQuickUnionUF;

public class Percolation {
    
    
    private int[] id;
    private int[] open;
    
    public Percolation(int N) {
        // create N-by-N grid, with all sites blocked
        for(int i = 0; i < N; i++){
            for(int j = 0; j < N; j++){
                id[10*i + j] = 10*i + j;
                open[10*i + j] = 0;
                
                if(i == 0) union(0, j);
                else if(i == N) union(N*N+1, 10*i + j);
            }
        }
    }
    
    public void open(int i, int j) {
        // open site (row i, column j) if it is not open already 
    
    }
        
    public boolean isOpen(int i, int j) {
        // is site (row i, column j) open?
        return open[i][j] == 1;
    }
    
    public boolean isFull(int i, int j) {
        // is site (row i, column j) full?
        return connected(0, 10*i+j);
    }
    
    public boolean percolates() {
        // does the system percolate?
        return connected(0, N*N+1);
    }

    public static void main(String[] args) {
        // test client (optional)
    
    }
}