#!/bin/bash
# 友华WR1200JS配置合并脚本

if [ $# -lt 2 ]; then
    echo "用法: $0 <配置类型> <输出文件>"
    echo "配置类型: base, plus, full"
    exit 1
fi

type="$1"
output="$2"
config_dir="configs/youhua"

case $type in
    base)
        cp "$config_dir/base.config" "$output"
        ;;
    plus)
        cat "$config_dir/base.config" "$config_dir/plus.diff" > "$output"
        ;;
    full)
        cat "$config_dir/base.config" "$config_dir/plus.diff" "$config_dir/full.diff" > "$output"
        ;;
    *)
        echo "错误: 未知配置类型 '$type'"
        echo "可用类型: base, plus, full"
        exit 1
        ;;
esac

echo "配置 '$type' 已生成到: $output"
echo "文件大小: $(wc -l < "$output") 行"
