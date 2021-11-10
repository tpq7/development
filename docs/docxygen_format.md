# Doxygen C 注释模板 

## 注释模板使用Javadoc风格的注释
```
/**
 * ... text ...
 */
```

## 文件注释模板
```
/**
* @file      文件名称 
* @brief     文件功能描述
* @author    作者
* @date      创建日期 
* @version   版本 例如：V1.0.0
* @copyright 版权                                                                
*/
```

## 函数注释模板
```
/** 
 * @brief        函数功能的描述
 * @param[in]    param1:    参数的描述      param1为实际函数参数名称
 * @param[out]   param2:    输出数据的描述  param2为实际函数参数名称
 * @retval 返回描述:
 *           - result1: 返回结果1描述
 *           - result2: 返回结果2描述
 * @note   函数需注意的描述
 */ 
```

## 枚举注释模板
```
/** 
* @brief This is an enum class
*/
enum class fooenum {
    FOO, ///< this is foo
    BAR, ///< this is bar
};
```

## 结构体注释模板
```
/** 
* @brief This is a struct
*/
typedef struct {
    int foo; ///< xxx
    int bar; ///< xxx
    char *baz; ///< xxx
} whatsit;
```

## 变量注释模板
```
uint8_t var;///< xxx
```

## 宏注释模板
1. 单个宏注释
```
#define PI XXX ///< xxx
```
2. 一组同类型宏注释
```
/**
 * @defgroup 宏描述
 * @{
 */

#define GPIO_Pin_0 XXX  ///< xxx
#define GPIO_Pin_1 XXX  ///< xxx
#define GPIO_Pin_2 XXX  ///< xxx

/** 
 * @}
 */
```
