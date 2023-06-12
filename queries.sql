--Queries that provide answers to the questions from all projects.

-- Find all animals whose name ends in "mon".
select * from animals where name LIKE '%mon';
-- List of the name of all animals born between 2016 and 2019.
select name from animals where date_of_birth  BETWEEN '2016-01-01' AND '2019-12-31';
-- List of the name of all animals that are neutered and have less than 3 escape attempts.
select name from animals where escape_attempts < 3 AND neutered =true;
-- List of date of birth of all animals named either "Agumon" or "Pikachu".
select date_of_birth from animals where name='Agumon' OR name='Pikachu';
-- List of name and escape attempts of animals that weigh more than 10.5kg
select name,escape_attempts from animals where weight_kg > 10.5;
-- Find all animals that are neutered.
select * from animals where neutered =true;
-- Find all animals not named Gabumon.
select * from animals where name!='Gabumon' ;
-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
select * from animals where weight_kg>=10.4 AND weight_kg<=17.3;

-- starting a transaction and update animal table by setting the species column to unspecified and rollback.
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals SET species = 'pokemon' WHERE species = '';
SELECT species FROM animals;
-- Commit the transaction.
COMMIT;
SELECT species FROM animals;

-- Inside a transaction delete all records in the animals table, then roll back the transaction.
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- STARTNG A TRANSACTION:
BEGIN;
-- Delete all animals born after Jan 1st, 2022.
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
-- Creating a savepoint for the transaction.
SAVEPOINT savepoint_1;
-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1;
-- Rollback to the savepoint
ROLLBACK TO SAVEPOINT savepoint_1;
-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
-- Commit transaction
COMMIT;

-- How many animals are there?
SELECT count(*) FROM animals;
-- How many animals have never tried to escape?
SELECT count(*) FROM animals WHERE escape_attempts = 0;
-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT neutered,MAX(escape_attempts) FROM animals GROUP BY neutered;
-- What is the minimum and maximum weight of each type of animal?
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-12-31' AND '2000-12-31' GROUP BY species;

-- What animals belong to Melody Pond? 
SELECT name, full_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Melody Pond';
-- List animals that are pokemon. 
SELECT animals.name, species.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
-- List of owners and their animals, remember to include those that don't own any animal. 
SELECT name, full_name FROM animals FULL JOIN owners ON animals.owner_id = owners.id;
-- How many animals are there per species? 
SELECT COUNT(animals.name), species.name FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;
-- List all Digimon owned by Jennifer Orwell. 
SELECT owners.full_name, animals.name AS animal_name, species.name AS species_name FROM animals JOIN owners ON owners.id = animals.owner_id JOIN species ON species.id = animals.species_id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';
-- List all animals owned by Dean Winchester that haven't tried to escape. 
SELECT name, escape_attempts, full_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE escape_attempts = 0 AND full_name = 'Dean Winchester';
-- Who owns the most animals? 
SELECT full_name, COUNT(animals.owner_id) as total_animals FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY owners.id ORDER BY total_animals DESC LIMIT 1;

/*Many to many queries*/
SELECT vet_id, vets.name AS vet_name, animals.name AS animal_name, date_of_visit FROM visits
INNER JOIN vets
ON visits.vet_id = vets.id
INNER JOIN animals
ON visits.animal_id = animals.id
WHERE vets.name = 'William Tatcher'
ORDER BY date_of_visit DESC
LIMIT 1;

SELECT COUNT(*) FROM visits
INNER JOIN vets
ON visits.vet_id = vets.id
INNER JOIN animals
ON visits.animal_id = animals.id
WHERE vets.name = 'Stephanie Mendez';

SELECT * FROM vets
FULL OUTER JOIN specializations
ON vets.id = specializations.vet_id
FULL OUTER JOIN species
ON specializations.species_id = species.id;

SELECT vet_id, vets.name AS vet_name, animals.name AS animal_name, date_of_visit
FROM visits
INNER JOIN vets
ON vets.id = visits.vet_id
INNER JOIN animals
ON animals.id = visits.animal_id
WHERE vets.name = 'Stephanie Mendez'
AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animals.name AS animal_name, COUNT(*) FROM visits
INNER JOIN animals
ON visits.animal_id = animals.id
GROUP BY animals.name
ORDER BY COUNT(*) DESC
LIMIT 1;

SELECT vets.name AS vet_name, animals.name AS animal_name, date_of_visit FROM visits
INNER JOIN vets
ON visits.vet_id = vets.id
INNER JOIN animals
ON visits.animal_id = animals.id
WHERE vets.name = 'Maisy Smith'
ORDER BY date_of_visit
LIMIT 1;

SELECT vets.name AS vet_name, animals.name AS animal_name, date_of_visit FROM visits
INNER JOIN vets
ON visits.vet_id = vets.id
INNER JOIN animals
ON visits.animal_id = animals.id
ORDER BY date_of_visit DESC
LIMIT 1;

SELECT COUNT(*) FROM visits
FULL OUTER JOIN vets
ON visits.vet_id = vets.id
FULL OUTER JOIN specializations
ON vets.id = specializations.vet_id
FULL OUTER JOIN species
ON specializations.species_id = species.id
WHERE specializations.vet_id IS NULL

SELECT species.name AS species_name, COUNT(*)  FROM visits
INNER JOIN vets
ON visits.vet_id = vets.id
INNER JOIN animals
ON visits.animal_id = animals.id
INNER JOIN species
ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
LIMIT 1;

-- Query mus run in >= 1 second
explain analyze SELECT COUNT(*) FROM visits where animal_id = 4
