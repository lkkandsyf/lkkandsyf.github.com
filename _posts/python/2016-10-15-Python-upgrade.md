---
layout: post
category : Python
tagline: "Supporting tagline"
tags : [Pyhon-package]
---
python updgrade
---
<!--more-->
---

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
 + get-pip.py
 wget https://bootstrap.pypa.io/get-pip.py
 python get-pip.py

## 常用的包整理

建议首先安装Anaconda python distribution,这里提供了大多数的必需包。以及一些库的依赖。使用脚本安装。

{% highlight C linenos %}
Anaconda.sh
sudo chmod +x Anaconda.sh
sudo ./Anaconda.sh
根据提示安装下去，就可以了，然后就修改你的.bashrc,以及对应的.zhsrc

再安装其他的包
sudo sh install-python-package.sh

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

`note:`pip 指定版本来安装

```python
sudo pip install package_name==x.x.x
```

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

## pyenv

为了解决系统中Python不同的版本的问题，便于控制版本，出现了pyenv--python版本切换工具，另外一个工具virtualenv也提供了一个种功能，就是将一个目录建立一个虚拟的python环境，这样，用户就可以建立多个虚拟环境。每个环境里的python版本可以是不同的，也可以是相同的，而且环境之间相互独立。

依赖包

	readline readline-devel readline-static
	openssl openssl-devel openssl-static
	sqlite-devel
	bzip2-devel bzip2-libs

Pyenv原理

pyenv 的美好之处在于，它并没有使用将不同的 $PATH 植入不同的 shell 这种高耦合的工作方式，而是简单地在 $PATH的最前面插入了一个垫片路径（shims）：~/.pyenv/shims:/usr/local/bin:/usr/bin:/bin。所有对 Python 可执行文件的查找都会首先被这个 shims 路径截获，从而架空了后面的系统路径。

安装pyenv

