-- DROP DATABASE oficina;
CREATE DATABASE oficina;
USE oficina;

-- tabela de peças
CREATE TABLE mechanical_parts_list(
	idMechanical_parts INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_model VARCHAR(45) NOT NULL,
    part_name VARCHAR(45) NOT NULL,
    quantity INT NOT NULL,
    part_price FLOAT NOT NULL
);
ALTER TABLE mechanical_parts_list AUTO_INCREMENT = 1;

-- tabela lista de preços
CREATE TABLE labor_price_list(
	idLabor_price_list INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(45) NOT NULL,
	service_value FLOAT NOT NULL
);
ALTER TABLE labor_price_list AUTO_INCREMENT = 1;

-- tabela equipe de mecânicos
CREATE TABLE mechanics_team(
	idMechanics_team INT AUTO_INCREMENT PRIMARY KEY,
    team_name VARCHAR(30), 
    contact VARCHAR(11)
);
ALTER TABLE mechanics_team AUTO_INCREMENT = 1;

-- tabela cliente
CREATE TABLE clients(
	idClients INT AUTO_INCREMENT PRIMARY KEY,
	fname VARCHAR(30) NOT NULL, 
    mname VARCHAR(45), 
    lname VARCHAR(45) NOT NULL, 
    contact VARCHAR(30) NOT NULL, 
    CNH CHAR(11) NOT NULL UNIQUE, 
    address VARCHAR(255) NOT NULL, 
    birth_date DATE NOT NULL,
    CPF CHAR(11) NOT NULL UNIQUE
);
ALTER TABLE clients AUTO_INCREMENT = 1;

-- tabela mecânico
CREATE TABLE mechanics(
	idMechanic INT AUTO_INCREMENT PRIMARY KEY, 
    CREA CHAR(10) UNIQUE, 
    fname VARCHAR(30), 
    mname VARCHAR(45), 
    lname VARCHAR(45), 
    address VARCHAR(255), 
    contact VARCHAR(20), 
    CPF CHAR(11) UNIQUE NOT NULL, 
    specialty VARCHAR(45),
    idMechanics_team INT DEFAULT 1,
    CONSTRAINT FK_idMechanics_team FOREIGN KEY (idMechanics_team) REFERENCES mechanics_team(idMechanics_team)
);
ALTER TABLE mechanics AUTO_INCREMENT = 1;

-- tabela veículo
CREATE TABLE vehicle(
	idVehicle INT AUTO_INCREMENT PRIMARY KEY,
    license_plate CHAR(7) UNIQUE, 
    vehicle_year INT, 
    RENAVAM CHAR(11) UNIQUE, 
    vehicle_make VARCHAR(10), 
    vehicle_model VARCHAR(10), 
    idMechanics_team INT DEFAULT 1,
    CONSTRAINT FK_vehicle_idMechanics_team FOREIGN KEY (idMechanics_team) REFERENCES mechanics_team(idMechanics_team)
);
ALTER TABLE vehicle AUTO_INCREMENT = 1;

-- tabela cliente possui veículos
CREATE TABLE customer_has_vehicles(
	idClients INT,
    idVehicle INT,
    quantity INT NOT NULL DEFAULT 1,
    PRIMARY KEY (idClients, idVehicle),
    CONSTRAINT FK_client_customer_has_vehicles FOREIGN KEY (idClients) REFERENCES clients(idClients),
    CONSTRAINT FK_vehicle_customer_has_vehicles FOREIGN KEY (idVehicle) REFERENCES vehicle(idVehicle)
);


-- tabela ordem de serviço
CREATE TABLE service_order(
	idService_order INT AUTO_INCREMENT,
    approval_status ENUM('Aprovado', 'Em análise', 'Recusado') NOT NULL DEFAULT 'Em análise',
    idClients INT,
    idLabor_price_list INT,
    order_date DATE, 
    labor_price_service FLOAT,
    service_description VARCHAR(255),
    periodic_review ENUM('True','False') NOT NULL DEFAULT 'False',
    PRIMARY KEY (idService_order, approval_status, idClients, idLabor_price_list),
    CONSTRAINT FK_client_service_order FOREIGN KEY (idClients) REFERENCES clients(idClients),
    CONSTRAINT FK_labor_price_list_service_order FOREIGN KEY (idLabor_price_list) REFERENCES labor_price_list(idLabor_price_list)
);
ALTER TABLE service_order AUTO_INCREMENT = 1;

