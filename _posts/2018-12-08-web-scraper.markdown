---
layout: post
title: "web版scrapy chome插件webscraper"
categories:  tools
---
{{ page.title}}

[webscraper官网](https://www.webscraper.io/)

一款方便在chome浏览器运行的爬虫插件，试用了一下比较方便。官网上有视频教程和测试网站，花了2个小时左右即可抓取基本的数据，对于ajax，分页抓取也很简单

## 1.安装

在google chome 中扩展插件搜索`webscraper`点击安装即可

## 2.用例
试用了一下抓取了月光博客和长沙地区58同城租房信息。我这边直接导出了两个，需要的可以直接在`webscraper`点击`import sitemap`复制一下json到导入页面。

月光博客文章列表爬取
```JSON
{
	"_id": "ygblog",
	"startUrl": ["https://www.williamlong.info/cat/?page=1"],
	"selectors": [{
		"id": "page-items",
		"type": "SelectorElement",
		"parentSelectors": ["_root", "next-page"],
		"selector": "div#divMain",
		"multiple": true,
		"delay": 0
	}, {
		"id": "next-page",
		"type": "SelectorLink",
		"parentSelectors": ["_root", "next-page"],
		"selector": "div.post.pagebar a:nth-of-type(n+2)",
		"multiple": true,
		"delay": 0
	}, {
		"id": "item",
		"type": "SelectorElement",
		"parentSelectors": ["page-items"],
		"selector": "div.post",
		"multiple": true,
		"delay": 0
	}, {
		"id": "title",
		"type": "SelectorText",
		"parentSelectors": ["item"],
		"selector": "h2.post-title a",
		"multiple": true,
		"regex": "",
		"delay": 0
	}]
}
```

长沙地区58同城租房信息爬取
```json
{
	"_id": "cs-58zhufang",
	"startUrl": ["https://cs.58.com/zufang/?PGTID=0d200001-0019-ed6c-6a42-329b77b2ef33&ClickID=1"],
	"selectors": [{
		"id": "items",
		"type": "SelectorElement",
		"parentSelectors": ["_root", "pagein"],
		"selector": "ul.listUl li",
		"multiple": true,
		"delay": 0
	}, {
		"id": "title",
		"type": "SelectorText",
		"parentSelectors": ["items"],
		"selector": "a.strongbox",
		"multiple": false,
		"regex": "",
		"delay": 0
	}, {
		"id": "price",
		"type": "SelectorText",
		"parentSelectors": ["items"],
		"selector": "div.money",
		"multiple": false,
		"regex": "",
		"delay": 0
	}, {
		"id": "room",
		"type": "SelectorText",
		"parentSelectors": ["items"],
		"selector": "p.room",
		"multiple": false,
		"regex": "",
		"delay": 0
	}, {
		"id": "address",
		"type": "SelectorText",
		"parentSelectors": ["items"],
		"selector": "p.add",
		"multiple": false,
		"regex": "",
		"delay": 0
	}, {
		"id": "pagein",
		"type": "SelectorLink",
		"parentSelectors": ["_root", "pagein"],
		"selector": "div.pager a",
		"multiple": true,
		"delay": 0
	}]
}
```
