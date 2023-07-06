-- - Retrieve the team names and their corresponding project count.

select
    teams.team_name,
    count(team_project.project_id) as project_count
from teams
    left join team_project on teams.id = team_project.team_id
group by
    teams.id,
    teams.team_name;

-- Retrieve the projects managed by the managers whose first name starts with "J" or "D".

select distinct p.*
from projects p
    join team_project tp on p.id = tp.project_id
    join employees e on tp.team_id = e.team_id
    join employees manager on e.manager_id = manager.id
where
    manager.first_name like 'J%'
    or manager.first_name like 'D%'
order by id;

-- Retrieve all the employees (both directly and indirectly) working under Andrew Martin

select e2.*
from employees e1
    join employees e2 ON e1.id = e2.manager_id
where
    e1.first_name = 'Andrew'
    and e1.last_name = 'Martin';

-- Retrieve all the employees (both directly and indirectly) working under Robert Brown

select e2.*
from employees e1
    join employees e2 ON e1.id = e2.manager_id
where
    e1.first_name = 'Robert'
    and e1.last_name = 'Brown';

-- Retrieve the average hourly salary for each title.

select
    titles.name,
    avg(hourly_salary) as average_hourly_salary
from titles
    join employees ON titles.id = employees.title_id
group by
    titles.id,
    titles.name
order by avg(hourly_salary);

-- Retrieve the employees who have a higher hourly salary than their respective team's average hourly salary.

select
    e.*,
    team_avg.team_avg_salary
from employees e
    join (
        select
            team_id,
            AVG(hourly_salary) AS team_avg_salary
        from employees
        group by
            team_id
    ) as team_avg on e.team_id = team_avg.team_id
where
    e.hourly_salary > team_avg.team_avg_salary
order by team_id;

-- Retrieve the projects that have more than 3 teams assigned to them.

select
    projects.*,
    count(team_project.team_id) as number_of_assigned_teams
from projects
    join team_project on projects.id = team_project.project_id
group by projects.id
having
    count(team_project.team_id) > 3;

-- Retrieve the total hourly salary expense for each team.

select
    team_id,
    sum(hourly_salary) as total_hourly_salary_expense
from employees
where team_id is not null
group by team_id
order by team_id;