---
layout: post
category: Hive
tagline: "Supporting tagline"
tags:
  -
title: 'Hive 参数配置大全'
---
使用Hive的过程，收集相互配置参数，便于优化

---


<!--more-->

## hive1

### hive-site.xml

hive.exec.mode.local.auto
决定 Hive 是否应该自动地根据输入文件大小，在本地运行（在GateWay运行）
true

hive.exec.mode.local.auto.inputbytes.max
如果 hive.exec.mode.local.auto 为 true，当输入文件大小小于此阈值时可以自动在本地模式运行，默认是 128兆。
134217728L

hive.exec.mode.local.auto.tasks.max
如果 hive.exec.mode.local.auto 为 true，当 Hive Tasks（Hadoop Jobs）小于此阈值时，可以自动在本地模式运行。
4

hive.auto.convert.join
是否根据输入小表的大小，自动将 Reduce 端的 Common Join 转化为 Map Join，从而加快大表关联小表的 Join 速度。
false

hive.mapred.local.mem
Mapper/Reducer 在本地模式的最大内存量，以字节为单位，0为不限制。
0

mapred.reduce.tasks
所提交 Job 的 reduer 的个数，使用 Hadoop Client 的配置。
默认是-1，表示Job执行的个数交由Hive来分配
-1

hive.exec.scratchdir
HDFS路径，用于存储不同 map/reduce 阶段的执行计划和这些阶段的中间输出结果。
/tmp/<user.name>/hive

hive.metastore.warehouse.dir
Hive 默认的数据文件存储路径，通常为 HDFS 可写的路径。
"

hive.groupby.skewindata
决定 group by 操作是否支持倾斜的数据。
原理是，在Group by中，对一些比较小的分区进行合并
false

hive.merge.mapfiles
是否开启合并 Map 端小文件，对于 Hadoop 0.20 以前的版本，起一首新的 Map/Reduce Job，对于 0.20 以后的版本，则是起使用 CombineInputFormat 的 MapOnly Job。
true

hive.merge.mapredfiles
是否开启合并 Map/Reduce 小文件，对于 Hadoop 0.20 以前的版本，起一首新的 Map/Reduce Job，对于 0.20 以后的版本，则是起使用 CombineInputFormat 的 MapOnly Job。
false

hive.default.fileformat
Hive 默认的输出文件格式，与创建表时所指定的相同，可选项为 'TextFile' 、 'SequenceFile' 或者 'RCFile'。
'TextFile'

hive.mapred.mode
Map/Redure 模式，如果设置为 strict，将不允许笛卡尔积。
'nonstrict'

hive.exec.parallel
是否开启 map/reduce job的并发提交。
默认Map/Reduce job是顺序执行的，默认并发数量是8，可以配置
false

hive.security.authorization.enabled
Hive 是否开启权限认证。
开启认证后，需要执行授权语句才能对表进行操作，详细请见hive.apache.org
false

hive.exec.plan
Hive 执行计划的路径，会在程序中自动进行设置
null

hive.exec.submitviachild
决定 map/reduce Job 是否应该使用各自独立的 JVM 进行提交（Child进程），默认情况下，使用与 HQL compiler 相同的 JVM 进行提交。
false

hive.exec.script.maxerrsize
通过 TRANSFROM/MAP/REDUCE 所执行的用户脚本所允许的最大的序列化错误数。
100000

hive.exec.script.allow.partial.consumption
是否允许脚本只处理部分数据，如果设置为 true ，因broken pipe等造成的数据未处理完成将视为正常。
false

hive.exec.compress.output
决定查询中最后一个 map/reduce job 的输出是否为压缩格式。
false

hive.exec.compress.intermediate
决定查询的中间 map/reduce job（中间 stage）的输出是否为压缩格式。
对于只进行Map的数据就没有必要了。压缩可以减少网络IO，提高效率。
false

hive.intermediate.compression.codec
中间 map/reduce job 的压缩编解码器的类名（一个压缩编解码器可能包含多种压缩类型），该值可能在程序中被自动设置。 LZO


hive.intermediate.compression.type
中间 map/reduce job 的压缩类型，如 "BLOCK" "RECORD"。

hive.exec.reducers.bytes.per.reducer
每一个 reducer 的平均负载字节数。
改变此参数可以用来影响hive的启动的Reducer的个数，默认每个Reducer处理1G数据
1000000000

hive.exec.reducers.max
reducer 个数的上限。
999

hive.exec.pre.hooks
语句层面，整条 HQL 语句在执行前的 hook 类名。
"

hive.exec.post.hooks
语句层面，整条 HQL 语句在执行完成后的 hook 类名。


