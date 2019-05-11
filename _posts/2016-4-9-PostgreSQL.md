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
# 查看表名称 pg_tables是系统视图
select * from pg_tables;
#退出数据库
/q
```

**系统表**

`\dt pg*`来看系统表

```c
                    List of relations
   Schema   |          Name           | Type  |  Owner
------------+-------------------------+-------+----------
 pg_catalog | pg_aggregate            | table | postgres
 pg_catalog | pg_am                   | table | postgres
 pg_catalog | pg_amop                 | table | postgres
 pg_catalog | pg_amproc               | table | postgres
 pg_catalog | pg_attrdef              | table | postgres
 pg_catalog | pg_attribute            | table | postgres
 pg_catalog | pg_auth_members         | table | postgres
 pg_catalog | pg_authid               | table | postgres
 pg_catalog | pg_cast                 | table | postgres
 pg_catalog | pg_class                | table | postgres
 pg_catalog | pg_collation            | table | postgres
 pg_catalog | pg_constraint           | table | postgres
 pg_catalog | pg_conversion           | table | postgres
 pg_catalog | pg_database             | table | postgres
 pg_catalog | pg_db_role_setting      | table | postgres
 pg_catalog | pg_default_acl          | table | postgres
 pg_catalog | pg_depend               | table | postgres
 pg_catalog | pg_description          | table | postgres
 pg_catalog | pg_enum                 | table | postgres
 pg_catalog | pg_event_trigger        | table | postgres
 pg_catalog | pg_extension            | table | postgres
 pg_catalog | pg_foreign_data_wrapper | table | postgres
 pg_catalog | pg_foreign_server       | table | postgres
 pg_catalog | pg_foreign_table        | table | postgres
 pg_catalog | pg_index                | table | postgres
 pg_catalog | pg_inherits             | table | postgres
 pg_catalog | pg_language             | table | postgres
 pg_catalog | pg_largeobject          | table | postgres
 pg_catalog | pg_largeobject_metadata | table | postgres
 pg_catalog | pg_namespace            | table | postgres
 pg_catalog | pg_opclass              | table | postgres
 pg_catalog | pg_operator             | table | postgres
 pg_catalog | pg_opfamily             | table | postgres
 pg_catalog | pg_pltemplate           | table | postgres
 pg_catalog | pg_proc                 | table | postgres
 pg_catalog | pg_range                | table | postgres
 pg_catalog | pg_rewrite              | table | postgres
 pg_catalog | pg_seclabel             | table | postgres
 pg_catalog | pg_shdepend             | table | postgres
 pg_catalog | pg_shdescription        | table | postgres
 pg_catalog | pg_shseclabel           | table | postgres
 pg_catalog | pg_statistic            | table | postgres
 pg_catalog | pg_tablespace           | table | postgres
 pg_catalog | pg_trigger              | table | postgres
 pg_catalog | pg_ts_config            | table | postgres
 pg_catalog | pg_ts_config_map        | table | postgres
 pg_catalog | pg_ts_dict              | table | postgres
 pg_catalog | pg_ts_parser            | table | postgres
 pg_catalog | pg_ts_template          | table | postgres
 pg_catalog | pg_type                 | table | postgres
 pg_catalog | pg_user_mapping         | table | postgres
```

`\dv pg*`来看系统视图

```c
                       List of relations
   Schema   |              Name               | Type |  Owner
