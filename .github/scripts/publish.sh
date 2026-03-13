#!/bin/bash -e
echo ""
echo "|************************|"
echo "|     NPM Publishing     |"
echo "|************************|"
echo ""
echo "This script will publish a new version to NPM, create a version bump git commit, tag it and push it."

branchName=`git rev-parse --abbrev-ref HEAD`

if [[ $branchName != "main" ]]; then
  echo "Current branch is $branchName. Only the main branch can be published."
  exit 1
fi

npm run compile
npm run test

npm version $VERSION_BUMP -m "Version Bump to %s ($VERSION_BUMP)"

newVersion=`npm view . --silent version`

git tag $newVersion

npm publish --ignore-scripts

git push origin master
git push origin $newVersion
