---
title: 编程资料--PostgreSQL
tagline: "pg collect "
category : DataBase
layout: post
tags : [postgres]
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

```c
sudo nano /etc/apt/sources.list.d/pgdg.list
# add
deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \\
sudo apt-key add -
sudo apt-get update
sudo apt-get install postgresql-9.4
```

**连接PostgreSQL数据库**

如果想连接到数据库，需要切换到postgres用户，然后使用psql来连接数据库中，在该用户下连接数据库是不需要密码的。

```c
sudo su - postgres
psql
#帮助文档
\help
#列车所有的数据库
\l
# 查看表名称
\dt
#带有序列
\d
#查询表结构
\d table_name;
# 查看表名称
select * from pg_tables;
#退出数据库
/q
```

**PostgreSQL数据库的目录**

默认在/var/lib/pgsql/data目录

**配置**

PostgreSQL数据库的配置主要是同坐修改数据目录下的postgresql.conf文件来实现的。

## 常用命令

### 基本sql

 + 创建表

 + 删除表
```c
删除表： drop table [表名]
```

 + limit 分页,起点0开始查，返回5条数据
```c
select * from table_name limit 5 offset 0;
```
 + 增加字段
```c
alter table  [表名] drop column if exists colunm_name
alter table [表名] add [字段名] 字段属性 default 缺省值 default 是可选参数
alter table [表名] add 字段名 smallint default 0 增加数字字段，整型，缺省值为0
alter table [表名] add 字段名 int default 0 增加数字字段，长整型，缺省值为0
alter table [表名] add 字段名 single default 0 增加数字字段，单精度型，缺省值为0
alter table [表名] add 字段名 double default 0 增加数字字段，双精度型，缺省值为0
alter table [表名] add 字段名 Tinyint default 0 增加数字字段，字节型，缺省值为0
alter table [表名] add 字段名 text [null] 增加备注型字段,[null]可选参数
alter table [表名] add 字段名 memo [null] 增加备注型字段,[null]可选参数
alter table [表名] add 字段名 varchar(N) [null] 增加变长文本型字段 大小 为N(1～255)
alter table [表名] add 字段名 char [null] 增加定长文本型字段 大小固定为255
alter table [表名] add 字段名 Datetime default 函数 增加日期型字段，其中 函数 可以是 now(),date()等，表示缺省值
```
 + 删除字段
```c
alter table [表名] drop 字段名
修改变长文本型字段的大小：alter table [表名] alter 字段名 varchar(N)
```
 + 修改字段
```c
```
 + 表的外键
```c
alter table talbe_name drop constraint table_f_name_fkey;
```

 + 创建表实例
```c
drop table if exist db.tablename;
create table if not exists public.tablename
(
id serial NOT NULL,
name character varying(256) NOT NULL,
time timestamp(0) without time zone NOT NULL,
value boolean NOT NULL,
value2 integer  NOT NULL,
value3 int4  NOT NULL,
text text,
json_data json,
constraint tablename.pkey primary key(id)
);
ALTER TABLE tablename
 OWNER TO dbuser;
```


1.查看数据表中每个表占用磁盘的大小
```c
SELECT  table_schema || '.' || table_name AS table_full_name,
		pg_size_pretty(pg_total_relation_size('"' || table_schema || '"."' || table_name || '"')) AS size
FROM information_schema.tables
ORDER BY  pg_total_relation_size('"' || table_schema || '"."' || table_name || '"') DESC
```
2.查看每个数据库占用磁盘的大小
```c
SELECT d.datname AS Name,  pg_catalog.pg_get_userbyid(d.datdba) AS Owner,
   CASE WHEN pg_catalog.has_database_privilege(d.datname, 'CONNECT')
       THEN pg_catalog.pg_size_pretty(pg_catalog.pg_database_size(d.datname))
       ELSE 'No Access'
   END AS SIZE
FROM pg_catalog.pg_database d
   ORDER BY
   CASE WHEN pg_catalog.has_database_privilege(d.datname, 'CONNECT')
       THEN pg_catalog.pg_database_size(d.datname)
       ELSE NULL
   END DESC -- nulls first
   LIMIT 20
```

3.备份恢复数据库或表

```C
-h:数据库服务器地址
-p:数据库端口
-U:表示用户名
-d:数据名
-f:路径文件名
```

数据库：
```c
pg_dump -h localhost -U uesr_name -d database_name > ${PATH}database.bak
```
```c
psql -h localhost -U user_name -d new_db_name -f ${PATH}database.bak
```
表
```c
pg_dump -h localhost -U user_name -d dbname -t table_name database_name > ${PATH}table_name.sql
```
```c
psql -h localhost -d databast_name -U user_name -f ${PATH}table_name.sql
```



