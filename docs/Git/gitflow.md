# GitFlow 工作流

下面的 [GitFlow 工作流](http://nvie.com/posts/a-successful-git-branching-model/)一节源于 [nvie](http://nvie.com/) 网站上的作者 Vincent Driessen。

GitFlow 工作流围绕项目发布定义了一个严格的分支模型。有些地方比[功能分支工作流](https://github.com/geeeeeeeeek/git-recipes/wiki/3.5-%E5%B8%B8%E8%A7%81%E5%B7%A5%E4%BD%9C%E6%B5%81%E6%AF%94%E8%BE%83#feature%E5%88%86%E6%94%AF%E7%9A%84%E5%B7%A5%E4%BD%9C%E6%B5%81)更复杂，为管理大型项目提供了鲁棒的框架。

和功能分支工作流相比，这种工作流没有增加任何新的概念或命令。它给不同的分支指定了特定的角色，定义它们应该如何、什么时候交流。除了功能分支之外，它还为准备发布、维护发布、记录发布分别使用了单独的分支。当然，你还能享受到功能分支工作流带来的所有好处：Pull Request、隔离实验和更高效的协作。

## 如何工作

GitFlow 工作流仍然使用中央仓库作为开发者沟通的中心。和[其他工作流](https://github.com/geeeeeeeeek/git-recipes/wiki/3.5-%E5%B8%B8%E8%A7%81%E5%B7%A5%E4%BD%9C%E6%B5%81%E6%AF%94%E8%BE%83)一样，开发者在本地工作，将分支推送到中央仓库。唯一的区别在于项目的分支结构。

### 历史分支

和单独的 `master` 分支不同，这种工作流使用两个分支来记录项目历史。`master` 分支储存官方发布历史，`develop` 分支用来整合功能分支。同时，这还方便了在 `master` 分支上给所有提交打上版本号标签。

![Historical Branches](https://wac-cdn.atlassian.com/dam/jcr:2bef0bef-22bc-4485-94b9-a9422f70f11c/02%20(2).svg)

工作流剩下的部分围绕这两个分支的差别展开。

### 功能分支

每个新功能都放置在自己的分支中，可以[在备份/协作时推送到中央仓库](https://github.com/geeeeeeeeek/git-recipes/wiki/3.2-%E4%BF%9D%E6%8C%81%E5%90%8C%E6%AD%A5#git-push)。但是，与其合并到 `master`，功能分支将开发分支作为父分支。当一个功能完成时，它将被[合并回 `develop`](https://github.com/geeeeeeeeek/git-recipes/wiki/3.4-%E4%BD%BF%E7%94%A8%E5%88%86%E6%94%AF#git-merge)。功能永远不应该直接在 `master` 上交互。

![Feature Branches](https://wac-cdn.atlassian.com/dam/jcr:b5259cce-6245-49f2-b89b-9871f9ee3fa4/03%20(2).svg)

注意，功能分支加上 `develop` 分支就是我们之前所说的功能分支工作流。但是，GitFlow 工作流不止于此。

### 发布分支

![Release Branches](https://wac-cdn.atlassian.com/dam/jcr:a9cea7b7-23c3-41a7-a4e0-affa053d9ea7/04%20(1).svg)

一旦  `develop`分支的新功能足够发布（或者预先确定的发布日期即将到来），你可以从 `develop` 分支 fork 一个发布分支。这个分支的创建开始了下个发布周期，只有和发布相关的任务应该在这个分支进行，如修复 bug、生成文档等。一旦准备好了发布，发布分支将合并进 `master`，打上版本号的标签。另外，它也应该合并回 `develop`，后者可能在发布启动之后有了新的进展。

使用一个专门的分支来准备发布确保一个团队完善当前的发布，其他团队可以继续开发下一个发布的功能。它还建立了清晰的开发阶段（比如说，「这周我们准备 4.0 版本的发布」，而我们在仓库的结构中也能看到这个阶段）。

通常我们约定：

- 从 `develop` 创建分支
- 合并进 `master` 分支
- 命名规范 `release-* or release/*`

### 维护分支

![Maintenance Branches](https://wac-cdn.atlassian.com/dam/jcr:61ccc620-5249-4338-be66-94d563f2843c/05%20(2).svg)

维护或者「紧急修复」分支用来快速给产品的发布打上补丁。这是唯一可以从 `master` 上 fork 的分支。一旦修复完成了，它应该被并入 `master` 和 `develop` 分支（或者当前的发布分支），`master` 应该打上更新的版本号的标签。

有一个专门的 bug 修复开发线使得你的团队能够处理 issues，而不打断其他工作流或是要等到下一个发布周期。你可以将维护分支看作在 `master` 分支上工作的临时发布分支。

## 栗子

下面的栗子演示了这种工作流如何用来管理发布周期。假设你已经创建了中央仓库。

### 创建一个开发分支

![Create a Develop Branch](https://www.atlassian.com/git/images/tutorials/collaborating/comparing-workflows/gitflow-workflow/06.svg)

你要做的第一步是为默认的 `master` 分支创建一个互补的 `develop` 分支。最简单的办法是[在本地创建一个空的 develop 分支](https://github.com/geeeeeeeeek/git-recipes/wiki/3.4-%E4%BD%BF%E7%94%A8%E5%88%86%E6%94%AF#git-branch)，将它推送到服务器上：

```
git branch develop
git push -u origin develop
```

这个分支将会包含项目中所有的历史，而 `master` 将包含不完全的版本。其他开发者应该[将中央仓库克隆到本地](https://github.com/geeeeeeeeek/git-recipes/wiki/2.2-%E5%88%9B%E5%BB%BA%E4%BB%A3%E7%A0%81%E4%BB%93%E5%BA%93#git-clone)，创建一个分支来追踪 develop 分支：

```
git clone ssh://user@host/path/to/repo.git
git checkout -b develop origin/develop
```

现在所有人都有了一份历史分支的本地副本。

### Mary 和 John 开始了新功能

![New Feature Branches](https://www.atlassian.com/git/images/tutorials/collaborating/comparing-workflows/gitflow-workflow/07.svg)

我们的栗子从 John 和 Mary 在不同分支上工作开始。他们都要为自己的功能创建单独的分支。[他们的功能分支都应该基于`develop`](https://github.com/geeeeeeeeek/git-recipes/wiki/3.4-%E4%BD%BF%E7%94%A8%E5%88%86%E6%94%AF#git-checkout)，而不是 `master`：

```
git checkout -b some-feature develop
```

他们都使用「编辑、缓存、提交」的一般约定来向功能分支添加提交：

```
git status
git add <some-file>
git commit
```

### Mary 完成了她的功能

![Merging a Feature Branch](https://www.atlassian.com/git/images/tutorials/collaborating/comparing-workflows/gitflow-workflow/08.svg)

在添加了一些提交之后，Mary 确信她的功能以及准备好了。如果她的团队使用 Pull Request，现在正是发起 Pull Request 的好时候，请求将她的功能并入 `develop` 分支。否则，她可以向下面一样，将它并入本地的 `develop` 分支，推送到中央仓库：

```
git pull origin develop
git checkout develop
git merge some-feature
git push
git branch -d some-feature
```

第一个命令在尝试并入功能分支之前确保 `develop` 分支已是最新。注意，功能绝不该被直接并入 `master`。冲突的处理方式和[中心化工作流](https://github.com/geeeeeeeeek/git-recipes/wiki/3.5-%E5%B8%B8%E8%A7%81%E5%B7%A5%E4%BD%9C%E6%B5%81%E6%AF%94%E8%BE%83#%E4%B8%AD%E5%BF%83%E5%8C%96%E7%9A%84%E5%B7%A5%E4%BD%9C%E6%B5%81)相同。

### Mary 开始准备发布

![Preparing a Release](https://www.atlassian.com/git/images/tutorials/collaborating/comparing-workflows/gitflow-workflow/09.svg)

当 John 仍然在他的功能分支上工作时，Mary s开始准备项目的第一个官方发布。和开发功能一样，她新建了一个分支来封装发布的准备工作。这也正是发布的版本号创建的一步：

```
git checkout -b release-0.1 develop
```

这个分支用来整理提交，充分测试，更新文档，为即将到来的发布做各种准备。它就像是一个专门用来完善发布的功能分支。

一旦 Mary 创建了这个分支，推送到中央仓库，这次发布的功能便被锁定了。不在 `develop` 分支中的功能将被推迟到下个发布周期。

### Mary完成了她的发布

![Merging Release into Master](https://www.atlassian.com/git/images/tutorials/collaborating/comparing-workflows/gitflow-workflow/10.svg)

一旦发布准备稳妥，Mary 将它并入 `master` 和 `develop`，然后删除发布分支。合并回 `develop` 很重要，因为可能已经有关键的更新添加到了发布分支上，而开发新功能需要用到它们。同样的，如果 Mary 的团队重视代码审查，现在将是发起 Pull Request 的完美时机。

```
git checkout master
git merge release-0.1
git push
git checkout develop
git merge release-0.1
git push
git branch -d release-0.1
```

发布分支是功能开发（`develop`）和公开发布（`master`）之间的过渡阶段。不论什么时候将提交并入 `master` 时，你应该为提交打上方便引用的标签：

```
git tag -a 0.1 -m "Initial public release" master
git push --tags
```

Git 提供了许多钩子，即仓库中特定事件发生时被执行的脚本。当你向中央仓库推送 `master` 分支或者标签时，你可以配置一个钩子来自动化构建公开发布。

### 终端用户发现了一个 bug

![Maintenance Branch](https://www.atlassian.com/git/images/tutorials/collaborating/comparing-workflows/gitflow-workflow/11.svg)

正式发布之后，Mary 回过头来和 John 一起为下一个发布开发功能。这时，一个终端用户开了一个 issue 抱怨说当前发布中存在一个 bug。为了解决这个 bug，Mary（或 John）从 `master` 创建了一个维护分支，用几个提交修复这个 issue，然后直接合并回 `master`。

```
git checkout -b issue-#001 master
# Fix the bug
git checkout master
git merge issue-#001
git push
```

和发布分支一样，维护分支包含了 `develop` 中需要的重要更新，因此 Mary 同样需要执行这个合并。接下来，她可以[删除这个分支](https://github.com/geeeeeeeeek/git-recipes/wiki/3.4-%E4%BD%BF%E7%94%A8%E5%88%86%E6%94%AF#git-branch)了：

```
git checkout develop
git merge issue-#001
git push
git branch -d issue-#001
```
