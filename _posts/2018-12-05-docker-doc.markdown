---
layout: post
title: "Docker 速查手册"
categories:  
---
{{ page.title}}
最近在学习Dcker总结了一下命令如下

### 1.镜像篇
镜像基本命令

| 命令 | 描述 |
|---|---|
|docker search 镜像名称|查找镜像|
|docker pull 镜像名称|拉取镜像|
|docker push|提交镜像|
|docker images|列出所有镜像|
|docker image rm 镜像id或者名称|删除镜像|
|docker build -t 镜像名称 .|编译根据Dockerfile编译镜像|
|docker tag 源镜像[:TAG] 目标镜像[:TAG] |列出所有镜像|

运行镜像


	docker run 镜像名称

### 2.容器篇
这两条命令相等`docker container ps = docker ps`

| 命令 | 描述 |
|---|---|
|docker ps -a|列出所有容器|
|docker rm 容器id|删除容器|
|docker start 容器id|启动容器|
|docker stop 容器id|停止容器|
|docker commit 容器id 新镜像名称|容器转镜像|

批量停止镜像 $() = \`\` 执行当前命令


	docker stop $(docker ps -aq)


