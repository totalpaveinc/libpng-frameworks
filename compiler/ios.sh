mkdir -p build/ios/iphoneos
mkdir -p build/ios/iphonesimulator

cmake \
    -G"Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DPNG_TESTS=OFF \
    -DPNG_EXECUTABLES=OFF \
    -DCMAKE_SYSTEM_NAME=iOS \
    -DCMAKE_OSX_ARCHITECTURES="arm64" \
    -DPNG_FRAMEWORK=OFF \
    -DPNG_SHARED=OFF \
    -DPNG_STATIC=ON \
    -DPNG_ARM_NEON=off \
    -DCMAKE_INSTALL_PREFIX="build/ios/iphoneos/install/" \
    -B build/ios/iphoneos \
    ./libpng

cmake \
    -G"Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DPNG_TESTS=OFF \
    -DPNG_EXECUTABLES=OFF \
    -DCMAKE_SYSTEM_NAME=iOS \
    -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" \
    -DPNG_FRAMEWORK=OFF \
    -DPNG_SHARED=OFF \
    -DPNG_STATIC=ON \
    -DPNG_ARM_NEON=off \
    -DCMAKE_OSX_SYSROOT=`xcrun -show-sdk-path -sdk iphonesimulator` \
    -DCMAKE_INSTALL_PREFIX="build/ios/iphonesimulator/install/" \
    -B build/ios/iphonesimulator \
    ./libpng

ORIG_CWD=`pwd`

cd build/ios/iphoneos
make -j
make install
cd $ORIG_CWD/build/ios/iphonesimulator
make -j
make install
cd $ORIG_CWD

rm -rf build/dist/ios/iphoneos
rm -rf build/dist/ios/iphonesimulator

mkdir -p build/dist/ios/iphoneos
mkdir -p build/dist/ios/iphonesimulator

cp -r build/ios/iphoneos/install/* build/dist/ios/iphoneos/
cp -r build/ios/iphonesimulator/install/* build/dist/ios/iphonesimulator/

#cp build/ios/iphoneos/libpng.a build/dist/ios/lib/iphoneos/libpng.a
# cp build/ios/iphoneos/pnglibconf.h build/dist/ios/iphoneos/include/pnglibconf.h

# xcodebuild -project ./build/ios/iphoneos/libpng.xcodeproj -scheme png_framework -sdk iphoneos -configuration Release -destination "generic/platform=iOS" clean
# xcodebuild -project ./build/ios/iphoneos/libpng.xcodeproj -scheme png_framework -sdk iphoneos -configuration Release -destination "generic/platform=iOS" build
# codesign --sign "$CODE_SIGN_IDENTITY" ./build/ios/iphoneos/Release-iphoneos/png.framework

# xcodebuild -project ./build/ios/iphonesimulator/libpng.xcodeproj -scheme png_framework -sdk iphonesimulator -configuration Release -destination "generic/platform=iOS Simulator" clean
# xcodebuild -project ./build/ios/iphonesimulator/libpng.xcodeproj -scheme png_framework -sdk iphonesimulator -configuration Release -destination "generic/platform=iOS Simulator" build

# rm -rf ./build/dist/ios/libpng.xcframework
# xcodebuild -create-xcframework \
#     -framework ./build/ios/iphoneos/Release-iphoneos/png.framework \
#     -framework ./build/ios/iphonesimulator/Release-iphonesimulator/png.framework \
#     -output ./build/dist/ios/libpng.xcframework
