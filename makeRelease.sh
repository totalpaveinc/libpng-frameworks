
# This script is licensed under MIT, Total Pave Inc. 2023.

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Not in a Git repository."
    exit 1
fi

if ! git diff-index --quiet HEAD --; then
    echo "Git repository is not clean. There are uncommitted changes."
    exit 1
fi

BUILD_INCREMENT=$(cat BUILD_INCREMENT | awk '{$1=$1};1' | tr -d '\n')

pushd libpng

png_commit=$(git rev-parse HEAD)
png_tags==$(git tag --contains "$png_commit")
png_tags="${png_tags#=}"

IFS=' ' read -r -a tags <<< "$png_tags"

png_version=""

if [ ${#tags[@]} -gt 0 ]; then
    # Get the first tag from the array
    png_version="${tags[0]}"
else
    branch=$(git symbolic-ref --short HEAD)
    if [ -n "$branch" ]; then
        # Set version to the branch name
        png_version="$branch"
    else
        # Set version to the commit hash
        png_version="$png_commit"
    fi
fi

popd

TAG="libpng-$png_version-$BUILD_INCREMENT"

git tag -a $TAG -m "Build: $TAG"
if [ $? -ne 0 ]; then
    exit $?
fi
git push --tags
if [ $? -ne 0 ]; then
    exit $?
fi

((BUILD_INCREMENT++))

echo -n "$BUILD_INCREMENT" > BUILD_INCREMENT
git add BUILD_INCREMENT
git commit -m "Build Increment: $BUILD_INCREMENT"
git push

gh release create $TAG \
    ./build/dist/libpng-android-bin.zip \
    ./build/dist/libpng-android-bin.zip.sha1 \
    ./build/dist/libpng-ios-bin.zip \
    ./build/dist/libpng-ios-bin.zip.sha1 \
    --verify-tag --generate-notes

