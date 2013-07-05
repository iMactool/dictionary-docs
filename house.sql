CREATE TABLE `fy_dictionary_house` (
  `house_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '楼盘id',
  `house_name` varchar(30) NOT NULL DEFAULT '' COMMENT '楼盘名称',
  `house_part` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '期数 0:不分期,$num:期数',
  `house_code` char(10) NOT NULL DEFAULT '' COMMENT '楼盘代码',
  `house_address_street` varchar(20) NOT NULL DEFAULT '' COMMENT '物业地址街',
  `house_address_num` varchar(20) NOT NULL DEFAULT '' COMMENT '物业地址号',
  `house_city` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所属城市(fk)',
  `house_area` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所属城区(fk)',
  `house_group` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所属店组(fk)',
  `house_business_circle` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所属商圈(fk)',
  `house_developer` varchar(30) NOT NULL DEFAULT '' COMMENT '开发商',
  `house_building_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '楼盘栋数',
  `house_family_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '楼盘户数',
  `house_use` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '楼盘用途 F000000133',
  `house_permissions` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '楼盘权属 F000000122',
  `house_land_nature` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '土地性质 F000000123',
  `house_land_life` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '土地年限 F000000124',
  `house_era` year(4) NOT NULL COMMENT '建成年份',
  `house_project_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '项目类别 F000000126',
  `house_structure` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '建筑结构 F000000127',
  `house_building_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '建筑类型 F000000128',
  `house_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '楼盘类别 F000000129',
  `house_heating_method` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '采暖方式 F000000130',
  `house_parking_rent` varchar(20) NOT NULL DEFAULT '' COMMENT '车位租金',
  `house_fee` varchar(20) NOT NULL DEFAULT '' COMMENT '物业费',
  `house_tax_price` varchar(20) NOT NULL DEFAULT '' COMMENT '计税评估价',
  `house_credit_price` varchar(20) NOT NULL DEFAULT '' COMMENT '贷款评估价',
  `house_parking_total_count` smallint(5) unsigned DEFAULT NULL COMMENT '总停车位',
  `house_parking_fee` varchar(20) NOT NULL DEFAULT '' COMMENT '停车费',
  `house_property_phone` varchar(20) NOT NULL DEFAULT '' COMMENT '物业电话',
  `house_alias` varchar(30) NOT NULL DEFAULT '' COMMENT '楼盘别名',
  `house_property` varchar(30) NOT NULL DEFAULT '' COMMENT '物业公司',
  `house_in_time` date NOT NULL COMMENT '入住日期',
  `house_building_area` varchar(20) NOT NULL DEFAULT '' COMMENT '建筑面积',
  `house_land_level` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '土地级别 F000000142',
  `house_volume_rate` varchar(20) NOT NULL DEFAULT '' COMMENT '容积率',
  `house_cover_area` varchar(20) NOT NULL DEFAULT '' COMMENT '占地面积',
  `house_pooled_rate` varchar(20) NOT NULL DEFAULT '' COMMENT '公摊率',
  `house_obstacle_channel` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '障碍通道 F000000146',
  `house_greening_rate` varchar(20) NOT NULL DEFAULT '' COMMENT '绿化率',
  `house_gateway` varchar(20) NOT NULL DEFAULT '' COMMENT '出入口 ??del',
  `house_floor_spacing` varchar(20) NOT NULL DEFAULT '' COMMENT '楼间距',
  `house_wall_color` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '外墙颜色 F000000150',
  `house_parking` varchar(20) NOT NULL DEFAULT '' COMMENT '车位比',
  `house_park_count` varchar(10) NOT NULL COMMENT '车位数',
  `house_garage_count` varchar(10) NOT NULL COMMENT '车库数量',
  `house_outwall` tinyint(1) unsigned NOT NULL COMMENT '外墙面 F000000154',
  `house_electricity_method` tinyint(1) unsigned NOT NULL COMMENT '供电方式 F000000155',
  `house_water_method` tinyint(1) unsigned NOT NULL COMMENT '供水方式 F000000156',
  `house_gas_method` tinyint(1) unsigned NOT NULL COMMENT '供气方式 F000000157',
  `house_communication` tinyint(1) unsigned NOT NULL COMMENT '通讯配置 F000000158',
  `house_elevator_brand` tinyint(2) NOT NULL COMMENT '电梯品牌 F000000159',
  `house_profile_material` tinyint(1) unsigned NOT NULL COMMENT '门窗材料 F000000160',
  `house_opening_price` varchar(20) NOT NULL DEFAULT '' COMMENT '开盘价格',
  `house_bottom_price` varchar(20) NOT NULL DEFAULT '' COMMENT '底商价格',
  `house_rent_price` varchar(20) NOT NULL DEFAULT '' COMMENT '现租价',
  `house_water_charge` varchar(20) NOT NULL DEFAULT '' COMMENT '水费',
  `house_electricity_charge` varchar(20) NOT NULL DEFAULT '' COMMENT '电费',
  `house_gas_charge` varchar(20) NOT NULL DEFAULT '' COMMENT '气费',
  `house_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '楼盘状态 0新建 1有效',
  `house_using` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否启用 ??del',
  `house_last_using_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后一次启用时间',
  `house_last_modify_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后一次修改时间',
  `house_last_close_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后一次关闭时间',
  `house_create_by` int(11) unsigned NOT NULL COMMENT '创建人',
  `house_create_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `house_modify_by` int(11) unsigned NOT NULL COMMENT '修改者',
  `house_duty_range` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '责任盘范围(责任盘) 1:责任盘,2:范围盘,3:非范围盘',
  `house_top_phone_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'a级电话数(房源)',
  `house_audit_status` smallint(1) unsigned NOT NULL DEFAULT '0' COMMENT '审核状态',
  `house_audit_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '审核时间',
  `house_audit_remark` varchar(500) NOT NULL DEFAULT '' COMMENT '审核备注',
  `work_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '工作类型',
  `house_if_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否已删除，1已删 0未删',
  PRIMARY KEY (`house_id`),
  KEY `house_business_circle` (`house_business_circle`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8 COMMENT='楼盘表'$$