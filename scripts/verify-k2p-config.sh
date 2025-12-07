#!/bin/bash
echo "=== K2P配置验证脚本 ==="
echo ""

# 检查关键配置
check_config() {
    local file="$1"
    local desc="$2"
    
    echo "检查: $desc"
    echo "文件: $file"
    
    if [ ! -f "$file" ]; then
        echo "❌ 文件不存在"
        return 1
    fi
    
    echo ""
    echo "1. 设备名称:"
    grep "CONFIG_TARGET.*DEVICE" "$file" || echo "未找到设备配置"
    
    echo ""
    echo "2. 目标平台:"
    if grep -q "CONFIG_TARGET_ramips=y" "$file" && grep -q "CONFIG_TARGET_ramips_mt7621=y" "$file"; then
        echo "✅ ramips/mt7621"
    else
        echo "❌ 目标平台配置不完整"
    fi
    
    echo ""
    echo "3. 镜像格式:"
    if grep -q "CONFIG_TARGET_ROOTFS_SQUASHFS=y" "$file"; then
        echo "✅ SQUASHFS"
    else
        echo "❌ 缺少SQUASHFS"
    fi
    
    if grep -q "CONFIG_TARGET_IMAGES_GZIP=y" "$file"; then
        echo "✅ GZIP压缩"
    else
        echo "❌ 缺少GZIP压缩"
    fi
    
    echo ""
    echo "4. 分区大小:"
    grep "CONFIG_TARGET.*PARTSIZE" "$file" || echo "使用默认分区大小"
    
    echo ""
    echo "5. 配置统计:"
    echo "总行数: $(wc -l < "$file")"
    echo "包数量: $(grep "^CONFIG_PACKAGE_" "$file" | wc -l)"
    
    echo "----------------------------------------"
}

# 检查所有配置文件
check_config "configs/base.config" "基础配置"
check_config "configs/k2p-lite.config" "K2P精简版配置" 2>/dev/null || echo "k2p-lite.config 不存在"
check_config "configs/k2p-chinese.config" "K2P中文版配置" 2>/dev/null || echo "k2p-chinese.config 不存在"

echo ""
echo "=== 重要提醒 ==="
echo "K2P的正确设备名称应该是: CONFIG_TARGET_ramips_mt7621_DEVICE_phicomm_k2p=y"
echo ""
echo "如果不同，请修正后重新生成配置文件"
