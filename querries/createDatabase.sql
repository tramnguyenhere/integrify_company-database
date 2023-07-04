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

-- Create table projects
CREATE TABLE public.projects
(
    id serial,
    name character varying(50) NOT NULL,
    client character varying(50) NOT NULL,
    start_date date NOT NULL,
    deadline date NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.projects
    OWNER to admin;

-- Import file to table projects
psql -U admin -d company_database -c "\copy public.projects(name,client,start_date,deadline) FROM 'C:\Users\tramn\OneDrive\Desktop\code\integrify\backend\fs15_16_company-database\data\projects.csv' DELIMITER ',' CSV HEADER"

-- Create table team_project
create table if not exists public.team_project(
	team_id int references public.teams (id) on delete cascade on update cascade,
	project_id int references public.projects (id) on delete cascade on update cascade,
    PRIMARY KEY(team_id, project_id)
);

ALTER TABLE IF EXISTS public.team_project
    OWNER TO admin;

-- Import file to table team_project
psql -U admin -d company_database -c "\copy public.team_project(team_id, project_id) FROM 'C:\Users\tramn\OneDrive\Desktop\code\integrify\backend\fs15_16_company-database\data\team_project.csv' DELIMITER ',' CSV HEADER"

-- Create table employees
create table if not exists public.employees(
	id serial primary key,
	first_name varchar(30) not null,
	last_name varchar(30) not null,
	hire_date date not null,
	hourly_salary numeric(10,2) not null,
	title_id int references public.titles (id) on delete cascade on update cascade,
	manager_id int references public.employees(id) on delete cascade on update cascade,
	team_id int references public.teams (id) on delete cascade on update cascade
);

ALTER TABLE IF EXISTS public.employees
    OWNER TO admin;

-- Import file to table employees
psql -U admin -d company_database -c "\copy public.employees(first_name, last_name, hire_date, hourly_salary, title_id, manager_id, team_id) FROM 'C:\Users\tramn\OneDrive\Desktop\code\integrify\backend\fs15_16_company-database\data\employees.csv' DELIMITER ',' CSV HEADER NULL 'NULL'"

-- Create table hour_tracking
create table if not exists public.hour_tracking(
	employee_id int references public.employees (id) on delete cascade on update cascade,
	project_id int references public.projects (id) on delete cascade on update cascade,
	total_hours int not null,
	PRIMARY KEY(employee_id, project_id),
	check(total_hours > 0)
	
);

ALTER TABLE IF EXISTS public.hour_tracking
    OWNER TO admin;

-- Import file to table hour_tracking
psql -U admin -d company_database -c "\copy public.hour_tracking(employee_id, project_id, total_hours) FROM 'C:\Users\tramn\OneDrive\Desktop\code\integrify\backend\fs15_16_company-database\data\hour_tracking.csv' DELIMITER ',' CSV HEADER"