hive.exec.parallel.thread.number
并发提交时的并发线程的个数。 默认8个
8

hive.mapred.reduce.tasks.speculative.execution
是否开启 reducer 的推测执行，与 mapred.reduce.tasks.speculative.execution 作用相同。
false

hive.exec.counters.pull.interval
客户端拉取 progress counters 的时间，以毫秒为单位。
1000L

hive.exec.dynamic.partition
是否打开动态分区。 需要打开
false

hive.exec.dynamic.partition.mode
打开动态分区后，动态分区的模式，有 strict 和 nonstrict 两个值可选，strict 要求至少包含一个静态分区列，nonstrict 则无此要求。
建议设置成nonstrict，strict情况下，查询表数据要求强制指定分区。
strict

hive.exec.max.dynamic.partitions
所允许的最大的动态分区的个数。可以手动增加分区。
1000

hive.exec.max.dynamic.partitions.pernode
单个 reduce 结点所允许的最大的动态分区的个数。
100

hive.exec.default.partition.name
默认的动态分区的名称，当动态分区列为''或者null时，使用此名称。''
'__HIVE_DEFAULT_PARTITION__'

hadoop.bin.path
Hadoop Client 可执行脚本的路径，该路径用于通过单独的 JVM 提交 job，使用 Hadoop Client 的配置。
$HADOOP_HOME/bin/hadoop

hadoop.config.dir
Hadoop Client 配置文件的路径，使用 Hadoop Client 的配置。
$HADOOP_HOME/conf

fs.default.name
Namenode 的 URL，使用 Hadoop Client 的配置。
file:///

map.input.file
Map 的输入文件，使用 Hadoop Client 的配置。
null

mapred.input.dir
Map 的输入目录，使用 Hadoop Client 的配置。
null

mapred.input.dir.recursive
输入目录是否可递归嵌套，使用 Hadoop Client 的配置。
false

mapred.job.tracker
Job Tracker 的 URL，使用 Hadoop Client 的配置，如果这个配置设置为 'local'，将使用本地模式。
local

mapred.job.name
Map/Reduce 的 job 名称，如果没有设置，则使用生成的 job name，使用 Hadoop Client 的配置。
null

mapred.reduce.tasks.speculative.execution
Map/Reduce 推测执行，使用 Hadoop Client 的配置。
null

hive.metastore.metadb.dir
Hive 元数据库所在路径。
"

hive.metastore.uris
Hive 元数据的 URI，多个 thrift://地址，以英文逗号分隔。
"

hive.metastore.connect.retries
连接到 Thrift 元数据服务的最大重试次数。
3

javax.jdo.option.ConnectionPassword
JDO 的连接密码。
"

hive.metastore.ds.connection.url.hook
JDO 连接 URL Hook 的类名，该 Hook 用于获得 JDO 元数据库的连接字符串，为实现了 JDOConnectionURLHook 接口的类。
"

javax.jdo.option.ConnectionURL
元数据库的连接 URL。
"

hive.metastore.ds.retry.attempts
当没有 JDO 数据连接错误后，尝试连接后台数据存储的最大次数。
1

hive.metastore.ds.retry.interval
每次尝试连接后台数据存储的时间间隔，以毫秒为单位。
1000

hive.metastore.force.reload.conf
是否强制重新加载元数据配置，一但重新加载，该值就会被重置为 false。
false

hive.metastore.server.min.threads
Thrift 服务线程池的最小线程数。
8

hive.metastore.server.max.threads
Thrift 服务线程池的最大线程数。
0x7fffffff

hive.metastore.server.tcp.keepalive
Thrift 服务是否保持 TCP 连接。
true

hive.metastore.archive.intermediate.original
用于归档压缩的原始中间目录的后缀，这些目录是什么并不重要，只要能够避免冲突即可。
'_INTERMEDIATE_ORIGINAL'

hive.metastore.archive.intermediate.archived
用于归档压缩的压缩后的中间目录的后缀，这些目录是什么并不重要，只要能够避免冲突即可。
'_INTERMEDIATE_ARCHIVED'

hive.metastore.archive.intermediate.extracted
用于归档压缩的解压后的中间目录的后缀，这些目录是什么并不重要，只要能够避免冲突即可。
'_INTERMEDIATE_EXTRACTED'

hive.cli.errors.ignore
是否忽略错误，对于包含多的 SQL 文件，可以忽略错误的行，继续执行下一行。
false

hive.session.id
当前会话的标识符，格式为“用户名_时间”用于记录在 job conf 中，一般不予以手动设置。
"

hive.session.silent
当前会话是否在 silent 模式运行。 如果不是 silent 模式，所以 info 级打在日志中的消息，都将以标准错误流的形式输出到控制台。
false

