---
title: Vite打包时的一些优化配置
date: 2023-04-08 19:59
tags: Vite
categories: Vite
---

在我们使用 vite 创建项目时, 可以进行一些配置来优化打包

<!-- more -->

### 1.分包策略

在说分包策略前，我们要明白浏览器的缓存策略：

- 当访问一个网站时向服务器请求获取静态资源并将静态资源进行缓存，如 css、js 等。
- 当下次再访问时，如果之前缓存的 “静态资源”的名字没有发生改变，则不会重新请求，直接从缓存中获取。

Vite 在打包时，只要代码内容变了，所生成的新文件的 hash 字符串完全不同。但是，我们改的一般都是源代码里面的内容，而依赖中的内容是不会变的，但是在每次打包时都会重新将这些依赖打包，所以可以将这些依赖分开打包，从而避免多次重新请求。

在 vite.config.js 中对 Rollup 进行如下配置：

```js
import { defineConfig } from 'vite'

export default defineConfig({
  build: {
    rollupOptions: {
      output: {
        // 对静态资源进行单独打包
        assetFileNames: 'static/[ext]/[name].[hash].[ext]',
        // 对项目依赖进行单独打包
        manualChunks: (id) => {
          if (id.includes('node_modules')) {
            return 'vandor'
          }
        }
      }
    }
  }
})
```

这里对静态资源根据文件的扩展名而分开打包，对项目的所有依赖又进行了单独打包。

### 2.gzip 压缩

gzip 压缩指的是：将打包后的静态资源压缩成 gzip 格式，服务器响应资源文件时发送 gzip 格式文件，然后浏览器拿到 gzip 文件之后再解压使用。但是文件比较小不建议用 gzip 压缩，因为浏览器在解压的时间可能大于请求原来资源的时间。

配置 gzip 压缩：

- 安装 gzip 压缩插件：

```js
npm i vite-plugin-compression -D
// or
yarn add vite-plugin-compression -D
```

- 在 vite.config.js 文件中引入插件并进行配置：

```js
import { defineConfig } from 'vite'
import viteCompression from 'vite-plugin-compression'

export default defineConfig({
  plugins: [
    // 配置 gzip 压缩插件
    viteCompression({
      // options
      verbose: true, // 是否在控制台输出压缩结果
      disable: false, // 是否禁用
      threshold: 1024 * 10, // 压缩的门槛大小
      algorithm: 'gzip', // 压缩的算法
      ext: '.gz' // 压缩后的文件扩展名
    })
  ]
})
```

### 3.cdn 加速

cdn: content delivery network， 即内容分发网络，在我们将项目的所有依赖以及文件在我们进行打包以后放到我们的服务器上面去前，把第三方依赖模块写成 cdn 的形式，从而保证我们自己代码的一个小体积，降低我们自己服务器的传输压力，第三方依赖代码通过 cdn 向最近最优的服务器请求过来。

配置 cdn ：

- 安装 cdn 插件：

```js
npm install vite-plugin-cdn-import -D
// or
yarn add vite-plugin-cdn-import -D
```

- 在 vite.config.js 文件中引入插件并进行配置：

```js
import { defineConfig } from 'vite'
import viteCDNPlugin from 'vite-plugin-cdn-import'

export default defineConfig({
  plugins: [
    // cdn加速插件
    viteCDNPlugin({
      modules: [
        {
          // 需要 cdn 加速的依赖名称
          name: 'lodash',
          // 全局分配给模块的变量，Rollup 需要这个变量名称
          var: '_',
          // 指定 CDN 上的加载路径
          path: 'https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js'
        }
      ]
    })
  ]
})
```

### 4.清除 console 与 debug

这一步相对简单，在 vite.config.js 进行如下配置：

```js
import { defineConfig } from 'vite'

export default defineConfig({
  build: {
    terserOptions: {
      compress: {
        drop_console: true,
        drop_debugger: true
      }
    }
  }
})
```

这里就是一些比较基本的优化配置，并没有很全面。
