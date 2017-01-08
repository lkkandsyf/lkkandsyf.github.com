---
layout: post
category : Scala
tagline: "Supporting tagline"
tags : [scala sbt]
---
{% include JB/setup %}

# Overview
{:.no_toc}
这里整理自己学习scala的整个过程，以及笔记。

* dir
{:toc}

## tools

[sbt](https://lkkandsyf.github.io/scala/2016/11/05/sbt-debug)

learn twitter scala course

[effective scala](http://twitter.github.io/effectivescala/index-cn.html)
[scala course](http://twitter.github.io/scala_school/zh_cn/index.html)

cnblog
[blog](http://hongqiang.info/scala)：这收集了许多比较全面的关于scala东西。[learn file](http://www.cnblogs.com/youarebest/p/5593349.html)

### 基础

#### 1.变量
	val 标志符：声明变量；如，val result = 1
	var 标志符：声明变量；

 + 类型推断：变量的类型由scala根据初始化变量的表达式推断出来，`鼓励使用val`；**note:声明变量时不做初始化会报错**
 + 明确类型：scala的`变量或函数的类型总是写在变量或函数的后面`.

```scala
val a:Int = 1
val str:String = "hello world"
```

#### 2.常用的类型

Scala支持`7中数值类型和1中Boolean类型`

	 Byte/Char/Short/Int/Float/Double
	 Boolean

<font color="red">note:</font>`所有这些类型都是类`，Scala并`未区分基本类型和引用类型`。如，可以调用123.toString方法。

#### 3.数值类型转换

Scala中使用方法，而`非强制类型转换`来做`数值类型之间的转换`，如：

	scala> 123.123.toInt
	res6: Int = 123
	scala> 123.123.toChar
	res7: Char = {
	scala> 123.123.toLong
	res8: Long = 123
	scala> "123.123".toDouble
	res9: Double = 123.123

#### 4.操作符

Scala支持Java绝大多数操作符，不过`所有的操作符都是方法`，如：a+b是a+(b)的缩写。即：a方法b是a.方法(b)的缩写，两种写法`可以互换`。

<font color="red">note:</font> Scala`不支持++和--操作符`。

#### 5.函数调用和方法

常用的数学函数包括在scala.math包中。

	import scala.math._			// Scala中，字符_是通配符，类似Java的*

另外，以scala开头的包，在引入或者使用时可以`省略scala`

	import math._
	math.sqrt(2)

<font color="red">note:</font> Scala`没有静态方法`。

`不带参数的方法在调用时可以省略括号`，如：在调用toStrig后面的括号是可以省略的。

	"Helloworld".toString

#### 6.apply方法

在Scala中通常使用类似函数调用的形式来访问数组、链表等的元素。

	scala>"helloworld"(0)
	res0:Char = h

上述调用中，"helloworld"(0)是"helloworld".apply(0)的调用，其中apply方法是StringOps类中的方法。

## 控制结构和函数

#### 1.if语句也有返回值

if语句成为`条件表达式`

	scala>val x = 1
	x :Int = 1
	scala>val y = if(x > 1) 1 else -1
	y : Int = 1

条件表达式的结构：`if（判断条件） 值1 else 值2`；类似于Java中`三目运算符`，但是，`Scala不支持三目运算符`，该条件表达式`可以用来初始化val常量`.

<font color="red">note:</font> Scala`中每个表达式都会有返回值`。

	scala>if (x > 4) 1
	res0 AnyVal =()

表达式返回了(),其中()表示Uint类，表示没有值，可以看做Java中`void类型`。

### 2.块表达式
块表达式：Scala中用{}括起来一系列表达式，其中{}括起来的部分`叫做块表达式`，块表达式的值是`块中最后一个表达式的值`

	scala>{
		1+2
		2+3
	}
	res1 Int = 5

可以使用块表达式为变量赋值

	scala>val x = 1;val x0 = 0;val y = 1;val y0= 0
	x:Int = 1
	x0:Int = 0
	y:Int = 1
	y0:Int = 0

	scala>val distance = {val dx = x - x0
		val dy = y - y0
		math.sqrt(dx*dx+dy*dy)
	}
	distance:Double = 1.41421

变量distance使用块表达式来赋值，其值为块中最后一个表达式的值

<font color="red">note:</font> Scala中赋值语句的`返回值为Uint`，也可记做：Scala中赋值语句是没有返回值的。

	scala> val a = 1
	a: Int = 1

	scala> val b = 2
	b: Int = 2

	scala> a = b =4
	<console>:13: error: reassignment to val
		a = b =4

a = b = 4；这种赋值形式在Scala中`不支持`，因为在赋值语句中Scala中`无返回值`，所以`+=，-=，*=,/=等赋值操作符都是无返回值`的.

#### 3.IO

 + 输入:常用的包括readline从控制台`读取一行输入`，另外，readLine还可以`带有字符串提示`

	scala> val name = readLine("input your name:")
	inpput your name:

readInt,readByte,readDouble,readShort,readLong,readFloat,readBoolean,readChar分别用于读取各自类型的值。
 + 输出:print(content),println(content),printf();其中println带换行，printf支持C风格的字符串输出。
#### 4.Loop
Scala支持Java相同的while和do循环

	scala>var x = 2
	x:Int = 2
	scala>while(x > 0){		// 这里必须写x>0 写成一个独立的x，程序会报错布尔和整形的区别
		println(x)
		x -= 1
	}
	2
	1
	scala> do{
		println(x)
		x -= 1
	}while(x > 0)
	0

#### 5.for
Scala的for循环结构:（for循环中，变量前面`不带var或val标志符`）

	for(变量 <- 表达式){	// 让变量遍历表达式的所有的值
		// operations
	}

如：

	scala> for(i <- 0 to 3)
	     | println(i)
	     0
	     1
	     2
	     3

     scala> val str = "hello world"
     str: String = hello world
     scala> for(c <- str)
          | println(c)
          h
          e
          l
          l
          o
          w
          o
          r
          l
          d

	scala> for(i <- 0 until str.length)
	     | println(str(i))
	     h
	     e
	     l
	     l
	     o

	     w
	     o
	     r
		 l
		 d

`for的高级用法`

__可以在for loop括号里面同事包含`多组"变量<- 表达式"结构`，组之间用`分号`隔开__

```scala
	for(i <- 1 until 3; j <- until 3){
		println(i*j)
	}
	//for loop的这种结构类似Java中嵌套环结构,也可以用

	for{i <- 1 until 3		// 使用大括号，使用换行来分割组
		j <- until 3 }{
			println(i*j)
	}
```

__可以为嵌套循环通过if表达式添加条件__

	 scala> for (i <- -1 until 3; j <- -1 until 3 if i != j) {
	 	     | printf("i = %d,j = %d\n",i,j)
	 	     |
			 }
	 i = -1,j = 0
	 i = -1,j = 1
	 i = -1,j = 2
	 i = 0,j = -1
	 i = 0,j = 1
	 i = 0,j = 2
	 i = 1,j = -1
	 i = 1,j = 0
	 i = 1,j = 2
	 i = 2,j = -1
	 i = 2,j = 0
	 i = 2,j = 1

	 scala> for (i <- -1 until 3; j <- -1 until 3 if i != j) {
	 	     | printf("i = %d,j = %d\n",i,j)
	 	     |
			}
	 i = -1,j = 0
	 i = -1,j = 1
	 i = -1,j = 2
	 i = 0,j = -1
	 i = 0,j = 1
	 i = 0,j = 2
	 i = 1,j = -1
	 i = 1,j = 0
	 i = 1,j = 2
	 i = 2,j = -1
	 i = 2,j = 0
	 i = 2,j = 1

	 scala> for (i <- -1 to 3; j <- -1 to 3 if i != j) {
	 	     | printf("i = %d,j = %d\n",i,j)
	         |
		 }
	 i = -1,j = 0
	 i = -1,j = 1
	 i = -1,j = 2
	 i = -1,j = 3
	 i = 0,j = -1
	 i = 0,j = 1
	 i = 0,j = 2
	 i = 0,j = 3
	 i = 1,j = -1
	 i = 1,j = 0
	 i = 1,j = 2
	 i = 1,j = 3
	 i = 2,j = -1
	 i = 2,j = 0
	 i = 2,j = 1
	 i = 2,j = 3
	 i = 3,j = -1
	 i = 3,j = 0
	 i = 3,j = 1
	 i = 3,j = 2

`if表达式是否添加括号`，结果无变化

until返回一个不包含上界的区间1 until 返回(1,2),to方法返回一个包含上界的区间 1 to 3返回(1,2,3)

__for 推导式__

如果for loop以yield开始，for loop会构造一个`集合`，保存到集合中。

	scala> for(i <- 1 to 3; j <- 1 to 3 if(i != j)) yield i*10+j
	res6: scala.collection.immutable.IndexedSeq[Int] = Vector(12, 13, 21, 23, 31, 32)

	scala> for(c <- "hello") yield(c.toInt - 32).toChar
	res7: String = HELLO

#### 6.函数式编程

	def 函数名(参数1:类型1，参数2::类型，...);返回值类型 = {
		// 函数体
	}

	scala>def isNeg(x:Int) = if(x>0) true else false
	isNeg:(x:Int)Boolean
	scala>isNeg(8)
	res3 Boolean = ture
	scala>isNeg(-1)
	res4 Boolean = false
	scala>def f(x:Int):Int = if(n==0 || n==1) 1 else f(n-1)*n
	f:(n:Int)Int

<font color="red">note:</font> 对于有`返回值的函数`，不能`省略等号`；对于递归函数，不能`省略函数返回类型`。

	scala>def noReturnVal(name:String){
		!	println("hello world")
		!	}
	noReturnVal:(name:Strint)Uint

<font color="red">note:</font> `无返回值的函数定义`可以`省略等号`；无返回值的函数返回类型是`Uint`.

	scala>def format(content:String,start:String="<<",end:String=">>") =
		!	start + content + end
	format:(content:String,start:String="<<",end:String=">>")String

带`默认函数的声明`，与`Java中默认值的方法很类似`.

带名参数-----在函数调用时通过`明确指明参数与其对应值`.

	scala>format("lkk")
	res5:String = <<lkk>>
	scala>format(start="%%",end="$$",content="lkk")
	res6:String = %%lkk$$

第一个函数调用为`普通调用`，第二个函数调用为`带参数调用`。

长度可变的参数列表，通过在函数的形参列表最后一个参数的类型后，添加**星号**，来定义一个接受任意多个参数的函数。

	scala>def Two(owner:String,guests:String*){
		for(guest <- guests){
			println(owner + " lkk welcome to learn scala" + guest)
		}
	}
	Two:(owner:String,guests:String*)Uint

	scala>Two("AAA","BBB","CCC")
	AAA lkk welcome to learn scala  BBB
	AAA lkk welcome to learn scala  CCC

如上面的Two函数，没有`返回值`的函数叫做过程，`过程在定义的时候，参数列表之后无等号`。

#### 7.懒值

当val被声明为`lazy`时,变量的初始化将被`延迟`，直到我们`首次对变量取值`

	lazy val fileContent = scala.io.Source.fromFile("filename").mkString

只有当我们读取`fileContent`值的时候，fileContent才会通过读取文件来进行初始化。若我们一直未`读取fileContent的值`，这个文件不会被读取。

<font color="red">note:</font>
 + Scala`不支持switch`语句，但是Scala有`强大的模式匹配机制`。
 + Scala`不支持break语句和continue`语句。
 + Scala`不支持break语句和continue`语句。
 + Scala`没有受检异常-----无需声明函数或方法可能会跑出某种异常`。
 + Scala`中将没有返回值的函数`，叫做过程,过程在定义的时候，`参数列表之后无等号`。


## 疑惑
 + 方法的定义体出现的等号(=)之后，为什么使用=？,而不像Java那样，使用的是{}来表示方法体呢？
 scala使用[]来表示参数类型，Java用的是<>,并且不允许在标识符中使用[].
 A:1)避免歧义是原因之一，当你在代码中省略`分号`时，Scala能够推断出来。在大多数的时候，Scala能够推导出方法的返回类型。假设方法不接受任何参数，你还可以在方法定义中省略参数列表。

  2)使用=也强调了函数式编程的一个准则：值和函数是高度对齐的概念。函数可以作为参数传递给其他函数，也能够返回函数，还能够赋给某一个变量，这与对象的行为是一致的。

  最后说一下，假设方法体中`仅包含一个表达式`，那么Scala允许你省略花括号，所以说，使用=能够避免可能的解析歧义。

#### 7.match

	scala>def level(s:Int) = s match{
		case n if n >= 90 => "good"
		case n if n >= 80 => "good2"
		case n if n >= 70 => "good3"
		case n if n >= 60 => "good3"
		case _ => "bad"
	}
	scala> levle(51)
	res2:String = bad

	scala> levle(91)
	res2:String = good

	scala> levle(81)
	res2:String = good2

可以看到，模式匹配可以使用swith相同的功能。但是switch需要使用break明确通知终止之后的判断不同，scala中match case是`默认break`的,只要其中一个case语句匹配，就会终止后的所有比较。且对应的case语句的表达式的值将作为整个match case表达式的值返回。

Scala中的模式匹配还有类型匹配，数据抽取，谓词判断等其它有用的功能。

### 数组-映射-元组-类-对象

#### 1.数组

**定长数组**

声明数组的两种形式

1)__声明`指定长度`的数组val 数组名 = new Array[类型](数组长度)__

	scala> val arr = new Array[String](5)
	arr: Array[String] = Array(null, null, null, null, null)

	scala> val intArr = new Array[Int](4)
	intArr: Array[Int] = Array(0, 0, 0, 0)

2)提供数组`初始值`的数组，`无需new`关键字

	scala> val charArr = Array('a','b','c')
	charArr: Array[Char] = Array(a, b, c)

Scala声明数组时，需要`带有Array`类名，且使用()来`指明长度`或`提供初始值序列`.在JVM中，Scala的Array以Java数组的方式实现。如arr在JVM的类型对应java.lng.String[],charArr对应char[].

**变长数组**

	scala>import scala.collection.mutable.ArrayBuffer

	scala> val b = ArrayBuffer[Int]()
	b: scala.collection.mutable.ArrayBuffer[Int] = ArrayBuffer()

	scala>  b += 1
	res1: b.type = ArrayBuffer(1)

	scala> b += (1,2,3,4,5)
	res2: b.type = ArrayBuffer(1, 1, 2, 3, 4, 5)

	scala> b.trimEnd(5)

	scala> b
	res7: scala.collection.mutable.ArrayBuffer[Int] = ArrayBuffer(1, 1, 2)
	scala> b.toArray
	res8: Array[Int] = Array(1, 1, 2)

	scala> b
	res9: scala.collection.mutable.ArrayBuffer[Int] = ArrayBuffer(1, 1, 2)

ArrayBuffer，全称：scala.collection.mutable.ArrayBuffer,类似与Java中的ArrayList和C++中的vector，是长度可变数组类型的结构，`称为数组缓冲`

通过：val name = ArrayBuffer[类型]\(\)来声明，声明`ArrayBuffer`时要指明`类型`。

通过+=操作操作来`添加元素或序列`，++=操作符来`拼接数组`。在ArrayBuffer的`尾端添加或删除元素是一个高效的操作`,ArrayBuffer还支持在`指定位置插入，删除元素`。

ArrayBuffer到数组的转换:toArray方法

**数组遍历**

	用for loop
	scala>for(i <- until array.length)
			println(i)
	scala>for(i <- b)
			println(i)
	指定遍历数组的步长---通过until(上界，步长)
	scala> val intArr = Array(1,2,3,4,5,6,7,8,9)
	intArr: Array[Int] = Array(1, 2, 3, 4, 5, 6, 7, 8, 9)
	scala> for(i <- 0 until(intArr.length,2))
	     | println(i)
	     0
	     2
	     4
	     6
	     8
	scala> for(i <- 0 until(intArr.length,2))
	     | println(intArr(i))
	     1
	     3
	     5
	     7
	     9
	通过reverse函数逆序遍历数组
	scala> for(i <- (0 until intArr.length).reverse)
	     | println(intArr(i))
	     9
	     8
	     7
	     6
	     5
	     4
	     3
	     2
	     1

**for loop get yield**

可以通过for loop + yield来获得`新的数组或ArrayBuffer`。

	scala> val intArr = Array(1,2,3,4)
	intArr: Array[Int] = Array(1, 2, 3, 4)

	scala> for(i <- intArr) yield{
			| i*2
			|
	}
	res0: Array[Int] = Array(2, 4, 6, 8)

	scala> for(b <- intArr) yield -b
	res2: Array[Int] = Array(-1, -2, -3, -4)

通过for+yield操作数组或者ArrayBuffer之后将得到新的数组或ArrayBuffer。

**操作数组/数组缓冲常用函数**

	scala> val intArr = Array(1,2,3,4)
	intArr: Array[Int] = Array(1, 2, 3, 4)

	scala> intArr.sum
	res0: Int = 10

	scala> intArr.max
	res1: Int = 4

	scala> intArr.min
	res2: Int = 1

	scala> intArr.sorted
	res4: Array[Int] = Array(1, 2, 3, 4)

求和，求最小值，最大值，数组排序.通过sorted函数对数组或者ArrayBuffer排序时，返回的是`一个新的数组或ArrayBuffer`，原有的`不变`。

`可以直接对数组调用排序算法`，但是不能对`ArrayBuffer排序`。

	scala> util.Sorting.quickSort(intArr)

	scala> intArr
	res7: Array[Int] = Array(1, 2, 3, 4)

**quickSort是直接修改原来的数组，而sorted方法是返回新数组。**

**多维数组**

Scala中的多维数组和同Java中一样，`多维数组都是数组的数组`。

1)通过Array.ofDim[类型]\(维度1，维度2，维度3,....\)来声明`多维数组`

	scala> val mulDimArr = Array.ofDim[Double](2,3)
	mulDimArr: Array[Array[Double]] = Array(Array(0.0, 0.0, 0.0), Array(0.0, 0.0, 0.0))

