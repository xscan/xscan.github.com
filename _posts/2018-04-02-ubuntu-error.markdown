---
layout: post
title: "ubuntu16.04图形界面错误"
categories: all 
---
{{ page.title}}

Ubuntu系统启动报错：The system is running in low-graphics mode


通常这种情况是由于ATI显卡引起的。按ALT+CTRL+F2 进入命令行模式, 用以下方法就可以解决


        sudo apt-get update
        sudo apt-get purge flglrx
        sudo reboot


最后使用这个步骤，竟然顺利进入图形界面了。
 
注意下面的 X11 要大写 X


        01.   cd /etc/X11  
        02.   sudo cp xorg.conf.failsafe xorg.conf 

reboot重启就好了