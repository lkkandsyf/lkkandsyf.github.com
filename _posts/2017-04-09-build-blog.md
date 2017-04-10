---
layout: post
category : blog
tagline: "Supporting tagline"
tags : [ jekyll ]
---
使用ubuntu镜像来搭建一个jekyll的博客环境
---
<!--more-->
---

## install env

```
 > 1. 进入docker
 sudo docker run -it ubuntu:14.04 /bin/bash
 apt-get update
 # solution add repo
 apt-get install python-software-properties
 apt-get install software-properties-common
 # add ruby repo
 apt-add-repository ppa:brightbox/ruby-ng
 apt-get update
 apt-get install ruby2.2-dev
 # check version
 ruby -v # 2.2
```

problem:`An error occurred while installing json (1.8.6), and Bundler cannot continue. on Ubuntu
`
solution:

```
sudo apt-get install libgmp-dev
sudo apt-get install libgmp3-dev
```
