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
The C preprocessor scans your program sequentially. Macro definitions take effect at the place you write them. Therefore, the following input to the C preprocessor
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

## Macro Arguments

Function-like macros can take arguments, just like true functions. To define a macro that uses arguments, you insert parameters between the pair of parentheses in the macro definition that make the macro function-like. The parameters must be valid C identifiers, separated by commas and optionally whitespace.

To invoke a macro that takes arguments, you write the name of the macro followed by a list of actual arguments in parentheses, separated by commas. The invocation of the macro need not be restricted to a single logical line—it can cross as many lines in the source file as you wish. The number of arguments you give must match the number of parameters in the macro definition. When the macro is expanded, each use of a parameter in its body is replaced by the tokens of the corresponding argument. (You need not use all of the parameters in the macro body.)

As an example, here is a macro that computes the minimum of two numeric values, as it is defined in many C programs, and some uses.

```
#define min(X, Y)  ((X) < (Y) ? (X) : (Y))
  x = min(a, b);          →  x = ((a) < (b) ? (a) : (b));
  y = min(1, 2);          →  y = ((1) < (2) ? (1) : (2));
  z = min(a + 28, *p);    →  z = ((a + 28) < (*p) ? (a + 28) : (*p));
```

(In this small example you can already see several of the dangers of macro arguments. See Macro Pitfalls, for detailed explanations.)

Leading and trailing whitespace in each argument is dropped, and all whitespace between the tokens of an argument is reduced to a single space. Parentheses within each argument must balance; a comma within such parentheses does not end the argument. However, there is no requirement for square brackets or braces to balance, and they do not prevent a comma from separating arguments. Thus,

```
macro (array[x = y, x + 1])
```

passes two arguments to `macro: array[x = y` and `x + 1]`. If you want to supply `array[x = y, x + 1]` as an argument, you can write it as `array[(x = y, x + 1)]`, which is equivalent C code.

All arguments to a macro are completely macro-expanded before they are substituted into the macro body. After substitution, the complete text is scanned again for macros to expand, including the arguments. This rule may seem strange, but it is carefully designed so you need not worry about whether any function call is actually a macro invocation. You can run into trouble if you try to be too clever, though. See Argument Prescan, for detailed discussion.

For example, `min (min (a, b), c)` is first expanded to

```
min (((a) < (b) ? (a) : (b)), (c))
```

and then to

```
((((a) < (b) ? (a) : (b))) < (c)
 ? (((a) < (b) ? (a) : (b)))
 : (c))
```

(Line breaks shown here for clarity would not actually be generated.)

You can leave macro arguments empty; this is not an error to the preprocessor (but many macros will then expand to invalid code). You cannot leave out arguments entirely; if a macro takes two arguments, there must be exactly one comma at the top level of its argument list. Here are some silly examples using `min:`

```
min(, b)        → ((   ) < (b) ? (   ) : (b))
min(a, )        → ((a  ) < ( ) ? (a  ) : ( ))
min(,)          → ((   ) < ( ) ? (   ) : ( ))
min((,),)       → (((,)) < ( ) ? ((,)) : ( ))

min()      error→ macro "min" requires 2 arguments, but only 1 given
min(,,)    error→ macro "min" passed 3 arguments, but takes just 2
```

Whitespace is not a preprocessing token, so if a macro `foo` takes one argument, `foo ()` and `foo ( )` both supply it an empty argument. Previous GNU preprocessor implementations and documentation were incorrect on this point, insisting that a function-like macro that takes a single argument be passed a space if an empty argument was required.

Macro parameters appearing inside string literals are not replaced by their corresponding actual arguments.

```          
#define foo(x) x, "x"
foo(bar)        → bar, "x"
```

## Stringizing

Sometimes you may want to convert a macro argument into a string constant. Parameters are not replaced inside string constants, but you can use the ‘#’ preprocessing operator instead. When a macro parameter is used with a leading ‘#’, the preprocessor replaces it with the literal text of the actual argument, converted to a string constant. Unlike normal parameter replacement, the argument is not macro-expanded first. This is called stringizing.

There is no way to combine an argument with surrounding text and stringize it all together. Instead, you can write a series of adjacent string constants and stringized arguments. The preprocessor replaces the stringized arguments with string constants. The C compiler then combines all the adjacent string constants into one long string.

Here is an example of a macro definition that uses stringizing:

```
#define WARN_IF(EXP) \
do { if (EXP) \
        fprintf (stderr, "Warning: " #EXP "\n"); } \
while (0)
WARN_IF (x == 0);
     → do { if (x == 0)
           fprintf (stderr, "Warning: " "x == 0" "\n"); } while (0);
```

The argument for `EXP` is substituted once, as-is, into the if statement, and once, stringized, into the argument to `fprintf`. If `x` were a macro, it would be expanded in the `if` statement, but not in the string.

