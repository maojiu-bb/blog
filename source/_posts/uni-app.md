---
title: uni-app的使用
date: 2023-03-04 20:52
tags: uni-app
categories: uni-app
---

`uni-app`  是一个使用  [Vue.js](https://vuejs.org/)  开发所有前端应用的框架，能够实现一套代码多端发布，减少开发与学习的成本。

<!-- more -->

#### 开发工具

使用了[HbuilderX](https://dcloud.io/hbuilderx.html)，[微信开发者工具](https://developers.weixin.qq.com/miniprogram/dev/devtools/download.html)

#### 创建项目

新建项目选择 uni-app 并使用 Vue3 的默认模板
![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a910a6d6316d41fe80daa6f0900030ae~tplv-k3u1fbpfcp-watermark.image?)
得到如下目录结构：

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f945350bae3a4f03875b06e00d96ce66~tplv-k3u1fbpfcp-watermark.image?)

其中，`mainifest.json`,`pages.json`都是相关的配置文件，`uni.scss`为一个全局的样式文件；其余的文件基本与 vue 中的相似，`pages`页面组件，`static`静态资源，`App.vue`根组件，`main.js`入口文件。

#### 运行项目

点击运行，分别选择运行到浏览器和微信小程序

![image.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e7c384690cbf452689b4348757823671~tplv-k3u1fbpfcp-watermark.image?)

![image.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/990287ba1f3f48b2b06a5966a3ee7635~tplv-k3u1fbpfcp-watermark.image?)

#### 对 pages.json 进行配置

根据 uni-app 的官方文档，pages.json 中的配置项非常多，具体请看[uni-app 官网](https://uniapp.dcloud.net.cn/collocation/pages.html)，我主要说说 globalStyle,pages,tabBar 的相关配置。

##### globalStyle

globalStyle 是一个全局的配置，可以设置状态栏，导航栏，标题，背景颜色等。

- navigationBarTextStyle：导航栏标题的颜色，有 black,white 两种。
- navigationBarTitleText：导航栏标题的文字内容。
- navigationBarBackgroundColor：导航栏的背景颜色，为一个十六进制的数。
- backgroundColor：导航栏的背景颜色，为一个十六进制的数。
- backgroundTextStyle：下拉 loading 的样式，有 light，dark 两种。
- enablePullDownRefresh：是否允许下拉刷新，为一个布尔值。
- 在这只列举的部分的配置，更多的配置请看官方文档。

在 globalStyle 中，也能够针对不同的端而进行单独的配置，如下：

```json
    "globalStyle": {
		"navigationBarTextStyle": "black",
		"navigationBarTitleText": "uni-app",
		"navigationBarBackgroundColor": "#F8F8F8",
		"backgroundColor": "#F8F8F8",
		"h5": {
			"pullToRefresh": {
				"color": "#ccc"
			}
		}
	}
```

对 H5 页面进行了单独的配置。

##### pages

pages 为一个数组，里面的每一项为每一个页面的路由配置与页面样式的配置，有点类似于 vue 中路由的配置。
里面的 path 为每一个页面的路径，style 为每一个页面的样式。值得注意的是，在 pages 里面的 style 中配置的相关样式优先级高于 globalStyle 中配置的全局样式，会将 globalStyle 中配置的样式覆盖。这里的样式配置，也可以根据不同的端而进行不同的配置。

```json
    "pages": [ //pages数组中第一项表示应用启动页，参考：https://uniapp.dcloud.io/collocation/pages
		{
			"path": "pages/index/index",
			"style": {
				"navigationBarTitleText": "uni-app",
				"h5": {
					"titleNView": {
						"backgroundColor": "#ccc"
					}
				}
			}
		}
	]
```

pages 中的第一项为启动项，即在编译运行项目后默认打开的页面。

##### tabBar

通过配置 tabBar 来配置导航栏。

- 可通过 position 来指定导航栏的位置，有 top 和 bottom 两项可选，但存在平台差异，如 top 仅微信小程序支持。
- list 配置项为一个数组，里面最少要有两项，并且 list 配置项为必须要的，它用来指定导航的相关信息，如导航的路径 pagePath，导航栏的文字 text，导航栏的图标 iconPath 和选中时的图标 selectedIconPath 等。
- 通过 backgroundColor 来设置导航栏的背景颜色。
- 通过 color 和 selectedColor 来设置文字的默认颜色与选中后的颜色
- ......
  具体的示例：

```json
      "tabBar": {
		"backgroundColor": "#ccc",
		"list": [{
			"iconPath": "/static/logo.png",
			"pagePath": "pages/index/index",
			"selectedIconPath": "static/logo.png",
			"text": "首页"
		}]
      }
```

这里的 list 我只配置了一项，在实际开发中至少要有两项。

#### 组件的学习与使用

uni-app 提供了非常多的内置组件，如视图容器，表单组件，媒体组件，地图，画布和广告等。在使用这些内置组件时，只需要将这些组件以标签的形式引入即可，相应的配置项可根据文档择需配置。如下：

```html
<swiper
  :indicator-dots="true"
  :autoplay="true"
  :interval="3000"
  :duration="1000"
>
  <swiper-item>
    <view class="swiper-item"></view>
  </swiper-item>
  <swiper-item>
    <view class="swiper-item"></view>
  </swiper-item>
</swiper>
```

这是一个轮播图的组件，这些组件，在开发中使用起来相当方便。但是，相关的一些配置项还是要多参考官方文档进行配置，避免平台差异。

除了 uni-app 内置的组件外，uni-app 还提供了扩展组件库 uni-ui，里面的组件也是相当丰富。可选择需要的组件单独安装组件，在文件中导入模块注册并使用。

#### 条件注释

条件注释是新接触到的一个概念，可以说它是注释，也可以说它不是注释。条件注释，能够根据不同的平台执行条件注释内的不同代码。条件注释，它的形如注释，而执行机制又如 if 语句。具体实例如下：

```css
.title {
  /* #ifdef H5 */
  font-size: 36rpx;
  /* #endif */
  /* #ifdef MP-WEIXIN */
  font-size: 30rpx;
  /* #endif */
  color: #8f8f94;
}
```

```html
<!-- #ifdef H5 -->
<view class="">H5</view>
<!-- #endif -->
<!-- #ifdef MP-WEIXIN -->
<view class="">WX</view>
<!-- #endif -->
```

```js
    onLoad() {
			// #ifdef H5
			console.log('H5')
			// #endif
			// #ifdef MP-WEIXIN
			console.log('WX')
			// #endif
		}
```

分别在样式，html 结构，js 中书写条件注释。它会根据条件注释，在不同的平台执行不同的代码从而实现不同的效果。

#### 更多

uni-app 很好的支持了 vue 的语法及其周边生态，在学习完 vue 后学习 uni-app 相对轻松，大部分都是与 vue 相同，不同的地方在于 uni-app 内置的组件与自身的生命周期钩子等。

这里只列举了 uni-app 的部分内容，更多的内容学习还得参考[uni-app 官网](https://uniapp.dcloud.net.cn/)
