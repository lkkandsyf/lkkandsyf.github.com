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

---

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

---

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
元组的遍历:元组的遍历是指通过循环语句依次访问元组中各个元素的值。遍历元组需要用到两个函数range(),len(),range和len都是内建函数，这些函数可以直接使用，不需要import语句导入。内建函数是Python自动导入的函数。
```python
tuple= (("apple","banana"),("grape","orange"),("watermelon",),("grape",))
for i in range(len(tuple)):
	print ("tuple[%d]:",%i " ",)
	for j in range(len(tuple[i])):
		print (tuple[i][j]," " ,)
	print()

#the second
tuple= (("apple","banana"),("grape","orange"),("watermelon",),("grape",))
for i in tuple:	#遍历元组
	for j in i:	#同样对子元组进行遍历
		print (j)	#依次打印元素
```
 + 列表

列表是Python内置的一种数据结构。它由一系列元素组成，所有元素被包含在一对方括号中。列表创建后，可以执行添加或删除操作。list = [ele1,ele2,....],追加append(object),object可以是`元组，列表，字典或任何对象`，列表的删除remove(value),如果value不在列表中，将会抛出异常.
```python
list = ["apple","banana","grape","orange"]		#定义列表
print (list)
print (list[2])
list.append("watermelon")			#add one elem
list.insert(1,"grapefruit")			#向列表中插入元素
print (list)
list.remove("grape")
print (list)
list.remove("a")					#列表中没有，就会抛出异常
print (list.pop())					#打印从列表弹出的元素，即最后一个元素
print (list)
```

列表的使用
```python
list = {"apple","banana","grape","orange"}
print (list[-2])
print (list[1:3])
print (list[-3:-1])

list = [["apple","banana"],["grape","orange"],["watermelon"],["grapefruit"]]

for i in range(len(list)):
	print ("list[%d]"%i,"",)
	for j in range(len(list[i])):
		print (list[i][j],"",)
	print()
```
列表连接
```python
list1 = ["apple","banana"]
list1 = ["grape","orange"]
list1.extend(list2)
print (list1)

list3 = ["watermelon"]
list1 = list1 + list3
print (list1)

list1 += ["grapefruit"]
print (list1)

list1 = ["apple","banana"] * 2
print (list1)

```
列表的查找，排序，反转
```python
list = ["apple","banana","grape","orange"]
print (list.index("grape"))		#打印grape的索引
print (list.index("orange"))	#打印oranage的索引
print ("orange" in list)		#True

list = ["banana","apple","orange","grape"]
list.sort()
print ("sort list:",list)

list.reverse()
print ("reverse list:",list)
```
列表的方法

 + append(object):在列表的末尾添加一个对象object
 + insert(index,object):在指定索引index出插入一个对象object
 + remove(value):删除列表中`首次`出现的value值
 + pop([index]):删除索引index指定的值，如果index不指定，删除列表中`最后一个元素`
 + extend(iterable):将iterable指定的元素添加到列表的末尾
 + index(value,[start,[stop]]):返回value出现在列表中的索引
 + sort(cmp=None,key=None,reverse=False):列表的排序
 + reverse():列表的反转

列表实现堆栈和队列
```python
#堆栈(先进后出)
list = ["apple","grape","grape"]
list.append("orange")
print (list)

print ("the pop element:",list.pop())
print (list)

#队列(先进先出)
list = ["apple","grape","grape"]
list.append("orange")
print (list)

print ("the pop element:",list.pop(0))#弹出第一个元素
print (list)
```
 + 字典

字典是由`键-值`对组成的集合，字典中的`值`通过`键`来引用,`键-值`对之间用`逗号`隔开，并且包含在一对`花括号`中。

	dictionary = {key1:value1,key2:value2,....}

其中key1，key2表示字典的key值，value1，value2等表示字典的value值。如果需要一个`空的字典`，只需要一对`花括号`即可

	dictionary = {}

字典的创建和访问
```python
dict = {"a":"apple","b":"banana","g":"grape","o","orange"}
print (dict)
print (dict["a"])


dict = {1:"apple",2:"banana",3:"grape",4,"orange"}
print (dict)
print (dict[1])

print ("%s, %(a)s,%(b)s" %{"a":"apple","b":"banana"})
# %s输出这个字典的内容
#%(a)s:获取对应key值为"a"的value值
#%(b)s:获取对应key值为"b"的value值

```
字典的`键`是区分`大小写`的，例如:dict["a"]和dict["A"]分别执行不同的值。

```python
dict = {"a":"apple","b":"banana","g":"grape","o","orange"}
dict["w"] = "watermelon"		#增加元素
del(dict["a"])					#删除字典中键为"a"的元素
dict["g"] = "grapefruit"		#修改字典中键为"g"的值
print (dict.pop("b"))			#弹出字典中键为"b"的元素
print (dict)
dict.clear()					#清除字典中所有的元素
print (dict)

#字典的遍历
dict = {"a":"apple","b":"banana","g":"grape","o","orange"}
for k in dict:
	print ("dict[%s] = "%k,dict[k])

#使用item返回一个由若干个元组组成的列表
dict = {"a":"apple","b":"banana","g":"grape","o","orange"}
print (dict.items())

#可见items()把字典中每对key和value组成了一个元组，并把这些元组存放在列表中返回
dict = {"a":"apple","b":"banana","g":"grape","o","orange"}
for (k,v) in dict.items():
	print ("ditc[%s] = "%k,v)
```
混合型字典：使用元组，列表或字典作为value值创建的字典

	dict ={"key1":(tuple),"key2":[list],"key3":[dictionary],....}

```python
dict = {"a":{"apple,"},"bo":{"b":"banana","o":orange},"g":["grape","grapefruit"]}
print (dict["a"])		#整个元组
print (dict["a"][0])	#元组的第一个元素
print (dict["bo"])		#输出字典
print (dict["g"])		#输出列表
print (dict["g"][1])	#输出列表中的第二个元素
```

字典的方法keys(),values()分别返回字典key列表和value列表
```python
dict = {"a":"apple","b":"banana","c":"grape","d":"orange"}
#输出key的列表
print (dict.keys())
#输出value的列表
print (dict.values())
```
要获取字典中某个value值，可以使用dict[key]的结构来访问。另一种获取value值的办法是使用字典的get()，get()的声明

	D.get(k[,d]) -> D[k]

参数k表示字典的键值，参数d可以作为get()的返回值，参数d可以默认，默认值是None。get()相当与一条if ... else ...语句，如果参数k在字典D中，get()将返回D[k],如果参数k不在字典D中，则返回参数d。
```python
#get()的等价语句
D = {"key1":"vaule1","key2","value2"}
if "key1" in D:
	print (D["key1"])
else:
	print ("None")

#get使用
dict = {"a":"apple","b":"banana","c":"grape","d","orange"}
print (dict)
print (dict.get("c","apple"))#获取键为c的值，不存在就返回默认值apple
print (dict.get("e","apple"))#获取键为e的值，不存在就返回默认值apple
```
如果需要添加新的元素到`已经存在的字典`中，可以调用字典的update(),update把一个字典的key和value值全部复制到另一个字典中，update相当与一个`合并函数`

	D.update(E) -> None

合并字典
```python
D = {"key1":"value1","key2","value2"}
E1= {"key3":"value3","key4","value4"}
for k in E:
	D[k] = E[k]	#如果字典中有相同的值，就会覆盖,update函数也是一样
print (D)

#update
dict = {"a":"apple","b":"banana"}
print (dict)
dict2 = {"c":"grape","d":"orange"}
dict.update(dict2)
print (dict)
```
`字典不属于序列`，所以字典`没有顺序性`，update之后，字典中的各元素的排列顺序是`无序的`。

setdefault()的使用
```python
#设置默认值
dict = {}
dict.setdefault("a")
print (dict)				#{"a",None}
dict["a"] = "apple"			# dict["a"] = "apple"
dict.setdefault("a","None")	#再次设置默认值None
print (dict)				#由于设置了dict["a"]的值为"apple",即使再次调用setdefault()也不会影响value值，所以dict["a"]的值仍然为apple，而不是"default"
```
字典的常用方法
 + items() 返回(key,value)元组组成的列表
 + iteritems() 返回执行字典的遍历器
 + setfault(k[,d]) 创建新的元素并设置默认的值
 + pop(k[,d]) 移除索引k对应的value值，并返回该值
 + get(k[,d]) 返回索引k对应的value值
 + keys() 返回字典中key的列表
 + values() 返回字典中value的列表
 + update(E) 把字典E中的数据扩展到原字典中
 + copy()  复制一个字典中所有的数据

