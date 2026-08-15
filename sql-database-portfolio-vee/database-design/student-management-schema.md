# Student Management Database Design

This example shows a normalised relational design created from student, programme, course and enrolment information.

## Final 3NF Structure

```mermaid
erDiagram
    STUDENT {
        TEXT StudentID PK
        TEXT Name
        TEXT DateOfBirth
        TEXT Gender
        TEXT Address
        TEXT Email
        TEXT Phone
    }

    PROGRAMME {
        TEXT ProgrammeID PK
        TEXT Degree
    }

    COURSE_OFFERING {
        TEXT CourseNo PK
        INTEGER Year PK
        TEXT Title
        INTEGER Pts
    }

    STUDENT_PROGRAMME_YEAR {
        TEXT StudentID PK, FK
        INTEGER Year PK
        TEXT ProgrammeID FK
    }

    ENROLMENT {
        TEXT StudentID PK, FK
        TEXT CourseNo PK, FK
        INTEGER Year PK, FK
        TEXT Grade
    }

    STUDENT ||--o{ STUDENT_PROGRAMME_YEAR : has
    PROGRAMME ||--o{ STUDENT_PROGRAMME_YEAR : belongs_to
    STUDENT ||--o{ ENROLMENT : has
    COURSE_OFFERING ||--o{ ENROLMENT : contains
    STUDENT_PROGRAMME_YEAR ||--o{ ENROLMENT : contextualises
```

## Tables

### STUDENT
Primary key: `StudentID`

### PROGRAMME
Primary key: `ProgrammeID`

### STUDENT_PROGRAMME_YEAR
Primary key: `(StudentID, Year)`

Foreign keys:
- `StudentID` → `STUDENT`
- `ProgrammeID` → `PROGRAMME`

### COURSE_OFFERING
Primary key: `(CourseNo, Year)`

### ENROLMENT
Primary key: `(StudentID, CourseNo, Year)`

Foreign keys:
- `StudentID` → `STUDENT`
- `(CourseNo, Year)` → `COURSE_OFFERING`
- `(StudentID, Year)` → `STUDENT_PROGRAMME_YEAR`

## Normalisation

The design was developed by identifying functional dependencies and moving from a flat structure through:

**1NF → 2NF → 3NF**

The final structure reduces duplicated data and preserves historical programme and course information.
