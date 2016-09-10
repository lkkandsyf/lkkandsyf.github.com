---
layout: post
category : C++
tagline: "Supporting tagline"
tags : [interview C++]
---
{% include JB/setup %}


# Overview
{:.no_toc}


* dir
{:toc}

# `C++ basic `

## C++与C的不同

C是一个结构化语言，它的重点在于算法和数据结构。对语言本身而言，C是C++的子集。C程序的设计首先考虑的是如何通过一个过程，对输入进行运算处理，得到输出。对于C++，首先考虑的是如何构造一个对象模型，让这个模型能够配合对应的问题，这样就可以通过获取对象的状态信息得到输出或实现过程控制。`因此，C与C++的最大的区别在于，它们用于解决问题的思想方法不一样`。

C实现了C++中过程化控制以及其他控制功能，而在C++中的C，相对于原来的C还有所加强，引入的重载，内联函数，异常处理等。C++更是拓展的面向对象设计的内容，如类，继承，虚函数，模板和包容器类等。

在C++中，不仅需要考虑数据的封装，还需要考考对象粒度的选择，对象接口的设计和继承、组合与继承的使用等问题。相对于C，C++包含了更丰富的设计概念。

C是面向过程化的，但是C++不是面向对象化的。在C++中也完全可以写出与C一样过程化的程序，所以只能说C++拥有面向对象的特性，Java是真正面向对象化的。

## C++main函数之后要执行的函数

可以用atexit()函数来注册程序正常终止时要被调用的函数，并且在main()函数结束时，调用这些函数的顺序与注册他们的顺序相反。

## 定义宏得到一个字的高位和低位

一个字由两个字节组成。
{% highlight C linenos %}
#define WORD_LO(xxx) ((byte)((word)(xxx)&255))
#define WORD_HI(xxx) ((byte)((word)(xxx)>>8))
{% endhighlight %}

## define 得到一年中有多少秒

{% highlight C linenos %}
// 考虑大数的情况
#define TIME_SEC ((365*24*60*60)UL)
{% endhighlight %}

## const和宏的区别

const常量存在于程序的数据段，并在堆栈分配的空间。const常量是一个Run-Time的概念，它在程序中确确实实的存在着并可以被调用，传递。const常量有数据类型，而宏常量没有数据类型。编译器可以对const常量进行安全类型检查。

## C++中const的作用

 + const用于定义常量：const定义的常量编译器可以对其进行数据静态类型安全检查。
 + const修饰的函数形式参数：当传入参数为用户子定义类型和抽象数据类型时，应该将“值传递”改为“cosnt &传递”，可以提高效率.
{% highlight C linenos %}
void fun(A a);
void fun(A const &a);
{% endhighlight %}
第一个函数效率低。函数体内产生A类型的`临时对象用于复制参数a，临时对象的构造，复制，析构都将消耗时间`，第二个函数提高了效率。用`引用传递`不需要产生临时对象，节省了临时对象的构造，复制，析构过程消耗的时间。但光用引用有可能改变a，所以要加const。
 + const修饰函数的返回值：如给`指针传递`的函数的返回值加const，则返回值不能被直接修改，且该修改的值只能被赋值给加const修饰的同类型指针.
{% highlight C linenos %}
const char *GetChar(void){}
char *ch = GetChar();	// error
const char * ch = GetChar();	// correct
{% endhighlight %}
 + const修饰的成员函数（函数定义体）；任何不会修改数据成员的函数都应该用const修饰，这样，当不小心修改了数据成员或调用了非const成员函数时，编译器都会报错，const的修饰类型
{% highlight C linenos %}
int GetCount(void) const;
{% endhighlight %}

## static有什么作用

在C语言中，关键static的3个明显的作用：
 + 在函数体，一个被声明为静态的变量在这一函数被调用的过程中国，维持它的值不变。
 + 在模块内(但在函数体外)，一个被声明被静态的变量可以被其他模块内的所有函数访问，但是不能被模块外其他函数访问。它是一个本地的全局变量。
 + 在模块内，一个被声明为静态的函数只可被这一模块内的其他函数调用。那就是这个函数被限制在声明它的模块的本地范围内使用。

## static 全局变量与普通的全局遍历的区别

 + static全局变量与普通全局变量的区别是，`static全局变量只初始化一次`，防止在其他文件中被引用。
 + static局部变量和普通局部变量的区别是，`static全局变量只初始化一次`，下一次的依据是上一次的结果。
 + static函数与普通函数的区别是，`static函数在内存中只有一份`，普通函数在每个函数被调用中维持一份复制品。

## sizeof和strlen的区别

 + sizeof是操作符，strlen是函数。
 + sizeof操作符的结果类型是size_t,它的头文件typedef 为 unsigned int类型，该类型保证能容纳实现所建立的最大对象的字节大小。
 + sizeof可以用类型参数，strlen只能是char\*做参数，且必须是以“\0”结尾的。
 + 数组做sizeof的参数不退化，传递给strlen就退化为指针了。
 + 大部分编译程序的在编译的时候，sizeof就被计算过了，这就是sizeof(x)可以数组维数的原因。strlen的结果要在运行的时候才能计算出来，它用来计算字符串的长度。
 + sizeof后如果是类型，必须加括弧；如果是变量名，可以不加括弧。这是因为sizeof是个操作符，不是个函数。
 + 在计算字符串数组的长度上有区别，strlen不包括‘\0’,但是sizeof包含这个，所以会比它多1.
{% highlight C linenos %}
char  str[100] = "12";
int a = strlen(str);	// 2
int b = sizeof(str);	// 100
{% endhighlight %}
 + 如果要计算`指针指向的字符串的长度，则一定要使用strlen`。例如
{% highlight C linenos %}
char  *str = "12";
int a = strlen(str);	// 2
int b = sizeof(str);	// 4
{% endhighlight %}
<font color="red"> note:sizeof(enum) = 4 <==> sizoef(int) = 4</font>

