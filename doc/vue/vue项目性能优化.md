### 图片优化
1. 图片大小优化，部分图片使用WebP（需要考虑webp兼容性）
    * 在线生成，如智图、又拍云
    * gulp生成，gulp-webp或gulp-imageisux
    * canvas生成

    可以参考[https://juejin.im/post/5ad0435c5188255c887c0bae](https://juejin.im/post/5ad0435c5188255c887c0bae)
2. 减少图片请求，使用雪碧图
    * 在线生成：sprites Generator、腾讯的gopng、spriteme
    * 代码生成：gulp.spritesmith或者sass的compass

3.一些较小图片使用base64
### 页面性能优化
#### 图片或组件懒加载
使用vue-lazyload组件或其他一些组件

vue-lazyload地址：[https://www.npmjs.com/package/vue-lazyload](https://www.npmjs.com/package/vue-lazyload)
1. 图片懒加载：v-lazy或使用v-lazy-container包含一个图片组
```
// 引入一张图片 
<img v-lazy="//domain.com/img1.jpg">  
// 引入一组图片
<div v-lazy-container="{ selector: 'img', error: 'xxx.jpg', loading: 'xxx.jpg' }">
  <img data-src="//domain.com/img1.jpg">
  <img data-src="//domain.com/img2.jpg">
  <img data-src="//domain.com/img3.jpg">  
</div>
```
2. 组件懒加载
```
Vue.use(VueLazyload, {
  lazyComponent: true
});
<lazy-component>
  <img class="mini-cover" :src="img.src" width="100%" height="400">
</lazy-component>
```
#### 图片预加载
快速显示图片

使用场景：在某个查看图片的组件，当不断翻看下一页的图片时，从服务端获取数据再展示图片会出现图片缓慢加载的情况，此时可以在展示新数据时候先预加载图片，图片加载完之后在，将图片填充到对应位置
#### 三方插件懒加载（按需加载）
js文件一般是同步加载的，放在页面内会阻塞主要js文件加载。

使用场景：有的项目必须引入jquery等文件时，在组件内部引入这些文件一定程度会阻塞页面渲染，因而通过特定事件（点击或者弹窗）动态加载jquery等JS文件，可以使主页面快速显示出来。
#### 异步加载页面，如何让组件之间不重合
加载多个vue组件时，同时组件是通过服务端数据渲染时，会出现多个组件先重合后分离的状况

四种方案
1. 当页面展示的版块是固定的时候且内容高度不易变动时候，可以预先在组件外设置一个固定高度，显示的时候就像在一个框架里添加内容。当页面内容不固定时候，为了减少异步加载时组件重合的问题，可以在首屏在某组件数据加载完成时候设置其他组件显示，通过v-show显示。
2. 当页面整体固定时，可以为页面增加一个骨架，这样防止页面闪烁的情况

    具体实施可以参照[https://segmentfault.com/a/1190000012403177](https://segmentfault.com/a/1190000012403177)
    
3.预渲染加关键css

预渲染的同时要在页面加载前获取页面所需要的数据，避免加载页面时出现重叠的情况

[https://github.com/EternallyMaybe/webpack-demo/blob/master/server-webpack.js](https://github.com/EternallyMaybe/webpack-demo/blob/master/server-webpack.js)
4. 服务端渲染页面,对于一些页面数据固定、更改较少的，可以考虑通过服务端渲染，会在短时间将页面显示出来，有比较好的用户体验。
#### 减少引入外部文件大小
框架引入部分ElementUI内容时，通过引入babel-plugin-component配置.babelrc文件，这样即可引入部分组件，从而减少组件的大小。
#### 路由懒加载
但使用到vue-router时，webpack会将所有组件打包在一个js文件中，这样就导致这个文件非常大，从而会影响首页的加载，最好的方法就是将其他路由分别打包到不同js文件中，切换路由时再加载对应js文件。
```
resolve => require([URL], resolve), 支持性好
() => system.import(URL) , webpack2官网上已经声明将逐渐废除, 不推荐使用
() => import(URL), webpack2官网推荐使用, 属于es7范畴, 需要配合babel的syntax-dynamic-import插件使用
```
#### 路由页面缓存
使用vue-router的keep-alive
缓存页面，下次打开页面时候不需要重新加载，显示更快

### 请求优化
1. 服务器对图片缓存
2. 设置请求缓存，设置cache-control
3. 开启Gzip,压缩响应信息，使传输快
4. 设置DNS缓存
5. 使用HTTP2.0