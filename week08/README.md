# Lab 8

# Task 1

```SQL
    select count(ID) from customers
```

```
count                                                                           
--------
 600000
(1 row)
```

## Column 1. B-Tree index
```SQL
select * from customer where id=350000
```

```
                                                    QUERY PLAN                                                      
-------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..22229.45 rows=1 width=211) (actual time=72.503..76.308 rows=1 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on customer  (cost=0.00..21229.35 rows=1 width=211) (actual time=58.238..63.070 rows=0 loops=3)
         Filter: (id = 350000)
         Rows Removed by Filter: 200000
 Planning Time: 1.042 ms
 Execution Time: 76.430 ms
(8 rows)
```
```SQL
create index id_btree on customer using btree (ID);
```

```
                                                    QUERY PLAN                                                      
---------------------------------------------------------------------------------------------------------------------
 Index Scan using id_btree on customer  (cost=0.42..8.44 rows=1 width=211) (actual time=0.034..0.037 rows=1 loops=1)
   Index Cond: (id = 350000)
 Planning Time: 0.129 ms
 Execution Time: 0.070 ms
(4 rows)
```

## Column 2. Hashtable index

```SQL
select * from customer where name='Jonathan Gonzalez';
```

```
                                                    QUERY PLAN                                                      
-------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..22230.15 rows=8 width=211) (actual time=45.879..71.909 rows=24 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on customer  (cost=0.00..21229.35 rows=3 width=211) (actual time=37.359..59.370 rows=8 loops=3)
         Filter: (name = 'Jonathan Gonzalez'::text)
         Rows Removed by Filter: 199992
 Planning Time: 0.201 ms
 Execution Time: 71.943 ms
(8 rows)
```

```SQL
create index name_hash on customer using hash(name);

```

```
                                                    QUERY PLAN                                                     
-------------------------------------------------------------------------------------------------------------------
 Bitmap Heap Scan on customer  (cost=4.06..35.66 rows=8 width=211) (actual time=0.049..0.127 rows=24 loops=1)
   Recheck Cond: (name = 'Jonathan Gonzalez'::text)
   Heap Blocks: exact=24
   ->  Bitmap Index Scan on name_hash  (cost=0.00..4.06 rows=8 width=0) (actual time=0.021..0.022 rows=24 loops=1)
         Index Cond: (name = 'Jonathan Gonzalez'::text)
 Planning Time: 0.191 ms
 Execution Time: 0.181 ms
```

## Column 3. SP-Gist index
```SQL
select * from customer where review = 'Fall improve floor cause he something parent. Realize other control military commercial recognize serious.
Economy office owner half environmental suffer. West outside discover feel southern heavy.';
```

```
                                                    QUERY PLAN                                                     
-------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..22229.75 rows=4 width=211) (actual time=66.432..77.452 rows=4 loops=1)
   Workers Planned: 2
   Workers Launched: 2
   ->  Parallel Seq Scan on customer  (cost=0.00..21229.35 rows=2 width=211) (actual time=57.307..64.073 rows=1 loops=3)
         Filter: (review = 'Senior claim remember final. Interview cover friend spend possible low big. Quite wonder heart participant wish since investment test. Look building matter church bag measure government.'::text)
         Rows Removed by Filter: 199999
 Planning Time: 0.114 ms
 Execution Time: 77.486 ms
(8 rows)
```

```
create index review_gin on customer using spgist(review);
```

```
                                                    QUERY PLAN                                                     
-------------------------------------------------------------------------------------------------------------------
 Bitmap Heap Scan on customer  (cost=347.66..8227.44 rows=3000 width=578) (actual time=0.063..0.076 rows=4 loops=1)
   Recheck Cond: ((review)::text = 'Senior claim remember final. Interview cover friend spend possible low big. Quite wonder heart participant wish since investment test. Look building matter church bag measure government.'::text)
   Heap Blocks: exact=4
   ->  Bitmap Index Scan on review_gin  (cost=0.00..346.91 rows=3000 width=0) (actual time=0.049..0.049 rows=4 loops=1)
         Index Cond: ((review)::text = 'Senior claim remember final. Interview cover friend spend possible low big. Quite wonder heart participant wish since investment test. Look building matter church bag measure government.'::text)
 Planning Time: 0.205 ms
 Execution Time: 0.132 ms
(7 rows)
```

# Task 2

## Part 1

The company is preparing its campaign for next Halloween, so the list of movies that have not been rented yet by the clients is needed, whose rating is R or PG-13 and its category is Horror or Sci-fi.

```sql
SELECT 
  film.title 
FROM 
  film 
  INNER JOIN film_category ON film.film_id = film_category.film_id 
  INNER JOIN category ON film_category.category_id = category.category_id 
WHERE 
  (
    film.rating = 'PG-13' 
    or film.rating = 'R'
  ) 
  and (
    category.name = 'Horror' 
    or category.name = 'Sci-fi'
  ) 
  and film.film_id NOT IN (
    SELECT 
      film_id 
    FROM 
      inventory
  )
```

![Screenshot 2022-04-08 at 22.12.00.png](Lab%208%20aee83/Screenshot_2022-04-08_at_22.12.00.png)

## Part 2

The company has decided to reward the best stores in each of the cities, so it is necessary
to have a list of the stores that have made a greater number of sales in term of money
during the last month recorded.

```sql
select city.city_id, s.store_id, total_p from address 
inner join city on city.city_id = address.city_id
inner join
(select store.address_id, store.store_id, sum(p.amount) as total_p from payment as p 
left join staff as st on p.staff_id = st.staff_id
left join store on store.store_id = st.store_id
group by store.store_id) as s on (s.address_id = address.address_id);
```

![Screenshot 2022-04-08 at 23.58.47.png](Lab%208%20aee83/Screenshot_2022-04-08_at_23.58.47.png)

## Part 3

The main problem is JOIN. It usually works in $n^2$.
