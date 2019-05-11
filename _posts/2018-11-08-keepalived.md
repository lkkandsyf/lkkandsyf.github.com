---
layout: post
category: HA
tagline: "Supporting tagline"
tags: keepalived
title: 'Keepalive 高可用'
---

---

<!--more-->

## 安装

 + Centos6
 rpm 进行安装,下载[Keepalived](ihttps://pkgs.org/)
 ```c
 # rpm -ivh keepalived-1.2.13-5.el6_6.x86_64.rpm
  warning: keepalived-1.2.13-5.el6_6.x86_64.rpm: Header V3 RSA/SHA1 Signature, key ID c105b9de: NOKEY
  Preparing                ########################################### [100%]
  1:keepalived             ########################################### [100%]
 ```

 + Centos7
 源码安装:下载[tar.gz](http://www.keepalived.org/index.html)
 ```c
 #tar xf keepalived-2.0.8.tar.gz
 #mv keepalived-2.0.8 keepalived
 #cd keepalived
 #./configure --prefix=/usr/local/keepalived
 #make && make install
 ```
 + 配置
 ```c
 mkdir /etc/keepalived
 cp /usr/local/keepalived/etc/keepalived/keepalived.conf /etc/keepalived/
 cp keepalived/keepalived/etc/init.d/keepalived /etc/rc.d/init.d/
 cp /usr/local/keepalived/etc/sysconfig/keepalived /etc/sysconfig/keeplalived
 # start keepalived
 cd /usr/lib/systemd/system/
 systemctl start keepalived.service
 ```

 Keepalived Configuration Manual Page

 [http://www.keepalived.org/manpage.html](http://www.keepalived.org/manpage.html)

## reference

[http://www.keepalived.org/index.html](http://www.keepalived.org/index.html)

[https://www.cnblogs.com/clsn/p/8052649.html#auto_id_17](https://www.cnblogs.com/clsn/p/8052649.html#auto_id_17)
