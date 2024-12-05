# 串口MSP协议

## 客户端包 Client Packages

\<preamble>,\<option>,\<device>,\<command>,\<size>,\<data>,\<crc>
| 项 | 描述 | 注释 |
| ----------- | ----------- | ----------- |
| preamble | 包的序言 | 总是为 0xFF |
| option | 包的选择 | 见下文 |
| device | 设备码 | 此包适用于设备 |
| command | 包命令 | 见下文 |
| size | 数据所占字节数 | |
| data | 数据 | 命令附带的可选数据 |
| crc | crc 校验和 | \<device>,\<command>,\<size>的异或运算，将每个数据字节归为零和 |

\<option> 位描述

缺省: 0xFF
| 位 7-1 | 位 0 |
| -------- | ----- |
| Reserved | Answer |
- Answer – 当设置为1时，执行该命令并发送回复。0时，行动但不回应。

## 响应包 Responce Packages

\<preamble>,\<option>,\<command>,\<size>,\<data>,\<crc>
| 项 | 描述 | 注释 |
| ----------- | ----------- | ----------- |
| preamble | 包的序言 | 总是为 0xFF |
| option | 包的选择 | 当这是一个确认时设置为0xFF，当这是一个异步消息时设置为0xFE |
| command | 包命令 | 见下文 |
| size | 数据所占字节数 | |
| data | 数据 | 命令附带的可选数据 |
| crc | crc 校验和 | \<device>,\<command>,\<size>的异或运算，将每个数据字节归为零和 |

## 设备码 Device Code

| 值 | 名称 |
| ----- | ---- |
| 0x00 | DCODE_CORE |
| 0x03 | DCODE_SOLAR_CLEANBOT |

## 核心命令 Core Command

| 值 | 名称 |
| ----- | ---- |
| 0x01 | CMD_PING |
| 0x02 | CMD_VERSION |
| 0x03 | CMD_GET_POWER_STATE |
| 0x04 | CMD_SET_POWER_NOTIFY |
| 0x05 | CMD_ENTER_BOOTLOADER |
| 0x06 | CMD_BINARY_INFO |
| 0x07 | CMD_BINARY_OFFSET |
| 0x08 | CMD_BINARY_TRANS |
| 0x09 | CMD_BINARY_TRANS_OVER |

## 命令 Command

### API命令

| 值 | 名称 | 描述 |
| ----- | ---- | ---- |
| 0x61 | CMD_RANGEFINDER | 获取超声波距离 |
| 0x62 | CMD_SET_HEARTBEAT | 设置心跳值(s)，默认1s发送一次心跳包 |
| 0x63 | CMD_SET_ROTATE | 设置旋转角度值 |
| 0x64 | CMD_SET_SPEED | 设置速度值 |
| 0x65 | CMD_SET_LINE_STATUS | 设置栅线数据 |
| 0x66 | CMD_RAW_IMU | 获取陀螺仪加速度原始值 |
| 0x67 | CMD_GET_LINE_STATUS | 获取栅线数据 |
| 0x68 | CMD_MOTOR_SPEED | 获取速度 |
| 0x69 | CMD_CROSS_BATT | 获取跨电池片数量 |
| 0x6C | CMD_ATTITUDE | 获取姿态角 |
| 0x6D | CMD_SYSTEM | 获取系统任务信息 |
| 0x6E | CMD_GET_REVEIVER | 获取遥控器通道数据 |
| 0x6F | CMD_FRAMERATE | 设置视觉处理帧率 |
| 0x82 | CMD_BATTERY_STATE | 获取电池状态 |
| 0x84 | CMD_GET_TEMP | 获取电机温度 |
| 0x85 | CMD_GET_MOVE_STATUS | 获取运动状态 |
| 0x86 | CMD_SET_CELL_INFO | 设置电池片尺寸信息 |

### 配置命令（上位机）

