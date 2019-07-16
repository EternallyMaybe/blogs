## npm模块安装机制
1. 发出npm install命令
2. npm 向 registry 查询模块压缩包的网址，这个网址后面跟上模块名，就会得到一个 JSON 对象，里面是该模块所有版本的信息。返回的 JSON 对象里面，有一个dist.tarball属性，是该版本压缩包的网址
3. 下载压缩包，存放在~/.npm目录
4. 解压压缩包到当前项目的node_modules目录

注意事项：
1. npm install的时候只会检查node_modules目录而不会检查~/.npm目录，也就是说如果没有安装到node_modules目录中，npm会从远程仓库下载一次新的压缩包。npm 提供了一个--cache-min参数，用于从缓存目录安装模块。--cache-min参数指定一个时间（单位为分钟），只有超过这个时间的模块，才会从 registry 下载
```
$ npm install --cache-min 9999999 <package-name>
```
2. 离线安装
+ Registry 代理。
+ npm install替代。
+ node_modules作为缓存目录。

## npm指令
1. npm install <package-name>  安装包
2. npm ls 查看安装的包
    + npm ls <package-name> 查看特定的包
3. npm update <package-name> 更新包
4. npm search <package-name> 搜索
5. npm config ls 查看npm配置
6. npm config set prefix [path] 设置安装全局包路径 （全局包就会安装在这里)
7. npm config set cache [path] 设置包缓存路径，方便下次快速安装包
8. npm config set registry  [path] 设置镜像代理

## 全局安装地址
window: C:\Users\XXX/AppData\Roaming\npm\node_modules