[official guide](https://github.com/yyuu/pyenv#installation)

手动安装

```
$ git clone https://github.com/yyuu/pyenv.git ~/.pyenv
$ echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile	#修改环境变量
$ echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile	#修改环境变量
$ echo 'eval "$(pyenv init -)"' >> ~/.bash_profile	#最后添加pyenv init
$ exec $SHELL			#输入命令重启Shell，然后就可以重启pyenv
```

myself config

```
$ git clone https://github.com/yyuu/pyenv.git ~/.pyenv
$ echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
$ echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
$ echo 'eval "$(pyenv init -)"' >> ~/.zshrc
$ exec $SHELL
```

basic command

	pyenv commands			#help	查看有用的命令
	pyenv install --list	#查看pyevn可安装的版本列表
	pyenv install -l
	pyenv install x.x.x		#安装指定版本python
	pyenv rehash			#安装结束之后，必须更新数据库,否则不会生效
	pyenv uninstall x.x.x	#卸载指定版本python
	pyenv rehash			#卸载结束之后，必须更新数据库
	pyven versions			#查看当前已经安装的python版本
	*system(set by /home/user/.pyenv/version)		#系统默认版本
	2.7.6
	3.4.1
	...

安装完成之后，就可以使用pyenv进行版本切换了。

python优先级shell>local>global

	pyenv local version or --unset
	pyenv global version or --unset
	pyenv shell version,versions or --unset
	pyenv local x.x.x		#在当前目录改变python的版本
	pyenv local --unset		#取消 改变
	pyenv global x.x.x		#全局改变python版本
	pyenv shell x.x.x		#改变当前shell的python版本

	pyenv which python-version

	$ pyenv global 3.4.0 -- 设置全局的 Python 版本，通过将版本号写入 ~/.pyenv/version 文件的方式。
	$ pyenv local 2.7.3 -- 设置面向程序的本地版本，通过将版本号写入当前目录下的 .python-version 文件的方式。通过这种方式设置的 Python 版本优先级较 global 高。
	pyenv 会从当前目录开始向上逐级查找 .python-version 文件，直到根目录为止。若找不到，就用 global 版本。
	$ pyenv shell pypy-2.2.1 -- 设置面向 shell 的 Python 版本，通过设置当前 shell 的 PYENV_VERSION 环境变量的方式。这个版本的优先级比 local 和 global 都要高。--unset
	参数可以用于取消当前 shell 设定的版本。
	$ pyenv shell --unset

升级
```
$ cd ~/.pyenv
$ git pull
```

卸载
```
rm -rf ~/.pyenv		#快速方便
```

eg:在pyenv中使用virtualenv部署werkzueg的测试app

	#将virtualenv安装在pyenv中
	pyenv local pypy-2.3.1
	pyenv virtualenv venv_pypy
	pyenv local venv_pypy
	which python
	pip install -Ur requirements.txt
	pip install -U Gunicorn
	pyenv rehash
	which gunicorn
	gunicorn -b:5000 -w 9 werkzeug:test_app

python virtualevn创建_纯净虚拟环境_

虽然直接通过pip来安装virtualenv也是可以的，但是通过pyenv插件的形式安装virtualenv的虚拟环境更加方便，因为之后的操作会比较方便

pyenv-virtualenv插件安装:项目[https://github.com/yyuu/pyenv-virtualenv](https://github.com/yyuu/pyenv-virtualenv)

pyenv帮助你在一台机上建立多个版本的python环境， 并提供方便的切换方法。

virtualenv则就是将一个目录建立为一个虚拟的python环境， 这样的话， 用户可以建立多个虚拟环境， 每个环境里面的python版本可以是不同的， 也可以是相同的， 而且环境之间相互独立。

pyenv-virtualenv是pyenv的插件

	$ git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
	$ echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bash_profile
	$ exec "$SHELL"			#restart shell

这个插件就安装在.pyenv文件下了。

创建一个python版本的虚拟环境

	pyenv virtualenv x.x.x(version) envxxx(virtual_env_name)

这样就创建一个python的虚拟环境，这个环境的真是目录位于:~/.pyenv/versions/下,x.x.x必须为当前系统中已经安装好的python版本，否则会出错，我们可以通过pyenv version来查看当前的_虚拟环境_

切换和使用新的python虚拟环境

	pyenv activate envxxx

这样就可以切换到这个版本的虚拟环境，通过python来查看版本，发现处于虚拟环境中了，可以为所欲为了。如果要切换到系统环境

	pyenv deactivate

列表virtualenv

		pyenv virtualenvs

如果要删除这个虚拟环境，只要直接删除它所在的目录就可以了

	rm -rf ~/.pyenv/version/envxxx

或者直接卸载

	pyenv uninstall envxxx


## Anaconda

使用conda list查看anaconda安装自带的包

	conda  list

使用conda
list命令的环境时，python版本切换到anaconda版本下，不然，这个命令无法查询，在anancoda环境下，也是可以通过pip来安装其他包的。

给anaconda安装包

	conda install xxx	#如果需要指定版本[package-name]=x.x

多个python版本并存，尤其是2.x和3.x的并存

这个通过virtualenv可以做到，Anaconda也可以实现，下面用create命令来创建多个环境

	conda create -n python2 python=2.7

这样就会在Anaconda的安装目录下的envs目录创建python2

## virtualenv

简单来说，你的每一个项目都可以拥有一个单独的，孤立的python环境，你可以把所有的包安装到各自孤立的环境中，通过pip来安装virtualenv

	sudo pip install virtualenv

安装完成之后，为你的项目创建_孤立_的python环境

	mkdir my_project_venv
	virtualenv --distribute my_project_venv

创建一个名叫my\_project\_venv的文件夹，由于存储新的python环境，--disribute参数告诉virtualenv使用基于distribute包来开发新的，更好的打包系统，而不是基于setuptools的旧系统，--distribute参数将会自动在虚拟环境中安装pip，免去了手动安装的麻烦。

激活虚拟环境

	cd my_project_venv
	source bin/activate

使用source命令启动activate脚步，你的命令行提示符应该会变成这样

	(my_project_venv)$

关闭虚拟环境

	(my_project_venv) deactivate

当你的_系统层面_安装virtualenv时(如果激活了虚拟环境，请先关闭)，可以通过下面的命令来查看使用哪个执行文件

	which python
	/usr/bin/python
	which pip
	/usr/local/bin/pip

note:

 + 在通过pyenv install Anxxx发现，如何网络不可达，就会出现curl:SSL read:error errno,找一个网络速比较好的地方，再进行安装。
