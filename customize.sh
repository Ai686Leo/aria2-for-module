#!/system/bin/sh

# 音量键选择函数
# 返回值: 1 表示按下了 [音量+] (执行操作)
#         0 表示按下了 [音量-] 或超时无操作 (不执行操作)
volume_key_selector() {
    # 等待时间 (秒)
    local timeout=10
    local start_time=$(date +%s)
    local key_detected=""

    echo "- 等待按键选择 (${timeout}秒)..."
    echo "- [音量+]：设置Aria2开机不自启"
    echo "- [音量-] 或 [不操作]：设置Aria2开机自启动"
    echo "- 请选择..."

    while [ $(( $(date +%s) - start_time )) -lt $timeout ]; do
        # 通过 getevent 监听按键，并识别具体按键
        local event_output=$(timeout 0.1 getevent -lc 1 2>/dev/null)
        
        if echo "$event_output" | grep -q -E "KEY_VOLUMEUP"; then
            key_detected="VOLUMEUP"
            break
        elif echo "$event_output" | grep -q -E "KEY_VOLUMEDOWN"; then
            key_detected="VOLUMEDOWN"
            break
        fi
        
        sleep 0.05
    done

    case "$key_detected" in
        "VOLUMEUP")
            echo "- 检测到 [音量+]，正在设置Aria2开机不自启"
            return 1
            ;;
        "VOLUMEDOWN")
            echo "- 检测到 [音量-]，正在设置Aria2开机自启动"
            return 0
            ;;
        *)
            echo "- 超时未选择，正在设置Aria2开机自启动"
            return 0
            ;;
    esac
}

# =============================================
FILE="/data/adb/modules/aria2-Android/noaria2"
# 调用音量键选择器
if volume_key_selector; then
    # 返回值为 0: 用户取消或超时
    rm -f "$FILE"
    echo "模块安装已完成"
else
    # 返回值为 1: 用户确认执行
    echo "已设置Aria2开机不自启" > "$FILE"
    echo "模块安装已完成"
fi
