# Bash Scripting #

**arithmetic operations**

```shell
## needs double parenthesis

## does only integer arithmetic
f=$((1/3))
echo $f

## will do floating point arithmetic
g=$(echo 1/3 | bc -l)
echo $g 
```  

**arrays**

```shell
a=() 
b=("apple" "banana" "cherry") # notice no commas ! 
echo ${b[2]} 
b[5]="kiwi" # don't have to populate every element.
b+=("mango") # append at the end, paranthesis is important.
# outputs the whole array
echo ${b[@]}
echo ${b[@]: -1}
```

**associative arrays**
`bash > 3.0`

```shell
declare -A myarray
myarray[color]=blue
myarray["office building"]="HQ West"

echo ${myarray["office building"]} is ${myarray[color]}
```

**brace  expansion**

```shell
$touch {apple, banana, cherry, durian} 
$touch file_{01..1000} # zero padding. 

echo {A..Z}
echo {a..Z}
echo {A..z}
echo {w..d..2}

touch {apple, banana, cherry, durian}_{01..100}{w..d}
```

**colouring options**

`echo -e "\033[5;31;40mERROR: \033[0m\033[31;40mSomething went wrong.\033[0m"`

```shell
flashred="\033[5;31;40m"
red="\033[31;40m"
none="\033[0m"
echo -e $flashred"ERROR: "$none$red"Something went wrong."$none 

## Also, can use "tput" notation 

flashred=$(tput setab 0; tput setaf 1; tput blink) 
red=$(tput setab 0; tput setaf 1) 
none=$(tput sgr 0) 

echo -e $flashred"ERROR: "$none$red"Something went wrong."$none 
```

**comparison operations**

`[["cat" == "cat" ]]` - returns 1 failure or 0 success  
`echo $?` - return value 

`[[ $a -lt $b]]` - used for integers !!  other comparison will be lexically. 

String is null or not.  
```
[[ -z $a && -n $b ]] # a is null and b is not null 
echo $? # returns result of the last comparison. 0 - success, 1 - failure.
```

**control structures**

```shell
if expression 
then 
    echo "True"
elif expression; then
    echo "ex is False, e2 is True"
fi
```

**debugging**

```shell
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
 
for file in $*; do 
    mv ${file} $prefix$file 
done
```

**declare**

```shell
declare -i d=123 # d is an integer
declare -r e=456 # e is read-only
declare -l f="LOLcats" # f is lolcats
declare -u g="LOLCATS" # g is LOLCATS
```

**exit codes**

``` shell
#!/bin/bash  
 
touch /root/test 2> /dev/null  
 
if [ $? -eq 0 ]; then  
    echo "Successfully created file"  
    exit 0  
else  
    echo "Could not create file" >&2  
    exit 1  
fi
```

**file i/o**

```shell
echo "some text" > file.txt
cat file.txt
> file.txt
echo "some more text" >> file.txt
```
```shell
i=1
while read f; do
    echo "Line $i: $f"
    ((i++))
done < file.txt
```

**here document**

to help display instructions:
```shell
cat << EndOfText
This is a 
multiline
text string
EndOfText
```
use `-` to remove tabs from following string.

```shell
ftp -n <<- DoneWithTheUpdate
    open mirrors.xmission.com
    user anonymous nothinghere
    ascii
    cd gutenberg
    get GUTINDEX.01
    bye
DoneWithTheUpdate
```

**interacting with the user**

