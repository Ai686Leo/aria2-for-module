#!/system/bin/sh

# 语言检测
SYS_LANG=$(getprop persist.sys.locale)
[ -z "$SYS_LANG" ] && SYS_LANG=$(getprop ro.product.locale)

ui_print_lang() {
    case "$SYS_LANG" in
        zh*) ui_print "$1" ;;
        *)   ui_print "$2" ;;
    esac
}

# 配置文件夹检测与复制

CONF="/data/adb/modules/aria2-Android/conf"

# 检测并执行复制
if [ -d "$CONF" ]; then
    ui_print_lang "- 检测到配置文件夹：$CONF" "- Found config directory: $CONF"
    ui_print_lang "- 正在复制配置到模块更新目录…..." "- Copying config to module update directory..."
    
    cp -rf "$CONF" "/data/adb/modules_update/aria2-Android/"

else
    ui_print_lang "- 未检测到配置文件夹，第一次安装？欢迎使用！" "- No config directory found. First install? Welcome!"
fi

# =============================================


# 音量键选择函数
volume_key_selector() {
    # 打印提示信息
    ui_print_lang "- 等待按键选择..." "- Waiting for key press..."
    ui_print_lang "- [音量+]：设置 Aria2 开机不自启" "- [Vol+]: Disable Aria2 auto-start"
    ui_print_lang "- [音量-] 或 [不操作]：设置 Aria2 开机自启动" "- [Vol-] or [No Action]: Enable Aria2 auto-start"
    ui_print_lang "- 请选择..." "- Please select..."

    # 设置超时时间
    local timeout=10
    local start_time=$(date +%s)
    
    while [ $(( $(date +%s) - start_time )) -lt $timeout ]; do
        # 监听输入，兼容性写法
        local event_output=$(timeout 0.1 getevent -lc 1 2>&1)
        
        if echo "$event_output" | grep -q "KEY_VOLUMEUP"; then
            return 1
        elif echo "$event_output" | grep -q "KEY_VOLUMEDOWN"; then
            return 0
        fi
    done

    # 超时默认返回 0
    ui_print_lang "- 超时未选择，默认执行：开机自启动" "- Timeout, defaulting to: Enable auto-start"
    return 0
}

# =============================================
# 调用函数
if volume_key_selector; then
    ui_print_lang "- 检测到 [音量-] 或超时" "- Detected [Vol-] or Timeout"
    ui_print_lang "- 正在设置：Aria2 开机自启动" "- Setting: Enable Aria2 auto-start"
    rm -f /data/adb/modules/aria2-Android/noaria2
else
    # 函数返回 1 (Vol+) -> 进入 else -> 禁用自启
    ui_print_lang "- 检测到 [音量+]" "- Detected [Vol+]"
    ui_print_lang "- 正在设置：Aria2 开机不自启" "- Setting: Disable Aria2 auto-start"
    > /data/adb/modules_update/aria2-Android/noaria2
fi

ui_print_lang "- 模块配置已完成" "- Module configuration completed"
