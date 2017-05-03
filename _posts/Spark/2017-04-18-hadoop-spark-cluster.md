---
layout: post
category : Spark
tagline: "Supporting tagline"
tags:
  -
title: 'Linux搭建Hadoop+Spark集群+ hive + hbase'
---
通过vbox虚拟机来搭建Hadoop+Spark集群,再额外添加一些外围的东西,如Zookeeper,Hbaes,Hive,Kafka,Flume,Redis等.

---

<!--more-->

## Hadoop集群

官网指导 [\[guide_cluster_setup\]](http://hadoop.apache.org/docs/r2.7.3/hadoop-project-dist/hadoop-common/ClusterSetup.html)

## Ubuntu虚拟机

操作系统为Ubuntu，可以设置两个网卡

+ eth0 使用Internal方式，为虚拟机集群创建内网通信
+ eth1 使用NAT方式配合使用端口转发，为虚拟机建立与外界的通信

### vbox

安装VirtualBox在Centos上。通过oracle官网下载软件,[download](https://www.virtualbox.org/wiki/Linux_Downloads)

通过rpm包来安装软件
```C
sudo rpm -ivh xxx.rpm
```

通过vbox创建三个虚拟机(Ubuntu)

虚拟网卡配置

<table>
<tr><td>选项</td>	<td>特点</td>		<td>其他</td></tr>
<tr><td>NAT</td>	<td>虚拟机通过主机访问外网</td>		<td>虚拟机之间无法互相访问，主机无法访问虚拟机，外网可以通过端口转发(port forwarding)访问虚拟机</td></tr>
<tr><td>Bridged</td>	<td>虚拟机通过主机网卡与外网桥接，有独立的IP</td>		<td>虚拟机之间、虚拟机与主机之间、虚拟机与外网之间都可以互相访问</td></tr>
<tr><td>Host-only</td>	<td>虚拟机通过Host-only网卡与主机之间建立内网</td>		<td>虚拟机之间、虚拟机与主机之间可以互相访问。虚拟机与外网之间无法互相访问</td></tr>
<tr><td>Internal</td>	<td>虚拟机之间建立内网</td>		<td>虚拟机之间可以互相访问。虚拟机与主机之间、虚拟机与外网之间无法互相访问</td></tr>
<tr><td>NAT Network</td>	<td>虚拟机之间建立内网，并通过主机主机访问外网</td>		<td>虚拟机之间可以互相访问。主机和外网无法访问虚拟机</td></tr>
</table>

这里我们选择桥接网络，就可以了

网络规划,同一网段。

```C
hostname:master
address 192.168.1.150
netmask 255.255.255.0

hostname:slaves1
address 192.168.1.151
netmask 255.255.255.0

hostname:slaves2
address 192.168.1.152
netmask 255.255.255.0

hostname:slavesx
...
```

### ntp

安装ntp,并在集群中同步时间
{% highlight C linenos %}
sudo apt-get install -y ntp ntpdate
{% endhighlight %}

设置时间服务器的同步方法

```C
sudo ntpdata cn.pool.ntp.org
```
将系统时间写入硬件

```C
sudo hwclock --systohc
```

关闭防火墙

```C
sudo ufw disable
```


### ssh

登陆主机中选择openssh

#### 安装ssh

```C
sudo apt-get install openssh-client openssh-server -y
# check sshd
ps -ef | grep sshd
# or start
sudo /etc/init.d/ssh start
```
如果出现进程，说明启动成功(ssh localhost)

#### ssh no passwd login

##### 介绍ssh

配置ssh免密码登陆，这个环节很重要，因为在集群中master和slave需要进行通信，SSH主要是通过RSA算法来产生公钥和私钥，在数据的传输过程中对数据进行加密来保障数据的安全性和可靠性，公钥部分是公共部分，网络中的任意结点都可以访问，私钥主要用于对数据进行加密，以防他人盗取数据。这是一种非对称算法，想要破解还是有难度的。

Hadoop集群的各个结点之间需要进行数据的访问，被访问的结点对于访问用户结点的可靠性必须进行验证，hadoop采用的是ssh的方法通过密钥验证及数据加解密的方式进行远程安全登录操作，当然，如果hadoop对每个结点的访问均需要进行验证，其效率将会大大降低，所以才需要配置SSH免密码的方法直接远程连入被访问结点，这样将大大提高访问效率

##### 基本原理和用法

ssh之所以能保证安全，原因在于它采用了公钥加密，过程如下:

```C
1.远程主机收到用户的登录请求，把自己的公钥发给用户
2.用户使用这个公钥，将登录密码加密后，发送回来
3.远程主机用自己的私钥，解密登录密码，如果密码正确，就同意用户登录
```

用法,ssh默认端口22

{% highlight C linenos %}
$ssh ip_address
$ssd ip_address -l user	#user
{% endhighlight %}

无密码登陆设置

{% highlight C linenos %}
$cd ~/.ssh # no .ssh file ---> ssh localhost
$ssh-keygen -t rsa
# id_rsa_.pub append to file authorized_keys
$ cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
{% endhighlight %}
上面的步骤，就可以实现登陆本机，可以不输入密码，**第一次登陆还是要密码的**，以后就不需要了。

如果要实现无密登陆到其它的主机，只需将生成的 “ id\_rsa.pub " 追加到其它主机的 ” ~/.ssh/authorized\_keys “ 中去。这里我们使用的方法是先将本机的 ” ~/.ssh/id\_rsa.pub “ 拷贝到你想无密登陆的主机上，再在相应的主机上使用 ” cat " 命令将” ~/.ssh/id\_rsa.pub “ 追加到该主机的 ” ~/.ssh/authorized\_keys “ 中

demo:

```C
> 主机A:用户名:hadoop,ip 192.168.1.150
> 需要登陆的主机B:用户名:hadoop,ip 192.168.1.151
```

A登陆B无密码过程
{% highlight C linenos %}
$scp ~/.ssh/id_rsa.pub hadoop@192.168.1.151:~/
#ssh登陆B
$ssh 192.168.1.151
$cat ~/id__rsa.pub >> ~/.ssh/authorized_keys	# note >>
{% endhighlight %}

现在，我们就可以在A中使用SSH无密登陆到B的hadoop用户了，同理如果想无密登陆其它的主机都可以使用此方法。需要注意的是配置hadoop集群时需要Master和Slave可以互相SSH无密登陆

## java以及hadoop环境变量

java-->[download](http://www.oracle.com/technetwork/java/javase/downloads/index.html)

hadoop-->[download](http://hadoop.apache.org/#Download+Hadoop)

下载完成之后进行解压
```C
tar xf xxx.tar.gz
```

Hadoop优点

> 1.高可靠性：Hadoop按位存储和处理数据
> 2.高扩展性：Hadoop是在计算机集群中完成计算任务，这个集群可以方便的扩展到几千台
> 3.高效性：Hadoop能够在节点之间动态地移动数据，并保证各个节点的动态平衡，因此处理速度快
> 4.高容错性：Hadoop能够自动保存数据的多个副本，并且能够自动将失败的任务重新分配
> 5.低成本：Hadoop是开源的，集群是由廉价的PC机组成

Hadoop是一个分布式系统基础架构，底层是HDFS（Hadoop Distributed File System）分布式文件系统，它存储Hadoop集群中所有存储节点上的文件（64MB块），HDFS上一层是MapReduce引擎（分布式计算框架），对分布式文件系统中的数据进行分布式计算。

__HDFS__:

> 1.NameNode：Hadoop集群中只有一个NameNode，它负责管理HDFS的目录树和相关文件的元数据信息
> 2.Sencondary NameNode：有两个作用，一是镜像备份，二是日志与镜像定期合并，并传输给NameNode
> 3.DataNode：负责实际的数据存储，并将信息定期传输给NameNode

__MapReduce__

Hadoop2开始采用yarn资源管理,Yarn主要是把jobtracker的任务分为两个基本功能：资源管理和任务调度与监控，ResourceManager和每个节点（NodeManager）组成了新处理数据的框架。

> **ResourceManager**：负责集群中的所有资源的统一管理和分配，接受来自各个节点（NodeManager）的资源汇报信息，并把这些信息按照一定的策略分配给各种应用程序（ApplicationMaster）。
> **NodeManager**：与ApplicationMaster承担了MR1框架中的tasktracker角色，负责将本节点上的资源使用情况和任务运行进度汇报给ResourceManager。

![MapReducev1](http://lkkandsyf.github.com/pictures/mapreducev1.png)

![MapReducev2](http://lkkandsyf.github.com/pictures/mapreducev2.png)

Hadoop三种运行方式：单节点方式（单台）、单机伪分布方式（一个节点的集群）与完全分布式（多台组成集群）

hadoop commands
{% highlight C linenos %}
#在使用hdfs之前先要创建用户：
hdfs dfs -mkdir -p /user/clusterwork
hdfs dfs -mkdir data  ——建目录，其实是建在了/user/clusterwork/data 下
hdfs dfs -put *.xml data  ——传文件
hdfs dfs -ls data    ——显示文件
hdfs dfs -rm data/* ——删除文件
hdfs dfs -rmdir data ——删除目录
{% endhighlight %}

配置环境变量
{% highlight C linenos %}

$ vim ~/.bashrc
# append env:
export JAVA_HOME=/usr/lib/jdk
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export PATH=$JAVA_HOME/bin:$PATH
# hadoop configure
export HADOOP_HOME=/usr/local/hadoop
export PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH
{% endhighlight %}

使环境变量生效
```c
source ~/.bashrc
```

## hadoop configure files

涉及到的配置文件主要有7个
<table>
<tr><td>编号</td>	<td><center>文件</center></td>		<td><center>操作</center></td></tr>
<tr><td>1</td>	<td>hadoop/ehadoop/hadoop-env.sh</td>		<td>JAVA_HOME</td></tr>
<tr><td>2</td>	<td>hadoop/etc/hadoop/yarn-env.sh</td>		<td>JAVA_HOME</td></tr>
<tr><td>3</td>	<td>Hadoop/etc/hadoop/slaves</td>		<td>add master and more slaves</td></tr>
<tr><td>4</td>	<td>hadoop/etc/hadoop/core-site.xml</td>		<td>hadoop 核心配置</td></tr>
<tr><td>5</td>	<td>hadoop/etc/hadoop/hdfs-site.xml</td>		<td>增加hdfs,namenode,datanode端口和目录位置</td></tr>
<tr><td>6</td>	<td>hadoop/etc/hadoop/mapred-site.xml</td>		<td>增加mapreduce配置，使用yarn框架，jobhistory地址以及web地址</td></tr>
<tr><td>7</td>	<td>hadoop/etc/hadoop/yarn-site.xml</td>		<td>增加yarn功能</td></tr>
</table>

### hadoop-env.sh

修改`Java_home`
add code in the file
{% highlight C linenos %}
export JAVA_HOME=/usr/lib/jdk
{% endhighlight %}

### yarn-env.sh

修改`Java_home`
add code in the file
{% highlight C linenos %}
export JAVA_HOME=/usr/lib/jdk
{% endhighlight %}

### core-site.xml

增加hadoop核心配置

{% highlight C linenos %}
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://master:9000</value>
    </property>
    <property>
        <name>io.file.buffer.size</name>
        <value>131072</value>
    </property>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>file:/home/ap/cdahdp/app/tmp</value>
        <description>Abasefor other temporary directories.</description>
    </property>
    <property>
        <name>hadoop.proxyuser.spark.hosts</name>
        <value>*</value>
    </property>
    <property>
        <name>hadoop.proxyuser.spark.groups</name>
        <value>*</value>
    </property>
</configuration>
{% endhighlight %}

### hdfs-site.xml

dfs.namenode.name.dir and dfs.datanode.data.dir设置路径,最好设置在hadoop.tmp.dir的目录下面

{% highlight C linenos %}
<configuration>
    </property>
        <name></name>
        <value></value>
    </property>
</configuration>

<configuration>
	<property>
		<name>dfs.namenode.name.dir</name>
		<value>file:/home/hadoop/dfs/name</value>
	</property>
	<property>
		<name>dfs.namenode.data.dir</name>
		<value>file:/home/hadoop/dfs/data</value>
	</property>
	<property>
		<name>dfs.replication</name>    #datanode数量，默认3，我们是2台设置2
		<value>2</value>
	</property>
</configuration>


{% endhighlight %}
### mapred-site.xml

{% highlight C linenos %}
<configuration>
	<property>
		<name>mapreduce.framework.name</name>
		<value>yarn</value>
	</property>
	<property>
		<name>mapreduce.jobhistory.address</name>
		<value>hadoop-master:10020</value>
	</property>
	<property>
		<name>mapreduce.jobhistory.webapp.address</name>
		<value>hadoop-master:19888</value>
	</property>
	<property>
		<name>mapred.job.tracker</name>
		<value>localhost:9001</value>
	</property>
</configuration>


{% endhighlight %}
### yarn-site.xml

{% highlight C linenos %}
<configuration>
	<property>
		<name>yarn.resourcemanager.address</name>
		<value>hadoop-master:8032</value>
	</property>
	<property>
		<name>yarn.resourcemanager.scheduler.address</name>
		<value>hadoop-master:8030</value>
	</property>
	<property>
		<name>yarn.resourcemanager.resource-tracker.address</name>
		<value>hadoop-master:8031</value>
	</property>
	<property>
		<name>yarn.resourcemanager.admin.address</name>
		<value>hadoop-master:8033</value>
	</property>
	<property>
		<name>yarn.resourcemanager.webapp.address</name>
		<value>hadoop-master:8088</value>
	</property>
	<property>
		<name>yarn.nodemanager.aux-services</name>
		<value>mapreduce_shuffle</value>
	</property>
	<property>
		<name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
		<value>org.apache.hadoop.mapred.ShuffleHandler</value>
	</property>
</configuration>
{% endhighlight %}
### slaves

增加slave节点
{% highlight C linenos %}
slave1
slave2
....
{% endhighlight %}

##

## 启动集群

### 格式化分布式文件系统

在每个结点中都要执行下面的初始化
```C
hdfs namenode -format	#这个需要执行一次即可，不需要每次启动都执行,如果status=0表示成功,否则失败
start-all.sh
```

### 启动HDFS文件系统jps查看进程

启动hdfs和yarn,关闭hdfs,yarn

```C
cd hadoop/sbin
./start-dfs.sh
./start-yarn.sh

./stop-dfs.sh
./stop-yarn.sh
```

启动jps查看进程,通常有NameNode,SecondaryNameNode,ResourceManager,DataNode

```C
jps
# master
pthread-id NodeMananger
pthread-id Jps
pthread-id NameNode
pthread-id ResourceMananger
pthread-id DataNode
pthread-id SecondaryNameNode
# slavesx
pthread-id Jps
pthread-id DataNode
pthread-id NodeMananger
```

**meeting problem**

**`not exists DataNode pthread`**

so1.首先修改过master那台的配置文件
so2.多次hadoop namenode -format命令这种不好的使用习惯
so3.在没有出现Datranode结点的机器上，

```C
./bin/Hadoop-daemon.sh start DataNode
./bin/Hadoop-daemon.sh start jobtracker
```
so4.到每个机器上找到../usr/hadoop/tmp/dfs/;ls会有data,这里需要把data文件夹删除掉.再启动集群,就会出现DataNode了。

如果启动异常，可以查看日志，在master机器的HADOOP\_HOME/logs目录

### 查看集群状态

```c
hdfs dfsadmin -report

```

### web查看资源

```C
hdfs:http://master-ip:8088
RM:http://master-ip:50070
```

### 查看HDFS状态

```C
http:master-ip:50070
```
### wordcount实例

上传几个文本文件到hdfs，路径为/tmp/input


查看执行结果

```C
cd ~
echo "hello world hello hadoop" > 1.txt
echo "hello liangkangkang welcome to learn hadoop" > 2.txt
#
hadoop fs -put /home/user/1.txt input
hadoop fs -put /home/user/2.txt input
# hadoop find mapreduce-examples.xx.jar path
# run
hadoop jar hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples.xx.jar wordcount input output

# ls file
hadoop fs -ls output
# result
hadoop fs -cat output/part-r-0000

```
与文件内容比对一下，是否正确。

`如果正确，表示Hadoop集群安装成功`


build env meet problem and solution[link](http://blog.csdn.net/yutianzuijin/article/details/9455319)


------------

## Spark集群

在hadoop集群的基础之上，只要简单配置一下slaves,spark-env.sh，对于spark要用到的目录要提前创建。

```C
mkdir -p

```

spark-evn.sh配置

{% highlight C linenos %}
cd $SPARK_HOME/conf
cp spark-env.sh.templeate spark-env.sh
# edit spark-env.sh
export SCALA_HOME=/usr/local/scala
export JAVA_HOME=/usr/lib/jdk
export SPARK_MASTER_IP=master-ip
export SPARK_WORKER_MEMORY=1g
export HADOOP_HOME=/usr/local/hadoop
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop

export HADOOP_HOME=/home/spark/hadoop
export SPARK_MASTER_IP=master
export SPARK_MASTER_PORT=7077
export SPARK_WORKER_MERMORY=2G
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export SPARK_DAEMON_JAVA_OPTS="-verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:/home/spark/spark/logs -XX:+UseParallelGC -XX:+UseParallelOldGC -XX:+DisableExplicitGC -Xms1024m -Xmx2048m -XX:PermSize=128m -XX:MaxPermSize=256m"
export SPARK_HISTORY_OPTS="-Dspark.history.ui.port=7777 -Dspark.history.retainedApplications=3 -Dspark.history.fs.logDirectory=hdfs://master:9000/sparkHistoryLogs -Dspark.yarn.historyServer.address=master:7788 -Dspark.history.fs.updateInterval=10"

 创建相应目录:
 [spark@master conf]$ mkdir /home/spark/spark/{logs,worker}
 [spark@master conf]$ hadoop fs -mkdir hdfs://master:9000/sparkHistoryLogs


SPARK_LOCAL_IP=10.*.*.41               #本机ip或hostname
SPARK_LOCAL_DIRS=/opt/data/spark/local #配置spark的local目录
SPARK_MASTER_IP=10.*.*.41              #master节点ip或hostname
SPARK_MASTER_WEBUI_PORT=8080           #web页面端口

export SPARK_MASTER_OPTS="-Dspark.deploy.defaultCores=4"    #spark-shell启动使用核数
SPARK_WORKER_CORES=2                    #Worker的cpu核数
SPARK_WORKER_MEMORY=8g                  #worker内存大小
SPARK_WORKER_DIR=/opt/data/spark/work   #worker目录
export SPARK_WORKER_OPTS="-Dspark.worker.cleanup.enabled=true -Dspark.worker.cleanup.appDataTtl=604800"  #worker自动清理及清理时间间隔
export SPARK_HISTORY_OPTS="-Dspark.history.ui.port=18080 -Dspark.history.retainedApplications=3 -Dspark.history.fs.logDirectory=hdfs://10.*.*.41:9000/tmp/spark/applicationHistory"    #history server页面端口、备份数、log日志在HDFS的位置
export SPARK_LOG_DIR=/opt/data/spark/log  #配置Spark的log日志目录
export JAVA_HOME=/usr/local/jdk1.8.0_91/  #配置java路径
export SCALA_HOME=/usr/local/scala-2.10.4/ #配置scala路径

export SPARK_MASTER_IP=10.*.*.41
export SPARK_WORKER_MEMORY=10240m

export HADOOP_HOME=/home/lscm/hadoop/hadoop/lib/native       #配置hadoop的lib路径
export HADOOP_CONF_DIR=/home/lscm/hadoop/hadoop/etc/hadoop/  #配置hadoop的配置路径
{% endhighlight %}

slaves配置

```C
cd $SPARK_HOME/conf
cp slaves.template slaves
# edit slaves
vim slaves
master
slaves1
slaves2
```

spark-default.conf

{% highlight C linenos %}
spark.master                     spark://master:7077
spark.eventLog.enabled           true
spark.eventLog.dir               hdfs://master:9000/sparkHistoryLogs
spark.eventLog.compress          true
spark.history.updateInterval     5
spark.history.ui.port            7777
spark.history.fs.logDirectory    hdfs://master:9000/sparkHistoryLogs

spark.eventLog.enabled  true #eventLog是否生效（建议开启，可以对已完成的任务记录其详细日志）
spark.eventLog.compress true #eventLog是否启用压缩（cpu性能好的情况下建议开启，以减少内存等的占用）
spark.eventLog.dir      hdfs://10.30.96.41:9000/tmp/spark/applicationHistory    #eventLog的文件存放位置，与spark-env.sh中的history server配置位置一致,这两个位置必须手动创建 hadoop fs -mkdir -p /tmp/spark/applicationHistory,否则spark启动失败
spark.broadcast.blockSize  8m        #广播块大小
spark.executor.cores       1         #Executor的cpu核数
spark.executor.memory      512m      #Executor的内存大小
spark.executor.heartbeatInterval  20s #Executor心跳交换时间间隔

spark.files.fetchTimeout   120s      #文件抓取的timeout
spark.task.maxFailures      6        #作业最大失败次数（达到此次数后，该作业不再继续执行，运行失败）
spark.serializer           org.apache.spark.serializer.KryoSerializer    #设置序列化机制（默认使用java的序列化，但是速度很慢，建议使用Kryo）
spark.kryoserializer.buffer.max 256m #序列化缓冲大小
spark.akka.frameSize            128  #Akka调度帧大小
spark.default.parallelism       20   #默认并行数
spark.network.timeout           300s #最大网络延时
spark.speculation               true #Spark推测机制（建议开启）
{% endhighlight %}



### 启动spark集群

**启动Master结点**

```C
cd $SPARK_HOME/sbin
./start-master.sh
```

**启动Worker结点**

```C
cd $SPARK_HOME/sbin
./start-slaves.sh
```

通过jps来查看,会发现在master结点中多出了Master,Worker进程，在slaves结点中jps来看到Worker进程，表示Spark集群安装成功

demo:

```C
cd $SPARK_HOME/bin
./spark-submit
```

通过web-UI来进一步观察

```C
http://master-ip:8080
http://master-ip:4040
```

### 在各个模式下运行spark

spark-submit命令有很多运行模式,local(本地)模式，standalone模式,on-yarn-cluster(on-yarn-standalone),on-yarn-client.

#### local mode
{% highlight C linenos %}
spark-submit --master local --class org.apache.spark.examples.SparkPi  JAR_PATH(mvn package)
{% endhighlight %}
#### standalone mode

首先进入spark安装目录,启动./sbin/start-all.sh,输入jps查看Master,Worker进程

{% highlight C linenos %}
spark-submit --master spark://master-ip:7077 --class org.apache.spark.examples.SparkPi  JAR_PATH(mvn package)
{% endhighlight %}

--master spark://master-ip:7077,这个ip要写的是在spark/conf目录下export SPARK\_MASTER\_IP的值

`这两中方式不需要启动hadoop集群，因为spark有自己的资源管理模式`

#### on-yarn-cluster mode

<font color="red">前提:master的机器和salves机器的系统时间要保持一致，否则会出错</font>

启动hadoop集群start-dfs.sh,start-yarn.sh

看到主节点和namenode secondarynamenode resourcemanager master和从节点有datanode nodemanager worker

提交jar包

{% highlight C linenos %}
spark-submit --master yarn-cluster --class org.apache.spark.examples.SparkPi  JAR_PATH(mvn package)
{% endhighlight %}

结果要在集群中的可以看到.

#### on-yarn-client mode

<font color="red">前提:master的机器和salves机器的系统时间要保持一致，否则会出错</font>

要求和on-yarn-cluster模式一样

{% highlight C linenos %}
spark-submit --master yarn-client --class org.apache.spark.examples.SparkPi  JAR_PATH(mvn package)
{% endhighlight %}

结果在当前的窗口就可以看到。

### 停止spark集群

在master结点中
```C
cd $SPARK_HOME/sbin
./stop-master.sh
./stop-slaves.sh
```

最后再停止hadoop集群


## Hive

hive是在hadoop的基础上构建的，所以要搭建好hadoop集群.如果完成了上面的步骤，就可以了。下面就开始搭建hive数据库.

[download hive from office](http://www.apache.org/dyn/closer.cgi/hive/)

[office guide](https://cwiki.apache.org/confluence/display/Hive/GettingStarted)

在安装Hive之前，还需要有一个元数据库，默认的是内嵌的Derby.但是在企业中大部分都使用Mysql数据库，所以就以这两种数据库,都进行了尝试。

### Hive configuration

hive env varible

```C
tar xf hive-xxx.tar.gz
# rename file in order to set varible
mv apache-xxx hive
vim ~/.bashrc
## appand to code
export HIVE_HOME=/home/lkk/software/hive
export PATH:$PATH:/home/lkk/software/hive/bin
source ~/.bashrc
```

hive configuration

```C
cd $HIVE_HOME/conf
cp hive-env.sh.template hive-evn.sh
vim hive-env.sh
# appand code
export HADOOP_HOME=/home/lkk/software/hadoop
# accord to machine
#export HADOOP_HEADSIZE=256
export HIVE_CONF_DIR=/home/lkk/software/hive

cp hive-default.xml.template hive-site.xml
vim hive-site.xml
# modify code find javax.jdo.option.ConnectionURL add oneself PATH in the metastore
# before
<value>jdbc:derby:;databaseName=metastore_db;create=true</value>
# after
<value>jdbc:derby:;databaseName=/home/lkk/software/hadoop/hive/metastore_db;create=true</value>
```
hive.metastore.warehouse.dir
该参数指定了 Hive 的数据存储目录，默认位置在 HDFS 上面的 /user/hive/warehouse 路径下。

hive.exec.scratchdir
该参数指定了 Hive 的数据临时文件目录，默认位置为 HDFS 上面的 /tmp/hive 路径下。

### Derby

对于Derby来，操作较为简单,[download Apache Derby](http://db.apache.org/derby/derby_downloads.html)

解压文件并设置环境变量

```C
tar xf db-derby-xxxx-bin.tar.gz ## xxx表示版本号
# rename db-derby-xxx-bin to derby
vim ~/.bashrc
export HIVE_HOME=/home/lkk/software/derby
export PATH:$PATH:/home/lkk/software/derby/bin
source ~/.bashrc
# create a directory to store Metastore
mkdir $DERBY_HOME/data -p
```
建立Hive目录用HDFS,warehouse来存储hive的tables或数据

```C
hdfs dfs -mkdir /home/lkk/software/hadoop/hive/warehouse
hdfs dfs -mkdir /tmp
# read and write permission
hdfs dfs -chmod g+w /home/lkk/software/hadoop/hive/warehouse
hdfs dfs -chmod g+w /tmp
```

初始化Derby数据库

```C
cd $HIVE_HOME/bin
schematool -initSchema -dbType derby

```

进入hive shell

```C
cd $HIVE_HOME/bin
hive --version
hive
hive>show databaes;
hive>create table(id string)
hive>show tables;
hive>exit
```

### Mysql

对于Mysql而言，这才是重点，以后也经常用过，必须要熟练应用。

1.先检查系统中是否已经安装了Mysql.

```C
sudo netstat -tap | grep msyql
```
2若没有安装，则可以安装

```C
sudo apt-get install mysql-client mysql-server
```
注意安装过程中会输入root密码。

通过mysql设置用户和密码

```C
mysql -u root -p
# create user
mysql>grant all on *.* to username@'%' identified by 'password';
mysql>flush privileges;
mysql>show grants for username;
mysql>create database hive;
mysql>exit
```

3.配置hive

hive-env.sh

```C
export HIVE_CONF_DIR=HIVE_PATH
export HADOOP_HOME=HADOOP_HOME
```

hive-site.sh

修改ConnectionURL,ConnectionDriverName,ConnectionUserName,ConnectionPassword.
```C
<configuration>
	<property>
		<name>javax.jdo.option.ConnectionURL</name>
		<value>jdbc:mysql://localhost:3306/hive?createDatabaseIfNotExist=true</value>
	</property>
	<property>
		<name>javax.jdo.option.ConnectionDriverName</name>
		<value>com.mysql.jdbc.Driver</value>
	</property>
	<property>
		<name>javax.jdo.option.ConnectionUserName</name>
		<value>root</value>
	</property>
	<property>
		<name>javax.jdo.option.ConnectionPassWord</name>
		<value>123456</value>
	</property>
</configuration>
```

4.JDBC驱动包

[download jdbc driver](http://dev.mysql.com/downloads/connector/j/)需要把jar包放到/hive/lib下

数据库初始化

```C
cd  $HIVE_HOME/bin
schematool -initSchema -dbType mysql
```
problem:

[Failed to get schema version when starting Hive Metastore Service](https://www.ibm.com/support/knowledgecenter/SSPT3X_4.1.0/com.ibm.swg.im.infosphere.biginsights.trb.doc/doc/trb_comp_hive_mysql.html)

进入hive shell

```C
cd $HIVE_HOME/bin
hive --version
hive
hive>show databaes;
hive>create table(id string)
hive>show tables;
hive>exit
```

完成之后，就把这个结点的配置拷贝到其他机器。

```C
scp -r PATH:PATH
```
配置环境和master是一样的。

参考

[Ubuntu系统下配置Hadoop2.7.1+Hive2.1.0](http://blog.csdn.net/cuihaolong/article/details/52038543)

[Hadoop+Hive环境搭建](http://nunknown.com/study/282/#3)

## Hbase

[\[guide office\]](http://hbase.apache.org/book.html)

## Kafka


## Flume


## Redis

## 附录

### WordCount.java

{% highlight java linenos %}
public class WordCount {
    // mapper
    public static class Map extends Mapper<LongWritable, Text, Text, IntWritable> {
        private static IntWritable one = new IntWritable(1);

        private Text word = new Text();

        @Override
        public void map(LongWritable key, Text value, Context context) throws IOException,
                InterruptedException {
            String line = value.toString();
            StringTokenizer token = new StringTokenizer(line);
            while (token.hasMoreElements()) {
                word.set(token.nextToken());
                context.write(word, one);
            }

        };
    }

    // reduce
    public static class Reduce extends Reducer<Text, IntWritable, Text, IntWritable> {
        protected void reduce(Text key, Iterable<IntWritable> values, Context context)
                throws IOException, InterruptedException {
            int sum = 0;
            for (IntWritable value : values) {
                sum += value.get();
            }
            context.write(key, new IntWritable(sum));
        };
    }

    public static void main(String[] args) throws Exception {

        Configuration conf = new Configuration();
        System.setProperty("HADOOP_USER_NAME", "root");//这句话很重要，要不然会告你没有权限执行
        Job job = new Job(conf);

        String[] ioArgs = new String[] { "hdfs://192.168.1.101:7001/input",
                "hdfs://192.168.1.101:7001/output" };
        String[] otherArgs = new GenericOptionsParser(conf, ioArgs).getRemainingArgs();

        job.setJarByClass(WordCount.class);

        FileInputFormat.addInputPath(job, new Path(otherArgs[0]));
        FileOutputFormat.setOutputPath(job, new Path(otherArgs[1]));

        job.setMapperClass(Map.class);
        job.setReducerClass(Reduce.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);

        System.exit(job.waitForCompletion(true) ? 0 : 1);

    }
}
{% endhighlight %}

通过spark-shell允许wordcount

{% highlight scala linenos %}
$hdfs dfs -cat ~/word.txt
$spark-shell --master spark://master:7077
scala>sc
# spark read HDRS text file
scala>val file = sc.textFile("hdfs://master:9000/users/word.txt")	// master not localhost because telnet localhost error
scala>val count = file.flatMap(line => line.split(" ")).map(word => (word, 1)).reduceByKey(_+_)
scala>count.collect()
scala>
scala>
{% endhighlight %}

