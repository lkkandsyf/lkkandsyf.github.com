---
layout: post
category :
tagline: "Supporting tagline"
tags: LSTM
  -
title: '进程监控web工具supverisor'
---
对于大型的平台，多个服务运行，需要一个工具来有效监控进程，Supverisor: A Process Control System，一个开源的工具，简单又好用

---


<!--more-->

superviso

## 安装
安装教程到官网[http://supervisord.org/](http://supervisord.org/)按照步骤，就可以了,这是一个python的工具，可以使用pip来安装。
{% highlight C linenos %}
sudo pip install supervisor --upgrade -i http://pypi.douban.com/simple --trusted-host pypi.douban.com
{% endhighlight %}

### 添加配置文件
安装完成supervisor之后，通过echo\_supervisord\_conf来生成配置文件,例如
```C
$echo_supervisord_conf
; Sample supervisor config file.
;
; For more information on the config file, please see:
; http://supervisord.org/configuration.html
;
; Notes:
;  - Shell expansion ("~" or "$HOME") is not supported.  Environment
;    variables can be expanded using this syntax: "%(ENV_HOME)s".
;  - Quotes around values are not supported, except in the case of
;    the environment= options as shown below.
;  - Comments must have a leading space: "a=b ;comment" not "a=b;comment".
;  - Command will be truncated if it looks like a config file comment, e.g.
;    "command=bash -c 'foo ; bar'" will truncate to "command=bash -c 'foo ".

[unix_http_server]
file=/tmp/supervisor.sock   ; the path to the socket file
;chmod=0700                 ; socket file mode (default 0700)
;chown=nobody:nogroup       ; socket file uid:gid owner
;username=user              ; default is no username (open server)
;password=123               ; default is no password (open server)

;[inet_http_server]         ; inet (TCP) server disabled by default
;port=127.0.0.1:9001        ; ip_address:port specifier, *:port for all iface
;username=user              ; default is no username (open server)
;password=123               ; default is no password (open server)

[supervisord]
logfile=/tmp/supervisord.log ; main log file; default $CWD/supervisord.log
logfile_maxbytes=50MB        ; max main logfile bytes b4 rotation; default 50MB
logfile_backups=10           ; # of main logfile backups; 0 means none, default 10
loglevel=info                ; log level; default info; others: debug,warn,trace
pidfile=/tmp/supervisord.pid ; supervisord pidfile; default supervisord.pid
nodaemon=false               ; start in foreground if true; default false
minfds=1024                  ; min. avail startup file descriptors; default 1024
minprocs=200                 ; min. avail process descriptors;default 200
;umask=022                   ; process file creation umask; default 022
;user=chrism                 ; default is current user, required if root
;identifier=supervisor       ; supervisord identifier, default is 'supervisor'
;directory=/tmp              ; default is not to cd during start
;nocleanup=true              ; don't clean up tempfiles at start; default false
;childlogdir=/tmp            ; 'AUTO' child log dir, default $TEMP
;environment=KEY="value"     ; key value pairs to add to environment
;strip_ansi=false            ; strip ansi escape codes in logs; def. false

; The rpcinterface:supervisor section must remain in the config file for
; RPC (supervisorctl/web interface) to work.  Additional interfaces may be
; added by defining them in separate [rpcinterface:x] sections.

[rpcinterface:supervisor]
supervisor.rpcinterface_factory = supervisor.rpcinterface:make_main_rpcinterface

; The supervisorctl section configures how supervisorctl will connect to
; supervisord.  configure it match the settings in either the unix_http_server
; or inet_http_server section.

[supervisorctl]
serverurl=unix:///tmp/supervisor.sock ; use a unix:// URL  for a unix socket
;serverurl=http://127.0.0.1:9001 ; use an http:// url to specify an inet socket
;username=chris              ; should be same as in [*_http_server] if set
;password=123                ; should be same as in [*_http_server] if set
;prompt=mysupervisor         ; cmd line prompt (default "supervisor")
;history_file=~/.sc_history  ; use readline history if available

; The sample program section below shows all possible program subsection values.
; Create one or more 'real' program: sections to be able to control them under
; supervisor.

;[program:theprogramname]
;command=/bin/cat              ; the program (relative uses PATH, can take args)
;process_name=%(program_name)s ; process_name expr (default %(program_name)s)
;numprocs=1                    ; number of processes copies to start (def 1)
;directory=/tmp                ; directory to cwd to before exec (def no cwd)
;umask=022                     ; umask for process (default None)
;priority=999                  ; the relative start priority (default 999)
;autostart=true                ; start at supervisord start (default: true)
;startsecs=1                   ; # of secs prog must stay up to be running (def. 1)
;startretries=3                ; max # of serial start failures when starting (default 3)
;autorestart=unexpected        ; when to restart if exited after running (def: unexpected)
;exitcodes=0,2                 ; 'expected' exit codes used with autorestart (default 0,2)
;stopsignal=QUIT               ; signal used to kill process (default TERM)
;stopwaitsecs=10               ; max num secs to wait b4 SIGKILL (default 10)
;stopasgroup=false             ; send stop signal to the UNIX process group (default false)
;killasgroup=false             ; SIGKILL the UNIX process group (def false)
;user=chrism                   ; setuid to this UNIX account to run the program
;redirect_stderr=true          ; redirect proc stderr to stdout (default false)
;stdout_logfile=/a/path        ; stdout log path, NONE for none; default AUTO
;stdout_logfile_maxbytes=1MB   ; max # logfile bytes b4 rotation (default 50MB)
;stdout_logfile_backups=10     ; # of stdout logfile backups (0 means none, default 10)
;stdout_capture_maxbytes=1MB   ; number of bytes in 'capturemode' (default 0)
;stdout_events_enabled=false   ; emit events on stdout writes (default false)
;stderr_logfile=/a/path        ; stderr log path, NONE for none; default AUTO
;stderr_logfile_maxbytes=1MB   ; max # logfile bytes b4 rotation (default 50MB)
;stderr_logfile_backups=10     ; # of stderr logfile backups (0 means none, default 10)
;stderr_capture_maxbytes=1MB   ; number of bytes in 'capturemode' (default 0)
;stderr_events_enabled=false   ; emit events on stderr writes (default false)
;environment=A="1",B="2"       ; process environment additions (def no adds)
;serverurl=AUTO                ; override serverurl computation (childutils)

; The sample eventlistener section below shows all possible eventlistener
; subsection values.  Create one or more 'real' eventlistener: sections to be
; able to handle event notifications sent by supervisord.

;[eventlistener:theeventlistenername]
;command=/bin/eventlistener    ; the program (relative uses PATH, can take args)
;process_name=%(program_name)s ; process_name expr (default %(program_name)s)
;numprocs=1                    ; number of processes copies to start (def 1)
;events=EVENT                  ; event notif. types to subscribe to (req'd)
;buffer_size=10                ; event buffer queue size (default 10)
;directory=/tmp                ; directory to cwd to before exec (def no cwd)
;umask=022                     ; umask for process (default None)
;priority=-1                   ; the relative start priority (default -1)
;autostart=true                ; start at supervisord start (default: true)
;startsecs=1                   ; # of secs prog must stay up to be running (def. 1)
;startretries=3                ; max # of serial start failures when starting (default 3)
;autorestart=unexpected        ; autorestart if exited after running (def: unexpected)
;exitcodes=0,2                 ; 'expected' exit codes used with autorestart (default 0,2)
;stopsignal=QUIT               ; signal used to kill process (default TERM)
;stopwaitsecs=10               ; max num secs to wait b4 SIGKILL (default 10)
;stopasgroup=false             ; send stop signal to the UNIX process group (default false)
;killasgroup=false             ; SIGKILL the UNIX process group (def false)
;user=chrism                   ; setuid to this UNIX account to run the program
;redirect_stderr=false         ; redirect_stderr=true is not allowed for eventlisteners
;stdout_logfile=/a/path        ; stdout log path, NONE for none; default AUTO
;stdout_logfile_maxbytes=1MB   ; max # logfile bytes b4 rotation (default 50MB)
;stdout_logfile_backups=10     ; # of stdout logfile backups (0 means none, default 10)
;stdout_events_enabled=false   ; emit events on stdout writes (default false)
;stderr_logfile=/a/path        ; stderr log path, NONE for none; default AUTO
;stderr_logfile_maxbytes=1MB   ; max # logfile bytes b4 rotation (default 50MB)
;stderr_logfile_backups=10     ; # of stderr logfile backups (0 means none, default 10)
;stderr_events_enabled=false   ; emit events on stderr writes (default false)
;environment=A="1",B="2"       ; process environment additions
;serverurl=AUTO                ; override serverurl computation (childutils)

; The sample group section below shows all possible group values.  Create one
; or more 'real' group: sections to create "heterogeneous" process groups.

;[group:thegroupname]
;programs=progname1,progname2  ; each refers to 'x' in [program:x] definitions
;priority=999                  ; the relative start priority (default 999)

; The [include] section can just contain the "files" setting.  This
; setting can list multiple files (separated by whitespace or
; newlines).  It can also contain wildcards.  The filenames are
; interpreted as relative to this file.  Included files *cannot*
; include files themselves.

;[include]
;files = relative/directory/*.ini
```
[more_info](http://supervisord.org/configuration.html#programx-section)
注释符号为;,根据自己的需求修改配置文件,生成配置文件
{% highlight C linenos %}
sudo echo_supervisord_conf > /etc/supervisord_conf
{% endhighlight %}

demo:
{% highlight C linenos %}
[supervisord]
logfile = /tmp/supervisord.log
logfile_maxbytes = 50MB
logfile_backups=10
loglevel = info
pidfile = /tmp/supervisord.pid
nodaemon = false
minfds = 1024
minprocs = 200
umask = 022
user = chrism
identifier = supervisor
directory = /tmp
nocleanup = true
childlogdir = /tmp
strip_ansi = false
environment = KEY1="value1",KEY2="value2"
{% endhighlight %}

### 启动supervisor
{% highlight C linenos %}
supervisord -c /etc/supervisord.conf
{% endhighlight %}
通过web页面(localhost:9001)就可以访问了

### 更新配置到supervisor
{% highlight C linenos %}
supervisorctl update
{% endhighlight %}

### 重新启动配置中的所有程序
{% highlight C linenos %}
supervisorctl reload
{% endhighlight %}

### 查看正在守护的进程
{% highlight C linenos %}
supervisorctl
{% endhighlight %}

### 停止全部进程
{% highlight C linenos %}
supervisorctl stop all
{% endhighlight %}

### 启动某个进程

program\_name=在配置文件中写的程序名称
{% highlight C linenos %}
supervisorctl start program_name
{% endhighlight %}

### 重启某个进程

program\_name=在配置文件中写的程序名称
{% highlight C linenos %}
supervisorctl restart program_name
{% endhighlight %}

## 监视进程

### 添加一个进程

官网配置文件[demo](http://supervisord.org/configuration.html#programx-section)
{% highlight C linenos %}
[program:cat]
command=/bin/cat
process_name=%(program_name)s
numprocs=1
directory=/tmp
umask=022
priority=999
autostart=true
autorestart=unexpected
startsecs=10
startretries=3
exitcodes=0,2
stopsignal=TERM
stopwaitsecs=10
stopasgroup=false
killasgroup=false
user=chrism
redirect_stderr=false
stdout_logfile=/a/path
stdout_logfile_maxbytes=1MB
stdout_logfile_backups=10
stdout_capture_maxbytes=1MB
stdout_events_enabled=false
stderr_logfile=/a/path
stderr_logfile_maxbytes=1MB
stderr_logfile_backups=10
stderr_capture_maxbytes=1MB
stderr_events_enabled=false
environment=A="1",B="2"
serverurl=AUTO
{% endhighlight %}
写一个python程序task.py,不停的写入日志文件
{% highlight python linenos %}
#!/bin/python
import os
import time
i = 0
file_name = "/root/log.log"
def write_log(content):
    f = open(file_name,'a')
    f.write(content + "\n")
    f.close()

while True:
    output = "echo " + str(i)
    write_log(output)

    i = i + 1
    time.sleep(2)

{% endhighlight %}
在supervisord运行 起来之后，添加要管理的进程的配置文件，在supervisord的配置文件中，通过include的方式把`不同的程序(组)`写到不同的配置文件中
```C
[include]
files = /etc/supervisor/*.conf
```
在/etc/supervisor/目录下创建一个task.conf文件，内容如下
```C
[program:task]
;directory = /root				;程序启动目录
command=/root/task.py
user=root					;以哪个用户来启动程序
numprocs=1
autostart=true					;在supervisor启动时也启动
autorestart=true
process_name=%(program_name)s			;程序文件名
startsecs=5
startretries=3					;启动失败自动重试次数,默认是3
stopsignal=TERM
stopasgroup=true
killasgroup=true
exitcodes=1,2
stdout_logfile=/root/task.log
stderr_logfile=/root/task.err
stdout_logfile_maxbytes=20MB
stdout_logfile_backups=5
stderr_logfile_maxbytes=10MB
stderr_logfile_backups=5
;通过environment 来添加需要的环境变量，常见的用法是修改PYTHONPATH
;environment=PYTHONPATH=$PYTHONPATH:/path/to/somewhere
```
配置完成之后，重新运行
{% highlight C linenos %}
supervisorctl reload
{% endhighlight %}
这时，再刷新浏览器就可以看到添加的任务了

除了单个进程的控制，还可以配置 group，进行分组管理。

经常查看日志文件，包括 supervisord 的日志和各个 pragram 的日志文件，程序 crash 或抛出异常的信息一半会输出到 stderr，可以查看相应的日志文件来查找问题。
## 异常问题

 + **Error:Another program already listening to a port that one of our HTTP servers is configured to use,Shut this program down first before starting**

 解决方案：由于supverisor 在启动时，会建立一个文件，只要删除了就可以了
```C
$find / -name supverisor.sock
$unlink /tmp/supervisor.sock
```
