---
layout: post
category : interview
tagline: "Supporting tagline"
tags : [algorithm]
---
{% include JB/setup %}

# Overview
{:.no_toc}

这里收集了一些关于链表的一些操作，在面试过程，掌握这些基本知识，是每个程序员必备的.

* dir
{:toc}

### 1.单链表中倒数第k个节点

在给定的链表中得到倒数第k个节点，特殊情况返回空.链表的尾节点是链表倒数第1个节点.

example:
```c
list:1->2->3->4->NULL
k = 2 output:
```
```c
output: 3 list node
```

#### Solution
{:.no_toc}

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



### 2.单链表中中间节点

在给定的单链表中得到中间的节点，不考虑奇偶的问题,**如果只有一个或者两个节点，就返回第一个节点**

example:
```c
list:1->2->3->4-5>NULL
```
output:
```c
output: 3 list node
```

#### Solution
{:.no_toc}

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

### 3.链表是否存在环

在给定的链表中是否有环的存在?
<font color="red">扩展：</font>如果有环，请输出环的入口节点

example:
```c
list:1->2->3->4->5
           |    |
	   8<-7<-6
```
output:
```c
output: 3 list node
```

#### Solution
{:.no_toc}

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


### 4.两个链表中的第一个公共节点
给定两个单链表，找出他们第一个公共节点。

> So1:暴力的方法，就是遍历第一个链表中的节点，同时也遍历第一个链表中的所有节点，如果一样，说明有节点
重合，就找到了第一个公共节点，时间复杂度O(mn),m,n为两个链表的长度。

> So2:我们分析一下，如果有一个公共节点，那么之后，两个链表的所有节点，都是一样的，拓扑形状看起来像
一个Y,不可能是X.首先遍历两个链表的长度，就能知道哪个链表长，以及长比短多几个节点，在第二次遍历的
时候，在长的链表中先走若干步，接着再同时在两个链表中遍历，找到第一个相同的节点就是第一个公共节点。

code:
{% highlight C linenos %}
// get list length
unsigned int GetLengthList(ListNode *head)
{
	unsigned int len = 0;
	ListNode *p = head->next;
	while(p != NULL){
		++len;
		p = p->next;
	}
	return len;
}
ListNode *FindFirstCommonNode(ListNode *head1,ListNode* head2)
{
	unsigned int len1 = GetLengthList(head1);
	unsigned int len2 = GetLengthList(head2);

	int diff_len = len1 - len2;

	ListNode* p_long = head1;
	ListNode* p_short = head2;

	if(len2 > len1){
		diff_len = len2 - len1;
		ListNode* p_long = head2;
		ListNode* p_short = head1;
	}

	// 先在长的链表中走几步
	for(int i = 0;i < diff_len;i++){
		p_long = p_long->next;
	}

	// 当两个指针相遇，并且相等，就得到了第一个公共节点
	while((p_long != NULL) &&
		  (p_short != NULL)&&
		  (p_long != p_short)){
		p_long = p_long->next;
		p_short = p_short->next;
	}
	return p_long;
}
{% endhighlight %}


### 5.删除链表中重复的节点

problem:
给定一个有序的链表中，编写一个程序来删除链表中重复的节点

example:
```c
list:1->2->2->2->3->3->4->5->5->6->NULL
```
output:
```c
list:1->4->6->NULL
```


#### Solution
{:.no_toc}

S01:借助哈希表就可以了，前提是数据是可知的。构造一个哈希，先遍历一次，记住每次节点出现的次数，如果
次数大于1，就删除节点,浪费了空间。

S02:



### 6.删除链表中的节点O(1)

给定的链表，在O(1)时间内删除节点
So1:把要删除的节点的下一个节点的数据拷贝到要删除的节点，把下一个节点删除，就可以了。

{% highlight C linenos %}
void DeleteNode(ListNode **head,ListNode* p_delete)
{
	if(*head == NULL || p_delete == NULL)
		return;
	// 要删除的节点不是尾节点
	if(p_delete->next != NULL){
		ListNode *tmp = p_delete->next;
		// copy delete node next node val
		p_delete->val = tmp->next;
		p_delete->next = tmp->next;
		delete tmp;
		tmp = NULL;
	}else if(*head == p_delete){ // 如果链表只有一个节点
		delete p_delete;
		p_delete = NULL;
		*head = NULL;
	}else{ //链表有多个节点,删除尾节点
		ListNode *p = *head->next
		// 找到要删除的上一个节点
			while(p->next != p_delete){
				p = p->next;
			}
		p->next = NULL;
		delete p_delete;
		p_delete = NULL;
	}
}
{% endhighlight %}


### 7.两个单链表删除存在的节点

给定两个链表，把第二个链表中的元素，在第一个链表中存在，就删除，最后返回成功删除的节点个数

example:
```c
list1:1->2->3->4->5->NULL
list2:1->3->5->NULL
```
output:
```c
3
list1:2->4->NULL
```

So1:主要考察如何删除链表的特殊情况

{% highlight C linenos %}
unsigned int DeleteListExistNode(ListNode *head1,ListHead *head2)
{
	// specific case
	if(!head1)
		return 0;
	int len = 0;
	ListNode *p = head1;
	while(p != NULL){
		++len;
	}
	if(!head2)
		return len;

	//two time travel list delete node

}

{% endhighlight %}
