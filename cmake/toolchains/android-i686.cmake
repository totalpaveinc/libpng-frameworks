
set(CMAKE_ANDROID_ARCH_ABI "x86")
include(${CMAKE_CURRENT_LIST_DIR}/android-toolchain.cmake)
include_directories(${CMAKE_SYSROOT}/usr/include/i686-linux-android)
set(BUILD_TARGET_TRIPLET "i686-linux-android")
