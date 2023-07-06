---
title: Vue3自定义 Hook
date: 2023-05-14 11:10
tags: Vue
categories: Vue
---

#### 什么是 hook

自定义 hook 函数其实本质就是一个函数，把 setup 函数中使用的 composition API（组合式 API）进行封装，这就类似[Vue2](https://so.csdn.net/so/search?q=Vue2&spm=1001.2101.3001.7020)中的 mixin。

自定义 hook 的优势：代码复用，使 setup 中的逻辑更清晰易懂。

<!-- more -->

#### 创建一个自定义 hook

我们创建一个自定义 hook 函数，并演示它的使用方法。

1.新建一个项目，在 src 文件夹下新建 hooks 文件夹

![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/0459ff9628a7402daa41bcd815c2f855~tplv-k3u1fbpfcp-watermark.image?)

2.在 hooks 文件夹下创建 useCount.ts 文件，在文件中写入演示代码

```ts
import { ref } from 'vue'

export const useCount = () => {
  const a = ref<number>(0)

  const add = () => a.value++

  const sub = () => a.value--

  return { a, add, sub }
}
```

在开头我们就说过，hook 函数其实本质就是一个函数，所以我们在这里导出 useCount 函数，通常情况下 hook 函数都是以 use 开头的。在这个函数里面，定义了一个变量 a，自增函数 add，自减函数 sub，并将它们返回。

#### 使用自定义 hook

在 components 文件夹下新建 Demo.vue 组件，并在 App.vue 中使用，在 Demo 组件中写入如下演示代码

```html
<template>
  <div>{{ a }}</div>
  <button @click="add">add</button>
  <button @click="sub">sub</button>
</template>

<script setup lang="ts">
  import { useCount } from '../hooks/useCount'
  const { a, add, sub } = useCount()
</script>

<style></style>
```

首先导入自定义的 useCount hook 函数，因为这个函数返回了 a, add, sub，所以通过结构的方式将他们取出。在 html 结构中，通过 div 将 a 的值展示，并通过两个按钮来控制自增自减。

![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/dec12fb5467d464f90a3ea39b6f96a28~tplv-k3u1fbpfcp-watermark.image?)

当点击 add 时，a 的数值增加

![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/5674199bd7f64196a6cbd4d59b90a2f1~tplv-k3u1fbpfcp-watermark.image?)

点击 sub 时，a 的数值减小

![image.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/33e1e40a87cb411e80b1038156678f0a~tplv-k3u1fbpfcp-watermark.image?)

这就是一个非常简单的自定义 hook 函数，通过这个加减的例子或许对你理解会有些许帮助。
