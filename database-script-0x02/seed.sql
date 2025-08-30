-- user insert statements
insert into user (user_id, first_name, last_name, email, password_hash, phone number, role_id, created_at) values (5, 'Harriett', 'Pimlock', 'hpimlock4@indiatimes.com', '$2a$04$UjxcKbvOJ03/SVcTYgn.ruLydlPHn9BACIEfD46dYhGg5fKA4Sszy', '444-306-6468', 5, '2023-05-15 03:52:50');
insert into user (user_id, first_name, last_name, email, password_hash, phone number, role_id, created_at) values (6, 'Archambault', 'Jecks', 'ajecks5@bigcartel.com', '$2a$04$YFT26MbYa8v3rpztjR/oPuwMJrZ8PsVxaQs9602UDc8KknZU9/E2K', '634-975-2303', 6, '2023-03-24 15:46:41');
insert into user (user_id, first_name, last_name, email, password_hash, phone number, role_id, created_at) values (7, 'Benton', 'Parmer', 'bparmer6@macromedia.com', '$2a$04$rfxbQIM/FfD1r3OPlFfCL.QoxkuviufQPR.FA6aOR/xxhuvkkTuiK', '873-767-7700', 7, '2024-10-27 23:33:17');
insert into user (user_id, first_name, last_name, email, password_hash, phone number, role_id, created_at) values (8, 'Paddie', 'Sissens', 'psissens7@google.nl', '$2a$04$/VOM/kRiGgXNMlgOHXLuS.o.zUY.L.gBo3og0CZ395YuNAEfcHIs.', '424-894-0832', 8, '2024-01-02 13:47:33');
insert into user (user_id, first_name, last_name, email, password_hash, phone number, role_id, created_at) values (9, 'Vitia', 'Kinnin', 'vkinnin8@odnoklassniki.ru', '$2a$04$vNTeeK.FGheHsq6uLAkZpOqwuCPJcKQEKMBKLb9OQBH4oojGRpAW2', '280-527-9802', 9, '2024-05-30 12:40:15');
insert into user (user,id, first_name, last_name, email, password_hash, phone number, role_id, created_at) values (10, 'Adriana', 'Blackden', 'ablackden9@noaa.gov', '$2a$04$6cfXWIqSWlcqyJYzLwvQ7eggxymxFVYyQkc7l1woh/oK3aG0RwlU.', '586-988-8410', 10, '2024-07-07 18:54:07');

--Role insert statements
insert into Role (role_id, Role) values (1, 'guest');
insert into Role (role_id, Role) values (2, 'host');
insert into Role (role_id, Role) values (3, 'host');
insert into Role (role_id, Role) values (4, 'admin');
insert into Role (role_id, Role) values (5, 'admin');

--location insert statements
insert into location(location_id, address, city, state, country) values(1, '1299', 'nyeri', 'Central', 'Kenya');
insert into location(location_id, address, city, state, country) values(2, '101', 'nairobi', 'nairobi', 'Kenya');
insert into location(location_id, address, city, state, country) values(3, '2130', 'nyandarua', 'Central', 'Kenya');
insert into location(location_id, address, city, state, country) values(4, '12991', 'lodwar', 'north', 'Kenya');
insert into location(location_id, address, city, state, country) values(5, '1090', 'mombasa', 'mombasa', 'Kenya');
insert into location(location_id, address, city, state, country) values(6, '1112', 'nakuru', 'rift valley', 'Kenya');

--property insert statements
insert into property (property id, host id, name, description, location_id, pricepernight, created_at, updated_at) values (1, 1, 'jenga apartments', 'beautiful 3 bedroom apartments.', 1, '£7111.97', '2023-03-01 00:00:00', '2023-05-30 05:35:17');
insert into property (property id, host id, name, description, location_id, pricepernight, created_at, updated_at) values (2, 2, 'Goodness apartments', 'spatious 1 bedroom apartments', 2, '£2619.53', '2023-03-01 00:00:00', '2025-05-23 21:57:52');
insert into property (property id, host id, name, description, location_id, pricepernight, created_at, updated_at) values (3, 3, 'Rosalind Apartments', 'Spatious studio apartments.', 3, '£6037.73', '2023-03-01 00:00:00', '2023-05-04 18:10:27');
insert into property (property id, host id, name, description, location_id, pricepernight, created_at, updated_at) values (4, 4, 'Gloryview Apartments', 'gorgeous 2 bedroom apartments', 4, '£3138.88', '2023-03-01 00:00:00', '2024-07-02 06:46:14');
insert into property (property id, host id, name, description, location_id, pricepernight, created_at, updated_at) values (5, 5, 'Monalisa Apartments', 'beautiful and spatious 2 bedroom apartments', 5, '£1286.59', '2023-03-01 00:00:00', '2025-03-16 06:17:14');
insert into property (property id, host id, name, description, location_id, pricepernight, created_at, updated_at) values (6, 6, 'Amani Apartments', '4 bedroom house. own compound', 6, '£4909.84', '2023-03-01 00:00:00', '2024-06-06 21:11:36');

