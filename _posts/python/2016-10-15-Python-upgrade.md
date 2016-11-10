---
layout: post
category : Python
tagline: "Supporting tagline"
tags : [Pyhon-package]
---
{% include JB/setup %}

# Overview
{:.no_toc}

* dir
{:toc}

## Ubuntu

1.安装bz2

sudo apt-get install libbz2-dev

2.下载[python](https://www.python.org/)源代码
tar xf python.tar.xz
./configure --prefix=/usr/local --enable-shared CFLAGS=-fPIC
make -j 8
sudo make install
建立动态链接
sudo ln -s /usr/bin/python /usr/local/python/bin/python

测试:
python -V


## Centos

1.安装bz2

sudo yum install bzip2-devel
yum install bzip2-devel

2.下载[python](https://www.python.org/)源代码
tar xf python.tar.xz
./configure --prefix=/usr/local --enable-shared CFLAGS=-fPIC
make -j 8
sudo make install
建立动态链接
sudo ln -s /usr/bin/python /usr/local/python/bin/python

测试:
python -V


## python package install

linux下使用包管理器pip.

 + 命令安装pip
sudo apt-get install python-pip
 + 下载源码安装
 sudo python setup.py install


## 常用的包整理

建议首先安装Anaconda python distribution,这里提供了大多数的必需包。以及一些库的依赖。使用脚本安装。

{% highlight C linenos %}
Anaconda.sh
sudo chmod +x Anaconda.sh
sudo ./Anaconda.sh
根据提示安装下去，就可以了，然后就修改你的.bashrc,以及对应的.zhsrc

再安装其他的包
sudo sh install-python-package.sh

install-python-install.sh:
/usr/bin/bash
for req in $(cat requirements.txt); do pip install $req; done

requirements.txt:
adium-theme-ubuntu>=0.3.4
apt-xapian-index>=0.45
backports-abc>=0.4
backports.shutil-get-terminal-size>=1.0.0
backports.ssl-match-hostname>=3.5.0.1
certifi>=2016.2.28
chardet>=2.0.1
colorama>=0.2.5
command-not-found>=0.3
configparser>=3.5.0
Cython>=0.24.1
dask>=0.10.2
debtagshw>=0.1
decorator>=3.4.0
defer>=1.0.6
dirspec>=13.10
duplicity>=0.6.23
easydict>=1.6
entrypoints>=0.2.2
gprof2dot
h5py>=2.6.0
html5lib>=0.999
httplib2>=0.8
ipdb>=0.8
ipykernel>=4.3.1
ipython>=5.0.0
ipython-genutils>=0.1.0
ipywidgets>=5.2.2
jedi>=0.9.0
Jinja2>=2.7.2
jsonschema>=2.3.0
jupyter>=1.0.0
jupyter-client>=4.3.0
jupyter-console>=5.0.0
jupyter-core>=4.1.0
leveldb>=0.193
lockfile>=0.8
lxml>=3.3.3
Markdown>=2.4
MarkupSafe>=0.18
matplotlib>=1.3.1
mistune>=0.7.3
mock>=1.0.1
MySQL-python>=1.2.3
nbconvert>=4.2.0
nbformat>=4.0.1
networkx>=1.11
nose>=1.3.7
notebook>=4.2.1
numpy>=1.11.2
oauthlib>=0.6.1
oneconf>=0.3.7.14.4.1
PAM>=0.4.2
pandas>=0.18.1
pathlib2>=2.1.0
pexpect>=3.1
pickleshare>=0.7.3
Pillow>=3.3.0
piston-mini-client>=0.7.5
prompt-toolkit>=1.0.3
protobuf>=3.0.0
ptyprocess>=0.5.1
pycrypto>=2.6.1
pycups>=1.9.66
pycurl>=7.19.3
Pygments>=1.6
pygobject>=3.12.0
pygraphviz>=1.3.1
pyOpenSSL>=0.13
pyparsing>=2.0.1
pyserial>=2.6
pysmbc>=1.0.14.1
pysqlite>(1.0.1
python-dateutil>=2.5.3
python-gflags>=3.0.6
pyxdg>=0.25
PyYAML>=3.11
pyzmq>=14.0.1
qtconsole>=4.2.1
reportlab>=3.0
requests>=2.2.1
scikit-image>=0.12.3
scikit-learn>=0.18
scipy>=0.18.0
setuptools>=25.1.0
simplegeneric>=0.8.1
six>=1.10.0
ssh-import-id>=3.21
system-service>=0.1.6
terminado>=0.6
tornado>=4.4.1
traitlets>=4.2.2
Twisted-Core>=13.2.0
Twisted-Web>=13.2.0
unity-lens-photos>=1.0
urllib3>=1.7.1
urwid>=1.1.1
vboxapi>=1.0
wcwidth>=0.1.7
wheel>=0.24.0
widgetsnbextension>=1.2.6
xdot>=0.5
zope.interface>=4.0.5)
{% endhighlight %}

<font color="red">note </font>

 + 遇到timeout 超时

 1.加大超时时间，sudo pip install xxxx timeout 100

 2.到官网下载包，xxx.whl
 sudo pip install xx.whl

 3.源代码编译

 sudo python setup.py install

 如果网速不好，就使用国内的源。

	sudo pip install numpy --upgrade -i http://pypi.douban.com/simple --trusted-host pypi.douban.com

 pipy国内镜像目前有：

  http://pypi.douban.com/  豆瓣

  http://pypi.hustunique.com/  华中理工大学

  http://pypi.sdutlinux.org/  山东理工大学

  http://pypi.mirrors.ustc.edu.cn/  中国科学技术大学

 + 测试模块
 python -c "import theano;theano.test()"


## tensorflow

 + cpu
 sudo pip install --ignore-installed --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.8.0rc0-cp27-none-linux_x86_64.whl -i http://pypi.douban.com/simple
 --trusted-host pypi.douban.com
 + gpu


## tools

python性能分析工具

sudo apt-get install python-profiler

## python 升级带来的问题

  + P1:vim: symbol lookup error: vim: undefined symbol: PyUnicodeUCS4_AsEncodedString
  [link](http://stackoverflow.com/questions/26909293/vim-symbol-lookup-error-vim-undefined-symbol-pyunicodeucs4-asencodedstring)
