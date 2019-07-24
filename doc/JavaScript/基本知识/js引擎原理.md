## js引擎工作原理
#### 名词定义
1. ECStack(执行环境栈):执行环境的栈，后进先出，保证程序能够按照正确的顺序执行。
2. EC(执行环境):每个函数都有自己的执行环境，当执行一个函数时，该函数的执行环境会被推入到执行环境栈的顶部并获取执行权。
3. 全局变量对象:包含原有的全局对象属性，还包括全局定义的变量和函数，定义函数时，会为函数添加一个内部属性scope，并将scope指向VO。
4. VO(变量对象):创建执行环境时与之关联的会有一个变量对象，该环境中的所有变量和函数全都保存在这个对象中。
5. AO(活动对象):进入到一个执行环境时，此执行环境中的变量和函数都可以被访问到，可以理解为被激活

#### 实例分析
```
var x = 1;
function A(y){
   var x = 2;
   function B(z){
       console.log(x+y+z);
   }
   return B;
}
var C = A(1);
C(1);
```

##### 全局初始化
1. 创建一个全局对象
2. JS引擎构建一个执行环境栈，同时创建一个全局执行环境EC，并将这个全局执行环境EC压入执行环境栈中。
3. JS引擎创建一个与EC相关联的全局变量对象VO
```
ECStack = [   //执行环境栈
    EC(G) = {   //全局执行环境
        VO(G):{ //定义全局变量对象
            ... //包含全局对象原有的属性
            x = 1; //定义变量x
            A = function(){...}; //定义函数A
            A[[scope]] = this; //定义A的scope，并赋值为VO本身
        }
    }
];
```

##### 执行函数A
1. JS引擎创建函数A的执行环境EC，然后将EC推入执行环境栈顶部获取执行权
2. JS引擎创建一个当前函数的活动对象AO
```
ECStack = [   //执行环境栈
    EC(A) = {   //A的执行环境
        [scope]:VO(G), //VO是全局变量对象
        AO(A) : { //创建函数A的活动对象
            y:1,
            x:2,  //定义局部变量x
            B:function(){...}, //定义函数B
            B[[scope]] = this; //this指代AO本身，而AO位于scopeChain的顶端，因此B[[scope]]指向整个作用域链
            arguments:[],//平时我们在函数中访问的arguments就是AO中的arguments
            this:window  //函数中的this指向调用者window对象
        },
        scopeChain:<AO(A),A[[scope]]>  //链表初始化为A[[scope]],然后再把AO加入该作用域链的顶端,此时A的作用域链：AO(A)->VO(G)
    },
    EC(G) = {   //全局执行环境
        VO(G):{ //创建全局变量对象
            ... //包含全局对象原有的属性
            x = 1; //定义变量x
            A = function(){...}; //定义函数A
            A[[scope]] = this; //定义A的scope，A[[scope]] == VO(G)
        }
    }
];
```

##### 执行函数B
1. 创建函数B的执行环境EC，将EC推入到执行环境栈的顶部并获取执行权。当函数B返回时，A的执行环境就会从栈中被删除，只留下全局执行环境。
2. 创建B的作用域链，初始化B的scope所包含的对象，即包含A的作用域链。
```
ECStack = [   //执行环境栈
    EC(B) = {   //创建B的执行环境,并处于作用域链的顶端
        [scope]:AO(A), //指向函数A的作用域链,AO(A)->VO(G)
        var AO(B) = { //创建函数B的活动对象
            z:1,
            arguments:[],
            this:window
        }
        scopeChain:<AO(B),B[[scope]]>  //链表初始化为B[[scope]],再将AO(B)加入链表表头，此时B的作用域链：AO(B)->AO(A)-VO(G)
    },
    EC(A), //A的执行环境已经从栈顶被删除,
    EC(G) = {   //全局执行环境
        VO:{ //定义全局变量对象
            ... //包含全局对象原有的属性
            x = 1; //定义变量x
            A = function(){...}; //定义函数A
            A[[scope]] = this; //定义A的scope，A[[scope]] == VO(G)
        }
    }
];
```

##### 注意
1. 闭包就是内部函数的作用域链仍然保持着对父函数活动对象的引用
2. 函数的作用域链包括父对象的作用域链以及当前活动对象

#### 原文地址
[探究JS引擎原理](http://www.cnblogs.com/onepixel/p/5090799.html)
[JavaScript深入之执行上下文栈](https://github.com/mqyqingfeng/Blog/issues/4)