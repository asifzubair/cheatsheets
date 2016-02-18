# JAVA #

these are notes from Lynda's essential training course. 

## General ##

* **JRE** is basically the **JVM** where your java programs run. It includes the browser plugins for Apple execution.  
* **JDK** is full featured SDK for java, including **JRE**, and compilers and tools (like javadoc and java debugger) to create and compile programs.  
* Usually, when you only care about running Java programs on your browser or computer you will only install **JRE**. It's all you need. On the other hand, if you are planning to do some Java programming, you will also need JDK.  
* Sometimes, even though you are not planning to do any Java Development on a computer, you still need the **JDK** installed. For example, if you are deploying a WebApp with JSP, you are technically just running Java Programs inside the application server. Why would you need JDK then? Because application server will convert JSP into Servlets and use JDK to compile the servlets. I am sure there might be more examples.  

**JDK** - runtime compiler  

`javac` - command line compiler text - `bytecode`  
`java` - runtime  
`jar` - the package archive in zip  
`javadoc` - documentation  

* in JAVA, everything is a class - all code should be wrapped in a class definition  
* JAVA is highly case-sensitive  
* `javac Main.java -d ../bin` - creats class file in the `bin` folder  
* `javac Main.java -verbose`  

Everthing is an object:
	* class definitions
	* methods

**UML:** Unified modelling language
	* object
	* variable
	* field

```
string welcome = "Hello!";
string welcome = new String("Hello!");
```  
* equivalent calls
* string is an array of `char` objects
* many mehtods for `string` class

**Anatomy of a java program**

```java
// package declaration
package com.lynda.javatrainig

// class declaration
public class HelloWorld{
	
	// main method
	public static void main(String[] args){
		System.out.println("Hello,World");
		}
}
```

`JAVA` always adds a no argument constructor method.

## Data Types ##

- Primitives
	* Numerics: `ints` and `floats`
	* single characters
	* Booleans
- Complex objects
	* Strings
	* Dates  
	* Everything else  

**simple**

`int newVar = 10;`  

**complex**

`Date newDate = new Date();`  
initial **UPPER** case | always `_lower_` case begin | constructor

**Primitives**

default initialisation is zero

- byte  
- short  
- int  
- long  
- float  
- double  

- Primitives - passed by copy  
- in `JAVA`, we always pass by copy  
- But with complex objects except `Strings`, internal references can be retained.  

**Dates**

```java
class java.util

Date d = new date();
//systime

GregorianCalendar gc = new GregorianCalendar();
gc.add();

DateFormat df = DateFormat.getDateInstance(DateFormat.Full);
```

**Data type conversion**

```
long l = 100L;
float f = 150.5f;
double d =150.5d;

double doubleValue = 156.5d;
Double doubleObj = new Double(doubleValue);

byte myByteValue = doubleObj.byteValue();
String myString = doubleObj.toString();
```

**BIG DECIMAL**

- retina precision when calculating and rounding  

```
double d = 1115.37;
String ds = Double.toString(d);
Bigdecimal bd = new Bigdecimal(ds);

System.out.println("The value is " + bd.toString());
```

**Casting**

```
double doubleValue = 3.99;
int intResult = (int)doubleValue;
```

## Strings/ArrayLists ##

**Strings**

comparing strings: `s1.equal(s2);`

```
char dollar = '\u0024';
// unicode character for $
System.out.println(Character.toUpperCase(a[]));
```

**String Class**

```
String s1 = "welcome to cal!";
String s2 = new String("welcome to cal!");
```

`String` class is immutable

* use `StringBuilder`
```
String s1 = "Welcome";
StringBuilder sb = new StringBuilder(s1);
sb.append("to Cal!");
Systerm.out.println(sb);
```

**String functions***
```
String s1 = "Welcome to Cal!";
s1.Legth();
s1.indexOF("Cal");
s1.substring("u");
s1.trim(); // removes whitespaces !
```

### Collections ###

**simple arrays**
- all elements of same type
- fixed type

```
int[] a1 = new int[3];
int[] a3 = {3,6,9};
```

**ArrayLists:** special class
- ordered collection of data
- resizable

```java
ArrayList<String> list = new ArrayList<String>();

list.add("Cal");
list.add("Ore");
list.add("Wash");
list.remove(0);
list.get(1);
list.indexOf("Alaska");
```

- associative arrays 
- structures
- dictionary
- hashmap

**Unordered Collection of data**

```
HashMap<String, String> map = new HashMAp<String, String>();
map.out();
```

iterator class for both `HashMap` and `ArrayLists` exists
```java
ListIterator<String> listIterator = list.listIterator();
Set<String> keys = map.keySet();
Iterator<String> iterator = keys.iterator();
```

## File I/O ##

```java
import java.io.File
...

// Read a file using native functions in JAVA.
public class CopyFile{
	public static void main(String[] args){
		try{
			File f1 = new File("lormipsum.txt");
			File f2 = new File("target.txt");
		
			InputStream in = new FileInputStream(f1);
			OutputStream out = new FileOutputStream(f2);
			
			byte[] buf = new byte[1024];
			int len;
		
			while ( (len = in.read(buf)) > 0){
				out.write(buf, 0, len);
			}

			in.close();
			out.close();

			System.out.println("File copied!")
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
```

```java
import java.net.URL;

public class ReadNetworkFile {
	public static void main (String[] args){

		URL url = new URL("http://services. explorecalifornia.org/RSS/tours.php");
		InputStream stream = url.openStream();
		BufferedInputStream buf = new BufferedInputStream(stream);
		
		StringBuilder sb = new StringBuilder(); 
		// let's you append or insert content into String without having to rebuild string.

		while(true){

			int data = buf.read();
			if(data == -1){
				break;
			} else {
				sb.append((char)data);
			}
			System.out.println(sb);
		}
	}
}

// can use Apache Commons lib to do this faster. 
```

[ApacheFileUtils](http://commons.apache.org)

- download the commons package from Apache page. 
- good practice to load the JAR files in a `lib` folder.
	* need to add to the build path  
	* `R-Click > build_path > Add to Build_Path`  
- use the functions in Apache Lib to copy files faster.

```java
public class CopyFile{
	public static void main(String[] args){
		try{

			File f1 = new File("lormipsum.txt");
			File f2 = new File("target.txt");
		
			FileUtils.copyfile(f1, f2);
			System.out.println("File copied!")

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();	
		}		
	}
}
```

## Functions ##

**Operators:**  
- Assignment  
- Equality or relational  
- Mathematical  
- Conditional  
- Ternary (short hand conditional)  

`instanceof` - Class membership

method : access modifiers  
- public  
- private  
- protected  
	
* static   
	- class method
* non-static
	- instance method

**method overloading**  
```java
public static int addValues(int i1, int i2){
	return i1 + i2;
}

public static int addValues (String s1, String s2){
	
	int i1 = Integer.parseInt(s1);
	int i2 = Integer.parseInt(s2);
	
	return i1+i2;
}
```
