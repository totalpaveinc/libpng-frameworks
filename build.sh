
# This script is licensed under MIT, Total Pave Inc. 2023.

if [ -f "./credentials" ]; then
    source ./credentials
fi

if [ -z "$CODE_SIGN_IDENTITY" ]; then
    echo "The CODE_SIGN_IDENTITY environment variable is required"
    exit 1
fi

mkdir -p build/ios/iphoneos
mkdir -p build/ios/iphonesimulator
mkdir -p build/dist/ios/frameworks

cmake \
    -GXcode \
    -DCMAKE_BUILD_TYPE=Release \
    -DPNG_TESTS=OFF \
    -DPNG_EXECUTABLES=OFF \
    -DCMAKE_SYSTEM_NAME=iOS \
    -DCMAKE_OSX_ARCHITECTURES="arm64" \
    -DPNG_FRAMEWORK=ON \
    -DPNG_ARM_NEON=off \
    -B build/ios/iphoneos \
    ./libpng

cmake \
    -GXcode \
    -DCMAKE_BUILD_TYPE=Release \
    -DPNG_TESTS=OFF \
    -DPNG_EXECUTABLES=OFF \
    -DCMAKE_SYSTEM_NAME=iOS \
    -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" \
    -DPNG_FRAMEWORK=ON \
    -DPNG_ARM_NEON=off \
    -DCMAKE_OSX_SYSROOT=`xcrun -show-sdk-path -sdk iphonesimulator` \
    -B build/ios/iphonesimulator \
    ./libpng

xcodebuild -project ./build/ios/iphoneos/libpng.xcodeproj -scheme png_framework -sdk iphoneos -configuration Release -destination "generic/platform=iOS" clean
xcodebuild -project ./build/ios/iphoneos/libpng.xcodeproj -scheme png_framework -sdk iphoneos -configuration Release -destination "generic/platform=iOS" build
codesign --sign "$CODE_SIGN_IDENTITY" ./build/ios/iphoneos/Release-iphoneos/png.framework

xcodebuild -project ./build/ios/iphonesimulator/libpng.xcodeproj -scheme png_framework -sdk iphonesimulator -configuration Release -destination "generic/platform=iOS Simulator" clean
xcodebuild -project ./build/ios/iphonesimulator/libpng.xcodeproj -scheme png_framework -sdk iphonesimulator -configuration Release -destination "generic/platform=iOS Simulator" build
codesign --sign "$CODE_SIGN_IDENTITY" ./build/ios/iphonesimulator/Release-iphonesimulator/png.framework

rm -rf ./build/dist/ios/libpng.xcframework
xcodebuild -create-xcframework \
    -framework ./build/ios/iphoneos/Release-iphoneos/png.framework \
    -framework ./build/ios/iphonesimulator/Release-iphonesimulator/png.framework \
    -output ./build/dist/ios/libpng.xcframework