hive.query.string
当前正在被执行的查询字符串。
"

hive.query.id
当前正在被执行的查询的ID。
"

hive.query.planid
当前正在被执行的 map/reduce plan 的 ID。
"

hive.jobname.length
当前 job name 的最大长度，hive 会根据此长度省略 job name 的中间部分。
50

hive.jar.path
通过单独的 JVM 提交 job 时，hive_cli.jar 所在的路径
"

hive.aux.jars.path
各种由用户自定义 UDF 和 SerDe 构成的插件 jar 包所在的路径。
"

hive.added.files.path
ADD FILE 所增加的文件的路径。
"

hive.added.jars.path
ADD JAR 所增加的文件的路径。
"

hive.added.archives.path
ADD ARCHIEVE 所增加的文件的路径。
"

hive.table.name
当前的 Hive 表的名称，该配置将通过 ScirptOperator 传入到用户脚本中。
"

hive.partition.name
当前的 Hive 分区的名称，该配置将通过 ScriptOperator 传入到用户脚本中。
"

hive.script.auto.progress
脚本是否周期性地向 Job Tracker 发送心跳，以避免脚本执行的时间过长，使 Job Tracker 认为脚本已经挂掉了。
false

hive.script.operator.id.env.var
用于识别 ScriptOperator ID 的环境变量的名称。
'HIVE_SCRIPT_OPERATOR_ID'

hive.alias
当前的 Hive 别名，该配置将通过 ScriptOpertaor 传入到用户脚本中。
"

hive.map.aggr
决定是否可以在 Map 端进行聚合操作
true

hive.join.emit.interval
Hive Join 操作的发射时间间隔，以毫秒为单位。
1000

hive.join.cache.size
Hive Join 操作的缓存大小，以字节为单位。
25000

hive.mapjoin.bucket.cache.size
Hive Map Join 桶的缓存大小，以字节为单位。
100

hive.mapjoin.size.key
Hive Map Join 每一行键的大小，以字节为单位。
10000

hive.mapjoin.cache.numrows
Hive Map Join 所缓存的行数。
25000

hive.groupby.mapaggr.checkinterval
对于 Group By 操作的 Map 聚合的检测时间，以毫秒为单位。
100000

hive.map.aggr.hash.percentmemory
Hive Map 端聚合的哈稀存储所占用虚拟机的内存比例。
0.5

hive.map.aggr.hash.min.reduction
Hive Map 端聚合的哈稀存储的最小 reduce 比例。
0.5

hive.udtf.auto.progress
Hive UDTF 是否周期性地报告心跳，当 UDTF 执行时间较长且不输出行时有用。
false

hive.fileformat.check
Hive 是否检查输出的文件格式。
true

hive.querylog.location
Hive 实时查询日志所在的目录，如果该值为空，将不创建实时的查询日志。
'/tmp/$USER'

hive.script.serde
Hive 用户脚本的 SerDe。
'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'

hive.script.recordreader
Hive 用户脚本的 RecordRedaer。
'org.apache.hadoop.hive.ql.exec.TextRecordReader'

hive.script.recordwriter
Hive 用户脚本的 RecordWriter。
'org.apache.hadoop.hive.ql.exec.TextRecordWriter'

hive.hwi.listen.host
HWI 所绑定的 HOST 或者 IP。
'0.0.0.0'

hive.hwi.listen.port
HWI 所监听的 HTTP 端口。
9999

hive.hwi.war.file
HWI 的 war 文件所在的路径。
$HWI_WAR_FILE

hive.test.mode
是否以测试模式运行 Hive
false

hive.test.mode.prefix
Hive 测试模式的前缀。
'test_'

hive.test.mode.samplefreq
Hive 测试模式取样的频率，即每秒钟取样的次数。
32

hive.test.mode.nosamplelist
Hive 测试模式取样的排除列表，以逗号分隔。
"

hive.merge.size.per.task
每个任务合并后文件的大小，根据此大小确定 reducer 的个数，默认 256 M。
256000000

hive.merge.smallfiles.avgsize
需要合并的小文件群的平均大小，默认 16 M。
16000000

hive.optimize.skewjoin
是否优化数据倾斜的 Join，对于倾斜的 Join 会开启新的 Map/Reduce Job 处理。
false

hive.skewjoin.key
倾斜键数目阈值，超过此值则判定为一个倾斜的 Join 查询。
1000000

hive.skewjoin.mapjoin.map.tasks
处理数据倾斜的 Map Join 的 Map 数上限。
10000

hive.skewjoin.mapjoin.min.split
处理数据倾斜的 Map Join 的最小数据切分大小，以字节为单位，默认为32M。
33554432

