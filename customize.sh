ui_print "- 正在释放文件"
# 默认不删除温控，非必要情况下建议保留温控
# unzip -o "$ZIPFILE" 'RESOURCES/system/*' -d $MODPATH >&2
unzip -o "$ZIPFILE" 'config.yaml' -d "/storage/emulated/0/Android/" >&2
echo "[$(date '+%m-%d %H:%M:%S.%3N')] All-In-One v1.2 模块安装成功, 等待重启" >> "/storage/emulated/0/Android/config.yaml.log"
ui_print "- All-In-One 优化模块 v1.2"
ui_print "- 对系统 CPU / GPU / 内存深度优化"
ui_print "- 可自行查看 service.sh 与 system.prop 文件"
ui_print "- 配置文件在 /storage/emulated/0/Android/config.yaml"
ui_print "- 作者 QQ: 854675824 | 酷安@TheCheese"
ui_print "- 模块安装结束 重启生效"