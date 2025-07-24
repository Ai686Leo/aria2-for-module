#!/system/bin/sh  

# 创建log和conf文件夹
LOG_DIR="${0%/*}/log"
CONF_DIR="${0%/*}/conf"

if [ ! -d "$LOG_DIR" ]; then
    mkdir -p "$LOG_DIR"
    echo "日志文件夹已创建：$LOG_DIR"
fi

# log 路径
LOG="${0%/*}/log/action.log"

# 检查 aria2c 进程是否存在并处理  
if pgrep aria2c > /dev/null 2>&1; then 
  echo "Aria2c正在运行，正在杀死进程，请到日志查看详情"  
  # 清除旧日志
  : > "$LOG"
  # 开始记录日志
  exec > "$LOG" 2>&1
    # 如果进程存在，使用 pkill 终止  
    pkill aria2c 
  sleep 0.7
  echo "已杀死进程"  
else  
  # 启动aia2c
  echo "正在启动Aria2c，请到日志查看详情"
  
  # 清除旧日志
  : > "$LOG"
  # 开始记录日志
  exec > "$LOG" 2>&1
  
  if [ ! -d "$CONF_DIR" ]; then
      mkdir -p "$CONF_DIR"
      echo "配置文件夹已创建：$CONF_DIR" 
  fi

  # Aria2配置文件
  CONF="${0%/*}/conf/aria2.conf"

  # 汇总根证书
  cat /system/etc/security/cacerts/*.0 > $CONF_DIR/ca-certificates.crt
  echo "已将根证书汇总到 $CONF_DIR/ca-certificates.crt"

  # 创建默认配置文件（如果不存在）
  if [ ! -f "$CONF" ]; then
    cat > "$CONF" <<EOF
  dir=/sdcard/Download
  enable-rpc=true
  rpc-listen-all=true
  rpc-allow-origin-all=true
  rpc-secret=123456
  rpc-listen-port=6800
  rpc-secure=true
  rpc-private-key=${0%/*}/cert/aria2.key
  rpc-certificate=${0%/*}/cert/aria2.crt
  check-certificate=true
  ca-certificate=$CONF_DIR/ca-certificates.crt
EOF
      echo "aria2配置文件不存在，已创建默认配置文件"
  fi

  # 启动 Aria2 服务
  aria2c --conf-path="$CONF"  &

fi

sleep 2 