## sizeof有哪些用途

 + 与存储分配和I/O系统那样的例程进行通信
{% highlight C linenos %}
void *malloc(size_t size);
size_t fread(void *ptr,size_t size,size_t nmemb,FILE *stream);
{% endhighlight %}

 + 查看某个类型的对象在内存中所占的单元字节
{% highlight C linenos %}
void *memset(void *s,int c,sizeof(s));
{% endhighlight %}

 + 在动态分配一对象时，可以让系统知道分配多少内存
 + 由于操作数的字节在实现时可能出现变化，建议在涉及操作数字字节大小时，用sizeof来代替
 + 如果操作树是函数中的数组形参或函数类型的形参，则sizeof给出其指针的大小。

## inline和宏的区别

 + 内联函数在编译时展开，宏在预编译时展开。
 + 在编译的时候，内联函数可以直接被镶嵌到目标代码中，而宏只是一个简单文本替换。
 + 内联函数可以完成像类型检测，语句是否正确等编译功能，宏不具有这样的功能。
 + 宏不是函数，inline是函数
 + 宏在定义时要小心处理宏参数（一般情况是把参数用括号括起来），否则容易出现二义性，内联函数的定义不会出现二义性。

## 指针和引用的区别

 + 初始化要求不同。引用在创建的同时必须初始化，即引用到一个有效的对象；而指针在定义的时候不必初始化，可以在定义的后面的任何地方重新赋值。
 + 可修改性不同，引用一旦被初始化为指向一个对象，它就不能被改变为另一个对象的引用；而指针在任何的时候都可以改变指向另一个对象。`给引用赋值并不是改变它和原始对象的绑定关系。`
 + 不存在NULL的引用，引用不能使用指向空值的引用，它必须总是指向某个对象，而指针可以为NULL，不需要总是指向某些对象，可以把指针指向任意的对象，所以指针更加灵活，也容易出错。
 + 测试需要的区别。由于引用不会指向空值，这意味着引用之前需要测试它的合法性；而指针则需要经常测试。因此使用引用的代码比使用指针的要高。
 + 应用的区别，如果是指向一个对象后就不会改变指向，用引用，如果有存在指向NULL（不指向任何对象）或在不同的时刻指向不同的对象的这可能性，就应该使用指针。
 + 实际上,在语言层面上，引用和对象一样，`在二进制层面，引用一般都是通过指针来实现的`,只不过编译器帮我们完成了转换。总的来说引用既具有指针的效率，也具有变量使用的方便性和直观性。

## 为什么传引用比传指针安全

由于不存在空的引用，并且引用一旦被初始化为指向一个对象，它就不会改变，因此很安全。对于指针，它可以随时指向别的对象，并且可以被初始化，或为NULL，所以不安全。const指针仍然存在空指针，并且可能产生野指针。

## 复杂指针的声明

 + a.一个整型数
 + b.一个指向整型数的指针
 + c.一个指向指针的指针，它指向的指针是指向一个整型数
 + d.一个有10个整型数的数组
 + e.一个有10个指针的数组，该指针是指向一个整型数
 + f.一个指向10个整型数组的指针
 + g.一个指向函数的指针，该函数有个整型参数并返回一个整型数
 + h.一个有10个指针的数组，该指针指向一个函数，该函数有一个整型参数并返回一个整型数。

{% highlight C linenos %}
/*
a.int	a;	an integer
b.int*	a;	a pointer to an integer
c.int**	a;	a pointer to a pointer to an integer
d.int	a[10];	an array of 10 integer
e.int*	a[10];	an array of 10 pointer to integer
f.int(*)	a[10];	a pointer to an array of 10 integer
g.int (*a)(int);	a pointer to function a that take an integer argument and returns an integer
h.int (*a(10)(int)an array of 10 pointer to functions that take an integer argument and return an integer

int (*fun)(int *p);
int (*fun)(int *p,int (*f)(int *));
int (*fun[5])(int *p);

int (*(*fun)[5])(int *p);
fun是一个指向数组的指针，这个数组的元素是函数指针，这些指针指向具有int *类型的形参，返回值为int类型的函数。
int (*(fun)(int *p))[5];
fun是一个函数指针，这类函数具有int*类型的形参，返回值是指向数组的指针，所指向的数组元素是具有5个int元素的数组。
*/
{% endhighlight %}

<font color="red">note:int (*(fun)(int *p))[5]; 这个不是很好理解</font>

## 指针常量和常量指针的区别

 + 常量指针，表述为`是常量的指针`，它首先应该是一个指针
 + 指针常量，表述为`是指针的常量`，它首先应该是一个常量

常量指针就是指向常量的指针，它所指向的地址的内容是不可修改的。

指针常量就是指针的常量，它是不可改变地址的指针，但是可以对它所指向的内容进行修改。

## 指针数组和数组指针

 + 指针数组表示它是一个数组，并且数组中的每一个元素是指针。
 + 数组指针表示它是一个指针，并且指向了一个数组。


## 函数指针和指针函数

 + 函数指针是指向函数指针的指针
 + 指针函数是返回指针类型的函数

## 各种指针的定义

 + a.含有10个元素的指针数组
 + b.数组指针
 + c.函数指针
 + d.指向函数的指针数组

```C
int *a[10]
int *n = new int[10];
void (*fun)(int,int);
int (*fnArray[10])(int,int)
```

 + 1.函数指针
 + 2.函数返回指针
 + 3.const指针
 + 4.指向const指针
 + 5.指向const的const指针

```C
void (*func)(int,int);
int *fun();
const int *p;
int *const p;
const int * const ptr;
```

## typedef用于定义函数指针的含义

{% highlight C linenos %}
typedef int (*pfun)(int x,int y);
int fun(int x,int y);
pfun p = fun;
int ret = p(2,3);
{% endhighlight %}

 + 定义pfun类型，表示一个函数指针类型
 + 定义了一个函数
 + 定义了一个pfun类型的函数指针p，并赋给它pfun的地址
 + 调用p(2,3)，实现fun(2,3)的调用功能

