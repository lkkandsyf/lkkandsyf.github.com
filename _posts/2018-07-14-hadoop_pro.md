---
layout: post
category: hadoop
tagline: "Supporting tagline"
tags: yarn
  -
title: 'hadoop 疑难杂症'
---
收集hadoop中的碰到过的疑难杂症

---

<!--more-->

##  yarn
  + I've got a number of Samza jobs that I want to run. I can get the first to run ok. However, the second job seems to sit at the ACCEPTED state and never transitions into the RUNNING state until I kill the first job.

  **solution**:
  I changed the value of yarn.scheduler.capacity.maximum-am-resource-percent within capacity-scheduler.xml to be `more than the default of 0.1.` the [document](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/CapacityScheduler.html) for more help

  + Why does Hadoop report `Unhealthy Node local-dirs and log-dirs are bad`?,On visiting http://localhost:8088/cluster, I find that my nodsted as an "unhealthy node".

  **solution**:
  The most common cause of local-dirs are bad is due to available disk space on the node exceeding yarn's max-disk-utilization-per-disk-percentage default value of 90.0%.
   Either clean up the disk that the unhealthy node is running on, or increase the threshold in yarn-site.xml
```C
<property>
<name>yarn.nodemanager.disk-health-checker.max-disk-utilization-per-disk-percentage</name>
<value>98.5</value>
</property>
```
Avoid disabling disk check, because your jobs may failed when the disk eventually run out of space, or if there are permission issues. Refer to the yarn-site.xml Disk Checker section for more details.
If you suspect there is filesystem error on the directory, you can check by running
hdfs fsck /tmp/hadoop-hduser/nm-local-dir
Refer to the [yarn-site.xml Disk Check section](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/NodeManager.html#Disk_Checker)

