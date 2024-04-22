# 切换到添加新submodule分支问题

## 确保当前分支下不存在新submodule文件夹

确定下方两个目录没有对应新submodule文件夹

```
.git\modules
submodule所在目录
```

有的话删除对应文件夹

## 按照下列文档方法在当前分支添加新的submodule

参考[添加submodule文档](https://timye-development.readthedocs.io/en/latest/Git/Git%E5%B8%B8%E7%94%A8%E5%91%BD%E4%BB%A4.html#submodule)

首先确定新分支增加的submodule名称与submodule仓库名称是否一致，不一致的话需要指定新的submodule对应本地文件夹名称。

如：
`git submodule add https://github.com/Timyerc/CleanRobot-MM32F0160-Bootloader.git Bootloader\mm32f0160-rc4bootloader`

仓库名称是`CleanRobot-MM32F0160-Bootloader`，本地对应submodule的名称是`mm32f0160-rc4bootloader`。

## 切换到新的分支

本地更改带到新的分支。