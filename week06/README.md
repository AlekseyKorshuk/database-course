# Lab 6

# Task 1

Create tables with data:

```sql
CREATE TABLE IF NOT EXISTS Suppliers (
	sid INTEGER,
	sname TEXT,
	address TEXT,
	PRIMARY KEY (sid)
);

CREATE TABLE IF NOT EXISTS Parts (
	pid INTEGER,
	pname TEXT,
	color TEXT,
	PRIMARY KEY (pid)
);

CREATE TABLE IF NOT EXISTS Catalog (
	sid INTEGER,
	pid INTEGER,
	cost REAL,
	PRIMARY KEY (sid, pid)
);

insert into suppliers (sid, sname, address)
values (1, 'Yosemite Sham',     E'Devil\'s canyon, AZ'),
       (2, 'Wiley E.Coyote',    'RR Asylum, NV'),
       (3, 'Elmer Fudd',        'Carrot Patch, MN');

insert into parts (pid, pname, color)
values (1, 'Red1',      'Red'),
       (2, 'Red2',      'Red'),
       (3, 'Green1',    'Green'),
       (4, 'Blue1',     'Blue'),
       (5, 'Red3',      'Red');

insert into catalog (sid, pid, cost)
values (1, 1, 10), (1, 2, 20), (1, 3, 30), (1, 4, 40), (1, 5, 50), (2, 1, 9), (2, 3, 34), (2, 5, 48);
```

- Find the names of suppliers who supply some red part.

```sql
SELECT 
  DISTINCT S.sname 
FROM 
  Suppliers S, 
  Parts P, 
  Catalog C 
WHERE 
  P.color = 'Red' 
  AND C.pid = P.pid 
  AND C.sid = S.sid
```

![Screenshot 2022-04-01 at 17.24.51.png](Lab%206%208ae2b/Screenshot_2022-04-01_at_17.24.51.png)

- Find the sids of suppliers who supply some red or green part.

```sql
SELECT 
  DISTINCT C.sid 
FROM 
  Catalog C, 
  Parts P 
WHERE 
  (
    P.color = 'Red' 
    OR P.color = 'Green'
  ) 
  AND P.pid = C.pid
```

![Screenshot 2022-04-01 at 17.27.42.png](Lab%206%208ae2b/Screenshot_2022-04-01_at_17.27.42.png)

- Find the sids of suppliers who supply some red part or are at 221 Packer Street.

```sql
SELECT 
  DISTINCT S.sid 
FROM 
  Suppliers S 
WHERE 
  S.address = '221 Packer street' 
  OR S.sid IN (
    SELECT 
      C.sid 
    FROM 
      Parts P, 
      Catalog C 
    WHERE 
      P.color = 'Red' 
      AND P.pid = C.pid
  )
```

![Screenshot 2022-04-01 at 17.31.01.png](Lab%206%208ae2b/Screenshot_2022-04-01_at_17.31.01.png)

- Find the sids of suppliers who supply every red or green part.

```sql
SELECT 
  DISTINCT C.sid 
FROM 
  Catalog C 
WHERE 
  NOT EXISTS (
    SELECT 
      P.pid 
    FROM 
      Parts P 
    WHERE 
      (
        P.color = 'Red' 
        OR P.color = 'Green'
      ) 
      AND (
        NOT EXISTS (
          SELECT 
            C1.sid 
          FROM 
            Catalog C1 
          WHERE 
            C1.sid = C.sid 
            AND C1.pid = P.pid
        )
      )
  )
```

![Screenshot 2022-04-01 at 17.33.14.png](Lab%206%208ae2b/Screenshot_2022-04-01_at_17.33.14.png)

- Find the sids of suppliers who supply every red part or supply every green part.

```sql
SELECT 
  DISTINCT C.sid 
FROM 
  Catalog C 
WHERE 
  (
    NOT EXISTS (
      SELECT 
        P.pid 
      FROM 
        Parts P 
      WHERE 
        P.color = 'Red' 
        AND (
          NOT EXISTS (
            SELECT 
              C1.sid 
            FROM 
              Catalog C1 
            WHERE 
              C1.sid = C.sid 
              AND C1.pid = P.pid
          )
        )
    )
  ) 
  OR (
    NOT EXISTS (
      SELECT 
        P1.pid 
      FROM 
        Parts P1 
      WHERE 
        P1.color = 'Green' 
        AND (
          NOT EXISTS (
            SELECT 
              C2.sid 
            FROM 
              Catalog C2 
            WHERE 
              C2.sid = C.sid 
              AND C2.pid = P1.pid
          )
        )
    )
  )
```

- Find pairs of sids such that the supplier with the first sid charges more for some part than the supplier with the second sid.

```sql
SELECT 
  DISTINCT C1.sid, 
  C2.sid 
FROM 
  Catalog C1, 
  Catalog C2 
WHERE 
  C1.pid = C2.pid 
  AND C1.sid != C2.sid 
  AND C1.cost > C2.cost
```

![Screenshot 2022-04-01 at 17.42.13.png](Lab%206%208ae2b/Screenshot_2022-04-01_at_17.42.13.png)

- Find the pids of parts supplied by at least two different suppliers.

```sql
SELECT 
  DISTINCT C.pid 
FROM 
  Catalog C 
WHERE 
  EXISTS (
    SELECT 
      C1.sid 
    FROM 
      Catalog C1 
    WHERE 
      C1.pid = C.pid 
      AND C1.sid != C.sid
  )
```

