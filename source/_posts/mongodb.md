---
title: MongoDB基本使用
date: 2023-03-19 10:01
tags: mongodb
categories: mongodb
---

mongodb 不同于 MySQL 这种关系型数据库，它是一个基于分布式文件存储的 Nosql 数据库。mongodb 支持的数据结构非常松散，可以通过 json 格式来修改插入数据。在 mongodb 中没有数据表，而是一个一个的 collection 集合。

<!-- more -->

#### 基本操作

- 查看数据库
  > show databses
- 选择数据库
  > use database[数据库名称] 选择不存在的数据库会隐式创建该数据库
- 删除数据库
  > 先选择到要删除的数据库 db.dropDatabase
- 查看集合

  > show collections

- 创建集合

  > db.createCollection('c1')

- 删除集合
  > db.集合名.drop()

#### 数据库的增删改查操作

- 增

  > 语法：db.集合名.insert(JSON 数据)

  > 集合存在，则直接插入数据，集合不存在，隐式创建并插入

  > 当同时插入多条数据时，将多条数据用数组包裹，每条数据为一个 json 数据对象

  > mongodb 支持 js 的部分语法，可以使用 for 循环一次性插入多条数据

示例：

```sh
use test2
db.c1.insert({username:"xzy",age:18})
db.c1.insertMany({})
留心一：数据库和集合不存在时，都隐式创建
留心二：对象的键同意不加引号方便看，但是查看集合数据时系统会自动加上
留心三：mongodn会给每条数据添加一个全球唯一的ID

插入多条数据：
传递数组，数组中每个元素都是一个JSON类型
db.c1.insert([
  {username:"z3",age:3},
  {username:"z4",age:4},
  {username:"z5",age:5}
])
插入十条数据：

for(var i=1;i<=10;i++){
  db.c1.insert({username:"a"+i,age:i})
}
```

- 删
  > 语法：db.集合名.remove(条件[,是否删除一条])
  > 是否删除一条 true 是，false 否 默认为 false

示例：

```sh
当存在多条符合条件的行时，只删除一条
db.c3.remove({username:"zs30"},true)
存在多条时，全部删除
db.c3.remove({username:"zs30"},false)
```

- 改

  > 语法：db.集合名.update（条件，新数据[,是否新增，是否修改多条]）

  > 是否新增：指条件匹配不到数据则插入，true 是插入，false 否不插入默认；是否修改多条：指将匹配成功的数据都修改（true 是，false 否默认）

示例：

```sh
db.c3.update({username:"zs1"},{username:"zs2"})#这样是替换，将符合条件的行直接换成这个
```

还可通过运算符来指定修改，运算符有：
运算符 | 作用 |
| ------- | ---- |
| $inc​ | 递增 |
| $rename | 重命名列 |
| $set | 修改列值 |
| $unset | 删除列

更新不存在的值,若不存在则不会有操作。在最后加一个 true 参数，作用是，如果不存在，则插入该条数据,默认为 false 则不管。第四个参数如果为 true，当匹配到多条条件符合的元素时，都更改，默认为 false，只改一条

示例：

```sh
db.c4.update({username:"熊子阳"},{
	$set:{username:"Aoi"},
	$inc:{age:971},
	$rename:{who:"sex"},
	$unset:{other:true}
})
db.c3.update({username:"zs30"},{$set:{age:30}},true）
db.c3.update({},{$set:{age:20}},false,true)
```

- 查
  > 语法：db.集合名.find(条件，[查询的列])

> 格式化：db.集合名.find().pretty()

> db.findOne() 只返回查询结果的第一条；db.findMany() 返回多条

示例：

```
条件：
	查询所有数据  				{}或者不写
	查询age=6的数据 			 {age:6}
	查询age=6且性别为男   {age:6,sex:'男'}

查询的列
	不写 - 查询全部的列
	{age:1} 只显示age列，可以显示多个想要的列{user:1,age:1.......}
	{age:0} 除了age列外都显示 可以不显示多个想要的列{user:0,age:0}
	无论怎么写系统自定义_id都会在
```

也可以通过运算符来指定查询：
运算符 | 作用 |
| ---- | ------ |
| $gt | 大于 |
| $gte | 大于等于 |
| $lt | 小于 |
| $lte | 小于等于 |
| $ne | 不等于 |
| $in | in |
| $nin | Not in

此时查询语法：

```sh
db.集合名.find({
	键：{运算符：值}
})
```

示例：

```sh
年龄小于5的
db.c1.find({age:{$lt:5}})

年龄等于3、4、5的
db.c1.find({age:{$in:[3,4,5]}})
```

#### try catch

当一次性插入或者更新 n 条数据时，mongodb 不会因为一条数据的错误而使得整个操作终止并回滚，只会终止接下来的操作，所以可以使用 try catch 来进行异常的捕捉处理。如下：

```
try{
  db.c1.insertMany([
  {"_id":1,name:"xzy"},
  {"_id":2,name:"lhl"},
	{"_id":3,name:"yzh"},
	{"_id":4,name:"lwy"}...
}
  ])
}catch(e){
	print
}
```

#### 排序与分页

- 排序
  > 语法：db.集合名.find().sort(JSON 数据)

> 这里 JSON 数据的键就是要排序的列/字段，值为排序的方式：1 升序，-1 降序

示例：

```sh
db.c2.find().sort({age:-1})
```

- 分页
  > 语法：db.集合名.find().skip(数字).limit(数字)

> 这里的 skip 为指定要跳过的数量，limit 为限制查询的数量，两者结合实现分页的效果

示例：

```sh
db.c2.find().sort({age:-1}).skip(1).limit(2)
```

#### 聚合查询

> 语法：db.集合名称.aggregate([{管道:{表达式}}....])

常用的管道有：

- $group 将集合中的文档分组，用于统计结果
- $match 过滤数据，只要输出符合条件的文档
- $sort 聚合数据进一步排序
- $skip 跳过指定文档数
- $limit 限制集合数据返回文档数

常用表达式有：

- $sum 总和
- $avg 平均
- $min 最小值
- $max 最大值

示例：
\_id 必须加，后跟指定列

```sh
男女生的总年龄
db.c3.aggregate([
	{
		$group:{
			_id:"$sex",
			res:{$sum:"$sex"}
	}
	}
])
求男女总人数
db.c3.aggregate([
	{
		$group:{
			_id:"$sex",
			res:{$sum:1}
	}
	}
])

求学生总数和平均年龄
db.c3.aggregate([
	{
		$group:{
			_id:null,
			res:{$sum:1},
      total_avg:{$avg:"$age"}
	}
	}
])

查询男生女生人数，升序排序
db.c3.aggregate([
	{$group:{	_id:"$sex",res:{$sum:1}}},
	{$sort:{res:1}}
])
```

以上就是 mongodb 的一些基本增删改查操作。
