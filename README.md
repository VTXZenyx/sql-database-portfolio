# SQL & Relational Database Portfolio

This repository shows database and SQL work I completed during university study.

I used **SQLite** and **DB Browser for SQLite** to write, run and test SQL, and **Draw.io** for database/dependency diagrams.

The SQL files contain my own coursework SQL, grouped by topic so the repository is easier to browse. I have kept the query logic and SQL statements from my work rather than replacing them with newly generated examples.

The screenshots below are taken directly from my submitted database-design work.

## What I worked with

- SQL querying and filtering
- Multi-table joins
- `GROUP BY` and `HAVING`
- Aggregate functions
- Nested and correlated subqueries
- Self joins
- Date/time functions
- `CREATE TABLE`, `INSERT`, `UPDATE`, `ALTER TABLE`
- Primary keys and foreign keys
- Composite keys
- Referential integrity
- Functional dependencies and normalisation
- Transactions and ACID
- SQL views
- Relational database design

## SQL work

### Music database
- [`fundamentals.sql`](sql/music-database/fundamentals.sql)
- [`joins-and-analysis.sql`](sql/music-database/joins-and-analysis.sql)
- [`subqueries.sql`](sql/music-database/subqueries.sql)

### Database design and operations
- [`roll-participation.sql`](sql/database-design/roll-participation.sql)
- [`bus-transport.sql`](sql/database-design/bus-transport.sql)
- [`department-reassignment.sql`](sql/database-design/department-reassignment.sql)
- [`dependency-design-ddl.sql`](sql/database-design/dependency-design-ddl.sql)
- [`dependency-change-ddl.sql`](sql/database-design/dependency-change-ddl.sql)
- [`student-management-database.sql`](sql/database-design/student-management-database.sql)
- [`messaging-database.sql`](sql/database-design/messaging-database.sql)

### Other relational query examples
- [`employee-certificate-flight.sql`](sql/other-query-examples/employee-certificate-flight.sql)
- [`natural-join.sql`](sql/other-query-examples/natural-join.sql)

The MusicDB files use the supplied music database. The other files use separate sample schemas from my database-design work.

## Database design work

### Student management database

This work shows how I moved from dependencies and a flat structure into relational tables with primary and foreign keys.

![Student management database design](evidence/screenshots/student-management-database-design.png)

![Student management schema](evidence/screenshots/student-management-schema-part-1.png)

![Student management schema continued](evidence/screenshots/student-management-schema-part-2.png)

### DB Browser for SQLite

I created and inspected the tables using DB Browser for SQLite.

![DB Browser for SQLite table structure](evidence/screenshots/db-browser-for-sqlite-table-structure.png)

### Transactions and database results

I also worked with transaction logging, ACID concepts and SQL calculations.

![Transaction log and ACID work](evidence/screenshots/transaction-log-and-acid-work.png)

![GPA query and result](evidence/screenshots/gpa-query-and-result.png)

## Messaging database design

I normalised a messaging dataset and designed tables for chats, users, receivers, groups and messages.

![Messaging dependency design](evidence/screenshots/messaging-database-dependency-design.png)

![Messaging database schema](evidence/screenshots/messaging-database-schema-part-1.png)

![Messaging database schema continued](evidence/screenshots/messaging-database-schema-part-2.png)

### Normalisation tool

![Normalisation tool input](evidence/screenshots/normalisation-tool-input.png)

![Normalisation tool output](evidence/screenshots/normalisation-tool-output.png)

### SQL view and output

![Messaging SQL view work](evidence/screenshots/messaging-view-work.png)

![SQL view result](evidence/screenshots/sql-view-result.png)

![Group member schema extension](evidence/screenshots/group-member-schema-extension.png)

## SQLite database

`data/MusicDB.db` is the **course-provided SQLite database** I used for the music-database SQL work. It is included so the relevant queries can be opened and tested in DB Browser for SQLite.

I am not claiming the supplied database itself as my own creation; the SQL queries in this repository are my work.

## Selected coursework results

- **68/70**
- **67.5/70**
- **58/60**

## Original database-design evidence

The full database-design submission used for the screenshots is included here:

[`database-design-and-normalisation-work.pdf`](evidence/original/database-design-and-normalisation-work.pdf)

## Portfolio note

This coursework is included for portfolio use with permission. Files have only been organised and renamed for presentation; the screenshots are direct crops from my submitted work.

## Author

**Viraj Gandhi**

Portfolio: https://vtxzenyx.github.io  
GitHub: https://github.com/VTXZenyx
