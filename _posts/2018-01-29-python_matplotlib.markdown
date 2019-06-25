---
layout: post
title: "python3 matplotlib中文显示"
categories: tools
---


## 1.修改matplotlib文件
自己电脑测试可行：平台：windows,python2.7
### 步骤一：打开设置文件


```python
import matplotlib
matplotlib.matplotlib_fname()
```
会显示matplotlibrc文件的地址

### 步骤二：修改matplotlibrc文件
将文件中的`#font.family: sans-serif`去掉注释，修改为`font.family: Microsoft YaHei`即可显示为中文

## 2.设置全局字体
```python
from matplotlib import pyplot as plt
import pandas as pd
import numpy as np

plt.rcParams['font.sans-serif'] = ['SimHei']  # 用来正常显示中文标签
plt.rcParams['axes.unicode_minus'] = False  # 用来正常显示负号

```
