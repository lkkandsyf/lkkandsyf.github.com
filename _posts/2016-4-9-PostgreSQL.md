---
title: 编程资料--PostgreSQL
tagline: ""
last_updated: null
category : Program-Document
layout: post
tags : [program, document, PostgreSQL]
---

摘要：　这是对编程资料--PostgreSQL的汇总。

<!-- more -->

## 快速入门

+ [PostgreSQL--易百教程](http://www.yiibai.com/html/postgresql/2013/080116.html)
+ [PostgreSQL新手入门 - 阮一峰的网络日志](http://www.ruanyifeng.com/blog/2013/12/getting_started_with_postgresql.html)
+ [Linux下免费数据库PostgreSQL开发入门](http://www.ibm.com/developerworks/cn/linux/l-pgsql/)
+ [初识Postgresql和Sqoop - smile_zjw的个人页面 - 开源中国社区](http://my.oschina.net/zhangjiawen/blog/180637#OSC_h2_2)

## 文档

+ [PostgreSQL教程,PostgreSQL下载,PostgreSQL中文手册](http://www.yiibai.com/html/postgresql/)
+ [Wiki](https://wiki.postgresql.org/wiki/Main_Page)
+ [PostgreSQL 9.3.1 中文手册](http://www.postgres.cn/docs/9.3/index.html)
+ [PostgreSQL 9.0.4 中文文档](http://manual.51yip.com/postgresql/)
+ [PostgreSQL: Documentation: 9.3: Functions and Operators](http://www.postgresql.org/docs/9.3/static/functions.html)
+ [The PostgreSQL™ JDBC Interface](https://jdbc.postgresql.org/documentation/head/index.html)
+ [PostgreSQL学习手册](http://www.cnblogs.com/stephen-liu74/archive/2012/05/02/2294071.html)
+ [在线文档-postgresql9.1](http://tool.oschina.net/apidocs/apidoc?api=postgresql9.1)

## 快速索引

+ [SQL 命令](http://www.postgres.cn/docs/9.3/sql-commands.html)
+ [SQL关键字](http://www.postgres.cn/docs/9.3/sql-keywords-appendix.html)
+ [索引](http://www.postgres.cn/docs/9.3/bookindex.html)


## 基本知识

安装：见[官网](https://www.postgresql.org/)

主要以Ubuntu:14.04.5为主。直接用命令安装

	sudo nano /etc/apt/sources.list.d/pgdg.list
	# add
	deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main
	wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \\
	 sudo apt-key add -
	 sudo apt-get update
	 sudo apt-get install postgresql-9.4

**连接PostgreSQL数据库**

如果想连接到数据库，需要切换到postgres用户，然后使用psql来连接数据库中，在该用户下连接数据库是不需要密码的。

	sudo su - postgres
	psql
	#帮助文档
	\help
	#列车所有的数据库
	\l
	#退出数据库
	/q

**PostgreSQL数据库的目录**

默认在/var/lib/pgsql/data目录

**配置**

PostgreSQL数据库的配置主要是同坐修改数据目录下的postgresql.conf文件来实现的。
