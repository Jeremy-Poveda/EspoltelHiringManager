show databases;
CREATE DATABASE IF NOT EXISTS ESPOLTEL_bd;
use ESPOLTEL_bd;

DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id_user BINARY(16) NOT NULL, 
    identification VARCHAR(10) NOT NULL UNIQUE CHECK (identification REGEXP '^[0-9]{10}$'),
	first_name VARCHAR (100) NOT NULL,
    middle_name VARCHAR(100),
	last_name VARCHAR (100) NOT NULL,
    second_last_name VARCHAR (100) NOT NULL,
    email VARCHAR (255) UNIQUE NOT NULL,
    country_code VARCHAR (5),
    phone_number VARCHAR(16),
    gender ENUM('Male','Female', 'Other'),
    password VARCHAR(255) NOT NULL,
    PRIMARY KEY(id_user)
);
DROP TABLE IF EXISTS directors;
CREATE TABLE directors (
	id_director BINARY(16) NOT NULL,
	PRIMARY KEY (id_director),
    FOREIGN KEY (id_director) REFERENCES users(id_user)
);
DROP TABLE IF EXISTS managers;
CREATE TABLE managers (
	id_manager BINARY(16) NOT NULL,
	PRIMARY KEY (id_manager),
    FOREIGN KEY (id_manager) REFERENCES users(id_user)
);
DROP TABLE IF EXISTS human_talent_users;
CREATE TABLE human_talent_users (
	id_human_talent BINARY(16) NOT NULL,
	PRIMARY KEY (id_human_talent),
    FOREIGN KEY (id_human_talent) REFERENCES users(id_user)
);
DROP TABLE IF EXISTS applicants;
CREATE TABLE applicants (
	id_applicant BINARY(16) NOT NULL,
	PRIMARY KEY (id_applicant),
    FOREIGN KEY (id_applicant) REFERENCES users(id_user)
);

DROP TABLE IF EXISTS locations;
CREATE TABLE locations (
	id_location INT AUTO_INCREMENT NOT NULL,
    name VARCHAR (100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_location)
);

DROP TABLE IF EXISTS projects;
CREATE TABLE projects (
	id_project BINARY(16) NOT NULL,
    id_director BINARY(16) NOT NULL,
    id_location INT NOT NULL,
    name VARCHAR (100) NOT NULL,
    description TEXT NOT NULL,
    creation_date DATETIME NOT NULL,
    start_date DATE NOT NULL, 
    end_date DATE NOT NULL,
    code VARCHAR(6) UNIQUE,
    PRIMARY KEY (id_project),
    FOREIGN KEY (id_director) REFERENCES directors(id_director),
    FOREIGN KEY(id_location) REFERENCES locations(id_location)
);
DROP TABLE IF EXISTS positions;
CREATE TABLE positions (
	id_position INT AUTO_INCREMENT NOT NULL,
    name VARCHAR (100) UNIQUE NOT NULL,
    PRIMARY KEY (id_position)
);
DROP TABLE IF EXISTS profile_status;
CREATE TABLE profile_status(
	id_status INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(100) UNIQUE NOT NULL,
    PRIMARY KEY (id_status)
);
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	id_profile BINARY(16) NOT NULL,
    id_project BINARY(16) NOT NULL,
    id_position INT NOT NULL, 
    id_status INT NOT NULL, 
    id_RRHH_USER BINARY(16) NOT NULL,
    name VARCHAR (100) NOT NULL, 
    activities TEXT NOT NULL, 
    referencial_salary DECIMAL (2,1) NOT NULL, 
    creation_date DATETIME,
    PRIMARY KEY (id_profile),
    FOREIGN KEY (id_project) REFERENCES projects(id_project),
    FOREIGN KEY (id_position) REFERENCES positions(id_position),
    FOREIGN KEY (id_status) REFERENCES profile_status(id_status),
    FOREIGN KEY (id_RRHH_USER) REFERENCES human_talent_users(id_human_talent)
);


CREATE TABLE requirements (
	id_requirement INT AUTO_INCREMENT NOT NULL,
    defintion TEXT,
    PRIMARY KEY (id_requirement)
);

CREATE TABLE profile_requirement (
    id_profile BINARY(16) NOT NULL,
    id_requirement INT NOT NULL,
    PRIMARY KEY(id_profile, id_requirement),
    FOREIGN KEY (id_profile) REFERENCES profiles(id_profile)
);
DROP TABLE IF EXISTS application_types;
CREATE TABLE application_types (
		id_application_type INT AUTO_INCREMENT NOT NULL,
        name VARCHAR (50) NOT NULL,
        PRIMARY KEY (id_application_type)
);

