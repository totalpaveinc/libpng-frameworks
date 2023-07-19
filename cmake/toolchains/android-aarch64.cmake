
set(CMAKE_ANDROID_ARCH_ABI "arm64-v8a")
set(TOOL_NAME "aarch64-linux-android")
include(${CMAKE_CURRENT_LIST_DIR}/android-toolchain.cmake)
include_directories(${CMAKE_SYSROOT}/usr/include/aarch64-linux-android)
set(BUILD_TARGET_TRIPLET "aarch64-linux-android")
set(OUT_PLATFORM "android")
set(OUT_ARCH "arm64")
