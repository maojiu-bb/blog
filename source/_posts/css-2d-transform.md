---
title: CSS中的2D转换
date: 2022-11-18 19:42
tags: CSS
categories: CSS
---

在一个页面中，一个图片的移动、缩放和旋转等往往能让用户有一个更好的体验。在 CSS 中，我们可以通过 2D 转换来实现这些效果。

<!-- more -->

**1.2D 转换-移动 translate**

2D 转换中的移动可改变元素在页面中的位置。2D 转换有以下三种语法格式：

![图片.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/17b70176e1bc4c59b854a5e9a858815f~tplv-k3u1fbpfcp-watermark.image?)

我们可以同时对 X、Y 进行移动的设置，也可以单独设置。

比如：一个宽和高都是 200 像素的 div 盒子，要向右移动 100 像素，只需要加一个 translateX（100px）或者 translate（100px,0）便可以实现。

![图片.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/46d51b9c090d405a8f75c8dfce59c96d~tplv-k3u1fbpfcp-watermark.image?)

值得**注意**的是：1.移动距离 X 和 Y 是以我们页面左上角为坐标原点的。 &nbsp;2.translate 的最大优点就是不会影响其他元素的位置。 &nbsp;3.当 translate 里面的单位用的是百分比时，移动的距离是以自身元素大小的百分比来移动。 &nbsp;4.translate 移动效果对行内元素使用无效。

**2.2D 转换-旋转 rotate**

2D 旋转是让元素在 2 维平面进行顺时针或逆时针旋转，语法格式如下：

![图片.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/478da5a8c4a744059d464948f37ce28d~tplv-k3u1fbpfcp-watermark.image?)

角度为正时，顺时针旋转；角度为负时，逆时针旋转。默认的旋转中心点为元素中心点。

**3.2D 转换-中心点 transform-origin**

我们可以设置元素转换的中心点来实现不同的效果。

语法格式为：
![图片.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/6a54cb44522448408145c455fd501c8b~tplv-k3u1fbpfcp-watermark.image?)

注意：1.里面参数 X 和 Y 之间要用空格隔开而不是用逗号 2.默认的中心点位元素的中心点 3.可对 X,Y 设置像素或者方位名词（top right bottom left center）。

**4.2D 转换-缩放 scale**

缩放，顾名思义，就是放大和缩小，只要给元素添加了 scale 缩放属性，就能控制扩大或者缩小了。

语法格式为：
![图片.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/5cb691498f3d4abc944069b5158123bd~tplv-k3u1fbpfcp-watermark.image?)

可对里面参数同时设置，也可以单独设置，只设置一个参数时，后一个参数值会与前一个一致：

![图片.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/23d511e6646949819b9f4e56c97a0578~tplv-k3u1fbpfcp-watermark.image?)

里面参数比 1 大时为扩大，比 1 小时为缩小。缩放的最大优势同样也是不影响其他的盒子。

**这么多的 2D 转换属性，当然也有像 background 一样的简写方法：**

![图片.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/8e8cb01025bd4706ab4fd30f49b069cf~tplv-k3u1fbpfcp-watermark.image?)

**重点**当然少不了：1.同时具有多个转换时，转换格式为 transform:translate() roate() scale() ...中间用空格隔开。 2.转换属性的顺序会影响转换效果和转换结果，因为代码的执行顺序是从左到右的。 3.当有多个属性时，将位移属性放在最前面。

好了，今天的 2D 转换就到这里了。
