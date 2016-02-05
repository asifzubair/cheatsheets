# Bash Scripting #

**arithmetic operations**

```
# does only integer arithmetic

f=$((1/3))
echo $f

# will do floating point arithmetic
g=$(echo 1/3 | bc -l)
echo $g 
```  

**arrays**

```
a=() 
b=("apple" "banana" "cherry") 
echo ${b[2]} 
b[5]="kiwi" 
b+=("mango") 
# outputs the whole array
echo ${b[@]}
```

**brace  expansion**

```
$touch {apple, banana, cherry, durian} 
$touch file_{01..1000} # zero padding.  
```

**comparison operations**

`[["cat" == "cat" ]]` - returns 1 failure or 0 success  
`echo $?` - return value 

`[[ $a -lt $b]]` - used for integers !!  

String is null or not.  
`[[ -z $a && -n $b ]]` - a is null and b is not null 
`echo $?`

**debugging**

```
# quick debugging 
# this will produce some interesting output information 
 
#!/bin/bash -x 

# verbose logging
#!/bin/bash -xv 
 
# a quick check to see if any arguments were given 
# raise warning if argument/file not given. 
 
if [$1 = ]; then 
echo "no arguments given" 
exit 0 
fi 
 
# this loop iterates through all of the files that we gave the program 
# it does one rename per file given. 
 
for file in $* 
do 
mv ${file} $prefix$file 
done
```

**exit codes**

``` 
#!/bin/bash  
 
touch /root/test 2> /dev/null  
 
if [ $? -eq 0 ]  
then  
echo "Successfully created file"  
exit 0  
else  
echo "Could not create file" >&2  
exit 1  
fi
```

**redirecting output**

```
$ cp -v * ../otherFolder 1> ../success.txt 2> ../error.txt 
1> stdout ; 2> stderr 

# will redirect stdout and stderr to output.log
bash my.file.sh > output.log 2>&1
```

---

`/dev/null` ! Great blue nowhere 
  
`echo $SECONDS` - time script has been running.  
`echo $0` - script name. 
  
`a=$(ping -c 1 example.com | grep 'bytes from' | cut -d = -f 4)`  
Stuff in parenthesis will be executed as system command.

`echo -e '\033[34;42mColorTest\033[0m'` - try it.  

```
flashred="\033[5;31;40m" 
red="\033[31;40m" 
none="\033[0m" 
  
echo -e $flashred"ERROR: "$none$red"Something went wrong."$none 
  
# Also, can use "tput" notation 
  
flashred=$(tput setab 0; tput setaf 1; tput blink) 
red=$(tput setab 0; tput setaf 1) 
none=$(tput sgr 0) 

echo -e $flashred"ERROR: "$none$red"Something went wrong."$none 
```

`printf "Name:\t%s\nID:\t%04d\n" "asif" "007"`

`cat < filename`

---
#### Up and Running Notes ####

`bash` major differences: http://tiswww.case.edu/php/chet/bash/bashref.html#SEC138



---

**How do I upgrade Bash in Mac OSX Mountain Lion and set it the correct path?**
 
Install bash with `brew install bash` .

Add `/usr/local/bin/bash` to `/etc/shells` .

Change the default shell with `chsh -s /usr/local/bin/bash` .

You don't normally have to change any settings in Terminal or iTerm 2. Both of them default to opening new shells with the default login shell. 

---

### Resources ###

http://guide.bash.academy/index.html 

http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html
