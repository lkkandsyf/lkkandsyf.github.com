---
layout: post
category :
tagline: "Supporting tagline"
tags : []
---
{% include JB/setup %}

# Overview
{:.no_toc}

* dir
{:toc}

## **语言基础**

### 基础语法

 + 优化代码

	import py_compile

	python -O m py_compile xxx.py

参数 -O 表示生成优化代码，参数 -m 表示把导入的py\_compile模块作为脚步运行，编译xxx.py需要调用py\_compile模块的compile()方法，xxx.py 需要编译的文件，最后会生成一个xxx.pyo的文件

变量名，包名，模块名通常采用`小写，可使用下划线`，类名一个字符`大写`，类的私有属性必须有`两个下划线`，对象名`小写`。

`代码缩进`是Python的基本语法

模块导入
```python
	import
	from ... import ...
```
使用空行分割代码
```python
	class A:
		def funX(self)
			print("funX")

		def funY(self)
			print("funY")

	if __name__ = "__main__"
		a = A()
		a.funX()
		a.funY()
```

注释：单行注释，块注释，中文注释 #-*-coding: UTF-8-*-

单行语句，太长，用\来分割

局部变量和全局变量(global),常量const模块

Python根据变量的自动`判断变量的类型`
```python
	#这两个i并不是同一个对象
	In [2]: i = 1
	In [3]: print(id(i))
	12865880
	In [4]: i = 2
	In [5]: print(id(i))
	12865856
```
字符串
```python
In [6]: str = "hello"
In [7]: print (str)
hello
In [8]: str = 'hello world'
In [9]: print (str)
hello world
In [12]: str = '''he says hello world"''' #三引号中带有双引号，双引号也会输出
In [13]: print (str)
he says hello world"

class Hello:
	'''hello class '''
	def printHello():
		'''print hello world'''
		print("hello world")

	print(Hello.__doc__)
	print(Hello.printHello.__doc__)

#转义字符
	str = 'he say :\`hello world!\'`
	print (str)
#特别注意多个引号在一起时，要让编译器知道```的存在
```
运算符和表达式

算术运算符:+,-,*,/,%,**

关系运算符:>,<,<=,>=,==,!=

逻辑运算符:and,or,not


### 控制结构

**if条件语句**

if...elif..else判断语句

if嵌套语句

Python中没有switch语句，而是使用字典来代替的。
```python
from __future__ import division

x = 1
y = 2
operator = '/'
result = {
	"+":x+y,
	"-":x-y,
	"*":x*y,
	"/":x/y,
}

print(result.get(operator))
```

**while循环**
```python
while(expr)
	...
else:
	...
```
_注意_while循环中的else子句也属于循环的一部分，最后一次的循环结束后将执行else子句
```python
x = 1
i = 1
while(x != 0):
	if(x > 0):
		x -= 1
	else:
		x += 1
	i = i+1
	print("the %d loop %d:",%(i,x))
else:
	print("x=",x)

```

**for 循环**
```python
for var in set:
	...
else:
	...
```
for...in...循环通常与range()函数一起使用，rangge返回一个列表，for...in...遍历列表中的元素

**break和continue**

break语句不能运行在`循环体或分支语句之外`，否则，Python解释器会提示错误。

冒泡排序
```python
def bubbleSort(numbers):
	for j in range(len(numbers),-1,-1,-1):
		for i in range(j):
			if numbers[i] > numbers[i+1]:
				numbers[i],numbers[i+1] = numbers[i+1],numbers[i]	#把数值小的放到顶端
			print(numbers)

def main():
	numbers = [23,5,9,46,78,9]
	bubbleSort(numbers)

if __name__ == '__main__':
	main()
