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

