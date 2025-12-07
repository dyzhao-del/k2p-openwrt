#!/bin/bash
echo "=== K2P分阶段构建脚本 ==="
echo ""

# 阶段1: 基础编译测试
echo "阶段1: 测试基础编译..."
echo "创建基础配置..."

BASE_CONFIG="configs/base.config"
if [ ! -f "$BASE_CONFIG" ]; then
    echo "错误: $BASE_CONFIG 不存在"
    exit 1
fi

echo "使用基础配置进行测试..."
echo "设备: $(grep 'CONFIG_TARGET.*DEVICE.*phicomm' "$BASE_CONFIG")"

echo ""
echo "建议分阶段添加插件:"
echo "1. 先确保基础配置能编译通过"
echo "2. 然后逐个添加插件，测试每个是否工作"
echo "3. 发现导致问题的插件后，移除或寻找替代"
echo ""
echo "可能导致libnettle冲突的插件:"
echo "- luci-app-ssr-plus"
echo "- luci-app-wireguard" 
echo "- 其他加密相关插件"
echo ""
echo "安全插件（通常无冲突）:"
echo "- luci-app-turboacc"
echo "- luci-app-upnp"
echo "- luci-app-ddns"
echo "- luci-app-adblock"
echo ""
echo "运行命令测试单个插件:"
echo "1. 创建测试配置: cat configs/base.config > test.config"
echo "2. 添加单个插件: echo 'CONFIG_PACKAGE_luci-app-turboacc=y' >> test.config"
echo "3. 测试编译"
