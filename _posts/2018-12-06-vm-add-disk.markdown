---
layout: post
title: "为Oracle VM 下linux虚拟机添加新硬盘"
categories:  
---


##  1.原因
由于开始创建虚拟机指定的10G系统盘大小，之后使用发现里面空间不够用了，需要在虚拟机里的Ubuntu 添加新的硬盘，由此有了此文

## 2.在vm中添加新磁盘
![添加磁盘](/assets/img/vm-adddisk.png)


## 3.查看ubuntu虚拟机中是否有磁盘

#### 查看虚拟机中是否有磁盘

```shell
sudo fdisk -l
```

#### 给磁盘分区

假设添加磁盘设备为`/dev/sdb`利用fdisk命令为磁盘分区

```shell
sudo fdisk /dev/sdb
```
	
- 输入 n 新建分区 回车
- 输入 p 建立选择主分区
- 设置分区号 默认为第一个分区 回车即可
- 设置分区的起始扇区 默认全盘 回车即可
- 设置完 输入 w 写入磁盘 

#### 格式化分区

使用以下命令格式化分区为ext4

```shell
sudo mkfs.ext4 /dev/sdb1 
```	

#### 挂载分区

我们把分区挂载在/mnt/sdb1下
- 新建/mnt/sdb1 目录
```shell
mkdir -p /mnt/sdb1
```
- 挂载`/dev/sdb1`到`/mnt/sdb1`目录下
```shell
sudo mount /dev/sdb1 /mnt/sdb1
```

就此操作完成此次linux虚拟机添加磁盘操作