字典的排序，复制
```python
dict = {"a":"apple","b":"banana","c":"grape","d","orange"}
print (dict)
#按照key排序
print (sorted(dict.items(),key=lambda d:d[0]))
#按照value排序
print (sorted(dict.items(),key=lambda d:d[1]))
```
字典的copy，实现了字典的浅拷贝操作
```python
dict1 = {"a":"apple","b":"banana","c":"grape","d","orange"}
dict2 = {"e":"watermelon","d","dance"}
dict2 = dict1.copy()		#拷贝dict1并赋给dict2
print (dict2)

```
身拷贝能够对拷贝对象内部所有的数据和引用，引用相当用C语言中的指针的概念，Python中`并不存在指针`，但是变量的内存结构中通过引用来为`维护变量`，而`浅拷贝`只是`复制数据`，并没有`复制数据的引用`，新的数据的旧的数据使用`同一块内存空间`，例如，字典B浅拷贝字典A的数据，如果字典B的数据发生`添加，删除或修改操作`，字典A的数据`也将发生变化`，相反，如果字典B`深拷贝`字典A的数据，字典B的数据`发生变化`，也`不会影响到字典A`

深拷贝和浅拷贝应用于`Python`中的`任何对象`，不只是字典，在Python中可以使用copy模块来实现对象的深拷贝和浅拷贝，deepcopy()用于深拷贝操作，copy()用于浅拷贝操作。
```python
#字典的深拷贝
import copy
dict = {"a":"apple","b":"banana","c":"grape","d","orange"}
dict2 = copy.deepcopy(dict)				#深拷贝
dict3 = copy.copy(dict)					#浅拷贝 === dict3 = dict.copy()
dict2["b"] = "liangkangkang"			#不会受到影响
print(dict)
dict3["b"] = "liangkangkang"			#会受到影响
print(dict)
```
全局字典----sys.modules模块

sys.modules是一个全局模块，这个字典是Python启动后就加载在`内存`中。每当程序员`导入`新的模块，sys.moules都将记录这些模。字典sys.modules对加载的模块起到了缓存的作用。当某个模块`第一次`导入时，字典sys.modules将自动记录该模块，当`第二次`导入此模块时，Python会直接到字典中`查找`，从而加快了程序的`运行速度`
```python
#查看模块
import sys
print (sys.modules.keys())
print (sys.modules.values())
print (sys.modules["os"]

#模块过滤
import sys
d = sys.modules.copy()
import copy.string
print (zip(set(sys.modules) - set(d)))	#zip对set集合进行解包
```

 + 序列

序列是具有`索引和切片能力的集合`,元组，列表，和字符串具有通过索引来访问某个具体的值，或通过切片返回一段切片的能力，因此,`元组，列表或字符串`都属于`序列`
```python
#序列索引
tuple = ("apple","banna","grape","orange")
list = ["apple","banna","grape","orange"]
str = "apple"
print (tuple(0))		#apple
print (tuple(-1))		#orange
print (list[0])			#apple
print (list[-1])		#orange
print (str[0])			#a
print (str[-1])			#e

#分片操作
tuple = ("apple","banna","grape","orange")
list = ["apple","banna","grape","orange"]
str = "apple"
print (tuple[:3])
print (tuple[3:])
print (tuple[1:-1])
print (tuple[:])

print (list[:3])
print (list[3:])
print (list[1:-1])
print (list[:])

print (str[:3])				#app
print (str[3:])				#le
print (str[1:-1])			#ppl
print (str[:])				#apple

分片seq[:3]表示从序列第一个元素到第三个元素的值，分片[:]表示整个序列
```
元组和列表都具有序列的特性，但是它们的区别也很明显。元组是`只读的一组数据`，而且元组`没有提供排序和查找的方法`，列表的数据可读写，而且提供了丰富的方法，支持排序，查找操作。`列表的数据通常具有相同的意义`。
```
				元组					列表
支持负索引			yes					yes
支持分片				yes					yes
支持添加删除修改			no					yes
支持排序查找			no					yes
数据的含义		一组不同含义的数据				一组相同含义的数据组成
```
---

### 模块与函数

Python的程序由包(package),模块(module)和函数组成。模块是处理某一类问题的集合，模块函数由函数和类组成。包是由一系列模块组成的集合。包就是一个`完成疼任务的工具箱`.

包必须`至少包含一个__init__.py文件`，这个文件可以`为空`，它用于`标示`当前的文件夹是`一个包`

一个Python文件就是一个模块,一个文件即是一个模块。模块是由代码，函数或类组成的。
```python
#自定义模块
#myModule.py
def func():
	print ("myModule.func")

class MyClass:
	def myFunc(self):
		print ("MyModule.MyClass.myFunc")

#同一个目录下的call_module.py
#调用自定义的模块
import myModule			#导入模块

myModule.func()
myClass = myModule.MyClass()	#实例对象
myClass.myFunc()				#调用方法

```
两个文件必须放到`同一个目录下`，或放在sys.path所列出的目录下，否则，Python解释器找不到`自定义的模块`

当Python导入一个模块时，Python首先查找当前路径，然后查找lib目录，site-packages目录(Python/Lib/site-packages)和环境变量PYTHONPATH设置的目录。如果导入的模块没有找到，在以上路径搜索一下，是否含有这个模块，通过sys.path语句搜索模块的查找路径。
```python
#导入模块
import ModuleNname
from  ModuleNname import *			#导入所有
```

**模块的属性**

例如,\_\_name==\_\_用来判断当前的模块是否是程序的`入口`，如果当前的程序正在使用，\_\_name\_\_的值为\_\_main\_\_,通常给每个模块添加一个`条件语句，用来端度测试该模块的功能`
```python

	if __name__ == "__main__":
		print ("myModule 作为程序正在运行")
	else:
		print ("myModule被另一个程序调用")
```

模块内建函数，利用这些函数可以实现数据类型的转换和数据的计算，序列的处理等功能。常用的内联模块函数

apply()调用可变参数的列表的函数的功能只能使用在列表前添加\*来实现

filter()可以对某个序列做过滤操作，判断自定义函数的结果是否为真来过滤，并一次性返回结果。从给定的列表总过滤大于0的数字
```python
	def func(x):
		if x > 0:
			return x
	print (filter(func,range(-9,10)))	#调用filter函数，返回filter对象
	print (list(filter(func,range(-9,10))))#将filter对象转换为列表
```
filter中的`过滤函数func的参数不能为空`，否则，没有可以存储sequence元素的变量，func也不能处理过滤

reduce()对序列重点数据可以通过循环来操作，比如累加，Python3中reduce移动到了functools模块中，使用前，必须提前导入
```python
	def sum(x,y):
		return x + y

	from functools import reduce
	print (reduce(sum,range(0,10)))		#0+1+2+...+..9 = 45
	print (reduce(sum,range(0,10),10))		#10 + 0+1+2+...+..9 = 55
	print (reduce(sum,range(0,0),10))		#返回空的列表，在加上10，结果为10
```
map(),map可以对元组进行解包。调用时，map的第一个参数是None。
```python
	class  map(object)
		map(func,*iterables) -->map object
```

参数func是自定义的函数，实现对序列每个元素的操作

参数iterables是待处理的序列，参数iterables的个数可以是多个

map的返回值是对序列元素处理后的列表
```python
	def power(x):
		return x**x
	print (map(power,range(1,5)))
	print (list(map(power,range(1,5))))	#[1,4,27,256]

	def power2(x,y):
		return x ** y
	print (map(power2,range(1,5)),range(5,1,-1))
	print (list(map(power2,range(1,5)),range(5,1,-1)))#[1,16,27,16]
```
如果Map中提供多个序列，则每个序列中的元素一一对应进行计算。如果每个序列的长度不相同，则短的序列后补充None，再进行计算。

常用的内置模块函数

abs(x):返回x的绝对值

bool(x):把一个值或表达式转换为bool类型，如果是表达式x为值，返回true，否则返回false

eval(s[,gloabl[,local]]):计算表达式的值

float(x)把数字或字符串转换为浮点类型

hash(object):返回一个对象的hash值

help(object):返回内置函数的帮助说明

id(x):返回一个对象的id

input([prompt]):接受控制台的输入，并把输入的值转换为数字

int(x):把数字或字符串转换我整形

len(obj):对象包含的元素的个数

range([start,]end[,step]):生成一个列表并返回

reduce(func,sequence[,initial]):对序列的值进行累计操作

round(x):四舍五入

set([iterable]):返回一个set集合

sort(iterable[,cmp[,key[,reverse]]]):返回一个sort后的列表

sum(iterable[,start=0]):返回一个序列的和

type(obj):返回一个对象的类型

zip(iter1[,iter2[..]]):把n个序列作为列表的元素返回

**自定义包**

