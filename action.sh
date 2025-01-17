#!/system/bin/sh  

# service.sh 脚本路径  
SERVICE="${0%/*}/service.sh"  

# 检查 aria2c 进程是否存在并处理  
if pgrep aria2c > /dev/null 2>&1; then  
  echo "Aria2c正在运行，正在杀死进程……"  
    # 如果进程存在，使用 pkill 终止  
    pkill aria2c 
  sleep 0.7
  echo "已杀死进程"  
else  
  echo "Aria2c未运行，正在启动……"  
    # 如果进程不存在，调用 service.sh 启动服务  
    sh "$SERVICE"  
  sleep 0.7
  echo "已成功启动"  
fi  

echo "将在两秒后退出"
sleep 2 
