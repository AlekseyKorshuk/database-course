# Lab 10

# Task 1

[ex01.sql](./ex01.sql)

![](ex01.jpg)

# Task 2

[ex02.sql](./ex02.sql)
![](ex02.jpg)

# Task 3

[ex03.sql](./ex03.sql)

# Task 4.1

[ex04_prepopulate.sql](./ex04_prepopulate.sql)

1st output: No since the fact we didn't commit the second transactions. Read committed protects from dirty read

2nd output: Lock. Why? We changed rows in the first transaction, and the UPDATE in the second transaction waits until
this changes will be committed (just SELECT will not see any changes here).

![](ex04_task1_repeatable_read_1.jpg)

![](ex04_task1_read_committed_1.jpg)

![](ex04_task1_read_committed_2.jpg)

![](ex04_task1_repeatable_read_2.jpg)

# Task 4.2

1st output: No since the fact we didn't commit the second transactions. Read committed protects from dirty read

2nd output: REPEATABLE READ prevents from getting the same result set (I mean rows) but with different data inside of
it (Non repeatable read). So the first transaction would work with modified data, which is prohibited at this isolation
level. I suppose, if we would use snapshots at the start of the transaction, we would leave ACID durability principle (
We would just lose changes after commit both transactions).

![](ex04_task2_read_committed.jpg)

![](ex04_task2_repeatable_read.jpg)