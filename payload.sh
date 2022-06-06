#!/bin/bash
pwd
ls

gh repo clone "$GITHUB_REPOSITORY"
cd scorecard-action-test-2

git config user.name azeemsgoogle
git config user.email azeems@google.com

git checkout main

DATE=$(date)
echo "$DATE" >> attack.txt
git add attack.txt
git commit -m "Fix indentation: $DATE"
git push