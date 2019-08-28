## 什么是JSON
JSON 指的是 JavaScript 对象表示法（JavaScript Object Notation）
JSON 是轻量级的文本数据交换格式
JSON 独立于语言 
JSON 具有自我描述性，更易理解

## JSON与XML
XML也是一种数据交换格式，为什么没有选择XML呢？因为XML虽然可以作为跨平台的数据交换格式，但是在JS(JavaScript的简写)中处理 XML非常不方便，同时XML标记比数据多，增加了交换产生的流量，而JSON没有附加的任何标记，在JS中可作为对象处理，所以我们更倾向于选择 JSON来交换数据

## JSON的两种结构
JSON有两种表示结构，对象和数组：
+ 对象结构以”{”大括号开始，以”}”大括号结束。中间部分由0或多个以”，”分隔的”key(关键字)/value(值)”对构成，关键字和值之间以”：”分隔，其中关键字是字符串，而值可以是字符串，数值，true,false,null,对象或数组。
+ 数组结构以”[”开始，”]”结束。中间由0或多个以”，”分隔的值列表组成。

## 认识JSON字符串
字符串：这个很好解释，指使用“”双引号或’’单引号包括的字符。例如：var comStr = 'this is string';

json字符串：指的是符合json格式要求的js字符串。例如：var jsonStr = "{StudentID:' 100', Name:' tmac ' ,Hometown:'usa'}";

json对象：指符合json格式要求的js对象。例如：var jsonObj = { StudentID: "100", Name: "tmac", Hometown: "usa" };

## 在JS中如何使用JSON
JSON是JS的一个子集，所以可以在JS中轻松地读，写JSON。读和写JSON都有两种方法，分别是利用”.”操作符和“[key]”的方式。
```
var obj = {
    1: "value1",
    "2": "value2",
    count: 3,
    person: [ //数组结构JSON对象，可以嵌套使用
        {
            id: 1,
            name: "张三"
        },
        {
            id: 2,
            name: "李四"
        }
    ],
    object: { //对象结构JSON对象
        id: 1,
        msg: "对象里的对象"
    }
};
```

#### 从JSON中读取数据
```
function ReadJSON() {
    alert(obj.1); //会报语法错误，可以用alert(obj["1"]);说明数字最好不要做关键字
    alert(obj.2); //同上

    alert(obj.person[0].name); //或者alert(obj.person[0]["name"])
    alert(obj.object.msg); //或者alert(obj.object["msg"])
}
```

#### 向JSON中写数据
```
function Add() { 
    //往JSON对象中增加了一条记录
    obj.sex= "男" //或者obj["sex"]="男"
}
```

#### 修改JSON中的数据
```
function Update() {
    obj.count = 10; //或obj["count"]=10
}
```

#### 删除JSON中的数据
```
function Delete() {
    delete obj.count;
}
```

#### 遍历JSON对象
可以使用for…in…循环来遍历JSON对象中的数据，比如我们要遍历输出obj对象的值
```
function Traversal() {
    for (var c in obj) {
        console.log(c + ":", obj[c]);
    }
}
```
## 解析JSON
#### 1.使用JavaScript的eval()函数
早期JSON解析器基本上就是使用JavaScript的eval()函数，但eval()则可以解析任何字符串，所以eval是不安全的。如：
```
var obj;
eval("obj={'zhangsan':4}");//合法的
obj=JSON.parse("{'zhangsan':4}");//抛出异常
console.info(obj);
```
#### 2.使用JSON对象 
ES5提供一个全局的JSON对象，用来序列化(JSON.stringify)和反序列化(JSON.parse)对象为JSON格式。

###### JSON.parse(text [, reviver])
JSON.parse接受文本(JSON格式)并转换成一个ECMAScript值 。该可选的reviver参数是有带有key和value两个参数的函数，其作用于结果——让过滤和转换返回值成为可能。
```
var result = JSON.parse('{"a": 1, "b": "2"}', function (key, value) {
    if (typeof value == 'string') {
        return parseInt(value);
    } else {
        return value;
    }
})
```
注意：单引号写在{}外，每个属性名都必须用双引号，否则会抛出异常。

###### JSON.stringify(value [, replacer [, space]])
JSON.stringify允许作者接受一个ECMAScript值然后转换成JSON格式的字符串。 在其最简单的形式中，JSON.stringify接受一个值返回一个字符串
```
var nums = {
    "first": 7,
    "second": 14,
    "third": 13
}

var luckyNums = JSON.stringify(nums, function (key, value) {
    if (value == 13) {
        return undefined;
    } else {
        return value;
    }
});
```

输出结果：
```
>> luckyNums
'{"first": 7, "second": 14}'
```
如果replacer方法返回undefined, 则键值对就不会包含在最终的JSON中。我们同样可以传递一个space参数以便获得返回结果的可读性帮助。space参数可以是个数字，表明了作缩进的 JSON字符串或字符串每个水平上缩进的空格数。如果参数是个超过10的数值，或是超过10个字符的字符串，将导致取数值10或是截取前10个字符。
```
var luckyNums = JSON.stringify(nums, function(key, value) {
  if (value == 13) {
    return undefined;
  } else {
    return value;
  }
}, 2);
```

输出结果：
```
>> luckyNums
'{
  "first":7,
  "second":14
}'
```

#### jQuery
$.parseJSON(string);