# Flex 

粘贴 wc.l 并编译操作。

```flex
/* %option noyywrap 功能较为复杂，同学们自行了解 */
%option noyywrap
%{
/* Flex 源程序采样类 C 的语法和规则 */
/* 以下是声明部分，`%{` 和 `%}` 之间的内容会被原样复制到生成的 C 文件头部
    包括该条注释内容 */
#include <string.h>
int chars = 0;
int words = 0;
%}

/* 以下是规则部分，在规则部分写注释不能顶格写 */
/* 每条规则由正则表达式和动作组成 */
/* 第一条规则匹配纯字母的字符串，并统计字母个数和字符串个数
                       其中 yytext 为匹配到的 token */
/* 第二条规则匹配其他字符或字符串并执行空动作 */
%%
 /* 在规则部分，不要顶格写注释 */
[a-zA-Z]+  { chars += strlen(yytext); words++; }
.          {}
%%

/* 以下为 C 代码部分 */
int main()
{
    /* yylex() 是由 Flex 自行生成的，用于执行 */
    yylex();
    /* 对于 stdin 输入匹配结束，执行其他操作 */
    printf("look, I find %d words of %d chars\n", words, chars);
    return 0;
}
```

生成了 lex.yy.c。

```c
... 超长。省略。
```

编译并执行词法器程序。

```bash
ezra@doesnotexist:~/Documents/ustc-compiler-principles-2024-autumn/lab1$ gcc lex.yy.c -o lexer
ezra@doesnotexist:~/Documents/ustc-compiler-principles-2024-autumn/lab1$ ./lexer
hello world!

look, I find 2 words of 10 chars
```

阅读 flex 自带的手册。

```bash
info flex
```

```output
Next: Copyright,  Prev: (dir),  Up: (dir)

flex
****

This manual describes 'flex', a tool for generating programs that
perform pattern-matching on text.  The manual includes both tutorial a\
nd
reference sections.

   This edition of 'The flex Manual' documents 'flex' version 2.6.4.  \
It
was last updated on 6 May 2017.

   This manual was written by Vern Paxson, Will Estes and John Millawa\
y.

* Menu:

* Copyright::                   
* Reporting Bugs::              
* Introduction::                
* Simple Examples::             
* Format::                      
* Patterns::                 
...
```

没看完，粗略看了一点。基本是 regex？好像有一些扩展。

# 思考题
如果存在同时以下规则和动作，对于字符串 +=，哪条规则会被触发，并尝试解释理由。

‵‵`flex
%%
\+ { return ADD; }
= { return ASSIGN; }
\+= { return ASSIGNADD; }
%%
```

ASSIGNADD，匹配长度更长。

如果存在同时以下规则和动作，对于字符串 ABC，哪条规则会被触发，并尝试解释理由。

```flex
%%
ABC { return 1; }
[a-zA-Z]+ {return 2; }
%%
```

1。顺序靠前。

如果存在同时以下规则和动作，对于字符串 ABC，哪条规则会被触发，并尝试解释理由。


```flex
%%
[a-zA-Z]+ {return 2; }
ABC { return 1; }
%%
```

2。顺序靠前。