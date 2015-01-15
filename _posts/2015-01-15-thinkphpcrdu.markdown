---
layout: post
title: thinkphp,M方法和sql原生联合查询写法对比例子
categories: home
---
{{ page.title}}
{% highlight php %}
//thinkphp M方法查询
$user=new Model();
$list=$user->Table( 'mb_emp_jfrecord jf,mb_emp_rzinfo rz,mb_emp_branch dp,mb_emp_info info' )
->field( 'branch_name,info.emp_name,sum(jf.value) value' )
->where( 'jf.emp_id=rz.emp_id and dp.branch_id=rz.ssdw and info.emp_id=jf.emp_id ' )
->group( 'jf.emp_id' )
->order( 'value desc' )->select();

//sql原生查询
$Model=new Model();
$sql='select
branch_name,
info.emp_name,
sum(jf.value) value
from
mb_emp_jfrecord jf,
mb_emp_rzinfo rz,
mb_emp_branch dp,
mb_emp_info info
where
jf.emp_id=rz.emp_id
and dp.branch_id=rz.ssdw
and info.emp_id=jf.emp_id
group by jf.emp_id';
$u=$Model->query($sql);
-----------------------华丽分割线----------------------------------
//查询当天积分 sql
SELECT emp_id,SUM( value ) as value
FROM  `mb_emp_jfrecord`
WHERE add_time =  date('Y-m-d',time())
GROUP BY  `emp_id`

//查询当月积分sql
$sql="SELECT SUM( value ) ,emp_id
FROM  `mb_emp_jfrecord`
WHERE add_time
like date('Y-m',time()) .'%'
GROUP BY  `emp_id` ";

//查询当天积分
$dayjf=M( 'mb_emp_jfrecord' )->field( 'value,emp_id' )->where( "add_time ='".date( 'Y-m-d', time() ) ."'" )->select();

//查询当月积分
$monthjf=M( 'mb_emp_jfrecord' )->field( 'sum(value) value,emp_id' )->where( "add_time like'" .date( 'Y-m', time() ). "%'" )->group( 'emp_id' )->select();

//查询当年积分
$yearjf=M( 'mb_emp_jfrecord' )->field( 'sum(value) value,emp_id' )->where( "add_time like '" .date( 'Y', time() ). "%'" )->group( 'emp_id' )->select();
{% endhighlight %}