## 什么是野指针

`野指针`不是NULL指针，而是指向`垃圾`内存指针，野指针的成因主要有两种：
 + 指针变量没有初始化
 + 指针被free或者delete之后，没有置为NULL

`野指针`不是NULL指针，而是指向`垃圾`内存的指针，其主要为：指针变量没有被初始化，或者指针被free或者delete之后，没有置为NULL。

## 有了malloc/free,为什么还要new/delete

malloc与free是C/C++的标准库函数，new/delete是C++的运算符。它们都可以用于申请动态内存和释放内存。

对于非内部数据类型的对象而言，对象在消亡之前要自动执行析构函数。由于malloc/free是库函数而不是运算符，不在编译器控制权限之内，不能把执行构造函数和析构函数的任务强加于malloc/free，因此只有使用new/delete运算符。

mem alloc:

C语言的标准内存分配函数：malloc，calloc，realloc，free等
malloc与calloc的区别为1块与n块的区别

 + malloc的调用形式(type*)malloc(size):在内存的动态存储区分配一块长度为size字节的连续内存区域，返回该区域的首地址，此时内存中的没有初始化，是个随机数
 + calloc的调用方式(type*)calloc(n,size):在内存的动态存储区分配一块长度为n块长度为size字节连续区域，返回首地址，此时内存中值都为初始化为0
 + realloc的调用形式为(type*)realloc(*ptr,size):将ptr内存的大小增大到size，新增加的内存快没有初始化
 + free的调用形式free(void *ptr):释放ptr所指向的一块内存空间

## 动态内存的传递

分析如下程序：
{% highlight C linenos %}
#include <iostream>
#include <stdio.h>
#include <string.h>
using namespace std;

void GetMemory(char *p,int num){
	p = (char*)malloc(sizeof(char)*num);
}

int main(int argc,char* argv[])
{
	// 如果没有初始化，就是野指针，随便指向系统任意一块区域,十分危险
	char *str = NULL;

	GetMemory(str,10);
	strcpy(str,"hello");

	return 0;
}
{% endhighlight %}

虽然p申请了内存，但是返回main函数时，str还是NULL，并不指向那块内存，调用strcpy会导致崩溃。

提出三种方法来解决上面的动态内存不能传递的问题。

 + 在C语言中，可以采用能够指向指针的指针解决这个问题，就可以把str的地址传递给函数GetMemory
 + 在C++中，多了一种选择，就是传递str指针的引用
 + 使用函数返回值来传递动态内存


{% highlight C linenos %}
#include <iostream>
#include <stdio.h>
#include <string.h>
using namespace std;

void GetMemory(char *p,int num){
	p = (char*)malloc(sizeof(char)*num);
}

void GetMemory2(char **p,int num){
	*p = (char*)malloc(sizeof(char) *num);
}


void GetMemory3(char *&p,int num){
	p = (char*)malloc(sizeof(char) *num);
}

char *GetMemory4(int num){
	char *p = (char*)malloc(sizeof(char)*num);
	return p;
}

int main(int argc,char* argv[])
{
	// 如果没有初始化，就是野指针，随便指向系统任意一块区域,十分危险
	char *str1 = NULL;
	char *str2 = NULL;
	char *str3 = NULL;
	char *str4 = NULL;

	//GetMemory(str1,20);
	GetMemory2(str2,20);
	GetMemory3(str3,20);
	str4 = GetMemory4(20);


	//GetMemory(str,10);
	strcpy(str2,"hello  2");
	strcpy(str3,"hello  3");
	strcpy(str4,"hello  4");

	cout << "str1 == NULL?" << (str1 == NULL?"yes":"no") << endl;

	cout << "str2 :" << str2 <<endl;
	cout << "str3 :" << str2 <<endl;
	cout << "str4 :" << str2 <<endl;

	free(str2);
	free(str3);
	free(str4);

	str2 = NULL;
	str3 = NULL;
	str4 = NULL;

	return 0;
}

{% endhighlight %}

output:
{% highlight C linenos %}
str1 == NULL?yes
str2: hello 2
str3: hello 3
str4: hello 4
{% endhighlight %}

## 内存的分配方法有几种

 + 从静态存储区域分配，内存的在编译的时候就已经分配好，这块内存在程序的整个运行期间都存在，例如全局变量
 + 在栈上分配。处理器的指令集中关于栈内存的分配运算，效率非常高
 + 在堆上分配，动态分配。程序在运行的时候用malloc和new申请任意多少的内存，程序员自己负责在何时用free或delete释放内存。动态内存的生存的生存期由我们决定，使用非常灵活，但问题也多。

## 指针和句柄有什么区别

句柄是一种指向指针的指针。

句柄和指针都是地址，不同之处在于:
 + 句柄所指的可以是一个复杂的结构，并且很有可能是与系统有关的.
 + 指针也可以指向一个复杂的结构，但是通常是由用户定义的，所以必需的工作都要工作用户完成，特别是在删除的时候.

## 算法的五大特性

 + 1.又穷性，算法是执行时候运行的有穷性，程序只是一段实现算法的代码
 + 2.确定性，算法对于特定的输入有特定的输出，程序提供了确定算法结果的平台
 + 3.可行性，算法需要考虑设计的可能，程序则具体是实现算法上的设计
 + 4.输入，算法有输入，算法的输入依靠程序的平台提供
 + 5.输出，算法的输出也靠代码的支持

# `chars`

## 不使用库函数将整数转换为字符串
我们可以通过把整数的各位上的数字加'\0'转换成char类型并存放字符数组，注意，需要用字符串逆序的方法。

