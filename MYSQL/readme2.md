# MySQL Functions & Queries Cheat Sheet

## 1. String Functions
| Function | Purpose | Example |
|----------|---------|---------|
| `CONCAT()` | Join strings together | `CONCAT(first_name, ' ', last_name)` → `'John Doe'` |
| `CONCAT_WS()` | Join with a separator | `CONCAT_WS('-', '2025', '08', '13')` → `'2025-08-13'` |
| `LEFT()` / `RIGHT()` | Get first/last N chars | `LEFT('Hello', 2)` → `'He'` |
| `SUBSTRING()` | Extract part of string | `SUBSTRING('HelloWorld', 6, 5)` → `'World'` |
| `TRIM()` | Remove spaces from both ends | `TRIM('  text  ')` → `'text'` |
| `LTRIM()` / `RTRIM()` | Remove spaces left/right | `LTRIM(' text')` → `'text'` |
| `UPPER()` / `LOWER()` | Change case | `UPPER('abc')` → `'ABC'` |
| `REPLACE()` | Replace substring | `REPLACE('abc123', '123', 'XYZ')` → `'abcXYZ'` |
| `LPAD()` / `RPAD()` | Pad with characters | `LPAD('7', 3, '0')` → `'007'` |

---

## 2. Date & Time Functions
| Function | Purpose | Example |
|----------|---------|---------|
| `CURDATE()` | Today’s date | `'2025-08-13'` |
| `NOW()` | Current date & time | `'2025-08-13 14:22:00'` |
| `DATE_FORMAT(date, format)` | Format date | `DATE_FORMAT(NOW(), '%Y-%m-%d')` → `'2025-08-13'` |
| `STR_TO_DATE(str, format)` | Convert string to date | `STR_TO_DATE('20250813','%Y%m%d')` → `'2025-08-13'` |
| `DATE_ADD()` / `DATE_SUB()` | Add/subtract interval | `DATE_ADD(CURDATE(), INTERVAL 7 DAY)` |
| `YEAR()`, `MONTH()`, `DAY()` | Extract components | `YEAR(CURDATE())` → `2025` |

---

## 3. Numeric & Conversion Functions
| Function | Purpose | Example |
|----------|---------|---------|
| `ROUND(number, decimals)` | Round to N decimals | `ROUND(123.4567, 2)` → `123.46` |
| `FLOOR()` / `CEIL()` | Round down/up | `FLOOR(123.9)` → `123`, `CEIL(123.1)` → `124` |
| `COALESCE()` | Replace NULL with value | `COALESCE(salary, 5000)` |
| `CAST(expr AS type)` | Convert type | `CAST('123' AS UNSIGNED)` |
| `CONVERT(expr, type)` | Convert type | `CONVERT('123.45', DECIMAL(5,2))` |

---

## 4. Aggregate & Window Functions
| Function | Purpose | Example |
|----------|---------|---------|
| `AVG(col)` | Average | `AVG(salary)` |
| `SUM(col)` | Sum | `SUM(sales)` |
| `COUNT(col)` | Count non-NULL | `COUNT(employee_id)` |
| `ROW_NUMBER() OVER(...)` | Row number | `ROW_NUMBER() OVER(PARTITION BY dept ORDER BY salary DESC)` |
| `RANK()` / `DENSE_RANK()` | Ranking | `RANK() OVER(PARTITION BY dept ORDER BY salary DESC)` |

---

## 5. Joins
| Type | Description | Example |
|------|------------|---------|
| `INNER JOIN` | Only matching rows | `SELECT * FROM a INNER JOIN b ON a.id=b.a_id` |
| `LEFT JOIN` | All rows from left + matches | `SELECT * FROM a LEFT JOIN b ON a.id=b.a_id` |
| `RIGHT JOIN` | All rows from right + matches | `SELECT * FROM a RIGHT JOIN b ON a.id=b.a_id` |
| `FULL OUTER JOIN` | All rows both sides (MySQL needs UNION) | `SELECT * FROM a LEFT JOIN b ... UNION SELECT * FROM a RIGHT JOIN b ...` |

---

## 6. Filtering & Conditional
| Function / Clause | Purpose | Example |
|------------------|---------|---------|
| `IN` | Check set membership | `WHERE dept IN ('HR','IT','Sales')` |
| `LIKE` | Pattern matching | `WHERE name LIKE 'J%n'` |
| `BETWEEN` | Range check | `WHERE salary BETWEEN 5000 AND 10000` |
| `CASE WHEN ... THEN ... ELSE ... END` | Conditional logic | `CASE WHEN salary>5000 THEN 'High' ELSE 'Low' END` |

---

## 7. Miscellaneous
| Function / Clause | Purpose | Example |
|------------------|---------|---------|
| `IFNULL(col, value)` | Replace NULL | `IFNULL(bonus,0)` |
| `GROUP BY` | Aggregate grouping | `GROUP BY dept` |
| `ORDER BY` | Sorting | `ORDER BY salary DESC` |
| `LIMIT` | Row limiting | `LIMIT 10` |
