# Lab 1
## 仓库目录结构

与本次实验有关的文件如下。

```shell
|-- CMakeLists.txt
|-- build # 在编译过程中产生，不需要通过 git add 添加到仓库中
|-- src
|   |-- CMakeLists.txt
|   |-- common
|   `-- parser
|       |-- CMakeLists.txt
|       |-- lexer.c
|       |-- lexical_analyzer.l # 你需要修改本文件
|       |-- parser.c
|       `-- syntax_analyzer.y # 你需要修改本文件
`-- tests
    |-- 1-parser
    |   |-- input # 针对 Lab1 的测试样例
    |   |-- output_standard # 助教提供的标准参考结果
    |   |-- output_student # 测试脚本产生的你解析后的结果
    |   |-- cleanup.sh
    |   `-- eval_lab1.sh # 测试用的脚本
    `-- testcases_general # 整个课程所用到的测试样例
```

## 编译

Fedora / RHEL 系记得安装 llvm 的开发包。

```shell
sudo dnf install llvm-devel
```

然后创建 build 目录执行 cmake 即可构建。

```shell
mkdir build
cd build
cmake ..
make
```

## 踩坑

在我的环境下，使用 c99 标准会没有 fileno 函数。需要手动修改 CMakeList 修复。

接下来挨个输入规则，缝缝补补即可。

成果：

```shell
ezra@doesnotexist:~/Documents/ustc-compiler-principles-2024-autumn/src/build$ ./lexer test.c 
Token         Text      Line    Column (Start,End)
280            int      0       (0,3)
258                     0       (3,4)
285           main      0       (4,8)
272              (      0       (8,9)
273              )      0       (9,10)
276              {      0       (10,11)
277              }      0       (11,12)
```

test.c：

```c
int main() {}
```

## 评测

```shell
ezra@doesnotexist:~/Documents/ustc-compiler-principles-2024-autumn/src/tests/1-parser$ ./eval_lab1.sh easy yes
[info] Analyzing expr.cminus
[info] Analyzing FAIL_comment2.cminus
error at line 1 column 1: syntax error
[info] Analyzing FAIL_comment.cminus
error at line 1 column 1: syntax error
[info] Analyzing FAIL_function.cminus
error at line 3 column 0: syntax error
[info] Analyzing FAIL_id.cminus
error at line 1 column 6: syntax error
[info] Analyzing id.cminus
[info] Comparing...
[info] No difference! Congratulations!
```