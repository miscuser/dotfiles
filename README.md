dotfiles
========

This is designed to provide me an easy way to back up and restore my dotfiles.  In particular, it should be easy to configure vim.

Original idea: http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/

To add a file
-------------
git add vimrc

Add comment
-----------
git commit -m 'Comments'

Add origin
----------
git remote add origin git@github.com:mygithubusername/dotfiles.git

Push changes to Github
----------------------
git push origin master

After making changes to a file
------------------------------
1. git add <file>
2. git commit -m "blah blah"
3. git push origin master

Clone files to another machine
------------------------------
git clone git://github.com/<mygithubusername>/dotfiles.git

Update local repo
-----------------
git pull origin master
