---
title: jQuery的使用
date: 2022-12-10 22:31
tags: jQuery
categories: jQuery
---

jQuery 是一个快速、简洁且功能丰富的 JavaScript 库，里面封装了 JavaScript 常用的功能代码，优化了文档操作、事件处理和动画设计等。

<!-- more -->

**1.jQuery 的入口函数**

使用 jQuery 语句书写 js 时，要先引入 jQuery 的 js 代码，然后在自己书写的 js 代码中，要先写一个入口函数，等页面 DOM 加载完毕后再去执行 js 代码，有以下两种方式：

            $(function() {  })
            $(document).ready(function() {  })

用 jQuery 书写 js 时要用 $ 其代表了 jQuery

**2.jQuery 的筛选选择器**

jQuery 的筛选选择器有以下几种： (1) :first 选择第一个 (2) :last 选择最后一个 (3) :odd 选择及数个 (4) :even 选择偶数个 (5) eq(index) 选择对应索引号的,索引号一样也是从 0 开始

            // :first  第一个
            // :last  最后一个
            // :odd  奇数个
            // :even 偶数个
            // :eq(index) 里面索引从 0 开始

            $(function() {
                $('ul li:first').css('backgroundColor' , 'pink');
                $('ul li:last').css('backgroundColor' , 'pink');
                $('ul li:eq(2)').css('backgroundColor' , 'green');
                $('ol li:odd').css('color' , 'pink');
                $('ol li:even').css('color' , 'skyblue');
            });

**3.jQuery 的筛选方法**

主要是对当前元素的父、子、兄或者第 n 个进行筛选。有（1）.parent() 得到最近一级的父元素；（2）.children() 得到最近一级的子元素，相当于子选择器；.find() 选择匹配的子元素，相当于后代选择器；（3）sibings() 得到当前元素的兄弟系节点，不包括自己；（4）.eq(index) 选择第 n 个

            $(function() {
                // 父
                console.log($(".son").parent());  // father 得到的为最近一级的父元素
                // 子
                console.log($(".son").children("p"));  // 相当于$("ul>li")  最近一级
                console.log($(".son").find("p"));   // 相当于$("ul li") 后代选择器
                // 兄
                console.log($(".son p").siblings("div"));  // 查找兄弟节点 不包括自己
            });

还可通过方法筛选判断是否有某个类名，如果有则返回 true ，如果没有则返回 false

            $("ul li:first").hasClass("bor");
            console.log($("ul li:eq(1)").hasClass("bor"));

**4.jQuery 的位置和尺寸方法**

jQuery 的位置方法有（1）offset 获取距离文档的位置或偏移量 （2）position 获取距离带有定位父元素的位置或偏移量。二者的区别在于：offset 能够获取并设置位置或偏移量 ，而 position 只能获取元素的位置或偏移量

            $(function() {
                // 1.offset 获取距离文档的位置（偏移）
                console.log($(".son").offset());   // Object { top: 100, left: 668 }
                console.log($(".son").offset().top);  // 100
                $(".son").offset({
                    left: 200,
                    top: 150
                });
                // 2.position 获取距离带有定位的父元素的位置（偏移） 如果父级没有定位 则以文档为准
                // 这个方法只能获取不能设置偏移
                console.log($(".son").position());
            });

jQuery 的尺寸方法有：(1) width() / height(), (2) innerWidth() / innerHeight(), (3) outerWidth() / outerHeight(), (4) outerWidth(true) / outerHeight(true) 具体用法如下：

            $(function() {
                // 1.width() / height() 获取设置元素的 width 和 height 大小
                console.log($("div").width());
                $("div").width(300);  // 里面的值不用跟单位
                // 2.innerWidth() / innerHeight() 获取设置元素 width / height + padding  大小
                console.log($("div").innerWidth());
                $("div").innerWidth(350);
                // 3.outerWidth() / outerHeight() 获取设置元素 width / height + padding + border 大小
                console.log($("div").outerWidth());
                $("div").outerHeight(300);
                // 4.outerWidth(true) / outerHeight(true) 获取设置元素 width / height + padding + border + margin 大小
                console.log($("div").outerWidth(true));
                $("div").outerHeight(500);
             });

**5.jQuery 的样式和属性操作**

jQuery 修改样式：

（1）修改样式 css 方法

