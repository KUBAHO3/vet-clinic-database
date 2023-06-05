/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name = 'Luna';

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