The `do` and `while (0)` are a kludge to make it possible to write `WARN_IF (arg)`;, which the resemblance of `WARN_IF` to a function would make C programmers want to do; see Swallowing the Semicolon.

Stringizing in C involves more than putting double-quote characters around the fragment. The preprocessor backslash-escapes the quotes surrounding embedded string constants, and all backslashes within string and character constants, in order to get a valid C string constant with the proper contents. Thus, stringizing `p = "foo\n"`; results in `"p = \"foo\\n\";"`. However, backslashes that are not inside string or character constants are not duplicated: `‘\n’` by itself stringizes to `"\n"`.

All leading and trailing whitespace in text being stringized is ignored. Any sequence of whitespace in the middle of the text is converted to a single space in the stringized result. Comments are replaced by whitespace long before stringizing happens, so they never appear in stringized text.

There is no way to convert a macro argument into a character constant.

If you want to stringize the result of expansion of a macro argument, you have to use two levels of macros.

```
#define xstr(s) str(s)
#define str(s) #s
#define foo 4
str (foo)
     → "foo"
xstr (foo)
     → xstr (4)
     → str (4)
     → "4"
```

`s` is stringized when it is used in `str`, so it is not macro-expanded first. But `s` is an ordinary argument to `xstr`, so it is completely macro-expanded before `xstr` itself is expanded (see Argument Prescan). Therefore, by the time `str` gets to its argument, it has already been macro-expanded.

## Concatenation

It is often useful to merge two tokens into one while expanding macros. This is called token pasting or token concatenation. The `‘##’` preprocessing operator performs token pasting. When a macro is expanded, the two tokens on either side of each `‘##’` operator are combined into a single token, which then replaces the `‘##’` and the two original tokens in the macro expansion. Usually both will be identifiers, or one will be an identifier and the other a preprocessing number. When pasted, they make a longer identifier. This isn’t the only valid case. It is also possible to concatenate two numbers (or a number and a name, such as `1.5` and `e3`) into a number. Also, multi-character operators such as `+=` can be formed by token pasting.

However, two tokens that don’t together form a valid token cannot be pasted together. For example, you cannot concatenate `x` with `+` in either order. If you try, the preprocessor issues a warning and emits the two tokens. Whether it puts white space between the tokens is undefined. It is common to find unnecessary uses of `‘##’` in complex macros. If you get this warning, it is likely that you can simply remove the `‘##’`.

Both the tokens combined by `‘##’` could come from the macro body, but you could just as well write them as one token in the first place. Token pasting is most useful when one or both of the tokens comes from a macro argument. If either of the tokens next to an `‘##’` is a parameter name, it is replaced by its actual argument before `‘##’` executes. As with stringizing, the actual argument is not macro-expanded first. If the argument is empty, that `‘##’` has no effect.

Keep in mind that the C preprocessor converts comments to whitespace before macros are even considered. Therefore, you cannot create a comment by concatenating `‘/’` and `‘*’`. You can put as much whitespace between `‘##’` and its operands as you like, including comments, and you can put comments in arguments that will be concatenated. However, it is an error if `‘##’` appears at either end of a macro body.

Consider a C program that interprets named commands. There probably needs to be a table of commands, perhaps an array of structures declared as follows:

```
struct command
{
  char *name;
  void (*function) (void);
};
```

```
struct command commands[] =
{
  { "quit", quit_command },
  { "help", help_command },
  …
};
```

It would be cleaner not to have to give each command name twice, once in the string constant and once in the function name. A macro which takes the name of a command as an argument can make this unnecessary. The string constant can be created with stringizing, and the function name by concatenating the argument with `‘_command’`. Here is how it is done:

```
#define COMMAND(NAME)  { #NAME, NAME ## _command }

struct command commands[] =
{
  COMMAND (quit),
  COMMAND (help),
  …
};
```

## Variadic Macros

A macro can be declared to accept a variable number of arguments much as a function can. The syntax for defining the macro is similar to that of a function. Here is an example:

```
#define eprintf(...) fprintf (stderr, __VA_ARGS__)
```

This kind of macro is called variadic. When the macro is invoked, all the tokens in its argument list after the last named argument (this macro has none), including any commas, become the variable argument. This sequence of tokens replaces the identifier __VA_ARGS__ in the macro body wherever it appears. Thus, we have this expansion:

```
eprintf ("%s:%d: ", input_file, lineno)
     →  fprintf (stderr, "%s:%d: ", input_file, lineno)
```

The variable argument is completely macro-expanded before it is inserted into the macro expansion, just like an ordinary argument. You may use the ‘#’ and ‘##’ operators to stringize the variable argument or to paste its leading or trailing token with another token. (But see below for an important special case for ‘##’.)

