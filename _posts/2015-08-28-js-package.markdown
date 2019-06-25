---
layout: post
title: javascript封装实例
categories: home
---

		

		//函数模块化
		 con=function(spec){
			var str=spec || '';
			var that={};

			that.get=function(){
				console.log(str)
				return this;
			}
			that.push=function(a){
				console.log(a)
				return this;
			}
			return that;
		}
		var fun=con('get')
		fun.get();
		fun.push('push');

		//原型扩展
		var obj=function(name){
			this.name=name||'你没有输 入值';
		};
		obj.prototype.tools=function(){
			alert(this.name)
		}
		var a=new obj();
		a.tools()
		//函数参数json化
		var obj=function({first:f,last:s}){
			console.log(f)
			console.log(s)
		}
		obj({'last':'1','first':'2'})