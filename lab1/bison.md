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

然后贴入 calc.y。

```cpp
/* calc.y */
%{
#include <stdio.h>
    int yylex(void);
    void yyerror(const char *s);
%}

%token RET
%token <num> NUMBER
%token <op> ADDOP MULOP LPAREN RPAREN
%type <num> top line expr term factor

%start top

%union {
    char   op;
    double num;
}

%%

top
: top line {}
| {}

line
: expr RET
{
    printf(" = %f\n", $1);
}

expr
: term
{
    $$ = $1;
}
| expr ADDOP term
{
    switch ($2) {
    case '+': $$ = $1 + $3; break;
    case '-': $$ = $1 - $3; break;
    }
}

term
: factor
{
    $$ = $1;
}
| term MULOP factor
{
    switch ($2) {
    case '*': $$ = $1 * $3; break;
    case '/': $$ = $1 / $3; break; // 这里会出什么问题？
    }
}

factor
: LPAREN expr RPAREN
{
    $$ = $2;
}
| NUMBER
{
    $$ = $1;
}

%%

void yyerror(const char *s)
{
    fprintf(stderr, "%s\n", s);
}

int main()
{
    yyparse();
    return 0;
}
```

编译执行。

```shell
ezra@doesnotexist:~/Documents/ustc-compiler-principles-2024-autumn/lab1$ bison -d calc.y
ezra@doesnotexist:~/Documents/ustc-compiler-principles-2024-autumn/lab1$ flex calc.l
ezra@doesnotexist:~/Documents/ustc-compiler-principles-2024-autumn/lab1$ ls calc.tab.c calc.tab.h lex.yy.c
calc.tab.c  calc.tab.h  lex.yy.c
ezra@doesnotexist:~/Documents/ustc-compiler-principles-2024-autumn/lab1$ gcc lex.yy.c calc.tab.c -o calc
ezra@doesnotexist:~/Documents/ustc-compiler-principles-2024-autumn/lab1$ ./calc
1+1
 = 2.000000
1+1*2
 = 3.000000
(1+1)*2
 = 4.000000
2*1+1
 = 3.000000
```

一个简单的计算器程序。支持加法乘法左右括号。
存在一个潜在问题。除数为 0 时会出现问题。

完整的工作流程图：

![](https://ustc-compiler-principles.github.io/2023/lab1/assets/image-20230913164805071-1694594895535-1-1694594931543-3.png)

## 为什么 Bison 可以处理左递归？

Bison 是一个 LALR(1) 解析器生成器，使用 自底向上 的语法解析方法（shift-reduce 解析）。规避了可能的死循环问题。（自顶向下就可能遇到这种问题！）

## 能否加入除数检查？

可以。修改记录见 git commit log。

```shell
ezra@doesnotexist:~/Documents/ustc-compiler-principles-2024-autumn/lab1$ ./calc 
1/0
Division by zero error
 = 1.000000
```