{% highlight C linenos %}
void int2str(int n,char* str)
{
	char  buf[20] = "";
	int		i = 0;
	int		len = 0;

	// tmp为n的绝对值
	int tmp = n < 0? -n :n;

	if(str == NULL)
		return;

	while(tmp){
		buf[i++] = (tmp % 10) + '0';// 把tmp的每一位上的数字存入buf从个位开始
		tmp /= 10;
	}

	//如果n是负数，多一位来存储负号
	len = n <0 ?++i:i;
	str[i] = 0;		//末尾结束符号

	while(1){
		i--;		// 用的非常好，控制下标的变化
		if(buf[len-i-1] == 0){
			break;
		}
		// 交换字符
		str[i] = buf[len-i-1];
	}
	// 如果是负数
	if(i == 0){
		str[i] = '-';
	}
}
{% endhighlight %}

## 实现字符串转换为整数

 + 正负数
 + 大数情况
 + 许多0开始的字符串
 + 字符串中有其他字符
 + 没有考虑特别复杂的情况,但是确保一定是数字的字符串
{% highlight C linenos %}
int str2int(const  char *str)
{
	if(!str)
		return NULL;
	int tmp = 0;
	// save str first bit
	const char *ptr = str;
	if(*str == '-' || *str == '+')
	{
		str++;
	}

	while(*str != '0'){
		if((*str < '0') || (*str > '9'))
			break;
		tmp = tmp*10 + *str - '0';
		str++;
		// 大数的情况
		if(tmp > 0x7FFFFFFF || tmp < (signed int )(0x80000000))
		{
			tmp = 0;
			break;
		}
	}

	if(*ptr == '-')
		tmp = -tmp;
	return tmp;
}
{% endhighlight %}

## 实现strcpy函数

{% highlight C linenos %}
char *strcpy(char *dst,const char *src)
{
	if(src == NULL || dst == NULL)
		return NULL;
	// str_dst 和dst指向同一的地址
	char *str_dst = dst;

	while((*dst++ = *src++)!= '\0');

	return str_dst;
}

{% endhighlight %}

 + `char *的返回值`:链式连接的需要
 + `参数是const类型，起到保护作用`:防止修改原来的内容

<font color="red"> note:以上的写法，当调用为strcpy(str+1,str),就会出现崩溃,因为出现的内存重叠的现象</font>
{% highlight C linenos %}
char *strcpyTwo(char *dst,const char *src)
{
	if(src == NULL || dst == NULL)
		return NULL;
	// str_dst 和dst指向同一的地址
	char *str_dst = dst;

	// call system memcpy
	memcpy(dst,src,strlen(src)+1);

	return str_dst;
}

{% endhighlight %}

## 实现memcpy函数

{% highlight C linenos %}
void *memcpy(void *memTo,const void *memFrom,size_t size)
{
	assert((memTo != NULL)&&(memFrom != NULL));

	// 保存参数的地址
	char *tmpFrom = memFrom;
	char *tmpTo = memTo;

	// start copy
	while(size-- >0){
		*tmpTo++ = *tmpFrom++;
	}
	return memTo;
}
{% endhighlight %}

## strcpy与memcpy的区别

 + 复制的内容不同，strcpy只能复制字符串，而memcpy可以是任意内容，例如：字符数组，整型等
 + 复制的方法不同，strcpy不需要指定长度，它是遇到字符结束符而结束的。memcpy则是根据其第三个参数决定复制的长度
 + 用途不同，通常在复制字符串时，用strcpy，若需要复制其他类型数据，则一般用memcpy


## 字串中各个单词的翻转

考察如何对字符串进行操作。

字符串翻转
{% highlight C linenos %}
void Reverse(char *p_begin,char *p_end)
{
	if(p_begin == NULL || p_end == NULL)
		return;
	// start swap
	while(p_begin < p_end){

		char tmp = *p_begin;
		*p_begin = *p_end;
		*p_end = tmp;
		p_begin++;
		p_end--;
	}
}
// 翻转英语句子
char *ReverseSentence(char *p_data)
{
	if(p_data == NULL)
		return NULL;

	char *p_begin = p_data;

	// 找到字符的末尾
	char *p_end = p_data;
	while(*p_end != '\0')
		p_end++;
	// 切记这里要回退一下，让p_end指向最后一个字符
	p_end--;

	// 翻转整个句子
	Reverse(p_begin,p_end);

	// 重新修改指针的指向，但是p_data的内容已经修改
	p_begin = p_end = p_data;

	// 找到单词并翻转 关键是如何确定一个单词

	while(p_begin != '\0'){
		// 在交换之后，两个指针都指向空空格，所以需要同时前进
		if(*p_begin == ' '){
			p_begin++;
			p_end++;
		}else if(*p_end == ' ' || *p_end == '\0'){// =='\0'让p_begin == '\0'跳出loop
			// 调整好指针的指向
			Reverse(p_begin,--p_end);
			// 完成交换之后，把两个指针的指向改为指向同一个字符,以便下次确定位置
			p_begin = ++p_end;
		}else{
			// 一直走，直到遇到空格
			p_end++;
		}
	}
	return p_data;
}

{% endhighlight %}

## 字符串是否是回文

{% highlight C linenos %}
int IsRevStr(char *str)
{
	int		i,len;
	int		found = 1;

	if(str == NULL)
		return -1;

	len = strlen(str);
	for(i = 0; i < len / 2;i++){
		if(*(str+i) != *(str + len -i -1))
		{
			found = 0;
			break;
		}
	}
	return found;
}
{% endhighlight %}

## 实现strcmp函数

{% highlight C linenos %}
int strcmp(const char *src,const char *dst)
{
	int		ret = 0;
	while(!(ret = *(unsigned char *)src - *(unsigned char *)dst) && *dst){
		++src;
		++dst;
	}

	if(ret < 0)
		ret = -1;
	else if(ret > 0)
		ret = 1;

	return ret;
}
{% endhighlight %}

## 查找两个字符串的最大公共子串

采用KMP的方法是最好的。复杂度O(m+n)


## 将十进制的数，转换为二进制和十六进制

