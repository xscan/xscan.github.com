---
layout: post
title: "npm 代理和仓库设置"
categories: html5
---
{{ page.title}}

## npm更新到最新版本

    npm install -g npm

### 1.显示npm设置

    npm config list


### 2.npm代理

    npm config set proxy 代理连接

### 3.npm仓库设置

    npm config set registry "http://registry.npm.taobao.org/"
