/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 5.7.30-log : Database - eladmin
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`diamondv` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `diamondv`;


/*Table structure for table `code_column_config` */

DROP TABLE IF EXISTS `code_column_config`;

CREATE TABLE `code_column_config` (
                                      `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                                      `table_name` varchar(255) DEFAULT NULL,
                                      `column_name` varchar(255) DEFAULT NULL,
                                      `column_type` varchar(255) DEFAULT NULL,
                                      `dict_name` varchar(255) DEFAULT NULL,
                                      `extra` varchar(255) DEFAULT NULL,
                                      `form_show` bit(1) DEFAULT NULL,
                                      `form_type` varchar(255) DEFAULT NULL,
                                      `key_type` varchar(255) DEFAULT NULL,
                                      `list_show` bit(1) DEFAULT NULL,
                                      `not_null` bit(1) DEFAULT NULL,
                                      `query_type` varchar(255) DEFAULT NULL,
                                      `remark` varchar(255) DEFAULT NULL,
                                      `date_annotation` varchar(255) DEFAULT NULL,
                                      PRIMARY KEY (`column_id`) USING BTREE,
                                      KEY `idx_table_name` (`table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='代码生成字段信息存储';

/*Data for the table `code_column_config` */

/*Table structure for table `code_gen_config` */

DROP TABLE IF EXISTS `code_gen_config`;

CREATE TABLE `code_gen_config` (
                                   `config_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                                   `table_name` varchar(255) DEFAULT NULL COMMENT '表名',
                                   `author` varchar(255) DEFAULT NULL COMMENT '作者',
                                   `cover` bit(1) DEFAULT NULL COMMENT '是否覆盖',
                                   `module_name` varchar(255) DEFAULT NULL COMMENT '模块名称',
                                   `pack` varchar(255) DEFAULT NULL COMMENT '至于哪个包下',
                                   `path` varchar(255) DEFAULT NULL COMMENT '前端代码生成的路径',
                                   `api_path` varchar(255) DEFAULT NULL COMMENT '前端Api文件路径',
                                   `prefix` varchar(255) DEFAULT NULL COMMENT '表前缀',
                                   `api_alias` varchar(255) DEFAULT NULL COMMENT '接口名称',
                                   PRIMARY KEY (`config_id`) USING BTREE,
                                   KEY `idx_table_name` (`table_name`(100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='代码生成器配置';

/*Data for the table `code_gen_config` */

/*Table structure for table `component` */

DROP TABLE IF EXISTS `component`;

CREATE TABLE `component` (
                             `id` int(11) NOT NULL AUTO_INCREMENT,
                             `component` varchar(128) DEFAULT NULL,
                             `vulnerability` varchar(128) DEFAULT NULL,
                             `timestamp` datetime DEFAULT NULL,
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `component` */

/*Table structure for table `dns_type` */

DROP TABLE IF EXISTS `dns_type`;

CREATE TABLE `dns_type` (
                            `id` int(11) NOT NULL AUTO_INCREMENT,
                            `ip` varchar(128) DEFAULT NULL,
                            `type` tinyint(4) DEFAULT NULL,
                            `epoch` int(11) DEFAULT NULL,
                            PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `dns_type` */

insert  into `dns_type`(`id`,`ip`,`type`,`epoch`) values
(1,'1.1.1.1',1,2),
(2,'2.2.2.2',2,2),
(3,'3.3.3.3',3,2),
(4,'4.4.4.4',4,2),
(5,'5.5.5.5',5,2),
(6,'6.6.6.6',1,2),
(7,'7.7.7.7',1,2),
(8,'1.1.1.1',3,1),
(9,'2.2.2.2',5,1);

/*Table structure for table `doh_attribute` */

DROP TABLE IF EXISTS `doh_attribute`;

CREATE TABLE `doh_attribute` (
                                 `id` int(11) NOT NULL AUTO_INCREMENT,
                                 `ip` varchar(128) DEFAULT NULL,
                                 `port` int(11) DEFAULT NULL,
                                 `host` varchar(128) DEFAULT NULL,
                                 `path` varchar(128) DEFAULT NULL,
                                 `method` varchar(4) DEFAULT NULL,
                                 `connect_type` int(11) DEFAULT NULL,
                                 `status_code` int(11) DEFAULT NULL,
                                 `rep_header` varchar(2048) DEFAULT NULL,
                                 `rep_body` varchar(1024) DEFAULT NULL,
                                 `timestamp` datetime DEFAULT NULL,
                                 `component` varchar(128) DEFAULT NULL,
                                 `rounds` tinyint(11) DEFAULT NULL,
                                 PRIMARY KEY (`id`),
                                 KEY `idx_ip` (`ip`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*Data for the table `doh_attribute` */

insert  into `doh_attribute`(`id`,`ip`,`port`,`host`,`path`,`method`,`connect_type`,`status_code`,`rep_header`,`rep_body`,`timestamp`,`component`,`rounds`) values
(1,'1.1.1.1',8443,'192.168.32.46','/test1','post',1,200,'{head1}','{body1}','2022-05-12 14:59:11','nginx',2),
(2,'2.2.2.2',8443,'192.168.77.88','/test2','get',2,400,'{head}','{erro}','2022-05-11 15:00:02','bind',2),
(3,'3.3.3.3',8443,'192.168.74.32','/test3','post',1,404,'{head}','{not found}','2022-04-10 15:00:52','nginx',2),
(4,'1.1.1.1',8443,'192.168.32.46','/test4','get',1,200,'{head2}','{body2}','2022-05-09 11:56:55','bind',2),
(5,'1.1.1.1',443,'192.168.32.47','/test1','post',1,200,'{head1}','{body1}','2022-05-08 16:58:48','nginx',2),
(6,'4.4.4.4',443,'192.168.1.1','/test4','get',1,200,'{head4}','{body4}','2022-05-07 14:37:43','bind',2),
(7,'5.5.5.5',443,'192.168.5.5','/test5','del',3,500,'{head5}','{body5}','2022-05-06 14:38:40','nginx',2),
(8,'6.6.6.6',443,'192.168.5.6','/test6','get',3,500,'{head6}','{body6}','2022-05-05 09:06:47','bind',2),
(9,'2.2.2.2',443,'192.168.77.88','/test2','get',2,400,'{head}','{erro}','2022-04-01 14:21:42','bind',1),
(10,'3.3.3.3',443,'192.168.74.31','/test3','post',1,404,'{head}','{not found}','2022-04-01 14:22:31','bind',1),
(11,'7.7.7.7',443,'192.168.77.77','/test7','post',1,404,'{head}','{not found}','2022-05-06 16:53:13','bind',2),
(12,'8.8.8.8',443,'192.168.88.88','/test8','post',1,404,'{head}','{not found}','2022-05-06 16:54:53','nginx',2),
(13,'9.9.9.9',443,'192.168.99.99','/test9','post',1,404,'{head}','{not found}','2022-05-06 16:54:59','nginx',2),
(14,'9.9.9.8',443,'192.168.99.98','/test98','post',1,404,'{head}','{not found}','2022-05-06 16:55:28','nginx',2),
(15,'9.9.9.7',443,'192.168.99.97','/test97','post',1,404,'{head}','{not found}','2022-05-13 16:59:18',NULL,2);

/*Table structure for table `forward_dns` */

DROP TABLE IF EXISTS `forward_dns`;

CREATE TABLE `forward_dns` (
                               `id` int(11) NOT NULL AUTO_INCREMENT,
                               `forwarder` varchar(128) DEFAULT NULL,
                               `upstream` varchar(128) DEFAULT NULL,
                               `epoch` int(11) DEFAULT NULL,
                               PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `forward_dns` */

insert  into `forward_dns`(`id`,`forwarder`,`upstream`,`epoch`) values
(1,'1.1.1.1','2.2.2.2',2),
(2,'2.2.2.2','1.1.1.1',2),
(3,'2.2.2.2','2.2.2.2',2),
(4,'3.3.3.3','4.4.4.4',2),
(5,'1.1.1.1','5.5.5.5',1),
(6,'2.2.2.2','6.6.6.6',1);

/*Table structure for table `ip_cert` */

DROP TABLE IF EXISTS `ip_cert`;

CREATE TABLE `ip_cert` (
                           `id` int(11) NOT NULL AUTO_INCREMENT,
                           `ip` varchar(128) DEFAULT NULL,
                           `port` int(11) DEFAULT NULL,
                           `certificate` varchar(5120) DEFAULT NULL,
                           `ca` varchar(128) DEFAULT NULL,
                           `timestamp` datetime DEFAULT NULL,
                           PRIMARY KEY (`id`),
                           KEY `idx_ip` (`ip`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `ip_cert` */

insert  into `ip_cert`(`id`,`ip`,`port`,`certificate`,`ca`,`timestamp`) values
(1,'1.1.1.1',8443,'t1证书','t1证书颁发者','2022-04-27 15:01:33'),
(2,'2.2.2.2',8443,'t2证书','t2证书颁发者','2022-04-27 15:01:49'),
(3,'3.3.3.3',8443,'t3证书','t3证书颁发者','2022-04-27 15:02:01'),
(4,'1.1.1.1',8443,'t1证书2','t1证书颁发者2','2022-05-06 09:03:22'),
(5,'2.2.2.2',443,'t2证书443','t2证书颁发者443','2022-05-18 13:51:00'),
(6,'3.3.3.3',443,'t3证书443','t3证书颁发者443','2022-05-18 13:51:01');

/*Table structure for table `ip_information` */

DROP TABLE IF EXISTS `ip_information`;

CREATE TABLE `ip_information` (
                                  `id` int(11) NOT NULL AUTO_INCREMENT,
                                  `ip` varchar(128) DEFAULT NULL,
                                  `country` varchar(50) DEFAULT NULL,
                                  `province` varchar(50) DEFAULT NULL,
                                  `city` varchar(50) DEFAULT NULL,
                                  `district` varchar(50) DEFAULT NULL,
                                  `provider` varchar(50) DEFAULT NULL,
                                  `isp` varchar(50) DEFAULT NULL,
                                  `asnumber` int(11) DEFAULT NULL,
                                  `timestamp` datetime DEFAULT NULL,
                                  `zipcode` varchar(50) DEFAULT NULL,
                                  `timezone` varchar(50) DEFAULT NULL,
                                  PRIMARY KEY (`id`),
                                  KEY `idx_ip` (`ip`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `ip_information` */

insert  into `ip_information`(`id`,`ip`,`country`,`province`,`city`,`district`,`provider`,`isp`,`asnumber`,`timestamp`,`zipcode`,`timezone`) values
(1,'1.1.1.1','中国','河北','邢台','1','华为','华为',123456789,'2022-04-27 14:55:00','100000','UTC'),
(2,'2.2.2.2','哥伦比亚','德克萨斯州','纽约','2','特斯拉','特斯拉',987654321,'2022-04-27 14:56:27','500000','USA'),
(3,'3.3.3.3','刚果','伦敦省','伦敦市','3','长安','长安',741852963,'2022-04-27 14:57:31','800000','UK'),
(4,'4.4.4.4','日本','北京','怀柔','4','烤鸭','烤鸭',8888888,'2022-04-28 11:16:40','100010','UTC'),
(5,'5.5.5.5','韩国','河南','郑州','5','三星','三星',55555555,'2022-05-06 14:39:53','100010','UTC'),
(6,'6.6.6.6','英国','河北','石家庄','5','苹果','苹果',666666,'2022-05-13 14:25:55','100010','UTC'),
(7,'7.7.7.7','法国','江苏','南京','5','移动','移动',77777777,'2022-05-13 14:30:16','100010','UTC'),
(8,'8.8.8.8','德国','柏林','柏林',NULL,'运营商1','运营商1',8888888,'2022-05-17 16:58:06','100010',NULL),
(9,'9.9.9.9','瑞典','斯德哥尔摩','斯德哥尔摩',NULL,'运营商2','运营商2',999999,'2022-05-17 16:58:10','100010',NULL),
(10,'9.9.9.8','丹麦','哥本哈根','哥本哈根',NULL,'运营商3','运营商3',9999998,'2022-05-17 16:58:12','100010',NULL),
(11,'9.9.9.7','意大利','罗马','罗马',NULL,'运营商4','运营商4',333333,'2022-05-17 16:59:55',NULL,NULL);

/*Table structure for table `mnt_app` */

DROP TABLE IF EXISTS `mnt_app`;

CREATE TABLE `mnt_app` (
                           `app_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                           `name` varchar(255) DEFAULT NULL COMMENT '应用名称',
                           `upload_path` varchar(255) DEFAULT NULL COMMENT '上传目录',
                           `deploy_path` varchar(255) DEFAULT NULL COMMENT '部署路径',
                           `backup_path` varchar(255) DEFAULT NULL COMMENT '备份路径',
                           `port` int(255) DEFAULT NULL COMMENT '应用端口',
                           `start_script` varchar(4000) DEFAULT NULL COMMENT '启动脚本',
                           `deploy_script` varchar(4000) DEFAULT NULL COMMENT '部署脚本',
                           `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
                           `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
                           `create_time` datetime DEFAULT NULL COMMENT '创建日期',
                           `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                           PRIMARY KEY (`app_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='应用管理';

/*Data for the table `mnt_app` */

/*Table structure for table `mnt_database` */

DROP TABLE IF EXISTS `mnt_database`;

CREATE TABLE `mnt_database` (
                                `db_id` varchar(50) NOT NULL COMMENT 'ID',
                                `name` varchar(255) NOT NULL COMMENT '名称',
                                `jdbc_url` varchar(255) NOT NULL COMMENT 'jdbc连接',
                                `user_name` varchar(255) NOT NULL COMMENT '账号',
                                `pwd` varchar(255) NOT NULL COMMENT '密码',
                                `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
                                `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
                                `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                PRIMARY KEY (`db_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='数据库管理';

/*Data for the table `mnt_database` */

/*Table structure for table `mnt_deploy` */

DROP TABLE IF EXISTS `mnt_deploy`;

CREATE TABLE `mnt_deploy` (
                              `deploy_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                              `app_id` bigint(20) DEFAULT NULL COMMENT '应用编号',
                              `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
                              `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
                              `create_time` datetime DEFAULT NULL,
                              `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                              PRIMARY KEY (`deploy_id`) USING BTREE,
                              KEY `FK6sy157pseoxx4fmcqr1vnvvhy` (`app_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='部署管理';

/*Data for the table `mnt_deploy` */

/*Table structure for table `mnt_deploy_history` */

DROP TABLE IF EXISTS `mnt_deploy_history`;

CREATE TABLE `mnt_deploy_history` (
                                      `history_id` varchar(50) NOT NULL COMMENT 'ID',
                                      `app_name` varchar(255) NOT NULL COMMENT '应用名称',
                                      `deploy_date` datetime NOT NULL COMMENT '部署日期',
                                      `deploy_user` varchar(50) NOT NULL COMMENT '部署用户',
                                      `ip` varchar(20) NOT NULL COMMENT '服务器IP',
                                      `deploy_id` bigint(20) DEFAULT NULL COMMENT '部署编号',
                                      PRIMARY KEY (`history_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='部署历史管理';

/*Data for the table `mnt_deploy_history` */

/*Table structure for table `mnt_deploy_server` */

DROP TABLE IF EXISTS `mnt_deploy_server`;

CREATE TABLE `mnt_deploy_server` (
                                     `deploy_id` bigint(20) NOT NULL COMMENT '部署ID',
                                     `server_id` bigint(20) NOT NULL COMMENT '服务ID',
                                     PRIMARY KEY (`deploy_id`,`server_id`) USING BTREE,
                                     KEY `FKeaaha7jew9a02b3bk9ghols53` (`server_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='应用与服务器关联';

/*Data for the table `mnt_deploy_server` */

/*Table structure for table `mnt_server` */

DROP TABLE IF EXISTS `mnt_server`;

CREATE TABLE `mnt_server` (
                              `server_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                              `account` varchar(50) DEFAULT NULL COMMENT '账号',
                              `ip` varchar(20) DEFAULT NULL COMMENT 'IP地址',
                              `name` varchar(100) DEFAULT NULL COMMENT '名称',
                              `password` varchar(100) DEFAULT NULL COMMENT '密码',
                              `port` int(11) DEFAULT NULL COMMENT '端口',
                              `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
                              `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
                              `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                              `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                              PRIMARY KEY (`server_id`) USING BTREE,
                              KEY `idx_ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='服务器管理';

/*Data for the table `mnt_server` */

/*Table structure for table `nonstandard_dns` */

DROP TABLE IF EXISTS `nonstandard_dns`;

CREATE TABLE `nonstandard_dns` (
                                   `id` int(11) NOT NULL AUTO_INCREMENT,
                                   `ip` varchar(128) DEFAULT NULL,
                                   `record` varchar(128) DEFAULT NULL,
                                   `epoch` int(11) DEFAULT NULL,
                                   PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `nonstandard_dns` */

insert  into `nonstandard_dns`(`id`,`ip`,`record`,`epoch`) values
(1,'1.1.1.1','aaaaa',2),
(2,'1.1.1.1','vvvvv',2),
(3,'2.2.2.2','22aaaa',2),
(4,'3.3.3.3','33aaaaa',2),
(5,'4.4.4.4','444aaaa',2),
(6,'5.5.5.5','555aaaa',2);

/*Table structure for table `scan_result` */

DROP TABLE IF EXISTS `scan_result`;

CREATE TABLE `scan_result` (
                               `id` int(11) NOT NULL AUTO_INCREMENT,
                               `ip` varchar(128) DEFAULT NULL,
                               `flags` int(11) DEFAULT NULL,
                               `opcode` tinyint(4) DEFAULT NULL,
                               `qr` tinyint(4) DEFAULT NULL,
                               `aa` tinyint(4) DEFAULT NULL,
                               `ra` tinyint(4) DEFAULT NULL,
                               `rcode` int(4) DEFAULT NULL,
                               `query_name` varchar(256) DEFAULT NULL,
                               `query_response` varchar(512) DEFAULT NULL,
                               `component` varchar(128) DEFAULT NULL,
                               `epoch` int(11) DEFAULT NULL,
                               `scan_type` tinyint(4) DEFAULT NULL,
                               `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                               PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Data for the table `scan_result` */

insert  into `scan_result`(`id`,`ip`,`flags`,`opcode`,`qr`,`aa`,`ra`,`rcode`,`query_name`,`query_response`,`component`,`epoch`,`scan_type`,`time`) values
(1,'1.1.1.1',NULL,NULL,NULL,1,1,200,'1.1.1.1请求域名','1.1.1.1应答结果','bind',2,NULL,'2022-05-17 09:49:53'),
(2,'2.2.2.2',NULL,NULL,NULL,2,2,400,'2.2.2.2请求域名','2.2.2.2应答结果','bind',2,NULL,'2022-05-16 16:26:15'),
(3,'3.3.3.3',NULL,NULL,NULL,3,3,500,'3.3.3.3请求域名','3.3.3.3应答结果','bind',2,NULL,'2022-05-16 16:26:12'),
(4,'4.4.4.4',NULL,NULL,NULL,4,4,404,'4.4.4.4请求域名','4.4.4.4应答结果','unbound',2,NULL,'2022-05-16 16:26:12'),
(5,'5.5.5.5',NULL,NULL,NULL,5,5,500,'5.5.5.5请求域名','5.5.5.5应答结果','unbound',2,NULL,'2022-05-16 16:26:11'),
(6,'1.1.1.1',NULL,NULL,NULL,3,4,404,'1.1.1.1请求域名2','1.1.1.1应答结果2','bind',2,NULL,'2022-05-16 16:26:11'),
(7,'6.6.6.6',NULL,NULL,NULL,6,6,200,'6.6.6.6请求域名','6.6.6.6应答结果','bind',2,NULL,'2022-05-16 16:26:10'),
(8,'7.7.7.7',NULL,NULL,NULL,7,7,400,'7.7.7.7请求域名','7.7.7.7请求域名','bind',2,NULL,'2022-05-16 16:26:09'),
(9,'8.8.8.8',NULL,NULL,NULL,8,8,400,'8.8.8.8请求域名','8.8.8.8请求域名','bind',2,NULL,'2022-05-16 16:26:09'),
(10,'9.9.9.9',NULL,NULL,NULL,9,9,400,'9.9.9.9请求域名','9.9.9.9请求域名','bind',2,NULL,'2022-05-16 16:26:08'),
(11,'9.9.9.8',NULL,NULL,NULL,9,9,400,'9.9.9.9请求域名2','9.9.9.9请求域名2','bind',2,NULL,'2022-05-16 16:26:07'),
(12,'9.9.9.7',NULL,NULL,NULL,9,9,400,'9.9.9.9请求域名3','9.9.9.9请求域名3','bind',2,NULL,'2022-05-16 16:26:07'),
(13,'9.9.9.6',NULL,NULL,NULL,9,9,400,'9.9.9.9请求域名4','9.9.9.9请求域名4','bind',2,NULL,'2022-05-16 16:26:06'),
(14,'1.1.1.1',NULL,NULL,NULL,1,1,200,'1.1.1.1请求域名2','9.9.9.9请求域名4','bind',1,NULL,'2022-05-16 16:26:04'),
(15,'2.2.2.2',NULL,NULL,NULL,2,2,200,'2.2.2.2请求域名2','2.2.2.2请求域名2','bind',1,NULL,'2022-05-16 16:26:02');

/*Table structure for table `sys_dept` */

DROP TABLE IF EXISTS `sys_dept`;

CREATE TABLE `sys_dept` (
                            `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                            `pid` bigint(20) DEFAULT NULL COMMENT '上级部门',
                            `sub_count` int(5) DEFAULT '0' COMMENT '子部门数目',
                            `name` varchar(255) NOT NULL COMMENT '名称',
                            `dept_sort` int(5) DEFAULT '999' COMMENT '排序',
                            `enabled` bit(1) NOT NULL COMMENT '状态',
                            `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
                            `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
                            `create_time` datetime DEFAULT NULL COMMENT '创建日期',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            PRIMARY KEY (`dept_id`) USING BTREE,
                            KEY `inx_pid` (`pid`),
                            KEY `inx_enabled` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='部门';

/*Data for the table `sys_dept` */

insert  into `sys_dept`(`dept_id`,`pid`,`sub_count`,`name`,`dept_sort`,`enabled`,`create_by`,`update_by`,`create_time`,`update_time`) values
(2,7,1,'研发部',3,'','admin','admin','2019-03-25 09:15:32','2020-08-02 14:48:47'),
(5,7,0,'运维部',4,'','admin','admin','2019-03-25 09:20:44','2020-05-17 14:27:27'),
(6,8,0,'测试部',6,'','admin','admin','2019-03-25 09:52:18','2020-06-08 11:59:21'),
(7,NULL,2,'华南分部',0,'','admin','admin','2019-03-25 11:04:50','2020-06-08 12:08:56'),
(8,NULL,2,'华北分部',1,'','admin','admin','2019-03-25 11:04:53','2020-05-14 12:54:00'),
(15,8,0,'UI部门',7,'','admin','admin','2020-05-13 22:56:53','2020-05-14 12:54:13'),
(17,2,0,'研发一组',999,'','admin','admin','2020-08-02 14:49:07','2020-08-02 14:49:07');

/*Table structure for table `sys_dict` */

DROP TABLE IF EXISTS `sys_dict`;

CREATE TABLE `sys_dict` (
                            `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                            `name` varchar(255) NOT NULL COMMENT '字典名称',
                            `description` varchar(255) DEFAULT NULL COMMENT '描述',
                            `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
                            `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
                            `create_time` datetime DEFAULT NULL COMMENT '创建日期',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            PRIMARY KEY (`dict_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='数据字典';

/*Data for the table `sys_dict` */

insert  into `sys_dict`(`dict_id`,`name`,`description`,`create_by`,`update_by`,`create_time`,`update_time`) values
(1,'user_status','用户状态',NULL,NULL,'2019-10-27 20:31:36',NULL),
(4,'dept_status','部门状态',NULL,NULL,'2019-10-27 20:31:36',NULL),
(5,'job_status','岗位状态',NULL,NULL,'2019-10-27 20:31:36',NULL);

/*Table structure for table `sys_dict_detail` */

DROP TABLE IF EXISTS `sys_dict_detail`;

CREATE TABLE `sys_dict_detail` (
                                   `detail_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                                   `dict_id` bigint(11) DEFAULT NULL COMMENT '字典id',
                                   `label` varchar(255) NOT NULL COMMENT '字典标签',
                                   `value` varchar(255) NOT NULL COMMENT '字典值',
                                   `dict_sort` int(5) DEFAULT NULL COMMENT '排序',
                                   `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
                                   `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
                                   `create_time` datetime DEFAULT NULL COMMENT '创建日期',
                                   `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                   PRIMARY KEY (`detail_id`) USING BTREE,
                                   KEY `FK5tpkputc6d9nboxojdbgnpmyb` (`dict_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='数据字典详情';

/*Data for the table `sys_dict_detail` */

insert  into `sys_dict_detail`(`detail_id`,`dict_id`,`label`,`value`,`dict_sort`,`create_by`,`update_by`,`create_time`,`update_time`) values
(1,1,'激活','true',1,NULL,NULL,'2019-10-27 20:31:36',NULL),
(2,1,'禁用','false',2,NULL,NULL,NULL,NULL),
(3,4,'启用','true',1,NULL,NULL,NULL,NULL),
(4,4,'停用','false',2,NULL,NULL,'2019-10-27 20:31:36',NULL),
(5,5,'启用','true',1,NULL,NULL,NULL,NULL),
(6,5,'停用','false',2,NULL,NULL,'2019-10-27 20:31:36',NULL);

/*Table structure for table `sys_job` */

DROP TABLE IF EXISTS `sys_job`;

CREATE TABLE `sys_job` (
                           `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                           `name` varchar(255) NOT NULL COMMENT '岗位名称',
                           `enabled` bit(1) NOT NULL COMMENT '岗位状态',
                           `job_sort` int(5) DEFAULT NULL COMMENT '排序',
                           `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
                           `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
                           `create_time` datetime DEFAULT NULL COMMENT '创建日期',
                           `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                           PRIMARY KEY (`job_id`) USING BTREE,
                           UNIQUE KEY `uniq_name` (`name`),
                           KEY `inx_enabled` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='岗位';

/*Data for the table `sys_job` */

insert  into `sys_job`(`job_id`,`name`,`enabled`,`job_sort`,`create_by`,`update_by`,`create_time`,`update_time`) values
(8,'人事专员','',3,NULL,NULL,'2019-03-29 14:52:28',NULL),
(10,'产品经理','',4,NULL,NULL,'2019-03-29 14:55:51',NULL),
(11,'全栈开发','',2,NULL,'admin','2019-03-31 13:39:30','2020-05-05 11:33:43'),
(12,'软件测试','',5,NULL,'admin','2019-03-31 13:39:43','2020-05-10 19:56:26');

/*Table structure for table `sys_log` */

DROP TABLE IF EXISTS `sys_log`;

CREATE TABLE `sys_log` (
                           `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                           `description` varchar(255) DEFAULT NULL,
                           `log_type` varchar(255) DEFAULT NULL,
                           `method` varchar(255) DEFAULT NULL,
                           `params` text,
                           `request_ip` varchar(255) DEFAULT NULL,
                           `time` bigint(20) DEFAULT NULL,
                           `username` varchar(255) DEFAULT NULL,
                           `address` varchar(255) DEFAULT NULL,
                           `browser` varchar(255) DEFAULT NULL,
                           `exception_detail` text,
                           `create_time` datetime DEFAULT NULL,
                           PRIMARY KEY (`log_id`) USING BTREE,
                           KEY `log_create_time_index` (`create_time`),
                           KEY `inx_log_type` (`log_type`)
) ENGINE=InnoDB AUTO_INCREMENT=3549 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统日志';

/*Data for the table `sys_log` */

insert  into `sys_log`(`log_id`,`description`,`log_type`,`method`,`params`,`request_ip`,`time`,`username`,`address`,`browser`,`exception_detail`,`create_time`) values
(3537,'修改用户','INFO','com.example.modules.system.rest.UserController.updateUser()','{\"gender\":\"男\",\"nickName\":\"测试\",\"roles\":[],\"jobs\":[{\"updateTime\":1589111786000,\"enabled\":true,\"jobSort\":5,\"updateBy\":\"admin\",\"createTime\":1554010783000,\"name\":\"软件测试\",\"id\":12}],\"avatarPath\":\"/Users/jie/Documents/work/me/admin/eladmin/~/avatar/avatar-20200806032259161.png\",\"updateTime\":1599273818000,\"dept\":{\"subCount\":0,\"name\":\"研发部\",\"id\":2},\"isAdmin\":false,\"enabled\":true,\"avatarName\":\"avatar-20200806032259161.png\",\"createBy\":\"admin\",\"phone\":\"19999999999\",\"pwdResetTime\":1588495111000,\"updateBy\":\"admin\",\"createTime\":1588648549000,\"id\":2,\"email\":\"231@qq.com\",\"username\":\"test\"}','192.168.32.87',144,'admin','内网IP','Chrome 98.0.4758.102',NULL,'2022-04-24 11:18:20'),
(3538,'新增用户','INFO','com.example.modules.system.controller.UserController.createUser()','{\"gender\":\"男\",\"nickName\":\"aaa\",\"roles\":[{\"level\":3,\"dataScope\":\"本级\",\"id\":2}],\"jobs\":[{\"id\":8}],\"updateTime\":1650790301429,\"dept\":{\"subCount\":0,\"id\":8},\"isAdmin\":false,\"enabled\":true,\"password\":\"$2a$10$39eu19DlibPMfC9EEPPErO86uBAZhCzySlhvSn/Evg0gdInNeNB3W\",\"createBy\":\"admin\",\"phone\":\"15014236547\",\"updateBy\":\"admin\",\"createTime\":1650790301429,\"id\":3,\"email\":\"22@qq.com\",\"username\":\"test2\"}','192.168.32.87',171,'admin','内网IP','Chrome 98.0.4758.102',NULL,'2022-04-24 16:51:41'),
(3539,'新增用户','ERROR','com.example.modules.system.controller.UserController.createUser()','{\"gender\":\"男\",\"nickName\":\"test3\",\"roles\":[{\"level\":3,\"dataScope\":\"本级\",\"id\":2}],\"jobs\":[{\"id\":8}],\"dept\":{\"subCount\":0,\"id\":7},\"isAdmin\":false,\"enabled\":true,\"password\":\"$2a$10$w8i0HM4aRHvCeVBg/KCx/O0kwDxrFDBpxvDX5ojBJ7xywJWEoDB6S\",\"phone\":\"15033669955\",\"email\":\"22@qq.com\",\"username\":\"test3\"}','192.168.32.87',34422,'admin','内网IP','Chrome 98.0.4758.102','com.example.exception.EntityExistException: User with email 22@qq.com existed\r\n	at com.example.modules.system.service.impl.UserServiceImpl.create(UserServiceImpl.java:90)\r\n	at com.example.modules.system.service.impl.UserServiceImpl$$FastClassBySpringCGLIB$$5003e55c.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:367)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:118)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:691)\r\n	at com.example.modules.system.service.impl.UserServiceImpl$$EnhancerBySpringCGLIB$$ea52fc62.create(<generated>)\r\n	at com.example.modules.system.controller.UserController.createUser(UserController.java:109)\r\n	at com.example.modules.system.controller.UserController$$FastClassBySpringCGLIB$$3a3729d2.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.AspectJAfterThrowingAdvice.invoke(AspectJAfterThrowingAdvice.java:62)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:88)\r\n	at com.example.aspect.LogAspect.logAround(LogAspect.java:68)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:644)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:633)\r\n	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.security.access.intercept.aopalliance.MethodSecurityInterceptor.invoke(MethodSecurityInterceptor.java:69)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:95)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:691)\r\n	at com.example.modules.system.controller.UserController$$EnhancerBySpringCGLIB$$9d3d2338.createUser(<generated>)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:190)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:105)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:878)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:792)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1040)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:943)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1006)\r\n	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:909)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:652)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:883)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:733)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:113)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at com.alibaba.druid.support.http.WebStatFilter.doFilter(WebStatFilter.java:124)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:320)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.invoke(FilterSecurityInterceptor.java:126)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.doFilter(FilterSecurityInterceptor.java:90)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:118)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:137)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.AnonymousAuthenticationFilter.doFilter(AnonymousAuthenticationFilter.java:111)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter.doFilter(SecurityContextHolderAwareRequestFilter.java:158)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.savedrequest.RequestCacheAwareFilter.doFilter(RequestCacheAwareFilter.java:63)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at com.example.modules.security.security.TokenFilter.doFilter(TokenFilter.java:90)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.web.filter.CorsFilter.doFilterInternal(CorsFilter.java:92)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.logout.LogoutFilter.doFilter(LogoutFilter.java:116)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doHeadersAfter(HeaderWriterFilter.java:92)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doFilterInternal(HeaderWriterFilter.java:77)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.SecurityContextPersistenceFilter.doFilter(SecurityContextPersistenceFilter.java:105)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter.doFilterInternal(WebAsyncManagerIntegrationFilter.java:56)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.FilterChainProxy.doFilterInternal(FilterChainProxy.java:215)\r\n	at org.springframework.security.web.FilterChainProxy.doFilter(FilterChainProxy.java:178)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:358)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:271)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:201)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:202)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:97)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:541)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:143)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:78)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)\r\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:374)\r\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:65)\r\n	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:868)\r\n	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1590)\r\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\r\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\r\n	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:748)\r\n','2022-04-24 16:59:29'),
(3540,'修改用户','INFO','com.example.modules.system.controller.UserController.updateUser()','{\"gender\":\"男\",\"nickName\":\"管理员\",\"roles\":[],\"jobs\":[{\"updateTime\":1588649623000,\"enabled\":true,\"jobSort\":2,\"updateBy\":\"admin\",\"createTime\":1554010770000,\"name\":\"全栈开发\",\"id\":11}],\"avatarPath\":\"/Users/jie/Documents/work/me/admin/eladmin/~/avatar/avatar-20200806032259161.png\",\"updateTime\":1599273811000,\"dept\":{\"subCount\":0,\"name\":\"研发部\",\"id\":2},\"isAdmin\":false,\"enabled\":true,\"avatarName\":\"avatar-20200806032259161.png\",\"phone\":\"18888888888\",\"pwdResetTime\":1588495111000,\"updateBy\":\"admin\",\"createTime\":1534986716000,\"id\":1,\"email\":\"201507802@qq.com\",\"username\":\"admin\"}','192.168.32.87',52,'admin','内网IP','Chrome 98.0.4758.102',NULL,'2022-04-24 17:03:00'),
(3541,'新增用户','INFO','com.example.modules.system.controller.UserController.createUser()','{\"gender\":\"男\",\"nickName\":\"xx\",\"roles\":[{\"level\":3,\"dataScope\":\"本级\",\"id\":2}],\"jobs\":[{\"id\":8}],\"updateTime\":1650793621130,\"dept\":{\"subCount\":0,\"id\":7},\"isAdmin\":false,\"enabled\":true,\"password\":\"$2a$10$NGkgAoFjWGUueMJ81409I.mAJXa2KHf9b9GwgWZOCN8TdL35lLigy\",\"createBy\":\"admin\",\"phone\":\"15044878963\",\"updateBy\":\"admin\",\"createTime\":1650793621130,\"id\":4,\"email\":\"3333@qq.com\",\"username\":\"xx\"}','192.168.32.87',166,'admin','内网IP','Chrome 98.0.4758.102',NULL,'2022-04-24 17:47:01'),
(3542,'新增用户','ERROR','com.example.modules.system.controller.UserController.createUser()','{\"gender\":\"男\",\"nickName\":\"xxx\",\"isAdmin\":false,\"enabled\":true,\"phone\":\"15044878963\",\"email\":\"33233@qq.com\",\"username\":\"xxx\"}','192.168.32.87',5,'admin','内网IP','PostmanRuntime 7.28.4','java.lang.NullPointerException\r\n	at com.example.modules.system.service.impl.RoleServiceImpl.findByRoles(RoleServiceImpl.java:158)\r\n	at com.example.modules.system.service.impl.RoleServiceImpl$$FastClassBySpringCGLIB$$dc8a47d1.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:687)\r\n	at com.example.modules.system.service.impl.RoleServiceImpl$$EnhancerBySpringCGLIB$$9cac769b.findByRoles(<generated>)\r\n	at com.example.modules.system.controller.UserController.checkLevel(UserController.java:191)\r\n	at com.example.modules.system.controller.UserController.createUser(UserController.java:106)\r\n	at com.example.modules.system.controller.UserController$$FastClassBySpringCGLIB$$3a3729d2.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.AspectJAfterThrowingAdvice.invoke(AspectJAfterThrowingAdvice.java:62)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:88)\r\n	at com.example.aspect.LogAspect.logAround(LogAspect.java:68)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:644)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:633)\r\n	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.security.access.intercept.aopalliance.MethodSecurityInterceptor.invoke(MethodSecurityInterceptor.java:69)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:95)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:691)\r\n	at com.example.modules.system.controller.UserController$$EnhancerBySpringCGLIB$$c18ababd.createUser(<generated>)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:190)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:105)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:878)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:792)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1040)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:943)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1006)\r\n	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:909)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:652)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:883)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:733)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:113)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at com.alibaba.druid.support.http.WebStatFilter.doFilter(WebStatFilter.java:124)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:320)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.invoke(FilterSecurityInterceptor.java:126)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.doFilter(FilterSecurityInterceptor.java:90)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:118)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:137)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.AnonymousAuthenticationFilter.doFilter(AnonymousAuthenticationFilter.java:111)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter.doFilter(SecurityContextHolderAwareRequestFilter.java:158)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.savedrequest.RequestCacheAwareFilter.doFilter(RequestCacheAwareFilter.java:63)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at com.example.modules.security.security.TokenFilter.doFilter(TokenFilter.java:90)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.web.filter.CorsFilter.doFilterInternal(CorsFilter.java:92)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.logout.LogoutFilter.doFilter(LogoutFilter.java:116)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doHeadersAfter(HeaderWriterFilter.java:92)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doFilterInternal(HeaderWriterFilter.java:77)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.SecurityContextPersistenceFilter.doFilter(SecurityContextPersistenceFilter.java:105)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter.doFilterInternal(WebAsyncManagerIntegrationFilter.java:56)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.FilterChainProxy.doFilterInternal(FilterChainProxy.java:215)\r\n	at org.springframework.security.web.FilterChainProxy.doFilter(FilterChainProxy.java:178)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:358)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:271)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:201)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:202)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:97)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:541)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:143)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:78)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)\r\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:374)\r\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:65)\r\n	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:868)\r\n	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1590)\r\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\r\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\r\n	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:748)\r\n','2022-04-24 17:49:17'),
(3543,'新增用户','ERROR','com.example.modules.system.controller.UserController.createUser()','{\"gender\":\"男\",\"nickName\":\"xxx\",\"isAdmin\":false,\"enabled\":true,\"phone\":\"15044878963\",\"email\":\"33233@qq.com\",\"username\":\"xxx\"}','192.168.32.87',6,'admin','内网IP','PostmanRuntime 7.28.4','java.lang.NullPointerException\r\n	at com.example.modules.system.service.impl.RoleServiceImpl.findByRoles(RoleServiceImpl.java:158)\r\n	at com.example.modules.system.service.impl.RoleServiceImpl$$FastClassBySpringCGLIB$$dc8a47d1.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:687)\r\n	at com.example.modules.system.service.impl.RoleServiceImpl$$EnhancerBySpringCGLIB$$9cac769b.findByRoles(<generated>)\r\n	at com.example.modules.system.controller.UserController.checkLevel(UserController.java:191)\r\n	at com.example.modules.system.controller.UserController.createUser(UserController.java:106)\r\n	at com.example.modules.system.controller.UserController$$FastClassBySpringCGLIB$$3a3729d2.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.AspectJAfterThrowingAdvice.invoke(AspectJAfterThrowingAdvice.java:62)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:88)\r\n	at com.example.aspect.LogAspect.logAround(LogAspect.java:68)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:644)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:633)\r\n	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.security.access.intercept.aopalliance.MethodSecurityInterceptor.invoke(MethodSecurityInterceptor.java:69)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:95)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:691)\r\n	at com.example.modules.system.controller.UserController$$EnhancerBySpringCGLIB$$c18ababd.createUser(<generated>)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:190)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:105)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:878)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:792)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1040)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:943)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1006)\r\n	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:909)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:652)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:883)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:733)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:113)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at com.alibaba.druid.support.http.WebStatFilter.doFilter(WebStatFilter.java:124)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:320)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.invoke(FilterSecurityInterceptor.java:126)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.doFilter(FilterSecurityInterceptor.java:90)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:118)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:137)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.AnonymousAuthenticationFilter.doFilter(AnonymousAuthenticationFilter.java:111)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter.doFilter(SecurityContextHolderAwareRequestFilter.java:158)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.savedrequest.RequestCacheAwareFilter.doFilter(RequestCacheAwareFilter.java:63)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at com.example.modules.security.security.TokenFilter.doFilter(TokenFilter.java:90)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.web.filter.CorsFilter.doFilterInternal(CorsFilter.java:92)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.logout.LogoutFilter.doFilter(LogoutFilter.java:116)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doHeadersAfter(HeaderWriterFilter.java:92)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doFilterInternal(HeaderWriterFilter.java:77)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.SecurityContextPersistenceFilter.doFilter(SecurityContextPersistenceFilter.java:105)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter.doFilterInternal(WebAsyncManagerIntegrationFilter.java:56)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.FilterChainProxy.doFilterInternal(FilterChainProxy.java:215)\r\n	at org.springframework.security.web.FilterChainProxy.doFilter(FilterChainProxy.java:178)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:358)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:271)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:201)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:202)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:97)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:541)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:143)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:78)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)\r\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:374)\r\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:65)\r\n	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:868)\r\n	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1590)\r\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\r\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\r\n	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:748)\r\n','2022-04-24 17:49:31'),
(3544,'新增用户','ERROR','com.example.modules.system.controller.UserController.createUser()','{\"gender\":\"男\",\"nickName\":\"xxx\",\"isAdmin\":false,\"enabled\":true,\"password\":\"$2a$10$yT504iKWln9Oi9ETxlXYe.1emlR9hqIL.utpSTXWrx2iFW51oIyXq\",\"phone\":\"15044878963\",\"email\":\"33233@qq.com\",\"username\":\"xxx\"}','192.168.32.87',102,'admin','内网IP','PostmanRuntime 7.28.4','com.example.exception.EntityExistException: User with phone 15044878963 existed\r\n	at com.example.modules.system.service.impl.UserServiceImpl.create(UserServiceImpl.java:93)\r\n	at com.example.modules.system.service.impl.UserServiceImpl$$FastClassBySpringCGLIB$$5003e55c.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:367)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:118)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:691)\r\n	at com.example.modules.system.service.impl.UserServiceImpl$$EnhancerBySpringCGLIB$$9777835f.create(<generated>)\r\n	at com.example.modules.system.controller.UserController.createUser(UserController.java:109)\r\n	at com.example.modules.system.controller.UserController$$FastClassBySpringCGLIB$$3a3729d2.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.AspectJAfterThrowingAdvice.invoke(AspectJAfterThrowingAdvice.java:62)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:88)\r\n	at com.example.aspect.LogAspect.logAround(LogAspect.java:68)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:644)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:633)\r\n	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.security.access.intercept.aopalliance.MethodSecurityInterceptor.invoke(MethodSecurityInterceptor.java:69)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:95)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:691)\r\n	at com.example.modules.system.controller.UserController$$EnhancerBySpringCGLIB$$1e21cf61.createUser(<generated>)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:190)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:105)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:878)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:792)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1040)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:943)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1006)\r\n	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:909)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:652)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:883)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:733)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:113)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at com.alibaba.druid.support.http.WebStatFilter.doFilter(WebStatFilter.java:124)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:320)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.invoke(FilterSecurityInterceptor.java:126)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.doFilter(FilterSecurityInterceptor.java:90)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:118)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:137)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.AnonymousAuthenticationFilter.doFilter(AnonymousAuthenticationFilter.java:111)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter.doFilter(SecurityContextHolderAwareRequestFilter.java:158)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.savedrequest.RequestCacheAwareFilter.doFilter(RequestCacheAwareFilter.java:63)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at com.example.modules.security.security.TokenFilter.doFilter(TokenFilter.java:90)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.web.filter.CorsFilter.doFilterInternal(CorsFilter.java:92)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.logout.LogoutFilter.doFilter(LogoutFilter.java:116)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doHeadersAfter(HeaderWriterFilter.java:92)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doFilterInternal(HeaderWriterFilter.java:77)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.SecurityContextPersistenceFilter.doFilter(SecurityContextPersistenceFilter.java:105)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter.doFilterInternal(WebAsyncManagerIntegrationFilter.java:56)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.FilterChainProxy.doFilterInternal(FilterChainProxy.java:215)\r\n	at org.springframework.security.web.FilterChainProxy.doFilter(FilterChainProxy.java:178)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:358)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:271)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:201)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:202)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:97)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:541)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:143)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:78)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)\r\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:374)\r\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:65)\r\n	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:868)\r\n	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1590)\r\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\r\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\r\n	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:748)\r\n','2022-04-24 17:52:01'),
(3545,'新增用户','INFO','com.example.modules.system.controller.UserController.createUser()','{\"gender\":\"男\",\"nickName\":\"xxx\",\"updateTime\":1650793939421,\"isAdmin\":false,\"enabled\":true,\"password\":\"$2a$10$y6hqVUiy6YSLngBuK4v/weonLYkyuIltwG0HTUCMTuCNtnGkFsDpW\",\"createBy\":\"admin\",\"phone\":\"15044878962\",\"updateBy\":\"admin\",\"createTime\":1650793939421,\"id\":5,\"email\":\"33233@qq.com\",\"username\":\"xxx\"}','192.168.32.87',121,'admin','内网IP','PostmanRuntime 7.28.4',NULL,'2022-04-24 17:52:19'),
(3546,'新增用户','INFO','com.example.modules.system.controller.UserController.createUser()','{\"gender\":\"男\",\"nickName\":\"ssss\",\"roles\":[{\"level\":3,\"dataScope\":\"本级\",\"id\":1}],\"jobs\":[{\"id\":8}],\"updateTime\":1650873057518,\"dept\":{\"subCount\":0,\"id\":7},\"isAdmin\":false,\"enabled\":true,\"password\":\"$2a$10$P.hvDg2NaJs/kYeLn15u4upYvYxbl4HB4ExNERrU1SM5EqTQF2Hae\",\"createBy\":\"admin\",\"phone\":\"15033698785\",\"updateBy\":\"admin\",\"createTime\":1650873057518,\"id\":6,\"email\":\"sasa@qq.com\",\"username\":\"bbbb\"}','192.168.32.87',14796,'admin','内网IP','Chrome 98.0.4758.102',NULL,'2022-04-25 15:50:59'),
(3547,'修改用户','ERROR','com.example.modules.system.controller.UserController.updateUser()','{\"gender\":\"男\",\"nickName\":\"ssss\",\"roles\":[{\"level\":3,\"dataScope\":\"本级\",\"id\":2}],\"jobs\":[{\"id\":8}],\"updateTime\":1650873058000,\"dept\":{\"subCount\":0,\"name\":\"华南分部\",\"id\":7},\"isAdmin\":false,\"enabled\":true,\"createBy\":\"admin\",\"phone\":\"15033698785\",\"updateBy\":\"admin\",\"createTime\":1650873058000,\"id\":6,\"email\":\"sasa@qq.com\",\"username\":\"bbbb\"}','192.168.32.87',3,'admin','内网IP','Chrome 98.0.4758.102','org.springframework.dao.InvalidDataAccessResourceUsageException: could not extract ResultSet; SQL [n/a]; nested exception is org.hibernate.exception.SQLGrammarException: could not extract ResultSet\r\n	at org.springframework.orm.jpa.vendor.HibernateJpaDialect.convertHibernateAccessException(HibernateJpaDialect.java:281)\r\n	at org.springframework.orm.jpa.vendor.HibernateJpaDialect.translateExceptionIfPossible(HibernateJpaDialect.java:255)\r\n	at org.springframework.orm.jpa.AbstractEntityManagerFactoryBean.translateExceptionIfPossible(AbstractEntityManagerFactoryBean.java:528)\r\n	at org.springframework.dao.support.ChainedPersistenceExceptionTranslator.translateExceptionIfPossible(ChainedPersistenceExceptionTranslator.java:61)\r\n	at org.springframework.dao.support.DataAccessUtils.translateIfNecessary(DataAccessUtils.java:242)\r\n	at org.springframework.dao.support.PersistenceExceptionTranslationInterceptor.invoke(PersistenceExceptionTranslationInterceptor.java:154)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.data.jpa.repository.support.CrudMethodMetadataPostProcessor$CrudMethodMetadataPopulatingMethodInterceptor.invoke(CrudMethodMetadataPostProcessor.java:149)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:95)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.JdkDynamicAopProxy.invoke(JdkDynamicAopProxy.java:212)\r\n	at com.sun.proxy.$Proxy171.findByUserId(Unknown Source)\r\n	at com.example.modules.system.service.impl.RoleServiceImpl.findByUsersId(RoleServiceImpl.java:153)\r\n	at com.example.modules.system.service.impl.RoleServiceImpl$$FastClassBySpringCGLIB$$dc8a47d1.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:687)\r\n	at com.example.modules.system.service.impl.RoleServiceImpl$$EnhancerBySpringCGLIB$$d77f5b25.findByUsersId(<generated>)\r\n	at com.example.modules.system.controller.UserController.checkLevel(UserController.java:190)\r\n	at com.example.modules.system.controller.UserController.updateUser(UserController.java:118)\r\n	at com.example.modules.system.controller.UserController$$FastClassBySpringCGLIB$$3a3729d2.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.AspectJAfterThrowingAdvice.invoke(AspectJAfterThrowingAdvice.java:62)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:88)\r\n	at com.example.aspect.LogAspect.logAround(LogAspect.java:68)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:644)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:633)\r\n	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:95)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:691)\r\n	at com.example.modules.system.controller.UserController$$EnhancerBySpringCGLIB$$111a6b16.updateUser(<generated>)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:190)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:105)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:878)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:792)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1040)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:943)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1006)\r\n	at org.springframework.web.servlet.FrameworkServlet.doPut(FrameworkServlet.java:920)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:655)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:883)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:733)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:113)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at com.alibaba.druid.support.http.WebStatFilter.doFilter(WebStatFilter.java:124)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:320)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.invoke(FilterSecurityInterceptor.java:126)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.doFilter(FilterSecurityInterceptor.java:90)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:118)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:137)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.AnonymousAuthenticationFilter.doFilter(AnonymousAuthenticationFilter.java:111)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter.doFilter(SecurityContextHolderAwareRequestFilter.java:158)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.savedrequest.RequestCacheAwareFilter.doFilter(RequestCacheAwareFilter.java:63)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at com.example.modules.security.security.TokenFilter.doFilter(TokenFilter.java:89)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.web.filter.CorsFilter.doFilterInternal(CorsFilter.java:92)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.logout.LogoutFilter.doFilter(LogoutFilter.java:116)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doHeadersAfter(HeaderWriterFilter.java:92)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doFilterInternal(HeaderWriterFilter.java:77)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.SecurityContextPersistenceFilter.doFilter(SecurityContextPersistenceFilter.java:105)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter.doFilterInternal(WebAsyncManagerIntegrationFilter.java:56)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.FilterChainProxy.doFilterInternal(FilterChainProxy.java:215)\r\n	at org.springframework.security.web.FilterChainProxy.doFilter(FilterChainProxy.java:178)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:358)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:271)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:201)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:202)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:97)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:541)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:143)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:78)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)\r\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:374)\r\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:65)\r\n	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:868)\r\n	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1590)\r\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\r\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\r\n	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:748)\r\nCaused by: org.hibernate.exception.SQLGrammarException: could not extract ResultSet\r\n	at org.hibernate.exception.internal.SQLExceptionTypeDelegate.convert(SQLExceptionTypeDelegate.java:63)\r\n	at org.hibernate.exception.internal.StandardSQLExceptionConverter.convert(StandardSQLExceptionConverter.java:42)\r\n	at org.hibernate.engine.jdbc.spi.SqlExceptionHelper.convert(SqlExceptionHelper.java:113)\r\n	at org.hibernate.engine.jdbc.spi.SqlExceptionHelper.convert(SqlExceptionHelper.java:99)\r\n	at org.hibernate.engine.jdbc.internal.ResultSetReturnImpl.extract(ResultSetReturnImpl.java:67)\r\n	at org.hibernate.loader.Loader.getResultSet(Loader.java:2341)\r\n	at org.hibernate.loader.Loader.executeQueryStatement(Loader.java:2094)\r\n	at org.hibernate.loader.Loader.executeQueryStatement(Loader.java:2056)\r\n	at org.hibernate.loader.Loader.doQuery(Loader.java:953)\r\n	at org.hibernate.loader.Loader.doQueryAndInitializeNonLazyCollections(Loader.java:350)\r\n	at org.hibernate.loader.Loader.doList(Loader.java:2887)\r\n	at org.hibernate.loader.Loader.doList(Loader.java:2869)\r\n	at org.hibernate.loader.Loader.listIgnoreQueryCache(Loader.java:2701)\r\n	at org.hibernate.loader.Loader.list(Loader.java:2696)\r\n	at org.hibernate.loader.custom.CustomLoader.list(CustomLoader.java:338)\r\n	at org.hibernate.internal.SessionImpl.listCustomQuery(SessionImpl.java:2142)\r\n	at org.hibernate.internal.AbstractSharedSessionContract.list(AbstractSharedSessionContract.java:1163)\r\n	at org.hibernate.query.internal.NativeQueryImpl.doList(NativeQueryImpl.java:173)\r\n	at org.hibernate.query.internal.AbstractProducedQuery.list(AbstractProducedQuery.java:1533)\r\n	at org.hibernate.query.Query.getResultList(Query.java:165)\r\n	at org.springframework.data.jpa.repository.query.JpaQueryExecution$CollectionExecution.doExecute(JpaQueryExecution.java:126)\r\n	at org.springframework.data.jpa.repository.query.JpaQueryExecution.execute(JpaQueryExecution.java:88)\r\n	at org.springframework.data.jpa.repository.query.AbstractJpaQuery.doExecute(AbstractJpaQuery.java:154)\r\n	at org.springframework.data.jpa.repository.query.AbstractJpaQuery.execute(AbstractJpaQuery.java:142)\r\n	at org.springframework.data.repository.core.support.RepositoryFactorySupport$QueryExecutorMethodInterceptor.doInvoke(RepositoryFactorySupport.java:618)\r\n	at org.springframework.data.repository.core.support.RepositoryFactorySupport$QueryExecutorMethodInterceptor.invoke(RepositoryFactorySupport.java:605)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.data.projection.DefaultMethodInvokingMethodInterceptor.invoke(DefaultMethodInvokingMethodInterceptor.java:80)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:367)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:118)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.dao.support.PersistenceExceptionTranslationInterceptor.invoke(PersistenceExceptionTranslationInterceptor.java:139)\r\n	... 122 more\r\nCaused by: java.sql.SQLSyntaxErrorException: Table \'eladmin.sys_users_roles\' doesn\'t exist\r\n	at com.mysql.cj.jdbc.exceptions.SQLError.createSQLException(SQLError.java:120)\r\n	at com.mysql.cj.jdbc.exceptions.SQLError.createSQLException(SQLError.java:97)\r\n	at com.mysql.cj.jdbc.exceptions.SQLExceptionsMapping.translateException(SQLExceptionsMapping.java:122)\r\n	at com.mysql.cj.jdbc.ClientPreparedStatement.executeInternal(ClientPreparedStatement.java:953)\r\n	at com.mysql.cj.jdbc.ClientPreparedStatement.executeQuery(ClientPreparedStatement.java:1003)\r\n	at net.sf.log4jdbc.sql.jdbcapi.PreparedStatementSpy.executeQuery(PreparedStatementSpy.java:780)\r\n	at com.alibaba.druid.filter.FilterChainImpl.preparedStatement_executeQuery(FilterChainImpl.java:3240)\r\n	at com.alibaba.druid.filter.FilterEventAdapter.preparedStatement_executeQuery(FilterEventAdapter.java:465)\r\n	at com.alibaba.druid.filter.FilterChainImpl.preparedStatement_executeQuery(FilterChainImpl.java:3237)\r\n	at com.alibaba.druid.proxy.jdbc.PreparedStatementProxyImpl.executeQuery(PreparedStatementProxyImpl.java:181)\r\n	at com.alibaba.druid.pool.DruidPooledPreparedStatement.executeQuery(DruidPooledPreparedStatement.java:227)\r\n	at org.hibernate.engine.jdbc.internal.ResultSetReturnImpl.extract(ResultSetReturnImpl.java:57)\r\n	... 150 more\r\n','2022-04-25 15:56:34'),
(3548,'新增用户','ERROR','com.example.modules.system.controller.UserController.createUser()','{\"gender\":\"男\",\"nickName\":\"xxxcds\",\"roles\":[{\"level\":3,\"dataScope\":\"本级\",\"id\":1}],\"jobs\":[{\"id\":8}],\"updateTime\":1650873529243,\"dept\":{\"subCount\":0,\"id\":7},\"isAdmin\":false,\"enabled\":true,\"password\":\"$2a$10$960h5w5vd1RMOIdiBp24HO2squJKm0D0EsZN5yMbZ7SF6VJlkaihW\",\"createBy\":\"admin\",\"phone\":\"15032145698\",\"updateBy\":\"admin\",\"createTime\":1650873529243,\"id\":7,\"email\":\"66@qq.com\",\"username\":\"ghjg\"}','192.168.32.87',97,'admin','内网IP','Chrome 98.0.4758.102','org.springframework.dao.InvalidDataAccessResourceUsageException: could not execute statement; SQL [n/a]; nested exception is org.hibernate.exception.SQLGrammarException: could not execute statement\r\n	at org.springframework.orm.jpa.vendor.HibernateJpaDialect.convertHibernateAccessException(HibernateJpaDialect.java:281)\r\n	at org.springframework.orm.jpa.vendor.HibernateJpaDialect.translateExceptionIfPossible(HibernateJpaDialect.java:255)\r\n	at org.springframework.orm.jpa.JpaTransactionManager.doCommit(JpaTransactionManager.java:538)\r\n	at org.springframework.transaction.support.AbstractPlatformTransactionManager.processCommit(AbstractPlatformTransactionManager.java:743)\r\n	at org.springframework.transaction.support.AbstractPlatformTransactionManager.commit(AbstractPlatformTransactionManager.java:711)\r\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.commitTransactionAfterReturning(TransactionAspectSupport.java:633)\r\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:386)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:118)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:691)\r\n	at com.example.modules.system.service.impl.UserServiceImpl$$EnhancerBySpringCGLIB$$adc982a6.create(<generated>)\r\n	at com.example.modules.system.controller.UserController.createUser(UserController.java:109)\r\n	at com.example.modules.system.controller.UserController$$FastClassBySpringCGLIB$$3a3729d2.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.AspectJAfterThrowingAdvice.invoke(AspectJAfterThrowingAdvice.java:62)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:88)\r\n	at com.example.aspect.LogAspect.logAround(LogAspect.java:68)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:644)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:633)\r\n	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:95)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:691)\r\n	at com.example.modules.system.controller.UserController$$EnhancerBySpringCGLIB$$111a6b16.createUser(<generated>)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:190)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:105)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:878)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:792)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1040)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:943)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1006)\r\n	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:909)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:652)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:883)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:733)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:113)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at com.alibaba.druid.support.http.WebStatFilter.doFilter(WebStatFilter.java:124)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:320)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.invoke(FilterSecurityInterceptor.java:126)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.doFilter(FilterSecurityInterceptor.java:90)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:118)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:137)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.AnonymousAuthenticationFilter.doFilter(AnonymousAuthenticationFilter.java:111)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter.doFilter(SecurityContextHolderAwareRequestFilter.java:158)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.savedrequest.RequestCacheAwareFilter.doFilter(RequestCacheAwareFilter.java:63)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at com.example.modules.security.security.TokenFilter.doFilter(TokenFilter.java:89)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.web.filter.CorsFilter.doFilterInternal(CorsFilter.java:92)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.logout.LogoutFilter.doFilter(LogoutFilter.java:116)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doHeadersAfter(HeaderWriterFilter.java:92)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doFilterInternal(HeaderWriterFilter.java:77)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.SecurityContextPersistenceFilter.doFilter(SecurityContextPersistenceFilter.java:105)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter.doFilterInternal(WebAsyncManagerIntegrationFilter.java:56)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.FilterChainProxy.doFilterInternal(FilterChainProxy.java:215)\r\n	at org.springframework.security.web.FilterChainProxy.doFilter(FilterChainProxy.java:178)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:358)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:271)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:201)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:202)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:97)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:541)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:143)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:78)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)\r\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:374)\r\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:65)\r\n	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:868)\r\n	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1590)\r\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\r\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\r\n	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:748)\r\nCaused by: org.hibernate.exception.SQLGrammarException: could not execute statement\r\n	at org.hibernate.exception.internal.SQLExceptionTypeDelegate.convert(SQLExceptionTypeDelegate.java:63)\r\n	at org.hibernate.exception.internal.StandardSQLExceptionConverter.convert(StandardSQLExceptionConverter.java:42)\r\n	at org.hibernate.engine.jdbc.spi.SqlExceptionHelper.convert(SqlExceptionHelper.java:113)\r\n	at org.hibernate.engine.jdbc.spi.SqlExceptionHelper.convert(SqlExceptionHelper.java:99)\r\n	at org.hibernate.engine.jdbc.internal.ResultSetReturnImpl.executeUpdate(ResultSetReturnImpl.java:200)\r\n	at org.hibernate.engine.jdbc.batch.internal.NonBatchingBatch.addToBatch(NonBatchingBatch.java:46)\r\n	at org.hibernate.persister.collection.AbstractCollectionPersister.recreate(AbstractCollectionPersister.java:1357)\r\n	at org.hibernate.action.internal.CollectionRecreateAction.execute(CollectionRecreateAction.java:52)\r\n	at org.hibernate.engine.spi.ActionQueue.executeActions(ActionQueue.java:604)\r\n	at org.hibernate.engine.spi.ActionQueue.lambda$executeActions$1(ActionQueue.java:478)\r\n	at java.util.LinkedHashMap.forEach(LinkedHashMap.java:684)\r\n	at org.hibernate.engine.spi.ActionQueue.executeActions(ActionQueue.java:475)\r\n	at org.hibernate.event.internal.AbstractFlushingEventListener.performExecutions(AbstractFlushingEventListener.java:348)\r\n	at org.hibernate.event.internal.DefaultFlushEventListener.onFlush(DefaultFlushEventListener.java:40)\r\n	at org.hibernate.event.service.internal.EventListenerGroupImpl.fireEventOnEachListener(EventListenerGroupImpl.java:102)\r\n	at org.hibernate.internal.SessionImpl.doFlush(SessionImpl.java:1363)\r\n	at org.hibernate.internal.SessionImpl.managedFlush(SessionImpl.java:454)\r\n	at org.hibernate.internal.SessionImpl.flushBeforeTransactionCompletion(SessionImpl.java:3213)\r\n	at org.hibernate.internal.SessionImpl.beforeTransactionCompletion(SessionImpl.java:2381)\r\n	at org.hibernate.engine.jdbc.internal.JdbcCoordinatorImpl.beforeTransactionCompletion(JdbcCoordinatorImpl.java:447)\r\n	at org.hibernate.resource.transaction.backend.jdbc.internal.JdbcResourceLocalTransactionCoordinatorImpl.beforeCompletionCallback(JdbcResourceLocalTransactionCoordinatorImpl.java:183)\r\n	at org.hibernate.resource.transaction.backend.jdbc.internal.JdbcResourceLocalTransactionCoordinatorImpl.access$300(JdbcResourceLocalTransactionCoordinatorImpl.java:40)\r\n	at org.hibernate.resource.transaction.backend.jdbc.internal.JdbcResourceLocalTransactionCoordinatorImpl$TransactionDriverControlImpl.commit(JdbcResourceLocalTransactionCoordinatorImpl.java:281)\r\n	at org.hibernate.engine.transaction.internal.TransactionImpl.commit(TransactionImpl.java:101)\r\n	at org.springframework.orm.jpa.JpaTransactionManager.doCommit(JpaTransactionManager.java:534)\r\n	... 118 more\r\nCaused by: java.sql.SQLSyntaxErrorException: Table \'eladmin.sys_users_roles\' doesn\'t exist\r\n	at com.mysql.cj.jdbc.exceptions.SQLError.createSQLException(SQLError.java:120)\r\n	at com.mysql.cj.jdbc.exceptions.SQLError.createSQLException(SQLError.java:97)\r\n	at com.mysql.cj.jdbc.exceptions.SQLExceptionsMapping.translateException(SQLExceptionsMapping.java:122)\r\n	at com.mysql.cj.jdbc.ClientPreparedStatement.executeInternal(ClientPreparedStatement.java:953)\r\n	at com.mysql.cj.jdbc.ClientPreparedStatement.executeUpdateInternal(ClientPreparedStatement.java:1092)\r\n	at com.mysql.cj.jdbc.ClientPreparedStatement.executeUpdateInternal(ClientPreparedStatement.java:1040)\r\n	at com.mysql.cj.jdbc.ClientPreparedStatement.executeLargeUpdate(ClientPreparedStatement.java:1347)\r\n	at com.mysql.cj.jdbc.ClientPreparedStatement.executeUpdate(ClientPreparedStatement.java:1025)\r\n	at net.sf.log4jdbc.sql.jdbcapi.PreparedStatementSpy.executeUpdate(PreparedStatementSpy.java:1080)\r\n	at com.alibaba.druid.filter.FilterChainImpl.preparedStatement_executeUpdate(FilterChainImpl.java:3253)\r\n	at com.alibaba.druid.filter.FilterAdapter.preparedStatement_executeUpdate(FilterAdapter.java:1092)\r\n	at com.alibaba.druid.filter.FilterEventAdapter.preparedStatement_executeUpdate(FilterEventAdapter.java:491)\r\n	at com.alibaba.druid.filter.FilterChainImpl.preparedStatement_executeUpdate(FilterChainImpl.java:3251)\r\n	at com.alibaba.druid.proxy.jdbc.PreparedStatementProxyImpl.executeUpdate(PreparedStatementProxyImpl.java:194)\r\n	at com.alibaba.druid.pool.DruidPooledPreparedStatement.executeUpdate(DruidPooledPreparedStatement.java:255)\r\n	at org.hibernate.engine.jdbc.internal.ResultSetReturnImpl.executeUpdate(ResultSetReturnImpl.java:197)\r\n	... 138 more\r\n','2022-04-25 15:58:49');

/*Table structure for table `sys_menu` */

DROP TABLE IF EXISTS `sys_menu`;

CREATE TABLE `sys_menu` (
                            `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                            `pid` bigint(20) DEFAULT NULL COMMENT '上级菜单ID',
                            `sub_count` int(5) DEFAULT '0' COMMENT '子菜单数目',
                            `type` int(11) DEFAULT NULL COMMENT '菜单类型',
                            `title` varchar(255) DEFAULT NULL COMMENT '菜单标题',
                            `name` varchar(255) DEFAULT NULL COMMENT '组件名称',
                            `component` varchar(255) DEFAULT NULL COMMENT '组件',
                            `menu_sort` int(5) DEFAULT NULL COMMENT '排序',
                            `icon` varchar(255) DEFAULT NULL COMMENT '图标',
                            `path` varchar(255) DEFAULT NULL COMMENT '链接地址',
                            `i_frame` bit(1) DEFAULT NULL COMMENT '是否外链',
                            `cache` bit(1) DEFAULT b'0' COMMENT '缓存',
                            `hidden` bit(1) DEFAULT b'0' COMMENT '隐藏',
                            `permission` varchar(255) DEFAULT NULL COMMENT '权限',
                            `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
                            `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
                            `create_time` datetime DEFAULT NULL COMMENT '创建日期',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            PRIMARY KEY (`menu_id`) USING BTREE,
                            UNIQUE KEY `uniq_title` (`title`),
                            UNIQUE KEY `uniq_name` (`name`),
                            KEY `inx_pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统菜单';

/*Data for the table `sys_menu` */

INSERT INTO `sys_menu` VALUES (1, NULL, 7, 0, '系统管理', NULL, NULL, 1, 'system', 'system', b'0', b'0', b'0', NULL, NULL, NULL, '2018-12-18 15:11:29', NULL);
INSERT INTO `sys_menu` VALUES (2, 1, 3, 1, '用户管理', 'User', 'system/user/index', 2, 'peoples', 'user', b'0', b'0', b'0', 'user:list', NULL, NULL, '2018-12-18 15:14:44', NULL);
INSERT INTO `sys_menu` VALUES (3, 1, 3, 1, '角色管理', 'Role', 'system/role/index', 3, 'role', 'role', b'0', b'0', b'0', 'roles:list', NULL, NULL, '2018-12-18 15:16:07', NULL);
INSERT INTO `sys_menu` VALUES (5, 1, 3, 1, '菜单管理', 'Menu', 'system/menu/index', 5, 'menu', 'menu', b'0', b'0', b'0', 'menu:list', NULL, NULL, '2018-12-18 15:17:28', NULL);
INSERT INTO `sys_menu` VALUES (6, NULL, 5, 0, '系统监控', NULL, NULL, 10, 'monitor', 'monitor', b'0', b'0', b'0', NULL, NULL, NULL, '2018-12-18 15:17:48', NULL);
INSERT INTO `sys_menu` VALUES (7, 6, 0, 1, '操作日志', 'Log', 'monitor/log/index', 11, 'log', 'logs', b'0', b'1', b'0', NULL, NULL, 'admin', '2018-12-18 15:18:26', '2020-06-06 13:11:57');
INSERT INTO `sys_menu` VALUES (9, 6, 0, 1, 'SQL监控', 'Sql', 'monitor/sql/index', 18, 'sqlMonitor', 'druid', b'0', b'0', b'0', NULL, NULL, NULL, '2018-12-18 15:19:34', NULL);
INSERT INTO `sys_menu` VALUES (10, NULL, 5, 0, 'DNS研究', NULL, NULL, 50, 'zujian', 'components', b'0', b'0', b'0', NULL, NULL, NULL, '2018-12-19 13:38:16', NULL);
INSERT INTO `sys_menu` VALUES (11, 10, 0, 1, '清华大学-NISL', 'Icons', 'components/icons/index', 51, 'icon', 'http://netsec.ccert.edu.cn/chs/', b'1', b'0', b'0', NULL, NULL, NULL, '2018-12-19 13:38:49', NULL);
INSERT INTO `sys_menu` VALUES (14, 36, 0, 1, 'DNS审查', 'Email', 'tools/email/index', 32, 'email', 'email', b'0', b'0', b'0', NULL, NULL, NULL, '2018-12-27 10:13:09', NULL);
INSERT INTO `sys_menu` VALUES (15, 10, 0, 1, 'APNIC', 'Editor', 'components/Editor', 52, 'fwb', 'https://blog.apnic.net/', b'1', b'0', b'0', NULL, NULL, NULL, '2018-12-27 11:58:25', NULL);
INSERT INTO `sys_menu` VALUES (18, 36, 0, 1, 'DNS威胁', 'Storage', 'tools/storage/index', 34, 'qiniu', 'storage', b'0', b'0', b'0', 'storage:list', NULL, NULL, '2018-12-31 11:12:15', NULL);
INSERT INTO `sys_menu` VALUES (19, 36, 0, 1, 'DNS集中性', 'AliPay', 'tools/aliPay/index', 35, 'alipay', 'aliPay', b'0', b'0', b'0', NULL, NULL, NULL, '2018-12-31 14:52:38', NULL);
INSERT INTO `sys_menu` VALUES (21, NULL, 1, 0, '关于', NULL, '', 900, 'menu', 'nested', b'0', b'0', b'0', NULL, NULL, 'admin', '2019-01-04 16:22:03', '2020-06-21 17:27:35');
INSERT INTO `sys_menu` VALUES (22, 21, 0, 1, '二级菜单1', '', 'nested/menu2/index', 999, 'menu', 'menu2-1', b'0', b'0', b'1', NULL, NULL, 'admin', '2019-01-04 16:23:29', '2020-06-21 17:27:20');
INSERT INTO `sys_menu` VALUES (23, 21, 0, 1, 'MESA', NULL, 'nested/menu2/index', 999, 'menu', 'https://www.mesalab.cn/', b'1', b'0', b'0', NULL, NULL, NULL, '2019-01-04 16:23:57', NULL);
INSERT INTO `sys_menu` VALUES (24, 22, 0, 1, '三级菜单1', 'Test', 'nested/menu1/menu1-1', 999, 'menu', 'menu1-1', b'0', b'0', b'1', NULL, NULL, NULL, '2019-01-04 16:24:48', NULL);
INSERT INTO `sys_menu` VALUES (27, 22, 0, 1, '三级菜单2', NULL, 'nested/menu1/menu1-2', 999, 'menu', 'menu1-2', b'0', b'0', b'1', NULL, NULL, NULL, '2019-01-07 17:27:32', NULL);
INSERT INTO `sys_menu` VALUES (28, 1, 3, 1, '任务调度', 'Timing', 'system/timing/index', 999, 'timing', 'timing', b'0', b'0', b'0', 'timing:list', NULL, NULL, '2019-01-07 20:34:40', NULL);
INSERT INTO `sys_menu` VALUES (30, 36, 0, 1, '新型DNS协议', 'GeneratorIndex', 'generator/index', 37, 'dev', 'generator', b'0', b'1', b'0', NULL, NULL, NULL, '2019-01-11 15:45:55', NULL);
INSERT INTO `sys_menu` VALUES (32, 6, 0, 1, '异常日志', 'ErrorLog', 'monitor/log/errorLog', 12, 'error', 'errorLog', b'0', b'0', b'0', NULL, NULL, NULL, '2019-01-13 13:49:03', NULL);
INSERT INTO `sys_menu` VALUES (33, 10, 0, 1, '南加州大学-ANT Lab', 'Markdown', 'components/MarkDown', 53, 'markdown', 'https://ant.isi.edu/', b'1', b'0', b'0', NULL, NULL, NULL, '2019-03-08 13:46:44', NULL);
INSERT INTO `sys_menu` VALUES (34, 10, 0, 1, '普林斯顿大学-Noise Lab', 'YamlEdit', 'components/YamlEdit', 54, 'dev', 'https://noise.cs.uchicago.edu/security.html', b'1', b'0', b'0', NULL, NULL, NULL, '2019-03-08 15:49:40', NULL);
INSERT INTO `sys_menu` VALUES (35, 1, 3, 1, '部门管理', 'Dept', 'system/dept/index', 6, 'dept', 'dept', b'0', b'0', b'0', 'dept:list', NULL, NULL, '2019-03-25 09:46:00', NULL);
INSERT INTO `sys_menu` VALUES (36, NULL, 7, 0, '专题报告', NULL, '', 30, 'sys-tools', 'sys-tools', b'0', b'0', b'0', NULL, NULL, NULL, '2019-03-29 10:57:35', NULL);
INSERT INTO `sys_menu` VALUES (37, 1, 3, 1, '岗位管理', 'Job', 'system/job/index', 7, 'Steve-Jobs', 'job', b'0', b'0', b'0', 'job:list', NULL, NULL, '2019-03-29 13:51:18', NULL);
INSERT INTO `sys_menu` VALUES (38, 36, 0, 1, '接口文档', 'Swagger', 'tools/swagger/index', 36, 'swagger', 'swagger2', b'0', b'0', b'1', NULL, NULL, NULL, '2019-03-29 19:57:53', NULL);
INSERT INTO `sys_menu` VALUES (39, 1, 3, 1, '字典管理', 'Dict', 'system/dict/index', 8, 'dictionary', 'dict', b'0', b'0', b'0', 'dict:list', NULL, NULL, '2019-04-10 11:49:04', NULL);
INSERT INTO `sys_menu` VALUES (41, 6, 0, 1, '在线用户', 'OnlineUser', 'monitor/online/index', 10, 'Steve-Jobs', 'online', b'0', b'0', b'0', NULL, NULL, NULL, '2019-10-26 22:08:43', NULL);
INSERT INTO `sys_menu` VALUES (44, 2, 0, 2, '用户新增', NULL, '', 2, '', '', b'0', b'0', b'0', 'user:add', NULL, NULL, '2019-10-29 10:59:46', NULL);
INSERT INTO `sys_menu` VALUES (45, 2, 0, 2, '用户编辑', NULL, '', 3, '', '', b'0', b'0', b'0', 'user:edit', NULL, NULL, '2019-10-29 11:00:08', NULL);
INSERT INTO `sys_menu` VALUES (46, 2, 0, 2, '用户删除', NULL, '', 4, '', '', b'0', b'0', b'0', 'user:del', NULL, NULL, '2019-10-29 11:00:23', NULL);
INSERT INTO `sys_menu` VALUES (48, 3, 0, 2, '角色创建', NULL, '', 2, '', '', b'0', b'0', b'0', 'roles:add', NULL, NULL, '2019-10-29 12:45:34', NULL);
INSERT INTO `sys_menu` VALUES (49, 3, 0, 2, '角色修改', NULL, '', 3, '', '', b'0', b'0', b'0', 'roles:edit', NULL, NULL, '2019-10-29 12:46:16', NULL);
INSERT INTO `sys_menu` VALUES (50, 3, 0, 2, '角色删除', NULL, '', 4, '', '', b'0', b'0', b'0', 'roles:del', NULL, NULL, '2019-10-29 12:46:51', NULL);
INSERT INTO `sys_menu` VALUES (52, 5, 0, 2, '菜单新增', NULL, '', 2, '', '', b'0', b'0', b'0', 'menu:add', NULL, NULL, '2019-10-29 12:55:07', NULL);
INSERT INTO `sys_menu` VALUES (53, 5, 0, 2, '菜单编辑', NULL, '', 3, '', '', b'0', b'0', b'0', 'menu:edit', NULL, NULL, '2019-10-29 12:55:40', NULL);
INSERT INTO `sys_menu` VALUES (54, 5, 0, 2, '菜单删除', NULL, '', 4, '', '', b'0', b'0', b'0', 'menu:del', NULL, NULL, '2019-10-29 12:56:00', NULL);
INSERT INTO `sys_menu` VALUES (56, 35, 0, 2, '部门新增', NULL, '', 2, '', '', b'0', b'0', b'0', 'dept:add', NULL, NULL, '2019-10-29 12:57:09', NULL);
INSERT INTO `sys_menu` VALUES (57, 35, 0, 2, '部门编辑', NULL, '', 3, '', '', b'0', b'0', b'0', 'dept:edit', NULL, NULL, '2019-10-29 12:57:27', NULL);
INSERT INTO `sys_menu` VALUES (58, 35, 0, 2, '部门删除', NULL, '', 4, '', '', b'0', b'0', b'0', 'dept:del', NULL, NULL, '2019-10-29 12:57:41', NULL);
INSERT INTO `sys_menu` VALUES (60, 37, 0, 2, '岗位新增', NULL, '', 2, '', '', b'0', b'0', b'0', 'job:add', NULL, NULL, '2019-10-29 12:58:27', NULL);
INSERT INTO `sys_menu` VALUES (61, 37, 0, 2, '岗位编辑', NULL, '', 3, '', '', b'0', b'0', b'0', 'job:edit', NULL, NULL, '2019-10-29 12:58:45', NULL);
INSERT INTO `sys_menu` VALUES (62, 37, 0, 2, '岗位删除', NULL, '', 4, '', '', b'0', b'0', b'0', 'job:del', NULL, NULL, '2019-10-29 12:59:04', NULL);
INSERT INTO `sys_menu` VALUES (64, 39, 0, 2, '字典新增', NULL, '', 2, '', '', b'0', b'0', b'0', 'dict:add', NULL, NULL, '2019-10-29 13:00:17', NULL);
INSERT INTO `sys_menu` VALUES (65, 39, 0, 2, '字典编辑', NULL, '', 3, '', '', b'0', b'0', b'0', 'dict:edit', NULL, NULL, '2019-10-29 13:00:42', NULL);
INSERT INTO `sys_menu` VALUES (66, 39, 0, 2, '字典删除', NULL, '', 4, '', '', b'0', b'0', b'0', 'dict:del', NULL, NULL, '2019-10-29 13:00:59', NULL);
INSERT INTO `sys_menu` VALUES (73, 28, 0, 2, '任务新增', NULL, '', 2, '', '', b'0', b'0', b'0', 'timing:add', NULL, NULL, '2019-10-29 13:07:28', NULL);
INSERT INTO `sys_menu` VALUES (74, 28, 0, 2, '任务编辑', NULL, '', 3, '', '', b'0', b'0', b'0', 'timing:edit', NULL, NULL, '2019-10-29 13:07:41', NULL);
INSERT INTO `sys_menu` VALUES (75, 28, 0, 2, '任务删除', NULL, '', 4, '', '', b'0', b'0', b'0', 'timing:del', NULL, NULL, '2019-10-29 13:07:54', NULL);
INSERT INTO `sys_menu` VALUES (77, 18, 0, 2, '上传文件', NULL, '', 2, '', '', b'0', b'0', b'0', 'storage:add', NULL, NULL, '2019-10-29 13:09:09', NULL);
INSERT INTO `sys_menu` VALUES (78, 18, 0, 2, '文件编辑', NULL, '', 3, '', '', b'0', b'0', b'0', 'storage:edit', NULL, NULL, '2019-10-29 13:09:22', NULL);
INSERT INTO `sys_menu` VALUES (79, 18, 0, 2, '文件删除', NULL, '', 4, '', '', b'0', b'0', b'0', 'storage:del', NULL, NULL, '2019-10-29 13:09:34', NULL);
INSERT INTO `sys_menu` VALUES (80, 6, 0, 1, '服务监控', 'ServerMonitor', 'monitor/server/index', 14, 'codeConsole', 'server', b'0', b'0', b'0', 'monitor:list', NULL, 'admin', '2019-11-07 13:06:39', '2020-05-04 18:20:50');
INSERT INTO `sys_menu` VALUES (82, 36, 0, 1, '生成配置', 'GeneratorConfig', 'generator/config', 33, 'dev', 'generator/config/:tableName', b'0', b'1', b'1', '', NULL, NULL, '2019-11-17 20:08:56', NULL);
INSERT INTO `sys_menu` VALUES (83, 10, 0, 1, '图表库', 'Echarts', 'components/Echarts', 50, 'chart', 'echarts', b'0', b'1', b'1', '', NULL, NULL, '2019-11-21 09:04:32', NULL);
INSERT INTO `sys_menu` VALUES (102, 97, 0, 2, '删除', NULL, '', 999, '', '', b'0', b'0', b'0', 'deployHistory:del', NULL, NULL, '2019-11-17 09:32:48', NULL);
INSERT INTO `sys_menu` VALUES (103, 92, 0, 2, '服务器新增', NULL, '', 999, '', '', b'0', b'0', b'0', 'serverDeploy:add', NULL, NULL, '2019-11-17 11:08:33', NULL);
INSERT INTO `sys_menu` VALUES (104, 92, 0, 2, '服务器编辑', NULL, '', 999, '', '', b'0', b'0', b'0', 'serverDeploy:edit', NULL, NULL, '2019-11-17 11:08:57', NULL);
INSERT INTO `sys_menu` VALUES (105, 92, 0, 2, '服务器删除', NULL, '', 999, '', '', b'0', b'0', b'0', 'serverDeploy:del', NULL, NULL, '2019-11-17 11:09:15', NULL);
INSERT INTO `sys_menu` VALUES (106, 93, 0, 2, '应用新增', NULL, '', 999, '', '', b'0', b'0', b'0', 'app:add', NULL, NULL, '2019-11-17 11:10:03', NULL);
INSERT INTO `sys_menu` VALUES (107, 93, 0, 2, '应用编辑', NULL, '', 999, '', '', b'0', b'0', b'0', 'app:edit', NULL, NULL, '2019-11-17 11:10:28', NULL);
INSERT INTO `sys_menu` VALUES (108, 93, 0, 2, '应用删除', NULL, '', 999, '', '', b'0', b'0', b'0', 'app:del', NULL, NULL, '2019-11-17 11:10:55', NULL);
INSERT INTO `sys_menu` VALUES (109, 94, 0, 2, '部署新增', NULL, '', 999, '', '', b'0', b'0', b'0', 'deploy:add', NULL, NULL, '2019-11-17 11:11:22', NULL);
INSERT INTO `sys_menu` VALUES (110, 94, 0, 2, '部署编辑', NULL, '', 999, '', '', b'0', b'0', b'0', 'deploy:edit', NULL, NULL, '2019-11-17 11:11:41', NULL);
INSERT INTO `sys_menu` VALUES (111, 94, 0, 2, '部署删除', NULL, '', 999, '', '', b'0', b'0', b'0', 'deploy:del', NULL, NULL, '2019-11-17 11:12:01', NULL);
INSERT INTO `sys_menu` VALUES (112, 98, 0, 2, '数据库新增', NULL, '', 999, '', '', b'0', b'0', b'0', 'database:add', NULL, NULL, '2019-11-17 11:12:43', NULL);
INSERT INTO `sys_menu` VALUES (113, 98, 0, 2, '数据库编辑', NULL, '', 999, '', '', b'0', b'0', b'0', 'database:edit', NULL, NULL, '2019-11-17 11:12:58', NULL);
INSERT INTO `sys_menu` VALUES (114, 98, 0, 2, '数据库删除', NULL, '', 999, '', '', b'0', b'0', b'0', 'database:del', NULL, NULL, '2019-11-17 11:13:14', NULL);
INSERT INTO `sys_menu` VALUES (116, 36, 0, 1, '生成预览', 'Preview', 'generator/preview', 999, 'java', 'generator/preview/:tableName', b'0', b'1', b'1', NULL, NULL, NULL, '2019-11-26 14:54:36', NULL);

/*Table structure for table `sys_quartz_job` */

DROP TABLE IF EXISTS `sys_quartz_job`;

CREATE TABLE `sys_quartz_job` (
                                  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                                  `bean_name` varchar(255) DEFAULT NULL COMMENT 'Spring Bean名称',
                                  `cron_expression` varchar(255) DEFAULT NULL COMMENT 'cron 表达式',
                                  `is_pause` bit(1) DEFAULT NULL COMMENT '状态：1暂停、0启用',
                                  `job_name` varchar(255) DEFAULT NULL COMMENT '任务名称',
                                  `method_name` varchar(255) DEFAULT NULL COMMENT '方法名称',
                                  `params` varchar(255) DEFAULT NULL COMMENT '参数',
                                  `description` varchar(255) DEFAULT NULL COMMENT '备注',
                                  `person_in_charge` varchar(100) DEFAULT NULL COMMENT '负责人',
                                  `email` varchar(100) DEFAULT NULL COMMENT '报警邮箱',
                                  `sub_task` varchar(100) DEFAULT NULL COMMENT '子任务ID',
                                  `pause_after_failure` bit(1) DEFAULT NULL COMMENT '任务失败后是否暂停',
                                  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
                                  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
                                  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
                                  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                  PRIMARY KEY (`job_id`) USING BTREE,
                                  KEY `inx_is_pause` (`is_pause`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='定时任务';

/*Data for the table `sys_quartz_job` */

insert  into `sys_quartz_job`(`job_id`,`bean_name`,`cron_expression`,`is_pause`,`job_name`,`method_name`,`params`,`description`,`person_in_charge`,`email`,`sub_task`,`pause_after_failure`,`create_by`,`update_by`,`create_time`,`update_time`) values
(2,'testTask','0/5 * * * * ?','','测试1','run1','test','带参测试，多参使用json','测试',NULL,NULL,NULL,NULL,'admin','2019-08-22 14:08:29','2020-05-24 13:58:33'),
(3,'testTask','0/5 * * * * ?','','测试','run','','不带参测试','Zheng Jie','','5,6','',NULL,'admin','2019-09-26 16:44:39','2020-05-24 14:48:12'),
(5,'Test','0/5 * * * * ?','','任务告警测试','run',NULL,'测试','test','',NULL,'','admin','admin','2020-05-05 20:32:41','2020-05-05 20:36:13'),
(6,'testTask','0/5 * * * * ?','','测试3','run2',NULL,'测试3','Zheng Jie','',NULL,'','admin','admin','2020-05-05 20:35:41','2020-05-05 20:36:07');

/*Table structure for table `sys_quartz_log` */

DROP TABLE IF EXISTS `sys_quartz_log`;

CREATE TABLE `sys_quartz_log` (
                                  `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                                  `bean_name` varchar(255) DEFAULT NULL,
                                  `create_time` datetime DEFAULT NULL,
                                  `cron_expression` varchar(255) DEFAULT NULL,
                                  `exception_detail` text,
                                  `is_success` bit(1) DEFAULT NULL,
                                  `job_name` varchar(255) DEFAULT NULL,
                                  `method_name` varchar(255) DEFAULT NULL,
                                  `params` varchar(255) DEFAULT NULL,
                                  `time` bigint(20) DEFAULT NULL,
                                  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='定时任务日志';

/*Data for the table `sys_quartz_log` */

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
                            `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                            `name` varchar(255) NOT NULL COMMENT '名称',
                            `level` int(255) DEFAULT NULL COMMENT '角色级别',
                            `description` varchar(255) DEFAULT NULL COMMENT '描述',
                            `data_scope` varchar(255) DEFAULT NULL COMMENT '数据权限',
                            `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
                            `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
                            `create_time` datetime DEFAULT NULL COMMENT '创建日期',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            PRIMARY KEY (`role_id`) USING BTREE,
                            UNIQUE KEY `uniq_name` (`name`),
                            KEY `role_name_index` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='角色表';

/*Data for the table `sys_role` */

INSERT INTO `sys_role` VALUES (1, '超级管理员', 1, '-', '全部', NULL, 'admin', '2018-11-23 11:04:37', '2022-06-13 11:18:51');
INSERT INTO `sys_role` VALUES (2, '普通用户', 2, '-', '本级', NULL, 'admin', '2018-11-23 13:09:06', '2020-09-05 10:45:12');
INSERT INTO `sys_role` VALUES (3, '系统管理员', 1, '系统菜单，监控，用户，部门等系统信息管理员', '全部', 'admin', 'sysadmin', '2022-06-13 11:17:59', '2022-06-13 11:36:44');

/*Table structure for table `sys_roles_depts` */

DROP TABLE IF EXISTS `sys_roles_depts`;

CREATE TABLE `sys_roles_depts` (
                                   `role_id` bigint(20) NOT NULL,
                                   `dept_id` bigint(20) NOT NULL,
                                   PRIMARY KEY (`role_id`,`dept_id`) USING BTREE,
                                   KEY `FK7qg6itn5ajdoa9h9o78v9ksur` (`dept_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='角色部门关联';

/*Data for the table `sys_roles_depts` */

/*Table structure for table `sys_roles_menus` */

DROP TABLE IF EXISTS `sys_roles_menus`;

CREATE TABLE `sys_roles_menus` (
                                   `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
                                   `role_id` bigint(20) NOT NULL COMMENT '角色ID',
                                   PRIMARY KEY (`menu_id`,`role_id`) USING BTREE,
                                   KEY `FKcngg2qadojhi3a651a5adkvbq` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='角色菜单关联';

/*Data for the table `sys_roles_menus` */

INSERT INTO `sys_roles_menus` VALUES (1, 2);
INSERT INTO `sys_roles_menus` VALUES (1, 3);
INSERT INTO `sys_roles_menus` VALUES (2, 2);
INSERT INTO `sys_roles_menus` VALUES (2, 3);
INSERT INTO `sys_roles_menus` VALUES (3, 3);
INSERT INTO `sys_roles_menus` VALUES (5, 3);
INSERT INTO `sys_roles_menus` VALUES (6, 1);
INSERT INTO `sys_roles_menus` VALUES (6, 2);
INSERT INTO `sys_roles_menus` VALUES (6, 3);
INSERT INTO `sys_roles_menus` VALUES (7, 1);
INSERT INTO `sys_roles_menus` VALUES (7, 2);
INSERT INTO `sys_roles_menus` VALUES (7, 3);
INSERT INTO `sys_roles_menus` VALUES (9, 1);
INSERT INTO `sys_roles_menus` VALUES (9, 2);
INSERT INTO `sys_roles_menus` VALUES (9, 3);
INSERT INTO `sys_roles_menus` VALUES (10, 1);
INSERT INTO `sys_roles_menus` VALUES (10, 2);
INSERT INTO `sys_roles_menus` VALUES (11, 1);
INSERT INTO `sys_roles_menus` VALUES (11, 2);
INSERT INTO `sys_roles_menus` VALUES (14, 1);
INSERT INTO `sys_roles_menus` VALUES (14, 2);
INSERT INTO `sys_roles_menus` VALUES (15, 1);
INSERT INTO `sys_roles_menus` VALUES (15, 2);
INSERT INTO `sys_roles_menus` VALUES (18, 1);
INSERT INTO `sys_roles_menus` VALUES (19, 1);
INSERT INTO `sys_roles_menus` VALUES (19, 2);
INSERT INTO `sys_roles_menus` VALUES (21, 1);
INSERT INTO `sys_roles_menus` VALUES (21, 2);
INSERT INTO `sys_roles_menus` VALUES (22, 1);
INSERT INTO `sys_roles_menus` VALUES (22, 2);
INSERT INTO `sys_roles_menus` VALUES (23, 1);
INSERT INTO `sys_roles_menus` VALUES (23, 2);
INSERT INTO `sys_roles_menus` VALUES (24, 1);
INSERT INTO `sys_roles_menus` VALUES (24, 2);
INSERT INTO `sys_roles_menus` VALUES (27, 1);
INSERT INTO `sys_roles_menus` VALUES (27, 2);
INSERT INTO `sys_roles_menus` VALUES (28, 3);
INSERT INTO `sys_roles_menus` VALUES (30, 1);
INSERT INTO `sys_roles_menus` VALUES (30, 2);
INSERT INTO `sys_roles_menus` VALUES (32, 1);
INSERT INTO `sys_roles_menus` VALUES (32, 2);
INSERT INTO `sys_roles_menus` VALUES (32, 3);
INSERT INTO `sys_roles_menus` VALUES (33, 1);
INSERT INTO `sys_roles_menus` VALUES (33, 2);
INSERT INTO `sys_roles_menus` VALUES (34, 1);
INSERT INTO `sys_roles_menus` VALUES (34, 2);
INSERT INTO `sys_roles_menus` VALUES (35, 3);
INSERT INTO `sys_roles_menus` VALUES (36, 1);
INSERT INTO `sys_roles_menus` VALUES (36, 2);
INSERT INTO `sys_roles_menus` VALUES (37, 3);
INSERT INTO `sys_roles_menus` VALUES (38, 1);
INSERT INTO `sys_roles_menus` VALUES (39, 3);
INSERT INTO `sys_roles_menus` VALUES (41, 1);
INSERT INTO `sys_roles_menus` VALUES (41, 3);
INSERT INTO `sys_roles_menus` VALUES (44, 3);
INSERT INTO `sys_roles_menus` VALUES (45, 3);
INSERT INTO `sys_roles_menus` VALUES (46, 3);
INSERT INTO `sys_roles_menus` VALUES (48, 3);
INSERT INTO `sys_roles_menus` VALUES (49, 3);
INSERT INTO `sys_roles_menus` VALUES (50, 3);
INSERT INTO `sys_roles_menus` VALUES (52, 3);
INSERT INTO `sys_roles_menus` VALUES (53, 3);
INSERT INTO `sys_roles_menus` VALUES (54, 3);
INSERT INTO `sys_roles_menus` VALUES (56, 3);
INSERT INTO `sys_roles_menus` VALUES (57, 3);
INSERT INTO `sys_roles_menus` VALUES (58, 3);
INSERT INTO `sys_roles_menus` VALUES (60, 3);
INSERT INTO `sys_roles_menus` VALUES (61, 3);
INSERT INTO `sys_roles_menus` VALUES (62, 3);
INSERT INTO `sys_roles_menus` VALUES (64, 3);
INSERT INTO `sys_roles_menus` VALUES (65, 3);
INSERT INTO `sys_roles_menus` VALUES (66, 3);
INSERT INTO `sys_roles_menus` VALUES (73, 3);
INSERT INTO `sys_roles_menus` VALUES (74, 3);
INSERT INTO `sys_roles_menus` VALUES (75, 3);
INSERT INTO `sys_roles_menus` VALUES (77, 1);
INSERT INTO `sys_roles_menus` VALUES (78, 1);
INSERT INTO `sys_roles_menus` VALUES (79, 1);
INSERT INTO `sys_roles_menus` VALUES (80, 1);
INSERT INTO `sys_roles_menus` VALUES (80, 2);
INSERT INTO `sys_roles_menus` VALUES (80, 3);
INSERT INTO `sys_roles_menus` VALUES (82, 1);
INSERT INTO `sys_roles_menus` VALUES (82, 2);
INSERT INTO `sys_roles_menus` VALUES (83, 1);
INSERT INTO `sys_roles_menus` VALUES (83, 2);
INSERT INTO `sys_roles_menus` VALUES (90, 1);
INSERT INTO `sys_roles_menus` VALUES (92, 1);
INSERT INTO `sys_roles_menus` VALUES (93, 1);
INSERT INTO `sys_roles_menus` VALUES (94, 1);
INSERT INTO `sys_roles_menus` VALUES (97, 1);
INSERT INTO `sys_roles_menus` VALUES (98, 1);
INSERT INTO `sys_roles_menus` VALUES (102, 1);
INSERT INTO `sys_roles_menus` VALUES (103, 1);
INSERT INTO `sys_roles_menus` VALUES (104, 1);
INSERT INTO `sys_roles_menus` VALUES (105, 1);
INSERT INTO `sys_roles_menus` VALUES (106, 1);
INSERT INTO `sys_roles_menus` VALUES (107, 1);
INSERT INTO `sys_roles_menus` VALUES (108, 1);
INSERT INTO `sys_roles_menus` VALUES (109, 1);
INSERT INTO `sys_roles_menus` VALUES (110, 1);
INSERT INTO `sys_roles_menus` VALUES (111, 1);
INSERT INTO `sys_roles_menus` VALUES (112, 1);
INSERT INTO `sys_roles_menus` VALUES (113, 1);
INSERT INTO `sys_roles_menus` VALUES (114, 1);
INSERT INTO `sys_roles_menus` VALUES (116, 1);
INSERT INTO `sys_roles_menus` VALUES (116, 2);
INSERT INTO `sys_roles_menus` VALUES (120, 1);

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
                            `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                            `dept_id` bigint(20) DEFAULT NULL COMMENT '部门名称',
                            `username` varchar(255) DEFAULT NULL COMMENT '用户名',
                            `nick_name` varchar(255) DEFAULT NULL COMMENT '昵称',
                            `gender` varchar(2) DEFAULT NULL COMMENT '性别',
                            `phone` varchar(255) DEFAULT NULL COMMENT '手机号码',
                            `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
                            `avatar_name` varchar(255) DEFAULT NULL COMMENT '头像地址',
                            `avatar_path` varchar(255) DEFAULT NULL COMMENT '头像真实路径',
                            `password` varchar(255) DEFAULT NULL COMMENT '密码',
                            `is_admin` bit(1) DEFAULT b'0' COMMENT '是否为admin账号',
                            `enabled` bigint(20) DEFAULT NULL COMMENT '状态：1启用、0禁用',
                            `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
                            `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
                            `pwd_reset_time` datetime DEFAULT NULL COMMENT '修改密码的时间',
                            `create_time` datetime DEFAULT NULL COMMENT '创建日期',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            PRIMARY KEY (`user_id`) USING BTREE,
                            UNIQUE KEY `UK_kpubos9gc2cvtkb0thktkbkes` (`email`) USING BTREE,
                            UNIQUE KEY `username` (`username`) USING BTREE,
                            UNIQUE KEY `uniq_username` (`username`),
                            UNIQUE KEY `uniq_email` (`email`),
                            KEY `FK5rwmryny6jthaaxkogownknqp` (`dept_id`) USING BTREE,
                            KEY `FKpq2dhypk2qgt68nauh2by22jb` (`avatar_name`) USING BTREE,
                            KEY `inx_enabled` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统用户';

/*Data for the table `sys_user` */

INSERT INTO `sys_user` VALUES (1, 2, 'admin', '管理员', '男', '18888888888', '201507802@qq.com', 'avatar-20200806032259161.png', '/Users/jie/Documents/work/me/admin/eladmin/~/avatar/avatar-20200806032259161.png', '$2a$10$Egp1/gvFlt7zhlXVfEFw4OfWQCGPw0ClmMcc6FjTnvXNRVf9zdMRa', b'1', 1, NULL, 'admin', '2020-05-03 16:38:31', '2018-08-23 09:11:56', '2022-04-24 17:03:00');
INSERT INTO `sys_user` VALUES (2, 2, 'test', '测试', '男', '19999999999', '231@qq.com', NULL, NULL, '$2a$10$4XcyudOYTSz6fue6KFNMHeUQnCX5jbBQypLEnGk1PmekXt5c95JcK', b'0', 1, 'admin', 'admin', NULL, '2020-05-05 11:15:49', '2022-04-24 11:18:18');
INSERT INTO `sys_user` VALUES (3, 8, 'test2', 'aaa', '男', '15014236547', '22@qq.com', NULL, NULL, '$2a$10$39eu19DlibPMfC9EEPPErO86uBAZhCzySlhvSn/Evg0gdInNeNB3W', b'0', 1, 'admin', 'admin', NULL, '2022-04-24 16:51:41', '2022-04-24 16:51:41');
INSERT INTO `sys_user` VALUES (4, 7, 'xx', 'xx', '男', '15044878963', '3333@qq.com', NULL, NULL, '$2a$10$NGkgAoFjWGUueMJ81409I.mAJXa2KHf9b9GwgWZOCN8TdL35lLigy', b'0', 1, 'admin', 'admin', NULL, '2022-04-24 17:47:01', '2022-04-24 17:47:01');
INSERT INTO `sys_user` VALUES (5, NULL, 'xxx', 'xxx', '男', '15044878962', '33233@qq.com', NULL, NULL, '$2a$10$y6hqVUiy6YSLngBuK4v/weonLYkyuIltwG0HTUCMTuCNtnGkFsDpW', b'0', 1, 'admin', 'admin', NULL, '2022-04-24 17:52:19', '2022-04-24 17:52:19');
INSERT INTO `sys_user` VALUES (6, 7, 'bbbb', 'ssss', '男', '15033698785', 'sasa@qq.com', NULL, NULL, '$2a$10$P.hvDg2NaJs/kYeLn15u4upYvYxbl4HB4ExNERrU1SM5EqTQF2Hae', b'0', 1, 'admin', 'admin', NULL, '2022-04-25 15:50:58', '2022-04-25 15:50:58');
INSERT INTO `sys_user` VALUES (7, 5, 'sysadmin', 'sysadmin', '男', '18765432100', '18765432100@qq.com', NULL, NULL, '$2a$10$Wp0dKiYZpAgNap.0NhK40.LEd2AgDTFC.i/unDcRPmICf9JMEcYzC', b'0', 1, 'admin', 'admin', NULL, '2022-06-13 11:20:03', '2022-06-13 11:20:03');

/*Table structure for table `sys_users_jobs` */

DROP TABLE IF EXISTS `sys_users_jobs`;

CREATE TABLE `sys_users_jobs` (
                                  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
                                  `job_id` bigint(20) NOT NULL COMMENT '岗位ID',
                                  PRIMARY KEY (`user_id`,`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_users_jobs` */

insert  into `sys_users_jobs`(`user_id`,`job_id`) values
(1,11),
(2,12),
(3,8),
(4,8),
(6,8);

/*Table structure for table `sys_users_roles` */

DROP TABLE IF EXISTS `sys_users_roles`;

CREATE TABLE `sys_users_roles` (
                                   `user_id` bigint(20) NOT NULL COMMENT '用户ID',
                                   `role_id` bigint(20) NOT NULL COMMENT '角色ID',
                                   PRIMARY KEY (`user_id`,`role_id`) USING BTREE,
                                   KEY `FKq4eq273l04bpu4efj0jd0jb98` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户角色关联';

/*Data for the table `sys_users_roles` */

insert  into `sys_users_roles`(`user_id`,`role_id`) values
(1,1),
(6,1),
(2,2),
(3,2),
(4,2);

/*Table structure for table `tool_alipay_config` */

DROP TABLE IF EXISTS `tool_alipay_config`;

CREATE TABLE `tool_alipay_config` (
                                      `config_id` bigint(20) NOT NULL COMMENT 'ID',
                                      `app_id` varchar(255) DEFAULT NULL COMMENT '应用ID',
                                      `charset` varchar(255) DEFAULT NULL COMMENT '编码',
                                      `format` varchar(255) DEFAULT NULL COMMENT '类型 固定格式json',
                                      `gateway_url` varchar(255) DEFAULT NULL COMMENT '网关地址',
                                      `notify_url` varchar(255) DEFAULT NULL COMMENT '异步回调',
                                      `private_key` text COMMENT '私钥',
                                      `public_key` text COMMENT '公钥',
                                      `return_url` varchar(255) DEFAULT NULL COMMENT '回调地址',
                                      `sign_type` varchar(255) DEFAULT NULL COMMENT '签名方式',
                                      `sys_service_provider_id` varchar(255) DEFAULT NULL COMMENT '商户号',
                                      PRIMARY KEY (`config_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='支付宝配置类';

/*Data for the table `tool_alipay_config` */

insert  into `tool_alipay_config`(`config_id`,`app_id`,`charset`,`format`,`gateway_url`,`notify_url`,`private_key`,`public_key`,`return_url`,`sign_type`,`sys_service_provider_id`) values
(1,'2016091700532697','utf-8','JSON','https://openapi.alipaydev.com/gateway.do','http://api.auauz.net/api/aliPay/notify','MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC5js8sInU10AJ0cAQ8UMMyXrQ+oHZEkVt5lBwsStmTJ7YikVYgbskx1YYEXTojRsWCb+SH/kDmDU4pK/u91SJ4KFCRMF2411piYuXU/jF96zKrADznYh/zAraqT6hvAIVtQAlMHN53nx16rLzZ/8jDEkaSwT7+HvHiS+7sxSojnu/3oV7BtgISoUNstmSe8WpWHOaWv19xyS+Mce9MY4BfseFhzTICUymUQdd/8hXA28/H6osUfAgsnxAKv7Wil3aJSgaJczWuflYOve0dJ3InZkhw5Cvr0atwpk8YKBQjy5CdkoHqvkOcIB+cYHXJKzOE5tqU7inSwVbHzOLQ3XbnAgMBAAECggEAVJp5eT0Ixg1eYSqFs9568WdetUNCSUchNxDBu6wxAbhUgfRUGZuJnnAll63OCTGGck+EGkFh48JjRcBpGoeoHLL88QXlZZbC/iLrea6gcDIhuvfzzOffe1RcZtDFEj9hlotg8dQj1tS0gy9pN9g4+EBH7zeu+fyv+qb2e/v1l6FkISXUjpkD7RLQr3ykjiiEw9BpeKb7j5s7Kdx1NNIzhkcQKNqlk8JrTGDNInbDM6inZfwwIO2R1DHinwdfKWkvOTODTYa2MoAvVMFT9Bec9FbLpoWp7ogv1JMV9svgrcF9XLzANZ/OQvkbe9TV9GWYvIbxN6qwQioKCWO4GPnCAQKBgQDgW5MgfhX8yjXqoaUy/d1VjI8dHeIyw8d+OBAYwaxRSlCfyQ+tieWcR2HdTzPca0T0GkWcKZm0ei5xRURgxt4DUDLXNh26HG0qObbtLJdu/AuBUuCqgOiLqJ2f1uIbrz6OZUHns+bT/jGW2Ws8+C13zTCZkZt9CaQsrp3QOGDx5wKBgQDTul39hp3ZPwGNFeZdkGoUoViOSd5Lhowd5wYMGAEXWRLlU8z+smT5v0POz9JnIbCRchIY2FAPKRdVTICzmPk2EPJFxYTcwaNbVqL6lN7J2IlXXMiit5QbiLauo55w7plwV6LQmKm9KV7JsZs5XwqF7CEovI7GevFzyD3w+uizAQKBgC3LY1eRhOlpWOIAhpjG6qOoohmeXOphvdmMlfSHq6WYFqbWwmV4rS5d/6LNpNdL6fItXqIGd8I34jzql49taCmi+A2nlR/E559j0mvM20gjGDIYeZUz5MOE8k+K6/IcrhcgofgqZ2ZED1ksHdB/E8DNWCswZl16V1FrfvjeWSNnAoGAMrBplCrIW5xz+J0Hm9rZKrs+AkK5D4fUv8vxbK/KgxZ2KaUYbNm0xv39c+PZUYuFRCz1HDGdaSPDTE6WeWjkMQd5mS6ikl9hhpqFRkyh0d0fdGToO9yLftQKOGE/q3XUEktI1XvXF0xyPwNgUCnq0QkpHyGVZPtGFxwXiDvpvgECgYA5PoB+nY8iDiRaJNko9w0hL4AeKogwf+4TbCw+KWVEn6jhuJa4LFTdSqp89PktQaoVpwv92el/AhYjWOl/jVCm122f9b7GyoelbjMNolToDwe5pF5RnSpEuDdLy9MfE8LnE3PlbE7E5BipQ3UjSebkgNboLHH/lNZA5qvEtvbfvQ==','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAut9evKRuHJ/2QNfDlLwvN/S8l9hRAgPbb0u61bm4AtzaTGsLeMtScetxTWJnVvAVpMS9luhEJjt+Sbk5TNLArsgzzwARgaTKOLMT1TvWAK5EbHyI+eSrc3s7Awe1VYGwcubRFWDm16eQLv0k7iqiw+4mweHSz/wWyvBJVgwLoQ02btVtAQErCfSJCOmt0Q/oJQjj08YNRV4EKzB19+f5A+HQVAKy72dSybTzAK+3FPtTtNen/+b5wGeat7c32dhYHnGorPkPeXLtsqqUTp1su5fMfd4lElNdZaoCI7osZxWWUo17vBCZnyeXc9fk0qwD9mK6yRAxNbrY72Xx5VqIqwIDAQAB','http://api.auauz.net/api/aliPay/return','RSA2','2088102176044281');

/*Table structure for table `tool_email_config` */

DROP TABLE IF EXISTS `tool_email_config`;

CREATE TABLE `tool_email_config` (
                                     `config_id` bigint(20) NOT NULL COMMENT 'ID',
                                     `from_user` varchar(255) DEFAULT NULL COMMENT '收件人',
                                     `host` varchar(255) DEFAULT NULL COMMENT '邮件服务器SMTP地址',
                                     `pass` varchar(255) DEFAULT NULL COMMENT '密码',
                                     `port` varchar(255) DEFAULT NULL COMMENT '端口',
                                     `user` varchar(255) DEFAULT NULL COMMENT '发件者用户名',
                                     PRIMARY KEY (`config_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='邮箱配置';

/*Data for the table `tool_email_config` */

/*Table structure for table `tool_local_storage` */

DROP TABLE IF EXISTS `tool_local_storage`;

CREATE TABLE `tool_local_storage` (
                                      `storage_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                                      `real_name` varchar(255) DEFAULT NULL COMMENT '文件真实的名称',
                                      `name` varchar(255) DEFAULT NULL COMMENT '文件名',
                                      `suffix` varchar(255) DEFAULT NULL COMMENT '后缀',
                                      `path` varchar(255) DEFAULT NULL COMMENT '路径',
                                      `type` varchar(255) DEFAULT NULL COMMENT '类型',
                                      `size` varchar(100) DEFAULT NULL COMMENT '大小',
                                      `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
                                      `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
                                      `create_time` datetime DEFAULT NULL COMMENT '创建日期',
                                      `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                      PRIMARY KEY (`storage_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='本地存储';

/*Data for the table `tool_local_storage` */

/*Table structure for table `tool_qiniu_config` */

DROP TABLE IF EXISTS `tool_qiniu_config`;

CREATE TABLE `tool_qiniu_config` (
                                     `config_id` bigint(20) NOT NULL COMMENT 'ID',
                                     `access_key` text COMMENT 'accessKey',
                                     `bucket` varchar(255) DEFAULT NULL COMMENT 'Bucket 识别符',
                                     `host` varchar(255) NOT NULL COMMENT '外链域名',
                                     `secret_key` text COMMENT 'secretKey',
                                     `type` varchar(255) DEFAULT NULL COMMENT '空间类型',
                                     `zone` varchar(255) DEFAULT NULL COMMENT '机房',
                                     PRIMARY KEY (`config_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='七牛云配置';

/*Data for the table `tool_qiniu_config` */

/*Table structure for table `tool_qiniu_content` */

DROP TABLE IF EXISTS `tool_qiniu_content`;

CREATE TABLE `tool_qiniu_content` (
                                      `content_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                                      `bucket` varchar(255) DEFAULT NULL COMMENT 'Bucket 识别符',
                                      `name` varchar(255) DEFAULT NULL COMMENT '文件名称',
                                      `size` varchar(255) DEFAULT NULL COMMENT '文件大小',
                                      `type` varchar(255) DEFAULT NULL COMMENT '文件类型：私有或公开',
                                      `url` varchar(255) DEFAULT NULL COMMENT '文件url',
                                      `suffix` varchar(255) DEFAULT NULL COMMENT '文件后缀',
                                      `update_time` datetime DEFAULT NULL COMMENT '上传或同步的时间',
                                      PRIMARY KEY (`content_id`) USING BTREE,
                                      UNIQUE KEY `uniq_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='七牛云文件存储';

/*Data for the table `tool_qiniu_content` */

/*Table structure for table `vulnerability` */

DROP TABLE IF EXISTS `vulnerability`;

CREATE TABLE `vulnerability` (
                                 `id` int(11) NOT NULL AUTO_INCREMENT,
                                 `component` varchar(128) DEFAULT NULL,
                                 `vulnerability` varchar(128) DEFAULT NULL,
                                 `timestamp` datetime DEFAULT NULL,
                                 PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `vulnerability` */

insert  into `vulnerability`(`id`,`component`,`vulnerability`,`timestamp`) values
(1,'nginx','nginx漏洞','2022-05-05 14:09:00'),
(2,'bind','bind漏洞','2022-05-05 14:09:13'),
(3,'unbound','unbound漏洞','2022-05-11 14:49:14');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
