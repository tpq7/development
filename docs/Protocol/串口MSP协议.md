## 串口MSP协议

### 客户端包 Client Packages

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

### 响应包 Responce Packages

\<preamble>,\<option>,\<command>,\<size>,\<data>,\<crc>
| 项 | 描述 | 注释 |
| ----------- | ----------- | ----------- |
| preamble | 包的序言 | 总是为 0xFF |
| option | 包的选择 | 当这是一个确认时设置为0xFF，当这是一个异步消息时设置为0xFE |
| command | 包命令 | 见下文 |
| size | 数据所占字节数 | |
| data | 数据 | 命令附带的可选数据 |
| crc | crc 校验和 | \<device>,\<command>,\<size>的异或运算，将每个数据字节归为零和 |

### 设备码 Device Code

| 值 | 名称 |
| ----- | ---- |
| 0x00 | DCODE_CORE |
| 0x03 | DCODE_SOLAR_CLEANBOT |

### 核心命令 Core Command

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

### 命令 Command

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

### API 命令细节 API Command Detial

#### Command 

CMD_RANGEFINDER 0x61

| device | command | size |
| ------ | ------- | ---- |
| 0x03   | 0x61    | 0x00 |

#### Response

| command | size | left front | right front | left back | right back | sample rate |
| ------- | ---- | -----------| ----------- | ----------| ---------- | ----------  |
| 0x61    | 0x0A | 16 bit unsigned  | 16 bit unsigned | 16 bit unsigned | 16 bit unsigned | 16 bit unsigned |

#### Command

CMD_SET_HEARTBEAT 0x62

| device | command | size | rotate value | 
| ------ | ------- | ---- | ----------------|
| 0x03   | 0x62    | 0x02 | 16 bit signed   |

#### Response

Simple response

#### Command

CMD_SET_ROTATE 0x63

| device | command | size | rotate value | 
| ------ | ------- | ---- | ----------------|
| 0x03   | 0x63    | 0x02 | 16 bit signed   |

#### Response

Simple response

#### Command

CMD_SET_SPEED 0x64

| device | command | size | speed value | 
| ------ | ------- | ---- | ----------------|
| 0x03   | 0x64    | 0x02 | 16 bit signed   |

#### Response

Simple response

#### Command

CMD_SET_LINE_STATUS 0x65

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

#### Command

CMD_MOTOR_SPEED 0x68

| device | command | size |
| ------ | ------- | ---- |
| 0x03   | 0x68    | 0x00 |

#### Response

| command | size | left raw speed | right raw speed | average speed | move distance |
| ------- | ---- | ---------------| --------------- | --------------| ------------- |
| 0x68    | 0x0C | 32 bit signed  | 32 bit signed   | 16 bit signed | 16 bit signed |

#### Command

CMD_ATTITUDE 0x6C

| device | command | size |
| ------ | ------- | ---- |
| 0x03   | 0x6C    | 0x00 |

#### Response

| command | size | yaw | pitch | roll | merge yaw |
| ------- | ---- | ---------------| --------------- | --------------| ------------- |
| 0x6C    | 0x08 | 16 bit signed  | 16 bit signed   | 16 bit signed | 16 bit signed |

#### Command

CMD_GET_REVEIVER 0x6E

| device | command | size |
| ------ | ------- | ---- |
| 0x03   | 0x6E    | 0x00 |

#### Response

| command | size | thr | yaw | arm | mode | sucker | brush | failsafe |
| ------- | ---- | --- | --- | ----| ---- | -------| ----- | -------- |
| 0x6E    | 0x0E | 16 bit unsigned  | 16 bit unsigned   | 16 bit unsigned | 16 bit unsigned | 16 bit unsigned | 16 bit unsigned | 16 bit unsigned |

#### Command

CMD_FRAMERATE 0x6F

| device | command | size | rotate value | 
| ------ | ------- | ---- | ----------------|
| 0x03   | 0x6F    | 0x02 | 16 bit signed   |

#### Response

Simple response

#### Command

CMD_BATTERY_STATE 0x82

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

#### Command

CMD_GET_TEMP 0x84

| device | command | size |
| ------ | ------- | ---- |
| 0x03   | 0x84    | 0x00 |

#### Response

| command | size | temperature |
| ------- | ---- | ------------|
| 0x84    | 0x01 | 16 bit signed |

温度以10℃为一级

#### Command

CMD_GET_MOVE_STATUS 0x85

| device | command | size |
| ------ | ------- | ---- |
| 0x03   | 0x85    | 0x00 |

#### Response

| command | size | move mode | path state |
| ------- | ---- | ------------| -------- |
| 0x85    | 0x02 | 8 bit unsigned | 8 bit unsigned |

#### Command

CMD_SET_CELL_INFO 0x86

| device | command | size | cell width | cell type | run dir  |
| ------ | ------- | ---- | -----------| --------- | -------- |
| 0x03   | 0x86    | 0x04 | 16 bit unsigned | 8 bit unsigned | 8 bit unsigned |

cell width: 电池片短边宽度

cell type: 0 半片；1 全片

run dir: 0 沿着长边运动；1 沿着短边运动

#### Response

Simple response
