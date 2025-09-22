BEGIN;

CREATE TABLE IF NOT EXISTS public.Student_group
(
	group_id serial PRIMARY KEY,
	group_name varchar(20) UNIQUE NOT NULL,
	faculty VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS public.Student 
(
	student_id serial PRIMARY KEY,
	first_name varchar(60) NOT NULL,
	last_name varchar(60) NOT NULL,
	email varchar(100) UNIQUE NOT NULL,
	group_id integer NOT NULL,
	
	FOREIGN KEY (group_id) REFERENCES public.Student_group (group_id) 
	ON UPDATE NO ACTION
	ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS public.Teacher
(
	teacher_id serial PRIMARY KEY,
	first_name varchar(60) NOT NULL,
	last_name varchar(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS public.Subject
(
	subject_id serial PRIMARY KEY,
	subject_name varchar(100) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS public.Teacher_Subject
(
	teacher_id integer NOT NULL,
	subject_id integer NOT NULL,
	
	PRIMARY KEY (teacher_id, subject_id),
	
	FOREIGN KEY (teacher_id) REFERENCES public.Teacher (teacher_id)
	ON UPDATE NO ACTION
	ON DELETE CASCADE,
	
	FOREIGN KEY (subject_id) REFERENCES public.Subject (subject_id)
	ON UPDATE NO ACTION
	ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS public.Class
(
	class_id serial PRIMARY KEY,
	subject_id integer NOT NULL,
	teacher_id integer NOT NULL,
	class_date timestamp with time zone NOT NULL,
	class_type varchar(60) NOT NULL,

	FOREIGN KEY (subject_id) REFERENCES public.Subject (subject_id)
	ON UPDATE NO ACTION
	ON DELETE CASCADE,

	FOREIGN KEY (teacher_id) REFERENCES public.Teacher (teacher_id)
	ON UPDATE NO ACTION
	ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS public.Attendance
(
	attendance_id serial PRIMARY KEY,
	class_id integer NOT NULL,
	student_id integer NOT NULL,
	status varchar(20) NOT NULL,

	FOREIGN KEY (class_id) REFERENCES public.Class (class_id)
	ON UPDATE NO ACTION
	ON DELETE CASCADE,

	FOREIGN KEY (student_id) REFERENCES public.Student (student_id)
	ON UPDATE NO ACTION
	ON DELETE CASCADE
);

END;
