---
layout: post
title: "python yield 协程"
categories: tools 
---

协程，又称微线程，纤程。英文名Coroutine。

协程的概念很早就提出来了，但直到最近几年才在某些语言（如Lua）中得到广泛应用。

子程序，或者称为函数，在所有语言中都是层级调用，比如A调用B，B在执行过程中又调用了C，C执行完毕返回，B执行完毕返回，最后是A执行完毕。

所以子程序调用是通过栈实现的，一个线程就是执行一个子程序。

子程序调用总是一个入口，一次返回，调用顺序是明确的。而协程的调用和子程序不同。

协程看上去也是子程序，但执行过程中，在子程序内部可中断，然后转而执行别的子程序，在适当的时候再返回来接着执行。

注意，在一个子程序中中断，去执行其他子程序，不是函数调用，有点类似CPU的中断。比如子程序A、B：

### 1. 例子
```python
def A():
    print('1')
    yield 10
    print('2')
    yield 20
    print('3')
    yield 30

def B(a):
    res_yield = a.send(None)
    print res_yield
    print('x')
    a.send(None)
    print('y')
    a.send(None)
    print('z')

c=B(A())
```

### 2. 生产者-消费者例子
#### 2.1正常流程（模拟）

```python 
#循环生产一个消费一个
def produce():
    n = 0
    while n < 5:
        n = n + 1
        print('[PRODUCER] Producing %s...' % n)
        if not n:
            return
        print('[CONSUMER] Consuming %s...' % n)
        r = '200 OK'
        print('[PRODUCER] Consumer return: %s' % r)
```
#### 2.2协程实现
```python
# 生产一个跳转到消费者消费
def consumer():
    r = ''
    while True:
        n = yield r
        if not n:
            return
        print('[CONSUMER] Consuming %s...' % n)
        r = '200 OK'

def produce(c):
    c.send(None)
    n = 0
    while n < 5:
        n = n + 1
        print('[PRODUCER] Producing %s...' % n)
        r = c.send(n)
        print('[PRODUCER] Consumer return: %s' % r)
    c.close()

c = consumer()
produce(c)
```

### 3。总结
yield 可以理解为一个占位符，占用一个位置使用send()占用执行