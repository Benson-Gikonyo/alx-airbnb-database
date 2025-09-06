--INNER JOIN to retrieve all bookings and the respective users who made those bookings.

SELECT user_id, first_name, last_name, email, phone_number
FROM User
INNER JOIN Booking ON User.booking_id = Booking.booking_id;

--LEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.

SELECT *
FROM Review
LEFT JOIN Property
ON Review.review_id = Property.property_id;

--FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a
-- booking is not linked to a user.

SELECT User.user_id, User.first_name, User.last_name, User.email, User.phone_number
FROM User
FULL OUTER JOIN Booking ON User.user_id=Booking.user_id;


