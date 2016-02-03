# Command Line Tools #

**.bashrc recommendation**

Most of the time you don’t want to maintain two separate config files for login and non-login shells — when you set a `PATH`, you want it to apply to both. You can fix this by sourcing `.bashrc` from your `.bash_profile` file, then putting `PATH` and common settings in `.bashrc`. 
 
To do this, add the following lines to `.bash_profile`: 
``` 
if [ -f ~/.bashrc ]; then  
source ~/.bashrc  
fi
```

Now when you login to your machine from a console `.bashrc` will be called.

**awk**

```
awk '$2==4 {print $0}' winters-raleigh-lines.tab > winters-raleigh-lines.4.tab  
awk '$1==4 && $2>2279734 && $2<2333528{print $0}' RAL-100_INDELS.vcf.tab
```

**wget**

```
wget $URL
wget -r -np -nH –cut-dirs=3 -R 'index.html*' -A '*_xwalk.csv' http://lehd.ces.census.gov/data/lodes/LODES7
```

**vi**
* For global substitution, use something like this   
 * `:%s/foo/bar/g`  - for all occurrences of foo change to bar 
* go to line: 
 * `G` - go to eof 
 * `A` - go to eol and append 
* If you wanted to go to line 14, you could press `Esc` and then enter `:14` 
* to change behaviour of `tab` and have LINE NUMBERS, put this into your `.vimrc` - it will be in your `$HOME` directory 
 * `set number` 
 * `set tabstop=4 shiftwidth=4 expandtab` 
* to turn on syntax highlighting, do this: 
 * `filetype plugin indent on` 
 * `syntax on`

**sed**
* `head $filename.csv | sed 's/\$//g' | csvlook | less -S` 
* have white spaces at the end and want to remove trailing `,` 
 * `cat filename | sed 's/,[[:blank:]]*$//g' > tmp.tmp; mv tmp.tmp desired_filename`

**ssh**

* `ssh-keygen -R [localhost]:2222` - to remove a particular hostkey from list of known hosts 

**qsub**

to kill jobs !

```
#!/bin/bash -xv 

export USER=asifzuba 

# to kill all the jobs 
qstat -u $USER | grep "$USER" | cut -d"." -f1 | xargs qdel 

# to kill all the running jobs 
qstat -u $USER | grep "R" | cut -d"." -f1 | xargs qdel 

# to kill all the queued jobs 
qstat -u $USER | grep "Q" | cut -d"." -f1 | xargs qdel 
```

interactive node:

`qsub -I -q cmb -l nodes=1:ppn=24 -l walltime=12:00:00 -l mem=48000mb -l vmem=48000mb -l pmem=2000mb`

**pbs**
```
#PBS -S /bin/bash 
#PBS -o /home/cmb-02/sn1/asifzuba/SOL_CHICKADEE/vcf/allelefrq  
#PBS -e /home/cmb-02/sn1/asifzuba/SOL_CHICKADEE/vcf/allelefrq 
#PBS -l walltime=24:00:00 
#PBS -l nodes=1:ppn=1 
#PBS -l mem=1900MB 
#PBS -q cmb
```

**rpm**

```
rpm --initdb --root /home/cmb-02/sn1/asifzuba --dbpath /home/cmb-02/sn1/asifzuba/lib/rpm 
rpm --dbpath /home/cmb-02/sn1/asifzuba/chimera/lib/rpm/ --relocate /usr=/home/cmb-02/sn1/asifzuba/chimera/ --nodeps -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm  
  
CPPFLAGS=-I /usr/local/include -I /tmp-old/backup/usr/include/readline 
LDFLAGS=-L/usr/local/lib -L/home3/fa/faga001/vol/readline-5.1/lib 
  
CFLAGS= -I/tmp-old/backup/usr/include/readline -L/tmp-old/backup/usr/lib64 
  
rpm --dbpath /home/cmb-02/sn1/asifzuba/rpm --relocate /usr=/home/cmb-02/sn1/asifzuba/chimera/ --nodeps -ivh readline-6.0-4.el6.src.rpm
```

---

`mkdir -p some_dir/dir1 some_dir/dir2 some_dir/dir3`

`$ ps -p $$` // to find your shell particulars 
Or simply `echo $SHELL` 

`uname -a` # Linux version 
`cat /etc/*release` # what flavor of Linux

`gdb example core` // to examine core dump for seg fault etc.  

`setfacl -m u:msalomon:rwx SOL_CHICKADEE` // give particular user a permission

```
# for loop in cshell 
foreach i (`seq 1 5 20`) 
... body … 
end
```

