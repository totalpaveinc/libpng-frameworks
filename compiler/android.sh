
mkdir -p build/android/arm64-v8a
mkdir -p build/android/armeabi-v7a
mkdir -p build/android/x86
mkdir -p build/android/x86_64

ORIG_CWD=`pwd`

cmake \
    -G"Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="build/android/arm64-v8a/install/" \
    -DCMAKE_TOOLCHAIN_FILE="`pwd`/cmake/toolchains/android-arm64-v8a.cmake" \
    -DPNG_SHARED=OFF \
    -DPNG_STATIC=ON \
    -DPNG_FRAMEWORK=OFF \
    -DPNG_TESTS=OFF \
    -DPNG_DEBUG=OFF \
    -DPNG_EXECUTABLES=OFF \
    -B build/android/arm64-v8a \
    ./libpng

if [ $? -ne 0 ]; then
    exit $?
fi

cmake \
    -G"Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="build/android/armeabi-v7a/install/" \
    -DCMAKE_TOOLCHAIN_FILE="`pwd`/cmake/toolchains/android-armeabi-v7a.cmake" \
    -DPNG_SHARED=OFF \
    -DPNG_STATIC=ON \
    -DPNG_FRAMEWORK=OFF \
    -DPNG_TESTS=OFF \
    -DPNG_DEBUG=OFF \
    -DPNG_EXECUTABLES=OFF \
    -B build/android/armeabi-v7a \
    ./libpng

if [ $? -ne 0 ]; then
    exit $?
fi

cmake \
    -G"Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="build/android/x86/install/" \
    -DCMAKE_TOOLCHAIN_FILE="`pwd`/cmake/toolchains/android-x86.cmake" \
    -DPNG_SHARED=OFF \
    -DPNG_STATIC=ON \
    -DPNG_FRAMEWORK=OFF \
    -DPNG_TESTS=OFF \
    -DPNG_DEBUG=OFF \
    -DPNG_EXECUTABLES=OFF \
    -B build/android/x86 \
    ./libpng

if [ $? -ne 0 ]; then
    exit $?
fi

cmake \
    -G"Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="build/android/x86_64/install/" \
    -DCMAKE_TOOLCHAIN_FILE="`pwd`/cmake/toolchains/android-x86_64.cmake" \
    -DPNG_SHARED=OFF \
    -DPNG_STATIC=ON \
    -DPNG_FRAMEWORK=OFF \
    -DPNG_TESTS=OFF \
    -DPNG_DEBUG=OFF \
    -DPNG_EXECUTABLES=OFF \
    -B build/android/x86_64 \
    ./libpng

if [ $? -ne 0 ]; then
    exit $?
fi

cd build/android/arm64-v8a
make -j
make install
if [ $? -ne 0 ]; then
    exit $?
fi
cd $ORIG_CWD

cd build/android/armeabi-v7a
make -j
make install
if [ $? -ne 0 ]; then
    exit $?
fi
cd $ORIG_CWD

cd build/android/x86
make -j
make install
if [ $? -ne 0 ]; then
    exit $?
fi
cd $ORIG_CWD

cd build/android/x86_64
make -j
make install
if [ $? -ne 0 ]; then
    exit $?
fi
cd $ORIG_CWD

rm -rf build/intermediates/android
mkdir -p build/intermediates/android/arm64-v8a
mkdir -p build/intermediates/android/armeabi-v7a
mkdir -p build/intermediates/android/x86
mkdir -p build/intermediates/android/x86_64

cp -r build/android/arm64-v8a/install/* build/intermediates/android/arm64-v8a/
if [ $? -ne 0 ]; then
    exit $?
fi
cp -r build/android/armeabi-v7a/install/* build/intermediates/android/armeabi-v7a/
if [ $? -ne 0 ]; then
    exit $?
fi
cp -r build/android/x86/install/* build/intermediates/android/x86/
if [ $? -ne 0 ]; then
    exit $?
fi
cp -r build/android/x86_64/install/* build/intermediates/android/x86_64/
if [ $? -ne 0 ]; then
    exit $?
fi

mkdir -p build/dist
rm -f build/dist/libpng-android-bin.zip

pushd build/intermediates/android
zip ../../dist/libpng-android-bin.zip -r ./
if [ $? -ne 0 ]; then
    exit $?
fi
popd
