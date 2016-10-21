---
layout: post
category : tools
tagline: "Supporting tagline"
tags : []
---
{% include JB/setup %}

# Overview
{:.no_toc}
这里整理了两个常用的翻墙软件.

* dir
{:toc}

## ubuntu lantern deb packege

这个就是一个简单的安装包，安装完成打开就可以使用了。

[download](https://github.com/getlantern/lantern)

## ubuntu XX-net

这个软件，需要装一些插件，就可以使用了，也是十分的方便。

首先，把这个软件下载下来。 然后安装插件就可以使用了。

推荐使用`谷歌浏览器`

install-xx-net.sh:
{% highlight C linenos %}
sudo apt-get install libnss3-tools
sudo apt-get install python-gtk2
sudo apt-get install python-openssl
sudo apt-get install libffi-dev
sudo apt-get install python-appindicator
sudo apt-get install -y python-gtk2
sudo apt-get install libnss3-tools
git clone https://github.com/XX-net/XX-Net
{% endhighlight %}

[安装插件](https://github.com/XX-net/XX-Net/wiki/%E5%AE%89%E8%A3%85%E5%92%8C%E4%BD%BF%E7%94%A8-SwitchyOmega)

进入到xx-net 目录中，sudo ./start 就可以使用了。但是还是推荐部署自己的appid。速度会快一些。