------------+---------------------------------+------+----------
 pg_catalog | pg_available_extension_versions | view | postgres
 pg_catalog | pg_available_extensions         | view | postgres
 pg_catalog | pg_cursors                      | view | postgres
 pg_catalog | pg_group                        | view | postgres
 pg_catalog | pg_indexes                      | view | postgres
 pg_catalog | pg_locks                        | view | postgres
 pg_catalog | pg_matviews                     | view | postgres
 pg_catalog | pg_prepared_statements          | view | postgres
 pg_catalog | pg_prepared_xacts               | view | postgres
 pg_catalog | pg_replication_slots            | view | postgres
 pg_catalog | pg_roles                        | view | postgres
 pg_catalog | pg_rules                        | view | postgres
 pg_catalog | pg_seclabels                    | view | postgres
 pg_catalog | pg_settings                     | view | postgres
 pg_catalog | pg_shadow                       | view | postgres
 pg_catalog | pg_stat_activity                | view | postgres
 pg_catalog | pg_stat_all_indexes             | view | postgres
 pg_catalog | pg_stat_all_tables              | view | postgres
 pg_catalog | pg_stat_archiver                | view | postgres
 pg_catalog | pg_stat_bgwriter                | view | postgres
 pg_catalog | pg_stat_database                | view | postgres
 pg_catalog | pg_stat_database_conflicts      | view | postgres
 pg_catalog | pg_stat_replication             | view | postgres
 pg_catalog | pg_stat_sys_indexes             | view | postgres
 pg_catalog | pg_stat_sys_tables              | view | postgres
 pg_catalog | pg_stat_user_functions          | view | postgres
 pg_catalog | pg_stat_user_indexes            | view | postgres
 pg_catalog | pg_stat_user_tables             | view | postgres
 pg_catalog | pg_stat_xact_all_tables         | view | postgres
 pg_catalog | pg_stat_xact_sys_tables         | view | postgres
 pg_catalog | pg_stat_xact_user_functions     | view | postgres
 pg_catalog | pg_stat_xact_user_tables        | view | postgres
 pg_catalog | pg_statio_all_indexes           | view | postgres
 pg_catalog | pg_statio_all_sequences         | view | postgres
 pg_catalog | pg_statio_all_tables            | view | postgres
 pg_catalog | pg_statio_sys_indexes           | view | postgres
 pg_catalog | pg_statio_sys_sequences         | view | postgres
 pg_catalog | pg_statio_sys_tables            | view | postgres
 pg_catalog | pg_statio_user_indexes          | view | postgres
 pg_catalog | pg_statio_user_sequences        | view | postgres
 pg_catalog | pg_statio_user_tables           | view | postgres
 pg_catalog | pg_stats                        | view | postgres
 pg_catalog | pg_tables                       | view | postgres
 pg_catalog | pg_timezone_abbrevs             | view | postgres
 pg_catalog | pg_timezone_names               | view | postgres
 pg_catalog | pg_user                         | view | postgres
 pg_catalog | pg_user_mappings                | view | postgres
 pg_catalog | pg_views                        | view | postgres
```

pg\_class
pg\_attribute

常用系统sql

 + 查看指定表对象的模式
 ```c
 SELECT relname,relnamespace,nspname FROM pg_class c,pg_namespace n WHERE relname = 'tablename' AND relnamespace = n.oid;
 ```
 + 查看指定表对象的ower即role
 ```c
 select relname,rolname from pg_class c,pg_authid au where relname = 'tablename' and relowner = au.oid;
 ```
 + 查看指定表中包含的字段名和字段编号
 ```c
 SELECT relname, attname,attnum FROM pg_class c,pg_attribute attr WHERE relname  = 'tablename' AND c.oid = attr.attrelid;
 ```
 + 查看用户自定义字段的类型
 ```c
  SELECT relname,attname,typname FROM pg_class c,pg_attribute a,pg_type t WHERE c.relname = 'tablename' AND c.oid = attrelid AND atttypid = t.oid AND attnum > 0;
 ```
 + 查看指定表有哪些字段存在缺省值，同时显示出字段名和缺省值的定义方式
 ```c
 SELECT c.relname, a.attname, ad.adnum, ad.adsrc FROM pg_class c, pg_attribute a, pg_attrdef ad where ad.adrelid = c.oid AND adnum = a.attnum AND attrelid = c.oid;
 ```
 + 从输出结果可以看出口令字段已经被加密
 ```c
 SELECT rolname,rolpassword FROM pg_authid;
 ```
 + 先查看角色成员表中有哪些角色之间的隶属关系，在当前结果集中只有一个成员角色隶属于一个组角色,如果有多个成员角色隶属于同一个组角色，这样将会有多条记录
 ```c
 SELECT * FROM pg_auth_members ;
 ```
 + 查看组角色的名字
 ```c
  SELECT rolname FROM pg_authid a,pg_auth_members am WHERE a.oid = am.roleid;
 ```
 + 查看成员角色的名字, 如果需要用一个结果集获取角色之间的隶属关系，可以将这两个结果集作为子查询后再进行关联
 ```c
 SELECT rolname FROM pg_authid a,pg_auth_members am WHERE a.oid = am.member;
 ```

 + 查看当前数据库public模式的创建者的名称
 ```c
 SELECT nspname,rolname FROM pg_namespace n, pg_authid a WHERE nspname = 'public' AND nspowner = a.oid;
 ```
 + 查看该索引所在表的名称，以及构成该索引的键值数量和具体键值的字段编号
 ```c
 SELECT indnatts,indkey,relname FROM pg_index i, pg_class c WHERE c.relname = 'tablename' AND indrelid = c.oid;
 ```
 + 查看指定表包含的索引，同时列出索引的名称。
 ```c
 SELECT t.relname AS table_name, c.relname AS index_name FROM (SELECT relname,indexrelid FROM pg_index i, pg_class c WHERE c.relname = 'tablename' AND indrelid = c.oid) t, pg_index i,pg_class c WHERE t.indexrelid = i.indexrelid AND i.indexrelid = c.oid;
 ```
 +
 ```c
 ```
 +
 ```c
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


