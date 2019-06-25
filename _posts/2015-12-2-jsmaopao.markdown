---
layout: post
title: js冒泡
categories: home
---


javascript, jquery的事件中都存在事件冒泡和事件捕获的问题，下面将两种问题及其解决方案做详细总结。

事件冒泡是一个从子节点向祖先节点冒泡的过程；

事件捕获刚好相反，是从祖先节点到子节点的过程。 

下面来看一个js阻止默认事件跳转,采用event事件（代码如下）

    	<a class="btn btn-danger btn-xs" href="http://www.baidu.com" onclick="fun(event)">跳转</a>
		<script>
		function fun(event){
			console.log(event);
			if(!confirm('是否删除')){
				//阻值a链接跳转事件
				event.preventDefault();
			}
		}
		</script>

还有一种


	<a class="btn btn-danger btn-xs" href="http://www.baidu.com" onclick="return fun(event)">跳转</a>
		<script>
		function fun(event){
			console.log(event);
			if(!confirm('是否删除')){
				//阻值a链接跳转事件
				return false;
			}
		}
		</script>

冒泡暂时我只看到这些

	event.stopPropagation 停止冒泡
	event.preventDefault() 阻止默认事件

下面摘抄了一写代码片段


	阻止冒泡事件
		var el = window.document.getElementById("a");
	    el.onclick = function (e) {
	        //如果提供了事件对象，则这是一个非IE浏览器
	        if (e && e.stopPropagation) {
	            //因此它支持W3C的stopPropagation()方法
	            e.stopPropagation();
	        }
	        else {
	            //否则，我们需要使用IE的方式来取消事件冒泡 
	            window.event.cancelBubble = true;
	            return false;
	        }
	    }


	  阻止默认事件
		var el = window.document.getElementById("a");
	    el.onclick = function (e) {
	        //如果提供了事件对象，则这是一个非IE浏览器
	        if (e && e.preventDefault) {
	            //阻止默认浏览器动作(W3C) 
	            e.preventDefault();
	        }
	        else {
	            //IE中阻止函数器默认动作的方式 
	            window.event.returnValue = false;
	            return false;
	        }
	    }
        
        
暂时先到说到这