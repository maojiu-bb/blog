---
title: 使用customRef来做防抖
date: 2023-6-30 19:48
tags: Vue
categories: Vue
---

在我们做防抖功能时，不管是用 lodash 还是其他的什么，都可能会使书写的代码变得臃肿。

对此，我们可以使用 Vue 提供的 customRef 来封装一个防抖函数。

<!-- more -->

- 新建 debounce.ts 文件

```ts
import { customRef } from 'vue'

export const debounce = (value: string, delay: number = 1000) => {}
```

首先先导入 `customRef` API，并写好基本的防抖函数，其中`value`为传过来的值，`delay`为要延迟的时间。

要通过`customRef`来实现防抖，首先要知道 Vue 的原理 `getter`, `setter`。我们就是要通过控制这两个来实现功能。

```ts
import { customRef } from 'vue'

export const debounce = (value: string, delay: number = 1000) => {
  return {
    get: () => {
      return value
    },
    set: (newValue: string) => {
      value = newValue
    }
  }
}
```

再配合上`customRef`:

```ts
import { customRef } from 'vue'

export const debounce = (value: string, delay: number = 1000) => {
  return customRef((track, trigger) => {
    return {
      get: () => {
        return value
      },
      set: (newValue: string) => {
        value = newValue
      }
    }
  })
}
```

其中的`track`是告诉 Vue 这个 value 值要被“追踪”, `trigger`是告诉 Vue 去更新界面。所以我们可以在这里做文章，实现防抖的功能。

```ts
import { customRef } from 'vue'

export const debounce = (value: string, delay: number = 1000) => {
  let timer: number
  return customRef((track, trigger) => {
    return {
      get: () => {
        track()
        return value
      },
      set: (newValue: string) => {
        clearTimeout(timer)
        timer = setTimeout(() => {
          value = newValue
          trigger()
        }, delay)
      }
    }
  })
}
```

配合上定时器，一个防抖功能的函数就完成了。

- 在页面中使用:

```ts
import { debounce } from './hooks/debounce'
const text = debounce('', 1000)
```

```html
<template>
  <input type="text" v-model="text" />
  <div>{{ text }}</div>
</template>
```
