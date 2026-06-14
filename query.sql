create type user_role as enum('Ticket Manager','Football Fan');
create type match_status as enum('Available', 'Selling Fast', 'Sold Out', 'Postponed');
create type payment_status as enum('Pending', 'Confirmed', 'Cancelled', 'Refunded');

create table if not exists users(
  user_id serial primary key ,
  full_name varchar(150) not null,
  email varchar(120) not null unique,
  role user_role not null,
  phone_number varchar(20)
)

create table if not exists matches(
  match_id serial primary key,
  fixture varchar(200) not null,
  tournament_category varchar(200) not null,
  base_ticket_price numeric(10,2) not null check (base_ticket_price > 0),
  match_status match_status not null
)

create table if not exists bookings(
  booking_id serial primary key,
  user_id int not null references users(user_id) on delete cascade,
  match_id int not null references matches(match_id) on delete cascade,
  seat_number varchar,
  payment_status payment_status,
  total_cost numeric(10,2) not null check (total_cost > 0),
  unique(match_id,seat_number)
)

-- insert sample data into users table
INSERT INTO Users (full_name, email, role, phone_number) VALUES
('Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
('Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
('Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
('Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);


-- insert sample data into matches table
INSERT INTO Matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available');


-- insert sample data into bookings table
INSERT INTO Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL, NULL, 150.00),
(505, 3, 102, 'C-20', 'Pending', 120.00);

-- Query 1: Retrieve all upcoming football matches belonging to the 'Champions League' where the match status is 'Available'.
select match_id, fixture, base_ticket_price from matches 
  where tournament_category = 'Champions League'
  and match_status = 'Available'


-- Query 2: Search for all users whose full names start with 'Tanvir' or contain the phrase 'Haque' (case-insensitive).
select user_id, full_name, email from users 
  where full_name ilike 'Tanvir%'
  or full_name ilike '%Haque%'


-- Query 3: Retrieve all booking records where the payment status is missing (NULL), replacing the empty result with 'Action Required'.
select booking_id,user_id,match_id, 
coalesce(payment_status::text,'Action Required') as systematic_status 
from bookings 
where payment_status is null;