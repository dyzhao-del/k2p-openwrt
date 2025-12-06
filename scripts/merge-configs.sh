#!/bin/bash
# 配置合并脚本

if [ $# -lt 2 ]; then
    echo "用法: $0 <基础配置> <输出配置> [差异文件...]"
    exit 1
fi

base="$1"
output="$2"
shift 2

# 复制基础配置
cp "$base" "$output"

# 应用差异
for diff in "$@"; do
    if [ -f "$diff" ]; then
        cat "$diff" >> "$output"
    fi
done

echo "合并完成: $output"
