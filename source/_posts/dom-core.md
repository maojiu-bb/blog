---
title: DOM核心重点
date: 2022-12-03 00:26
tags: JavaScript
categories: JavaScript
---

关于 DOM 操作，我们主要针对于元素的操作，主要有创建、增加、删除、修改、查询、属性操作、事件操作

<!-- more -->

1.创建

- document.write();

- innerHTML

- createElement

如：

```html
<button>点击</button>
<p>abc</p>
<script>
  // 1. document.write()

  var btn = document.querySelector('button')

  btn.onclick = function () {
    document.write('<div>123</div>') // 文档执行完毕后 会导致页面重绘现象
  }

  // 2.element.innerHTML

  // innerHTML  采用数组拼接  而 不用字符串拼接  时 效率高  但结构复杂

  // 3.document.creatElement()

  // craetElement() 创建多个元素的话效率低一些  但是结构清晰
</script>
```

2.增加

- appendChild

- inserBefore

如：

```html
<ul>
  <li>123</li>
</ul>

<script>
  // 1.创建元素节点

  var li = document.createElement('li')

  // 2.添加元素节点 node.appendChild(child)  node 父级   child 子级  在后面追加元素

  var ul = document.querySelector('ul')

  ul.appendChild(li)

  // 3.添加节点 node.insertBefore(child,指定元素);

  var lili = document.createElement('li')

  ul.insertBefore(lili, ul.children[0])

  // 4.想要添加一个新的元素 : 1.创建元素  2. 添加元素
</script>
```

3.删除

- removeChild

如：

```html
<button>删除</button>

<ul>
  <li>第1个li</li>

  <li>第2个li</li>

  <li>第3个li</li>
</ul>

<script>
  // 删除节点 node.removeChild(child)

  // 获取元素

  var btn = document.querySelector('button')

  var ul = document.querySelector('ul')

  // 注册事件

  btn.onclick = function () {
    if (ul.children.length == 0) {
      this.disabled = true
    } else {
      ul.removeChild(ul.children[0])
    }
  }
</script>
```

4.修改

主要修改 dom 的元素，dom 元素内容，表单属性值等

(1) 修改元素属性：src href title 等

(2) 修改元素内容：innerHTML innerText

(3) 修改表单元素：value type disabled 等

(4) 修改样式：style className

5.查询

主要获取查询 dom 元素

（1）DOM 提供的 API 方法: getElementByIb()通过 id 获取、 getElementByTagName()通过标签名获取，方法古老，不推荐使用

（2）H5 提供的方法：querySelector()、querySelectorAll() 推荐使用

（3）利用节点获取元素：获取父节点 parentNode() 、 获取子节点 children() / childNodes() 、 获取兄弟节点 perviousElementSibling() / nextElementSibling()

6.属性操作

主要针对自定义属性进行操作

(1)setAttribute:设置 dom 的属性值

(2)getAttribute:得到 dom 的属性值

(3)removeAttribute:移除 dom 的属性

如：

```html
<div id="demo" index="1"></div>

<script>
  // 获取属性值

  var div = document.getElementById('demo')

  // 1.element.属性

  console.log(div.id)

  // 2.element.getAttribute('属性')

  console.log(div.getAttribute('id'))

  console.log(div.getAttribute('index'))

  // 设置属性值

  // (1) element.属性 = '值';

  div.id = 'text'

  div.className = 'navs'

  // (2) element.setAttribute('属性','值');    主要针对自定义属性

  div.setAttribute('index', 2)

  // 移除属性  removeAttribute(属性)\

  div.removeAttribute('index')
</script>
```

7.事件操作

事件操作的基本格式为：事件源.事件类型 = 事件处理程序

事件操作有鼠标事件和键盘事件

(1)鼠标事件

```
             onclick        // 鼠标点击触发
             onmouseover    //鼠标经过触发
             onmouseout     //鼠标离开触发
             onmousemove    //鼠标移动触发
             onmouseup      //鼠标弹起触发
             onmousedown    //鼠标按下触发
             onfocus        //获得鼠标焦点触发
             onblur         //失去鼠标焦点触发
```

（2）键盘事件

```html
<script>
  // 常用键盘事件

  // 1. keyup 按键弹起时触发

  document.addEventListener('keyup', function () {
    console.log('我弹起了')
  })

  // 2. keydown 按键按下时触发   能识别功能键 ctrl shift 箭头键等

  document.addEventListener('keydown', function () {
    console.log('我按下了down')
  }) // 先输出的为 keydown
  // 3. keypress 按键按下时触发    不能识别功能键 ctrl shift 箭头键等

  document.addEventListener('keypress', function () {
    console.log('我按下了press')
  })

  // 4.三个事件的执行顺序  keydown -> keypress -> keyup
</script>
```
