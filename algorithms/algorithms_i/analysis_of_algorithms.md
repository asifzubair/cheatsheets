## Analysis of Algorithms ##

### Memory ###

- 1byte - 8bits
- 1MB - 2^20 bytes
- 1GB - 2^30 bytes
- 32-bit machine - 4 byte pointers
- 64-bit machine - 8 byte pointers

|type|bytes|
|:--:|:---:|
|boolean|1|
|byte|1|
|char|2|
|int|4|
|float|4|
|long|8|
|double|8|
|`char[]`|2N+24|
|`int[]`|4N+24|
|`double[]`|8N+24|
|`char[][]`|~2MN|
|`int[][]`|~4MN|
|`double[][]`|~8MN|

- array: 24bytes + memory for each array entry

objects in JAVA

- object overhead 16 bytes
- reference 8 bytes
- padding each object uses a multiple of 8 bytes

ex:
```java
public class Date
{
	private int day;
	private int month;
	private int year;
		...
} // will take 32 bytes

public class String
{
	private char[] value; // reference to array 8bytes & 2N+24 bytes for the char[] array
	private int offset;
	private int count;
	private int hash;
		...
} // a virgin string of length N uses ~2N bytes of memory
```
