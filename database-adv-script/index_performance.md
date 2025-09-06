EXPLAIN ANALYZE
SELECT *
FROM Booking
WHERE property_id = '1234-uuid'
  AND status_id = 2;
