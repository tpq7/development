# 宏定义

## Object-like （对象替换宏）
一个对象替换宏是一个标识，用来替换一个代码段，之所以叫对象替换，因为看起来像是在代码中的使用的一个数据对象。一般用来为数字常量提供符号名称。

您可以使用“#define”指令创建宏。‘#define’后面是宏的名称。接下来的缩写片段就是宏的主体、扩展或替换列表，例如：
```
#define BUFFER_SIZE 1024
```

定义一个宏的名称为**BUFFER_SIZE**为1024的缩写。如果在‘#define’的后面某个地方出现这样性的是C语句
```
foo = (char *) malloc (BUFFER_SIZE);
```
那么C预处理器就会识别并扩展宏**BUFFER_SIZE**。C编译器将会识别为以下形式
```
foo = (char *) malloc (1024);
```
为了方便，宏定义的名称都是大写的。这样看程序就会更容易阅读。

宏的主体在“#define”行的末尾结束。如有必要，可以使用反斜杠换行符在多行上继续定义。但是，当宏展开时，它将全部显示在一行上。例如:

```
#define NUMBERS 1, \
                2, \
                3
int x[] = { NUMBERS };
     → int x[] = { 1, 2, 3 };
```     
The most common visible consequence of this is surprising line numbers in error messages.

如果宏的主体部分能分解为有效的预处理标记，则对宏体中可以包含的内容没有限制。主体不需要类似有效的C代码。（如果没有，则在使用宏时可能会从C编译器获得错误消息。）

C预处理器按顺序扫描程序。宏定义在编写它们的地方生效。因此，以下输入将会被C预处理器
```
foo = X;
#define X 4
bar = X;
```
理解为
```
foo = X;
bar = 4;
```
预处理器展开宏名称时，宏的展开将替换宏调用，然后检查展开是否有更多宏要展开。例如

```
#define TABLESIZE BUFSIZE
#define BUFSIZE 1024
TABLESIZE
     → BUFSIZE
     → 1024
```
**TABLESIZE** 先会展开为**BUFSIZE**， 然后**BUFSIZE**继续展开，最终结果为1024.

注意当**TABLESIZE**定义时， **BUFSIZE**还没有定义。**TABLESIZE** 的“#define”完全使用您指定的扩展（在本例中为 **BUFSIZE**），并且不检查它是否也包含宏名称。只有当您使用 **TABLESIZE** 时，才会扫描其扩展的结果以获取更多宏名称。


如果您在源文件中的某个点更改 **BUFSIZE** 的定义，这会有所不同。 **TABLESIZE**，如图所示定义，将始终使用当前有效的 **BUFSIZE** 定义进行扩展：
```
#define BUFSIZE 1020
#define TABLESIZE BUFSIZE
#undef BUFSIZE
#define BUFSIZE 37
```

现在 **TABLESIZE** 扩展（分两个阶段）到 37。


## Function-like Macros （函数替换宏）

您还可以定义使用看起来像函数调用的宏。这些被称为函数替换宏。要定义一个函数替换的宏，您可以使用相同的‘#define’指令，但您在宏名称之后立即放置一对括号。例如，
```
#define lang_init()  c_init()
lang_init()
     → c_init()
```
函数替换的宏只有在其名称后面有一对括号时才会被扩展。如果你只写名字，它就不管了。当您有一个函数和一个同名的宏，并且您有时希望使用该函数时，这会很有用。

```
extern void foo(void);
#define foo() /* optimized inline version */
…
  foo();
  funcptr = foo;
```
这里对 `foo()` 的调用将使用宏，但函数指针将获得实际函数的地址。如果要扩展宏，则会导致语法错误。

如果您在宏定义中的宏名称和括号之间放置空格，则它不定义函数替换宏，它定义了对象替换宏，其扩展恰好以一对括号开头。

```
#define lang_init ()    c_init()
lang_init()
     → () c_init()()
```
这个扩展中的前两对括号来自宏。第三个是`lang_init`自身后面的括号。由于 lang_init 是一个对象替换的宏，它不使用这些括号。

## 宏定义形参

类似于带参数的函数一样，可以将函数形参用宏代替。
例如，取两个数中的最小数

```
#define min(X, Y)  ((X) < (Y) ? (X) : (Y))
  x = min(a, b);          →  x = ((a) < (b) ? (a) : (b));
  y = min(1, 2);          →  y = ((1) < (2) ? (1) : (2));
  z = min(a + 28, *p);    →  z = ((a + 28) < (*p) ? (a + 28) : (*p));
```


## 字符串化宏

在函数式宏定义中，如果替换列表中有'#', 则其后的预处理记号必须是当前宏的形参。在预处理期间，'#'连同后面的形参一起被实参取代。例如

```
#include <stdio.h>
#define PSQR(x) printf("The square of " #x" is %d.\n", ((x) * (x)))
int main(void)
{
     int y = 5;
     PSQR(y);
     PSQR(2 + 4);
     PSQR( 3 * 2 );
     return 0;
}
```
程序运行结果如下：
```
The square of y is 25.
The square of 2 + 4 is 36.
The square of 3 * 2 is 36.
```

## 连接符
宏定义连接符##用于将两个字符文本连接成一个字符文本。
宏定义连接符##的使用场景
在需要动态生成变量名时，可以使用连接符##来拼接变量名和变量值。
例如
```
#define CONNECT(x, y) x##y
int xy = 100;
int main(void) 
{
    int result = CONNECT(x, y);
    printf("%d", result);
    return 0;
}

```
CONNECT(x, y) 相当于 xy，所以结果为100

