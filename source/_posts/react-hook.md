---
title: React Hook的使用
date: 2023-04-16 16:00
tags: React
categories: React
---

### 什么是 Hooks

我们知道，React 的组件创建方式有两种：（1）类式组件（2）函数式组件。

- 类式组件能够对状态的管理与切换进行操控，但是在简单的页面中使用类式组件会使代码显得很重，并且状态逻辑难以复用。即便是使用 render props (渲染属性)和高阶组件可以优化，但是这两种方式都会将原来的组件用一个容器包裹起来，形成层级嵌套，代码冗余。此外，在类式组件中，this 的指向问题也值得思考。
- 函数式组件没有了类式组件中的状态，没有生命周期，更不存在 this。但是为了对状态进行管理等，就有了 hooks。

<!-- more -->

**React Hook**就是将组件写成纯函数的形式，在需要一些特定的功能时，就将特定的 hook 钩子引进来，并且可以在此基础上封装我们自定义的 hook。

### 常用的 Hooks

#### useState()

我们知道，纯函数组件是没有 state 的，但是为了能够操控数据，useState()为函数式组件注入了状态。
示例：

```js
import React, { useState } from 'react'

function App() {
  const [count, setCount] = useState(0)
  const add = () => {
    setCount(count + 1)
  }
  return (
    <div className="App">
      <div>Count: {count}</div>
      <button onClick={add}>点击+1</button>
    </div>
  )
}

export default App
```

useState()创建一个状态，可以赋一个初始值，用一个数组来接收，数组的第一项即为创建的状态变量，数组的第二项是一个函数，用于修改状态变量的值。其中，这个 setCount 函数可以有多种写法，上面的写法是其中一种，还可以在里面写一个函数，函数的返回值就是要进行状态修改的操作。

```js
setCount((count) => {
  return count + 1
})
// 简写
setCount((count) => count + 1)
```

值得注意的是，当 useState 里面的状态为一个对象时，useState 是不会进行局部更新的，而是将修改后的内容将之前的内容进行覆盖。
示例：

```js
import React, { useState } from 'react'

function App() {
  const [user, setUser] = useState({ name: 'tom', age: 18 })
  const changeName = () => {
    setUser({
      ...user,
      name: 'jack'
    })
  }
  return (
    <div className="App">
      <h1>{user.name}</h1>
      <h1>{user.age}</h1>
      <button onClick={changeName}>Click</button>
    </div>
  )
}

export default App
```

从 setUser 的写法我们也不难看出，这里是用修改后的 name 将原来的 name 进行一个覆盖，然后再生成了一个新的 user 对象。

#### useRef()

useRef 用于获取真的的 DOM 节点，返回一个对象，里面有 current 属性存放着获取到的 DOM 对象。
示例：

```js
import React, { useRef } from 'react'

function App() {
  const myRef = useRef()
  const handleClick = () => {
    console.log(myRef.current)
  }
  return (
    <div className="App">
      <input ref={myRef} type="text" />
      <button onClick={handleClick}>点击打印</button>
    </div>
  )
}

export default App
```

#### useEffect()

useEffect 可以检测数据的更新，更好的处理异步请求等副作用。useEffect 接收两个参数，第一个参数为要进行的异步操作，第二个参数为一个数组，里面为要检测的依赖项，只要数组里面的依赖项发生了变化，useEffect 就会执行。当第二个参数不传时，在每次组件渲染时 useEffect 都会执行，类似于 componentDidUpdate 生命周期钩子。第一个参数返回的函数就相当于 componentWillUnmont.

```js
// useEffect 可以模拟三个生命周期钩子
useEffect(() => {
  let timer = setInterval(() => {
    setCount((count) => count + 1)
  }, 1000)
  return () => {
    clearInterval(timer)
  }
}, [count])
// 第一个参数返回的函数就相当于 componentWillUnmont
// 第二个参数为要检测的数组，谁要检测就传谁
// 若不传第二个参数，则相当于 componentDidUpdate，传了相当于 componentDidMount
```

#### useContext()

context 有上下文的意思，所以 useContext() 常用于组件之间的数据状态共享，避免了逐级传递 props 的缺陷。通过 createContext 来创建 context 对象，然后使用 context 对象上的 Procider 来提供数据，在后代组件中通过 useContext 来接收数据。
示例：

```js
import { createContext, useContext } from 'react'

const ThemeContext = createContext(null)

export default function MyApp() {
  return (
    <ThemeContext.Provider value="dark">
      <Form />
    </ThemeContext.Provider>
  )
}

function Form() {
  return (
    <Panel title="Welcome">
      <Button>Sign up</Button>
      <Button>Log in</Button>
    </Panel>
  )
}

function Panel({ title, children }) {
  const theme = useContext(ThemeContext)
  const className = 'panel-' + theme
  return (
    <section className={className}>
      <h1>{title}</h1>
      {children}
    </section>
  )
}

function Button({ children }) {
  const theme = useContext(ThemeContext)
  const className = 'button-' + theme
  return <button className={className}>{children}</button>
}
```

### 总结

React Hooks 能够让我们在函数式组件中灵活的编写状态和功能等，避免了类式组件中存在的一些问题。这里只列举了部分的 hook，还有一些重要的 hooks 在 React 官方文档都有详细的说明。
