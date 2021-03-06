/*
Navicat MySQL Data Transfer

Source Server         : 测试环境
Source Server Version : 50154
Source Host           : master.mysql.fdd:3306
Source Database       : fy_new_me

Target Server Type    : MYSQL
Target Server Version : 50154
File Encoding         : 65001

Date: 2013-07-12 18:18:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for #readme
-- ----------------------------
DROP TABLE IF EXISTS `#readme`;
CREATE TABLE `#readme` (
  `change_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `change_author` varchar(50) NOT NULL COMMENT '作者',
  `change_sql` text NOT NULL COMMENT '变更SQL',
  `change_comment` varchar(255) NOT NULL COMMENT '变更备注',
  `change_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变更时间',
  PRIMARY KEY (`change_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='做为本库说明及结构变更记录（需手动添加），每一个库必备本表';

-- ----------------------------
-- Table structure for fy_basic_audit_record
-- ----------------------------
DROP TABLE IF EXISTS `fy_basic_audit_record`;
CREATE TABLE `fy_basic_audit_record` (
  `record_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '记录id',
  `flow_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '审核流程id',
  `follow_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '跟进id',
  `audit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '审核时间',
  `audit_status` char(10) NOT NULL COMMENT '审核状态',
  `audit_remark` varchar(300) NOT NULL DEFAULT '' COMMENT '审核意见',
  `audit_object` varchar(20) NOT NULL DEFAULT '' COMMENT '审核对象 部门，职务，职员',
  `work_type` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '工作类型',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '审核人ID',
  `audit_code` mediumint(8) NOT NULL DEFAULT '0' COMMENT '状态码',
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='审核记录表';

-- ----------------------------
-- Table structure for fy_basic_code
-- ----------------------------
DROP TABLE IF EXISTS `fy_basic_code`;
CREATE TABLE `fy_basic_code` (
  `code_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '代码id',
  `code_prefix` varchar(10) NOT NULL DEFAULT '' COMMENT '代码名称',
  `code_value` int(10) unsigned NOT NULL COMMENT '代码自增值',
  `code_module` tinyint(2) unsigned NOT NULL COMMENT '代码模块 1:公司,2:部门类型,3:职务,4:职称,5:部门,6:岗位,7:职员,8:客源,9楼盘,10:房源,11:字段,12:选项,13:角色,14:账号,16:客源租赁\n更多请见CodeLogic的注释',
  `code_length` tinyint(2) unsigned NOT NULL COMMENT '代码总长度',
  PRIMARY KEY (`code_id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for fy_basic_field
-- ----------------------------
DROP TABLE IF EXISTS `fy_basic_field`;
CREATE TABLE `fy_basic_field` (
  `field_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '字段id',
  `field_code` char(10) NOT NULL COMMENT '字段代码',
  `field_operation_name` varchar(60) NOT NULL DEFAULT '' COMMENT '字段数据名',
  `field_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '字段所属范围=>1:楼盘字典,2:房源管理,3:客源管理,...100:公共选项',
  `field_module` tinyint(4) unsigned NOT NULL COMMENT '字段所属板块=>11:楼盘,12:栋座,13:单元,14:房屋,21:买房,22:租房,31:买客,32:租客,1:公共',
  `field_name` varchar(20) NOT NULL COMMENT '字段名称(中文)',
  `field_header_order` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否可排序(表头配置)=>1:是,2:否',
  `field_header_width` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '字段宽度(表头配置)',
  `field_header_align` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '字段对齐方式(表头配置)=>1:left,2:center,3:right',
  `set_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '选项id',
  `field_can_set` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否可配置(字段维护)=>1:是,2:否',
  `field_can_require` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否可选填必填=>1:是,2:否',
  `field_can_use` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否可启用关闭=>1:是,2:否',
  PRIMARY KEY (`field_id`),
  UNIQUE KEY `field_code` (`field_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='字段表';

-- ----------------------------
-- Table structure for fy_basic_field_company_map
-- ----------------------------
DROP TABLE IF EXISTS `fy_basic_field_company_map`;
CREATE TABLE `fy_basic_field_company_map` (
  `map_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '字段映射id',
  `company_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '公司id',
  `field_id` int(11) unsigned NOT NULL COMMENT '字段id',
  `field_using` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否启用=>1:启用,2:关闭',
  `field_requiring` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否必填=>1:必填,2:选填',
  PRIMARY KEY (`map_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='字段公司映射表';

-- ----------------------------
-- Table structure for fy_basic_header
-- ----------------------------
DROP TABLE IF EXISTS `fy_basic_header`;
CREATE TABLE `fy_basic_header` (
  `header_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '表头id',
  `header_module` varchar(100) NOT NULL,
  `header_fields` varchar(400) NOT NULL COMMENT '表头全部字段',
  PRIMARY KEY (`header_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='表头配置表';

-- ----------------------------
-- Table structure for fy_basic_header_user_map
-- ----------------------------
DROP TABLE IF EXISTS `fy_basic_header_user_map`;
CREATE TABLE `fy_basic_header_user_map` (
  `map_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '映射id',
  `header_id` int(11) unsigned NOT NULL COMMENT '表头id',
  `user_id` int(11) unsigned NOT NULL COMMENT '用户id',
  `fields` varchar(400) NOT NULL COMMENT '表头字段',
  PRIMARY KEY (`map_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='表头用户映射表';

-- ----------------------------
-- Table structure for fy_basic_option
-- ----------------------------
DROP TABLE IF EXISTS `fy_basic_option`;
CREATE TABLE `fy_basic_option` (
  `option_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '选项值id',
  `set_id` int(11) unsigned NOT NULL COMMENT '选项id',
  `option_key` tinyint(4) unsigned NOT NULL COMMENT '选项键',
  `option_value` varchar(20) NOT NULL COMMENT '选项值',
  PRIMARY KEY (`option_id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='选项值表';

-- ----------------------------
-- Table structure for fy_basic_option_set
-- ----------------------------
DROP TABLE IF EXISTS `fy_basic_option_set`;
CREATE TABLE `fy_basic_option_set` (
  `set_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '选项id',
  `set_code` char(10) NOT NULL COMMENT '选项代码',
  `set_name` varchar(20) NOT NULL COMMENT '选项名称',
  `set_can_configure` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '是否可配置',
  PRIMARY KEY (`set_id`),
  UNIQUE KEY `set_code` (`set_code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='选项集表';

-- ----------------------------
-- Table structure for fy_basic_region
-- ----------------------------
DROP TABLE IF EXISTS `fy_basic_region`;
CREATE TABLE `fy_basic_region` (
  `region_id` int(11) NOT NULL COMMENT '区域ID',
  `region_name` varchar(30) NOT NULL COMMENT '名称',
  `region_property` varchar(30) NOT NULL COMMENT '属性',
  `region_alias` varchar(30) NOT NULL COMMENT '别名',
  `region_level` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '区域层级',
  `region_using` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1启用 0不启用',
  PRIMARY KEY (`region_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='行政区域表';

-- ----------------------------
-- Table structure for fy_basic_set_company_map
-- ----------------------------
DROP TABLE IF EXISTS `fy_basic_set_company_map`;
CREATE TABLE `fy_basic_set_company_map` (
  `map_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '选项公司映射id',
  `company_id` int(11) unsigned NOT NULL COMMENT '公司id',
  `set_id` int(11) unsigned NOT NULL COMMENT '选项id',
  `options` varchar(400) NOT NULL DEFAULT '' COMMENT '勾选了的选项值  以,隔开',
  PRIMARY KEY (`map_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='选项公司映射表';

-- ----------------------------
-- Table structure for fy_cus_collect
-- ----------------------------
DROP TABLE IF EXISTS `fy_cus_collect`;
CREATE TABLE `fy_cus_collect` (
  `collect_id` int(10) NOT NULL COMMENT '收藏id',
  `collect_cus_id` int(10) NOT NULL DEFAULT '0' COMMENT '收藏客户id',
  `collect_user_id` int(10) NOT NULL DEFAULT '0' COMMENT '收藏用户id',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  PRIMARY KEY (`collect_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='淘宝池客户收藏';

-- ----------------------------
-- Table structure for fy_cus_config
-- ----------------------------
DROP TABLE IF EXISTS `fy_cus_config`;
CREATE TABLE `fy_cus_config` (
  `f_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '规则自增id',
  `f_key` tinyint(1) NOT NULL DEFAULT '0' COMMENT '规则类型=>(1:持有量上限,2:查重,3:淘宝池规则) ',
  `company_id` int(11) NOT NULL DEFAULT '0' COMMENT '公司id',
  `f_value` varchar(200) NOT NULL DEFAULT '' COMMENT '规则内容',
  PRIMARY KEY (`f_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='客源规则配置表';

-- ----------------------------
-- Table structure for fy_cus_customer
-- ----------------------------
DROP TABLE IF EXISTS `fy_cus_customer`;
CREATE TABLE `fy_cus_customer` (
  `c_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '客源id',
  `c_name` varchar(30) NOT NULL DEFAULT '' COMMENT '客源姓名',
  `c_sex` tinyint(1) NOT NULL DEFAULT '0' COMMENT '客源性别 1:男,2:女',
  `c_cellphone` varchar(100) NOT NULL DEFAULT '' COMMENT '客源手机号',
  `entrust_date` date NOT NULL DEFAULT '0000-00-00' COMMENT '委托日期',
  `c_numbers` char(10) NOT NULL DEFAULT '' COMMENT '客源编号',
  `c_nature` tinyint(1) NOT NULL DEFAULT '0' COMMENT '客源性质=>(1:私客,2:公客)',
  `c_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '需求类型=>(1:求租,2:求购)',
  `c_source` tinyint(1) NOT NULL DEFAULT '0' COMMENT '客户来源',
  `c_nationality` tinyint(1) NOT NULL DEFAULT '0' COMMENT '客户国籍',
  `c_age` tinyint(1) NOT NULL DEFAULT '0' COMMENT '客户年龄',
  `id_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '客户证件类型',
  `id_card` varchar(30) NOT NULL DEFAULT '' COMMENT '客户证件号',
  `people_numbers` int(11) NOT NULL DEFAULT '0' COMMENT '客户家庭居住人数',
  `marital_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '客户婚姻状况',
  `decision_maker` varchar(10) NOT NULL COMMENT '决策人',
  `month_income` tinyint(1) NOT NULL DEFAULT '0' COMMENT '客户月收入',
  `first_payment` tinyint(1) NOT NULL DEFAULT '0' COMMENT '首付',
  `pay_type` varchar(10) NOT NULL DEFAULT '' COMMENT '付款方式',
  `work_unit` varchar(50) NOT NULL DEFAULT '' COMMENT '工作单位',
  `c_address` varchar(50) NOT NULL DEFAULT '' COMMENT '客户居住地址',
  `work_address` varchar(50) NOT NULL DEFAULT '' COMMENT '工作单位地址',
  `loan_times` tinyint(1) NOT NULL DEFAULT '0' COMMENT '贷款次数',
  `buy_times` tinyint(1) NOT NULL DEFAULT '0' COMMENT '购房次数',
  `buy_experience` text COMMENT '购房经历',
  `follow_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最近跟进日期',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '客源创建日期',
  `update_time` date NOT NULL DEFAULT '0000-00-00' COMMENT '客源最后修改日期',
  `provide_id` int(11) NOT NULL DEFAULT '0' COMMENT '客源录入者id',
  `department_id` int(11) NOT NULL DEFAULT '0' COMMENT '录入者所属部门',
  `company_id` int(4) NOT NULL DEFAULT '0' COMMENT '录入者所属公司',
  `belong_id` int(11) NOT NULL DEFAULT '0' COMMENT '客源归属者id',
  `belong_did` int(11) NOT NULL DEFAULT '0' COMMENT '客源归属者所属部门',
  `belong_comid` int(4) NOT NULL DEFAULT '0' COMMENT '客源归属者所属公司',
  `c_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '客源状态=>(1:新建,2:有效,3:预定,4:暂缓,5:已租,6:已购,7:我租,8:我购,9:未知,10:托管,11:无效)',
  `c_level` tinyint(1) NOT NULL DEFAULT '0' COMMENT '客源等级',
  `business_name` varchar(30) NOT NULL DEFAULT '' COMMENT '商机名称',
  `business_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '客户商机状态=>(1:潜客,2:1看,3:2看,4:复看,5:斡旋)',
  `follow_days` int(11) NOT NULL DEFAULT '0' COMMENT '已推进天数',
  PRIMARY KEY (`c_id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='客源表';

-- ----------------------------
-- Table structure for fy_cus_demand
-- ----------------------------
DROP TABLE IF EXISTS `fy_cus_demand`;
CREATE TABLE `fy_cus_demand` (
  `demand_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '客户需求编号',
  `c_id` int(11) NOT NULL DEFAULT '0' COMMENT '客源编号',
  `house_type_upper` tinyint(1) NOT NULL DEFAULT '0' COMMENT '期望户型(上限)',
  `requerst_area_upper` smallint(5) NOT NULL DEFAULT '0' COMMENT '期望面积(上限)',
  `house_price_upper` int(11) NOT NULL DEFAULT '0' COMMENT '购房总价(上限)',
  `average_price` int(11) NOT NULL DEFAULT '0' COMMENT '购房均价',
  `house_direction` varchar(10) NOT NULL DEFAULT '' COMMENT '期望朝向',
  `requerst_decoration` varchar(10) NOT NULL DEFAULT '' COMMENT '期望装修',
  `house_user` varchar(10) NOT NULL DEFAULT '' COMMENT '物业用途',
  `purpose` varchar(10) NOT NULL DEFAULT '' COMMENT '购房目的',
  `preference` varchar(10) NOT NULL DEFAULT '' COMMENT '客户偏好',
  `school_district` tinyint(1) NOT NULL DEFAULT '0' COMMENT '学区要求',
  `house_id` int(11) NOT NULL DEFAULT '0' COMMENT '意向楼盘',
  `request_region` varchar(10) NOT NULL DEFAULT '' COMMENT '意向区域',
  `request_block` varchar(10) NOT NULL DEFAULT '' COMMENT '意向板块',
  `requerst_year` varchar(10) NOT NULL DEFAULT '' COMMENT '期望年份',
  `house_type_lower` tinyint(1) NOT NULL DEFAULT '0' COMMENT '户型区间(下限)',
  `requerst_area_lower` smallint(5) NOT NULL DEFAULT '0' COMMENT '期望面积(下限)',
  `house_price_lower` int(11) NOT NULL DEFAULT '0' COMMENT '购房总价(下限)',
  `floor_upper` smallint(4) DEFAULT '0' COMMENT '楼层上限',
  `floor_lower` smallint(4) DEFAULT '0' COMMENT '楼层下限',
  PRIMARY KEY (`demand_id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='客源购房需求表';

-- ----------------------------
-- Table structure for fy_cus_follow
-- ----------------------------
DROP TABLE IF EXISTS `fy_cus_follow`;
CREATE TABLE `fy_cus_follow` (
  `cus_follow_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '客户跟进id',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '客户跟进人id',
  `cus_id` int(10) NOT NULL DEFAULT '0' COMMENT '客户id',
  `house_id` varchar(30) NOT NULL DEFAULT '0' COMMENT '约看/带看/斡旋跟进的房源id ',
  `cus_follow_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '客户跟进类型=>（1:普通跟进, 2 :约看  ,3:带看  ,4:斡旋 ）',
  `cus_follow_way` tinyint(1) NOT NULL DEFAULT '0' COMMENT '跟进方式=>(1:去电 , 2,来电,  3,看房,  4,约看, 5 ,勘察 , 6,来访 ,7 ,拜访,  8,派单,  9,短信,  10,邮件)',
  `cus_taobao_follow` int(4) NOT NULL DEFAULT '0' COMMENT '是否淘宝池跟进0否（1,2,3）',
  `follow_content` text NOT NULL COMMENT '跟进内容',
  `audit_result` tinyint(1) NOT NULL DEFAULT '0' COMMENT '审核结果=>( 1:通过 ,2:拒绝 ,3: 待审)',
  `cus_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '客源类型 =>(1 :买卖，2 :租凭)',
  `follow_date` date NOT NULL DEFAULT '0000-00-00' COMMENT '跟进日期',
  `follow_create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  PRIMARY KEY (`cus_follow_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='客户跟进表（跟进，带看，约看，斡旋）';

-- ----------------------------
-- Table structure for fy_cus_history
-- ----------------------------
DROP TABLE IF EXISTS `fy_cus_history`;
CREATE TABLE `fy_cus_history` (
  `cus_history_id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `customer_id` int(10) NOT NULL DEFAULT '0' COMMENT '客户id',
  `operator_id` int(10) NOT NULL DEFAULT '0' COMMENT '变更操作人id',
  `change_record_type` int(10) NOT NULL DEFAULT '0' COMMENT '变更类型=>(1:新增,2:编辑,3:删除,4:审核)',
  `department_id` int(10) NOT NULL DEFAULT '0' COMMENT '所属部门',
  `history_remark` varchar(255) NOT NULL DEFAULT '' COMMENT '变更信息',
  `history_before_value` varchar(50) NOT NULL DEFAULT '' COMMENT '变更前的值',
  `history_after_value` varchar(50) NOT NULL DEFAULT '' COMMENT '变更后的值',
  `work_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '工作类型=>(1:买卖,2:租赁)',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `history_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '变更状态=>(1 审核通过 ,2审核中 ,  3 已拒绝 )',
  `cus_module` tinyint(1) NOT NULL DEFAULT '0' COMMENT '所属模块=>(1:客户信息,2:跟进,3:转介,4:分配,5:客源,6:新客审核,7:转私客审核,8:跟进审核)',
  PRIMARY KEY (`cus_history_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='客源客户操作历史表';

-- ----------------------------
-- Table structure for fy_cus_notice
-- ----------------------------
DROP TABLE IF EXISTS `fy_cus_notice`;
CREATE TABLE `fy_cus_notice` (
  `notice_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '客源提醒表主键',
  `c_id` int(11) NOT NULL DEFAULT '0' COMMENT '客源编号',
  `notice_date` date NOT NULL DEFAULT '0000-00-00' COMMENT '提醒日期',
  `notice_content` text COMMENT '提醒内容',
  `create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建提醒记录的日期',
  PRIMARY KEY (`notice_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='客源提醒表';

-- ----------------------------
-- Table structure for fy_cus_schedule
-- ----------------------------
DROP TABLE IF EXISTS `fy_cus_schedule`;
CREATE TABLE `fy_cus_schedule` (
  `sch_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '调度id',
  `sch_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '客户调度类型 =>(1转介 ,2分配)',
  `sch_operator_id` int(10) NOT NULL DEFAULT '0' COMMENT '(转介,分配)操作者id',
  `customer_id` int(10) NOT NULL DEFAULT '0' COMMENT '客户id',
  `sch_from_user_id` int(10) NOT NULL DEFAULT '0' COMMENT '客户原所属用户id',
  `sch_from_department_id` int(4) NOT NULL DEFAULT '0' COMMENT '客户原所属用户部门',
  `sch_to_user_id` int(10) NOT NULL DEFAULT '0' COMMENT '(转介,分配)给用户id',
  `sch_to_department_id` int(4) NOT NULL DEFAULT '0' COMMENT '(转介,分配)给部门id',
  `reason_allocate` tinyint(2) NOT NULL DEFAULT '0' COMMENT '分配原因=>(1 :客户太多,2:人事变动,3 :能力有限,4 :其它)',
  `reason_referral` tinyint(2) NOT NULL DEFAULT '0' COMMENT '转介原因=>(1:非本区域 ,2 :客户太多 ,3 :能力有限,4 :其它)\n            ',
  `percent` tinyint(4) NOT NULL DEFAULT '0' COMMENT '转介百分比',
  `sch_mark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `sch_status` tinyint(1) NOT NULL DEFAULT '3' COMMENT '调度状态=>(1:已接收,2:拒绝,3:待接收)',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `sch_last_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后更新时间',
  `effect` tinyint(1) NOT NULL DEFAULT '0' COMMENT '转介有效性=>(1:有效，2:无效)',
  PRIMARY KEY (`sch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='客户调度表(分配，转介)';

-- ----------------------------
-- Table structure for fy_dictionary_follow
-- ----------------------------
DROP TABLE IF EXISTS `fy_dictionary_follow`;
CREATE TABLE `fy_dictionary_follow` (
  `follow_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '精耕记录id',
  `room_id` int(11) unsigned NOT NULL COMMENT '房屋id',
  `follow_purpose` tinyint(2) unsigned NOT NULL COMMENT '精耕目的{1:议价,2:独家,3:限时,4:验房,5:拿钥匙,6:带看反馈,7:保鲜翻盘,8:情感联接,9:斡旋谈判}',
  `follow_type` tinyint(1) unsigned NOT NULL COMMENT '精耕类型{1:电话,2:短信,3:面谈,4:电子邮件,5:QQ,6:其他}',
  `follow_content` varchar(255) NOT NULL DEFAULT '' COMMENT '精耕内容',
  `follow_result` varchar(100) NOT NULL DEFAULT '' COMMENT '精耕结果',
  `follow_create_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建人',
  `follow_create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `audit_status` smallint(1) unsigned NOT NULL DEFAULT '0' COMMENT '审核状态',
  PRIMARY KEY (`follow_id`),
  KEY `index_room` (`room_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='精耕(跟进)记录表';

-- ----------------------------
-- Table structure for fy_dictionary_house
-- ----------------------------
DROP TABLE IF EXISTS `fy_dictionary_house`;
CREATE TABLE `fy_dictionary_house` (
  `house_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '楼盘id',
  `house_code` char(10) NOT NULL DEFAULT '' COMMENT '楼盘代码',
  `house_name` varchar(30) NOT NULL DEFAULT '' COMMENT '楼盘名称',
  `house_name_pinyin` varchar(30) NOT NULL DEFAULT '' COMMENT '楼盘名称拼音（用于智能匹配搜索）',
  `house_name_pinyin_first_word` varchar(30) NOT NULL DEFAULT '' COMMENT '楼盘名称拼音首字母（用于智能匹配搜索）',
  `house_alias` varchar(30) NOT NULL DEFAULT '' COMMENT '楼盘别名',
  `house_part` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '期数 0:不分期,$num:期数',
  `house_city` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所属城市(fk)',
  `house_area` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所属城区(fk)',
  `house_business_circle` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所属商圈(fk)',
  `house_address_street` varchar(20) NOT NULL DEFAULT '' COMMENT '物业地址街',
  `house_address_num` varchar(20) NOT NULL DEFAULT '' COMMENT '物业地址号',
  `house_building_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '楼盘栋数',
  `house_family_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '楼盘户数',
  `house_use` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '楼盘用途 F000000133',
  `house_opening` date NOT NULL DEFAULT '0000-00-00' COMMENT '开盘时间',
  `house_tags` varchar(30) NOT NULL DEFAULT '' COMMENT '标签',
  `house_intro` varchar(200) NOT NULL DEFAULT '' COMMENT '小区简介',
  `house_building_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '建筑类型 F000000128',
  `house_structure` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '建筑结构 F000000127',
  `house_project_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '项目类别 F000000126',
  `house_era` year(4) NOT NULL DEFAULT '0000' COMMENT '建成年份',
  `house_building_area` varchar(20) NOT NULL DEFAULT '' COMMENT '建筑面积',
  `house_cover_area` varchar(20) NOT NULL DEFAULT '' COMMENT '占地面积',
  `house_volume_rate` varchar(20) NOT NULL DEFAULT '' COMMENT '容积率',
  `house_pooled_rate` varchar(20) NOT NULL DEFAULT '' COMMENT '公摊率',
  `house_greening_rate` varchar(20) NOT NULL DEFAULT '' COMMENT '绿化率',
  `house_land_nature` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '土地类别 F000000123',
  `house_land_life` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '土地年限 F000000124',
  `house_land_certificate_date` date NOT NULL DEFAULT '0000-00-00' COMMENT '土地证日期',
  `house_permissions` varchar(20) NOT NULL DEFAULT '' COMMENT '权属 F000000122',
  `house_electricity_method` tinyint(1) unsigned NOT NULL COMMENT '供电方式 F000000155',
  `house_water_method` tinyint(1) unsigned NOT NULL COMMENT '供水方式 F000000156',
  `house_gas_method` tinyint(1) unsigned NOT NULL COMMENT '供气方式 F000000157',
  `house_communication` tinyint(1) unsigned NOT NULL COMMENT '通讯配置 F000000158',
  `house_outwall` tinyint(1) unsigned NOT NULL COMMENT '外墙面 F000000154',
  `house_wall_color` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '外墙颜色 F000000150',
  `house_profile_material` tinyint(1) unsigned NOT NULL COMMENT '门窗材料 F000000160',
  `house_park_count` varchar(10) NOT NULL COMMENT '车位数',
  `house_parking_rent` varchar(20) NOT NULL DEFAULT '' COMMENT '车位月租金',
  `house_parking_fee` varchar(20) NOT NULL DEFAULT '' COMMENT '停车费',
  `house_parking_remarks` varchar(200) NOT NULL DEFAULT '' COMMENT '车位信息备注',
  `house_sell_average_price` decimal(6,2) unsigned zerofill NOT NULL DEFAULT '0000.00' COMMENT '出售均价：元/平方米',
  `house_rent_average_price` decimal(6,2) unsigned zerofill NOT NULL DEFAULT '0000.00' COMMENT '出租均价：元/平方米',
  `house_developer` varchar(30) NOT NULL DEFAULT '' COMMENT '开发商',
  `house_developer_address` varchar(30) NOT NULL DEFAULT '' COMMENT '开发商公司地址',
  `house_developer_contact_name` varchar(10) NOT NULL DEFAULT '' COMMENT '开发商联系人',
  `house_developer_contact_phone` varchar(20) NOT NULL DEFAULT '' COMMENT '开发商联系电话',
  `house_developer_remarks` varchar(200) NOT NULL DEFAULT '' COMMENT '开发商信息备注',
  `house_property` varchar(30) NOT NULL DEFAULT '' COMMENT '物业公司',
  `house_property_address` varchar(30) NOT NULL DEFAULT '' COMMENT '物业公司地址',
  `house_property_fee` decimal(6,2) NOT NULL DEFAULT '0.00' COMMENT '物业费 元/㎡',
  `house_property_contact_name` varchar(20) NOT NULL DEFAULT '' COMMENT '物业联系人',
  `house_property_contact_phone` varchar(20) NOT NULL DEFAULT '' COMMENT '物业联系电话',
  `house_property_remarks` varchar(200) NOT NULL DEFAULT '' COMMENT '物业信息备注',
  `house_selling_points` text NOT NULL COMMENT '楼盘卖点',
  `house_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '楼盘类别 F000000129',
  `house_group` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所属店组(fk)',
  `house_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '楼盘状态 =>0新建 1有效 2无效',
  `house_create_by` int(11) unsigned NOT NULL COMMENT '创建人',
  `house_create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `house_last_modify_by` int(11) unsigned NOT NULL COMMENT '修改者',
  `house_last_modify_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '修改时间',
  `house_duty_range` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '责任盘范围(责任盘) 1:责任盘,2:范围盘,3:非范围盘',
  `audit_status` smallint(1) unsigned NOT NULL DEFAULT '0' COMMENT '审核状态 ',
  PRIMARY KEY (`house_id`),
  UNIQUE KEY `house_code_UNIQUE` (`house_code`) USING BTREE,
  KEY `house_business_circle` (`house_business_circle`) USING BTREE,
  KEY `index_part` (`house_part`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='楼盘表';

-- ----------------------------
-- Table structure for fy_dictionary_house_import
-- ----------------------------
DROP TABLE IF EXISTS `fy_dictionary_house_import`;
CREATE TABLE `fy_dictionary_house_import` (
  `import_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '导入历史id',
  `import_file_unique_hash` char(40) NOT NULL COMMENT '全局唯一hash',
  `import_file_name` varchar(50) DEFAULT NULL COMMENT '上传文件名',
  `import_fail` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '有无失败楼盘 0:无,1:有',
  `import_file_url` varchar(100) NOT NULL DEFAULT '' COMMENT '原文件路径',
  `import_file_fail_url` varchar(100) NOT NULL DEFAULT '' COMMENT '失败楼盘文件路径',
  `user_id` int(10) unsigned NOT NULL COMMENT '上传者',
  `import_upload_time` timestamp NULL DEFAULT NULL COMMENT '上传时间',
  PRIMARY KEY (`import_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='批量导入历史表';

-- ----------------------------
-- Table structure for fy_dictionary_house_import_detail
-- ----------------------------
DROP TABLE IF EXISTS `fy_dictionary_house_import_detail`;
CREATE TABLE `fy_dictionary_house_import_detail` (
  `detail_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '历史详情id',
  `import_id` int(11) unsigned NOT NULL COMMENT '导入历史id',
  `detail_row` tinyint(1) unsigned NOT NULL COMMENT '行数',
  `detail_house_name` varchar(30) NOT NULL COMMENT '上传楼盘名称',
  `detail_house_part` varchar(20) NOT NULL COMMENT '楼盘分期',
  `detail_city_area` varchar(45) DEFAULT NULL COMMENT '城区',
  `detail_seat` varchar(45) DEFAULT NULL COMMENT '栋座名',
  `detail_unit` varchar(45) DEFAULT NULL COMMENT '单元',
  `detail_room` varchar(45) DEFAULT NULL COMMENT '房号',
  `detail_result` tinyint(1) unsigned NOT NULL COMMENT '上传结果 0:失败, 1:成功',
  `detail_fail_reson` varchar(40) NOT NULL DEFAULT '' COMMENT '失败原因',
  PRIMARY KEY (`detail_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='批量导入历史详情表';

-- ----------------------------
-- Table structure for fy_dictionary_house_school_relation
-- ----------------------------
DROP TABLE IF EXISTS `fy_dictionary_house_school_relation`;
CREATE TABLE `fy_dictionary_house_school_relation` (
  `dhsr_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '关联id',
  `school_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '学校id',
  `house_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '楼盘id',
  `dhsr_status` tinyint(1) unsigned NOT NULL COMMENT '关联状态 1有效 2无效',
  PRIMARY KEY (`dhsr_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='学校楼盘关联表';

-- ----------------------------
-- Table structure for fy_dictionary_house_support
-- ----------------------------
DROP TABLE IF EXISTS `fy_dictionary_house_support`;
CREATE TABLE `fy_dictionary_house_support` (
  `support_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '配套id',
  `house_id` int(11) unsigned NOT NULL COMMENT '楼盘id',
  `support_type_id` int(11) unsigned NOT NULL COMMENT '配套类型id',
  `support_name` varchar(20) NOT NULL COMMENT '配套名称',
  `support_remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`support_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='楼盘配套设施表';

-- ----------------------------
-- Table structure for fy_dictionary_house_transit_map
-- ----------------------------
DROP TABLE IF EXISTS `fy_dictionary_house_transit_map`;
CREATE TABLE `fy_dictionary_house_transit_map` (
  `house_transit_map_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `house_id` int(11) unsigned NOT NULL COMMENT '楼盘id',
  `transit_line_id` int(11) unsigned NOT NULL COMMENT '公交id',
  `transit_type` tinyint(2) NOT NULL COMMENT '公交类型',
  `transit_line_name` varchar(30) NOT NULL COMMENT '线路名称',
  PRIMARY KEY (`house_transit_map_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='楼盘公交映射表';

-- ----------------------------
-- Table structure for fy_dictionary_picture
-- ----------------------------
DROP TABLE IF EXISTS `fy_dictionary_picture`;
CREATE TABLE `fy_dictionary_picture` (
  `picture_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件id',
  `picture_module` smallint(6) NOT NULL COMMENT '图片所属模块=>100:楼盘字典,200:房源',
  `picture_target_type` smallint(6) DEFAULT NULL COMMENT '对象类型=>101:楼盘,104:房屋,201:房源',
  `picture_target_id` int(11) unsigned NOT NULL COMMENT '对象id',
  `picture_type` smallint(6) NOT NULL COMMENT '图片类型(房源:（201:房屋照片,202:证件图,203:户型图）,)',
  `file_unique_hash` char(40) NOT NULL COMMENT '文件id',
  `file_save_path` varchar(100) NOT NULL COMMENT '文件路径(冗余)',
  `picture_name` varchar(50) NOT NULL DEFAULT '' COMMENT '图片名称',
  `picture_size` varchar(45) NOT NULL DEFAULT '' COMMENT '图片尺寸',
  `picture_file_type` varchar(45) NOT NULL DEFAULT '' COMMENT '图片文件类型如：（.jpg,.gif,.jpeg）',
  `picture_belong` tinyint(3) NOT NULL COMMENT '图片所属(10:客厅,20:厨房,30:客房,40:厕所,50:阳台,60:杂物间)',
  `picture_tag` smallint(6) NOT NULL COMMENT '标签图片(200:验房)',
  `picture_is_cover` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否是封面(0:不是封面，1：封面)',
  PRIMARY KEY (`picture_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='图片表';

-- ----------------------------
-- Table structure for fy_dictionary_region_operation_config
-- ----------------------------
DROP TABLE IF EXISTS `fy_dictionary_region_operation_config`;
CREATE TABLE `fy_dictionary_region_operation_config` (
  `droc_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '业务区域配置id',
  `droc_name` varchar(20) NOT NULL DEFAULT '' COMMENT '模块名称',
  `droc_alias` varchar(20) NOT NULL DEFAULT '' COMMENT '别名',
  `droc_order` tinyint(1) unsigned NOT NULL COMMENT '顺序',
  PRIMARY KEY (`droc_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='业务区域配置表';

-- ----------------------------
-- Table structure for fy_dictionary_room
-- ----------------------------
DROP TABLE IF EXISTS `fy_dictionary_room`;
CREATE TABLE `fy_dictionary_room` (
  `room_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '房屋ID',
  `house_id` int(10) unsigned NOT NULL COMMENT '楼盘id',
  `seat_id` int(10) unsigned NOT NULL COMMENT '栋座id',
  `unit_id` int(10) unsigned NOT NULL COMMENT '单元ID',
  `room_name` varchar(10) NOT NULL DEFAULT '' COMMENT '房屋户号',
  `room_alias` varchar(20) NOT NULL DEFAULT '' COMMENT '房屋别名',
  `room_floor_number` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所处楼层（在第几楼）',
  `room_use_area` varchar(20) NOT NULL DEFAULT '' COMMENT '套内面积',
  `room_build_area` varchar(20) NOT NULL DEFAULT '' COMMENT '产权面积（建筑面积）',
  `room_useful_area` varchar(20) DEFAULT NULL COMMENT '实用面积',
  `room_orientation` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '朝向{1:东,2:南,3:西,4:北}',
  `type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '户型ID',
  `room_address` varchar(200) NOT NULL COMMENT '房屋地址',
  `room_build_year` year(4) DEFAULT NULL COMMENT '建成年代',
  `room_style` tinyint(4) DEFAULT NULL COMMENT '房屋样式=>1:复式,2:跃层,3:错层',
  `room_basic_decoration` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '装修类型{1:精装,2:简装,3:毛坯,4:清水:,5:豪装,6:统装}',
  `room_basic_elevator` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有电梯{1:有,0:无}',
  `room_basic_affiliate_facility` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附属设施{1:花园,2:露台,3:地下室,4:阁楼}',
  `room_basic_purpose` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '房屋用途{1:住宅-公寓,2:住宅-普通住宅,3:住宅-别墅,4:非住宅-商铺,5:非住宅-公建,6:非住宅-写字间,7:非住宅-车库,8:工用-仓库,9:工用-厂房}',
  `room_basic_actuality` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '房屋现状{1:自住,2:闲置,3:出售,4:出租}',
  `room_owner_name` varchar(20) NOT NULL DEFAULT '' COMMENT '产权人姓名',
  `room_owner_contact` varchar(200) NOT NULL DEFAULT '' COMMENT '产权人联系方式',
  `room_owner_papers_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '产权证类型',
  `room_owner_papers_number` varchar(30) NOT NULL DEFAULT '' COMMENT '证件号码',
  `room_owner_paper_date` date DEFAULT NULL COMMENT '证件日期',
  `room_owner_common` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否共有{1:共有,0:不共有}',
  `room_owner_coowner` varchar(20) NOT NULL DEFAULT '' COMMENT '共有人姓名',
  `room_last_follow_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后一次精耕时间',
  `room_last_follow_by` int(10) unsigned NOT NULL DEFAULT '0',
  `room_create_by` int(10) unsigned NOT NULL COMMENT '添加人id',
  `room_create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `room_last_modify_by` int(10) unsigned NOT NULL COMMENT '修改人id',
  `room_last_modify_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后一次修改时间',
  `audit_status` smallint(1) unsigned NOT NULL DEFAULT '0' COMMENT '审核状态',
  `room_owner_remark` varchar(255) DEFAULT NULL COMMENT '产权人备注',
  PRIMARY KEY (`room_id`),
  KEY `house_id` (`house_id`) USING BTREE,
  KEY `index_seat_id` (`seat_id`) USING BTREE,
  KEY `index_unit_id` (`unit_id`) USING BTREE,
  KEY `index_time` (`room_last_modify_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='楼盘字典房屋表';

-- ----------------------------
-- Table structure for fy_dictionary_room_type
-- ----------------------------
DROP TABLE IF EXISTS `fy_dictionary_room_type`;
CREATE TABLE `fy_dictionary_room_type` (
  `type_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '户型id',
  `type_name` varchar(20) NOT NULL DEFAULT '' COMMENT '户型名称',
  `type_room` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '室',
  `type_hall` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '厅',
  `type_kitchen` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '厨',
  `type_bathroom` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '卫',
  `type_balcony` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '阳',
  PRIMARY KEY (`type_id`),
  KEY `index_search` (`type_room`,`type_hall`,`type_kitchen`,`type_bathroom`,`type_balcony`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='户型表';

-- ----------------------------
-- Table structure for fy_dictionary_school
-- ----------------------------
DROP TABLE IF EXISTS `fy_dictionary_school`;
CREATE TABLE `fy_dictionary_school` (
  `school_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '学校id',
  `school_associate` int(10) unsigned DEFAULT NULL COMMENT '关联学校id',
  `school_code` char(10) NOT NULL DEFAULT '' COMMENT '学校代码 10位 X000000001',
  `school_name` varchar(20) NOT NULL DEFAULT '' COMMENT '学校名称',
  `school_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '学校类型 F000000324',
  `school_address` varchar(100) NOT NULL DEFAULT ' ' COMMENT '学校地址',
  `school_level` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '学校等级 F000000325',
  `ro_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '末级业务区域id',
  `school_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 100新建 200有效（110，120...）',
  `school_create_by` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建人',
  `school_create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `school_modify_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '修改时间',
  `school_modify_by` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '修改人',
  `school_if_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 (0:未删1:删除)',
  `school_city` int(11) DEFAULT '0' COMMENT '学校所属城市',
  PRIMARY KEY (`school_id`),
  KEY `index_assoc` (`school_associate`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='学校信息表';

-- ----------------------------
-- Table structure for fy_dictionary_seat
-- ----------------------------
DROP TABLE IF EXISTS `fy_dictionary_seat`;
CREATE TABLE `fy_dictionary_seat` (
  `seat_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '栋座id',
  `house_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属楼盘id',
  `seat_name` varchar(30) NOT NULL DEFAULT '' COMMENT '栋座名称',
  `seat_number` varchar(20) NOT NULL DEFAULT '0' COMMENT '栋座号',
  `seat_buliding_number` varchar(20) NOT NULL DEFAULT '0' COMMENT '建筑号',
  `seat_buliding_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '建筑类型{1=>多层；2=>小高层；3=>高层;4=>联排;5=>叠拼;6=>独栋}',
  `seat_unit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单元数',
  `seat_households` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '总户数',
  `seat_selling` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '在售数（从房源冗余）',
  `seat_renting` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '在租数（从房源冗余）',
  `seat_property_fee` float(10,2) unsigned NOT NULL COMMENT '物业费',
  `seat_tax` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '计税评估价',
  `seat_loan` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '贷款评估价',
  `seat_obstacle_course` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '障碍通道{0=>无;1=>有}',
  `seat_complete_year` year(4) NOT NULL COMMENT '建成年代',
  `seat_region_num` varchar(50) NOT NULL COMMENT '栋座行政号',
  `seat_create_by` int(10) unsigned NOT NULL COMMENT '创建人id',
  `seat_create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `seat_last_modify_by` int(10) unsigned NOT NULL COMMENT '修改人',
  `seat_last_modify_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后一次修改时间',
  `audit_status` smallint(1) unsigned NOT NULL DEFAULT '0' COMMENT '审核状态',
  PRIMARY KEY (`seat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='栋座';

-- ----------------------------
-- Table structure for fy_dictionary_unit
-- ----------------------------
DROP TABLE IF EXISTS `fy_dictionary_unit`;
CREATE TABLE `fy_dictionary_unit` (
  `unit_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '单元id',
  `house_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属楼盘id',
  `seat_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属栋座id',
  `unit_name` varchar(30) NOT NULL DEFAULT '' COMMENT '单元名称',
  `unit_alias` varchar(30) DEFAULT NULL COMMENT '单元别名',
  `unit_floor_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '楼层数',
  `unit_households` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '总户数',
  `unit_create_by` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建者id',
  `unit_create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `unit_last_modify_by` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '修改人id',
  `unit_last_modify_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后一次修改时间',
  `audit_status` smallint(1) unsigned NOT NULL DEFAULT '0' COMMENT '审核状态',
  PRIMARY KEY (`unit_id`),
  KEY `index_time` (`unit_last_modify_time`),
  KEY `index_house` (`house_id`),
  KEY `index_seat` (`seat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='单元表';

-- ----------------------------
-- Table structure for fy_dictionary_unit_room_type_relation
-- ----------------------------
DROP TABLE IF EXISTS `fy_dictionary_unit_room_type_relation`;
CREATE TABLE `fy_dictionary_unit_room_type_relation` (
  `relation_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '关系id',
  `unit_id` int(10) unsigned NOT NULL COMMENT '单元id',
  `type_id` int(10) unsigned NOT NULL COMMENT '户型id',
  PRIMARY KEY (`relation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='单元户型关系表';

-- ----------------------------
-- Table structure for fy_dictionary_view_times
-- ----------------------------
DROP TABLE IF EXISTS `fy_dictionary_view_times`;
CREATE TABLE `fy_dictionary_view_times` (
  `times_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '查看id',
  `room_id` int(10) unsigned DEFAULT NULL COMMENT '房屋id',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT '查看人id',
  `times_count` int(10) unsigned DEFAULT '0',
  `times_last_update_time` timestamp NULL DEFAULT NULL COMMENT '查看时间',
  PRIMARY KEY (`times_id`),
  KEY `index_room_id` (`room_id`) USING BTREE,
  KEY `index_user_id` (`user_id`) USING BTREE,
  KEY `index_user_room` (`user_id`,`room_id`) USING BTREE,
  KEY `index_time` (`times_last_update_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='业主电话查看记录表';

-- ----------------------------
-- Table structure for fy_journal
-- ----------------------------
DROP TABLE IF EXISTS `fy_journal`;
CREATE TABLE `fy_journal` (
  `j_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `j_create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '日志创建时间',
  `j_type` char(6) NOT NULL DEFAULT '10' COMMENT '日志类型 10:账号前缀+01:类型  1001表示登录成功',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '创建用户ID',
  `department_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属部门ID（冗余）',
  `company_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属公司ID（冗余）',
  `staff_name` varchar(20) NOT NULL COMMENT '职员姓名',
  `j_target_id` int(11) NOT NULL DEFAULT '0' COMMENT '日志对象ID',
  `j_parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '目标对象关联对象',
  `appkey` varchar(40) NOT NULL COMMENT '日志秘钥',
  `j_path` char(6) NOT NULL DEFAULT '000000' COMMENT '数据节点',
  `j_type_f` char(2) NOT NULL DEFAULT '00' COMMENT '数据模型',
  `j_type_s` char(4) NOT NULL DEFAULT '0000' COMMENT '模块',
  `j_parent_type` char(4) NOT NULL COMMENT '关联对象类型',
  PRIMARY KEY (`j_id`),
  KEY `app-user-type` (`appkey`,`user_id`,`j_type`) USING BTREE,
  KEY `typy-target_id` (`j_type`,`j_target_id`),
  KEY `type-f-user` (`j_type_f`,`user_id`),
  KEY `type-s-user` (`j_type_s`,`user_id`),
  KEY `type-parent` (`j_parent_id`,`j_parent_type`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COMMENT='系统日志表';

-- ----------------------------
-- Table structure for fy_journal_detail
-- ----------------------------
DROP TABLE IF EXISTS `fy_journal_detail`;
CREATE TABLE `fy_journal_detail` (
  `j_detail` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志明细ID',
  `j_id` int(11) NOT NULL DEFAULT '0' COMMENT '日志ID',
  `appkey` varchar(40) NOT NULL COMMENT '日志秘钥',
  `j_before_value` text COMMENT '记录变更前数据',
  `j_after_value` text COMMENT '记录变更后数据',
  `j_path` char(10) NOT NULL DEFAULT '000000' COMMENT '数据节点',
  PRIMARY KEY (`j_detail`),
  KEY `app` (`appkey`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='系统日志快照表';

-- ----------------------------
-- Table structure for fy_journal_field
-- ----------------------------
DROP TABLE IF EXISTS `fy_journal_field`;
CREATE TABLE `fy_journal_field` (
  `j_filed_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `j_id` int(11) NOT NULL COMMENT '日志ID',
  `appkey` varchar(40) NOT NULL COMMENT '日志秘钥',
  `j_change_field` varchar(50) NOT NULL COMMENT '变更字段',
  `j_field_before_value` varchar(1000) NOT NULL COMMENT '变更前的值',
  `j_field_after_value` varchar(1000) NOT NULL COMMENT '变更后的值',
  `j_path` char(6) NOT NULL DEFAULT '000000' COMMENT '数据节点',
  PRIMARY KEY (`j_filed_id`),
  KEY `app-j` (`appkey`,`j_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='系统日志字段修改明细表';

-- ----------------------------
-- Table structure for fy_journal_map
-- ----------------------------
DROP TABLE IF EXISTS `fy_journal_map`;
CREATE TABLE `fy_journal_map` (
  `m_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '组织关系图ID',
  `appkey` char(40) DEFAULT NULL COMMENT '日志秘钥',
  `m_name` varchar(100) DEFAULT NULL COMMENT '类型名称',
  `m_nood_id` char(6) DEFAULT NULL COMMENT '类型ID',
  `m_parent_id` char(4) DEFAULT NULL COMMENT '关联ID',
  PRIMARY KEY (`m_id`),
  UNIQUE KEY `m_nood_id` (`m_nood_id`)
) ENGINE=MyISAM AUTO_INCREMENT=125 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for fy_journal_path
-- ----------------------------
DROP TABLE IF EXISTS `fy_journal_path`;
CREATE TABLE `fy_journal_path` (
  `j_path_id` int(11) NOT NULL AUTO_INCREMENT,
  `j_path` char(6) NOT NULL DEFAULT '000000' COMMENT '数据节点',
  `j_hash` char(40) NOT NULL COMMENT '映射hash，与外部数据交互的枢纽(type+''/''+target_id)',
  PRIMARY KEY (`j_path_id`),
  UNIQUE KEY `path-hash` (`j_path`,`j_hash`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='日志数据节点表';

-- ----------------------------
-- Table structure for fy_properties_complement
-- ----------------------------
DROP TABLE IF EXISTS `fy_properties_complement`;
CREATE TABLE `fy_properties_complement` (
  `c_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `p_id` int(11) NOT NULL COMMENT '关联property表的property_id',
  `c_name` tinyint(4) NOT NULL DEFAULT '0' COMMENT '房源配套名称',
  `c_number` tinyint(4) NOT NULL DEFAULT '0' COMMENT '配套数量',
  `c_remark` varchar(300) NOT NULL DEFAULT '' COMMENT '房源配套备注',
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='房源配套信息关联表';

-- ----------------------------
-- Table structure for fy_properties_follow
-- ----------------------------
DROP TABLE IF EXISTS `fy_properties_follow`;
CREATE TABLE `fy_properties_follow` (
  `follow_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '跟进编号',
  `property_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '房源编号',
  `follow_way` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '跟进方式=>1：来电，2：去电，3：来访，4：拜访，5：派单，6：短信，7：邮件',
  `follow_opt_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '跟进操作类型=>101:情感联系，102:验房，103：议价，104：限时，105：委托，106：钥匙',
  `follow_opt_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '跟进操作id，对应到具体操作的主键值',
  `follow_content` char(50) NOT NULL DEFAULT '' COMMENT '跟进内容',
  `follow_is_valid` tinyint(1) NOT NULL DEFAULT '0' COMMENT '跟进状态=>0：新建，1：有效，2：无效',
  `follow_create_by` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '跟进创建人',
  `follow_create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '跟进创建时间',
  PRIMARY KEY (`follow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='房源跟进表';

-- ----------------------------
-- Table structure for fy_properties_follow_conf
-- ----------------------------
DROP TABLE IF EXISTS `fy_properties_follow_conf`;
CREATE TABLE `fy_properties_follow_conf` (
  `follow_conf_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '跟进配置id',
  `follow_opt_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '跟进操作类型=>101:情感联系，102:验房，103：议价，104：限时，105：委托，106：钥匙（冗余自跟进表）',
  `follow_conf_is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示=>1：显示，2：不显示',
  `follow_conf_create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `follow_conf_create_by` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建人',
  `follow_conf_last_modify_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后次修改时间',
  `follow_conf_last_modify_by` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后次修改人',
  PRIMARY KEY (`follow_conf_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='房源跟进配置表';

-- ----------------------------
-- Table structure for fy_properties_level_conf
-- ----------------------------
DROP TABLE IF EXISTS `fy_properties_level_conf`;
CREATE TABLE `fy_properties_level_conf` (
  `lc_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '房源等级id',
  `lc_property_level` char(1) NOT NULL DEFAULT '' COMMENT '房源等级 ABC',
  `lc_property_level_desc` varchar(100) NOT NULL DEFAULT '' COMMENT '房源等级描述',
  `lc_company_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '公司id',
  `lc_property_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '房源类型（0：买卖 1：租赁）',
  PRIMARY KEY (`lc_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='房源等级表';

-- ----------------------------
-- Table structure for fy_properties_num_limit_conf
-- ----------------------------
DROP TABLE IF EXISTS `fy_properties_num_limit_conf`;
CREATE TABLE `fy_properties_num_limit_conf` (
  `nlc_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nlc_num_limit` smallint(4) unsigned NOT NULL DEFAULT '0' COMMENT '总房源数量限制在多少内',
  `nlc_a_num_limit` smallint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'A级房源数量限制在多少内',
  `nlc_b_num_limit` smallint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'B级房源数量限制在多少内',
  `nlc_c_num_limit` smallint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'C级房源数量限制在多少内',
  `nlc_user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `nlc_post_id` int(10) NOT NULL DEFAULT '0' COMMENT '职务id',
  `nlc_post_level_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '职级编号，为0时表示全局',
  `nlc_company_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '公司编号',
  `nlc_modify_by` int(10) NOT NULL DEFAULT '0',
  `nlc_modify_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `nlc_create_by` int(10) NOT NULL DEFAULT '0',
  `nlc_create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `nlc_type` tinyint(1) DEFAULT '0' COMMENT '配置类型： 0：房源买卖配置；1：房源租赁配置',
  PRIMARY KEY (`nlc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='持有房源数量限制配置表';

-- ----------------------------
-- Table structure for fy_properties_property
-- ----------------------------
DROP TABLE IF EXISTS `fy_properties_property`;
CREATE TABLE `fy_properties_property` (
  `property_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '房源表主键id',
  `room_id` int(11) NOT NULL DEFAULT '0' COMMENT '房屋id',
  `property_numbers` char(20) NOT NULL DEFAULT '''''' COMMENT '房源编号',
  `property_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '房源类型 0买卖 1租赁',
  `property_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '房源状态（1 新建，2 有效）',
  `property_quoted_price` decimal(12,5) NOT NULL DEFAULT '0.00000' COMMENT '报价',
  `property_reserve_price` decimal(12,5) NOT NULL DEFAULT '0.00000' COMMENT '底价',
  `property_source` tinyint(2) NOT NULL DEFAULT '0' COMMENT '''房源来源 1.安居客 2.搜房 3.58同城 4.百姓网 5.易居中国 6.公司网站 7.上门 8.社区精耕 9.老客户转介 10.洗盘 11.准客户转介 12.租转售 13.房交会 14.其他''',
  `property_owner_name` varchar(20) NOT NULL DEFAULT '''''' COMMENT '业主姓名',
  `property_owner_phone` varchar(200) NOT NULL DEFAULT '''''' COMMENT '业主电话',
  `property_remark` varchar(300) NOT NULL DEFAULT '''''' COMMENT '备注',
  `property_open_user_id` int(10) NOT NULL DEFAULT '0' COMMENT '开盘人',
  `property_open_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '开盘时间',
  `property_property_level` char(2) NOT NULL DEFAULT '''''' COMMENT '房源等级 A B C',
  `property_basic_actuality` tinyint(1) NOT NULL DEFAULT '0' COMMENT '房源现状：1有效，2预定，3暂缓，4托管，5无效，6未知，7他租，8我租',
  `property_attribute` tinyint(1) NOT NULL DEFAULT '0' COMMENT '产权性质 (1:商品房2:房改房3:拆迁安置房4:安居房5:公房6:经济适用房7:私房)',
  `property_housing_reason` tinyint(1) NOT NULL DEFAULT '0' COMMENT '租售房原因 1.换房 2.女儿上学 3.女儿结婚',
  `property_is_degreed` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否有学位，1有，2没有',
  `property_is_settled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否可落户',
  `property_complement_id` int(10) NOT NULL DEFAULT '0' COMMENT '配套设施id',
  `property_is_common_propertyed` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否共有产权 1 共有，2 不共有',
  `property_is_uniqued` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否唯一住房 1 是 2 不是',
  `property_is_five_yeared` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否过5年 1:是 2：不是',
  `property_proxy_name` varchar(20) NOT NULL DEFAULT '''''' COMMENT '代理人姓名',
  `property_proxy_phone` varchar(200) NOT NULL DEFAULT '''''' COMMENT '代理人电话',
  `property_special_point` varchar(300) NOT NULL DEFAULT '''''' COMMENT '特殊卖点',
  `type_id` int(10) NOT NULL DEFAULT '0' COMMENT '户型id',
  `property_view_count` smallint(5) NOT NULL DEFAULT '0' COMMENT '房源被带看量',
  `property_is_focus` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否聚焦设定( 1:是 2:否)',
  `property_is_key` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否钥匙签订(1:是 2：否)',
  `property_is_entrust` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否委托房 1：是 2：不是',
  `property_is_have_picture` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否有图片 1：是 2：否',
  `property_is_check` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否验房 1：是 2：不是',
  `property_is_limit_time` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否限时房 1：是 2：不是',
  `property_first_belong` int(10) NOT NULL DEFAULT '0' COMMENT '房源最初所属人',
  `property_current_belong` int(10) NOT NULL DEFAULT '0' COMMENT '房源当前所属人（最终所属人）',
  `property_is_contracted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已经签约 1：是 2：否',
  `property_create_user_id` int(10) NOT NULL DEFAULT '0' COMMENT '房源添加人id',
  `property_create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '房源添加时间',
  `property_modify_user_id` int(10) NOT NULL DEFAULT '0' COMMENT '修改房源人id',
  `property_modify_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '修改房源时间',
  `property_audit_user_id` int(10) NOT NULL DEFAULT '0' COMMENT '审核人id',
  `property_audit_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '审核时间',
  `property_audit_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '审核状态 1：通过 2：审核中 3：已通过 4：已驳回 5：已撤销',
  `property_audit_remark` varchar(200) NOT NULL DEFAULT '''''' COMMENT '审核备注',
  `property_work_type` smallint(5) NOT NULL DEFAULT '0' COMMENT '房源工作类型',
  PRIMARY KEY (`property_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for fy_properties_property_room
-- ----------------------------
DROP TABLE IF EXISTS `fy_properties_property_room`;
CREATE TABLE `fy_properties_property_room` (
  `pr_id` int(10) NOT NULL COMMENT '房源系统房屋冗余表id',
  `p_id` int(11) NOT NULL DEFAULT '0' COMMENT '房源表id',
  `room_use_area` varchar(20) NOT NULL DEFAULT '' COMMENT '套内面积',
  `room_build_area` varchar(20) NOT NULL DEFAULT '' COMMENT '产权面积（建筑面积）',
  `room_useful_area` varchar(20) NOT NULL COMMENT '实用面积',
  `room_orientation` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '朝向{1:东,2:南,3:西,4:北}',
  `type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '户型ID',
  `room_basic_decoration` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '装修类型{1:精装,2:简装,3:毛坯,4:清水:,5:豪装,6:统装}',
  `room_basic_purpose` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '房屋用途{1:住宅-公寓,2:住宅-普通住宅,3:住宅-别墅,4:非住宅-商铺,5:非住宅-公建,6:非住宅-写字间,7:非住宅-车库,8:工用-仓库,9:工用-厂房}',
  `room_style` tinyint(4) NOT NULL COMMENT '房屋样式=>1:复式,2:跃层,3:错层',
  `room_basic_affiliate_facility` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附属设施{1:花园,2:露台,3:地下室,4:阁楼}',
  `room_basic_elevator` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有电梯{1:有,0:无}',
  `room_owner_papers_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '产权证类型',
  `room_owner_papers_number` varchar(30) NOT NULL DEFAULT '' COMMENT '证件号码',
  `room_owner_paper_date` date DEFAULT NULL COMMENT '证件日期',
  `room_owner_marital` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '婚姻状况{1:已婚0:未婚  已婚  未婚   离异   丧偶  其他}',
  `room_owner_sex` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '性别{1:男,2:女}',
  `room_owner_country` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '国籍',
  PRIMARY KEY (`pr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='房源系统房屋冗余表';

-- ----------------------------
-- Table structure for fy_properties_star_conf
-- ----------------------------
DROP TABLE IF EXISTS `fy_properties_star_conf`;
CREATE TABLE `fy_properties_star_conf` (
  `sc_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置id',
  `sc_star_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '星级类型 1房源图片 2关联钥匙 3签订独家 4签订限时',
  `sc_star_level` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '星级等级',
  `sc_company_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '公司id',
  `sc_property_type` tinyint(2) DEFAULT '0' COMMENT '房源类型（0：买卖 1：租赁）',
  PRIMARY KEY (`sc_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='房源星级配置表';

-- ----------------------------
-- Table structure for fy_properties_transfer
-- ----------------------------
DROP TABLE IF EXISTS `fy_properties_transfer`;
CREATE TABLE `fy_properties_transfer` (
  `transfer_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '转移记录编号',
  `property_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '房源编号',
  `transfer_target_department` int(10) NOT NULL DEFAULT '0' COMMENT '转移目标部门',
  `transfer_target_user` int(10) NOT NULL DEFAULT '0' COMMENT '转移目标职员',
  `transfer_reason` tinyint(1) NOT NULL DEFAULT '0' COMMENT '转移原因',
  `transfer_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '转移类型(1:完全转介)',
  `transfer_remark` varchar(300) NOT NULL DEFAULT '' COMMENT '备注',
  `transfer_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '转移状态(0:无操作1:接收2:拒绝)',
  `transfer_modify_by` int(10) NOT NULL DEFAULT '0' COMMENT '修改用户编号',
  `transfer_last_modify_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后修改时间',
  `transfer_create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '转移记录添加时间',
  `transfer_create_by` int(10) NOT NULL DEFAULT '0' COMMENT '转移记录添加人',
  PRIMARY KEY (`transfer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='房源转移表';

-- ----------------------------
-- Table structure for fy_properties_view_record
-- ----------------------------
DROP TABLE IF EXISTS `fy_properties_view_record`;
CREATE TABLE `fy_properties_view_record` (
  `view_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '表主键',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `company_id` int(10) NOT NULL DEFAULT '0' COMMENT '公司id',
  `view_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '用户最后一次查看的时间',
  `view_num` int(10) NOT NULL DEFAULT '0' COMMENT '当前用户已经查看的次数',
  `view_property_record` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '房源浏览记录json',
  `property_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '房源类型',
  PRIMARY KEY (`view_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户查看房源的详情中重要信息的记录表。';

-- ----------------------------
-- Table structure for fy_properties_views_conf
-- ----------------------------
DROP TABLE IF EXISTS `fy_properties_views_conf`;
CREATE TABLE `fy_properties_views_conf` (
  `views_conf_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置编号id',
  `views_conf_time_limit_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '时间限制类型（1：周 2：天）',
  `views_conf_counts_limit` smallint(4) unsigned NOT NULL DEFAULT '0' COMMENT '次数限制配置',
  `post_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '职务编号id',
  `rank_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '职级编号id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '职员id',
  `company_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户所在公司id',
  `views_conf_view_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '房源查看配置状态（1：显示 2:隐藏）',
  `property_conf_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '判断是房源租赁的配置还是买卖的配置：0：买卖，1：租赁。默认0.',
  PRIMARY KEY (`views_conf_id`)
) ENGINE=MyISAM AUTO_INCREMENT=77 DEFAULT CHARSET=utf8 COMMENT='房源浏览配置表';

-- ----------------------------
-- Table structure for fy_struct_company
-- ----------------------------
DROP TABLE IF EXISTS `fy_struct_company`;
CREATE TABLE `fy_struct_company` (
  `company_id` int(11) unsigned NOT NULL COMMENT '集团公司',
  `company_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '公司类型=>1:集团,2:公司',
  `city_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '公司所在地',
  `company_tax_reg_code` varchar(40) NOT NULL DEFAULT '' COMMENT '纳税登记号',
  `company_legal_name` varchar(40) NOT NULL DEFAULT '' COMMENT '公司法人名称',
  `company_phone` varchar(20) NOT NULL DEFAULT '' COMMENT '公司电话',
  `company_address` varchar(40) NOT NULL DEFAULT '' COMMENT '公司地址',
  `company_business` varchar(40) NOT NULL DEFAULT '' COMMENT '公司主营业务',
  `company_fax` varchar(20) NOT NULL DEFAULT '' COMMENT '公司传真',
  `company_remark` varchar(40) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='公司表';

-- ----------------------------
-- Table structure for fy_struct_company_ownership
-- ----------------------------
DROP TABLE IF EXISTS `fy_struct_company_ownership`;
CREATE TABLE `fy_struct_company_ownership` (
  `ownership_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '所有权份额',
  `company_id` int(11) unsigned NOT NULL COMMENT '公司',
  `ownership_name` varchar(10) NOT NULL DEFAULT '' COMMENT '姓名',
  `ownership_idcard` varchar(18) NOT NULL DEFAULT '' COMMENT '身份证号码',
  `ownership_contact` varchar(20) NOT NULL DEFAULT '' COMMENT '联系方式',
  `ownership_count` varchar(10) NOT NULL COMMENT '所占份额',
  PRIMARY KEY (`ownership_id`),
  KEY `ownership_company_fk` (`company_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='公司所有份额表';

-- ----------------------------
-- Table structure for fy_struct_department
-- ----------------------------
DROP TABLE IF EXISTS `fy_struct_department`;
CREATE TABLE `fy_struct_department` (
  `department_id` int(11) unsigned NOT NULL COMMENT '部门',
  `type_id` int(11) unsigned NOT NULL COMMENT '部门类型',
  `level_id` int(11) unsigned NOT NULL COMMENT '部门级别',
  `department_worker_count` int(11) unsigned NOT NULL COMMENT '部门职员数',
  `department_duty` varchar(40) NOT NULL DEFAULT '' COMMENT '部门职责',
  `department_slogan` varchar(40) NOT NULL DEFAULT '' COMMENT '部门口号',
  `department_purpose` varchar(40) NOT NULL DEFAULT '' COMMENT '部门宗旨',
  `department_remark` varchar(40) NOT NULL DEFAULT '' COMMENT '部门备注',
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='部门表';

-- ----------------------------
-- Table structure for fy_struct_department_honor
-- ----------------------------
DROP TABLE IF EXISTS `fy_struct_department_honor`;
CREATE TABLE `fy_struct_department_honor` (
  `department_honor_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '部门荣誉',
  `department_id` int(11) unsigned NOT NULL COMMENT '部门',
  `department_honor_content` varchar(255) NOT NULL DEFAULT '' COMMENT '部门荣誉内容',
  PRIMARY KEY (`department_honor_id`),
  KEY `department_id` (`department_id`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='部门荣誉表';

-- ----------------------------
-- Table structure for fy_struct_department_level
-- ----------------------------
DROP TABLE IF EXISTS `fy_struct_department_level`;
CREATE TABLE `fy_struct_department_level` (
  `level_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '部门级别',
  `level_name` varchar(10) NOT NULL COMMENT '部门级别名称',
  `company_id` int(11) unsigned NOT NULL COMMENT '所属公司',
  `level_level` tinyint(2) unsigned NOT NULL COMMENT '部门层级',
  `level_using` tinyint(1) unsigned NOT NULL COMMENT '部门级别状态=>1:启用,2:关闭',
  `level_describe` varchar(40) NOT NULL COMMENT '部门级别说明',
  `level_create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `level_create_by` int(11) unsigned NOT NULL COMMENT '创建人',
  `level_last_modify_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `level_last_modify_by` int(11) unsigned NOT NULL COMMENT '修改人',
  PRIMARY KEY (`level_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for fy_struct_department_type
-- ----------------------------
DROP TABLE IF EXISTS `fy_struct_department_type`;
CREATE TABLE `fy_struct_department_type` (
  `type_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '部门类型',
  `company_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所属公司',
  `type_nature` tinyint(1) unsigned NOT NULL COMMENT '部门性质=>1:职能部门,2:业务部门',
  `type_name` varchar(10) NOT NULL DEFAULT '' COMMENT '部门类型名称',
  `type_describe` varchar(40) NOT NULL DEFAULT '' COMMENT '部门类型说明',
  `type_using` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '部门类型状态=>1:启用,2:关闭',
  `type_create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `type_create_by` int(11) unsigned NOT NULL COMMENT '创建人',
  `type_last_modify_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后修改时间',
  `type_last_modify_by` int(11) unsigned NOT NULL COMMENT '修改人',
  PRIMARY KEY (`type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='部门类型表';

-- ----------------------------
-- Table structure for fy_struct_post
-- ----------------------------
DROP TABLE IF EXISTS `fy_struct_post`;
CREATE TABLE `fy_struct_post` (
  `post_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '职务',
  `company_id` int(10) unsigned NOT NULL COMMENT '所属公司',
  `post_name` varchar(10) NOT NULL COMMENT '职务名称',
  `post_describe` varchar(40) NOT NULL DEFAULT '' COMMENT '职务说明',
  `post_hash` char(40) NOT NULL COMMENT '职务hash值，用于结合职级匹配相应角色及权限',
  `post_using` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '职务状态=>1:启用,2:关闭',
  `post_create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `post_create_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加人id',
  `post_last_modify_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后一次修改时间',
  `post_last_modify_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改人id',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='职务表';

-- ----------------------------
-- Table structure for fy_struct_post_level
-- ----------------------------
DROP TABLE IF EXISTS `fy_struct_post_level`;
CREATE TABLE `fy_struct_post_level` (
  `level_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '职务级别',
  `post_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '职务',
  `level_name` varchar(20) NOT NULL COMMENT '职务级别名称',
  `level_using` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '职务级别状态=>1:启用,2:关闭',
  `level_create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `level_create_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加人id',
  `level_last_modify_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后一次修改时间',
  `level_last_modify_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改人id',
  PRIMARY KEY (`level_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='职务级别表';

-- ----------------------------
-- Table structure for fy_struct_post_relation
-- ----------------------------
DROP TABLE IF EXISTS `fy_struct_post_relation`;
CREATE TABLE `fy_struct_post_relation` (
  `relation_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '职务关系',
  `user_id` int(11) unsigned NOT NULL COMMENT '用户',
  `post_id` int(11) unsigned NOT NULL COMMENT '职务',
  `level_id` int(11) unsigned NOT NULL COMMENT '职务级别',
  `is_primary` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '是否是主职=>1:是,2:否',
  PRIMARY KEY (`relation_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=240 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='职务关系表';

-- ----------------------------
-- Table structure for fy_struct_staff
-- ----------------------------
DROP TABLE IF EXISTS `fy_struct_staff`;
CREATE TABLE `fy_struct_staff` (
  `user_id` int(11) unsigned NOT NULL COMMENT '用户',
  `staff_name` varchar(20) NOT NULL COMMENT '职员姓名',
  `staff_code` char(10) NOT NULL COMMENT '职员代码',
  `company_id` int(11) unsigned NOT NULL COMMENT '所属公司(冗余)',
  `department_id` int(11) unsigned NOT NULL COMMENT '所属部门(冗余)',
  `post_id` int(11) unsigned NOT NULL COMMENT '主职务(冗余)',
  `staff_entry_time` date NOT NULL COMMENT '入职时间',
  `staff_mobile` varchar(20) NOT NULL COMMENT '移动电话',
  `staff_email` varchar(50) NOT NULL DEFAULT '' COMMENT '电子邮箱',
  `file_unique_hash` char(40) NOT NULL DEFAULT '' COMMENT '文件上传记录id',
  `staff_identity_property` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '身份属性=>1:正式员工,2:试用期员工,3:实习员工',
  `staff_working_state` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '在职状态=>1:在职,2:休假,3:离职',
  `staff_leader_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '负责信息=>1:普通职员,2:部门负责人,3:公司负责人',
  `staff_sex` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '性别=>1:男,2:女,',
  `staff_hometown_province_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '籍贯省份',
  `staff_hometown_city_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '籍贯城市',
  `staff_idcard` varchar(20) NOT NULL DEFAULT '' COMMENT '身份证号',
  `staff_birthday` date NOT NULL COMMENT '出生年月',
  `staff_ethnic` varchar(10) NOT NULL DEFAULT '' COMMENT '民族',
  `staff_marital_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '婚姻状况=>1:已婚,2:未婚',
  `staff_location_province_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '户口所在地省份',
  `staff_location_city_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '户口所在地城市',
  `staff_office_tel` varchar(20) NOT NULL DEFAULT '' COMMENT '办公电话',
  `staff_tel` varchar(20) NOT NULL DEFAULT '' COMMENT '家庭电话',
  `staff_address` varchar(255) NOT NULL DEFAULT '' COMMENT '家庭地址',
  `staff_interest` varchar(255) NOT NULL DEFAULT '' COMMENT '兴趣爱好',
  `staff_remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `staff_create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `staff_create_by` int(11) unsigned NOT NULL COMMENT '添加人id',
  `staff_last_modify_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后一次修改时间',
  `staff_last_modify_by` int(11) unsigned NOT NULL COMMENT '变更人',
  `staff_leave_time` date NOT NULL COMMENT '离职时间',
  `staff_last_transform_time` date NOT NULL COMMENT '上次转岗时间',
  `staff_update_time` date NOT NULL COMMENT '变更时间(重要信息)',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `staff_code` (`staff_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='职员表';

-- ----------------------------
-- Table structure for fy_struct_staff_education
-- ----------------------------
DROP TABLE IF EXISTS `fy_struct_staff_education`;
CREATE TABLE `fy_struct_staff_education` (
  `education_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '教育经历',
  `user_id` int(11) unsigned NOT NULL COMMENT '用户',
  `education_start_time` date NOT NULL COMMENT '开始时间',
  `education_end_time` date NOT NULL COMMENT '结束时间',
  `education_school` varchar(30) NOT NULL COMMENT '就读学校',
  `education_specialty` varchar(30) NOT NULL COMMENT '就读专业',
  `education_system` tinyint(2) NOT NULL DEFAULT '0' COMMENT '学制 1:普通高等院校统招,2:普通高等院校自费,3:自考,4:夜大,5:在读,6:函授,7:统招,8:计划,9:自考,10:留学',
  `education_background` tinyint(2) NOT NULL COMMENT '学历 1:初中,2:高中,3:中技,4:中专,5:大专,6:本科,7:硕士,8:博士',
  `education_if_top` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否最高学历 1:是,0:否',
  `education_certificate_number` varchar(20) NOT NULL DEFAULT '' COMMENT '学位证书编号',
  `education_remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`education_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='职员教育经历表';

-- ----------------------------
-- Table structure for fy_struct_staff_emergency_contact
-- ----------------------------
DROP TABLE IF EXISTS `fy_struct_staff_emergency_contact`;
CREATE TABLE `fy_struct_staff_emergency_contact` (
  `emergency_contact_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '紧急联系人',
  `user_id` int(11) unsigned NOT NULL COMMENT '用户',
  `emergency_contact_name` varchar(10) NOT NULL COMMENT '紧急联系人姓名',
  `emergency_contact_mobile` varchar(20) NOT NULL COMMENT '移动电话',
  `emergency_contact_tel` varchar(20) NOT NULL COMMENT '固定电话',
  `emergency_contact_relation` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '关系；1=>配偶;2=>父母;3=>亲戚;4=>朋友;5=>其他;',
  PRIMARY KEY (`emergency_contact_id`)
) ENGINE=MyISAM AUTO_INCREMENT=222 DEFAULT CHARSET=utf8 COMMENT='紧急联系人表';

-- ----------------------------
-- Table structure for fy_struct_staff_qualification
-- ----------------------------
DROP TABLE IF EXISTS `fy_struct_staff_qualification`;
CREATE TABLE `fy_struct_staff_qualification` (
  `qualification_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '国家职业资格',
  `user_id` int(11) unsigned NOT NULL COMMENT '用户',
  `qualification_name` varchar(20) NOT NULL COMMENT '资格名称',
  `qualification_level` varchar(20) NOT NULL DEFAULT '' COMMENT '资格等级',
  `qualification_certificate_number` varchar(20) NOT NULL,
  `qualification_get_time` date NOT NULL COMMENT '获取时间',
  `qualification_approver` varchar(100) NOT NULL COMMENT '批准单位',
  `qualification_remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`qualification_id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='国家职业资格表';

-- ----------------------------
-- Table structure for fy_struct_staff_title
-- ----------------------------
DROP TABLE IF EXISTS `fy_struct_staff_title`;
CREATE TABLE `fy_struct_staff_title` (
  `title_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '外部职称',
  `user_id` int(11) unsigned NOT NULL COMMENT '用户',
  `title_name` varchar(20) NOT NULL COMMENT '职称名称',
  `title_level` varchar(20) NOT NULL DEFAULT '' COMMENT '职称等级',
  `title_certificate_number` varchar(20) NOT NULL COMMENT '证件号',
  `title_assess_time` date NOT NULL COMMENT '评定日期',
  `title_assess_body` varchar(30) NOT NULL COMMENT '评定机构',
  `title_remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`title_id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='职员外部职称表';

-- ----------------------------
-- Table structure for fy_struct_staff_work
-- ----------------------------
DROP TABLE IF EXISTS `fy_struct_staff_work`;
CREATE TABLE `fy_struct_staff_work` (
  `work_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '工作经历',
  `user_id` int(11) unsigned NOT NULL COMMENT '用户',
  `work_start_time` date NOT NULL COMMENT '开始时间',
  `work_end_time` date NOT NULL COMMENT '结束时间',
  `work_unit` varchar(30) NOT NULL COMMENT '工作单位',
  `work_department` varchar(20) NOT NULL COMMENT '所属部门',
  `work_post` varchar(20) NOT NULL COMMENT '担任职务',
  `work_witnesses` varchar(20) NOT NULL COMMENT '证明人',
  `work_witnesses_content` varchar(20) NOT NULL COMMENT '证明人联系方式',
  `work_leave_reson` varchar(30) NOT NULL DEFAULT '' COMMENT '离职原因',
  `work_statement` varchar(255) NOT NULL DEFAULT '' COMMENT '工作职责',
  `work_check` varchar(255) NOT NULL DEFAULT '' COMMENT '背景调查',
  `work_remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`work_id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='职员工作经历';

-- ----------------------------
-- Table structure for fy_struct_title
-- ----------------------------
DROP TABLE IF EXISTS `fy_struct_title`;
CREATE TABLE `fy_struct_title` (
  `title_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '职称',
  `company_id` int(11) unsigned NOT NULL COMMENT '所属公司',
  `title_name` varchar(20) NOT NULL COMMENT '职称名称',
  `title_describe` varchar(255) NOT NULL DEFAULT '' COMMENT '职称描述',
  `title_using` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '职称状态=>1:启用,2:关闭',
  `title_create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `title_create_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加人',
  `title_last_modify_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后一次修改时间',
  `title_last_modify_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改人',
  PRIMARY KEY (`title_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='职称表';

-- ----------------------------
-- Table structure for fy_struct_title_level
-- ----------------------------
DROP TABLE IF EXISTS `fy_struct_title_level`;
CREATE TABLE `fy_struct_title_level` (
  `level_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '职称级别',
  `title_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '职称',
  `level_name` varchar(20) NOT NULL COMMENT '职称级别名称',
  `level_using` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '职称级别状态=>1:启用,2:关闭',
  `level_create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `level_create_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加人',
  `level_last_modify_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后一次修改时间',
  `level_last_modify_by` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改人',
  PRIMARY KEY (`level_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='职称级别表';

-- ----------------------------
-- Table structure for fy_struct_title_relation
-- ----------------------------
DROP TABLE IF EXISTS `fy_struct_title_relation`;
CREATE TABLE `fy_struct_title_relation` (
  `relation_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '职称关系',
  `user_id` int(11) unsigned NOT NULL COMMENT '用户',
  `title_id` int(11) unsigned NOT NULL COMMENT '职称',
  `level_id` int(11) unsigned NOT NULL COMMENT '职称级别',
  PRIMARY KEY (`relation_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for fy_struct_tree
-- ----------------------------
DROP TABLE IF EXISTS `fy_struct_tree`;
CREATE TABLE `fy_struct_tree` (
  `node_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '节点',
  `parent_node_id` int(11) unsigned NOT NULL COMMENT '父节点',
  `node_type` tinyint(1) unsigned NOT NULL COMMENT '节点类型=>1:公司,2:部门',
  `genealogy` varchar(255) NOT NULL DEFAULT '' COMMENT '族谱 如/1/2/3/',
  `node_name` varchar(40) NOT NULL DEFAULT '' COMMENT '节点名称(部门或公司名称 冗余)',
  `company_nick` varchar(20) NOT NULL COMMENT '公司简称(只有节点为公司时有,部门时为其所属公司的简称)',
  `company_id` int(11) unsigned NOT NULL COMMENT '所属公司(只有节点为部门时有,公司时为0)',
  `user_id` int(11) unsigned NOT NULL COMMENT '负责人',
  `node_setup_time` date NOT NULL COMMENT '成立时间',
  `node_check` tinyint(1) unsigned NOT NULL COMMENT '是否启用考核=>1:是,2:否',
  `node_leader_check` tinyint(1) unsigned NOT NULL COMMENT '负责人考核启用=>1:是,2:否',
  `node_update_time` date NOT NULL COMMENT '变更时间（重要信息）',
  `node_using` tinyint(1) unsigned NOT NULL COMMENT '启用状态=>1:启用,2:关闭',
  `node_create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `node_create_by` int(11) unsigned NOT NULL COMMENT '添加人',
  `node_last_modify_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后一次修改时间',
  `node_last_modify_by` int(11) unsigned NOT NULL COMMENT '变更人',
  PRIMARY KEY (`node_id`)
) ENGINE=InnoDB AUTO_INCREMENT=236 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='组织架构结构树表';