包就是一个`至少包含__init__.py`的文件夹，包就是为了`实现程序的重用`，它实现一个常用的功能的代码组合到一个包总，调用包的服务从而实现重用。
```python
	---parent
		| __init__.py
		|pack
			| __init__.py
			| myModule.py
		|pack2
			| __init__.py
			| myModule.py

	#pack中的myModule.py
	def func():
		print ("pack.myModule.func")

	if __name__ == '__main__':
		print ('myModule作为主程序运行')
	else:
		print ('myModule被另一个模块调用')

	#pack2的myModule2模块
	def func():
		print ('pack2.myModule.func')
	if __name__ == '__main__':
		print ('myModule2作为主程序运行')
	else:
		print ('myModule2被另一个程序调用')

	#main 模块来调用两个pack的函数
	from pack import myModule
	from pack2 import myModule2

	myModule.func()
	myModule2.func()

```
\_\_init\_\_.py，也可以用于提供当前包的模块列表，例如，在pack包的\_\_init\_\_.py文件中前面添加一行代码

```python
	__all__ = ["myModule"]
```

\_\_all\_\_用于记录当前pack包所包含的模块。其中方括号中的内容是`模块名的列表`，如果模块数量超过2个，使用逗号分开。同理，在pack2包也添加一行类似的代码
```python
	__all__ = ["myModule2"]
```
这样就可以在main模块中一次导入pack,pack2包中所有的模块
```python

	#main 模块来调用两个pack的函数
	from pack import *
	from pack2 import *

	myModule.func()
	myModule2.func()
```
首先执行pack中init文件，然后在all属性查找pack包含的模块，如果没有记录的模块，就会报错。

函数：函数就是一段可以`重复多次调用的代码`，通过输入的参数值，返回需要的结果

函数定义：使用关键字def,函数在使用前，必须定义，函数的类型即返回值的类型
```python
	def funName(参数1，参数2,...):
		...
	return 表达式
```
参数中，用逗号隔开的，这些都是形式参数，括号后面以冒号结束，冒号下面就是函数的主体。实际参数必须与形式参数一一对应，否则将出现错误计算，具有默认值的参数例外。

函数的参数：在C/C++中参数的传递有值传递和引用传递两种方式，而Python中任何东西都是对象，所以参数只支持引用传递的方式，Python通过名称绑定的机制，把实际的参数和形式参数绑在一起。即把形式参数传递到函数所在的`局部命名空间中`，形式参数和实际参数`指向内存中同一个存储空间`

函数的参数支持默认值，当某个参数没有传递实际值时，函数使用默认的参数进行计算。
```python
	def arithmetic(x = 1,y = 1,operator = "+"):
		result = {
			"+" : x + y
			"-" : x - y
			"*" : x * y
			"/" : x / y
		}
```
参数可以是变量，也可以是元组，列表等内置数据结构。

`列表作为参数传递`
```python
	def arithmetric(args=[],operator="+"):
		x = args[0]
		y = args[1]
		result = {
			"+" : x + y
			"-" : x - y
			"*" : x * y
			"/" : x / y
		}
	print (arithmetric([1,2]))


	def func(*args):
		print args

	func(1,2,3)
```
Python还提供了另外一个标识符"\*\*"，在形式参数的前面添加"\*\*",可以引用一个字典。根据实际的参数的赋值表达式生成字典。

**传递可变参数**
```python
	def search(*t,**d):
		keys = d.keys()
		values = d.values()

	search("one","three","one=1","two=2","three=3")
```

**函数的返回值**

返回值使用return语句，return语句后面可以是变量或表达式。

**没有返回值的函数**
```python
	def func():
		pass	#pass关键字，相当与占位符
	print (func())
```
None是Python中的对象，不属于数字也不属于字符串。当函数中return语句不带`任何参数时`，返回的结果也是`None`
```python
	def func():
		return

	print (func())
```
如果需要`返回多个值`,可以把这些值`打包`到元组中，在调用时，对返回的元组进行`解包`即可，下面的代码实现输入变量的反转。例如输入1,2,3输出2,1,0
```python
	#返回多个值
	def func(x,y,z):
		l = [x,y,z]
		l.reverse()
		numbers = tuple(l)
		return numbers

	x,y,z = func(0,1,2)
	print (x,y,z)

	#second
	#返回多个值
	def func(x,y,z):
		l = [x,y,z]
		l.reverse()
		a,b,c = tuple(l)	#解包
		return a,b,c

	x,y,z = func(0,1,2)
	print (x,y,z)
```
**嵌套函数**

函数的嵌套是指在`函数的内部调用其他函数`，函数的嵌套层数不能过多，否则，容易造成`代码的可读行差，不易维护等问题`，一般函数的嵌套控制在3层以内。
```python
def sum(a,b):
	return a + b
def sub(a,b):
	return a - b

def func():
	x = 1
	y = 2
	m = 3
	n = 4
	return sum(x,y)*sub(m,n)

print (func())

#second

def func():
	x = 1
	y = 2
	m = 3
	n = 4
	def sum(a,b):
		return a + b
	def sub(a,b):
		return a - b
	return sum(x,y)*sub(m,n)

print (func())

#three
#内部函数可以直接调用外部函数定义的变量
def func():
	x = 1
	y = 2
	m = 3
	n = 4
	def sum():
		return a + b
	def sub():
		return a - b
	return sum()*sub()

print (func())
```

**递归函数**

递归函数需要`编写递归结束的条件`，否则，递归程序将无法结束。一般通过判断语句来结束程序
```python
#计算阶乘
def refunc(n):
	i = 1
	fi n > 1:
		i = n
		n = n * refunc(n-1)
	print ("%d! =",%i,n)
	return n

refunc(5)
```
每次调用递归函数都会复制函数中的所有变量，再执行递归函数。程序需要更多的存储空间，对程序的性能有一定的影响，因此，对于没有必要进行递归的程序，最好`其他方法进行改进`
```python
#使用reduce计算阶乘
from functools import reduce
print ("5! = ",reduce(lambda x,y:x*y,range(1,6)))
```

**lambda函数**

lambda函数用于创建一个匿名函数，函数名未知和标识符进行绑定。使用lambda函数可以返回一些简单的运算结果，lambda函数的格式：
```python
	lambda 变量1，变量2，...:表达式
```
```python
#赋值
func = lamdba 变量1，变量2...:表达式

func()
#这样就就把lambda和变量func绑定到一起了，变量func的名称即使函数名，lambda可以消除内部函数

def func():
	x = 1
	y = 2
	m = 3
	n = 4
	sum = lambda x,y:x+y
	pirint (sum)
	sub = lambda m,n:m-n
	pirint (sub)
	return sum(x,y)*sub(m,n)

print (func())

#一个数的绝对值
print ((lambda:x-x)(-2))		#输出2
```
**Generator函数**

生成器的作用使一次产生一个数据项，并把数据项输出。Generator函数可以在`for循环中遍历`，Generator函数每次`返回一个数据项的特性`，使得迭代器的性能更佳。

Generator函数定义
```python
	def 函数名(参数列表):
		....
		yield 表达式
```
Generator函数的定义和普通函数定义没有什么区别，只要在函数体内使用yield生成数据项即可。Generator函数可以在`for循环中遍历`,而且可以通过next()方法获得yield生成的数据项。
```python
#定义Generator函数
def func(n):
	for i in range(n):
		yield i

#for loop
for i in func(3):
	print (i)

#使用next方法
r = func(3)
print (r.next())
print (r.next())
print (r.next())
print (r.next())

```

yield 和 return的区别:原理不相同，yield生成值并不会中止程序的执行，返回值后程序继续往后执行。return返回值后，程序将中止执行
```python
def func(n):
	for i in range(n):
		return i

def func2(n):
	for i in range(n):
		yield i

print (func(3))

f = func2(3)
print (f.next())
print (f.next())

```

Generator函数可以返回元素的值，而序列也可以获取元素的值。但是两者还存在很大的区别。Generator函数一次只返回一个数据项，占用更少的内存。每次生成数据都要记录当前状态，便于下一次生成数据。数据的访问是通过next方法实现的。当访问越界时，Generator函数会抛出异常StopIteration。序列一次返回所有的数据，元素的访问是通过索引来完成的，当访问越界时序列提示list index out of range.

当程序需要`较高的性能或一次需要一个值进行处理`，使用Generator函数，当需要`一次获取一组元素时，使用序列`

---

### 字符串与正则表达式

Python中也提供了字符串格式化，将若干值插入`带有"%"标记的字符串中，从而可以动态的输出字符串`。
```python
"%s" %str				#单个格式化
"%s %s" %(str1,str2)	#多个格式化
```
code:
```python
#格式化字符串
str1 = "verison"
num = 1.0
format = "%s" %str1
print (format)

format = "%s %d" %(str1,num)
print (format)
```
如果要格式化多个值，元组中的元素的顺序必须和格式化字符串的替代的顺序`完全一致`，否则会出现类型不匹配的问题，比如上面的code如果替换，就会跑出异常

