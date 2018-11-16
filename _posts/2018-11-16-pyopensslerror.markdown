---
layout: post
title: "python pip openssl 错误"
categories:  
---
{{ page.title}}

删除python openssl库重新安装即可
### 1.删除库

    sudo rm -rf /usr/lib/python2.7/dist-packages/OpenSSL
    sudo rm -rf /usr/lib/python2.7/dist-packages/pyOpenSSL-0.15.1.egg-info


### 2.从新安装

    sudo apt install python-openssl



