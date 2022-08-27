#!/bin/bash

set -eu -o pipefail

version_re="[0-9]+.[0-9]+.[0-9]+"

CHANGELOG_PATH="CHANGELOG.md"

while IFS= read -r line
do
if [[ $line =~ $version_re ]]
then
    extracted_ver="${BASH_REMATCH[0]}"
    echo "version: ${extracted_ver}"
    break
fi
done < $CHANGELOG_PATH

if [ -z $extracted_ver ]
then
    echo "Can nof find version from ${CHANGELOG_PATH}!"
    exit -1
fi

VERSION_FILE_PATH="CloudronManifest.json"

# assume BSD sed
sed -i "" -E "s/\"version\": \".*\",/\"version\": \"${extracted_ver}\",/" "${VERSION_FILE_PATH}"

git add ${VERSION_FILE_PATH}
