# Java #

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

```
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

```
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
