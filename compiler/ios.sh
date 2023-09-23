mkdir -p build/ios/iphoneos
mkdir -p build/ios/iphonesimulator

cmake \
    -G"Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DPNG_TESTS=OFF \
    -DPNG_EXECUTABLES=OFF \
    -DCMAKE_SYSTEM_NAME=iOS \
    -DCMAKE_OSX_ARCHITECTURES="arm64" \
    -DCMAKE_OSX_DEPLOYMENT_TARGET="12.0" \
    -DPNG_FRAMEWORK=OFF \
    -DPNG_SHARED=OFF \
    -DPNG_STATIC=ON \
    -DPNG_ARM_NEON=off \
    -DCMAKE_INSTALL_PREFIX="build/ios/iphoneos/install/" \
    -B build/ios/iphoneos \
    ./libpng

if [ $? -ne 0 ]; then
    exit $?
fi

cmake \
    -G"Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DPNG_TESTS=OFF \
    -DPNG_EXECUTABLES=OFF \
    -DCMAKE_SYSTEM_NAME=iOS \
    -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" \
    -DCMAKE_OSX_DEPLOYMENT_TARGET="12.0" \
    -DPNG_FRAMEWORK=OFF \
    -DPNG_SHARED=OFF \
    -DPNG_STATIC=ON \
    -DPNG_ARM_NEON=off \
    -DCMAKE_OSX_SYSROOT=`xcrun -show-sdk-path -sdk iphonesimulator` \
    -DCMAKE_INSTALL_PREFIX="build/ios/iphonesimulator/install/" \
    -B build/ios/iphonesimulator \
    ./libpng

if [ $? -ne 0 ]; then
    exit $?
fi

ORIG_CWD=`pwd`

cd build/ios/iphoneos
make -j
make install
if [ $? -ne 0 ]; then
    exit $?
fi
cd $ORIG_CWD/build/ios/iphonesimulator
make -j
make install
if [ $? -ne 0 ]; then
    exit $?
fi
cd $ORIG_CWD

rm -rf build/intermediates/ios/iphoneos
rm -rf build/intermediates/ios/iphonesimulator

mkdir -p build/intermediates/ios/iphoneos
mkdir -p build/intermediates/ios/iphonesimulator

cp -r build/ios/iphoneos/install/* build/intermediates/ios/iphoneos/
if [ $? -ne 0 ]; then
    exit $?
fi
cp -r build/ios/iphonesimulator/install/* build/intermediates/ios/iphonesimulator/
if [ $? -ne 0 ]; then
    exit $?
fi

mkdir -p build/dist
rm -f build/dist/libpng-ios-bin.zip

pushd build/intermediates/ios
zip ../../dist/libpng-ios-bin.zip -r ./
if [ $? -ne 0 ]; then
    exit $?
fi
popd

pushd build/dist/
CHECKSUM="$(shasum -a 1 libpng-ios-bin.zip  | cut -d ' ' -f 1)"
echo -n "$CHECKSUM" > libpng-ios-bin.zip.sha1
popd
