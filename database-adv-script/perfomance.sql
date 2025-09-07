-- performance.sql

-- Initial Query: Retrieve bookings with user, property, and payment details
-- Initial query: retrieve all bookings + user + property + payment details
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.payment_method
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
WHERE b.start_date >= '2024-06-01'
  AND b.end_date   <= '2024-06-30'
  AND b.status = 'confirmed';

-- Performance analysis with EXPLAIN

EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.payment_method
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
WHERE b.start_date >= '2024-06-01'
  AND b.end_date   <= '2024-06-30'
  AND b.status = 'confirmed';

-- Inefficiencies:

-- Seq Scan on Booking → no index on start_date / end_date.

-- Nested Loop Joins → large intermediate results if indexes are missing on user_id and property_id.

-- Sort operation → if no covering index for filtering & ordering.
