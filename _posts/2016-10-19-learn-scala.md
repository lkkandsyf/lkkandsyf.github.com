---
layout: post
category :
tagline: "Supporting tagline"
tags : []
---
{% include JB/setup %}

# Overview
{:.no_toc}
这里整理自己学习scala的整个过程，以及笔记。

* dir
{:toc}

## tools

 + sbt
 当你启动sbt命令时，假设不指定任何`任务`，SBT将启动一个`交互式REPL（REPL是 Read，Eval，Print，Loop的简写，代表了“读取-求值-打印-循环”）`。

 运行sbt命令；>时SBT默认的交互式提示符，可以在#符号后编写sbt注释
{% highlight C linenos %}
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
{% endhighlight %}
为了能编译更新后的代码并运行对应测试，我通常会执行~test命令。SBT使用了`增量的编译器和测试执行器`，因此每次执行是不用等待完全构建所需时间。假如你`希望执行其他任务或者退出sbt`，只需要`按一下回车即可`。

使用Scala REPL能有效地对你编写的代码进行试验，也可以通过REPL来学习API，即便是JAVA API也是一样。在SBT上使用console任务执行代码时，console任务会很体贴地为你咋classpath中添加依赖项以及编译后的项目diamante

scaladoc:与javadoc不同，Scaladoc按照package来`排列类型`，而不是`按照字母顺序全部列出`.

`运行REPL的三种方式`
 + 可以不指定脚本或main参数来直接输入scala命令
 + 可以使用sbt console命令
 + 可以在那些流行的IDE中使用`worksheet`特性

解释器返回的是变量的`类型和数值`,可变数据是错误之源.

## 基本知识

##




## 疑惑
 + 方法的定义体出现的等号(=)之后，为什么使用=？,而不像Java那样，使用的是{}来表示方法体呢？
 scala使用[]来表示参数类型，Java用的是<>,并且不允许在标识符中使用[].
 A:1)避免歧义是原因之一，当你在代码中省略`分号`时，Scala能够推断出来。在大多数的时候，Scala能够推导出方法的返回类型。假设方法不接受任何参数，你还可以在方法定义中省略参数列表。

  2)使用=也强调了函数式编程的一个准则：值和函数是高度对齐的概念。函数可以作为参数传递给其他函数，也能够返回函数，还能够赋给某一个变量，这与对象的行为是一致的。

  最后说一下，假设方法体中`仅包含一个表达式`，那么Scala允许你省略花括号，所以说，使用=能够避免可能的解析歧义。
