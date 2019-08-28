## 什么是gitbook
gitbook简单来说就是一款可以在线制作书籍的网站，在这里可以把自己的文档整理成书籍发布出来，便于阅读。具体制作有两种方式，一种是在gitbok官网上进行创作，另外一种使用gitbook工具进行开发。本文主要介绍使用gitbook工具开发这种方式，关于在线制作，大家可以进入官网尝试，不过可能会遇到翻墙问题。

gitbook官网：https://www.gitbook.com/
## 使用gitbook工具开发
#### 安装node、git
开发之前先确保已经安装nodejs、git,这是我本机安装的情况，只要能查看到版本信息，就说明安装成功了
```
~ node -v
v8.12.0
~ git --version
git version 2.19.1.windows.1
```
#### 安装gitbook命令行工具
Node提供了gitbook的命令行工具gitbook-cli，所以在这里下载一个这样的工具
```
~ npm install -g gitbook-cli
```
查看是否安装成功
```
~ gitbook --version
CLI version: 2.3.2
GitBook version: 3.2.3
```
出现版本信息，证明gitbook安装成功
#### gitbook初始化
创建工作目录，并创建README.md、SUMMARY.md,然后进行初始化
```
~ mkdir gitbook
~ cd gitbook
~ touch README.md
~ touch SUMMARY.md
```
在SUMMARY.md填写自己的目录机构
```
* [Introduction](README.md)
* [第一章](doc/chapter1/README.md)
    * [第一节](doc/chapter1/page1.md)
    * [第二节](doc/chapter1/page2.md)
* [第二章](doc/chapter2/README.md)
    * [第一节](doc/chapter2/page1.md)
    * [第二节](doc/chapter2/page2.md)
```
开始初始化
```
gitbook init
```
目录结构如下

![gitbook目录](/blogs/src/images/gitbook-menu.png)

gitbook会自动创建对应的目录和文件。当然你也可以选择先不创建README.md、SUMMARY.md这两个文件，直接使用gitbook init进行初始化，它会自动为你创建这两个文件。
#### 本地启动服务编写书籍
输入gitbook serve命令,启动服务
```
~ gitbook serve
Live reload server started on port: 35729
Press CTRL+C to quit ...

info: 7 plugins are installed
info: loading plugin "livereload"... OK
info: loading plugin "highlight"... OK
info: loading plugin "search"... OK
info: loading plugin "lunr"... OK
info: loading plugin "sharing"... OK
info: loading plugin "fontsettings"... OK
info: loading plugin "theme-default"... OK
info: found 7 pages
info: found 6 asset files
info: >> generation finished with success in 0.9s !

Starting server ...
Serving book on http://localhost:4000
```
出现以上提示就表示服务已经启动成功，然后在浏览器输入http://localhost:4000 就可以看到效果了
#### 项目部署到github pages
首先了解一下[github pages](https://pages.github.com/),它是为你的项目提供一个免费的访问站点，并且直接指向你的github仓库，你的仓库更新，站点也自动更新。

紧接着我们把项目分成master、gh-pages两个分支，源码放在master分支上，要部署的网站放在gh-pages分支。
具体操作:
##### 1.在github上创建gitbook仓库
##### 2.在本地项目中创建.gitignore文件,内容如下:
```
_book
```
##### 3.上传本地项目到github
上传master分支的内容
```
~ git init
~ git add .
~ git commit -m 'gitbook init'
~ git remote add origin https://github.com/{username}/gitbook.git
~ git push origin master
```
上传gh-pages的内容，为了方便可以在根目录创建一个deploy.sh脚本

```
#!/usr/bin/env sh
echo '开始执行命令'

# 是否安装node
echo '检查是否安装node'
if command -v node >/dev/null 2>&1; then
    echo "Node exists"
else 
    echo "Node does not exist" && exit 0
fi

# 是否安装git
echo '检查是否安装git'
if command -v git >/dev/null 2>&1; then
    echo "Git exists"
else 
    echo "Git does not exist" && exit 0
fi

# 生成静态文件
echo '执行命令：gitbook build .'
gitbook build .

# 进入生成的文件夹
echo '执行命令：cd ./_book'
cd ./_book

# 重写图片路径
echo '执行命令：node ./build/renameImgUrl'
node ./build/renameImgUrl.js

sleep 1

# 初始化一个仓库，仅仅是做了一个初始化的操作，项目里的文件还没有被跟踪
echo "执行命令：git init\n"
git init

# 保存所有的修改
echo "执行命令：git add ."
git add .

# 把修改的文件提交
echo "执行命令：commit -m 'deploy'"
git commit -m 'deploy'

# 如果发布到 https://<USERNAME>.github.io/<REPO>
echo "执行命令：git push -f git@github.com:EternallyMaybe/blogs.git master:gh-pages"
git push -f git@github.com:EternallyMaybe/blogs.git master:gh-pages

# 返回到上一次的工作目录
echo "回到刚才工作目录"
cd -
```

文件保存后，执行bash deploy.sh命令,然后要发布的内容就会被推送到gh-pages分支上，这里需要注意一点，window系统不支持.sh文件，但是git bash却支持这种文件，所以可以在git bash中运行这条命令。

##### 4.发布项目
在github网站上的仓库里面点击Settings -> GitHub Pages选项中 -> Source里面选择gh-pages branch 然后点击Save按钮，然后在GitHub Pages下面就会看见一个网站。

#### 插件
gitbook有[插件官网](https://docs.gitbook.com/v2-changes/important-differences),默认带有5个插件，highlight、search、sharing、font-settings、livereload，如果要去除自带的插件， 可以在插件名称前面加 -，比如：
```
"plugins": [
    "-search"
]
```
新增插件
```
{
    "plugins": ["github"],
    "pluginConfig": {
        "github": {
            "url": "https://github.com/your/repo"
        }
    }
}
```
最后在控制台输入gitbook install

#### 项目地址
最后附上本项目的github地址：[https://github.com/EternallyMaybe/blogs/](https://github.com/EternallyMaybe/blogs/)

## 参考文章
gitbook使用教程:[https://segmentfault.com/a/1190000017960359](https://segmentfault.com/a/1190000017960359)

Github Pages:[https://sspai.com/post/54608](https://sspai.com/post/54608)

gitbook 插件:[https://www.cnblogs.com/mingyue5826/p/10307051.html](https://www.cnblogs.com/mingyue5826/p/10307051.html)

