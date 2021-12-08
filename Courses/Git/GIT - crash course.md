# What is git ?
- Git is a version control tool which helps programmers to keep track of changes made in the project files.
- Git also helps to synchronize code between a programmer and his colleague
- Git is a command line tool
- Git holds the project code in a Repository

# Git basics Commands
```bash
# Get the verion of git
git --version

# Get a copy of a github repository
git clone https://github.com/RomainLanglois/SLAE_x86

# Setup the local repository parameters
git config --global user.email "youremail@example"
git config --global user.name "Your name"
```

# What is a working directory ?
A working directory is simply a directory which contains your project files and these files are not tracked by GIT.
In order to make git aware and keep track of these files we need to run the <b>"git add"</b> command


# What is the staging area ?
Staging area is the area where a file waits to for a commit to occur. In this area a file is tracked and checked by <b>"Git"</b> for any changes made to it

# Git add / Git commit / Git push / Git pull
```bash
# This command will add the file from the "working folder" to the "staging area"
git add test.txt toto.py tata.c

# This command is used to save the changes from the "staging area" into our "local repository"
git commit -m "Insert a comment" test.txt toto.py tata.c

# This command will push the modifications to the remote repository
git push

# This command will retrieve the content from the remote repository
git pull
```

# Git Branching 
<b>Git branching</b> allows a programmer to work on different versions of the same file without disturbing the main master source code of the project. 
```bash
# Will show the cuurent branch name
git branch

# Will create a new branch
git checkout -b "branch-name"

# Change to another branch
git checkout "branch-name"

# Merge a branch to master
git merge "branch-name"
```

# Other important commands
```bash
# Delete a file from the project
git rm "filename"

# This command shows the state of the local repository
git status

# This command will show all commit information
git status
```

# Disable TLS/SSL verification
```bash
GIT_SSL_NO_VERIFY=true git clone <repository>
```