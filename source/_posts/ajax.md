---
title: Ajax的使用
date: 2022-12-24 21:57
tags: Ajax
categories: Ajax
---

**什么是 AJAX？**

AJAX 是一种创建交互式网页应用的开发技术，通过客户端与服务器之进行数据交换，使网页内容实现异步更新

<!-- more -->

**AJAX 的原理**：通过 XMLHttpRequest 对象来向服务器发出异步请求，从服务器中获得数据，然后用 Javascript 来操作 DOM 从而更新局部页面。

**AJAX 的请求有以下几个步骤：**

1.创建 XMLHttpRequest 对象

        var xhr = new XMLHttpRequest();

2.使用 open 方法设置请求的方式和 URL 地址从而与服务器连接

        xhr.open('method' , 'url');

其中，method 为请求的方式，可以是 GET、POST 等，url 为请求的 url 地址

3.使用 send 方法发送请求

        xhr.send();

如果发送的为 GET 请求，()括号里面不需要传递参数；如果发送的为 POST 请求，()括号里面要传递参数,传递的参数采用键值对的形式，中间用等号=隔开，当传递多个参数时，参数之间用&符号分开。如下：

        // get 请求
        xhr.send();
        // post 请求
        xhr.send('uname=zs&age=18')

4.设置回调函数来接受返回结果,要使用 onreadystatechange 监听事件

       xhr.onreadystatechange = function() {}

5.在回调函数中对响应状态进行判断并进行后续操作

(1)对 Ajax 请求所处的状态（readyState）进行判断，当状态值为 4 时，表示请求完成，意味着数据已经彻底完成或者失败

(2)对响应状态码（status）进行判断，当状态码为 200 时，表示请求完成，一般用于 GET 和 POST 请求；类似的还有 201，表示已创建，用于 PUT 请求；404 Not Found ，表示服务器无法根据客户端请求找到资源...

       xhr.onreadystatechange = function() {
           if (xhr.readyState === 4 && xhr.status === 200) {
           console.log(xhr.resopnseText);
       }

**完整的 AJAx 实例**

            // 1. 创建 xhr 对象
          var xhr = new XMLHttpRequest();
            // 2. 调用 open()   第一个参数为请求方式,第二个参数为url地址
            xhr.open('GET' , 'http://www.liulongbin.top:3006/api/getbooks');
            // 3. 调用 send()
            xhr.send();
            // 4. 监听 onreadystatechange 事件
            xhr.onreadystatechange = function() {
                // 判断是否响应 xhr.readyState === 4 && xhr.status === 200 固定写法
                    if (xhr.readyState === 4 && xhr.status === 200) {  
                     // 注意这里的status与响应数据里面的status是不一样的含义
                    // 获取服务器响应数据
                    console.log(xhr.responseText);
                }
            }

**jQuery 中的 Ajax**

由于 XMLHttpRequest 用法比较复杂，所以 jQuery 对 XMLHttpRequest 进行了封装，提供了一些列 Ajax 相关的函数，极大降低了 Ajax 的使用难度

jQuery 中发起 Ajax 请求通常有以下三种方法：

1.$.get()发起 GET 请求，语法如下：

      $.get(url , [data] , [callbak]);

data 为请求时携带的参数，callback 为请求成功时的回调函数，中括号表示为可选参数，可以没有

2.$.post()发起 POST 请求

    $.post()的用法与$.get()类似，只是data传递的数据为需要提交的信息，是一个对象，数据采用键值对来表示

3.$.ajax()既可以发起 GET 请求，又可以发起 POST 请求

相比于前面两个，$.ajax()是一个功能比较综合的函数允许我们对 Ajax 请求进行更详细的配置,基本语法如下：

    $.ajax({
        type: '',  // 请求的方式 如 GET 或 POST
        url: '',  // 请求的地址
        data: {},  // 请求携带的数据，可以为空
        success: function() {}  // 请求成功之后的回调函数
    })

AJAX 的基本使用就是这些了
