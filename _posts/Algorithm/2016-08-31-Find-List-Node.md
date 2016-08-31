---
layout: post
category : interview
tagline: "Supporting tagline"
tags : [algorithm]
---
{% include JB/setup %}


# Overview

这里收集了一些关于链表的一些操作，在面试过程，掌握这些基本知识，是每个程序员必备的.

## Problem

> [单链表中倒数第k个节点](#1)

> [单链表中中间节点](#2)

> [链表是否存在环](#3)

<span id=1></span>
### 单链表中倒数第k个节点

在给定的链表中得到倒数第k个节点，特殊情况返回空.链表的尾节点是链表倒数第1个节点.

example:
{% highlight C %}
list:1->2->3->4->NULL
{% endhighlight %}
k = 2 output:
{% highlight C %}
output: 3 list node
{% endhighlight %}

### Solution

这里有几个特殊的情况需要考虑:
> 1.指针为空,

> 2.链表的长度小于k,

> 3.如果k的值为0,也返回空.

So1:遍历链表得到长度len,然后在遍历链表到第len-k+1个节点，就是倒数第k个节点.

So2:使用两个指针，让第一个指针先走k-1步，然后两个指针同时一起走，当第1个指针到达尾部时，第二个指针指向的就是链表倒数第k个节点.

code:
{% highlight C linenos %}
typedef struct _ListNode{
	int		val;
	struct _ListNode *next;
}ListNode;

///		head has header node
ListNode* FindKthNodeTail(ListNode *head,unsigned int k)
{
	// empty pointer unsigned int value prevent k-1 ==  INF
	if(head == NULL ||k <= 0)
		return NULL;
	ListNode *p_first = head->next;
	ListNode *p_second = NULL;

	//firstly move k-1 step
	for(int i = 0; i < k -1;i++){
		if(p_first->next != NULL)
			p_first = p_first->next;
		else
			return NULL;
	}

	// let p_second == head;
	p_second = head;
	//	when p_fist == NULL p_second is tail k node
	while(p_first->next != NULL){
		p_first = p_fist->next;
		p_second = p_second->next;
	}
	return p_second;
}
{% endhighlight %}



<span id=2></span>
### 单链表中中间节点

在给定的单链表中得到中间的节点，不考虑奇偶的问题,**如果只有一个或者两个节点，就返回第一个节点**

example:
{% highlight C %}
list:1->2->3->4-5>NULL
{% endhighlight %}
output:
{% highlight C %}
output: 3 list node
{% endhighlight %}

### Solution

这里需要两个指针，同时走，只是一个走的快，一个走的慢，例如:一个走1步，一个走两步，当快的指针到达尾部的时候，第一个指针指向的就是链表中的中间节点


{% highlight C linenos %}
///		head has header node
ListNode* FindMidNode(ListNode *head)
{
	if(head == NULL)
		return NULL;
	ListNode *p_qucik = head->next;
	ListNode *p_slow = head->next;

	while(p_quic != NULL){
		if(p_quick->next->next == NULL)
			return slow;
		p_quick = p_qucik->next->next;
		p_slow = p_slow->next;
	}
}
{% endhighlight %}

<span id=3></span>
### 链表是否存在环

在给定的链表中是否有环的存在?
<font color="red">扩展：</font>如果有环，请输出环的入口节点

example:
{% highlight C %}
list:1->2->3->4-5
           |    |
	   8<-7<-6
{% endhighlight %}
output:
{% highlight C %}
output: 3 list node
{% endhighlight %}

### Solution

So1:这里也使用两个指针，一个走的快，一个走的慢，当慢的指针与快的指针相遇了，说明链表中有环的存在。
但是还要找到环的入口：这就要费一点脑子了，这两个指针相遇，一定在换上，这是一定的，但是不一定在环
的入口，我们就要考虑这两种情况:
> 1.当相遇的点是入口，那么链表到入口的长度等于N倍的环的长度,让一个指针
	回到首部，两个指针同时按照走一步的方法，到了相遇的时候，就是入口节点

> 2.当相遇的点不是入口，只是环中的一个点，经过验算之后，发现用上面的方法，也是可以找到入口的。

S02:把链表的节点都插入到一个集合中，如果该节点已经存在，说明就是入口，这个比较好理解。

{% highlight C linenos %}
ListNode* FindLoopPort(ListNode *head)
{
	ListNode *p_slow = head,*p_quick = head;
	// find loop
	while(p_qucik && p_quick->next){
		p_slow = p_slow->next;
		p_quick = p_quick->next->next;
		if(p_slow == p_quick)
			break;
	}
	// detect loop
	if(p_quick == NULL || p_quick->next == NULL)
		return NULL;

	// find enter loop
	p_slow = head;
	while(p_slow != p_quick){
		p_slow = p_slow->next;
		p_quick = p_quick->next;
	}
	return slow;
}
{% endhighlight %}
<font color="red">note:一个很重要的判断条件</font>
{% highlight C %}
	/// 用来检测是否到了倒数第二个指针,接下来，没有环的存在的判断
	while(p_qucik && p_quick->next)
{% endhighlight %}
{% highlight C %}
	/// 对于得到的节点，再一次判断，返回结果。
	// detect loop
	if(p_quick == NULL || p_quick->next == NULL)
		return NULL;
{% endhighlight %}

对于链表的操作，就是考察程序员对指针使用的熟练程序,还有树。。。
