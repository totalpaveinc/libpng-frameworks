
# This script is licensed under MIT, Total Pave Inc. 2023.

source compiler/android.sh

if [ `uname` == "Darwin" ]; then
    source compiler/ios.sh
fi
