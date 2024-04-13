# Git常用命令

作者@Justin

## 删除远程标签

`git push --delete origin tagname`

同时可以使用下面的命令删除本地标签

`git tag --delete tagname`

## 清除未跟踪的文件和文件夹

`git clean -f -d -x`

## 使用reset回到历史提交，并推送到远程，用来丢弃新的提交

```
git reset --hard commit-id
git push --force
```

***需谨慎使用，无法回到丢弃的提交***

## 忽略已跟踪的文件

`git rm --cached <file>`

## submodule相关

添加submodule

`git submodule add repo-url`

如果你已经克隆了仓库，但忘了加`--recurse-submodules`, 你可以通过执行下方命令来完成submodule初始化和更新

`git submodule update --init`

如果要更新其他嵌套的submodule，执行下方命令

`git submodule update --init --recursive`

## git设置和取消代理

```
git config --global http.proxy http://127.0.0.1:1080
git config --global https.proxy https://127.0.0.1:1080
git config --global --unset http.proxy
git config --global --unset https.proxy
```
