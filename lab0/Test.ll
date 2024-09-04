; ModuleID = 'Test.c'
source_filename = "Test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

@grade_mul = dso_local global i32 0, align 4
@degree_mul = dso_local global i32 0, align 4
@.str = private unnamed_addr constant [6 x i8] c"PB%d\0A\00", align 1
@Grade = dso_local global [1 x i32] zeroinitializer, align 4
@Degree = dso_local global [1 x i32] zeroinitializer, align 4
@Number = dso_local global [1 x i32] zeroinitializer, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @StudentNumber(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %11 = load ptr, ptr %4, align 8
  %12 = getelementptr inbounds i32, ptr %11, i64 0
  %13 = load i32, ptr %12, align 4
  store i32 %13, ptr %7, align 4
  %14 = load ptr, ptr %5, align 8
  %15 = getelementptr inbounds i32, ptr %14, i64 0
  %16 = load i32, ptr %15, align 4
  store i32 %16, ptr %8, align 4
  %17 = load ptr, ptr %6, align 8
  %18 = getelementptr inbounds i32, ptr %17, i64 0
  %19 = load i32, ptr %18, align 4
  store i32 %19, ptr %9, align 4
  %20 = load i32, ptr %7, align 4
  %21 = load i32, ptr @grade_mul, align 4
  %22 = mul nsw i32 %20, %21
  %23 = load i32, ptr %8, align 4
  %24 = load i32, ptr @degree_mul, align 4
  %25 = mul nsw i32 %23, %24
  %26 = add nsw i32 %22, %25
  %27 = load i32, ptr %9, align 4
  %28 = add nsw i32 %26, %27
  store i32 %28, ptr %10, align 4
  %29 = load i32, ptr %10, align 4
  %30 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %29)
  ret void
}

declare dso_local i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 22, ptr @Grade, align 4
  store i32 11, ptr @Degree, align 4
  store i32 227, ptr @Number, align 4
  store i32 1000000, ptr @grade_mul, align 4
  store i32 10000, ptr @degree_mul, align 4
  call void @StudentNumber(ptr noundef @Grade, ptr noundef @Degree, ptr noundef @Number)
  ret i32 0
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{!"clang version 18.1.6 (Fedora 18.1.6-3.fc40)"}
