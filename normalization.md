Current Entities and Attributes:
User

    user_id: Primary Key, UUID, Indexed
    first_name: VARCHAR, NOT NULL
    last_name: VARCHAR, NOT NULL
    email: VARCHAR, UNIQUE, NOT NULL
    password_hash: VARCHAR, NOT NULL
    phone_number: VARCHAR, NULL
    role: ENUM (guest, host, admin), NOT NULL
    created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

Property

    property_id: Primary Key, UUID, Indexed
    host_id: Foreign Key, references User(user_id)
    name: VARCHAR, NOT NULL
    description: TEXT, NOT NULL
    location: VARCHAR, NOT NULL
    pricepernight: DECIMAL, NOT NULL
    created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
    updated_at: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP

Booking

    booking_id: Primary Key, UUID, Indexed
    property_id: Foreign Key, references Property(property_id)
    user_id: Foreign Key, references User(user_id)
    start_date: DATE, NOT NULL
    end_date: DATE, NOT NULL
    total_price: DECIMAL, NOT NULL
    status: ENUM (pending, confirmed, canceled), NOT NULL
    created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

Payment

    payment_id: Primary Key, UUID, Indexed
    booking_id: Foreign Key, references Booking(booking_id)
    amount: DECIMAL, NOT NULL
    payment_date: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
    payment_method: ENUM (credit_card, paypal, stripe), NOT NULL

Review

    review_id: Primary Key, UUID, Indexed
    property_id: Foreign Key, references Property(property_id)
    user_id: Foreign Key, references User(user_id)
    rating: INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL
    comment: TEXT, NOT NULL
    created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

Message

    message_id: Primary Key, UUID, Indexed
    sender_id: Foreign Key, references User(user_id)
    recipient_id: Foreign Key, references User(user_id)
    message_body: TEXT, NOT NULL
    sent_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

Constraints
User Table

    Unique constraint on email.
    Non-null constraints on required fields.

Property Table

    Foreign key constraint on host_id.
    Non-null constraints on essential attributes.

Booking Table

    Foreign key constraints on property_id and user_id.
    status must be one of pending, confirmed, or canceled.

Payment Table

    Foreign key constraint on booking_id, ensuring payment is linked to valid bookings.

Review Table

    Constraints on rating values (1-5).
    Foreign key constraints on property_id and user_id.

Message Table

    Foreign key constraints on sender_id and recipient_id.

Indexing

    Primary Keys: Indexed automatically.
    Additional Indexes:
        email in the User table.
        property_id in the Property and Booking tables.
        booking_id in the Booking and Payment tables.


Potential redundancies and violations according to 3rd Normal Form:

1. In the user table, the role field is in enum. There should be a role table, refrewnced by role id on the users table. 

2. In the property table, location is left as a free string. it should be separated into its own table with columns for adress, city, state and country respectively. Location should then be referenced as location ID on the property table. 

3. in the booking table, total price is a derived price ( pricepernight x nights stayed). It should be removed from the schema and calculated when needed. 

4. In the booking table, status shoould also be made into its own table, with a reference to booking ststus id  on the booking table

5. in the payment table, payment method should also be made into its own table, with a reference to payment status id on the payment table.

Entities and their respective tables according to 3NF:

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

