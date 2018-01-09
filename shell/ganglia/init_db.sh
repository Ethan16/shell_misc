#!/bin/bash

#----------------------------------------
#Purpose：监控数据表的初始化
#Author:zyc
#Time:20160121
#Usage:
#----------------------------------------

MYSQL=`which mysql`

$MYSQL test -u root -padmin123. <<EOF
create table resource(
hostname varchar(30) not null default '',
ip varchar(20) not null default '',
mem_buffers varchar(20) default null,
part_max_used varchar(20) default null,
mem_cached varchar(20) default null,
cpu_wio varchar(20) default null,
cpu_num varchar(20) default null,
cpu_speed varchar(20) default null,
swap_free varchar(20) default null,
bytes_in varchar(20) default null,
swap_total varchar(20) default null,
mem_free varchar(20) default null,
load_fifteen varchar(20) default null,
mem_total varchar(20) default null,
boottime varchar(20) default null,
cpu_idle varchar(20) default null,
cpu_user varchar(20) default null,
cpu_nice varchar(20) default null,
load_five varchar(20) default null,
gexec varchar(20) default null,
cpu_system varchar(20) default null,
disk_free varchar(20) default null,
disk_total varchar(20) default null,
mem_shared varchar(20) default null,
machine_type varchar(20) default null,
proc_total varchar(20) default null,
pkts_in varchar(20) default null,
pkts_out varchar(20) default null,
bytes_out varchar(20) default null,
load_one varchar(20) default null,
os_name varchar(20) default null,
os_release varchar(20) default null,
cpu_aidle varchar(20) default null,
proc_run varchar(20) default null
);

show tables;
EOF