| 值 | 指令名称 | 描述 |
| ----- | ---- | ---- |
| 130 | MSP_GET_PWMVALUE | 获取风机占比 |
| 131 | MSP_GET_USE_FAN_LEVEL_DYNAMIC_COMP | 获取风机最大最小占比 |
| 132 | MSP_GET_USE_FAN_OUTPUT_PID | 获取风机恒压占比 |
| 133 | MSP_GET_MOTOR_VALUE | 获取马达占比 |
| 134 | MSP_GET_BOUNDLESS | 获取无边电流 |
| 135 | MSP_GET_SPRAY_VALUE | 获取喷水功能 |
| 136 | MSP_GET_GYRO_THRESHOLD | 获取陀螺仪阈值 |
| 220 | MSP_SET_PWMVALUE | 设置风机占比 |
| 221 | MSP_SET_USE_FAN_LEVEL_DYNAMIC_COMP | 设置风机最大最小占比 |
| 222 | MSP_SET_USE_FAN_OUTPUT_PID | 设置风机恒压占比 |
| 223 | MSP_SET_MOTOR_VALUE | 设置马达占比 |
| 224 | MSP_SET_BOUNDLESS | 设置无边电流 |
| 225 | MSP_SET_SPRAY_VALUE | 设置喷水功能 |
| 226 | MSP_SET_GYRO_THRESHOLD | 设置陀螺仪阈值 |

## API 命令细节 API Command Detial

### CMD_RANGEFINDER 0x61

#### Require

| device | command | size |
| ------ | ------- | ---- |
| 0x03   | 0x61    | 0x00 |

#### Response

| command | size | left front | right front | left back | right back | sample rate |
| ------- | ---- | -----------| ----------- | ----------| ---------- | ----------  |
| 0x61    | 0x0A | 16 bit unsigned  | 16 bit unsigned | 16 bit unsigned | 16 bit unsigned | 16 bit unsigned |

### CMD_SET_HEARTBEAT 0x62

#### Require

| device | command | size | rotate value | 
| ------ | ------- | ---- | ----------------|
| 0x03   | 0x62    | 0x02 | 16 bit signed   |

#### Response

Simple response

### CMD_SET_ROTATE 0x63

#### Require

| device | command | size | rotate value | 
| ------ | ------- | ---- | ----------------|
| 0x03   | 0x63    | 0x02 | 16 bit signed   |

#### Response

Simple response

### CMD_SET_SPEED 0x64

#### Require

| device | command | size | speed value | 
| ------ | ------- | ---- | ----------------|
| 0x03   | 0x64    | 0x02 | 16 bit signed   |

#### Response

Simple response

### CMD_SET_LINE_STATUS 0x65

#### Require

| device | command | size | busbar distance | busbar angle  | gap distance  | gap angle     | state          |
| ------ | ------- | ---- | ----------------| ------------- | ------------  | ------------- | -------------- |
| 0x03   | 0x65    | 0x08 | 16 bit signed   | 16 bit signed | 16 bit signed | 16 bit signed | 8 bit unsigned |

| state     | value |
| --------- | ----- |
| 正常       | 0x00  |
| 竖直有数据 | 0x01  |
| 水平有数据 | 0x02  |
| 异常       | 0x03  |

#### Response

Simple response

### CMD_MOTOR_SPEED 0x68

#### Require

| device | command | size |
| ------ | ------- | ---- |
| 0x03   | 0x68    | 0x00 |

#### Response

| command | size | left raw speed | right raw speed | average speed | move distance |
| ------- | ---- | ---------------| --------------- | --------------| ------------- |
| 0x68    | 0x0C | 32 bit signed  | 32 bit signed   | 16 bit signed | 16 bit signed |

### CMD_ATTITUDE 0x6C

#### Require

| device | command | size |
| ------ | ------- | ---- |
| 0x03   | 0x6C    | 0x00 |

#### Response

| command | size | yaw | pitch | roll | merge yaw |
| ------- | ---- | ---------------| --------------- | --------------| ------------- |
| 0x6C    | 0x08 | 16 bit signed  | 16 bit signed   | 16 bit signed | 16 bit signed |

### CMD_GET_REVEIVER 0x6E

#### Require

| device | command | size |
| ------ | ------- | ---- |
| 0x03   | 0x6E    | 0x00 |

#### Response

