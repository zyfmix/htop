#!/usr/bin/env bash
set -e

sc_dir="$(
  cd "$(dirname "$0")" >/dev/null 2>&1 || exit
  pwd -P
)"

rs_path=${sc_dir/htop*/htop}

source $rs_path/bin/libs/headers.sh

ebc_info "首先清除已编译文件..."
mkdir -p bin/build && rm -rf bin/build/*

rm -rf logs/*.log

Case=${1:-run}

ebc_debug "解析命令参数> run.sh $Case"

case "$Case" in
help)
  ebc_debug "说明: run.sh 命令快捷参数"
  ebc_debug "用法: run.sh <Case>"
  ebc_debug "示例: run.sh run"
  ;;
build)
  sudo apt install libncursesw5-dev autotools-dev autoconf automake build-essential
  ./autogen.sh && ./configure && make
 ;;
rebuild)
  make
  ./htop --version
 ;;
run)
  ./htop --version
 ;;
*)
  echo "[参数命令不合法]case: $Case [run,build]"
  exit 1
  ;;
esac
