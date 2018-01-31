#!/bin/bash
base_url="http://200.200.166.1:8082/artifactory/AutoTestEnv"

# 所有需要下载的文件路径
file_paths=(
    /sf/data/local/iso/debian-live-amd64-custom_for_sdn_test.iso \
    /sf/data/local/iso/debian-live-amd64-custom_for_sdn_test.qcow2 \
    /sf/data/local/iso/debian-live-amd64-custom_for_sdn_test.vma \
    /sf/data/local/iso/ubuntu_for_sdn_test.qcow2 \
    /sf/data/local/iso/ubuntu_vs.qcow2 \
    /sf/data/local/iso/UNALIGNED.qcow2 \
    /usr/bin/load_cfs_ini.pl \
    /usr/bin/set_cfs_ini.pl \
    /usr/bin/load_vm_config.pl \
    /usr/bin/set_vm_config.pl \
    /usr/bin/checklv.sh \
    /usr/bin/vst_get_vm_screendump.pl \
)

# 所有需要下载的目录及目录下的文件
dir_path=(
    /sf/data/local/iso/auto_backup_dir \
    /sf/data/local/iso/backup_dir \
    /sf/data/local/iso/backup_md5 \
    /sf/data/local/iso/tpl_backup_dir \
    /sf/data/local/passcmd_util
)

# 如果是perl脚本或shell脚本,则需要加上执行权限
function add_exec_permission_if_is_script() {
    local download_file_path=$1
    if [ "${download_file_path#*.}" == 'pl' ] || [ "${download_file_path#*.}" == 'sh' ]; then
        `chmod +x ${download_file_path}`
    fi
}

# 下载文件
function download_file() {
    for file_path in ${file_paths[@]}
    do
        # 下载
        base_name=`basename ${file_path}`
        `wget -O ${file_path} ${base_url}/${base_name}`
        add_exec_permission_if_is_script ${file_path}
    done
}

# 下载目录及目录下的所有文件
function download_dir() {
    for dir in ${dir_path[@]}
    do
        # 下载
        base_dirname=`basename ${dir}`
        `wget -r -np -nd -P ${dir} ${base_url}/${base_dirname}/`

        filelist=`ls ${dir}`
        for file in $filelist
        do
            add_exec_permission_if_is_script ${dir}/${file}
        done
    done
}

download_file
download_dir

