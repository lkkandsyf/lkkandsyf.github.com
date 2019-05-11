---
layout: post
category:
tagline: "Supporting tagline"
tags: Hadoop
title: '搭建分布式大数据平台'
---
 + Hadoop
 + Hive
 + Spark
 + Zookeeper
 + Kafka
 + Hbase
 + Elasticsearch
 + Flink
 + Kylin
 + Flume
 + Redis
 + Druid
 + OpenTSDB
 + Keepalived

---


<!--more-->

## 基础环境

软件包要求:Jdk8 Hadoop-2.7,Spark-2.0,Hive-2.3,Hbase-1.2,Zookeeper-3.4.10

 1. Linux(CentOS7)
 ```C
 master ip1
 slave1 ip2
 slave2 ip3
 ```

 2. SSH

 免密码登录

 3. Java

 下载Linux版本的Java8，并安装配置在/etc/profile中增加
 ```c
export JAVA_HOME=/opt/big-data/java
export PATH=$PATH:$JAVA_HOME/bin
 ```

## Hadoop

 Hadoop2.7[\[安装包\]](https://archive.apache.org/dist/hadoop/common/)
 解压文件重命名hadoop

### 单个NameNode

 1. 配置文件在${HADOOP\_HOME}/etc/hadoop目录下

 + hadoop-env.sh
 修改JAVA\_HOME的值
 ```C
 export JAVA_HOME/opt/big-data/java
 ```
 + core-site.xml
 修改或增加fs.defualtFS的value
 ```C
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://master:9000</value>
    </property>
 ```
 修改或增加hadoop.tmp.dir的value
 ```C
    <property>
        <name>hadoop.tmp.dir</name>
        <value>file:///opt/big-data/hadoop/tmp</value>
        <description>Abasefor other temporary directories.</description>
    </property>
 ```
 用xmllint来格式化验证
 ```c
 xmllint -format /opt/big-data/hadoop/etc/hadoop/core-site.xml
 ```
 如果想了解更多的配置[\[请点击\]](http://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/core-default.xml)

 + hdfs-site.xml
 修改或增加dfs.namenode.data.dir的value
	<property>
		<name>dfs.namenode.name.dir</name>
		<value>file:///opt/big-data/hadoop/data/hdfs/namenode</value>
	</property>
 修改或增加dfs.datanode.data.dir的value
 ```C
	<property>
		<name>dfs.datanode.name.dir</name>
		<value>file:///opt/big-data/hadoop/data/hdfs/datanode</value>
	</property>
 ```
 修改或增加dfs.replication的value
 ```C
	<property>
		<name>dfs.replication</name>    #datanode数量，默认3，我们是2台设置2
		<value>2</value>
	</property>
 ```

 用xmllint来格式化验证
 ```c
 xmllint -format /opt/big-data/hadoop/etc/hadoop/hdfs-site.xml
 ```
 如果想了解更多的配置[\[请点击\]](http://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml)
 + mapred-site.xml
 `刚解压之后，是没有这个文件的`,需要把mapred-site.xml.template copy为mapred-site.xml
 修改或增加mapreduce.framework.name的value
 ```C
	<property>
　　　　<!-指定Mapreduce运行在yarn上-->
		<name>mapreduce.framework.name</name>
		<value>yarn</value>
	</property>
 ```
 用xmllint来格式化验证
 ```c
 xmllint -format /opt/big-data/hadoop/etc/hadoop/mapred-site.xml
 ```
 + yarn-site.xml
 修改或增加yarn.resourcemanager.hostname的value
 ```C
  <!-- 指定ResourceManager的地址-->
	<property>
		<name>yarn.resourcemanager.hostname</name>
		<value>mip</value>
	</property>
 ```
 修改或增加hadoop.tmp.dir的value
 修改或增加hadoop.tmp.dir的value

 用xmllint来格式化验证
 ```c
 xmllint -format /opt/big-data/hadoop/etc/hadoop/yarn-site.xml
 ```
 如果想了解更多的配置[\[请点击\]](http://hadoop.apache.org/docs/stable/hadoop-yarn/hadoop-yarn-common/yarn-default.xml)
 + log4j.properties
 修改hadoop.log.dir
 ```C
 hadoop.log.dir=/opt/big-data/hadoop/log
 ```
 + slaves
 这个文件的写的启动datanode/nodemanager的主机名,如果所有节点都启动
 ```C
 master
 slave1
 slave2
 ```
 `只在从节点启动`，推荐使用这种，可以减少主节点的负载,我采用的就是这种
 ```C
 slave1
 slave2
 ```

 + 创建配置的目录
 ```c
 mkdir /opt/big-data/hadoop/log
 mkdir -p /opt/big-data/hadoop/data/hdfs/namenode
 mkdir -p /opt/big-data/hadoop/data/hdfs/datanode
 mkdir -p /opt/big-data/hadoop/tmp
 ```
 + Hadoop环境变量
 ```c
 export HADOOP_HOME=/opt/big-data/hadoop
 export PATH=$PATH:$HADOOP_HOME/bin
 export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
 ```
 2. 启动集群
  + scp拷贝文件,`保证每个节点的文档Hadoop目录文件结构是一样的`
  + 一键启动
  0. `格式化`
  ```c
  hdfs namenode -format
  ```
  1. 启动hdfs
  ```c
  sh /opt/big-data/hadoop/sbin/start-dfs.sh
  ```
  2. 启动yarn
  ```c
  sh /opt/nsfocus/espc/deps/hadoop/sbin/start-yarn.sh
  ```
  + 单步启动
  1. namenode
  ```c
  sh /opt/big-data/hadoop/sbin/hadoop-daemons.sh start namenode
  sh /opt/big-data/hadoop/sbin/hadoop-daemons.sh start secondnamenode
  ```
  2. datanode
  ```c
  sh /opt/big-data/hadoop/sbin/hadoop-daemons.sh start datanode
  ```
  3. resourcemanager
  ```c
  /opt/big-data/hadoop/sbin/yarn-daemons.sh start resourcemanager
  ```
  4. nodemanager
  ```c
  /opt/big-data/hadoop/sbin/yarn-daemons.sh start nodemanager
  ```
  5. mapreduce作业日志服务器
  ```c
  sh /opt/big-data/hadoop/sbin/mr-jobhistory-daemon.sh start historyserver
  ```
  了解更详细的命令使用[\[链接\]]()
  ```c
  hdfs -h
  yarn -h
  ```

  + 进程验证
  cmd:
  ```c
  jps | grep -iE 'name|node|resource'
  ```
  master主机 ssh master  cmd
  ```c
  27911 SecondaryNameNode
  26724 ResourceManager
  26536 NameNode
  ```
  slave1主机 ssh slave1 cmd
  ```c
  26830 NodeManager
  26626 DataNode
  ```
  slave2主机 ssh slave2 cmd
  ```c
  26831 NodeManager
  26621 DataNode
  ```

 3. Web预览

  + master:50070
  + master:8088
  + master:19888

 4. 测试
 ```C
  hdfs dfs -mkdir /wordCountInput
  hdfs dfs -put /opt/big-data/hadoop/README.txt /wordCountInput
  hdfs dfs -ls -R /wordCountInput
  hadoop jar /opt/big-data/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.7.jar wordcount /wordCountInput/README.txt /wordCountOput
  hdfs dfs -ls -R /wordCountOutput
  hdfs dfs -cat /wordCountOput/part-r-00000
 ```

 5. 关闭集群
 ```c
 sh /opt/big-data/hadoop/sbin/stop-yarn.sh
 sh /opt/big-data/hadoop/sbin/stop-dfs.sh
 ```

###  HA高可用

#### NameNode HA
  为了实现自动切换，需要借助Zookeeper来协调，必须有一个`Zookeeper的集群环境`






problem:
 + 手动切换namonde为active



[http://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-hdfs/HDFSHighAvailabilityWithQJM.html](http://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-hdfs/HDFSHighAvailabilityWithQJM.html)

#### ResourceManager HA



[http://hadoop.apache.org/docs/stable/hadoop-yarn/hadoop-yarn-site/ResourceManagerHA.html](http://hadoop.apache.org/docs/stable/hadoop-yarn/hadoop-yarn-site/ResourceManagerHA.html)

## Hive

  Hive2.3[\[安装包\]](http://mirror.bit.edu.cn/apache/hive/)解压文件重命名hive

  + hive-env.sh

  ```C
  export HIVE_CONF_DIR=/opt/big-data/hive/conf
  ```

  + hive-site.xml

 没有这个文件时，拷贝hive-default.xml.template hive-site.xml,元数据库选择，大部分是Mysql,Postgresql

  1. Mysql
  <table>
  <tr><td>javax.jdo.option.ConnectionURL</td>		<td>jdbc:mysql://master:3306/metastore?characterEncoding=UTF-8</td></tr>
  <tr><td>javax.jdo.option.ConnectionDriverName</td>		<td>com.mysql.jdbc.Drive</td></tr>
  <tr><td>javax.jdo.option.ConnectionUserName</td>		<td>user</td></tr>
  <tr><td>javax.jdo.option.ConnectionPassword</td>		<td>password</td></tr>
  <tr><td>hive.metastore.uris</td>		<td>thrift://master:9083</td></tr>
  <tr><td>hive.metastore.warehouse.dir</td>		<td>/user/hive/warehouse</td></tr>
  <tr><td>hive.querylog.location</td>		<td>/opt/log/hive</td></tr>
  <tr><td></td>		<td></td></tr>
  </table>

  2. Postgresql
  <table>
  <tr><td>javax.jdo.option.ConnectionURL</td>		<td>jdbc:mysql://master:5432/metastore?characterEncoding=UTF-8</td></tr>
  <tr><td>javax.jdo.option.ConnectionDriverName</td>		<td>org.postgresql.Driver</td></tr>
  <tr><td>javax.jdo.option.ConnectionUserName</td>		<td>user</td></tr>
  <tr><td>javax.jdo.option.ConnectionPassword</td>		<td>password</td></tr>
  <tr><td>hive.metastore.uris</td>		<td>thrift://master:9083</td></tr>
  <tr><td>hive.metastore.warehouse.dir</td>		<td>/user/hive/warehouse</td></tr>
  <tr><td>hive.querylog.location</td>		<td>/opt/log/hive</td></tr>
  <tr><td></td>		<td></td></tr>
  </table>


  + 驱动包

  1. Mysql

  2. Postgresql


## Spark

  Spark2.0[\[安装包\]](http://spark.apache.org/downloads.html)
  解压文件重命名spark
### Hive on Spark


### Spark Thrift




+ spark提交任务java.nio.channels.ClosedChannelException
```C
ERROR client.TransportClient: Failed to send RPC 6159851572252707613 to /0.0.0.0:39986: java.nio.channels.ClosedChannelException
java.nio.channels.ClosedChannelException
```
内存的原因,是从yarn-site.xml中配置计算来的，yarn.scheduler.minimum-allocation-mb  \* yarn.nodemanager.vmem-pmem-ratio = 虚拟内存的总量，如果需要的虚拟内存总量超过这个计算所得的数值，就会出发 Killing container.

此处 我的yarn.scheduler.minimum-allocation-mb值没设置，默认为1G，yarn.nodemanager.vmem-pmem-ratio也没设置，默认为2.1,给spark 任务配置更大的内存即可解决问题
```C
	<kroperty>
			<name>yarn.scheduler.maximum-allocation-mb</name>
			<value>9216</value>
			<discription>每个任务最多可用内存,单位MB,默认8182MB</discription>
	</property>
	<property>
			<name>yarn.scheduler.minimum-allocation-mb</name>
			<value>4000</value>
			<discription>每个任务最shao可用内存</discription>
	</property>
	<property>
			<name>yarn.nodemanager.vmem-pmem-ratio</name>
			<value>4.1</value>
	</property>
```
  way-2:通过关闭虚拟内存的检查
```C
<property>
    <name>yarn.nodemanager.vmem-check-enabled</name>
    <value>false</value>
</property>
```

## Zookeeper

  Zookeeper3.4.10[\[安装包\]](https://archive.apache.org/dist/zookeeper/)
  解压文件重命名Zookeeper
  + 配置文件
  1. zoo.cfg
  修改或增加dataDir和logDir
  ```C
  dataDir=/opt/big-data/zookeeper/data
  ```
  增加下面配置:
  ```C
  server.1=master:2888:3888
  server.2=slave1:2888:3888
  server.3=slave2:2888:3888
  ```
  2. myid
  这个文件与zoo.cfg配置有关.server.数字与主机名是一一对应的。这个文件的目录在zk的数据目录下/opt/big-data/zookeeper/data
  ```C
  master:
  cat myid
  1
  slaves1:
  cat myid
  2
  slaves3:
  cat myid
  3
  ```
  3. log4j.properties
  修改zookeeper日志输出目录
  ```C
  zookeeper.log.dir=/opt/big-data/zookeeper/log
  ```

  4. 环境变量
  在/etc/profile添加下面配置，然后source /etc/profile生效
  ```C
  export ZK_HOME=/opt/big-data/zookeeper
  export PATH=$PATH:$ZK_HOME/bin
  ```

  + 启动ZK集群
  拷贝文件到每个节点对应的目录下，并且`修改myid的值`
  在每个节点上执行
  ```c
  zkServer.sh start
  ```

  + 验证状态
  在每个节点上执行
  ```c
  zkServer.sh status
  ```
  会有一个是leader，其他都是follower

  + 关闭集群
  在每个节点上执行
  ```c
  zkServer.sh stop
  ```

## Kafka

  Kafka0.9.0.1[\[安装包\]](http://kafka.apache.org/downloads)
  解压文件重命名kafka

## Hbase

  Hbase1.2.8[\[安装包\]](http://archive.apache.org/dist/hbase/)
  解压文件重命名hbase

## Elasticsearch

[https://www.elastic.co/guide/en/elasticsearch/reference/current/xpack-sql.html](https://www.elastic.co/guide/en/elasticsearch/reference/current/xpack-sql.html)

[https://www.elastic.co/blog/an-introduction-to-elasticsearch-sql-with-practical-examples-part-1](https://www.elastic.co/blog/an-introduction-to-elasticsearch-sql-with-practical-examples-part-1)
jdbc 官网需要会员支持

[https://github.com/NLPchina/elasticsearch-sql](https://github.com/NLPchina/elasticsearch-sql)

离线安装
```c
./bin/elasticsearch-plugin install file:$PATH/plugin-package
./bin/elasticsearch-plugin list
```

操作过程

[https://www.elastic.co/guide/en/elasticsearch/reference/current/xpack-sql.html](https://www.elastic.co/guide/en/elasticsearch/reference/current/xpack-sql.html)



## Flink
## Kylin
## Flume
## Redis
## Druid
## OpenTSDB
## Keepalived



## Problem

 + javax.jdo.JDODataStoreException: Required table missing : "`VERSION`" in Catalog "" Schema "".
 在执行启动hive metastore时报错：

 解决方法:初始化一下数据库即可
 ```C
 /hive/bin/schematool -dbType mysql -initSchema
 ```
 + Exception in thread "main" MetaException(message:Version information not found in metastore. )
 hive-site.xml
 ```C
  <name>hive.metastore.schema.verification</name>
    <value>false</value>
 ```

## reference

Apache archive [http://archive.apache.org/dist/](http://archive.apache.org/dist/)
持续更新中....
