-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: localhost    Database: auths_config
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `config_info`
--

DROP TABLE IF EXISTS `config_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `content` longtext COLLATE utf8mb3_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text COLLATE utf8mb3_bin COMMENT 'source user',
  `src_ip` varchar(50) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) COLLATE utf8mb3_bin DEFAULT NULL,
  `tenant_id` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) COLLATE utf8mb3_bin DEFAULT NULL,
  `c_use` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `effect` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `type` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `c_schema` text COLLATE utf8mb3_bin,
  `encrypted_data_key` text COLLATE utf8mb3_bin COMMENT '秘钥',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfo_datagrouptenant` (`data_id`,`group_id`,`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='config_info';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info`
--

LOCK TABLES `config_info` WRITE;
/*!40000 ALTER TABLE `config_info` DISABLE KEYS */;
INSERT INTO `config_info` VALUES (1,'application-dev.yml','DEFAULT_GROUP','spring:\n  autoconfigure:\n    exclude: com.alibaba.druid.spring.boot.autoconfigure.DruidDataSourceAutoConfigure\n  mvc:\n    pathmatch:\n      matching-strategy: ant_path_matcher\n\n# feign 配置\nfeign:\n  sentinel:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\n\n# 暴露监控端点\nmanagement:\n  endpoints:\n    web:\n      exposure:\n        include: \'*\'\n','aaa73b809cfd4d0058893aa13da57806','2020-05-20 12:00:00','2022-04-24 10:26:34','nacos','0:0:0:0:0:0:0:1','','','通用配置','null','null','yaml',NULL,''),(2,'auths-gateway-dev.yml','DEFAULT_GROUP','spring: \n  data:\n    redis:\n      host: 49.232.14.89\n      port: 6379\n      password: 123456\n  cloud:\n    gateway:\n      discovery:\n        locator:\n          lowerCaseServiceId: true\n          enabled: true\n      routes:\n        # 认证中心\n        - id: auths-auth\n          uri: lb://auths-auth\n          predicates:\n            - Path=/auth/**\n          filters:\n            # 验证码处理\n            - CacheRequestFilter\n            - ValidateCodeFilter\n            - StripPrefix=1\n        # 代码生成\n        - id: auths-gen\n          uri: lb://auths-gen\n          predicates:\n            - Path=/code/**\n          filters:\n            - StripPrefix=1\n        # 定时任务\n        - id: auths-job\n          uri: lb://auths-job\n          predicates:\n            - Path=/schedule/**\n          filters:\n            - StripPrefix=1\n        # 系统模块\n        - id: auths-system\n          uri: lb://auths-system\n          predicates:\n            - Path=/system/**\n          filters:\n            - StripPrefix=1\n        # 文件服务\n        - id: auths-file\n          uri: lb://auths-file\n          predicates:\n            - Path=/file/**\n          filters:\n            - StripPrefix=1\n\n# 安全配置\nsecurity:\n  # 验证码\n  captcha:\n    enabled: true\n    type: math\n  # 防止XSS攻击\n  xss:\n    enabled: true\n    excludeUrls:\n      - /system/notice\n  # 不校验白名单\n  ignore:\n    whites:\n      - /auth/logout\n      - /auth/login\n      - /auth/register\n      - /*/v2/api-docs\n      - /csrf\n','b86d548d4f8f989df119804f087c7ee0','2020-05-14 14:17:55','2024-02-05 07:12:52','nacos','120.192.18.47','','','网关模块','null','null','yaml','',''),(3,'auths-auth-dev.yml','DEFAULT_GROUP','spring: \n  data:\n    redis:\n      host: 49.232.14.89\n      port: 6379\n      password: 123456\n','5a9e78045c37359eeec889871aa815b8','2020-11-20 00:00:00','2024-02-05 07:12:44','nacos','120.192.18.47','','','认证中心','null','null','yaml','',''),(4,'auths-monitor-dev.yml','DEFAULT_GROUP','# spring\nspring:\n  security:\n    user:\n      name: auths\n      password: 123456\n  boot:\n    admin:\n      ui:\n        title: 若依服务状态监控\n','6f122fd2bfb8d45f858e7d6529a9cd44','2020-11-20 00:00:00','2022-09-29 02:48:54','nacos','0:0:0:0:0:0:0:1','','','监控中心','null','null','yaml','',''),(5,'auths-system-dev.yml','DEFAULT_GROUP','# spring配置\nspring:\n  data:\n    redis:\n      host: 49.232.14.89\n      port: 6379\n      password: 123456\n  datasource:\n    druid:\n      stat-view-servlet:\n        enabled: true\n        loginUsername: admin\n        loginPassword: 123456\n    dynamic:\n      druid:\n        initial-size: 5\n        min-idle: 5\n        maxActive: 20\n        maxWait: 60000\n        timeBetweenEvictionRunsMillis: 60000\n        minEvictableIdleTimeMillis: 300000\n        validationQuery: SELECT 1 FROM DUAL\n        testWhileIdle: true\n        testOnBorrow: false\n        testOnReturn: false\n        poolPreparedStatements: true\n        maxPoolPreparedStatementPerConnectionSize: 20\n        filters: stat,slf4j\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\n      datasource:\n        # 主库数据源\n        master:\n          driver-class-name: com.mysql.cj.jdbc.Driver\n          url: jdbc:mysql://49.232.14.89:3306/yyf_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n          username: root\n          password: Admin@2030\n        # 从库数据源\n        # slave:\n          # username: \n          # password: \n          # url: \n          # driver-class-name: \n\n# mybatis配置\nmybatis:\n  # 搜索指定包别名\n  typeAliasesPackage: com.auths.system\n  # 配置mapper的扫描，找到所有的mapper.xml映射文件\n  mapperLocations: classpath:mapper/**/*.xml\n\n# swagger配置\nswagger:\n  title: 系统模块接口文档\n  license: Powered By auths\n  licenseUrl: https://auths.vip','504f4e1f3f1479997af0ba6d1f110ebb','2020-11-20 00:00:00','2024-02-05 02:47:16','nacos','120.192.18.47','','','系统模块','null','null','yaml','',''),(6,'auths-gen-dev.yml','DEFAULT_GROUP','# spring配置\nspring: \n  data:\n    redis:\n      host: 49.232.14.89\n      port: 6379\n      password: 123456\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://49.232.14.89:3306/yyf_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: Admin@2030\n\n# mybatis配置\nmybatis:\n  # 搜索指定包别名\n  typeAliasesPackage: com.auths.gen.domain\n  # 配置mapper的扫描，找到所有的mapper.xml映射文件\n  mapperLocations: classpath:mapper/**/*.xml\n\n# swagger配置\nswagger:\n  title: 代码生成接口文档\n  license: Powered By auths\n  licenseUrl: https://auths.vip\n\n# 代码生成\ngen:\n  # 作者\n  author: auths\n  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool\n  packageName: com.auths.system\n  # 自动去除表前缀，默认是false\n  autoRemovePre: false\n  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）\n  tablePrefix: sys_\n','63eef60c45707245306ee9d891cabb6e','2020-11-20 00:00:00','2024-02-05 07:13:15','nacos','120.192.18.47','','','代码生成','null','null','yaml','',''),(7,'auths-job-dev.yml','DEFAULT_GROUP','# spring配置\nspring: \n  data:\n    redis:\n      host: 49.232.14.89\n      port: 6379\n      password: 123456\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://49.232.14.89:3306/yyf_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: Admin@2030\n\n# mybatis配置\nmybatis:\n  # 搜索指定包别名\n  typeAliasesPackage: com.auths.job.domain\n  # 配置mapper的扫描，找到所有的mapper.xml映射文件\n  mapperLocations: classpath:mapper/**/*.xml\n\n# swagger配置\nswagger:\n  title: 定时任务接口文档\n  license: Powered By auths\n  licenseUrl: https://auths.vip\n','df2af0037c195b3746fa11050cfd23c8','2020-11-20 00:00:00','2024-02-05 07:13:24','nacos','120.192.18.47','','','定时任务','null','null','yaml','',''),(8,'auths-file-dev.yml','DEFAULT_GROUP','# 本地文件上传    \nfile:\n  domain: http://127.0.0.1:9300\n  path: D:/auths/uploadPath\n  prefix: /statics\n\n# FastDFS配置\nfdfs:\n  domain: http://8.129.231.12\n  soTimeout: 3000\n  connectTimeout: 2000\n  trackerList: 8.129.231.12:22122\n\n# Minio配置\nminio:\n  url: http://49.232.14.89:9000\n  accessKey: minioadmin\n  secretKey: minioadmin\n  bucketName: yyf_cloud','90fc5f8f641f23418f4916280b2faab2','2020-11-20 00:00:00','2024-02-02 09:40:16','nacos','120.192.18.47','','','文件服务','null','null','yaml','',''),(9,'sentinel-auths-gateway','DEFAULT_GROUP','[\r\n    {\r\n        \"resource\": \"auths-auth\",\r\n        \"count\": 500,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"auths-system\",\r\n        \"count\": 1000,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"auths-gen\",\r\n        \"count\": 200,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    },\r\n	{\r\n        \"resource\": \"auths-job\",\r\n        \"count\": 300,\r\n        \"grade\": 1,\r\n        \"limitApp\": \"default\",\r\n        \"strategy\": 0,\r\n        \"controlBehavior\": 0\r\n    }\r\n]','9f3a3069261598f74220bc47958ec252','2020-11-20 00:00:00','2020-11-20 00:00:00',NULL,'0:0:0:0:0:0:0:1','','','限流策略','null','null','json',NULL,'');
/*!40000 ALTER TABLE `config_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_info_aggr`
--

DROP TABLE IF EXISTS `config_info_aggr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_info_aggr` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'datum_id',
  `content` longtext COLLATE utf8mb3_bin NOT NULL COMMENT '内容',
  `gmt_modified` datetime NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) COLLATE utf8mb3_bin DEFAULT NULL,
  `tenant_id` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfoaggr_datagrouptenantdatum` (`data_id`,`group_id`,`tenant_id`,`datum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='增加租户字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info_aggr`
--

LOCK TABLES `config_info_aggr` WRITE;
/*!40000 ALTER TABLE `config_info_aggr` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_info_aggr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_info_beta`
--

DROP TABLE IF EXISTS `config_info_beta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_info_beta` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext COLLATE utf8mb3_bin NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text COLLATE utf8mb3_bin COMMENT 'source user',
  `src_ip` varchar(50) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` text COLLATE utf8mb3_bin COMMENT '秘钥',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfobeta_datagrouptenant` (`data_id`,`group_id`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='config_info_beta';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info_beta`
--

LOCK TABLES `config_info_beta` WRITE;
/*!40000 ALTER TABLE `config_info_beta` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_info_beta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_info_tag`
--

DROP TABLE IF EXISTS `config_info_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_info_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext COLLATE utf8mb3_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text COLLATE utf8mb3_bin COMMENT 'source user',
  `src_ip` varchar(50) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfotag_datagrouptenanttag` (`data_id`,`group_id`,`tenant_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='config_info_tag';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info_tag`
--

LOCK TABLES `config_info_tag` WRITE;
/*!40000 ALTER TABLE `config_info_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_info_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_tags_relation`
--

DROP TABLE IF EXISTS `config_tags_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_tags_relation` (
  `id` bigint NOT NULL COMMENT 'id',
  `tag_name` varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nid`),
  UNIQUE KEY `uk_configtagrelation_configidtag` (`id`,`tag_name`,`tag_type`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='config_tag_relation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_tags_relation`
--

LOCK TABLES `config_tags_relation` WRITE;
/*!40000 ALTER TABLE `config_tags_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_tags_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_capacity`
--

DROP TABLE IF EXISTS `group_capacity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_capacity` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) COLLATE utf8mb3_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  `usage` int unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `max_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='集群、各Group容量信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_capacity`
--

LOCK TABLES `group_capacity` WRITE;
/*!40000 ALTER TABLE `group_capacity` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_capacity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `his_config_info`
--

DROP TABLE IF EXISTS `his_config_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `his_config_info` (
  `id` bigint unsigned NOT NULL,
  `nid` bigint unsigned NOT NULL AUTO_INCREMENT,
  `data_id` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `group_id` varchar(128) COLLATE utf8mb3_bin NOT NULL,
  `app_name` varchar(128) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext COLLATE utf8mb3_bin NOT NULL,
  `md5` varchar(32) COLLATE utf8mb3_bin DEFAULT NULL,
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `src_user` text COLLATE utf8mb3_bin,
  `src_ip` varchar(50) COLLATE utf8mb3_bin DEFAULT NULL,
  `op_type` char(10) COLLATE utf8mb3_bin DEFAULT NULL,
  `tenant_id` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` text COLLATE utf8mb3_bin COMMENT '秘钥',
  PRIMARY KEY (`nid`),
  KEY `idx_gmt_create` (`gmt_create`),
  KEY `idx_gmt_modified` (`gmt_modified`),
  KEY `idx_did` (`data_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='多租户改造';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `his_config_info`
--

LOCK TABLES `his_config_info` WRITE;
/*!40000 ALTER TABLE `his_config_info` DISABLE KEYS */;
INSERT INTO `his_config_info` VALUES (2,1,'auths-gateway-dev.yml','DEFAULT_GROUP','','spring:\n  redis:\n    host: localhost\n    port: 6379\n    password:\n  cloud:\n    gateway:\n      discovery:\n        locator:\n          lowerCaseServiceId: true\n          enabled: true\n      routes:\n        # 认证中心\n        - id: auths-auth\n          uri: lb://auths-auth\n          predicates:\n            - Path=/auth/**\n          filters:\n            # 验证码处理\n            - CacheRequestFilter\n            - ValidateCodeFilter\n            - StripPrefix=1\n        # 代码生成\n        - id: auths-gen\n          uri: lb://auths-gen\n          predicates:\n            - Path=/code/**\n          filters:\n            - StripPrefix=1\n        # 定时任务\n        - id: auths-job\n          uri: lb://auths-job\n          predicates:\n            - Path=/schedule/**\n          filters:\n            - StripPrefix=1\n        # 系统模块\n        - id: auths-system\n          uri: lb://auths-system\n          predicates:\n            - Path=/system/**\n          filters:\n            - StripPrefix=1\n        # 文件服务\n        - id: auths-file\n          uri: lb://auths-file\n          predicates:\n            - Path=/file/**\n          filters:\n            - StripPrefix=1\n\n# 安全配置\nsecurity:\n  # 验证码\n  captcha:\n    enabled: true\n    type: math\n  # 防止XSS攻击\n  xss:\n    enabled: true\n    excludeUrls:\n      - /system/notice\n  # 不校验白名单\n  ignore:\n    whites:\n      - /auth/logout\n      - /auth/login\n      - /auth/register\n      - /*/v2/api-docs\n      - /csrf\n','57cec5abd0e0a6b77d853750344a9dc0','2024-02-02 17:10:57','2024-02-02 09:10:58','nacos','120.192.18.47','U','',''),(2,2,'auths-gateway-dev.yml','DEFAULT_GROUP','','spring:\n  redis:\n    host: localhost\n    port: 6379\n    password: 123456\n  cloud:\n    gateway:\n      discovery:\n        locator:\n          lowerCaseServiceId: true\n          enabled: true\n      routes:\n        # 认证中心\n        - id: auths-auth\n          uri: lb://auths-auth\n          predicates:\n            - Path=/auth/**\n          filters:\n            # 验证码处理\n            - CacheRequestFilter\n            - ValidateCodeFilter\n            - StripPrefix=1\n        # 代码生成\n        - id: auths-gen\n          uri: lb://auths-gen\n          predicates:\n            - Path=/code/**\n          filters:\n            - StripPrefix=1\n        # 定时任务\n        - id: auths-job\n          uri: lb://auths-job\n          predicates:\n            - Path=/schedule/**\n          filters:\n            - StripPrefix=1\n        # 系统模块\n        - id: auths-system\n          uri: lb://auths-system\n          predicates:\n            - Path=/system/**\n          filters:\n            - StripPrefix=1\n        # 文件服务\n        - id: auths-file\n          uri: lb://auths-file\n          predicates:\n            - Path=/file/**\n          filters:\n            - StripPrefix=1\n\n# 安全配置\nsecurity:\n  # 验证码\n  captcha:\n    enabled: true\n    type: math\n  # 防止XSS攻击\n  xss:\n    enabled: true\n    excludeUrls:\n      - /system/notice\n  # 不校验白名单\n  ignore:\n    whites:\n      - /auth/logout\n      - /auth/login\n      - /auth/register\n      - /*/v2/api-docs\n      - /csrf\n','b9d6af846735c90a3ec2b58737fa586b','2024-02-02 17:11:18','2024-02-02 09:11:19','nacos','120.192.18.47','U','',''),(3,3,'auths-auth-dev.yml','DEFAULT_GROUP','','spring:\n  redis:\n    host: localhost\n    port: 6379\n    password:\n','8bd9dada9a94822feeab40de55efced6','2024-02-02 17:11:26','2024-02-02 09:11:27','nacos','120.192.18.47','U','',''),(5,4,'auths-system-dev.yml','DEFAULT_GROUP','','# spring配置\nspring:\n  redis:\n    host: localhost\n    port: 6379\n    password:\n  datasource:\n    druid:\n      stat-view-servlet:\n        enabled: true\n        loginUsername: admin\n        loginPassword: 123456\n    dynamic:\n      druid:\n        initial-size: 5\n        min-idle: 5\n        maxActive: 20\n        maxWait: 60000\n        timeBetweenEvictionRunsMillis: 60000\n        minEvictableIdleTimeMillis: 300000\n        validationQuery: SELECT 1 FROM DUAL\n        testWhileIdle: true\n        testOnBorrow: false\n        testOnReturn: false\n        poolPreparedStatements: true\n        maxPoolPreparedStatementPerConnectionSize: 20\n        filters: stat,slf4j\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\n      datasource:\n          # 主库数据源\n          master:\n            driver-class-name: com.mysql.cj.jdbc.Driver\n            url: jdbc:mysql://localhost:3306/auths_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n            username: root\n            password: password\n          # 从库数据源\n          # slave:\n            # username: \n            # password: \n            # url: \n            # driver-class-name: \n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.auths.system\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# swagger配置\nswagger:\n  title: 系统模块接口文档\n  license: Powered By auths\n  licenseUrl: https://auths.vip','48e0ed4a040c402bdc2444213a82c910','2024-02-02 17:11:34','2024-02-02 09:11:35','nacos','120.192.18.47','U','',''),(6,5,'auths-gen-dev.yml','DEFAULT_GROUP','','# spring配置\nspring:\n  redis:\n    host: localhost\n    port: 6379\n    password:\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://localhost:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: password\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.auths.gen.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# swagger配置\nswagger:\n  title: 代码生成接口文档\n  license: Powered By auths\n  licenseUrl: https://auths.vip\n\n# 代码生成\ngen:\n  # 作者\n  author: auths\n  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool\n  packageName: com.auths.system\n  # 自动去除表前缀，默认是false\n  autoRemovePre: false\n  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）\n  tablePrefix: sys_\n','eb592420b3fceae1402881887b8a6a0d','2024-02-02 17:11:43','2024-02-02 09:11:43','nacos','120.192.18.47','U','',''),(7,6,'auths-job-dev.yml','DEFAULT_GROUP','','# spring配置\nspring:\n  redis:\n    host: localhost\n    port: 6379\n    password: \n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://localhost:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: password\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.auths.job.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# swagger配置\nswagger:\n  title: 定时任务接口文档\n  license: Powered By auths\n  licenseUrl: https://auths.vip\n','edcf0e3fe13fea07b4ec08b1088f30b3','2024-02-02 17:11:54','2024-02-02 09:11:54','nacos','120.192.18.47','U','',''),(5,7,'auths-system-dev.yml','DEFAULT_GROUP','','# spring配置\nspring:\n  redis:\n    host: 49.232.14.89\n    port: 6379\n    password: 123456\n  datasource:\n    druid:\n      stat-view-servlet:\n        enabled: true\n        loginUsername: admin\n        loginPassword: 123456\n    dynamic:\n      druid:\n        initial-size: 5\n        min-idle: 5\n        maxActive: 20\n        maxWait: 60000\n        timeBetweenEvictionRunsMillis: 60000\n        minEvictableIdleTimeMillis: 300000\n        validationQuery: SELECT 1 FROM DUAL\n        testWhileIdle: true\n        testOnBorrow: false\n        testOnReturn: false\n        poolPreparedStatements: true\n        maxPoolPreparedStatementPerConnectionSize: 20\n        filters: stat,slf4j\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\n      datasource:\n          # 主库数据源\n          master:\n            driver-class-name: com.mysql.cj.jdbc.Driver\n            url: jdbc:mysql://localhost:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n            username: root\n            password: password\n          # 从库数据源\n          # slave:\n            # username: \n            # password: \n            # url: \n            # driver-class-name: \n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.auths.system\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# swagger配置\nswagger:\n  title: 系统模块接口文档\n  license: Powered By auths\n  licenseUrl: https://auths.vip','6c6d810c5a84fde1b7e03ca03e334f1d','2024-02-02 17:13:19','2024-02-02 09:13:19','nacos','120.192.18.47','U','',''),(5,8,'auths-system-dev.yml','DEFAULT_GROUP','','# spring配置\nspring:\n  redis:\n    host: 49.232.14.89\n    port: 6379\n    password: 123456\n  datasource:\n    druid:\n      stat-view-servlet:\n        enabled: true\n        loginUsername: admin\n        loginPassword: 123456\n    dynamic:\n      druid:\n        initial-size: 5\n        min-idle: 5\n        maxActive: 20\n        maxWait: 60000\n        timeBetweenEvictionRunsMillis: 60000\n        minEvictableIdleTimeMillis: 300000\n        validationQuery: SELECT 1 FROM DUAL\n        testWhileIdle: true\n        testOnBorrow: false\n        testOnReturn: false\n        poolPreparedStatements: true\n        maxPoolPreparedStatementPerConnectionSize: 20\n        filters: stat,slf4j\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\n      datasource:\n          # 主库数据源\n          master:\n            driver-class-name: com.mysql.cj.jdbc.Driver\n            url: jdbc:mysql://49.232.14.89:3306/yyf_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n            username: root\n            password: Admin@2030\n          # 从库数据源\n          # slave:\n            # username: \n            # password: \n            # url: \n            # driver-class-name: \n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.auths.system\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# swagger配置\nswagger:\n  title: 系统模块接口文档\n  license: Powered By auths\n  licenseUrl: https://auths.vip','117995db68294041a7d6e70da98d5952','2024-02-02 17:14:38','2024-02-02 09:14:39','nacos','120.192.18.47','U','',''),(6,9,'auths-gen-dev.yml','DEFAULT_GROUP','','# spring配置\nspring:\n  redis:\n    host: 49.232.14.89\n    port: 6379\n    password: 123456\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://localhost:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: password\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.auths.gen.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# swagger配置\nswagger:\n  title: 代码生成接口文档\n  license: Powered By auths\n  licenseUrl: https://auths.vip\n\n# 代码生成\ngen:\n  # 作者\n  author: auths\n  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool\n  packageName: com.auths.system\n  # 自动去除表前缀，默认是false\n  autoRemovePre: false\n  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）\n  tablePrefix: sys_\n','479c64967d2695edc7fcd56072d6c64d','2024-02-02 17:15:07','2024-02-02 09:15:08','nacos','120.192.18.47','U','',''),(7,10,'auths-job-dev.yml','DEFAULT_GROUP','','# spring配置\nspring:\n  redis:\n    host: 49.232.14.89\n    port: 6379\n    password: 123456\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://localhost:3306/ry-cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: password\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.auths.job.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# swagger配置\nswagger:\n  title: 定时任务接口文档\n  license: Powered By auths\n  licenseUrl: https://auths.vip\n','0d2d15a6210e663e166bcf66ed9bb922','2024-02-02 17:15:21','2024-02-02 09:15:21','nacos','120.192.18.47','U','',''),(8,11,'auths-file-dev.yml','DEFAULT_GROUP','','# 本地文件上传    \r\nfile:\r\n    domain: http://127.0.0.1:9300\r\n    path: D:/auths/uploadPath\r\n    prefix: /statics\r\n\r\n# FastDFS配置\r\nfdfs:\r\n  domain: http://8.129.231.12\r\n  soTimeout: 3000\r\n  connectTimeout: 2000\r\n  trackerList: 8.129.231.12:22122\r\n\r\n# Minio配置\r\nminio:\r\n  url: http://8.129.231.12:9000\r\n  accessKey: minioadmin\r\n  secretKey: minioadmin\r\n  bucketName: test','5382b93f3d8059d6068c0501fdd41195','2024-02-02 17:21:12','2024-02-02 09:21:13','nacos','120.192.18.47','U','',''),(8,12,'auths-file-dev.yml','DEFAULT_GROUP','','# 本地文件上传    \nfile:\n    domain: http://127.0.0.1:9300\n    path: D:/auths/uploadPath\n    prefix: /statics\n\n# FastDFS配置\nfdfs:\n  domain: http://8.129.231.12\n  soTimeout: 3000\n  connectTimeout: 2000\n  trackerList: 8.129.231.12:22122\n\n# Minio配置\nminio:\n  url: http://49.232.14.89:9000\n  accessKey: minioadmin\n  secretKey: minioadmin\n  bucketName: test','93b9bbb338590d92c8934dac4942f3d0','2024-02-02 17:21:22','2024-02-02 09:21:23','nacos','120.192.18.47','U','',''),(8,13,'auths-file-dev.yml','DEFAULT_GROUP','','# 本地文件上传    \nfile:\n    domain: http://127.0.0.1:9300\n    path: D:/auths/uploadPath\n    prefix: /statics\n\n# FastDFS配置\nfdfs:\n  domain: http://8.129.231.12\n  soTimeout: 3000\n  connectTimeout: 2000\n  trackerList: 8.129.231.12:22122\n\n# Minio配置\nminio:\n  url: http://49.232.14.89:9000\n  accessKey: minioadmin\n  secretKey: minioadmin\n  bucketName: yyf_cloud','08a87e52e54d35f142b985f7baf10da0','2024-02-02 17:40:15','2024-02-02 09:40:16','nacos','120.192.18.47','U','',''),(5,14,'auths-system-dev.yml','DEFAULT_GROUP','','# spring配置\nspring:\n  redis:\n    host: 49.232.14.89\n    port: 6379\n    password: 123456\n  datasource:\n    druid:\n      stat-view-servlet:\n        enabled: true\n        loginUsername: admin\n        loginPassword: 123456\n    dynamic:\n      druid:\n        initial-size: 5\n        min-idle: 5\n        maxActive: 20\n        maxWait: 60000\n        timeBetweenEvictionRunsMillis: 60000\n        minEvictableIdleTimeMillis: 300000\n        validationQuery: SELECT 1 FROM DUAL\n        testWhileIdle: true\n        testOnBorrow: false\n        testOnReturn: false\n        poolPreparedStatements: true\n        maxPoolPreparedStatementPerConnectionSize: 20\n        filters: stat,slf4j\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\n      datasource:\n        # 主库数据源\n        master:\n          driver-class-name: com.mysql.cj.jdbc.Driver\n          url: jdbc:mysql://49.232.14.89:3306/yyf_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n          username: root\n          password: Admin@2030\n        # 从库数据源\n        # slave:\n          # username: \n          # password: \n          # url: \n          # driver-class-name: \n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.auths.system\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# swagger配置\nswagger:\n  title: 系统模块接口文档\n  license: Powered By auths\n  licenseUrl: https://auths.vip','eed95a72bc77f6ffc2be6cdfd182650c','2024-02-02 17:41:02','2024-02-02 09:41:02','nacos','120.192.18.47','U','',''),(6,15,'auths-gen-dev.yml','DEFAULT_GROUP','','# spring配置\nspring:\n  redis:\n    host: 49.232.14.89\n    port: 6379\n    password: 123456\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://49.232.14.89:3306/yyf_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: Admin@2030\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.auths.gen.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# swagger配置\nswagger:\n  title: 代码生成接口文档\n  license: Powered By auths\n  licenseUrl: https://auths.vip\n\n# 代码生成\ngen:\n  # 作者\n  author: auths\n  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool\n  packageName: com.auths.system\n  # 自动去除表前缀，默认是false\n  autoRemovePre: false\n  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）\n  tablePrefix: sys_\n','309fb3eeb6603797c00ac25c7bf3f668','2024-02-02 17:41:17','2024-02-02 09:41:18','nacos','120.192.18.47','U','',''),(7,16,'auths-job-dev.yml','DEFAULT_GROUP','','# spring配置\nspring:\n  redis:\n    host: 49.232.14.89\n    port: 6379\n    password: 123456\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://49.232.14.89:3306/yyf_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: Admin@2030\n\n# mybatis配置\nmybatis:\n    # 搜索指定包别名\n    typeAliasesPackage: com.auths.job.domain\n    # 配置mapper的扫描，找到所有的mapper.xml映射文件\n    mapperLocations: classpath:mapper/**/*.xml\n\n# swagger配置\nswagger:\n  title: 定时任务接口文档\n  license: Powered By auths\n  licenseUrl: https://auths.vip\n','2d8039776bc43a854f3d01d771491560','2024-02-02 17:41:29','2024-02-02 09:41:29','nacos','120.192.18.47','U','',''),(7,17,'auths-job-dev.yml','DEFAULT_GROUP','','# spring配置\nspring:\n  redis:\n    host: 49.232.14.89\n    port: 6379\n    password: 123456\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://49.232.14.89:3306/yyf_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: Admin@2030\n\n# mybatis配置\nmybatis:\n  # 搜索指定包别名\n  typeAliasesPackage: com.auths.job.domain\n  # 配置mapper的扫描，找到所有的mapper.xml映射文件\n  mapperLocations: classpath:mapper/**/*.xml\n\n# swagger配置\nswagger:\n  title: 定时任务接口文档\n  license: Powered By auths\n  licenseUrl: https://auths.vip\n','6a27de68a1ae6b1800965cfb9593866d','2024-02-02 17:43:31','2024-02-02 09:43:31','nacos','120.192.18.47','U','',''),(7,18,'auths-job-dev.yml','DEFAULT_GROUP','','# spring配置\nspring:\n  redis:\n    host: 49.232.14.89\n    port: 6379\n    password: 123456\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://49.232.14.89:3306/yyf_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: Admin@2030\n\n# mybatis配置\nmybatis:\n  # 搜索指定包别名\n  typeAliasesPackage: com.auths.job.domain\n  # 配置mapper的扫描，找到所有的mapper.xml映射文件\n  mapperLocations: classpath:mapper/**/*.xml\n\n# swagger配置\nswagger:\n  title: 定时任务接口文档\n  license: Powered By auths\n  licenseUrl: https://auths.vip\n','6a27de68a1ae6b1800965cfb9593866d','2024-02-02 17:44:17','2024-02-02 09:44:18','nacos','120.192.18.47','U','',''),(3,19,'auths-auth-dev.yml','DEFAULT_GROUP','','spring:\n  redis:\n    host: 49.232.14.89\n    port: 6379\n    password: 123456\n','4b5b449412d982ad94afe582266b7f06','2024-02-02 17:46:17','2024-02-02 09:46:18','nacos','120.192.18.47','U','',''),(3,20,'auths-auth-dev.yml','DEFAULT_GROUP','','spring:\n  redis:\n    host: 49.232.14.89\n    port: 6379\n    password: 123456\n','4b5b449412d982ad94afe582266b7f06','2024-02-02 17:47:57','2024-02-02 09:47:58','nacos','120.192.18.47','U','',''),(3,21,'auths-auth-dev.yml','DEFAULT_GROUP','','spring:\n  redis:\n    host: 49.232.14.89\n    port: 6379\n    password: 123456\n','4b5b449412d982ad94afe582266b7f06','2024-02-02 17:49:17','2024-02-02 09:49:18','nacos','120.192.18.47','U','',''),(3,22,'auths-auth-dev.yml','DEFAULT_GROUP','','spring:\n  redis:\n    host: 49.232.14.89\n    port: 6379\n    password: 123456\n','4b5b449412d982ad94afe582266b7f06','2024-02-02 17:58:21','2024-02-02 09:58:21','nacos','120.192.18.47','U','',''),(3,23,'auths-auth-dev.yml','DEFAULT_GROUP','','spring: \n  redis:\n    host: 192.168.6.74\n    port: 6379\n    password: 123456\n','34257b30ca38b572df411b5d1d723eea','2024-02-02 18:00:50','2024-02-02 10:00:51','nacos','120.192.18.47','U','',''),(3,24,'auths-auth-dev.yml','DEFAULT_GROUP','','spring: \n  redis:\n    host: 49.232.14.89\n    port: 6379\n    password: 123456\n','9b681ee5982cd0a3dba49338d2cf66ce','2024-02-02 18:00:55','2024-02-02 10:00:56','nacos','120.192.18.47','U','',''),(5,25,'auths-system-dev.yml','DEFAULT_GROUP','','# spring配置\nspring:\n  redis:\n    host: 49.232.14.89\n    port: 6379\n    password: 123456\n  datasource:\n    druid:\n      stat-view-servlet:\n        enabled: true\n        loginUsername: admin\n        loginPassword: 123456\n    dynamic:\n      druid:\n        initial-size: 5\n        min-idle: 5\n        maxActive: 20\n        maxWait: 60000\n        timeBetweenEvictionRunsMillis: 60000\n        minEvictableIdleTimeMillis: 300000\n        validationQuery: SELECT 1 FROM DUAL\n        testWhileIdle: true\n        testOnBorrow: false\n        testOnReturn: false\n        poolPreparedStatements: true\n        maxPoolPreparedStatementPerConnectionSize: 20\n        filters: stat,slf4j\n        connectionProperties: druid.stat.mergeSql\\=true;druid.stat.slowSqlMillis\\=5000\n      datasource:\n        # 主库数据源\n        master:\n          driver-class-name: com.mysql.cj.jdbc.Driver\n          url: jdbc:mysql://49.232.14.89:3306/yyf_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n          username: root\n          password: Admin@2030\n        # 从库数据源\n        # slave:\n          # username: \n          # password: \n          # url: \n          # driver-class-name: \n\n# mybatis配置\nmybatis:\n  # 搜索指定包别名\n  typeAliasesPackage: com.auths.system\n  # 配置mapper的扫描，找到所有的mapper.xml映射文件\n  mapperLocations: classpath:mapper/**/*.xml\n\n# swagger配置\nswagger:\n  title: 系统模块接口文档\n  license: Powered By auths\n  licenseUrl: https://auths.vip','22bfa6bc719925c75f44447b1bbe754b','2024-02-05 10:47:15','2024-02-05 02:47:16','nacos','120.192.18.47','U','',''),(3,26,'auths-auth-dev.yml','DEFAULT_GROUP','','spring: \n  redis:\n    host: 49.232.14.89\n    port: 6379\n    password: 123456\n','9b681ee5982cd0a3dba49338d2cf66ce','2024-02-05 15:11:39','2024-02-05 07:11:40','nacos','120.192.18.47','U','',''),(3,27,'auths-auth-dev.yml','DEFAULT_GROUP','','spring: \n  data:\n    redis:\n      host: 49.232.14.89\n      port: 6379\n      password: 123456\n','5a9e78045c37359eeec889871aa815b8','2024-02-05 15:12:44','2024-02-05 07:12:44','nacos','120.192.18.47','U','',''),(2,28,'auths-gateway-dev.yml','DEFAULT_GROUP','','spring:\n  redis:\n    host: 49.232.14.89\n    port: 6379\n    password: 123456\n  cloud:\n    gateway:\n      discovery:\n        locator:\n          lowerCaseServiceId: true\n          enabled: true\n      routes:\n        # 认证中心\n        - id: auths-auth\n          uri: lb://auths-auth\n          predicates:\n            - Path=/auth/**\n          filters:\n            # 验证码处理\n            - CacheRequestFilter\n            - ValidateCodeFilter\n            - StripPrefix=1\n        # 代码生成\n        - id: auths-gen\n          uri: lb://auths-gen\n          predicates:\n            - Path=/code/**\n          filters:\n            - StripPrefix=1\n        # 定时任务\n        - id: auths-job\n          uri: lb://auths-job\n          predicates:\n            - Path=/schedule/**\n          filters:\n            - StripPrefix=1\n        # 系统模块\n        - id: auths-system\n          uri: lb://auths-system\n          predicates:\n            - Path=/system/**\n          filters:\n            - StripPrefix=1\n        # 文件服务\n        - id: auths-file\n          uri: lb://auths-file\n          predicates:\n            - Path=/file/**\n          filters:\n            - StripPrefix=1\n\n# 安全配置\nsecurity:\n  # 验证码\n  captcha:\n    enabled: true\n    type: math\n  # 防止XSS攻击\n  xss:\n    enabled: true\n    excludeUrls:\n      - /system/notice\n  # 不校验白名单\n  ignore:\n    whites:\n      - /auth/logout\n      - /auth/login\n      - /auth/register\n      - /*/v2/api-docs\n      - /csrf\n','8f19a6cdea0eef79f7bb11368850b9ad','2024-02-05 15:12:51','2024-02-05 07:12:52','nacos','120.192.18.47','U','',''),(6,29,'auths-gen-dev.yml','DEFAULT_GROUP','','# spring配置\nspring:\n  redis:\n    host: 49.232.14.89\n    port: 6379\n    password: 123456\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://49.232.14.89:3306/yyf_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: Admin@2030\n\n# mybatis配置\nmybatis:\n  # 搜索指定包别名\n  typeAliasesPackage: com.auths.gen.domain\n  # 配置mapper的扫描，找到所有的mapper.xml映射文件\n  mapperLocations: classpath:mapper/**/*.xml\n\n# swagger配置\nswagger:\n  title: 代码生成接口文档\n  license: Powered By auths\n  licenseUrl: https://auths.vip\n\n# 代码生成\ngen:\n  # 作者\n  author: auths\n  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool\n  packageName: com.auths.system\n  # 自动去除表前缀，默认是false\n  autoRemovePre: false\n  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）\n  tablePrefix: sys_\n','2afcbea0299b5d202efc83a6b86f6630','2024-02-05 15:13:14','2024-02-05 07:13:15','nacos','120.192.18.47','U','',''),(7,30,'auths-job-dev.yml','DEFAULT_GROUP','','# spring配置\nspring:\n  redis:\n    host: 49.232.14.89\n    port: 6379\n    password: 123456\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://49.232.14.89:3306/yyf_cloud?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: Admin@2030\n\n# mybatis配置\nmybatis:\n  # 搜索指定包别名\n  typeAliasesPackage: com.auths.job.domain\n  # 配置mapper的扫描，找到所有的mapper.xml映射文件\n  mapperLocations: classpath:mapper/**/*.xml\n\n# swagger配置\nswagger:\n  title: 定时任务接口文档\n  license: Powered By auths\n  licenseUrl: https://auths.vip\n','6a27de68a1ae6b1800965cfb9593866d','2024-02-05 15:13:23','2024-02-05 07:13:24','nacos','120.192.18.47','U','','');
/*!40000 ALTER TABLE `his_config_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `role` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `resource` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `action` varchar(8) COLLATE utf8mb4_general_ci NOT NULL,
  UNIQUE KEY `uk_role_permission` (`role`,`resource`,`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `username` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `role` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  UNIQUE KEY `idx_user_role` (`username`,`role`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES ('nacos','ROLE_ADMIN');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenant_capacity`
--

DROP TABLE IF EXISTS `tenant_capacity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant_capacity` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) COLLATE utf8mb3_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  `usage` int unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `max_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数',
  `max_aggr_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='租户容量信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_capacity`
--

LOCK TABLES `tenant_capacity` WRITE;
/*!40000 ALTER TABLE `tenant_capacity` DISABLE KEYS */;
/*!40000 ALTER TABLE `tenant_capacity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenant_info`
--

DROP TABLE IF EXISTS `tenant_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) COLLATE utf8mb3_bin NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) COLLATE utf8mb3_bin DEFAULT '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tenant_info_kptenantid` (`kp`,`tenant_id`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='tenant_info';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_info`
--

LOCK TABLES `tenant_info` WRITE;
/*!40000 ALTER TABLE `tenant_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `tenant_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(500) COLLATE utf8mb4_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('nacos','$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-06 10:45:14
