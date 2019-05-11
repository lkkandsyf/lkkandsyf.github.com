---
layout: post
category: Os
tagline: "Supporting tagline"
tags: docker-compose
  -
title: 'Docker-compose基础教程'
---
Docker-compose来部署集群,方便快捷

Docker Compose是一个用来定义和运行复杂应用的Docker工具。一个使用Docker容器的应用，通常由多个容器组成。使用Docker Compose不再需要使用shell脚本来启动容器。 
Compose 通过一个配置文件来管理多个Docker容器，在配置文件中，所有的容器通过services来定义，然后使用docker-compose脚本来启动，停止和重启应用，和应用中的服务以及所有依赖服务的容器，非常适合组合使用多个容器进行开发的场景。

---


<!--more-->

## 安装

首先要安装好[docker]()，然后再安装docker-compose,需要考虑docker-compose的兼容性,两种安装方式

 1. 二进制安装
 ```C
 下载最新版的docker-compose文件 
 $ sudo curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
 添加可执行权限 
 $ sudo chmod +x /usr/local/bin/docker-compose
 测试安装结果 
 $ docker-compose --version 
 docker-compose version 1.16.1, build 1719ceb
 ```
 2. sudo pip install docker-compose

Docker版本变化说明：
Docker从1.13.x版本开始，版本分为企业版EE和社区版CE，版本号也改为按照时间线来发布，比如17.03就是2017年3月。

Docker的linux发行版的软件仓库从以前的https://apt.dockerproject.org和https://yum.dockerproject.org变更为目前的https://download.docker.com, 软件包名字改为docker-ce和docker-ee。

## docker-compose文件结构