CREATE TABLE applications (
	id_application BINARY(16) NOT NULL,
    id_profile BINARY(16) NOT NULL,
    id_applicant BINARY(16) NOT NULL,
    id_type INT NOT NULL,
    has_priority BOOLEAN NOT NULL,
    postulation_date DATETIME NOT NULL,
    PRIMARY KEY(id_application),
    FOREIGN KEY (id_profile) REFERENCES profiles (id_profile),
    FOREIGN KEY (id_applicant) REFERENCES applicants (id_applicant),
    FOREIGN KEY (id_type) REFERENCES application_types (id_application_type)
);

CREATE TABLE application_documents (
	id_application_documents INT NOT NULL,
    id_application BINARY(16) NOT NULL,
    curriculum_path VARCHAR(255) NOT NULL UNIQUE,
    id_card_copy VARCHAR(255) NOT NULL UNIQUE,
    PRIMARY KEY (id_application_documents),
    FOREIGN KEY (id_application) REFERENCES applications(id_application)
);

CREATE TABLE job_application_repository (
	id_application BINARY(16) NOT NULL,
    PRIMARY KEY (id_application),
    FOREIGN KEY (id_application) REFERENCES applications(id_application)
);


CREATE TABLE contract_states(
	id_contract_state INT AUTO_INCREMENT NOT NULL,
	PRIMARY KEY (id_contract_state)
    
);

CREATE TABLE contracts (
	id_contract BINARY (16) NOT NULL,
    id_application BINARY(16) NOT NULL,
    id_manager BINARY(16) NOT NULL,
    id_contract_state INT NOT NULL,
	path_contract_file TEXT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    title TEXT, 
    description TEXT NOT NULL,
    salary DECIMAL(10,2) UNSIGNED NOT NULL,
    payment_terms VARCHAR(30) NOT NULL,
	penalty_clause TEXT NOT NULL,
    confidentially_clause BOOLEAN NOT NULL,
    PRIMARY KEY (id_contract),
    FOREIGN KEY (id_application) REFERENCES applications (id_application),
    FOREIGN KEY (id_manager) REFERENCES managers(id_manager),
    FOREIGN KEY (id_contract_state) REFERENCES contract_states (id_contract_state)
);
DROP TABLE IF EXISTS interview_states;
CREATE TABLE interview_states (
	state_id INT AUTO_INCREMENT NOT NULL, 
    name VARCHAR(50) UNIQUE NOT NULL,
    PRIMARY KEY (state_id)
);

CREATE TABLE interviews (
	id_interview INT AUTO_INCREMENT NOT NULL, 
    id_application BINARY(16) NOT NULL,
	id_state INT NOT NULL,
    id_location INT NOT NULL,
    scheduled_date DATE NOT NULL,
    PRIMARY KEY (id_interview),
    FOREIGN KEY (id_application) REFERENCES applications (id_application),
    FOREIGN KEY (id_location) REFERENCES locations (id_location),
    FOREIGN KEY (id_state) REFERENCES interview_states (state_id)
);

CREATE TABLE interview_results (
	id_interview INT NOT NULL, 
    id_interview_result INT NOT NULL, 
    observations TEXT NOT NULL,
    approved BOOLEAN NOT NULL,
    PRIMARY KEY (id_interview, id_interview_result),
    FOREIGN KEY (id_interview) REFERENCES interviews (id_interview)
);


CREATE TABLE hiring_form_format (
	id_hiring_form INT AUTO_INCREMENT NOT NULL, 
    file VARCHAR(100) NOT NULL, 
    name VARCHAR (100) NOT NULL,
    PRIMARY KEY (id_hiring_form)
);

CREATE TABLE hiring_form_document_employee (
	id_hiring_form INT NOT NULL,
    id_application BINARY(16) NOT NULL,
    PRIMARY KEY(id_hiring_form ,id_application),
	FOREIGN KEY (id_hiring_form) REFERENCES hiring_form_format(id_hiring_form),
	FOREIGN KEY (id_application) REFERENCES applications (id_application)
);



CREATE TABLE employees (
	id_employee BINARY(16) NOT NULL,
    id_contract BINARY(16) NOT NULL,
	PRIMARY KEY (id_employee),
    FOREIGN KEY (id_employee) REFERENCES users(id_user),
	FOREIGN KEY (id_contract) REFERENCES contracts(id_contract)
);
DROP TABLE IF EXISTS preferred_profile_employees;
CREATE TABLE preferred_profile_employees (
	id_profile BINARY(16) NOT NULL, 
    id_employee BINARY(16) NOT NULL
    
);
