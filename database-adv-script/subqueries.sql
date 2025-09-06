-- a query to find all properties where the average rating is greater than 4.0 using a subquery
SELECT Property.property_id, 
       Property.name AS property_name, 
       Property.price_per_night, 
       Location.city, Location.country
FROM Property 
JOIN Location  ON Property.location_id = Location.location_id
WHERE Property.property_id IN (
    SELECT Review.property_id
    FROM Review 
    GROUP BY Review.property_id
    HAVING AVG(Review.rating) > 4.0
);


--correlated subquery to find users who have made more than 3 bookings.

SELECT User.user_id, 
       User.first_name,
       User.last_name, 
       User.email
FROM User 
WHERE (
    SELECT COUNT(*)
    FROM Booking 
    WHERE Booking.user_id = User.user_id
) > 3;

--Query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.

SELECT User.user_id,
       User.first_name,
       User.last_name,
       COUNT(Booking.booking_id) AS total_bookings
FROM User 
LEFT JOIN Booking  ON User.user_id = Booking.user_id
GROUP BY User.user_id, User.first_name, User.last_name
ORDER BY total_bookings DESC;

--A window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have
-- received.

SELECT Property.property_id,
       Property.name AS property_name,
       COUNT(Booking.booking_id) AS total_bookings,
       RANK() OVER (ORDER BY COUNT(Booking.booking_id) DESC) AS booking_rank
FROM Property 
LEFT JOIN Booking  ON Property.property_id = Booking.property_id
GROUP BY Property.property_id, Property.name
ORDER BY booking_rank;

