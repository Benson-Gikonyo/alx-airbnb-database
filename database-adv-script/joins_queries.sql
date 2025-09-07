--INNER JOIN to retrieve all bookings and the respective users who made those bookings.

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


--LEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.
-- Order results by property name

SELECT p.property_id,
       p.name AS property_name,
       r.review_id,
       r.rating,
       r.comment,
       r.created_at
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
ORDER BY p.name;


--FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a
-- booking is not linked to a user.

SELECT User.user_id, User.first_name, User.last_name, User.email, User.phone_number
FROM User
FULL OUTER JOIN Booking ON User.user_id=Booking.user_id;


