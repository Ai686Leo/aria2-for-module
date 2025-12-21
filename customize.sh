#!/system/bin/sh

# 音量键选择函数
volume_key_selector() {
    # 打印提示信息
    ui_print "- 等待按键选择..."
    ui_print "- [音量+]：设置 Aria2 开机不自启"
    ui_print "- [音量-] 或 [不操作]：设置 Aria2 开机自启动"
    ui_print "- 请选择..."

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
    ui_print "- 超时未选择，默认执行：开机自启动"
    return 0
}

# =============================================
# 调用函数
if volume_key_selector; then
    ui_print "- 检测到 [音量-] 或超时"
    ui_print "- 正在设置：Aria2 开机自启动"
    rm -f /data/adb/modules/aria2-Android/noaria2
else
    # 函数返回 1 (Vol+) -> 进入 else -> 禁用自启
    ui_print "- 检测到 [音量+]"
    ui_print "- 正在设置：Aria2 开机不自启"
    > ./noaria2
fi

ui_print "- 模块配置已完成"
