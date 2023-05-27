# keil新建公司工程教程

## 说明
公司软件新项目软件新建是在先前相近的项目,修改得到的，所以在软件上可以使用先前版本的软件工程复制进行修改，下面我会举例介绍公司软件新建工程的流程。


## 复制相近的工程文件，进行修改
①确定项目相近的先前工程，复制粘贴，并按照公司的外接擦窗机PCBA编码规范修改复制得来的项目名称如下图。

![image](image\keil_bulid_project_01.png)

②打开新建的工程文件，将工程文件文件夹中，复制过来的多余的文件都删掉，只留下项目的工程文件并将工程文件的名字改成项目名称如下图所示。

![image](image\keil_bulid_project_02.png)


## 修改工程的项目配置
①打开项目的工程文件，点击魔术棒弹出项目配置选项卡。

![image](image\keil_bulid_project_03.png)

②选择配置选项卡里面的Output选项卡，将可执行文件的名称更改为项目名称如下图

![image](image\keil_bulid_project_04.png)

③选择配置选项卡里面的User选项，检查环境变量是否正确，如果不正确请改正，正确的环境变量是

..\..\..\utils\bootscript.bat @P mm32f0144

fromelf --bin --output .\output\@P.bin .\output\@P.axf

..\..\..\utils\script.bat @P mm32f0144 {UV2_TARGET}

其中@P表示的是项目的名称，项目的环境变量修改如下图。

![image](image\keil_bulid_project_05.png)

## 修改工程中的 target.h 文件

①检查target.h 文件里面的引脚定义与原理图是否对应，如果有不对应的地方按照项目原理图修改！！！

②修改项目的版本号，如下图。

![image](image\keil_bulid_project_06.png)

③如果项目带有APP功能，需要修改APP的ID号，ID号需要在涂鸦服务器上申请，并将申请的ID号码在target.h中进行修改，如下图。

![image](image\keil_bulid_project_07.png)

### 至此工程新建就已经完成。