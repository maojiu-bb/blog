---
title: Vue3响应式原理
date: 2023-02-10 16:29
tags: Vue
categories: Vue
---

Vue3 与 Vue2 有着不同的响应式原理

<!-- more -->

### 回顾 Vue2 的响应式原理

Vue2 的响应式是通过`Object.defineProperty()`来实现的，也是利用数据劫持。

如下：

    // 数据源
    const person = {
        name: 'zs',
        age: 18
      }

    const p1 = {}
      Object.defineProperty(p1, 'name', {
        configurable: true,
        get() {
          // 读取 name 时调用
          return person.name
        },
        set(val) {
          // 修改 name 时调用
          console.log('修改了 name 属性')
          person.name = val
        }
      })

在读取 person 对象的 name 属性时，调用了 get 方法，返回读取对象属性的属性值；在修改 name 属性的时候，调用 set 方法，对 name 属性重新赋值。

这种响应式存在着一些缺点：

在新增属性，删除属性以及直接通过下标修改数组时，页面不会自动更新。

### Vue3 的响应式原理

Vue3 的响应式是基于 Proxy 来实现的，解决了 Vue2 中响应式存在的缺陷。

实现原理：

**通过 Proxy 代理**：拦截对象属性的操作，包括属性增删改查等。

**通过 Reflect 反射**：对源对象的属性进行操作。

实例：

    const p2 = new Proxy(person, {
        // 读取某个属性时调用
        // 拦截
        get(target, propName) {
          console.log(`有人读取了p2上的${propName}`)
          // 读取源对象属性
          // return target[propName]
          return Reflect.get(target, propName)
        },
        // 有人修改或追加某个属性时调用
        set(target, propName, val) {
          console.log(`有人修改了p2上的${propName}`)
          // target[propName] = val
          return Reflect.set(target, propName, val)
        },
        // 有人修改某个属性时调用
        deleteProperty(target, propName) {
          console.log(`有人删除了p2上的${propName}`)
          // return delete target[propName]
          return Reflect.deleteProperty(target, propName)
        }
      })

#### Proxy

Proxy 用来创建对象代理，第一个参数`target`为要拦截的目标对象，第二个参数`handler`为配置对象，指定拦截后的行为， get 和 set 等方法就要写在配置对象中。

#### Reflect

Reflect  是一个内置的对象，它提供拦截 JavaScript 操作的方法。这些方法与 proxy handlers 的方法相同。Reflect 不是一个函数对象，因此它是不可构造的。

### 总结

Vue3 使用`Proxy`和`Reflect`配合实现数据的响应式，解决了 Vue2 通过`Object.defineProtypies`实现响应式中存在的一些问题。
