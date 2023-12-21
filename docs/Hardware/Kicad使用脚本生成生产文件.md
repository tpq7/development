# Kicad使用脚本生成生产文件

## 准备

### 安装相关软件

安装最新的Kicad软件 [Kicad](https://www.kicad.org/)

安装 [Python](https://www.python.org/)

Python安装好后安装必要的库

打开Windows终端，依次输入如下命令

```
python -m pip install xlsxwriter
```

### 设置系统环境变量

添加Kicad安装目录下的bin文件夹路径到系统环境变量

*如下目录仅供参考，添加自己的实际目录*

```
C:\Program Files\KiCad\7.0\bin\
```

![image](image/kicad-script-gen-fabs-1.png)
![image](image/kicad-script-gen-fabs-2.png)

## 执行脚本生成生产文件

打开Windows终端，进入工程仓库目录下的utils子目录

执行如下脚本

```
chcp 65001

gen-fabs.bat 总的项目名称
gen-fabs.bat 总的项目名称\具体的电路板

例子：
gen-fabs.bat EGS-01
gen-fabs.bat EGS-01\cleanrobot-square-main
```

如果只指定总的项目名称（例：`EGS-01`），则会生成这个项目所有电路板的生产文件；如果指定了项目下的具体的电路板（例：`EGS-01\cleanrobot-square-main`），则只会生成这个电路板的生产文件。

查看log信息，确定是否有报错

![image](image/kicad-script-gen-fabs-3.png)

1. 指示生成具体哪个板子
2. 板子版本
3. 板子尺寸和工艺信息
4. 指示生成BOM
5. 指示生成Gerber
6. 指示生成坐标文件
7. 指示生成贴片图
