---
layout: post
title: Github的两种提交方式
categories: home
---

#Github的两种提交方式

##1.HTTPS方式
    
    git remote add origin https://github.com/xscan/xscan.github.com.git
    git push -u origin master

##2.SSH方式
    
    SSH采用密钥方式连接

    1.生成密钥,可以一路回车下去采用默认,之后在用户目录下生成.ssh目录.目录下有id_rsa和is_rsa.pub两个文件，打开is_rsa.pub文件。我们需要这个公钥

        ssh-keygen -t rsa 

    2.进入github网站，进入自己的主页。点击进入需要克隆的项目的主页，点击右边 “<>Code”菜单最下面Settings。进入设置界面。在点击左边菜单“Deploy keys”这个选项。添加一个公钥，title自己输入,key把前面is_rsa.pub文件里面的内容，复制到key。之后点击添加

    3.之后这个项目我们就不需要每次提交输入账号密码了



