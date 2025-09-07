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