从二维数组的初始化，我们看到，多维数组在Scala中也是数组的数组。


2)通过Array[Array]\[Int\](维度1)来声明数组，可以声明`不规则数组`

	scala> val difLenMulArr = new Array[Array[Int]](3)
	difLenMulArr: Array[Array[Int]] = Array(null, null, null)

	scala> for (i <- 1 to difLenMulArr.length){
			| difLenMulArr(i-1) = new Array[Int](i)
				|
	}

	scala> difLenMulArr
	res9: Array[Array[Int]] = Array(Array(0), Array(0, 0), Array(0, 0, 0))

多维数组是数组的数组，按照这种性质来声明多维数组，如例子中的二维数组，声明时，需要指定最外围的数组大小。

__note:可以通过scala.collection.JavaConversions包中隐式转换方法来实现Scala容器类与Java中类的转换__

#### 2.映射

**映射构造**

`对偶`，即名值对，可以通过->操作符号来定义`对偶`，**名->值**运算的结构是(名，值)

	scala> "aaa" -> 1
	res10: (String, Int) = (aaa,1)

	scala> ("bbb" -> 2)
	res11: (String, Int) = (bbb,2)

也可以`声明对偶形式的变量`

	scala> val (name,age) = ("liangkangkang",26)
	name: String = liangkangkang
	age: Int = 26

