#!/system/bin/sh

# 获取证书目录路径
CERT="${0%/*}/system/etc/security/cacerts"
APEX="/apex/com.android.conscrypt/cacerts"
ANDROID_VERSION=$(getprop ro.build.version.sdk)

# 检查 Android 版本是否大于等于 14
if [ "$ANDROID_VERSION" -ge 34 ]; then

    # 遍历目录，查找以 .0 结尾的文件
    for cert_file in "$CERT"/*.0; do
        if [ -f "$cert_file" ]; then

           # 获取证书文件名
            cert_name=$(basename "$cert_file")

            # 删除证书
            rm -f "$APEX/$cert_name"

        fi
    done
fi