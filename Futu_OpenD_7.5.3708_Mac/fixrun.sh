#!/bin/sh

# 由于MacOS的保护机制，从网上下载的app可能无法获取自身真实的路径。这个脚本可以修改FutuOpenD自身的标记，使其可以正确获取自身路径。

if [ "$1" = "-h" ]; then
    echo "Fix FutuOpenD's attr so that it can locate its config file in it's folder."
    echo 'Usage: fixrun.sh [appdir]'
    echo "    appdir: FutuOpenD's parent folder. If not given, the current directory is tried."
    exit 0
fi

script_dir="$(dirname ${BASH_SOURCE[0]})"
opend_dir="${script_dir}"
if [ -n "$1" ]; then
    opend_dir="$1"
fi

opend_path="${opend_dir}/FutuOpenD.app"
if [ -d "${opend_path}" ]; then
    xattr -r -d com.apple.quarantine "${opend_path}"
    echo "Ok, try launch FutuOpenD again."
else
    echo "FutuOpenD.app does not exist in dir ${opend_dir}"
    exit 1
fi