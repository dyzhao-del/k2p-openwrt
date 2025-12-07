# OpenWrt 中文界面设置指南

## 刷机后首次设置

### 方法1：网页界面设置
1. 登录 LuCI 界面: http://192.168.1.1
2. 进入: 系统 → 系统 → 语言和界面
3. 选择: `中文 (简体)`
4. 点击: `保存并应用`

### 方法2：SSH命令行设置
```bash
# 设置语言为中文
uci set luci.main.lang=zh_cn
uci commit luci

# 重启LuCI服务
/etc/init.d/uhttpd restart

# 或者重启路由器
reboot
