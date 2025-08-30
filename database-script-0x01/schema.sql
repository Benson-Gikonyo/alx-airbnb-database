-- Role table


CREATE TABLE role (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) UNIQUE NOT NULL
);

-- User table

CREATE TABLE user(
    user_id UUID PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(50),
    role_id INT NOT NULL REFERENCES Role(role_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  
);

-- location table
CREATE TABLE location(
    location_id SERIAL PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    country VARCHAR(100) NOT NULL,

);

--property table

CREATE TABLE property(
    property_id UUID PRIMARY KEY,
    host_id UUID NOT NULL REFERENCES user(user_id),
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    location_id INT NOT NULL REFERENCES Location(location_id),
    price_per_night DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--  BookingStatus Table
CREATE TABLE bookingStatus (
    booking_status_id SERIAL PRIMARY KEY,
    status_name VARCHAR(50) UNIQUE NOT NULL
);

--  Booking Table
CREATE TABLE booking (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL REFERENCES Property(property_id),
    user_id UUID NOT NULL REFERENCES "User"(user_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    booking_status_id INT NOT NULL REFERENCES bookingStatus(status_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--  PaymentMethod Table
    CREATE TABLE paymentmethod (
    method_id SERIAL PRIMARY KEY,
    method_name VARCHAR(50) UNIQUE NOT NULL
);

-- 8. Payment Table
CREATE TABLE Payment (
    payment_id UUID PRIMARY KEY,
    booking_id UUID NOT NULL REFERENCES Booking(booking_id),
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    method_id INT NOT NULL REFERENCES paymentmethod(method_id)
);

-- Review Table
CREATE TABLE review (
    review_id UUID PRIMARY KEY,
    property_id UUID NOT NULL REFERENCES Property(property_id),
    user_id UUID NOT NULL REFERENCES "User"(user_id),
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


--  Message Table
CREATE TABLE message (
    message_id UUID PRIMARY KEY,
    sender_id UUID NOT NULL REFERENCES "User"(user_id),
    recipient_id UUID NOT NULL REFERENCES "User"(user_id),
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Indexes for performance
CREATE INDEX idx_user_email ON user(email);
CREATE INDEX idx_property_host ON Property(host_id);
CREATE INDEX idx_property_location ON Property(location_id);
CREATE INDEX idx_booking_property ON Booking(property_id);
CREATE INDEX idx_booking_user ON Booking(user_id);
CREATE INDEX idx_payment_booking ON Payment(booking_id);

