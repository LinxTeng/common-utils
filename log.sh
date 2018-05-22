#######################################
#!/bin/bash
#author linx
#######################################
prefix="/APP/web/logs/"	# 定义前缀
suffix="/log.log" # 定义后缀
# 如果参数为空提示
if ( [ $# -lt 1 ] )
then
	echo "请输入需要查找的日志文件!如:$0 cjds-point-service"
else
	# 遍历文件列表
	i=0
	for file in $@
	do
		i=`expr $i + 1`		#当前第几号文件
		filelocal[$i]=${prefix}${file}${suffix}
	done
        tail -f ${filelocal[@]}
fi



