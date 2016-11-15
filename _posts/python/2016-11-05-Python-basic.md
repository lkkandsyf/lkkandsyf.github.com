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

---



### 文件处理

---

### 面向对象编程


---


### 异常处理与程序调试


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
