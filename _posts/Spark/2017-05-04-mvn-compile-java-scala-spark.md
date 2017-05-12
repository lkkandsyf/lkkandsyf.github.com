---
layout: post
category : Spark
tagline: "Supporting tagline"
tags:
  -
title: '以spark2.0为主,使用mvn命令来编译java,scala的spark程序'
---
mvn compile Java Scala Spark
---
熟练使用命令对程序的编译和执行，使我们可以更加清新的了解整个过程，有助于学习基本理论，加深印象
<!--more-->

---

开始前奏:配置好[\[Jdk 1.8\]](http://www.oracle.com/technetwork/java/javase/downloads/index.html),[\[Scala 2.11.8\]](http://www.scala-lang.org/download/),[\[Maven 3\]](http://maven.apache.org/download.cgi),[\[Spark2.0.0 later\]](http://spark.apache.org/downloads.html).好了，让我们开始吧。

## mvn create project

通过使用 mvn archetype:generate交互式界面，进行创建项目。需要填写一些基本的信息就可以了。也可以通过一键部署。

```C
mvn archetype:generate \
-DarchetypeGroupId=org.apache.maven.archetypes \
-DgroupId=com.nsfocus \
-DartifactId=Myspark \
-Dfilter=org.apache.maven.archetypes:maven-archetype-quick
```

得到了一个Myspark目录，通过find命令来查看结果。

```C
.
├── pom.xml
└── src
    ├── main
    │   └── java
    │       └── com
    │           └── nsfocus
    │               └── App.java
    └── test
        └── java
            └── com
                └── nsfocus
                    └── AppTest.java

9 directories, 3 files
```

## mvn run java scala Spark code

根据自己的项目`configure pom.xml`，非常重要。国内建议使用[\[aliyun repo\]](http://maven.aliyun.com/nexus/content/groups/public/)

pom.xml
{% highlight xml linenos %}
<?xml version="1.0"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.nsfocus</groupId>
  <artifactId>myspark</artifactId>
  <version>1.0-SNAPSHOT</version>
  <packaging>jar</packaging>
  <name>myspark</name>
  <url>http://maven.apache.org</url>
  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <spark.version>2.0.0</spark.version>
  </properties>
  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>3.8.1</version>
      <scope>test</scope>
    </dependency>
    <dependency>
      <groupId>org.apache.spark</groupId>
      <artifactId>spark-core_2.11</artifactId>
      <version>${spark.version}</version>
    </dependency>
    <dependency>
      <groupId>org.apache.spark</groupId>
      <artifactId>spark-streaming_2.11</artifactId>
      <version>${spark.version}</version>
    </dependency>
    <!--<dependency>-->
    <!--<groupId>org.apache.spark</groupId>-->
    <!--<artifactId>spark-streaming-kafka_2.11</artifactId>-->
    <!--<version>${spark.version}</version>-->
    <!--</dependency>-->
    <dependency>
      <groupId>org.apache.spark</groupId>
      <artifactId>spark-sql_2.11</artifactId>
      <version>${spark.version}</version>
    </dependency>
    <dependency>
      <groupId>org.apache.spark</groupId>
      <artifactId>spark-hive_2.11</artifactId>
      <version>${spark.version}</version>
    </dependency>
    <!--<dependency>-->
    <!--<groupId>com.google.code.gson</groupId>-->
    <!--<artifactId>gson</artifactId>-->
    <!--<version>2.3.1</version>-->
    <!--</dependency>-->
    <!--<dependency>-->
    <!--<groupId>org.bouncycastle</groupId>-->
    <!--<artifactId>bcprov-jdk15on</artifactId>-->
    <!--<version>1.47</version>-->
    <!--</dependency>-->
    <!--<dependency>-->
    <!--<groupId>com.alibaba</groupId>-->
    <!--<artifactId>fastjson</artifactId>-->
    <!--<version>1.2.22</version>-->
    <!--</dependency>-->
  </dependencies>
  <build>
    <sourceDirectory>src/main/java</sourceDirectory>
    <testSourceDirectory>src/test/java</testSourceDirectory>
    <plugins>
      <plugin>
        <artifactId>maven-assembly-plugin</artifactId>
        <configuration>
          <descriptorRefs>
            <descriptorRef>jar-with-dependencies</descriptorRef>
          </descriptorRefs>
        </configuration>
        <executions>
          <execution>
            <id>make-assembly</id>
            <phase>package</phase>
            <goals>
              <goal>single</goal>
            </goals>
          </execution>
        </executions>
      </plugin>
    </plugins>
    <resources>
      <resource>
        <directory>src/main/resources</directory>
        <filtering>true</filtering>
        <excludes>
          <exclude>persistent.properties</exclude>
        </excludes>
      </resource>
    </resources>
  </build>
</project>
{% endhighlight %}

### add Java Spark code

直接从下载的Spark文件中找到examples文件夹，这里列举了许多例子，我们以JavaSparkPi.java为例。

```java
/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//package org.apache.spark.examples;
package com.nsfocus;

import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.api.java.function.Function;
import org.apache.spark.api.java.function.Function2;
import org.apache.spark.sql.SparkSession;

import java.util.ArrayList;
import java.util.List;

/**
 * Computes an approximation to pi
 * Usage: JavaSparkPi [slices]
 */
public final class JavaSparkPi {

  public static void main(String[] args) throws Exception {
    SparkSession spark = SparkSession
      .builder()
      .master("local")
      .appName("JavaSparkPi")
      .getOrCreate();

    JavaSparkContext jsc = new JavaSparkContext(spark.sparkContext());

    int slices = (args.length == 1) ? Integer.parseInt(args[0]) : 2;
    int n = 100000 * slices;
    List<Integer> l = new ArrayList<Integer>(n);
    for (int i = 0; i < n; i++) {
      l.add(i);
    }

    JavaRDD<Integer> dataSet = jsc.parallelize(l, slices);

    int count = dataSet.map(new Function<Integer, Integer>() {
      @Override
      public Integer call(Integer integer) {
        double x = Math.random() * 2 - 1;
        double y = Math.random() * 2 - 1;
        return (x * x + y * y < 1) ? 1 : 0;
      }
    }).reduce(new Function2<Integer, Integer, Integer>() {
      @Override
      public Integer call(Integer integer, Integer integer2) {
        return integer + integer2;
      }
    });

    System.out.println("Pi is roughly " + 4.0 * count / n);

    spark.stop();
  }
}
```

在文件需要根据自己的包名来修改，来满足自己定义的包,以及`指定master的选项`

**compile java code package and  run**

> mvn compile

```C
.
├── pom.xml
├── src
│   ├── main
│   │   └── java
│   │       └── com
│   │           └── nsfocus
│   │               ├── App.java
│   │               └── JavaSparkPi.java
│   └── test
│       └── java
│           └── com
│               └── nsfocus
│                   └── AppTest.java
└── target
    ├── classes
    │   └── com
    │       └── nsfocus
    │           ├── App.class
    │           ├── JavaSparkPi$1.class
    │           ├── JavaSparkPi$2.class
    │           └── JavaSparkPi.class
    └── maven-status
        └── maven-compiler-plugin
            └── compile
                └── default-compile
                    ├── createdFiles.lst
                    └── inputFiles.lst

17 directories, 10 files
```

> mvn package

```C
.
├── pom.xml
├── src
│   ├── main
│   │   └── java
│   │       └── com
│   │           └── nsfocus
│   │               ├── App.java
│   │               └── JavaSparkPi.java
│   └── test
│       └── java
│           └── com
│               └── nsfocus
│                   └── AppTest.java
└── target
    ├── archive-tmp
    ├── classes
    │   └── com
    │       └── nsfocus
    │           ├── App.class
    │           ├── JavaSparkPi$1.class
    │           ├── JavaSparkPi$2.class
    │           └── JavaSparkPi.class
    ├── maven-archiver
    │   └── pom.properties
    ├── maven-status
    │   └── maven-compiler-plugin
    │       ├── compile
    │       │   └── default-compile
    │       │       ├── createdFiles.lst
    │       │       └── inputFiles.lst
    │       └── testCompile
    │           └── default-testCompile
    │               ├── createdFiles.lst
    │               └── inputFiles.lst
    ├── Myspark-1.0-SNAPSHOT.jar
    ├── Myspark-1.0-SNAPSHOT-jar-with-dependencies.jar
    ├── surefire-reports
    │   ├── com.nsfocus.AppTest.txt
    │   └── TEST-com.nsfocus.AppTest.xml
    └── test-classes
        └── com
            └── nsfocus
                └── AppTest.class

25 directories, 18 files
```
> java run jar

```C
java -cp "target/myspark-1.0-SNAPSHOT.jar:${$SPARK_HOME}jars/*"  com.nsfocus.JavaSparkPi	## zsh
````
SPARK_HOME，就是配置Spark的目录，可以通过env来查看。

result:
```C
Pi is roughly 3.14508
```
最后通过`mvn clean`来清空。

### add Scala Spark code

Scala code 我们也以SparkPi.scala为例。
```scala
/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// scalastyle:off println
package com.nsfocus

import scala.math.random

import org.apache.spark.sql.SparkSession

/** Computes an approximation to pi */
object SparkPi {
  def main(args: Array[String]) {
    val spark = SparkSession
      .builder
      .master("local")
      .appName("Spark Pi")
      .getOrCreate()
    val slices = if (args.length > 0) args(0).toInt else 2
    val n = math.min(100000L * slices, Int.MaxValue).toInt // avoid overflow
    val count = spark.sparkContext.parallelize(1 until n, slices).map { i =>
      val x = random * 2 - 1
      val y = random * 2 - 1
      if (x*x + y*y < 1) 1 else 0
    }.reduce(_ + _)
    println("Pi is roughly " + 4.0 * count / (n - 1))
    spark.stop()
  }
}
// scalastyle:on println
```

在文件需要根据自己的包名来修改，来满足自己定义的包

__compile package and  run__

用scalac 来`compile`

> mkdir -p target/classes
> scalac -d target/classes -classpath "target/classes:${SPARK_HOME}/jars/*" src/main/java/com/nsfocus/SparkPi.scala

-d:class文件存放目录

-classpath:指定类的路径，因为可以配目录和jar包

tree -> result:
```C
.
├── pom.xml
├── src
│   ├── main
│   │   └── java
│   │       └── com
│   │           └── nsfocus
│   │               ├── App.java
│   │               ├── JavaSparkPi.java
│   │               └── SparkPi.scala
│   └── test
│       └── java
│           └── com
│               └── nsfocus
│                   └── AppTest.java
└── target
    └── classes
        └── com
            └── nsfocus
                ├── SparkPi$$anonfun$1.class
                ├── SparkPi$$anonfun$2.class
                ├── SparkPi.class
                └── SparkPi$.class

13 directories, 9 files
```
用java来执行.class

> java -classpath "target/classes:${SPARK_HOME}/jars/*" com.nsfocus.SparkPi

result:
```C
Pi is roughly 3.1422157110785554
```

## mvn 创建Java项目和Scala项目

### mvn 创建Java项目

```C
mvn archetype:generate \
-DarchetypeGroupId=org.apache.maven.archetypes \
-DgroupId=com.nsfocus \
-DartifactId=Myspark \
-Dfilter=org.apache.maven.archetypes:maven-archetype-quick
```
mvn 参数

<table>
<tr><td>compile</td><td>package</td>	<td>run</td><td>clean</td></tr>
<tr><td>mvn compile</td><td>mvn package</td><td>mvn exec:java -Dexec.mainClass="packageName.className"</td><td>mvn clean</td></tr>
</table>

### mvn 创建Scala项目

```C
mvn archetype:generate \
-DarchetypeGroupId=org.scala-tools.archetypes \
-DarchetypeArtifactId=scala-archetype-simple \
-DarchetypeVersion=1.3  \
-DremoteRepositories=http://scala-tools.org/repo-releases \
-DgroupId=com.nsfocus -DartifactId=Myspark
```

可以使用[\[scala-maven-plugin\]](https://davidb.github.io/scala-maven-plugin/usage.html)

modify xml file add as follow code

{% highlight xml linenos %}
<plugin>
	<groupId>net.alchim31.maven</groupId>
	<artifactId>scala-maven-plugin</artifactId>
	<version>3.2.1</version>
	<executions>
 	 <execution>
	   <goals>
		<goal>compile</goal>
		<goal>testCompile</goal>
	   </goals>
	</execution>
	</executions>
	<configuration>
		<scalaVersion>${scala.version}</scalaVersion>
	</configuration>
</plugin>
{% endhighlight %}

完整的xml文件如下所示:

Displayint scala help and version

{% highlight xml linenos %}
<?xml version="1.0"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.nsfocus</groupId>
  <artifactId>Myspark</artifactId>
  <version>1.0-SNAPSHOT</version>
  <name>${project.artifactId}</name>
  <properties>
    <encoding>UTF-8</encoding>
    <scala.version>2.11.8</scala.version>
  </properties>
  <dependencies>
    <dependency>
      <groupId>org.scala-lang</groupId>
      <artifactId>scala-library</artifactId>
      <version>${scala.version}</version>
    </dependency>
    <!-- Test -->
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.8.1</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
  <build>
    <sourceDirectory>src/main/scala</sourceDirectory>
    <testSourceDirectory>src/test/scala</testSourceDirectory>
    <plugins>
      <plugin>
        <groupId>net.alchim31.maven</groupId>
        <artifactId>scala-maven-plugin</artifactId>
        <version>3.2.1</version>
        <executions>
          <execution>
            <goals>
              <goal>compile</goal>
              <goal>testCompile</goal>
            </goals>
          </execution>
        </executions>
        <configuration>
          <scalaVersion>${scala.version}</scalaVersion>
        </configuration>
      </plugin>
    </plugins>
  </build>
</project>
{% endhighlight %}

```C
mvn scala:help
```

<table>
<tr><td>compile</td><td>package</td>	<td>run</td><td>clean</td></tr>
<tr><td>mvn scala:compile</td><td>mvn package</td><td>mvn exec:java -Dexec.mainClass="packageName.className"</td><td>mvn clean</td></tr>
</table>

如果程序运行`需要参数`:

```C
mvn exec:java -Dexec.mainClass="packageName.ClassName" -Dexec.args="arg0 arg1 arg2"
```

Displayint the command line used

```C
mvn scala:compile -DdisplayCmd=true
```

对于scala-mvn想关注更多[\[click here\]](https://davidb.github.io/scala-maven-plugin/usage.html)


## mvn创建Java和Scala，Spark混合项目

其实如果上面的步骤你都操作了，下面的步骤就很简单了.我这主要是通过mvn创建出Java项目，然后再添加scala的项目文件。

1.mvn 创建Java项目
```C
mvn archetype:generate \
-DarchetypeGroupId=org.apache.maven.archetypes \
-DgroupId=com.nsfocus \
-DartifactId=Myspark \
-Dfilter=org.apache.maven.archetypes:maven-archetype-quick
```
查看目录tree

```C
.
├── pom.xml
└── src
    ├── main
    │   └── java
    │       └── com
    │           └── nsfocus
    │               └── App.java
    └── test
        └── java
            └── com
                └── nsfocus
                    └── AppTest.java

9 directories, 3 files
```
2.添加Scala目录

再次查看目录tree
```C
.
├── pom.xml
└── src
    ├── main
    │   ├── java
    │   │   └── com
    │   │       └── nsfocus
    │   │           └── App.java
    │   └── scala
    │       └── com
    │           └── nsfocus
    └── test
        ├── java
        │   └── com
        │       └── nsfocus
        │           └── AppTest.java
        └── scala
            └── com
                └── nsfocus

15 directories, 3 files

```
从Spark中的examples找一个例子，添加到scala目录下,并且根据包名修改文件中的包名,以SparkPi.scala为例

最后的文件结构
```C
.
├── pom.xml
└── src
    ├── main
    │   ├── java
    │   │   └── com
    │   │       └── nsfocus
    │   │           └── App.java
    │   └── scala
    │       └── com
    │           └── nsfocus
    │               └── SparkPi.scala
    └── test
        ├── java
        │   └── com
        │       └── nsfocus
        │           └── AppTest.java
        └── scala
            └── com
                └── nsfocus

15 directories, 4 files

```

4.添加Scala,Spark依赖项，`mvn-scala-compile,scala-library,Spark`等依赖，pom.xml如下:

{% highlight xml linenos %}

<?xml version="1.0"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.nsfocus</groupId>
  <artifactId>Myspark</artifactId>
  <version>1.0-SNAPSHOT</version>
  <packaging>jar</packaging>
  <name>Myspark</name>
  <url>http://maven.apache.org</url>
  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <scala.version>2.11.8</scala.version>
    <spark.version>2.0.0</spark.version>
  </properties>
  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>3.8.1</version>
      <scope>test</scope>
    </dependency>
    <dependency>
      <groupId>org.apache.spark</groupId>
      <artifactId>spark-core_2.11</artifactId>
      <version>${spark.version}</version>
    </dependency>
    <dependency>
      <groupId>org.apache.spark</groupId>
      <artifactId>spark-streaming_2.11</artifactId>
      <version>${spark.version}</version>
    </dependency>
    <!--<dependency>-->
    <!--<groupId>org.apache.spark</groupId>-->
    <!--<artifactId>spark-streaming-kafka_2.11</artifactId>-->
    <!--<version>${spark.version}</version>-->
    <!--</dependency>-->
    <dependency>
      <groupId>org.apache.spark</groupId>
      <artifactId>spark-sql_2.11</artifactId>
      <version>${spark.version}</version>
    </dependency>
    <dependency>
      <groupId>org.apache.spark</groupId>
      <artifactId>spark-hive_2.11</artifactId>
      <version>${spark.version}</version>
    </dependency>
    <dependency>
      <groupId>org.scala-lang</groupId>
      <artifactId>scala-library</artifactId>
      <version>${scala.version}</version>
    </dependency>
    <dependency>
      <groupId>org.scala-lang</groupId>
      <artifactId>scala-compiler</artifactId>
      <version>${scala.version}</version>
    </dependency>
    <dependency>
      <groupId>org.scala-lang</groupId>
      <artifactId>scala-reflect</artifactId>
      <version>${scala.version}</version>
    </dependency>
    <dependency>
      <groupId>org.scala-lang</groupId>
      <artifactId>scala-actors</artifactId>
      <version>${scala.version}</version>
    </dependency>
    <dependency>
      <groupId>org.scala-tools</groupId>
      <artifactId>maven-scala-plugin</artifactId>
      <version>2.15.2</version>
    </dependency>
  </dependencies>
  <build>
    <plugins>
      <plugin>
        <groupId>net.alchim31.maven</groupId>
        <artifactId>scala-maven-plugin</artifactId>
        <version>3.2.1</version>
        <executions>
          <execution>
            <goals>
              <goal>compile</goal>
              <goal>testCompile</goal>
            </goals>
          </execution>
        </executions>
        <configuration>
          <scalaVersion>${scala.version}</scalaVersion>
        </configuration>
      </plugin>
    </plugins>
  </build>
</project>

{% endhighlight %}

SparkPi.scala

```scala
package com.nsfocus

import scala.math.random

import org.apache.spark.sql.SparkSession

/** Computes an approximation to pi */
object SparkPi {
  def main(args: Array[String]) {
    var beg = System.currentTimeMillis()
    val spark = SparkSession
      .builder()
      .master("local[2]")
      .appName("Spark Pi")
      .getOrCreate()
    val slices = if (args.length > 0) args(0).toInt else 2
    val n = math.min(100000L * slices, Int.MaxValue).toInt // avoid overflow
    val count = spark.sparkContext.parallelize(1 until n, slices).map { i =>
      val x = random * 2 - 1
      val y = random * 2 - 1
      if (x*x + y*y < 1) 1 else 0
    }.reduce(_ + _)
    var end = System.currentTimeMillis()
    println("Pi is roughly " + 4.0 * count / (n - 1) + " use time " +  (end - beg) + " ms ")

    spark.stop()
  }
}

```

5.运行Java和Scala的Spark代码

JavaSParkPi.java

```java
package com.nsfocus;

import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.api.java.function.Function;
import org.apache.spark.api.java.function.Function2;
import org.apache.spark.sql.SparkSession;

import java.util.ArrayList;
import java.util.List;

/**
 * Computes an approximation to pi
 * Usage: JavaSparkPi [slices]
 */
public final class JavaSparkPi {

  public static void main(String[] args) throws Exception {
    long beg = System.currentTimeMillis();
    SparkSession spark = SparkSession
      .builder()
      .master("local[2]")
      .appName("JavaSparkPi")
      .getOrCreate();

    JavaSparkContext jsc = new JavaSparkContext(spark.sparkContext());

    int slices = (args.length == 1) ? Integer.parseInt(args[0]) : 2;
    int n = 100000 * slices;
    List<Integer> l = new ArrayList<Integer>(n);
    for (int i = 0; i < n; i++) {
      l.add(i);
    }

    JavaRDD<Integer> dataSet = jsc.parallelize(l, slices);

    int count = dataSet.map(new Function<Integer, Integer>() {
      @Override
      public Integer call(Integer integer) {
        double x = Math.random() * 2 - 1;
        double y = Math.random() * 2 - 1;
        return (x * x + y * y < 1) ? 1 : 0;
      }
    }).reduce(new Function2<Integer, Integer, Integer>() {
      @Override
      public Integer call(Integer integer, Integer integer2) {
        return integer + integer2;
      }
    });

    long end = System.currentTimeMillis();
    System.out.println("javaSparkPi is roughly " + 4.0 * count / n + " use time " + (end -beg) + " ms");

    spark.stop();
  }
}

```
 > Java
 ```C
 mvn compile
 mvn exec:java -Dexec.mainClass="com.nsfocus.JavaSparkPi"
 ```

ScalaPi.java

```scala
package com.nsfocus

import scala.math.random

import org.apache.spark.sql.SparkSession

/** Computes an approximation to pi */
object SparkPi {
  def main(args: Array[String]) {
    var beg = System.currentTimeMillis()
    val spark = SparkSession
      .builder()
      .master("local[2]")
      .appName("Spark Pi")
      .getOrCreate()
    val slices = if (args.length > 0) args(0).toInt else 2
    val n = math.min(100000L * slices, Int.MaxValue).toInt // avoid overflow
    val count = spark.sparkContext.parallelize(1 until n, slices).map { i =>
      val x = random * 2 - 1
      val y = random * 2 - 1
      if (x*x + y*y < 1) 1 else 0
    }.reduce(_ + _)
    var end = System.currentTimeMillis()
    println("ScalaPi is roughly " + 4.0 * count / (n - 1) + " use time " +  (end - beg) + " ms ")

    spark.stop()
  }
}
// scalastyle:on println

```

 > Scala
 ```C
 mvn scala:compile
 mvn exec:java -Dexec.mainClass="com.nsfocus.SparkPi"
 ```

 如果觉得不是很方便，就把这个项目导入到IDEA中，就可以了。继续努力!!!,前方还有无数的坑，等着我呢。
