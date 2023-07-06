---
title: 函数内this指向问题
date: 2022-12-16 23:59
tags: JavaScript
categories: JavaScript
---

在 js 中，this 的指向问题一直是一个需要特别注意的点，在有些情况下，this 的指向很容易弄错，并且可能需要手动修改 this 的指向。

<!-- more -->

**1.函数内部的 this 指向**

这些 this 指向，是当我们调用的时候确定的，调用方式不同 this 的指向也会不同，一般指向调用者。

（1）普通函数： this 指向的是 window

（2）构造函数： this 指向实例对象，原型对象里面的方法也指向实例对象

            function Star() {
                console.log(this);
            }
            Star.prototype.sing = function() {
                console.log(this);
            }
            var ldh = new Star();

（3）对象方法： this 指向方法的所属对象

            var o = {
                sayHi: function() {
                    console.log(this);   // this 指向 o
                }
            }
            o.sayHi();

（4）事件绑定函数： this 指向绑定事件对象

         var btn = document.querySelector("button");
            btn.onclick = function() {
                console.log(this);   // 点击按钮就可调用这个函数
            }   // this 指向这个绑定点击事件的按钮 button

(5)定时器函数：this 指向 window

            setInterval(function() {
                console.log(this);    // 每隔一秒自动调用一次
            } , 1000);

(6)立即执行函数：this 指向的是 window

           (function() {
                console.log("");    // 立即执行函数是自动调用的
            })();

**2.改变函数内部的 this 指向**

改变函数内部的 this 指向有三个方法可以实现：

（1）call()

call 第一个可以调用函数 第二个可以改变函数内的 this 指向，括号里面第一个值为要改变的对象，括号里面还可传递参数， call 的主要作用可以实现继承

            var o1 = {
              name: "maojiu"
          }
          function fn1(a , b) {
              console.log(this);
              console.log(a + b);
          }
          fn1.call(o1 , 1 ,2);

（2）apply()

apply 也是调用函数 第二个可以改变函数内部的 this 指向，apply 里面的参数必须是数组(伪数组)， apply 的主要作用，比如可以利用 apply 借助于数学内置对象求最大最小值

          var arr = [1 , 22 , 66 , 99];
          var max = Math.max.apply(Math , arr);
          var min = Math.min.apply(Math , arr);
          console.log(max , min);

（3）bind()

band 与 call、apply 不同的是不会调用原来的函数，可以改变原来函数内部的 this 指向，band 返回的是原函数改变 this 之后产生的新函数

            var o3 = {
              name: "pugec"
           }
          function fn3(a , b) {
                console.log(this);
                console.log(a + b);
           }
           var f = fn3.bind(o3 , 1 ,2);
           f();

**3.call apply bind 总结**

相同点：

都可以改变函数内部的 this 指向

不同点：

（1）call 和 apply 会调用函数，并且改变函数内部的 this 指向

（2）call 和 apply 传递的参数不一样，call 传递参数 aru1,aru2...的形式，apply 必须以数组的形式[arg]

（3）bind 不会调用函数，可以改变函数内部的 this 指向

主要应用场景：

（1）call 常用做继承

（2）apply 常跟数组有关，比如借助数学内置对象求相关数值

（3）bind 不调用函数，但是还想改变 this 指向，如改变定时器内部的 this 指向
