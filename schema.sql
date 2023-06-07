/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

CREATE TABLE animals(
	id BIGSERIAL NOT NULL PRIMARY KEY,
	name VARCHAR UNIQUE NOT NULL, 
	date_of_birth DATE, 
	escape_attempts INTEGER, 
	neutered BOOLEAN, 
	weight_kg DECIMAL
);

--Adding new colum to the table
ALTER TABLE animals ADD COLUMN species VARCHAR;

-- Create owners table 
CREATE TABLE owners (
 id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 full_name VARCHAR(50),
 age INT
);

-- Create species table 
CREATE TABLE species (
 id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 name VARCHAR(50)
);
