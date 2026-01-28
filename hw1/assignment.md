
# CSCI5708 — HW 1: SQL

**Due Date: Thursday, Feb 5 @ 11:59 PM CT**

**Submission:** Upload a single file named `submission.sql` to Gradescope.

- Your file **must** contain answers labeled with the exact markers: `-- Q0`, `-- Q1`, ..., `-- Q10`.
- For each question, write the required SQL directly under its marker.
- Unless a question explicitly says otherwise, **your query output must exactly match the required columns and ordering**.

**Database:** PostgreSQL (the autograder uses PostgreSQL and loads the provided schema/data before each question).

---

## Schema

Tables and key columns:

- `Students(sid, sname, age, gpa, major_id)`
- `Majors(major_id, mname)`
- `Courses(cid, title, dept, credits)`
- `Enrollment(sid, cid, term, grade)`
- `Drivers(did, dname, dyear, age, region)`
- `Cars(cid, model)`
- `Reserves(did, cid, rdate)`
- `Sales(region, product, amount)`

---

## Q0 — DDL + Constraints + Index

Create a new table `Waitlist` with the following requirements:

1. Columns:
   - `sid INT NOT NULL`
   - `cid INT NOT NULL`
   - `requested_at TIMESTAMP NOT NULL DEFAULT NOW()`
   - `position INT NOT NULL`
2. Constraints (use **exact** names):
   - `CONSTRAINT pk_waitlist PRIMARY KEY (sid, cid)`
   - `CONSTRAINT fk_waitlist_sid FOREIGN KEY (sid) REFERENCES Students(sid) ON DELETE CASCADE`
   - `CONSTRAINT fk_waitlist_cid FOREIGN KEY (cid) REFERENCES Courses(cid) ON DELETE CASCADE`
   - `CONSTRAINT chk_waitlist_position CHECK (position > 0)`
   - `CONSTRAINT uq_waitlist_position UNIQUE (cid, position)`
3. Create an index (use **exact** name):
   - `CREATE INDEX idx_waitlist_cid ON Waitlist(cid);`

No output is required for Q0 (DDL only). The autograder checks catalog metadata.

---

## Q1 — Strings in SQL

Return `sid` and `email` for students whose `sname` satisfies **either**:

- `sname ILIKE 'a%'` (starts with 'a' case-insensitively), **OR**
- `sname` matches the regex `'^Dr\.'` using the `~` operator.

Define `email` as:

`lower(regexp_replace(sname, '[^a-zA-Z0-9]+', '', 'g')) || '@umn.edu'`

**Output columns:** `sid | email`  
**Order by:** `sid` ascending

---

## Q2 — Core SELECT semantics

For each `dyear`, return the minimum driver age (`minage`) among drivers with `age > 18`,
but **only** keep `dyear` groups with more than 1 qualifying driver.

**Output columns:** `dyear | minage`  
**Order by:** `dyear` ascending

---

## Q3 — Joins

For each driver, compute the number of **distinct** cars they reserved in **calendar year 2025**.

- Include drivers with **zero** reservations in 2025 (so use an outer join).
- Count distinct `cid`.

**Output columns:** `did | dname | cnt`  
**Order by:** `cnt` descending, then `did` ascending

---

## Q4 — Nested queries

Return the distinct driver names (`dname`) for drivers who have reserved car `cid = 20`
(at any date), using an `IN (subquery)`.

**Output columns:** `dname`  
**Order by:** `dname` ascending

---

## Q5 — Nested queries using LATERAL

For each course, compute:

- `cnt`: number of enrolled students in term `'2026S'`
- `avg_gpa`: average `gpa` of enrolled students in term `'2026S'`, rounded to 2 decimals

Use `LATERAL` subqueries (as in lecture). Include all courses (even if enrollment is 0).

**Output columns:** `cid | title | cnt | avg_gpa`  
**Order by:** `cnt` ascending, then `cid` ascending

---

## Q6 — CTE (WITH)

Using a CTE named `good_students` defined as students with `gpa >= 3.5`,
return for each major:

- `major_id`
- `mname`
- `cnt_good`: number of good students in that major
- `avg_good_gpa`: average GPA of good students in that major, rounded to 2 decimals

**Output columns:** `major_id | mname | cnt_good | avg_good_gpa`  
**Order by:** `cnt_good` descending, then `major_id` ascending

---

## Q7 — Ranking

Compute GPA rank **within each major**:

`RANK() OVER (PARTITION BY major_id ORDER BY gpa DESC)`

Return only rows with rank <= 2 (top-2 ranks per major, ties included).

**Output columns:** `sid | major_id | gpa | rnk`  
**Order by:** `major_id`, then `rnk`, then `sid`

---

## Q8 — Windowing

For each course, pick exactly one “representative” enrolled student in term `'2026S'`:

- Highest `gpa` first
- Ties broken by **younger age**
- Further ties broken by `sid` ascending

Use:

`ROW_NUMBER() OVER (PARTITION BY cid ORDER BY gpa DESC, age ASC, sid ASC)`

Return only `row_number = 1`.

**Output columns:** `cid | sid | sname | gpa`  
**Order by:** `cid` ascending

---

## Q9 — ROLLUP

Using `Sales(region, product, amount)`, compute totals using:

`GROUP BY ROLLUP(region, product)`

**Output columns:** `region | product | total`  
**Order by:** `region NULLS LAST, product NULLS LAST`

---

## Q10 — CUBE

Using the same `Sales` table, compute totals using:

`GROUP BY CUBE(region, product)`

**Output columns:** `region | product | total`  
**Order by:** `region NULLS LAST, product NULLS LAST`