## 函数

 + pg\_size\_pretty(bigint)
 把以字节计算的数值转换为一个人类容易读的尺寸单位

 + pg\_table\_size(regclass)
 指定表OID或表名的表使用的磁盘空间，除去索引（但是包含TOAST，自由空间映射和可视映射）

 + pg\_indexs\_size(regclass)
 关联指定表索引的使用空间

 + pg\_total\_relation\_size(regclass)
 指定表和索引的整体占用磁盘空间

 + 查看某个数据库的大小
 ```C
 select pg_size_pretty(pg_database_size('database'));
 ```

 + 查看数据库中某一个表的大小
 ```C
 select pg_size_pretty(pg_relation_size('database.table'));
 ```

 + 时间戳与日期相互转换
 ```C
  select TO_TIMESTAMP(1512498970);
  --日期转时间戳
  SELECT EXTRACT(epoch FROM NOW());
  SELECT EXTRACT(epoch FROM CAST('2019-02-06 10:27:20' AS TIMESTAMP));
  select to_timestamp('2019-03-20 10:09:10.815125','yyyy-mm-dd hh24:mi:ss.us');

 ```
 ```C

 函数	返回类型	描述	例子
 to_char(timestamp, text)	text	把时间戳转换成字串	to_char(current_timestamp, 'HH12:MI:SS')
 to_char(interval, text)	text	把时间间隔转为字串	to_char(interval '15h 2m 12s', 'HH24:MI:SS')
 to_char(int, text)	text	把整数转换成字串	to_char(125, '999')
 to_char(double precision, text)	text	把实数/双精度数转换成字串	to_char(125.8::real, '999D9')
 to_char(numeric, text)	text	把numeric转换成字串	to_char(-125.8, '999D99S')
 to_date(text, text)	date	把字串转换成日期	to_date('05 Dec 2000', 'DD Mon YYYY')
 to_timestamp(text, text)	timestamp	把字串转换成时间戳	to_timestamp('05 Dec 2000', 'DD Mon YYYY')
 to_timestamp(double)	timestamp	把UNIX纪元转换成时间戳	to_timestamp(200120400)
 to_number(text, text)	numeric	把字串转换成numeric	to_number('12,454.8-', '99G999D9S')

 模式	描述
 HH	一天的小时数(01-12)
 HH12	一天的小时数(01-12)
 HH24	一天的小时数(00-23)
 MI	分钟(00-59)
 SS	秒(00-59)
 MS	毫秒(000-999)
 US	微秒(000000-999999)
 AM	正午标识(大写)
 Y,YYY	带逗号的年(4和更多位)
 YYYY	年(4和更多位)
 YYY	年的后三位
 YY	年的后两位
 Y	年的最后一位
 MONTH	全长大写月份名(空白填充为9字符)
 Month	全长混合大小写月份名(空白填充为9字符)
 month	全长小写月份名(空白填充为9字符)
 MON	大写缩写月份名(3字符)
 Mon	缩写混合大小写月份名(3字符)
 mon	小写缩写月份名(3字符)
 MM	月份号(01-12)
 DAY	全长大写日期名(空白填充为9字符)
 Day	全长混合大小写日期名(空白填充为9字符)
 day	全长小写日期名(空白填充为9字符)
 DY	缩写大写日期名(3字符)
 Dy	缩写混合大小写日期名(3字符)
 dy	缩写小写日期名(3字符)
 DDD	一年里的日子(001-366)
 DD	一个月里的日子(01-31)
 D	一周里的日子(1-7；周日是1)
 W	一个月里的周数(1-5)(第一周从该月第一天开始)
 WW	一年里的周数(1-53)(第一周从该年的第一天开始)
 ```

