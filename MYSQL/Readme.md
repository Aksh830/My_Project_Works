# MySQL Cheat Sheet (CRUD Operations)

## 1. CREATE (INSERT Data)

### Create Database:
```sql
CREATE DATABASE database_name;
```

### Use Database:
```sql
USE database_name;
```

### Create Table:
```sql
CREATE TABLE table_name (
    id INT AUTO_INCREMENT PRIMARY KEY,
    column1 VARCHAR(255),
    column2 INT,
    column3 DATE
);
```

### Insert Data:
```sql
INSERT INTO table_name (column1, column2, column3)
VALUES ('Value1', 100, '2025-02-16');
```

### Insert Multiple Rows:
```sql
INSERT INTO table_name (column1, column2, column3)
VALUES
('Value1', 100, '2025-02-16'),
('Value2', 200, '2025-02-17');
```

## 2. READ (Retrieve Data)

### Select All Columns:
```sql
SELECT * FROM table_name;
```

### Select Specific Columns:
```sql
SELECT column1, column2 FROM table_name;
```

### Filter Results (WHERE Clause):
```sql
SELECT * FROM table_name WHERE column2 = 100;
```

### Using LIKE for Pattern Matching:
```sql
SELECT * FROM table_name WHERE column1 LIKE 'Val%';
```

### Sorting Results (ORDER BY):
```sql
SELECT * FROM table_name ORDER BY column2 DESC;
```

### Limiting Rows (LIMIT):
```sql
SELECT * FROM table_name LIMIT 5;
```

### Counting Rows:
```sql
SELECT COUNT(*) FROM table_name;
```

## 3. UPDATE (Modify Data)

### Update Single Row:
```sql
UPDATE table_name
SET column1 = 'UpdatedValue'
WHERE id = 1;
```

### Update Multiple Rows:
```sql
UPDATE table_name
SET column2 = column2 + 10
WHERE column2 < 200;
```

## 4. DELETE (Remove Data)

### Delete Specific Row:
```sql
DELETE FROM table_name WHERE id = 1;
```

### Delete All Rows (Without Dropping Table):
```sql
DELETE FROM table_name;
```

### Drop a Table:
```sql
DROP TABLE table_name;
```

### Drop a Database:
```sql
DROP DATABASE database_name;
```

## Additional Useful Queries

### Join Two Tables (INNER JOIN):
```sql
SELECT a.column1, b.column2
FROM table1 a
INNER JOIN table2 b ON a.id = b.table1_id;
```

### Left Join:
```sql
SELECT a.column1, b.column2
FROM table1 a
LEFT JOIN table2 b ON a.id = b.table1_id;
```

### Create an Index:
```sql
CREATE INDEX index_name ON table_name (column_name);
```

### Aggregate Functions:
```sql
SELECT AVG(column2), SUM(column2), MIN(column2), MAX(column2)
FROM table_name;
```

### Group By:
```sql
SELECT column1, COUNT(*)
FROM table_name
GROUP BY column1;
```

### Having Clause:
```sql
SELECT column1, COUNT(*)
FROM table_name
GROUP BY column1
HAVING COUNT(*) > 1;
```



