#!/bin/bash

echo -e "\n*********************************"
echo -e "*\tPublish doxygen script start"
echo -e "*********************************\n"

mkdir push_to_ghpages
cp -Rf ./build/doc/html/ ./push_to_ghpages/
cp -Rf ./build/reports/ ./push_to_ghpages/
pushd ./push_to_ghpages/
mv html/ doxygen/

git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis-CI"

git clone --quiet --branch=gh-pages https://${GH_TOKEN}@${GH_REF} gh-pages > /dev/null 2>&1

cd gh-pages/
git rm -rf ./doxygen/
git rm -rf ./reports/
cd ..
mv doxygen/ gh-pages/
mv reports/ gh-pages/
cd gh-pages/

git add --all
git commit -m "Latest documentation and reports. Auto-pushed from travis. Build $TRAVIS_BUILD_NUMBER"

git remote rm origin
git remote add origin https://${GH_USR}:${GH_TOKEN}@${GH_REF} > /dev/null 2>&1

git push -fq origin gh-pages > /dev/null 2>&1

echo -e "\n*********************************"
echo -e "*\tPublish doxygen script finish"
echo -e "*********************************\n"
