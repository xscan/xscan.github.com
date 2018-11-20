---
layout: post
title: "python 简单二叉树实现"
categories:  tools
---
{{ page.title}}

### 1.二叉树理解

二叉树是有限个元素的集合，该集合或者为空、或者有一个称为根节点（root）的元素及两个互不相交的、分别被称为左子树和右子树的二叉树组成。

- 二叉树的每个结点至多只有二棵子树(不存在度大于2的结点)，二叉树的子树有左右之分，次序不能颠倒。
-  二叉树的第i层至多有2^{i-1}个结点
- 深度为k的二叉树至多有2^k-1个结点；
- 对任何一棵二叉树T，如果其终端结点数为N0，度为2的结点数为N2，则N0=N2+1

### 2.二叉树实现
####1. 定义节点类

```python
class Node:
    def __init__(self,item):
        self.item = item
        self.childl = None
        self.childr = None
```
####2. 定义树类
```python

class Tree(object):
    # 未插入左右节点队列
    lists = []
    # 初始化根节点
    def __init__(self):
        self.root = None
    def add(self,item):
        pass

```

### 3.完整实现代码
```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
class Node:
    def __init__(self,item):
        self.item = item
        self.childl = None
        self.childr = None

class Tree(object):
    # 未插入左右节点队列
    lists = []
    # 初始化根节点
    def __init__(self):
        self.root = None
    def add(self,item):
        node = Node(item)
        # 判断节点是否为空
        if self.root is None:
            self.root = node
            self.lists.append(self.root)
        else:
            while True:

                # 取出第一个节点
                pop_node = self.lists[0]
                # 如果左边节点无数据则把当前节点放置在父节点左边，当前节点 加入 未插入左右节点队列
                if pop_node.childl is None:
                    pop_node.childl = node
                    # 当前节点 加入 未插入左右节点队列 
                    self.lists.append(pop_node.childl)
                    return 
                # 如果左边节点无数据则把当前节点放置在父节点右边 当前节点 加入 未插入左右节点队列 
                if pop_node.childr is None:
                    pop_node.childr = node
                    # 当前节点 加入 未插入左右节点队列 
                    self.lists.append(pop_node.childr)
                    # 弹出左右节点完整的节点 
                    self.lists.pop(0)
                    return

    # 层序遍历
    def prints(self):
        if self.root is None:
            return None
        # 定义节点队列
        q = [self.root]
        # 返回数据队列
        res = [self.root.item]
        while q != []:
            # 取出根节点
            pop_node = q.pop(0)
            if pop_node.childl is not None:
                # 添加左节点到队列
                q.append(pop_node.childl)
                res.append(pop_node.childl.item)

            if pop_node.childr is not None:
                q.append(pop_node.childr)
                res.append(pop_node.childr.item)
        return res

    def preorder(self,root):  # 先序遍历
        if root is None:
            return []
        result = [root.item]
        left_item = self.preorder(root.childl)
        right_item = self.preorder(root.childr)
        return result + left_item + right_item
        
    def inorder(self,root):  # 中序遍历
        if root is None:
            return []
        result = [root.item]
        left_item = self.preorder(root.childl)
        right_item = self.preorder(root.childr)
        return  left_item + result + right_item

    def postorder(self,root): # 后序遍历
        if root is None:
            return []
        result = [root.item]
        left_item=self.postorder(root.childl)
        right_item=self.postorder(root.childr)
        return left_item + right_item + result

if __name__=='__main__':
    t=Tree()
    for x in range(10):
        t.add(x)

    print t.prints()
    print t.preorder(t.root)
    print t.inorder(t.root)
    print t.postorder(t.root)
```