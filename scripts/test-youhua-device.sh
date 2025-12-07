#!/bin/bash
echo "=== 友华WR1200JS设备名称测试 ==="
echo ""

# 测试不同设备名称
TEST_NAMES="youhua_wr1200js youhua,wr1200js wr1200js"

for DEVICE in $TEST_NAMES; do
    echo "测试设备名称: $DEVICE"
    
    # 创建测试配置
    cat > test-config.txt << CONFIG_END
CONFIG_TARGET_ramips=y
CONFIG_TARGET_ramips_mt7621=y
CONFIG_TARGET_ramips_mt7621_DEVICE_${DEVICE//,/_}=y
CONFIG_TARGET_ROOTFS_SQUASHFS=y
CONFIG_TARGET_IMAGES_GZIP=y
CONFIG_PACKAGE_base-files=y
CONFIG_END
    
    echo "配置内容:"
    cat test-config.txt
    echo ""
done

echo "建议：查看OpenWrt官方target/linux/ramips/image/mt7621.mk文件"
echo "找到正确的youhua wr1200js设备定义"