| command | size | thr | yaw | arm | mode | sucker | brush | failsafe |
| ------- | ---- | --- | --- | ----| ---- | -------| ----- | -------- |
| 0x6E    | 0x0E | 16 bit unsigned  | 16 bit unsigned   | 16 bit unsigned | 16 bit unsigned | 16 bit unsigned | 16 bit unsigned | 16 bit unsigned |

### CMD_FRAMERATE 0x6F

#### Require

| device | command | size | rotate value | 
| ------ | ------- | ---- | ----------------|
| 0x03   | 0x6F    | 0x02 | 16 bit signed   |

#### Response

Simple response

### CMD_BATTERY_STATE 0x82

#### Require

| device | command | size |
| ------ | ------- | ---- |
| 0x03   | 0x82    | 0x00 |

#### Response

| command | size | battery voltage | battery state |
| ------- | ---- | ----------------| -------------- |
| 0x82    | 0x03 | 16 bit unsigned | 8 bit unsigned |

电池电压为0.01V级

| battery state | value |
| ------------- | ----- |
| BATTERY_OK    | 0x00 |
| BATTERY_WARNING | 0x01 |
| BATTERY_CRITICAL | 0x02 |
| BATTERY_NOT_PRESENT | 0x03 |

### CMD_GET_TEMP 0x84

#### Require

| device | command | size |
| ------ | ------- | ---- |
| 0x03   | 0x84    | 0x00 |

#### Response

| command | size | temperature |
| ------- | ---- | ------------|
| 0x84    | 0x01 | 16 bit signed |

温度以10℃为一级

### CMD_GET_MOVE_STATUS 0x85

#### Require

| device | command | size |
| ------ | ------- | ---- |
| 0x03   | 0x85    | 0x00 |

#### Response

| command | size | move mode | path state |
| ------- | ---- | ------------| -------- |
| 0x85    | 0x02 | 8 bit unsigned | 8 bit unsigned |

### CMD_SET_CELL_INFO 0x86

#### Require

| device | command | size | cell width | cell type | run dir  |
| ------ | ------- | ---- | -----------| --------- | -------- |
| 0x03   | 0x86    | 0x04 | 16 bit unsigned | 8 bit unsigned | 8 bit unsigned |

cell width: 电池片短边宽度

cell type: 0 半片；1 全片

run dir: 0 沿着长边运动；1 沿着短边运动

#### Response

Simple response

## 配置命令细节

### MSP_GET_PWMVALUE 130

#### Require

| device | command | size |
| ------ | ------- | ---- |
| 0x02   | 130    | 0x00 |

#### Response

| device | command | size | pwmValue |
| ------ | ------- | ---- | -----------|
| 0x02   | 130    | 0x01 | 8 bit unsigned |

### MSP_GET_USE_FAN_LEVEL_DYNAMIC_COMP 131

#### Require

| device | command | size |
| ------ | ------- | ---- |
| 0x02   | 131    | 0x00 |

#### Response

| device | command | size | pwmvalueMax | pwmvalueMin|
| ------ | ------- | ---- | -----------|-----------|
| 0x02   | 131    | 0x02 | 8 bit unsigned |8 bit unsigned |

### MSP_GET_USE_FAN_OUTPUT_PID 132

#### Require

| device | command | size |
| ------ | ------- | ---- |
| 0x02   | 132    | 0x00 |

#### Response

| device | command | size | fanPwmvalueAtIdle | fanPwmvalueMin|fanPwmvalueMax|defaultTargetFanPwmvalue|maxTargetFanPwmvalue|minTargetFanPwmvalue|
| ------ | ------- | ---- | -----------|-----------|------- | ---- | -----------|-----------|
| 0x02   | 132    | 0x09 | 8 bit unsigned |8 bit unsigned |8 bit unsigned |16 bit unsigned |16 bit unsigned |16 bit unsigned |

### MSP_GET_MOTOR_VALUE 133

#### Require

| device | command | size |
| ------ | ------- | ---- |
| 0x02   | 133    | 0x00 |

#### Response

| device | command | size | minPwmValue | upMinPwmValue|
| ------ | ------- | ---- | -----------|-----------|
| 0x02   | 133    | 0x02 | 8 bit unsigned |8 bit unsigned |