--booking status insert statements
insert into bookingStatus(booking_status_id, status_name) values (1, 'pending');
insert into bookingStatus(booking_status_id, status_name) values (2, 'cancelled');
insert into bookingStatus(booking_status_id, status_name) values (3, 'cancelled');
insert into bookingStatus(booking_status_id, status_name) values (4, 'pending');
insert into bookingStatus(booking_status_id, status_name) values (5, 'confirmed');
insert into bookingStatus(booking_status_id, status_name) values (6, 'confirmed');

--booking insert statements

insert into booking (booking_id, property_id, user_id, start_date, end_date, booking_status_id, created_at) values (1, 1, 1, '2025-06-02 20:18:24', '2023-03-03 10:58:40', 1, '2023-03-01 00:00:00');
insert into booking (booking_id, property_id, user_id, start_date, end_date, booking_status_id, created_at) values (2, 2, 2, '2023-10-09 23:46:31', '2023-03-05 08:29:56', 2, '2023-03-01 00:00:00');
insert into booking (booking_id, property_id, user_id, start_date, end_date, booking_status_id, created_at) values (3, 3, 3, '2025-05-13 03:54:56', '2024-03-29 05:13:37', 3, '2023-03-01 00:00:00');
insert into booking (booking_id, property_id, user_id, start_date, end_date, booking_status_id, created_at) values (4, 4, 4, '2024-04-26 18:46:32', '2023-09-21 15:12:37', 4, '2023-03-01 00:00:00');
insert into booking (booking_id, property_id, user_id, start_date, end_date, booking_status_id, created_at) values (5, 5, 5, '2025-08-25 20:58:22', '2023-06-30 09:46:01', 5, '2023-03-01 00:00:00');
insert into booking (booking_id, property_id, user_id, start_date, end_date, booking_status_id, created_at) values (6, 6, 6, '2025-07-13 01:31:12', '2023-03-11 10:43:02', 6, '2023-03-01 00:00:00');

--payment method insert statements

insert into paymentmethod(method_id, paymentmethod) values(1, 'mobile money');
insert into paymentmethod(method_id, paymentmethod) values(2, 'card');
insert into paymentmethod(method_id, paymentmethod) values(3, 'cash');

--payment insert statements
insert into payment(payment_id, booking_id, amount, payment_date, method_id) values (1, 1, 5000, '2023-09-21 15:12:37', 1 );
insert into payment(payment_id, booking_id, amount, payment_date, method_id) values (2, 1, 3000, '2023-09-21 15:12:37', 2 );
insert into payment(payment_id, booking_id, amount, payment_date, method_id) values (3, 1, 4000, '2023-09-21 15:12:37', 3 );
insert into payment(payment_id, booking_id, amount, payment_date, method_id) values (4, 1, 10000, '2023-09-21 15:12:37', 3 );
insert into payment(payment_id, booking_id, amount, payment_date, method_id) values (5, 1, 8000, '2023-09-21 15:12:37', 1 );
insert into payment(payment_id, booking_id, amount, payment_date, method_id) values (6, 1, 9000, '2023-09-21 15:12:37', 2 );

--review insert statements
insert into review(review_id, property_id, user_id, rating, message_body, sent_at) values ( 1, 1, 1, 4, 'great space. well reccommended', '2025-08-21 15:12:37')
insert into review(review_id, property_id, user_id, rating, message_body, sent_at) values ( 1, 1, 1, 1, 'mould everywhere, wont come again', '2025-08-21 15:12:37')
insert into review(review_id, property_id, user_id, rating, message_body, sent_at) values ( 1, 1, 1, 2, 'great space. bedbugs ruined my sleep', '2025-08-21 15:12:37')
insert into review(review_id, property_id, user_id, rating, message_body, sent_at) values ( 1, 1, 1, 3, 'tiny space. great amenities', '2025-08-21 15:12:37')
insert into review(review_id, property_id, user_id, rating, message_body, sent_at) values ( 1, 1, 1, 5, 'great space. great amenities', '2025-08-21 15:12:37')
insert into review(review_id, property_id, user_id, rating, message_body, sent_at) values ( 1, 1, 1, 5, 'great space. well reccommended', '2025-08-21 15:12:37')

--message insert statements
insert into message(message_id, sender_id, recipient_id, message_body, sent_at) values (1, 1, 1, 'hello, id like to rent a house','2023-09-21 15:12:37' )
insert into message(message_id, sender_id, recipient_id, message_body, sent_at) values (1, 1, 1, 'hello, id like to check out your house','2023-09-21 15:12:37' )
insert into message(message_id, sender_id, recipient_id, message_body, sent_at) values (1, 1, 1, 'hello, id like options on your offerings','2023-09-21 15:12:37' )
insert into message(message_id, sender_id, recipient_id, message_body, sent_at) values (1, 1, 1, 'hello, id like to rent a house','2023-09-21 15:12:37' )
insert into message(message_id, sender_id, recipient_id, message_body, sent_at) values (1, 1, 1, 'hello, id like to rent a house','2023-09-21 15:12:37' )
insert into message(message_id, sender_id, recipient_id, message_body, sent_at) values (1, 1, 1, 'hello, id like to rent a house','2023-09-21 15:12:37' )