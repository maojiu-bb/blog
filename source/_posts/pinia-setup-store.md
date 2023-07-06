---
title: Pinia的setup store
date: 2023-05-14 10:19
tags: Pinia
categories: Pinia
---

如果你对 Pinia 不了解，但 Vuex 你应该知道，它是 Vue 的一个状态管理仓库。Vuex 的目前版本为 4.0x，你可以将 Pinia 理解为下一代的 Vuex。在现在的 Vue3 官方文档中，Pinia 已被官方推荐使用。

<!-- more -->

#### 先看看 Option Store 的语法

```js
import { defineStore } from 'pinia'

export const useCounterStore = defineStore('counter', {
  state: () => ({ count: 0 }),
  getters: {
    doubleCount: (state) => state.count * 2
  },
  actions: {
    increment() {
      this.count++
    }
  }
})
```

通过`defineStore()`  就可以定义一个 Store，里面有`state`,`getters`,`actions`。这种语法与  Vuex 中定义 Store 的语法非常近似，只是少了  `mutation` 。

不仅如此，这种写法也和  Vue2 的 Options API（选项式 API）结构类似：`state`  与  `data`  对应、`getters`  与  `computed`  对应、`actions`  与  `methods`  对应。

这种 Option Store 的写法，结构很清楚，思路很简单，与 Vuex 相似，使用起来容易上手。

#### 再看看 Setup Store 的语法

```js
import { defineStore } from 'pinia'
import { ref, computed } from 'vue'

export const useCounterStore = defineStore('counter', () => {
  const count = ref(0)
  const doubleCount = computed(() => count.value * 2)
  const increment = () => {
    count.value++
  }

  return {
    count,
    doubleCount,
    increment
  }
})
```

这对于习惯了 Vue3 的朋友来说就是一种享受，一眼便能看出来这就类似于 Vue3 推出的 Composition API（组合式 API）。这种写法更加灵活，这里的`ref`与`state`对应，`computed`与`getter`对应，定义的函数`function`与`action`对应。

两种写法都有属于它自己的优点，在开发时选择适合自己的就好了。
