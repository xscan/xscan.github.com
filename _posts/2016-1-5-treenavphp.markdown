---
layout: post
title: thinkpphp二级菜单
categories: home
---
{{ page.title}}
# 1.sql数据表
      DROP TABLE IF EXISTS `nav`;
      CREATE TABLE `nav` (
        `id` int(11) NOT NULL AUTO_INCREMENT,
        `name` text NOT NULL,
        `pid` int(11) NOT NULL,
        PRIMARY KEY (`id`)
      ) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=gbk;

      -- ----------------------------
      -- Records of nav
      -- ----------------------------
      INSERT INTO `nav` VALUES ('1', '电动车', '0');
      INSERT INTO `nav` VALUES ('2', '手机', '0');
      INSERT INTO `nav` VALUES ('3', '电脑', '0');
      INSERT INTO `nav` VALUES ('4', 'vivo', '2');
      INSERT INTO `nav` VALUES ('5', '小米', '2');
      INSERT INTO `nav` VALUES ('6', '联想电脑', '3');
      INSERT INTO `nav` VALUES ('7', '惠普电脑', '3');
      INSERT INTO `nav` VALUES ('8', '艾玛电动', '1');
      INSERT INTO `nav` VALUES ('9', '小电动', '1');

# 2.控制器

    public function nav(){
        $list=M('nav')->where('pid=0')->select();
            foreach ($list as $key => $value) {
                $list[$key]['child']=M('nav')->where("pid=".$value['id'])->select();
            }
            return $list;
    }

    
# 3.模板

      	<foreach name="nav" item="vo">
      	<ul>
      		<li>{$vo.name}
      			<ul>
      				<foreach name="vo.child" item="v">
      					<li>{$v.name}</li>
      				</foreach>
      			</ul>
      		</li>
      	</ul>
      </foreach>

# 4.后记
  就是这样子咯，记得配置数据库配置文件哦！！！
