#######################################
#!/bin/bash
#author linx 检查服务启动状态
#######################################
# 如果参数为空提示
echo "监控服务启动情况,0代表未启动，1代表已经启动"
if ( [ $# -lt 1 ] )
then
	echo "请输入查看的服务器!如:$0 cjds-point-service"
else
	for service in $@
	do 
		echo $service `ps -ef |grep "$service"|grep -v "grep" |wc -l`
	done
fi

