#!/bin/bash

git config user.name azeemsgoogle
git config user.email azeems@google.com
echo "$DATE" >> attack.txt
git add attack.txt
git commit -m "Fix indentation: $DATE"
git push