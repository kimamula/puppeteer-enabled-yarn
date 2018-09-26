#!/bin/sh

set -ex

# SET THE FOLLOWING VARIABLES
# docker hub username
USERNAME=kimamula
# image name
IMAGE=puppeteer-enabled-yarn

# ensure we're up to date
git pull

# bump version
version=`cat VERSION`
echo "version: $version"

# run build
docker build -t $USERNAME/$IMAGE:latest .

# tag it
git add -A
git commit -m "version $version"
git tag -a "$version" -m "version $version"
git push
git push --tags
docker tag $USERNAME/$IMAGE:latest $USERNAME/$IMAGE:$version
# push it
docker push $USERNAME/$IMAGE:latest
docker push $USERNAME/$IMAGE:$version
