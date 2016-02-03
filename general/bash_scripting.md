# Bash Scripting #

* `#!/bin/bash -xv` : verbose logging
* `bash my.file.sh > output.log 2>&1` : will redirect `stdout` and `stderr` to `output.log`

```
# quick debugging 
# this will produce some interesting output information 
 
#!/bin/bash -x 
 
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




### Resources ###

http://guide.bash.academy/index.html 

http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html
