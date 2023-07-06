-- Create a function `track_working_hours(employee_id, project_id, total_hours)` to insert data into the hour_tracking table to track the working hours for each employee on specific projects. Make sure that data need to be validated before the insertion.

CREATE FUNCTION TRACK_WORKING_HOURS(EMPLOYEE_ID INTEGER
, PROJECT_ID INTEGER, TOTAL_HOURS DECIMAL) RETURNS 
VOID AS 
	$$ begin if not exists (
	    select 1
	    from employees
	    where
	        id = employee_id
	) then raise exception 'Invalid employee_id';
	end if;
	if not exists (
	    select 1
	    from projects
	    where
	        id = project_id
	) then raise exception 'Invalid project_id';
	end if;
	insert into
	    hour_tracking (
	        employee_id,
	        project_id,
	        total_hours
	    )
	values (
	        employee_id,
	        project_id,
	        total_hours
	    );
END; 

$$ language plpgsql;

-- Create a function `create_project_with_teams` to create a project and assign teams to that project simultaneously.

CREATE FUNCTION CREATE_PROJECT_WITH_TEAMS(PROJECT_NAME 
VARCHAR, CLIENT VARCHAR, START_DATE DATE, DEADLINE 
DATE, TEAMS INTEGER[]) RETURNS VOID AS 
	$$ DECLARE project_id integer;
	team_id integer;
	BEGIN
	insert into
	    projects (
	        name,
	        client,
	        start_date,
	        deadline
	    )
	values (
	        project_name,
	        client,
	        start_date,
	        deadline
	    ) RETURNING id into project_id;
	FOREACH team_id in ARRAY teams
	loop
	insert into
	    team_project (team_id, project_id)
	values (team_id, project_id);
	end loop;
END; 

$$ LANGUAGE plpgsql;