---
layout: post
category : algorithm
tagline: "Supporting tagline"
tags : [list]
---
{% include JB/setup %}

### List Reverse
链表反转，这是一个很基础的题，对于操作指针来说，非常重要。

{% highlight C %}
typedef struct _list_node{
	int		key;
	struct _list_node *next;
}list_node;

list_node* ListReverse(list_node *head)
{
	//	first node pointer
	list_node *p = head->next;
	//	temp node pointer
	list_node *q = NULL;
	head->next = NULL;

	while(p != NULL){
		//	use q save next node
		q = p->next;
		//	new node insert head after
		p->next = head->next;
		//	head node always point to new node
		head->next = p;
		// swap pointer point to next pointer,go on loop
		p = q;
	}
	return head;
}
{% endhighlight %}
