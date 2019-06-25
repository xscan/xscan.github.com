---
layout: post
title: "python Flask框架例子"
categories:  
---


## 1.Flask入门例子
安装`pip install flask`
```python
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello World!'

if __name__ == '__main__':
    app.run()
```

- [flask官网](http://docs.jinkan.org/docs/flask/)
