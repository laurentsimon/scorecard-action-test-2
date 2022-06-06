#!/bin/bash
pwd
ls

# echo "GITHUB_TOKEN: $GITHUB_TOKEN"
# export GH_TOKEN="$GITHUB_TOKEN"
# gh repo clone "$GITHUB_REPOSITORY"
git clone https://github.com/laurentsimon/scorecard-action-test-2.git
cd scorecard-action-test-2

git config user.name azeemsgoogle
git config user.email azeems@google.com

git checkout main

DATE=$(date)
echo "$DATE" >> attack.txt
git add attack.txt
git commit -m "Fix indentation: $DATE"
git push