`映射`是由对偶构成的，**映射是对偶的集合**.

1) 声明`不可变`映射,直接用`Map`来声明时，默认是不可变映射类型。

	scala> val charIntMap = Map('a'->97,'b'->98)
	charIntMap: scala.collection.immutable.Map[Char,Int] = Map(a -> 97, b -> 98)

	scala> charIntMap('a')
	res12: Int = 97

__注意:不可变映射维持元素的插入顺序__

2)声明`可变`对象(scala.collection.mutable.Map)

	scala> val charToIntMap = collection.mutable.Map('a'->96,'b'->97)
	charToIntMap: scala.collection.mutable.Map[Char,Int] = Map(b -> 97, a -> 96)

__注意：放入`可变映射中的值`并未按照`放入顺序`来排序__

通过for loop来修改`可变Map`中的值

	scala> for ((k,v) <- charToIntMap){
	     | charToIntMap(k) = v + 1
          |
		}
	scala> charToIntMap
	res14: scala.collection.mutable.Map[Char,Int] = Map(b -> 98, a -> 97)

__注意:映射可变，不可变指的是`整个映射是否可变`，包扩`元素值，映射中元素的个数，元素次序等`__

3)声明空映射

直接通过new Map[类型1，类型2]\(\)来定义映射会`报错`，因为Map是抽象的，无法实例化。

