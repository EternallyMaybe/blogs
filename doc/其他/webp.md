### 什么是Webp图片
WebP是一种新的图片格式，目标是减少文件大小但达到和JPEG格式相同的图片质量，能够减少网络上的请求时间。
### 优势与劣势
#### WebP优势
WebP相比于JPG拥有更小的文件尺寸、更高的质量（相比于相同大小不同格式的压缩图片），抽取100张商品图片采用80%压缩，大约能减少60%的文件大小。
#### WebP劣势
根据Google的测试，目前WebP与JPG相比较，编码速度慢10倍，解码速度慢1.5倍。
编码方面，一般来说，我们可以在图片上传时生成一份WebP图片或者在第一次访问JPG图片时生成WebP图片，对用户体验的影响基本忽略不计。
解码方面，WebP虽然会增加额外的解码时间，但由于减少了文件体积，缩短了加载的时间，页面的渲染速度加快了。同时，随着图片数量的增多，WebP页面加载的速度相对JPG页面增快了。
### WebP兼容性
下图为兼容性情况（数据来源于[https://caniuse.com/#search=WebP](https://caniuse.com/#search=WebP)）
![](https://user-gold-cdn.xitu.io/2018/4/13/162bd91c5946c546?w=1264&h=454&f=png&s=35523)
就目前而言，WebP支持Chrome和Opera浏览器以及部分手机浏览器
### Webp生成方式
#### 在线生成
* 智图 [http://zhitu.isux.us/](http://zhitu.isux.us/)
* 又拍云 [https://www.upyun.com/webp](https://www.upyun.com/webp)
* CloudConvert [https://cloudconvert.com/webp-to-anything](https://cloudconvert.com/webp-to-anything)
* iSparta [http://isparta.github.io/index.html](http://isparta.github.io/index.html)

#### canvas生成
```
var canvas = document.createElement('canvas'),
    ctx = canvas.getContext('2d'),
    img = document.getElementById('img');

    var loadImg = function(url, fn) {
        var image = new Image();
        image.src = url;
        image.onload = function() {
             fn(image);
        }
    }
    loadImg('image url', function(image) {
        canvas.height = image.height;
        canvas.width = image.width;
        ctx.drawImage(image, 0, 0);
        img.setAttribute('src', canvas.toDataURL('image/webp'));
    });
```

#### gulp-WebP或gulp-imageisux
通过使用gulp的两个插件来进行压缩
##### gulp-WebP

```
var gulp = require('gulp');
var webp = require('gulp-webp');

gulp.task('default', ()=> {
    gulp.src('./*.{png,jpg,jpeg}')
    .pipe(webp({quality: 80}))
    .pipe(gulp.dest('./dist'));
});
```
有损压缩图片设置webp插件的quality参数，无损压缩设置lossless参数为true即可

##### gulp-imageisux

```
var imageisux = require('gulp-imageisux');
gulp.task('default', ()=>　{
    gulp.src('./*.{png,jpg,jpeg}')
    .pipe(imageisux('/dirpath/', enableWebp));
})
```
API 两个参数，dirpath目标目录以及enableWebp是否同时导出对应WEBP格式图片
* dirpath: 如果未定义，会自动生成两个目录：'/dest/'目录放压缩后图片，'/webp/'目录放对应的webp格式压缩图片。
* enableWebp : 若为true，则会同时输出webp图片；若为false，则只会有压缩后原格式图片。