{% highlight C linenos %}
void Dec2Bin(unsigned int num,unsigned int *result)
{
	int		i = 0;
	int		tmp;

	// transform
	while(num != 0){
		tmp = num % 2;
		result[i++] = tmp;
		num /= 2;
	}
}

int Bin2Dec(const char *buf)
{
	int		num = 0;

	// 便于控制,通过p++来得到最终的bit数
	char *p = buf;
	int		w = 1;//weight

	// 二进制的bit数
	int n = 0;

	while(*p != NULL)
	{
		if(*p >= '0'&& *p <= '1')
			++n;
		else
			return -1;
	}

	// transform
	while(n--){
		num += (buf[n] - '0')* w;
		w*=2;// 出现2 的次方
	}
	return num;

}
{% endhighlight %}

## 实现任意长度的两个正整数相加

这是一个大数的问题，需要通过字符串来模拟数字的加法运算。

## 实现strcat函数

{% highlight C linenos %}
char *strcat(char *dest,const char *src)
{
	char *ret = dst;
	// 走到dest的末尾
	while(*dest++);

	// 回退一个字符
	dest--;

	while(*dest++ = *src++);
	return ret;
}
{% endhighlight %}

## C++中的4中运算符转化以及他们的不同点

 + const_cast操作符:用来帮助调用那些应该使用却没有使用cosnt关键字的函数。就是提高程序设计师在`特殊情况下将限制为const成员函数的const定义解除，使其能更改特定属性。`
 + dynamic_cast操作符:如果启动了支持运行时间类型信息(RTTI)，dynamic_cast可以有助于判断在运行时所指向对象的确切类型。它与typeid运算符有关。可以将一个基类的指针指向许多不同的子类型(派生类)，然后将被转型为基础来的对象还原成原来的类。不过，限于对象指针的类型转换，而非对象变量。
 + reinterpret_cast操作符:将一个指针转换成其他类型的指针，新类型的指针与旧类型的指针可以毫不相关。通常用于非标准的指针数据类型转换，例如将void转换char*。`它存在潜在的危险，除非有使用它的充分理由，否则就不要使用它`
 + static_cast操作符:它能在相关的对象的指针类型之间进行转换。通常情况下，static_cast操作符大多用于将数域宽度较大的类型转换为较小的类型。当转换的类型是原始数据类型时，这种操作可以有效的禁止编译器发出警告。


## 关键字volatile的作用

一个定义为volatile的变量就是说这个变量可能会被意想不到的改变，这样编译器就不会去假设这个变量的值了。精确的说，就是优化器用到这个变量时必须每次都小心地重新读取这个变量，而不是使用保存在寄存器的备份
 + 并行设备的硬件寄存器(状态寄存器)
 + 一个中断服务子程序会访问到非自动变量
 + 多线程应用中被几个任务共享的变量

## 如何判断处理器是大端还是小端

若为Big_endian 返回0，若是Little_endian的，返回1.
{% highlight C linenos %}
int CheckCPU()
{
	union w
	{
		int	a;
		char	b;
	}c;
	c.a = 1;
	return (c.b == 1);
}
{% endhighlight %}

# `C++ Object`

## 描述面向对象技术的基本概念

面向对象的基本概念:按照人们认识客观世界的系统思维方式，采用基于对象(实体)的概念建立模型，模拟客观世界分析、设计，实现软件的办法。通过面向对象的概念使计算机软件系统能与现实世界中的系统一一对应，包括下面几方面的内容。

 + 类:具有相似的内部状态和运动规律的实体集合。在归纳的过程中，从一个个具体的事物中把共同的特征抽取出来，形成一个一般的概念。在演绎的过程中又把同类的事物，根据相同的特征分成不同的小类。
 + 对象:指现实世界中各种各样的实体，也就是类的实例，他们既可以指具体的事物，也可以指抽象的事物。在面向对象概念中，把对象的内部状态称为属性，运动的规律称为事件。
 + 消息:指对象的内部相互联系和相互作用的方式，一个消息主要由5部分组成:发送消息的对象，接受消息的对象，消息传递到方法，消息内容反馈。
 + 类的特性:抽象，继承，封装，重载，多态。

## class和struct的区别

 + C语言中是struct与C++的class的区别:struct只是作为一种复杂数据类型定义，不能用于面向对象编程。
 + C++中的struct和class的区别:采用成员访问权限以及继承方式，class中是默认是private，而struct中则是public。class还可以用于表示模板类型，struct则不行。

## 与全局对象相比，使用静态数据成员有什么优势

 + 静态数据成员没有进入程序的全局名字空间，因此不存在程序中其他全局名字冲突的可能性
 + 使用静态数据成员可以隐藏信息，因为静态成员可以是private成员，而全局对象不能

## 初始化列表不能用assignment

## main函数执行前还会执行什么代码

main函数之前，主要是初始化系统的相关资源
 + 设置栈指针
 + 初始化static和全局变量，即data段
 + 将未初始化部分的全局变量赋初值：数值型short，int，long等为0，bool为False，指针为NULL等等，即.bss段的内容
 + 运行全局构造器，估计是C++中构造函数之类的
 + 将main函数的参数，argc，argv等传递给main函数，然后运行main函数。

`expands:`在main函数之后运行

 + 全部对象的析构函数在main之后运行
 + 可以用_onexit注册函数，在main函数之后运行

**如果你需要加入一段在main退出后执行的代码，可以使用atexit函数。**


## C++默认的空类会产生哪些类成员函数

	会产生六个默认的成员函数
 + 默认构造函数
 + 默认析构函数
 + 拷贝构造函数
 + 复制运算符
 + 取地址运算符 非const
 + 取地址运算符 const

demo:
{% highlight C linenos %}

class Empty
{
public:
	Empty();
	Empty(const Empty &);
	~Empty();
	Empty& operator=(const Empty &);
	Empty* operator&();
	const Empty* operator&() const;
}

{% endhighlight %}

## explicit构造函数与普通构造函数的区别

