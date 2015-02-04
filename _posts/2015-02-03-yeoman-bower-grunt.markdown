---
layout: post
title: 搭建yeoman-bower+grunt前端流
categories: html5
---

##1.简介

####一个有八字胡的男人+一只澳大利亚的肥鸟+一头发怒的野猪在一起能触碰出什么火花呢？
<h1>
<img src="http://yeoman.io/assets/img/yeoman-02.6442.png" alt="yo" width="100px" height="100px">+
<img src="http://segmentfault.com/img/bVcOG5" alt="bower" width="100px" height="100px">+
<img src="http://segmentfault.com/img/bVcOG2" alt="grunt" width="100px" height="100px">=?
</h1>


###答案在下面
前端工作流

###以下下是我自己理解和到网上找的一些资料整合的

yeoman可以方便web开发者快速构建出一个标准化结构的web项目流程。它不只是一个工具，是一个工作流程，这个工作流程包含了3个工具。

+ [yeoman](http://yeoman.io/) 下载框架（脚手架）
+ [bower](http://bower.io/)  下载插件（包管理器）
+ [grunt](http://www.gruntjs.net/) 整和代码，测试代码，压缩代码（构建工具）



##2.前期工作

（本人是在ubuntu14.04下 所以省略了npm的安装，windows自行下载安装）

先安装好我们需要的环境（-g 表示安装到全局变量）

	npm install -g yo grunt-cli bower

##3.构建项目

###yeoman-bower+grunt操作流程(以下用webapp库做例子)：

	mkdir webapp （建立项目文件夹）
	cd webapp	（进入文件夹）
	npm install -g generator-webapp （安装webapp框架）
	yo webapp	（安装框架）
	npm install	（检查,下载package.json文件里的依赖包）
	bower install	（检查,下载bower.json文件里插件依赖包）
	grunt	(执行Gruntfile.js里面定义的任务)





