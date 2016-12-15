---
layout: post
title: "Windows PowerShell初体验"
categories: home
---

##先看效果


    # create new excel instance
     $objExcel = New-Object -comobject Excel.Application
     $objExcel.Visible = $True
     $objWorkbook = $objExcel.Workbooks.Add()
     $objWorksheet = $objWorkbook.Worksheets.Item(1)
     # write information to the excel file
    $i = 0
    $first10 = (ps | sort ws -Descending | select -first 10)
    $first10 | foreach -Process {$i++; $objWorksheet.Cells.Item($i,1) = $_.name; $objWorksheet.Cells.Item($i,2) = $_.ws}
    $otherMem = (ps | measure ws -s).Sum - ($first10 | measure ws -s).Sum
    $objWorksheet.Cells.Item(11,1) = "Others"; $objWorksheet.Cells.Item(11,2) = $otherMem
    # draw the pie chart
    $objCharts = $objWorksheet.ChartObjects()
    $objChart = $objCharts.Add(0, 0, 500, 300)
    $objChart.Chart.SetSourceData($objWorksheet.range("A1:B11"), 2)
    $objChart.Chart.ChartType = 70
    $objChart.Chart.ApplyDataLabels(5)


1. 这个脚本调用了Excel的COM库。
2. 当然从命令耦合的角度来看，输出成文本格式更有利，但这个例子主要想说明PowerShell的强大以及微软产品优异的复用性。
3. 要手动启动PowerShell，可以在开始菜单的搜索框中直接键入PowerShell回车即可）
简单领略PowerShell的强大之后，下文就从几个方面介绍一下PowerShell相对于以往版本的命令提示符甚至Linux Shell的优势

##调用自定义dll

在Windows的世界里，.Net代表着现在和将来，是新生力量。与.Net联姻，就意味着榜上了粗腿，迈上了快车道。号称基于.Net Framework，
那么使用.Net的基类就易如反掌。基本步骤如下：
1. 添加类所在程序集；
2. 创建类的实例；
3. 调用实例的函数或者属性。以StringBuilder类为例，代码如下


    Add-Type -AssemblyName mscorlib
    $str = New-Object System.Text.StringBuilder
    $str.Append("Hello")
    $str.ToString()

其实最让人开心的，是PowerShell能够使用自定义的.Net类库。这意味着我们的产品或者工具都能在PowerShell中继续有效。基本步骤是：写一个类库，编译成DLL，导入到PowerShell会话中，然后所定义的函数和属性都可以使用了。示例如下：
首先写好代码，编译成DLL，假设路径是D:\PowerShellDemo\PowerShellDemo.dll。


    using System;
    namespace PowerShellDemo
    {
        public class PowerShellDemo
        {
            public void Greet()
            {
                Console.WriteLine("Hello!");
            }
        }
    }


然后将其导入到PowerShell会话中，并使用其函数或者属性。

    Add-Type –Path “D:\PowerShellDemo\PowerShellDemo.dll”
    $obj = New-Object PowerShellDemo.PowerShellDemo
    $obj.Greet()


以上调用的输出是Hello字符串.
如此容易就能使用.Net的托管程序集，必然为它招徕一大票簇拥。


##执行策略限制


Powershell一般初始化情况下都会禁止脚本执行。脚本能否执行取决于Powershell的执行策略。


    PS E:> Get-ExecutionPolicy

更改脚本执行策略，可以通过


    PS E:> Get-ExecutionPolicy
    Restricted
    PS E:> Set-ExecutionPolicy UnRestricted



##后文

突然发现Windows PowerShell还是很强大的，只要是.net可以做的他都可以做
