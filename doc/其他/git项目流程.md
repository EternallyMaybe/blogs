#### 1.仓库
##### 源仓库
在项目的开始，项目的发起者构建起一个项目的最原始的仓库，我们把它称为origin，例如我们的PingHackers网站，origin就是这个PingHackers/blog了。源仓库的有两个作用：
+ 汇总参与该项目的各个开发者的代码
+ 存放趋于稳定和可发布的代码

源仓库应该是受保护的，开发者不应该直接对其进行开发工作。只有项目管理者（通常是项目发起人）能对其进行较高权限的操作。
##### 开发者仓库
任何开发者都不会对源仓库进行直接的操作，源仓库建立以后，每个开发者需要做的事情就是把源仓库的“复制”一份，作为自己日常开发的仓库。这个复制，也就是github上面的fork。

每个开发者所fork的仓库是完全独立的，互不干扰，甚至与源仓库都无关。每个开发者仓库相当于一个源仓库实体的影像，开发者在这个影像中进行编码，提交到自己的仓库中，这样就可以轻易地实现团队成员之间的并行开发工作。而开发工作完成以后，开发者可以向源仓库发送pull request，请求管理员把自己的代码合并到源仓库中，这样就实现了分布式开发工作，和最后的集中式的管理。

#### 2.分支
永久性分支
+ master branch：主分支
+ develop branch：开发分支

临时性分支
+ fixbug branch: bug修复分支
+ feature branch：功能分支
+ release branch：预发布分支
+ hotfix branch：bug修复分支

#### 3.工作流
1. 源仓库的构建
2. 开发者fork源仓库
3. 把自己开发者仓库clone到本地
git clone "git.com"
4. 构建功能分支进行开发
```
 // 切换到`develop`分支
 git checkout develop
// 分出一个功能性分支
 git checkout -b feature-discuss
// 假装discuss.js就是我们要开发的功能
 touch discuss.js
 git add .
// 提交更改
git commit -m 'finish discuss feature'
// 回到develop分支 
git checkout develop
// 把做好的功能合并到develop中
git merge --no-ff feature-discuss
// 删除功能性分支
git branch -d feature-discuss
// 把develop提交到自己的远程仓库中
git push origin develop
```
5. 向管理员提交pull request
6. 管理员测试、合并
```
// 对我的代码进行review
// 在他的本地测试新建一个测试分支
git checkout develop
// 进入他本地的develop分支
git checkout -b livoras-develop
// 从develop分支中分出一个叫livoras-develop的测试分支测试我的代码
git pull https://github.com/livoras/git-demo.git develop
// 把我的代码pull到测试分支中，进行测试
// 判断是否同意合并到源仓库的develop中
```

#### 4.提交规范
Commit message 都包括三个部分：Header，Body 和 Footer。Header 是必需的，Body 和 Footer 可以省略。

##### Header部分只有一行，包括三个字段：type（必需）、scope（可选）和subject（必需）。
###### type
type用于说明 commit 的类别，只允许使用下面7个标识。

feat：新功能（feature）

fix：修补bug

docs：文档（documentation）

style： 格式（不影响代码运行的变动）

refactor：重构（即不是新增功能，也不是修改bug的代码变动）

test：增加测试

chore：构建过程或辅助工具的变动

如果type为feat和fix，则该 commit 将肯定出现在 Change log 之中。其他情况（docs、chore、style、refactor、test）由你决定，要不要放入 Change log，建议是不要。
###### scope
scope用于说明 commit 影响的范围，比如数据层、控制层、视图层等等，视项目不同而不同。
###### subject
subject是 commit 目的的简短描述，不超过50个字符

##### Body
Body 部分是对本次 commit 的详细描述，可以分成多行

#### 其他
1. git merge --no-ff feature-discuss退出vim
输入i编辑信息
按Esc键
输入：wq,按enter回到原界面
2. git checkout release, git rebase dev
把你的"release"分支里的每个提交(commit)取消掉，并且把它们临时 保存为补丁(patch)(这些补丁放到".git/rebase"目录中),然后把"release"分支更新 为最新的"origin"分支，最后把保存的这些补丁应用到"release"分支上。
解决冲突
在解决完冲突后，用"git-add"命令去更新这些内容的索引(index), 然后，你无需执行 git-commit,只要执行: git rebase --continue
在任何时候，你可以用--abort参数来终止rebase的行动，并且"mywork" 分支会回到rebase开始前的状态。

#### 参考网址
工作流程:[https://blog.csdn.net/xiangff_csdn/article/details/52184394](https://blog.csdn.net/xiangff_csdn/article/details/52184394)

退出vim:[https://segmentfault.com/q/1010000005979356/a-1020000005980392](https://segmentfault.com/q/1010000005979356/a-1020000005980392)

rebase:[https://blog.csdn.net/wh_19910525/article/details/7554489](https://blog.csdn.net/wh_19910525/article/details/7554489)

提交规范:[http://www.ruanyifeng.com/blog/2016/01/commit_message_change_log.html](http://www.ruanyifeng.com/blog/2016/01/commit_message_change_log.html)

gitflow:[https://www.jianshu.com/p/9a76e9aa9534](https://www.jianshu.com/p/9a76e9aa9534)

gitflow:[https://segmentfault.com/a/1190000006194051](https://segmentfault.com/a/1190000006194051)
