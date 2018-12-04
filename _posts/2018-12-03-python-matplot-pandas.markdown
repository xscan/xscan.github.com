---
layout: post
title: "python可视化分析58租房信息（二）"
categories:  
---
{{ page.title}}

## 1.数据去重
```python
# -*- coding: utf-8 -*-
import pandas as pd

data = pd.read_csv('./save.csv',encoding='utf8')
# 删除重复数据
data.columns = ['type','size','address','price']
primarykey = data.drop_duplicates()

print(primarykey)

primarykey.to_csv('./data.csv')
```

## 2.数据分析

![可视化图片](/assets/img/Figure_1.png)
我们来统计`暮云地区租房`和`最多房源的地区`和`平均价格最高的前5个地区`代码如下

```python
from matplotlib import pyplot as plt
import pandas as pd
import numpy as np

plt.rcParams['font.sans-serif'] = ['SimHei']  # 用来正常显示中文标签
plt.rcParams['axes.unicode_minus'] = False  # 用来正常显示负号
sdata = pd.read_csv('./data.csv',encoding='utf8')

# 删除第一列
df = sdata.drop(['Unnamed: 0'],axis=1)
# 根据地址分组
address = df.groupby('address')

# 添加6个图库
fig, axes = plt.subplots(nrows=3, ncols=2)

ax0, ax1, ax2, ax3,ax4,ax5 = axes.flatten()
# 根据地址统计各地区租房信息个数
# plt.plot() pd索引为x，plt.plot(y) plot(y)为y

# 统计
sumcount = df['price'].groupby(df['address']).count().sort_values()

#最多房源排名前5的地区
ax0.set_title('最多房源排名前5的')
ax0.bar(list(sumcount[-5:].keys()),sumcount[-5:].values.reshape(-1),alpha=0.9, width = 0.35, facecolor = 'lightskyblue', edgecolor = 'white', label='one', lw=1)

# 平均价格最贵的地区
top5avg = df['price'].groupby(df['address']).mean().sort_values()
ax1.set_title('平均价格最贵的地区')
ax1.bar(list(top5avg[-5:].keys()),top5avg[-5:].values.reshape(-1),alpha=0.9, width = 0.35, facecolor = 'lightskyblue', edgecolor = 'white', label='one', lw=1)

# ax1.grid(True)

# 暮云户型数量
muyun = address.get_group('暮云').sort_values(by=['size','price']).groupby('type').count()
ax2.set_title('暮云出租户型数量图')
ax2.plot(muyun['price'])
ax2.grid(True)


# 暮云出租户型百分比图
ax3.set_title('暮云出租户型百分比图')
ax3.pie(muyun['size'],labels=muyun.index,shadow=True,startangle=90,autopct='%1.1f%%')
ax3.axis('equal')



# 暮云出租户型的平均价格
ax4.set_title('暮云出租户型的平均价格')
muyunavgprice = address.get_group('暮云').groupby('type').mean()
ax4.plot(list(muyunavgprice.index),muyunavgprice.values.reshape(-1))


#查看暮云地区房价 
muyun = address.get_group('暮云').sort_values(by=['size','price']).groupby('type').mean()
ax5.set_title('暮云出租户型平均价格图')
ax5.bar(list(muyun.index),muyun.values.reshape(-1), alpha=0.9, width = 0.35, facecolor = 'lightskyblue', edgecolor = 'white', label='one', lw=1)

plt.show()

```