### MSP_GET_BOUNDLESS 134

#### Require

| device | command | size |
| ------ | ------- | ---- |
| 0x02   | 134    | 0x00 |

#### Response

| device | command | size | fanThrdAddE | fanUpThrdAdd|hangCnt|
| ------ | ------- | ---- | -----------|-----------| -----------|
| 0x02   | 134    | 0x03 | 8 bit unsigned |8 bit unsigned |8 bit unsigned |

### MSP_GET_SPRAY_VALUE 135

#### Require

| device | command | size |
| ------ | ------- | ---- |
| 0x02   | 135    | 0x00 |

#### Response

| device | command | size | waterPump | waterPumpDuration|waterPumpStartAngle|waterPumpMoveCnt|
| ------ | ------- | ---- | -----------|-----------| -----------|-----------|
| 0x02   | 135    | 0x05 | 8 bit unsigned |16 bit unsigned |8 bit unsigned |8 bit unsigned |

### MSP_GET_GYRO_THRESHOLD 136

#### Require

| device | command | size |
| ------ | ------- | ---- |
| 0x02   | 136    | 0x00 |

#### Response

| device | command | size | gyroDiffThreshold | gyroThreshold|gyroUpDiffThreshold|gyroUpThreshold|
| ------ | ------- | ---- | -----------|-----------| -----------|-----------|
| 0x02   | 136    | 0x04 | 8 bit unsigned |8 bit unsigned |8 bit unsigned |8 bit unsigned |

### MSP_SET_PWMVALUE 220

#### Require

| device | command | size | pwmValue |
| ------ | ------- | ---- | -----------|
| 0x02   | 220    | 0x01 | 8 bit unsigned |

#### Response

Simple response

### MSP_SET_USE_FAN_LEVEL_DYNAMIC_COMP 221

#### Require

| device | command | size | pwmvalueMax | pwmvalueMin|
| ------ | ------- | ---- | -----------|-----------|
| 0x02   | 221    | 0x02 | 8 bit unsigned |8 bit unsigned |

#### Response

Simple response

### MSP_SET_USE_FAN_OUTPUT_PID 222

#### Require

| device | command | size | fanPwmvalueAtIdle | fanPwmvalueMin|fanPwmvalueMax|defaultTargetFanPwmvalue|maxTargetFanPwmvalue|minTargetFanPwmvalue|
| ------ | ------- | ---- | -----------|-----------|------- | ---- | -----------|-----------|
| 0x02   | 222    | 0x09 | 8 bit unsigned |8 bit unsigned |8 bit unsigned |16 bit unsigned |16 bit unsigned |16 bit unsigned |

#### Response

Simple response

### MSP_SET_MOTOR_VALUE 223

#### Require

| device | command | size | minPwmValue | upMinPwmValue|
| ------ | ------- | ---- | -----------|-----------|
| 0x02   | 223    | 0x02 | 8 bit unsigned |8 bit unsigned |

#### Response

Simple response

### MSP_SET_BOUNDLESS 224

#### Require

| device | command | size | fanThrdAddE | fanUpThrdAdd|hangCnt|
| ------ | ------- | ---- | -----------|-----------| -----------|
| 0x02   | 134    | 0x03 | 8 bit unsigned |8 bit unsigned |8 bit unsigned |

#### Response

Simple response

### MSP_SET_SPRAY_VALUE 225

#### Require

| device | command | size | waterPump | waterPumpDuration|waterPumpStartAngle|waterPumpMoveCnt|
| ------ | ------- | ---- | -----------|-----------| -----------|-----------|
| 0x02   | 225    | 0x05 | 8 bit unsigned |16 bit unsigned |8 bit unsigned |8 bit unsigned |

#### Response

Simple response

### MSP_SET_GYRO_THRESHOLD 226

#### Require

| device | command | size | gyroDiffThreshold | gyroThreshold|gyroUpDiffThreshold|gyroUpThreshold|
| ------ | ------- | ---- | -----------|-----------| -----------|-----------|
| 0x02   | 136    | 0x04 | 8 bit unsigned |8 bit unsigned |8 bit unsigned |8 bit unsigned |

#### Response

Simple response