explict的主要用法就是放在`单参数`的构造函数中，`防止隐式转换`，导致函数的入口，出现`歧义`。

如果可以使用A构造B，`未加explict的`构造函数，当使用B进行参数处理时，就可以使用A，使得`接口混乱`

为了避免这种情况，使用`explict避免隐式构造，只能通过显示(explict)构造`

## 复制构造函数是什么?什么是深复制和浅复制

复制构造函数，就把一个对象复制另一个相同的对象的过程。但是拷贝构造函数又分为两种情况，也就是深拷贝和浅拷贝。

 + 浅拷贝：指的是在对象复制时，**只是对对象中的数据进行简单的赋值，默认拷贝构造函数执行的也是浅拷贝**,`大多数情况浅拷贝已经能很好的工作了，但是一旦对象在**动态成员，那么浅拷贝就会出现问题**`

{% highlight C linenos %}
class A
{
public:
	A()
	{
		p = new int(10);
	}
	~A()
	{
		if(p != NULL)
		{
			delete p;
		}
	}
private:
	int width;
	int height;
	int *p;
}

int main()
{
	A a1;
	A a2(a1);
	return 0;
}
{% endhighlight %}

这段代码运行时会出现错误，原因就是在进行对象复制时，对于动态分配的内容没有进行正确的操作。在销毁对象时，两个对象的析构函数将对同一个内存释放了两次，这显然是不对的。

我们需要的不是两个p具有相同的值，而是两个p指向的空间有相同的值，解决方法`使用深拷贝`

 + 深拷贝：在深拷贝的情况下，对于对象中的`动态成员，`就不是简简单单的赋值了，应该重新分配内存空间
{% highlight C linenos %}
class A
{
public:
	A()
	{
		p = new int(10);
	}
	~A()
	{
		if(p != NULL)
		{
			delete p;
		}
	}
	A(const A &a)
	{
		width = a.width;
		height = a.height;
		p = new int(10);
		*p = *(a.p);
	}
private:
	int width;
	int height;
	int *p;
}

int main()
{
	A a1;
	A a2(a1);
	return 0;
}
{% endhighlight %}

这样调用之后就不会出错了。


## 复制构造函数与赋值函数有什么区别

有三个方面的区别：

 + 复制构造函数是一个对象来初始化一块内存区域，这块内存就是新对象的内存区

{% highlight C linenos %}
class A;
A a;
A b = a;	// 复制构造函数
A c(a)		// 复制构造函数
{% endhighlight %}

而对于赋值函数是`对于一个已经被初始化的对象来进行operator=操作.`
{% highlight C linenos %}
class A;
A a;
A b;
b = a;	// 赋值构造函数

{% endhighlight %}

 + 一般来说是在数据成员包含指针对象的时候，应付两种不同的处理需求:**一种是复制指针对象，一种是引用指针对象**.`赋值构造函数在大多数情况下复制，赋值函数则是引用对象。`
 + 实现不一样。复制构造函数首先是一个构造函数，它调用的时候是通过`参数传进来的那个对象来初始化产生一个对象`。赋值函数则是`把一个对象赋值给一个原有的对象`，所以原来的对象中有内存分配，`要先把内存释放掉，而且还要检查以下两个对象是不是同一个对象，如果是的话，就不和任何操作`。

## 编写String的构造函数，析构函数和赋值函数


{% highlight C linenos %}
class MString
{
public:
	// MString(const char *str = NULL);	//普通构造函数
	MString(const char *str);	//普通构造函数
	MString(const MString &other);	// 复制构造函数
	~MString(void);	// 析构函数
	MString &operator=(const MString &other);	// 赋值函数

private:
	char *m_string;
};

MString::MString(const char *str = NULL)
{
	// special exception
	if (str == NULL){
		m_string = new char[1];
		*m_string = '\0';
	}else{
		m_string = new char[strlen(str) + 1];
		strcpy(m_string,str);
	}
}

// 切记下面的const的好处
MString::MString(const MString &other)
{
	m_string = new char [strlen(other.m_string) + 1];
	strcpy(m_string,other.m_string);
}

MString &MString::operator =(const MString &other)
{
	if (this == &other){
		return *this;
	}
	// delete other.m_string  prevent mem leak
	delete [] m_string;
	// renew alloc mem
	m_string = new char[strlen(other.m_string) + 1];
	strcpy(m_string,other.m_string);

	return *this;
}

MString::~MString(void)
{
	if (m_string != NULL)
	{
		delete [] m_string;
		m_string = NULL;
	}
}

{% endhighlight %}

临时对象：

真正的临时对象是看不见的，它不会出现在程序代码中，大多数情况下，它会影响程序的执行的效率，所以有时想避免临时对象的产生。通常在以下两种情况下产生临时对象：

 + 参数按值传递
 + 返回值按值传递

**note：引用必须有一个实在的，可引用的对象，否则引用是错误的，因此，在没有实在的、可引用的对象的时候，只有依赖临时对象**

## 为什么c不支持重载而c++支持

函数重载是用来描述同名函数具有相同或者相似的功能，但数据类型或者参数不同的函数管理操作。例如，要进行不同数据类型的和操作。

函数重载是用来描述同名函数具有相同或相似的功能，但数据类型或者参数不同的函数来管理操作。

函数名通过C++编译器处理后包含了原函数名、函数参数数量以及返回类型信息，而C语言不会对函数名进行处理。

## 重载和重写的区别

重载是指子类改写了父类的方法，重写是指同一个函数的不同版本之间参数的不同。

重载是编写一个与已有函数同名但参数表不同(参数数量和参数类型不同)的方法，特征：
 + 方法名必须相同
 + 参数列表必须不相同，与参数列表的顺序无关
 + 返回类型可以不同

重写是派生类重写基类的虚函数，具有如下特征：

 + 只有虚方法和抽象方法才能够被重写
 + 相同的函数名
 + 相同的参数列表
 + 相同的返回值类型

