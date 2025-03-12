INSERT INTO year(academic_year_code, academic_year)
SELECT DISTINCT
    academic_year_code,
    academic_year
FROM staging.dav_course_schedule stg
ORDER BY academic_year_code;

INSERT INTO term(academic_year_pk, term_code, term, term_start_date, term_end_date)
SELECT DISTINCT
    y.academic_year_pk,
    term_code,
    term,
    CAST(term_start_date AS DATE),
    CAST(term_end_date AS DATE)
FROM staging.dav_course_schedule stg
INNER JOIN public.year y ON y.academic_year_code = stg.academic_year_code
ORDER BY term_code;


INSERT INTO subject(subject_code, subject)
SELECT DISTINCT
    subject_code,
    subject
FROM staging.dav_course_schedule
ORDER BY subject_code;


INSERT INTO course(subject_pk, course_number)
SELECT DISTINCT
    s.subject_pk,
    course_number
FROM staging.dav_course_schedule stg
INNER JOIN public.subject s ON s.subject_code = stg.subject_code
ORDER BY s.subject_pk,
         stg.course_number;

INSERT INTO instructor(instructor)
SELECT DISTINCT
    instructor
FROM staging.dav_course_schedule
ORDER BY instructor;

INSERT INTO schedule_type(schedule_type)
SELECT DISTINCT
    schedule_type
FROM staging.dav_course_schedule
ORDER BY schedule_type;

INSERT INTO section(course_pk, term_pk, crn, instructor_pk, schedule_type_pk, subject_pk, section, section_title,
                    current_enrollment, max_enrollment, seats_available)
SELECT DISTINCT
    c.course_pk,
    t.term_pk,
    crn,
    i.instructor_pk,
    st.schedule_type_pk,
    s.subject_pk,
    section,
    section_title,
    current_enrollment,
    max_enrollment,
    seats_available
FROM staging.dav_course_schedule stg
INNER JOIN public.term t on t.term_code = stg.term_code
INNER JOIN public.instructor i on i.instructor = stg.instructor
INNER JOIN public.schedule_type st on st.schedule_type = stg.schedule_type
INNER JOIN public.subject s on s.subject_code = stg.subject_code
INNER JOIN public.course c on c.course_number = stg.course_number and c.subject_pk = s.subject_pk
ORDER BY
    stg.crn;





