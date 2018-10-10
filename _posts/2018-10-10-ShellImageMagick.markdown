---
layout: post
title: "Shell-ImageMagick批量转换图片"
categories:  
---
{{ page.title}}


## 1.场景描述
- 问题：一个车辆网站 存在大量高清图片，访问速度过慢
- 解决方案：写脚本批量转换图片，降低图片质量，图片分辨率不变，png格式转换为jpg格式图片

## 2.代码编写
### 1. 基本思路解析：
    1. 获取所有图片文件全路径和文件名称
    2. 用ImageMagick的Convert工具转换格式与图片质量
### 2. 技术要求：
    1. shell
    2. ImageMagick

### 3. 编写遍历文件夹及子文件夹脚本保存为 `getDir.sh `


        #!/bin/bash
        function getdir(){
            for element in `ls $1`
            do  
                dir_or_file=$1"/"$element
                if [ -d $dir_or_file ]
                then 
                    getdir $dir_or_file
                else
                    echo $dir_or_file
                fi  
            done
        }

        root_dir="./demo/images"
        getdir $root_dir


### 4. 运行脚本写入img_list.txt文件

    bash getDir.sh |grep -E ".jpg|.png" > img_list.txt 


### 5.编写脚本convert.sh 用于读取img_list.txt中文件全路径

        cat img_list.txt | while read line
        do
        newline=${line//png/jpg}
        convert.exe -background white -flatten -quality 50 "${line}" "${newline}"
        echo "convert:${line}"
        done




## 3.其他判断小技巧

    1.判断字符串尾部是否存在相同
    echo "File:${line}"
    if [[ $line == *$png ]]
    then
        echo "ok"
    else
        echo "no"
    fi

    2.判断字符串中是否包含子字符串
    A="helloworld"
    B="low"
    if [[ $A == *$B* ]]
    then
        echo "包含"
    else
        echo "不包含"
    fi




