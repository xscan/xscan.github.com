---
layout: post
title: thinkphpajax分页
categories: 
---
{{ page.title}}
Thinkphp目录的Lib\ORG\Util\目录里新建AjaxPage.class.php,写入一下内容：

    <?php
    // +----------------------------------------------------------------------
    // | ThinkPHP [ WE CAN DO IT JUST THINK IT ]
    // +----------------------------------------------------------------------
    // | Copyright (c) 2009 http://thinkphp.cn All rights reserved.
    // +----------------------------------------------------------------------
    // | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
    // +----------------------------------------------------------------------
    // | Author: liu21st <liu21st@gmail.com>
    // +----------------------------------------------------------------------
    // $Id: Page.class.php 2712 2012-02-06 10:12:49Z liu21st $

    class AjaxPage {
        // 分页栏每页显示的页数
        public $rollPage = 5;
        // 页数跳转时要带的参数
        public $parameter  ;
        // 默认列表每页显示行数
        public $listRows = 20;
        // 起始行数
        public $firstRow ;
        // 分页总页面数
        protected $totalPages  ;
        // 总行数
        protected $totalRows  ;
        // 当前页数
        protected $nowPage    ;
        // 分页的栏的总页数
        protected $coolPages   ;
        // 分页显示定制
        protected $config  = array('header'=>'条记录','prev'=>'上一页','next'=>'下一页','first'=>'第一页','last'=>'最后一页','theme'=>' %totalRow% %header% %nowPage%/%totalPage% 页 %upPage% %downPage% %first%  %prePage%  %linkPage%  %nextPage% %end%');
        // 默认分页变量名
        protected $varPage;


        public function __construct($totalRows,$listRows='',$ajax_func,$parameter='') {
            $this->totalRows = $totalRows;
            $this->ajax_func = $ajax_func;
            $this->parameter = $parameter;
            $this->varPage = C('VAR_PAGE') ? C('VAR_PAGE') : 'p' ;
            if(!empty($listRows)) {
                $this->listRows = intval($listRows);
            }
            $this->totalPages = ceil($this->totalRows/$this->listRows);     //总页数
            $this->coolPages  = ceil($this->totalPages/$this->rollPage);
            $this->nowPage  = !empty($_GET[$this->varPage])?intval($_GET[$this->varPage]):1;
            if(!empty($this->totalPages) && $this->nowPage>$this->totalPages) {
                $this->nowPage = $this->totalPages;
            }
            $this->firstRow = $this->listRows*($this->nowPage-1);
        }

    public function setConfig($name,$value) {
            if(isset($this->config[$name])) {
                $this->config[$name]    =   $value;
            }
        }


        public function show() {
            if(0 == $this->totalRows) return '';
            $p = $this->varPage;
            $nowCoolPage      = ceil($this->nowPage/$this->rollPage);
            $url  =  $_SERVER['REQUEST_URI'].(strpos($_SERVER['REQUEST_URI'],'?')?'':"?").$this->parameter;
            $parse = parse_url($url);
            if(isset($parse['query'])) {
                parse_str($parse['query'],$params);
                unset($params[$p]);
                $url   =  $parse['path'].'?'.http_build_query($params);
            }
            //上下翻页字符串
            $upRow   = $this->nowPage-1;
            $downRow = $this->nowPage+1;
            if ($upRow>0){
                $upPage="<a id='big' href='javascript:".$this->ajax_func."(".$upRow.")'>".$this->config['prev']."</a>";
            }else{
                $upPage="";
            }

    if ($downRow <= $this->totalPages){
                $downPage="<a id='big' href='javascript:".$this->ajax_func."(".$downRow.")'>".$this->config['next']."</a>";
            }else{
                $downPage="";
            }
            // << < > >>
            if($nowCoolPage == 1){
                $theFirst = "";
                $prePage = "";
            }else{
                $preRow =  $this->nowPage-$this->rollPage;
                $prePage = "<a id='big' href='javascript:".$this->ajax_func."(".$preRow.")'>上".$this->rollPage."页</a>";
                $theFirst = "<a id='big' href='javascript:".$this->ajax_func."(1)' >".$this->config['first']."</a>";
            }
            if($nowCoolPage == $this->coolPages){
                $nextPage = "";
                $theEnd="";
            }else{
                $nextRow = $this->nowPage+$this->rollPage;
                $theEndRow = $this->totalPages;
                $nextPage = "<a id='big' href='javascript:".$this->ajax_func."(".$nextRow.")' >下".$this->rollPage."页</a>";
                $theEnd = "<a id='big' href='javascript:".$this->ajax_func."(".$theEndRow.")' >".$this->config['last']."</a>";
            }
            // 1 2 3 4 5
            $linkPage = "";
            for($i=1;$i<=$this->rollPage;$i++){
                $page=($nowCoolPage-1)*$this->rollPage+$i;
                if($page!=$this->nowPage){
                    if($page<=$this->totalPages){
                       $linkPage .= "&nbsp;<a id='big' href='javascript:".$this->ajax_func."(".$page.")'>&nbsp;".$page."&nbsp;</a>";
                    }else{
                        break;
                    }
                }else{
                    if($this->totalPages != 1){
                        $linkPage .= "&nbsp;<span class='current'>".$page."</span>";
                    }
                }
            }
            $pageStr  =  str_replace(
                array('%header%','%nowPage%','%totalRow%','%totalPage%','%upPage%','%downPage%','%first%','%prePage%','%linkPage%','%nextPage%','%end%'),
                array($this->config['header'],$this->nowPage,$this->totalRows,$this->totalPages,$upPage,$downPage,$theFirst,$prePage,$linkPage,$nextPage,$theEnd),$this->config['theme']);
            return $pageStr;
        }

    }

    ?>

控制器里写入以下内容：
 

    <?php
    class UserAction extends Action{
        public function user(){
              import("ORG.Util.AjaxPage");// 导入分页类  注意导入的是自己写的AjaxPage类
              $credit = M('user');
              $count = $credit->count(); //计算记录数
            $limitRows = 5; // 设置每页记录数
           
            $p = new AjaxPage($count, $limitRows,"user"); //第三个参数是你需要调用换页的ajax函数名
            $limit_value = $p->firstRow . "," . $p->listRows;
           
            $data = $credit->order('id desc')->limit($limit_value)->select(); // 查询数据
            $page = $p->show(); // 产生分页信息，AJAX的连接在此处生成

            $this->assign('list',$data);
            $this->assign('page',$page);
            $this->display();

         }
    }
 
=========我是分界线======================================================
 
模板文件如下：
 {% highlight html %}
<html>
    <head>
        <title>Ajax无刷新分页</title>
        <script type="text/javascript" src="../Public/jquery-1.7.2.min.js"></script>
        <script type="text/javascript">
            function user(id){    //user函数名 一定要和action中的第三个参数一致上面有
                 var id = id;
                    $.get('User/user', {'p':id}, function(data){  //用get方法发送信息到UserAction中的user方法
                     $("#user").replaceWith("<div  id='user'>"+data+"</div>"); //user一定要和tpl中的一致
                });
             }
            
        </script>
    </head>

    <body>
            <div id='user'>   <!--这里的user和下面js中的test要一致-->
                    <volist id='list' name='list'>   <!--内容输出-->
                    <{$list.id}>&nbsp;&nbsp;<{$list.username}><br/>
            </volist>
            <{$page}>  <!--分页输出-->
        </div>
        
    </body>
</html>
{% endhighlight %}