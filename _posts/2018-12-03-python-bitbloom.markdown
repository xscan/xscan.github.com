---
layout: post
title: "python布隆过滤器简单实现"
categories:  python,tools
---
{{ page.title}}

```python
#coding=utf-8
class Bloomfilter(object):
    """
    布隆过滤器-根据hash%size求出位置,判断是否重复
    """
    def __init__(self, size):
        """初始化布隆过滤器"""
        self.values = [False] * size
        self.size = size

    def hash_value(self, value):
        """通过hash的值计算位置"""
        return hash(value) % self.size

    def add_value(self, value):
        """添加值到布隆过滤器"""
        h = self.hash_value(value)
        self.values[h] = True

    def might_contain(self, value):
        """检查值是否是布隆过滤器中"""
        h = self.hash_value(value)
        return self.values[h]

    def print_contents(self):
        """打印过滤器"""
        print self.values


bf = Bloomfilter(10)
bf.add_value('dog')
bf.add_value('fish')
bf.add_value('cat')
bf.print_contents()
bf.add_value('bird')
bf.print_contents()
# Note: contents are unchanged after adding bird - it collides
for term in ['dog', 'fish', 'cat', 'bird', 'duck', 'emu']:
    print '{}: {} {}'.format(term, bf.hash_value(term), bf.might_contain(term))

```