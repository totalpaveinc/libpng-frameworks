
mkdir -p build/android/arm64
mkdir -p build/android/armeabi
mkdir -p build/android/i686
mkdir -p build/android/x86_64

mkdir -p build/dist/android

ORIG_CWD=`pwd`

cmake \
    -G"Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="build/android/arm64/install/" \
    -DCMAKE_TOOLCHAIN_FILE="`pwd`/cmake/toolchains/android-aarch64.cmake" \
    -B build/android/arm64 \
    ./libpng

cmake \
    -G"Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="build/android/armeabi/install/" \
    -DCMAKE_TOOLCHAIN_FILE="`pwd`/cmake/toolchains/android-armv7a.cmake" \
    -B build/android/armeabi \
    ./libpng

cmake \
    -G"Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="build/android/i686/install/" \
    -DCMAKE_TOOLCHAIN_FILE="`pwd`/cmake/toolchains/android-i686.cmake" \
    -B build/android/i686 \
    ./libpng

cmake \
    -G"Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="build/android/x86_64/install/" \
    -DCMAKE_TOOLCHAIN_FILE="`pwd`/cmake/toolchains/android-x86_64.cmake" \
    -B build/android/x86_64 \
    ./libpng

cd build/android/arm64
make -j
make install
cd $ORIG_CWD

cd build/android/armeabi
make -j
make install
cd $ORIG_CWD

cd build/android/i686
make -j
make install
cd $ORIG_CWD

cd build/android/x86_64
make -j
make install
cd $ORIG_CWD

rm -rf build/dist/android
mkdir -p build/dist/android/arm64
mkdir -p build/dist/android/armeabi
mkdir -p build/dist/android/i686
mkdir -p build/dist/android/x86_64

cp -r build/android/arm64/install/* build/dist/android/arm64/
cp -r build/android/armeabi/install/* build/dist/android/armeabi/
cp -r build/android/i686/install/* build/dist/android/i686/
cp -r build/android/x86_64/install/* build/dist/android/x86_64/
