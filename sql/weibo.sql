--- MySQL Script generated by MySQL Workbench
-- 06/06/16 10:18:35
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema weibo
-- -----------------------------------------------------
-- 微博库
DROP SCHEMA IF EXISTS `weibo` ;

-- -----------------------------------------------------
-- Schema weibo
--
-- 微博库
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `weibo` DEFAULT CHARACTER SET utf8 ;
USE `weibo` ;

-- -----------------------------------------------------
-- Table `weibo`.`xiaozhu_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `weibo`.`xiaozhu_user` ;

CREATE TABLE IF NOT EXISTS `weibo`.`xiaozhu_user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` CHAR(20) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` CHAR(32) NOT NULL DEFAULT '' COMMENT '密码',
  `register` INT(10) UNSIGNED NOT NULL COMMENT '注册时间',
  `lock` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0是表示没有被锁定 1是表示别锁定了',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username` (`username` ASC))
ENGINE = MyISAM
COMMENT = '用户表';


-- -----------------------------------------------------
-- Table `weibo`.`xiaozhu_userinfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `weibo`.`xiaozhu_userinfo` ;

CREATE TABLE IF NOT EXISTS `weibo`.`xiaozhu_userinfo` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `nikename` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `truename` VARCHAR(45) NULL DEFAULT '' COMMENT '真是姓名',
  `sex` ENUM('男', '女') NOT NULL DEFAULT '男' COMMENT '性别  默认是男',
  `location` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '所在地',
  `constellation` CHAR(10) NOT NULL DEFAULT '' COMMENT '星座',
  `intro` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '一句话介绍自己',
  `face50` VARCHAR(60) NOT NULL DEFAULT '' COMMENT '50*50的头像',
  `face80` VARCHAR(60) NOT NULL DEFAULT '' COMMENT '头像80*80',
  `face180` VARCHAR(60) NOT NULL DEFAULT '' COMMENT '头像180*180',
  `styleview` VARCHAR(45) NOT NULL DEFAULT 'default'' COMMENT '默认的模板',
  `follownum` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '关注数',
  `fansinum` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '粉丝数量',
  `weibonum` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '发布的微博数量',
  `uid` INT NOT NULL COMMENT '外键user表的id',
  PRIMARY KEY (`id`),
  INDEX `uid` (`uid` ASC))
ENGINE = MyISAM
COMMENT = '用户信息表';


-- -----------------------------------------------------
-- Table `weibo`.`xiaozhu_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `weibo`.`xiaozhu_group` ;

CREATE TABLE IF NOT EXISTS `weibo`.`xiaozhu_group` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '分组id',
  `name` VARCHAR(45) NOT NULL DEFAULT '' COMMENT '分组名字',
  `uid` INT NOT NULL COMMENT '关注用户的id',
  PRIMARY KEY (`id`),
  INDEX `uid` (`uid` ASC))
ENGINE = MyISAM
COMMENT = '关注分组表';


-- -----------------------------------------------------
-- Table `weibo`.`xiaozhu_follow`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `weibo`.`xiaozhu_follow` ;

CREATE TABLE IF NOT EXISTS `weibo`.`xiaozhu_follow` (
  `follow` INT UNSIGNED NOT NULL COMMENT '关注人的id',
  `fansi` INT UNSIGNED NOT NULL COMMENT '粉丝用户id',
  `gid` INT NOT NULL COMMENT '用户所属组的外键id',
  INDEX `follow` (`follow` ASC),
  INDEX `fansi` (`fansi` ASC),
  INDEX `gid` (`gid` ASC))
ENGINE = MyISAM
COMMENT = '关系表  我关注了谁 谁关注了我';


