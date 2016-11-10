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

## 基础语法

## 控制结构

## 数据结构

## 模块与函数

## 字符串与正则表达式

## 文件处理

## 面向对象编程

## 异常处理与程序调试

## Python和HTML

## Python和XML

## Python-Django

## Python的进程和线程

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

## Ipython

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
## Jupyter

## Python网络编程

 + socket
 + time
 + datetime
 + socketserver
 + urllib
 + select
 + asyncore

Tweisted网络框架

Twisted是一个面向对象，基于事件驱动的顶级通信框架，可以完成大部分的网络的应用任务。

## Python网络应用

常用的模块

 + ftplib
 + poplib
 + smtplib
 + telnetlib
 + pysnmp
 + scapy

## Python测试驱动开发

##
##
##
##
##
