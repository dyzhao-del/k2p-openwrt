#!/bin/bash
echo "=== K2P配置修复脚本 ==="
echo ""

# 检查当前设备名称
echo "当前设备配置:"
grep "CONFIG_TARGET.*DEVICE" configs/base.config 2>/dev/null || echo "未找到配置"

echo ""
echo "根据OpenWrt官方，K2P的正确设备名称是:"
echo "CONFIG_TARGET_ramips_mt7621_DEVICE_phicomm_k2p=y"
echo ""

read -p "是否更新为正确设备名称？ (y/n): " confirm

if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
    echo "正在备份原始配置..."
    cp configs/base.config configs/base.config.backup.$(date +%Y%m%d)
    
    echo "更新设备名称..."
    sed -i 's/CONFIG_TARGET_ramips_mt7621_DEVICE_.*=y/CONFIG_TARGET_ramips_mt7621_DEVICE_phicomm_k2p=y/' configs/base.config
    
    echo "重新生成配置文件..."
    if [ -f "configs/k2p-lite.diff" ]; then
        cat configs/base.config configs/k2p-lite.diff > configs/k2p-lite.config
        echo "✅ 重新生成 k2p-lite.config"
    fi
    
    if [ -f "configs/k2p-chinese.diff" ]; then
        cat configs/base.config configs/k2p-chinese.diff > configs/k2p-chinese.config
        echo "✅ 重新生成 k2p-chinese.config"
    fi
    
    echo ""
    echo "更新后的设备配置:"
    grep "CONFIG_TARGET.*DEVICE.*phicomm_k2p" configs/base.config
    
    echo ""
    echo "✅ 修复完成！请重新运行构建。"
else
    echo "取消更新"
fi
