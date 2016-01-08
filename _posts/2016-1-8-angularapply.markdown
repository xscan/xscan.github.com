---
layout: post
title: AngularJS状态改变视图不同步(解决)
categories: html5
---

# 1.问题描述

    当然,有时候你也会发现明明数据变化了.但是UI没有刷新,是双向绑定失效了吗?
    没有
    只是在 $scope 模型遍历 digest 循环时,你的数据还没有返回来,
    案例：
      1)需要实现一个这样的效果，
      登陆前：显示登陆页面
      登陆后：我的信息页面

# 2.想象是美好的

这里为了方便我都写到一个页面，当然是实际项目肯定不是这样写咯

* 问题描述：赋值一个变量为name，过2秒后改变name值。

代码如下：


    <!DOCTYPE html>
    <html>
    <head>
    <meta charset="utf-8">
    <script src="http://apps.bdimg.com/libs/angular.js/1.4.6/angular.min.js"></script>
    </head>
    <body>

    <div ng-app="myApp" ng-controller="personCtrl">

    {{name}}
    </div>

    <script>
    var app = angular.module('myApp', []);
    app.controller('personCtrl', function($scope) {
      $scope.name='Hello';
      setTimeout(function() {
        $scope.name= 'Hello World!';
      }, 2000);
    });
    </script>

    </body>
    </html>
# 3.现实的残酷

然而想象是美好的，现实是残酷的。2秒之后，木有变化。到底咋回事呢？呵呵。
麻痹原来是视图刷新木有同步。所有我们后面要手动同步一下视图
代码如下：

    setTimeout(function() {
      $scope.name= 'Hello World!';
     $scope.$apply();
    }, 2000);


相信大家可能都遇到这样的坑过，
具体原理大家可以看下一介布衣的描述，附带[传送门](http://yijiebuyi.com/blog/30cdefc95f924a88f526850b74d1083c.html)


# 4. 十八层地狱

还是不行，还是同步不了，哥哥只能采用猥琐一个方法，借用angularjs的自带神器ng-model来做个中转了

* 视图

{% highlight html %}

    <input type="text" ng-model="keyworld" ng-show="false">  
         <div style="text-align:center;display:block">
             <span style="display:block" ng-show="keyworld !=''">
               <ion-spinner icon="bubbles" class="spinner-balanced"></ion-spinner>
               <span style="">正在获取地理位置</span>
             </span>
             <span style="display:block" ng-hide="keyworld !=''">{{address}}</span>
        </div>

{% endhighlight %}

* 控制器

      直接采用
      $scope.keyworld=''
      $scope.keyworld='hide'
      来控制视图变化

因为ng-model他是双向数据绑定的

# 5.收工睡觉
