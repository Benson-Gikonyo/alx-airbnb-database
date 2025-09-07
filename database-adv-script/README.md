# Booking Management Database - README
This project demonstrates a relational database for a Booking Management System.
It covers:

- Different join strategies (INNER, LEFT, FULL OUTER).

- Analytical queries with subqueries.

- Use of window functions and aggregates.

- Indexing and performance analysis.

- Optimize Complex Queries

- Table partitioning for scalability.

- Monitoring and Refining Database Performance



## 1. Different join strategies (INNER, LEFT, FULL OUTER).
- INNER JOIN to retrieve all bookings and the respective users who made those bookings.
```
SELECT b.booking_id,
       b.start_date,
       b.end_date,
       b.status_id,
       u.user_id,
       u.first_name,
       u.last_name,
       u.email
FROM Booking b
INNER JOIN "User" u ON b.user_id = u.user_id;
```

-LEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews. Order results by property name
```
SELECT p.property_id,
       p.name AS property_name,
       r.review_id,
       r.rating,
       r.comment,
       r.created_at
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
ORDER BY p.name;
```

- FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
```
SELECT User.user_id, User.first_name, User.last_name, User.email, User.phone_number
FROM User
FULL OUTER JOIN Booking ON User.user_id=Booking.user_id;
```
## 2. Analytical queries with subqueries.

-a query to find all properties where the average rating is greater than 4.0 using a subquery
```
SELECT Property.property_id, 
       Property.name AS property_name, 
       Property.price_per_night, 
       Location.city, Location.country
FROM Property 
JOIN Location  ON Property.location_id = Location.location_id
WHERE Property.property_id IN (
    SELECT Review.property_id
    FROM Review 
    GROUP BY Review.property_id
    HAVING AVG(Review.rating) > 4.0
);
```

- correlated subquery to find users who have made more than 3 bookings.
```
SELECT User.user_id, 
       User.first_name,
       User.last_name, 
       User.email
FROM User 
WHERE (
    SELECT COUNT(*)
    FROM Booking 
    WHERE Booking.user_id = User.user_id
) > 3;
```

## 3. Use of window functions and aggregates.

- Query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.
```
SELECT User.user_id,
       User.first_name,
       User.last_name,
       COUNT(Booking.booking_id) AS total_bookings
FROM User 
LEFT JOIN Booking  ON User.user_id = Booking.user_id
GROUP BY User.user_id, User.first_name, User.last_name
ORDER BY total_bookings DESC;
```

- A window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.
```
SELECT Property.property_id,
       Property.name AS property_name,
       COUNT(Booking.booking_id) AS total_bookings,
       RANK() OVER (ORDER BY COUNT(Booking.booking_id) DESC) AS booking_rank
FROM Property 
LEFT JOIN Booking  ON Property.property_id = Booking.property_id
GROUP BY Property.property_id, Property.name
ORDER BY booking_rank;
```


## 4. Indexing and performance analysis.

- Indexes for User Table
```
CREATE UNIQUE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_role ON User(role_id);
CREATE INDEX idx_user_created_at ON User(created_at);
```

- Indexes for Booking Table
```
CREATE INDEX idx_booking_property ON Booking(property_id);
CREATE INDEX idx_booking_user ON Booking(user_id);
CREATE INDEX idx_booking_status ON Booking(status_id);
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);
CREATE INDEX idx_booking_created_at ON Booking(created_at); 
```

- Indexes for Property Table
```
CREATE INDEX idx_property_host ON Property(host_id);
CREATE INDEX idx_property_location ON Property(location_id);
CREATE INDEX idx_property_price ON Property(price_per_night);
CREATE INDEX idx_property_created_at ON Property(created_at); --newest listings
```


## 5. Optimize Complex Queries

-Analysis of a query's performance that retrieves all bookings along with the user details, property details, and payment details

Initial Query: Retrieve bookings with user, property, and payment details
```
SELECT b.booking_id,
       b.start_date,
       b.end_date,
       b.status_id,
       u.user_id,
       u.first_name,
       u.last_name,
       u.email,
       p.property_id,
       p.name AS property_name,
       p.price_per_night,
       pay.payment_id,
       pay.amount,
       pay.payment_method,
       pay.payment_date
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id;
```

Analysis of above query
```
EXPLAIN ANALYZE
SELECT b.booking_id,
       b.start_date,
       b.end_date,
       b.status_id,
       u.user_id,
       u.first_name,
       u.last_name,
       u.email,
       p.property_id,
       p.name AS property_name,
       p.price_per_night,
       pay.payment_id,
       pay.amount,
       pay.payment_method,
       pay.payment_date
FROM Booking b
JOIN "User" u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id;
```

optimised query: Only necessary fields, indexed joins
```
SELECT b.booking_id,
       b.start_date,
       b.end_date,
       b.status_id,
       u.first_name || ' ' || u.last_name AS full_name,
       u.email,
       p.name AS property_name,
       p.price_per_night,
       pay.amount AS payment_amount,
       pay.payment_method
FROM Booking b
JOIN "User" u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id;
```

## 6. Table partitioning for scalability.
- Before Partitioning:
```
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE start_date BETWEEN '2024-06-01' AND '2024-06-30';
```

Execution plan: Seq Scan on full Booking table.
Time: ~120 ms on a large dataset (example).

- After Partitioning:

Execution plan: Seq Scan or Index Scan on Booking_2024 only (partition pruning).
Time: ~10–15 ms.

Observed Improvements

- Partition pruning means only the relevant partition is scanned.

- Significant reduction in query execution time when filtering by date ranges.

- Indexes on partitions further improved performance for selective queries.

- Maintenance benefit: old partitions (e.g., Booking_2022) can be archived or dropped without affecting current data.

- Conclusion: Partitioning Booking by start_date drastically improves performance for date-based queries, making the system more scalable as bookings grow year over year.

## 7. Monitoring and Refining Database Performance

Analysing a frequent query:
```
EXPLAIN ANALYZE
SELECT b.booking_id, b.start_date, b.end_date, b.total_price,
       u.first_name, u.last_name, u.email,
       p.name AS property_name, p.location
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
WHERE b.start_date BETWEEN '2024-06-01' AND '2024-06-30'
ORDER BY b.start_date DESC;
```
From the EXPLAIN ANALYZE output, typical issues include:

- Seq Scan on Booking → full table scan because start_date is not indexed.

- Nested Loop Join → inefficient when joining large Booking and User tables.

- Sort operation → slow ORDER BY due to missing index.

Suggested changes:

- Add index on Booking.start_date to optimize date filtering.

- Add composite index on Booking(user_id, property_id) for joins.

- Add index on Property(location) if often filtered by location.

```
CREATE INDEX idx_booking_start_date ON Booking(start_date);
CREATE INDEX idx_booking_user_property ON Booking(user_id, property_id);
CREATE INDEX idx_property_location ON Property(location);
``` 
Schema Adjustment

- Partitioning Booking by start_date (done earlier).

- Ensure User.email has a unique index (already implemented).
