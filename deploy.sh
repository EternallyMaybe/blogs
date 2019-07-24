#!/bin/bash
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
echo "执行命令：git commit -q -m 'deploy'"
git commit -q -m 'deploy'

# 如果发布到 https://<USERNAME>.github.io/<REPO>
echo "执行命令：git push -f git@github.com:EternallyMaybe/blogs.git master:gh-pages"
git push -f git@github.com:EternallyMaybe/blogs.git master:gh-pages

# 返回到上一次的工作目录
echo "回到刚才工作目录"
cd -
