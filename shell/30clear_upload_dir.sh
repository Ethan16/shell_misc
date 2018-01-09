#!/bin/bash
#用于执行不定时的下载以及凌晨升级

LOG_BASE_DIR=/sf/log

. func-common.sh
CE="-e "
CLOG_PRE=" VLC "
CLOG_PATH=$LOG_BASE_DIR/today/clear_upload_dir.log
. func-clog.sh

ldebug "\n\n\n###########################$0 $* @ $(date +'%Y-%m-%d %H:%M:%S')###########################";

# 上传的目录
clear_dirs="/tmp/ondisk/backup  /tmp/ondisk/syslog"

# 根据现在的时间来计算超时时间
timeout_val=$(expr $(date --date="-1 hour" +"%Y%m%d%H%M%S") + 0);

for clear_dir in $clear_dirs; do
	if [ ! -d $clear_dir ]; then
		continue;
	fi
	
	# clear_dir内的文件，若是超过1小时没有访问，则删除
	for dir in `ls $clear_dir/`; do
		dir_access_time=$(stat $clear_dir/$dir  | sed -n '5 p' | awk '{print $2 $3}' | cut -d"." -f1 | sed -e 's/-//g' -e 's/://g');
		if [ $dir_access_time -lt $timeout_val ]; then
			rm -rf $clear_dir/$dir;
			ldebug "rm -rf $clear_dir/$dir";
		fi
	done
done

ldebug "end $0"
exit 0
