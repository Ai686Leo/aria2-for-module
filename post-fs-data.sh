#!/system/bin/sh

CERT_DIR="${0%/*}/system/etc/security/cacerts"
LOG_FILE="${0%/*}/log/post-mount.log"
ANDROID_SDK=$(getprop ro.build.version.sdk)
set_context() {
    # 仅在 SELinux 强制模式下操作
    [ "$(getenforce)" = "Enforcing" ] || return 0
    # 默认上下文
    default_selinux_context=u:object_r:system_file:s0
    selinux_context=$(ls -Zd $1 | awk '{print $1}')
    # 检查上下文有效性
    if [ -n "$selinux_context" ] && [ "$selinux_context" != "?" ]; then
        chcon -R $selinux_context $2
    else
        # 回退到默认上下文
        chcon -R $default_selinux_context $2
    fi
}

# 初始化日志
mkdir -p "${0%/*}/log"
: > "$LOG_FILE"
exec > "$LOG_FILE" 2>&1

echo "脚本开始运行"

set_context /system/etc/security/cacerts ${0%/*}/system/etc/security/cacerts
echo "→处理system证书目录上下文"

# Android 14+ 处理 APEX
if [ "$ANDROID_SDK" -lt 34 ]; then
       echo "Android 版本低于 14，无需操作"
       exit 0
   else
       echo "Android 版本高于 14"
fi

# 查找所有 APEX 证书目录
echo "找 APEX 证书目录."
APEX_CACERTS_DIRS=$(find /apex -maxdepth 2 -type d -path "*/com.android.conscrypt*/cacerts" 2>/dev/null)

if [ -z "$APEX_CACERTS_DIRS" ]; then
    echo "→未找到任何 APEX 证书目录！？"
    exit 1
fi

# 处理
echo "尝试挂载并复制证书"
for APEX_CACERTS_DIR in $APEX_CACERTS_DIRS; do
    echo "→处理目录: $APEX_CACERTS_DIR"
    
     # 检查目录是否可写
    if touch "$APEX_CACERTS_DIR/.test_write" 2>/dev/null; then
        rm -f "$APEX_CACERTS_DIR/.test_write"
        echo "  →目录可写，开始复制"
        
        # 复制证书
        for CERT_FILE in "$CERT_DIR"/*.0; do
            if [ -f "$CERT_FILE" ]; then
                CERT_NAME=$(basename "$CERT_FILE")
                echo "    →复制证书: $CERT_NAME"
                cp -f "$CERT_FILE" "$APEX_CACERTS_DIR/"
                    chmod 644 "$APEX_CACERTS_DIR/$CERT_NAME"
                    chown root:root "$APEX_CACERTS_DIR/$CERT_NAME"
            fi
        done
    else
        # 尝试绑定解决无法复制
        for CERT_FILE in "$CERT_DIR"/*.0; do
            if [ -f "$CERT_FILE" ]; then
                echo "  →目录不可写，已尝试绑定"
                CERT_NAME=$(basename "$CERT_FILE")
                CERT_CACHE=/data"$APEX_CACERTS_DIR"
                mkdir -p "$CERT_CACHE"
                    chmod 755 "$CERT_CACHE"
                    chown 0:2000 "$CERT_CACHE"
                cp -f  "$APEX_CACERTS_DIR"/* "$CERT_CACHE"
                cp -f  "$CERT_FILE" "$CERT_CACHE"
                    chmod 644 "$CERT_CACHE"/*.0
                    chown 1000:1000 "$CERT_CACHE"/*.0
                    set_context "$APEX_CACERTS_DIR" "$CERT_CACHE"
                mount --bind "$CERT_CACHE" "$APEX_CACERTS_DIR"
            fi
        done
    fi
done
