#!/bin/sh



set -e
echo "---"
echo $BRANCH
echo "---"



if [[ -z "$INPUT_GITHUB_TOKEN" ]]; then
  echo "Set the GITHUB_TOKEN environment variable."
  exit 1
fi

REPO="https://$GITHUB_ACTOR:$INPUT_GITHUB_TOKEN@github.com/$GITHUB_REPOSITORY"
echo $REPO
# Github actions no longer auto set the username and GITHUB_TOKEN
git remote set-url origin $REPO

# Pull all branches references down locally so subsequent commands can see them
git fetch origin '+refs/heads/*:refs/heads/*' --update-head-ok

# Workaround for `hub` auth error https://github.com/github/hub/issues/2149#issuecomment-513214342
export GITHUB_USER="$GITHUB_ACTOR"


echo "Old set of branches"
# Print out all branches
git --no-pager branch -a -vv


COMMAND="git branch -D $BRANCH"
echo $COMMAND
GO_TO_OBJECT=$(sh -c "$COMMAND")

if [["$?" != "0"]]; then
  exit 1
fi

COMMAND="git push origin --delete $BRANCH"
echo $COMMAND
CREATE_LOCAL_BRANCH=$(sh -c "$COMMAND")

if [["$?" != "0"]]; then
  exit 1
fi


echo "New set of branches"
# Print out all branches
git --no-pager branch -a -vv