sqlite> CREATE TABLE student_performance (
(x1...>     student_id INT,
(x1...>     student_name VARCHAR(100),
(x1...>     course VARCHAR(100),
(x1...>     marks INT,
(x1...>     attendance FLOAT,
(x1...>     city VARCHAR(100)
(x1...> );
sqlite> INSERT INTO student_performance
   ...> (student_id, student_name, course, marks, attendance, city)
   ...> VALUES
   ...> (1,'Shravani','Python',85,90.5,'Pune'),
   ...> (2,'Rohan','Java',78,85.0,'Mumbai'),
   ...> (3,'Sneha','Python',92,95.0,'Pune'),
   ...> (4,'Amit','SQL',67,75.5,'Nashik'),
   ...> (5,'Priya','Java',88,91.0,'Nagpur'),
   ...> (6,'Rahul','SQL',73,80.0,'Pune'),
   ...> (7,'Neha','Python',95,98.0,'Mumbai'),
   ...> (8,'Om','Java',81,87.5,'Pune'),
   ...> (9,'Sakshi','SQL',89,92.0,'Kolhapur'),
   ...> (10,'Akash','Python',76,83.0,'Satara');
sqlite> CREATE TABLE revenue (
(x1...>     month VARCHAR(20),
(x1...>     course VARCHAR(100),
(x1...>     revenue INT
(x1...> );
sqlite> INSERT INTO revenue
   ...> (month, course, revenue)
   ...> VALUES
   ...> ('January','Python',50000),
   ...> ('February','Java',62000),
   ...> ('March','SQL',45000),
   ...> ('April','Python',70000),
   ...> ('May','Java',68000),
   ...> ('June','SQL',55000);
sqlite> SELECT * FROM student_performance;
╭────────────┬──────────────┬────────┬───────┬────────────┬──────────╮
│ student_id │ student_name │ course │ marks │ attendance │   city   │
╞════════════╪══════════════╪════════╪═══════╪════════════╪══════════╡
│          1 │ Shravani     │ Python │    85 │       90.5 │ Pune     │
│          2 │ Rohan        │ Java   │    78 │       85.0 │ Mumbai   │
│          3 │ Sneha        │ Python │    92 │       95.0 │ Pune     │
│          4 │ Amit         │ SQL    │    67 │       75.5 │ Nashik   │
│          5 │ Priya        │ Java   │    88 │       91.0 │ Nagpur   │
│          6 │ Rahul        │ SQL    │    73 │       80.0 │ Pune     │
│          7 │ Neha         │ Python │    95 │       98.0 │ Mumbai   │
│          8 │ Om           │ Java   │    81 │       87.5 │ Pune     │
│          9 │ Sakshi       │ SQL    │    89 │       92.0 │ Kolhapur │
│         10 │ Akash        │ Python │    76 │       83.0 │ Satara   │
╰────────────┴──────────────┴────────┴───────┴────────────┴──────────╯
sqlite> SELECT * FROM revenue;
╭──────────┬────────┬─────────╮
│  month   │ course │ revenue │
╞══════════╪════════╪═════════╡
│ January  │ Python │   50000 │
│ February │ Java   │   62000 │
│ March    │ SQL    │   45000 │
│ April    │ Python │   70000 │
│ May      │ Java   │   68000 │
│ June     │ SQL    │   55000 │
╰──────────┴────────┴─────────╯
sqlite> SELECT
   ...> student_name,
   ...> course,
   ...> marks,
   ...> RANK() OVER(
(x1...> PARTITION BY course
(x1...> ORDER BY marks DESC
(x1...> ) AS rank_no
   ...> FROM student_performance;
╭──────────────┬────────┬───────┬─────────╮
│ student_name │ course │ marks │ rank_no │
╞══════════════╪════════╪═══════╪═════════╡
│ Priya        │ Java   │    88 │       1 │
│ Om           │ Java   │    81 │       2 │
│ Rohan        │ Java   │    78 │       3 │
│ Neha         │ Python │    95 │       1 │
│ Sneha        │ Python │    92 │       2 │
│ Shravani     │ Python │    85 │       3 │
│ Akash        │ Python │    76 │       4 │
│ Sakshi       │ SQL    │    89 │       1 │
│ Rahul        │ SQL    │    73 │       2 │
│ Amit         │ SQL    │    67 │       3 │
╰──────────────┴────────┴───────┴─────────╯
sqlite> SELECT
   ...> student_name,
   ...> marks,
   ...> DENSE_RANK() OVER(
(x1...> ORDER BY marks DESC
(x1...> ) AS dense_rank
   ...> FROM student_performance;
╭──────────────┬───────┬────────────╮
│ student_name │ marks │ dense_rank │
╞══════════════╪═══════╪════════════╡
│ Neha         │    95 │          1 │
│ Sneha        │    92 │          2 │
│ Sakshi       │    89 │          3 │
│ Priya        │    88 │          4 │
│ Shravani     │    85 │          5 │
│ Om           │    81 │          6 │
│ Rohan        │    78 │          7 │
│ Akash        │    76 │          8 │
│ Rahul        │    73 │          9 │
│ Amit         │    67 │         10 │
╰──────────────┴───────┴────────────╯
sqlite> SELECT
   ...> student_name,
   ...> ROW_NUMBER() OVER(
(x1...> ORDER BY marks DESC
(x1...> ) AS row_num
   ...> FROM student_performance;
╭──────────────┬─────────╮
│ student_name │ row_num │
╞══════════════╪═════════╡
│ Neha         │       1 │
│ Sneha        │       2 │
│ Sakshi       │       3 │
│ Priya        │       4 │
│ Shravani     │       5 │
│ Om           │       6 │
│ Rohan        │       7 │
│ Akash        │       8 │
│ Rahul        │       9 │
│ Amit         │      10 │
╰──────────────┴─────────╯
sqlite> SELECT
   ...> month,
   ...> revenue,
   ...> LAG(revenue)
   ...> OVER(ORDER BY month)
   ...> AS previous_month
   ...> FROM revenue;
╭──────────┬─────────┬────────────────╮
│  month   │ revenue │ previous_month │
╞══════════╪═════════╪════════════════╡
│ April    │   70000 │ NULL           │
│ February │   62000 │          70000 │
│ January  │   50000 │          62000 │
│ June     │   55000 │          50000 │
│ March    │   45000 │          55000 │
│ May      │   68000 │          45000 │
╰──────────┴─────────┴────────────────╯
sqlite> SELECT
   ...> month,
   ...> revenue,
   ...> LEAD(revenue)
   ...> OVER(ORDER BY month)
   ...> AS next_month
   ...> FROM revenue;
╭──────────┬─────────┬────────────╮
│  month   │ revenue │ next_month │
╞══════════╪═════════╪════════════╡
│ April    │   70000 │      62000 │
│ February │   62000 │      50000 │
│ January  │   50000 │      55000 │
│ June     │   55000 │      45000 │
│ March    │   45000 │      68000 │
│ May      │   68000 │ NULL       │
╰──────────┴─────────┴────────────╯
sqlite> WITH avg_marks AS (
(x1...> SELECT
(x1...> course,
(x1...> AVG(marks) AS avg_score
(x1...> FROM student_performance
(x1...> GROUP BY course
(x1...> )
   ...>
   ...> SELECT *
   ...> FROM avg_marks
   ...> WHERE avg_score > 70;
╭────────┬────────────────────╮
│ course │     avg_score      │
╞════════╪════════════════════╡
│ Java   │ 82.333333333333329 │
│ Python │               87.0 │
│ SQL    │ 76.333333333333329 │
╰────────┴────────────────────╯
sqlite> CREATE VIEW top_students AS
   ...> SELECT *
   ...> FROM student_performance
   ...> WHERE marks > 85;
sqlite> SELECT * FROM top_students;
╭────────────┬──────────────┬────────┬───────┬────────────┬──────────╮
│ student_id │ student_name │ course │ marks │ attendance │   city   │
╞════════════╪══════════════╪════════╪═══════╪════════════╪══════════╡
│          3 │ Sneha        │ Python │    92 │       95.0 │ Pune     │
│          5 │ Priya        │ Java   │    88 │       91.0 │ Nagpur   │
│          7 │ Neha         │ Python │    95 │       98.0 │ Mumbai   │
│          9 │ Sakshi       │ SQL    │    89 │       92.0 │ Kolhapur │
╰────────────┴──────────────┴────────┴───────┴────────────┴──────────╯
sqlite>











sqlite> CREATE TABLE student_performance (
(x1...>     student_id INT,
(x1...>     student_name VARCHAR(100),
(x1...>     course VARCHAR(100),
(x1...>     marks INT,
(x1...>     attendance FLOAT,
(x1...>     city VARCHAR(100)
(x1...> );
sqlite> INSERT INTO student_performance
   ...> (student_id, student_name, course, marks, attendance, city)
   ...> VALUES
   ...> (1,'Shravani','Python',85,90.5,'Pune'),
   ...> (2,'Rohan','Java',78,85.0,'Mumbai'),
   ...> (3,'Sneha','Python',92,95.0,'Pune'),
   ...> (4,'Amit','SQL',67,75.5,'Nashik'),
   ...> (5,'Priya','Java',88,91.0,'Nagpur'),
   ...> (6,'Rahul','SQL',73,80.0,'Pune'),
   ...> (7,'Neha','Python',95,98.0,'Mumbai'),
   ...> (8,'Om','Java',81,87.5,'Pune'),
   ...> (9,'Sakshi','SQL',89,92.0,'Kolhapur'),
   ...> (10,'Akash','Python',76,83.0,'Satara');
sqlite> CREATE TABLE revenue (
(x1...>     month VARCHAR(20),
(x1...>     course VARCHAR(100),
(x1...>     revenue INT
(x1...> );
sqlite> INSERT INTO revenue
   ...> (month, course, revenue)
   ...> VALUES
   ...> ('January','Python',50000),
   ...> ('February','Java',62000),
   ...> ('March','SQL',45000),
   ...> ('April','Python',70000),
   ...> ('May','Java',68000),
   ...> ('June','SQL',55000);
sqlite> SELECT * FROM student_performance;
╭────────────┬──────────────┬────────┬───────┬────────────┬──────────╮
│ student_id │ student_name │ course │ marks │ attendance │   city   │
╞════════════╪══════════════╪════════╪═══════╪════════════╪══════════╡
│          1 │ Shravani     │ Python │    85 │       90.5 │ Pune     │
│          2 │ Rohan        │ Java   │    78 │       85.0 │ Mumbai   │
│          3 │ Sneha        │ Python │    92 │       95.0 │ Pune     │
│          4 │ Amit         │ SQL    │    67 │       75.5 │ Nashik   │
│          5 │ Priya        │ Java   │    88 │       91.0 │ Nagpur   │
│          6 │ Rahul        │ SQL    │    73 │       80.0 │ Pune     │
│          7 │ Neha         │ Python │    95 │       98.0 │ Mumbai   │
│          8 │ Om           │ Java   │    81 │       87.5 │ Pune     │
│          9 │ Sakshi       │ SQL    │    89 │       92.0 │ Kolhapur │
│         10 │ Akash        │ Python │    76 │       83.0 │ Satara   │
╰────────────┴──────────────┴────────┴───────┴────────────┴──────────╯
sqlite> SELECT * FROM revenue;
╭──────────┬────────┬─────────╮
│  month   │ course │ revenue │
╞══════════╪════════╪═════════╡
│ January  │ Python │   50000 │
│ February │ Java   │   62000 │
│ March    │ SQL    │   45000 │
│ April    │ Python │   70000 │
│ May      │ Java   │   68000 │
│ June     │ SQL    │   55000 │
╰──────────┴────────┴─────────╯
sqlite> SELECT
   ...> student_name,
   ...> course,
   ...> marks,
   ...> RANK() OVER(
(x1...> PARTITION BY course
(x1...> ORDER BY marks DESC
(x1...> ) AS rank_no
   ...> FROM student_performance;
╭──────────────┬────────┬───────┬─────────╮
│ student_name │ course │ marks │ rank_no │
╞══════════════╪════════╪═══════╪═════════╡
│ Priya        │ Java   │    88 │       1 │
│ Om           │ Java   │    81 │       2 │
│ Rohan        │ Java   │    78 │       3 │
│ Neha         │ Python │    95 │       1 │
│ Sneha        │ Python │    92 │       2 │
│ Shravani     │ Python │    85 │       3 │
│ Akash        │ Python │    76 │       4 │
│ Sakshi       │ SQL    │    89 │       1 │
│ Rahul        │ SQL    │    73 │       2 │
│ Amit         │ SQL    │    67 │       3 │
╰──────────────┴────────┴───────┴─────────╯
sqlite> SELECT
   ...> student_name,
   ...> marks,
   ...> DENSE_RANK() OVER(
(x1...> ORDER BY marks DESC
(x1...> ) AS dense_rank
   ...> FROM student_performance;
╭──────────────┬───────┬────────────╮
│ student_name │ marks │ dense_rank │
╞══════════════╪═══════╪════════════╡
│ Neha         │    95 │          1 │
│ Sneha        │    92 │          2 │
│ Sakshi       │    89 │          3 │
│ Priya        │    88 │          4 │
│ Shravani     │    85 │          5 │
│ Om           │    81 │          6 │
│ Rohan        │    78 │          7 │
│ Akash        │    76 │          8 │
│ Rahul        │    73 │          9 │
│ Amit         │    67 │         10 │
╰──────────────┴───────┴────────────╯
sqlite> SELECT
   ...> student_name,
   ...> ROW_NUMBER() OVER(
(x1...> ORDER BY marks DESC
(x1...> ) AS row_num
   ...> FROM student_performance;
╭──────────────┬─────────╮
│ student_name │ row_num │
╞══════════════╪═════════╡
│ Neha         │       1 │
│ Sneha        │       2 │
│ Sakshi       │       3 │
│ Priya        │       4 │
│ Shravani     │       5 │
│ Om           │       6 │
│ Rohan        │       7 │
│ Akash        │       8 │
│ Rahul        │       9 │
│ Amit         │      10 │
╰──────────────┴─────────╯
sqlite> SELECT
   ...> month,
   ...> revenue,
   ...> LAG(revenue)
   ...> OVER(ORDER BY month)
   ...> AS previous_month
   ...> FROM revenue;
╭──────────┬─────────┬────────────────╮
│  month   │ revenue │ previous_month │
╞══════════╪═════════╪════════════════╡
│ April    │   70000 │ NULL           │
│ February │   62000 │          70000 │
│ January  │   50000 │          62000 │
│ June     │   55000 │          50000 │
│ March    │   45000 │          55000 │
│ May      │   68000 │          45000 │
╰──────────┴─────────┴────────────────╯
sqlite> SELECT
   ...> month,
   ...> revenue,
   ...> LEAD(revenue)
   ...> OVER(ORDER BY month)
   ...> AS next_month
   ...> FROM revenue;
╭──────────┬─────────┬────────────╮
│  month   │ revenue │ next_month │
╞══════════╪═════════╪════════════╡
│ April    │   70000 │      62000 │
│ February │   62000 │      50000 │
│ January  │   50000 │      55000 │
│ June     │   55000 │      45000 │
│ March    │   45000 │      68000 │
│ May      │   68000 │ NULL       │
╰──────────┴─────────┴────────────╯
sqlite> WITH avg_marks AS (
(x1...> SELECT
(x1...> course,
(x1...> AVG(marks) AS avg_score
(x1...> FROM student_performance
(x1...> GROUP BY course
(x1...> )
   ...>
   ...> SELECT *
   ...> FROM avg_marks
   ...> WHERE avg_score > 70;
╭────────┬────────────────────╮
│ course │     avg_score      │
╞════════╪════════════════════╡
│ Java   │ 82.333333333333329 │
│ Python │               87.0 │
│ SQL    │ 76.333333333333329 │
╰────────┴────────────────────╯
sqlite> CREATE VIEW top_students AS
   ...> SELECT *
   ...> FROM student_performance
   ...> WHERE marks > 85;
sqlite> SELECT * FROM top_students;
╭────────────┬──────────────┬────────┬───────┬────────────┬──────────╮
│ student_id │ student_name │ course │ marks │ attendance │   city   │
╞════════════╪══════════════╪════════╪═══════╪════════════╪══════════╡
│          3 │ Sneha        │ Python │    92 │       95.0 │ Pune     │
│          5 │ Priya        │ Java   │    88 │       91.0 │ Nagpur   │
│          7 │ Neha         │ Python │    95 │       98.0 │ Mumbai   │
│          9 │ Sakshi       │ SQL    │    89 │       92.0 │ Kolhapur │
╰────────────┴──────────────┴────────┴───────┴────────────┴──────────╯
sqlite>
















