```

### 数据结构

 + 元组

元组是Python中常用的一种数据结构。元组由不同的元素组成，每个元素可以存储`不同类型的数据`，如字符串，数字甚至元组。元组是`写保护`的，即元组创建后不能再做任务`修改操作`，元组通常代表`一行`数据，而在元组中的元素代表`不同`的数据项。
```python
tuple = (ele1,ele2,...)			#元组的创建
tuple = ("apple","banana","grape","orange")	#元组的初始化，元素之间逗号分割
tuple = ()	#空元组
#如果元组中只有元素，记得在后面加上,否则输出tuple[0]的结果不是自己想要的
tuple = ("apple",)
print (tuple[0])
print (tuple[n])	#元组中元素的值通过索引访问，索引就是下标。元组中的元组创建之后就不能修改，元组不存在任何添加，删除元素的操作，元组不存在其他任何的方法

#元组分片tuple[m:n]支持负数操作
#元组可以由其他元组组成，例如二元元组可以表示
tuple = (('t1','t2'),('t3','t4'))
#access
print (tuple[m][n])

#打包
tuple = ("a","b","c")
#解包
a,b,c = tuple
print (a,b,c)


```
 + 列表

 + 字典

 + 序列

### 模块与函数

### 字符串与正则表达式

### 文件处理

### 面向对象编程

### 异常处理与程序调试

## **Python应用**

### Python和HTML

### Python和XML

### Python-Django

 + django
 + MVC

### TDD

 + unittest
 + doctest

### Python的进程和线程

进程和线程的相关模块

 + os/sys：包含基本_进程_管理函数
 + signal：Python基本库中_信号_的相关函数
 + subprocess：Python基本库中多_进程_的相关模块
 + theading：Python基本库中_线程_相关的模块


**进程**

	popen:生成新的进程
	abort/exit：终止进程
	system：直接生成字符串所代表的进程
	exec家族：在现有的进程环境下生成新的进程

**线程**

	theading模块中Thead类的常用方法
	start:开始运行生成的线程实例
	run:重载这个方法，作为线程的运行部分
	join:等待线程的结束
	getName:返回线程的名字
	setName:设置线程的名字
	isAlive:查看线程是否还是活动的
	isDaemon:查看线程是否后台运行标志
	setDaemon:设置线程的后台运行标志

**线程数据同步的常用方法**

_锁机制_

	使用互斥锁实现数据同步，
	acquire：获取锁，
	release：释放锁

_条件变量_

	同样使用互斥锁，可以实现带有条件的临界区访问
	acquire：获取锁
	release：释放锁
	wait：阻塞线程，直到有事件来唤醒
	notify：唤醒等待次条件变量的线程
	notifyAll：同notify，但是将会唤醒所有等待次条件的线程

_信号量_

	acquire：获取资源，将内部计数器减少1，如果内部计数器为0，则等待
	release：释放资源，将内部计数器加1

_同步队里_

	使用同步队列的入队和出对来有效的实现数据同步
	qsize：队里的长度（线程的原因，不一定准确）
	empyt：队列是否为空（线程的原因，不一定准确）
	full：队里是否已满（线程的原因，不一定准确）
	put：将任务入队
	put_nowait:将任务入队，如果队列已满，则跑出Full异常
	get：将任务出队
	get_nowait:将任务出队，如果队列为空则抛出Empyt异常
	task_done:指示上一个入队任务是否完成操作
	join:等待队列中任务完成任务

### Ipython

Ipython的特性

 + magic函数：内置了很多函数用来实现各种特性
 + Tab补全：可以有效的补齐Python语言的模块，方法和类等。
 + 源码编辑:可以直接修改源码并运行
 + 宏：可以将一段代码定义为一个宏，便于以后运行
 + 历史记录：提供了强大的历史记录功能
 + 对象自省：有强大的对象自省功能
 + 执行系统命令：可以直接在交互式shell中执行系统命令

安装可以使用pip来直接安装

	sudo pip install ipython

magic函数的使用和构造

	%cd dir #都有补全的功能

这里还提供了cd命令的一个参数-q使得Ipython不用打印此消息。

	dhist [n] [m] #history [n] [m] n - m  command
	history -r
	env	#环境变量
	page #分页
	pfile module_name #查看相关信息
	pdef function_name #函数原型
	pdoc function_name #函数文档字符串
	pinfo function_name#函数的相关信息
	psearch object_name #搜索当前名字空间中已有的Python对象。
	psearch a*	#搜索以a开头的Python对象
	psearch -e buidtin a* #-选项将内置函数去掉
	psource object_name #输出对象代码
	bg	#将后面的函数放在后台执行
	pycat #用语法高亮显示一个pythonfile
	r #重复上次的命令
	run #执行文件
	save #将代码保存为文件
	time #计算时间
	who #打印所有的Python变量
	who_ls #返回所有的Python变量的列表
	whos #和who相似，但会输出更加详细的信息

使用_符号访问输出结果。

	!command
	result = !command
	!!command #不能赋值给某个变量，因为返回的是一个list
	!python test.py
	%run test.py
	import sys
	dir(sys) #列出次模块中支持的所有的方法和成员
	help(object)	#帮助手册
	?/??	#查看详细信息

tarfile

定时执行任务

```python
import time
import os

