-- Indexes for User Table


CREATE UNIQUE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_role ON User(role_id);
CREATE INDEX idx_user_created_at ON User(created_at); --signup date

-- Indexes for Booking Table

CREATE INDEX idx_booking_property ON Booking(property_id);
CREATE INDEX idx_booking_user ON Booking(user_id);
CREATE INDEX idx_booking_status ON Booking(status_id);
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);
CREATE INDEX idx_booking_created_at ON Booking(created_at); --latest bookings

-- Indexes for Property Table

CREATE INDEX idx_property_host ON Property(host_id);
CREATE INDEX idx_property_location ON Property(location_id);
CREATE INDEX idx_property_price ON Property(price_per_night);
CREATE INDEX idx_property_created_at ON Property(created_at); --newest listings


--Before indexing

EXPLAIN ANALYZE
SELECT b.booking_id, b.start_date, b.end_date, u.first_name, p.name
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
WHERE b.start_date BETWEEN '2024-06-01' AND '2024-06-30'
ORDER BY b.start_date;

