#!/bin/bash
echo "=== K2P配置切换工具 ==="
echo ""
echo "当前可用配置:"
echo "1. k2p-lite.config (精简版)"
echo "2. k2p-emergency.config (紧急精简版)"
echo "3. k2p-minimal.config (极限精简版)"
echo ""
read -p "选择配置 (1-3): " choice

case $choice in
    1)
        CONFIG="k2p-lite.config"
        echo "使用精简版配置"
        ;;
    2)
        CONFIG="k2p-emergency.config"
        echo "使用紧急精简版配置"
        ;;
    3)
        CONFIG="k2p-minimal.config"
        echo "使用极限精简版配置"
        ;;
    *)
        echo "无效选择，使用默认精简版"
        CONFIG="k2p-lite.config"
        ;;
esac

echo ""
echo "更新工作流文件中的配置..."
sed -i "s|CONFIG_FILE: configs/.*\.config|CONFIG_FILE: configs/$CONFIG|" .github/workflows/02-build-k2p-lite-final.yml

echo "✅ 已切换到 $CONFIG"
echo "运行工作流: 02-build-k2p-lite-final.yml"