def main(cmd,inc=60):
	while True:
		os.system(cmd)
		time.sleep(inc)

main("netstat -an",60)
```

使用sched模块

```python
import time os
import sched

schedule = sched.scheduler(time.time,time.sleep)

def execute_command(cmd,inc):
	os.system(cmd)
	schedule.enter(inc,0,execute_command,(cmd,inc))

def main(cmd,inc=60):
	schedule.enter(0,0,execute_command,(cmd,inc))
	schedule.run()

main("netstat -an",60)
```

### Jupyter

### Python网络编程

 + socket
 + time
 + datetime
 + socketserver
 + urllib
 + select
 + asyncore

Tweisted网络框架

Twisted是一个面向对象，基于事件驱动的顶级通信框架，可以完成大部分的网络的应用任务。

### Python网络应用

常用的模块

 + ftplib
 + poplib
 + smtplib
 + telnetlib
 + pysnmp
 + scapy

### Python测试驱动开发

### pdb

[官网](https://docs.python.org/2/library/pdb.html)

python中有个pdb模块，使python代码也可以像gdb那样进行调试，一般情况下pdb模块可以在代码内直接使用，也可以通过命令行参数的形式添加该模块进行调试(python -m pdb file.py)。在代码中直接使用pdb模块调试时，import pdb模块后，然后在需要调试的代码出添加pdb.set_trace()命令即可，运行程序后，在运行到次代码处会自动停止，进入调试模式。

一般常用的调试命令有：

	q  退出debug
	h  打印可用的调试命令
	b  设置断点，b 5 在第五行设置断点
	h command  打印command的命令含义
	disable codenum  使某一行断点失效
	enable codenum   使某一行的断点有效
	condition codenum xxx  针对断点设置条件
	c    继续执行程序，直到下一个断点
	n    执行下一行代码，如果当前语句有函数调用，则不会进入函数体中
	s    执行下一行代码，但是s会进入函数
	w    打印当前执行点的位置
	j    codenum  让程序跳转到指定的行
	l    列出附近的源码
	p    打印一个参数的值
	a    打印当前函数及参数的值
	回车  重复执行上一行
	return 或 r	执行代码直到从当前函数返回
	cl	清除断点
	w ，Print a stack trace, with the most recent frame at the bottom.An arrow indicates the "current frame", which determines the context of most commands. 'bt'
	n alias for this command.
	d ，Move the current frame one level down in the stack trace
	(to a newer frame).
	u ，Move the current frame one level up in the stack trace
	(to an older frame).使用 u 和 d 命令，我们可以在栈帧之间切换，用以获取其相关上下文变量信息。w可以显示最近的一些栈帧信息。

调试过程如下:python -m pdb xxx.py

参考[http://www.ibm.com/developerworks/cn/linux/l-cn-pythondebugger/](http://www.ibm.com/developerworks/cn/linux/l-cn-pythondebugger/)

