# Linux 环境配置

我正在使用 Fedora。因此不会遵照原 lab 的指引进行配置。

原文：

```markdown
# 更新软件源
sudo apt update
# 更新软件（可选）
sudo apt upgrade
# 安装 LLVM 和 Clang
sudo apt install clang llvm
```

我的配置：

```bash
sudo dnf install clang llvm

正在忽略仓库:docker-ce-stable
上次元数据过期检查：0:51:25 前，执行于 2024年09月04日 星期三 10时06分23秒。
依赖关系解决。
================================================================================
 软件包                        架构       版本                仓库         大小
================================================================================
安装:
 clang                         x86_64     18.1.6-3.fc40       updates      78 k
 llvm                          x86_64     18.1.6-2.fc40       updates      26 M
安装依赖关系:
 clang-libs                    x86_64     18.1.6-3.fc40       updates      23 M
 clang-resource-filesystem     noarch     18.1.6-3.fc40       updates      15 k
安装弱的依赖:
 compiler-rt                   x86_64     18.1.6-1.fc40       updates     2.3 M
 libomp                        x86_64     18.1.6-2.fc40       updates     656 k
 libomp-devel                  x86_64     18.1.6-2.fc40       updates     480 k

事务概要
================================================================================
安装  7 软件包

总下载：53 M
安装大小：276 M
确定吗？[y/N]： y
下载软件包：
(1/7): clang-resource-filesystem-18.1.6-3.fc40.  76 kB/s |  15 kB     00:00    
(2/7): clang-18.1.6-3.fc40.x86_64.rpm           273 kB/s |  78 kB     00:00    
(3/7): compiler-rt-18.1.6-1.fc40.x86_64.rpm     1.3 MB/s | 2.3 MB     00:01    
(4/7): libomp-18.1.6-2.fc40.x86_64.rpm          342 kB/s | 656 kB     00:01    
(5/7): libomp-devel-18.1.6-2.fc40.x86_64.rpm    917 kB/s | 480 kB     00:00    
(6/7): clang-libs-18.1.6-3.fc40.x86_64.rpm      5.3 MB/s |  23 MB     00:04    
(7/7): llvm-18.1.6-2.fc40.x86_64.rpm            1.3 MB/s |  26 MB     00:20    
--------------------------------------------------------------------------------
总计                                            2.2 MB/s |  53 MB     00:23     
运行事务检查
正在等待 pid 为398838的进程退出。
事务检查成功。
运行事务测试
事务测试成功。
运行事务
  准备中  :                                                                 1/1 
  安装    : clang-resource-filesystem-18.1.6-3.fc40.noarch                  1/7 
  安装    : libomp-18.1.6-2.fc40.x86_64                                     2/7 
  安装    : libomp-devel-18.1.6-2.fc40.x86_64                               3/7 
  安装    : compiler-rt-18.1.6-1.fc40.x86_64                                4/7 
  安装    : clang-libs-18.1.6-3.fc40.x86_64                                 5/7 
  安装    : clang-18.1.6-3.fc40.x86_64                                      6/7 
  安装    : llvm-18.1.6-2.fc40.x86_64                                       7/7 
  运行脚本: llvm-18.1.6-2.fc40.x86_64                                       7/7 

已安装:
  clang-18.1.6-3.fc40.x86_64                                                    
  clang-libs-18.1.6-3.fc40.x86_64                                               
  clang-resource-filesystem-18.1.6-3.fc40.noarch                                
  compiler-rt-18.1.6-1.fc40.x86_64                                              
  libomp-18.1.6-2.fc40.x86_64                                                   
  libomp-devel-18.1.6-2.fc40.x86_64                                             
  llvm-18.1.6-2.fc40.x86_64                                                     

完毕！
```

git 本来就有。大部分 build-essentials 包括的上回编译驱动的时候就装了。

```bash
ezra@doesnotexist:~$ sudo dnf install cmake flex bison
Docker CE Stable - x86_64                       5.7 kB/s | 3.5 kB     00:00    
软件包 cmake-3.28.2-1.fc40.x86_64 已安装。
软件包 flex-2.6.4-16.fc40.x86_64 已安装。
软件包 bison-3.8.2-7.fc40.x86_64 已安装。
依赖关系解决。
无需任何处理。
完毕！
```

这些之前也装了。

gdb 也装了。

在同名目录下贴入 test.c 代码、执行。

```bash
# 该指令对 Text.c 进行编译，并生成其对应的 LLVM IR 代码，记为 Test.ll。
ezra@doesnotexist:~/Documents/ustc-compiler-principles-2024-autumn/lab0$ clang -S -emit-llvm Test.c -o Test.ll
ezra@doesnotexist:~/Documents/ustc-compiler-principles-2024-autumn/lab0$ lli Test.ll && echo $?
PB22110227
0
```