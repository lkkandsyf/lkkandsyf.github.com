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

{% highlight C %}
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

在给定的链表中是否有环的存在，如果有环，请输出环的入口节点

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

