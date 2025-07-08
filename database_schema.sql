-- Parfly Database Schema
-- PostgreSQL Database Structure for Parfly Delivery Management System

BEGIN;

-- Users table (base for all user types)
CREATE TABLE IF NOT EXISTS public.users
(
    user_id serial NOT NULL,
    full_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    email character varying(255) COLLATE pg_catalog."default" NOT NULL,
    password_hash text COLLATE pg_catalog."default" NOT NULL,
    phone character varying(20) COLLATE pg_catalog."default" NOT NULL,
    role character varying(10) COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_pkey PRIMARY KEY (user_id),
    CONSTRAINT users_email_key UNIQUE (email),
    CONSTRAINT users_phone_key UNIQUE (phone)
);

-- Drivers table (extends users for driver-specific data)
CREATE TABLE IF NOT EXISTS public.drivers
(
    driver_id serial NOT NULL,
    user_id integer,
    vehicle_type character varying(50) COLLATE pg_catalog."default" NOT NULL,
    vehicle_plate character varying(20) COLLATE pg_catalog."default" NOT NULL,
    is_available boolean DEFAULT true,
    CONSTRAINT drivers_pkey PRIMARY KEY (driver_id),
    CONSTRAINT drivers_user_id_key UNIQUE (user_id),
    CONSTRAINT drivers_vehicle_plate_key UNIQUE (vehicle_plate)
);

-- Deliveries table (core business logic)
CREATE TABLE IF NOT EXISTS public.deliveries
(
    delivery_id serial NOT NULL,
    sender_id integer,
    receiver_id integer,
    driver_id integer,
    pickup_address text COLLATE pg_catalog."default" NOT NULL,
    dropoff_address text COLLATE pg_catalog."default" NOT NULL,
    status character varying(20) COLLATE pg_catalog."default" DEFAULT 'pending'::character varying,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    payer character varying(8) COLLATE pg_catalog."default" NOT NULL DEFAULT 'sender'::character varying,
    add_info text COLLATE pg_catalog."default",
    pickup_lat numeric(10, 6),
    pickup_long numeric(10, 6),
    dropoff_lat numeric(10, 6),
    dropoff_long numeric(10, 6),
    parcel_amount integer,
    accepted_at timestamp without time zone,
    received_at timestamp without time zone,
    sender_name text COLLATE pg_catalog."default",
    receiver_name text COLLATE pg_catalog."default",
    driver_name text COLLATE pg_catalog."default",
    vehicle text COLLATE pg_catalog."default",
    vehicle_plate text COLLATE pg_catalog."default",
    delivery_fee numeric(10, 2) DEFAULT 0,
    commission_amount numeric(10, 2) DEFAULT 0,
    driver_earnings numeric(10, 2) DEFAULT 0,
    commission_deducted boolean DEFAULT false,
    additional_compensation numeric(10, 2) DEFAULT 0,
    tip numeric(10, 2) DEFAULT 0,
    receiver_contact text COLLATE pg_catalog."default",
    duration_minutes numeric(10, 2) DEFAULT 0,
    distance_km numeric(10, 2) DEFAULT 0,
    pickup_city text COLLATE pg_catalog."default",
    dropoff_city text COLLATE pg_catalog."default",
    arrival_time timestamp without time zone,
    is_arrived boolean DEFAULT false,
    last_eta_update timestamp without time zone DEFAULT now(),
    CONSTRAINT deliveries_pkey PRIMARY KEY (delivery_id)
);

-- Notifications table
CREATE TABLE IF NOT EXISTS public.notifications
(
    notification_id serial NOT NULL,
    user_id integer,
    message text COLLATE pg_catalog."default" NOT NULL,
    status character varying(10) COLLATE pg_catalog."default" DEFAULT 'unread'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT notifications_pkey PRIMARY KEY (notification_id)
);

-- Ratings table (feedback system)
CREATE TABLE IF NOT EXISTS public.ratings
(
    rating_id serial NOT NULL,
    delivery_id integer,
    customer_id integer,
    driver_id integer,
    rating integer NOT NULL,
    feedback text COLLATE pg_catalog."default",
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT ratings_pkey PRIMARY KEY (rating_id),
    CONSTRAINT ratings_delivery_id_key UNIQUE (delivery_id)
);

-- Tracking table (real-time location tracking)
CREATE TABLE IF NOT EXISTS public.tracking
(
    tracking_id serial NOT NULL,
    delivery_id integer,
    driver_id integer,
    latitude numeric(10, 6) NOT NULL,
    longitude numeric(10, 6) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT tracking_pkey PRIMARY KEY (tracking_id)
);

-- Foreign Key Constraints
ALTER TABLE IF EXISTS public.deliveries
    ADD CONSTRAINT deliveries_driver_id_fkey FOREIGN KEY (driver_id)
    REFERENCES public.drivers (driver_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE SET NULL;

ALTER TABLE IF EXISTS public.deliveries
    ADD CONSTRAINT deliveries_receiver_id_fkey FOREIGN KEY (receiver_id)
    REFERENCES public.users (user_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE SET NULL;

ALTER TABLE IF EXISTS public.deliveries
    ADD CONSTRAINT deliveries_sender_id_fkey FOREIGN KEY (sender_id)
    REFERENCES public.users (user_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE SET NULL;

ALTER TABLE IF EXISTS public.drivers
    ADD CONSTRAINT drivers_user_id_fkey FOREIGN KEY (user_id)
    REFERENCES public.users (user_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id)
    REFERENCES public.users (user_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.ratings
    ADD CONSTRAINT ratings_customer_id_fkey FOREIGN KEY (customer_id)
    REFERENCES public.users (user_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.ratings
    ADD CONSTRAINT ratings_delivery_id_fkey FOREIGN KEY (delivery_id)
    REFERENCES public.deliveries (delivery_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.ratings
    ADD CONSTRAINT ratings_driver_id_fkey FOREIGN KEY (driver_id)
    REFERENCES public.drivers (driver_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.tracking
    ADD CONSTRAINT tracking_delivery_id_fkey FOREIGN KEY (delivery_id)
    REFERENCES public.deliveries (delivery_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.tracking
    ADD CONSTRAINT tracking_driver_id_fkey FOREIGN KEY (driver_id)
    REFERENCES public.drivers (driver_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

-- Indexes for performance optimization
CREATE INDEX IF NOT EXISTS drivers_user_id_key
    ON public.drivers(user_id);

CREATE INDEX IF NOT EXISTS ratings_delivery_id_key
    ON public.ratings(delivery_id);

-- Sample data insertion (optional - for development)
-- You can uncomment these lines to populate with test data

/*
-- Insert sample admin user
INSERT INTO public.users (full_name, email, password_hash, phone, role) 
VALUES ('Admin User', 'admin@parfly.com', '$2b$12$hashedpassword', '+1234567890', 'admin');

-- Insert sample customer
INSERT INTO public.users (full_name, email, password_hash, phone, role) 
VALUES ('John Doe', 'john@example.com', '$2b$12$hashedpassword', '+1234567891', 'customer');

-- Insert sample driver
INSERT INTO public.users (full_name, email, password_hash, phone, role) 
VALUES ('Driver One', 'driver@example.com', '$2b$12$hashedpassword', '+1234567892', 'driver');

-- Link driver to users table
INSERT INTO public.drivers (user_id, vehicle_type, vehicle_plate, is_available) 
VALUES (3, 'Motorcycle', 'ABC-123', true);
*/

END;