## 三类日志

 1. pg\_log (数据库运行日志) 内容可读  默认关闭的，需要设置参数启动
  这个日志一般是记录服务器与DB的状态，比如各种Error信息，定位慢查询SQL，数据库的启动关闭信息，发生checkpoint过于频繁等的告警信息，诸如此类。该日志有.csv格式和.log。建议使用.csv格式，因为它一般会按大小和时间自动切割，毕竟查看一个巨大的日志文件比查看不同时间段的多个日志要难得多。pg\_log是可以被清理删除，压缩打包或者转移，同时并不影响DB的正常运行。当我们有遇到DB无法启动或者更改参数没有生效时，第一个想到的就是查看这个日志
 2. pg\_xlog (WAL 日志，即重做日志) 内容一般不具有可读性  强制开启
 这个日志是记录的Postgresql的WAL信息，也就是一些事务日志信息(transaction log)。默认单个大小是16M，源码安装的时候可以更改其大小（./configure --with-wal-segsize=target\_value 参数，即可设置）这些日志会在定时回滚恢复(PITR)， 流复制(Replication Stream)以及归档时能被用到，这些日志是非常重要的，记录着数据库发生的各种事务信息，不得随意删除或者移动这类日志文件，不然你的数据库会有无法恢复的风险.WAL：PostgreSQL在将缓存的数据刷入到磁盘之前，先写日志, 这就是PostgreSQL WAL(Write-Ahead Log)方式，也就是预写日志方式,每个pg\_xlog完成了归档后，都会在这里面生成一个.done的文件
 3. pg\_clog (事务提交日志，记录的是事务的元数据) 内容一般不具有可读性强制开启
pg\_xlog和pg\_clog一般是在$PGDATA/下面的文件夹下，pg\_log默认路径是$PGDATA/pg\_log，通常可自定义路径和文件名

  说明：当你的归档或者流复制发生异常的时候，事务日志会不断地生成，有可能会造成你的磁盘空间被塞满，最终导致DB挂掉或者起不来。遇到这种情况不用慌，可以先关闭归档或者流复制功能，备份pg\_xlog日志到其他地方，但不要删除。然后删除较早时间的的pg\_xlog，有一定空间后再试着启动Postgres。

  pg\_clog这个文件也是事务日志文件，但与pg\_xlog不同的是它记录的是事务的元数据(metadata)，这个日志告诉我们哪些事务完成了，哪些没有完成。这个日志文件一般非常小，但是重要性也是相当高，不得随意删除或者对其更改信息。
