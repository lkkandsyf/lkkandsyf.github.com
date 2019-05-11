---
layout: post
category :
tagline: "Supporting tagline"
tags:
  - zookeeper
title: '在Linux下搭建zookeeper集群服务模式'
---
Zookeeper是一个开源的分布式应用程序协调服务.可用于对集群的有效管理.

---
<!--more-->

因为Zookeeper前提需要jdk的支持，所以要先配置好Java环境,才能配置zookeeper,[\[download zookeeper\]](http://zookeeper.apache.org/releases.html)找到需要的版本进行下载。

## 安装Zookeeper

将将下载好的文件进行解压
```C
tar xf zookeeper-xx-xx.tar.gz
```

配置zookeeper的环境变量,在~/.bashrc中添加如下配置
```C
ZOOKEEPER_HOME=/opt/deploy/zookeeper-3.3.6
PATH=$PATH:$ZOOKEEPER_HOME/bin
```
source  ~/.bashrc使配置生效。

然后进入到刚刚解压的目录，不过最后我们可以重命名一下文件名(zookeeper)，这样便于操作.进入到conf目录下，把zoo\_sample.cfg复制为zoo.cfg
```C
cd zookeeper/conf
cp zoo_sample.cfg zoo.cfg
```
接下来，需要对复制的文件zoo.cfg文件，进行修改,主要是dataDir,dataLogDir，server的设置

参数说明

 + tickTime这个时间是作为zookeeper服务器之间或客户端与服务器之间维持心跳的时间间隔,也就是说每个tickTime时间就会发送一个心跳。

 + initLimit这个配置项是用来配置zookeeper接受客户端（这里所说的客户端不是用户连接zookeeper服务器的客户端,而是zookeeper服务器集群中连接到leader的follower 服务器）初始化连接时最长能忍受多少个心跳时间间隔数。

 + 当已经超过10个心跳的时间（tickTime）长度后 zookeeper 服务器还没有收到客户端的返回信息,那么表明这个客户端连接失败。总的时间长度就是 10*2000=20秒。

 + syncLimit这个配置项标识leader与follower之间发送消息,请求和应答时间长度,最长不能超过多少个tickTime的时间长度,总的时间长度就是5*2000=10秒。

 + dataDir顾名思义就是zookeeper保存数据的目录,默认情况下zookeeper将写数据的日志文件也保存在这个目录里；

 + clientPort这个端口就是客户端连接Zookeeper服务器的端口,Zookeeper会监听这个端口接受客户端的访问请求；

 + server.A=B:C:D中的A是一个数字,表示这个是第几号服务器,B是这个服务器的IP地址，C第一个端口用来集群成员的信息交换,表示这个服务器与集群中的leader服务器交换信息的端口，D是在leader挂掉时专门用来进行选举leader所用的端口。

```C
# The number of milliseconds of each tick
tickTime=2000
# The number of ticks that the initial
# synchronization phase can take
initLimit=10
# The number of ticks that can pass between
# sending a request and getting an acknowledgement
syncLimit=5
# the directory where the snapshot is store
dataDir=/usr/zookeeper/data
dataLogDir=/usr/zookeeper/log
# the port at which the clients will connect
clientPort=2181
## cluster mode
server.1=192.168.1.149:2888:3888
server.2=192.168.1.150:2888:3888
server.3=192.168.1.151:2888:3888
```
`注意`:dataDir和dataLogDir所指的文件夹必须存在，否则启动的时候会出现错误

如果是集群模式,将在zoo.cfg文件的末尾添加对应的ip:port,如上面的配置，然后将zookeeper文件夹拷贝到其他的机器上,在dataDir的目录下创建myid文件，并把zoo.cfg文件中服务的数字写入myid

```C
# server.1 ip
echo 1 dataDir/myid

# server.2 ip
echo 2 dataDir/myid

# server.3 ip
echo 3 dataDir/myid

# copy file to other machine
scp -r zookeeper user@ip:`pwd`
```

### 启动

通过zkServer.sh来启动,如果是单机，则通过下面命令

```C
zkServer.sh start
# status
zkServer.sh status
ps -ef | grep zookeeper # run status
```

如果是集群的话，需要在每一个机器上去运行这个命令

### 测试

**单机模式**

如果不加参数，默认是本地

```C
zkCli.sh
```

**集群模式**

在任何一台机器上运行,下面的命令

```C
zkCli.sh -server 192.168.1.147:2181
help
```
如果出现cat ~/zookeeper.out

后面的ip是配置中的任意一个。

`注意`:如果出现拒绝连接，看看是不是防火墙没关

```C
1.防火墙是否关闭 ststemctl stop firwalld(Centos7) --> firwall-cmd --stat,systemctl disable firewalld.service (禁止开机启动，永久关闭)
2.将本地的ip映射到本地/etc/hosts文件中
```

## 日志配置

conf/log4j.properties配置日志目录和文件名,但是启动zk发现不起作用，日志全都输入当前的目录下zookeeper.out文件中，不利于故障排查,下次想看zookeeper日志的时候，又忘记上次在哪执行的命令啦，这真的很蛋疼,为此找到根本原因,从启动程序来看

zkEnv.sh中没有配置ZOO\_LOG\_DIR默认是就是当前目录,`修改ZOO_LOG_DIR="$ZK_HOME/log"`,将日志文件写到zookeeper安装目录下的log文件夹中（logs不需要创建，它会自己创建）,但是启动程序，还会有out文件，大小为0，究其原因是因为zkServer.sh会使用nohup进行zk启动，然而nohup必然会输出一个日志文件到你设置的目录中

zkServer.sh,修改配置
```c
_ZOO_DAEMON_OUT="$ZOO_LOG_DIR/zookeeper.log"
```
对于日志，我们也可以设置每天一个文件，按天滚动,继续修改zkEnv.sh
```C
将
ZOO_LOG4J_PROP="INFO,CONSOLE"
修改为：
ZOO_LOG4J_PROP="INFO,ROLLINGFILE"
```
修改log4j.properties文件
```C
zookeeper.root.logger=INFO,ROLLINGFILE			和env保持一致
log4j.appender.ROLLINGFILE=org.apache.log4j.RollingFileAppender
```
其他配置
```c
log4j.appender.ROLLINGFILE.File=zookeeper.log
log4j.appender.ROLLINGFILE.DataPattern='.'yyyy-MM-dd-HH-mm
log4j.appender.ROLLINGFILE.Threshold=debug
log4j.appender.ROLLINGFILE.encoding=UTF-8
log4j.appender.ROLLINGFILE.Append=false
log4j.appender.ROLLINGFILE.layout=org.apache.log4j.PatternLayout
log4j.appender.ROLLINGFILE.layout.ConversionPattern= [%d{yyyy-MM-dd HH\:mm\:ss}]%-5p %c(line\:%L) %x-%m%n
```

DailyRollingFileAppender特点是`固定周期时间生成一个日志文件`，比如，默认情况是每天生成一个文件。这种日志可以方便根据时间来定位日志位置，使日志清晰易查。但是这种日志有个不好地方是，不能限制日志数量，`MaxBackupIndex属性和MaxFileSize在DailyRollingFileAppender中是无效的`，这个还是按照自己的需求来定！

所以还需要自己弄个`Crontab`定期清理日志

### zNode节点操作

```C
create /parh data　　　　　　创建一个名为/path的zNode节点，并包含数据data

delete /path　　　　  　　　　删除名为/path的zNode节点

exists /path   　　　　　　　　检查是否存在名为/path的zNode节点

setData /path data    　　　　设置名为/path的zNode的数据为data

getData  /path　　　　　　　  返回名为/path的zNode节点的数据信息

getChildren /path　　　　　　返回所有/path节点的所有子节点列表

```
zNode节点还有不同的类型，持久（persistent）节点和临时（ephemeral）节点。持久的zNode，如/path，只能通过调用delete来进行删除，而临时的zNode则与之相反，当创建该节点的客户端崩溃或者关闭了与ZooKeeper服务器的连接时候，这个临时zNode节点就会被删除了。其中临时节点可用于实现分布式锁。


## 常见问题

 + zookeeper too many file open
 ulimit -n 太小造成
 ulimit -n 653600

 +  fsync-ing the write ahead log in SyncThread:1 took 4675ms which will adversely effect operation la

 “FOLLOWER”在跟“LEADER”同步时，fsync操作时间过长，导致超时。
 ```C
 增加“tickTime”或者“initLimit和syncLimit”的值，或者两者都增大
 ```

## ref

基本操作[https://blog.csdn.net/xyang81/article/details/53053642](https://blog.csdn.net/xyang81/article/details/53053642)

### zk配置参数

| 参数 | 描述 | 默认 | 配置文件| demo|
| :------| :------ | :------ |:------ | :----- |
| tickTime | zk时钟 | 单位毫秒2000 | zoo.cfg | tickTime=2000 |
| minSessionTimeout | 最小超时时间 | 2\*tickTime | zoo.cfg | minSessionTimeout=4000 |
| maxSessionTimeout | 最大超时时间 | 20\*tickTime | zoo.cfg | minSessionTimeout=40000 |


[http://zookeeper.apache.org/doc/current/zookeeperStarted.html](http://zookeeper.apache.org/doc/current/zookeeperStarted.html)



### 疑难杂症
