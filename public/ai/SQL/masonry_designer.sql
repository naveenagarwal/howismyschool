/*
SQLyog - Free MySQL GUI v5.15
Host - 5.5.38 : Database - masonry_designer
*********************************************************************
Server version : 5.5.38
*/

SET NAMES utf8;

SET SQL_MODE='';

create database if not exists `masonry_designer`;

USE `masonry_designer`;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';

/*Table structure for table `brick_sizes` */

DROP TABLE IF EXISTS `brick_sizes`;

CREATE TABLE `brick_sizes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `create_date` int(11) NOT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modify_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='This table is used to store brick size details';

/*Data for the table `brick_sizes` */

/*Table structure for table `brick_variant_details` */

DROP TABLE IF EXISTS `brick_variant_details`;

CREATE TABLE `brick_variant_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brick_variant_id` int(11) NOT NULL,
  `leed_distance` varchar(255) DEFAULT NULL,
  `recommended_cleaning` varchar(100) DEFAULT NULL,
  `astm_type` varchar(50) DEFAULT NULL,
  `master_format_2010` varchar(100) DEFAULT NULL,
  `astm_specification` varchar(30) DEFAULT NULL,
  `test_date` date DEFAULT NULL,
  `efflorescence` tinyint(4) NOT NULL DEFAULT '0',
  `percent_void` varchar(10) DEFAULT NULL,
  `min_thickness_of_face_shells` varchar(10) DEFAULT NULL,
  `equivalent_web_thickness` varchar(10) DEFAULT NULL,
  `recycled_content_percent` decimal(10,1) DEFAULT NULL,
  `qty_per_sf` decimal(10,1) DEFAULT NULL,
  `water_absorption_types_id` tinyint(4) DEFAULT NULL,
  `weight_pounds` decimal(10,1) DEFAULT NULL,
  `compressive_strength_psi` varchar(20) DEFAULT NULL,
  `specifications` varchar(255) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `create_date` int(11) NOT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modify_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `brick_variant_id` (`brick_variant_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='This table is used to store product details';

/*Data for the table `brick_variant_details` */

/*Table structure for table `brick_variant_images` */

DROP TABLE IF EXISTS `brick_variant_images`;

CREATE TABLE `brick_variant_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brick_variant_id` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `created_by` int(11) NOT NULL,
  `create_date` int(11) NOT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modify_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `brick_variant_id` (`brick_variant_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Store mapping of alpha images with brick variants';

/*Data for the table `brick_variant_images` */

/*Table structure for table `brick_variants` */

DROP TABLE IF EXISTS `brick_variants`;

CREATE TABLE `brick_variants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `brick_size_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `colors` varchar(30) NOT NULL,
  `catalog` varchar(255) DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `size` varchar(30) NOT NULL,
  `length` int(11) NOT NULL,
  `breadth` int(11) NOT NULL,
  `width` int(11) NOT NULL,
  `dimension_unit` varchar(50) DEFAULT NULL,
  `texture` varchar(20) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `create_date` int(11) NOT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modify_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `brick_size_id` (`brick_size_id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='This table is used to store brick variants details';

/*Data for the table `brick_variants` */

/*Table structure for table `log_history` */

DROP TABLE IF EXISTS `log_history`;

CREATE TABLE `log_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `log_type_id` tinyint(4) NOT NULL COMMENT '1: Export,2:Import,3:Edit,4:Delete...',
  `details` tinytext NOT NULL,
  `created_by` int(11) NOT NULL,
  `create_date` int(11) NOT NULL,
  `IP` varchar(15) NOT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modify_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='This table is used to store log history';

/*Data for the table `log_history` */

/*Table structure for table `log_types` */

DROP TABLE IF EXISTS `log_types`;

CREATE TABLE `log_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `details` varchar(255) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL,
  `created_by` int(11) NOT NULL,
  `create_date` int(11) NOT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modify_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='This table is used to store type of logs being recorded';

/*Data for the table `log_types` */

/*Table structure for table `menus` */

DROP TABLE IF EXISTS `menus`;

CREATE TABLE `menus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_usage` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:Link,2:Button',
  `menu_code` varchar(255) NOT NULL,
  `menu_name` varchar(255) NOT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT '1',
  `parent_menu_id` int(11) NOT NULL DEFAULT '0',
  `menu_type` tinyint(4) NOT NULL COMMENT '1: Top Menu,2: Sub Menu,3: Sub-Sub Menu,4 : Hidden Menus(Ex: Ajax Calls)',
  `menu_url` varchar(255) NOT NULL DEFAULT '#',
  `menu_order` tinyint(4) DEFAULT NULL,
  `menu_description` varchar(255) DEFAULT NULL,
  `menu_image_path` varchar(255) DEFAULT NULL,
  `created_by` int(11) DEFAULT '0',
  `create_date` int(11) DEFAULT '0',
  `modified_by` int(11) DEFAULT '0',
  `modify_date` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `menu_code` (`menu_code`)
) ENGINE=MyISAM AUTO_INCREMENT=96 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='This table is used to store modules used throughout the system';

/*Data for the table `menus` */

insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (1,1,'USER_MGMT','Users',1,7,2,'user-roles/users/user-list',2,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (2,1,'PERMISSION_MGMT','Manage Permission',0,8,4,'user-roles/permission/permission-edit',NULL,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (3,1,'ROLES_MGMT','Roles',1,7,2,'user-roles/roles/role-list',1,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (4,1,'ROLE_ADD','New Role',1,3,4,'user-roles/roles/role-add',NULL,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (5,1,'ROLE_EDIT','Edit Role & Assign Permission',1,3,4,'user-roles/roles/role-edit',NULL,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (6,1,'HOME','Ajax Call',0,8,4,'user-roles/users/image-delete',NULL,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (7,1,'USER_ROLES_MGMT','Roles & Users',1,0,1,'#',5,'This will help you in managing roles,users and user\'s permission','users.png',0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (10,1,'REPORT','Reports',0,0,1,'#',3,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (11,1,'POWER_TOOLS','Configuration Tools',1,0,1,'#',4,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (12,1,'HELP','Help',0,0,1,'help',6,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (13,2,'USER_ADD','New User',1,1,4,'user-roles/users/user-add',NULL,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (14,1,'USER_EDIT','Edit User & Assign Permission',1,1,4,'user-roles/users/user-edit',NULL,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (15,1,'USER_DELETE','Delete User',1,1,4,'user-roles/users/user-delete',NULL,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (16,1,'ROLE_DELETE','Delete Role',1,3,4,'user-roles/roles/role-delete',NULL,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (17,1,'CONFIGURATION','Site Configuration',1,11,2,'configuration/configuration',NULL,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (18,1,'CONFIGURATION','Upload Site Logo',1,11,4,'configuration/upload-image',NULL,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (30,1,'DASHBOARD','Dashboard Widgets',1,0,0,'#',NULL,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (31,1,'DASHBOARD_WIDGET1','Dashboard Widget 1',1,30,2,'DASHBOARD_AB1_GRAPH',NULL,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (32,1,'DASHBOARD_WIDGET2','Dashboard Widget 2',1,30,2,'DASHBOARD_AB2_GRAPH',NULL,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (33,1,'DASHBOARD_LOG_HISTORY','Log History',1,30,2,'DASHBOARD_LOG_HISTORY',NULL,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (34,1,'DASHBOARD_QUICK_LINKS','Quick Links',1,30,2,'DASHBOARD_QUICK_LINKS',NULL,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (37,1,'TRANSLATIONS','Translation',0,11,2,'translation/translation-list',NULL,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (38,1,'TRANSLATIONS_ADD','Add Translation',1,37,4,'translation/translation-add',NULL,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (39,1,'TRANSLATIONS_EDIT','Edit Translation',1,37,4,'translation/translation-edit',NULL,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (40,1,'TRANSLATIONS_UPLOAD','Upload Translation',1,37,4,'translation/translation-upload',NULL,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (54,1,'VIEW_LOGS','View Logs',1,11,2,'view-logs/view-logs',NULL,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (55,1,'VIEW_LOGS_UPLOAD','Upload Log Entries',1,54,4,'view-logs/log-upload',NULL,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (56,1,'VIEW_LOGS_DOWNLOAD','Download Log Entries',1,54,4,'view-logs/log-download',NULL,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (76,1,'HOME','Ajax Call',1,8,4,'common/dynamic-filters',NULL,NULL,NULL,0,0,0,0);
insert into `menus` (`id`,`menu_usage`,`menu_code`,`menu_name`,`is_active`,`parent_menu_id`,`menu_type`,`menu_url`,`menu_order`,`menu_description`,`menu_image_path`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (91,1,'UNLINK_LOGO','Remove Site Logo',1,18,4,'configuration/unlink-logo',NULL,NULL,NULL,1,122121222,0,0);

/*Table structure for table `mortars` */

DROP TABLE IF EXISTS `mortars`;

CREATE TABLE `mortars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brick_size_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `thickness` int(11) DEFAULT NULL COMMENT 'For future use',
  `thickness_unit` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `create_date` int(11) NOT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modify_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `brick_size_id` (`brick_size_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='This table is used to store mortar details';

/*Data for the table `mortars` */

/*Table structure for table `product_manufacturer` */

DROP TABLE IF EXISTS `product_manufacturer`;

CREATE TABLE `product_manufacturer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `company` varchar(100) CHARACTER SET utf8 NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 NOT NULL,
  `address` varchar(255) CHARACTER SET utf8 NOT NULL,
  `contact_number` varchar(15) CHARACTER SET utf8 NOT NULL,
  `email_id` varchar(50) CHARACTER SET utf8 NOT NULL,
  `created_by` int(11) NOT NULL,
  `create_date` int(11) NOT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modify_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `product_manufacturer` */

/*Table structure for table `product_plants` */

DROP TABLE IF EXISTS `product_plants`;

CREATE TABLE `product_plants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `plant_name` varchar(100) CHARACTER SET utf8 NOT NULL,
  `plant_longitude` geometry NOT NULL,
  `plant_latitude` geometry NOT NULL,
  `created_by` int(11) NOT NULL,
  `create_date` int(11) NOT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modify_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `product_plants` */

/*Table structure for table `products` */

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_product_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `number` int(6) NOT NULL,
  `description` tinytext,
  `test_date` date NOT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `create_date` int(11) NOT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modify_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='This table is used to store product details';

/*Data for the table `products` */

/*Table structure for table `role_permissions` */

DROP TABLE IF EXISTS `role_permissions`;

CREATE TABLE `role_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `menu_codes` varchar(255) NOT NULL COMMENT 'Tilde (~) delimited strings',
  `created_by` int(11) NOT NULL,
  `create_date` int(11) NOT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modify_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=211 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='This table is used to store role wise permissions';

/*Data for the table `role_permissions` */

insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (52,36,'POWER_TOOLS~SUPPLIERS~SUPPLIERS_ADD',1,1404112824,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (53,36,'POWER_TOOLS~SUPPLIERS~SUPPLIERS_EDIT',1,1404112824,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (82,41,'PRODUCTS~PRODUCT-AVAILIBILITY_SAVE',1,1404896837,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (83,41,'PRODUCTS~PRODUCT_AVAILIBILIY',1,1404896837,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (84,41,'PRODUCTS~PRODUCT_IMPORT',1,1404896837,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (85,41,'PRODUCTS~EXPORT-TEMPLATE-BUTTON-6',1,1404896837,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (86,41,'PRODUCTS~CHAIN-ID',1,1404896837,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (87,41,'PRODUCTS~PRODUCT_DESCRIPTION',1,1404896837,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (88,41,'PRODUCTS~PRODUCT_DESCRIPTION_SAVE',1,1404896837,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (89,41,'POWER_TOOLS~CONFIGURATION',1,1404896837,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (90,41,'POWER_TOOLS~KEYWORDS~KEYWORDS_MANAGE_VALUES',1,1404896837,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (91,41,'POWER_TOOLS~KEYWORDS~KEYWORDS_DISPLAY_VALUES',1,1404896837,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (94,37,'DASHBOARD~DASHBOARD_LOG_HISTORY',1,1404976830,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (95,37,'POWER_TOOLS~KEYWORDS~KEYWORDS_MANAGE_VALUES',1,1404976830,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (96,37,'POWER_TOOLS~VIEW_LOGS~VIEW_LOGS_DOWNLOAD',1,1404976830,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (97,45,'PRODUCTS~PRODUCT_AVAILIBILIY',1,1404981069,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (98,45,'PRODUCTS~PRODUCT_DESCRIPTION',1,1404981069,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (99,45,'POWER_TOOLS~SUPPLIERS~SUPPLIERS_ADD',1,1404981069,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (100,45,'POWER_TOOLS~SUPPLIERS~SUPPLIERS_EDIT',1,1404981069,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (101,46,'DASHBOARD~DASHBOARD_LOG_HISTORY',1,1405054319,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (102,46,'DASHBOARD~DASHBOARD_QUICK_LINKS',1,1405054319,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (103,46,'PRODUCTS~PRODUCT_AVAILIBILIY',1,1405054319,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (104,46,'PRODUCTS~PRODUCT_DESCRIPTION',1,1405054319,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (105,49,'DASHBOARD~DASHBOARD_AB1_GRAPH',1,1405068572,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (106,49,'DASHBOARD~DASHBOARD_AB2_GRAPH',1,1405068572,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (107,49,'DASHBOARD~DASHBOARD_LOG_HISTORY',1,1405068572,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (108,49,'DASHBOARD~DASHBOARD_QUICK_LINKS',1,1405068572,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (109,49,'PRODUCTS~PRODUCT_AVAILIBILIY',1,1405068572,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (110,49,'PRODUCTS~PRODUCT_DESCRIPTION',1,1405068572,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (111,49,'POWER_TOOLS~SUPPLIERS~SUPPLIERS_ADD',1,1405068572,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (112,49,'POWER_TOOLS~SUPPLIERS~SUPPLIERS_EDIT',1,1405068572,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (113,49,'POWER_TOOLS~SUPPLIERS~SUPPLIERS_DELETE',1,1405068572,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (114,49,'POWER_TOOLS~SUPPLIERS~SUPPLIERS_UPLOAD',1,1405068572,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (115,49,'POWER_TOOLS~KEYWORDS~KEYWORDS_ADD',1,1405068572,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (116,49,'POWER_TOOLS~KEYWORDS~KEYWORDS_EDIT',1,1405068572,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (117,49,'POWER_TOOLS~KEYWORDS~KEYWORDS_DELETE',1,1405068572,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (118,49,'POWER_TOOLS~KEYWORDS~KEYWORDS_MANAGE_VALUES',1,1405068572,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (119,49,'POWER_TOOLS~KEYWORDS~KEYWORDS_DISPLAY_VALUES',1,1405068572,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (120,49,'POWER_TOOLS~BACKUP~BACKUP_DO_BACKUP',1,1405068572,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (121,49,'POWER_TOOLS~BACKUP~BACKUP_DO_PURGE',1,1405068572,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (122,49,'USER_ROLES_MGMT~ROLES_MGMT~ROLE_ADD',1,1405068572,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (123,49,'USER_ROLES_MGMT~ROLES_MGMT~ROLE_EDIT',1,1405068572,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (124,49,'USER_ROLES_MGMT~ROLES_MGMT~ROLE_DELETE',1,1405068572,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (125,49,'USER_ROLES_MGMT~USER_MGMT~USER_ADD',1,1405068572,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (126,49,'USER_ROLES_MGMT~USER_MGMT~USER_EDIT',1,1405068572,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (127,49,'USER_ROLES_MGMT~USER_MGMT~USER_DELETE',1,1405068572,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (149,47,'DASHBOARD~DASHBOARD_AB1_GRAPH',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (150,47,'DASHBOARD~DASHBOARD_AB2_GRAPH',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (151,47,'DASHBOARD~DASHBOARD_LOG_HISTORY',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (152,47,'DASHBOARD~DASHBOARD_QUICK_LINKS',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (153,47,'PRODUCTS~PRODUCT_AVAILIBILIY',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (154,47,'PRODUCTS~PRODUCT_IMPORT',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (155,47,'PRODUCTS~EXPORT-TEMPLATE-BUTTON-6',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (156,47,'PRODUCTS~CHAIN-ID',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (157,47,'PRODUCTS~PRODUCT_DESCRIPTION',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (158,47,'POWER_TOOLS~CONFIGURATION',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (159,47,'POWER_TOOLS~SUPPLIERS~SUPPLIERS_ADD',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (160,47,'POWER_TOOLS~SUPPLIERS~SUPPLIERS_EDIT',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (161,47,'POWER_TOOLS~SUPPLIERS~SUPPLIERS_DELETE',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (162,47,'POWER_TOOLS~SUPPLIERS~SUPPLIERS_UPLOAD',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (163,47,'POWER_TOOLS~KEYWORDS~KEYWORDS_ADD',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (164,47,'POWER_TOOLS~KEYWORDS~KEYWORDS_EDIT',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (165,47,'POWER_TOOLS~KEYWORDS~KEYWORDS_DELETE',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (166,47,'POWER_TOOLS~KEYWORDS~KEYWORDS_MANAGE_VALUES',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (167,47,'POWER_TOOLS~KEYWORDS~KEYWORDS_DISPLAY_VALUES',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (168,47,'POWER_TOOLS~MANAGE_PRODUCT_TYPE~PRODUCT_TYPE_ADD',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (169,47,'POWER_TOOLS~MANAGE_PRODUCT_TYPE~PRODUCT_TYPE_EDIT',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (170,47,'POWER_TOOLS~MANAGE_PRODUCT_TYPE~PRODUCT_TYPE_DELETE',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (171,47,'POWER_TOOLS~EAN_MANAGEMENT~EANS_UPLOAD',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (172,47,'POWER_TOOLS~EAN_MANAGEMENT~EAN_EXPORT',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (173,47,'POWER_TOOLS~EAN_MANAGEMENT~EAN_DELETE',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (174,47,'POWER_TOOLS~PRODUCT_EXPORT_SETTINGS',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (175,47,'POWER_TOOLS~VARIATIONS~VARIATION_ADD',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (176,47,'POWER_TOOLS~VARIATIONS~VARIATION_EDIT',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (177,47,'POWER_TOOLS~VARIATIONS~VARIATION_DELETE',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (178,47,'POWER_TOOLS~VARIATIONS~VARIATION_UPLOAD',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (179,47,'POWER_TOOLS~MANAGE_EXPORT_TEMPLATES~EXPORT_TEMPLATES_ADD',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (180,47,'POWER_TOOLS~MANAGE_EXPORT_TEMPLATES~EXPORT_TEMPLATES_DELETE',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (181,47,'POWER_TOOLS~MANAGE_EXPORT_TEMPLATES~EXPORT_TEMPLATES_EDIT',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (182,47,'POWER_TOOLS~BACKUP~BACKUP_DO_BACKUP',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (183,47,'POWER_TOOLS~BACKUP~BACKUP_DO_PURGE',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (184,47,'USER_ROLES_MGMT~ROLES_MGMT~ROLE_ADD',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (185,47,'USER_ROLES_MGMT~ROLES_MGMT~ROLE_EDIT',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (186,47,'USER_ROLES_MGMT~ROLES_MGMT~ROLE_DELETE',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (187,47,'USER_ROLES_MGMT~USER_MGMT~USER_ADD',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (188,47,'USER_ROLES_MGMT~USER_MGMT~USER_EDIT',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (189,47,'USER_ROLES_MGMT~USER_MGMT~USER_DELETE',1,1405068688,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (190,48,'DASHBOARD~DASHBOARD_AB1_GRAPH',1,1405318095,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (191,48,'DASHBOARD~DASHBOARD_AB2_GRAPH',1,1405318095,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (192,48,'PRODUCTS~PRODUCT_AVAILIBILIY',1,1405318095,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (193,48,'PRODUCTS~PRODUCT_IMPORT',1,1405318095,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (194,48,'PRODUCTS~EXPORT-TEMPLATE-BUTTON-6',1,1405318095,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (195,48,'PRODUCTS~CHAIN-ID',1,1405318095,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (196,48,'PRODUCTS~PRODUCT_DESCRIPTION',1,1405318095,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (197,48,'POWER_TOOLS~SUPPLIERS~SUPPLIERS_ADD',1,1405318095,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (198,48,'POWER_TOOLS~SUPPLIERS~SUPPLIERS_EDIT',1,1405318095,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (199,48,'POWER_TOOLS~SUPPLIERS~SUPPLIERS_DELETE',1,1405318095,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (200,48,'POWER_TOOLS~SUPPLIERS~SUPPLIERS_UPLOAD',1,1405318095,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (201,48,'POWER_TOOLS~KEYWORDS~KEYWORDS_ADD',1,1405318095,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (202,48,'POWER_TOOLS~KEYWORDS~KEYWORDS_EDIT',1,1405318095,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (203,48,'POWER_TOOLS~KEYWORDS~KEYWORDS_DELETE',1,1405318095,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (204,48,'POWER_TOOLS~KEYWORDS~KEYWORDS_MANAGE_VALUES',1,1405318095,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (205,48,'POWER_TOOLS~KEYWORDS~KEYWORDS_DISPLAY_VALUES',1,1405318095,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (206,48,'USER_ROLES_MGMT~USER_MGMT~USER_ADD',1,1405318095,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (207,48,'USER_ROLES_MGMT~USER_MGMT~USER_EDIT',1,1405318095,NULL,NULL);
insert into `role_permissions` (`id`,`role_id`,`menu_codes`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (208,48,'USER_ROLES_MGMT~USER_MGMT~USER_DELETE',1,1405318095,NULL,NULL);

/*Table structure for table `roles` */

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'CakePHP will automatically generate PK for US :)',
  `role_name` varchar(100) NOT NULL,
  `role_code` varchar(50) NOT NULL,
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '1 = deleted, 0 = not deleted',
  `is_active` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1: Active,0 : InActive',
  `created_by` int(11) NOT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `create_date` int(11) NOT NULL,
  `modify_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_code` (`role_code`)
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='This table is used to store role details';

/*Data for the table `roles` */

insert into `roles` (`id`,`role_name`,`role_code`,`is_deleted`,`is_active`,`created_by`,`modified_by`,`create_date`,`modify_date`) values (1,'SuperAdmin','SUPADM',0,1,0,NULL,0,NULL);
insert into `roles` (`id`,`role_name`,`role_code`,`is_deleted`,`is_active`,`created_by`,`modified_by`,`create_date`,`modify_date`) values (52,'End User','ENDUSER',0,1,1,NULL,1406204387,NULL);

/*Table structure for table `site_configurations` */

DROP TABLE IF EXISTS `site_configurations`;

CREATE TABLE `site_configurations` (
  `site_name` varchar(255) NOT NULL,
  `site_email` varchar(100) NOT NULL,
  `site_status` tinyint(4) NOT NULL DEFAULT '1',
  `offline_message` varchar(255) DEFAULT NULL,
  `site_logo_path` varchar(120) NOT NULL,
  `fb_app_id` varchar(50) NOT NULL,
  `fb_app_secret` varchar(75) NOT NULL,
  `fb_return_url` varchar(255) NOT NULL,
  `twitter_api_key` varchar(100) NOT NULL,
  `twitter_api_secret` varchar(100) NOT NULL,
  `twitter_owner` varchar(255) NOT NULL,
  `twitter_owner_id` varchar(50) NOT NULL,
  `created_by` int(11) NOT NULL,
  `create_date` int(11) NOT NULL,
  `modified_by` int(11) NOT NULL,
  `modify_date` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='This table is used to store site wide configuration';

/*Data for the table `site_configurations` */

insert into `site_configurations` (`site_name`,`site_email`,`site_status`,`offline_message`,`site_logo_path`,`fb_app_id`,`fb_app_secret`,`fb_return_url`,`twitter_api_key`,`twitter_api_secret`,`twitter_owner`,`twitter_owner_id`,`created_by`,`create_date`,`modified_by`,`modify_date`) values ('Masonry Designer','dbaveja@q3tech.com',1,NULL,'logo1406871772.png','','','','','','','',0,0,1,1406871772);

/*Table structure for table `site_translation` */

DROP TABLE IF EXISTS `site_translation`;

CREATE TABLE `site_translation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang_code` varchar(2) NOT NULL,
  `source_label` varchar(255) NOT NULL,
  `translated_label` varchar(255) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `create_date` int(11) DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modify_date` int(11) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`,`lang_code`)
) ENGINE=MyISAM AUTO_INCREMENT=569 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='This table is used to store translation entries';

/*Data for the table `site_translation` */

insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (1,'DE','Please enter start date','Bitte Startdatum eingeben',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (2,'DE','Please enter end date','Bitte Enddatum eingeben',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (3,'DE','Please enter valid start date','Bitte ein gültiges Startdatum eingeben',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (4,'DE','Please enter valid end date','Bitte ein gültiges Enddatum eingeben',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (5,'DE','Start date can not be greater than end date','Startdatum darf nicht später als Enddatum liegen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (6,'DE','Start date can not be greater than current date','Startdatum darf nicht früher als heutiges Datum liegen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (7,'DE','End date can not be greater than current date','Enddatum darf nicht früher als heutiges Datum liegen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (8,'DE','Backup process initiated successfully','Die Datensicherung wurde erfolgreich gestartet',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (9,'DE','Start Date','Startdatum',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (10,'DE','End Date','Enddatum',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (11,'DE','Type','Typ',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (12,'DE','Download','Download',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (13,'DE','Backup','Datensicherung',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (14,'DE','Select the new filter to add','Wählen Sie einen neuen Filter',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (15,'DE','Select one filter','Wählen Sie einen Filter',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (16,'DE','Add','Hinzufügen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (17,'DE','Close','Schließen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (18,'DE','Product','Produkt',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (19,'DE','Supplier','Lieferant',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (20,'DE','Age','Alter',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (21,'DE','Gender','Geschlecht',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (22,'DE','Article No.','Artikel Nr.',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (23,'DE','EAN','EAN',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (24,'DE','Variation Id,','Var-Id',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (25,'DE','Brand','Marke',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (26,'DE','No','Nein',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (27,'DE','Yes','Ja',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (28,'DE','In Stock','auf Lager',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (29,'DE','Distribution','Vertrieb',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (30,'DE','Shoe Shape','Schuhform',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (31,'DE','Sizes','Größen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (32,'DE','Size','Größe',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (33,'DE','Category,','Kategorie',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (34,'DE','category','Kategorie',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (35,'DE','Date Input','Datumseingabe',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (36,'DE','Weight','Gewicht',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (37,'DE','Season','Saison',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (38,'DE','FT','FT',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (39,'DE','FD','FD',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (40,'DE','Availibility','Verfügbarkeit',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (41,'DE','Product Type1','Produkt Typ1',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (42,'DE','Product Type2','Produkt Typ2',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (43,'DE','Product Type3','Produkt Typ3',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (44,'DE','Data saved successfully','Daten erfolgreich gesichert',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (45,'DE','Data could not be saved','Daten konnten nicht gesichert werden',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (46,'DE','API Post URL','API Post URL',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (47,'DE','API User Name','API Benutzername',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (48,'DE','API Password','API Passwort',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (49,'DE','Maximum file size exceeds','Maximale Dateigröße überschritten',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (50,'DE','Site logo uploaded successfully','Seitenlogo erfolgreich hochgeladen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (51,'DE','Invalid file type','Ungültiger Dateityp',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (52,'DE','No input file specified or file size is too large','Keine Eingabedatei angegeben oder Datei zu groß',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (53,'DE','ean','EAN',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (54,'DE','Record deleted succesfully','Eintrag erfolgreich entfernt',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (55,'DE','please select the EAN from the list and then remove','Bitte EAN aus der Liste aussuchen und dann löschen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (56,'DE','Photo','Foto',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (57,'DE','ID','ID',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (58,'DE','Variation ID','Var-ID',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (59,'DE','Article Number','Artikelnummer',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (60,'DE','Price','Preis',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (61,'DE','Supplier Color','Farbe Lieferant',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (62,'DE','Lilulei Color','Farbe Lilulei',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (63,'DE','Input file must have one column','Eingabebefehl muss eine Spalte haben',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (64,'DE','Empty EAN found in','Leere EAN gefunden in',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (65,'DE','Maximum length exceeds for EAN in','Die maximale Länge für EAN ist überschritten in',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (66,'DE','Duplicate EAN found in','Doppelte EAN gefunden in',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (67,'DE','No EAN information found','Keine EAN Anzeige gefunden',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (68,'DE','EAN\'s information uploaded successfully','EANs  erfolgreich hochgeladen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (69,'DE','Keyword','Keyword',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (70,'DE','This keyword already exists','Dieses Keyword existiert bereits',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (71,'DE','Keyword id can not be empty','Keyword-ID kann nicht leer sein',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (72,'DE','You can not delete it','Kann nicht gelöscht werden',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (73,'DE','Edit','Bearbeiten',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (74,'DE','Delete','Löschen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (75,'DE','Manage Values','Werte verwalten',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (76,'DE','Values saved succesfully','Werte erfolgreich gespeichert',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (77,'DE','Please add at least one value','Bitte mindestens einen Wert eingeben',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (78,'DE','Please enter value','Bitte Wert eingeben',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (79,'DE','position','Standort',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (80,'DE','Duplicate value found in','Doppelter Wert gefunden in',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (81,'DE','Add More','Neue Werte hinzufügen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (82,'DE','Values','Werte',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (83,'DE','Please enter username','Bitte Benutzernamen eingeben',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (84,'DE','Please enter password','Bitte Passwort eingeben',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (85,'DE','Invalid username or password','Benutzername oder Passwort ungültig',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (86,'DE','You are logged out due to inactivity','Sie wurden ausgeloggt, da sie länger inaktiv waren',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (87,'DE','Site Offline','Seite offline',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (88,'DE','Shipping Cost','Versandkosten',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (89,'DE','Buying Price','Kaufpreis',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (90,'DE','Froogle','Froogle',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (91,'DE','Kelkoo','Kelkoo',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (92,'DE','Level','Level',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (93,'DE','Vat','Mehrwertsteuer',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (94,'DE','Position','Position',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (95,'DE','Product Rename','Produkt umbenennen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (96,'DE','Selling Price','Verkaufspreis',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (97,'DE','Selling Price Type','Verkaufspreis Typ',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (98,'DE','Template Name','Template Name',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (99,'DE','Status','Status',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (100,'DE','This template name already exists','Dieser Template Name existiert bereits',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (101,'DE','Template id can not be empty','Template ID darf nicht leer sein',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (102,'DE','Please choose at least one field','Bitte mindestens ein Feld aussuchen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (103,'DE','Alias can not be duplicate','Alias kann nicht kopiert werden',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (104,'DE','Export Id Missing','Export ID fehlt',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (105,'DE','Mode Of Export Is Missing','Export Art fehlt',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (106,'DE','Export Id Not Found In The System','Export ID im System nicht gefunden',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (107,'DE','Template For Export Is Not Set Yet','Template für Export noch nicht festgelegt',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (108,'DE','At least one record must be selected for export','Mindestens ein Eintrag muss für den Export ausgewählt werden',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (109,'DE','No Records Found For Export','Keine Eintragungen für den Export gefunden',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (110,'DE','Products','Produkte',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (111,'DE','Product id can not be empty','Produkt ID darf nicht leer sein',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (112,'DE','Date','Datum',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (113,'DE','Image','Bild',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (114,'DE','Username','Benutzername',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (115,'DE','Password','Passwort',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (116,'DE','Confirm Password','Passwort bestätigen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (117,'DE','Full Name','Vor- und Nachname',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (118,'DE','Email','E-Mail',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (119,'DE','Role','Funktion',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (120,'DE','Passwords do not matched','Passwörter stimmen nicht überein',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (121,'DE','This username already exists','Der Benutzername existiert bereits',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (122,'DE','This email id already exists','Die E-Mail-ID existiert bereits',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (123,'DE','Permission updated successfully','Zugriffsrechte erfolgreich aktualisiert',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (124,'DE','Permission could not be saved','Zugriffsrechte konnten nicht gespeichert werden',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (125,'DE','Select','Auswählen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (126,'DE','Maximum','Maximum',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (127,'DE','No product data found for import','Keine Produktdatei für den Import gefunden',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (128,'DE','Product\'s information uploaded successfully','Produktinfos erfolgreich hochgeladen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (129,'DE','Product ID','Produkt ID',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (130,'DE','Color','Farbe',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (131,'DE','Order Quantity','Ordermenge',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (132,'DE','Total Stock','Gesamtbestand',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (133,'DE','Memo','Memo',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (134,'DE','Search Alias','Alias suchen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (135,'DE','Discount Price','Rabattpreis',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (136,'DE','Description','Beschreibung',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (137,'DE','Show','Zeigen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (138,'DE','Upload Products','Produkte hochladen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (139,'DE','Category Name','Kategorie Name',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (140,'DE','Category Code','Kategorie Code',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (141,'DE','This category name already exists','Dieser Kategorie Name existiert bereits',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (142,'DE','This category code already exists','Dieser Kategorie Code existiert bereits',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (143,'DE','Product category id can not be empty','Produktkategorie ID darf nicht leer sein',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (144,'DE','This category can not be deleted','Diese Kategorie kann nicht gelöscht werden',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (145,'DE','This category can not be edited','Diese Kategorie kann nicht bearbeitet werden',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (146,'DE','Active','Aktiv',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (147,'DE','No records found','Keine Einträge gefunden',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (148,'DE','No Tables Found','Keine Tabelle gefunden',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (149,'DE','Error','Fehler',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (150,'DE','Name','Name',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (151,'DE','Code','Code',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (152,'DE','Information','Information',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (153,'DE','This code already exists','Dieser Code existiert bereits',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (154,'DE','Supplier id can not be empty','Lieferanten ID darf nicht leer sein',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (155,'DE','Supplier Name','Lieferanten Name',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (156,'DE','Supplier Code','Lieferanten Code',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (157,'DE','Input file must have four columns','Eingabedatei muss vier Spalten haben',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (158,'DE','Empty supplier name found in','Leerer Lieferanten Name gefunden in',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (159,'DE','Maximum length exceeds for supplier name in','Maximale Länge für Lieferanten Name überschritten in',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (160,'DE','Empty supplier code found in','Leeren Lieferanten Code gefunden in',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (161,'DE','Duplicate supplier code found in','Doppelten Lieferanten Code gefunden in',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (162,'DE','Maximum length exceeds for supplier code in','Maximale Länge für Lieferanten Code überschritten in',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (163,'DE','Maximum length exceeds for supplier info in','Maximale Länge für Lieferanten Information überschritten in',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (164,'DE','Empty or invalid status found in','Leerer oder ungültiger Status gefunden in',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (165,'DE','No supplier information found','Keine Lieferanten Information gefunden',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (166,'DE','Supplier\'s information uploaded successfully','Lieferanten Information erfolgreich hochgeladen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (167,'DE','Translation id can not be empty','Übersetzungs-ID darf nicht leer sein',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (168,'DE','Input file must have two columns','Eingabedatei muss zwei Spalten haben',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (169,'DE','Translation information uploaded successfully','Übersetzungsinformation erfolgreich hochgeladen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (170,'DE','No translation information found','Keine Übersetzungsinformation gefunden',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (171,'DE','Role Name','Funktionsname',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (172,'DE','Role Code','Funktionscode',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (173,'DE','This role name already exists','Dieser Funktionsname existiert bereits',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (174,'DE','Role id can not be empty','Funktions-ID darf nicht leer sein',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (175,'DE','This role can not be deleted as there are active usere associated with this role','Diese Funktion kann nicht gelöscht werden, da aktive Benutzer mit dieser Funktion verbunden sind',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (176,'DE','This role code already exists','Dieser Funktionscode existiert bereits',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (177,'DE','This role can not be deactived as there are active usere associated with this role','Diese Funktion kann nicht deaktiviert werden, da aktive Benutzer mit der Funktion verbunden sind',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (178,'DE','User Count','Benutzeranzahl',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (179,'DE','Username or email id can not be empty','Benutzer oder E-Mail Adresse darf nicht leer sein',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (180,'DE','We couldn\'t find an account associated with provided username or email','Es konnte kein Konto gefunden werden, das mit diesem Benutzernamen oder der E-Mail Adresse verbunden ist',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (181,'DE','User information not found','Benutzerinformation nicht gefunden',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (182,'DE','Enter New Password','Neues Passwort eingeben',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (183,'DE','An error occured while resetting password. Please try again later.','Ein Fehler ist beim Zurücksetzen des Passworts aufgetreten. Bitte versuchen Sie es später wieder.',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (184,'DE','Password have been updated successfully','Passwort wurde erfolgreich aktualisiert',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (185,'DE','User id can not be empty','Benutzer ID darf nicht leer sein',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (186,'DE','Super admin can not be deleted','Super Admin kann nicht gelöscht werden',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (187,'DE','This variation id already exists','Diese Variations-ID existiert bereits',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (188,'DE','Variation id can not be empty','Variations-ID darf nicht leer sein',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (189,'DE','This variation id can not be deleted','Diese Variations-ID kann nicht gelöscht werden',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (190,'DE','This variation id can not be edited,','Diese Variations-ID kann nicht hinzugefügt werden',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (191,'DE','Empty variation id found in','Leere Variations-ID gefunden in',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (192,'DE','Maximum length exceeds for variation id in','Maximale Länge für Variations-ID überschritten in',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (193,'DE','Duplicate variation id found in','Doppelte Variations-ID gefunden in',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (194,'DE','Please enter numeric value for variation id found in','Bitte numerischen Wert für die gefundene Variations-ID eingeben',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (195,'DE','Variation information uploaded successfully','Variations Information erfolgreich hochgeladen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (196,'DE','Log Type','Protokolltyp',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (197,'DE','IP','IP',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (198,'DE','Details','Details',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (199,'DE','ID Range','ID Bereich',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (200,'DE','Imported Rows','Importierte Zeilen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (201,'DE','Last Login','Letzter Login',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (202,'DE','Input file must have five columns','Eingabedatei muss fünf Spalten haben',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (203,'DE','Empty log type found in','Leeren Protokolltyp gefunden in',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (204,'DE','Invalid log type found in','Ungültigen Protokolltyp gefunden in',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (205,'DE','Empty user id found in','Leere Benutzer ID gefunden in',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (206,'DE','Invalid user id found in','Ungültige Benutzer ID gefunden in',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (207,'DE','Empty IP found in','Leere IP gefunden in',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (208,'DE','Invalid IP found in','Ungültige IP gefunden in',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (209,'DE','Empty user agent found in','Leerer User Agent gefunden',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (210,'DE','Empty details found in','Leere Details gefunden in',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (211,'DE','Invalid details found in','Ungültige Details gefunden in',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (212,'DE','No log information found','Keine Protokoll Information gefunden',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (213,'DE','Log information uploaded successfully','Protokoll Information erfolgreich hochgeladen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (214,'DE','Module','Modul',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (215,'DE','Inactive','Inaktiv',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (216,'DE','Add New Filter','Neuen Filter hinzufügen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (217,'DE','Search','Suchen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (218,'DE','and','und',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (219,'DE','not in','nicht in',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (220,'DE','not equal','nicht gleich',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (221,'DE','Afterbuy1 XML Post URL','Afterbuy1 XML Post URL',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (222,'DE','XML Post URL','XML Post URL',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (223,'DE','Afterbuy1 User Name','Afterbuy1 Benutzername',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (224,'DE','User Name','Benutzername',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (225,'DE','Afterbuy1 Password','Afterbuy1 Passwort',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (226,'DE','AB Password','AB Passwort',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (227,'DE','Afterbuy1 Partner ID','Afterbuy1 Partner ID',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (228,'DE','AB Partner ID','AB Partner ID',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (229,'DE','Afterbuy1 Partner Password','Afterbuy1 Partner Passwort',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (230,'DE','AB Partner Password','AB Partner Passwort',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (231,'DE','Save','Speichern',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (232,'DE','Afterbuy2 XML Post URL','Afterbuy2 XML Post URL',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (233,'DE','Afterbuy2 User Name','Afterbuy2 Benutzername',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (234,'DE','Afterbuy2 Password','Afterbuy2 Passwort',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (235,'DE','Afterbuy2 Partner ID','Afterbuy2 Partner ID',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (236,'DE','Afterbuy2 Partner Password','Afterbuy2 Partner Passwort',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (237,'DE','Site Logo','Seiten Logo',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (238,'DE','Content coming soon','Inhalt kommt demnächst',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (239,'DE','Return to home page','Zurück zur Hauptseite',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (240,'DE','Dashboard','Dashboard',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (241,'DE','Home','Home',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (242,'DE','AB1 Graph','AB1 Graph',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (243,'DE','More info','Mehr Info',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (244,'DE','AB2 Graph','AB2 Graph',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (245,'DE','View All','Alles ansehen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (246,'DE','Sales','Verkäufe',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (247,'DE','Master Id','Master Id',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (248,'DE','Show filters','Filter anzeigen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (249,'DE','Clear filter','Filter löschen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (250,'DE','Export All','Alles exportieren',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (251,'DE','Remove','Entfernen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (252,'DE','Import EANs','EAN importieren',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (253,'DE','Ok','Ok',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (254,'DE','Cancel','Abbrechen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (255,'DE','Lisa','Lisa',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (256,'DE','LISA 5.0','LISA 5.0',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (257,'DE','Welcome','Willkommen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (258,'DE','Edit Profile','Profil bearbeiten',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (259,'DE','Logout','Logout',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (260,'DE','This is 404 page.','Das ist eine 404 Seite',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (261,'DE','Submit','Abschicken',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (262,'DE','New Keyword','Neues Keyword',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (263,'DE','Sign In','Registrieren',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (264,'DE','Log In','Login',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (265,'DE','Save Template','Template sichern',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (266,'DE','Product Export Settings','Produktexport Einstellungen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (267,'DE','Other Details','Andere Details',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (268,'DE','Free Fields','Freie Felder',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (269,'DE','Action','Aktion',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (270,'DE','Fields','Felder',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (271,'DE','Alias','Alias',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (272,'DE','up','hoch',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (273,'DE','down','runter',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (274,'DE','Add New Template','Neues Template hinzufügen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (275,'DE','Availability','Verfügbarkeit',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (276,'DE','Available From','Verfügbar vom',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (277,'DE','Pricing','Preiskalkulation',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (278,'DE','Supplier Information,','Lieferanten Information',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (279,'DE','Photo List','Foto Liste',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (280,'DE','Item Supplier','Artikel Lieferant',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (281,'DE','Brand Supplier','Marke Lieferant',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (282,'DE','Color Supplier','Farbe Lieferant',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (283,'DE','Color Lilulie','Farbe Lilulei',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (284,'DE','Product Category','Produktkategorie',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (285,'DE','Image Url','Bild URL',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (286,'DE','Info','Info',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (287,'DE','GR','GR',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (288,'DE','A','A',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (289,'DE','B','B',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (290,'DE','C','C',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (291,'DE','D','D',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (292,'DE','E','E',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (293,'DE','F','F',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (294,'DE','OM','OM',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (295,'DE','DS','DS',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (296,'DE','FU','FU',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (297,'DE','LS','LS',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (298,'DE','New Product Type','Neuer Produkttyp',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (299,'DE','Search Filters','Filter suchen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (300,'DE','Buttons','Buttons',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (301,'DE','Export Data','Daten exportieren',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (302,'DE','Please select at least one record','Bitte mindestens einen Eintrag auswählen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (303,'DE','Parent Category','Oberkategorie',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (304,'DE','Add Category','Kategorie hinzufügen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (305,'DE','Update','Aktualisieren',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (306,'DE','Add New Supplier','Neuen Lieferanten hinzufügen',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (307,'DE','Import Suppliers','Lieferanten importieren',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (308,'DE','Import Translation','Übersetzung importieren',1,1404967740,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (309,'DE','Assign Permission','Zugriffsrechte zuweisen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (310,'DE','Add New Role','Neue Funktion hinzufügen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (311,'DE','Forgot Password','Passwort vergessen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (312,'DE','Please enter your username or email id','Bitte Benutzername oder E-Mail Adresse eingeben',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (313,'DE','Send Password Reset Link','Sende Link zum Passwort zurücksetzen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (314,'DE','Login','Anmelden',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (315,'DE','Email ID','E-Mail Adresse',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (316,'DE','Reset Password','Passwort zurücksetzen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (317,'DE','Please enter new password','Bitte neues Passwort eingeben',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (318,'DE','Please confirm new password','Bitte neues Passwort bestätigen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (319,'DE','Add New User','Neuen Benutzer hinzufügen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (320,'DE','New Variation','Neue Variation',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (321,'DE','Import Variations','Variationen importieren',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (322,'DE','Select Log Type','Protokolltyp aussuchen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (323,'DE','View','Ansicht',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (324,'DE','Export Log Data','Exportiere Log Data',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (325,'DE','Import Log Data','Importiere Log Data',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (326,'DE','style','Style',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (327,'DE','Your login credentials are deactivated','Ihre Zugangsdaten sind deaktiviert',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (328,'DE','Your login credentials are deleted','Ihre Zugangsdaten sind gelöscht',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (329,'DE','The role to which you belong is deactivated','Ihre Funktion ist deaktiviert',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (330,'DE','The role to which you belong is deleted','Ihre Funktion ist gelöscht',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (331,'DE','Profile','Profil',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (332,'DE','Address','Adresse',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (333,'DE','Contact No.','Kontaktnummer',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (334,'DE','You are not allowed to access menu','Sie sind nicht berechtigt, auf das Menü zuzugreifen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (335,'DE','No permission items found','Keine Zugriffsrechte gefunden',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (336,'DE','Error occured due to an empty query','Aufgrund einer leeren Suchanfrage ist ein Fehler aufgetreten',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (337,'DE','Error occured while retrieving database object','Bei der Datenbank Abfrage ist ein Fehler aufgetreten',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (338,'DE','Error occured while firing SQL query to database','Bei der SQL-Anfrage ist ein Fehler aufgetreten',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (339,'DE','is required','ist erforderlich',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (340,'DE','Invalid choice detected for','Ungültige Auswahl entdeckt bei',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (341,'DE','Please enter only numeric values for','Bitte nur numerische Werte eingeben bei',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (342,'DE','Please enter only alphabetic values for','Bitte nur alphabetische Werte eingeben bei',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (343,'DE','Please enter a valid value for','Bitte einen gültigen Wert eingeben für',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (344,'DE','Please enter a valid email id','Bitte eine gültige E-Mail Adresse eintragen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (345,'DE','Please enter a valid','Bitte einen gültigen Wert eingeben',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (346,'DE','Maximum length exceeds for','Überschreitung der maximalen Länge bei',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (347,'DE','Minimum length not reached for','Minimale Länge nicht erreicht bei',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (348,'DE','Invalid file type found for','Ungültiger Dateityp gefunden bei',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (349,'DE','Maximum file size exceeds for','Maximale Dateigröße überschritten bei',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (350,'DE','Error occured during uploading','Beim Hochladen ist ein Fehler aufgetreten',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (351,'DE','Registration','Registrierung',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (352,'DE','Page Not Found','Seite nicht gefunden',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (353,'DE','About Us','Über uns',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (354,'DE','Access Denied','Zugriff verweigert',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (355,'DE','Reset Your Password','Setzen Sie Ihr Passwort zurück',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (356,'DE','Hi','Hi',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (357,'DE','Changing your password is simple','Ihr Passwort zu ändern ist einfach',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (358,'DE','Please use the link below','Bitte nutzen Sie den Link unten',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (359,'DE','Thank You','Danke',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (360,'DE','We have sent you an email that will allow you to','Wir haben Ihnen eine Mail zugeschickt mit einem Link zum Zurücksetzen des Passworts',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (361,'DE','reset your password','Passwort zurücksetzen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (362,'DE','and any previous mail of reset password will be neglected','und jede vorhergehende E-Mail zum Passwort Zurücksetzen verliert ihre Gültigkeit',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (363,'DE','Previous','vorherige',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (364,'DE','Next','nächste',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (365,'DE','Account has been created','Das Konto wurde erstellt',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (366,'DE','Your account has been created successfully','Ihr Konto wurde erfolgreich erstellt',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (367,'DE','Account details are as follows','Konto-Details sind wie folgt',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (368,'DE','Regards','Mit freundlichen Grüßen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (369,'DE','lines','Zeilen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (370,'DE','line','Zeile',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (371,'DE','is required in','wird benötigt für',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (372,'DE','Minimum allowed length for','Minimal erlaubte Länge für',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (373,'DE','is not satisfies in','genügt nicht bei',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (374,'DE','Maximum allowed length for','Maximal erlaubte Länge für',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (375,'DE','Invalid data type for','Ungültiger Dateityp für',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (376,'DE','found in','gefunden in',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (377,'DE','Invalid value for','Ungültiger Wert für',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (378,'DE','Duplicate value for','Doppelter Wert für',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (379,'DE','Error during export','Fehler beim Exportierens',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (380,'DE','No Records Found','Keine Einträge gefunden',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (381,'DE','Loading data from server','Daten werden vom Server geladen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (382,'DE','You are not allowed to access this page','Sie haben keine Zugriffsrechte für diese Seite',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (383,'DE','User Login','User Login',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (384,'DE','Import Data','Daten importieren',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (385,'DE','All','Alles',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (386,'DE','Product Type 1','Produkt Typ1',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (387,'DE','Product Type 2','Produkt Typ2',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (388,'DE','Product Type 3','Produkt Typ3',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (389,'DE','Has Variations','Hat Variationen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (390,'DE','Afterbuy SKU','Afterbuy SKU',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (391,'DE','English Name','Englischer Name',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (392,'DE','German Name','Deutscher Name',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (393,'DE','Short Description','Kurze Beschreibung',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (394,'DE','Long Description','Lange Beschreibung',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (395,'DE','Product Information','Produktinformation',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (396,'DE','Unit','Einheit',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (397,'DE','Dealer Purchase Price','Händlereinkaufspreis',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (398,'DE','Quantity','Anzahl',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (399,'DE','Full Image Path','Kompletter Bildpfad',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (400,'DE','Thumb Image Path','Thumb Bildpfad',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (401,'DE','No. of Photos','Nummer der Fotos',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (402,'DE','Is discounted','ist rabattiert',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (403,'DE','Minimum Quantity','Minimale Menge',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (404,'DE','Shipping Group','Versandgruppe',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (405,'DE','Product Catalog Id','Produktkatalog ID',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (406,'DE','Is Froogle','Is Froogle',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (407,'DE','Is Kelkoo','Is Kelkoo',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (408,'DE','Delivery Date','Liefertermin',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (409,'DE','Delivery Time','Lieferzeit',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (410,'DE','Google Product Category','Google Produkt Kategorie',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (411,'DE','Manufacturer Part Number','Hersteller Artikelnummer',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (412,'DE','Shoe Size','Schuhgröße',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (413,'DE','Insole Length','Länge Innensohle',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (414,'DE','Insole Material','Material Innensohle',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (415,'DE','Heel Height','Absatzhöhe',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (416,'DE','Bootleg Height','Schafthöhe',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (417,'DE','Bootleg Width','Schaftweite',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (418,'DE','Outsole Length','Länge Außensohle',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (419,'DE','Outsole Material','Material Außensohle',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (420,'DE','Free Size','Free Size',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (421,'DE','Plateau','Plateau',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (422,'DE','Shoe Heel Type','Absatzart',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (423,'DE','Shoe Image','Schuh Bild',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (424,'DE','Clipping Type','Ausschnitt-Typ',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (425,'DE','Sections','Abschnitte',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (426,'DE','Material Outside','Obermaterial',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (427,'DE','Material Inside','Innenmaterial',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (428,'DE','Feeding Type,','Typ Fütterung',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (429,'DE','End to End Feeding','Komplett Gefüttert',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (430,'DE','Applicable For Gender','Geeignet für Geschlecht',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (431,'DE','Age Group','Altersgruppe',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (432,'DE','Availabe Sizes','Verfügbare Größen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (433,'DE','Actual Size','Aktuelle Größe',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (434,'DE','Lisa Color','Farbe Lisa',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (435,'DE','Ebay Color, Ebay Farbe','Farbe Ebay',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (436,'DE','Amazon Color','Farbe Amazon',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (437,'DE','Sessionsm','Abschnitte',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (438,'DE','Closures','Verschlüsse',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (439,'DE','Styles','Styles',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (440,'DE','Discount Quantity','Rabattmenge',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (441,'DE','Discount Sequence Id','Rabatt Sequenz-ID',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (442,'DE','Base product Id','Basis Produkt ID',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (443,'DE','Ignore Listing','Aufzählung ignorieren',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (444,'DE','No API Display','Keine API Darstellung',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (445,'DE','Product Position','Produkt Position',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (446,'DE','Can Renamem','Umnennung möglich',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (447,'DE','Field 1','Feld 1',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (448,'DE','Field 2','Feld 2',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (449,'DE','Field 3','Feld 3',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (450,'DE','Field 4','Feld 4',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (451,'DE','Field 5','Feld 5',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (452,'DE','Field 6','Feld 6',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (453,'DE','Field 7','Feld 7',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (454,'DE','Error during searching','Fehler bei der Suche',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (455,'DE','can not be empty or blank','darf nicht leer oder unbeschriftet sein',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (456,'DE','can not be','darf nicht',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (457,'DE','not equal at the same time','nicht gleich zur selben Zeit',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (458,'DE','End date can not be empty or blank for','Enddatum darf nicht leer oder unbeschriftet sein bei',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (459,'DE','Start date can not be empty or blank for','Startdatum darf nicht leer oder unbeschriftet sein bei',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (460,'DE','Start date can not be greater than end date for','Startdatum kann nicht später sein als Enddatum bei',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (461,'DE','Start date can not be greater than current date for','Startdatum kann nicht eher sein als aktuelles Datum bei',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (462,'DE','End date can not be greater than current date for','Enddatum kann nicht eher sein als aktuelles Datum',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (463,'DE','backup','Datensicherung',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (464,'DE','Input file must have seventy seven columns','Eingabedatei muss sieben Spalten haben',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (465,'DE','Lisa Product ID','Lisa Produkt ID',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (466,'DE','Article No','Artikel Nr.',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (467,'DE','Image URL','Bild URL',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (468,'DE','Thumbnail Image','Thumbnail Bild',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (469,'DE','Photo No.','Foto Nr.',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (470,'DE','Discontinued','unterbrochen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (471,'DE','External ID2','External ID2',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (472,'DE','Rack Position','Lagerort',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (473,'DE','Outside Material','Obermaterial',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (474,'DE','Inside Material','Innenmaterial',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (475,'DE','Catalog','Katalog',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (476,'DE','Manufacturer Part No','Artikelnummer Hersteller',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (477,'DE','Product Condition','Produktzustand',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (478,'DE','Available','Verfügbare Größen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (479,'DE','Style','Style',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (480,'DE','Section','Abschnitt',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (481,'DE','Heel Type','Absatzart',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (482,'DE','Sole Outside Material','Material Außensohle',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (483,'DE','Sole Inside Material','Material Innensohle',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (484,'DE','Free Field','Freies Feld',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (485,'DE','users','Benutzer',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (486,'DE','manage permission','Verwaltung von Zugriffsrechten',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (487,'DE','roles','Funktionen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (488,'DE','new role','neue Funktion',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (489,'DE','edit role & assign permission','Funktion bearbeiten und übertrage Zugriffsrechte',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (490,'DE','roles & users','Funktionen und Nutzer',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (491,'DE','products','Produkte',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (492,'DE','orders and stock entries','Bestellungen und Bestands-Eingänge',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (493,'DE','reports','Reports',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (494,'DE','power tools','Power Tools',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (495,'DE','help','Hilfe',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (496,'DE','new user','Neuer Benutzer',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (497,'DE','edit user & assign permission','Bearbeite Benutzer und übertrage Zugriffsrechte',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (498,'DE','delete user','Lösche Benutzer',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (499,'DE','delete role','Lösche Funktion',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (500,'DE','site configurationm','Seitengestaltung',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (501,'DE','upload site logo','Lade Seitenlogo hoch',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (502,'DE','suppliers','Lieferanten',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (503,'DE','new supplier','neuer Lieferant',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (504,'DE','edit supplier','Bearbeite Lieferanten',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (505,'DE','delete supplierm','Lösche Lieferanten',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (506,'DE','upload supplier','Lade Lieferanten hoch',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (507,'DE','keyword administration','Keyword Administration',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (508,'DE','new keyword','neues Keyword',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (509,'DE','edit keyword','Bearbeite Keyword',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (510,'DE','delete keyword','Lösche Keyword',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (511,'DE','update keyword values','Update Keyword Werte',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (512,'DE','manage keyword values','Manage Keyword Werte',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (513,'DE','dashboard widgets','Dashboard Widgets',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (514,'DE','best selling products in afterbuy 1','umsatzstärkste Produkte in Afterbuy1',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (515,'DE','best selling products in afterbuy 2','umsatzstärkste Produkte in Afterbuy2',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (516,'DE','log history','Protokollhistorie',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (517,'DE','quick links','Quick Links',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (518,'DE','afterbuy xml api settings','Afterbuy xml api Einstellungen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (519,'DE','pixi api settings','pixi api Einstellungen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (520,'DE','translation','Übersetzung',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (521,'DE','Add Translation','Übersetzung hinzufügen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (522,'DE','edit translation','Übersetzung bearbeiten',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (523,'DE','upload translation','Übersetzung hochladen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (524,'DE','manage products type(categories)','Produktarten (Kategorien) managen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (525,'DE','add product category','Produktkategorie hinzufügen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (526,'DE','edit product category','Produktkategorie bearbeiten',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (527,'DE','delete product type','Produktkategorie löschen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (528,'DE','eans','EANs',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (529,'DE','afterbuy product export setting','Afterbuy Produkt Export Einstellungen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (530,'DE','manage variation id','Variations-ID managen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (531,'DE','add variation','Variation hinzufügen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (532,'DE','edit variation','Variation bearbeiten',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (533,'DE','delete variation','Variation löschen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (534,'DE','upload variation','Variation  hochladen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (535,'DE','upload ean','EAN hochladen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (536,'DE','view logs','Protokolle sehen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (537,'DE','manage export templates','Export Vorlagen managen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (538,'DE','upload log entries','Protokolleinträge hochladen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (539,'DE','download log entries','Protokolleinträge herunterladen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (540,'DE','add export template','Export Vorlage hinzufügen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (541,'DE','delete export templates','Export Vorlage löschen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (542,'DE','edit export template','Export Vorlage bearbeiten',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (543,'DE','product description','Produktbeschreibung',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (544,'DE','product description save','Produktbeschreibung gespeichert',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (545,'DE','product availibility save','Produktverfügbarkeit gespeichert',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (546,'DE','product availibility','Produktverfügbarkeit',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (547,'DE','import product','Import Produkt',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (548,'DE','ean export','EAN exportieren',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (549,'DE','ean delete','EAN löschen',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (550,'DE','backup & purge database','Datensicherung und Datenbanksäuberung',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (551,'DE','chain id','Ketten ID',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (552,'DE','remove site logo','Entferne Seitenlogo',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (553,'DE','backup database','Datenbanksicherung',1,1404967741,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (554,'DE','Forgot your password ?','Passwort vergessen?',NULL,NULL,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (555,'DE','Username/email id','Benutzername / E-Mail-ID',NULL,NULL,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (556,'DE','Welcome to','Willkommen bei',NULL,NULL,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (557,'DE','Unauthorized Access Warning','Unbefugte Zugang Warning',NULL,NULL,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (558,'DE','Access to this computer is prohibited unless authorized.','Zugriff auf diesen Computer ist verboten, sofern zulässig.',NULL,NULL,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (559,'DE','Accessing programs or data unrelated to your job is prohibited.','Zugriff auf Programme oder Daten, die nicht mit Ihrem Job ist verboten.',NULL,NULL,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (560,'DE','All rights reserved.','Alle Rechte vorbehalten.',NULL,NULL,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (561,'DE','Download Sample File','Beispieldatei herunterladen',NULL,NULL,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (562,'DE','Show/Hide Columns','Spalten anzeigen / ausblenden',NULL,NULL,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (563,'DE','First','erste',NULL,NULL,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (564,'DE','Last','letzte',NULL,NULL,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (565,'DE','Note','Anmerkung',NULL,NULL,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (566,'DE','Select & Upload File','Wählen und Upload File',NULL,NULL,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (567,'DE','Allowed image types are','Bildtypen sind erlaubt',NULL,NULL,NULL,NULL,1);
insert into `site_translation` (`id`,`lang_code`,`source_label`,`translated_label`,`created_by`,`create_date`,`modified_by`,`modify_date`,`is_active`) values (568,'DE','and maximum allowed file size is','und maximal erlaubte Dateigröße beträgt',NULL,NULL,NULL,NULL,1);

/*Table structure for table `system_logs` */

DROP TABLE IF EXISTS `system_logs`;

CREATE TABLE `system_logs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `IP` varchar(15) CHARACTER SET utf8 NOT NULL,
  `user_agent` varchar(255) CHARACTER SET utf8 NOT NULL,
  `operation_performed` tinyint(1) NOT NULL COMMENT '1: Export,2: Import : 3 : Login',
  `module_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `id_range` tinytext CHARACTER SET utf8 COMMENT 'Used during export',
  `total_imported` int(11) DEFAULT NULL COMMENT 'Used during import',
  `created_by` int(11) NOT NULL,
  `create_date` int(11) NOT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modify_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='This table is used to store different system wide logs';

/*Data for the table `system_logs` */

insert into `system_logs` (`id`,`IP`,`user_agent`,`operation_performed`,`module_name`,`id_range`,`total_imported`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (1,'127.0.0.1','Mozilla/5.0 (Windows NT 5.1; rv:31.0) Gecko/20100101 Firefox/31.0',3,'Login','',0,1,1406871279,NULL,NULL);
insert into `system_logs` (`id`,`IP`,`user_agent`,`operation_performed`,`module_name`,`id_range`,`total_imported`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (2,'127.0.0.1','Mozilla/5.0 (Windows NT 5.1; rv:31.0) Gecko/20100101 Firefox/31.0',3,'Login','',0,1,1406871763,NULL,NULL);
insert into `system_logs` (`id`,`IP`,`user_agent`,`operation_performed`,`module_name`,`id_range`,`total_imported`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (3,'127.0.0.1','Mozilla/5.0 (Windows NT 5.1; rv:31.0) Gecko/20100101 Firefox/31.0',3,'Login','',0,1,1406872228,NULL,NULL);

/*Table structure for table `user_designs` */

DROP TABLE IF EXISTS `user_designs`;

CREATE TABLE `user_designs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `brick_size_id` int(11) NOT NULL,
  `mortar_id` int(11) NOT NULL,
  `brick_variant_id` int(11) NOT NULL,
  `json_info` text NOT NULL,
  `html_info` text NOT NULL,
  `design_image_path` varchar(255) NOT NULL,
  `created_by` int(11) NOT NULL,
  `create_date` int(11) NOT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modify_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='This table is used to store designs created by an user';

/*Data for the table `user_designs` */

/*Table structure for table `user_details` */

DROP TABLE IF EXISTS `user_details`;

CREATE TABLE `user_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `full_name` varchar(200) NOT NULL,
  `address` tinytext,
  `email_id` varchar(255) NOT NULL,
  `contact_no` varchar(15) DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `is_active` tinyint(4) DEFAULT '1',
  `is_deleted` tinyint(1) DEFAULT '0',
  `created_by` int(11) NOT NULL,
  `create_date` int(11) NOT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modify_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=104 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='This table is used to store user''s additional details';

/*Data for the table `user_details` */

insert into `user_details` (`id`,`user_id`,`full_name`,`address`,`email_id`,`contact_no`,`profile_image`,`is_active`,`is_deleted`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (1,1,'Super Admin','','sadmin@example.com','1234567890',NULL,1,0,0,0,1,1405322622);
insert into `user_details` (`id`,`user_id`,`full_name`,`address`,`email_id`,`contact_no`,`profile_image`,`is_active`,`is_deleted`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (93,87,'Deep',NULL,'dbaveja@q3tech.com',NULL,NULL,1,0,0,1406205835,NULL,NULL);
insert into `user_details` (`id`,`user_id`,`full_name`,`address`,`email_id`,`contact_no`,`profile_image`,`is_active`,`is_deleted`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (94,88,'Deep',NULL,'dbaveja@q3tech.com',NULL,NULL,1,0,0,1406206002,NULL,NULL);
insert into `user_details` (`id`,`user_id`,`full_name`,`address`,`email_id`,`contact_no`,`profile_image`,`is_active`,`is_deleted`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (95,89,'Deep',NULL,'dbaveja@q3tech.com',NULL,NULL,1,0,0,1406207640,NULL,NULL);
insert into `user_details` (`id`,`user_id`,`full_name`,`address`,`email_id`,`contact_no`,`profile_image`,`is_active`,`is_deleted`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (96,90,'Deep',NULL,'dbaveja@q3tech.com',NULL,NULL,1,0,0,1406207977,NULL,NULL);
insert into `user_details` (`id`,`user_id`,`full_name`,`address`,`email_id`,`contact_no`,`profile_image`,`is_active`,`is_deleted`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (97,91,'Deep',NULL,'dbaveja@q3tech.com',NULL,NULL,1,0,0,1406208063,NULL,NULL);
insert into `user_details` (`id`,`user_id`,`full_name`,`address`,`email_id`,`contact_no`,`profile_image`,`is_active`,`is_deleted`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (98,92,'Deep',NULL,'dbaveja@q3tech.com',NULL,NULL,1,0,0,1406208896,NULL,NULL);
insert into `user_details` (`id`,`user_id`,`full_name`,`address`,`email_id`,`contact_no`,`profile_image`,`is_active`,`is_deleted`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (99,93,'Deep',NULL,'dbaveja@q3tech.com',NULL,NULL,1,0,0,1406208919,NULL,NULL);
insert into `user_details` (`id`,`user_id`,`full_name`,`address`,`email_id`,`contact_no`,`profile_image`,`is_active`,`is_deleted`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (100,94,'Deep',NULL,'dbaveja1@q3tech.com',NULL,NULL,1,0,0,1406209516,NULL,NULL);
insert into `user_details` (`id`,`user_id`,`full_name`,`address`,`email_id`,`contact_no`,`profile_image`,`is_active`,`is_deleted`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (101,95,'Deep',NULL,'dbaveja2@q3tech.com','2342342342',NULL,1,0,0,1406209962,NULL,NULL);
insert into `user_details` (`id`,`user_id`,`full_name`,`address`,`email_id`,`contact_no`,`profile_image`,`is_active`,`is_deleted`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (102,96,'sfsdf',NULL,'dbaveja3@q3tech.com','2342342343',NULL,1,0,0,1406295813,NULL,NULL);
insert into `user_details` (`id`,`user_id`,`full_name`,`address`,`email_id`,`contact_no`,`profile_image`,`is_active`,`is_deleted`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (103,97,'dgsdf',NULL,'dfsdf@fddg.dfg','3242423423',NULL,1,0,0,1406727342,NULL,NULL);

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_password` varchar(40) NOT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT '1',
  `registered_user_ip` varchar(15) DEFAULT NULL,
  `reset_password_token` tinytext COMMENT 'To store token of reset password mail',
  `reset_password_end_time` int(11) DEFAULT NULL COMMENT 'To store end time upto which a password can be reset.',
  `last_login_date` int(11) DEFAULT NULL,
  `last_login_IP` varchar(15) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `created_by` int(11) NOT NULL,
  `create_date` int(11) NOT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modify_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=98 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='This table is used to store user''s primary details';

/*Data for the table `users` */

insert into `users` (`id`,`role_id`,`user_name`,`user_password`,`is_active`,`registered_user_ip`,`reset_password_token`,`reset_password_end_time`,`last_login_date`,`last_login_IP`,`is_deleted`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (1,1,'sadmin','c5edac1b8c1d58bad90a246d8f08f53b',1,NULL,'c2FkbWluQGV4YW1wbGUuY29tX3NhZG1pbl8xXzExNTUxMjI5OQ==',1405174578,1406872228,'127.0.0.1',0,0,0,1,1405322622);
insert into `users` (`id`,`role_id`,`user_name`,`user_password`,`is_active`,`registered_user_ip`,`reset_password_token`,`reset_password_end_time`,`last_login_date`,`last_login_IP`,`is_deleted`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (89,52,'deepbaveja','81dc9bdb52d04dc20036dbd8313ed055',1,'192.168.11.114',NULL,NULL,NULL,NULL,0,0,1406207640,NULL,NULL);
insert into `users` (`id`,`role_id`,`user_name`,`user_password`,`is_active`,`registered_user_ip`,`reset_password_token`,`reset_password_end_time`,`last_login_date`,`last_login_IP`,`is_deleted`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (90,52,'deepbaveja1','81dc9bdb52d04dc20036dbd8313ed055',1,'192.168.11.114',NULL,NULL,NULL,NULL,0,0,1406207977,NULL,NULL);
insert into `users` (`id`,`role_id`,`user_name`,`user_password`,`is_active`,`registered_user_ip`,`reset_password_token`,`reset_password_end_time`,`last_login_date`,`last_login_IP`,`is_deleted`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (91,52,'deepbaveja2','81dc9bdb52d04dc20036dbd8313ed055',1,'192.168.11.114',NULL,NULL,NULL,NULL,0,0,1406208063,NULL,NULL);
insert into `users` (`id`,`role_id`,`user_name`,`user_password`,`is_active`,`registered_user_ip`,`reset_password_token`,`reset_password_end_time`,`last_login_date`,`last_login_IP`,`is_deleted`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (92,52,'deepbaveja3','827ccb0eea8a706c4c34a16891f84e7b',1,'192.168.11.114',NULL,NULL,NULL,NULL,0,0,1406208896,NULL,NULL);
insert into `users` (`id`,`role_id`,`user_name`,`user_password`,`is_active`,`registered_user_ip`,`reset_password_token`,`reset_password_end_time`,`last_login_date`,`last_login_IP`,`is_deleted`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (93,52,'deepbaveja4','202cb962ac59075b964b07152d234b70',1,'192.168.11.114',NULL,NULL,NULL,NULL,0,0,1406208919,NULL,NULL);
insert into `users` (`id`,`role_id`,`user_name`,`user_password`,`is_active`,`registered_user_ip`,`reset_password_token`,`reset_password_end_time`,`last_login_date`,`last_login_IP`,`is_deleted`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (94,52,'deepbaveja6','81dc9bdb52d04dc20036dbd8313ed055',1,'192.168.11.114',NULL,NULL,NULL,NULL,0,0,1406209516,NULL,NULL);
insert into `users` (`id`,`role_id`,`user_name`,`user_password`,`is_active`,`registered_user_ip`,`reset_password_token`,`reset_password_end_time`,`last_login_date`,`last_login_IP`,`is_deleted`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (95,52,'deepbaveja7','827ccb0eea8a706c4c34a16891f84e7b',1,'192.168.11.114',NULL,NULL,NULL,NULL,0,0,1406209962,NULL,NULL);
insert into `users` (`id`,`role_id`,`user_name`,`user_password`,`is_active`,`registered_user_ip`,`reset_password_token`,`reset_password_end_time`,`last_login_date`,`last_login_IP`,`is_deleted`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (96,52,'sdfxcvxv','81dc9bdb52d04dc20036dbd8313ed055',1,'192.168.11.114',NULL,NULL,NULL,NULL,0,0,1406295813,NULL,NULL);
insert into `users` (`id`,`role_id`,`user_name`,`user_password`,`is_active`,`registered_user_ip`,`reset_password_token`,`reset_password_end_time`,`last_login_date`,`last_login_IP`,`is_deleted`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (97,52,'xcvcxv','81dc9bdb52d04dc20036dbd8313ed055',1,'192.168.11.114',NULL,NULL,NULL,NULL,0,0,1406727342,NULL,NULL);

/*Table structure for table `users_permissions` */

DROP TABLE IF EXISTS `users_permissions`;

CREATE TABLE `users_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `menu_codes` varchar(255) NOT NULL,
  `created_by` int(11) NOT NULL,
  `create_date` int(11) NOT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modify_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=731 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='This table is used to store user''s permissions';

/*Data for the table `users_permissions` */

/*Table structure for table `water_absorption_types` */

DROP TABLE IF EXISTS `water_absorption_types`;

CREATE TABLE `water_absorption_types` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `absorption_types` varchar(35) CHARACTER SET utf8 NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `create_date` int(11) DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modify_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `water_absorption_types` */

insert into `water_absorption_types` (`id`,`absorption_types`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (1,'Boil < 17% ',NULL,NULL,NULL,NULL);
insert into `water_absorption_types` (`id`,`absorption_types`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (2,'Avg. Boil < 20 Ind',NULL,NULL,NULL,NULL);
insert into `water_absorption_types` (`id`,`absorption_types`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (3,'Saturation < .78',NULL,NULL,NULL,NULL);
insert into `water_absorption_types` (`id`,`absorption_types`,`created_by`,`create_date`,`modified_by`,`modify_date`) values (4,'Avg. Saturation < .80 Ind',NULL,NULL,NULL,NULL);

SET SQL_MODE=@OLD_SQL_MODE;