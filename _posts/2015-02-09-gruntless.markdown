---
layout: post
title: Grunt-Less插件(1)
categories: home
---
{{ page.title}}

##项目结构

###编译前
	.
	├── css
	│   └── test.less
	├── Gruntfile.js
	├── node_modules
	│   ├── grunt
	│   ├── grunt-contrib-less
	│   └── l
	└── package.json
			

###编译后
		.
		├── css
		│   ├── test.css
		│   ├── test.less
		│   └── test-min.css
		├── Gruntfile.js
		├── node_modules
		│   ├── grunt
		│   ├── grunt-contrib-less
		│   └── l
		└── package.json

##流程


	1 新建项目目录

	mkdir less
	cd less

	2 建立package.json和Gruntfile.js文件

	* 新建package.json插件下载配置文件。。这里一路确定下去
	* 安装less编译插件，--save-dev 添加这个插件到package.json文件里面
	* 新建Gruntfile.js文件
	* 打开Gruntfile.js

	npm init 
	
	npm install grunt-contrib-less --save-dev 
	
	>Gruntfile.js

	sudo gedit Gruntfile.js

	//写入任务配置如下
		module.exports = function (grunt) {
		//编写任务
		  grunt.initConfig({
		    less: {
		      compile: {
		        files: {
		          'css/test.css': 'css/test.less'
		        }
		      },
		      compress: {
		        files: {
		          'css/test-min.css': 'css/test.css'
		        },
		        options: {
		          compress: true
		        }
		      }
		    }
		  });
		  // 载入插件
		  grunt.loadNpmTasks('grunt-contrib-less');
		//定义默认任务
		  grunt.registerTask('default', ['less']);
		};

		3 建立编译输出文件夹

		mkdir css
		cd css
		>test.less
		  //test.less内容
			@base: #f938ab;

			.box-shadow(@style, @c) when (iscolor(@c)) {
			  -webkit-box-shadow: @style @c;
			  box-shadow:         @style @c;
			}
			.box-shadow(@style, @alpha: 50%) when (isnumber(@alpha)) {
			  .box-shadow(@style, rgba(0, 0, 0, @alpha));
			}
			.box {
			  color: saturate(@base, 5%);
			  border-color: lighten(@base, 30%);
			  div { .box-shadow(0 0 5px, 30%) }
			}		

		4 执行Gruntfile.js定义的任务
		grunt less

