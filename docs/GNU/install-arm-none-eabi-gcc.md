# Install `arm-none-eabi-gcc`

## 下载

[下载](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads) Arm GNU Toolchain

根据宿主系统和编译的目标选择对应的安装包，如宿主机为Linux，目标为Arm不带系统裸跑程序，则选择`AArch32 bare-metal target (arm-none-eabi)`。

## 安装

### Linux

下载后解压到本地，添加bin目录到系统环境变量。

或者添加到系统启动项.bashrc，添加如下行:

```
export PATH=$PATH:/home/justin/arm-gnu-toolchain-12.3.rel1-x86_64-arm-none-eabi/bin
```
