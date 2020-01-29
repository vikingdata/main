Initially just a bunch of sample programs. Eventually DAD.py, ramsey, mysql,
mongo and other
scripts will be up here.

https://www.git-tower.com/blog/git-cheat-sheet


git clone SITE
cd SITE

git checkout master
git pull

git checkout -b TEMPBRANCH
git add FILE
git commit

git push origin master
git push --set-upstream origin master

1. goto website
2. accept push
3. delete branch


# Later you can do this, but not recommened.
# Just checkout TEMPBRANCH each time instead of deleting.
# Unless you want to tie it to a JIRA ticket.
 git checkout master
 git branch -d TEMPBRANCH
