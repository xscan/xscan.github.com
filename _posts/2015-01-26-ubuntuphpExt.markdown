---
layout: post
title: ubuntu-php5.5.9安装mongodb数据库扩展
categories: 
---


	1. wget http://pecl.php.net/get/mongo-1.4.5.tgz
	2. tar zxvf mongo-1.4.5.tgz
	3. cd mongo-1.4.5
	4. phpize(运行此命令生成./configureure)
	5. ./configureure
	6. make
	7. sudo make install( 此地方最好加sudo 用root权限执行。本人就在这个地方卡了很久)
	8. 查找php.ini。在php.ini里加入extension=mongo.so这行
	9.重启apache2 ：service apache2 restart(最好重启一下系统)