## 全局作用域中的this
```
console.log(this); // Window全局对象
```
在浏览器中执行上面的语句后，我们将得到一个Window对象，这是一个全局对象。在全局作用域内，我们可以通过this访问到所有的全局属性。如下代码所示：
```
var a = 1;
console.log(this.a); // 1
```
## 函数作用域中的this
现在，我们将this关键字放到函数作用域中，测试代码如下：
```
var a = 1;
function test(){
    var a = 2;
    console.log(this.a); // 1
}
test();
```
我们可以看到此时打印出来的结果仍然是1，也就是说这时候this指向的还是全局对象。这里也可以澄清的是，this并没有指向函数作用域（或者说 是并没有指向函数作用域链中的活动对象，有关活动对象的概念可以参考JavaScript速记5 —— 执行环境、变量对象和作用域链），那么this是否会指向函数本身呢，我们接着来看下面一个例子：
```
var a = 1;
function test(){
    var a = 2;
    console.log(this.a); // 1
}
test.a = 3;
test();
```
通过上面的例子，我们知道this也并未指向函数本身。上面的例子中，this最终指向的都是全局对象，那么什么情况下this会指向其他对象呢，我们再来看下面的例子：
```
var a = 1;
function test(){
    var a = 2;
    console.log(this.a); // 3
}
var obj = {a: 3};
test.call(obj);
```
上面的例子中this指向了对象obj。既然只有当函数被调用时，才能确定this指向的对象，那么下一节我们就针对不同的函数调用方法下，逐一说明this的使用。

## 不同函数调用方法下的this
1. 直接调用
```
var a = 1;
function test(){
    console.log(this.a); //1
}
test();
```
很明显，函数被直接调用是this指向的就是全局对象。

2. 作为对象的方法调用
```
var a = 1;
function test(){
    console.log(this.a); // 2
}
var obj = {a: 2, fn: test};
obj.fn();
```
当函数作为对象的方法被调用时，this指向当前调用该方法的对象。

3. 作为构造函数调用
```
var a = 1;
function test(){
    this.a = 2;
}
var obj = new test();
console.log(a); // 1
console.log(obj.a); // 2
```
通过上面的代码结果可以看到，全局对象中的属性a并没有被改变，此时this指向该构造函数创建的对象。

4. 通过call或apply方法调用
call和apply都是Function对象的方法，都可以用来动态改变this的指向，达成函数复用的目的。这里笔者不在详细介绍这两个方法， 有兴趣的读者可以参考相关文章。需要特别说明的是，这两个方法的第一个参数就是this。由于这两个方法的用法类似，这里我们仅以call方法为例。上例 子：
```
var a = 1;
function test(){
    console.log(this.a); // 1
}
test.call();
```
call方法的第一个参数是this，在没有实参的情况下，上面例子中this默认指向的对象就是全局对象。我们再来看一个例子：
```
var a = 1;
function test(){
    console.log(this.a); // 1
}
var obj = {a: 2, fn: test};
obj.fn.call();
```
上面的例子进一步证明了，即便使用对象的方法调用call，this默认指向的依旧是全局对象。为了改变this的指向，我们需要显式的传递第一个参数过去，如下代码：
```
var a = 1;
function test(){
    console.log(this.a); // 2
}
var obj = {a: 2};
test.call(obj);
// 实现原理
Function.prototype.call2 = function(context) {
    context.fn = this;
    var args = [];
    for(var i = 1, len = arguments.length; i < len; i++) {
        args.push(arguments[' + i + ']);
    }
    eval('context.fn(' + args +')');
    delete context.fn;
}
```
与bind的区别，bind是在EcmaScript5中扩展的方法（IE6,7,8不支持），bind() 方法与 apply 和 call 很相似，也是可以改变函数体内 this 的指向，只不过bind是返回的一个函数
## 嵌套函数作用域中的this
文章的最后我们再来看一下嵌套函数中的this引用。示例代码如下：
```
var a = 1;
function test(){
    console.log(this.a); // 2
    function test2(){
        console.log(this.a); // 1
    }
    test2();
}
var obj =
 {a: 2, fn: test};
obj.fn();
```
上面的例子说明，嵌套函数被调用是并没有继承被嵌套函数的this引用，在嵌套函数被调用时，this指向全局对象。在有些应用中，我们需要在嵌套函数中读取调用被嵌套函数的对象的属性，此时可以声明一个局部变量保存this引用，代码如下所示：
```
var a = 1;
function test(){
    console.log(this.a); // 2
    var self = this;
    function test2(){
        console.log(self.a); // 2
    }
    test2();
}
var obj = {a: 2, fn: test};
obj.fn();
```
this指向：调用函数时，你可以把this想象为每个函数内的一个特殊（躲起来的）参数。无论什么时候，JavaScript都会把this放到function内部。它是基于一种非常简单的思想：如果函数直接是某个对象的成员，那么this的值就是这个对象。如果函数不是某个对象的成员那么this的值便设为某种全局对象（常见有，浏览器中的window对象）。下面的内部函数可以清晰的看出这种思想。
如果返回值是一个对象，那么this指向的就是那个返回的对象，如果返回值不是一个对象那么this还是指向函数的实例

```
function fn() {
    this.user = '追梦子';
    return {}; // function() {}一样的
}
var a = new fn();
console.log(a.user); //undefined

function fn() {
    this.user = '追梦子';
    return 1; //或undefined、null等ss
}
var a = new fn();
console.log(a.user); //追梦子
```