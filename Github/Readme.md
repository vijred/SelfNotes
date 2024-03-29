Github
======

* NOTE: Consider using a IDE (Integrated Developmetn Environment), VSCode is a great choice. I have Adopted VSCode as prefered tool for BitBucket work starting late 2022.


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

# How to remove credentials, useful when the password is reset.  Unset credentials and run git pull (this asks for credentials again)
git config --global --unset credential.helper
git config --system --unset credential.helper

# How to configure credentials to store (Note: This stores the credentials on the system. `-credentials` on Windows Server / `~/.git-credentials` on Linux server; By default it will be secured)
git config --global credential.helper store


# How to provide password during password reset. Just add -u option during push, it will read new credentials
git push -u origin branch_name_that_you_want_to_push
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


* How to checkout a single file from a different branch (** Tested, multiple times and working **)
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
* How to view list of all global configurations
    - `git config --list --global`
* How to list origin of all configurations
    - `git config --list --show-origin`
* How to edit gitconfig file
    -   `git config --global --edit` 
* Disable SSL Verify
    -   `git config --global http.sslVerify false`

* How to link Local repo to remove Repo
	-	git remote add origin https://github.com/vijred/myrepo.git
	

SSH authentication to Github
```
SSH Authentication Commands
SSH Authentication Commands
 

Lecture Command Listing
cd ~
cd .ssh
mkdir .ssh
cd .ssh
pwd
ssh-keygen -t rsa -C "jason@jasongtaylor.com"
mate id_rsa.pub
ssh -T git@github.com
 

Command Reference
Generating an SSH Key

ssh-keygen -t rsa -C "your.name@your-company.com"
Use your actual email address in the example above.

Verify SSH authentication

ssh -T git@github.com
Above command uses ssh to connect to GitHub over the SSH protocol.
```
* How to handle merge conflicts while merging myfeature to develop branch  (Suggestion from Github)

**Merge conflict**:

This pull request has conflicts.

You must resolve the conflicts by manually merging develop into this branch. After the conflicts are resolved you will be able to merge the pull request.

**Step 1**: Checkout the source branch and merge in the changes from the target branch. Resolve conflicts.
`git checkout myfeature`
`git pull origin develop`

**Step 2**: After the merge conflicts are resolved, stage the changes accordingly, commit the changes and push.
`git commit`
`git push origin HEAD`

**Step 3**: Merge the updated pull request.


Tips:
-----
* How to correct the mistakes while pushing the data -> https://about.gitlab.com/blog/2018/08/08/git-happens/ 
* Basic commands -> https://confluence.atlassian.com/bitbucketserver/basic-git-commands-776639767.html 
* How to remove sensitive data from one of the files in github -> https://rtyley.github.io/bfg-repo-cleaner/ 
* Troubleshoot gitbug certificate issues - https://stackoverflow.com/questions/23885449/unable-to-resolve-unable-to-get-local-issuer-certificate-using-git-on-windows
* recommended e-book: http://git-scm.com/book/en/v2 
