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

**ssh**

**qsub**

---

`mkdir -p some_dir/dir1 some_dir/dir2 some_dir/dir3`
