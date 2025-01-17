#!/system/bin/sh

# 获取证书目录路径
CERT="${0%/*}/system/etc/security/cacerts"
APEX="/apex/com.android.conscrypt/cacerts"
ANDROID_VERSION=$(getprop ro.build.version.sdk)

# 创建log文件夹
LOG_DIR="${0%/*}/log"

if [ ! -d "$LOG_DIR" ]; then
    mkdir -p "$LOG_DIR"
fi

# log 路径
LOG="${0%/*}/log/post-fs-data.log"

# 清除旧日志
: > "$LOG"

# 开始记录日志
exec > "$LOG" 2>&1

# 输出调试信息到日志文件和终端
echo "正在启动 post-fs-data.sh 脚本..."

# 检查 Android 版本是否大于等于 14
if [ "$ANDROID_VERSION" -ge 34 ]; then
    echo "正在检查证书文件..."

    # 遍历目录，查找以 .0 结尾的文件
    for cert_file in "$CERT"/*.0; do
        if [ -f "$cert_file" ]; then
            echo "找到证书文件：$cert_file"

            # 复制证书到目标目录
            cp "$cert_file" "$APEX/"
            chmod 644 "$APEX/$(basename "$cert_file")"
            chown root:root "$APEX/$(basename "$cert_file")"

            echo "证书已成功复制到 $APEX"
        else
            echo "未找到证书文件！！！"
        fi
    done
else
    echo "Android 版本低于 14，无需复制证书到 $APEX"
fi

