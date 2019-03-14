/*
Navicat MySQL Data Transfer

Source Server         : 10.60.38.173_3306
Source Server Version : 80013
Source Host           : 10.60.38.173:3306
Source Database       : EDUCATION

Target Server Type    : MYSQL
Target Server Version : 80013
File Encoding         : 65001

Date: 2019-03-01 14:21:20
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `AUTHORITY`
-- ----------------------------
DROP TABLE IF EXISTS `AUTHORITY`;
CREATE TABLE `AUTHORITY` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of AUTHORITY
-- ----------------------------
INSERT INTO `AUTHORITY` VALUES ('1', 'ROLE_STUDENT');
INSERT INTO `AUTHORITY` VALUES ('2', 'ROLE_TEACHER');

-- ----------------------------
-- Table structure for `category`
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoryName` char(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_categoryName_uindex` (`categoryName`),
  UNIQUE KEY `category_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('3', '作业');
INSERT INTO `category` VALUES ('1', '笔记');
INSERT INTO `category` VALUES ('2', '讲义');
INSERT INTO `category` VALUES ('4', '试卷');

-- ----------------------------
-- Table structure for `course_admin`
-- ----------------------------
DROP TABLE IF EXISTS `course_admin`;
CREATE TABLE `course_admin` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_name` varchar(20) NOT NULL,
  `admin_class` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '课程号',
  `admin_userid` int(30) DEFAULT NULL COMMENT '用户ID',
  PRIMARY KEY (`admin_id`),
  KEY `course_admin_class` (`admin_class`),
  CONSTRAINT `course_admin_class` FOREIGN KEY (`admin_class`) REFERENCES `course_class` (`course_no`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of course_admin
-- ----------------------------
INSERT INTO `course_admin` VALUES ('1', 'Zhang San', '123456', '2');
INSERT INTO `course_admin` VALUES ('2', 'qibatu', '111', '2');
INSERT INTO `course_admin` VALUES ('3', 'Zhang San2', '987654', '2');
INSERT INTO `course_admin` VALUES ('4', 'qibatu', '12312', '2');
INSERT INTO `course_admin` VALUES ('5', 'qibatu', '11122', '2');
INSERT INTO `course_admin` VALUES ('6', 'qibatu', '1234', '2');
INSERT INTO `course_admin` VALUES ('7', 'qibatu', '1234', '2');

-- ----------------------------
-- Table structure for `course_class`
-- ----------------------------
DROP TABLE IF EXISTS `course_class`;
CREATE TABLE `course_class` (
  `course_id` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `course_no` varchar(20) NOT NULL,
  `course_name` varchar(30) NOT NULL,
  `course_term` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `course_start_date` datetime(6) NOT NULL,
  `course_signup_link` varchar(50) NOT NULL,
  `course_access_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `course_class_link` varchar(50) NOT NULL,
  `course_instructor_self_signup` bit(1) NOT NULL,
  `course_class_status` bit(1) NOT NULL,
  `course_credit` varchar(3) NOT NULL,
  `course_university` varchar(255) DEFAULT NULL,
  `course_major` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`course_id`) USING BTREE,
  KEY `course_no` (`course_no`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of course_class
-- ----------------------------
INSERT INTO `course_class` VALUES ('003', '123456', '测试课程名', 'FALL 2018', '2018-12-24 00:00:00.000000', '123456.com/fall2018/123', '123456789', '123456.com/fall2018/123/home', '', '', '3', null, null);
INSERT INTO `course_class` VALUES ('004', '111', '11', '0', '2018-12-04 00:00:00.000000', 'xlab409.com/tongji_university/fall2018/11', '111111', 'xlab409.com/tongji_university/fall2018/11/home', '', '', '1', '1', '1');
INSERT INTO `course_class` VALUES ('005', '987654', '测试课程名2', 'FALL 2018', '2018-12-29 00:00:00.000000', '123456.com/fall2018/123', '12345678', '123456.com/fall2018/123/home', '', '', '3', '测试2', '测试2');
INSERT INTO `course_class` VALUES ('006', '12312', 'test1', '1', '2019-01-23 00:00:00.000000', 'xlab409.com/fudan_university/spring2019/test1', '111222', 'xlab409.com/fudan_university/spring2019/test1/home', '', '', '3', '2', '154');
INSERT INTO `course_class` VALUES ('007', '11122', 'test2', 'SPRING 2018', '2019-01-15 00:00:00.000000', 'xlab409.com/tongji_university/test2', '123123', 'xlab409.com/tongji_university/test2/home', '', '', '3', '1', '3');
INSERT INTO `course_class` VALUES ('008', '1234', '1234', 'FALL 2018', '2019-01-22 00:00:00.000000', 'xlab409.com/tongji_university/1234', '123456', 'xlab409.com/tongji_university/1234/home', '', '', '2', '1', '3');
INSERT INTO `course_class` VALUES ('009', '1234', 'newclass', 'SPRING 2018', '2019-01-15 00:00:00.000000', 'xlab409.com/tongji_university/newclass', '123456', 'xlab409.com/tongji_university/newclass/home', '', '', '2', '1', '3');

-- ----------------------------
-- Table structure for `course_score`
-- ----------------------------
DROP TABLE IF EXISTS `course_score`;
CREATE TABLE `course_score` (
  `score_id` int(11) NOT NULL AUTO_INCREMENT,
  `course_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '课程号',
  `grade` decimal(3,1) DEFAULT '0.0',
  `student_id` int(20) DEFAULT NULL COMMENT '用来联系course_student和course_score',
  PRIMARY KEY (`score_id`),
  KEY `score_course_no` (`course_no`),
  CONSTRAINT `score_course_no` FOREIGN KEY (`course_no`) REFERENCES `course_class` (`course_no`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of course_score
-- ----------------------------
INSERT INTO `course_score` VALUES ('1', '123456', '0.0', '4');
INSERT INTO `course_score` VALUES ('6', '123456', '0.0', '7');
INSERT INTO `course_score` VALUES ('7', '123456', '0.0', '8');
INSERT INTO `course_score` VALUES ('8', '123456', '0.0', '9');
INSERT INTO `course_score` VALUES ('9', '123456', '0.0', '10');
INSERT INTO `course_score` VALUES ('10', '123456', '0.0', '11');
INSERT INTO `course_score` VALUES ('11', '11122', '0.0', '8');
INSERT INTO `course_score` VALUES ('12', '987654', '0.0', '8');
INSERT INTO `course_score` VALUES ('13', '987654', '0.0', '8');
INSERT INTO `course_score` VALUES ('15', '11122', '0.0', '13');
INSERT INTO `course_score` VALUES ('16', '123456', '0.0', '15');
INSERT INTO `course_score` VALUES ('17', '123456', '0.0', '14');
INSERT INTO `course_score` VALUES ('18', '123456', '0.0', '16');
INSERT INTO `course_score` VALUES ('19', '123456', '0.0', '18');
INSERT INTO `course_score` VALUES ('20', '123456', '0.0', '17');

-- ----------------------------
-- Table structure for `course_students`
-- ----------------------------
DROP TABLE IF EXISTS `course_students`;
CREATE TABLE `course_students` (
  `student_no` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '学号',
  `student_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `student_sex` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `student_birthday` datetime(6) DEFAULT NULL,
  `student_school` int(11) NOT NULL DEFAULT '0',
  `student_major` int(11) NOT NULL DEFAULT '0',
  `student_email` varchar(255) NOT NULL,
  `student_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  PRIMARY KEY (`student_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of course_students
-- ----------------------------
INSERT INTO `course_students` VALUES ('0', '', '', null, '0', '0', '314279802@qq.com', '4');
INSERT INTO `course_students` VALUES ('0', '', '', null, '0', '0', '111111@qq.com', '5');
INSERT INTO `course_students` VALUES ('0', '', '', null, '0', '0', '123456@qq.com', '7');
INSERT INTO `course_students` VALUES ('0', '', '', null, '0', '0', 'qibatu@outlook.com', '8');
INSERT INTO `course_students` VALUES ('0', '', '', null, '0', '0', '123@qq.com', '9');
INSERT INTO `course_students` VALUES ('0', '', '', null, '0', '0', 'aaa@qq.com', '10');
INSERT INTO `course_students` VALUES ('0', '', '', null, '0', '0', 'mmm@126.com', '11');
INSERT INTO `course_students` VALUES ('0', '', '', null, '0', '0', '314279802@qq.com', '13');
INSERT INTO `course_students` VALUES ('0', '', '', null, '0', '0', '23422342@qq.com', '14');
INSERT INTO `course_students` VALUES ('0', '', '', null, '0', '0', '34238947@qq.com', '15');
INSERT INTO `course_students` VALUES ('0', '', '', null, '0', '0', 'sjdlfkj@163.com', '16');
INSERT INTO `course_students` VALUES ('0', '', '', null, '0', '0', 'mmm@163.com', '17');
INSERT INTO `course_students` VALUES ('0', '', '', null, '0', '0', '3323324@qq.com', '18');

-- ----------------------------
-- Table structure for `downloadResource`
-- ----------------------------
DROP TABLE IF EXISTS `downloadResource`;
CREATE TABLE `downloadResource` (
  `id` char(60) NOT NULL,
  `userID` int(11) DEFAULT NULL,
  `resourceID` char(100) DEFAULT NULL,
  `downloadTimes` int(11) DEFAULT '1',
  `downloadTime` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `downloadResource_USER_ID_fk` (`userID`),
  KEY `downloadResource_resource_resourceID_fk` (`resourceID`),
  CONSTRAINT `downloadResource_USER_ID_fk` FOREIGN KEY (`userID`) REFERENCES `USER` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `downloadResource_resource_resourceID_fk` FOREIGN KEY (`resourceID`) REFERENCES `resource` (`resourceid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of downloadResource
-- ----------------------------
INSERT INTO `downloadResource` VALUES ('105c24c5bb5906ca239811763c', '10', '5c24c5bb5906ca239811763c', '1', '2018-12-27 09:33:46');
INSERT INTO `downloadResource` VALUES ('115c385a6790aa9eeefbb72036', '11', '5c385a6790aa9eeefbb72036', '1', '2019-01-11 05:05:27');
INSERT INTO `downloadResource` VALUES ('115c38623690aa9eeefbb7205c', '11', '5c38623690aa9eeefbb7205c', '1', '2019-01-11 05:32:58');
INSERT INTO `downloadResource` VALUES ('25c1fa4b18f3d170b44460559', '2', '5c1fa4b18f3d170b44460559', '2', '2019-01-10 07:46:21');
INSERT INTO `downloadResource` VALUES ('25c22f886d2f55f8528144986', '2', '5c22f886d2f55f8528144986', '1', '2019-01-10 07:46:00');
INSERT INTO `downloadResource` VALUES ('25c22fa80d2f55f8528144992', '2', '5c22fa80d2f55f8528144992', '1', '2019-01-10 07:45:30');
INSERT INTO `downloadResource` VALUES ('25c24c5bb5906ca239811763c', '2', '5c24c5bb5906ca239811763c', '2', '2019-01-10 07:45:41');
INSERT INTO `downloadResource` VALUES ('25c37337e90aa9e515a3933a6', '2', '5c37337e90aa9e515a3933a6', '5', '2019-01-10 08:04:36');
INSERT INTO `downloadResource` VALUES ('35c1a5427ccdcfd1cc4228730', '3', '5c1a5427ccdcfd1cc4228730', '4', '2018-12-21 11:49:41');
INSERT INTO `downloadResource` VALUES ('35c1ceecd8f3d17404866ba6d', '3', '5c1ceecd8f3d17404866ba6d', '1', '2018-12-22 02:24:41');
INSERT INTO `downloadResource` VALUES ('35c1fa4b18f3d170b44460559', '3', '5c1fa4b18f3d170b44460559', '2', '2019-01-10 07:47:24');
INSERT INTO `downloadResource` VALUES ('55c1a5427ccdcfd1cc4228730', '5', '5c1a5427ccdcfd1cc4228730', '3', '2018-12-19 10:24:11');
INSERT INTO `downloadResource` VALUES ('55c1a561dccdcfd1cc4228736', '5', '5c1a561dccdcfd1cc4228736', '2', '2018-12-19 10:31:35');
INSERT INTO `downloadResource` VALUES ('65c1c51c8eacaa52ddb116034', '6', '5c1c51c8eacaa52ddb116034', '1', '2018-12-21 10:38:39');
INSERT INTO `downloadResource` VALUES ('75c1ceecd8f3d17404866ba6d', '7', '5c1ceecd8f3d17404866ba6d', '2', '2018-12-21 09:53:25');
INSERT INTO `downloadResource` VALUES ('75c2096e78f3d173adc7fa05b', '7', '5c2096e78f3d173adc7fa05b', '1', '2018-12-26 11:48:04');
INSERT INTO `downloadResource` VALUES ('75c22fa80d2f55f8528144992', '7', '5c22fa80d2f55f8528144992', '3', '2018-12-26 12:19:26');
INSERT INTO `downloadResource` VALUES ('85c1ceecd8f3d17404866ba6d', '8', '5c1ceecd8f3d17404866ba6d', '1', '2018-12-24 08:39:53');
INSERT INTO `downloadResource` VALUES ('85c20d5138f3d173adc7fa064', '8', '5c20d5138f3d173adc7fa064', '1', '2018-12-24 10:09:01');
INSERT INTO `downloadResource` VALUES ('95c20d5138f3d173adc7fa064', '9', '5c20d5138f3d173adc7fa064', '1', '2018-12-25 10:21:55');

-- ----------------------------
-- Table structure for `education_major`
-- ----------------------------
DROP TABLE IF EXISTS `education_major`;
CREATE TABLE `education_major` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `univid` int(10) unsigned NOT NULL,
  `majorid` varchar(10) NOT NULL,
  `major` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `education_major_education_university_univid_fk` (`univid`),
  CONSTRAINT `education_major_education_university_univid_fk` FOREIGN KEY (`univid`) REFERENCES `education_university` (`univid`)
) ENGINE=InnoDB AUTO_INCREMENT=331 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of education_major
-- ----------------------------
INSERT INTO `education_major` VALUES ('1', '1', '080902', '软件工程');
INSERT INTO `education_major` VALUES ('2', '1', '000000', '工科试验班');
INSERT INTO `education_major` VALUES ('3', '1', '0701', '数学类');
INSERT INTO `education_major` VALUES ('4', '1', '000000', '理科试验班(数学类)');
INSERT INTO `education_major` VALUES ('5', '1', '070101', '数学与应用数学(创新实验区)');
INSERT INTO `education_major` VALUES ('6', '1', '070101', '数学与应用数学');
INSERT INTO `education_major` VALUES ('7', '1', '071201', '统计学');
INSERT INTO `education_major` VALUES ('8', '1', '000000', '数理强化班(创新实验区)');
INSERT INTO `education_major` VALUES ('9', '1', '000000', '理科试验班(化学类)');
INSERT INTO `education_major` VALUES ('10', '1', '000000', '化学-材料交叉实验班');
INSERT INTO `education_major` VALUES ('11', '1', '070302', '应用化学');
INSERT INTO `education_major` VALUES ('12', '1', '081301', '化学工程与工艺');
INSERT INTO `education_major` VALUES ('13', '1', '000000', '创新创业实验区');
INSERT INTO `education_major` VALUES ('14', '1', '000000', '创新创业+人才培养模式创新实验区');
INSERT INTO `education_major` VALUES ('15', '1', '040203', '社会体育指导与管理');
INSERT INTO `education_major` VALUES ('16', '1', '0201', '经济学类');
INSERT INTO `education_major` VALUES ('17', '1', '120402', '行政管理');
INSERT INTO `education_major` VALUES ('18', '1', '000000', '社会科学试验班(管理类)');
INSERT INTO `education_major` VALUES ('19', '1', '000000', '数理金融（创新实验区）');
INSERT INTO `education_major` VALUES ('20', '1', '1201', '管理科学与工程类');
INSERT INTO `education_major` VALUES ('21', '1', '0203', '金融学类');
INSERT INTO `education_major` VALUES ('22', '1', '120103', '工程管理');
INSERT INTO `education_major` VALUES ('23', '1', '120102', '信息管理与信息系统');
INSERT INTO `education_major` VALUES ('24', '1', '120201', '工商管理(国际班)');
INSERT INTO `education_major` VALUES ('25', '1', '120202', '市场营销');
INSERT INTO `education_major` VALUES ('26', '1', '020401', '国际经济与贸易');
INSERT INTO `education_major` VALUES ('27', '1', '120203K', '会计学');
INSERT INTO `education_major` VALUES ('28', '1', '020301K', '金融学');
INSERT INTO `education_major` VALUES ('29', '1', '120601', '物流管理');
INSERT INTO `education_major` VALUES ('30', '1', '120201', '工商管理(中法班)');
INSERT INTO `education_major` VALUES ('31', '1', '120601', '物流管理(中德班)');
INSERT INTO `education_major` VALUES ('32', '1', '082801', '建筑学(国际班)');
INSERT INTO `education_major` VALUES ('33', '1', '082801', '建筑类(复合型创新人才实验班)');
INSERT INTO `education_major` VALUES ('34', '1', '082801', '建筑学');
INSERT INTO `education_major` VALUES ('35', '1', '082802', '城乡规划');
INSERT INTO `education_major` VALUES ('36', '1', '082804T', '历史建筑保护工程');
INSERT INTO `education_major` VALUES ('37', '1', '082803', '风景园林');
INSERT INTO `education_major` VALUES ('38', '1', '082801', '建筑学（四）');
INSERT INTO `education_major` VALUES ('39', '1', '000000', '工程（土木）-法学（创新实验区）');
INSERT INTO `education_major` VALUES ('40', '1', '000000', '工科试验班（地质与水利工程类）');
INSERT INTO `education_major` VALUES ('41', '1', '081008T', '智能建造');
INSERT INTO `education_major` VALUES ('42', '1', '081001', '土木工程');
INSERT INTO `education_major` VALUES ('43', '1', '081401', '地质工程');
INSERT INTO `education_major` VALUES ('44', '1', '081103', '港口航道与海岸工程');
INSERT INTO `education_major` VALUES ('45', '1', '000000', '中德机械与能源工程（创新实验区）');
INSERT INTO `education_major` VALUES ('46', '1', '000000', '工科试验班(机械类)');
INSERT INTO `education_major` VALUES ('47', '1', '000000', '工科试验班(能源类)');
INSERT INTO `education_major` VALUES ('48', '1', '0802', '机械类');
INSERT INTO `education_major` VALUES ('49', '1', '080213T', '智能制造工程');
INSERT INTO `education_major` VALUES ('50', '1', '081002', '建筑环境与能源应用工程');
INSERT INTO `education_major` VALUES ('51', '1', '080501', '能源与动力工程');
INSERT INTO `education_major` VALUES ('52', '1', '080202', '机械设计制造及其自动化');
INSERT INTO `education_major` VALUES ('53', '1', '120701', '工业工程');
INSERT INTO `education_major` VALUES ('54', '1', '080202', '机械设计制造及其自动化(中意班)');
INSERT INTO `education_major` VALUES ('55', '1', '1207001', '工业工程(中德班)');
INSERT INTO `education_major` VALUES ('56', '1', '000000', '工科试验班(环境类)');
INSERT INTO `education_major` VALUES ('57', '1', '0825', '环境科学与工程学类');
INSERT INTO `education_major` VALUES ('58', '1', '082502', '环境工程');
INSERT INTO `education_major` VALUES ('59', '1', '081003', '给排水科学与工程');
INSERT INTO `education_major` VALUES ('60', '1', '082503', '环境科学');
INSERT INTO `education_major` VALUES ('61', '1', '082502', '环境工程(创新实验区)');
INSERT INTO `education_major` VALUES ('62', '1', '082503', '环境科学(创新实验区)');
INSERT INTO `education_major` VALUES ('63', '1', '050101', '汉语言文学');
INSERT INTO `education_major` VALUES ('64', '1', '010101', '哲学');
INSERT INTO `education_major` VALUES ('65', '1', '000000', '人文科学试验班');
INSERT INTO `education_major` VALUES ('66', '1', '120210', '文化产业管理');
INSERT INTO `education_major` VALUES ('67', '1', '000000', '材料-汽车-新能源（创新实验区）');
INSERT INTO `education_major` VALUES ('68', '1', '080414T', '新能源材料与器件');
INSERT INTO `education_major` VALUES ('69', '1', '080401', '材料科学与工程');
INSERT INTO `education_major` VALUES ('70', '1', '000000', '工科试验班(电气类)');
INSERT INTO `education_major` VALUES ('71', '1', '000000', '工科试验班(电子类)');
INSERT INTO `education_major` VALUES ('72', '1', '080801', '自动化(中意班)');
INSERT INTO `education_major` VALUES ('73', '1', '0809', '计算机类');
INSERT INTO `education_major` VALUES ('74', '1', '080910T', '数据科学与大数据技术');
INSERT INTO `education_major` VALUES ('75', '1', '0807', '电子信息类');
INSERT INTO `education_major` VALUES ('76', '1', '080704', '微电子科学与工程');
INSERT INTO `education_major` VALUES ('77', '1', '080901', '计算机科学与技术');
INSERT INTO `education_major` VALUES ('78', '1', '080801', '自动化');
INSERT INTO `education_major` VALUES ('79', '1', '080701', '电子信息工程');
INSERT INTO `education_major` VALUES ('80', '1', '080601', '电气工程及其自动化');
INSERT INTO `education_major` VALUES ('81', '1', '080703', '通信工程');
INSERT INTO `education_major` VALUES ('82', '1', '080904K', '信息安全');
INSERT INTO `education_major` VALUES ('83', '1', '080702', '电子科学与技术');
INSERT INTO `education_major` VALUES ('84', '1', '080701', '电子信息工程(中意班)');
INSERT INTO `education_major` VALUES ('85', '1', '050203', '德语');
INSERT INTO `education_major` VALUES ('86', '1', '050201', '英语');
INSERT INTO `education_major` VALUES ('87', '1', '000000', '德强班');
INSERT INTO `education_major` VALUES ('88', '1', '000000', '法强班');
INSERT INTO `education_major` VALUES ('89', '1', '050102', '汉语言（汉语国际教育方向）');
INSERT INTO `education_major` VALUES ('90', '1', '000000', '留学生班');
INSERT INTO `education_major` VALUES ('91', '1', '050102', '汉语言(经贸方向)');
INSERT INTO `education_major` VALUES ('92', '1', '050102', '汉语言(经贸方向)(春季)');
INSERT INTO `education_major` VALUES ('93', '1', '050102', '汉语言(春季)(经贸方向)');
INSERT INTO `education_major` VALUES ('94', '1', '100201K', '临床医学(留学生班)');
INSERT INTO `education_major` VALUES ('95', '1', '100201K', '临床医学(5+3一体化培养)');
INSERT INTO `education_major` VALUES ('96', '1', '100201K', '临床医学（五）');
INSERT INTO `education_major` VALUES ('97', '1', '101101', '护理学');
INSERT INTO `education_major` VALUES ('98', '1', '101005', '康复治疗学');
INSERT INTO `education_major` VALUES ('99', '1', '100201K', '临床医学(贯通培养)');
INSERT INTO `education_major` VALUES ('100', '1', '100301K', '口腔医学');
INSERT INTO `education_major` VALUES ('101', '1', '000000', '工科试验班(交通类)');
INSERT INTO `education_major` VALUES ('102', '1', '0818', '交通运输类');
INSERT INTO `education_major` VALUES ('103', '1', '081802', '交通工程');
INSERT INTO `education_major` VALUES ('104', '1', '081801', '交通运输');
INSERT INTO `education_major` VALUES ('105', '1', '120602', '物流工程');
INSERT INTO `education_major` VALUES ('106', '1', '0710', '生物科学类');
INSERT INTO `education_major` VALUES ('107', '1', '000000', '生命科学(试验基地班)');
INSERT INTO `education_major` VALUES ('108', '1', '071002', '生物技术');
INSERT INTO `education_major` VALUES ('109', '1', '071003', '生物信息学');
INSERT INTO `education_major` VALUES ('110', '1', '080207', '车辆工程(创新实验区)');
INSERT INTO `education_major` VALUES ('111', '1', '080207', '车辆工程(汽车）');
INSERT INTO `education_major` VALUES ('112', '1', '000000', '海洋学(试验基地班)');
INSERT INTO `education_major` VALUES ('113', '1', '000000', '理科试验班(海洋类)');
INSERT INTO `education_major` VALUES ('114', '1', '070702', '海洋技术');
INSERT INTO `education_major` VALUES ('115', '1', '070901', '地质学');
INSERT INTO `education_major` VALUES ('116', '1', '070801', '地球物理学');
INSERT INTO `education_major` VALUES ('117', '1', '081903T', '海洋资源开发技术');
INSERT INTO `education_major` VALUES ('118', '1', '000000', '轨道交通（创新实验区）');
INSERT INTO `education_major` VALUES ('119', '1', '080207', '车辆工程');
INSERT INTO `education_major` VALUES ('120', '1', '000000', '工科试验班(轨道交通)');
INSERT INTO `education_major` VALUES ('121', '1', '080102', '工程力学');
INSERT INTO `education_major` VALUES ('122', '1', '082003', '飞行器制造工程');
INSERT INTO `education_major` VALUES ('123', '1', '000000', '航空（飞行器制造）-力学（创新实验区）');
INSERT INTO `education_major` VALUES ('124', '1', '0802', '机械类(中外合作办学)');
INSERT INTO `education_major` VALUES ('125', '1', '080204', '机械电子工程');
INSERT INTO `education_major` VALUES ('126', '1', '080208', '汽车服务工程');
INSERT INTO `education_major` VALUES ('127', '1', '081004', '建筑电气与智能化');
INSERT INTO `education_major` VALUES ('128', '1', '030101K', '法学');
INSERT INTO `education_major` VALUES ('129', '1', '030201', '政治学与行政学');
INSERT INTO `education_major` VALUES ('130', '1', '030301', '社会学');
INSERT INTO `education_major` VALUES ('131', '1', '0305', '马克思主义理论');
INSERT INTO `education_major` VALUES ('132', '1', '1305', '设计学类');
INSERT INTO `education_major` VALUES ('133', '1', '080205', '工业设计');
INSERT INTO `education_major` VALUES ('134', '1', '130502', '视觉传达设计');
INSERT INTO `education_major` VALUES ('135', '1', '130503', '环境设计');
INSERT INTO `education_major` VALUES ('136', '1', '130504', '产品设计');
INSERT INTO `education_major` VALUES ('137', '1', '080205', '工业设计(珠宝设计实验区)');
INSERT INTO `education_major` VALUES ('138', '1', '080205', '工业设计(车辆造型实验区)');
INSERT INTO `education_major` VALUES ('139', '1', '081201', '测绘工程');
INSERT INTO `education_major` VALUES ('140', '1', '000000', '理科试验班(物理类)');
INSERT INTO `education_major` VALUES ('141', '1', '070201', '物理学(试验基地班)');
INSERT INTO `education_major` VALUES ('142', '1', '070202', '应用物理学');
INSERT INTO `education_major` VALUES ('143', '1', '080705', '光电信息科学与工程');
INSERT INTO `education_major` VALUES ('144', '1', '0702', '物理学类');
INSERT INTO `education_major` VALUES ('145', '1', '0503', '新闻传播学类');
INSERT INTO `education_major` VALUES ('146', '1', '050303', '广告学');
INSERT INTO `education_major` VALUES ('147', '1', '130305', '广播电视编导');
INSERT INTO `education_major` VALUES ('148', '1', '050302', '广播电视学');
INSERT INTO `education_major` VALUES ('149', '1', '130310', '动画');
INSERT INTO `education_major` VALUES ('150', '1', '130301', '表演');
INSERT INTO `education_major` VALUES ('151', '1', '130201', '音乐表演');
INSERT INTO `education_major` VALUES ('152', '2', '050101', '汉语言文学');
INSERT INTO `education_major` VALUES ('153', '2', '050102', '汉语言');
INSERT INTO `education_major` VALUES ('154', '2', '050102', '汉语言(对外语言文化方向)');
INSERT INTO `education_major` VALUES ('155', '2', '050102', '汉语言(对外商务汉语方向)');
INSERT INTO `education_major` VALUES ('156', '2', '060101', '历史学');
INSERT INTO `education_major` VALUES ('157', '2', '120901K', '旅游管理');
INSERT INTO `education_major` VALUES ('158', '2', '060104', '文物与博物馆学');
INSERT INTO `education_major` VALUES ('159', '2', '010101', '哲学');
INSERT INTO `education_major` VALUES ('160', '2', '010101', '哲学(国学方向)');
INSERT INTO `education_major` VALUES ('161', '2', '010101', '哲学(科学哲学与逻辑学方向)');
INSERT INTO `education_major` VALUES ('162', '2', '010103K', '宗教学');
INSERT INTO `education_major` VALUES ('163', '2', '050201', '英语');
INSERT INTO `education_major` VALUES ('164', '2', '050261', '翻译');
INSERT INTO `education_major` VALUES ('165', '2', '050202', '俄语');
INSERT INTO `education_major` VALUES ('166', '2', '050203', '德语');
INSERT INTO `education_major` VALUES ('167', '2', '050204', '法语');
INSERT INTO `education_major` VALUES ('168', '2', '050207', '日语');
INSERT INTO `education_major` VALUES ('169', '2', '050209', '朝鲜语');
INSERT INTO `education_major` VALUES ('170', '2', '050205', '西班牙语');
INSERT INTO `education_major` VALUES ('171', '2', '050301', '新闻学');
INSERT INTO `education_major` VALUES ('172', '2', '050302', '广播电视学');
INSERT INTO `education_major` VALUES ('173', '2', '050303', '广告学');
INSERT INTO `education_major` VALUES ('174', '2', '050304', '传播学');
INSERT INTO `education_major` VALUES ('175', '2', '030202', '国际政治');
INSERT INTO `education_major` VALUES ('176', '2', '030201', '政治学与行政学');
INSERT INTO `education_major` VALUES ('177', '2', '120402', '行政管理');
INSERT INTO `education_major` VALUES ('178', '2', '030101K', '法学');
INSERT INTO `education_major` VALUES ('179', '2', '030301', '社会学');
INSERT INTO `education_major` VALUES ('180', '2', '030302', '社会工作');
INSERT INTO `education_major` VALUES ('181', '2', '071101', '心理学');
INSERT INTO `education_major` VALUES ('182', '2', '020101', '经济学');
INSERT INTO `education_major` VALUES ('183', '2', '020101', '经济学(数理经济方向)');
INSERT INTO `education_major` VALUES ('184', '2', '020401', '国际经济与贸易(国际经济学)');
INSERT INTO `education_major` VALUES ('185', '2', '020201K', '财政学');
INSERT INTO `education_major` VALUES ('186', '2', '020301K', '金融学');
INSERT INTO `education_major` VALUES ('187', '2', '020303', '保险学');
INSERT INTO `education_major` VALUES ('188', '2', '120101', '管理科学(供应链)');
INSERT INTO `education_major` VALUES ('189', '2', '120102', '信息管理与信息系统(电子商务)');
INSERT INTO `education_major` VALUES ('190', '2', '120201K', '工商管理(战略、国际商务、人力资源)');
INSERT INTO `education_major` VALUES ('191', '2', '120202', '市场营销');
INSERT INTO `education_major` VALUES ('192', '2', '120204', '财务管理(金融工程)');
INSERT INTO `education_major` VALUES ('193', '2', '120203K', '会计学');
INSERT INTO `education_major` VALUES ('194', '2', '071201', '统计学');
INSERT INTO `education_major` VALUES ('195', '2', '070101', '数学与应用数学');
INSERT INTO `education_major` VALUES ('196', '2', '070102', '信息与计算科学');
INSERT INTO `education_major` VALUES ('197', '2', '070201', '物理学');
INSERT INTO `education_major` VALUES ('198', '2', '082201', '核工程与核技术');
INSERT INTO `education_major` VALUES ('199', '2', '070301', '化学');
INSERT INTO `education_major` VALUES ('200', '2', '070302', '应用化学');
INSERT INTO `education_major` VALUES ('201', '2', '070305T', '能源化学');
INSERT INTO `education_major` VALUES ('202', '2', '080101', '理论与应用力学');
INSERT INTO `education_major` VALUES ('203', '2', '082002', '飞行器设计与工程');
INSERT INTO `education_major` VALUES ('204', '2', '080402', '材料物理');
INSERT INTO `education_major` VALUES ('205', '2', '080403', '材料化学');
INSERT INTO `education_major` VALUES ('206', '2', '080702', '电子科学与技术');
INSERT INTO `education_major` VALUES ('207', '2', '080407', '高分子材料与工程');
INSERT INTO `education_major` VALUES ('208', '2', '082503', '环境科学');
INSERT INTO `education_major` VALUES ('209', '2', '082503', '环境科学(环境工程方向)');
INSERT INTO `education_major` VALUES ('210', '2', '082503', '环境科学(环境管理方向)');
INSERT INTO `education_major` VALUES ('211', '2', '070601', '大气科学');
INSERT INTO `education_major` VALUES ('212', '2', '071001', '生物科学');
INSERT INTO `education_major` VALUES ('213', '2', '071002', '生物技术');
INSERT INTO `education_major` VALUES ('214', '2', '071004', '生态学');
INSERT INTO `education_major` VALUES ('215', '2', '080714T', '电子信息科学与技术');
INSERT INTO `education_major` VALUES ('216', '2', '082601', '生物医学工程');
INSERT INTO `education_major` VALUES ('217', '2', '080705', '光电信息科学与工程');
INSERT INTO `education_major` VALUES ('218', '2', '080703', '通信工程');
INSERT INTO `education_major` VALUES ('219', '2', '080601', '电气工程及其自动化');
INSERT INTO `education_major` VALUES ('220', '2', '080704', '微电子科学与工程');
INSERT INTO `education_major` VALUES ('221', '2', '080901', '计算机科学与技术');
INSERT INTO `education_major` VALUES ('222', '2', '080904K', '信息安全');
INSERT INTO `education_major` VALUES ('223', '2', '120106TK', '保密管理');
INSERT INTO `education_major` VALUES ('224', '2', '080902', '软件工程');
INSERT INTO `education_major` VALUES ('225', '2', '080910T', '数据科学与大数据技术');
INSERT INTO `education_major` VALUES ('226', '2', '100101K', '基础医学');
INSERT INTO `education_major` VALUES ('227', '2', '100901K', '法医学');
INSERT INTO `education_major` VALUES ('228', '2', '100201K', '临床医学(八年制)');
INSERT INTO `education_major` VALUES ('229', '2', '100201K', '临床医学(六年制)');
INSERT INTO `education_major` VALUES ('230', '2', '100201K', '临床医学(五年制)');
INSERT INTO `education_major` VALUES ('231', '2', '100201K', '临床医学(五年制)(儿科学方向)');
INSERT INTO `education_major` VALUES ('232', '2', '100401K', '预防医学');
INSERT INTO `education_major` VALUES ('233', '2', '120401', '公共事业管理');
INSERT INTO `education_major` VALUES ('234', '2', '100701', '药学');
INSERT INTO `education_major` VALUES ('235', '2', '100701', '药学(临床药学方向)');
INSERT INTO `education_major` VALUES ('236', '2', '101101', '护理学');
INSERT INTO `education_major` VALUES ('237', '2', '101101', '护理学(助产士方向)');
INSERT INTO `education_major` VALUES ('238', '3', '081901', '船舶与海洋工程');
INSERT INTO `education_major` VALUES ('239', '3', '081801', '交通运输');
INSERT INTO `education_major` VALUES ('240', '3', '081001', '土木工程');
INSERT INTO `education_major` VALUES ('241', '3', '080102', '工程力学');
INSERT INTO `education_major` VALUES ('242', '3', '0819', '海洋工程类');
INSERT INTO `education_major` VALUES ('243', '3', '0802', '机械类');
INSERT INTO `education_major` VALUES ('244', '3', '0810', '土木类');
INSERT INTO `education_major` VALUES ('245', '3', '080201', '机械工程');
INSERT INTO `education_major` VALUES ('246', '3', '080501', '能源与动力工程');
INSERT INTO `education_major` VALUES ('247', '3', '120701', '工业工程');
INSERT INTO `education_major` VALUES ('248', '3', '080503T', '新能源科学与工程');
INSERT INTO `education_major` VALUES ('249', '3', '082201', '核工程与核技术');
INSERT INTO `education_major` VALUES ('250', '3', '0802', '机械类(国际化人才培养试点班)');
INSERT INTO `education_major` VALUES ('251', '3', '0807', '电子信息类');
INSERT INTO `education_major` VALUES ('252', '3', '080801', '自动化');
INSERT INTO `education_major` VALUES ('253', '3', '080706', '信息工程');
INSERT INTO `education_major` VALUES ('254', '3', '080702', '电子科学与技术');
INSERT INTO `education_major` VALUES ('255', '3', '080901', '计算机科学与技术');
INSERT INTO `education_major` VALUES ('256', '3', '080301', '测控技术与仪器');
INSERT INTO `education_major` VALUES ('257', '3', '080601', '电气工程及其自动化');
INSERT INTO `education_major` VALUES ('258', '3', '080904K', '信息安全');
INSERT INTO `education_major` VALUES ('259', '3', '080902', '软件工程');
INSERT INTO `education_major` VALUES ('260', '3', '080704', '微电子科学与工程');
INSERT INTO `education_major` VALUES ('261', '3', '0807', '电子信息类(IEEE试点班)');
INSERT INTO `education_major` VALUES ('262', '3', '080401', '材料科学与工程');
INSERT INTO `education_major` VALUES ('263', '3', '082501', '环境科学与工程');
INSERT INTO `education_major` VALUES ('264', '3', '082601', '生物医学工程');
INSERT INTO `education_major` VALUES ('265', '3', '082001', '航空航天工程');
INSERT INTO `education_major` VALUES ('266', '3', '0703', '化学类');
INSERT INTO `education_major` VALUES ('267', '3', '081301', '化学工程与工艺');
INSERT INTO `education_major` VALUES ('268', '3', '070301', '化学');
INSERT INTO `education_major` VALUES ('269', '3', '070101', '数学与应用数学');
INSERT INTO `education_major` VALUES ('270', '3', '070201', '物理学');
INSERT INTO `education_major` VALUES ('271', '3', '0710', '生物科学类');
INSERT INTO `education_major` VALUES ('272', '3', '071002', '生物技术');
INSERT INTO `education_major` VALUES ('273', '3', '083001', '生物工程');
INSERT INTO `education_major` VALUES ('274', '3', '080901', '计算机科学与技术(人工智能方向)');
INSERT INTO `education_major` VALUES ('275', '3', '080801', '自动化(人工智能方向)');
INSERT INTO `education_major` VALUES ('276', '3', '080706', '信息工程(人工智能方向)');
INSERT INTO `education_major` VALUES ('277', '3', '0902', '自然保护与环境生态类');
INSERT INTO `education_major` VALUES ('278', '3', '082506T', '资源环境科学');
INSERT INTO `education_major` VALUES ('279', '3', '090301', '动物科学');
INSERT INTO `education_major` VALUES ('280', '3', '090104', '植物科学与技术');
INSERT INTO `education_major` VALUES ('281', '3', '1007', '药学类');
INSERT INTO `education_major` VALUES ('282', '3', '100701', '药学');
INSERT INTO `education_major` VALUES ('283', '3', '100703', '临床药学(五年制)');
INSERT INTO `education_major` VALUES ('284', '3', '000000', '经济管理试验班');
INSERT INTO `education_major` VALUES ('285', '3', '020301K', '金融学');
INSERT INTO `education_major` VALUES ('286', '3', '020401', '国际经济与贸易');
INSERT INTO `education_major` VALUES ('287', '3', '020101', '经济学');
INSERT INTO `education_major` VALUES ('288', '3', '120201K', '工商管理');
INSERT INTO `education_major` VALUES ('289', '3', '120203K', '会计学');
INSERT INTO `education_major` VALUES ('290', '3', '120206', '人力资源管理');
INSERT INTO `education_major` VALUES ('291', '3', '120102', '信息管理与信息系统');
INSERT INTO `education_major` VALUES ('292', '3', '030101K', '法学');
INSERT INTO `education_major` VALUES ('293', '3', '050201', '英语');
INSERT INTO `education_major` VALUES ('294', '3', '050207', '日语');
INSERT INTO `education_major` VALUES ('295', '3', '050203', '德语');
INSERT INTO `education_major` VALUES ('296', '3', '050101', '汉语言文学(中外文化交流)');
INSERT INTO `education_major` VALUES ('297', '3', '120402', '行政管理');
INSERT INTO `education_major` VALUES ('298', '3', '050304', '传播学');
INSERT INTO `education_major` VALUES ('299', '3', '130305', '广播电视编导');
INSERT INTO `education_major` VALUES ('300', '3', '120210', '文化产业管理');
INSERT INTO `education_major` VALUES ('301', '3', '080205', '工业设计');
INSERT INTO `education_major` VALUES ('302', '3', '082801', '建筑学');
INSERT INTO `education_major` VALUES ('303', '3', '130502', '视觉传达设计(含环境设计)');
INSERT INTO `education_major` VALUES ('304', '3', '090502', '园林');
INSERT INTO `education_major` VALUES ('305', '3', '0807', '电子信息类(全英语授课)');
INSERT INTO `education_major` VALUES ('306', '3', '080909T', '电子与计算机工程');
INSERT INTO `education_major` VALUES ('307', '3', '0802', '机械类(全英语授课)');
INSERT INTO `education_major` VALUES ('308', '3', '0804', '材料类(全英语授课)');
INSERT INTO `education_major` VALUES ('309', '3', '0807', '电子信息类(零法语基础,英语+法语授课)');
INSERT INTO `education_major` VALUES ('310', '3', '0802', '机械类(零法语基础,英语+法语授课)');
INSERT INTO `education_major` VALUES ('311', '3', '050204', '法语');
INSERT INTO `education_major` VALUES ('312', '3', '000000', '工科试验班类');
INSERT INTO `education_major` VALUES ('313', '3', '000000', '理科试验班类');
INSERT INTO `education_major` VALUES ('314', '3', '000000', '自然科学试验班(生命与环境交叉平台)');
INSERT INTO `education_major` VALUES ('315', '3', '071201', '统计学');
INSERT INTO `education_major` VALUES ('316', '3', '070202', '应用物理学');
INSERT INTO `education_major` VALUES ('317', '3', '070401', '天文学');
INSERT INTO `education_major` VALUES ('318', '3', '082701', '食品科学与工程');
INSERT INTO `education_major` VALUES ('319', '3', '100201K', '临床医学(本博连读)');
INSERT INTO `education_major` VALUES ('320', '3', '100201K', '临床医学(本博连读法语班)');
INSERT INTO `education_major` VALUES ('321', '3', '100201K', '临床医学');
INSERT INTO `education_major` VALUES ('322', '3', '100201K', '临床医学(儿科方向5+3)');
INSERT INTO `education_major` VALUES ('323', '3', '100201K', '临床医学(英语班)');
INSERT INTO `education_major` VALUES ('324', '3', '100201K', '临床医学(本博连读口腔医学方向)');
INSERT INTO `education_major` VALUES ('325', '3', '100301K', '口腔医学');
INSERT INTO `education_major` VALUES ('326', '3', '100401K', '预防医学');
INSERT INTO `education_major` VALUES ('327', '3', '1010', '医学技术类');
INSERT INTO `education_major` VALUES ('328', '3', '101001', '医学检验技术');
INSERT INTO `education_major` VALUES ('329', '3', '100402', '食品卫生与营养学');
INSERT INTO `education_major` VALUES ('330', '3', '101101', '护理学');

-- ----------------------------
-- Table structure for `education_university`
-- ----------------------------
DROP TABLE IF EXISTS `education_university`;
CREATE TABLE `education_university` (
  `univid` int(11) unsigned NOT NULL,
  `university` varchar(60) NOT NULL,
  PRIMARY KEY (`univid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of education_university
-- ----------------------------
INSERT INTO `education_university` VALUES ('1', '同济大学');
INSERT INTO `education_university` VALUES ('2', '复旦大学');
INSERT INTO `education_university` VALUES ('3', '上海交通大学');

-- ----------------------------
-- Table structure for `favouriteResource`
-- ----------------------------
DROP TABLE IF EXISTS `favouriteResource`;
CREATE TABLE `favouriteResource` (
  `id` char(60) NOT NULL,
  `userID` int(11) DEFAULT NULL,
  `resourceID` char(100) DEFAULT NULL,
  `favouriteTime` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `favouriteResource_USER_ID_fk` (`userID`),
  KEY `favouriteResource_resource_resourceID_fk` (`resourceID`),
  CONSTRAINT `favouriteResource_USER_ID_fk` FOREIGN KEY (`userID`) REFERENCES `USER` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `favouriteResource_resource_resourceID_fk` FOREIGN KEY (`resourceID`) REFERENCES `resource` (`resourceid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of favouriteResource
-- ----------------------------
INSERT INTO `favouriteResource` VALUES ('105c24c5bb5906ca239811763c', '10', '5c24c5bb5906ca239811763c', '2019-01-09 08:47:19');
INSERT INTO `favouriteResource` VALUES ('115c385a6790aa9eeefbb72036', '11', '5c385a6790aa9eeefbb72036', '2019-01-11 05:06:14');
INSERT INTO `favouriteResource` VALUES ('115c38623690aa9eeefbb7205c', '11', '5c38623690aa9eeefbb7205c', '2019-01-11 05:32:27');
INSERT INTO `favouriteResource` VALUES ('25c37337e90aa9e515a3933a6', '2', '5c37337e90aa9e515a3933a6', '2019-01-10 08:00:34');
INSERT INTO `favouriteResource` VALUES ('25c385a6790aa9eeefbb72036', '2', '5c385a6790aa9eeefbb72036', '2019-01-11 04:58:29');
INSERT INTO `favouriteResource` VALUES ('75c1a561dccdcfd1cc4228736', '7', '5c1a561dccdcfd1cc4228736', '2018-12-21 10:41:36');
INSERT INTO `favouriteResource` VALUES ('75c1ceecd8f3d17404866ba6d', '7', '5c1ceecd8f3d17404866ba6d', '2018-12-22 11:46:30');
INSERT INTO `favouriteResource` VALUES ('85c1ceecd8f3d17404866ba6d', '8', '5c1ceecd8f3d17404866ba6d', '2018-12-24 08:39:01');
INSERT INTO `favouriteResource` VALUES ('95c20d5138f3d173adc7fa064', '9', '5c20d5138f3d173adc7fa064', '2018-12-25 10:21:34');

-- ----------------------------
-- Table structure for `forum_answer`
-- ----------------------------
DROP TABLE IF EXISTS `forum_answer`;
CREATE TABLE `forum_answer` (
  `answer_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '回答编号',
  `user_ID` int(11) NOT NULL COMMENT '回答者编号',
  `answer_text` varchar(1000) NOT NULL COMMENT '回答内容',
  `answer_collection` int(11) NOT NULL COMMENT '答案收藏',
  `answer_date` datetime(6) NOT NULL COMMENT '回答时间',
  `clicking_rate` int(11) NOT NULL COMMENT '点击率',
  `answer_evaluation` int(11) NOT NULL COMMENT '答案评分',
  PRIMARY KEY (`answer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of forum_answer
-- ----------------------------

-- ----------------------------
-- Table structure for `forum_blackboard`
-- ----------------------------
DROP TABLE IF EXISTS `forum_blackboard`;
CREATE TABLE `forum_blackboard` (
  `publish_id` int(11) NOT NULL,
  `publish_type_id` int(11) NOT NULL COMMENT '1',
  `blackboard_id` int(8) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `sector_id` int(11) NOT NULL,
  `blackboard_name` varchar(35) NOT NULL,
  `blackboard_text` varchar(1000) NOT NULL,
  `blackboard_date` datetime(6) NOT NULL,
  `reply_count` int(11) DEFAULT NULL,
  `clicking_rate` int(11) DEFAULT NULL,
  `praise_count` int(11) DEFAULT NULL,
  `favorite_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`blackboard_id`,`publish_id`),
  KEY `Blackboard_publish_id` (`publish_id`),
  KEY `blackboard_publish_type_id` (`publish_type_id`),
  KEY `blackboard_user_id` (`user_id`),
  KEY `blackboard_sector_id` (`sector_id`),
  CONSTRAINT `Blackboard_publish_id` FOREIGN KEY (`publish_id`) REFERENCES `forum_publish` (`publish_id`),
  CONSTRAINT `blackboard_publish_type_id` FOREIGN KEY (`publish_type_id`) REFERENCES `forum_publish_type` (`publish_type_id`),
  CONSTRAINT `blackboard_sector_id` FOREIGN KEY (`sector_id`) REFERENCES `forum_sector` (`sectorid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `blackboard_user_id` FOREIGN KEY (`user_id`) REFERENCES `USER` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of forum_blackboard
-- ----------------------------
INSERT INTO `forum_blackboard` VALUES ('1', '0', '2', '3', '0', '哇啊啊', '有的我都不记得了', '2018-12-20 15:31:51.000000', '3', '3', '2', '1');
INSERT INTO `forum_blackboard` VALUES ('0', '1', '3', '1', '-1', '软件工程', '<p>帅帅帅</p>', '2018-12-20 21:20:23.000000', '7', '3', '0', '0');
INSERT INTO `forum_blackboard` VALUES ('0', '1', '4', '1', '0', '软件工程答辩', '<p><span style=\"font-weight: bold;\">2018年12月22日<span style=\"font-style: italic;\">10:00</span></span></p>', '2018-12-22 11:49:01.000000', '0', '4', '0', '0');
INSERT INTO `forum_blackboard` VALUES ('0', '1', '5', '1', '-1', '呵呵', '<p>哈哈哈</p>', '2018-12-22 23:05:56.000000', '0', '1', '0', '1');
INSERT INTO `forum_blackboard` VALUES ('0', '1', '6', '2', '0', '哈哈哈', '<p>呵呵</p>', '2018-12-22 23:11:49.000000', '1', '8', '0', '1');
INSERT INTO `forum_blackboard` VALUES ('0', '1', '7', '1', '1', '测试标题', '<p>测试内容</p>', '2019-01-10 01:29:24.000000', '1', '0', '1', '0');
INSERT INTO `forum_blackboard` VALUES ('0', '1', '8', '1', '1', '测试黑板报测试', '<p>测试测试测试</p><p><img src=\"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/f6/2018new_aini_org.png\" alt=\"[爱你]\" data-w-e=\"1\">&#128516;<br></p><p><img src=\"http://tjce-image.oss-cn-beijing.aliyuncs.com/20190110014404120web.jpg\"><br></p>', '2019-01-10 01:44:10.000000', '0', '0', '1', '9');

-- ----------------------------
-- Table structure for `forum_draft`
-- ----------------------------
DROP TABLE IF EXISTS `forum_draft`;
CREATE TABLE `forum_draft` (
  `draft_id` int(11) NOT NULL AUTO_INCREMENT,
  `state_id` int(11) NOT NULL COMMENT '1',
  `publish_type_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `sector_id` int(11) NOT NULL,
  `draft_name` varchar(35) NOT NULL,
  `draft_text` varchar(2000) NOT NULL,
  `write_date` datetime(6) NOT NULL,
  PRIMARY KEY (`draft_id`),
  KEY `draft_sector_id` (`sector_id`),
  KEY `draft_user_id` (`user_id`),
  KEY `publish_draft_state_id` (`state_id`),
  KEY `publish_draft_type_id` (`publish_type_id`),
  CONSTRAINT `draft_sector_id` FOREIGN KEY (`sector_id`) REFERENCES `forum_sector` (`sectorid`),
  CONSTRAINT `draft_user_id` FOREIGN KEY (`user_id`) REFERENCES `USER` (`id`),
  CONSTRAINT `publish_draft_state_id` FOREIGN KEY (`state_id`) REFERENCES `forum_publish_state` (`publish_state_id`),
  CONSTRAINT `publish_draft_type_id` FOREIGN KEY (`publish_type_id`) REFERENCES `forum_publish_type` (`publish_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of forum_draft
-- ----------------------------
INSERT INTO `forum_draft` VALUES ('7', '0', '1', '4', '0', '绞尽脑汁', '编不出来了，就酱吧', '2018-12-20 15:48:40.000000');
INSERT INTO `forum_draft` VALUES ('11', '1', '0', '1', '-1', '软件工程笔记', '<p>生死时速</p>', '2018-12-20 21:17:16.000000');
INSERT INTO `forum_draft` VALUES ('12', '1', '0', '1', '-1', '软件工程笔记', '<p>生死时速</p>', '2018-12-20 21:18:28.000000');
INSERT INTO `forum_draft` VALUES ('13', '1', '1', '1', '-1', '软件工程', '<p>帅帅帅</p>', '2018-12-20 21:20:21.000000');
INSERT INTO `forum_draft` VALUES ('14', '1', '0', '1', '-1', '啊啊', '<p>啊啊</p>', '2018-12-20 21:24:24.000000');
INSERT INTO `forum_draft` VALUES ('15', '1', '0', '1', '-1', '哈哈哈哈', '<p>sad</p>', '2018-12-20 22:26:36.000000');
INSERT INTO `forum_draft` VALUES ('17', '1', '0', '1', '-1', 'JavaEE答辩', '<p>今天要JavaEE答辩了，好紧张啊！还在写文档啊。</p>', '2018-12-21 21:57:27.000000');
INSERT INTO `forum_draft` VALUES ('21', '1', '0', '1', '-1', '11', '<p>2</p>', '2018-12-22 23:30:08.000000');
INSERT INTO `forum_draft` VALUES ('24', '1', '0', '7', '1', '这是草稿的题目', '这是草稿原文', '2018-10-27 00:00:00.000000');
INSERT INTO `forum_draft` VALUES ('25', '1', '0', '2', '-1', '11', '<p>1</p>', '2018-12-22 23:35:06.000000');
INSERT INTO `forum_draft` VALUES ('26', '1', '1', '1', '1', '测试标题', '<p>测试内容</p>', '2019-01-10 01:29:20.000000');
INSERT INTO `forum_draft` VALUES ('27', '1', '0', '1', '-1', '文章测试', '<p>测试测试测试</p>', '2019-01-10 02:08:42.000000');
INSERT INTO `forum_draft` VALUES ('28', '1', '0', '1', '-1', '测试发表文章', '<p>输入文章内容</p>', '2019-01-10 02:17:50.000000');

-- ----------------------------
-- Table structure for `forum_favorite`
-- ----------------------------
DROP TABLE IF EXISTS `forum_favorite`;
CREATE TABLE `forum_favorite` (
  `favourite_id` int(11) NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `collection_time` datetime(6) NOT NULL,
  `type` int(5) NOT NULL DEFAULT '0' COMMENT '区分是文章还是黑板报，0 为文章（默认），1 为黑板报',
  PRIMARY KEY (`favourite_id`),
  KEY `favorite_topic_id` (`topic_id`),
  KEY `favorite_user_id` (`user_id`),
  CONSTRAINT `favorite_user_id` FOREIGN KEY (`user_id`) REFERENCES `USER` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of forum_favorite
-- ----------------------------
INSERT INTO `forum_favorite` VALUES ('1', '0', '5', '2018-12-20 15:49:17.000000', '0');
INSERT INTO `forum_favorite` VALUES ('3', '24', '1', '2019-01-09 21:38:30.000000', '0');
INSERT INTO `forum_favorite` VALUES ('4', '6', '1', '2019-01-09 21:41:05.000000', '1');
INSERT INTO `forum_favorite` VALUES ('5', '5', '1', '2019-01-09 21:43:56.000000', '1');
INSERT INTO `forum_favorite` VALUES ('7', '26', '1', '2019-01-10 15:19:15.000000', '0');
INSERT INTO `forum_favorite` VALUES ('16', '8', '1', '2019-01-11 15:04:40.000000', '1');

-- ----------------------------
-- Table structure for `forum_keyword`
-- ----------------------------
DROP TABLE IF EXISTS `forum_keyword`;
CREATE TABLE `forum_keyword` (
  `KeywordId` int(11) NOT NULL DEFAULT '0',
  `Word` varchar(35) NOT NULL,
  PRIMARY KEY (`KeywordId`),
  KEY `KeywordId` (`KeywordId`,`Word`),
  KEY `Word` (`Word`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of forum_keyword
-- ----------------------------
INSERT INTO `forum_keyword` VALUES ('1', '分布式');
INSERT INTO `forum_keyword` VALUES ('0', '区块链');

-- ----------------------------
-- Table structure for `forum_praise`
-- ----------------------------
DROP TABLE IF EXISTS `forum_praise`;
CREATE TABLE `forum_praise` (
  `praise_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `type` bit(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  `praise_date` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`praise_id`),
  KEY `type_id` (`type_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `forum_praise_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `USER` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of forum_praise
-- ----------------------------
INSERT INTO `forum_praise` VALUES ('1', '0', '', '5', '2018-12-20 15:49:47.000000');
INSERT INTO `forum_praise` VALUES ('11', '17', '', '1', '2018-12-22 11:52:02.065000');
INSERT INTO `forum_praise` VALUES ('13', '23', '', '7', '2018-12-23 01:07:36.646000');
INSERT INTO `forum_praise` VALUES ('20', '24', '', '1', '2019-01-09 21:38:22.008000');
INSERT INTO `forum_praise` VALUES ('24', '2', '', '1', '2019-01-09 21:44:07.456000');
INSERT INTO `forum_praise` VALUES ('25', '23', '', '1', '2019-01-09 21:44:38.322000');
INSERT INTO `forum_praise` VALUES ('26', '7', '', '1', '2019-01-10 15:11:57.983000');
INSERT INTO `forum_praise` VALUES ('27', '26', '', '1', '2019-01-10 15:19:16.619000');
INSERT INTO `forum_praise` VALUES ('30', '8', '', '1', '2019-01-11 15:04:41.262000');
INSERT INTO `forum_praise` VALUES ('31', '27', '', '1', '2019-01-11 17:21:01.144000');

-- ----------------------------
-- Table structure for `forum_publish`
-- ----------------------------
DROP TABLE IF EXISTS `forum_publish`;
CREATE TABLE `forum_publish` (
  `publish_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `state_id` int(11) NOT NULL,
  `publish_type_id` int(11) NOT NULL,
  `publish_sector_id` int(11) NOT NULL,
  `publish_name` varchar(35) NOT NULL,
  `publish_text` varchar(2000) NOT NULL,
  `publish_date` datetime(6) NOT NULL,
  PRIMARY KEY (`publish_id`),
  KEY `Publisher_sector_id` (`publish_sector_id`),
  KEY `Publisher_state_id` (`state_id`),
  KEY `Publisher_type_id` (`publish_type_id`),
  KEY `Publisher_user_id` (`user_id`),
  CONSTRAINT `Publisher_sector_id` FOREIGN KEY (`publish_sector_id`) REFERENCES `forum_sector` (`sectorid`),
  CONSTRAINT `Publisher_state_id` FOREIGN KEY (`state_id`) REFERENCES `forum_publish_state` (`publish_state_id`),
  CONSTRAINT `Publisher_type_id` FOREIGN KEY (`publish_type_id`) REFERENCES `forum_publish_type` (`publish_type_id`),
  CONSTRAINT `Publisher_user_id` FOREIGN KEY (`user_id`) REFERENCES `USER` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of forum_publish
-- ----------------------------
INSERT INTO `forum_publish` VALUES ('0', '2', '1', '1', '0', '糟糕', '数据库怎么被删了', '2018-12-20 15:30:55.000000');
INSERT INTO `forum_publish` VALUES ('1', '3', '1', '0', '1', '哇啊啊', '有的我都不记得了', '2018-12-20 15:31:45.000000');

-- ----------------------------
-- Table structure for `forum_publish_state`
-- ----------------------------
DROP TABLE IF EXISTS `forum_publish_state`;
CREATE TABLE `forum_publish_state` (
  `publish_state_id` int(11) NOT NULL,
  `publish_state_name` varchar(35) NOT NULL,
  PRIMARY KEY (`publish_state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of forum_publish_state
-- ----------------------------
INSERT INTO `forum_publish_state` VALUES ('0', 'draft');
INSERT INTO `forum_publish_state` VALUES ('1', 'publish');

-- ----------------------------
-- Table structure for `forum_publish_type`
-- ----------------------------
DROP TABLE IF EXISTS `forum_publish_type`;
CREATE TABLE `forum_publish_type` (
  `publish_type_id` int(11) NOT NULL,
  `publish_type_name` varchar(255) NOT NULL,
  PRIMARY KEY (`publish_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of forum_publish_type
-- ----------------------------
INSERT INTO `forum_publish_type` VALUES ('0', 'blackboard');
INSERT INTO `forum_publish_type` VALUES ('1', 'article');
INSERT INTO `forum_publish_type` VALUES ('2', 'question');

-- ----------------------------
-- Table structure for `forum_question`
-- ----------------------------
DROP TABLE IF EXISTS `forum_question`;
CREATE TABLE `forum_question` (
  `question_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '问题编号，主键，标识列',
  `question_title` varchar(255) NOT NULL COMMENT '问题标题',
  `user_ID` int(11) NOT NULL COMMENT '提问者编号',
  `question_sector_ID` int(11) NOT NULL COMMENT '问题类型',
  `question_text` varchar(255) NOT NULL COMMENT '问题内容',
  `question_date` datetime(6) NOT NULL COMMENT '提问时间',
  `answer_count` int(11) NOT NULL DEFAULT '0' COMMENT '回答数量',
  `clicking_rate` int(11) NOT NULL DEFAULT '0' COMMENT '问题点击率',
  `question_evaluation` int(11) NOT NULL DEFAULT '0' COMMENT '问题评分',
  `question_follow` int(2) NOT NULL DEFAULT '0' COMMENT '0为关注，1为不关注',
  `picture_path` varchar(1000) NOT NULL,
  `question_participate` int(11) DEFAULT '0',
  PRIMARY KEY (`question_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of forum_question
-- ----------------------------
INSERT INTO `forum_question` VALUES ('1', '问题1', '2', '1', '问题1的内容', '2019-01-09 12:53:29.000000', '0', '0', '3', '0', 'https://tjce-image.oss-cn-beijing.aliyuncs.com/20181204205454618web.jpg', '0');
INSERT INTO `forum_question` VALUES ('2', '问题2 ', '2', '1', '问题2的内容', '2019-01-09 12:54:29.000000', '0', '0', '4', '0', 'https://tjce-image.oss-cn-beijing.aliyuncs.com/20181204205454618web.jpg', '0');
INSERT INTO `forum_question` VALUES ('3', '问题3', '2', '1', '问题3的内容', '2019-01-09 12:55:29.000000', '0', '0', '5', '0', 'https://tjce-image.oss-cn-beijing.aliyuncs.com/20181204205454618web.jpg', '0');

-- ----------------------------
-- Table structure for `forum_question_sector`
-- ----------------------------
DROP TABLE IF EXISTS `forum_question_sector`;
CREATE TABLE `forum_question_sector` (
  `sector_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `sector_name` varchar(255) NOT NULL COMMENT '类型名称',
  `question_count` int(11) NOT NULL COMMENT '问题数量',
  PRIMARY KEY (`sector_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of forum_question_sector
-- ----------------------------
INSERT INTO `forum_question_sector` VALUES ('1', '计算机科学与技术', '5');

-- ----------------------------
-- Table structure for `forum_reply`
-- ----------------------------
DROP TABLE IF EXISTS `forum_reply`;
CREATE TABLE `forum_reply` (
  `ReplyId` int(11) NOT NULL AUTO_INCREMENT,
  `TopicId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `ReplyText` varchar(1000) NOT NULL,
  `ReplyDate` datetime(6) NOT NULL,
  `ClickingRate` int(11) DEFAULT NULL,
  `PraiseCount` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT '0',
  PRIMARY KEY (`ReplyId`),
  KEY `Topic_2education` (`TopicId`),
  KEY `UserId_1education` (`UserId`),
  CONSTRAINT `UserId_1education` FOREIGN KEY (`UserId`) REFERENCES `USER` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of forum_reply
-- ----------------------------
INSERT INTO `forum_reply` VALUES ('1', '0', '4', '正好理一遍吧', '2018-12-20 15:47:39.000000', '1', '1', '0');
INSERT INTO `forum_reply` VALUES ('2', '17', '1', '测试一下评论', '2018-12-22 13:15:03.000000', '0', '0', '0');
INSERT INTO `forum_reply` VALUES ('3', '19', '1', '1', '2018-12-22 13:19:56.000000', '0', '0', '0');
INSERT INTO `forum_reply` VALUES ('4', '19', '1', '测试', '2018-12-22 14:28:28.000000', '0', '0', '0');
INSERT INTO `forum_reply` VALUES ('5', '19', '1', '测试', '2018-12-22 22:28:38.000000', '0', '0', '0');
INSERT INTO `forum_reply` VALUES ('7', '14', '1', '测试回复', '2018-12-08 17:36:00.000000', '0', '2', '0');
INSERT INTO `forum_reply` VALUES ('8', '14', '2', '测试回复', '2018-12-08 17:36:00.000000', '0', '2', '0');
INSERT INTO `forum_reply` VALUES ('10', '14', '7', '测试回复', '2018-12-08 17:36:00.000000', '0', '2', '0');
INSERT INTO `forum_reply` VALUES ('13', '23', '7', '测试回复数是否+1', '2018-12-11 00:00:00.000000', '0', '2', '1');
INSERT INTO `forum_reply` VALUES ('14', '22', '7', '测试回复数是否+1', '2018-12-11 00:00:00.000000', '0', '2', '1');
INSERT INTO `forum_reply` VALUES ('15', '23', '2', '十大', '2018-12-22 23:26:38.000000', '0', '0', '0');
INSERT INTO `forum_reply` VALUES ('17', '23', '7', '1223', '2018-12-22 23:43:17.000000', '0', '0', '0');
INSERT INTO `forum_reply` VALUES ('18', '24', '8', '范范棒棒哒！', '2018-12-24 20:49:24.000000', '0', '0', '0');
INSERT INTO `forum_reply` VALUES ('20', '24', '8', '范范棒棒哒！', '2018-12-24 20:49:36.000000', '0', '0', '0');
INSERT INTO `forum_reply` VALUES ('23', '17', '1', '评论测试', '2019-01-10 00:46:19.000000', '0', '0', '0');
INSERT INTO `forum_reply` VALUES ('24', '2', '1', '评论', '2019-01-10 01:30:23.000000', '0', '0', '1');
INSERT INTO `forum_reply` VALUES ('25', '2', '1', '测试评论', '2019-01-10 01:42:58.000000', '0', '0', '1');
INSERT INTO `forum_reply` VALUES ('26', '25', '1', '测试评论', '2019-01-10 02:20:48.000000', '0', '0', '0');
INSERT INTO `forum_reply` VALUES ('27', '3', '1', 'hello', '2019-01-10 15:11:29.000000', '0', '0', '1');
INSERT INTO `forum_reply` VALUES ('28', '3', '1', 'hi', '2019-01-10 15:11:35.000000', '0', '0', '1');
INSERT INTO `forum_reply` VALUES ('29', '27', '1', '回复回复', '2019-01-10 19:12:55.000000', '0', '0', '0');
INSERT INTO `forum_reply` VALUES ('30', '3', '1', '发表评论', '2019-01-11 14:03:04.000000', '0', '0', '1');
INSERT INTO `forum_reply` VALUES ('31', '3', '1', '评论', '2019-01-11 14:03:16.000000', '0', '0', '1');
INSERT INTO `forum_reply` VALUES ('32', '3', '1', 'pinglun', '2019-01-11 14:07:52.000000', '0', '0', '1');
INSERT INTO `forum_reply` VALUES ('33', '3', '1', 'pinglu', '2019-01-11 14:08:32.000000', '0', '0', '1');
INSERT INTO `forum_reply` VALUES ('34', '3', '1', 'pinglun', '2019-01-11 14:09:34.000000', '0', '0', '1');
INSERT INTO `forum_reply` VALUES ('35', '7', '1', 'pinglun', '2019-01-11 14:13:35.000000', '0', '0', '1');
INSERT INTO `forum_reply` VALUES ('36', '6', '1', '发表评论', '2019-01-11 14:13:48.000000', '0', '0', '1');

-- ----------------------------
-- Table structure for `forum_search`
-- ----------------------------
DROP TABLE IF EXISTS `forum_search`;
CREATE TABLE `forum_search` (
  `SearchId` int(11) NOT NULL,
  `KeywordId` int(11) NOT NULL,
  `SearchModeId` int(11) NOT NULL,
  `IsDesc` bit(1) NOT NULL,
  `IsBefore` bit(1) NOT NULL,
  `SearchDate` datetime(6) NOT NULL,
  `ClickingRate` int(11) DEFAULT '0',
  `SectorId` int(11) NOT NULL,
  `TopicId` int(11) NOT NULL,
  PRIMARY KEY (`SearchId`),
  KEY `KeywordId_education` (`KeywordId`),
  KEY `SearchModeId_education` (`SearchModeId`),
  KEY `SectorId_1education` (`SectorId`),
  KEY `TopicId_1education` (`TopicId`),
  CONSTRAINT `KeywordId_education` FOREIGN KEY (`KeywordId`) REFERENCES `forum_keyword` (`keywordid`),
  CONSTRAINT `SearchModeId_education` FOREIGN KEY (`SearchModeId`) REFERENCES `forum_searchmode` (`searchmodeid`),
  CONSTRAINT `SectorId_1education` FOREIGN KEY (`SectorId`) REFERENCES `forum_sector` (`sectorid`),
  CONSTRAINT `TopicId_1education` FOREIGN KEY (`TopicId`) REFERENCES `forum_topic` (`topicid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of forum_search
-- ----------------------------
INSERT INTO `forum_search` VALUES ('0', '0', '0', '', '', '2018-12-20 15:59:35.000000', '1', '0', '0');

-- ----------------------------
-- Table structure for `forum_searchmode`
-- ----------------------------
DROP TABLE IF EXISTS `forum_searchmode`;
CREATE TABLE `forum_searchmode` (
  `SearchModeId` int(11) NOT NULL DEFAULT '0',
  `SearchModeName` varchar(35) NOT NULL,
  PRIMARY KEY (`SearchModeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of forum_searchmode
-- ----------------------------
INSERT INTO `forum_searchmode` VALUES ('0', '标签');
INSERT INTO `forum_searchmode` VALUES ('1', '名字');

-- ----------------------------
-- Table structure for `forum_sector`
-- ----------------------------
DROP TABLE IF EXISTS `forum_sector`;
CREATE TABLE `forum_sector` (
  `SectorId` int(11) NOT NULL AUTO_INCREMENT,
  `SectorName` varchar(35) NOT NULL,
  `SectorType` int(11) NOT NULL,
  `SectorState` varchar(255) NOT NULL,
  `SectorLogo` varchar(255) NOT NULL,
  `ClickingRate` int(11) NOT NULL DEFAULT '0',
  `TopicCount` int(11) NOT NULL,
  PRIMARY KEY (`SectorId`),
  KEY `SectorType_education` (`SectorType`),
  KEY `SectorId` (`SectorId`),
  KEY `SectorId_2` (`SectorId`),
  CONSTRAINT `SectorType_education` FOREIGN KEY (`SectorType`) REFERENCES `forum_sector_type` (`sectortypeid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of forum_sector
-- ----------------------------
INSERT INTO `forum_sector` VALUES ('-1', '图形学', '1', '1', '1', '1', '1');
INSERT INTO `forum_sector` VALUES ('0', '软件工程', '1', '1', '1', '1', '1');
INSERT INTO `forum_sector` VALUES ('1', '计算机科学', '1', '1', '1', '1', '1');

-- ----------------------------
-- Table structure for `forum_sector_type`
-- ----------------------------
DROP TABLE IF EXISTS `forum_sector_type`;
CREATE TABLE `forum_sector_type` (
  `SectorTypeId` int(11) NOT NULL DEFAULT '0',
  `SectorTypeName` varchar(35) NOT NULL,
  PRIMARY KEY (`SectorTypeId`),
  KEY `SectorTypeName` (`SectorTypeName`),
  KEY `SectorTypeNameIndex` (`SectorTypeName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of forum_sector_type
-- ----------------------------
INSERT INTO `forum_sector_type` VALUES ('1', '信息');

-- ----------------------------
-- Table structure for `forum_sector_use`
-- ----------------------------
DROP TABLE IF EXISTS `forum_sector_use`;
CREATE TABLE `forum_sector_use` (
  `sectoruse_id` int(11) NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) NOT NULL,
  `sector_id` int(11) NOT NULL COMMENT '1',
  PRIMARY KEY (`sectoruse_id`),
  KEY `sector_use_id_1` (`sector_id`),
  KEY `sector_use_topic_id` (`topic_id`),
  CONSTRAINT `sector_use_id_1` FOREIGN KEY (`sector_id`) REFERENCES `forum_sector` (`sectorid`),
  CONSTRAINT `sector_use_topic_id` FOREIGN KEY (`topic_id`) REFERENCES `forum_topic` (`topicid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of forum_sector_use
-- ----------------------------
INSERT INTO `forum_sector_use` VALUES ('1', '0', '0');
INSERT INTO `forum_sector_use` VALUES ('2', '14', '0');
INSERT INTO `forum_sector_use` VALUES ('3', '15', '0');
INSERT INTO `forum_sector_use` VALUES ('4', '17', '0');
INSERT INTO `forum_sector_use` VALUES ('5', '17', '1');
INSERT INTO `forum_sector_use` VALUES ('6', '19', '0');
INSERT INTO `forum_sector_use` VALUES ('7', '22', '0');
INSERT INTO `forum_sector_use` VALUES ('8', '23', '0');
INSERT INTO `forum_sector_use` VALUES ('9', '24', '0');
INSERT INTO `forum_sector_use` VALUES ('10', '25', '0');
INSERT INTO `forum_sector_use` VALUES ('11', '25', '1');
INSERT INTO `forum_sector_use` VALUES ('12', '26', '0');
INSERT INTO `forum_sector_use` VALUES ('13', '27', '0');

-- ----------------------------
-- Table structure for `forum_sector_use_draft`
-- ----------------------------
DROP TABLE IF EXISTS `forum_sector_use_draft`;
CREATE TABLE `forum_sector_use_draft` (
  `sectoruse_id` int(11) NOT NULL AUTO_INCREMENT,
  `draft_id` int(11) NOT NULL,
  `sector_id` int(11) NOT NULL COMMENT '1',
  PRIMARY KEY (`sectoruse_id`),
  KEY `sector_use_id_1` (`sector_id`),
  KEY `sector_use_topic_id` (`draft_id`),
  CONSTRAINT `forum_sector_use_draft_ibfk_1` FOREIGN KEY (`sector_id`) REFERENCES `forum_sector` (`sectorid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of forum_sector_use_draft
-- ----------------------------
INSERT INTO `forum_sector_use_draft` VALUES ('7', '28', '0');

-- ----------------------------
-- Table structure for `forum_topic`
-- ----------------------------
DROP TABLE IF EXISTS `forum_topic`;
CREATE TABLE `forum_topic` (
  `publish_id` int(11) NOT NULL,
  `publish_type_id` int(11) NOT NULL COMMENT '0',
  `TopicId` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` int(11) NOT NULL,
  `sector_use_id` int(11) NOT NULL,
  `TopicTitle` varchar(35) NOT NULL,
  `TopicText` varchar(2000) NOT NULL,
  `TopicDate` datetime(6) NOT NULL,
  `ReplyCount` int(255) DEFAULT NULL,
  `ClickingRate` int(11) DEFAULT NULL,
  `PraiseCount` int(11) DEFAULT NULL,
  `favorite_count` int(11) DEFAULT NULL,
  `is_favorite` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`TopicId`,`publish_id`),
  KEY `Publish_topic_id` (`publish_id`),
  KEY `Publish_type_id` (`publish_type_id`),
  KEY `UserId_education` (`UserId`),
  KEY `TopicId` (`TopicId`),
  KEY `topic_sector_use_id` (`sector_use_id`),
  KEY `TopicId_2` (`TopicId`),
  KEY `TopicId_3` (`TopicId`),
  KEY `TopicId_4` (`TopicId`),
  KEY `TopicId_5` (`TopicId`),
  CONSTRAINT `Publish_topic_id` FOREIGN KEY (`publish_id`) REFERENCES `forum_publish` (`publish_id`),
  CONSTRAINT `Publish_type_id` FOREIGN KEY (`publish_type_id`) REFERENCES `forum_publish_type` (`publish_type_id`),
  CONSTRAINT `UserId_education` FOREIGN KEY (`UserId`) REFERENCES `USER` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of forum_topic
-- ----------------------------
INSERT INTO `forum_topic` VALUES ('0', '1', '0', '2', '0', '糟糕', '数据库怎么被删了', '2018-12-20 15:30:21.000000', '1', '4', '1', '1', '');
INSERT INTO `forum_topic` VALUES ('0', '0', '14', '1', '0', '宿舍', '<p>宿舍</p>', '2018-12-20 21:24:08.000000', '3', '9', '0', '0', '');
INSERT INTO `forum_topic` VALUES ('0', '0', '15', '1', '0', '答辩', '<p>哈哈哈，下周二要答辩了 开心。。。</p>', '2018-12-21 10:40:25.000000', '0', '11', '0', '0', '');
INSERT INTO `forum_topic` VALUES ('0', '0', '17', '1', '0', 'JavaEE答辩', '<p>今天要JavaEE答辩了，好紧张啊！还在写文档啊。</p>', '2018-12-21 21:59:40.000000', '2', '28', '1', '0', '');
INSERT INTO `forum_topic` VALUES ('0', '0', '18', '1', '0', 'JAVA-EE', '<p>要答辩了好激动</p>', '2018-12-22 12:20:48.000000', '0', '0', '0', '0', '');
INSERT INTO `forum_topic` VALUES ('0', '0', '19', '1', '0', '要答辩了好激动', '<p>答辩了答辩了&nbsp;&nbsp;&nbsp;&nbsp;</p>', '2018-12-22 12:21:23.000000', '3', '27', '0', '0', '');
INSERT INTO `forum_topic` VALUES ('0', '0', '20', '2', '0', '哈哈哈', '<p>呵呵</p>', '2018-12-22 22:59:04.000000', '0', '0', '0', '0', '');
INSERT INTO `forum_topic` VALUES ('0', '0', '22', '7', '0', '测试存自定义标签是否正常 from yapi', '测试是否正常 from yapi', '2018-12-10 00:00:00.000000', '20', '0', '0', '0', '');
INSERT INTO `forum_topic` VALUES ('0', '0', '23', '2', '0', '哈哈哈', '<p>呵呵</p>', '2018-12-22 23:05:25.000000', '2', '55', '2', '0', '');
INSERT INTO `forum_topic` VALUES ('0', '0', '24', '7', '0', '做项目好累啊', '<p>嘤嘤嘤</p>', '2018-12-23 23:37:36.000000', '2', '16', '1', '1', '');
INSERT INTO `forum_topic` VALUES ('0', '0', '25', '1', '0', '文章测试', '<p>测试测试测试</p>', '2019-01-10 02:08:58.000000', '1', '1', '0', '0', '');
INSERT INTO `forum_topic` VALUES ('0', '0', '26', '1', '0', '测试发表文章', '<p>输入文章内容</p>', '2019-01-10 02:17:53.000000', '0', '3', '1', '1', '');
INSERT INTO `forum_topic` VALUES ('0', '0', '27', '1', '0', '文章标题', '<p>文章内容<img src=\"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/ee/2018new_beishang_org.png\" alt=\"[悲伤]\" data-w-e=\"1\">&#128524;</p>', '2019-01-10 02:20:15.000000', '1', '7', '1', '0', '');

-- ----------------------------
-- Table structure for `resource`
-- ----------------------------
DROP TABLE IF EXISTS `resource`;
CREATE TABLE `resource` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `resourceID` char(100) NOT NULL,
  `uploaderID` int(11) NOT NULL,
  `categoryID` int(10) DEFAULT NULL,
  `resourceMajorID` int(10) DEFAULT NULL,
  `description` text,
  `resourceName` char(64) DEFAULT NULL,
  `uploadTime` char(40) NOT NULL,
  `points` int(11) DEFAULT '0',
  `tags` char(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `resource_id_uindex` (`id`),
  UNIQUE KEY `resource_resourceID_uindex` (`resourceID`),
  KEY `resource_USER_ID_fk` (`uploaderID`),
  KEY `resource_category_id_fk` (`categoryID`),
  KEY `resource_resourceMajor_id_fk` (`resourceMajorID`),
  CONSTRAINT `resource_USER_ID_fk` FOREIGN KEY (`uploaderID`) REFERENCES `USER` (`id`),
  CONSTRAINT `resource_category_id_fk` FOREIGN KEY (`categoryID`) REFERENCES `category` (`id`),
  CONSTRAINT `resource_resourceMajor_id_fk` FOREIGN KEY (`resourceMajorID`) REFERENCES `resourceMajor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of resource
-- ----------------------------
INSERT INTO `resource` VALUES ('2', '5c1a5427ccdcfd1cc4228730', '5', '1', '1', '课件', '软件工程11章课件', '2018-12-19 10:22:32', '1', '');
INSERT INTO `resource` VALUES ('3', '5c1a561dccdcfd1cc4228736', '5', '1', '1', '软工课件', '软件工程1课件', '2018-12-19 10:30:54', '2', '软件工程');
INSERT INTO `resource` VALUES ('4', '5c1c51c8eacaa52ddb116034', '6', '1', '1', '作业', '计算机图形学', '2018-12-21 10:36:57', '1', '思考题');
INSERT INTO `resource` VALUES ('5', '5c1ceecd8f3d17404866ba6d', '7', '1', '1', '这是2018-2019学年度，秋季学期JAVAEE课程第一讲课件', 'JavaEE课件', '2018-12-21 09:46:55', '1', 'JavaEE 软件工程 计算机 课程文档');
INSERT INTO `resource` VALUES ('7', '5c1fa4b18f3d170b44460559', '7', '2', '1', 'slides presented by Tongji Univ.', 'SE_04', '2018-12-23 11:07:29', '1', 'SE');
INSERT INTO `resource` VALUES ('9', '5c2096e78f3d173adc7fa05b', '7', '2', '1', 'slides presented by Tongji Univ.', 'SE_05', '2018-12-24 04:20:55', '1', '');
INSERT INTO `resource` VALUES ('11', '5c20d5138f3d173adc7fa064', '8', '2', '1', '棒棒哒', '编译原理', '2018-12-24 08:46:12', '5', '编译原理');
INSERT INTO `resource` VALUES ('12', '5c22f886d2f55f8528144986', '7', '2', '1', '同济大学软件工程课程讲义-第十章', '软件工程课件Chapter10', '2018-12-26 11:42:06', '5', '软件工程');
INSERT INTO `resource` VALUES ('13', '5c22fa80d2f55f8528144992', '7', '2', '1', '编译原理课程', '编译原理课件', '2018-12-26 11:50:25', '4', '编译原理 课件');
INSERT INTO `resource` VALUES ('14', '5c24c5bb5906ca239811763c', '10', '2', '1', '', '大学学术资源共享平台的构建', '2018-12-27 08:29:47', '5', '');
INSERT INTO `resource` VALUES ('15', '5c37337e90aa9e515a3933a6', '2', '2', '1', '计算机组成原理 第一章课件', '计算机组成原理 第一章课件', '2019-01-10 07:58:55', '3', '计算机 组成原理');
INSERT INTO `resource` VALUES ('17', '5c385a6790aa9eeefbb72036', '2', '2', '1', '计算机组成原理课件棒棒哒', '计算机组成原理第十章', '2019-01-11 04:57:12', '5', '组成原理 计算机');
INSERT INTO `resource` VALUES ('18', '5c385cd790aa9eeefbb7203b', '11', '2', '1', '老杜棒棒哒！', '计算机组成原理第六章', '2019-01-11 05:07:42', '1', '计算机 组成原理');
INSERT INTO `resource` VALUES ('19', '5c38623690aa9eeefbb7205c', '11', '2', '1', '杜老师棒棒哒', '计算机组成原理C8', '2019-01-11 05:30:34', '5', '计算机');

-- ----------------------------
-- Table structure for `resourceComment`
-- ----------------------------
DROP TABLE IF EXISTS `resourceComment`;
CREATE TABLE `resourceComment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) DEFAULT NULL,
  `resourceID` char(100) DEFAULT NULL,
  `comment` char(128) DEFAULT NULL,
  `commentTime` char(20) DEFAULT NULL,
  `score` int(11) DEFAULT '3',
  `commentTitle` char(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `resourceComment_id_uindex` (`id`),
  KEY `resourceComment_USER_ID_fk` (`userID`),
  KEY `resourceComment_resource_resourceID_fk` (`resourceID`),
  CONSTRAINT `resourceComment_USER_ID_fk` FOREIGN KEY (`userID`) REFERENCES `USER` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resourceComment_resource_resourceID_fk` FOREIGN KEY (`resourceID`) REFERENCES `resource` (`resourceid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of resourceComment
-- ----------------------------
INSERT INTO `resourceComment` VALUES ('1', '7', '5c1a561dccdcfd1cc4228736', '楼主棒棒哒，给楼主点个赞！', '2018-12-21 10:38:04', '5', '点赞');
INSERT INTO `resourceComment` VALUES ('2', '7', '5c1a561dccdcfd1cc4228736', '资源很实用谢谢楼主！', '2018-12-21 10:39:49', '4', '给个鼓励');
INSERT INTO `resourceComment` VALUES ('3', '7', '5c1ceecd8f3d17404866ba6d', '棒棒哒！', '2018-12-22 11:45:08', '5', '范老师课程讲的好，说话又好听');
INSERT INTO `resourceComment` VALUES ('4', '7', '5c1ceecd8f3d17404866ba6d', '', '2018-12-23 11:35:23', '4', 'nice');
INSERT INTO `resourceComment` VALUES ('5', '8', '5c1ceecd8f3d17404866ba6d', '范范棒棒哒！', '2018-12-24 08:39:30', '5', '范老师棒棒哒！');
INSERT INTO `resourceComment` VALUES ('6', '9', '5c20d5138f3d173adc7fa064', '棒棒哒', '2018-12-25 10:21:51', '5', '棒棒哒');
INSERT INTO `resourceComment` VALUES ('7', '7', '5c2096e78f3d173adc7fa05b', '测试', '2018-12-26 11:46:08', '5', '测试');
INSERT INTO `resourceComment` VALUES ('8', '7', '5c2096e78f3d173adc7fa05b', '测试发布评论后刷新', '2018-12-26 11:47:58', '5', '测试发布评论后刷新');
INSERT INTO `resourceComment` VALUES ('9', '7', '5c2096e78f3d173adc7fa05b', '测试发布', '2018-12-26 11:48:44', '5', '测试发布评论刷新');
INSERT INTO `resourceComment` VALUES ('10', '7', '5c2096e78f3d173adc7fa05b', '测试', '2018-12-26 11:49:45', '5', '测试清空字段');
INSERT INTO `resourceComment` VALUES ('11', '2', '5c385a6790aa9eeefbb72036', '我们棒棒哒', '2019-01-11 04:58:44', '5', '棒棒哒');
INSERT INTO `resourceComment` VALUES ('12', '11', '5c385a6790aa9eeefbb72036', '人好看声音又好听，给分好点更好了hhh', '2019-01-11 05:06:10', '5', '阿杜萌萌哒！');
INSERT INTO `resourceComment` VALUES ('13', '11', '5c38623690aa9eeefbb7205c', '给分好一点', '2019-01-11 05:32:38', '5', '杜老师棒棒哒');

-- ----------------------------
-- Table structure for `resourceMajor`
-- ----------------------------
DROP TABLE IF EXISTS `resourceMajor`;
CREATE TABLE `resourceMajor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resourceMajorName` char(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `resourceMajor_id_uindex` (`id`),
  UNIQUE KEY `resourceMajor_resourceMajorName_uindex` (`resourceMajorName`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of resourceMajor
-- ----------------------------
INSERT INTO `resourceMajor` VALUES ('3', ' Java应用');
INSERT INTO `resourceMajor` VALUES ('29', '临床医学');
INSERT INTO `resourceMajor` VALUES ('13', '化学');
INSERT INTO `resourceMajor` VALUES ('4', '历史学');
INSERT INTO `resourceMajor` VALUES ('6', '哲学');
INSERT INTO `resourceMajor` VALUES ('20', '土木工程');
INSERT INTO `resourceMajor` VALUES ('25', '地球物理');
INSERT INTO `resourceMajor` VALUES ('10', '地质学');
INSERT INTO `resourceMajor` VALUES ('5', '外语');
INSERT INTO `resourceMajor` VALUES ('26', '天文学');
INSERT INTO `resourceMajor` VALUES ('23', '应用数学');
INSERT INTO `resourceMajor` VALUES ('19', '建筑学');
INSERT INTO `resourceMajor` VALUES ('31', '护理学');
INSERT INTO `resourceMajor` VALUES ('7', '政治学');
INSERT INTO `resourceMajor` VALUES ('11', '数学');
INSERT INTO `resourceMajor` VALUES ('22', '机械工程');
INSERT INTO `resourceMajor` VALUES ('27', '核物理');
INSERT INTO `resourceMajor` VALUES ('8', '海洋工程');
INSERT INTO `resourceMajor` VALUES ('14', '物理');
INSERT INTO `resourceMajor` VALUES ('9', '环境工程与科学');
INSERT INTO `resourceMajor` VALUES ('28', '生命科学');
INSERT INTO `resourceMajor` VALUES ('17', '电子信息工程');
INSERT INTO `resourceMajor` VALUES ('18', '电气信息工程');
INSERT INTO `resourceMajor` VALUES ('2', '算法设计');
INSERT INTO `resourceMajor` VALUES ('12', '统计学');
INSERT INTO `resourceMajor` VALUES ('30', '药剂学');
INSERT INTO `resourceMajor` VALUES ('24', '计算机科学');
INSERT INTO `resourceMajor` VALUES ('21', '车辆工程');
INSERT INTO `resourceMajor` VALUES ('1', '软件工程');
INSERT INTO `resourceMajor` VALUES ('16', '通信工程');
INSERT INTO `resourceMajor` VALUES ('15', '金融学');

-- ----------------------------
-- Table structure for `suggestedResource`
-- ----------------------------
DROP TABLE IF EXISTS `suggestedResource`;
CREATE TABLE `suggestedResource` (
  `id` char(50) NOT NULL,
  `userID` int(11) DEFAULT NULL,
  `resourceID` char(100) DEFAULT NULL,
  `suggested` int(10) DEFAULT NULL,
  `suggestTime` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `suggestedResource_id_uindex` (`id`),
  KEY `suggestedResource_USER_ID_fk` (`userID`),
  KEY `suggestedResource_resource_resourceID_fk` (`resourceID`),
  CONSTRAINT `suggestedResource_USER_ID_fk` FOREIGN KEY (`userID`) REFERENCES `USER` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `suggestedResource_resource_resourceID_fk` FOREIGN KEY (`resourceID`) REFERENCES `resource` (`resourceid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of suggestedResource
-- ----------------------------
INSERT INTO `suggestedResource` VALUES ('105c24c5bb5906ca239811763c', '10', '5c24c5bb5906ca239811763c', '1', '2018-12-27 10:06:47');
INSERT INTO `suggestedResource` VALUES ('115c385a6790aa9eeefbb72036', '11', '5c385a6790aa9eeefbb72036', '1', '2019-01-11 05:05:30');
INSERT INTO `suggestedResource` VALUES ('115c38623690aa9eeefbb7205c', '11', '5c38623690aa9eeefbb7205c', '1', '2019-01-11 05:32:25');
INSERT INTO `suggestedResource` VALUES ('25c1ceecd8f3d17404866ba6d', '2', '5c1ceecd8f3d17404866ba6d', '1', '2019-01-10 08:01:03');
INSERT INTO `suggestedResource` VALUES ('25c22fa80d2f55f8528144992', '2', '5c22fa80d2f55f8528144992', '1', '2019-01-10 07:58:11');
INSERT INTO `suggestedResource` VALUES ('25c37337e90aa9e515a3933a6', '2', '5c37337e90aa9e515a3933a6', '1', '2019-01-11 04:58:55');
INSERT INTO `suggestedResource` VALUES ('55c1a5427ccdcfd1cc4228730', '5', '5c1a5427ccdcfd1cc4228730', '1', '2018-12-19 10:23:57');
INSERT INTO `suggestedResource` VALUES ('75c1ceecd8f3d17404866ba6d', '7', '5c1ceecd8f3d17404866ba6d', '1', '2018-12-21 09:53:54');
INSERT INTO `suggestedResource` VALUES ('75c22fa80d2f55f8528144992', '7', '5c22fa80d2f55f8528144992', '1', '2018-12-26 12:08:48');
INSERT INTO `suggestedResource` VALUES ('85c1ceecd8f3d17404866ba6d', '8', '5c1ceecd8f3d17404866ba6d', '1', '2018-12-24 08:38:57');
INSERT INTO `suggestedResource` VALUES ('95c20d5138f3d173adc7fa064', '9', '5c20d5138f3d173adc7fa064', '1', '2018-12-25 10:21:29');

-- ----------------------------
-- Table structure for `USER`
-- ----------------------------
DROP TABLE IF EXISTS `USER`;
CREATE TABLE `USER` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USERNAME` varchar(255) NOT NULL,
  `PASSWORD` varchar(2048) NOT NULL,
  `EMAIL` varchar(255) NOT NULL,
  `ADMISSIONYEAR` varchar(20) NOT NULL,
  `STUDENTID` varchar(50) NOT NULL,
  `GENDER` varchar(10) NOT NULL COMMENT 'male/female',
  `BIRTHDAY` varchar(50) NOT NULL,
  `UNIVERSITYID` int(10) unsigned NOT NULL,
  `MAJORID` int(10) unsigned NOT NULL,
  `POINTS` int(10) unsigned DEFAULT '100',
  `IMAGE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `USER_USERNAME_uindex` (`USERNAME`),
  KEY `USER_education_university_univid_fk` (`UNIVERSITYID`),
  KEY `ID` (`ID`),
  KEY `ID_2` (`ID`),
  KEY `ID_3` (`ID`),
  KEY `ID_4` (`ID`),
  KEY `ID_5` (`ID`),
  KEY `ID_6` (`ID`),
  KEY `ID_7` (`ID`),
  CONSTRAINT `USER_education_university_univid_fk` FOREIGN KEY (`UNIVERSITYID`) REFERENCES `education_university` (`univid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of USER
-- ----------------------------
INSERT INTO `USER` VALUES ('1', '还好', '1', '77@qq.com', '2016', '123', 'male', '2019-6-01', '1', '1', '100', 'https://tjce-image.oss-cn-beijing.aliyuncs.com/20181204205454618web.jpg');
INSERT INTO `USER` VALUES ('2', 'qibatu', '$2a$10$7Q9C1Gs3Y.Uzy3O6lSBuJ.VUnNbQXsoXUd4C54da1/KXmnFMgW/bG', 'qibatu@outlook.com', '2016', '1655555', 'male', '2018-09-09', '1', '1', '90', 'https://tjce-image.oss-cn-beijing.aliyuncs.com/20181204205454618web.jpg');
INSERT INTO `USER` VALUES ('3', 'chloe', '$2a$10$1uMhU3Gce9a1YhImi7YioOsOjITAfgaUTGzn1a13epwZk0QTRnQ0y', 'chloe@outlook.com', '2016', '1655555', 'male', '2018-09-09', '1', '1', '97', 'https://tjce-image.oss-cn-beijing.aliyuncs.com/20181204205454618web.jpg');
INSERT INTO `USER` VALUES ('4', '丽丽', '$2a$10$HxU.y60PaoGpo00lxaPdYuEbMg9krkLGAewUDf2FtILYPPwEHuPUC', '122222@qq.com', '2010', '123132', 'male', '2018-1-01', '1', '1', '100', 'https://tjce-image.oss-cn-beijing.aliyuncs.com/20181204205454618web.jpg');
INSERT INTO `USER` VALUES ('5', '林志玲', '$2a$10$Fz5CylW3n5FZhMy6CRilPOkvMOyPZOuwDo2uoKz9GIQ7dkun/PXYy', '87923984@qq.com', '2015', '1234567', 'female', '2019-7-01', '1', '6', '101', 'https://tjce-image.oss-cn-beijing.aliyuncs.com/20181204205454618web.jpg');
INSERT INTO `USER` VALUES ('6', '李文渊', '$2a$10$upRFEJ6gGr4nv7igtbo7WOMWeLkUzbfXB8pTc65Ku4wrhqmwsKlxq', '12334444@sina.com', '2016', '1553530', 'male', '1998-2-01', '1', '1', '100', 'https://tjce-image.oss-cn-beijing.aliyuncs.com/20181204205454618web.jpg');
INSERT INTO `USER` VALUES ('7', '肉沫拌豆腐', '$2a$10$K5R21ZQbs8Gs6Vy2fo3yPutuxzzyt0gmQbxzQOZYgM6bj1r2NgJMi', '12345678@sina.com', '2016', '1553530', 'male', '2000-1-01', '1', '1', '113', 'https://tjce-image.oss-cn-beijing.aliyuncs.com/20181204205454618web.jpg');
INSERT INTO `USER` VALUES ('8', '吴彦祖', '$2a$10$mtkXaklrawkcNckXj/XA1uhvaXB79YmQU0tkEZOVCCOC92iZzuNc6', 'wuyanzu@sina.com', '2016', '1651111', 'male', '1997-11-01', '1', '1', '104', null);
INSERT INTO `USER` VALUES ('9', '彭于晏', '$2a$10$SuLi0zt5gK4PT9UKF/ypJO2BG.Tkhregq/SDGAmneJ0QSI2wFQyNC', '987867@qq.com', '2010', '162573', 'male', '2018-2-01', '1', '1', '95', null);
INSERT INTO `USER` VALUES ('10', 'chen', '$2a$10$wQs7k1vg0bf0ct0dAU7T8Otnq8UNg9ThoDYWrGqTRhz3gjsBizrXy', '1234@163.com', '2015', '1552707', 'male', '1998-4-01', '1', '1', '105', null);
INSERT INTO `USER` VALUES ('11', '徐熙娣', '$2a$10$FJAvMVZH.yyWyFKMOr6fJepz9ka1Qoe2qzUk9ejNLCRnAv.CswAWS', '123456@sina.com', '1983', '1652673', 'male', '2014-11-01', '1', '1', '95', null);

-- ----------------------------
-- Table structure for `USER_AUTHORITY`
-- ----------------------------
DROP TABLE IF EXISTS `USER_AUTHORITY`;
CREATE TABLE `USER_AUTHORITY` (
  `USER_ID` int(11) NOT NULL,
  `AUTHORITY_ID` int(11) NOT NULL,
  PRIMARY KEY (`USER_ID`,`AUTHORITY_ID`),
  KEY `USER_AUTHORITY_AUTHORITY_ID_fk` (`AUTHORITY_ID`),
  CONSTRAINT `USER_AUTHORITY_AUTHORITY_ID_fk` FOREIGN KEY (`AUTHORITY_ID`) REFERENCES `AUTHORITY` (`id`),
  CONSTRAINT `USER_AUTHORITY_USER_ID_fk` FOREIGN KEY (`USER_ID`) REFERENCES `USER` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of USER_AUTHORITY
-- ----------------------------
INSERT INTO `USER_AUTHORITY` VALUES ('1', '1');
INSERT INTO `USER_AUTHORITY` VALUES ('2', '1');
INSERT INTO `USER_AUTHORITY` VALUES ('3', '1');
INSERT INTO `USER_AUTHORITY` VALUES ('4', '1');
INSERT INTO `USER_AUTHORITY` VALUES ('5', '1');
INSERT INTO `USER_AUTHORITY` VALUES ('6', '1');
INSERT INTO `USER_AUTHORITY` VALUES ('7', '1');
INSERT INTO `USER_AUTHORITY` VALUES ('8', '1');
INSERT INTO `USER_AUTHORITY` VALUES ('9', '1');
INSERT INTO `USER_AUTHORITY` VALUES ('10', '1');
INSERT INTO `USER_AUTHORITY` VALUES ('11', '1');

-- ----------------------------
-- Table structure for `userICON`
-- ----------------------------
DROP TABLE IF EXISTS `userICON`;
CREATE TABLE `userICON` (
  `userID` int(11) NOT NULL,
  `icon` text,
  PRIMARY KEY (`userID`),
  CONSTRAINT `userICON_USER_ID_fk` FOREIGN KEY (`userID`) REFERENCES `USER` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of userICON
-- ----------------------------
INSERT INTO `userICON` VALUES ('5', '_9j_4AAQSkZJRgABAQAAAQABAAD_2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj_2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj_wAARCAFoAWgDASIAAhEBAxEB_8QAHAAAAgIDAQEAAAAAAAAAAAAAAQIAAwQFBgcI_8QATBAAAQMDAgQCBQYLBQcEAwEAAQACEQMEIQUxEkFRYQZxExQigZEjMqGxwdEHFRYzQlJygpLh8CQlNWJjNFNzg5Oy8URFVFVDZMLS_8QAGQEBAQADAQAAAAAAAAAAAAAAAAECBAUD_8QAJxEBAAIBAwQCAgMBAQAAAAAAAAECEQMSURMhMTIUQQQzIkJSYXH_2gAMAwEAAhEDEQA_APdUVjDUrAnF3R_iTC-sycXVH-MLTy2MSu5ogKoXVqdrmj_GE4r252r0j--FcwYk6kICpSO1Wmf3gnDmR89vxCZTBYRCf2f1m_FEAdQmTCDdEBMG4RDeqZATAwjwlFreqygQJmohuU4bCoiIRATBpUygBOCgGlMBhUEJgSOaABTNElMhmlMCgG4RjZTIcHCYOSRCcBUNPdEFABGEQQU0pYURDzhLKiiAhyhcgghgZQlRBFSUCVClMoqcSVz1EhRUcSkLoCj0hUyiEylJUJgJCZTKoXSkJUKVxVEJUSOKiD5pb4wrfpaW73VQrB4xIIB0ytHaoFzZMZEKTvlZdKrQ-Xqcun_LEASdOufc9pVjfGNPH9gux7x965TiChep0ar8u7sG-MqI3srye0H7U7fG1uMi0vv4f5rjRUhH0hnJwnRqy-Zd2o8e2bXZoX4_c_mrqfj_AE8ES2_H_LK4IvzMp-Ix_NSdCp8270Rvj_T2nNS-ae9Mq5n4QdNnNzeN7mm5ea8aAJMwVPj1X5t-HqLPwjaUDHr9yCP9Nyub-EfSuWqVeuWO-5eU8QAge9FpEzAToV5X5tuHrlP8I2kkCdYePMOH2LIp_hG0oxGttnlM_cvHuMCMD4KcYgDhaAOynx45Pmzw9pZ-EPTjka3RjuVaPwhWEiNbtve4LxEvEYDfgg3g5sYfNoT4_wD1lH5vMPdWeP7M4Gs2nvcFczx3bESNWsiP22rwQspHemwju0IFlGR8jS_gCdD_AKfOj_L6Db43pnbUrE_vNVrfGucXtk799v3r51NOhzoUp_ZCBpW5P-z0_wCFOhPJ82v-X0i3xm4jFezP7w-9XN8XvOz7V3k8fevmhtK1Ej1en8FBRt-VFoHYn706NuSPzaf5fTY8WVDu23Pk7-aub4rqkfmaR_eXzB6OiPmsIx-i9w-1MKbCZD6w8qrh9qnRv9WPmafD6gHiup_8dh8nJh4rfztR_Evl_hgYr3I54rv-9KXv_Rvb5v7Ny771elflfl6X3D6l_KzraH-JH8rWAZtXfxL5bbVugRwanqIj_wDYcrW3l-0Q3VtR_wCsTCdK_KfK0uH1APF9EfOtn_EJvyvtp_2er9C-X_xhqg-brWo_9Qfcj-NtZbHDrl-PNwP2J09Tlfk6XD6hHi-z3NGr9CI8XWHOnVHuXzC3WdbDf8eu5_ZafsTs1zXARxa5VI70mlNmpysfkaMvpo-L9N5-lH7qI8XaXzfUH7q-Zxr-uNGNXDv2qDUG-I9d_wDsaR87cJs1F-Rovpn8rtI51nj90qHxdo__AMk_wFfNDfEutSJvbYmeduPvVg8R6mT7V1aHsaBH1FTbqLGvpT9vpI-LdGgkXXu4SgPFWivE-usaehBXzafEOo_76yPf0bh9qR_iG_5eovx0cMpt1F62ly-lj4k0U7ahS96n4_0c7ajb_wAS-ZB4i1E70bLz4nJvx9dkZo2nkKh-5Nt-F62ly-mRrOlO_wDcLb-MI_jfTDtqFt_1AvmV2t3MwLe1d5Vj9yr_AB_cF0OsqfmK38k234Opp8vqCleW1ySLa5pVSMkMcCiXZXiXg69dS13TawcafpHAOaDyI2Xs4eHCQrWZnyznH0clRJKiyR8lz3MIgyqmuJ5xzTyIxIXs40GJKUujKUOxugeU555RTE7dUZSclAgcHKYGeqrRBgFA_HBhNxxsqSYRaUFs9UQ7uqyYKgcgsLzKgcqyeSbfsgbi7wmDphVzvCM9Ags4o5eSBfCRxhJxGOyCwOJRn6VSCm4s5RD8YlQGNoMpJlQFBaHH3Jg4BUymBQO509ksxlLPdAnKBycdVA5JugcCSgs4sIceUhPbKEyQiLeJAujr8VXMbKEoG4jzRL-5VZKUuQOX5hKTJSThTaCRjkY3RTcSnH3VbjhLOURYHRMT8UpcSkLiAhKKsJjKDXkGT1Sz0STOEHonhx0Xulk_7xh-le5WjvkwvB_Dzi650sj9dn1r3OzM0h5LUjzLsV9YZZdKiWVFmr5Lx1R4uu_JL0lAjMrYcWDF3ZCfpyg2ZzkKSR5IyO1Ed0rTlEn4oGkBTmkkgI_BARyTAJQE09eaAkJThD3qTnsgduYiSTsBzWZe0KdqylT4i65yasRwt6Dz6rEt6j6VanUpAF7XAgESCVnauKZr020qYpVYmqOMuaHHz2QY1rSqXNwyhSBL3mAsrVGW9CqyhbHiNMQ9_wCs5ZlZtCw0-nQsorXlcw-4G8DcM6DlPNaYATCGEccRKWpTqUuE1GOaHCWyIlbFjqOnt9ISyveH5rN2Uu56nsmDn3Gg3dxcvNSobum1pdy9h5MfQhhqyYE_UoClKk9UQwKkzhLKgKDIt6FSu8ik0EtEkzACyDaQ2oPWKJqMBcWAkyAsNuxys22ilp9xcu-dU-Qp_W4_DHvRWJIbug8OADoIadipxAzC2NehUqaVYFjPkwHEuPd38kIjLFubd9sWioWniaHiDyKocDwgkHhOxjdZlv6OpWFa9c-pbUYY6P0zHstHbHwRrPrapWY6oWsaDwtDWw1o6AIu1gk45pfNXXtNlvc1KVJ5exhjiIhY5JIkIxNzUnullQ522REJBiDsgT2lAkhAlBCrXXNZ9tTt3vmjTJLWkbE7q-1t7KrS47q_NAgkGm2iXuI7cvirn3On2zeGysfTu_3147iPmGtgD3yixDWHaNk9Wg6nQpVC4H0kwOYgwqqji4k4BOYAwt1eW9qzT7Opc13ek9EOGhTGSTJkk7BFiMtRUpw8NpuNT2eIwNsSfgqowt_olNr7PU30mcV0-nwU2Ny4A4MfFaGqx1N7m1Glj2mC1w2KGMAl5ozICEhEd14dPy2mH_UZ9a92sz8i2Oi8E8OO_wANP-oz_uXvNkZpBan9pdivrDKnqokUWavk-R3TDZDA3S8U7HcLYcbA7odBumAlAlFQHONkfNAbYR5d0BJOUOW5U5lTcIGBxhEndKO2ynIYQE7Ie9ECZ5IEBBdY1_QXdKqWh4puB4TzWTfMaCytTe6pTrAuBeIcM5BWuccd1udftvU6llQDpaLZrsHckkk_H6kDaff0mtt6QoH04cGelJw1nESYHUytZUIFR8fN4isvR6NN9avWquhtvSNWJicgD61gE5MYRcthU0qq3S6F6x3FTqBznSOEMgwBPMlWVz6Pw5YUwTxVK9Wq7yAa0fUVh1by4q29CjVrPfRogimwnDZ6LKvzxabpkbBlT_v_AJojXnAwUp2TGAl-1AqYbA5lA8lJgIjKs6lGn6R9an6ZwA4GEw0nvC3Va5rcYpVGU2WdGkBVHAA3iIkgd9lq9PsHvAr3L6dCg0hw9IYL-wHRXX9xbV6xfXrPrNBJDKLeBo8ifrhFhrSeFvdbm7eLtljTrveHmiwMDAA0EuO_uWouazHgClR9GzoXcRPvWx1Attr-1DyQGUqRMcsAosSy_wAVB1WnaOeGspFxPEeH0rzPsjvACx69SpY0HPrUzTu3kspUoj0Ldi6Op2HxVesao-91R1zS4WMa6abQMecHqrHanR1Nhp6uS24b-aumN-b_AJXN5jvuEXMNO49clLKLgJjB8tkhRhIgyMIzskGMgZRwiCT0hKd0UMIGosdVrMZTbxVHODWjqTstnrTA-vUZa05t7JraLntGCeZPmZWPpVenavrXLiPTU2cNEdHnHF7hJWPQuqtuahpu_OsLHg5DgeoRlHhj-7dbW8q29K7pG7t33DBbsAY2pwZ4RuYWrcnu65uKpe4AYAgdhCGcNvUfTsLO9faVRTfXe2k1jHSWtAk537LXaoHitRFV_HV9E0vd1JH3QsJW1rqpVospVDxNp4aSMgdJ6IZyq2HVA56KThAIjtPDh9jTu1Rn_cvebE_It8l4H4dM07A8_St_7l7zYmaLVqf2l16ekM1RBRZsnyjvupvEdUCczlQFbDjmBxnKVwzsmB3Ud3CBBj4Ik7TshOYRlAT7lNwAgM7IjogJ2wcdUWkSEszlQH-ggtmOiU43hDkoYMoEKcuc75xO0BV_WiD2QNMH6PNSSce9ASoSeqBxtlXOq1H0qdNzyadMktb0nf6gqWJ2z2QBxO-EnFlO_Yqvn2QEoA8kHHpKEicoLXOc4guJJAjJ5IOBBgiDvlZen02tp1LuuJo0cNadqlQ_Nb9p7BY1Wq-q91Sq7ie_JKBeQlW3NepXfx1XcToAmOgwqhyRa0vcGsBc4mABkkoFJIQJ2T16NW3eG16b6bt4e2JVcoCDMqHKE4QcSNkBnKE8kvXOJRRMDvzUKihBGHBzTzCKEYxujuiOiLR5IEhBOYlKcIEIjKQq1-2ypJ_qUEygTnzQJ-KkSY5IOy0Axb2G_wA9v_cF7zp5-RC8I0b_AGbTwf8AJ9a9000_It8lqR7S69fSGeCogOqizV8onyU2xMok5IA7ITK2HHM05zlEnfEpWuzsm890Fc5PIIyFCNsobbICDmEyATAiECwCd8pm4G6DsxgSgDMILGoO27oNI257okYH3oEnrCkqHbmkmDnZBYTHPdTEQkBxEfFMCCgZvJWB0dlUDtKYGep8kDu2VZ3RcY5hVmORQM6ZVbj8T0TO-aEtPhFRpdsHBBuL6lWdSpWttQqPpW7Q6qWNJ9siST9AWtWxqG9bqdVtB9Vk1OMEEgR-t5QsXUara19Xq0o4XOMEDBQWUrXj065ujU4fRVKdNrI-cXBx37cKx6dV9Go2pReWVGmQ4ck4uo002vCZNYVSfJsAfSVRODGQgy6j6j9MaKz3O-VHo-IzAg8X2LCK2l7Y3NSzt7ilRL7QUxDmEGDzkcsrVTB6oG5JSMKAySrberTp1Q6tS9KyCOGY5IBb29auSKNNz_IYHvSmQTO4wQmrXdatDS8tpjAa3ACpB75KB_NNUqOqOl5JJwZSfRKgInJ5IHlQTCUGMlKXwAJwEDkoE98qsukSl4sIqyoYPfpKocoXDlJSudhBCVJSEnkoCYwfoRYdvozmus7Ej9HhB-K900wj0AXhGitDbCzjchpPxXumm_mWrTj2l1q-kNiCFFW05UXoPlaUu8AJo2KHvWw5GDAzJKKHu8kY8kQpjM4QUeMwgMlA4g-eyI3SbFMOmEWDOM9Ek7dU5-Z3lLvP1IuDs3TP-aqxgjkmJQwQ5Se9O4qs7nKGBnAlGTySTJ3jumbLSefkhiFg2AmUZ2KAO2d1JiJRcI4iClA7So507hAHESjA0exHMFVkJp9kiUs4QXi6ualEURUqvpjHCCTCU8bDwua5s9RCus9TvLKi6ja13UmPdxODQJJjqsmve3N1pZN5WNUisPRl24weLPwRYYKIwkBwskWx_FxuuNsGr6LgjO0yUXDHy0nhcQecGJSbFbi5qW2nWbbe0FOveVGzWrn2gz_Kz7StNPKcoxnsY9UD0AQB3UJ-CATE4RDsJXHolBzCGF0qbqoEpmEzCLB34aqc7SCrX7KmYlBC6JygSc74QJHJDBQR09UvZElL3QTqpKUlQlCHcaQf7BaEdG_WvcNL_MN8l4VoTp0uhnA5-9e56WfkG-S1P7S61fSGxBUSgqLJXy45pDsqs-azbhreMjZw-lYj2xvnyWw5cxggdHmrAdjuqhuFYBjqqxwDzKrB952Vjhtv8Em22UXCCe6dmISfamaI2QWO-Z70k_Qmn2Uk8z9SBhyyoTufMpJ2Tu6dUFb3c0vFzRcMSY80gMx9CIYHsmYSlM8lJ5c0SF0yNp8lJ-5AbCDCB5oyDvhCc7e9H6Un6RgIxysbkEdUhxlQHmgc-SJAGRke5bC_-RZbWuAadMOf-07J-iFhWzDVuqFLYPe1p8pV-o1jU1O4qCPzhg9gcIqkD2iJhbPSHNNV1tVzQrw13-V3J39clrA4lxLskmSthp9RlKqH1GekAaSGh0ZRWDWpmjVqUnwHMcWmNpBVc-15J69Q1Xue4iXuLj5qolEOfNCd4UED_wApTsgDj_4Qnuo7bshPtIDlEOMSEp6YRnkeXRBd86nJEKgnKtY72TBCpcZJQLPbzRPU_WlmTHVToghk-_kkOyY5wl-pBFJg5QzP3oEzz80IdrorQzSLcgzLZ-le46Sf7OzyC8K0CqH6VTABHB7Pvle5aQf7NTk8gtT-0urT0hswZUSgqKq8AvdPD59CzA5k7rUVrdzKhAEkbrp6NxSqAcZHC4YhZVAWgYS-k0le0Wa9tKJcFUbwOzsVG7b_ABW-1i0pVnF1Bga6MZWlNFzB7YjKzicta9JrKtwMbKrYkzzVzuYwqlWASQrJx26qsgkwi3EzhEXGDTKqcYACLTDDKDtgeSKO28qcgo0yeo7on6UCPO-0Dmk8k7-RVbsoxGeyLckJZCIIBiEFgII5ShOe6APmOSWUXJwTuUJ3gqT8ECeSMRlKTH81HGUoeWPDmmCCCEU2eQJjogBk8Ug9Fe7VL0kl1y-e0BZetVHmnp7K7uK5bbg1Sd_aJIB8hHxRcNcDkZWbRdw79CsS0ZTrXdKlWrMt6b3Q6q8EhncgZWyr2AoXNKnSuqVzQq4p3FMENdmNjkQitaYhIYW__FVHThXudX46lNlR1KhQaeE13Dck8mhaKs8VKj3BrWAmQ0bDsESQB2EypOIS4CBODCIDnb9UpdnllQx_4UA7FAwcd481HHmUsoTnYILGujfdKRzSznupJn-SCSOagnmhPSUef3IFJzlQZ2UKEkckWEn4dUqhKiH26zw1I0yp04vsXuukH-y0_wBkfUvCvC5J0yqOYd9i9y0UzZ0j_lH1LVn2l1NP9cNqCokBURk-ZbTUzTji4nRyXQWd3TqRB9rzXC2rw3ckziZWTRvDTrAF2Jgr3ww8u5qMDsYla2ppxqGOOD1KxdP1Sm88IJOcyt3SrW7mggkk8-inh53pny5y8tvVyRxcUcwFgnLl0epUKbxxtqA9lzzxDiO6zictS9dslMnCcGR3SA7pthghV5mEER32ReYaMJOKcJiSQIIhDyWcyMe5NJInZLkgfYgDuIQyLu6rfvvKdx54VTjLoMgISk7lM0zHPyVWJG-EQekhEXNwN0JIKnVD4oGxIOJ3hAkiUTMbJfI5QSev0pCconYoATyQZOl2wutSt6Lzw0yZe48mgS76AUL66N3fVq_Ko8kDoOQ-CoDuEyHQY5JJ96MlkxmNlutSta9paWTKjHMphshxxL3ZMeWFpOIuiZ2jPJZVzeXF26m67r1Kvo2hjeN0wAh4bfxFcPvLbTbx7y4VKZYRyD2mD8cFaF26yK10-rb0aBPDSpEkDudyiLeiATWvaQHSm0uJ-pEmWIgTB2RcWSQwmOrt0hKIhPeEsxnMdkSc_wBBAjMIBJ9yJKHPGyMZygnmpHmp1jzQJwJMBBMx0hQnMygUD05bwixCbc5QPJE9kD9CKAElE47oI8wh9ur8K50-uf8AN9i9x0MzY0Y_UH1LwzwnJsrgHHtfYvcPD_8AsFD9hv1LUt7y6en6Q2qiiirJ8ctruAHCSDG6elUJdJOVjOYG7uBBQY_heAHER2W0wbuzr-jdJc1dNYVab2lzakzsFxYeXACPgtzpNZtF7YIB5dCsJJ7t_eguECYWpqNg91vWPbUpAyD7lq7xoFQ7Z5JWWpq1-2CRlRp67JnQJS8gs3hJpxiUZlo6IRzMBEnE8kYlJzBQOM5UPkUORlASdxuq3fUnMjf3pSZPTogTf70f62QIjf6VOSBwcckwPXdIBzhEQhgx-CWTsQZTgDh7bJXwixBXEY7oTncdkHQhOJKKIPEtw2myzuaVIWbbrhYKlUOBlwIkx0AHNaYfNMiQumoPNfw2LM1OG8fTNZrh-lTaT7BPuJ9yLDnH8JcSwcLZJAJmByWb-Lrr0lsynTdUq12cbadMFzo7gbYE-SwXAxgLrbG8tGWl7fsvWW11c0xag1WOPo8e3wxvIEDzRPLlzGZSdehT1ixtQtpPL2DZxESq0TCbbbd0pTH4hI4iEXAHJQlQwQVMIIDnCIOdxKXA_kjvEIkwP0BSUOecKIYQz02S_UpmUc7g-aKCB25I-XuQOxRU-CYf0Eu-wRbuOiDqvCftWtz5j6l7d4dP93W__Db9S8Q8IH-z3g7iPgvbPDn-GW3X0bfqWpb3l0dP9cNyFFFFWT4yYGu3CDmFu-yvDIGEfRzTDtwtpgWk4mANwtxprgKjfSieh5StVSpw7BgHmtjb0HMh3pBnGCsZWHZ2jjXpAhoEGICo1K1aGF2zgqNMrltMCfaWyvHur0GnBHMheecSx1K5hzbu5St809wC2rBVQ6L1aEwdxmftQ4sHMlCJKgOIVY4TqEMe9MN_sSu3GdkQHEnlhKd9imPfohGUXBdz2hQGJwpHXZAoo_X2TAQPNKMnqEYznkgYbQUHTsMo8sbKOMjoUCTjb6EpnEInYJfigJ2zlbCjqLqFtTZTpgXFNpptqz-ge3Xda0OIxyhZtG2pmjTqXNVzOM-w1jZc7lPlKKpr1X3FV9WqQXvMkgQlc48IbMgGQFZe0jbXNSju5ji3ZZVtpdWtbse6oynUqgmjTO9SN_LZBg5UJM78vgoBOyDsTnKAO7pdphGc4zhDmiJOJJgKAwR3UUGRO4QHpGEOY5xnKg7IZ25lARspjBQ5Kbb_AEoBz79FInAUJj3ocuyA7oFxJ_rKkeSIjeEWAG_dEbc1PNRpESUPt1Hg93HRuhjBGV7Z4aP92W3_AA2_UvEfBh9m8H7K9s8MmNKtv2B9S1b-7o6X64bsFRAKIzfHYLgc5Ctow4ZSghwDgma0kYEgLZlhAhpYRCy7UiQS3HVYvCYPD5qy2qODojfkVisOg070fASXlrxkDcQt5SY51HBwRyXMWdUNeGvIb5rpLSmBawxxg5WE9i3hprz2axEzlYo-hZN0SHODjgLGdI7r1hz7eUnqhjdQjGEB55VYmBgpSVCP62QPPkQiCDyGFDnv2UOx6qcpQITGyAIIRM9RlATKBgc8lNvtQHdHyQWbNSu2RBweZSvIKBP6lKe6Y5S_0EEA37La6RR9fcy1lza7AX0ag2EZh3aefVaknO_mttolemLfUbd1VlCpWpN4XvMAw8Et94-pFhhXXpTc1vWOL0_GeLiGeLmtzbGrVbaajbFo9TpEVSRPA5oMY7g4WuvdQq1zcsBmjUqCoQR-kAQD8CVsfDT6dOw1V1Ys9G9jWva4wS0h23eQ1FiWl5-eUjgmaZIQfI_mgrk-5SVDtslO6MUwCVNlORndTaPvQEkEe9ScoDkj9KKM464SkgoZAGTHZTzQSCpv1lQlDffHVA08iCgSBmVNpwfcoNiiwGQfuVjfRmm8PLgf0YG6r9_koDByg6fwSZqXgnk1e1-Fv8ItZ_UC8S8En5a7n9UL2vwqZ0q2_ZC1L-8ujpfrb0KKKKq-PKRBBBgdFa09CsamRIOxWTTEvHf6FtSxWsxlMBFQOEqFvDIzKjDggjbqscLhm06jHkekYOIcz0XQaI_hcGNILXbhcu1zYmQB1W602o1rmuG_IrGwyNYp-juHHh4Qc42Wu2MLe6yPS21N5Htt-paEjKyr4aWrGLJExtHJAgEjEJikJ-GyyeSCcoDY9VNztlMd8c0RDvzUKE7Iie5ygQ_Sldtk5Tu-nZVkDMgygMxExPRHHSAhIiNoQ3OAgszw_SlJxnmi3faexSg9oQDfAUQBnlIUnCACJIn3FW29Crcv4KFN1QjJjYDueQVYMLa2lrWvNMdTsHcdVji6tQaYe4cjHMDoiwoudNr0bV90KttUp0y1rxTqhzmztjosMOgAwPuWfqOnfi-kxlerN2_LqTR8wdz17JNJt23d9TZUxRZ8pVPRjcn6o96KxxG8jdZNpY3N-agtaLntpjiqOmGsHUk7K23rUrzxDRq1Wsp0qtw0lgwAC7ZNq17cFr7AkMo0qjpYwcPE6d3dfeg1TsGDBKBBG2yMRjYIERy3RA5e9QiVMARtyyiThDADB2UEA7KDlspCCSISonGYU5oBvvyRkjmOinUckPKUBGc9VJx3U-hA4CKh6BAzyROdoQdgiEHSeBz_AGi7En5o-te1-E_8Kt_2V4p4HkV7kf5AfpXtXhE_3Tbnt9q1L-7oaX64dAooojN8e-jxIktPPomZTIAIkhLSeWkN_QWXT6jbotmWEK2CQMlXNaOKS6Ah6POAfJOWO6Ejqscs0NMDvOQthpzwzhBGDyWEwECHD4rJtT7XCQN8KSOjuKQdp5dOw3JWhIjK31q70lk-m7bmtFVaQXdJWVZamvXHdW4kEZKUZ3Ud3Q-lZtZJz25KcROTlDniY6KYKIJcNuYSkxjYeSkz0KH2oHDoGZQJ267oAdEQT0goID_5CAxvugSYPLmogn2d1D9Sh7ISeyCHPmpmFJmAZMKHoEB5gnJC3Xh807S0v9WdDri24KVuw5io-faPkGn3rSx1IVtpdV7Ss59u_hc8cJxM5n60VsNRqF16y4u2B1d9OarRj2jMHtyKwqFx6tZ3LWfna_DTPZm5-JhX0qVL0wbdGtVuahxSpn2iT1PVU6lTpU65p0qNWi5ns1GVHhxDp6orFaYALTBHNbDXLildai6tRcHcbG8bgIBdGT8VjWlD0ja1Wo7ho0mye5OwCoGI5GOSBwR2ylBzjdDod1I3hEEkhQZKE-aiA88IdMKZJwEBugYxBSpkDkz1QAzspgIHfmhGeSBx1jCHxKEgI_aipv5hKcYKY7Z96UoOk8E4vbn9gfWvavCJnSaE9D9a8U8D_wCI3E86f2r2nwef7qpe_wCsrVv7uho_rdECop0UUZvkBjYGRPmsy3EmIkKhkOgkrOtaRc4ejknotm04hKxkwp9Bv0Wa2gQxpAJwsq1sy4Nc8TOVsKtuQ1pYM914Tfh7xRz9Wk7iiCBMgosoPDsNPEtu23lw44T3FBrILXZ6SrFkmptPMjhAzzWt1IBtd7RsCtnZ-y6YjqtVqxm5PCcbr0p5an5HqwnGTEqczOUT3j4KHzXo0Cnf3IeWyY5CUd-aCEbfUhCJ7qHA2QT2eePtUGIgdkAY5wFI8kEOBPPmpPfKk_FA777oCRy_oqHKEgFQFFE4ETHJQHCEdQFOLdBCep84WZpHoBqFI3L_AEdPPtkcQaYwSOeVhBMN8EhFdPp11aW1_UfptM1G0Kbq1a7qj23DYBo_RBJA6rna7vScVVzgaj3EuH0yrKF0-ja3NuxoHrHDxP5w0zHlP1LGMCJE7Si-Wff_ACFnbWrR7UCrV_aO0-5a8nK3de2ovuq93d1Gi0e0mmGPHE4x7IA7GJWk4toRJQHKhj7UDMc1JxzRBJiMob5x3UkbHZTnIQTBbO4QLgoDAJRGMBBOn2KE4ypPxQ_rKA84hDr1UCiKEbppxInCU_BQoDKESJjHVKQN4GFA4tDmDmg6XwSf7xrjrT-1ez-DsaZT7Ej6SvFfBGNSrbfm_tXtXg0_3c3rxH61q6nu6Gj-t0qiAURm-SaNOR7E7jC6HTqBaGGIeFqtNoy8HcBdHaM4uENwQstSz106MqnTPEGu2CyXRuRhPTbxEyMnCd1KQdoWvltRVi-ia7LTzhI-1HFMnHNZfA1nzRum4YIxIKsThharBp0Qx0wT0Wgv3l9zUcSDJXXPpD0biBPVcdeHirOLRzWzpTlz_wAqMQx3SlO_NMeh5Jd17OeG8CT3RUGeakRMIgOzEboEkyCZ80c9VCD8ECuOcGExjlugNjlGSd-XJACTyJlA9kwHPmpHXzlFIRKnuR3UIjzQDngIjfHPChBCJmEUJ33UkBSc5KBJO26DNtadOnR9YuZ9HMNYDBf7-QSX1F9OpTdUoCgKzBUYwEn2Tsc5W2p0bZz7epVqMqj2WUbemZLj_m6CVjeKbj1nXK-fZpRSb0HCI-9GWGLpulXF-W-iLGl5IZxOgvIEmFhcMbzhdHpNN7vDN9XaHCrblwokOgkEDj84EH3rnX8pRJgCeUlDM-SHnuiCJ3RE6k8kSFI7YU54QAneVPOUcRKUkbICTnshPQ5Qknv2U890D4B-lKTlRsDp71CTPZBCVCQNkJ3k98IHcIuEJBzEoJ2nmd1eLVzg4uMCJklFisy3PgnGq1Rn83uvaPB3-HD9o_WvFtEvLLSawfWuWkubwuDRP0r0vwf4s0Zlq2m69phxcSAcLXvWZtnDd0pxTD0QQFFh2OpWV4AbW6pVZ5B2VFjh6PnCwo8NIE7nottau4TIEmOawbNnG4NZst_ZW3HALcD6VjqS2tKsyyaQlocJys1tEupcXIDKa0pkOhwnkIW2t9OurgAUaLiD2WtMzPhuYiI7udc0DBQIjkF0lfwfqb2ue1rQOhK19Pw7qTz7NJriDsDlZ5iPLxxu9e7BbTdUtqoZvBXCXTXtqvBiZ5L1K2s6tKo-jWpllTaCF53q1o-jqFakwF3AYwFsaFu8w5_5lJxEtOQd8o7ZjBWQ-jUb86m4eYSOpVAR8m8zzAW05u2VW0InKuFtXOBSe4fslXM0-8exz2WtdzW7kUzhTMGy0_TCg_yRiT_NZbbC8f8ANtLh3ThplXM0fUnU3PGn3Ya0w4-iKZjk2W4at0z9ykefmtg_StQH_oLqT_pO-5QaPqRMDTrqf-E5N0cmy3DBAjuOiEZkT5LY_iPVQT_dt3xD_TKH4l1Uifxbdn_lFN0cmy3DXkYS8JytmNC1g7aXeH_ku-5MPD-tn_2q9jn8iU3Ryuy3DVEQgTst23wxrj2-zpF6Sc_mnJT4Y1vIOkXuP9Fym6OTp34aU4RAJxK3H5M65t-Kb0Db80UfyW10f-03k7fmim-vK9O3DXafWFpqFvXLOMU3h_D1hV1q9SqCHkEFzn7ZklblnhHxE-oGjR7ziJjNOArXeCPEzAC_R7mD2BTfXlenbhjWt_Sp6daBr49C2sKtM443PED6PqWkGYnfkujHgjxM440m494ATN8D-JJIOl1R7x96m-vK9O8_TmTIOQURnGF0rvBHiNz4dpz5O5Lh96td-D_xA2mHG2px09KJTqU5SNK_DlhsoV0dTwTr9OIsuKf1Xt-9Vu8Ia408JsH558TfvTfXk6V-HPnZKV07fBGuucR6o0YnNRsIVfA2vNIi2puxyqtP2p1K8r0b8OYhSTGcrpGeCNeeSPVqbQOtVoRd4H1tgHFRo5_1mp1K8nRvw5oYKZdH-ROs_wC7oAf8YIO8F60TAp0AepqiE6leV6N-HNHIQgkwJ6BdVS8DatU-e-0pjq6sFXdeGLjSHsr39ShUpNd82k-SeyReJ8HSvHmGu0yyogGvdmabAfZmJPJarVbwVqvCDDQI4eSt17VHVKvoafydIfojmtHUPF84z3Wb1iMLQ_8ARBMbAKxpLTjBWFJDgYO-6y2OnHNVWbp-pX2n1BWtLmpTcx0tgqKtlMvYYGN1FGWZdppNsS0cTSAOa39KsyjwUzAJwtUy8p2zOBuXch1Wi1TWfR1OIEVa8w1o-aFo7ZvLpxaKx2eraPRpuqNqGn6SN4OAuwsNcoU_kqNAGo3nGF4v4W8RXdrpVelWrcb3uLg3h2lbHRb-6FWo9lV_t7iVZtFI7LGjbVn-T1a51-tezSYGsbOeHmksyabwSVz2iyaYcd-i3Bq8PwXOvebWzLp6elWldsQu1Rhq16dxSa3ibgmFr62uXNF5DBaCDEmgyfqTWWr0jXq29WQ5h581XqAsXXQZTfTdUeOLhMSt6tJ2ZcnXvG_aR3iG7wXPs_8AoU_uUPiK-x8vaj_ks-5KNPpn_wDE34KHTmE4ptHuUw8uyflHqAyLigPKkz7kR4l1KP8AbqYnkGM-5H1Buxptz2Q9Qbn5MfBMJMl_KLUzkagwdg1o-xJU8R6pz1IfAH7FabBv6g-CX1Fs_ME-SYTKr8otTOfxmR5R9yX8otSIj8aO-P8AJX-oj9UImxaRljfgmDLFf4h1Jwj8a1fcf5IHX9Rg_wB615_bKy_UW8mqGyG5YPOExkywTr2pf_Z3H8RVTte1In_Err-MrZepz-iFBZj9UJtTLWHXNSO-pXfueVW7W7-M394f33Lbi0AGwQ9Uz80K4XLUfje9dve3gz-u5KdVvDH9rvP4nLc-pjoj6oB-j70wZaN-o3Z_9TdH99yU310RBrXR_eK3xtMYCAtTG30KbU3NA-8uIj0l0QO5-9AXFd3_AMmD5_eug9VR9Uxsrg3ObcazpI9ZB6_0VhUqF_RqGo2vc1Dx8XA8wI6QCuv9V7KG17Jgy0rdQuSwB2lWzj1Lqn_-k7dRuogaXZ4PMPP_APS2_qvZH1Xsm0y01e_1CoJp2FjTO3s0j9pKxahvKr-J9FvGdw32R8F0fqudkHWvaCrtXLmvR3fKkJ6cSYU7v_dtnu5dF6rgYyp6rzTamXOmnebhjPeUQy9jDacdyuh9V7KeqxsE2puaFgvGnNKg4E8yfvXJeOtRc007U0qVOqBxTTJ5-ZK9I9VPReP-N6nptUvagklruBvYAL20a92OpbMOMun8VUudJnCqBhJXqS855oMqunBx3W212Qx2fPks63t3OHEIDRvPJa-jd1WbMZUbvBbM-9eq_g78N07-xbqV_Rw8k0qbxiOpXlq6kacbpemnSb2xDX-ENKs7u2rvuKzAKZBIO8Qou31DQ6Fxf0pYGngLQ5oiMqLU68W75bE6Ux2w8e1XWfRl1CyPEHYc85Lj2VmlaU6oGvdlzsgzt2hN4c0U1XC4uGewILR1XaadRa64Y0AQOoWV9Tb2ht6GjNu8qLTSDb24e7LludKphh4Qs26ogMa0TjkmtLeIIGdlpzfLo1ph0OlQyl5LLqP35LHsW8NDeUrqpL4Xg98OH1KvqJ1WuKbZpB2DuSsnUfDGo3NpS1rS7moKzMvYdwV0_qrTUceEHiO66fw0xtO0dTxE7Le0tXPaHH_J05pG5xXgrxc2-rO0_VaZpXtKAXxAd9y74UGuAIggrkfHXhWHHV9IaG3FP2qjG_pAJvBvimndURSruALRBn9Er3mue8NH_wAdaLYdFHW3ZZTHte0OaQWnYhNC85juyYXqwI2QNrjZZyDhhZYYsH1cTsp6v2WYG9VITAwvVuynqwPJZkKEJgywja5S-rROFnR2ygZTBlhG3lAWo96zYwhCYGJ6uOmUpoBZkIFqYGH6AKegHJZUKEYUwMP0PkiaGFkwoeidjLE9CEfQjoshKR0VwKDRACBpBZEIEJgUeiEckhphZMQkIEoqj0YQ9GFfCEIig0wECwdFfHRKQgxbiKNvUqH9Fsr518UXVT8Y3PEDDiTvuvovURFjXJHzWE_QvCfEXo9S0L0jWN9Nb1Szi6zyK9NO23ym3dHZwRqS7IG6IqBuQwe8qXNGpRguZ7J58ljcXIYW15a89mfbvNxXbSnDjEDYL6J8KVGUtGtaFOOFlFsBfOOlH-3U-pK9_wDDtcMtrcAmDbs332Wj-dH8Ybn4nl0lanFzRPXKiNeq3-yuOMgSouZDfmrz28pMtqQFMNAHKIU0MF9x6QjsAqtdqhvo2E75Wf4ZaJGMkrZtP8ctykRl0L6Be0HqOiyLe3DeqzKVMFgTtYBha0Ze8QNAcNMgLAqOIrY6rYfMpuK13EHVwAckpLOGa0QRKyH6JU1stoW9zXt6kTxUnwqHYK6PwzXo2hfWuKgYIgSVsaHeznfl52Zh5V430Hxd4ctqj6GsXFa3g8TCT81eYaVrVzRuuJzyCTBgkE9l9c-JGUNU0aoBwva5piR2Xgv4JPC9tqPifUq17SZUoWjy1jCCRxTufdC6NbTEd3Izu7vU_ANR9bw3bVHkukYJELpeHGVKNFlGmGUmtYwYDWiAE5C8Z7mVcIc08KQgTPNSMJoQiECQoQnQhCYJwlDhVkIFCFcYQIVhGUCEFcYQITwgQgSEE5CEZQVx2QIVpSlGKuECMqyEIhGSsiNkvNWkJeEIZVlAhWFuECCEVUQpwq0hLCCvhlTgxlWQoUGq12qy30e8q1TDGUnEn3Lw7SaAurPUrbhJcWemkkYd0C9f_CIx9TwtdU6Pz3lrfdOV59-JKNhp1rqNIvdcADjPFgzgiPer9JScS463oUri0c0sDh0ctBqukvoudUpglg5Dku2srIlji1hMOI2UdZSTIkHlCV1dsvW-lFoedWJNO5AIAP0r1_QNQmxtPbmoGhpXnepacLKuakS1xPCUNN1WrZVxElhjC9NWvVr2eWnM6cvehXFaxaZ9pjgYUWl0m-bc0KVUH2KrYg8j0UXJmkxLpxOe7lNTrurXQZOQV0mgAEiBAxCii97-G5p-Xa0B8i3yVgCii8GyouncNElayypVH3rqpngaMKKLGUtOIbOcwsyhY3V2-ibdnE1rvaBOFFF7aXlo63h02pTY6JVbUAaGUnOnkuG_AzacOiXl65sPubl7uLqP6lRRb0WnDlYiMvRECFFFHlIEIAKKIoQgoogEIKKIqIFRRACFIUURjIHZKR0UURQIwhCiiEggRKiiJAQhHNRRFKQgeiiiJIKFRRFhIlAt6KKIoQlII3UUQYt_bMuqDqdQSw7grl36XNC4sqmQ5ns43CiiMY8uLt6Draq-k4OjY9ism3tGkzuoota0ujSMw1HiPRxVtsU5nOForvwxVqUm1rdrY4AS3nsoosqatohjfSrae7qNPeLXS2ioOGm8Ne10ZY7uooovStYnvLGLTHaH_9k=');
INSERT INTO `userICON` VALUES ('7', '_9j_4AAQSkZJRgABAQAAAQABAAD_2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj_2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj_wAARCAFoAWgDASIAAhEBAxEB_8QAHQABAAEFAQEBAAAAAAAAAAAAAAECAwYHCAUECf_EAEIQAAEDAwMCBAQEAwYEBgMBAAEAAgMEBREGEiEHMRMiQVEIMmFxFCNCgRWRoTNScrHB0Rc0YoMWJEOCorIlRZLh_8QAGQEBAQEBAQEAAAAAAAAAAAAAAAIBAwQF_8QAHxEBAQEBAQEBAAMBAQAAAAAAAAERAiESMQMTQSJR_9oADAMBAAIRAxEAPwDqlERAREQEREBERAREQEREBERAREQEKIUEZUhQpCAiIgIiIIymURAymURBKIEQEREBERAREQEREBERAREQEREBERAREQEREBERAREQFGVJUYWMTlMqETWxOUVOVOU1qVBJ9AmVAGSc9k1ikPfuwWjH3UmQbsKh5aDgDKofIIWl7vK0e6y0xfOfTlA8c59Fheo-othsTXfi62Jrx-gnlap1P19gkY5tsj8MN7SbgQVn03HQclZCzO6WNoH95wC8ev1jZaB22orI89vKQf8AVcYal6sXa7SPa6uL2k_K3hYlUXe4vidMXSsB_UXZT6MfoJaNR267Pc2ina_Hbkcr1i4-wXFvQq9XGHUdADO5zXO9Sux4Klr4onSvGXYx90-m3mvt9FSHD3CpMjTx_qqCxuc7f6p9JyrpLgeAMKr0VAkY7gOHChxz2blVrcXMnHHKnPHKthxDeGo07xymmK8nPopVpoznBUhxBwVmsXMqMoSiqNAVKhSjBERAREQEREBERAREQEREBERAREQEyhUIIe7aM4JUB4d8pyomJDOP3Vtj27cxtwPXPCmi65wHdUCUHOeMe6xjVOsrRYYXOq6jLwOzMOI_Zad1L14AZJFaYYpAP1SEtKzVSOiWyhwJ7AeqNla8ZYQ4fRcS3Tq5fK_c1lwq6Z2flhyQvUs3VfUNtowXTSTf43HlZa3HZDn7cZC8u7ahtlqjc6trIYy39LnYK5tq-vlZJaTFJGyKfHzMJytXXTU181XVubD4s7nHu_IH81n0fLozWXW630LXstzSXjs84IWlNT9XrveJHAVG3PAERxwvJboSslphNdqnwR32MeCvnjtVto3bY4_EI_UWrLdbOXiVlVeLs7O5zgfWTJVUGnHSMBrXuJHow4WRt3EYiaGN-irzswN5cT3z6KfW_LzaC00kH9mxuR_fGV8V6bIQGeDvjDgcRtXsTR5OWnCrj4byOfdPWzn14EFyqaV2aWmqInDsWjBC9A6wvYa0uluHl9pHf7r0C77qnPvz90XXxx68vDHZE1w_eR3-6-9nUu8MAAnq-Pd5Vp0cTu8bVbdR07u7B_JE2Pfpusl3hAHjcj-8vRp-ut8iPFRT4_6mrBzb6d3emj_kqTY6N_zQMH7K_pPy2tb-v90Y3NRNSOz7MC9Ok6_z7_zPCLfo0LRr9P0ZeQG7fsFZm0ywj8qZzf5J9Hy6TpevtuEbTVwyOeTjyYCzGw9WrDc3Ma55gc7t4jgFxg7TtQ53hwzuLh5skhfE2espqv8ADGVzpWOxkHKafL9HqKqhrads1M9r43diDlfQFpv4eLrLU6eMNZVZexvDXOHHK3A1xzjuPdVKi-LgIz3U5VAaGu-qqVxKcooUoCIiAiIgIiICIiAiIgIiICKCiM0JUbhnGeVaqQ4t_KOJPQnsvlnnioKV0lRIGRN5e9x7e6m9KkfRVSRiF7nuAazkn2wtH9T-r8VnjlpbJIJpxkGRpxhYz1k6tyVE0lqsr9lK3O6UfqI9iFouKCsvc7pqxxYwnOTxlRetXOX03PUN11FXPmjme6Vx87_YJS2OPmSuHjyn9l6tHTQ0sQZTtH1PuvoWarHzU1DTU8WYYwx3srkkTHU5a5m5xV1FlrZGOTaedNOJDNhuflwsssVa-yRBsLRJke3ZfMixuPsrK-oq5DJJMcH9C-J7i52GjaFKYQxSAW-u4eygkD5GYJ7lV4TC3Wo2jGcqppCjCghNFe4e6pODxnChE0R4YH6lGMeiqRNZidx903O91CLG4nGRndz7Kna0_MMqUQS5jWx5j8pPBWLV9qqaWtfWUmZd2SQFlDXc7T2VyHayYB3LPVaPG0nruvslZw90Dgflz8y6e6cdWaO6RRQXKZscpAAye60xPpOz6jofDgc2KqA4OcZP7LX9dRXfRtcY5GvMIORIB_qq1F41-g0E7KhjXxODmOGQQrmRnC5a6SdYDTTRUddIZISMEk9l0jbbnSXSjbPSzsla4Zy0rZ059c49QOBdtzyqsr5mgSFucgDsPVfQq1KcplQioTlMqEQTlMqEQTlFCIJREQEREEFRke4UPaSSc44VhwDcknLQPMstMV1EjI4zJI9rWNGS4nGFzT1v6n_ivHtdvl2U7cgvaeXHsQvd67dQzQ009rtb8HBbIWlaEs9lffJ_4jW5FE05wfV3qudrpzHl2e11VeH1VYdtMD5dx5PtwveZh1P4TQGtb7L7a0D5GH8lvDPoF8Xhn0Ua6SJDDtb4Z4B5yq1AaQO_KkFx7rNbgiqDQe6pWgiKg4LwIn-f1CCs8d-FLRkcL7_4TVSQh5j3fuvllimpztkiLGoLeCmFTl7v7PkKBJ5tpG13qgrUO7KHxnGd2EwNnz5PsghERAREQEREBERBOAW_VTGMDzKkKVovU9XJRS-JC9zXemFmFDcqHUFGaK7xsL3DAeRlYQ4ZVcO5jw5vog83WOiKzTlS6utjjJSE_pOSM_QLJ-k3UuqsNfFTzSOkpyQHMkPb7BepZL42oeKGtP5DhzlY5rzRMcYN4sI8rfM5rQt1l512Ppy_UV9o456KVruAXDPIXuZHuFxB0r6g1lir4wXuEW7bKwn0zyuwNNXenvlsiq6d4c1wBDQeyqVz65xkGUVknOAeHq8OyuOYiItBERAREQSiIgIoRZot1G7bhvr3WD9UdVRaX0_I5rszvbhoz78LNZ3lrhjJzwVyP8QGpaiu1PLSEPbHTboQMcHnuptbGvLncKnUd7zKSY3O_NcfZZTcKtjIYqGhw2ma0E49TjlYrZPBbThkTyXj5ie5XqM-YLnXaRU0FrXAHLc_yTxMDA7pnDyMgA88q5A7blz2t4PCjFx84p6iSQFoOMr6DTyt7hZnSaitjIGCelYDjaC1nqvqbf7OW-amb_8AwtxrX5a4d0We-NYaw5cPDz7DC-KrsVtmOaWqA_xOAT8LGHqCC8gEYHoQvcqrK-IYimgd_wC8LzvwE8ZPLXH2Bys1mLUNXUUz2-DMB9Hcr24L7M0BtZCyeP12MAXgVFPOTzHj7BREJWR4JP7rZdMZWKayXRuY3Gkm9nv_ANl8dbpyqjbugLZ4x6sCx8F4fkYz7r06O8V1I4bJNzPVritMfFOyZjiyWJwwrGwNdnBCy-G_W-rAZXQbHn9TWr5LjZm1Q8S2yxkd9rnDOFmjHEX0Txlr_wAyN0Zb6kYBVuPyyBxHfsD2KayVbRezS19KfyaqFjSeMgL6JtPslaZaKXfnnBK1uMeRXDRTwuImaW4P6uFQ_LfQEfRDEIgORlSmGAREWmGRg5UsJHZQmUMUFrvF3Z2_VZBZ76aOPZVeaB3BaV4fdWiC_wArhkfVY2XIa2sEdG5t3tJzC_mRo5wO5WUdJde1FproGtlL4HkAtznGV4rbk2GhlhqhmAtII-i13DWso726Shc7wC7A-iqOfT9FbZXx3GgiqYSMOGfsvRHYLTHw83iquloqKeq3FlMGhrj-rK3OOwXTlxoiIqYIiICIiCUREEIiKB597q3UNvnqWN3GJhcVw_1R1GbnqCrf4QEkjyQcrtfVc0NNZK6ScZZ4J3DPouFNbQU1XeJ5o5mxMLi5m72WKjyrFQVcLzM4HZIsobnAHqvD09eJXSGllLXt7NIHZe7K7MoEY2k9ifdTXXkIj3Dxu3p91br5m01HLNIchnYK1VxXCeZtPbG-NV43kNbngd18NbU1D2ugqojFUtcA8OHfn2Uqx6unqC4aiAgg_JI5aScd_usnk6T6wfEHQSF4-jwtkjphT3nTturKCcUVx2g7snB8oxwFnej9O11lpRHcq9lQR7Aj_NTqpHPUfSPWros-bP8AiCsP6b63pGEvoPFA95F1m3niNwA-qhw3cOAKm1Ujjeew6rpX4ltZZj2dlfO6W-UZPiU0uR6YK7LNNC75omH7tCOoKSRo30sB_wC2E1uOKptQ3JjvzqKXb_hKt_8AiOGTiaF7H_4Su0KixWyoYWyUcBB9mD_ZeHWdONN1WXS0IyfbA_0SVNjk1l0pSd3ilv0wr8dfBUkCNwcW-p4wuj6vozpKqBxRStf7-IsZufQG2S_8pUfhvbc5xVypxo663H8NHlwDv3XyWm_1bZTLStGQDgbltG8fD5c4YnOpLnFK30bscStbXXplqqxVbZoqGoka14Ac1vHf7q_DK9ei1YaxhprvTF7uwL8r7nR09VGDDIGlnLWj0W4NN9P6K-6HtrtR0ZFwew7nM8mD-ywHVnR29Whpns9SJGlx2xBpJI9AojMYdNTEvzN5j7r7KSrqaMD8NKQB6Ly5Kuvs26nvVK-KUceYAKI6uGemc-J35mPdU31mAu9JdWCO4xhkmMZ7rzbhZ3sG-kfuiPosSstdXzvmiipn1Ug-Uxgccr2KW9SU-BUTtila7Don91ms9C0sO1wwR6KF9756eukc8t8KR3PJ7r4J2vil2uGE09EUyDbj7KkZPotalFTu5xhVPBA4QSDgqJJMcNHKhh_vKqMgSA-iyj5Lk10lDM17PmaQvD0Zb6O43BlHUMDPzmtzj6raN6tkP8AiqIGec_Mf2WrbBUPpdRljsBvjCQceoIV8oruTp7p2n03ZmwUjRktG44xlZeOyxvQtW65aVoal7g572ZJCyQdgukcaIiLWCIiAiIglERBCIinBj-tLVNeLJVUdO8Ne9hAycLjbXOmarSV2ay5ReKxzScgZC7lkZk5A-6wPqjoqm1VZpA5u2aIeUgZzjlTVRyDa5aKZrZIogwHvkYK-muqmUdPI-bjaMsPuV8WprXVafrZI5ItjWHzBUzwsvFJE4yHwmHP3PsorrG9-gmlGi3uvlSGSTTfKH8gMI5WX37pbY7zcxWuyyRztzmswAsE-HnWPiVEunapjcNBdG8nkADst7tjDI3kMDXemFP1Hbn8WqSOKOjhp4mljIQGg4weBhXztxkbnfdVgAHBGeEPbjhc7ddJFpuHn-6q8IB78qVMbiMKodkTK3GJRvzKMplbIZqqQ54HCjYBgk7lQ7lQ0bfVPT5JyAONytiKORhEzGPafRwyrxJPdUlmR3U7035i0xrYwI8Da3sB6K48xucSQXccZ9Cq2taCDtBKgNxjHbOVs6ZeY8HUekrRf6RzKymi8Rw-cNGf5rReseiM9u8SrsNQ6Qd9jn5H8l0nhuHAtBBVEMTY2lvcFV9J-XEGkp63S-u4GXGne3LwC1zeD3XUt10HYNU26nmkpWU75WB5fG0NOV6920RY7rc4a6tooZZonbgXBZDBTxwtaxjQImjAZ6ALfpny5m1h0mvFiqJ6mxyCopActEjtzsfRYWy4yQbqe5QmKUcZe3BXaDms3hmwFh7N9lhur-m9j1OJBNTxw1OOJGtycrdZkcyMAe04ka7PIwVU0OjHK-vWnT2_aQqHzwNkqLeHY3eo_YLw47tDLEBvPiY5a4YVRlj7w8AkkJ4hd6LxoLwx9YIJwGEnDT7rIaOWnknZC3nd3OOyrEvl3gnb6qkE-G4-y-i5U7qSuIa3c052n3CtxMy1zT2PqprWxrTGK3SLgeSAcLSN-j_A6hY7tzj-q3voICTTbhIcEuc0D3WmeqdK6mvQIHl3bs_uq5rn06y6EXYVuk46fOXQNAK2kOwXO_wALlw8WKsY8_PtwPZdELpK5UREVJEREBERBKIiCEU4TCC3I47SAOSqXZ8Ltn3Cu4VGDk4xgqbBoP4htGsrKD-KUzAGAEy4C5ssNT-DrJqBxywDc37krvTVtqZc9PVdE4ZbI3C4N1LTttuqAQ1waKgsOfUAlc7HXmvc0rc3WXXNBNFlr5Hhn7FwC7SD3PGR8pAXC9XUNbqO2ygciZhGPbcF25Yqr8VaIJccvaD9lx6nrvx-PvjOWkn7KpfJLW08DWiplbCc8bzjK-kPa6MPYdzD2IU46SqkVG_zAYP3U7hu2nhMVqpFD8t9M_ZPTKzW-JUFQ7hucE_ZAchbKYIiKgUjsoypBStSiIuaRERBGUypaMjJ4-hQgAEkj7KobFJdlzSP0qkR-JP4rHYwqXyBrC5z2sb_1LGbzrqxWadtNPVs8Vxxw8Kom2MlrIY62F8VXE18LgWkEBaG6tdGIpKd91043w5vmMQySVneq-o1DYauhdtfUUtRtG-PkAlZzSV8Vwo4Z2N3U8zN2PUKtxH6_Pe501VDchR3BjqeZjsO3d1njaSstLYfxzSwOjDmSEYBBHC3J1w6XG_ww11iZHHNGS55I5cveounTbn09itd5INcwbmSs4I44BPsqnWssaqtTG3izvjbh9QOQR7BeBsfA2eORpD2r4qKap0XrSaiqphJFE8x5ByPRZfrOe2vo21VJLGHPGSMrajXuaCr4ILX4FQ4B4cXAFYB1kfDKwzR4yHj_ADXzx3VlOXS-MMbcBrT6rFNR3WS7N8FrJOXDzEcLZEWtzfDFVvbd6WIHyyHldarlH4ZrXPHd4JJGENpz5nEcHPsurl05c6IiKkiIiAiIglERAREQQUQojFqodiJ2RkEFcKdY4mQ3521uCKhzv6ld2y_I4Y9FxL18gEN-qAB5gd2Fzq4woND7vaHHnMkf_wBgu4dOxhlojDTjLRgLhuzSCa_2SPuS6Pj_ANwXc9uppWMjYQWtxz9Fx6nr1fx_jUfUu36h1Jrqlo6F0kNBAWvc5p75BB9Fjmpupl6slxjoaKKR1NRjZI5-WgkLoprcSY8MAg8P91iusdGW6-2uWjMDY3SSeI-THdYqtPW34h5JrrDHXUEcdG3Ie9m5y2XZ-r2mbmWtfUFjz28uP9V8NF0Y05FbG0raVu97fPJnsVrnV_QOeme6WwTOkI5AYDwq5kqdro-319HcYBJSVQe09hkK_vDSGuHf1XFtDqfVPT66CnrnSiNpxhy6a6aa3h1ja4nZBna3zc-qzrmK5tZ0wPY455aVDM8591EQfgh54CA7Rl3CiTHSKkKNIcMhSQcLdapUhQeBkqW8jI7LG6qRUtcHHAOU3BQlUigkAZPZRI4MjL3nDfdMEja_gnDx79lhOu-oNn0vCWyS-NWekbRuH9F8eqtRV9but-mYnTl_ldUM7NXmac6U03j_AMQ1E78XVuO7DsjatRedayuOqtda2qJG2ildTUzz5CHFvH7hYxdOk-uK6oimqmiSUu-Z0v8A_i68t9BDRw-DTwNjYzhpx6L7g4lha4B2O3CuVN4aj0N04qTpeCg1U1pnZKJGkEOwPRbOoKKO2wspoDmGMbQvsIdn5cjCt7Q1hc08eoWdXxvM9VMG6MMLQWO75UFuYyeAOwCttkcTlv8AZ-6rawvcQ12QBlTxfVdzxxdr5sTuod8gq3bQZ3OafsAsDudXK2R0fjudGOyzHr3C-DXlW4gxh73HPv2WtHyu7O5Xpk15Or6-qCpe6TDpHYW2ememH6nuFPT-H-X8xd9lqS10_wCLr4YwOC4AldofDppj8JZ56uZm17X4jJHduFeM1srSGmKDT9EyCCNolx5nYWUDsvnLXOYQW7T7q-OAFUTUomUytSImUQEREEoiICIiAVCFEFubhpd7BcRdc5hWX-qLstIJH9SuzdR3Wns9rmqql7Q1jc4J7rinqPc6LUF8llgwxrnkHIx6qaqMZ0BFHVattTCeWOaf5OC7vicHYLQ4jA7LhTQF3tVi1mypuW_wIstBYzdz6Lfl365wU8LjaIY5GjsZMtUXnXXnrI3nIGta3Jwc5wVbc4Fcu3nrveZ97G0tKwOGA5jzkfZYnV9WtQTA7Kqdv-ElReHSduz2-J-kKsty3JIDvZcPf8TdUPJ2XO4_ZuT_AKKiTqJrFx3fjbh_X_ZZOG_TrTXGh7XquhdDNCxk5HD8ALy-l_Tuk0Q6TEz3uz_fJHZcxs6latGPFqrgPqA7_ZehRdX9UURBe2Sdo9ZSQT9-FvyfTs5mZJCWg7FLnAsOWkYPquZbL8QFfEI_4jSxsZ67Mkrd2jdd2vVdFHLSytaT5S1_ldn7LLz4rnr1lIeHDDQqmuIc0Ht6qQxsbuD3UTHY13HJXGxdqp7Mu3Z8qhzgW4DTjPoqXk4jaDkErWfWLXVTpyFtFaGxvrXjO0uxxnkqpEbjZUzmMGWzRs99y-KovtppcCevga71JdwFx5ddfXaomca67VVOT3bC7cAsaq9Q10k35NTV1m70kaeVc4Tf5XZt36g6bom4fcaeUj0jeFiN36r6bnj8PZVOA9WSLl1tNdbhI0fw9zXu7eV3-yyW2dL9V3FrXRxGIH0Lsf6KvhN_kbsi6x6Yt3_KW-pDvfhWK3rzQPb-VTTD74WCU3QPUvlNTMwNIzxKCsiofh3nlYDVV8jT9HNKf1xP3UVnXioDMUzGNHpvaCvkh653Rxy4wEfRgWU0fw92eIBtTcKp0g7gtGF6MfQfT2doq6gfUMCf1w_srw7J1x53VlJNM_OMRAdll9n6q2O6Thskc1AT3NQ4AFedP0EtcYP4K6VbHEdwGhYrcuid2pt4ophXuzkfiXgYS8LnbfVJVUtZRumo3iSPGQ9pyD9lfZKA5paODwVo7p_U33R19pLRqHDYKx_hxtDtzW-q3mwM8LIxzyFM4dd2OM_iehMet2EfK9rj_ULTr1u74q4zHq2hyCN8Tj_8gtItGXgFd-fI8Xc_6ZJoakNTcWYGTld-9Nbd-B0pRDsXxhxXFfR23_idS0EO0ubJKGkgZXe1thbSUMNO0cRtDQmlfQ0AEglVYVOAXlXOFaFOEwquPoiCnClSoKAiIglERAREQW5MEgFQ_DW8Kt4BP1VLsNBB9kGgPiY1EKajgpI3cuyHAFctRUV3vdVuo4ZHRvO3IW4PiNuBk1JWwZz4Z8oW1fh2sFKNGx1FXSMdIXuOS0KaqOVdL6NuV91QLVGHMnbndx6Dut6234dZ5ID-LuRbDxlhYqunERd8QVzEYZHG3xsbm8Le-t9U0-nrZK7aZqojDIWfM4opoDUPSXT-nXRxxSNraybyRQgYLXe6znR_SDTbLcDcaRklQ5u9zCOxWQ6D0xNNWT6jvLvErqloAjPZjQctw3sDz3Wc-EXs8jmMfn29Flqowyg6Z6SgiDorZECe59l6H_gXTbRHE-3REOOFi_XDWdZo-wOdbNv4yT5XFuW9_ZfH8P2urjqyCrhu238RAwSfLjuVOqkZkdC6cdG4G3xAB2Avlm6ZaUqRmotURz6rLx4j9wLmDnPZXGOcexCzVY1deOiOlqth_BQR0zz6gZWqtbaCuXTiop7raKp8tPG8OcGjA911NuId5sfsFj_UGhhuWk7hCWhzxC4gEZ5wtnrPx8ehL4zUmlaO4bsVD2Au-6yUEclzslc-dI9W0GmNK3V15EmKSdkTWh2PRffVfERYI6vZHb6stae-8YK59xUreI8PfiPg9ytE9ULNGerFplqjmmmpXsJPbLiAF7-lut1kvlyhpo6eWJ8ztjdzgvr61xNbbaC5NAzHVwsDvXaXjKnnytvseOPh7tUtydVTSNMD8HbtWVs6YaQ09Ry1T6OJzmM4-4WexV0H8PiqonF8QaCcFeO99Reakl8ZFK30I7rtK4TljGjtNMqq11bUxNbSA_lAjsPRbADRDIGtaDnsQEZG0QtiibsjaMYHoqg5sTSB5iexVaucq2Nz5XeYjlUVcsUAHjOEfryUY7YXyNdkYXO3xF6guR1HQWu3VghdOxo4JHc49FOUdCRTR1cZkjcHtb6hVtaDD4sXotMdFJL_AGmsqLZeS6WFjtrZCDyMe5W54Q8EsA8hWZTxUw5IKvY3HCttAD8BfRSjMnKq_ievPWueuNsDtIzXaFv_AJy2tMsLh3B7L6pNX2OxaTtdffbhHE2SNjS48-baOF73UaKOfTFfTytLmSR4OFwFcnV1bdZqGOaoqT-IcyKEvLsnPAAKyNnfjYvxF6rsmrb3QT2WsbUMgicw7R7laffG1nm3fsvWudorrPWRxVtBPR1JByJx3_ZWZqNz4w7h7z6NVVG7W0-g9THSXWnqJpBHEx-XOPoMrrmn1jZqp7I4LjGXHt9Vw5p2yamfS_8A4211bmO4y1q9Srt2r7NG2e5UVbHAOcgFp_nlRvrbHeLZWP2uDwc9sKssyzbu5K5E6YdW621VjIqqfxaXIBif5n_zK6qstzprzRR1dM_Ic0EjPZdY516QZhoB5wrgOQqGHP1CrWsEKIUEIiIJREQQiIgg91YqTinlPqGO_wAlfPcL5a92KSpPtG7_ACWDiHq8X1Wr6vc4uc54HK6x6b282nRlLA7jdEH_AMwCuSeo84brHc7s6TldfWq5xv0FFVggbKZrR-zQio570Zeobb1lvdXKN2zxmNGM5cRwtr6R0_VXq5G_3olwed0cL-zf2Wm-k9BFeur1y_EDdE50kvPuOy6ng_JjZGBho4A9lNXEjDH-HHwAOQPZS7kjb3CFobJkdz3KgHa45UV0xz18UtwYystdPxjY7LfflfZ8MNJO59zukkZZHPC2Noxjs5Yz8TcL5dV2UH5XEj_5LoLRdop7DpygpqVgaHMDnY-oBWM5e6wYy4-vCqA2cD0VrLi3J7buFdzkotOM914-qg6Ox18rMcQuz_JewFj2uqltNpi7OccZpnAffC2MrRPTTSdNq61ajhrXODZKtpBH-FfTUfDnbvGH4auneQcuDiOFknw6U0rNO3Coe3d4szXD-S3Bsj-cMDXO7rn1avmNGaX6DRWW8w134hzhG4OALh3WwOqdsdcdFyUsIy6EiXP-HJWZgkO258qtVrI5oZacAYkYWn9xhTKvGC9Hrs296Kihc9xlhGJM_dbGaxtOxuDtDhgAe60Rou4R6N6l1Wn3t2UlZIA13YcLehx42HndHgFhXaOfX6uDjOPVQAAeylFlIjDHPO3Ibjlcs9aXPb1ZtDZWsLGuY7cT2G4LqfbucY8YbjOVy_8AE3bpYNRUtfAxxYyMNLgOxytc7HRVoqrTWSj8HJC6cdwHBeq2XcWB3lJOOFx_0Frb1WdQIXtllNHk5z27LsKJhaGucN2PVacqQ4POGcYdgkqozimEz3uAY09yVEga1ry4hgA3ZWNMNTfrl4TCRRRn8w-kh9Cr_wAZ3X0zNlu9rrZ5i4RPbhjVgvSvTlhmtlXWSWynfVR1kgbKY_M0g98rbU3h0lC6FrB4YC170ba7-C3ElmWG4Tf_AGK51z4_WPdXunUV9dT3WAvkna3wiw_9R7qrpp0ftVjp4ZbuxtTUO52yAOAW2uBK7YwEFHMDo9xGR7-yzXaxRQW-ipH-HSU0UTQOzW4C-m5UFFcKcwVlPHMxzSMOGV8dVWUtO9kc1U2M8EDPdfZSTNmOQdzPQoiuR-vmhG6QvMN2t8bWU0hLi1vYLZfw4aiNZBLTSyudlnlBPY5WSfETa46_pvcqh-C-Bo2fzWjfhxq5ItQU7QTtfJs_qqlTXZzBtZ-ylh3NBVG7A5-yraMAALrHKpREWf6QREWtSiIgJhEQUu-YKxWRB9PMz-8xw_or7vX7K0Wkub7YwsHC_WegdR6qrMnDYn5auhunVcb30qBY8FjGua4--ABha0-JawmG61E4B_PPGPoqegms6WHSVysMkmx8LHyNLuMknsio-joMxv8AxQunhjyMMrT_ACXSjRtzj191zb8PQLtf3eUctc-Qk_XC6TU115Uv4Zx6cqpzQ5jS7ug78pJlwwFFdMaW6-6Sq7xHT1tvYXVFNyzjPrlfV0U1Zqi9VM9JqKie2KCNrGHww3scLbphbKzbK0OH1UUlCykke-GKKPeMZaMLEzxc7tw8gNB7KC4ZdsBICpLdmcnJyqgfDcPLw_lFEbvE-UY-61114ub7bo4sa4D8Q4xdu-Qtk4GTtwPdaH613L-O6stWnaY-I1krJXlvP3WwZp0ZtcdHoih7tdLGHOyfXlZ035fQr4bRbmW-gpaeI4ZGzbhfcQA4gLl068p9FSGNByVUoLS4Yb3URVaW6-WiRlNT362sLainJc5w7rYvTe_t1HpOiqI3AyM8kmeTwAF6F9tkV0tdRR1LAWSNwAtC6TvVd0v1TNb7ox_8MqXkNcASG5JK68Vy7dJlw3YAyoIe05xkewXx2a50l3pBU22ZkjTzjIyvQD3OZyA1y6WJlR3aR6HuvOvdlob1RGluEDZIvsM_zXoosM1jOndF2XT73m1xCJxOSXHOFk0LXSx7I3BoH6jzlUjZJJwOG8PWN6wvFQ2eG1WhmZqg7HPaP7Pjvn0Rz68W7zVT3a6_wq2u_KDfzZhyM-oWV2q3st9vhpGj-zGC_wB18-nLTHaKRrSN8rxue88nd6r1nyO2uLi1v3XT_HLdY9r-uFv0rX1rTjwo87vZeB0rpJKXTJDeBPO6ZxPqHcrG-s-qI6yjZpe3O8WquOYX7edvqth6ZpnW_T9DTEedsbWu_korrzHoljXk7ThreFaldKGljIyXHsfRfSIg8kA4A7qW5MjTkYClVaHrunWqdQXo3WpujYzHMQ1gDgNoPHAK3Zpyhlt9shp6h4fLtG4r62RAxFgcQdxPCujG3aDl4HdE1rD4jbhDRdOLlTk4llaPD5-q0P8ADu0u1DRNA5E27-qy34rb-zxKC3MfucNweAVHw0WFz7rLXFv5ccbXNP1ytiK6lwXv2nsOVdVDSNoPqVWu0_HKiIiz_SCIi1qUREBERBDuVS5pI4OFWVCyjXXV3Rg1JZHSMJdUwtJY3HzLjbUen7hpm4TTQtdTP_U1vqF-hUgy5ue3quZ_iZgghrdkbA0loJOO_Cm1fLw_hZulPLeqmKWUCqkDnnccZ4XT3iMb_aHHthcUdJNJ3a8VFRXWGUwVMDiBwTnjOFt-m19rTT7hTag09W1cTOBIwNaD_VTa7yeeN8sy7049Cqy4NGFpn_jjhrRU6brYA3sXSNX0RdcbS_8A5mglj-8gUWm_-tut3HtypyGsaJHEkHK1K7rZp30G0-xkCiTrbbiP_L0UlQfQMeElV-_jbPmc7MbRj7qS5_mfM1rQ3gc91pmXq_cKvy0Wk7jIPQte3_dfFU3bqHqBjo6S31FsppflMzA7A-4K3YYzTqP1CoNM0EjYpfFrZRhsbeef2WI9HtM1NXWzakvzS6qmcRGx_o3OQV92juleKkVup5xXVIO4AZGD9itoxhkcDY4IhGxg2gAegU9dZPG8z1dncNhaDjJz9kjHlHqVREwuOXK7lvYei422us8FIJHbhESUQRmPa7k-hWM6u0db9T0MsNxa173Nw2QjJZ9QsnVLwC0g9l0nWJsc5P07rbp5XmayzS1Vsb-guAGP2C9ug68zMlEN4tBhLeHOAcVu6SLxog120sHo4ZXkXKx2m4RGKWhiB9XbQq-0Yxak6z6Vm2-JVPYT3HhnhevD1O0vOMxV-fu3C8-q6U6TqASaRzXHud68iboxp0kmFz2_9wp9mVk9T1H09HC9tPWN8R_zfdePZNc6atc81XXXR0k0nc7cnGey8lvRLT-_fIZjnufFcvUpujek425dFNKfbxiqnSbxv6-i69c9M08R_AyPqZhwG-GeVh9VrnWmuJPBsdtNFAeBO15Bx9is5t_TrTVvlBhtzw4cgOdlZbStpaCIRwxMgaPTAVfTP6GBdPunItlzF2vkzqy5ZDt0gGQfuFtNmAMY-y-aCdsudvP1V9pWWt-cVHygkHv3U-GCzg4UEnHlIH1K8m46jtNukxVXCGLHzFx7LEWvZa3nLV4esNSW7TNkqK6slawgYA9SSOFrzXnXLTNha6O3ytuE5GMwyYwf3XNeudZ3zX1w8aoe9lE07WMHAxngHC2RFWdR3OfXOuaitlz4LpPK3uAuuOh2n3WPSTfEb-Y_JyfUHstO9CemE1zfHXXCIw0bcEbx_a_Yrqmmp2UtMyCJu1jAAFSOqrOQ1rx6jGFeaMBUtw5n2VTTloJVypThMIi0MIiICIiAiIgFQpKhZRRKMjHp6rmf4of-dOe7Y2kEfZdNEZC5v-J-Atc2Ujh4Df6Kavlj_wALtc1lHWiXLT4hPH2W-Za2mqXBr4myf4xlc4fDex0tZVU0ZwSXHH7LoWG2TRvBJK5dV9H-HmXj19_8KttQ0F9DTn7xhW36Zsr_AJrbSn_thehTxOYwZKvrlekdcR440xYx_wDqaI_eEKqLT9rhdmK2UY_7QXrIpvSZy-aOgo2DyUsLD_0tAX0FrSxrclobwMKUws-qr5UBgJy5zh9ipG76YVWEwm6SJDuOUaBkkKMKWo1UiIgKCiJ6IDj2IGEj2scTtB-6YU4T1NijOTyAhOPlaFOEwslq8iCS4YICNaG8-qeqq9FctMebeJnQwmQZ3D2WP26eWtqMyOIAPZyy2aATDa4ZC-aO1QRvyBj9lWus7kmPpoZWFpY0DLRzhfdGdzchfPFTxRY8Lu7ur7Bg7QqkeXu7-Nf9fLvUWTp7UVNHN4VQZGAEHBwc5XH0M19vtQ57a2abefl3krenxa38xfw61MO5kke57c-ocsf-Hix01be6UyRAtDhuGF0kef8AGG6b6bXS5VgApZi5xwXStOFvzp70VgpJY6m8AEs7MafKfuFuqO3xUrWCkhY0A849l9OZN3ygBXIi1YpKOGiYyKljbHG3gNaMAL7Hbj2xhQ57Wjnuqx2SpqkNI7KpvACKQtjBERUCIiAiIgIiIBUIVCllqmRxaQfT1Wl_iVtjquwUs7GF2JDuI9BhbqIyMFYn1Is5vOlqqEDLmtJasq-XK_w9V7Lbr98FS8RtkY_bn144XWczSWtwuFqr8TpzWMFRks8GUNd9twyu0dM3mO_afprhTuB3tBAC49x7eL49ju7YHeZoyR9FUqJHB8o2jGAMn3VS4WtzUphQqlipMRhSiLWpTChShTCdlKgrGClQFPotgjlSiKmnCcIiMRhMIi35apPdSFB7ojcXG4x3U8evKob2VQWxy65VRN_OaQOM8q7PIyCF8sjg1rBucT6BWHMEjSwOw8_LytZdctdR6Y0pJTRSNNdODFtHcAjuuvLlfHNfW-__AMf1_UNjlD4oJTGx3pjIW6vhktU8dVVzysO1gaWnC5v0_bai73hskjS-eZ4OB9V3R0k0_wDwDS9NDK3FSW_mFW49des4JAwO2UAdnvwqI2kE7ufZXlsRqnY31VSIqzWCkKETGJRQpC1oiIgIiICIiCCih3dSFJiC7BA91alYJoXMI4PBV1zckFQ5wb3Tojjz4i9KPt16MkLHbJgZNwHA5916vw2a1_CvbYrjIADhsO49v9lvnqXpeLU1hmgDQXjzjjnhcVaot1XpS_unha6OWJ_mx6Lnmx6eendLG-Xv5Scgj1VS1L0X6kx6ltkVLcJA2tj4DSeT6BbbwHDJ4K4Xn125uoVSpc0gZYeVUpsx0giIsBM4RUnzO2_RGq8oqANoIc_hVb27Rh63GWpCn0RmD-tXCNrc7kkT9LSlWKiaKkp3y1cgaz1JUh7XMZJHICx_AWmryKnCYQ1UiItapdweVCOy_O7s3skJL8k8Baalqqzg4PdUcNfjG53osY13q-3aRtklZcpWuqMeRmcFbI59dL-t9Y27R9rfW1z2mRoJY3uSfsuONQ3m4691PLWzb3Q7iI2c9s8L69UahuXUC-NnnD3wbz4MWe63t0e6XRwxRV92h2PHmbA4dvZy6yPP1VXQ3pgygiF4u0e5zuYmOHYELfjGhrA0DDjxwqKKERNDAAGN4aB7L7FeOVq0HZIHsrilFUjEIpULWUREQFIUKQgIiI0REQEREFLu6lvdCizG6h2eFDwHjlVJhLNY-ab8uLyDOTg_Zao6xdOIdRW-Sso4gKpoJAA7_cLbz28cBUStB5J49Qs-fFSvz4MFy0jfmy0jnMlp37tvPP0XTPSvqlQ6hom0lfI1lfjG3IC9fqj01pr5TTVlrp4mVbRuAHG4_Vco32wXbTF4M8Xi01U12SW5A_muV5ejmu6IWOxyeD2Vxc6dJ-tJYI6DUjnZGG-I7JK6Ao7jS18LZaKeOUOAPlcD_kufUd50-tQqQS8ccH-inDyBnHHsVHy3Uo4eUY7kqNwecZwQq0kFqQNDw3a5xAJ4WA37qta7FdJqGsp5N0fHGFsP9WfX3Xg3XSdiuczpq23U8kzu73MyStTZaw1vWfT0nzB7Pu4KJur-mQzcZHvwc7WyclehV9LNPVLsto4mD6NCij6S6cpZRL-EhlI_S5owiPmsE1frqt17BJabBQVcTZCA2THH8wtyaToZrfp-jp6l_iTNaN3rjgK_arNbLU1v4Okhhc3sWDGF6TMDJHqsUYTClFuNQihmTye3spdyMnAb9O60txQQSSAoc3dGdx2sbySrVXcKOio5ZqmdsUbBkl5DT_Vc59WOt8soltenG_lnLXTch37LZE3tsnqT1XtulaZ9PRubLWFuAAQcFc0XKoveurqamqe95kdlsIz2P0VemdK3bVl2jfKZKiWQg7n9gPuuqum_S2j09HFUVrGyVYHY4IC6zjxw679Y10b6WR2uFlyusI8doDo2OHAP1C3cxjBgNYGYb3AwFcZGATk8Yxt9Arm0YxjhXI5W6ogDR2OSeSryhrQ0cABSqxIiItEBFKIIRSiMQpCIjRERAREQEREAqFJUICIiCHDIIVDWbGHcchVuGRgqBwMLBZDAR5OFieuNC27VNIWzxM_EAcPx2WZOALSPQqGtDRgKbFTpxP1M6U3KyVLpPCfJTg-WUDssd0vrHUOhqpoimlkpQfNEeMhd6VlHT1kLo6mJkjCMeZoK091A6L0F3L6m1Yim74ccjP2UXlc_kebonrVZb3EyGse2lqCMFpOcrZ9LX0tbDG-hma8EZwFyBq_pleLLM6R0MgLez4wWhedpvXeqNI1QFPOHxtPmY9u4_wBSpvLrz27dcxuBj5lUO3K0po7rtarkI4brDJT1R4L3uAb_ACW2rVdqK6UzZaCshlaf7pyo65x3nUekpAz3Cpa9jhtBxJ9VAac4JyR7KMPrR3HokbQX-3Ch5AHILPqVEeMZJz9kxv8AgYxvzlVHIIA7KNnqThVwhxBy4ALJKy-JRRtcTgEff0WP6j1ZatPRudca6EED5c4KuSs-o912GguD9pWD686j2bS1K576hktWOzAVpbqL1rrru59Dptpp6cktLngOJ-uQsD0zpa76juYfI2orHPOXEEkD-aucuV6fVrHXl81xcH7pZIaCR2WxDkYWW9Nekc98qop6mIilBBMjgttdO-kVHQPhqrnDmRg4af8AZbfho6eFzWwxCNrewYMBVI5Xp4emNI2nTVE2OkgYwju8DuVkLS5-C3ke6utY3n1VQaB2XWOVq3G0NJOck91dCItZqUQItBERAREQEREBERAREQEREBERAKhSVCAiIgJhFGVlE4TCAomARwrAaGAlriVfVHh4GGeVbg-Gvt1LcYSyrgY8H3GVrTVnSC03lr3UsYhmPLdoAH7rbTWkDvkoG4B9z6qbFTrHFOu-kV3s0jnvhLoxy10HmP8ARYZQ3XU2lakPpqmYMb_6TnEf0X6Cy07JonRytD2O7grBNT9LNP3pr3fhYoZ3f-qBkqbFfbQmj_iBno3NZqCkGOxc1hJW3tOdU9NX4l8FW6F5xkS4YP2ytf6p6DSRseaLNWPTIAwtUXnpfdbRLuqIpImk-UNGVOR057djQ3S2TgPFwp5B7eK0_wCqqF3tz5xBHUw7sZwHj0XDrafUFBNtpaioYB6AL7mP1PC4VbK2qZLjbuDfdZkdZ27UdcqNsmZa2lawf3pQFi-r-p2mrHC7fViRzBkiIh2f5LlNlLqW5v2y1dTKXe7V7ll6T3a4TMdPSukDzy93ok5T10yfVXXm5XJrqXTtNthdx4j2lrlr6O037VFX4tVLVVL3n5OXALf2iuhlPThstxnJb6xlowtvad0nZrCAbdSxxPH6mhbJHG9ND6C6JGYMqL2PCYADtZ3P3C3vpzTFvssDY6GnjjAHz4w4rIPCbnd-r3VQaO55KqcpvSgdgCfN6q4AAEDG5yByU2n-8qkRRox2UqGtwO6nC1giYTCAFKAItaIiICIiAiIgIiICIiAiIgIiIBUKSoQEREBMKQiCMIpTCCEU4TCCEU4TCCFQ9gPLlcwoKZotDaRgEfurFRRU84Imiifn3aCvpdGHfT7KdgA4WfJKxufRtllk8R1G3d34A_2Vcumba-DwH0sIiyD8gz_kshAUloPcJ8q-3iUWnbbS48Kki--0f7L02RwR4a1kbD6ANC-nAHZUOYHHkD7p8svWpDePTCoLAeBwVUxpae-QpA82U-WaqHZFOEwtAIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAVCIgIiIJCIiAiIgIiICIiAoKIgIiIURETUiIia2CIiKxKIiMEREBERAREQEREBERAREQEREBERAREQf__Z');
INSERT INTO `userICON` VALUES ('8', '_9j_4AAQSkZJRgABAQAAAQABAAD_2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj_2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj_wAARCAFoAWgDASIAAhEBAxEB_8QAHAAAAwADAQEBAAAAAAAAAAAAAAECAwQFBwYI_8QASRAAAQMDAgQCBwQFCQcEAwAAAQACEQMEITFBBRJRYXGBBhMiMpGhsQcUwdEVJELh8BcjJTRDUmKS8RYzY3JzgoM1RFOTRVXC_8QAGQEBAQEBAQEAAAAAAAAAAAAAAAECBQQD_8QAJREBAAEDBQABBQEBAAAAAAAAAAECETEDEhMyUQQUISNBYTMi_9oADAMBAAIRAxEAPwD9BgyqGqxBWCvO-7JMKmrHKoHCIySqDiscwqBQZGlWDCxA5VgygsHKyByxBMFBmDlYcFhlU04ygyl2ipruqxA9VQKDKCqB6rGHJgozZlBRKgFHMrdLMqFj5lQOEuzZSFMpylyxhNRKYKXkscolJEpcsaamUpS5ZRKJUF2UFyXWyubokXYUEpSixCpSJUk4SmFGrHzJEpE4woLkWynHooJlTOVLnQimSoJykSVJKBuKknCTj8FMoEUj3RMKSUEkoScUIjCDCsKQJKsBFCobIDVTQiGmCiEwMoGExqgDVMBBQKYShMIHnqrBUQrDUFc0aqpUwmBBS4yAwE-ZQEwMoLBwqnuoVIHKYOVITRFygGVKERZMJSpQgoO6o5lKELKlIlJEoCUSkhFBKkmCglSSinzZUudhCgopkkqSc5Q7RYySUuhudCklIoJS6lKkuQ4qCgCcpIKk6oAlQT0QSocUAThCkoQcwcftv7jwsg49an9mp8F4CPTzj4MOseHnrBcFlp-nnHm68NsD_wCRy-ezUZ59F76zjtoRkVB5LI3jVmdXPHkvBB9oPGxAPB7V2f2apWVn2h8V5iH8FoCDp67VZ26rXLpeveBxmy_-Rw8lkHGLHeofgvB2_aJfxLuBtJ6CuFf8o11GeAvJ_wANYJbV8XfpT-3vA4vYn-2jyVDilidK4-C8Hb9o1WPa4HcA9PWtVN-0lsw7gd5jWHhPy-Lu0vXvI4nZEf79qv8ASNlH9ZYvCB9pFHfgt8BvphV_KTZb8LvxP-GU_J4btP17u2_sif6zT-Kyi9tD_wC4p_5l4KftH4Z-1Y8QH_iVN-0jg41ocRb40VL6nibtP17197tScXFP_MFYuKB_tmf5gvBh9pHBWwXsv2_-Aqx9o_ATk1LsDvQKXr8X_if2939dRIxVpn_uCyMqUoH842f-YLwhv2icAdEXVdp70nBZW_aF6P78RcPFjld9UfotT690D2bPb8Vct6j4rw0en_o-RI4qAO4csg9OuBf_ALimPM_knLV4bKZ_b28R1VQOq8Rb6ccE247QHY1CFmb6b8IdHLx62A_6yck-Jsj17Ryo5e68dZ6Y2BxT45QPhXWVvpbbu9zjVH_7wnLPhsj169ypcq8nb6WDRnGKX_3j81kb6UVD7vF6ZP8A1m_mry_w4_69U5UFhXmLPSi524jTO3vtVD0nvcfrzD_3BOX-HH_XpfKUQvNT6VX-1zT-Sf8AtXxScVafwCcseLxT69IhBC83_wBsOJg60j_2oPpnxQfsUv8AKnLHiccvRyFJbnC85PpvxMf2Nv8A5So_294gD_V7c-RTlg2S9I5VBbC84f8AaBfFsC3og9RKG_aJdtaA-ypPPXmIV5IXZL0R2ighef8A8o9Ye9YU46iofyR_KQR73DZ8Kn7lN8GyX3pUmV8L_KTSBh3DX-VT9yY-0q0HvcPreTx-Sb4NkvuCOqh2Cviv5SrHfh9cf9wQPtH4c4j1llctb1BBViuDZL7JxxhQSsNrd0by1pXNrUD6NQS0hUXLcTdlTioQTKUqgQpJlCD8rNM5wq5omVgDj_oguX2chmFTon6zOcrBz9ThAOOqIzl8iJwk1wE5ysUmJnCObGc9ELtjmBQH43WHm3MyguzjRLjL6x3MYIlL1pAiYWEvAx0Uh3XTZVGz65xGs-aXr3AYJKwSdZRzDr5KDaNy-NSkKzoy4k9VrcwIAQHRgDCF5bLqxO8nugvDgA4Ax2C1w_PbRUCJRbyzgU59xn-VQ4Uck06en90KOYHAEqHeKJeVOZbnLqFInpyBL7tamB6imB0hTMSRqUyd9kN1Xo-6Wk5t6UjT2UjZ2bjLranPggOx4J83wRd0-oNhZHW2pqXWFkSP5geRKy80a_RIOMqWN8-pbw6xAPMxx7B5QOH2gJ5fXA_9Ryvm6GEuaf3FLQRqVerFpaBjWipcg9qpCHUKYAi5uxt_vTlYufGJKA7qlo8a5q_WSnTIENvL0f8AmKsOe0x9-vs_8YrCXR-0oL-pTbHhy1-t5tao1oB4jfmdYq_uWX73UjHFOIjwcCuUSpB6fBTbDXPX663325H_AOVv8591pQ6_u-ZppcWuoGvMxpkrlcw7o5sYKbKfD6iv10BxDinMY4q7_wCsFUziHEh7_FfM0WrlE5xKC8zrKmynxfqK_XYbxK-JzxNgG5NAH8Uv0jxGfY4lbuHehH4rjAoJjXdNlPjX1Nbqni3Fg4j7xaPHU0yF3eD3Na4tHG6dTLw6AWaQvjA6ZyZO6-n9H3E2byY1CxqUxFP2fbR16qqrS9s-zq5a70dpU5nle4a919TMr4H7N3AcIIGoquX3LXYCxTP2eycsshIlYyZRK1dFoUShLj8og4GgTnqsckapzO6-7jqGpVZJIUDAVHBIOMxlAQqAjMqRpgrJ6mobf15Z_NTAd1KBF2NVMgeCAcRJ8lDjnVAyRtqhphRIOmE9NSiMnN5dUHOxlY9hCN90FY79JVB3mokJygvmhMEzqsYJnTB3VjZAEyMadUb-KR1RmJ3QOdMpEqZzkpj4oCfHxTyQZMlGdcqBkmUFE7E4S3HRJBOeyBzGT9E-b4KJyO2iDlA9ZROinHxSJBMRsgZd8eiRM6pEpSJPdASgHGvms_DqVG5vWUbq5-7UnSDU5Zg7LBVbyVHM5g7lJEt0KIlx2HzSnbPRDu6XfZEUDmM-Kkuk6JGNDqpRYXPRInBlLTGfwROCUUTiV9N6Nu_o93_Mvlsgyvo_Rs_q1TxXz1Or0fG_0h639mzv6MqDcVSvvG-6F8B9mx_o6piP50_gvvWn2QvhTh0qssgSUymtoJQpJQg_KLtyhhzB207pTnGE9RGV6HHdThdOnSpuvrloe2m6KNM6Pf1PYLSuKz69xUq1Xc1R7i4k910OBV6jGVW1W0allT_nHNqsDhOkDoStK3oMvL1rH1adtSe4kudo1qC-F2hvbsMLgyi3NV50Y1bfGeIU7h7aFm0C2pDlaY1H5Lb4zdU22dvw3htP1ds72oiXVBoC49SuCQARsi2sf7ONFsWnDq94HPptayiz36tQ8rG-ayWltbuZ6-9rertmnDW5fUPQD8Vi4nf1btoptApWzRDKLNG_me6IwXFB9tU5KkZHM0jRwO4WMmAI-RXX460UrbhTBqLJhd5klccwiTAkwOb5pzpCkddkc2VRR0QNBKknomDoJUGe2ZTq1SK1YUWATzchcfIBbTn2FDk5KFW4O5e7lB8AFotEiVt8KotuL5jXGKVOatTs1ufyRYF_Rp0bp7KbS1sAhpzEhavMRqICy3Vwa9xVqunme4lYKhhhMTugy3du-3LWviX0xUaOxGFu8UoW9v8Advu8g1KLXnMjI_1WzxyzrOvA4t5aDWMph7sDDR8VzqFJlaqQ4udQojmqOB26DxRdp0LK4uLWpcMpxb08OqOMCeg6lanNounxG-ff3HqqILLRhIo0AIDW-HXukLK3p8MuK9Z73VWw1nKYaHHbvhEmlzTMxsieilxg9EjoiKlBMaqQdMonGMFA-YnRInqlklIzOoRDMnc-SR_iUp7lbfD2WFV1Vt_c17fALH06fP4giQg0zoZRLSDynA3XaFxwa0_qdjVvas_7y7fDf8gWpxDjF5eM9XVqU6dCcUqVMMb8AjVmh4ytq7oU6XD7MtZFWoHPceo5sLSccYmV9NxGhw6lZ2r76pVq1mUWU227DyzieZx6ZRYi75-o9htqVNtNvMCSXbunRO8tatnWFK4Aa8tDoBmJ6re4S-hU4zbPuPV0qFM8wadMaN-Kv0np13cVuLirRqCk9_KHlpAMADBQs4-EjhIkAiPgmfmiJOq-i9Gz-rVexC-eny3Xd9GieSvjovnqdX2-P_pD1v7NT-oVR_xT-C-9GgXnv2aOP3KuB_8AKfovQW6L4U4dOrKgYTlQmVtDQp80IPyjpM6IBiQMII_JKO51Xocd2rMi64Wy0oVGU7htRz3MdI9d0g9Rlcx41aRB6dFtcBovueK0GDRk1XEbBuVq1X-tqPfEczi74oO7QvLFtW0q0S515UfTp8pbim0QD5lcW6AZd12t0D3D5rLwihUr31P1bcMIqOJxygLWrGa1R395xOPFFlsWNhWv61RtvyD1bDUcXuiAFqEE8uCC6IneV1fR7iVvwy4uKtxaG556RY0c3KAe_ULF95qcR4lRq3TgXuqNbAENaJGAOiI2_Sw_03UpNILaNNlMRtDQuMQQI1XQ464v43ek6etcPmufEjMQhOSnvB3SdmFWh2iVMCeqIQnZVgZk5U7p7INqwp0atV5uqhZSY3nhvvO6Ad112cRo2nCjVs7WnTdWqeqHP7bi0ZMztK-dYScMBc44AAyvobh1K3p2tOhS-83FGlytaGktY45JPU9kWGhxdrDVoOFNlKpUphz6bRhp_Ba1rVFG6pP9Uypyu914kE7LafZXbia12WsLjJdUeAT5arXs6Yq8St6THc3NVa2euQg7HGqT77jNYfemir64UadIkzmBPgtZtjV-7UbCgC66uHlz2t3DTAntqVQeX-lHON7wZ_7v3Lc9J7ulacQq0bF4NUx6yow5aJnlB-qNtGjQBvfuFqQ14n19d4yANfALU4jdtuKraVuf1SiOVgOp6uPcr6E39jxa3No2r934jWYGm5ezlbU6Meev-JfM31nXsa7qF1TNKq0ZB3HUHcIky1i4RuiZQZBKmfBHzMHcEGUA6qBIMiOVV3BwgerfwSJSzofqhAEnQFSYJ7px2TY1z6rGUxzVHu5WgdTog6_DqdC34HfX1xTa5z4tqHMP2jlzh4BcZ2dV1vSB7Wfd-G0T7Fm2C4aGofeP8dFh4rd0L5tvXbTFO65eWs1ohpI0cPFGpc1xxB26ldrizbd3GuW8qVKVIU6YLmM5iIYNpC4zRLgHQAYBlbnGqza_EK1Rh5ml0A9gIQibOlZ8Nt63FrF9g6qbUj1xdXABAaTMx4LHV4lecUr8RNao59p6tz-Q-6wA-zHRcmne3NMBrKrmgUzSHLj2TssvDbqnQ9dRuWvNtWaGP9WfaEaHuhE3aWXDOqZ7_BVWDGVXCm7mYDh0RIUE46oAzoBC7nowP6xI2C4Ixnqu76NETXg7DHmvnq9X2-P3h6x9m39VuOnrT9AvQGH2QvO_s2P6tcDf1v4L0JhwIXwow6c5ZE5UyglbQ0JShB-VCZUndU6G7lQTk916HHdf0a4lQ4ZdXL7mi-qyrRNIchEjIO_guY52uAJOk6LENYnCodPig6HDeICzo3tP1Ze-vTDWPmOUh0_RaQ0noFGZGs7J5kTOUFAkjQHuslB_q69NxMBrgZPisQgdfNV1kYQb3GHsdxW7dSe2o11QuDhoQVpP2iEAdMJOEbmUAde6RMbY-KnoBKMlATHbyR3ET1QlPxQde1vrTh4_VbYV65bmtW0B6ABYLjit5WPKavJT_u0gGj5LQ-SyVKNWnTpPqMLRUEsncdUEk8zi8kyepW96POpt49ZPrODabagcSTpC0B72JTbHNB-SDPWr1G3j61Kpyu9YXtIzGcFY31XVHue8lz3GST13WM5SPUGEDdlbFa-ubihTpV6nrGUp5C7VoO09FrZAS2xsgo580iMhE4xCR16hELQwmMTCnrE9EOOZygqdRA8UpSGRuQngICepBV2lw-1uWV6QbzsnlkTBiJWPp9QjzJ8ULKLi5xc48xOs7qD_ABCYEYTjHSEVEzokZjVXGEo0QQfipdpqYWSPioJQhPZMxAk6pancEbJYQMGDhdv0aPt3BmMALhOMAGThd70YBLa7o9gYnuvnq9X2-P3h6n9m5_mbn_q_gvQ2aBec_Zuf5q6H_EH0XolPRfCh06ssqagKltBuUIQg_Ks56dlE5z-aoiRgE-CguxvnK9DjlMabqgdepSG2T5JgycIDMfJMkwYMKZxqE9ARqgYORqsmRoVhHvCCsjNvkUGQE7pP0KAcJE4QY98J45cpHaAkTg9kBv8ARIEe1KU95BUkxqR5oOnwq3ZWqvrXI_VLdvrKp69GjuSte6ual3XdXrElxMNAOGjYBbvEnizsLfh7Ced4Fauerj7o8guYNMFBQycoiQem6UwJKz3lrWs6jadw1rXOY2oBM4cJCDAdsSToBqk4OYeV7XNOsOBBWxZ3dWxrtr28Cq1pDSRMEjUd1tG9uL_h9yy9qGv6poqU31D7QMxE9NUHNnMndAKmUgUFkyc_FS6dpCHYxspOmSgcSXHMHVAOuhUg57dVQMjCBxoUZjAlInCqk4sqMe0wWmRhBJg9R12VduqqpVL6jnnV3QKRgaeaBnr9VXwUTBkgpk4QLAS01QSgieiBHQbLE8zOD8Vl2xg7rDUMxEQEWYSc6pHpGUiczp5JThBcZIX0XouItrj_AJx9F83MaaL6L0WINrcgkc3O3E9ivlq9X3-P3emfZyYbdRvUH0XotP3AvOPs7kC6H-MfRejU_dC-NDo1ZZdFQMqRlMY1W0UhTKEH5VOgMTnZQddICs4bHRQcTsvQ46ScTtogaSk7U5gJTrBCFlmTGYO4lCgZgnOFQJQV8CVbTjOyx4JOfOVQJwDGqC9M5QXT0UznU-CHHOk5QSSZ7bJgzIAlQHEjIk9AhpyB1QDnHorsafrb63Ych1QDylY3TJhO3rGhXo1cn1bg6OsFB13X9t9-vKtzYMu31KhjnqOaGtGIELDxWjbUXUKtlztoXFP1gY8yWGYIndVVtbF1R1dl_TFu88_JB9YJ2iFrXdyLqu0hvq6LByUxrAQYCeaGbOMfFdX0mqet4zWAPM1gZTEdGtAXJiMzlNznOcXOPM4mSSgeCD2W5c_q3D6NJoHPcD1j-zdh-K0uXmEHC6rLrhNzZ0mX9O8pXdNoZ62iWuY4DTByg5Bd_ewU9Np80qnKHubTJcwHDjiQpgxrqgoZ6rPa21S7rGlSgOiSXGAtecd9ygEjIJHhhBvD7jaNaCw3dfcaMWtdXP3iqKgp06cCIYIWtqTqSVWdRjxQX2AyjTwUgTrGU5idhCA1dhOcCUgSDMoGNEFj3s4B3UlwOmihzp6lQXfmisjnZzukTI6-KgumYKmRiYQZHPc7B0GkBRMgdVBcdiFJOYkoGTCkuyUGead-6kjqD1QUHDqfJd_0W5j69w90EAlfPiV9J6KYt7gA_tg_Ir56vV9_j94elfZ8fauv-Zv0XolI-yF519n2Kl13c36L0SmQWr4UOjVlnBkpgrGDlVK2ii5Cg4KEH5cJ9lYjlWTIypJXocqzG4dEnQm6SMEeCmThA5yN9kxkjIU5cRHXUoAIOd-iJ9mRkRnRVmBupa6ZMqp92D4IthMEHqhxgHb8Up5SY-ClxGZHmjMgZOs-ScmQZyFIOwOAjEzhEVUA5jKg4ATeZMykc9kGShQuLkn7vRq1YOeVhd9Fnq8N4jRomrVsbllMZLzTIASs-K31lRqUbK9rW7KhBe2m7l5lu8J4jf1L9jTd1nscHc4e8kFsGZlGos5YIjv3VBSTgwUzidkVQwCdApIH71s17OpRs7Ws9zT95aXNYNRmMrsEUPR20YTTZX4zVEkPHMy2B0EaF30RJh84ZGuqBnB1RUqPqPc-q7mc4kuJ3UkwfwRlW6RkxJygaAR8EifGECJMlAMHSEOIAyR4KJPeYRbMoJCc6gfJYZgA9VQccZRLMg16eCr-JWJh2WQwjTCYOZ-aNp2See-qUgxOqIU4xPkjOdIScYI6IwcEoEdDmCp67qpjQKTB794QG2EgQBO6CY1jKnmgoK6n4L6X0UINC5bPtczfhC-ZJwe67_omSH184IHkvnq9X3-P3h6b9n-K10O7V6NS9wLzn0CMXF1n-6vRKXuBeeh0assoVAwoBTlfRDKEihB-WjrjGVLzAVb51WI757wvQ5UicmYSEKYg5geKMHHTVEur2SOo3Q12ZyTCWBqf9EwQNyiMrSNYymJB_eoYRlMwcgZjVGjxGRkqJGY6-KqQBvGmqX7PkiSRjO34pkicxhQZ5s_FP6okqfqOwUaKyfZErG4yIRASZyulw94o8OvLvIc_9Xpg9Tlx-AXMeRyknSF0-Jg0OHcNt5h3Ia7xEZdp8gitAjpKbZJQeU0WkPJeXQRGgTZ5x0Qu69k39IcPNk_NehzPo_4mnJauNMzLpzvrK7XAKVX9I0atJjiaT2uc4aNE5nyXKu3NddXD2e66o5zYPUot2ExGYQ2SBudEjnfKAc6SUQxKNNUox-CCY6IE4mJ2PRTiY2QdDnwACkHHQSgqSB2RON0htrnqkd9NUGQODfFZWkPEyFrkcrVlo4MQOqDHUkKSZHWVkqgEkhYSgAQDGEHJwUjoI1QCdJEnsgCegmFMnmzPxVaSPooJ7D4oDM5KNTv8UYGu3REySNIQLbPlC-g9FKZ9Zcvj2RygmV8-4geC-i9EHGLoRglv4rGr1ffQ7w9J9A3frdyOzV6NSPsBeb-ghi9uddG4K9Fon2AvNS6Ms4yn4KGnYqxjRauyEJIVV-W3GRopMGcY7Ij2ZScdA0wTqvS5TG_XTG_VEnfMIO8JEZMRMoyowScEhLMY31SmT-aYM_BBlaYlMuBHQqAQCIOiHGROfAosHPMRiSNka-KnbsiCBlEmQ4S7p3RvrIQTzFJEN0wkfkUGcyMSpLsxMIsE9vNicLe41d07u-NSjzeraxrG83YALSDXOwxjnGJ0OqHMe0tNVj2A7uaRPxQUDjwV0zJ18liMRAgBVTySi2dGi5wbV5HFstgwYXPJlukdltsdytfOfZ16rUJgZOd0JTOMfJDTpr8UHJ0yNkpbKIs4ET8UnYlR1EbJz8UAYmJUE7BIug65KmcROUGQGRvhAE-CxtdmZJ7K2kiM47IHpjp0VMeATOkdVjJxOE2kNygqsc7hQSScY8kyebplS6B2QLrJx2TO2SpntnRAHePBAGd9FMg4803EapE5RYPbKkjJ3T7lKToRjshMFMwDpsux6LvcL40wXBrhnoYlcb6rr-jI_pOnG0n5LFfWX00e8PU_QX-vXM_3W_VejUj7IXnHoNjiFwD_AHG_Vei0T7IXmow6dWWZVKiU1q6GhJCo_Lsz4jVI6R_ATJnXKkmRpEr0uVKAcaFTvnQKnYnEwsc-1lGVYxHjKMDAHhKnEnsmDInM6IMhIMQczCZdkdenRQJ5oOiCRyCAZ1EIGO-oTnOVIOdEHxMIipjqPNIYbBkiUiRKRMz-aKZ36J0K9W3rNq0H8lRplpgGPioJhRAIcM5Qb7uMcReZfd1e8GPot-jc163oxfvvKr6jXVqdOh6wl0PGSR5L59-PHouzx-LWlY8NEfq1Pnqwdajsn4CAiw5ZOMrqcE4LecZbWdYutW-qgH19dtOSdhOq5XsneEBnMYa3mecDx2RXTp2lY3ws3M5LhzxS5XY9omFs8O4K-5vbgXlYW1nauP3isRIbn3R1JS4rXqUeJU-Qh1e2ZTaXay9oXW9Lr43HD7MWrA2zuibkkauqaOB8EHznFa1lUrgcMt30bZggF7pe_wDxOWlmc46LJUHTqohGZG5j6JEwEtZKQQI6afJSInXRVMbGFMnEbbIKwOsoGOnmpJxJGEAyUDJEnCJ0ASOv4I16oGXHQxhKZHbqlB6fFBnlg7oAHODr0TnKXNnT2eiDPmgDE75UzATLiXHCUwcRCLEDmmYSPdImZlLfO-kIsq8F1fRh0cWpg6QTp2XKiJXT9HI_SlCDpO-uFmvEt6XaHqnoWT-ka_8AyD6r0Sj7gXnXobH6SrCf7MfVeiUvdC8lDqVZZQqCxjVZFtk5QpQrEj8vN00jxKRwAT-9TPtHqnI016L0uTEkZ0WFzgArcSZbOVE6ohTo2NQmCdDp4JEkOJxI-CM6GPzQZQ4EAtBMplx3JPTGigaQNVXWMfggQiY6qzJIziFImTmI1TwR72iBb6bKcTrITlKdxogMh0Y0UgDGwTJ8UYnUyB0RbMtlUp0L-3rVWesp0qgeWzrCV7cvu7yvXrOl9VxeZ7rETGSJUk50EnaJRWSmGn3iWgAmQJW9wKra0ONWVa_c5tuyoC5zW80dDG65wkOgzzYMEGVQ80LOtxq6sq1879GseaQmatQe1UPUjZbFxWZ_spRoVXRWZcudSG4YRn5riNMabKi4luSSAiXIx4KCRMT8VtU6toAz11s-o_eakA-SVzeioOSjb0bdukMGT5ojXIiJ-Sk_NInGQQk7XUeaBnXEhQ7B0kbyEzE4EeCCcCDPigkamPgn_GiD03GEDX80CMfvVEGT9Uh7JxunrA1A1QAyYUuMmIT3PTsiT0KBHTGiU-zk6HQJkeKU7_ElFiCk8udehTONUEzhTG3dFEJjEyp_jCBEjrugonxK6Xo6eXi9HufwXMjSIXQ4CI4rQdpBxus14lvS7Q9V9EHTxOoBImmPqvRaPuDwXnXoif6Vf_0_xXotH3AvJQ6dWWRW3RQrGi2hoQhQflmDqJyp2wSgZ27yEdd43XrcgOyMhYnaCTjqspdgkxKh0xv5oJ6A-WVW4ifzSI6_JA3IxCCmzMTnXKeuQQVAAxt4qmxiDsgqdAB8kzG5KkDHj3VbA7aSEES4HIkoG8x8VRENAOyjHmjUQAZ7ZUzO-e6Dg6b6oO_5oBrpgCV1af6lwulXpD-duHOaahzygRgd1ymkftbr6T0NrUx94ZfCmbOkW1GuqCQyoTDT_HRFhzuK3t3cUbWhfUWirRaSKrmw9zToCufRpuq1G06bS57yAGjclbXFqdzT4jcMvXOfXDzLz-0Oo7J8EuKdrxe2q1jy0wSC_wDuyCAfJBkq8KuWcSqWdBpuarBzO9SC4CBJ-C08TPbqvtOHcPvuG8C4gbOmyvd3zvVisx4IFLd0ziV8bc03W7zSc5jiNeR3MJ8USzEfCUYO2UE5zojUIlk6eHdEn8EyQVLoj5otidrAIUnGI1TMaSkBpOyBzsdEgTHdEDSEb656IGCMDHijMYCR8IhBOdM9USxyBvqiTB3jJSMg7eSWgESUWxnqVIxn8U8ykSZkIH22RnH1RBnXul2wiwJOxE9kb6oOoykYz0QUIOuq6HA3Rxa2AMHnxC5oJgDr8l0OCkDi9nge-s14lrT7Q9U9FI_SziD_AGf4r0eh_uwvOPRaRxkicerP1Xo1D3AvJQ6dWWVUpCYkraKQkhB-WNjsnI5dfgk72RJOEHr8O5XqcggZzqpBxMApx2OUogbzrCBOguIGvTomBJj6JSM7-CR-Y1hGlSNiZ8E5PRToDp4lP9oa6IKB9nedFQJ5IH-ijmEwBjuqwMxHkgCToZKgEaTAVuGOu6xwJMbCSOhQIxj6JE-1mAmSO8pCBmNNkDbEeyfiunwlv3nht7ZiqxtXnZWAeYDwARE9plcwe1GvwSjAiJHzRYdrjV5Z3RJpiq-6ZyU21A4chaGwfOVxyCcGDODG6TAI9kABVlEZa9d1Wlb0pc1lJsBoOO6xDGmuiXQd09oQMmBpKUwd0TAkfNKRpqIQIknEiVIOFXwU-IQM4G-UjgZlNuNMpCdDCBwCB4pEDOJQB2JTA_iUC3G0YhPBkbApTO5QNAijzRmCico-EbQiEO0IEgnO0I118kp0J0QAaIOndORHteSXgIlBkjTRFgjB_KUCR4eCYGBPxQBpoeyEgYGRlb_BQHcUt5MO5pHc9FoDpv4rb4VP6UtB_wAUfVSrDVGXq_ouZ4wMasP1Xo1A-wF516Nf-stG3IfqF6JQ9xeOl1KmcISTW4ZMlCSFUu_LTiDtHcFKZnqlM7pg9I1XpcqwIxEYSJAaZhP6FKY1076oqcCIM-KNf9UTGkBIOQAIwBPbCto6lTJgwRonnXGEDBgAzhVGDGFAOcdcLIPdQITB_BYzE-W6onGmFB1QI5GD2S0EYiEzJ18lJ17lAhqIPkFv8OpUTSrXFy3np0oHqwfeJ0nstELZsbgW1RxeznpPHLUYdx-aK3qwZW4M67FrQoRXFJnqgRIiTPyXMZSdWqhjRLnODQOpOi6XGuHusadF9Oo91lW9unzYgxoR1XPpVTSrUq1LJpuDp8ChZ3WcMsnVH8OpB9W_bTc81Q72Q5oktA6d1whkDou_cU61K9uOK2j-S2dTNUOadebBZ8VwNMiTKLNgYwomHEwreNZ8pUEEDVEIA7wJ6YRmc9UmyDiPFAxpjzRCkfBMGSQfilIkH8UjkAmSEF_gg9JEqQdtAgnOYz2QGpAEZTA8c7oDjp1RiNcaIFGDpKCZMT59EOMkykc7BAO1CW3foiIRgjOwRTABER3R3Gg7ImCAR5Ix_BRYPpp-CU7ajsl2aUph0HpshKm4BJWzw139I2jogCoCsVv6r1jhcFzWFpgtEwVVjA4haQTHrW_VScNUZet-jeOMM2lpXotE4C864B_63RPYr0ah7q8dDp1MoVKU1pk0JIQflnB6pj-JSGpMAeCcQ0EgxOq9blFgOjCJ5dZVAYz1SdIERB8UGPMTyxlKSMZx2VnfbzUzIJb_AKoDY4KYGBsfFIGdTJnRPXSPigc5H0Vg4BJCxieyoGBgT5oAmWCAR2UAZjYlVidVMRgwSgRkxKXc6pk511SOv4IJJIJjfotvhZpfpOzFeBSNZgd0iQtRpz0Q0aZMjcIsPpeM3Nf1fEad2C177qWNdo0Dp5QuPxC7F3cmt6plJzg0FtMQ2QIn5LFcXNe7AddVX1iBA5jJAWGZjTBlB9TwUNf6JXdGrIbUe97HTgFgBjzXzgORnTZbFK_uGcPfZNqxbF3O5vLmfFaowcHARVPnoViJk6QsxyMicSsThmJREnLhv3U5mMyFRGdvJTga6ygYk4SHY4TGpRkDEz4IhGHRBnvCY3x4JQRrhA0lFPf6pA8o1TEl0IGTHMgUneNEACMZS00HxRjugZPwS6EEk7JEGR0TEc85ghADBAlBPXKDGB8UYk4ARQdtJCJJzPkmdRjOqnYayUJNpGkCFltc31vj-0afmsBOCVktXct5b_8AUbB81Jw1Rl6_wE_0xQncFejUMtXm3BMcXoEbz9F6Rbe4F4qHTqZlQUkJhfRkzqhCFB-WdCRjoqAgCJnRIkDOAgeMgL1uUMAZI1RA6wFPMIEkKxvpnughwE5iI1UE6CJ_JZHaYyoy0kAIJZE41nwTBxr5hEx8esoJgjbXXdAwTB_u-CsZMAGdFjGSCCqaYzjCBT7JGhCUY1CZJkgx5KHHONfkge2mUeCJkCdOyR2mUAJ5hkR4rPa2z7qt6sODGgS9x0aOqwHB0grf4VWtW1KlG_c-nRrNDfWNE8h2MdEWGVlbhlq4sp2pvToalZ5aD4ALW4o-zrXbavDqBtqRYC6lMgOGsdl2aPo7TtRUvOK3FN3D6cFjqDp9cdgOi4V5Vp1biq-hSbSpT7LZmAiyxtY6pUYxjeZ73BrQNySti9oVLK6r29w0NrUXFrxrBGq3fR0Mp3FTiFQA07JhqgHQv_ZHxXLuKxrvqVKri57yXOPUlB2LHgd1dVoqGnQotpipVrPdim058z2Wrxc8Na9tHhQuKjWiHVq2C89hsFv-lVQOr2tem4-pubdlRsaExBHkVwdTsfNBP7Rj5JYPYqhoPqkZmNZREjOkwRhMYTkjGYCTTAxOUBrIQNDAMJamMhMmTk7IEcEZOEEnQpgdktpGiBGRvsgygkkHIR1hAYACMRgQjQGcoyegPZAtASRA6ymf4yjSRnwRrJ2RR4x4IOSgkgzr5JEAxn5ISRzqfBZLUH73QAMQ9uu2VjfmDA7QrtfZuaR3FRsfEKThqjL13gp_pi331-i9Ito5F5twcn9L2sZmfoV6Rb-6F46XTqZ1SlUFpkIQhB-VuYxJM-SQIjsjwkY66JHYYPSV63KMnvlSDk5BjogHpKP7uc9kFAgNzJ2wkT7IOANijbWSESJxscICSIJIhDjAPLGuiJh07qSYmcIKEaDplTqPd00TzpGNUnQNx-aBnWNyJhSD1wEToCEwckQIhAt9MfVPPTBSid05kxmZ2QI5AnykLe4LZfpTjNnZh3KK9Tlc6YgRJPwBWiM7QVdGtUt7mlXoOLatJwc0or6e84m_iN7dWNFrRwqmwtYwDDQ0Yd4z9V88ajPufqfVn1vPzc04iNIWe7vzctNG1t221OoZc1hkvd0_csg4W4M_W720tXETyvcXEeIAMI01zc-o4U23pn261TnqdgNAtNvu4iVlvbf7vcvoirTrcpH85TMtcOyx0muqVm0qTeZzjDQiOtXr03ei1pRqVGPrU7h3q2gy5rCJIPmuWCTvqN0VKfqq1RhMuaeWRopMzplEUT7IykTBg4P1U9RvogYmN0D-co5icEyfDRGusaJbQgYHs6hBJg533EIJ6nySB2CB-SMAxACQ1OZ6J690Ek51_ennG8JmA2N0t8aoF07oGgEeCUapGJ3QXOdkGD2hLIGMIOfHuijOg2RqAemvdEyZPgiNAB4oF4lVTH89R7PafmFJ7j4pA-1T0w4H5qThqnMPX-Duji1pAjJ-i9It_dC824X7PE7QxHtf_wAr0m29wLx0OnVLYBlMKQchUFpk0IQg_KgjEnKROCTMdIT1wSjbMz4r1uUnfITGTCBHmjy0-SAE7iSnncRmEgTEjXqkSYMkkhBTgNtsFLeQfCEx7wj5qBoSNCgo-fxSOgxMo3yD1hG_dFGgCWsz4p9UbaIEInAlV3z5qfekaZ1VHQzpvlAp7_AJEuOTJKCZmMInGT4oOva2dyz1dCypPq8Qqt5iGiTTafot-34Za8O4ZfVr19O6vGt5GsbllNx6nc6rVq-kd6eGts6Yo0WRFSpSbFSqBoHHoo4iz7nwXh9r_aVgbmr1k4aPgjX2ciIbBEd-q6PD2fdLGrfOA53TSojudStCtU52sAphpaOWRqQuhxuKJoWLJ5LamAe7jkojmEeyQczuCkiMdY-SIMdkBEgx5o0Ax8CgHxRkk6YwiDAzumemUpBaTGEtBMFA5Jico8gfNJ0gY-abtCW7dEAcQgGB13wpHMRMgDxVdJQA85IQdx1SMblBME9kBywPFLfp4Ib17aIGOnggRTbvkwkBDu2ieTOYnqiwfikciEOPiYSLokGZGiAOmIVM96nJ_aH1Spt5x70eKGkc7NcEKThacvW-FH-kbHs4a-C9LtfcC8z4X_XLLOjh9F6Xae4PBeOn9upOIbMKlKpbZCEIUH5UHVG8xgoQvW5QGSAPmkddBG6EIFIEE_6IPjnp1QhAaED2igHInZCECETE6ILoJ0QhFE53PkjXUoQgZMD8UgYn80IQKZTwYkIQimBAwM7rNcXFW5e19w8ve0BoJOYGgQhFYuble1w0a4Fd59K2qcRPFK91bG1c_wBb6snme7_Dy_mhCDjX1Zlxd16lOkykx7y9rGiA0ToFrjOsH5IQiSDrgQgxGB-9CEQE56pyDshCCSMYiUyQCImUIQMYnr3Rprp2QhAvmkDnGUIQHTYo8IQhFE4iPJAiMYQhAu8FLSTMIQilzFrsHXshoy0ScmEIUkpy9c4Yf1qyOPebp4L0y0P80PBCF44y6s4bI0TCELcMHohCEH__2Q==');
INSERT INTO `userICON` VALUES ('11', '_9j_4AAQSkZJRgABAQAAAQABAAD_2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj_2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj_wAARCAFoAWgDASIAAhEBAxEB_8QAHAAAAQQDAQAAAAAAAAAAAAAABAIDBQYAAQcI_8QAURAAAQMCBAMFBQYDBAQMBQUAAQACAwQRBRIhMQZBUQcTImFxFDKBkaEII0JSscEVYtEzcpLhFiRDsiUnU2NkgqKztMLD8CY0N0TSdHWEo_H_xAAaAQACAwEBAAAAAAAAAAAAAAAAAQIDBAUG_8QALhEAAgIBBAEDBAIBBQEBAAAAAAECAxEEEiExQQUTURQiMmFCcSMVUoGRoTOx_9oADAMBAAIRAxEAPwCmQuuNyQng42GiHg1anw5If6Nkkg6_JKjB6pNja5NgtMNiLoELINjdMz7BPOPqmJvdSYxMJs43R0biNj81HRHxaqQj1tYadUDwGRv8PRIkNtTqeq2zQHktvNm-dkxMZc42PUoWY2Y4EjbVPucL-aEqLm7RpdAETEbttddD7OMBMpdi9W0GCA2haR7z-vw_VU7hnB6jGcWgoqZhzOPiPJreZK7dOyDD6SCgpfDDC0NA_dZdRbsjjyzTpqt8sswYibjqt1mIxQ07pZntY1ouSTYBRkhDdRuuR9sWMCoZDhral0bL95M1htccgfqudWpN7cnUt2qO7Ax2hdqTp5JqDhwZ3atdUgX_AMP9VysYbU1DjNVy5XyG5LzdxRPtcFO0tp2NYOvMpiFlbidSyGghmqJnHRkbS4_RdKuOxfajl2Sdj-7_AKHBgLD7tW34tTcmASh3gnhcOtyF0Th3sj4rxQsdUxR4dCec7vF_hC6dgXYvhFBllxapnr5AblvuM-Q1Sdrj5BVRfZxns5wCsZi12xumziwELS7W_Pouyv7O-IHUnfCmjBtcRmUZj8F0bB4qHD4G09DTxU8bdA2NoGyXXY77DVXe4ue4aX2alHUZWWXrSbpbYo89YjhsrsRgo5oXR1Ama1zXCxbrqu2UjMscZboQLKK4gpI8U4opsUDW2EIDrbl9zb6WU9E20bb9FjvuVk1t8Gimh1Ral5EyTlg8TUOahpOhsn57FqiptHaKLmWRj8ExS1hjOjhZPy41ltrayr7HBwtr8EzNG78x9EJ8cCcFnksH8bc86HRFRYsH6E6qnFrxbXRLikew89EZYOEX4LXUPDjcEWKClkAO6izXvIsTZDVmJxU0JknflaPmfRLDb4JLEVyyRxHEo6GkkmkdsNB1K5hXVMtZWSTyOBLzfnoEviHGZ8QkzsBbC0-Fh_XzKjqecRjO9ht5hdKirYsvs5epu9x4XQUM7hqTYJZOSPUOCyGtilNrAdCiqh7XUxc02t9VoM2SLkzE3vp5pp9rdfNYZTI4tufitSENFm79QmgFRv1GZ2ifAOUmPxBR4mF7HUohkjj7psUh8D7JXt92w6hERyZzuGuQzXg6yWv5JYbGdtR12T5ALOYHXKk5h0-iba9m1h80vW12kfBIYrNfQ_VYm-em_NYgCHpS4jxFFNJtuo-lddGtdYIRFj19NVjLXsm2n6pYdproUAOu0AsmZbEGyWSm5NQkPsZafEjYXeEBACxN-aMgN7eSADWEga2K08m37JIJI8wkuJOpTEJ8roVwL5crdSdE-TodSpngfCjiXEEdx9xB97IfIbD4myUpKKyxxW54Og8I4DFwxgpe4A4lVDNI78g5NCRPnfIXOupxxdUSHMbp5tFGfeaCuVNO15Z1YSjQsFOqmSyNc2LQ2Oq87YngHEGL4_VUvsVRUVrZCHlrTb1vtZeuXUcLR7gTL-5gvka1t9yBuit-02x2yV6SRwfhLsNlkyVHE1Z3Y39ngNz6F39F2XhzA8H4egbDhVHDTgaFwHid6ncoieqsD0UTJUObNmDnHySnfKXZKrTpFt9pGXdMzVQMZ11VUxLiShwimfUYpVxU8QFxmdqfQblck4p7aXzOkgwCmLGbd_MNT6N_qpw3TX2oqnGFb-5naH1wgqrFzfE7wgncnkpPG8BxGItlq6eMxn8QOa3kuG9lVNxBxDxFBieIRTGlbI17ppyQCAdmj-i9WT4o2dmXw5Hb3GishRHa4t8ilqZqacUc4ZTGOwc2x80aGeFTGN0l4hUwDNEDlJ6FRkZBasUq3XLazUrfcjuI-fRRs-_kpiqZzsomdu6g0WRwwdpLTe2i3I--oWnaa803eykmOUUZc3SH5rfunR4tUqdwY2w94qWSDiQGOYg6iiaGW7x50vy81Vah76gmSWRzyeqJx6pNRikgabsi8A-G_wBVHZm30cR5Lq0V7Yp-Tj6ixyk1ng3C1pJMozDb0WyWNkAAGQ6HzSHuyC1mlKEgIAyj5FXmcyRkLHXicGtPK6y9mObnJPS6cIBN7XHSyRJ7pDW_FAA2rTYm3wWpDoATp1K1pe4NykXJNideiBi2wtOwt5lPsiZbQm_kmo3WdzJ6ck_qd7BADjIhf3b-qdbGR0HxTDTlG7iPPRPtdcXDb_FMB0NHIC4WnXbryKS0bmxCwH-Y_FAZNgg31ssSCRqOaxIlkgqd2V1gEcBp5qMjcQ4XKPa63xSIhDb281gN7W-qba42TjCb8kwbHPqm33tb9ku55FIcSdkhoYBObVFQk7IRzrO809G7zQgJBnu6lbk9210NG7XqnExCHEDmuodnlAaHAZKp7bPq3XHXINv3XO8Hw6TFMVgpIxrI6xPQcyuzSNZTwRU8QsyJoY0eQCzaqeFg06aGZZC6J0YcM_NH1ckEMeYOA6hVyScxxkjUjZR0tW-U-O9zosHu4WEbfp9z3NkpV4qwnLH81Gy1ec6nRPQUXeNBduU6_ConNs6-vmotSZOMox4KpxHxRQ4HTGaqc-Q3yiOJpc4lc8reI-M-JZDHw9hUlDTHQSyjxEep0C7SzBKCM5nQxl29yLoxvcQN8DWj4KUMR7XI5vf-LeDiOB9jmI4vUe08VYpK97tS1ri53zK6Zw_2W8L4NlfHQMmlb-Obxn66Kc_iAbLYWsE8_Emthc97g1oGpJsFarnLgqlTs5QeI4aWECBjWNboABYJ0RT4mxkNIXZybkgX0VLwrjLD8Y4hgwjD3mpeZckr2e6wDfXmu2YTDSxUTBRsDWdRuT6q-qtyeXwZ7LfbSa5YPS4Y2kwb2aU94bXeTzKp2K4e6ikL4rmE8-nkV0NxDmljtyFBVTAc7HgEHQgq-2mNkcGWu-Vct3yUZ7sw1QE7AXeamcZoX0bu8iu6A8_y-RUM5wcFybIOD2s7NNimt0QF8ZB1TbmX5WR5b8k0WjMoItbBGtPJPYvhmIYdhMmIT0U4h7vO15aSD09PinfSxXQeGOJql9J3NbFHLFEAwECxItz5K-iuNktrM2oslXHcjzA15L3OJ8ROqTfMbAEHyFl6Y4k4Z4Ix97BWRxYdWy6RzRnuXOd0_K4-RuVzXjLsfxbCWOqcHf8AxOmAuWtGWVvw5_D5Lr4wcfOTmZL7WNjZbZLa4DRp5BMu76FzmnR4Ni1w1B-K02V4II-VkAGxyE7NHyTdQS4HNYeib79wFrfRNTyE6vumA2X9NttVobW_D1skOOgLjqdgsa7_AN9EmMJboRrb0RDCbC3zOqGY7T9ynmWcOZ-KBNBIFwLvt6BbAAdcF6Qy-wDQPRLuQdXfRMBwuaBoXX9VgccuzT8Ei5I95adfnp0IQNpG7kA8x8isWnE6fqFiQiBYDd1_VFxEFgQ5u9rbbJyM5bghIaCgbAJbXXOmyZDjayU0ghMTH7787pBJASm7fqku15pDQO_3tU9H4gmJDZw1TkSSG-guLfX4I6goaivrGU1FC-eeQ2axguSUJh9PPW1cdPSRPlnlcGsY0XLiV6T4A4UpuCsE9qrmskxacfeO3y9GN8upTyiJHcAdn1Pw3RSYhxDJGKp7bZWu0iHS_M-ija4sNRKYSTFmOUne3JTWP4jPWuvK_wAI2aNgq3O5x22XN1Fim8I6Wmg4rLBpZBnIvdbp42mQZrC6Yl0KFlmeCNbBZk8GvGS2AwxRC5GgQFRXM_CoMVrj4SSUTDGZRc7Kze5FaqS5ZuoridjYKNqcUZGDnkHoNSj56KN42-aEdhsWa5F1BplkWiN_ibnuDYIXuJO7jZaqeHqjGJWPq6-obDt3MZAZ8rKT9jILQyO-qsmG4c-RjTMcgA0aN1o09FlkvtRRqtRVVH7mR_BHCuBYQ7LRQ-zyyuJmnvme7rqumvxOhw9jY2SDI0WAGqptTCYQO6sA3ZbjqmVDMktrrvVaJQim3l-TzV_qMpyaisLwWmXiCCRuaFj3HlrZVmv4wZDXCOamLWk6uzaoV7jSvsAS09FFcSUraiATsAzN81ojpq_KMktXbjKZe4pYaynEkTmyxPHqCq3jGBuizTUYLo-bNy308lVcCxupwmos0l8R95hOhXRsLxWlxKPNTSDOPeYdwsGq0WVh9fJ0tFr8cx7-ClsGliNfNaki5hXaswymqiXFmSQ_ibz9VE1GBzC_dOa8etiuNPSTh1yd2GthPvgr0bBzCneFyHmqA1DS0H1sU23Bao3GS3mSFJUeGjC8JmY15MpDpHv_AJrclbpKZqeWsFOsvg62k8hFbR09fSyU1ZEyWB4s5rhcKKoP47wm7PhVVJieGN96gqXXe0f82_l6FQ9Lj1ZTiz3CVt_xjX5q20NdTVsbe6lYX5bll9QutOmUOzjVXxs6IXjXhDDe0LBf45w1lgxZoPexEZS8jdjxyf5__wCrz_URVFNPJBLdkjHFrmuaQQRyIXp2hhOHY02vo3mN0lm1MY92VvmPzDkfgqB9oPhNlNVQcSUAtDUkR1Ibtn_C74gW9R5qrBpTOPOdJa2ayYJAJtqeqUACdXFNvv5hvohDE2100PNbaQLA3t0HNJN7a_AJTDrvqkDCYzfz8k8HZTvfyQ8RsTrYeSIGjbjwpoB5thqGX80tmbKblo8kyxzQPzJ4Hw-4hgbJJH4T8FoabeElJaATqwrLm1gSW8wkNChrpoCdx1WJINrjl16LEh4IallHdgFbc4h9wgqZ-mqOLbtuEhIea4kXS2nXVDiQ5bHROsfciykDCQei0ToktKxx0SEDyElyKoYZameOCnY6SaRwYxjRcuJ2ACGtmIABLibAAbr0R2Odn8fD9I3iDH48te9uaCJw_sGkbkfmP0SJMluzXgel4MwwYlioZLi0rddL91f8DfPqVI4nXyVsxe82H4W8gEvF699ZMXONmDRregUTclZbbNzwuiyEMcsGrRdpUPLoSpWrJsoqoFtVjmsm-p4QHKM2yEkizblFSv6aBDOkANrqvBcmxsRtabp6KbIbNJTBeE5GGk-IgKUU28IJS2rLCY5CdynWsDtzZHUWEzzQCWKFz43Dwu6pp-HVjbn2aS4_lXb0egg1uu_6PP6_1KzOyhf8hbKaN9P90LHrzTdFVuhlMcp1BsE5QNnaLSQyAebSm8Tpde8a0grrxUV9q6OHNzk977JcFlRFooupgdG-7TqmKCrdG7K_Q-amCWVEdxa6PxYfmv2RMhe9lj8yUNm7yN0TiNeV0fJCWvO9kNJC7NmaTYcrqxMrwVKtjLJXNI1B5JunqJqdwlhe5j263B1Uvi9P4w-wN1EOBaSCNFLsr5XRbcH41kYGx17BIB-IaO_zVnpMew6qaCydrCeT9CuSSREODgNCnqOcNm7t50KzT0sJcrg2VayyPD5OvPxCkY3M-piA_vBQWP8AEFO-mdTUrs5foXcrKkVDJGuuHXbyISIb3N3XUYaWMXnJZPWyksYwH3DjomzLJSStngcWubzBtZNF5YNdQnQWyNIOtwtGDNkIGL4hHUtmbVSOadLE3A-CC7QsaxDGuFmUk0zhFTyCQsaBZ42156Jtn3ZMUnLZWns6qIYeLKRs7WubK10bS7XK62h-lviqraoOLeC6i6amlk4DdjXXFiUiRw0vo47NV97asIZg_H9e2mgayCpa2oYGiwGYa2-IKoD9NHXLlyTuIS4nz9eixvIdEh59bLGHmCgAuLe-lzzPJPtNzYDN0KGZtcajon49BZ2vkjsB03H4x6BOsNwDlcTZJa64IDGjTmsDQR79kALBFx4nNPK6xx89D-JaBI0Ba71TbjldcXB_KUdjFh5HPXz5rEnMC3UadOYWIDJXKe5ZcbXRkUhAsVGUMh1B0Rovf-iiMMjGc5um6U0gbbJhjwGZeu5snIPe9U8kQpt0otuCtAkcl0jsg4DdxPiRrsQbbCaVwzA_7Z--QeXVGRk92JdnzZXR8S45EPZ2eKkieNHEf7QjoOXzXTcZxJ1XLlYSIW-6OvmnsaxCPIKOjAZTxjLZugNuQ8lASvWa2zwiyEc8sTM8m_RNxyAblMzy6HVR76gtBWTdya4wysD1bNlceiiKme-yflkLxqhXsufNGMli-0Ekc92gT1Jg1fWFro4XBjvxu0C6xFw9RR4VQB1JD7RE1riS3Uutrfrqt1LW9yW27st1DeXwWqOlXcjLPVy6icrxrBajB-5knIkgcfG5n4AnqnCYZoA-nkcGkXBurxjEbaiiAkaHDYgjcKhPbPhMxgJLqV-sRPL-Urq6OFUHhLk4uvndNZcuC68HOIwWKN-j4y5rh53KndFWeDZ-9w6RwvrK7f4Kwh4uLqu782XUPNa_oU2zZL8kV3MEzbPjY8ebUIUTA_QCyryy7CYFPhNKHXFPEf8AqpVPQ0jdDAwDy0Uk4Zm2KGezKnvl8kfbj8DUmBUUozNzjyBQzuG6PfNJ8SpGCbu3WKLJDxcKXuzXkj7Nb8FaqeGaB0ZBje71cVFu4Xww7wH_ABlXJx5FR1Qyzz0R7s_kPYr_ANqK6eGMMAsID_jKGn4Swx2vcuB8nFWU6FaIBR7s_kPZr_2or7eGqB0WQGVvnmQ7uEaYPuJ5QPQKxOblddOizgmr7F5IvT1v-JU5-EYntIbUvHq26AdwnNE60dY0jzZb91erW0Tc0WZvhNipfUWfJF6Wt-CgYnw3Vw0zpw9kndi5ynWyiMLqzT1VPUC4dTzNk9LFdJa4seWP1B0IKrsnCLTUSvhqMrHkkNLdvqr6dSmmrDLdpGmnWA_aVw3PFgmMQjRwdTyO8iA5v_nXCHt01sT1K9LdqtK6u7Gy64kloTGS_wA2OyE_VeZHk6AXItuVgl2dWHK5NO3sT81rTkkvOi01xI5IJBcbgQNfVPjUeE2CFZyI_wAkSxo0JOZx2CEJhMZa1pvmcet054wLtawX6phrTldmfp06JQMYFrOQAokj3xY9RySSL6uNxyN9UguG0ZJ8jzWwdL2seYCGgF2sbgDNz5grFrUAA_i2KxJ8AVCnfklsTYKTY7M3dRL9JAjoSSBclA8BrbIqBvPkh4nbaKcw3DJ8Rnhgooy-SQ2ACi5JDxkN4RwGq4nx2mw2iFnyHxvOzGDdx9AvUUkNNw3gdNg-GNDGRsy3G9uZPmTdRXZ3wpScD8OuqJ2tfiE7QZJLa-TB5JqqqH1Ez5ZDdzjcquye1YXklGOWNSv03Qcr05K_dCv1KxtmmKGn3N0LKiJHABBSvuoFyY24ozA6UVuL0sBNg-QX9EASbq2dn1F3uLGZzTaFpffzOgH6_JadPV7kv0jPqbfbjjy-C_V7xdrAdbXUVM_Mcr9fNVnFuJX03ElS2R16UPyDytpp8bqwU9VBWRtex7buFwQdCujOuUMNnMjbGzKj4Aqtp7l7Ty2VempoqqJ8Mwu0nTqDyKslUQ15a83GyrMkojrpGctwoZaeUSwpLDH-E6eWjo5YZh4hK7XqFPZrFRlBMHx5r7ko0PFt1KUnJ5YoxUVtQSH3CdgdYoJsg2uPmn45AdQdUieUSbCCFhAQ8Ulxqfqnsw6pDG3xhy3C90ZtfRLvY76LCA7W3yQAXJATTiW4seSjaqMltxuFMVByYfEPRR8ga9pF7FA2RZF91qx-C3J4XEE7JBeOtkETT23CbaS11k7mvzCbktuCEBkWfJaSGSjYuC26Rg3c0epTSDKGK2LOzMNwmqZ92eielqYWt8csYHm4KLpaqN9ZJFE9rgD-E3Q0-wymPYG3-P8AA3GWFnxPbNUwtB5EszN-puvKzyQP1C9MdidW6pxvjqmv92KpkjfV3eNP-6F5sxOPuK-pi_LI5vyJSl2Tj0CudcG5K00-LZJDvEbpQdqokgqMDTa6KhIyENNhzQjDdosbfBPw5m6v1b06pgENIDbNbc9Sl5pMvK_RNkOcy48LUkNA_wBpqgQo2Js4ZXFKFgDbVy1m18dvIrCdNd-SORm9LHKLjmFi1mvb11PRYjAipyN8QOqLpxcaJFmPYMpujsHoZayqighYXPkcGtA5lQbGkyU4ewirxauip6SIyPd8h5lelezPg2mwoNBa2SZoDpZbbn8o8lA8F8PQcO4e1jQHVbxeWTz6DyXTXPGC8O5jpUSjTrmP9AqFJSefCLWtqwu2R3E-I-0VncRuvFDppzdzUC-TRNOkuCSblMOkWeU9zyy6MMLA69yHkeBokvk3Q0knVQbLYxMlehXuutyPuU0Lk7IG2KGrtF0Hho_wThCpxKosHPBe0Hps35lUTD6GTEsSpqWnPikfYnoOZ-Ss3apiEdNR0mDQOysDQ94HIDRo_X6Lu6ajbCMPMuX_AEcHVajfOVniPC_so1ZMS4vkfma45sx5nzR_CeMFs7qJ8vgJzQu6HmFC07mOjLHszWGx1UTM809W6SG7Xt8bfIrp21qcdpxqrnXNSOtuqHOBJkvbzVZqakvrnvv5JyPEvbcKiqYRZz2eK3I81DCraIJHO3aCb-i4zi08M7qmmtyIE4vUitlbFPKxuc6NcRzRza-pkbrPLrr7yrEDy6qzE2spiGUADTXf0XchBJLg89K2Um3kLNdVBxtLJ8XJ6mxWqD7e0Sgc_EgJnG4NreiYY9zZB_VPYvgXuSXkuNHiNQ4i88p6HMVIMxKqGgqJPTMVWaCQnLo0qTJ2IbY81BwXwWqyXyTJxOsy_wDzEl-RzJUeLVxGlS__ABKIikI0dt6pTjbY3Ufbj8E1bP5OjcT1E0XDGHuEjmyOyZnA6nw6ql-21J3mlPxVu48-7wPDmdHAfJqoehuDv5KjTxThk06uTVmM_APi09Q2QObNIQf5kA2tncLGd9_7yOrWF0Pm3ZQ8rHA5mgLQor4Mu5_I66rqGnWWS395PR1T5W2dK75lAPdcX_RNxSZXaEp7UJyfyPySTxOuJHfMouKd0sfie4n1TRIlZawJ6ppl43W1shpDyx55cOZI6KPrsYdgEFRXNe50kgDI2E6ZtdUa83Co3H0x7mKNp_GqL4pwZo00sWI6b9mKd9RWcVSyaveIHOPUkyrh2PkDG8Q__USf7xXavsrm8vE-uzKf_wBVcQx53_DdeRzqJP8AeK5PZ3MEeTr1Sra35JBdqlBwvYaoH0GQgZQTeyejdYEgAnohYi6w106ImM3aS4a8gnyA8W5gC51r8rpWRv4d_MpuFme5cfgnjFc3F7-SCIltg61r-aV6LAL6WWrEHZMDdr8rLFq99ysSAquGtc8hoK7Z2TcPxwsfik7Q6T3YbjbqVxnh5pkro4mi5c4Bem8HgZQ4dT07NBGwD1PNZb54WEaKIbuS0YDB7XisEZF23zOHkNUbxxX95XspmHwwtuf7x_ysneAIs81VUu2Y0MB9dT-gVXxaq9rxGonB0e8kenJVN7av7LVHdZ_QyXptz9U2XWKQ92izl-BT325oeV3Rac-4TRN-aaQmzZRuD0Tq6rbH-Hdx8kEDorhwpQkRNs097OdD0HVaKIbpcme6e2PHZI8I4DDgkldilRLeJrDkLvwtGrj9FzXiCrfiuJ1VbJ4jK6-Xo3kPgF17iiqjpqFlCxgfnbZ4P5f81xDiqCswqqz08f8AqzyS13TyK7ulsUpvc-Tz2trcYLauBlkpgkYbnQ6KUnoaWuZ3rJBHINwdlSZK6okN36DyWU9fJDIXZ3FpGrSt7wclSyXXDDUULnUrYw-FxvYfqCq9xDVijdURsd4JRYNdoWnmmW4tUZLRvIHXoofFaDEcSlbNDG6RgPiN9SsdvtOaz2dGr3vaeFlCaKYy1P8AL1U_T7HQFQeGUdVTyfeQSN5eJhVjp6SocAWwyPB6NW3cvk5sIS8obmaXsaGgaIKW7dLG_I9FONwquLbNo5j8EPU4FiTgbUk1v7hS9yPyWe1N9IHwqqIe0H3h5K1MHexZmgKmfw3EqeUPfRztb_cKtWESPkiDHMeDbok5RfTHGEl2jZL4nbaIhkzS2xsFqrpZLAtjcfgmIxKLXjePgjKJKLR07tGNsLw_-_8A-VUAEHmVfe0lj34Vh4ja5xz7Afyqjw0FW4Ainl9MpWbTtKvlmzVxbt4QxUlwjuG_NRDahhkIcrN_CaxzbGmeR5qIrOGsRMpdHT26XICs92HyUezPwiPliB8TLWKj52FruYVkpuHsTIs-JrfVwRb-EKqYXdJED6n-iPfgvI_p7JdIqtLIW6FFlwdqTr0U2zg2pYdamO3SxRcXCNrGWp-DWqL1FfyTWlt-CrSOs0krnXHUwkqYWt0vdxC7s7h2hpo3STOfJlFyCbBcNdW0Tu0ehlqyxuHx1kfeZxdoZnub-VlnuvjODSNNGnlCxNnX_s_wR8P9nfEOP1bTG2QueSRY5ImEj6ucvOlVKZp5JXe89xcbeZXqr7QGLOpuzEHDMklLXyxxmWM3b3ZGYEW3BsPmvKEm-g1WA6qNE3Nr28kpoB9eqbvrtdbFwUxhcN-tkUHE2sLNQkR8P8yJYSBlQGAjvNg1uvknGyOBtqPqkNfZulwfJbvfU3zI7FjBtzrm62XEpNzfkkk6oA3e-ixa0HUrEN4Hg32X4f7ZxVDdt44byOPpt9V3syLnnZBhJp6GrxCRtu9d3cZPMDf6q_Zhchc3USzLB0NNDEMnQcCvh_A1TVHwvlD3A8_yhUPP1V64tf7DwZRUrdC_Iw-gFz9QFz7Mi_hqPwhULKcvljpdyTL3XSS9Nudqqi5oU51isBukAhY062ATRW0EQNLn6NzW1IXVOG-7jwv-IytMbXM8LSNgqdwjhBr6kNe090LOlPQch8VKccY8YaiOjordzB_agbOP5fgtlL2Lc-jJct72rsRiVQ6smklkOrjp5KBxOE1NNJTygOa4bnl5oykrYqyHvIXAjmOYKmOHsNNfXNfI37iI5nX5nkFqT8oxOOeGV3HuEMIoeA6L2iNkGJyyRtbMfee9xuRb-7fTyXP6vh-CnmOa8gGxKY7c-0E4h2gUOHYfKP4fg84zkbPmv4j6Aaet1ZMQkbNGxzTcOAI9FY7p47ILT1J52ldfBE1ukbeim8KhEUDNPNBOjGZrRa5KvXBOCUuL1E0NTI9ojjzNDDYnVVJ5LsGYZZzbOaD6hTMR0GijoqZ1FVy07_eieWajeyk47aa_BNMg1yExMdKWtYCXk2AHNbqqWaAAyNsHaAggi_wS6aR8ErZI9HNNwlVlS6aJrMrWMDi6zepTAiqiP0S6F4a8AgfFLkbcHVN0NLJU1scERAc87nlzUemNLJONY18ejW_BCSMsbZQiWsfR1LqeVwc5vMcwt1UVxmClkMBlXVQ1FBA3NeUWuLbaaqPILTtohHHIb5wioJw8BrjZyBimuOx0CIxKmpmUsjmBoIDe7fnuXnncJktsbpuobdm1kARmoOqW1wG5W5GpnNlKQBDnA7JNwmg89U66CYU3tBjd3N7ZuSAA6-z6aRp2cCCvLvF8bYOJsSjjAyNmcAOi9MY1Vx0eHTVEgJbG0uNl5WxitfiGKVNWRlM0jn2Bva52Q-sDj3k9CtL-JPsynL95PQQ8hsIX_sxecHkA67r0L9mfFocRwPHeF6yxzAzMY78THtyPFvLT_EuFcUYVPgWP1-F1bMk1LKYzmG45H4ix-KRYiMDuQCUN00D_AOwlg6i6MDC4jcIuO1_3QcJAGlzzRbDpYC10eBY5HgAQSEtrPRJbpZLaLnRAGiRy16rWbyW72NitBPIf2acSFi24jY7rEmxnd6GhjwvC6aihtliYG36nmfmtx-Koij5ueG_MpMlSHsBHRLwM99xBhkZGhqI7_wCILjt7pI7KjtiXHtSmEbcNgB0Ac63yCoIlVt7Wnk4vRtvo2En5lUhrjpdTvf8AlZXp4pVIIL91oO080OW2kLw49LJTjooIc8Dub4hH4VSS11ZFDAwve42DQgKKCaqqGU9Mx0krzZrWi911HDaKi4Mwd1XXOa-scLaHn-Vv7lX117nz0ZrJqK47H8QqYOE8BbBC4OrZRvzJ5u9ByXEeKeLqShmMLpC-dxu7LqR6oLtD7QJaysnbSyB07tC8G7Yx0CpHCXCuMca4x7LhcL5STeaok9yIdXO_bcrQo73-jPu2L9l_7PMYfivEkNDg4mqJpzeUFvhY3m5x5ALoHbXx5BwHw23B8JkH8brWEMLd4mHQyHz5D_JCYhX8O9h_CppaHLXcRVTbkO9-R35nW91gOw5-epXl3H8Wr8dxmqxPFJ3T1dQ_NI930A6ACwA8lojHasFEm5PcwSeR2V7yS57tSee-67ng2K054dwt89TEH-zsDruA1AsVwhzmgOzXvyIVjpwJcPpCwmxba1_NXV173gzX3e0s4Oy4bNDVuMsMjHtGl2m6unBlb7HxDSOB8Mh7p3o7T9bFeeBUz0EbTTSvjN7nK611M8PcT4lTYrTy-0PkDHglrtQbFWfSyXRQtdHOJI9LcVQCLGTIB_asDvjt-yCicRbopHjLEaQYFh2MPky08gaQ-3J7QR-iqI4pwgAH2kH0B_oqlCT6RfOyKfLLTG642CU4XabqvR8V4Rpllc4Ho0rUnFtECckcp6XsFNU2PwQd9a_kS8oIKkuFY82K5z-BhP7KgYjxrHDr7K8t9Va-ynH48dOJSxwmIQ5G3Jve9z-yUqZxWWiUNRXJ7U-QvGao_wAcqHNdoHZfkLKRpZWzw23K5PVcf0klVM-SnkDi8k2I3up7h7jTCp3NHtQjJ_C_Qpe1Ndoa1FUupFwliaJ2BwvdwRXGB7t9GW6EB17dNEDJW0Va2Pu5hIHkDw-qztEq5aUUvcw96Sx3O3RJVybwSdkVFyzwbo6sStAO6LyhzSNyuOs4_fR1boqiiLXA28L_APJWTDu0GKcACDKTzLlb9NYvBQtZS-mXKSO1wUJKweShaniCapjvCWNPkFA19bWVDC1877HobKS0sn2RlrILrktssscQ8cjW-psp7i3EKbBOGaWOqlbGHlrBfmQLlchwPDZq3iKgp3F7mvnZm56XuforX21t9trsPpWvsIInPsOriP2aEfTJTUciWqbrc8dELxFjNNiODVMFI8yl0ZuQLBebnHxEBd0wumMVE5j7FxJ-S4jjUBpMXq4D-CVwHpdYZSXvSgvB1IQl7EZy7ZO9n3EcvC3FuG4rCTkikDZmX9-M6OHy-q6p9qTA4xWYPxDStBZVxmCV7eZAuwn1BP8AhXBGk7bL0xxbl4t-zTRV4Oeoo4Y5Sf54nGN_0zKZFvk80NGt90607ZhZNA9U4y4KMjCoTf3Si2croSMi2yKacwsDojIDove2wTgdroU0wG_klNBB11KGCYou11K2LWScuutljel9EZ44DBh5-SxbJA2CxQbY8HZopQYgb8lL8GgycV4Y07d7f5AlULhbGGYhhkL8wLw2zh5q_wDZ-Q_i7D-dnO_3SuXGP3pP5O3Zj2nJfBKdqrg7iOJp_DTt_UqnA2Vr7UXf_FTgTtCwfqqe54tupXf_AEZnqeKo4HC7VJLyeaFnqY4mF0jw1o5kqu4nxfS0oLaZpmk6jZEIOXRGc0uzsPCvEeB8N4FPVVbCMQ1u4_iHIA8guTcZ8bYxxtiwosIinnfKcjI4GkuI6NA5eaomJY3WYpKXVUpyX0YNgjuCuKKvhHH4sVw5kUsrGuYWSi7XNO4W6EWklIwymstxOq8Gdh8uT27jWrbSUrBnNNG8ZrbnO_Zo9L-oRnF_azgfCWF_wLs7pad72Xb7Q1v3MfUj_lHeZ056rk_GXH2P8WyOOK1zhB-GliGSJo9Bv6m5VPeb6K1PHRVj5F4xiNXitdNWYlUSVNVM7M-WR13OKiXE5tBe3Iot5FuaElN-iaBoaeRlN_mrJwjUxTwupXH7yI3b5hVeV2VpUvwBD7TxMyIHxPjfl8yGk2-iupnskZtRXvhgs-JMFgOQSMGbepyk3LQSsxJzmyPad7pWCR_fyyEahg_UrpJ5OJKOGehKx4rfs_xvncXOgY0Anlllyj6Lj1NlLSLOXXMJY6s-z9XMZe7GyON-QbIHH6BcapyXEWa8nyT038l-xa18wf6ROUrWZbh7x9VKQua5oGckKuQioY8AFwb_ADFdC4R4BxfGC2arcaOiOud7bOd_dH7lXTnGCzJlNUJWPEVkAocGfjU7aSkY-WR_IbNHUnkFeOIZqXs17Pv4ZQuY_E6sOAd-ZxsHPPkBoPgpeXEcF4LojRYSxs9adHm-Y36vP7Bcx4oikxuSWrqpXTVLtbuOgHQDkFnSd7TaxFf-myW3TRe3mb_8Obveb8iStszRkOHxIT1ZSOic4ts0t-KEZK69nAEeS1NHNi-eToPAnE7aaphhrHHu841Pqu2cbRh8VLLa7Ddt_kQvLUD7PB1XpbAMUoeL-HKOmfWNixCJoEkZIzZmixNuYO-nVYtR9slM62jbnCUGcV47wtzagzsaAD0Vew-d8bmi-i9D4t2fDEIDG-uaPPuv81AQ9lWA4S72jGsYkMV75SWxNPlc3PyVsdXXtw-zPZoLd-5dFGw2sldIxkQdIXWAa0Ekq04hhdfh9BDWV9P3UMpDRmOoJ2BHLZT1TxfwtwrTdzw_RNqJR-KMWHxedT9VQeJ-L8X4slZEad4p2OzNhgGgPUk7lVqycnnGF-y72oQWN2ZfouvZ3BFUcSRytIJhjc8W9LfuoDtNq5JeMapjT4GBrb-gCnOxykqYcVrH1LHNtAAAT1cFVuI2VGJ8TYt3cTyY6iWxt7zQ42Wa-1x3Tr5aRt01UXshbwmwajN2ALkPaZSim4okeBZszA_47H9F12iDgLAWPmuf9sdHlhoasDUOcwn11H6Lh0SfuZfk9FqI_wCPjwc5a646ea9I9jv-s_Z_4rhnJMUYq8l-X3Idp8dV5pY7qvTPCcIwH7L2I1Ul2ProppDf-d3dt-YA-a6KOazza3Q6p5lzumWG5HJOtJ0uo9kkFxkDnuiohsLoOIhFR7oAKGy0NNlpmywDz1TyI2TbktAkHVadod1v0TA1m87rFo_VYokuhjCMQmoHZqdxb1HVdZ7GuLRU8e4bTVndxNeHgPc6wvlNguI98QbtGiW95dHdpsVF1xbywjdNR2p8HdO1_jWCn4_xKliAmbCI2B7Hgi-RpI-BJCoVVxpNI0iCEMJ5k3VIjObffqU-zwhQdUW8tE1dNJRTJCvxOprHXnme6_LkgSk5tSNwsvy2ViSRW22-TbPeIslbFNh2WRL31QI25oIuEw8JwkgJmTrzQhjUg1KEqDldYBFP01sg5NXFSRFjEgz3HJH8F1IouL8OlJswTtafQmx_VRzja6apJO6rY5Nix4PyTIHo5_CuGvqXSyse-5vYu0QHEHDsdDE2ooYSGvbZ4aLgWOitFHL7RSwSDXvGNd8wp2NoDACBawFirIWyjLJTZTCUXHA_2WB2IdkWOUIaQ8CoiHq6O_7rjGFyRe3U7ap7o6Z0jRK9ouWsuLkedl6X7P4420VfBGxrWOcHEAWuSCD-gVCk4VwlsjmGlj8LiOa016lRcm12Y7tE5xik-iYOMdnnDDI5aN0NdU2DmCP754-J0b9CqtxH2nYhjTnQUJOH0nSM3e71dy-Ck28LYRfSjYfmnWcOYYz_AOyjB62KUbq08tNv9kpUXNbYtJfooNLNG4XcCXeZKkoHA7AG_Qq80-D4dGbijhv1LbqTgoqFhBZTwtd1DArvrV4Rn_0-XlnJsUwWold3sED3sePwi6hJeFcUvmbRy5T_ACr0NEI3RlmUWWVeDSR0HtLi235ediovWy8IkvTIPtnnB-G1dLI0TwSMII95pRGeYm5eLW2sb31_y-S7RPC25a9oPqoqKjecRcTHSmktpZvivp_mqpard2i6OhUPxZQsIxvF6WZobVVroxbwd44j5K5swOXiCL2lkZjn3Oe4zKcbExtsrWi3kjKWYxOBaSE_q34WAjol_J5IOj4LiY4OrpO8I_C3QfNT0WHU9NEI4ImMaOTQpaKeOoaA7R_VZJAR5hUTslPtmquqFf4of4OgbFV1LmjdgH1VKq3OixGodsDK4n5lX_hlhbUT3H4R-q5Zx1Vugq5KaIkOe9xcfK6IQc5bUOyxQjuYyRG-ofJFbK43Cp_atSifhaZwF3RESD5_0urNhb70rBfVuhUbxiwT4FWxnnE79FyLP8drT8M7dX-SlNeUeeYWukkZG33nOAFl6c7f5xw12RcO8NwHK-YxRvaObImXd_2i1cR7HcIGNdpuAUbxmjbUtnkHItj8ZB9ctvir_wDasxUVXHVFh0bw5tFSAvAPuveSbfLKfiukujl-TjTCQPNOxnkh2HS6dj6oZIMi5X2RsRHPVAs0AuiYiPNLsYWNfIJQISBtqsDt7aoYjZOqy43H1SXXtfmtAABD6Ds2bkG5CxaOnJYovJL-yEDbNslNOUHmtX0WN6n5KXaIG4zrdP3JAKYG-ycG31UUMca0m5uAlGwAJOqSDZousNjzQAo-9qlEC1xdNHlqnDsCCgBN97ck2_rZOEXvyTTib9EDGZCg5d9EVJoUFPvzTRFjJtc5iPRCk_e3GlkSb3PohN5LNvckCw5qRBnojssxxuNYTBCRaamaGPHUAaFdDv4iNd1yLsi9nwGim9veGT1BDrnZo6LrNPURzNzxuD2nYg3UpQceyEZqXTLr2fvPtVU3kYwfkf8ANQ9fZlfUt5CRw-qluz4XrKl3SMD6qHxFwdiFSRt3jv1SJGRnXoEQ17La6lBtJ01SjcndAgolh2_RNh4aeqZDSeZRmHYfPXziOBun4nHZqBYJLAoXVtW0Afdt8Tz5dFM4rPBPUMpS6zGEZrdeiZq6in4foPZ6azqpwv536n-irDKt2fM4kuJuT1TH0T_EGFwxGN0LLMcLEb2KgX0eW9hZWfC8WpqynFNWkB2wLjofj1Ts-DHeF-ZvIHdAFO9nk2ASTG9p1Cs0mHuZ74cP-qh3UgPuBzz0awlGMhnHZBMe-M3FwpKhr5HvbEWF5doAFIU-CTzOBkaImdXb_JO1mI4Rw6whhbJVW2Bu74nknGDbwiMpxisyeCXw2jNMTI4gF7dW9FxTjgtl4mqwB_Zvcy_oSr1wZxDUYxxXVMqKkPb3BcyFvussRt81SeJ8Xp4uLcTpKqMFzah2p6E3H6rZRW4WNPvBh1NqnUmuskTht2l7eW6Zx-xw2pH_ADbv0UhUNhbKySnIyuGwUZjhvh8_9w_ouL6lHbe8eT0HpUt2mS-OCI-ybgpquL8XxeRv3dDT901x5PkJ_Zrvmua9puMOx7tBx3EMxc2Sqc2M3_A3wt-jQu79msn-gX2fMVx6RoZVVglqIr7lzvu4vqAfQry-Hlzi5xJcTckrX4Mi7H2bbp1u4sU029gnWDW6THkLYDcFFwg80FE7UA3RjCRsUDHy63mth3VJb1K2SCjsQo-fNJFuW6SdVvz1SbAy5I6LElx0N1iQyIcRcrAbiySL3N1sDXT6KX9kEh1g-ix30SmeEG6be4XSJDjXW03WO12SWG-v0S_XZIDNzonb6apFtE4AANUMBOmU7nomHEA7p958JB-CYNrXCBjDzc6oSbZFSnlshJfJNIiwZ99UTwvC2XiOjjeLjNm18hdDXObZP8OR1MvENEyiZnqHSNDB1U4tJpsqmsxaR1Cdty76J_CMcrMNkc2CU5Q43adQnsTo5qKXu52ZXb6ahRUkZa57gN3FddKM4nAlKVUvhno7sdxWWt4cxPFaxjI2MflBGlwxtyfr9FToeLo6lz5ZKSVt3EnKc3NTcebh7sDYW-CetiB16Su__BQnCHahHgOBU-Gvwhszob3kZIG5rkm5FjrqssaVLLUc8m6WocNsZSxxl8B0fEdI_K1sNQXk6NDLkqwYZT4liLh3WF1cTPzztEY-uqi5O2djW3jwOzupqB_-KhMV7XMaqmObRR01ECN2tzu-btPol9NJ9Rx_yP62uPc8_wDB1JuC0WHU_tONVcbGN1ILsrR8earWOdqOF4cw02BwGbLp3hGRg9AdSuKYvjtXXzGXEq6Wd1zrI8n5KFmxGJo0df4q6vRxX5Mz2-pSziCwdMqe0R0kjnvpg57jclz7kqPqe0CoBPd08I9SVzd-Iue7wMNkjvJpdgVoWkqXgyS9Qu-S-ycf1_4RG0-TUuh7VeIaDSGraWDZj2BwVCZSzSEXupXDOHamteBFE51-Z0AVi09a8FP1l7fEmdMou3avYwe14ZSzO6sc5n9VIQ9uElQQ1uGQQk83Sl37BURvClJRtBrqlodzawXWTUWCsYSxhcRzOirenp-C9arUruX_AOF_xTj7EqunuagRROHuxeH67rn-JcQzzvc2DXXUoJ8vfgQwgiFugvuU_BRhpFm3JVkK4x6RCds7Hyy3dis0zOO4zO8nvoJI2jztm_8AKh-1XDHM49xGYZrSFj9P7gH7KS7O6WWl4nw6oc3K0SZbn-YFv7q5ceYUJeIHVRizh0TdSNNLhZpSUbs_o1xg56fHwzmNAXsjYJLgkaXW8SjdPTPiZ77xlHqdFlbOZ6172ANjiNtPVE0njr6Np1BmZ-oXD9Whi1S-T0no1idDj8BP2m52YD2acN8O0vgje9jLDnHCwD9XNXmGPkvQf2xJnnFeGIL_AHbIZ3geZcwH_dC89M33VxTkKZchERIdmyfYSCLJdksBVhYG1kTG4ki2yFYdLWuiYbW6JIYRey0bhySDre6x5vtupCFutvzWX5dUgH5rd9bhRwBjtliS86XKxRJEUCfUrYuTotAizr6HlZbY7RWFY4Dpa61l8Wqy-2gSieSiNoy3MreYdVhtpcbrdrm4CQ0OXFtOaU0WvdNgbEJ1uyQxp2t9NEzJYbA2TzwQDsmJCTumAy-yFlsdk-7Y3TDxubaJoi-QZ1w_4K39jYhfx3TibKHGN_d3_NZU83MmqRS1c1DXRVFM90csbszXNOoKkRbPUPEGCurIS647xurSqU3D6ySdtO-mOZ8gYNNCSVJ8IcbSVeE00uJMz52-Jzd9NP2V_wCCZMP4i4kpGUjge5f3r2ka2br-th8VqhOypcLgw21U6h8vDJHtskjoOFcCweJpylws0C4yxsAt_wBoLkVNh80zwI4st9yTYLs_aUG12PxxO1ZTxBtuQJ1P7Kv0tFGNmhENVKuO2KHZooWT3yZShwjic7L0zqe52L3n9ggJ-z3iydxDXwOb0jdZdVZRgAGO7XeSKp6urozqc7fqj6uzyRfp9XhHJIOyTiKQAyiIH-aQFGw9k2JsP30kQP8ALqux0uIGrGVjg2ToSkzR1TT4r2Vi1k0Vv06p_JylnZrLFbvZH6dGKx8N9lceJMlklqHQxx6XLPeKvOFUdVX1Qjbmawe-87Af1Uzj-IMoKUYfR6PtZzh-Ef1Kb11jWEKPplSeXycfhwTDKGVwEfeOabXOxRD6pjGiOBgYNgBoFfMHpo63E4IagXjcTf4An9lrH6CGjxN8cMPgABbopfW_KI_6djpnMajg7EsRcZGPdJm1sCUuHs5xcgF8RI83D-q6PT1c0Qs24RbMRnG5JUXrZvokvTa12UKg7O6_MA8RxjrdWvCeAKancH1cneu6AWCnYa-oP4CfgjzUTeyvmMZEbBdx6KqWpsl5L4aSqHgEgwqioXMlEbbsIIJ1sortgqqinwGllpSO7mf3b3DoRcfoVTeNONH1Dn0eGvIZs-QfoFasLH-k_ZU2JxMlRSNy25kx6gfFtlNQlFxsn8kJWxkpVV94Oa0kGWjeXjV4TUsj2Qd5G4tkYMzSORGyPB70tiZu45QEHLG5neRPFi24ssnrHUToegrO84fxxxZjfFmKMm4grTVS0zTDGcjWhrb9AB81AsN0VjsXc4zWx7ZZnD6lBs3uoJ5SZKSxJoMYb2_RPM5FCsKJiRgAuMjoiIzuBshGC5RLDyTJD4trcLL32SW67FK-aBM2N1nPRaJ2WhYm6QG3-6ViRJ4Wm-oWKLySRF2BI0Sx-iTqCddUpu_XmpPJWhbAbrHaEWWMNiVl_qokjTnXuthxWiFjfjdADrHE2Tzd9dk1HonRdIZp50PVDuN087nqUwRqmgGntGuiGlNrol6FlT67Igbv7RCTH7y6McPvL21Qko--sFIgyz8LYjVMaaeIkxsBfbovSP2bqdrxjeNzANhiY2FriNjbM_XyAb81w3g7Bn0uEtrZmm1WDkJH4QbL0RhzG8JdgVVNC3JUVkT3i2hL5SGA_Btvktqy6kvk5suNQ5Y4Syc6rONq-fG62re7PHNM54jfrlaToL-QsFYMK4vo5soqWGFx5jULlFLKZfu5DaUDf8yfcJozmIJb1Wt6aElyjDHW2VvvKO_4ZVwVgDoJmSN52Oyl_ZGvHhIPkqRwH2f4li2C0eJtxOCmp6huYNDS5wF_gugwQ8PcNQ_8LY-2WRo1E0zQdOjRr-q59lUYvEXk61V8ppSmsADsJlLgYmOzcsqsWCYZXFv-vlrYhsHauKr8vanw1TS91QCSZoNu8azK0_PX6KQpuM8LxeMsFYxgcPdvlUXTNctFivrk8KSLDU1cVNTuhw_Jn6jYf1KrTqOWRxe4FzibknmpClZSOIdFUscPJwRgMIOkg-ahhlmUyJpKeSCpjla03Y4FTmN4ca4RzwZS4NsR1CaM9O3dzB8U7DXxsH3cjbdL6IwwyiKjwmUus5pB9FJUuCtbYvA-KJfizGsvZv8AiVH4t7Q4cPD4KV4kqeTWHQepUoVym8RRCdkYLMmXavqcNwenM1fURQxtH4jb5DmuV8a9pj6-Cow_BIe5ppGmN07x4nA72HK6omK4tXYzOZa2Z7ydQ3kExDTue6wFrdVvq0qjzLlnMu1sp_bDhArW20aCSV1fseq3UNTLQVBAZWDM1p_OB-4_RUKip42SA3zv3tyCtnDmH1E-IQVhe6NkLw9hGlyP2V2o2-29xRpFL3E4klU8MPw_iWre8f6u1xfD5g7fLb4Km4m6-I1QsNJCF2PiPEaKowxs3egTM3b0HO64hNLnrZnk_wBoS5cXVxldTKT8HodDKNF8YL-WTiPHEPd8T1zRzfm-YuoNt81grF2gEO4oqiT-X9FXm77qur8EW3fm_wCx5ouU_FYbplgPqn4yOYspleAqN2nLVERmzQTohmEcjqiY9R4uSBjgcDsl3sNUkC1kt3iCTAT5aLY-C1ax0K2Lb7obAbm91xOuixIqXWjcfJYlySABvcpUeu1knZLbZNshgXytzWbWCwGxtot6WskM0QD5rYFlsZUoeaECNsGicAttqm739E-0eFIYy4aZgmH3F-ifeLc9Ey43HVMAd2uhKHlBNuiJeLElDykX6J9kQUixQcotP6o1-h0QMp--3KZHyeo-FcLp6_gnC6RzB4qduU9CRupLtFxSvqOFMMwL-GvjjpAzvJWuzNfkblFh9dVv7Nb6LiTgeeCo8VfQuEQdmN2tIu02_wDeyvLDDOTDVRgSNJabhXVTcWmUXVKxNfJ5pqqJ-YuYCHDZS3D1fGXClro2l2wJG67jifB9BXtJMTAT-ICx-ioWPdmdZGTLh0mct1DXb_NdCvVxf5cHJs0E4cw5IbEMLxAUjm4RX1LaV3iMDJnNb8gbKm1FPUQylsocHX1urlTyYngknd19JKwDckXaUe7FcLq2Wq4W3O5IWuDT5RhtrfT4OckyApcdVPHbK949F0WPA8Ir4zJA-wPQ7LY4Oo3XyzH6KxteSr2p-CkQY9iUP9nUSD4p9nEmMOOlRIVcm8JULLF0pPyRAw7CsPbmAY5w_Pqo_b8E1CxdvBWKGr4krTeJ7izm5w0UjJiGJYSzvcQxKJvMRt1JTGPY9VOd7NhzGxttq4BV1uGzTS56h0kj_O5KUnFdkkpN4i2ySqOKMUxCQtjnkhh8jqQkQN7x95JL8ySnKfBap7SIaeV3_UKMw_h3FJqhsfskkbb7uFlX7kF0y1U3PtNm2zRxDLGAR1KPw2jrMUnEVJG93U8grZgnATC5slc8uA3aNArkxtHhNOI6eNgI08IWWzVpcRN9Whk-Zsr2G8LU-GU-erd3sx36KS74tjywtDW9UiokfUvzykhvJqisYxaKjp3CMh83Jg_dZJSna-eTcowpjxwWLinC4qngOWqw0Hv42B0mpJcAfED-q4j_ABCN_EYo2OBdHTZ3epIXYuyGrOJ4fjdDVSF-Zwc5p5B4IP6LxfXYriOGcS1Exe5lfTzOieSb3cCQQflslasVTq8senl_nhf4Jrjo5uJauxBOn6KBA0UtxPNJU4oZ52tZJJGxzmjkcoUUOY2WWv8AFI3XPM2x-IIiNDxnZPsFipf2Vj7NBqEXFo1DNuiY7W1Nkhjod5rZSBa263ckIAUfK1lrewWNt8PNaJtqgMjFfpTvPQLEzijj7I_XksS5DIydbaarGg31W2m_qsOpUn8CQ408lsn5JIC2VHAzLho6rQfY-SzkkfiQA-x1ztuiG-55oaMa-SJy2akMadsUy7RPv90phw9CUwGnjqhprddAn3kD0Q0ljew0TRFgz_eI5IKo_tUc4eJB1LbSXHVMizu_2QsXNJxzX4a6QiKtonODOsjHNI_7Jeu5cQCWmxaqyatzk2ttfVeWOwLEW4Z2o4HM5-UPlMJ8w8Fv7r1bxpXx4ZxVTRVAtDWw3Y8_nabEfItU4rPRCTS7BaPE3CzXGwUvBXNeALgqKqKKOdveQaO305oLM6I2OZjxuVLIsfBY53U0oyysY6_JwuobEMOwl2kmGwEHmGAJdJWRPGSqAN-alooI-7DWPY9nIO3UlJroUoqXZzmuwMiof_D5GQRH8ORDDAZ9S6qdm_lFl004fTu3IB8ikuwqJw8Lx8lY9Tb8lH0lXwcvdgM19Z5HfFY3h1rvea53qV0t2C9HNKwYQ4c2qLvsfbJLT1LqJRKThyFpDjEL-YU5S4UxlgGNt6K0w4XG0Xkd8AlTSUNEwuldG0D8xUW3LyWqMY9Ii6TDM2gZYdVJspKakZnlIJHmq7i3HOH0rS2GVr3Dk3VUPFuOp6hxETPQuP7KUKZy6RVPUVw7Z0uvxlouynAA_NyVYxLiCjpHF00wll_K03XO6nFq-tJ7-dzW_lGg-SDe8DUm_qtMdH_vZjn6gv4ItVfxNVVpLID3MJ531VcxfHosNpJZppA1oHvHc-ir-P8AE9LhEJD3h0pHhjB1_wAlyTiLH6vGJy6d9mD3WDYKc7IUrESFcLNQ8yfB6N-yrxRLjPaJxHBITkloGysbfYMkA_8AUXGeMsPFR2zYzQgWa_FpiR5d4T-ivX2L_wD6p4p_-zS_9_AoDGGsf9obHM4uBiE9vXVcu-bcXI7OmrSlGC6yQ3GcYix-dpvYBtvkoMbq3dpFOYsZbLbSRgF_MKpW11CopeYI0amLjbJD0Y10T8aHZsn4zpsrfBUgtuw5ohuguRayEi3ui2-IC-yGhjg1N9Fjt9FjfPfZZmsbJAJ56JW43WgLErRCYsEdjb7Ubh0WJrHXWpdOZWJCaHQ4EAW1SgdkjKHc7FKGmh16qTFgc5LTjoLLAb77LZ19FHJI1rZYBqs5LbAgB6Mack9s3fdNAWsnuVuaQDLzzAQ7t9NkRIdNeSZc3kmMHkbpa-6Gddo1RL_0TEg2TXAmCm90JVn7yx6oxwIt6oSr_tNUyAXg9WaKriqGXD4nhzSPIr2H2jyf6V9lWE8R0ZzSQd3UFzOjvC75OsfgvF7NgvT32a-LaHF-zTHOGMarKeF1HnEZmkDbwyNPXezg75hWVS2vJVbDdFr9GcOdoBgMUNe0ge6XjX4q5HibDqhoEksJvscwXG44YQ8lwztvpZGU1Bh8r_FUTRN_KbELo_Sxnymcr66yHElk6yJKWYZoZAR5FKjllY60chsuf038PobdzWSsI3s7QqSpuM8PodJHmYj8zVVLRyX4mmOvhj7-C9QVFUTs4-gR8NTKNJM7PMhUNvarh8QAbSEj-UWQmIdqrnsIoaPU85Cq1p7M4wWfW04zuOqipEbM0koaB1KhcW43wnDmuD6pskg_CzVcQxXiPFcXee-qnMYT7jTYKMbACc0shceeqvhpPMmZLPUkuII6JjvahU1AdHhsQiB2e7UqmzYjiWJy5qieaRx5XKkeBcGpMf4qocKke6OOcvzPYAXANY52l-uVHcY4aeG-JqvDKT7yCLKWyyCxsQDryWiEK4S2rsy2WXWw3yfGcEZTYY4tvO9sd-RNyiXUETGZu8YAOfNQFfjdLQtL62tj01ytcL_JUfHu0Nz2uiw1pH_OP_opzthDtkKqZWdIu-OYzh-FMc6omseTeZ9FzfHuO6mpDo8Pb3DPzbuVQrK2etndLUyOkeTuTdD_ABXOt1Tl-PB1adFGHMuWPz1EtRIXzOL3HUkm6GJJPmU4B9UjZZezaklwj0V9iiiz8bY_Xf8AI4cIf8cjT_6ap0xdVdvXEEzNWtxGpJ9A4hR3Yv2pT9mVZissWGRV7a-JrC10hYWOaSWm9jceI3HpqrbwrwVxDT0x49xqOBlHi7nStyv8YdI4uzFvIHW2qpveK2adKs3RX7N9o9GZsKFS0eKJwJ9DouY63sdV2HF2HEcHqomaOdGbevJcey2dY77LPpH9uGbPUYbbFL5HGHXa5RMYuCh2C3JER-evktZzwhjSANLolmgtyTDNdLohlzoFEkOArOa02w0Kwm53smBhIWi7XyWtSVo8z0QkBC8QvvG1oOl1iZ4gdZ0YWJ4IPskW31W7_JZa6wm3oojFs3-CUkNAJ0S2NPIXKCRnRLY3kdvJaNvJbAttrdIB5gHIJX6pLOWiWbnUoAZkB3TDrlEyWtchCyDxXTQhmTVMy3y6J52pKZl80AwX8QCCqjeUjkjneaBqRaS97qRFhWEOpWYjSvxCOSWibKwzMYbOdHcZgDyJF12r7R_ZvgmGcL4RxhwNSNp8MeGsqGwlxaWvAMcmp06HzIXC4ttV6a-zhxDTcZcF432e49aQRQu7jNu6B-hHq1xBB8x0RETOD8J8ZupmspsSJdE3RsnMevVdGo5KbEWNlpKmN5IuLOXGeMeHavhTifEsExJpbUUcxjvye38Lh5EWI9VGUtZUUzrwyyRkc2lbadU4rEuTnX6GNnMeD0CcLqZfxMt1zJl-DSNbmc5pP95cTbxFizNqyV3mHFOf6T4vlsKyY_FaVrYLwY5emzZ16WJkTfvALoSWspY_emYzrcrks2PVtRpUVMx_6xQbnul178n1KjLWxXSJR9Mk_wApHVavibDKb_bBxH5dVAVvHcYu2lgJHV7lRHRSXvqR5JHdu5iw81TLWTfXBpr9Orjy-TuH2d-KKvEu2jh6lcGNhf7RmAG9qeUj6hCfaexOsj7X8Yp2TyNiayGzQ421jao37L9m9uPDTRufadf_AONKnftQu_46MbHRkP8A3bVnlbKT3N8muNMIx2pcHK5JZJDd7y6_UpuxWGywaHVVt5LEkujduiVlte5WtrpTd_FskNmNvfdIOhSm8_JIdtYJiRpupXtntGa_BuxnhHDHMtJ3dMx7b2sWw6_VeNMBoDieN0FA3R1XURwC3LM4N_de1_tByRk8P0ROVuaSUAHkA0fuqb3itmvRLdfE4xjld_D8Hkltle4WA9VytxLpHE8zdX7tInbFBT0sf4vEVz-_O4VWmjtjk0-pWbrNvhDrCS71RUe4t9UKy5GiKivcHRaDAuQpnPYlPDl18k00AgHmnNbbhJokLDiG2IG97rVyTdaZ5n4LLJ5A30v81jvdNuaTm6lYdRcnRICuY869S0dAsTOMuBrTrsFikipsnQtb6lb3sFrQk3SJti2nRPMbZmYG19LJllrXG6cbZIZuxylKaOY9FltLjZLaBax5JAOtGg6JRFmhJAuRqlONggYy_YoYgXRL7a2Q7iADpzRkBl-hQ8g6p-UXKYfsmAM4XBuUBVHNLtyUi690BVj7wEAeqCDNR67KS4M4oquDuOMOxyiLg6llHeNH-0jOj2n1F1HRqNrx9-622mia7Ez079qvhalx_h3CO0LAS2aF8TI6h7NnxP1jf8Ccp9R0XlvdeqfsucSUfFPBuL9nnEFpWNie6Brz78L9HtHQtcbj-95Lzrxxw5U8JcW4ngdc13fUkxYHEWzs3a70LSD8VMiV9wLdittc7S31S2jWx2Su7HJAhBdf3mA-aTZv5Pql7XsdUnOTp0QAtkjhowW81oxvcbk3SCSSLJ6O4ILr28igZ077MMRb25cNE_8ASf8Aw0qd-1Ey_bPjRO2WH_umpP2Y3X7ceG_P2n_w0qX9qA_8c-NeTIf-7agDk2Qg7LeS3NOG52CzKTuhfsQg25JOvJLsNik23CQzB7vqkA5nX5BZI_kFpg0TAvXYjh38T7WOGafKXAVrJT5Bniv_ANlekO3aqhfxrAZ3Wjo6NoNzo1znOJ-mVcm-yLhJxHtX9sLT3eHUUs2YDTM60YHyeT8E728cRvxPtBxmCJ_3MM3c3HPIA39lVbFyjg1aS2NU978IpfFGJDE8QfIy5Y3ws15KGC3tvZaba-qIRUVghObnJyfY7HYEXRDDqLbIZtkXCARbe6lkggqO5FzbRL0TbRbQb2Sm6HdBIXcgLW53Nuq2SC65OiS12u4SFk2Gi_O_qkvOhStb8_im5Lhp2RgZVcTJdWSDzWJusN6qU3uLrFLBUWS2t7pY3ssWIJLsXfloLJTdR1WLEAmOtSx8lixQJjjBcaJZF2jVYsQMZfohXCx8lixNdiY0_cpl-1-SxYhi8DPPRR9Zo8XWLEIixMQ19UBiI-_PoFixNCxwS_AvE1XwdxZhuOUB-9pZQ5zOUjNnsPqCQvRH2puGoOJeFMG7QsCHexCFjagtAuYH6sefQmx_veSxYpkTy3mF9EnM5xsAsWIQjBE91zsE77OB7xWLEDFZWNAsAkOdcggA2PMXWLEC8nTvsxNt25cNk_8ASf8Aw0qL-0_H_wAcuME82Qn_APrasWJ4BPg5U0WGh9dUhztOixYkwQgi5F03KbCw3WLEhjYAtql30ssWJsD1Z9jqkjwvhXiviOrBZAHNjL_5YmF7v95cFxatkxLFKuunP31TM-Z5H5nEk_qsWKLJIE5DTVaBv5LFiiyXkcj3IRce45LFiYIKB2sUvdYsSSJM3YEJQsFixGcC7Mz3uh6lxEbiOQWLEMH1kp7zeVx31WLFibIJn__Z');
