#!/usr/bin/env bash
# test/run.sh - vim9 script のテストをバッチ実行する
#
# 使い方:
#   test/run.sh                       # test/ 以下の *_test.vim を全て実行
#   test/run.sh test/diff_apply_test.vim  # 個別指定も可
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

files=("$@")
if [ ${#files[@]} -eq 0 ]; then
  files=(test/*_test.vim)
fi

status=0
for f in "${files[@]}"; do
  echo "== ${f} =="
  if ! vim -u NONE -N -es -S "${f}"; then
    status=1
  fi
done

exit "${status}"
