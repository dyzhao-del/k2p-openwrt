#!/bin/bash
echo "=== K2P一键测试脚本 ==="
echo ""

echo "1. 检查配置..."
if [ -f "configs/base.config" ]; then
    DEVICE=$(grep "CONFIG_TARGET.*DEVICE.*=y" configs/base.config)
    echo "设备: $DEVICE"
    
    if echo "$DEVICE" | grep -q "phicomm_k2p"; then
        echo "✅ 设备名称正确"
    else
        echo "❌ 设备名称可能错误"
        echo "应该是: CONFIG_TARGET_ramips_mt7621_DEVICE_phicomm_k2p=y"
    fi
fi

echo ""
echo "2. 检查镜像配置..."
if grep -q "CONFIG_TARGET_ROOTFS_SQUASHFS=y" configs/base.config; then
    echo "✅ SQUASHFS已启用"
else
    echo "❌ 缺少SQUASHFS配置"
fi

if grep -q "CONFIG_TARGET_IMAGES_GZIP=y" configs/base.config; then
    echo "✅ GZIP压缩已启用"
else
    echo "❌ 缺少GZIP压缩配置"
fi

echo ""
echo "3. 建议操作:"
echo "   A. 运行 ./fix-k2p.sh 修复配置"
echo "   B. 运行渐进式测试阶段1"
echo "   C. 如果生成固件，继续测试其他阶段"
