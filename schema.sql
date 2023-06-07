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
 id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
 name VARCHAR(50)
);

-- Modify the animals table
ALTER SEQUENCE animals_id_seq RESTART WITH 1;
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id BIGINT REFERENCES species (id);
ALTER TABLE animals ADD COLUMN owner_id BIGINT REFERENCES owners (id);

-- Create a table named vets
CREATE TABLE vets(
  id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(255), 
  age INT, 
  date_of_graduation date
  );

-- Create a table named specialization.
CREATE TABLE specializations(
  id SERIAL PRIMARY KEY NOT NULL,
  vets_name VARCHAR(255), 
  species_name VARCHAR(255),
  species_id int,
  vet_id int
  );

-- Create a table named visits.
CREATE TABLE visits(
  id SERIAL PRIMARY KEY NOT NULL,
  animals_name VARCHAR(255), 
  vets_name VARCHAR(255), 
  date_of_visit date,
  animal_name int,
  vet_id int
  );