---
layout: post
category: Elasticsearch
tagline: "Supporting tagline"
tags: cat
  -
title: 'ES操作大全'
---

---

### cat命令

首先接触es，了解了基本的架构，加上cat命令操作，加深理解。不管学什么help就是的入门法宝!

```C
curl http://localhost:9200/cat
=^.^=
/_cat/allocation
/_cat/shards
/_cat/shards/{index}
/_cat/master
/_cat/nodes
/_cat/tasks
/_cat/indices
/_cat/indices/{index}
/_cat/segments
/_cat/segments/{index}
/_cat/count
/_cat/count/{index}
/_cat/recovery
/_cat/recovery/{index}
/_cat/health
/_cat/pending_tasks
/_cat/aliases
/_cat/aliases/{alias}
/_cat/thread_pool
/_cat/thread_pool/{thread_pools}
/_cat/plugins
/_cat/fielddata
/_cat/fielddata/{fields}
/_cat/nodeattrs
/_cat/repositories
/_cat/snapshots/{repository}
/_cat/templates
```
#### allocation

#### shards

#### master

#### nodes

#### tasks

#### indices

#### segments

#### count

#### recovery

#### health

#### pending\_tasks

#### aliases

#### thread\_pool

#### plugins

#### fielddata

#### nodeattrs

#### repositories

#### snapshots

#### templates


<!--more-->

## reference

sql to  dsl

[https://github.com/360EntSecGroup-Skylar/ElasticHD](https://github.com/360EntSecGroup-Skylar/ElasticHD)

[https://github.com/cch123/elasticsql](https://github.com/cch123/elasticsql)
