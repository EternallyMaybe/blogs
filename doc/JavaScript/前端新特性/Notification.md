### 介绍
Notification的通知接口用于向用户配置和显示桌面通知
### 构造方法
let notification = new Notification(title, options);
### 参数
##### title:必要参数，显示的通知标题
##### options:可选参数，一个被允许用来设置通知的对象
+ dir:文字方向,auto/ltr(从左到右)/rtl(从右到左)
+ lang:指定通知中所使用的语言
+ body：通知中额外显示的字符串
+ tag:赋予通知一个ID，必要时候进行刷新、替换或移除
+ icon:图标URL,用于显示通知的图标
+ vibrate:通知显示时候，设备震动硬件需要的振动模式
+ renotify:true表示新通知替换之前的，false表示不替换
+ silent:布尔值。通知出现时，是否要有声音
+ sound:字符串。音频地址，表示通知出现要播放的声音资源。
+ noscreen:布尔值，是否不在屏幕上显示通知信息。
+ sticky:布尔值。通知是否具有粘性。
+ requireInteraction:布尔值。通知是否自动关闭
### 属性
##### 静态属性
Notification.permission
+ denied:拒绝
+ granted:允许
+ default:默认(与denied行为表现一致)
##### 实例属性
与options内容一致
###### 实例事件处理
+ Notification.onclick:处理 click 事件的处理。每当用户点击通知时被触发。
+ Notification.onshow:处理 show 事件的处理。当通知显示的时候被触发。
+ Notification.onerror:处理 error 事件的处理。每当通知遇到错误时被触发。
+ Notification.onclose:处理 close 事件的处理。当用户关闭通知时被触发。
#### 方法
##### 静态方法
Notification.requestPermission()，用于当前页面向用户申请显示通知的权限。
这个方法只能被用户行为调用（比如：onclick事件），并且不能被其他的方式调用。
##### 实例方法
+ Notification.close():关闭通知
+ EventTarget.addEventListener():
+ EventTarget.removeEventListener()
+ EventTarget.dispatchEvent()
### 使用
html:
```
<div onclick="notify()">click me</div>
```
js:
```
function notify(title, options) {
    if (!(Notification in window)) {
        alert('当前浏览器不支持Notification');
        return;
    }
    if (Notification.permission === 'granted') {
        var notification = new Notification(title, options);
    } else if (Notification.permission !== 'denied') {
        Notification.requestPermission().then((permission) => {
            if (permission === 'granted') {
                var notification = new Notification(title, options);
            } else {
                alert('用户拒绝授权，不能显示通知');
            }
        })
    } else {
        alert('用户拒绝授权，不能显示通知');
    }
}
```
### 参考链接
+ [掘金-H5 notification浏览器桌面通知](https://juejin.im/post/5c6df433f265da2de80f5eda)
+ [MDN-notification](https://developer.mozilla.org/zh-CN/docs/Web/API/notification)
+ [张鑫旭-简单了解HTML5中的Web Notification桌面通知](https://www.zhangxinxu.com/wordpress/2016/07/know-html5-web-notification/)