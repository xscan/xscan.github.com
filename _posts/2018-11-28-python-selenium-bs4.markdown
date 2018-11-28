---
layout: post
title: "python可视化分析58租房信息（一）"
categories: tools,python
---
{{ page.title}}

# （一）数据爬取
## 技术储备
[Selenium中文文档](https://selenium-python-zh.readthedocs.io/en/latest/)
[Beautifulsoup中文文档](https://beautifulsoup.readthedocs.io/zh_CN/v4.4.0/#id)
[Matplotlib教程](https://www.cnblogs.com/duye/p/8862666.html)
[pandas速查手册](https://blog.csdn.net/qq_33399185/article/details/60872853)

- Selenium+bs4(爬取页面+解析页面数据)
- pandas+matplotlib(分析数据+可视化数据)

## 1.通用流程分析
1. 爬取信息
2. 数据清洗
    2.1 无效数据清洗
    2.2 数据去重
3. 数据分析
4. 数据可视化


## 2.需求分析
- 爬取58同城租房信息(由于58同城采用cookie来获取数据，我们采用selenium +bs4来爬取数据)
- 通过pandas清洗、分析数据
- 通过matplotlib数据可视化分析

## 3.爬取数据(实例代码)
```python
#coding:utf-8
from selenium import webdriver
from pprint import pprint
import time
import json
import re
from bs4 import BeautifulSoup


def parsePage(html):
    soup = BeautifulSoup(html, 'html.parser')
    for sel in soup.select('ul.listUl li'):       
        try:
            prices = sel.select('div.money b')[0].contents[0]
            titles =sel.select('div.des h2 a')[0].contents[0]
            rooms =sel.select('p.room')[0].contents[0].split()
            adds = sel.select('p.add a')[0].contents[0]

            print titles,rooms[0],rooms[1],adds,prices
            # 58爬虫采用css3自定义字体文件 我们这边通过正则过滤掉价格不是数字的数据
            if re.search('[\d]',prices) == None:
                    continue
            s = "%s,%s,%s,%s"%(rooms[0],rooms[1],adds,prices)
            with open('./save.csv','a+') as f:
                f.write(s.encode('utf-8')+"\n")
            pass
        except IndexError :
            continue
            pass

driver=webdriver.Chrome()

driver.get('https://cs.58.com/')

cookies = driver.get_cookies()

time.sleep(5)
# 点击租房
driver.find_element_by_xpath('/html/body/div[3]/div[1]/div[1]/div/div[1]/div[1]/span[1]/a').click()
time.sleep(3)

while True:
    # 切换页面，由于点击租房，会新开一个页面，所以我们这边切换一下页面。要不然不能获取到最新的页面信息
    driver.switch_to_window(driver.window_handles[-1])
    # print cookies
    cookies = driver.get_cookies()
    pprint(cookies)

    response=driver.page_source
    parsePage(response)
    time.sleep(5)
    try:
        next = driver.find_element_by_class_name('next').click()
        pass
    except:
        print(u'爬取完成')
        break
        pass
    


```