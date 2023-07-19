
set(CMAKE_ANDROID_ARCH_ABI "x86_64")
include(${CMAKE_CURRENT_LIST_DIR}/android-toolchain.cmake)
include_directories(${CMAKE_SYSROOT}/usr/include/x86_64-linux-android)
set(BUILD_TARGET_TRIPLET "x86_64-linux-android")
set(OUT_PLATFORM "android")
set(OUT_ARCH "x86_64")