```C
log_destination = 'stderr'
logging_collector = on
log_directory = 'pg_log'                   ---可自定义路径
log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'   ---日志文件名
log_line_prefix = '%t-%d-%h-%a :'          ---日志每行的标准格式
```
[http://906179271.iteye.com/blog/2270652](http://906179271.iteye.com/blog/2270652)

## VACUUM

VACUUM存在两种形式，区别如下:

![VACUUM-FULL](http://lkkandsyf.github.com/pictures/vacuum-full.png)

vacuum的效率
```C
1.1释放,再利用 更新/删除的行所占据的磁盘空间.
1.2更新POSTGRESQL查询计划中使用的统计数据
1.3防止因事务ID的重置而使非常老的数据丢失。
```
第一点的原因是PostgreSQL数据的插入,更新,删除操作并不是真正放到数据库空间.如果不定期释放空间的话,由于数据太多,查询速度会巨降.

第二点的原因是PostgreSQL在做查询处理的时候,为了是查询速度提高,会根据统计数据来确定执行计划.如果不及时更新的话,查询的效果可能不如预期.

第三点的原因是PostgreSQL中每一个事务都会产生一个事务ID,但这个数字是有上限的. 当事务ID达到最大值后,会重新从最小值开始循环.这样如果不及时把以前的数据释放掉的话,原来的老数据会因为事务ID的丢失而丢失掉.


1. vacuumdb 是 SQL 命令 VACUUM的封装,所以用vacuumdb和vacuum来清理数据库都可以，效果是一样的。
2. vacuumdb 中的几个重要参数：可以用vacuumdb --help查询。
```C
-a/--all               vacuum所有的数据库
-d dbname        只vacuum dbname这个数据库
-f/--full               执行full的vacuum
-t table              只vacuum table这个数据表
-z/--analyze       Calculate statistics for use by the optimizer
```
3. 切换到postgres用户下：
`vacuumdb -d yourdbname -f -z -v` 来清理你的数据库。
或者加到conrtab中15 1 * * * postgres vacuumdb -d mydb-f -z -v >> /tmp/vacuumdb.log,每天的一点一刻开始进行清理。
4. 如何查询我的XID是否接近临界值的命令：
```C
select max(age(datfrozenxid)) from pg_database;
select age(datfrozenxid) from pg_database;
```
5. 然而我们关心的是哪一个大的表组要真正的vacuum,这个命令是查询按照最老的XID排序，查看大于1G而且是排名前20的表。
```c
SELECT relname, age(relfrozenxid) as xid_age, pg_size_pretty(pg_table_size(oid)) as table_size FROM pg_class WHERE relkind = 'r' and pg_table_size(oid) > 1073741824 ORDER BY age(relfrozenxid) DESC LIMIT 20;
```
然后你可以单独每个表进行vacuum：
```C
vacuumdb --analyze --verbose --table 'postgres_log' mydb
```
[http://www.databasesoup.com](http://www.databasesoup.com)

## Single-mode

停掉数据库服务，进入单用户模式,这时Postgres进程不会进入到后台服务模式，而是进入到一个交互式的命令行模式。使用模式修复数据的场景
```C
(1)当多用户模式下不接收所有命令时，可以使用单用户连接到数据库
(2)initdb的阶段
(3)修复系统表
```
举例来说，在PG中的一条记录上，事物年龄不能超过2的31次方，如果超过了，这条数据就会丢失。PG数据库不允许这种情况的出现，当记录的年龄离2的31次方还有1千万的时候，数据库的日志中就会有如下警告：
```C
WARNING:database 'osdba' must be vacuumed within 177000234 transactions
HINT:To avoid a database shutdown,execute a database-wide VACUUM in 'osdba'
```
如果不处理，当记录的年龄离2的31次方还有100W时，数据库服务器处于安全考虑，将自动禁止来自任何用户的连接，同时在日志中提示如下信息：
```C
ERROR:databse is not accepting commands to avoid wraparound data loss in database "osdba"
HINT:Stop the postmaster and user a standalone  backend to VACUUM in "osdba"
```
出现这种情况，只能把数据库启动到单用户模式下，执行VACUUM命令来修复：
```c
postgres --single -D $PG_DATA
PostgreSQL stand-alone backend 9.4
backend> vacuum full;
backend>Ctrl + D
```

## pg配置



## problem

 +  psql: FATAL: the database system

 数据库连接不上，报 "the database system",先正常关闭数据库，然后再启动

 + postgrel LOG:  startup process (PID 32252) was terminated by signal 6: Aborted

 用postgresql自带的pg\_resetxlog 工具可以跳过对EAL log的恢复，可能会丢失一个事务
 ```c
 runuser -l postgres  -c "pg_resetxlog -f $PG_DATA"
 ```
 然后重启pg

 + 致命错误:  database is not accepting commands to avoid wraparound data loss in database "postgres",提示 Stop the postmaster and use a standalone backend to vacuum database "postgres".
 1. 先停掉数据库，以postgres用户登录系统
 ```c
 su postgres
 ```
 2. 进入单用户模式
 ```c
 postgres --single -D $PG_DATA [database]
 ```
 3. 修复
 ```c
 vacuum full;
 ```
 4. 直到修复完成重启数据库




## reference


[https://www.postgresql.org/docs](https://www.postgresql.org/docs)

[http://postgres.cn/docs](http://postgres.cn/docs)

[http://www.php.cn/manual/view/20881.html](http://www.php.cn/manual/view/20881.html)
