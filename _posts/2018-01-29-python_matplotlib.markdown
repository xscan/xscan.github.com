---
layout: post
title: "python3 matplotlib中文显示"
categories: tools
---
{{ page.title}}
```python
自己电脑测试可行：平台：windows,python2.7
步骤一：打开设置文件
import matplotlib
matplotlib.matplotlib_fname()
会显示matplotlibrc文件的地址
步骤二：修改matplotlibrc文件
将文件中的#font.family: sans-serif去掉注释，修改为font.family: Microsoft YaHei
可显示为中文
```
