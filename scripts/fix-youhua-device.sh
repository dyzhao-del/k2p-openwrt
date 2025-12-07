#!/bin/bash
echo "=== 友华WR1200JS设备名称修复工具 ==="
echo ""

# 检查当前配置
echo "当前配置中的设备名称:"
grep "CONFIG_TARGET.*DEVICE" configs/youhua/base.config 2>/dev/null || echo "未找到配置文件"

echo ""
echo "根据OpenWrt官方源码，友华WR1200JS的正确设备名称应该是:"
echo "CONFIG_TARGET_ramips_mt7621_DEVICE_youhua_wr1200js=y"
echo ""

read -p "是否更新为正确设备名称？ (y/n): " confirm

if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
    echo "正在更新配置..."
    
    # 备份原配置
    cp configs/youhua/base.config configs/youhua/base.config.backup.$(date +%Y%m%d_%H%M%S)
    
    # 更新设备名称
    sed -i 's/CONFIG_TARGET_ramips_mt7621_DEVICE_.*=y/CONFIG_TARGET_ramips_mt7621_DEVICE_youhua_wr1200js=y/' configs/youhua/base.config
    
    # 重新生成配置文件
    cat configs/youhua/base.config configs/youhua/plus.diff > configs/youhua/plus.config
    cat configs/youhua/base.config configs/youhua/plus.diff configs/youhua/full.diff > configs/youhua/full.config
    
    echo "✅ 配置已更新"
    echo ""
    echo "更新后的设备配置:"
    grep "CONFIG_TARGET.*DEVICE" configs/youhua/base.config
    
    echo ""
    echo "请重新运行构建工作流:"
    echo "1. 04-build-youhua-plus-debug.yml (调试版)"
    echo "2. 或 04-build-youhua-plus-fixed.yml (修复版)"
else
    echo "取消更新"
fi
