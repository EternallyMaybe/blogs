#### new主要进行了以下三个操作：
1. 创建一个空对象
2. 空对象的_proto_指向对象的原型对象
3. 将对象的的this指针替换成空对象

换成代码实现就是以下代码
```
var obj = {};
obj._proto_ = Fun.prototype;
Fun.call(obj);
```