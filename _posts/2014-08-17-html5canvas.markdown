---
layout: post
title: HTML5 Canvas 画心
categories: html5
---
<html>
	<head>
		<meta charset="utf-8" />
		<title>HTML5 Canvas 心</title>
	</head>
	<body>
		
		<canvas id="x" height="500" width="500"></canvas>
		<script type="text/javascript">
			var ob=document.getElementById("x");
			var c=ob.getContext("2d");
			c.lineWidth=2;
			c.strokeStyle='green';
			c.beginPath();
			c.moveTo(250,160);
			c.bezierCurveTo(200,125,175,200,250,250) ;
			c.moveTo(250,160);
			c.bezierCurveTo(300,125,325,200,250,250) ;
			c.stroke();
		</script>
	</body>
</html>

{% highlight html %}
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>HTML5 Canvas 心</title>
	</head>
	<body>
		
		<canvas id="x" height="1000" width="1000"></canvas>
		<script type="text/javascript">
			var ob=document.getElementById("x");
			var c=ob.getContext("2d");
			c.lineWidth=2;
			c.strokeStyle='green';
			c.beginPath();
			c.moveTo(500,320);
			c.bezierCurveTo(400,250,350,400,500,500) ;
			c.moveTo(500,320);
			c.bezierCurveTo(600,250,650,400,500,500) ;
			c.stroke();
		</script>
	</body>
</html>
{% endhighlight %}

