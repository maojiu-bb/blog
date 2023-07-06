---
title: Promise的使用
date: 2023-01-04 19:10
tags: Promise
categories: JavaScript
---

我们知道，JavaScript 是单线程机制的，所谓的单线程，就是按照顺序执行，即执行完一个任务后再执行下一个。但是在 JavaScript 的线程上又出现了`同步`和`异步`两种情况，它们都在一条线程上，只是执行的顺序不一样。

<!-- more -->

当遇到异步任务时，异步任务会先被放到任务队列中，先去执行执行栈中的同步任务，一旦执行栈中的所有同步任务执行完毕，系统就会按次序的读取任务队列中的异步任务，于是异步任务结束等待状态，进入到执行栈中，开始执行。

![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/6cf27c5607c543918be25fe9e808b1cd~tplv-k3u1fbpfcp-watermark.image?)

由于主线程上不断重复获得任务，执行任务，再获取再执行，这种机制被称为`事件循环`

### Promise 是什么？

Promise 是异步编程的一种解决方案，实质也是一个构造函数，自身上有`resolve`、`reject`和`all`等方法，原型上有`then`和`catch`等方法。

Promise 能有效的解决回调地狱的问题，当一个回调函数嵌套一个回调函数的时候就会出现这样的一个嵌套结构，当嵌套多了就会出现回调地狱的情况，而 Promise 很好的解决了回调地狱的问题。

一个 Promise 对象代表了一个异步操作，并且一个 promise 必然处于以下几种状态之一：

- 待定(pending):初始状态，既没有被兑现，也没有被拒绝。
- 已兑现(fulfilled):这意味着操作完成。
- 已拒绝(rejected):这意味着操作失败。

![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/dbaefff0c03e424ebb84f5c2ba8c7fd7~tplv-k3u1fbpfcp-watermark.image?)

待定状态的 Promise 对象要么会通过一个值被兑现，要么会通过一个错误被拒绝。只有异步操作的结果可以决定当前是哪一种状态，任何的其他操作都无法改变这一个状态。一旦状态改变，就不会再变，任何时候都可以得到这个结果。

**Promise 的基本语法格式**

    const p = new Promise((resolve , reject) => {
    // resolve 表示成功的回调
    // reject 表示失败的回调

    // resolve('success');
    reject('error');
    })

    p.then(res => {
        // 成功的函数
        console.log(res);
    } , err => {
        // 失败的函数
        console.log(err);
    })

这里先创建了 Promise 的实例对象 p，在构造函数的内部接受了一个函数，函数的内部传递了`resolve`和`reject`两个参数。`resolve`将 Promise 对象的状态变为成功的状态，在异步操作成功时进行回调，并将结果作为参数传递出去；`reject`将 Promise 对象的状态变为失败的状态，在异步操作失败时进行回调，并将失败时发生的错误作为参数传递出去。再通过 Promise 的实例对象 p 调用`then()`方法来指定不同状态下的回调函数。

**catch 的使用**

Promise 对象的`catch`方法，这个方法与`try catch`方法类似，都是用来捕获异常的，同时和`then`方法中第二个参数 reject 的回调效果是一样的。区别在于：

在`then`方法中，如果在执行完 resolve 的回调后抛出一个错误，通过 reject 不能捕获到异常的错误

    p.then(res => {
      console.log(res);
      throw new Error('抛出错误');
    } , err => {
      console.log(err);
    })     // Uncaught (in promise) Error: 抛出错误！

Uncaught 表明异常错误未被捕获

而通过`catch`方法可以捕获异常错误，不会报错卡死 js 代码，而是进入到这个 catch 方法中

    p.then(res => {
      console.log(res);
      throw new Error("抛出错误！");
    }).catch(err => {
      console.log(err);
    })   // // Error: 抛出错误！

**Promise.all 的使用**

`all`方法，可以使异步操作并行执行，并且在所有异步任务执行结束并且执行结果都是成功后才执行回调。如使用`Promise.all`方法发送多个 Ajax 请求：

    function ajax(url) {
      return new Promise((resolve, reject) => {
        const xhr = new XMLHttpRequest();
        xhr.open("GET", url);
        (xhr.responseType = "json"),
        (xhr.onload = function () {
            if (this.status === 200) {
              resolve(this.response);
            } else {
              reject(new Error(this.statusText));
            }
          });
        xhr.send();
      });
    }
    Promise.all([
      ajax("http://localhost:3000/booklist"),
      ajax("http://localhost:3000/musiclist"),
    ]).then((res) => {
        console.log(res);
    }).catch((err) => {
        console.log(err);
    })

all 接收的是一个数组，数组里面的参数都是 Promise 对象，里面的所有异步操作并行执行，执行结束后将结果传递到 then 里面，通过 then 来指定成功的回调将结果接收。

**Promise.race 的使用**

`race`根据单词就知道是比赛，是竞速，race 与 all 不同，race 是谁先执行完成谁就回调，它不论成功还是失败，只要执行完成就进行回调，其余的无法再通过 race 来进行回调。

    const promise = ajax("http://localhost:3000/booklist");
    const timeout = new Promise((resolve , reject) => {
        setTimeout(() => {
            reject(new Error('出错了'))
        } , 100);
    });
    Promise.race([
        promise,
        timeout
    ]).then((res) => {
        console.log(res);
    }).catch((err) => {
        console.log(err);
    })

对网络进行节流处理，得到的结果为`出错了`，Ajax 的请求结果没有在控制台打印；不进行网络节流处理，得到的结果为`Ajax请求的结果`，这就说明了 race 是谁先执行完成谁就先回调。race 接收的也是一个数组，里面的参数也是 Promise 对象。

**Promise 链式调用**

由于 then 方法返回的是一个新的 Promise 实例，所以可以用链式调用，即在 then 方法后再回调 then 方法

    const promise = new Promise((resolve, reject) => {
      return setTimeout(() => {
        resolve("ok");
      }, 1000);
    });
    promise.then(value => {
        return value;   // 通过return将结果传递
    }).then(value => {
        return value;
    }).then(value => {
        console.log(value);
    }).catch(err => {
        console.log(err);
    })

每一个 then 回调中结果的状态会决定下一步的执行，如果中间发生错误，则将直接跳到 catch 方法中对错误进行捕获，否则将成功的结果继续传递到下一个回调中继续执行。

（Ps: Promise 中 then/catch 回调执行的任务为微任务，在同步任务执行完后，会立即执行微任务）
