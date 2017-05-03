---
layout: post
category : Scala
tagline: "Supporting tagline"
tags:
  -
title: 'Scala Java性能比较'
---
对于Scala,Java这两种语言，都是在JVM上的运行的。我们需要考察一下，他们的性能如何,便于以后分析。

---

<!--more-->

## Spark程序

通过一个Spark程序来说明,读取一个文本(很大的数据)。

**Scala version**

```scala

import org.apache.spark.{SparkConf, SparkContext}

object yb {
  def main(args: Array[String]): Unit={
    val startTime=System.currentTimeMillis()//获取开始时间
    val conf=new SparkConf().setAppName("Test").setMaster("local[4]")
    val sc = new SparkContext(conf)
    val lines = sc.textFile("E:/Spark/xyz/data_format1/100W.txt")
    /*
    sortByKey参数有二个。1、true（升序），否则反之。2、标识分片数（分区数）
    flatMap相当于获取一个朋友对象的列表。
     */
    val worldcounts=lines.flatMap(line => line.split("\t")).map(word => (word,1)).reduceByKey((a,b) => a+b).map{case (key,value)=>(value,key)}.sortByKey(false,1)
    /*val topK=worldcounts.top(10)
    topK.foreach(println)*/
    worldcounts.foreach(println)
    val endTime=System.currentTimeMillis() //获取结束时间
    println("Scala程序运行时间： "+(endTime-startTime)+"ms")
  }
}

```


**Java version**

```java

import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaPairRDD;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.api.java.function.FlatMapFunction;
import org.apache.spark.api.java.function.Function2;
import org.apache.spark.api.java.function.PairFunction;
import scala.Tuple2;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/**
 * Created by Administrator on 2015/12/11.
 */
public class JavaWordCount {
    public static void main(String[] args) {
        long startTime=System.currentTimeMillis();//获取开始时间

        SparkConf conf=new SparkConf().setAppName("JavaWordCount").setMaster("local[8]");
        JavaSparkContext sc=new JavaSparkContext(conf);
        JavaRDD<String>  dataline=sc.textFile("E:/Spark/xyz/data_format1/100w.txt");
        JavaRDD<String> words=dataline.flatMap(new FlatMapFunction<String, String>() {
            @Override//重写方法
            public Iterable<String> call(String s) {
                return Arrays.asList(s.split(" "));
            }
        });
        JavaPairRDD<String,Integer> pair=words.mapToPair(new PairFunction<String, String, Integer>() {
            @Override
            public Tuple2<String, Integer> call(String s) {
                return new Tuple2<String, Integer>(s, 1);
            }
        });
        JavaPairRDD<String,Integer> counts=pair.reduceByKey(new Function2<Integer, Integer, Integer>() {
            @Override
            public Integer call(Integer a, Integer b) {
                return a + b;
            }
        });
        List<Tuple2<String,Integer>> ouput=counts.collect();
        Collections.sort(ouput, new Comparator<Tuple2<String,Integer>>() {
            @Override
            public int compare(Tuple2<String, Integer> o1, Tuple2<String, Integer> o2) {
                if(o1._2 < o2._2)
                return 1;
                else if(o1._2 > o2._2){
                       return -1;
                }else{
                    return 0;
                }
            }
        });
        for(Tuple2 tuple:ouput){
            System.out.println(tuple._1 + ": " + tuple._2);
        }

        long endTime=System.currentTimeMillis(); //获取结束时间
        System.out.println("Java程序运行时间： "+(endTime-startTime)+"ms");
       /* File fp=new File("E:/Spark/xyz/data_format1/out.txt");//这里是将结果保存到Txt中，也可以不要，在控制台输出。
        PrintWriter pfp = null;
        try {
            pfp = new PrintWriter(fp);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        for(Tuple2 tuple:ouput){
           pfp.println(tuple._1 + ": " + tuple._2);
        }*/
    }
}

```

`比较Java，Scala有下列优势:`

 + FP 泛型支持:如果用多了 Spring 中大量的 template 接口, 你就会觉得 FP 其实还是蛮好用的.而这仅仅是 FP 好处的冰山一角.函数其实就是一个 input -> output (scala 也是这么表示一个函数的), 没有任何副作用, 与状态无关, 由于这种特性, 所以函数式的编程范式在分布式领域有很多好处,对于函数式编程,我的知识实在是皮毛, 但可以这么说, FP 相对与 OO 有哪些优势, Scala 对于 Java 差不多就有哪些优势.正因为 FP 有如此多的优势, 所以 Java8 才引入了 FP. 从某种程度上来说, Java 认可了 Scala 的做法.
 + 类型系统支持:如果说 Java 是一种类型安全的语言, 那么毫无疑问, Scala 的类型更加安全, 从某种程度上说, Scala 的类型是图灵完备的, 而 Java 不是. 我的一位好朋友在这方面研究的比较深( http://hongjiang.info/scala/  ), 而我对与 Scala 的类型系统的理解, 也还是皮毛.

 正是以上这两点大优势, 造成了 Scala 比 Java 更加安全, 同时又具备灵活性, 想象力.

 + 其他语言层面上的优势

 在 Java 中, 你是否有时很想继承多个 AbstractClass 呢? 对不起, Java 只支持单继承

 在 Scala 中, 你可以进行 mixin (Java 8 也开始引入 default method 了呢)

 在 Java 中, 想要一个 singleton ? 要么在 static block 中做, 要么利用 Enum 的单例特性完成, 或者其他更纠结的方法.

 在 Scala 中, 只要声明为 object, 即为单例.

 在 Java 中, 想要延迟加载一个单例? double check吧

 在 Scala 中, 只要在 object 中将变量修饰为 lazy 即可

 在 Java 中, 想要对集合进行一些操作? 使用一层一层的 for 循环吧

 在 Scala 中, 使用 collection 的一些集合操作, 即可获得如写SQL般的享受.

 在 Java 中, 在并发中想对Future进行回调? 对不起, Future 不是 Listenable (无法支持回调), 除非你使用额外的工具(如 guava, spring)

 在 Scala 中, 本来就主张异步编程, future 和 promise 的配合让人非常愉快.

 在 Java 中, 要透明扩展一个第三方库的类怎么办? 包装, 再加一层. 在 Scala 中, 有强大的 implicit 机制让你更优雅的做到这一点, 同时还能保证类型安全(比起 Ruby 的 monkey patch, 要安全得多)

 Scala 的表达力很强, 相同功能的代码, 用 Java 和 Scala 的行数不可同日而语.

 + Scala 的表达力很强, 相同功能的代码, 用 Java 和 Scala 的行数不可同日而语.

 这些单单是语言层面上的优势, 除此之外, Scala 还能无缝结合 Java

 Scala 与 Java `语法上的明显差异`有：

  + 不需要分号结尾
  + 不类型定义开头需大写（与 Haskell 相同）
  + 不函数定义需 def 开头（与 Python、Ruby 相同）
  + return 可以省略
  + Actor并发模型,并发编程上写起来很顺手
  + 语言更灵活，不过语法更复杂
  + 开发效率更高，代码更精简
  + OO+FP