定义空映射时，需要指定映射的`实现类`，通过`new`来定义

	scala> val map = new scala.collection.immutable.HashMap[Int,Char]()
	map: scala.collection.immutable.HashMap[Int,Char] = Map()

	scala> val map = new collection.mutable.HashMap[Int,Char]()
	map: scala.collection.mutable.HashMap[Int,Char] = Map()

从上面的immutable和mutable可以看出来，两者是不同的。

**映射常用操作**

1)判断映射中`是否含有某个键`:map.contain(键值)

	scala> charToIntMap.contains('c')
	res15: Boolean = false

	scala> charToIntMap.contains('a')
	res16: Boolean = true

2)使用+=向`可变`映射中`添加元素或拼接映射`

	scala> map += (1->'a')
	res17: map.type = Map(1 -> a)

	scala> map
	res18: scala.collection.mutable.HashMap[Int,Char] = Map(1 -> a)

	scala> map += (2->'b',3->'d')
	res19: map.type = Map(2 -> b, 1 -> a, 3 -> d)

3)使用-=来`移除可变`映射中的键及对应元素

	scala> map -= 2
	res21: map.type = Map(1 -> a, 3 -> d)

4)不可变映射可通过+操作符返回一个`新的不可变映射`；不可变映射可通过-操作符返回一个`新的不可变映射`

	scala> val map = Map(1->1,2->4,3->9)
	map: scala.collection.immutable.Map[Int,Int] = Map(1 -> 1, 2 -> 4, 3 -> 9)

	scala> val mapSum = map + (4->16,5->25)
	mapSum: scala.collection.immutable.Map[Int,Int] = Map(5 -> 25, 1 -> 1, 2 -> 4, 3 -> 9, 4 -> 16)

	scala> val mapDif = mapSum - 1
	mapDif: scala.collection.immutable.Map[Int,Int] = Map(5 -> 25, 2 -> 4, 3 -> 9, 4 -> 16)

