---
layout: post
title: "mongodb数据去重"
categories: home
---
{{ page.title}}

### 1.建立唯一索引 去除数据库中重复值

> db.test.ensureIndex({"userid":1},{"unique":true,"dropDups":true})


###  2.我们同样可以创建复合唯一索引，即保证复合键值唯一即可。如：
> db.test.ensureIndex({"userid":1,"age":1},{"unique":true})   

### 3.基本查询

> db.test.find({})

### 4.like查询
#### 单条件like
sql查询语句
>select * from mongodb where title like "PHP"

MongoDB 查询语句
>db.getCollection('mongodb').find({title:/PHP/})

#### 多条件like
>db.getCollection('mongodb').find({$or:[{title:/php/},{title: /PHP/}]})

### 5.And查询

>db.getCollection('mongodb').find({title:/php/,ext:'azw3'})
