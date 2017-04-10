---
layout: post
category : JavaError
tagline: "Supporting tagline"
tags : [maven-surefire-plugin]
---
这里整理自己学习Java过程中遇到的一些问题，简单记录下来，方便以后查看。
---
<!--more-->
---


## 编译错误

**P1**
```Java
Failed to execute goal org.apache.maven.plugins:maven-surefire-plugin:2.10:test
```
[stackoverflow](http://stackoverflow.com/questions/13170860/failed-to-execute-goal-org-apache-maven-pluginsmaven-surefire-plugin2-10test)

`Solution`:

Update the Maven project:

Steps:

	1.Right-click on "project"
	2.Go to "Maven" >> "Update"
	3.Wait for all the changes to be applied
	4.Commit the changes (if code is on repo)
	5.Run

or:

In my application, certain unit tests were not compatible with Java 8 so they were failing. The build would succeed with `mvn clean install -DskipTests `but it is not recommended to skip the unit test.


**P2**

```Java
NoClassDefFoundError: scala/collection/Seq
```
[stackoverflow](http://stackoverflow.com/questions/33885339/noclassdeffounderror-scala-collection-seq)

`Solution`:

It happened because my java code was build with Scala, but at runtime scala library wasn't available. `Added scala-library.jar to classpath'`, that [resolved it](http://zyjustin9.iteye.com/blog/2172445).