修改样式用 css("属性" ， "属性值") , 若直接打印某个属性，得到的将会是属性值；如果要修改多个样式，则采用大括号{}括在一起，里面的属性名可以不用加引号，属性值是数字时可以不用引号不用单位

            $(function() {
                console.log($("div").css("color"));  // 得到的为属性值
                $("div").css("color" , "skyblue");
                // $("div").css("height" , 600);   // 这里的数字可以不用引号 不用单位
                // 修改多个属性值时
                $("div").css({
                    width: 400,   // 这里的属性名可以不用引号
                    height: 300,  // 数字可以不接单位
                    backgroundColor: "purple"     // 不是数字 必须加引号
                });
            });

(2) 修改样式操作类

修改样式的操作类有（1）添加类 addClass() ；（2）移除类 removeClass() ; (3) 切换类 toggleClass()

            $(function() {
                // 1.添加类  addClass()
                // $("div").addClass("current");
                // 2.移除类  removeClass()
                // $("div").removeClass("current");
                // 3.切换类  toggleClass()
                $("div").click(function() {
                    $(this).toggleClass("current");
                });
            });

jQuery 属性操作：

jQuery 属性操作有：（1）element.prop("属性名")   获取元素固有的属性值 ； （2）attr() 获取元素自定义属性值 ； （3）data() 数据缓存 这里面的数据是存放在元素的内存里面，这个方法获取 data-index h5 自定义属性 不用写 data- 返回的是数字型

            $(function() {
                // 1.element.prop("属性名")  获取元素固有的属性值
                console.log($("a").prop("href"));
                // 对立面的值进行修改  prop("属性名" ， "属性值")
                $("a").prop("title" , "猫九的掘金博客");
                $("input").change(function() {
                    console.log($(this).prop("checked"));
                });
                // 2.attr() 获取元素自定义属性值
                console.log($("div").attr("index"));
                // 对立面的值进行修改  attr("属性名" , "属性值")
                $("div").attr("index" , 4);
                console.log($("div").attr("data-index"));
                // 3.data() 数据缓存 这里面的数据是存放在元素的内存里面
                $("span").data("uname" , "andy");
                console.log($("span").data("uname"));
                // 这个方法获取data-index h5自定义属性 不用写data- 返回的是数字型
                console.log($("span").data("index"));  // 数字型 6
            });

**6.jQuery 创建、添加、删除元素**

(1) 创建元素：$("要添加的元素")

(2) 添加元素：append() 添加内部元素，类似于 appendChild()在元素的内部后面添加 ; before() 在外部元素的前面添加 ， after() 在外部元素的后面添加

(3) 删除元素：remove() 删除匹配元素 ； empty() 删除匹配元素的子节点 ； $(" ").html("") 删除匹配元素的子节点

            $(function() {
                // 1.创建元素
                var li = $("<li>后生li</li>");
                // 2.添加元素
                    // (1)添加内部元素
                $("ul").append(li);   // 类似于appendChild 在元素内部后面添加
                    // (2)添加外部元素
                var div = $("<div>后生div</div>");
                // $("div").after(div);  // 在后面添加
                $("div").before(div);  // 在前面添加
                // 3.删除元素
                // $("ul").remove();   // 可以删除匹配的元素 自杀
                // $("ul").empty();    // 可以删除匹配的元素的子节点 孩子
                $("ul").html("");    // 可以删除匹配的元素的子节点 孩子  ("")括号里面要加引号
            });

**7.jQuery 的显示与隐藏、淡入与淡出**

显示与隐藏：

显示用 show() , 隐藏用 hide()

            $(function() {
                $("button").eq(1).click(function() {
                    $("div").hide(1000 , function() {
                        alert("隐藏");
                    });
                });
                $("button").eq(0).click(function() {
                    $("div").show(1000 , function() {
                        alert("显示");
                    });
                });
                $("button").eq(2).click(function() {
                    $("div").toggle(1000 , function() {
                    });
                });
            });

淡入与淡出：

fadeIn() 淡出 ； fadeOut() 淡入 ; fadeToggle() 切换淡入淡出效果 ； fadeTo() 透明度，括号里面必须写上透明度的值

            $(function() {
                // 淡出  fadeIn()
                $("button").eq(0).click(function() {
                    $("div").fadeIn(1000);
                });
                // 淡入  fadeOut()
                $("button").eq(1).click(function() {
                    $("div").fadeOut(1000);
                });
                // 切换  fadeToggle
                $("button").eq(2).click(function() {
                    $("div").fadeToggle(1000);
                });
                // 透明度  fadeTo()  里面必须写透明度
                $("button").eq(3).click(function() {
                    $("div").fadeTo(1000 , 0.5);
                });
            });

