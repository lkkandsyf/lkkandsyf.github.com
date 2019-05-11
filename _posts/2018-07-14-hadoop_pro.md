---
layout: post
category: Hadoop
tagline: "Supporting tagline"
tags: yarn
  -
title: 'hadoop 疑难杂症'
---
收集hadoop中的碰到过的疑难杂症

---

<!--more-->

## namenode

 + 安装hadoop启动之后总有警告18/12/17 10:15:24 WARN util.NativeCodeLoader: `Unable to load native-hadoop library for your platform.`.. using builtin-java classes where applicable
 原因：Apache提供的hadoop本地库是32位的，而在64位的服务器上就会有问题，因此需要自己编译64位的版本。或者直接找编译好的,到这里下载[http://dl.bintray.com/sequenceiq/sequenceiq-bin/](http://dl.bintray.com/sequenceiq/sequenceiq-bin/)对应的版本

 将准备好的64位的lib包解压到已经安装好的hadoop安装目录的lib/native 和 lib目录下：
 ```c
 tar xf hadoop-native-64-2.7.0.tar -C $HADOOP_HOME/lib/native
 tar xf hadoop-native-64-2.7.0.tar -C $HADOOP_HOME/lib/
 ```
 编辑环境变量
 ```c
 vim /etc/profile
 export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
 export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib"
 source /etc/profile
 ```
 自检hadoop checkative -a
 ```c
 $HADOOP_HOME/bin/hadoop checknative -a
 ```
 ```C
 18/12/17 10:28:50 WARN bzip2.Bzip2Factory: Failed to load/initialize native-bzip2 library system-native, will use pure-Java version
 18/12/17 10:28:50 INFO zlib.ZlibFactory: Successfully loaded & initialized native-zlib library
 Native library checking:
 hadoop:  true /opt/big-data/hadoop/lib/libhadoop.so
 zlib:    true /lib64/libz.so.1
 snappy:  false
 lz4:     true revision:99
 bzip2:   false
 openssl: false Cannot load libcrypto.so (libcrypto.so: `无法打开共享对象文件: 没有那个文件或目录)!`
 18/12/17 10:28:50 INFO util.ExitUtil: Exiting with status 1
 ```
 `openssl: false Cannot load libcrypto.so (libcrypto.so: 无法打开共享对象文件: 没有那个文件或目录)!`,这是Hadoop1.7的bug[https://issues.apache.org/jira/browse/HADOOP-12845](https://issues.apache.org/jira/browse/HADOOP-12845),只能去规避
 ```C
 ```
 尝试解决,建立符号链接
 ```c
 cd /usr/lib64/
 ln -s libcrypto.so.1.0.1e libcrypto.so
 18/12/17 10:32:05 WARN bzip2.Bzip2Factory: Failed to load/initialize native-bzip2 library system-native, will use pure-Java version
 18/12/17 10:32:05 INFO zlib.ZlibFactory: Successfully loaded & initialized native-zlib library
 Native library checking:
 hadoop:  true /opt/big-data/hadoop/lib/libhadoop.so
 zlib:    true /lib64/libz.so.1
 snappy:  false
 lz4:     true revision:99
 bzip2:   false
 openssl: true /usr/lib64/libcrypto.so
 18/12/17 10:32:05 INFO util.ExitUtil: Exiting with status 1
 ```
 现在输入hdfs命令时，就不会出现警告了。

 + namenode 服务起不来
```c
ERROR org.apache.hadoop.hdfs.server.namenode.FSImage: Failed to load image from FSImageFile(file=/opt/hadoop/dfs/name/current/fsimage_0000000000000001344, cpktTxId=0000000000000001344)
java.io.IOException: Premature EOF from inputStream
```
  原因：namenode loadFSImage file 失败
  **solution**:
  1.重新格式化namenode的数据，之前的元数据全部丢失,`慎用`
  2.如果是集群，保证两个namenode数据同步就行了,查看文件大小fsimage\_0000000000000001344大小，并进行对比，保证文件一致,如果不相同可以copy和删除这个文件的md5文件。
  3.最后的方案：格式化之前要删除hdsf文件以及日志,重启namenode，datenode
```c
hadoop namenode -format
```

 + Datanode掉线判断
 datatname`进程死亡或者网络故障`
 1. datanode 端口已占用 :hadoop datanode java.net.BindException: 地址已在使用,Port already in use 53905
 **solution**:
 ```c
 netstat -alnp |grep 68905
 [root@lkk current]# netstat -alnp |grep 53901
 tcp        0      0 10.65.133.5:53901           10.65.133.5:9092            ESTABLISHED 10686/java
 tcp        0      0 10.65.133.5:9092            10.65.133.5:53901           ESTABLISHED 6208/java
 [root@lkk current]#kill -9 10686 6208
 [root@lkk current]# hadoop-daemon.sh --config $HADOOP_HOME/conf  start datanode
  ```
  然后启动对应的服务,之前kill的服务
##  yarn
  + I've got a number of Samza jobs that I want to run. I can get the first to run ok. However, the second job seems to sit at the ACCEPTED state and never transitions into the RUNNING state until I kill the first job.

  **solution**:
  I changed the value of yarn.scheduler.capacity.maximum-am-resource-percent within capacity-scheduler.xml to be `more than the default of 0.1.` the [document](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/CapacityScheduler.html) for more help

  + Why does Hadoop report `Unhealthy Node local-dirs and log-dirs are bad`?,On visiting http://localhost:8088/cluster, I find that my nodsted as an "unhealthy node".

  **solution**:
  The most common cause of local-dirs are bad is due to available disk space on the node exceeding yarn's max-disk-utilization-per-disk-percentage default value of 90.0%.
   Either clean up the disk that the unhealthy node is running on, or increase the threshold in yarn-site.xml
```C
<property>
<name>yarn.nodemanager.disk-health-checker.max-disk-utilization-per-disk-percentage</name>
<value>98.5</value>
</property>
```
Avoid disabling disk check, because your jobs may failed when the disk eventually run out of space, or if there are permission issues. Refer to the yarn-site.xml Disk Checker section for more details.
If you suspect there is filesystem error on the directory, you can check by running
hdfs fsck /tmp/hadoop-hduser/nm-local-dir
Refer to the [yarn-site.xml Disk Check section](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/NodeManager.html#Disk_Checker)



## hadoop Unhealthy Nodes

由于磁盘空间不足引起. NodeManager默认会每两分钟检查本地磁盘（local-dirs），找出那些目录可以使用。注意如果判定这个磁盘不可用，则在重启NodeManager之前，就算磁盘好了，也不会把它变成可用。代码在LocalDirsHandlerService，DirectoryCollection。

当好磁盘数少于一定量时，会把这台机器变成unhealthy，将不会再给这台机器分配任务。

**solution**
1. 重启nodemanager
+ yarn-daemon.sh stop nodemanager
+ yarn-daemon.sh start nodemanager
2. 重启resourcemanager(否则会导致修改的节点状态错乱)
+ yarn-daemon.sh stop resourcemanager
+ yarn-daemon.sh start resourcemanager
3. 刷新web监控页面
不健康的节点nodemanager已经不见了
4. yarn显示各节点状态
```
yarn node --list -all
```
### namenode 异常


 + WARN org.apache.hadoop.hdfs.server.blockmanagement.BlockPlacementPolicy: Failed to place enough replicas, still in need of 1 to reach 3 (unavailableStorages=[], storagePolicy=BlockStoragePolicy{HOT:7, storageTypes=[DISK], creationFallbacks=[], replicationFallbacks=[ARCHIVE]}, newBlock=false) For more information, please enable DEBUG log level on org.apache.hadoop.hdfs.server.blockmanagement.BlockPlacementPolicy

 namenode高可用,可以在core-site.xml文件中修改ha.health-monitor.rpc-timeout.ms参数值，来扩大zkfc监控检查超时时间。
 ```C
 <property>
  <name>ha.health-monitor.rpc-timeout.ms</name>
   <value>180000</value>
 </property>
 ```
 [http://www.freeoa.net/osuport/db/my-hbase-usage-problem-sets_2979.html](http://www.freeoa.net/osuport/db/my-hbase-usage-problem-sets_2979.html)

[https://blog.csdn.net/Aquester/article/details/50032271?locationNum=13&fps=1#_Toc4121](https://blog.csdn.net/Aquester/article/details/50032271?locationNum=13&fps=1#_Toc4121)
