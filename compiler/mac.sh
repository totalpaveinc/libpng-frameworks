
mkdir -p build/mac/x86_64
mkdir -p build/mac/arm64

cmake \
    -G"Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DPNG_TESTS=OFF \
    -DPNG_EXECUTABLES=OFF \
    -DCMAKE_OSX_ARCHITECTURES="x86_64" \
    -DPNG_FRAMEWORK=OFF \
    -DPNG_SHARED=OFF \
    -DPNG_STATIC=ON \
    -DPNG_ARM_NEON=off \
    -DCMAKE_INSTALL_PREFIX="build/mac/x86_64/install/" \
    -B build/mac/x86_64 \
    ./libpng

if [ $? -ne 0 ]; then
    exit $?
fi

cmake \
    -G"Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Release \
    -DPNG_TESTS=OFF \
    -DPNG_EXECUTABLES=OFF \
    -DCMAKE_OSX_ARCHITECTURES="arm64" \
    -DPNG_FRAMEWORK=OFF \
    -DPNG_SHARED=OFF \
    -DPNG_STATIC=ON \
    -DPNG_ARM_NEON=off \
    -DCMAKE_INSTALL_PREFIX="build/mac/arm64/install/" \
    -B build/mac/arm64 \
    ./libpng

if [ $? -ne 0 ]; then
    exit $?
fi

ORIG_CWD=`pwd`

cd build/mac/x86_64
make -j
make install
if [ $? -ne 0 ]; then
    exit $?
fi

cd $ORIG_CWD/build/mac/arm64
make -j
make install
if [ $? -ne 0 ]; then
    exit $?
fi

cd $ORIG_CWD

rm -rf build/intermediates/mac
mkdir -p build/intermediates/mac/x86_64
mkdir -p build/intermediates/mac/arm64

cp -r build/mac/x86_64/install/* build/intermediates/mac/x86_64/
if [ $? -ne 0 ]; then
    exit $?
fi
cp -r build/mac/arm64/install/* build/intermediates/mac/arm64/


mkdir -p build/dist
rm -f build/dist/libpng-mac-bin.zip

pushd build/intermediates/mac
zip ../../dist/libpng-mac-bin.zip -r ./
if [ $? -ne 0 ]; then
    exit $?
fi
popd

pushd build/dist/
CHECKSUM="$(shasum -a 1 libpng-mac-bin.zip  | cut -d ' ' -f 1)"
echo -n "$CHECKSUM" > libpng-mac-bin.zip.sha1
popd