If your macro is complicated, you may want a more descriptive name for the variable argument than __VA_ARGS__. CPP permits this, as an extension. You may write an argument name immediately before the ‘...’; that name is used for the variable argument. The eprintf macro above could be written

```
#define eprintf(args...) fprintf (stderr, args)
```

using this extension. You cannot use __VA_ARGS__ and this extension in the same macro.

You can have named arguments as well as variable arguments in a variadic macro. We could define eprintf like this, instead:

```
#define eprintf(format, ...) fprintf (stderr, format, __VA_ARGS__)
```

This formulation looks more descriptive, but historically it was less flexible: you had to supply at least one argument after the format string. In standard C, you could not omit the comma separating the named argument from the variable arguments. (Note that this restriction has been lifted in C++2a, and never existed in GNU C; see below.)

Furthermore, if you left the variable argument empty, you would have gotten a syntax error, because there would have been an extra comma after the format string.

```
eprintf("success!\n", );
     → fprintf(stderr, "success!\n", );
```

This has been fixed in C++2a, and GNU CPP also has a pair of extensions which deal with this problem.

First, in GNU CPP, and in C++ beginning in C++2a, you are allowed to leave the variable argument out entirely:

```          
eprintf ("success!\n")
     → fprintf(stderr, "success!\n", );
```

Second, C++2a introduces the __VA_OPT__ function macro. This macro may only appear in the definition of a variadic macro. If the variable argument has any tokens, then a __VA_OPT__ invocation expands to its argument; but if the variable argument does not have any tokens, the __VA_OPT__ expands to nothing:

```
#define eprintf(format, ...) \
  fprintf (stderr, format __VA_OPT__(,) __VA_ARGS__)
```

__VA_OPT__ is also available in GNU C and GNU C++.

Historically, GNU CPP has also had another extension to handle the trailing comma: the ‘##’ token paste operator has a special meaning when placed between a comma and a variable argument. Despite the introduction of __VA_OPT__, this extension remains supported in GNU CPP, for backward compatibility. If you write

```
#define eprintf(format, ...) fprintf (stderr, format, ##__VA_ARGS__)
```

and the variable argument is left out when the eprintf macro is used, then the comma before the ‘##’ will be deleted. This does not happen if you pass an empty argument, nor does it happen if the token preceding ‘##’ is anything other than a comma.

```
eprintf ("success!\n")
     → fprintf(stderr, "success!\n");
```

The above explanation is ambiguous about the case where the only macro parameter is a variable arguments parameter, as it is meaningless to try to distinguish whether no argument at all is an empty argument or a missing argument. CPP retains the comma when conforming to a specific C standard. Otherwise the comma is dropped as an extension to the standard.

The C standard mandates that the only place the identifier __VA_ARGS__ can appear is in the replacement list of a variadic macro. It may not be used as a macro name, macro argument name, or within a different type of macro. It may also be forbidden in open text; the standard is ambiguous. We recommend you avoid using it except for its defined purpose.

Likewise, C++ forbids __VA_OPT__ anywhere outside the replacement list of a variadic macro.

Variadic macros became a standard part of the C language with C99. GNU CPP previously supported them with a named variable argument (‘args...’, not ‘...’ and __VA_ARGS__), which is still supported for backward compatibility.

## Undefining and Redefining Macros

If a macro ceases to be useful, it may be undefined with the `‘#undef’` directive. `‘#undef’` takes a single argument, the name of the macro to undefine. You use the bare macro name, even if the macro is function-like. It is an error if anything appears on the line after the macro name. `‘#undef’` has no effect if the name is not a macro.

```
#define FOO 4
x = FOO;        → x = 4;
#undef FOO
x = FOO;        → x = FOO
```

Once a macro has been undefined, that identifier may be redefined as a macro by a subsequent `‘#define’` directive. The new definition need not have any resemblance to the old definition.

However, if an identifier which is currently a macro is redefined, then the new definition must be effectively the same as the old one. Two macro definitions are effectively the same if:

* Both are the same type of macro (object- or function-like).
* All the tokens of the replacement list are the same.
* If there are any parameters, they are the same.
* Whitespace appears in the same places in both. It need not be exactly the same amount of whitespace, though. Remember that comments count as whitespace.

These definitions are effectively the same:

```
#define FOUR (2 + 2)
#define FOUR         (2    +    2)
#define FOUR (2 /* two */ + 2)
```

but these are not:

```          
#define FOUR (2 + 2)
#define FOUR ( 2+2 )
#define FOUR (2 * 2)
#define FOUR(score,and,seven,years,ago) (2 + 2)
```

If a macro is redefined with a definition that is not effectively the same as the old one, the preprocessor issues a warning and changes the macro to use the new definition. If the new definition is effectively the same, the redefinition is silently ignored. This allows, for instance, two different headers to define a common macro. The preprocessor will only complain if the definitions do not match.