-- tabela serviço
CREATE TABLE service(
	idService INT AUTO_INCREMENT,
    idService_order INT,
    idClients INT,
    idMechanics_team INT,
    PRIMARY KEY (idService, idService_order, idClients, idMechanics_team),
    CONSTRAINT FK_service_order_service FOREIGN KEY (idService_order) REFERENCES service_order(idService_order),
    CONSTRAINT FK_clients_order_service FOREIGN KEY (idClients) REFERENCES clients(idClients),
    CONSTRAINT FK_mechanics_team_service FOREIGN KEY (idMechanics_team) REFERENCES mechanics_team(idMechanics_team)
);


-- tabela orçamento de peças para compra
CREATE TABLE parts_quote_for_purchase(
	idService_order INT,
    approval_status ENUM('Aprovado', 'Em análise', 'Recusado') NOT NULL DEFAULT 'Em análise',
    idClients INT,
    idMechanical_parts INT, 
    PRIMARY KEY (idService_order, approval_status, idClients, idMechanical_parts),
	vehicle_model VARCHAR(45) NOT NULL, 
    quantity INT NOT NULL,
    order_date DATE NOT NULL,
	part_name VARCHAR(45) NOT NULL
);

INSERT INTO mechanical_parts_list (vehicle_model, part_name, quantity, part_price) VALUES
								  ('Gol', 'Brake', 1, 50.00),
                                  ('Uno', 'Gearbox', 1, 70.00),
                                  ('Fox', 'Wheel', 1, 250.00),
                                  ('Gol', 'Spark Plug', 1, 150.00),
                                  ('Honda', 'Baterry', 1, 250.00),
                                  ('Hyndai', 'Injection Pump', 1, 150.00);


INSERT INTO labor_price_list (service_name, service_value) VALUES
							 ('Labor for Overhaul', 80.00),
                             ('Alignment', 60.00),
                             ('Balancing', 50.00),
                             ('Engine Change', 3000.00),
                             ('Tire Change', 50.00),
                             ('Oil Change', 40.00);
                             
INSERT INTO mechanics_team (team_name, contact) VALUES
						   ('Veículos Pesados', '1234667'),
                           ('Veículos Leves', '2234667'),
                           ('Duas Rodas', '3234667'),
                           ('Veículos Elétricos', '4234667');
                           
INSERT INTO clients (fname, mname, lname, contact, CNH, address, birth_date, CPF) VALUES
					('Felipe', 'D', 'Madri', '1234563', '12345678912', 'Adress 1', '1990-03-30', '12345678907'),
                    ('Lucas', 'D', 'Lucca', '2234563', '22345678912', 'Adress 2', '1991-03-30', '22345678907'),
                    ('Marcos', 'D', 'Rodrigues', '3234563', '32345678912', 'Adress 3', '1992-03-30', '32345678907'),
                    ('Rafaela', 'D', 'Oliveira', '4234563', '42345678912', 'Adress 4', '1993-03-30', '42345678907'),
                    ('Larissa', 'D', 'Silva', '5234563', '52345678912', 'Adress 5', '1994-03-30', '52345678907');
                  
INSERT INTO mechanics (CREA, fname, mname, lname, address, contact, CPF, specialty) VALUES
					  ('123456789','Felipe', 'D', 'Santos','adress 1', '1234', '12345678345','Motor'),
                      ('123452789','Marco', 'D', 'Santos','adress 1', '1234', '22345678345','Cambio Elétrico'),
                      ('123436789','Arthur', 'D', 'Santos','adress 1', '1234', '32345678345','Suspenção'),
                      ('123556789','João', 'D', 'Santos','adress 1', '1234', '42345678345','Módulo'),
                      ('123656789','Carlos', 'D', 'Santos','adress 1', '1234', '52345678345','Elétrica');
                   
INSERT INTO vehicle (license_plate, vehicle_year, RENAVAM, vehicle_make, vehicle_model) VALUES
					('12AD34F',2000,'12345673456','Uno','Fire'),
                    ('12AS34F',2010,'12345613456','Uno','Mile'),
                    ('12AD34R',1990,'22345673456','Gol','1990'),
                    ('42AD34F',2011,'18345673456','Hyndai','Velox'),
                    ('12GD34F',2001,'92345673456','Honda','City');                      

