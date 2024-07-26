#!bin/bash

set -e -u -o pipefail

if [ ! -d landing-zone-accelerator-on-aws ]; then
  git clone https://github.com/awslabs/landing-zone-accelerator-on-aws.git
fi
cd landing-zone-accelerator-on-aws
git checkout main
git pull
release=$(git describe --tags --abbrev=0)
git -c advice.detachedHead=false checkout $release
cd ..
echo $release
docker build --platform linux/amd64 --tag cc-lza-validator:$release .
