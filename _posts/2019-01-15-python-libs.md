---
layout: post
category: Python
tagline: "Supporting tagline"
tags:
  -
title: 'Python libs整理'
---
对于日常中Python库的整理

---


<!--more-->

##  json simplejson

JSON(JavaScript Object Notation)是一种轻量级的数据交换格式

simplejson比json更新快, simplejson支持的python版本范围更广

```c
try:
    import simplejson as json
except ImportError:
    import json
```
格式化json格式文件python -m simplejson.tool PATH/json.json
```C
在python中使用Json
Import json
.json文件的读入
with open(filePath,'r')as f:
      data = json.load(f)
data是字典类型
可以通过for k,v in data.items()来遍历字典
.json文件的写入
首先存放为.json类型的文件一般是k-v类型的，一般是先打包成字典写入
jsFile = json.dumps(bigramDict)
with open(filepath.json,'w')as f:
    f.write(jsFile)
    f.close()

几个主要函数：dump,dumps,load,loads 带s跟不带s的区别是 带s的是对 字符串的处理，而不带 s的是对文件对像的处理。
函数1dumps(dict):将python字典json化,接收参数为字典类型
函数2sort_keys:设置是否排序字典
函数3dump（）：对文件对象的处理
函数4 loads(str)解析json的字符串
函数5 load()
```

### pycharts
```c
pip install pyecharts
```
+ 柱形图
```C
from pyecharts import Bar

bar = Bar("成绩柱形图", "副标题")
# 用于添加图表的数据和设置各种配置项
# is_more_utirl=True 可以按右边的下载按钮将图片下载到本地
bur.add("成绩表", ["语文", "数学", "英语", "物理", "化学", "生物"], [88, 90, 92, 87, 83, 81],)

bur.add("成绩表", ["语文", "数学", "英语", "物理", "化学", "生物"], [88, 90, 92, 87, 83, 81],is_more_util=True)
bar.show_config()    # 打印输出图表的所有配置项
bar.render('D:\pye\bar.html')         # 在指定目录下生成一个 bar.html 的文件
```
+ 饼图
```C
from pyecharts import Pie


attr = ["语文", "数学", "英语", "物理", "化学", "生物"]
score = [20, 30, 40, 25, 10, 15]
pie = Pie('图书销量饼图')
pibel_show=True)
pie.render('F:\pye\pie.html')e.add('', attr, score,)

```
+ 圆环图
```C
from pyecharts import Pie


attr = ["语文", "数学", "英语", "物理", "化学", "生物"]
score = [20, 30, 40, 25, 10, 15]
pie = Pie('图书销量圆环图', title_pos='center')
pibel_show=True,
        legend_orient='vertical', legend_pos='left')
        pie.render('F:\pye\pieround.html')   # 在指定目录下生成文件e.add('', attr, score, radius=[40, 75], label_text_color=None,)

```
+ 3D散图
```C
from pyecharts import Scatter3D
from pyecharts import Page
import random

plmap=True, visual_range_color=range_color)
page.add(scatter3D)
page.render('D:\pye\scatter.html')    # 在指定目录下生成文件age = page()
data = [[random.randint(0, 100), random.randint(0, 100), random.randint(0, 100)] for _ in range(80)]
range_color = ['#313695', '#4575b4', '#74add1', '#abd9e9', '#e0f3f8', '#ffffbf',
               '#fee090', '#fdae61', '#f46d43', '#d73027', '#a50026']
               scatter3d = scatter3d("3d 散点图示例", width=1200, height=600)
               scatter3d.add("", data,)

```
+ 3D折线图
```C
from pyecharts import Line3D

dlmap=True)
Line3D.render('F:\pye\3D折线图.html')    # 在指定目录下生成文件ata = [[1, 2, 3, 4], [1, 2, 3, 4], [0, 4, 8, 16]]
line3d = line3d("3d 折线图示例", width=1200, height=600)
line3d.add("", data,)

```
+ 仪表盘
```C
from pyecharts import Gauge

gauge = Gauge('项目完成进度')
gauge.add('进度表', '完成率', 88.88)
gauge.render('F:\pye\gauge.html')    # 在指定目录下生成文件

```
+ 漏斗图
```C
from pyecharts import Funnel

attr = ['认知', '了解', '认可', '考虑', '意向', '购买']
value = [120, 100, 80, 60, 40, 20]
funnel = Funnel('客户购买分析图')
fubel_show=True, label_pos='inside', label_text_color='#fff')
funnel.render('F:\pye\funel.html')    # 在指定目录下生成文件nnel.add('买车', attr, value,)

```
+ 地图
```C
from pyecharts import Geo

decewise=True, visual_split_number=6)
geo.render('F:\pye\geo.html')    # 在指定目录下生成文件lmap=True,ata = [
    ("上海", 25), ("北京", 36), ("武汉", 23), ("舟山", 12), ("齐齐哈尔", 14), ("盐城", 15),
        ("赤峰", 16), ("青岛", 18), ("乳山", 18), ("金昌", 19), ("泉州", 21), ("莱西", 21),
            ("日照", 21), ("胶南", 22), ("南通", 23), ("拉萨", 24), ("云浮", 24), ("梅州", 25)
]
geo = geo('主要城市空气质量', 'pm2.5', title_color='#fff', title_pos='center',
          width=1200, height=600, background_color='#404a59')
attr, value = geo.cast(data)
geo.add('', attr, value, visual_range=[0, 200], visual_text_color='#fff', symbol_size=15,
       )

```
+ 词云图
```C
from pyecharts import WordCloud

language = ['Python', 'C++', 'C', 'Java', 'C#', 'PHP', 'R', 'JavaScript', 'Go', 'Assembly']
rank = [100, 98.4, 98.2, 97.5, 89.8, 85.4, 83.3, 82.8, 76.7, 74.5]
wordcloud = WordCloud(width=1500, height=700)
wordcloud.add('', language, rank, word_size_range=[20, 100])
wordcloud.render('F:\pye\wc.html')    # 在指定目录下生成文件

```
+ 水球图
```C
from pyecharts import Liquid

liquid = Liquid("水球图")
liquid.add("Liquid", [0.8])
liquid.show_config()
liquid.render('F:\pye\sq.html')    # 在指定目录下生成文件

```
[http://pyecharts.org](http://pyecharts.org)
