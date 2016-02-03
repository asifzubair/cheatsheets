# Git / Github #

[Merg Conflicts](http://www.bogotobogo.com/cplusplus/Git/Git_GitHub_Merge_Conflicts_with_Simple_Example.php)

```
git clone RepoURL 
git pull 
git commit -am 'some comment' 
git push 
git status 
git add 
git checkout <file_name> --> to discard changes in cwd 
```
 
**Global settings for line endings**
 
The `git config core.autocrlf` command is used to change how Git handles line endings. It takes a single argument. 
On Windows, you simply pass true to the configuration. For example: 

``` 
git config --global core.autocrlf true
# Configure Git on Windows to properly handle line endings 
```

From <https://help.github.com/articles/dealing-with-line-endings/>  
 
