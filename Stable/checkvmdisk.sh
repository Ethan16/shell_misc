#!/bin/bash

windows_vmid_file=/sf/data/local/lxf/windows_vmid.log
linux_vmid_file=/sf/data/local/lxf/linux_vmid.log
hy_vmid_file=/sf/data/local/lxf/hy_vmid.log
appstack_vmid_file=/sf/data/local/lxf/appstack_vmid.log
result=/sf/data/local/lxf/result.txt

qm-c list | grep windows | grep _ | awk -F " " '{print $1}' > $windows_vmid_file
qm-c list | grep linux00 | grep _ | awk -F " " '{print $1}' > $linux_vmid_file
qm-c list | grep hy | grep _ | awk -F " " '{print $1}' > $hy_vmid_file
qm-c list | grep APPSTACK | awk -F " " '{print $1}' > $appstack_vmid_file

echo "====================check windows VM Disk====================" >> $result
for vmid in `cat $windows_vmid_file`
do
    echo "===========$vmid begin==========" >> $result
    cd `get_vm_dir_by_vmid.pl $vmid`
    qemu-img info vm-disk-1.qcow2 &>> $result
    qemu-img check vm-disk-1.qcow2 &>> $result
    echo "==========$vmid end==========" >> $result
done

echo "====================check linux VM Disk====================" >> $result
for vmid in `cat $linux_vmid_file`
do
    echo "===========$vmid begin==========" >> $result
    cd `get_vm_dir_by_vmid.pl $vmid`
    qemu-img info vm-disk-1.qcow2 &>> $result
    qemu-img check vm-disk-1.qcow2 &>> $result
    echo "==========$vmid end==========" >> $result
done

echo "====================check hy VM Disk====================" >> $result
for vmid in `cat $hy_vmid_file`
do
    echo "===========$vmid begin==========" >> $result
    cd `get_vm_dir_by_vmid.pl $vmid`
    qemu-img info vm-disk-1.qcow2 &>> $result
    qemu-img check vm-disk-1.qcow2 &>> $result
    echo "==========$vmid end==========" >> $result
done

echo "====================check appstack VM Disk====================" >> $result
for vmid in `cat $appstack_vmid_file`
do
    echo "===========$vmid begin==========" >> $result
    cd `get_vm_dir_by_vmid.pl $vmid`
    qemu-img info vm-disk-1.qcow2 &>> $result
    qemu-img check vm-disk-1.qcow2 &>> $result
    echo "==========$vmid end==========" >> $result
done

cd /sf/data/local/lxf
