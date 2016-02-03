# Command Line Tools #

**.bashrc Recommendation**

Most of the time you don’t want to maintain two separate config files for login and non-login shells — when you set a `PATH`, you want it to apply to both. You can fix this by sourcing `.bashrc` from your `.bash_profile` file, then putting `PATH` and common settings in `.bashrc`. 
 
To do this, add the following lines to `.bash_profile`: 
``` 
if [ -f ~/.bashrc ]; then  
source ~/.bashrc  
fi
```

Now when you login to your machine from a console `.bashrc` will be called.
