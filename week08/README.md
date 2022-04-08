# Lab 8

# Task 1

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