5)映射遍历

	scala> mapDif
	res25: scala.collection.immutable.Map[Int,Int] = Map(5 -> 25, 2 -> 4, 3 -> 9, 4 -> 16)

	scala> for((base,square) <- mapDif){
			| println(base + "*" + base + " = " + square)
			|
	}
	5*5 = 25
	2*2 = 4
	3*3 = 9
	4*4 = 16

6)获取映射的键集合keySet和值集合

	scala> mapSum
	res27: scala.collection.immutable.Map[Int,Int] = Map(5 -> 25, 1 -> 1, 2 -> 4, 3 -> 9, 4 -> 16)
	scala> mapSum.keySet
	res28: scala.collection.immutable.Set[Int] = Set(5, 1, 2, 3, 4)
	scala> for(squ <- mapSum.values)
	     | {println(squ)}
	     25
	     1
	     4
	     9
	     16

通过映射的keySet方法可以活动映射的由键值构成集合，通过values方法可以过得映射值的Interable对象，应用于循环中，Scala的keySet/valus方法类似于Java中的映射方法。

7)Scala的映射的底层实现要么基于`哈希表`，或者`基于平衡树`，其中基于平衡树的映射内部是`有序的`。

	scala> val sortedMap = collection.immutable.SortedMap('c'->3,'b'->2,'e'->5,'a'->1)
	sortedMap: scala.collection.immutable.SortedMap[Char,Int] = Map(a -> 1, b -> 2, c -> 3, e -> 5)

Scala目前基于平衡树的映射只提供了`不可变版本`，**构建可变有序映射可借助Java的TreeMap**

8)可变映射中，若要`构建维持元素插入顺序的映射可`通过`LinkedHashMap`，通过scala.collection.JavaConversions.MapAsScalaMap可将Java的Map转换为Scala类型的Map；通过scala.collection.JavaConversions.MapAsJavaMap可将Scala的映射转换为Java类型的映射。

9)toMap方法可以将`对偶组成的集合`转换为`映射`

	scala> val mapArr = Array((1,'a'),(2,'b'),(3,'c'))
	mapArr: Array[(Int, Char)] = Array((1,a), (2,b), (3,c))

	scala> mapArr.toMap
	res31: scala.collection.immutable.Map[Int,Char] = Map(1 -> a, 2 -> b, 3 -> c)


Scala的immutable
collection并没有添加和删除元素的操作，其定义+（List使用::在头部添加）操作都是生成一个新的集合，而要删除一个元素一般使用.filterNot函数来映射一个新的集合实现。

（注：Scala中也scala.collection.mutable._集合，它定义了不可变集合的相应可变集合版本。一般情况下，除非一性性能优先的操作（其实Scala集合采用了共享变量的优化，生成一个新集合并不会生成所有元素的副本，它将会和老的集合共享大元素。因为Scala中变量默认都是不可变的），推荐还是采用不可变集合。因为它更直观、线程安全，你可以确定你的变量不会在其它地方被不小心的更改。）

#### 3.元组

1.元组是`不同类型的值`的聚集，`对偶`是最简单的元组.

2.元组表示：通过将不同的值`用小括号`括起来，即表示元组。

	scala> (1,2.1,'a',"helloworld")
	res14: (Int, Double, Char, String) = (1,2.1,a,helloworld)

