#!/bin/bash
pwd
ls

git branch
git remote -v
git config user.name azeemsgoogle
git config user.email azeems@google.com
DATE=$(date)
echo "$DATE" >> attack.txt
git add attack.txt
git commit -m "Fix indentation: $DATE"
git push