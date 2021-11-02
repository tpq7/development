# C Coding Style

本文档翻译改编自cleanflight代码风格：[https://github.com/betaflight/betaflight/blob/master/docs/development/CodingStyle.md](https://github.com/betaflight/betaflight/blob/master/docs/development/CodingStyle.md)

## Formatting style

### 缩进

[1TBS](https://en.wikipedia.org/wiki/Indentation_style#Variant:_1TBS_(OTBS)) (based K&R) 4个空格缩进，没有硬件制表符(所有制表符都用空格代替)。

### Tool support

Any of these tools can get you pretty close:

Eclipse built in "K&R" style, after changing the indent to 4 spaces and change Braces after function declarations to Next line.
```
astyle --style=kr --indent=spaces=4 --min-conditional-indent=0 --max-instatement-indent=80 --pad-header --pad-oper --align-pointer=name --align-reference=name --max-code-length=120 --convert-tabs --preserve-date --suffix=none --mode=c
```
```
indent -kr -i4 -nut
```
(the options for these commands can be tuned more to comply even better)

Note: These tools are not authorative.
Sometimes, for example, you may want other columns and line breaks so it looks like a matrix.

Note2: The Astyle settings have been tested and will produce a nice result. Many files will be changed, mostly to the better but maybe not always, so use with care. 

### 大括号

函数在下一行的开始处应该有一个大括号。
```
int function(int x)
{
    body of function
}
```

所有非函数语句块(if、switch、for)的左大括号应该放在同一行最后，接下来的语句从下一行开始。

右大括号只能在代码块中最后一条语句的下一行。

```
if (x is true) {
    we do y
    ...
}
```

```
switch (action) {
case ADD:
    return "add";
case REMOVE:
    return "remove";
case CHANGE:
    return "change";
default:
    return NULL;
}
```

如果后面跟着`else`或者`else if`，则应该放在右大括号的同一行，且再次将左大括号放在同一行上。
```
if (x is true) {
    we do y
    ...
} else {
    we do z
    ...
}
```

Omission of "unnecessary" braces in cases where an `if` or `else` block consists only of a single statement is not permissible in any case. These "single statement blocks" are future bugs waiting to happen when more statements are added without enclosing the block in braces.
在`if`或`else`块只包含一条语句的情况下，不允许省略“不必要的”大括号。这些“单条语句块”可能是未来的一个bug，比如当更多的语句被添加时，你可能会忘了用大括号把语句括起来。

### 空格

在(大多数)关键字之后添加一个空格。值得注意的一些例外情况包括sizeof、typeof、alignof和__attribute__，它们看起来有点像函数(通常与括号一起使用)。因此，在以下关键词后加上空格:
```
if, switch, case, for, do, while
```
但不适用于sizeof, typeof, alignof, 或者 __attribute__ 等关键词。
```
s = sizeof(struct file);
```
当定义指针数据或返回指针类型的函数时，‘*’应靠近数据名称或函数名称，而不是类型名称。例如：
```
char *linux_banner;
memparse(char *ptr, char **retptr);
char *match_strdup(substring_t *s);
```
在大多数二元和三元运算符前后各使用一个空格，比如下面的任何一个:
```
=  +  -  <  >  *  /  %  |  &  ^  <=  >=  ==  !=  ?  :
```
但一元运算符后没有空格:
```
&  *  +  -  ~  !  sizeof  typeof  alignof  __attribute__  defined
```
在递增和递减一元运算符前后都不要有空格
```
++  --
```
 '.' 和 "->" 结构成员操作符前后没有空格

'*' 和 '&', 当用作指针和引用时，它和后面的变量名之间应该没有空格。

## typedef

没有计数或其他终止符元素的枚举应该在最后一个元素后加一个逗号:

```
typedef enum {
    MSP_RESULT_ACK = 1,
    MSP_RESULT_ERROR = -1,
    MSP_RESULT_NO_REPLY = 0,
    MSP_RESULT_CMD_UNKNOWN = -2,
} mspResult_e;
```

这确保了，如果在以后要添加更多的成员，那么在复查中只会显示额外的行，从而使复查更容易。

有计数的枚举应该将计数声明为枚举列表中的最后一项，这样它就会被自动维护，例如:
```
typedef enum {
    PID_CONTROLLER_MW23 = 0,
    PID_CONTROLLER_MWREWRITE,
    PID_CONTROLLER_LUX_FLOAT,
    PID_COUNT
} pidControllerType_e;
```
之后就不用再计算，例如使用PID_CONTROLLER_LUX_FLOAT + 1;

typedef 结构体定义应包含结构体名称，以便可以前向引用该类型，如:
```
typedef struct motorMixer_s {
    float throttle;
...
    float yaw;
} motorMixer_t;
```
motorMixer_s名称是必需的。

## 变量

### 命名


通常情况下，具有描述性的小驼峰（lowerCamelCase）名称是函数名、变量、参数等的理想选择。对于用户可以通过CLl或类似方式访问的配置变量，最好使用带下划线的小写字母（_lowercase）。

变量名应该是名词。

作用域很小的简单临时变量可能会很简短，但这样符合惯例。比如在`for`循环中将”i“作为临时计数器，如`for (int i = 0; i < 4; i++)`。在这种情况下使用“temporaryCounter”不会提高可读性。

### 声明

避免全局变量。

变量应该在使用变量的最小作用域的顶部声明。应避免变量的重复使用 —— 当他们的作用不相关时，应定义不同的变量。定义后面应有一行空行。

提示：有时你可以创建一个块，即添加大括号，以进一步缩小范围。例如，将变量范围限制为单个`case`分支。

Variables with limited use may be declared at the point of first use. It makes PR-review easier (but that point is lost if the variable is used everywhere anyway).
使用有限的变量可以在第一次使用时声明。它使的代码review更容易（但是如果到处都使用这个变量，这一点就不适用了）。

### 初始化

The pattern with "lazy initialisation" may be advantageous in the Configurator to speed up the start when the initialisation is "expensive" in some way.
In the FC, however, it’s always better to use some milliseconds extra before take-off than to use them while flying.

不要使用”lazy initialisation“。

最好使用显式的“init”函数。

### 数据类型

注意使用的数据类型，不要相信隐式类型转换一定正确。

角度有时会用浮点型的度来表示。有时又会用uint8_t的十进制度。你需要时刻注意。

避免隐式双转换，只使用浮点参数函数。

不要直接使用sin() 和 cos()函数，尽量使用近似的效率更高的替代函数。

浮点型的常量需要有”f“后缀，如 1.0f 和 3.1415926f，否则可能会发送重复转换。

## 函数

### 命名

Methods that return a boolean should be named as a question, and should not change any state. e.g. 'isOkToArm()'.

Methods should have verb or verb-phrase names, like deletePage or save. Tell the system to 'do' something 'with' something. e.g. deleteAllPages(pageList).

Non-static functions should be prefixed by their class. Eg baroUpdate and not updateCompass .

Groups of functions acting on an 'object' should share the same prefix, e.g.
```
float biQuadFilterApply(...);
void biQuadFilterInit(...);
boolean biQuadIsReady();
```
rather than
```
float applyBiQuadFilter(...);
void newBiQuadLpf(...);
boolean isBiQuadReady();
```

### Parameter order

Data should move from right to left, as in memcpy(void *dst, const void *src, size\_t size).
This also mimics the assignment operator (e.g. dst = src;)

When a group of functions act on an 'object' then that object should be the first parameter for all the functions, e.g.:
```
float biQuadFilterApply(biquad_t *state, float sample);
void biQuadNewLpf(biquad_t *state, float filterCutFreq, uint32_t refreshRate);
```
rather than
```
float biQuadFilterApply(float sample, biquad_t *state);
void biQuadNewLpf(float filterCutFreq, biquad_t *state, uint32_t refreshRate);
```

### Declarations

Functions not used outside their containing .c file should be declared static (or STATIC\_UNIT\_TESTED so they can be used in unit tests).

Non-static functions should have their declaration in a single .h file.

Don't make more than necessary visible for other modules, not even types. Pre-processor macros may be used to declare module internal things that must be shared with the modules test code but otherwise hidden.

In the .h file:
```
#ifdef MODULENAME_INTERNALS_
… declarations …
#endif
```
In the module .c file, and in the test file but nowhere else, put `#define MODULENAME_INTERNALS_` just before including the .h file.

Note: You can get the same effect by putting the internals in a separate .h file.

### Implementation

Keep functions short and distinctive.
Think about unit test when you define your functions. Ideally you should implement the test cases before implementing the function.

Never put multiple statements on a single line.
Never put multiple assignments on a single line.
Never put multiple assignments in a single statement.

Defining constants using pre-processor macros is not preferred.
Const-correctness should be enforced.
This allows some errors to be picked up at compile time (for example getting the order of the parameters wrong in a call to memcpy).

A function should only read data from the HW once in each call, and preferably all at one place.
For example, if gyro angle or time is needed multiple times, read once and store in a local variable.

Use `for` loops (rather than `do` or `while` loops) for iteration.

The use of `continue` or `goto` should be avoided.
Same for multiple `return` from a function and multiple `break` inside a `case`.
In general, they reduce readability and maintainability.
In rare cases such constructs can be justified but only when you have considered and understood the alternatives and still have a strong reason.

In expressions, parentheses should only be used where they are required, i.e. where operator precedence will not evaluate in the right order, or where a compiler warning is triggered without parentheses. This brings all expressions into a canonical form, and avoids the problem of different developers having different ideas of what 'easy to read' expressions are.

One exception to this rule is the ternary conditional operator

```
pidStabilisationEnabled = (pidControllerState == PID_STABILISATION_ON) ? true : false
```

Here, the condition shall be enclosed in braces, to make the ternary operator easier to spot when reading left to right.

## Includes

All files must include their own dependencies and not rely on includes from the included files or that some other file was included first.

Do not include things you are not using.

"[#pragma once](https://en.wikipedia.org/wiki/Pragma_once)" is preferred over "#include guards" to avoid multiple includes.


## Other details

No trailing whitespace at the end of lines or at blank lines.

Stay within 120 columns, unless exceeding 120 columns significantly increases readability and does not hide information.
(Less is acceptable. More than 140 makes it difficult to read on Github so that shall never be exceeded.)

Take maximum possible advantage of compile time checking, so generally warnings should be as strict as possible.

Don't call or reference "upwards". That is don't call or use anything in a software layer that is above the current layer. The software layers are not that obvious, but we can certainly say that device drivers are the bottom layer and so should not call or use anything outside the device drivers.

Target specific code (e.g. #ifdef CC3D) is not permissible outside of the `src/main/target` directory.

`typedef void handlerFunc(void);` is easier to read than `typedef void (*handlerFuncPtr)(void);`.

Code should be spherical.
That is its surface area (public interfaces) relative to its functionality should be minimised.
Which is another way of saying that the public interfaces shall be easy to use,
do something essential and all implementation should be hidden and unimportant to the user

Code should work in theory as well as in practice.
It should be based on sound mathematical, physical or computer science principles rather than just heuristics.
This is important for test code too. Tests shall be based on such principles and real-world properties so they don't just test the current implementation as it happens to be.

Guidelines not tramlines: guidelines are not totally rigid - they can be broken when there is good reason.
