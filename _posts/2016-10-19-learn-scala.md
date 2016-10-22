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

 + sbt:当你启动sbt命令时，假设不指定任何`任务`，SBT将启动一个`交互式REPL（REPL是 Read，Eval，Print，Loop的简写，代表了“读取-求值-打印-循环”）`。

运行sbt命令；>时SBT默认的交互式提示符，可以在#符号后编写sbt注释

	$sbt
	>help				# 描述命令
	>tasks				# 显示最常用的，当前可用的任务
	>tasks -V			# 显示所有的可用任务
	>compile			# 增量编译代码
	>test				# 增量编译代码，并执行测试
	>clean				# 删除所有已经编译好的构建
	>~test				# 一旦有文件保存，执行增量编译并运行测试
					# 适用于任何使用了～前缀的命令
	>console			# 运行Scala REPL
	>run				# 执行项目的某一程序
	>show x				# 显示变量X的定义
	>eclipse			# 生成Eclipse项目文件
	>exit				# 退出REPL(也可以通过ctrl+d的方式退出)

为了能编译更新后的代码并运行对应测试，我通常会执行~test命令。SBT使用了`增量的编译器和测试执行器`，因此每次执行是不用等待完全构建所需时间。假如你`希望执行其他任务或者退出sbt`，只需要`按一下回车即可`。

使用Scala REPL能有效地对你编写的代码进行试验，也可以通过REPL来学习API，即便是JAVA API也是一样。在SBT上使用console任务执行代码时，console任务会很体贴地为你咋classpath中添加依赖项以及编译后的项目diamante

scaladoc:与javadoc不同，Scaladoc按照package来`排列类型`，而不是`按照字母顺序全部列出`.

`运行REPL的三种方式`
 + 可以不指定脚本或main参数来直接输入scala命令
 + 可以使用sbt console命令
 + 可以在那些流行的IDE中使用`worksheet`特性

解释器返回的是变量的`类型和数值`,可变数据是错误之源.

## 基本知识

### 基础

#### 1.变量
	val 标志符：声明变量；如，val result = 1
	var 标志符：声明变量；

 + 类型推断：变量的类型由scala根据初始化变量的表达式推断出来，`鼓励使用val`；**note:声明变量时不做初始化会报错**
 + 明确类型：scala的`变量或函数的类型总是写在变量或函数的后面`.
{% highlight C %}
val a:Int = 1
val str:String = "hello world"
{% endhighlight %}

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

	for(i <- 1 until 3; j <- until 3){
		println(i*j)
	}
	for loop的这种结构类似Java中嵌套环结构,也可以用

	for{i <- 1 until 3		// 使用大括号，使用换行来分割组
		j <- until 3 }{
			println(i*j)
	}

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

#### 4.类

#### 5.对象




### Scala API download

只要我们按照如下的格式，就可以下载到对于版本的API了。

	http://downloads.typesafe.com/scala/{version}/scala-docs-{version}.txz
	http://downloads.typesafe.com/scala/{version}/scala-docs-{version}.zip

example:

	axel -n 10 http://downloads.typesafe.com/scala/2.11.8/scala-docs-2.11.8.txz
	axel -n 10 http://downloads.typesafe.com/scala/2.11.8/scala-docs-2.11.8.zip


