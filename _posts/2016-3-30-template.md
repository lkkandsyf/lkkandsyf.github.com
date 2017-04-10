---
layout: post
category :
tagline: "Supporting tagline"
tags : []
---
template blog
---
<!--more-->
---

This Jekyll introduction will outline specifically  what Jekyll is and why you would want to use it.
Directly following the intro we'll learn exactly _how_ Jekyll does what it does.


# kangakng
 - [] 不勾选
 - [x] 勾选

```

 First Header | Second Header | Third Header
 ------------ | ------------- | ------------
 Content Cell | Content Cell  | Content Cell
 Content Cell | Content Cell  | Content Cell


```
tow diff

```

First Header | Second Header | Third Header
:----------- | :-----------: | -----------:
Left         | Center        | Right
Left         | Center        | Right


```

x^{y^z}=(1+{\rm e}^x)^{-2xy^w}

```ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
```

c++ code
```c++
#include <iostream>

void main(int argc,char *argv)
{
    return 0;
}
```


> ``` git push origin master```


* void
* main

## kangkangblog
  1.请注意，* dir这一行是必需的，它表示目录树列表，至于星号后面写什么请随意
  2.如果要把某标题从目录树中排除，则在该标题的下一行写上 {:.no_toc}
  3.目录深度可以通过 config.yml 文件中添加 toc_levels 选项来定制，默认为 1..6，表示标题一至标题六全部渲染
  4.{:toc} 默认生成的目录列表会添加 id 值 markdown-toc，我们可以自定义 id 值，比如 {:toc #chenxsan}，生成的目录列表添加的 id 将会是 chenxsan。


para.*Italic*,**bold**,***both***,`liangkangkang`

Here is a bullet list:

- apple
- banana
- orange

Here is a number list:

- 1.apple

- 2.banana

- 3.organge

> Block quotes are writeen like so.
> I like you

You can specify an inline like so $x^2+y^2=z^2$

