CREATE DATABASE IF NOT EXISTS ESPOLTEL;
USE ESPOLTEL;
CREATE TABLE IF NOT EXISTS users(
	id INT AUTO_INCREMENT PRIMARY KEY,
	ced VARCHAR(32) NOT NULL UNIQUE,
	first_name VARCHAR(100),
	middle_name VARCHAR(100),
	last_name VARCHAR(100),
	second_last_name VARCHAR(100),
	email VARCHAR(255) UNIQUE,
	country_code VARCHAR(5), -- E.g (+593), pero pueden haber trabajadores de otros países.
	phone_number VARCHAR(16),
	gender ENUM('masculino', 'femenino', 'otros') NOT NULL,
	password VARCHAR(255) NOT NULL -- No es el límite de caracteres por que será la contraseña con hash.
);

CREATE TABLE IF NOT EXISTS roles(
	id INT AUTO_INCREMENT PRIMARY KEY,
	rol_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS user_roles(
	user_id INT NOT NULL,
	rol_id INT NOT NULL,
	PRIMARY KEY(user_id, rol_id),
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(rol_id) REFERENCES roles(id)
);