**8.jQuery 滑动效果、事件切换及动画方法**

滑动效果有：slidedup() 上滑 ； slidedown() 下滑 ； slideToggle() 切换上下滑动效果

事件切换：语法格式为：$(" ").hover(function() {} , function() {}) ，当鼠标经过时，自动切换事件

动画方法：因为 jQuery 已经包含了 animation 自定义动画的方法，所以直接调用即可

**9.jQuery 遍历对象方法**

遍历对象有两种方法： (1) each() ; (2) $.each() 主要用于遍历数据，进行数据处理

            $(function() {
                // 1. each() 方法遍历元素
                var arr = ["skyblue" , "yellowgreen" , "pink"];
                var sum = 0;
                $("div").each(function(index , domEle) {
                    // 回调函数第一个参数一定是索引号 可以自定义索引号名称
                    console.log(index);
                    // 回调函数第二个参数一定是dom元素对象
                    console.log(domEle);
                    $(domEle).css("backgroundColor" , arr[index]);
                    sum += parseInt($(domEle).text());   // 要进行类型转换
                });
                console.log(sum);   // 6
                // 2. $.each() 方法遍历元素 主要用于遍历数据 数据处理
                $.each($("div") , function(index , domEle) {
                    console.log(index);
                    console.log(domEle);
                });
                $.each(arr , function(index , domEle) {
                    console.log(index);
                    console.log(domEle);
                });
                $.each({
                    name: "andy",
                    age: 19
                } , function(i , ele) {
                    console.log(i);
                    console.log(ele);
                })
            });

注意：回调函数第一个参数一定是索引号 可以自定义索引号名称，回调函数第二个参数一定是 dom 元素对象

**10.jQuery 的隐式迭代和链式编程**

隐式迭代：当我们调用 jQuery 时，jQuery 方法会遍历内部的 DOM 数组，这个过程称为隐式迭代

        <div>惊喜</div>
        <div>惊喜</div>
        <div>惊喜</div>
        <div>惊喜</div>
            $(function() {
                $('div').css('backgroundColor' , 'pink');
            });

这里的所有 div 的背景颜色都将变成粉红色，这就是隐式迭代的作用

链式编程：链式编程即将多个方法写在一行显示，从而减少代码量，但要注意先后顺序的问题

                // 链式编程  

                    $(this).css("backgroundColor" , "pink").siblings().css("backgroundColor" , "");

                    $(this).siblings().parent().css("color" , "blue");

**11.jQuery 的对象拷贝**

对象拷贝分深拷贝和浅拷贝两种

（1）深拷贝：把原来对象里面的数据完全复制一份给目标对象 $.extend(true , targetObj , obj)

（2）浅拷贝：把原来对象里面的复杂数据类型的地址拷贝给目标对象 $.extend(targetObj , obj)

            $(function() {
                var targetObj = {
                    age: 16,
                    sex: "男"
                };
                var obj = {
                    name: "andy",
                    age: 18,
                    msg:{
                        tel: 666
                    }
                }
                // 语法格式 $.extend(target , obj);
                $.extend(targetObj , obj);
                // 1.浅拷贝把原来对象里面的复杂数据类型地址拷贝给目标对象
                    console.log(targetObj);  // age: 18 后面的值将前面的覆盖掉了
                    console.log(obj);
                // 2.深拷贝把原来对象里面的数据完全复制一份给目标对象
                $.extend(true , targetObj , obj);  // 里面第一个属性值改为 true 为深拷贝
                targetObj.age = 20;
                    console.log(targetObj);
                    console.log(obj);
            });

如果里面有不冲突的属性 会合并在一起;如果里面有冲突的属性   后面的值会将前面的值覆盖

**12.jQuery 自动触发事件**

自动触发事件，不需要点击等任何操作便可执行. 有 trigger("事件") 和 triggerHandler("事件")，后者不会触发元素的默认行为

                // 2.元素.trigger("事件")
                $("div").trigger("click");
                // 3.元素.triggerHandler("事件")  不会触发元素的默认行为
                $("input").on("focus" , function() {
                    $(this).val("你好吗");
                })
                $("input").triggerHandler("focus");

jQuery 的一些基本内容就到这里了