```python
#带有精确度的格式化
print ("the :%f" %1.25))
print ("the :%.1f" %1.25))	#精确到小数点后一位
print ("the :%f.2" %1.25))	#精确到小数点后两位
```
其他的格式：%c,%s,%d,%u,%o,%x,%X,%f,%e,%E,%g,%G,%p.要输出%可以通过%%来输出
```python
#使用字典格式多个值
print ("%(version)s:%(num)1.f"%("version":"version","num":2))

#字符串对齐

word = "version3.0"

print (word.center(20))
print (word.center(20,"*"))
print (word.ljust(0)
print (word.rjust(20)
print ("%30s"%word)
```
转义字符\会经常遇到。\n,\t各占一个字符，Python中还提供了strip,lstrip,rstrip函数来去掉字符串中的转义字符.

字符串的合并，使用+来实现。可能有些麻烦，Python提供了join连接字符串函数
```python
#join
strs = ["hello","world"]
result = "".join(strs)
print result

#reduce
from functools import reduce
import operatro
strs = ["hello","world"]
result = reduce(operator.add,strs,"")
print result
#两者的结果是一样的

```
字符串的截取string[start:end:step]
```python
str1 = "hello world"
print (str1[0:3])		#第一个字符到第三个字符
print (str1[::3])		#省略了开始和结束的字符，从字符串的第一个字符开始以2为步长逐个截取字符
print (str1[1::2])		#从第二个字符开始，以步长为2截取字符
```
如果要同时截取多个子串，可以使用函数split函数
```python
split([char][,num])
```
参数char表示用于分割的字符，默认的分割字符是空格，num表示分割的次数。如果num等于2，将把源字符串分割为3个子串，默认将根据字符char在字符串中出现的个数来分割子串，函数的返回值是由子串组成的列表
```python
sentence = "bob said:1,2,3,4"
print ("使用空格取子串:",sentence.split())
print ("使用逗号取子串:",sentence.split(","))
print ("使用两个逗号取子串:",sentence.split(",",2))
```
字符串连接之后，Python将分配新的空间给连接后的字符串，源字符串保持不变。
```python
str1 = "a"
print (id(str1))
print (id(str1 +"b"))		#两个结果不一样
```
字符串的比较
```python
str1 = 1
str2 = "1"
if str1 == str2:
	print ("the same")
else:
	print ("the same not")

if str(str1) == str2:
	print ("the same")
else:
	print ("the same not")
```
比较字符，python提供了startswith()和endswith()函数
```python
#比较两个字符的开始和结束
word = "hello world"
print ("hello" == word(0,5))
print (word.startswith("hello"))
print (world.endswith("ld",6))
print (world.endswith("ld",6,10))
print (world.endswith("ld",6,len(word)))
```
`startswith(),endswith()相当于分片[0:n]`，n是源字符串的最后一个索引，这两个`不能用于比较源字符串中任意一部分的子串`。

字符串反转
```python
#循环实现字符串反转
def reverse(s):
	out = ""
	li = list(s)
	for i in range(len(li),0,-1):
		out += "".join(li[i-1])
	return out

#使用list的reverse方法
def reverse(s):
	li = list(s)
	li.reverse()
	s = "".join(li)
	return s

#很简单的一种
def reverse(s):
	return s[::-1]
```
字符串的查找和替换,Python中提供了find函数

	find(substring[,start[,end]])

参数substring表示待查找的字符串，start表示开始索引的位置，end表示结束索引的位置，即在分片[start:end]中查找。如果找到字符串substring，则返回substring在`源字符串中第一次出现的索引`，否则返回-1.rfind的参数和find是一样的。不同的是从 字符串的尾部开始查找子串。
```python
#查找字符串
sen = "this is a apple"
print (sen.find("a"))		# 8		第一次出现的索引
sen = "this is a apple"
print (sen.rfind("a"))		# 10	最后一次出现索引
```
repacle函数repale(old,new[,max]):old表示被替换的字符串，new：表示替换old的字符串，参数max表示使用new替换old的次数，返回一个新的字符串，如果字符串old不在源字符串中，则函数返回源字符串的值。
```python
#字符串的替换
sen = "hello world,hello china"
print (sen.replace("hello","hi"))		#全部替换
print (sen.replace("hello","hi",1))		#第一个被替换
print (sen.replace("abc","hi"))			#替换失败，返回源字符串
```
日期与字符串的转换

Python中提供了time模块处理日期和时间，

**时间到字符串**

函数strftime()可以从时间到字符串的转换,strftime的声明


	strftime(format[,tuple]) -> string

参数format表示格式化日期的特殊字符，例如,"%Y-%m-%d",参数tuple表示需要转换的时间，用元组存储，元组中的元素分别表示年，月，日，时，分，秒。函数返回一个表示时间的字符串

**字符串到时间**

字符串到时间需要进行两次转换，需要使用time模块和datetime模块，转换的过程分为三个步骤

 + 调用函数strptime()把字符串转换为一个元组，进行第一次转换。strptime()的声明如:strptime(string,format) -> struct\_time,参数string表示需要转换的字符串，参数format表示日期时间的输出格式。函数返回一个存放时间的元组。
 + 把表示时间的元组赋给表示年，月，日的三个变量
 + 把表示年，月，日的三个变量传递给函数datetime()，进行第二次转换，datetime类的datetime函数为datetime(year,month,day[[,hour[,minute]]]),参数year，month，day分别表示年，月，日，这三个参数不可少。函数返回一个datetime类型的变量

```python
import time ,datetime

#时间到字符串的转换
print (time.strftime("%Y-%m-%d %X",time.localtime()))

#字符串到时间的转换
t = time.strptime("2005-02-04","%Y-%m-%d")
y,m,d = t[0:3]
print (datetime.datetime(y,m,d))
```
格式化日期的特殊标记是`区分大小写的`


**正则表达式**

正则表达式的特殊字符

 + ^	正则表达之的开始字符
 + $	正则表达之的结束字符
 + \w	匹配字母，数字，下划线
 + \W	匹配不是字母，数字，下划线
 + \s	匹配空白字符
 + \S	匹配不是空白字符
 + \d 	匹配数字
 + \D	匹配非数字
 + \b	匹配单词的开始和结束
 + \B	匹配不是单词的开始和结束
 + .	匹配任意字符，包括汉字
 + [m]	匹配单个字符串
 + [m1m2..n]	匹配多个字符串
 + [m-n]	匹配m-n区间的数字，字母
 + [^m]		匹配除m以外的字符串
 + ()		对正则表达式进行分组，一对圆括号表示一组

`note`其中，匹配符"[]"，可以指定一个匹配范围，例如"[ok]",将匹配包含"o"或"k"的字符。同时"[]",可以与\w,\s,\d等标记等价，如[0-9a-zA-Z] 等价\w [^0-9]等价\D

^与[^m]两个是不同的，后者的"^"表示除了的意思

正则表达式中的常用限定符

 + * 匹配`零次或多次`
 + + 匹配`一次或多次`
 + ? 匹配`一次或零次`
 + {m} 重复m次
 + {m.n} 重复m到n次，其中n可以省略，表示m到`无限次`

利用{}可以控制重复的次数，\d{1,4}表示1~3为数字，"("和")"是正则表达式中特殊的字符，如果把它们作为普通字符处理需要加上转义\


