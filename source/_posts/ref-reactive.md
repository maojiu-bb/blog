---
title: ref函数与reactive函数
date: 2023-02-10 17:23
tags: Vue
categories: Vue
---

`ref`函数与`reactive`函数都是用来定义响应式数据的，但它们又存在差别：

<!-- more -->

### ref 函数

基本语法：`const data = ref(initValue)`

`ref`函数返回的是一个`RefImpl`的实例对象（引用实现的实例对象），里面包含了响应式的数据，在 js 中访问 ref 中的数据时要加`.value`，在模板中使用不需要加。`ref`函数可以接收基本数据类型，也可以接收引用数据类型。

如：

```js
const name = ref('Vue3')
const jobInfo = ref({
  type: 'frontend',
  salary: '40w'
})

const changeInfo = () => {
  name.value = '鱿鱼丝'
  // jobInfo 是 RefImpl 实例
  // jobInfo.value 是 Proxy 实例对象
  jobInfo.value.salary = '50w'
}
```

### reactive 函数

基本语法：`const 代理对象 = reactive(源对象)`

`reactive`不可用于定义基本数据类型。接收的是对象或数组，返回代理对象（Proxy 的实例对象）。`reactive`是基于 ES6 的 Proxy 实现的，通过代理对象来操作源对象内部的数据，是深度响应式的。通过`reactive`定义的数据，在 js 和模板中访问都不需要加`.value`。

如：

```js
const person = reactive({
  name: 'Vue3',
  sex: 'unknown',
  info: {
    school: 'Oxford',
    major: 'computer'
  }
})

const color = reactive(['red', 'green', 'blue'])

const changeInfo = () => {
  person.info.major = 'art'
  color[0] = 'yellow'
}
```

### 总结

`ref`函数和`reactive`函数都是用来定义响应式数据的，但 ref 函数适合于定义基本数据类型的数据，reactive 适合于定义引用数据类型的数据。
