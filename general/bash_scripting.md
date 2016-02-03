# Bash Scripting #

**Debugging**

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

**Exit Codes**
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

**brace  expansion**

```
$touch {apple, banana, cherry, durian} 
$touch file_{01..1000} # zero padding.  
```

**Redirecting output**
```
$ cp -v * ../otherFolder 1> ../success.txt 2> ../error.txt 
1> stdout ; 2> stderr 

# will redirect stdout and stderr to output.log
bash my.file.sh > output.log 2>&1
```

`/dev/null` ! Great blue nowhere 
  
`echo $SECONDS` - time script has been running.  
`echo $0` - script name. 
  
`a=$(ping -c 1 example.com | grep 'bytes from' | cut -d = -f 4)`
Stuff in parenthesis will be executed as system command.


### Resources ###

http://guide.bash.academy/index.html 

http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html