![Screenshot 2022-04-01 at 17.44.54.png](Lab%206%208ae2b/Screenshot_2022-04-01_at_17.44.54.png)

- find the average cost of the red parts and green parts for each of the suppliers

```sql
SELECT 
  F.sid, 
  F.color, 
  AVG(F.cost) as avg_cost 
FROM 
  (
    SELECT 
      p.color, 
      C.cost, 
      C.sid 
    FROM 
      Catalog C 
      INNER JOIN parts p ON p.pid = C.pid 
    WHERE 
      p.color = 'Red' 
      OR p.color = 'Green'
  ) AS F 
GROUP BY 
  F.sid, 
  F.color
```

![Screenshot 2022-04-01 at 19.00.44.png](Lab%206%208ae2b/Screenshot_2022-04-01_at_19.00.44.png)

- find the sids of suppliers whose most expensive part costs $50 or more

```sql
SELECT 
  DISTINCT C1.sid 
FROM 
  Catalog C1 
WHERE 
  (C1.cost >= 50)
```

![Screenshot 2022-04-01 at 17.48.27.png](Lab%206%208ae2b/Screenshot_2022-04-01_at_17.48.27.png)

# Task 2

Creating tables with data:

```sql
CREATE TABLE Author (
	author_id INT NOT NULL PRIMARY KEY,
	first_name VARCHAR(255),
	last_name VARCHAR(255)
);

CREATE TABLE Book (
	book_id INT NOT NULL PRIMARY KEY,
	book_title VARCHAR(255),
	month VARCHAR(255), 
	year INT,
	editor INT,
	FOREIGN KEY (editor) REFERENCES Author(author_id)
);

CREATE TABLE Pub (
	pub_id INT NOT NULL PRIMARY KEY,
	title VARCHAR(255),
	book_id INT,
	FOREIGN KEY (book_id) REFERENCES Book(book_id)
);

CREATE TABLE AuthorPub (
	author_id INT,
	FOREIGN KEY (author_id) REFERENCES Author(author_id),
	pub_id INT,
	FOREIGN KEY (pub_id) REFERENCES Pub(pub_id),
	author_position INT
);

INSERT INTO Author(author_id, first_name, last_name) VALUES
(1, 'John', 'McCarthy'),
(2, 'Dennis', 'Ritchie'),
(3, 'Ken', 'Thompson'),
(4, 'Claude', 'Shannon'),
(5, 'Alan', 'Turing'),
(6, 'Alonzo', 'Church'),
(7, 'Perry', 'White'),
(8, 'Moshe', 'Vardi'),
(9, 'Roy', 'Batty');

INSERT INTO Book(book_id, book_title, month, year, editor) VALUES
(1, 'CACM', 'April', 1960, 8),
(2, 'CACM', 'July', 1974, 8),
(3, 'BTS' , 'July', 1936, 2),
(4, 'MLS' , 'November', 1936, 7),
(5, 'Mind', 'October', 1950, NULL),
(6, 'AMS' , 'Month', 1941, NULL),
(7, 'AAAI', 'July', 2012, 9),
(8, 'NIPS', 'July', 2012, 9);

INSERT INTO Pub(pub_id, title, book_id) VALUES
(1, 'LISP', 1),
(2, 'Unix', 2),
(3, 'Info Theory', 3),
(4, 'Turing Machines', 4),
(5, 'Turing Test', 5),
(6, 'Lambda Calculus', 6);

INSERT INTO AuthorPub(author_id, pub_id, author_position) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 2, 2),
(4, 3, 1),
(5, 4, 1),
(5, 5, 1),
(6, 6, 1);

```

## Subtask 1

![Screenshot 2022-04-01 at 19.40.15.png](Lab%206%208ae2b/Screenshot_2022-04-01_at_19.40.15.png)

```sql
SELECT 
  * 
FROM 
  Author 
  INNER JOIN Book ON Author.author_id = Book.editor;
```

![Screenshot 2022-04-01 at 19.42.53.png](Lab%206%208ae2b/Screenshot_2022-04-01_at_19.42.53.png)

## Subtask 2

![Screenshot 2022-04-01 at 19.41.46.png](Lab%206%208ae2b/Screenshot_2022-04-01_at_19.41.46.png)

```sql
SELECT 
  first_name, 
  last_name 
FROM 
  Author 
WHERE 
  author_id NOT IN (
    SELECT 
      author_id 
    FROM 
      Author 
    WHERE 
      author_id IN (
        SELECT 
          editor 
        FROM 
          Book
      )
  );
```

![Screenshot 2022-04-01 at 19.43.54.png](Lab%206%208ae2b/Screenshot_2022-04-01_at_19.43.54.png)

## Subtask 3

![Screenshot 2022-04-01 at 19.41.59.png](Lab%206%208ae2b/Screenshot_2022-04-01_at_19.41.59.png)

```sql
SELECT 
  author_id 
FROM 
  Author 
WHERE 
  author_id NOT IN (
    SELECT 
      author_id 
    FROM 
      Author 
    WHERE 
      author_id IN (
        SELECT 
          editor 
        FROM 
          Book
      )
  );
```

![Screenshot 2022-04-01 at 19.44.55.png](Lab%206%208ae2b/Screenshot_2022-04-01_at_19.44.55.png)