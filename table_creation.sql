

CREATE TABLE year(
    academic_year_pk INT GENERATED ALWAYS AS IDENTITY,
    academic_year_code INT UNIQUE,
    academic_year VARCHAR(30) NOT NULL,
    constraint pk_academic_year primary key (academic_year_pk)

)


CREATE TABLE IF NOT EXISTS term(
    term_pk INT GENERATED ALWAYS AS IDENTITY,
    term_code INT NOT NULL,
    term VARCHAR(20) NOT NULL,
    term_start_date VARCHAR(11) NOT NULL,
    term_end_date VARCHAR(11) NOT NULL,
    academic_year_pk INT NOT NULL,
    CONSTRAINT pk_term primary key (term_pk),
    CONSTRAINT fk_term_academic_year foreign key (academic_year_pk)
        REFERENCES public.year (academic_year_pk)
)

CREATE TABLE IF NOT EXISTS subject (
    subject_pk INT GENERATED ALWAYS AS IDENTITY,
    subject_code VARCHAR(10) NOT NULL,
    subject VARCHAR(100) NOT NULL,
    CONSTRAINT pk_subject PRIMARY KEY (subject_pk)
);


CREATE TABLE IF NOT EXISTS course(
    course_pk INT GENERATED ALWAYS AS IDENTITY,
    course_number INT NOT NULL,
    subject_pk INT NOT NULL,
    CONSTRAINT pk_course PRIMARY KEY (course_pk),
    CONSTRAINT fk_subject FOREIGN KEY (subject_pk)
        REFERENCES public.subject (subject_pk)
)

CREATE TABLE IF NOT EXISTS instructor(
    instructor_pk INT GENERATED ALWAYS AS IDENTITY,
    instructor VARCHAR(200) NOT NULL,
    CONSTRAINT pk_instructor PRIMARY KEY (instructor_pk)
)

CREATE TABLE IF NOT EXISTS schedule_type(
    schedule_type_pk INT GENERATED ALWAYS AS IDENTITY,
    schedule_type VARCHAR(200) NOT NULL,
    CONSTRAINT pk_schedule_type PRIMARY KEY (schedule_type_pk)
)

CREATE TABLE IF NOT EXISTS section(
    course_pk INT NOT NULL,
    term_pk INT NOT NULL,
    crn INT NOT NULL,
    instructor_pk INT NOT NULL,
    schedule_type_pk INT NOT NULL,
    subject_pk INT NOT NULL,
    section_pk INT GENERATED ALWAYS AS IDENTITY,
    section VARCHAR(10) NOT NULL,
    section_title VARCHAR(200) NOT NULL,
    current_enrollment INT NOT NULL,
    max_enrollment INT NOT NULL,
    seats_available INT NOT NULL,
    CONSTRAINT pk_section PRIMARY KEY (section_pk),
    CONSTRAINT fk_course FOREIGN KEY (course_pk)
        REFERENCES public.course (course_pk),
    CONSTRAINT fk_term FOREIGN KEY (term_pk)
        REFERENCES public.term (term_pk),
    CONSTRAINT fk_instructor FOREIGN KEY (instructor_pk)
        REFERENCES public.instructor (instructor_pk),
    CONSTRAINT fk_subject FOREIGN KEY (subject_pk)
        REFERENCES public.subject (subject_pk),
    CONSTRAINT fk_schedule_type FOREIGN KEY (schedule_type_pk)
        REFERENCES public.schedule_type (schedule_type_pk)
)




