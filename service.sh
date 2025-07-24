#!/system/bin/sh

if [ -e "${0%/*}/noaria2"]; then
    exit 1
else
    # action.sh 脚本路径  
    ACTION="${0%/*}/action.sh"  
    sh "$ACTION"  
fi
