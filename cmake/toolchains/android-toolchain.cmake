
include(${CMAKE_CURRENT_LIST_DIR}/common.cmake)

set(NDK_VERSION "25.0.8775105")
set(ANDROID_VERSION 24)
set(ANDROID_USE_LEGACY_TOOLCHAIN_FILE NO)
set(BUILD_PLATFORM "android")
set(ANDROID)
set(ANDROID_PLATFORM ${ANDROID_VERSION}) # Android toolchains will end up rewriting this to an `android-<version>` format
set(ANDROID_TOOLCHAIN ${TOOL_NAME}${ANDROID_PLATFORM}-clang++)
include($ENV{ANDROID_HOME}/ndk/${NDK_VERSION}/build/cmake/android.toolchain.cmake)
