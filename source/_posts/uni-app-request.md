---
title: uni-app封装request请求
date: 2023-03-11 16:43
tags: uni-app
categories: uni-app
---

在 uni-app 中发送网络请求，uni-app 为我们提供了 uni.request(OBJECT)来发起网络请求。在一个项目中，如果只有少量的请求，用这个来发起网络请求还是可以的。但是，在实际开发中往往会有很多的请求，一个项目的接口随着需求的增加而增加。如果在每次发送请求的时候都单独按照 uni.request(OBJECT)来进行设置的话，会使我们的代码变得繁琐冗余不利于维护。对此，我们可以基于 uni.request(OBJECT)来封装一个我们自己的网络请求。

<!-- more -->

#### 封装 request 请求

##### 1.定义域名

可以定义一个域名来避免在代码中重复书写

```js
const BASE_URL = 'http://localhost:3006'
```

##### 2.设置请求头

对请求头中的信息进行整理

```js
const header = {
  'content-type': 'application/json'
}
// 判断在缓存中是否含有token
const token = uni.getStorageSync('token')
if (token) {
  header = {
    'content-type': 'application/json',
    Authorization: 'Bearer ' + token
  }
}
```

##### 3.利用 Promise 将 uni.request 包裹

利用 Promise 将 uni.request 进行包裹来发送异步请求

```js
new Promise((resolve, reject) => {
  uni.request({
    url: BASE_URL + option.url,
    method: option.method || 'GET',
    header: header,
    data: option.data,
    success(res) {
      resolve(res)
    },
    fail(err) {
      reject(err)
    }
  })
})
```

##### 4.完整示例

```js
const BASE_URL = 'http://localhost:3006'
const header = {
  'content-type': 'application/json'
}
const token = uni.getStorageSync('token')
if (token) {
  header = {
    'content-type': 'application/json',
    Authorization: 'Bearer ' + token
  }
}
export const request = (option) => {
  return new Promise((resolve, reject) => {
    uni.request({
      url: BASE_URL + option.url,
      method: option.method || 'GET',
      header: header,
      data: option.data,
      success(res) {
        resolve(res)
      },
      fail(err) {
        reject(err)
      }
    })
  })
}
```

#### 在组件中使用 request

##### 1.引入 request.js

```js
import { request } from '@/utils/request.js'
```

我所封装的 request.js 是在 utils 目录下的

##### 2.使用 request 发请求

```js
request({
  url: '/api/getData',
  method: 'GET'
}).then((res) => {
  console.log(res)
})
```

我们也可以使用 async,await 语法糖来获取数据，如下示例：

```js
import { ref } from 'vue'
let num = ref('')
const getData = async () => {
  const res = await request({
    url: '/api/getData',
    method: 'GET'
  })
  if (res.code === 200) {
    num = res.num
  }
}
```

这里封装的 request 请求，不含有拦截器，只是基于 uni-app 进行了简单的封装。