`限定符与?的组合`

 + *? 匹配零次或多次，且最短匹配
 + +? 匹配一次或多次，且最短匹配
 + ?? 匹配一次或零次，且最短匹配
 + {m.n}? 重复m次，且最短匹配
 + (?#...) 表达式中的注释
 + (?P<name>) 给分组命令，name表示分组的名称
 + (?P=name) 使用名为name的分组

**re模块**

```python

In [1]: import re

In [2]: s = "HELLO WORLD"

In [3]: s
Out[3]: 'HELLO WORLD'

In [4]: print (re.findall(r"^hello",s))
[]

In [5]: print (re.findall(r"^hello",s,re.I))			#忽略大小写
['HELLO']

In [6]: print (re.findall("WORLD$",s,))
['WORLD']

In [7]: print (re.findall(r"World$",s,re.I))
['WORLD']

In [8]: print (re.findall(r"\b\w+\b",s))				#匹配英文单词
['HELLO', 'WORLD']

################################################

In [1]: import re

In [2]: s = "hello world"

In [3]: print (re.sub("hello","hi",s))	#sub()先创建变量s的拷贝，然后在拷贝中替换字符串，并不会改变变量s的内容
hi world

In [4]: print (re.sub("hello","hi",s[-4:]))
orld

In [5]: print (re.sub("world","China",s[-5:]))
China

```
与sub类似的就是subn功能相同，但是多返回一个值，即匹配后的替换次数
```python
import re

########compile
s = "1abc23def45"
p = re.compile(r"\d+")
print (p.findall(s))
print (p.pattern)

```

正则表达的分组
```python
import re
p = re.compile(r"(abc)\1")
m = p.match("abcabcabc")
print(m.group(0))
print(m.group(1))
print(m.group())


p = re.compile(r"(?P<one>abc)(?P=one)")
m = p.search("abcabcabc")

print (m.group("one"))
print (m.groupdict().keys())
print (m.groupdict().values())
print (m.re.pattern)
```

---

### 文件处理

**基本操作**

文件通常用于存储数据或应用系统的参数。Python提供了os，os.path,shutil模块处理文件，其中包括打开文件，读写文件，复制和删除文件等函数

**`文件的创建`**

	open(file,mode='r',buffering=-1,encoding=None,error=None,newline=None,closefd=True,opener=None) -> file object

参数file是被打开的文件名称，如果`文件不存在`，open将创建name文件，然后在打开该文件，参数mode是指文件打开的模式，文件的打开模式

 + r	以只读的方式打开文件
 + r+	以读写的方式打开
 + w	以写入的方式打开文件，先删除文件的原有内容，在重新写入新的内容，如果文件不存在，就创建一个新的文件
 + w+	以读写的方式打开文件，先删除文件的原有内容，在重新写入新的内容，如果文件不存在，就创建一个新的文件
 + a	以写入的方式打开文件，在文件的末尾追加新的内容，如果文件不存在，则创建一个新的文件
 + a+	以读写的方式打开文件，在文件的末尾追加新的内容，如果文件不存在，则创建一个新的文件
 + b	以二进制的模式打开文件，可与r,w,a,+结合使用
 + U	支持所有的换行符号，"\r","\n","\r\n"都表示换行

参数buffering设置缓存模式，0表示不缓存，1表示行缓冲，如果大于1则表示缓冲区的大小，以字节为单位。open返回1个file对象，file对象可以对文件进行各种操作。

文件的常用属性和方法

closed		判断文件是否关闭，如果文件关闭，返回True

encoding	显示文件的编码类型

mode		显示文件的打开模式

name		显示文件的名称

newline		文件使用的换行模式

file(name[,mode[,buffering])	以mode的方式打开文件，如果不存在就创建，再打开文件buffering表示缓存模式，0不缓存，1表示行缓存，大于1表示缓冲区的大小

flush()		把缓冲区的内容写入磁盘

close()		关闭文件

read([size])	从文件中读取size个字符的内容，作为字符串返回

readline([size])	从文件中读取一行，如果指定size，表示每行每次读取的字节数，依然`读完整行的内容`

realines([size])	把文件中的每行存储在列表中返回，如果指定size，表示每次读取的字节数

seek(offset[,whence])	把文件指针移动到一个新的位置，offset表示相对于whence的位置，whence：0表示文件开头，1文件当前位置，2表示文件末尾

tell()		返回文件指针当前的位置

next()		返回下一行的内容，将文件制作移动到下一行

truncate([size])	删除size个字节的内容

write(str)			把字符串写入到文件

writelines(sequence\_of\_string)	把字符串序列写入到文件

```python
#create file
context = ```hello world```

f = open('hello.txt',w)	#open file
f.write(context)		#write str
f.close()				#close file
```

**`文件的读取`**

文件的读取有多种方式，可以使用readline,readlines,read函数读取文件

 + readline

readline每次读取文件中的一行，需要使用永真表达式读取文件，当文件指针移动到文件的末尾，依然用readline读取文件将出现错误，因此需要添加yield判断语句，如果到末尾，就跳出loop

```python
f = open("hello.txt")
while True:
	line = f.readline()
	if line:
		print (line)
	else:
		break

f.close()
```

 + 多行读取方式readlines

使用readlines读取文件，一次性读取文件的多行数据

```python
f = file('hello.txt')
lines = f.readlines()
for line in lines:
	print (line)

f.close()
```
 + read

一次性读取所有的内容，并赋值给一个变量
```python
f = open('hello.txt')
context = f.read()
print (context)
f.close()

#控制read的参数
f = open('hello.txt')
context = f.read(5)
print (context)
print (f.tell())
context = f.read(5)
print (context)
print (f.tell())			#输出文件指针的位置
f.close()
```

**`文件的写入`**

文件的写入也有多种方法，可以使用write(),writelines()方法写入文件，write把字符串写入文件，writelines方法把列表中存储的内容写入文件

```python
#use writelines
f = file("hello.txt","w+")
li = ["helloworld \n","hello china"]
f.writelines(li)
f.close()

#追加新的内容到文件
f = fiel("hello.txt",a+)
context = "goodbye"
f.write(context)
f.close()
```
如果要写入的字符串非常多，可以使用writelines(),提供效率，如果需要写入少量的字符串，直接使用write即可

**`文件的删除`**

文件的删除需要使用os模块和os.path模块

os模块常用的函数

 + access(path,mode)			按照mode指定的权限访问文件
 + chmod(path,mode)				改变文件的访问权限，mode用UNIX系统中权限代号
 + open(filename,flag[,mode=777]) 按照mode指定的权限打开文件，默认情况下，给所有的用户读写执行
 + remove(path)					删除path的文件
 + rename(old,new)				重命名文件或目录
 + stat(path)					返回path指定文件的所有属性
 + fstat()						返回打开文件的所有属性
 + lseek()						设置文件的当前位置，返回当前位置的字节数
 + startfile()					启动关联程序打开文件
 + tmpfile ()					创建临时文件，文件创建在os的临时目录

os.模块的open与内建函数open的用法`不一样`,文件的删除需要调用remove函数实现，要删除文件之前要先判断文件是否存在，如存在则删除文件，否则不进行任何操作。

os.path模块常用的函数

 + abspath(path)	返回path所在的绝对路径
 + dirnaem(p)		返回目录的路径
 + exists(path)		判断文件是否存储
 + getatime(filename)	返回文件的最后访问时间
 + getctime(filename)	返回文件的创建时间
 + getmtime(filename)	返回文件的最后的修改时间
 + getsize(filename)	返回文件的大小
 + isab(s)				测试路径是否是绝对路径
 + isdir(path)			判断path是否为目录
 + isfile(path)			判断path是否为文件
 + split(p)				对路径进行分割，以列表的形式返回
 + splitext(p)			从路径中分割文件的扩展名
 + splitdriver(p)		从路径中分割驱动器的名称
 + walk(top,func,arg)	遍历目录数与os.walk的功能相同

```python
#文件删除
file("hello.txt""w")
if os.path.exists("hello.txt"):
	os.remove("hello.txt")
```

**`文件的复制`**

file类没有提供文件的直接复制方法，可以使用read,write方法，同样实现文件的复制功能

```python
#use read write to realise to cope file
src = file("hello.txt","w")
li = ["hello world\n","liangkangkang\n"]
src.writelines(li)
src.close()

#start copy file
src = open("hello.txt","w")
dst = open("hello2.txt","w")
dst.wrtie(src.read())		#一次复制所有内容
src.close()
dst.close()
```
使用shutil模块来实现文件的复制
```python
import shutil

shutil.copyfile("hello.txt","hello2.txt")
shutil.move("hello.txt","../")
shutil.move("hello2.txt","hello3.txt")

```

**`文件的重命名`**

os模块的rename函数实现文件或目录重命名
```python
#modify filename
import os
li = os.listdir(".")
print (li)

if "hello.txt" in li:
	os.rename("hello.txt","hi.txt")
elif "hi.txt" in li:
	os.rename("hi.txt",hello.txt)

#大量后缀的文件修改
#把后缀为html的文件改为htm
import os
files = os.listdir(".")
for filename  in files:
	pos = filename.find(".")
	if filename[pos + 1:] == "html":
		newname = filenaem[:pos+1]+"htm"
		os.rename(filename,newname)

#下面也是一种方法
import os
files = os.listdir(".")
for filename  in files:
	li = os.path.splitext(filename)		#返回文件名和后缀名的列表
	if li[1] == "html":
		newname = li[0] + ".htm"
		os.rename(filename,newname)
```

**`文件内容的搜索和替换`**

```python
#从文件hello.txt中找出字符串"hello",并统计"hello"出现的次数
import re

f1 = file("hello.txt",'r')
count = 0

for s in f1.readlines():
	li = re.findall("hello",s)
	if len(li) > 0:
		count = count + li.count("hello")

print ("the sum:" + str(count) + "hello")
f1.close()

#文件的替换
f1 = file("hello.txt","r")
f1 = file("hello2.txt","w")

for s in f1.readlines():
	f2.write(s.relplace("hello"),"hi")

f1.close()
f2.close()
```


**`文件的比较`**
python提供了difflib模块
```python
import difflib

f1 = file("hello.txt",'r')
f2 = file("hi.txt",'w')
src = f1.read()
dst = f2.read()

print (src)
print (dst)

s = difflib.SequenceMatcher(lambda x:x == "",src,dst)
for tag ,i1,i2,j1,j2 in s.get_opcodes():
	print ("%s src[%d;%d] = %s dst[%d:%d] = %d " %(tag,i1,i2,src[i1:i2],j1,j2,dst[j1:j2]))

```
配置文件模块configparser

**目录操作**

**`创建和删除目录`**

os模块中提供常用的目录处理函数

 + mkdir(path[,mode=0777])
 + makedirs(name,mode=511)
 + rmdir(path)
 + removedir(path)
 + listdir(path)
 + getcwd()
 + chdir(path)
 + walk(top,topdown=True,onerror=None)

目录的创建和删除可以使用mkdir,makedirs,rmdir,removedirs实现
```python
import os

os.mkdir("hello")
os.rmdir("hello")
os.makedirs("hello/world")
os.removedirs("hello/world")

```
如果需要一次性创建，删除多个目录，应使用makedirs,removedirs函数,mkdir和rmdir一次只能创建一个目录和删除一个目录


**`目录的遍历`**

目录的遍历有两种方式，递归函数，os.walk

```python
#递归遍历目录

import os
def VisitDir(path):
	li = os.listdir(path)
	for p in li:
		pathname = os.path.join(path.p)
		if not os.path.isfile(pathname)
			VisitDir(pathname)
		else:
			print (pathname)

if __name__ == "__main__":
	path = "."
	VisitDir(path)

#os模块提供了同名的函数walk函数，os.walk可用于目录的遍历，功能类似于so.path模块的walk函数,os.walk不需要回调函数，更容易使用。
#使用os.walk
import os
def VisitDir(path):
	for root,dir,files,in os.walk(path):
		for filepath in files:
			print (os.path,join(root,filepath))

if __name__ == "__main__"
	path = "."
	VisitDir(path)
```

**`文件和流`**

sys模块提供了3种基本的流对象stdin,stdout,stderr.

```python
#stdin
import sys
sys.stdin = open("hello.txt","r")
for line in sys.stdin.readlines():
	print (line)

#stdout
import sys
sys.stdout = opeon(r"hello.txt","a")
print ("goodbye")
sys.stdout.close()


#stderr

import sys,time
sys.stderr = open("record.log","a")
f = open(r"hello.txt","r")
t =- time.strftime("%Y-%m-%d %X",time.localtime())
context = f.read()
if context:
	sys.stderr.write(t+" "+context)
else:
	raise Exception,t+"raise excepion"

```

文件处理
```python
#文件属性浏览程序,通过给定的目录路径查看文件的名称，大小，创建时间，最后修改时间和最后访问时间。
#实现分为3个步骤
#1.通过遍历path指定的目录，获取每个子目录的路径
#2.遍历子目录的所有的文件，并返回文件的属性列表
#分解属性列表，对属性列表的值进行格式化输出

def ShowFileProperties(path):
	```显示文件 的属性，包含路径，大小，创建日期，最后修改日期，最后访问日期```
	import time,os
	for root,dirs,files,files in os.walk(path,True):
		print ("pos:"+root)
		for filename in files:
			state = os.stat(os.path.join(root,filename))
			info = "filename:"+filename+" "
			info = info +"size:"+("%d"%state[-4]) + " "
			t = time.strftime("%Y-%m-%d %X",time.localtime(state[-1]))
			info = info +"create itme:" + t + ""
			t = time.strftime("%Y-%m-%d %X",time.localtime(state[-2]))
			info = info +"last modify:" + t + " "
			t = time.strftime("%Y-%m-%d %X",time.localtime(state[-3]))
			info = info +"last access:" + t + " "
			print (info)

if __name__ == "__main__":
	path = "."
	ShowFileProperties(path)

```

---

### 面向对象编程

**面向对象概述**

 + 用例图

用例图描述`系统使用者与系统之间的交互关系`。用例图通常用在`系统的分析阶段`，分析系统中的`主要流程`。用例图用于描述`不同的业务实体，以及实体之间的关系`

 + 活动图

`活动图是对用例图的补充`,用与分析复杂的`用例`，表示用例中的`逻辑行为`，活动图类似于传统的`数据流程图`，可以描述业务的流程，帮助分析人员确定`用例中的交互及其关系`

 + 状态图

状态图用于`对系统的行为进行建模`，用于分析和设计阶段之间的过渡时期。状态图和活动图有些类似，状态图是对单个对象的描述，强调对象内部状态的变迁过程。

 + 类图

类图包括`属性，操作以及访问权限等内容。`类图用于系统设计阶段，根据系统用力提炼出系统中的对象。类图是面向对象设计的核心，通过类图`可以直接表示抽象，继承，多态等面向对象的特性`，能够表现系统架构设计及系统中`对象之间的层次关系`

 + 序列图和协助图

序列图和协助图都可以用于描述系统中对象之间的行为，是对系统具体行为的设计。序列图和协助图通常用于类图设计完成后的最后一个步骤。序列图是对用力的具体体现，通过消息的方式描述系统中对象的生命周期和控制流程，而协助图侧重与对消息的建模，描述`系统对象之间的交互关系`

 + 组件图和部署图

组件图用于描述`系统组件之间的交互，类和组件的依赖关系`，部署图用于描述系统的部署以及组件之间的配置。

这些图都可以使用UML来制作。

**类和对象**

类和对象是面向对象中的两个重要的概念。类是抽象，对象是实例。

Python使用class关键字定义一个类，类名的`首字符一般要写`
```python
#继承object
class Class_name(object):
	....

#不显示继承
class Class_name:


#demo
#类的创建
class Fruit:
	def __init__(self):
		self.name = name
		self.color = color
	def grow(self):
		print ("Fruit grow....")
```
类的方法必须有个self参数，但是在方法调用时，可以不传递这个参数。

```python
#对象创建

if __name__ == "__main__ :
	fruit = Fruit()
	furit.grow()
```

**属性和方法**

类由`属性和方法组成`,类的属性是对数据的封装，而类的方法则表示对象具有的行为，类通常有函数(实例方法)和变量(类变量)组成，Python的构造函数，析构函数，私有属性或方法都通过名称约定区分的。

Python使用`约定属性的名称来达到数据封装的目的`，如果属性的名字以两个下划线开始，就`表示为私有属性`，反之，没有使用下划线开始的都表示为共有属性，Python中没有保护类型的修饰符。

Python中的属性`分为实例属性和静态属性`。实例属性是一个self作为前缀的属性，\_\_ini\_\_方法即Python类的构造函数,静态变量可以被类直接调用，而不被实例化对象调用。当创建新的实例化对象后，静态变量并不会获得新的的内存空间，而是使用类创建的内存空间。因此，`静态变量`能够被多个实例化的对象`共享`,在Python中静态变量称为`类变量`，类变量可以在该类的所有`实例中`被共享。
```pyhon
class Fruit:
	price = 0					#类属性

	def __init__(self):
		self.color = "red"		#实例属性
		zone = "china"			#局部变量

if __name__ == "__main__":
	print(Fruit.price)
	apple = Fruit()
	print (apple.color)
	Fruit.price = Fruit.price + 10
	print ("apple's price :" +str(apple.price))
	banana = Fruit()
	print ("banaan's price :" + str(banana.price))
```
Python的类和对象都可以访问i`类属性`，而Java中的静态变量只能被类调用。

Python对类的属性和方法的定义次序并没有要求，合理的方式是把类属性定义在类中`最前面，然后在定义私有方法，最后定义共有方法`

**`内置属性`**
```python
class Fruit:
	def __init__(self):
		self.__color = "red"

class Apple(Fruit):
	"""this is doc"""
	pass

if __name__ == "__main__":
	fruit = Fruit()
	apple = Aplle()
	print (Apple.__bases__)		#输出基类的组成的元组
	print (apple.__dict__)		#输出属性组成的字典
	print (apple.__module__)	#输出类所在的模块名
	print (apple.__doc__)		#输出doc文档

```

**`方法`**

类的方法分为共有方法和私有方法。私有方法不能被模块外的类或方法调用，私有方法也不能被外部的类或函数调用。Python使用函数staticmethod()或者@staticmethod修饰器把普通的函数转换为`静态方法`，Python的中静态方法并没有和类的实例进行名称绑定，要调用只需要使用类名组委的它的前缀即可。
```python
class Fruit:
	price = 0								#类变量
	def __init__(self):
		self.__color = "red"				#定义私有变量

	def getColor(self):
		print(self.__color)					#打印私有变量

	@ staticmethod							#使用@staticmethod修饰器静态方法
	def getPrice():
		print (Fruit.price)

	def __getPrice():						#定义私有函数
		Fruit.price = Fruit.price + 10
		print (Fruit.price)

	count = staticmethod(__getPrice)		#使用staticmethod方法定义静态方法

if __name == "__main__":
	apple = Fruit()							#实例化apple
	apple.getColor()						#使用实例调用静态方法
	Fruit.count()							#使用类名调用静态方法
	banana = Fruit()
	Fruit.count()							#静态方法再次调用
	Fruit.getPrice()
```
类的外部不能`直接访问私有方法`

上面的代码的getColor方法中有1个参数self参数，该参数是`区别方法和函数的标志`。类的方法`至少需要一个参数`，该方法不必给该参数赋值。通常这个特殊的参数被命令为self，self参数表示指向`实例对象本身`，self参数是`用于区分函数和类的方法`,self必须显示调用，因为Python是动态语言，没有提供声明变量的方式，这样就无法知道在方法中要赋值的变量是不是局部变量或是需要保存成实例属性。

Python中还有一个种方法称为类方法。类方法是将本身作为操作对象的方法。类方法可以使函数classmethod或@classmethod修饰器定义。而与实例方法不同的是，把类方法作为第一个参数(cls)传递。把上面的静态方法，修改为类方法
```python
	@ cclassmethod
	def getPrice(cls):
		print(cls.price)


	def __getPrice(cls):
		cls.price = cls.price + 10
		print (cls.price)

	count = classmethod(__getPrice)
```
可见类方法和静态方法是十分相似的，`如果某个方法需要被其他实例共享，同事又需要使用当前实例的属性，则定义为类方法`

self参数的名称可以是`任意合法的变量名`，建议使用self作为参数名，便于程序的阅读和统一，对于类方法，约定使用cls作为参数名。

**`内部类的使用`**

在某个类的内部定义的类成为`内部类`，内部类中的方法可以使用两种方法调用

第`一`种方法是`直接使用外部类调用内部类`，生成`内部类的实例`，再调用内部类的方法
```python
object_name = outcloass_name.inclass_name()
object_name.method()
```
其中outclass\_name表示外部类的名称，inclass\_name表示内部类的名称，object\_name表示内部类的实例。

第`二`种方法先对外部类进行实例化，然后对实例化内部类，最后调用内部类的方法。
```python
out_name = outclass_name()
in_name = out_name.inclass_name()
in_name.method()
```
其中out\_name表示外部类的实例，in\_name表示内部类的实例
```python
class Car:
	class Door:					#内部类
		def open(self):
			print ("open door")
	class Wheel:				#内部类
		def run(self):
			print ("car run")


if __name__ == "__main__":
	car = Car()					#实例化car
	backDoor = Car.Door()		#内部类的实例化方法1类名
	fontDoor = car.Door()		#内部类的实例化方法2对象名
	backDoor.open()
	fontDoor.open()
	wheel = Car.Wheel()
	wheel.run()
```
内部类并不适合藐视类之间的组合关系，而把Door,Wheel类的对象作为类的属性使用。内部类容易造成`程序结构的复杂`，不提倡使用

**`__init__方法`**

构造函数用于初始化类的内部状态,Python的构造函数为\_\_init\_\_.除了用于定义实例变量外，还用于程序的初始化。\_\_init\_\_是`可选的`，如果不提供\_\_init\_\_方法，Python将会给出一个默认的\_\_init\_\_方法。
```python
class Fruit:
	def __init__(self,color):
		self.__color = color
		print (self.__color)

	def getColor(self):
		print (self.__color)

	def setColor(self.color):
		self.__color = color
		print (self.__color)


if __name__ == "__main__":
	color = "red"
	Fruit = Fruit(color)
	fruit.getColor()
	fruit.setColor("blue")
```
\_\_init\_\_方法和传统的开发语言一样不能`返回任何值`


**`__del__方法`**

析构函数用于释放对象占用的资源，Python提供了析构函数\_\_del\_\_(),析构函数可以释放对象的资源，是另一种释放资源的方法，析构函数是可选的，如果不提供，Python会在后台提供默认的析构函数
```python

class Fruit:
	def __init__(self):
		self.color = color

	def __del__(self):
		self.__color = ""

	def grow(self):
		print ("Fruit grow....")


if __name__ == "__main__ :
	color = "red"
	fruit = Fruit(color)
	furit.grow()
#使用Python编写程序，可以不考虑后台的内存管理，直接面对 程序编程
```

**`垃圾回收机制`**

Python提供了gc模块，如果要设置调用垃圾回收器，可以使用gc模块函数实现


**`类的内置方法`**

常用的内置方法
```python
__init__(self)				#初始化对象，在创建新对象时调用
__del__(self)				#释放对象，在对象释放被删除之前调用
__new__(cls,*args,**kwd)	#实例的生成操作
__str__(self)				#在使用print语句被调用
__getitem(self,key)			#获取序列的索引key对应的值，等价与seq[key]
__len__(self)				#在调用内联函数len()被调用
__cmp__(src,dst)			#比较两个对象src和dst
__getattr(s,name)			#获取属性的值
__setattr(s,name,val)		#设置属性的值
__delattr(s,name)			#删除name的属性
__call__(self,*args)		#把实例对象作为函数调用
__gt__(self,other)			#判断self对象是否大于other对象
__lt__(self,other)			#判断self对象是否小于other对象
__ge__(self,other)			#判断self对象是否大于或等于other对象
__le__(self,other)			#判断self对象是否小于或等于other对象
__eq__(self,other)			#判断self对象是否等于other对象

```
 + \_\_new\_\_()

\_\_new\_\_()在\_\_init\_\_()之前被调用，用于创建实例对象。利用这个方法和类的属性的特性可以实现设计模式中`单例模式`，单例模式是创建`唯一对象`，单例模式设计的类`只实例化一个对象`
```python
class Singleton(object):			#定义实例
	__instance = None

	def __init__(self):
		pass

	def __new__(cls,*args,**kwd):		#在__init__之前调用
		if Singleton.__instance is None:		#生成唯一实例
				Singleton.__instance = object.__new__(cls,*args,**kwd)
		return Singleton.__instance

```
 + \_\_getitem\_\_()

如果类中把某个属性定义为`序列`，就可以该方法输出序列中的各个元素。
```python
class FruitShop():
	def __getitem__(self):
		return self.fruit[i]

if __name__ == "__main__ :
	shop = FruitShop()
	shop.fruits = ["apple","banana"]		#给fruit赋值
	print (shop[1])
	for item in shop:						#输出水果
		print (item,end="")

```

 + \_\_str\_\_()

它表示对象代表的意义，返回一个字符串，实现了该方法后，就可以直接用print方法输出结果,也可以通过str()来出发\_\_str\_\_()的执行。这就把`对象和字符串关联起来`，便于某些程序的实现，可是用这个字符串表示某个类

```python
class Fruit:
	```Fruit class```
	def __str__(self):			#定义对象的字符串表示
		return self.__doc__		#doc

if __name__ == "__main__ :
	fruit = Fruit()
	print (str(fruit))			#调用__str__
	print (fruit)
```

 + \_\_call\_\_()

使用该方法可以`模拟静态方法`
```python
class Fruit:
	class Growth:			#内部类
		def __call__(self):
			print ("grow....")


	grow = Growth()			#返回__call__的内容

if __name__ == "__main__ :
	fruit = Fruit()
	fruit.grow()			#使用实例调用
	Fruit.grow()			#使用类名调用

```

**`方法的动态特性`**

Python作为动态语言，编写的程序具有很强的动态性，可以`动态的添加类的方法`，把某个定义的函数添加到类中

	class_name.method_name = function_name

```python
class Fruit:
	pass

def add(self):					#定义在类外部的函数
	print ("grow...")

if __name__ == "__main__ :
	Fruit.grow = add			#动态添加add函数
	fruit = Fruit()
	fruit.grow()
```
利用动态特性，可以对已经定义的方法，进行修改

	class_name.method_name = function_name

```python

class Fruit:
	pass

def update(self):					#定义在类外部的函数
	print ("grow...")

if __name__ == "__main__ :
	fruit = Fruit()
	fruit.grow()
	fruit.grow = update				#将grow方法更新为update方法
	fruit.grow()

```

**继承**

继承是面向对象的重要特性之一。通过继承可以创建新类，目的是使用或修改现有的类的行为。原始的类被成为父类或超类，新类称为子类或派生类。继承可以实现代码的重用.类之间存在`继承，组合，依赖等关系`，可以使用ＵＭＬ工具表示类之间的关系。

```python
class Fruit:
	def __init__(self,color):
		self.color = color
		print ("fruit's color :%s"%self.color)

	def grow(self):
		print ("grow...")

class Apple(Fruit):
	def __init__(self,color):
		Fruit.__init__(self.color)
		print ("apple's color ;%s"%self.color)

class Banana(Fruit):
	def __init__(self,color):			#调用父类的构造函数
		Fruit.__init__(self.color)
		print ("banana's color ;%s"%self.color)

	def grow(self):
		print ("banana grow...")

if __name__ == "__main__ :
	apple =  Apple("red")
	apple.grow()
	banana = Banana("yellow")
	banana.grow()
```
还可以使用super类的super()调用父来的构造函数。

	super(type,obj)

type是某个类，obj是type类实例化的对象，super可以绑定type类的对象。
```python
#使用super调用父类
class Fruit:
	def __init__(self):
		print ("parent")

class Apple(Fruit):
	def __init__(self,color):
		suple(Apple,self).__init__()		#使用ｓｕｐｅｒ调用父类
		print ("apple's color ;%s"%self.color)

if __name__ == "__main__ :
	Apple()

```
super类的实现代码继承了object,因此Fruit类必须继承object,如果不继承object,使用super将会出现错误。

**`抽象基类`**

抽象基类是对一类事物的特征行为的抽象，由抽象方法组成。在Python3中有abc模块,抽象基类`不能直接实例化`
```python
from abc import ABCMeta,abstractmethod
class Fruit(metaclass=ABCMeta):
	@abstractmethod
	def grow(self):
		pass

class Apple(Fruit):
	def grow(self):
		print("Apple growing")

if __name__ == "__main__ :
	apple = Apple()
	apple.grow()

```

**`多态性`**

同一种方法，实现不同的功能
```python
class Fruit:
	def __init__(self,color=None):
		self.color = color

class Apple(Fruit):
	def __init__(self,color = "red"):
		Fruit.__init__(self.color)


class Banana(Fruit):
	def __init__(self,color = "yellow")
		Fruit.__init__(self.color):			#调用父类的构造函数

class FruitShop:
	def sellFruit(self,fruit):
		if isinstance(fruit,Apple):
			print ("self apple")
		if isinstance(fruit,Banana):
			print ("self banana")
		if isinstance(fruit,fruit):
			print ("self fruit")

if __name__ == "__main__ :
		shop = FruitShop()
		apple = Apple("red")
		banana = Banana("yellow")
		shop.sellFruit(apple)		#参数多态性
		shop.sellFruit(banana)		#参数多态性
```

**`多重继承`**

Python支持多重继承，即１一个类可以继承多个父类。

	class_name(parent_class1,parent_class2...)

西瓜继承蔬菜和水果，蔬菜继承水果。

```python
class Fruit:
	def __init__(self):
		print ("initial Fruit")

	def grow(self):
		print ("grow ...")


class Vegetable(object):
	def __init__(self):
		print ("initial Vegetable")

	def plant(self):
		print ("plant...")

class Watermelon(Vegetable,Fruit):
	pass

if __name__ == "__main__ :
		w = Watermelon()
		w.grow()
		w.plant()

```
作为一般规则，在大多数程序中，最好避免多重继承，但是多重继承有利于定义所谓的混合类(Mixin)

**`Minix机制`**

还是苹果和香蕉的例子，都继承水果类，但是从去皮的角度，可以分为削皮和剥皮。
```python
class Fruit:
	def __init__(self):
		pass

class HuskedFruit(Fruit):
	def __init__(self)
		print ("initial HuskedFruit")

	def hush(self):
		print ("husk...")

class DecorticateFruit(Fruit):
	def __init__(self)
		print ("initial DecorticateFruit")

	def hush(self):
		print ("decorticate...")

class Apple(HuskedFruit):
	pass

class Banana(DecorticateFruit):
	pass

```
`如果按照季节对水果进行分类`，整个结构将发生变化。例如把水果分为夏季水果和冬季水果。

```python
class Fruit:
	def __init__(self):
		pass

class HuskedFruit(Fruit):
	def __init__(self)
		print ("initial HuskedFruit")

	def hush(self):
		print ("husk...")

class DecorticateFruit(Fruit):
	def __init__(self)
		print ("initial DecorticateFruit")

	def hush(self):
		print ("decorticate...")

class Apple(HuskedFruit,Fruit):		#水果，并且是削皮水果
	pass

class Banana(DecorticateFruit,Fruit):	#水果，并且剥皮水果
	pass

```

**运算符重载**

Python把运算符和类的内置方法`关联起来`，每个运算符都对应一个１个函数，例如,\_\_init\_\_()表示运算符"+"等

```python
class Fruit:
	def __init__(self,price=0):
		self.price = price

	def __add__(self,other):
		return self.price + other.price

	def __gt__(self,other):
		if self.price > other.price:
			flag = True
		else:
			flag = false
		return flag

class Apple(Fruit):
	pass

class Banana(Fruit):
	pass

if __name__ == "__main__ :
	apple = Apple()
	print ("apple price:",apple.price)
	banana = Banana()
	print ("bananan price:",banana.price)
	print (apple>banana)
	total = apple + banana
	print ("total:",total)

#对<< >>重载

import sys

class Stream:
	def __init__(self,file):
		self.file = file

	def __lshifht__(self,obj):		#对<< 进行重载
		self.file.write(str(obj))
		return self

class Fruit(Stream):
	def __init__(self,price=0,file=None):
		Stream.__init__(self,price)
		self.price = price

classs Apple(Fruit):
	pass

class Banana(Fruit):
	pass

if __name__ == "__main__ :
	apple = Apple(2,sys.stdout)
	banana = Banana(2,stdout)
	endl = "\n"
	apple << apple.price << endl;
	apple << banana.price << endl;
```

**Python设计模式**

设计模式是面向对象程序设计的解决方案，是复用性程序设计的经验总结。

设计模式根据目的不同而分为`创建型模式`,`结构型模式`,`行为模式`.

 + 创建型模式:提出了对象创建的解决方案，以及数据封装的方法。降低了创建对象时代码实现复杂度，使对象的创建能满足特定的要求，例如，工厂模式，抽象工厂模式，单例模式，生成器模式。
 + 结构型模式:描述了对象之间的体系结构，通过组合，继承等方式改善体系结构降低体系结构中组件的依赖性，例如，适配器模式，桥接模式，组合模式，装饰器模式，外观模式。
 + 行为型模式:描述了对象之间的交互和各自的职责，有助于实现程序中对象的通信和流程的控制，例如，迭代器模式，解释器模式，中介者模式，观察者模式。

```python
#python实现工厂模式
class Factory:						#工厂类
	def createFruit(self,fruit):	#工厂方法
		if fruit == "apple":		#如果是apple则返回类Apple
			return Apple()
		elif fruit == "banana":		#如果是banana则返回类Banana
			return Banana()

class Fruit:
	def __str__(self):
		return "fruit"

class Apple(Fruit):
	def __str__(self):
		return "apple"

class Banana(Fruti):
	def __str__(self):
		return "banana"


if __name__ == '__main__':
	factory = Factory()
	print (factory.createFruit("apple"))		#创建apple对象
	print (factory.createFruit("banana"))		#创建banana对象

```

工厂方法模式的应用非常广泛，通常用于设计对象的生成以及系统的框架。

---

### 异常处理与程序调试

异常是任何语言必不可少的一部分。Python提供了强大的异常处理机制，通过捕获异常可以提高程序的健壮性。异常处理还具有释放对象，中止循环的运行等作用。

异常如：序列的下标越界，打开不存在的文件，空引用等。

 + StopIteration,

 + ArithmeticError

 + AssertionError

 + AttributeError

 + BufferError

 + EOFError

 + ImportError

 + LookupError

 + MemoryError

 + NameError

 + OSError

 + ReferenceError

 + RuntimeError

 + SyntaxError

 + SystemError

 + TyepError

 + ValueError

 + WarningError


**异常处理**

**`Python中异常`**

**`try..except使用`**

**`try..finally使用`**

**`使用raise抛出异常`**

**`自定义异常`**

**`assert语句的使用`**

**`异常信息`**

---

## **Python应用**

### Python和HTML

---


### Python和XML

---


### Python-Django

 + django
 + MVC

---

### TDD

 + unittest
 + doctest

---

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

---


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

---

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

---

### ipdb

ipdb是pdb的交互式debug,ipdb debug.py 直接对程序进行调试

---