上例中的元组的类型就是(Int,Double,Char,String);元组中可以存放`不同类型的值`。

3.元组的访问

3.1)元组中的元素称为`组元`，可通过\_1,\_2,\_3的形式来访问对应下标的组元。

	scala> val tuple = (1,2.3,'c',"hello world")
	tuple: (Int, Double, Char, String) = (1,2.3,c,hello world)

	scala> tuple.
	_1   _3   canEqual   equals     productArity     productIterator   toString
	_2   _4   copy       hashCode   productElement   productPrefix

	scala> tuple._1
	res15: Int = 1

	scala> tuple._4
	res16: String = hello world

<font color="red">note元组的中下标是从1开始的。</font>

3.2)通过模式匹配来访问元组中的值

	scala> val (i,d,c,str) = tuple
	i: Int = 1
	d: Double = 2.1
	c: Char = a
	str: String = helloworld

**忽略不需要的值**,在模式匹配时，通过\_(万能匹配符)来为需要获取值的组元`占位`，每个\_仅可以为一个组员占位。

	scala> val (i,_,_,str) = tuple
	i: Int = 1
	str: String = helloworld

4.元组可用于函数返回多个值

	scala> def fun():(Int,String)={
		     | (0,"hello world")
		          |
	}
	fun: ()(Int, String)

上例中，`函数定义返回值`类型为`元组`(Int,String).

#### 4.List

python中，常用的集合类型：list,tuple,set,dict.Scala中对应的是:List,Tuple[X],Set,Map.

Scala中List是一个`递归不可变集合`，它很精妙的使用`递归`结构定义了一个列表集合。

	scala>val list = 1::2::3::4::5::Nil
	list:List[Int] = List(1,2,3,4,5)

List采用`前缀`操作的方式(所有的操作都在列表的顶端)进行，::操作符的作用是将一个元素和列表连接起来，并把元素放在`列表的开头`，这样List的操作就可以定义成一个`递归操作`。添加一个元素就是把元素加到list的开头，List只需要`改下头指针`，而删除一个元素就是把List的头指针指向列表中的第二个元素。这样，List的实现就非常的高效，它也不需要对内存做任何的转移操作。List有很多常用的方法

	scala> list.indexOf(3)
	res6: Int = 2

	scala> 0 :: list
	res8: List[Int] = List(0, 1, 2, 3, 4, 5)

	scala> list.reverse
	res9: List[Int] = List(5, 4, 3, 2, 1)

	scala> list.filter(item => item == 3)
	res11: List[Int] = List(3)

	scala> list
	res12: List[Int] = List(1, 2, 3, 4, 5)

	scala> val list2 = List(4, 5, 6, 7, 8, 9)
	list2: List[Int] = List(4, 5, 6, 7, 8, 9)

	scala> list.intersect(list2)
	res13: List[Int] = List(4, 5)

	scala> list.union(list2)
	res14: List[Int] = List(1, 2, 3, 4, 5, 4, 5, 6, 7, 8, 9)

	scala> list.diff(list2)
	res15: List[Int] = List(1, 2, 3)

Scala中默认都是`Immutable collection`，在集合上定义的操作都`不会更改集合本身`，而是生成一个`新的集合`。Python中只有set上有求交、并、差积运算，Scala中将其范化到所以序列集合上（Seq、List、Set、Array……）都可以支持。

#### 5.Set

