#include <stdio.h>

int Grade[1];
int Degree[1];
int Number[1];
int grade_mul;
int degree_mul;

void StudentNumber(int u[], int v[], int k[]) {
    int grade;
    int degree;
    int number;
    int result;
    grade = u[0];
    degree = v[0];
    number = k[0];
    result = grade * grade_mul + degree * degree_mul + number;
    // 若学号前缀不是 PB 可于此修改
    printf("PB%d\n",result);
    return;
}

/**
 * @brief 修改 main 函数中的信息输出你的学号
 *
 * @param Grade[0]: 你的年级，如 20，21，22 等
 * @param Degree[0]: 你的专业代号，如计科是 11
 * @param Number[0]: 你的学生序号，如 0011，4514 等
 * @return int
 */
int main(void) {
    Grade[0] = 22;
    Degree[0] = 11; // 我不是 USTC 的所以默认留着吧
    Number[0] = 227;
    grade_mul = 1000000;
    degree_mul = 10000;
    StudentNumber(Grade,Degree,Number);
    return 0;
}