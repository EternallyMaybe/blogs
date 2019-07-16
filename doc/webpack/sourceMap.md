## 为什么引入source map
JavaScript脚本正变得越来越复杂。大部分源码（尤其是各种函数库和框架）都要经过转换，才能投入生产环境。
常见的源码转换，主要是以下三种情况
1. 压缩，减小体积。比如jQuery 1.9的源码，压缩前是252KB，压缩后是32KB。
2. 多个文件合并，减少HTTP请求数。
3. 其他语言编译成JavaScript。最常见的例子就是CoffeeScript。

这三种情况，都使得实际运行的代码不同于开发代码，除错（debug）变得困难重重。
通常，JavaScript的解释器会告诉你，第几行第几列代码出错。但是，这对于转换后的代码毫无用处。举例来说，jQuery 1.9压缩后只有3行，每行3万个字符，所有内部变量都改了名字。你看着报错信息，感到毫无头绪，根本不知道它所对应的原始位置。
这就是Source map想要解决的问题。

## 什么是source map
简单说，Source map就是一个信息文件，里面储存着位置信息。也就是说，转换后的代码的每一个位置，所对应的转换前的位置。有了它，出错的时候，除错工具将直接显示原始代码，而不是转换后的代码。这无疑给开发者带来了很大方便。
+ version：Source Map的版本号。
+ sources：转换前的文件列表。
+ names：转换前的所有变量名和属性名。
+ mappings：记录位置信息的字符串，经过编码。
+ file：(可选)转换后的文件名。
+ sourceRoot：(可选)转换前的文件所在的目录。如果与转换前的文件在同一目录，该项为空。
+ sourcesContent:(可选)转换前的文件内容列表，与sources列表依次对应。

## 怎样使用Source Map
主流浏览器均支持Source Map功能，不过Chrome与Firefox需要一些简单的配置
1. 开启开发者工具
2. 打开设置
3. 开启Source Map

## 如何生成Source Map
https://docs.fundebug.com/notifier/javascript/sourcemap/generate/