[handy tutorial](http://wiki.bash-hackers.org/howto/getopts_tutorial)

> working with arguments

arguments are assigned the way they are passed - `$1`, `$2`, etc.  

for large number of arguments use `$@` and `$#`.
```shell
for i in $@; do
    echo $i
done

echo "There were $# arguments."
```

> working with flags

```shell
#!/bin/bash -xv

help_message(){
printf "Usage\t$0\n"
printf "\t-u:\tUser\t\tdefault: user\n"
printf "\t-p:\tPassword\tdefault: password\n"
}

default_values(){
user="user"
pass="pass"
}

if [ $# -eq 0 ]; then
    help_message
    exit 0
fi

default_values

while getopts :u:p:ab option; do
 case $option in
  u) user=$OPTARG;;
  p) pass=$OPTARG;;
  a) echo "Got the A flag!";;
  b) echo "Got the B flag!";;
  ?) echo "I don't know what &OPTARG is!";;
 esac
done

echo "User: $user / Pass: $pass"
```

> getting input during execution

```shell
echo "What is your name?"
read name

## silent mode - typed text will not appear. 
echo "What is your password?"
read -s pass

## inlne prompt
read -p Waht is your favourite animal? " animal

echo name: $name, pass: $pass, animal: $animal
```

Look at this [link](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_08_02.html) for other options.

```shell
## this will produce a menued list
select animal in "cat" "dog" "bird" "fish"; do 
    echo "You selected $animal!"
    break
done
```

```shell
## using a case block can be useful
select animal in "cat" "dog" "quit"; do 
    case $option in
    cat) echo "Cats like to sleep.";;
    dog) echo "Dogs like to play catch.";;
    quit) break;;
    *) echo "I'm not sure what that is.";;
    esac
done
```

> ensuring a response

```shell
#!/bin/bash 

if [#t -lt 3]; then
    cat <<- EOM
    This command requires three arguments:
    username, userid, and favourite number.
    EOM
else
 ## the program goes here
    echo "Username: #1"
    echo "UserID: $2"
    echo "Favourite Number: $3"
fi
```

```
read -p "Favourite animal? " a
while [[ -z "$a" ]]; do
    read -p "I need an answer! " a
done
echo "$a was selected."
```

```shell
read -p "Favourite animal?[cat] " a
## the -z option checks that the variable is not empty
while [[ -z "$a" ]]; do
    a="cat"
done
echo "$a was selected."
```

```shell
## basic validation using regex
read -p "What year? [nnnn] " a
while [[ ! $a =~ [0-9]{4} ]]; do
    read -p "A year, please! [nnnn] " a
done
echo "Selected year: $a"
```

**redirecting output**

```
$ cp -v * ../otherFolder 1> ../success.txt 2> ../error.txt 
1> stdout ; 2> stderr 

# will redirect stdout and stderr to output.log
bash my.file.sh > output.log 2>&1
```

**working with strings**

```shell
a="hello "
b="world"
c=$a$b
echo $c # concatenated string

echo ${#a} # length of string
echo ${c:3} # substring from third character
echo ${c:3:4}
echo ${c: -4}
echo ${c: -4:3}

## string replacement
fruit="apple banana banana cherry"
echo ${fruit/banana/durian} # only first instance is replaced
echo ${fruit//banana/durian} # all instances are replaced

echo ${fruit/#apple/durian} # replace only if instance occurs at very beginning of string
echo $fruit/%cherry/durian} # replace only if instance occurs at end of string
```

## Up and Running Notes ##

`bash` major differences: http://tiswww.case.edu/php/chet/bash/bashref.html#SEC138

ENV. Variables : `$MACHTYPE`, `$HOSTNAME`, `$BASH_VERSION`, `$SECONDS`

`/dev/null` ! Great blue nowhere 

`echo $SECONDS` - time script has been running.  
`echo $0` - script name. 

```
a=$(ping -c 1 example.com | grep 'bytes from' | cut -d = -f 4)
echo "The ping was $a"
```

`echo -e '\033[34;42mColorTest\033[0m'` - try it.  

```
date +"%d-%m-%Y"
date +"%H:%M:%S"
```

`printf "Name:\t%s\nID:\t%04d\n" "asif" "7"`

```
today=$(date +"%d-%m-%Y")
time=$(date +"%H:%M:%S")
printf -v d "Current User:\t%s\nDate:\t\t%s @ %s\n" $USER $today $time
echo $d
```

One would write the below text in a file:
```
open mirrors.xmission.com
user anonymous nothinghere
ascii
cd gutenberg
get GUTINDEX.00
```
and then pass that file to something like `ftp` to execute line by line - `ftp -n < ftp.txt`

```shell
freespace=$(df -h / | grep -E "\/$" | awk '{print $4}')
greentext="\033[32m"
bold="\033[1m"
normal="\033[0m"
logdate=$(date +"%Y%m%d")
logfile="$logdate"_report.log

echo -e $bold"Quick system report for "$greentext"$HOSTNAME"$normal
printf "\tSystem type:\t%s\n" $MACHTYPE
printf "\tBash Version:\t%s\n" $BASH_VERSION
printf "\tFree Space:\t%s\n" $freespace
printf "\tFiles in dir:\t%s\n" $(ls | wc -l)
printf "\tGenerated on:\t%s\n" $(date +"%m/%d/%y) # US date format
echo -e $greentext"A summary of this info has been saved to $logfile"$normal

cat <<- EOF> $logfile
 This report was automatically generated by my Bash script
 It contains a brif summary of some systme information.
EOF

printf "SYS:\t%s\n" $MACHTYPE >> $logfile
printf "BASH:\t%s\n" $BASH_VERSION >> $logfile
```

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
