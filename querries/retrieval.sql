-- - Retrieve the team names and their corresponding project count.
select
    teams.team_name,
    count(team_project.project_id) as project_count
from teams
    right join team_project on teams.id = team_project.team_id
group by
    teams.id,
    teams.team_name;