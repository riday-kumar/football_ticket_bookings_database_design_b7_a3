# Football Ticket Booking System - Database Design & SQL Queries

### Overview & Objectives

This repository contains the SQL schema, sample queries, and solutions for a Football Ticket Booking Database project built with PostgreSQL.

The database is designed to manage football match ticket sales, user bookings, and payment tracking while maintaining data integrity through primary keys, foreign keys, constraints, and enumerated status fields.

### Database Features

- User management with different roles
- Football match management
- Ticket booking system
- Payment status tracking
- Foreign key relationships for data integrity
- Unique seat allocation per match
- ENUM-based status management

### Database Schema

#### Users Table

- user_id(PK)
- full_name
- email
- role
- phone_number

#### Matches Table

- match_id(PK)
- fixture
- tournament_category
- base_ticket_price
- match_status

#### Bookings Table

- booking_id (PK)
- user_id (FK -> Users)
- match_id (FK -> Matches)
- seat_number
- payment_status
- total_cost

### Relationships

- One User can create multiple Bookings.
- One Match can have multiple Bookings.
- Each Booking belongs to exactly one User and one Match.

### Status Fields

| match_staus  | payment_status |
| ------------ | -------------- |
| Available    | Pending        |
| Selling Fast | Confirmed      |
| Sold Out     | Cancelled      |
| Postponed    | Refunded       |

## ERD Design Link

https://drive.google.com/file/d/1gzKWAjAV1D6WM411-8-mSp_eNmHF4OSQ/view
