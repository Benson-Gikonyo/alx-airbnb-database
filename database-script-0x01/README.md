The following is a schema for the airbnb clone project. The  entities and their respective column tables( according ton 3NF) are:


    User 
    user_id UUID PRIMARY KEY,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR UNIQUE NOT NULL,
    password_hash VARCHAR NOT NULL,
    phone_number VARCHAR,
    role_id INT REFERENCES Role(role_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

    Role 
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR UNIQUE NOT NULL  -- guest, host, admin

    Property 
    property_id UUID PRIMARY KEY,
    host_id UUID REFERENCES User(user_id),
    name VARCHAR NOT NULL,
    description TEXT NOT NULL,
    location_id INT REFERENCES Location(location_id),
    price_per_night DECIMAL NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

    Location 
    location_id SERIAL PRIMARY KEY,
    address VARCHAR NOT NULL,
    city VARCHAR NOT NULL,
    state VARCHAR,
    country VARCHAR NOT NULL

    Booking 
    booking_id UUID PRIMARY KEY,
    property_id UUID REFERENCES Property(property_id),
    user_id UUID REFERENCES User(user_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    booking_status_id INT REFERENCES BookingStatus(status_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

    BookingStatus 
    booking_status_id SERIAL PRIMARY KEY,
    status_name VARCHAR UNIQUE NOT NULL -- pending, confirmed, canceled

    Payment 
    payment_id UUID PRIMARY KEY,
    booking_id UUID REFERENCES Booking(booking_id),
    amount DECIMAL NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    method_id INT REFERENCES PaymentMethod(method_id)

    PaymentMethod 
    method_id SERIAL PRIMARY KEY,
    method_name VARCHAR UNIQUE NOT NULL -- credit_card, paypal, stripe

    Review 
    review_id UUID PRIMARY KEY,
    property_id UUID REFERENCES Property(property_id),
    user_id UUID REFERENCES User(user_id),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

    Message 
    message_id UUID PRIMARY KEY,
    sender_id UUID REFERENCES User(user_id),
    recipient_id UUID REFERENCES User(user_id),
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

