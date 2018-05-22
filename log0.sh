#######################################
#!/bin/bash
#author linx
#######################################
lineStep=10
arr_number=()

# 监控日志文件的n行到m行
tailfile(){
	file=$1
	fromLine=$2
	toLine=$3
	#计算是否有下一行
	totalLine=`wc -l $file |cut -d " " -f 1`	#总行数
	hasNext=`expr $totalLine - $fromLine`
	if [ $hasNext -lt 1 ]
	then
		return 0
	else
		head -n $toLine $file | tail -n +$fromLine	
		return $hasNext
	fi
}

# 初始化起始行
init(){
	j=0
	for file in $@
	do
		j=`expr $j + 1`
		arr_number[$j]=`wc -l $file | cut -d " " -f 1`	
	done
}

# 如果参数为空提示
if ( [ $# -lt 1 ] )
then
	echo "请输入需要查找的日志文件!如:$0 cjds-point-service"
else
	init $@
	# 实时遍历文件列表
	while true
	i=0
	do
		# 遍历文件列表
		for file in $@
		do 
			i=`expr $i + 1`			#当前第几号文件
			echo "当前log文件为:$file"
			fromLine=${arr_number[$i]}	# 开始行
			toLine=`expr $fromLine + $lineStep` #结束行
			arr_number[$i]=$toLine
			tailfile $file $fromLine $toLine	#输出监控日志
			echo "tailfile $file $fromLine $toLine"
			if [ $? -eq 0 ]
				then
				arr_number[$i]=$fromLine
			fi
		done
		sleep 1
	done
fi



