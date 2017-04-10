#########################################
#         File name   :create blog.sh
#         Author      :kangkangliang
#         File desc   :use to new blog quickly
#         Mail        :liangkangkang@yahoo.com
#         Create time :2016-08-30
#########################################
#!/usr/bin/bash
# $# 表示有几个参数，程序名不算一个argv
# no argv
if [ $# -lt 1 ];then
	echo "---script usage---"
	echo "sh xxx.sh blog_name"
	echo "xxxx-xx-xx-title.md"
fi

#help txt and create blog name
#if [ $# -ge 1 ];then
#	echo "look help document xxx.sh -h or --help"
#elif [ $1="-h" ] ||[ $1="--h" ]||[ $1="--help" ]||[ $1="--h" ];then
#	echo "sh xxx.sh blog_name"
#	echo "xxxx-xx-xx-title.md"
#fi
if [ $# -ge 1 ] && [ $1!="-h" ];then
	echo "------------"
	time=`date +"%F"`
	blog_name=$time-$1.md
	echo "blog_name:"
	touch $blog_name
	echo $blog_name
	echo "blog_template create success,and start to write"
else
	echo "sh xxx.sh blog_name"
	echo "xxxx-xx-xx-title.md"
	echo "for example:2016-8-30-name.md"
fi
# auto add some specfic context
cat << CHAR > $blog_name
---
layout: post
category :
tagline: "Supporting tagline"
tags:
  -
title: ''
---

---


<!--more-->

CHAR