重载是一种语法规则，由编译器在编译阶段完成，不属于面向对象的编程；重写是由运行阶段决定的，是面向对象编程的重要特征。



## 私有继承和组合有什么相同点和不同点。

使用组合表示`有一个(has-A)`的关系。如果在组合中需要使用一个对象的某些方法，则完全可以利用私有继承代替。
私有继承下派生类会获得基类的一份备份，同时得到了访问基类的公共以及保护接口的权利和重写基类虚函数的能力，它意味这`以---实现`，它是组合的一种语法上的变形(聚合或者`有一个`)
 + 相同点：都可以表示`有一个`关系
 + 不同点：私有继承中派生类能访问基类的protected成员，并且可以重写基类的虚函数，甚至当基类是抽象的情况。组合不具有这些功能。

<font color="red"> note:选择它们的原则为尽可能使用组合，万不得已才用继承</font>

## 什么是多态

多态性的定义：同一操作作用与不同的对象，可以有不同的理解，产生不同的解释，产生不同的执行结果。有两种类型的多态性：
 + 编译时的多态性。编译时的多态性是通过重载来实现的，对于非虚的成员来说，系统在编译时，根据传递的参数，返回的类型等信息决定实现何种操作。
 + 运行时的多态性。运行时的多态性就是指直到系统运行时，才根据实际的情况来决定实现何种操作，C++，运行时的多态性通过虚成员实现。

## 虚函数是怎么实现的

简单的来说，虚函数是通过`虚函数表来实现的`.
 + 虚函数是通过一张虚函数表来实现的，有多少虚函数，就有多少指针；
 + 在这个表中，主要是一个类的虚函数的地址表，这张表解决了继承，覆盖的问题；
 + 实际上在编译的时候，编译器会自动加上虚表；
 + 虚函数的作用是实现动态联编，也就是说在程序运行阶段动态的选择合适的成员函数，在定义虚函数之后，可以在基类的派生类中对虚函数重新定义；
 + 虚表的使用方法是如果派生类在自己定义中没有修改基类的虚函数，我们就指向基类的虚函数，如果派生类修改了基类的虚函数，这时虚表则将原来指向接力的虚函数的地址替换为指向自身虚函数的地址；
 + 必须通过的基类类型的引用和指针进行函数调用才会发生多态。


## 多继承的构造函数的顺序

 + 1.任何虚拟基类的构造函数按照他们被继承的顺序构造
 + 2.任何非虚拟的构造函数按照他们的被构造的顺序构造
 + 3.任何成员对象的构造函数按照他们声明的顺序调用
 + 4.类自身的构造函数

## 为什么要引入抽象基类和纯虚函数

纯虚函数在基类中是没有定义的，必须子啊子类中加以实现，如果基类含有一个或者多个纯虚函数，那么它就属于抽象类，不能被实例化。

为什么要引入抽象基类和纯虚函数
 + 为了方便使用多态特性。
 + 在很多情况下，基类本身生成对象是不合理的。定义纯虚函数相当与接口，能把派生类的共同行为提取出来。

## 虚函数和纯虚函数有什么区别

 + 类里如果声明了虚函数，这个函数是可以实现的，哪怕是空的，它的作用就是为了能让这个函数在它的子类中可以被覆盖，这样编译器可以使用后期绑定来达到了多态了，纯虚函数只是一个接口，是个函数的声明而已，它要到子类中去实现。
 + 虚函数在子类里面也可以不重载；但纯虚函数必须在子类中实现，通常要在这个函数前加上virtual关键字，是一个好习惯，虽然牺牲了一些性能，但是增加了面向对象的多态性，因为很难预料到父类里面的这个不在子类里面不去修改它的实现。
 + 虚函数的类用于`实作继承`，也就说继承接口的同时也继承了父类的实现。当然大家也可以自己去实现。纯虚函数的类用于`界面继承`，即纯虚函数关注的接口的统一性，实现由子类来完成。
 + 带纯虚函数的类叫虚基类，这种基类不能直接生成对象，而只有被继承，并重写其虚函数后，才能使用，这样的类也叫抽象类。

## 构造二叉排序树

## `泛型编程`

##  什么是泛型编程

泛型编程编写完全一般化并可重复使用的算法，其效率与针对的某特定的数据类型而设定的算法相同。所谓的泛型，是指具有在数据类型上皆可操作的含义，在C++中实际上就是使用模板实现。

{% highlight C linenos %}
int max(int a,int b)
{
	return a>b?a:b;
}

float max(float a,float b)
{
	return a > b?a:b;
}

double max(double a,double b)
{
	return a > b?a:b;
}
// use template
template <typename T>
T max(T a,T b)
{
	return a > b? a:b;
}
{% endhighlight %}

## 函数模板和类模板分别是什么

函数模板是一种抽象的函数定义，它代表一类同构函数。类模板是一种更高层次的抽象的类定义。

函数模板的实例化是由编译程序在处理函数调用时自动完成的，而类模板的实例化必须由程序员在显式地指定。

类模板实例的个数由参数类型的种类决定的。

{% highlight C linenos %}
Array<int> arr1;
Array<char> arr2,arr3;
Array<int> arr4,arr8;
Array<double> arr5;
...
// 这里一共有3个实例。
{% endhighlight %}

## 使用模板有什么缺点？如何避免

template是节省时间和避免代码重复的非常好的方法。我们恶意只输入一个类模板，就能让编译器实例化所需要都很多个特定类以及函数。类模板的成员函数只有被使用时，才会被实例化，所以只有在每个函数都在实际中被使用时，我们才会得到这些函数。
模板的缺点：不当的使用模板会`导致代码膨胀，即二进制代码臃肿而松散，会严重影响程序的运行效率。`

解决方法：`把C++模板中与参数无关的代码分离出来。`

## 解释什么是模板的特化

模板的特化(template specialization)分为两类：函数模板的特化和类模板的特化。
1.函数模板的特化：当函数模板需要对某些类型进行特别处理时，成为函数模板的特化.


