#######################################
#!/bin/bash
#author linx
#
#######################################
echo "日志记录脚本开始..."
#dir=C:/Users/linx/Desktop/test
#todir=D:/APP

dir=/APP/web/logs
todir=~/log

function writeToDir(){
	logdir=$1
	logDate=$2
	logtodir=$3
	for element in `ls $logdir`
	do
		echo "<<==开始处理文件:$logdir/$element"
		if [ -d $logdir/$element ]
		then
			# 判断文件夹下是否存在符合条件的文件
			count=`ls $logdir/$element |grep .*log-$logDate.*\.error\.log$ |wc -l`
			if [ $count -eq 0 ]  
			then 
				continue
			fi
			#判断文件是否存在,不存在则删除
			if [ ! -d $logtodir/$element ]
				then 
					mkdir $logtodir/$element
			fi
			echo "==>>写入文件:"$logtodir/$element/$logDate.error.log
			# 获取错误日志信息，写入文件
			cat $logdir/$element/log-$logDate*.error.log |grep -v 'DubboMonitor'|grep -A6 '^'${logDate}'.*ERROR*' > $logtodir/$element/$logDate.error.log
		fi
	done
}

if ( [ $# -lt 1 ] )
then
	echo "请输入需要查找的时间!如:./logerror.sh 2018-08-08"
else
	writeToDir $dir $1 $todir
fi
