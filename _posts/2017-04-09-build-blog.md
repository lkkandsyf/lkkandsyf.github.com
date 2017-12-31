---
layout: post
category :
tagline: "Supporting tagline"
tags : [ jekyll ]
---
使用ubuntu镜像来搭建一个jekyll的博客环境
---
<!--more-->
---

## install env

```C
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

```C
sudo apt-get install libgmp-dev
sudo apt-get install libgmp3-dev
```

tips: ufw,jekyll access by ip not localhost
```C
1.close ubuntu ufw
$sudo ufw status
$sudo ufw disable
2.open ubuntu ufw
$sudo ufw enable
$sudo ufw default deny
```

如何让jekyll服务可以通过局域网的ip来访问,由于我们使用的jekyll把地址绑定到了127.0.0.1,导致局域网的其他机器访问不了服务，实际上只要改变jekyll的参数就可以了
```C
jekyll serve -w --host=0.0.0.0
```
