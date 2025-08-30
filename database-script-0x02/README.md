This project models a simplified accommodation booking platform (similar to Airbnb) using a relational database normalized to 3rd Normal Form (3NF).

It includes tables for users, roles, properties, locations, bookings, payments, reviews, and messages.

The provided SQL INSERT statements populate the database with real-world sample data for testing.

 Schema Overview

Role – Defines user roles (guest, host, admin).

User – Stores platform users with references to roles.

Location – Stores structured location data for properties.

Property – Listings created by hosts, linked to locations.

BookingStatus – Possible booking states (pending, confirmed, canceled).

Booking – Reservations made by guests for properties.

PaymentMethod – Supported payment options (credit card, PayPal, Stripe).

Payment – Records payments for bookings.

Review – Guest reviews and ratings for properties.

Message – Communication between users.

sample insert statements:

