Initially just a bunch of sample programs. Eventually DAD.py, ramsey, mysql,
mongo and other
scripts will be up here.

https://www.git-tower.com/blog/git-cheat-sheet


git clone SITE
cd SITE


# The above was one time. 

git checkout master
git pull

git checkout -b TEMPBRANCH
git add FILE
git commit
  # It should say a file has changed.
  #Or later the website won't say there are diferences in branches.

git push origin master
git push --set-upstream origin master

1. goto website
2. accept push
3. delete branch

then just stay in the same brach or
 git checkout master
 git branch -d TEMPBRANCH

# to sync, delete all, reget download, delete branches on website
# OR --- but it may not be want you want
git fetch origin
git reset --hard origin/master
git clean -f -d