-- -----------------------------------------------------
-- Table `weibo`.`xiaozhu_letter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `weibo`.`xiaozhu_letter` ;

CREATE TABLE IF NOT EXISTS `weibo`.`xiaozhu_letter` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '发私信的id',
  `fromid` INT NOT NULL COMMENT '发送人id',
  `content` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '发送内容',
  `formtime` INT(10) UNSIGNED NOT NULL COMMENT '发送时间',
  `uid` INT NOT NULL COMMENT '所属用户id（收件人）',
  PRIMARY KEY (`id`),
  INDEX `uid` (`uid` ASC))
ENGINE = MyISAM
COMMENT = '发送私信的表';


-- -----------------------------------------------------
-- Table `weibo`.`xiaozhu_weibo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `weibo`.`xiaozhu_weibo` ;

CREATE TABLE IF NOT EXISTS `weibo`.`xiaozhu_weibo` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '微博id',
  `content` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '发表微博的内容',
  `isturn` INT NOT NULL DEFAULT 0 COMMENT '微博是否是转发的微博，默认是0表示不是，如果是转发的微博那么就把微博的id写入进去。\n',
  `time` INT(10) UNSIGNED NOT NULL COMMENT '转发的时间',
  `turnnum` INT(10) UNSIGNED NOT NULL,
  `keepnum` INT(10) UNSIGNED NOT NULL COMMENT '收藏次数',
  `commentnum` INT(10) NULL COMMENT '评论次数',
  `uid` INT NOT NULL COMMENT '用户表uid外键',
  PRIMARY KEY (`id`),
  INDEX `uid` (`uid` ASC))
ENGINE = MyISAM
COMMENT = '微博表';


-- -----------------------------------------------------
-- Table `weibo`.`xiaozhu_picture`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `weibo`.`xiaozhu_picture` ;

CREATE TABLE IF NOT EXISTS `weibo`.`xiaozhu_picture` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '图片id',
  `minipic` VARCHAR(60) NOT NULL DEFAULT '' COMMENT '小图片',
  `meadiumpic` VARCHAR(60) NOT NULL DEFAULT '' COMMENT '中图',
  `maxpic` VARCHAR(60) NULL DEFAULT '' COMMENT '大图',
  `wid` INT NOT NULL COMMENT '微博id',
  PRIMARY KEY (`id`),
  INDEX `wid` (`wid` ASC))
ENGINE = MyISAM
COMMENT = '图片表';


-- -----------------------------------------------------
-- Table `weibo`.`xiaozhu_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `weibo`.`xiaozhu_comment` ;

CREATE TABLE IF NOT EXISTS `weibo`.`xiaozhu_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '评论内容',
  `time` INT(10) UNSIGNED NOT NULL COMMENT '评论时间',
  `uid` INT NOT NULL COMMENT '谁评论的  评论人的用户id',
  `wid` INT NOT NULL COMMENT '外键 所属微博的id',
  PRIMARY KEY (`id`),
  INDEX `uid` (`uid` ASC),
  INDEX `wid` (`wid` ASC))
ENGINE = MyISAM
COMMENT = '微博评论表';


-- -----------------------------------------------------
-- Table `weibo`.`xiaozhu_keep`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `weibo`.`xiaozhu_keep` ;

CREATE TABLE IF NOT EXISTS `weibo`.`xiaozhu_keep` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `uid` INT NOT NULL,
  `time` INT(10) UNSIGNED NOT NULL COMMENT '收藏时间',
  `wid` INT NOT NULL COMMENT '微博的id',
  PRIMARY KEY (`id`),
  INDEX `wid` (`wid` ASC))
ENGINE = MyISAM
COMMENT = '收藏表';


-- -----------------------------------------------------
-- Table `weibo`.`xiaozhu_atme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `weibo`.`xiaozhu_atme` ;

CREATE TABLE IF NOT EXISTS `weibo`.`xiaozhu_atme` (
  `id` INT NOT NULL,
  `wid` INT NOT NULL,
  `uid` INT NOT NULL COMMENT '用户id  外键',
  PRIMARY KEY (`id`),
  INDEX `uid` (`uid` ASC),
  INDEX `wid` ())
ENGINE = MyISAM
COMMENT = '微博@艾特我的';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
