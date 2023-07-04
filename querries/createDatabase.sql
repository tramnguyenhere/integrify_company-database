-- Create database by superuser
\c - tramnguyen
CREATE DATABASE company_database;

-- Create table titles
CREATE TABLE public.titles
(
    id serial,
    name character varying(30) NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.titles
    OWNER to admin;

-- Import file to table titles
psql -U admin -d company_database -c "\copy public.titles(name) FROM 'C:\Users\tramn\OneDrive\Desktop\code\integrify\backend\fs15_16_company-database\data\titles.csv' DELIMITER ',' CSV HEADER"

-- Create table teams
CREATE TABLE public.teams
(
    id serial,
    team_name character varying(30) NOT NULL,
    location character varying(30) NOT NULL,
    PRIMARY KEY (id)
);

-- Import file to table teams
ALTER TABLE IF EXISTS public.teams
    OWNER to admin;

psql -U admin -d company_database -c "\copy public.teams(team_name, location) FROM 'C:\Users\tramn\OneDrive\Desktop\code\integrify\backend\fs15_16_company-database\data\teams.csv' DELIMITER ',' CSV HEADER"