# 串口MSP协议
## 读取
| 类别 | 值 | 名称 | 具体字段 | 数值范围 | 描述 |
| ----------- | ----------- | ----------- |---|---|---|
| 风机 | 301 | MSP_GET_PWMVALUE | PWMVALUE | 0-100 | 设置风机占比 |
|  | 302 | MSP_GET_USE_FAN_LEVEL_DYNAMIC_COMP | USE_FAN_LEVEL_DYNAMIC_COMP | 存在 | 设置最大最小占比 |
|  |  |  | PWMVALUE_MAX | 0-100 | 最大占比 |
|   |   |   | PWMVALUE_MIN | 0-100 | 最小占比 |
|   | 303 | MSP_GET_USE_FAN_OUTPUT_PID | USE_FAN_OUTPUT_PID | 存在 | 使用恒压 |
|   |   |   | FAN_PWMVALUE_AT_IDLE | 0-100 | 缺省风机占比 |
|   |   |   | FAN_PWMVALUE_MIN | 0-100 | 风机最小占比 |
|   |   |   | FAN_PWMVALUE_MAX | 0-100 | 风机最大占比 |
|   |   |   | DEFAULT_TARGET_FAN_PWMVALUE | 0-100 | 缺省吸力 |
|   |   |   | MAX_TARGET_FAN_PWMVALUE | 0-100 | 最大吸力 |
|   |   |   | MIN_TARGET_FAN_PWMVALUE | 0-100 | 最小吸力 |
| 马达 | 304 | MSP_GET_MOTOR_VALUE | MIN_PWM_VALUE | 0-100 | 马达最小输出占比 |
|   |   |   | UP_MIN_PWM_VALUE | 0-100 | 向上马达最小输出占比 |
| 无边电流 | 305 | MSP_GET_BOUNDLESS | FAN_THRD_ADD | 0-200 | 正常行走阈值 |
|   |   |   | FAN_FAN_UP_THRD_ADD | 0-200 | 向上行走阈值 |
|   |   |   | FAN_HANG_CNT | 0-10 | 次数 |
| 喷水功能 | 306 | MSP_GET_SPRAY_VALUE | WATER_PUMP | 0,1 | 0不喷水；1支持喷水 |
|   |   |   | USE_LEFT_PUMP | 存在 | 支持左侧喷水口 |
|   |   |   | SPRAY_PWM | 0;1 | 0水泵；1雾化 |
|   |   |   | FAN_SPRAY_FREQ | 0-200 | 雾化片频率 |
|   |   |   | SPRAY_PWM_DUTY | 0-200 | 雾化片 |
|   |   |   | WATER_PUMP_DURATION | 0-500 | 喷水时间 |
|   |   |   | WATER_PUMP_START_ANGLE | 0-100 | 喷水角度 |
|   |   |   | WATER_PUMP_MOVE_CNT | 0-10 | 喷水间隔步数 |
| 陀螺仪 | 307 | MSP_GET_GYRO_THRESHOLD | GYRO_DIFF_THRESHOLD | 0-200 | 检测边缘陀螺仪变化值阈值 |
|   |   |   | GGYRO_THRESHOLD | 0-200 | 检测边缘堵转陀螺仪阈值 |
|   |   |   | GGYRO_UP_DIFF_THRESHOLD | 0-200 | 向上走边缘陀螺仪变化值阈值 |
|   |   |   | GGYRO_UP_THRESHOLD | 0-200 | 向上走边缘堵转陀螺仪阈值 |

---

## 设置
| 类别 | 值 | 名称 | 具体数值 | 数值范围 | 描述 |
|---|---|---|---|---|---|
| 风机 | 401 | MSP_SET_PWMVALUE | PWMVALUE | 0-100 | 设置风机占比 |
|   | 402 | MSP_SET_USE_FAN_LEVEL_DYNAMIC_COMP | USE_FAN_LEVEL_DYNAMIC_COMP | 存在 | 设置最大最小占比 |
|   |   |   | PWMVALUE_MAX | 0-100 | 最大占比 |
|   |   |   | PWMVALUE_MIN | 0-100 | 最小占比 |
|   | 403 | MSP_SET_USE_FAN_OUTPUT_PID | USE_FAN_OUTPUT_PID | 存在 | 使用恒压 |
|   |   |   | FAN_PWMVALUE_AT_IDLE | 0-100 | 缺省风机占比 |
|   |   |   | FAN_PWMVALUE_MIN | 0-100 | 风机最小占比 |
|   |   |   | FAN_PWMVALUE_MAX | 0-100 | 风机最大占比 |
|   |   |   | DEFAULT_TARGET_FAN_PWMVALUE | 0-100 | 缺省吸力 |
|   |   |   | MAX_TARGET_FAN_PWMVALUE | 0-100 | 最大吸力 |
|   |   |   | MIN_TARGET_FAN_PWMVALUE | 0-100 | 最小吸力 |
| 马达 | 404 | MSP_SET_MOTOR_VALUE | MIN_PWM_VALUE | 0-100 | 马达最小输出占比 |
|   |   |   | UP_MIN_PWM_VALUE | 0-100 | 向上马达最小输出占比 |
| 无边电流 | 405 | MSP_SET_BOUNDLESS | FAN_THRD_ADD | 0-200 | 正常行走阈值 |
|   |   |   | FAN_FAN_UP_THRD_ADD | 0-200 | 向上行走阈值 |
|   |   |   | FAN_HANG_CNT | 0-10 | 次数 |
| 喷水功能 | 406 | MSP_SET_SPRAY_VALUE | WATER_PUMP | 0,1 | 0不喷水；1支持喷水 |
|   |   |   | USE_LEFT_PUMP | 存在 | 支持左侧喷水口 |
|   |   |   | SPRAY_PWM | 0;1 | 0水泵；1雾化 |
|   |   |   | FAN_SPRAY_FREQ | 0-200 | 雾化片频率 |
|   |   |   | SPRAY_PWM_DUTY | 0-200 | 雾化片 |
|   |   |   | WATER_PUMP_DURATION | 0-500 | 喷水时间 |
|   |   |   | WATER_PUMP_START_ANGLE | 0-100 | 喷水角度 |
|   |   |   | WATER_PUMP_MOVE_CNT | 0-10 | 喷水间隔步数 |
| 陀螺仪 | 407 | MSP_SET_GYRO_THRESHOLD | GYRO_DIFF_THRESHOLD | 0-200 | 检测边缘陀螺仪变化值阈值 |
|   |   |   | GGYRO_THRESHOLD | 0-200 | 检测边缘堵转陀螺仪阈值 |
|   |   |   | GGYRO_UP_DIFF_THRESHOLD | 0-200 | 向上走边缘陀螺仪变化值阈值 |
|   |   |   | GGYRO_UP_THRESHOLD | 0-200 | 向上走边缘堵转陀螺仪阈值 |

---