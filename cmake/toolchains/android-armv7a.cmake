
set(CMAKE_ANDROID_ARCH_ABI "armeabi-v7a")
include(${CMAKE_CURRENT_LIST_DIR}/android-toolchain.cmake)
include_directories(${CMAKE_SYSROOT}/usr/include/arm-linux-android)
set(BUILD_TARGET_TRIPLET "arm-linux-android")
set(OUT_PLATFORM "android")
set(OUT_ARCH "armeabi-v7a")
set(OUT_PLATFORM "android")
set(OUT_ARCH "x86")
