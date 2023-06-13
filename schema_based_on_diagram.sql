CREATE DATABASE vet_clinic;

CREATE TABLE patients(
	id INT NOT NULL PRIMARY KEY,
	name VARCHAR UNIQUE NOT NULL, 
	date_of_birth DATE
);

CREATE TABLE medical_histories(
	id BIGSERIAL NOT NULL PRIMARY KEY,
	addimited_at TIMESTAMP, 
	patient_id BIGINT REFERENCES patients (id),
    status VARCHAR
);

CREATE TABLE treatments (
    id INT NOT NULL PRIMARY KEY,
    type VARCHAR,
    name VARCHAR
);

CREATE TABLE invoices (
    id INT NOT NULL PRIMARY KEY,
    total_amount DECIMAL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history__id INT REFERENCES medical_histories(id)
);

CREATE TABLE invoice_items (
    id INT NOT NULL PRIMARY KEY,
    unit_price DECIMAL,
    quantity INT,
    total_price DECIMAL,
    invoice_id INT REFERENCES invoices(id),
    treatment_id INT REFERENCES treatments(id),
);

CREATE TABLE medical_treatments (
	medical_history_id INTEGER REFERENCES medical_histories(id),
	treatment_id INTEGER REFERENCES treatments(id)
);

CREATE INDEX patient_index ON medical_histories(patient_id);
CREATE INDEX medical_histories_index ON invoices(medical_history__id);
CREATE INDEX treatments_idx ON invoice_items(treatment_id);
CREATE INDEX invoices_index ON invoice_items(invoice_id);
CREATE INDEX medical_history_index ON medical_treatments(medical_history_id);
CREATE INDEX medical_treatments_idx ON medical_treatments(treatment_id);