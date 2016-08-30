---
layout: post
category : algorithm
tagline: "Supporting tagline"
tags : [list]
---
{% include JB/setup %}

### List Reverse

    链表反转，这是一个很基础的题，对于操作指针来说，非常重要。

方法：典型的头插法,这是带有头节点链表结构
主要是对头插法的深入理解和灵活运用

{% highlight C linenos %}
/// head insert
	head->next = NULL;
	while(loop){
		//node  malloc mem
		node->val = key;
		node->next = head->next
		head->next = node;
	}
/// tail insert
	while(loop){
		//node  malloc mem
		node->val = key;
		head->next = node;
		head = node;
	}
	node->next;

{% endhighlight %}

{% highlight C linenos %}
typedef struct _ListNode{
	int		key;
	struct _ListNode *next;
}ListNode;

///	use two extra pointer
ListNode* ListReverse(list_node *head)
{
	//first node pointer
	ListNode *p = head->next;

	//temp node pointer
	ListNode *tmp = NULL;

	head->next = NULL;

	while(p != NULL){

		//use tmp save next node
		tmp = p->next;

		//new node insert head after
		p->next = head->next;

		//head node always point to new node
		head->next = p;

		//swap pointer point to next pointer,go on loop
		p = tmp;
	}
	return head;
}

{% endhighlight %}
