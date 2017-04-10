---
layout: post
category : algorithm
tagline: "Supporting tagline"
tags : [sort]
---
Qucik sort
---
<!--more-->
---

### Qucik sort

快速排序是一个经典的算法，对一个程序员来说有很大用处。
方法：一般都是把第一个元素当做哨兵，以它为key值，每趟都要保证哨兵前面的比它小，后面的比它大。

{% highlight C %}
void QuickSort(vector<int>& v,int left,int right)
{
	// exception
	if(v.size()<= 0 || left < 0 || right < 0)
		return;
	if(left < right){
		int	key = v[left];
		int	low = left;
		int	high = right;

		while(low < high){
			///	from right find compare key smaller
			while(low < high && v[high] >= key)
				high--;
			if(low < high)
				v[low++] = v[high];
			///	from left find compare key bigger
			while(low < high && v[low] < key)
				low++;
			if(low < high)
				v[high--] = v[low];
		}
		v[low] = key;
		///	left sort	low is key position
		QuickSort(v,left,low-1);
		///	right sort
		QuickSort(v,low+1,right);
	}
}
{% endhighlight %}

