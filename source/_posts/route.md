---
title: 导航与导航守卫
date: 2023-01-19 16:22
tags: Vue-router
categories: Vue
---

## 导航

前端路由导航有两种不同的方式，一种是声明式导航，一种是编程式导航。

<!-- more -->

### 声明式导航

声明式导航就是使用`<a href=""></a>`或者`<router-link></router-link>`等声明的方式来进行导航跳转

```html
<a href="www.baidu.com">跳转到百度</a>
<router-link to="/home">首页</router-link>
```

### 编程式导航

编程式导航就是不使用`<a href=""></a>`或`<router-link></router-link>`等声明方式来导航

##### location.href

在原生的 js 中，通过 location.href = '跳转的地址'，来实现编程式导航跳转

    loaction.href = 'www.baidu.com'

##### this.$router

在 vue 项目中，this 指向 vue 的实例对象$router 上有许多与编程式导航跳转的方法：

1.`this.$router.push('hash地址')`，通过这个方法进行跳转会留下一条历史记录

2.`this.$router.replace('hash地址')`，这个方法跳转会替换掉当前的历史记录前往新的地址

3.`this.$router.go(n)`，n 是一个数值，当数值为正时，表示要前进的历史记录层数；当数值为负时，表示要后退的历史记录层数

4.`this.$router.back(n)`，n 也是数值，后退到指定的历史记录层数页面

5.`this.$router.forward(n)`，n 也是数值，前进到指定的历史记录层数页面

```js
    methods: {
        handlerPush() {
            this.$router.push('/home')
        },
        handlerReplace() {
            this.$router.replace('/login')
        },
        handlerGo() {
            this.$router.go(-1)
        },
        handlerBack() {
            this.$router.back(1)
        },
        handlerForward() {
            this.$router.forward(1)
        }
    }
```

## 导航守卫

导航守卫能够控制路由的访问权限，比如在未登录的状态下无法访问后台相关的信息，强制跳转到登录页在登录后才能访问

##### 全局前置导航守卫

每次在路由导航时都会触发全局前置导航守卫，调用路由实例对象的`beforeEach()`方法，声明全局前置守卫。

`router.beforeEach(fn)`，其中，fn 为一个回调函数，里面接收三个参数，分别为`(to,from,next)`，to 是将要访问的路由信息对象，from 是将要离开的路由信息对象，next 是一个函数，调用`next()`方法表示放行，允许本次访问。

next 函数的三种调用方式：

1.`next()`，表示拥有访问权限直接放行

2.`next('/login')`，表示没有访问权限，强行跳转到一个登录页面上

3.`next(false)`，表示没有访问权限，也不进行跳转

实例

```js
// 全局前置导航守卫
router.beforeEach((to, from, next) => {
  if (pathArray.includes(to.path)) {
    // pathArray 为一个存放要访问权限的hash地址的数组
    const token = localStorage.getItem('token')
    // 判断是否有 token若无直接跳转到登录页面
    if (token) {
      // 有 token 放行
      next()
    } else {
      // 无 token 强制跳转到登录页
      next('/login')
    }
  } else {
    // 不需要 token 直接放行
    next()
  }
})
```
