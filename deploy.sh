#!/usr/bin/env sh

set -e 

npm run build

cd dist 

git init 
git add  -A 
git commit -m 'New deployment'
git push -f git@github.com:Furkangunduz/flag-guesser-clone.git master:gh-pages

cd -