Github
======

* First time cloning, SSL certificate problem on Windows server, try this!
```
PS C:\github> git clone https://github.com/vijred/SelfNotes.git
Cloning into 'SelfNotes'...
fatal: unable to access 'https://github.com/vijred/SelfNotes.git/': SSL certificate problem: unable to get local issuer certificate
PS C:\github> git config --global http.sslbackend schannel
PS C:\github> git clone https://github.com/vijred/SelfNotes.git
Cloning into 'SelfNotes'...
remote: Enumerating objects: 439, done.
```


* Most frequent used commands to add changes to server
```
git add *
git commit -m "Comment about the change"
git push
```
* Push changes to specific branch on server
    - `git push origin BranchName`
* How to clone a new Repo Example
```
git clone https://github.com/vijred/Powershell.git
git clone https://orgname@dev.azure.com/prgname/Project1/_git/Project1 c:\VJ\otherrepos\AzureDevops\Project1 --progress
```


* How to clone a branch from remote to local 
```
# Use `-b branchname` option
git clone -b develop https://github.com/vijred/Powershell.git
```
* How to pull latest version 
```
git pull
```

* How switch to remote branch
```
git fetch --all
git checkout ＜remotebranch＞
git checkout -b ＜remotebranch＞ origin/＜remotebranch＞ ## On a few older versions 
```

* How to reset new branch to one of the remote branch
```
git fetch --all
git checkout -b ＜branchname＞
git reset --hard origin/＜branchname＞
```

* Hardreset
```
git fetch origin
git reset --hard origin/master
```

* Credential Management commands
```
Credential Management:
git remote
git remote set-url origin git@github.com:yourname/yourrepo.git

# How to remove credentials , usefule when password is reset
git config --global --unset credential.helper
git config --system --unset credential.helper

# How to configure credentials to store
git config --global credential.helper store

```
* Check status of changes
    - `Git status`
* Create local git repo - Convert a project as local repo
    - `git init`

* Find git remote server info
    - `git remote -v`
* Find the differences in last 2 comments
    - `git diff -2`
* Comment tree
```
git log --graph --decorate --pretty=oneline --abbrev-commit --all
git log --all --graph --pretty=format:'%C(yellow)%h%Creset%C(blue)%d%Creset %C(white bold)%s%Creset %C(white dim)(%an on %ai [%ar])%Creset'
git log --oneline --graph --decorate --color
```
* Save the state of your current branch in another branch, named mybackup
```
git commit -a -m "Backup."
git branch mybackup
```
* Fetch the remote branch and set your branch to match it. (Example: pull changes from Master to your local devbranch)
```
git fetch origin
git reset --hard origin/master
```
* Remove additional files from local branch 
```
# Verify list of files that will be removed
git clean -n -f

#remove these files 
git clean -f
```
* Pull master bits to mylocalbranch 
```
# Option-0 is to pull from master 
git checkout mylocalbranch
git pull origin master

# Optipon-1 is to rebase 
git checkout mylocalbranch
git rebase master

#Option-2 is merge
git checkout mylocalbranch
git merge origin/master

# Option-3 Save work and merge again 
git stash // to save all existing changes in local branch
git checkout master // Switch to master branch from branch-1
git pull // take changes from the master
git checkout branch-1 // switchback to your own branch
git rebase master // merge all the changes and move you git head  forward
git stash apply // reapply all you saved changes 
```

Branch:
-------
* List all branches in local repo
    - `Git branch`
* List all branches from Server 
    - `git branch -a`
* Create new branch 
    - `git branch -b NewBranchname`
* Switch a branch
    - `git checkout BranchName`
* Delete a branch
    - `git branch -D DeletingBranchName`

* How to checkout a new branch with non-master branch as base. Example, checkout feature/buildsql with develop as base branch 
```
#Fetch remote branches
git fetch --all

# switch to develop branch
git checkout -b develop  origin/develop
 
#Create and checkout new feature branch
git checkout -b feature/buildsql
```
------


* How to checkout a single file from a different branch 
```
git checkout workign_branch               # first get back to workign_branch
git checkout other_branch_name -- myfilename.yaml # then copy the version of app.js 
                                  # from branch "other_branch_name"
```

* How to copy a single file from one branch to other 
	-	Run following from destination branch 
	-	`git restore --source SourceBranch relativePath/filename.yml`

Config
------
* How to edit gitconfig file
    -   `git config --global --edit` 
* Disable SSL Verify
    -   `git config --global http.sslVerify false`

* How to edit gitconfig file
    -   `git config --global --edit` 
* Disable SSL Verify
    -   `git config --global http.sslVerify false`

* How to link Local repo to remove Repo
	-	git remote add origin https://github.com/vijred/myrepo.git
	

Tips:
-----
* How to correct the mistakes while pushing the data -> https://about.gitlab.com/blog/2018/08/08/git-happens/ 
* Basic commands -> https://confluence.atlassian.com/bitbucketserver/basic-git-commands-776639767.html 
* How to remove sensitive data from one of the files in github -> https://rtyley.github.io/bfg-repo-cleaner/ 
* Troubleshoot gitbug certificate issues - https://stackoverflow.com/questions/23885449/unable-to-resolve-unable-to-get-local-issuer-certificate-using-git-on-windows
