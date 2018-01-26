#!/bin/bash
#touch ../_posts/test.markdown


function a(){
if [ $# -gt 2 ];then
echo "cans 2"
fi
}
function createPorts (){
datetime=`date -d today +"%Y-%m-%d-"`
#cat > $datetime$1.markdown << EOF
cat > ../_posts/$datetime$1.markdown << EOF
---
layout: post
title: "$2"
categories: $3 
---
{{ page.title}}

EOF
}

if [ x$1 != x ];then
createPorts $1 $2 $3
else 
echo "create 文件名 标题 类别";  
fi



