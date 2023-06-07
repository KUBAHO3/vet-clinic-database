/* Populate database with sample data. */

INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered,weight_kg) values(1, 'Agumon', '2020-03-02', 0, true, 10.23);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) values(2, 'Gabumon', '2018-11-15', 2, true, 8),(3, 'Pikachu', '2021-01-07', 1, false, 15.04),(4, 'Devimon', '2017-05-12', 5, true,11);

INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (5 ,'Charmander', '2020-02-08', 0, false, -11);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (6 ,'Plantmon', '2021-11-15', 2, true, -5.7);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (7 ,'Squirtle', '1993-04-02', 3, false, -12.13);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (8 ,'Angemon', '2005-06-12', 3, true, -45);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (9 ,'Boarmon', '2005-06-07', 7, true, 20.4);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (10 ,'Blossom', '1998-10-13', 3, true, 17);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (11 ,'Ditto', '2022-05-14', 4, true, 22);

-- Insering data in owners table
INSERT INTO owners (id, full_name, age) VALUES (DEFAULT, 'Sam Smith', 34), (DEFAULT, 'Jennifer Orwell', 19), (DEFAULT, 'Melody Pond', 45), (DEFAULT, 'Dean Winchester', 14), (DEFAULT, 'Jodie Whittaker', 38), (DEFAULT, 'Bob', 45);

-- Inserting data into species table
INSERT INTO species (id, name) VALUES (DEFAULT, 'Pokemon'), (DEFAULT, 'Digimon');

-- Update animals Table. 
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE name NOT LIKE '%mon';

-- Modify your inserted animals to include owner information (owner_id):
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name = 'Gabumon' OR name = 'Pikachu';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name = 'Angemon' OR name = 'Boarmon';

-- Insert the following data for vets:
INSERT INTO vets(name,age,date_of_graduation) values('William Tatcher',45,'2000-04-23'),('Maisy Smith',26,'2019-01-17'),('Stephanie Mendez',45,'1981-05-04'),('Jack Harkness',38,'2008-06-08');