mapred.min.split.size
Map Reduce Job 的最小输入切分大小，与 Hadoop Client 使用相同的配置。
1

hive.mergejob.maponly
是否启用 Map Only 的合并 Job。
true

hive.heartbeat.interval
Hive Job 的心跳间隔，以毫秒为单位。
1000

hive.mapjoin.maxsize
Map Join 所处理的最大的行数。超过此行数，Map Join进程会异常退出。
1000000

hive.hashtable.initialCapacity
Hive 的 Map Join 会将小表 dump 到一个内存的 HashTable 中，该 HashTable 的初始大小由此参数指定。
100000

hive.hashtable.loadfactor
Hive 的 Map Join 会将小表 dump 到一个内存的 HashTable 中，该 HashTable 的负载因子由此参数指定。
0.75

hive.mapjoin.followby.gby.localtask.max.memory.usage
MapJoinOperator后面跟随GroupByOperator时，内存的最大使用比例
0.55

hive.mapjoin.localtask.max.memory.usage
Map Join 的本地任务使用堆内存的最大比例
0.9

hive.mapjoin.localtask.timeout
Map Join 本地任务超时，淘宝版特有特性
600000

hive.mapjoin.check.memory.rows
设置每多少行检测一次内存的大小，如果超过 hive.mapjoin.localtask.max.memory.usage 则会异常退出，Map Join 失败。
100000

hive.debug.localtask
是否调试本地任务，目前该参数没有生效
false

hive.task.progress
是否开启 counters ，以记录 Job 执行的进度，同时客户端也会拉取进度 counters。
false

hive.input.format
Hive 的输入 InputFormat。
默认是org.apache.hadoop.hive.ql.io.HiveInputFormat，其他还有org.apache.hadoop.hive.ql.io.CombineHiveInputFormat

hive.enforce.bucketing
是否启用强制 bucketing。
false

hive.enforce.sorting
是否启用强制排序。
false

hive.mapred.partitioner
Hive 的 Partitioner 类。
'org.apache.hadoop.hive.ql.io.DefaultHivePartitioner'

hive.exec.script.trust
Hive Script Operator For trust
false

hive.hadoop.supports.splittable.combineinputformat
是否支持可切分的 CombieInputFormat
false

hive.optimize.cp
是否优化列剪枝。
true

hive.optimize.ppd
是否优化谓词下推。
true

hive.optimize.groupby
是否优化 group by。
true

hive.optimize.bucketmapjoin
是否优化 bucket map join。
false

hive.optimize.bucketmapjoin.sortedmerge
是否在优化 bucket map join 时尝试使用强制 sorted merge bucket map join。
false

hive.optimize.reducededuplication
是否优化 reduce 冗余。
true

hive.hbase.wal.enabled
是否开启 HBase Storage Handler。
true

hive.archive.enabled
是否启用 har 文件。
false

hive.archive.har.parentdir.settable
是否启用 har 文件的父目录可设置。
false

hive.outerjoin.supports.filters
是否启动外联接支持过滤条件。
true

hive.fetch.output.serde
对于 Fetch Task 的 SerDe 类
'org.apache.hadoop.hive.serde2.DelimitedJSONSerDe'

hive.semantic.analyzer.hook
Hive 语义分析的 Hook，在语义分析阶段的前后被调用，用于分析和修改AST及生成的执行计划，以逗号分隔。
null

hive.cli.print.header
是否显示查询结果的列名，默认为不显示。
false

hive.cli.encoding
Hive 默认的命令行字符编码。
'UTF8'

hive.log.plan.progress
是否记录执行计划的进度。
true

hive.pull.progress.counters
是否从 Job Tracker 上拉取 counters，淘宝特有配置项。
true

hive.job.pre.hooks
每个 Job 提交前执行的 Hooks 列表，以逗号分隔，淘宝特有配置项。
"

hive.job.post.hooks
每个 Job 完成后执行的 Hooks 列表，以逗号分隔，淘宝特有配置项。
"

hive.max.progress.counters
Hive 最大的进度 couters 个数，淘宝特有配置项。
100

hive.exec.script.wrapper
Script Operator 脚本调用的封装，通常为脚本解释程序。例如，可以把该变量值的名称设置为"python"，那么传递到 Script Operator 的脚本将会以"python &lt;script command&gt;"的命令形式进行调用，如果这个值为null或者没有设置，那么该脚本将会直接以"&lt;script command&gt;"的命令形式调用。
null

hive.check.fatal.errors.interval
客户端通过拉取 counters 检查严重错误的周期，以毫秒为单位，淘宝特有配置项。
5000L


## hive2
### hive-site.xml
