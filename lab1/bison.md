# Bison

贴入 Bison 示例代码。编译执行。

```cpp
/* file name : bison_demo.y */
%{
#include <stdio.h>
/* 定义部分 */
/* 这部分代码会被原样拷贝到生成的 .c 文件的开头 */
int yylex(void);
void yyerror(const char *s);
%}

/* 定义部分 */
/* 对语法的终结符和非终结符进行声明 */
%start reimu
%token REIMU

/* 从这里开始，下面是解析规则 */
%%
reimu : marisa { /* 这里写与该规则对应的处理代码 */ puts("rule1"); }
      | REIMU  { /* 这里写与该规则对应的处理代码 */ puts("rule2"); }
      ; /* 规则最后不要忘了用分号结束哦～ */

 /* 这种写法表示 ε —— 空输入 */
marisa : { puts("Hello!"); }
%%


/* 以下是 C 代码部分 */
/* 在这个 Bison 程序中，我们没有联动 Flex，所以手写一个 yylex 函数 */
int yylex(void)
{
    int c = getchar(); // 从 stdin 获取下一个字符
    switch (c) {
    case EOF: return YYEOF;
    case 'R': return REIMU;
    default:  return YYUNDEF;     // 报告 token 未定义，迫使 bison 报错。
    // 由于 bison 不同版本有不同的定义。如果这里 YYUNDEF 未定义，请尝试 YYUNDEFTOK 或使用一个随意的整数。
    }
}

void yyerror(const char *s)
{
    fprintf(stderr, "%s\n", s);
}

int main(void)
{
    yyparse(); // 启动解析
    return 0;
}
```

```shell
ezra@doesnotexist:~/Documents/ustc-compiler-principles-2024-autumn/lab1$ bison bison_demo.y
ezra@doesnotexist:~/Documents/ustc-compiler-principles-2024-autumn/lab1$ ls bison_demo.tab.c
bison_demo.tab.c
ezra@doesnotexist:~/Documents/ustc-compiler-principles-2024-autumn/lab1$ gcc bison_demo.tab.c -o bison_demo
ezra@doesnotexist:~/Documents/ustc-compiler-principles-2024-autumn/lab1$ ./bison_demo 
Hello!
rule1
ezra@doesnotexist:~/Documents/ustc-compiler-principles-2024-autumn/lab1$ ./bison_demo 
blablablaHello!
rule1
syntax error
ezra@doesnotexist:~/Documents/ustc-compiler-principles-2024-autumn/lab1$ ./bison_demo 
Rrule2

syntax error
```

空输入和未解析是 rule1。带 R 的触发灵梦 rule2。（唉二次元。）