Set是一个`不重复且无序的`集合，初始化一个Set需要使用Set对象:

	scala> val set = Set("Python", "Scala", "Java", "C++", "Javascript", "C#", "PHP")
	set: scala.collection.immutable.Set[String] = Set(Scala, C#, Python, Javascript, PHP, C++, Java)

	scala> set + "Go"
	res21: scala.collection.immutable.Set[String] = Set(Scala, C#, Go, Python, Javascript, PHP, C++, Java)

	scala> set filterNot (item => item == "PHP")
	res22: scala.collection.immutable.Set[String] = Set(Scala, C#, Python, Javascript, C++, Java)

#### 6.类

1)Scala中的类是`公有可见性`的，且多个类可以包含在同一个源文件中。

	class Counter{
		private var value = 0	//类成员变量必须初始化，否则报错
`
		def increment(){		//类中的方法默认是公有可见性
			value += 1
		}

		def current() = value	//类中的取值方法，在定义时可省略括号，直接 def current = value
	}

类的使用

	scala> class Counter{
		     | private var value = 0
			 | def increment(){
			 	     | value += 1
		 	          |
			 }
	      | def current = value
	      |
	}
	defined class Counter
	scala> var counter = new Counter
	counter: Counter = Counter@619bfe29
	scala> counter.current
	res0: Int = 0
	scala> counter.increment
	scala> counter.current
	res2: Int = 1

Scala的类在`未提供构造器时`，也会提供`默认构造器`；且在调用无参构造器或无参方法可`省略方法后的括号`

2)Scala类中的每个`字段`都有`geter`和`setter`方法，`私有字段`的`getter`和`setter`默认是`私有的`，公有字段的`getter`和`setter`默认是公有的。其中对于类中的属性value，Scala类默认生成的getter方法名为`value`,默认生成的setter方法名为`value_=`.使用时，我们可以重新定义获取或设置属性的方法。


	scala> class Clock{
	     | var hour = 0
	     | var minute = 0
	     | var second = 0
  		 | def getTime():String = {
         | return hour + ":" + minute +":"+second
			}
	}
	defined class Clock

对于Clock类中的属性，如hour，其对应的getter方法为hour，其对应的setter方法名为`hour_=`

	scala> var clock = new Clock()
	clock: Clock = Clock@7ff6804a

	scala> clock.hour
	res4: Int = 0

	scala> clock.hour_=(12)

	scala> clock.hour
	res6: Int = 12

注意：`可以重新定义获取Scala类中属性的方法`，但是最好不要与属性`默认对应的getter/setter方法重名`，否则会报错。

3)对于Scala类总的val属性，只有默认的getter方法；对于private属性，其默认getter，setter都是private的，因而，对于不想提供setter方法的变量可以设置为val，对于不想提供getter，setter方法的变量可以设置为private.

4)注意，Scala类中，定义函数时，若函数声明`省略了`函数名`后的括号`(由于无参数，可以省略)，必须参数`无括号`的形式，通过带括号形式`调用会报错`
```scala
class Counter{
	var		value = 0

	def current = value
}
```

在类Counter定义中，对于方法current,由于不接受参数，所以定义时，省略了方法名current后的`括号`。此时，对于Counter的实例counter，调用current方法时，必须采用counter.current(无括号形式)

5)构造器

Scala的类可以有一个`主构造器`和`多个辅助构造器`。多个辅助构造器的名称为this，每一个辅助构造器都必须以调用已经定义的辅助构造器或主构造器开始定义。

 + 主构造器

如果一个类`没有显示定义主构造器`，则有一个默认的`无参主构造器`。如：

```scala
class Student(val name:String, var age:Int = 0, address:String = "", private var school:String = ""){
	var grade:Int = if( age>7  ) age-7 else 0

	println(" I'm in main constructor. ")

	def info() = ""
}
```

对于Scala类，`主构造器的参数`放置在类名后，由`括号`括起来。且对于`主构造器中var、val、private`等标注的参数，都会成为类的对应字段，并生成对应的`默认getter、setter方法`。如Student类中的name、age、school等。对于主构造器中的未用var、val标注的参数，如果在类的任何一个方法用用到该参数，该参数将会转换为类的字段，否则不会，如Student类的address属性。

由于在Student类中的info方法中用到了参数address，所以Student共有name、age、address、school、grade等5个属性，且Scala根据对应属性的特点生成了默认的getter和setter方法。

**对于主构造器的参数，也可以提供参数默认值。通过为主构造器提供默认值可减少辅助构造器的个数**.主构造器的函数体，是类中除了方法定义以外的其他语句，如在Student类的主构造器中，包含grade属性的初始化和prinln这两行语句。

6)辅助构造器

辅助构造器通过this来定义，且必须首先调用`主构造器`或者其他`已经定义的辅助构造器`。

```scala
class Person(val name:String){
	 var age = 0
	 var sex:Char = 'f'

    println("main constructor...")

     def this(name:String,  age:Int){
	       this(name)        //调用主构造器
	        this.age = age     //使用this关键字
	         println(" auxiliary constructor1 ")

	}
	   def this(name:String, age:Int, sex:Char){
	          this(name, age)
	          this.sex = sex
	          println(" auxiliary constructor2 ")
	 }
}
```

note：辅助构造器的参数前`不能添加val,var,标志`，否则会`报错`。

7)私有构造器

```scala
class Person private(val name:String){
  var age:Int = 1

  def this(name: String, age:Int){
         this(name)
         this.age = age
	}
}
```

私有构造器通过在类名后`用private关键字`标注主构造器参数来表明，此时，可以通过辅助构造器`来创建该类的对象`。

8)嵌套类

```scala
class Family(val h_name:String, val w_name:String){
	class Husband(var name:String){
         println(" I'm a husband ")
	}

	class Wife(var name:String){
	        println(" I'm a Wife ")
	 }

	 var husband = new Husband(h_name)
	 var wife = new Wife(w_name)

	 def info(){
	        println( "husband: "+husband.name+", wife:"+wife.name  )
    }
}
```
在Scala中，你几乎可以在`任何语法结构`中`嵌套语法结构`，如在`函数中定义函数，在类中定义类`。

#### 7.对象

1)Scala中没有`静态方法`和`静态字段`，但是可以用`object`语法来实现类似的功能。对象定义某个类的单个实例。Scala的object中可以实现类似的功能，用来存放`工具函数或常量`等。

```scala
object Sequence{
		private var next_num = 0
		val threshold = 100

		def getSequence() = {
			next_num += 1
			next_num
	}
}

```
使用object中的常量或方法，通过object名直接调用，对象构造器在对象`第一次被使用`时调用(如果某对象一直`未被使用`，那么其构造器也不会被`调用`)


object的构造器`不接受参数传递`

	scala> Seq.getSequence
	res4:	Int = 1
	scala> Seq.threshold
	res5:	Int = 100

2)伴生对象

可以将在Scala中定义的`静态常量、方法等`放置到Scala的类的伴生对象中，伴生对象与`类同名`，且`必须放置同一个源文件中`。类可以访问伴生对象私有属性，但是必须通过`伴生对象.属性名`或`伴生对象.方法`调用

**伴生对象是类的一个`特殊实例`**

```scala
class Counter{
     def getTotalCounter()= Counter.getCount
}
object Counter{
     private var cnt = 0
     private def getCount()= cnt
}
```

如在类Counter方法其伴生对象的使用方法getCount，必须通过Counter.getCount()的方式调用。

3)对象可以继承或扩展多个特质

```scala
abstract class Person(var name:String, var age:Int){
     def info():Unit
}
object XiaoMing extends Person("XiaoMing", 5){
     def info(){
        println("name is" +naem +",age is " + age)
	}
}

```

4)apply方法

当遇到object(参数1，参数2，...,参数n)的形式的调用时，apply方法便会调用。

5)main方法--Scala程序的入口

main方法定义在object中，形式如下

```scala
object  Hello{
	def main(args:Array[String]){
		println("hello world")
	}
}
```

可以通过scalac 源文件名，然后通过scala 类名来执行主程序

6)还可以通过`扩展特质App`来运行指定代码

```scala
object hello extens App{
	println("A `hello world` from hello world")
}
```
通过扩展App特质的方式执行程序，将要执行的程序放到了object的主构造器中。

7)枚举

Scala并没有定义枚举类型，但是可以通过定义扩展Enumeration的对象，并用value方法初始化枚举中所有可选的值，提供枚举。

```scala
object TrafficeLight extends Enumeration{
	val Red,Yellow,Green = value
}
```

上述实例中的 val Red,Yellow,Green = value语句，相当于

```scala
val red = value
val Yellow = value
val Green = value
```

用value方法来`初始化枚举类变量`时，value方法会返回内部类的新实例，且该内部类也叫value。另外，在调用value方法时，可传入`ID，名称`两个参数。如果没有指定ID，默认`从0开始，后面参数的ID加1`，如果未指定名称，默认与属性字段同名。

```scala
object TrafficLight extends Enumeration{
	val Red = value(1,"stop")
	val Yellow = value("wait")// 可以单独传名字
	val Green = value(4)	// 可以传入ID
}
```

上例中，Yellow属性就`仅定义了名称`，Green`仅定义ID`

```scala
scala>TrafficLight.Red
res10:TrafficLight.value = Stop
scala>TrafficLight.Green
res11:TrafficLight.value = Green
```

参数在`不指定名称`时，默认参数的value为`字段名`

**note:枚举类型的值是对象的value,如上面中的枚举类型是TrafficLight.value**

8)通过id方法来获取枚举类型值的ID

```scala
scala>TrafficLight.Green.id
res12: Int = 4
```

9)通过values方法获取所有枚举值的集合

```scala
scala>TrafficLight.values
res13:TrafficLight.ValueSet = TrafficLight.ValueSets(Stop,Wait,Green)
```

10)通过ID来获取对应的枚举对象

```scala
scala>TrafficLight(1)
res14:TrafficLight.value = Stop
```

#### 8.函数

在Scala中，函数是一等公民。函数可以像类型一样被赋值给一个变量，也可以做为一个函数的参数被传入，甚至还可以做为函数的返回值返回（这就是函数式编程）。

	scala> def calc(n1: Int, n2: Int): (Int, Int) = {
			|   (n1 + n2, n1 * n2)
				|
	}
	calc: (n1: Int, n2: Int)(Int, Int)

	scala> val (add, sub) = calc(5, 1)
	add: Int = 6
	sub: Int = 5

这里定义了一个函数：calc，它有两个参数：n1和n2，其类型为：Int。cala函数的返回值类型是一个有两个元素的元组，在Scala中可以简写为：(Int,
Int)。在Scala中，代码段的最后一句将做为函数返回值，所以这里不需要显示的写return关键字。

而val (add, sub) = calc(5,
1)一句，是Scala中的抽取功能。它直接把calc函数返回的一个Tuple2值赋给了add他sub两个变量。



### Scala API download

只要我们按照如下的格式，就可以下载到对于版本的API了。

	http://downloads.typesafe.com/scala/{version}/scala-docs-{version}.txz
	http://downloads.typesafe.com/scala/{version}/scala-docs-{version}.zip

example:

	axel -n 10 http://downloads.typesafe.com/scala/2.11.8/scala-docs-2.11.8.txz
	axel -n 10 http://downloads.typesafe.com/scala/2.11.8/scala-docs-2.11.8.zip


### learn web

[https://github.com/tanacasino/learning-scala](https://github.com/tanacasino/learning-scala)

[https://github.com/elephantscale/learning-scala](https://github.com/elephantscale/learning-scala)

[https://github.com/yusugomori/DeepLearning](https://github.com/yusugomori/DeepLearning)

[https://github.com/deanwampler/prog-scala-2nd-ed-code-examples](https://github.com/deanwampler/prog-scala-2nd-ed-code-examples)

[https://github.com/scala-exercises/scala-exercises](https://github.com/scala-exercises/scala-exercises)

[https://github.com/renchunxiao/scala-learn](https://github.com/renchunxiao/scala-learn)

[https://github.com/TheAlgorithms/Scala](https://github.com/TheAlgorithms/Scala)

[https://github.com/twitter/scala_school](https://github.com/twitter/scala_school)

[https://github.com/bwwinthehouse/learning_scala](https://github.com/bwwinthehouse/learning_scala)
