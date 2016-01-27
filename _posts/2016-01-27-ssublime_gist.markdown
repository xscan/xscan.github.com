---
layout: post
title: sublime+github-gist在线代码片段
categories: home
---

# 1. 安装package controll
使用ctrl+`(esc下面那个按键)打开siblime命令行

这里我直接引用sublime官方的

sublime2

    import urllib2,os,hashlib; h = '2915d1851351e5ee549c20394736b442' + '8bc59f460fa1548d1514676163dafc88'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); os.makedirs( ipp ) if not os.path.exists(ipp) else None; urllib2.install_opener( urllib2.build_opener( urllib2.ProxyHandler()) ); by = urllib2.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); open( os.path.join( ipp, pf), 'wb' ).write(by) if dh == h else None; print('Error validating download (got %s instead of %s), please try manual install' % (dh, h) if dh != h else 'Please restart Sublime Text to finish installation')


sublime3

    import urllib.request,os,hashlib; h = '2915d1851351e5ee549c20394736b442' + '8bc59f460fa1548d1514676163dafc88'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)


# 2. 安装gist插件
    命令如下
     1. 打开命令界面 Ctrl+Shift+P
     2. 安装包回车 Install Package
     3. 输入gist查找安装


# 3. 在自己的github获取gist access token
    1.登陆githuub
    2.找到右上角图标，找到Setting这一栏，点击进入
    3.找到Personal access tokens ，点击
    4。找到Generate new token，点击进入之后填写token的描述，select scopes选择gist,创建成功后你会得到access token，这个在sublime中要用到
# 4. 本地配置gist
  在第二步我们在sublime已经安装好了gist.下面我们来使用它
  1.在首选项->插件设置找到gist,打开setting-default（默认设置）填入在第三步获取的access token,
  2.配置github账号密码。接着上面的，在打开setting-user。里面是你github的账号密码，格式如下

    {
      "username":"你的github账号",
      "password":"你的密码"
    }
    保存。

# 5.使用
  我这里只推荐你个常用的

  * 打开gist在线代码列表 Ctrl+K，CTRL+O
  * 创建gist代码片段 Ctrl+K，CTRL+I

那就介绍到这里了，小伙伴们是时候可以好好管理自己的代码片段了