## `STL`

STL的基本观念就是把数据和操作分离。

![image](http://lkkandsyf.github.com/pictures/stl.jpg)


STL中数据由容器类别类加以管理，操作则由可定制的算法来完成。迭代器的容器和算法之间当粘合剂，它使得任何算法都可以和任何容器进行交互运作。STL含有容器、算法、迭代器组件。

 + STL序列容器:vector,string,deque,list
 + STL关联容器:set,multiset,map,multimap
 + STL适配容器:stack,queue,priority_queue

## STL中如何实现vector

vector内部是使用动态数组的方式实现的，如果动态数组的内存不够用，就要动态的重新分配，一般是当前大小的两倍，然后把原来数组的内存copy过去，所以一般情况下，其访问速度同一般数组，只有在重新分配发生时，其性能才会下降。它的内部使用allocator类进行内存管理，程序员不需要自己操作内存。note: vector<type>::size_type 使用方法，定义的变量是unsigned int,切记访问的时候，需要特殊的考虑。对于arrar.erase(iter),每次调用的时候，被删除元素之后的内容会自动往前移动，导致迭代遗漏。

## list和vector有什么区别

vector和数组类似，它拥有一段连续的内存空间，并且起始地址不变，因此它能非常好的支持`随机存取`(使用[]操作符来访问其中的元素)。但由于它的内存空间是连续的，所以在中间进行`插入和删除`会造成内存快的copy(复杂度O(n))，另外，当该数组后的内存空间不够时，需要重新申请一块足够大的内存并进行内存的copy，这些都大大影响了vector的性能。

list是由数据结构中的双向链表实现的，因此它的内存空间是可以不连续的，因此只能`通过指针来进行访问数据`，这个特点使得它的`随机存取变得非常没有效率`，需要遍历中间的元素，搜索复杂度为O(n)，因此它没有提供[]操作符的重载，但是由于链表的特点，它可以以很好的效率支持`任意地方的删除和插入`。
note:如果需要高效的随机存取，而不在乎插入和删除的效率，就可以使用vector；如果需要大量的插入和删除，而不关心随机存取，则应使用list。

vector拥有一段`连续的内存空间`，因此`支持随机存取`，如果需要高效的`随机存取`，而`不在乎插入和删除的效率`，就使用vector。
list拥有一段`不连续的内存空间`，因此`不支持随机存取`，如果过需要`大量的插入和删除`,而`不在乎随机存取`，就使用list。

## 在做应用的时候，如何选择vector和deque

deque使用一段一段的定量内存，在进行内存扩充时，也只是加一段定量内存，因此不存在容量的概念，也就没有capacity()和reserve()成员函数。最后在插入操作，deque和vector有很大的不同，由于vector是一块连续的内存，所以插入的位置决定执行效率，位置越靠近数组首部，效率越低，而deque中的内存是分段连续的，因此在不同段中的插入效率都相同。

vector和deque的不同：内部数据管理不同。为了提高效率，vector在添加元素之前最好调用reserve()设置容量，而deque则不需要。
选择的方法，一般情况下选择vector，但当需要从首尾两端进行插入和删除元素操作的时候，应该选择deque。

## STL中的map内部如何实现，map和hashmap的区别

标准的STL关联容器(包括set和map以及set的衍生体multiset和map的衍生体multimap)的内部结构是一个平衡的二叉树，AVL-tree，RB-tree，AA-tree，STL的底层机制都是一红黑树完成的，每个结点都被着上了红色和黑色，结点的颜色被用来检测树的平衡性，在对结点进行插入和删除的操作，可能会被旋转树的平衡性，平均和最坏的情况下的插入、删除、查找的时间都是O(logn)
一个红黑树是一个平衡二叉树，除了二叉树带有的一般要求外，具有一下的属性。
 + 结点为红色或黑色
 + 所有叶子结点都是空结点，并且被着为黑色
 + 如果父结点是红色的，那么两个子结点都是黑色的
 + 结点到其子孙结点的每条简单路径上都包含相同的数目的黑色结点
 + 根结点是黑色

map和hashmap：
 + 底层数据结构不同，map是红黑树，hashmap是哈希表。
 + map的优点在与元素的可以自动按照键值排序，而hashmap的优点在于它的各项操作的平均时间复杂度接近常数。
 + map属于标准的一部分，而hashmap则不是。

## vector中的erase方法和algorithm中的remove有什么区别

 + vector中的erase是真正删除了元素，迭代器不能访问了。
 + 而algorithm中的remove只是简单的要把remove的元素移动到容器的后面，迭代器还是可以访问的，这是因为algorithm通过迭代器操作，不知容器的内部结构，所以无法做到真正的删除。


## 智能指针如何实现

智能指针是用来`实现指针指向的对象的共享的`。基本思想：

 + 每次创建类的新的对象时，初始化指针并将引用的计数置为1；
 + 当对象作为另一对象的副本而创建时，copy构造函数copy指针并增加与之相应的引用计数；
 + 对一个对象进行赋值时，赋值操作符减少左操作数所指对象的引用计数（如果引用计数减少为0，则删除对象），并增加右操作数所指对象的引用计数；
 + 调用析构函数时，减少引用计数（如果引用计数减少为0，则删除基础对象）;
 + 重载“->” 以及“\*”操作符，使得智能指针有类似与普通指针的操作。

## 使用std::auto_ptr 有什么方面的限制

 + auto_ptr要求一个对象只能有一个拥有者。
 + auto_ptr是不能以传值方式进行传递的。
 + 不支持数组
 + 注意Release，Release是释放指针，即交出指针的所有权。
 + auto_ptr在拷贝构造和=操作符的特殊意义决定了它不能为STL标准容器的成员。


`note:`函数对象，就是一个重载的`()`的运算符的类的对象，它可以像函数一样的使用。
{% highlight C linenos %}
minus <int> int_min;
cout << int_min(2,4) << endl; // -2
{% endhighlight %}
