---
layout: post
category : C
tagline: "Supporting tagline"
tags : [endian]
---
大小端判断
---
<!--more-->
---


### 原则判断

+ 低低小

低低小：低位在低地址，就是小端的存储方式

```C
int	b = 0x12345678

// address ----> become bigger
0x00	0x01	0x02	0x03
78	56	34	12

// 快速判断大小端
int		b = 1;
char *p = (char*)&b;

if(*p){
	printf("little mode")
}
else{
	printf("large mode")
}

```
