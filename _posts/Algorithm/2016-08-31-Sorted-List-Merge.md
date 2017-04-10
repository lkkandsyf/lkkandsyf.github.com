---
layout: post
category : interview
tagline: "Supporting tagline"
tags : [algorithm]
---
sort list
---
<!--more-->
---


## Problem
two sorted list to merge into a sorted list

example:
{% highlight C %}
list1:1->3->NULL
list2:2->4->NULL
{% endhighlight %}
output:
{% highlight C %}
list:1->2->3->4->NULL
{% endhighlight %}
<font color="red">note:</font>
1.if two lists are empty,output empyt.
2.if list has equal list  node,and insert into list

## Solution
1.list insert(tail insert)

2.compare to list val,insert into list

code:
{% highlight C linenos %}
typedef struct _ListNode{
	int		val;
	struct _ListNode *next;
}ListNode;

ListNode* MergeSortedList(ListNode* head1,ListNode* head2)
{
	// list is NULL special place
	if(!head1)
		return head2;
	if(!head2)
		return head1;

	// define var
	ListNode *head = NULL;
	ListNode *p1 = NULL;
	ListNode *p2 = NULL;

	// find two list first smaller node head become to new head node
	if(head1->next->val > head2->next->val){
		head = head2;
		p2 = head2->next;
		p1 = head1->next;
	}else{
		head = head1;
		p1 = head1->next;
		p2 = head2->next;
	}

	ListNode *merge = head;

	// travel in lists,find samller node insert merge
	while(p1 != NULL && p2 != NULL){
		/// tail insert
		if(p1->val <= p2->val){
			merge->next = p1;
			merge = p1;
			p1 = p1->next;
		}else{
			merge->next = p2;
			merge = p2;
			p2 = p2->next;
		}
	}

	// take to p1 or p2 another node insert to merge node
	if(p1 != NULL)
		merge->next = p1;
	if(p2 != NULL)
		merge->next = p2;

	return merge;
}
{% endhighlight %}
<font color="red">Attention:</font>
I take the two list parameter the same list name,lead to oneself gdb a long time.

joke:take a  poniter node point to oneself,it is not possible!!!

pointer :list must be careful

finally, the two list both change with the same to merge list.

## a better solution
<font color="red">Recursive Algorithm</font>

{% highlight C linenos %}
ListNode* RecursiveMerge(ListNode* head1,ListNode* head2)
{
	if(head1 == NULL)
		return head2;
	else if(head2 == NULL)
		return head2;
	ListNode *tmp = NULL;

	if(p->val <= p->val)
	{
		tmp = p;
		tmp->next = RecursiveMerge(p->next,q);
	}else{
		tmp = q;
		tmp>next = RecursiveMerge(p,q->next);
	}
	return tmp;

}
ListNode* MergeSortedList(ListNode* head1,ListNode* head2)
{
	if(head1 == NULL)
		return head2;
	else if(head2 == NULL)
		return head1;

	///		take off head node
	ListNode* p = head1->next;
	ListNode* q = head2->next;

	return RecursiveMerge(p,q);
}

{% endhighlight %}

note:understand list pointer,header node exists  and recursive methods


