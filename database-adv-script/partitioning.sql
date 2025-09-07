-- Drop table if it exists
DROP TABLE IF EXISTS Booking CASCADE;

-- Step 1: Create parent Booking table partitioned by start_date
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL REFERENCES Property(property_id),
    user_id UUID NOT NULL REFERENCES User(user_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    status VARCHAR NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);

-- Step 2: Create partitions (example: yearly)
CREATE TABLE Booking_2023 PARTITION OF Booking
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE Booking_2024 PARTITION OF Booking
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE Booking_2025 PARTITION OF Booking
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Step 3: (Optional) Create indexes on partitioned tables
CREATE INDEX idx_booking_2023_start_date ON Booking_2023(start_date);
CREATE INDEX idx_booking_2024_start_date ON Booking_2024(start_date);
CREATE INDEX idx_booking_2025_start_date ON Booking_2025(start_date);

-- Step 4: Example query to test partition pruning
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE start_date BETWEEN '2024-06-01' AND '2024-06-30';
