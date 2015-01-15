---
layout: post
title: jquerypost提交方法
categories: home
---
{{ page.title}}
{% highlight html %}
$.post("{:U('Admin/Messmassage/SendMsg')}", {//提交的Url
id: 'asd'//提交的数据
},
 function(data, status) {//回调函数
	alert(data.message)
 });
{% endhighlight %}