INSERT INTO customer_has_vehicles (idClients, idVehicle, quantity) VALUES 
								  (1,1, DEFAULT),
                                  (2,2, DEFAULT),
                                  (3,3, DEFAULT),
                                  (1,4, DEFAULT),
                                  (4,5, DEFAULT);
                                    
INSERT INTO service_order (approval_status, idClients, idLabor_price_list, order_date, labor_price_service, periodic_review) VALUES
						  ('Recusado', 1, 1,'2022-11-20', 500.00, DEFAULT),
                          (DEFAULT, 2, 1,'2022-11-20', 20.00, DEFAULT),
                          ('Aprovado', 3, 1,'2022-11-20', 300.00, DEFAULT),
                          (DEFAULT, 1, 1,'2022-11-20', 400.00, 'True'),
                          ('Aprovado', 4, 1,'2022-11-20', 150.00, DEFAULT);
 
INSERT INTO service (idService_order, idClients, idMechanics_team) VALUES
					(1, 1, 1),
					(2, 2, 1),
					(3, 3, 1),
					(4, 1, 1),
					(5, 4, 1);
                
INSERT INTO parts_quote_for_purchase (idService_order, approval_status, idClients, idMechanical_parts, vehicle_model, quantity, order_date, part_name) VALUES
						  (1,'Recusado', 1, 1, 'Uno - Fire',1,'2022-11-20', 'Gearbox'),
                          (2,DEFAULT, 2, 1,'Uno - Mile',2,'2022-11-20', 'Gearbox'),
                          (3,'Aprovado', 3,1,'Gol - 1990',1,'2022-11-20', 'Brake'),
                          (4,DEFAULT, 1, 1,'Hyndai - Velox',1,'2022-11-20', 'Injection Pump'),
                          (5,'Aprovado',4, 2,'Honda - City',1,'2022-11-20', 'Baterry');
SELECT * FROM parts_quote_for_purchase;                              
show tables;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'oficina';

USE oficina;

-- mecanicos do time 1
SELECT fname 
FROM mechanics as mec
	INNER JOIN mechanics_team as mt 
    ON mec.idMechanics_team = mt.idMechanics_team;


-- Quantidade de Veículos por Cliente
SELECT concat(fname, ' ', mname, ' ', lname) AS client_name, count(quantity) AS Qtde_Veículos
FROM clients AS c
INNER JOIN customer_has_vehicles AS chv ON c.idClients = chv.idClients
INNER JOIN vehicle AS v ON chv.idVehicle = v.idVehicle
GROUP BY chv.idClients;

-- Recuperando clientes que aprovaram a ordem de serviço, o preço do serviço e as peças que precisa comprar
SELECT DISTINCT so.idService_order, c.idClients, concat(c.fname, ' ', c.lname) as Nome_cliente, pq.order_date, so.labor_price_service, c.CPF, vehicle_model, quantity, part_name
FROM service_order AS so
	INNER JOIN clients as c ON so.idClients = c.idClients
    INNER JOIN parts_quote_for_purchase as pq ON c.idClients = pq.idClients
WHERE pq.approval_status = 'Aprovado'
ORDER BY so.idService_order;


-- Selecionar os Veículos que mesmo mecânico é responsável
SELECT DISTINCT concat(fname, ' ', lname) as Mecânico_Responsável, mt.team_name, v.idVehicle, v.license_plate, v.RENAVAM, v.vehicle_make, v.vehicle_model, chv.idClients 
FROM mechanics as m
	INNER JOIN mechanics_team as mt
    USING(idMechanics_team)
	INNER JOIN (vehicle as v INNER JOIN customer_has_vehicles as chv ON v.idVehicle = chv.idVehicle) 
    ON v.idVehicle = chv.idVehicle
	GROUP BY v.idVehicle;
    
show tables;
SELECT * FROM mechanical_parts_list;

-- recuperando status de pedido acima de contagem > 1 e ser valor de serviço bem como o modelo do carro
SELECT count(*), pq.order_date, pq.quantity, pq.vehicle_model, pq.approval_status, lp.service_value
FROM parts_quote_for_purchase as pq, service_order as so
	INNER JOIN labor_price_list as lp ON lp.idLabor_price_list = so.idLabor_price_list
	GROUP BY pq.part_name 
    HAVING count(*)>1;