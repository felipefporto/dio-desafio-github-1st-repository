-- criação do banco de dados para o cenário de E-commerce 
-- drop database ecommerce;

CREATE DATABASE ecommerce;
USE ecommerce;

-- tabela pagamento
CREATE TABLE payments(
	bank_approvation ENUM('Cancelado','Confirmado','Em processamento') DEFAULT 'Em processamento',
    idPayment INT auto_increment unique,
    Card_number VARCHAR(45) NOT NULL,
    Expiration_date DATE NOT NULL,
    Security_code CHAR(3) NOT NULL,
    typePayment enum('Boleto','Cartão','Dois cartões'),
    limitAvailable FLOAT,
    PRIMARY KEY(bank_approvation, idPayment)
);
ALTER TABLE payments AUTO_INCREMENT = 1;

DESC payments;
-- tabela cliente
CREATE TABLE clients(
	idClient INT AUTO_INCREMENT PRIMARY KEY,
	identification VARCHAR(45),
    Payments_idPayment INT,
    CONSTRAINT fk_payment FOREIGN KEY (Payments_idPayment) REFERENCES payments(idPayment)
    ON UPDATE CASCADE
);
ALTER TABLE clients AUTO_INCREMENT = 1;

-- tabela PJ
CREATE TABLE clients_pj(
	idPJ INT,
    CNPJ CHAR(14) UNIQUE,
    Razao_social VARCHAR(45) NOT NULL,
    Inscricao_estadual CHAR(9),
    email VARCHAR(45) NOT NULL,
    telefone VARCHAR(45),
    Client_idClient INT,
    CONSTRAINT fk_idClient_pj FOREIGN KEY (Client_idClient) REFERENCES clients(idClient),
    PRIMARY KEY (idPJ, CNPJ)
);
ALTER TABLE clients_pj AUTO_INCREMENT = 1;

-- tabela PF
CREATE TABLE clients_pf(
	idPF INT,
    CPF CHAR(11) NOT NULL UNIQUE,
    PRIMARY KEY (idPF, CPF),
    Fname VARCHAR(15) NOT NULL,
	Mname VARCHAR(10),
    Lname VARCHAR(15) NOT NULL,
    Birth_date DATE NOT NULL,
    email VARCHAR(45),
    telefone VARCHAR(45),
    Client_idClient INT,
    CONSTRAINT fk_idClient_pf FOREIGN KEY (Client_idClient) REFERENCES clients(idClient)
);
ALTER TABLE clients_pf AUTO_INCREMENT = 1;

-- tabela endereço do cliente
CREATE TABLE adress(
	idAddress INT AUTO_INCREMENT PRIMARY KEY,
    State CHAR(2) NOT NULL,
    City VARCHAR(45) NOT NULL,
    Street VARCHAR(120) NOT NULL,
    Complement VARCHAR(45),
    CEP CHAR(8) NOT NULL,
    Client_idClient INT,
    CONSTRAINT fk_idClient FOREIGN KEY (Client_idClient) REFERENCES clients(idClient)
);
ALTER TABLE adress AUTO_INCREMENT = 1;

-- tabela pedido
CREATE TABLE orders(
	idOrder INT,
    order_status ENUM('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    order_description VARCHAR(255),
    Client_idClient INT,
    PRIMARY KEY (idOrder, Client_idClient),
    CONSTRAINT fk_order_client FOREIGN KEY (Client_idClient) REFERENCES clients(idClient),
    sendValue FLOAT DEFAULT 19.99,
    -- bank_status ENUM('Cancelado','Confirmado','Em processamento'),
    -- CONSTRAINT fk_bank_approvation FOREIGN KEY (bank_status) REFERENCES payments(bank_approvation),
    order_payment INT,
    CONSTRAINT fk_order_payment FOREIGN KEY (order_payment) REFERENCES payments(idPayment)
    ON UPDATE CASCADE
);
ALTER TABLE orders AUTO_INCREMENT = 1;

-- tabela produtos
CREATE TABLE product(
	idProduct INT AUTO_INCREMENT PRIMARY KEY,
	Category ENUM('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') NOT NULL,
	Description_product VARCHAR(255) NOT NULL,
	Price FLOAT,
	disponibility BOOLEAN,
	product_name VARCHAR(45) NOT NULL,
	product_score float default 0,
	size VARCHAR(10)
);
ALTER TABLE product AUTO_INCREMENT = 1;

-- tabela detalhes do pedido
CREATE TABLE details_order(
	idProduct INT,
    idOrder INT,
	quantity INT default 1,
    date_order DATE,
    total_value FLOAT,
    PRIMARY KEY(idProduct, idOrder),
	details_order_status ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    CONSTRAINT fk_idProduct FOREIGN KEY (idProduct) REFERENCES product(idProduct),
    CONSTRAINT fk_idOrder FOREIGN KEY (idOrder) REFERENCES orders(idOrder)
);
ALTER TABLE details_order AUTO_INCREMENT = 1;

-- tabela entrega
CREATE TABLE delivery(
	idDelivery INT auto_increment PRIMARY KEY,
    tracking_number VARCHAR(45),
    delivery_status VARCHAR(45)
);
ALTER TABLE delivery AUTO_INCREMENT = 1;

-- tabela detalhes da tabela
CREATE TABLE details_delivery(
	idOrder INT,
    idDelivery INT unique,
    primary key (idOrder, idDelivery),
	CONSTRAINT fk_details_idOrder FOREIGN KEY (idOrder) REFERENCES orders(idOrder),
	CONSTRAINT fk_idDelivery FOREIGN KEY (idDelivery) REFERENCES delivery(idDelivery),
    forecast_date DATE
);

-- tabela estoque
CREATE TABLE product_storage(
	idProdStorage INT PRIMARY KEY,
    storageLocation varchar(255),
    SKU VARCHAR(45)
);
ALTER TABLE product_storage auto_increment = 1;

-- tabela localização
CREATE TABLE location(
	idProdStorage INT,
    idProduct INT,
    PRIMARY KEY(idProdStorage, idProduct),
	CONSTRAINT fk_ProdStorage_location FOREIGN KEY (idProdStorage) REFERENCES product_storage(idProdStorage),
    CONSTRAINT fk_Product_location FOREIGN KEY (idProduct) REFERENCES product(idProduct),
    quantity int default 0
);

-- tabela fornecedor
CREATE TABLE supplier(
	idSupplier INT AUTO_INCREMENT PRIMARY KEY,
    corporate_name VARCHAR(255) NOT NULL,
    CNPJ CHAR(14) UNIQUE,
    Inscricao_estadual CHAR(9),
    email VARCHAR(45) NOT NULL,
    contact VARCHAR(45)
);
ALTER TABLE supplier auto_increment = 1;

-- tabela fornece produtos
CREATE TABLE product_supplier(
	idProd_Supplier INT,
    idProd_Product INT,
    quantity INT NOT NULL DEFAULT 0,
    PRIMARY KEY (idProd_Supplier, idProd_Product),
    CONSTRAINT fk_prod_supplier_supplier FOREIGN KEY (idProd_Supplier) REFERENCES supplier(idSupplier),
    constraint fk_prod_supplier_product FOREIGN KEY (idProd_Product) REFERENCES product(idProduct)
);

-- tabela vendedor terceirizado precisa ter MEI aberta
CREATE TABLE seller(
	idSeller INT AUTO_INCREMENT PRIMARY KEY,
    corporate_name VARCHAR(45) NOT NULL,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    Inscricao_estadual CHAR(9),
    location VARCHAR(45) NOT NULL,
    adress VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL,
    telefone VARCHAR(45)
);
ALTER TABLE seller auto_increment = 1;

-- tabela produtos por vendedor terceirizado
CREATE TABLE product_seller(
	idProd_seller INT,
    idProd_product INT,
    prod_quantity INT DEFAULT 1,
    PRIMARY KEY (idProd_seller, idProd_product),
    CONSTRAINT fk_product_seller FOREIGN KEY (idProd_seller) REFERENCES seller(idSeller),
    CONSTRAINT fk_product_product FOREIGN KEY (idProd_product) REFERENCES product(idProduct)
);

show tables;
show databases;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';

-- inserção de dados e queries
use ecommerce;
show tables;
desc clients_pj;
-- idPJ, CNPJ (14), Razao_Social, Inscricao_estadual (9), email, telefone
insert into clients_pj (idPJ,CNPJ, Razao_social, Inscricao_estadual, email, telefone) 
	   values(4,'12345678911234','12354','123456789', 'teste@gmail.com', '1234561'),
			 (6,'12345678911232','121354','123456788', 'teste1@gmail.com', '1234562'),
             (7,'12345678911233','123254','123456787', 'teste2@gmail.com', '1234563');
            -- ('12345678911235','123534','123456786', 'teste3@gmail.com', '1234564'),
            -- ('12345678911236','123544','123456785', 'teste4@gmail.com', '1234565'),
            -- ('12345678911237','123554','123456784', 'teste5@gmail.com', '1234566'),
            -- ('12345678911238','123564','123456783', 'teste6@gmail.com', '1234567'),
            -- ('12345678911239','123574','123456782', 'teste7@gmail.com', '1234568');
             
desc clients_pf;
-- idPF, CPF (11), Fname, Mname, Lname, Birth_date, email, telefone
insert into clients_pf (idPF,CPF, Fname, Mname, Lname, Birth_date, email, telefone) 
	   values(1,'45678911234','Felipe','D', 'Oliveira', '1990-11-10', 'teste@gmail.com', '1234561'),
			 (2,'45678911232','Luan','F', 'Martins', '1990-11-10','teste1@gmail.com', '1234562'),
             (3,'45678911233','Higor','G', 'Gold', '1990-11-10','teste2@gmail.com', '1234563'),
             (5,'45678911235','Luis','H', 'Santos', '1990-11-10','teste3@gmail.com', '1234564'),
             (8,'45678911236','Gabriel','J', 'Correia', '1990-11-10','teste4@gmail.com', '1234565');
            -- ('45678911237','Janaína','K', 'Portugal', '1990-11-10','teste5@gmail.com', '1234566'),
            -- ('45678911238','Juliane','L', 'Celeval', '1990-11-10','teste6@gmail.com', '1234567'),
            -- ('45678911239','Larissa','U', 'Silva', '1990-11-10','teste7@gmail.com', '1234568');

desc clients;             
insert into clients (identification) 
	   values('PF'),
			 ('PF'),
             ('PF'),
             ('PJ'),
             ('PF'),
             ('PJ'),
             ('PJ'),
             ('PF');	

desc product;
-- idProduct, Category, Description_product, Price, disponibility, product_name, product_score, size
insert into product (Category, Description_product, Price, disponibility, product_name, product_score, size) values
							  ('Eletrônico','Fone de ouvido', 19.99, false, 'Fone de ouvido',4,null),
                              ('Brinquedos','Barbie Elsa', 199.99, true, 'Barbie Elsa',3,null),
                              ('Vestimenta','Body Carters', 290.00,true, 'Body Carters',5,null),
                              ('Eletrônico','Microfone Vedo', 999.99,False, 'Microfone Vedo',4,null),
                              ('Móveis','Sofá retrátil', 2999.99, False, 'Sofá retrátil', 3,'3x57x80'),
                              ('Alimentos','Farinha de arroz', 4.99, False, 'Farinha de arroz', 2, null),
                              ('Eletrônico','Fire Stick Amazon', 399.99, False, 'Fire Stick Amazon',3,null);

select * from clients;
select * from clients_pf;
select * from clients_pj;
select * from product;

desc payments;
-- bank_approvation, idPayment, Card_number, Expiration_date, Security_code (3), typePayment, limitAvailable
INSERT INTO payments (Card_number, Expiration_date, Security_code, typePayment, limitAvailable) VALUES
					('123456', '2030-11-10',123,'Cartão',9999),
                    ('223456', '2031-11-10',123,'Cartão',99999),
                    ('323456', '2032-11-10',123,'Boleto',999999),
                    ('423456', '2033-11-10',123,'Dois Cartões',999999),
                    ('523456', '2034-11-10',123,'Cartão',9999999),
                    ('623456', '2035-11-10',123,'Cartão',999999),
                    ('723456', '2036-11-10',123,'Cartão',99999);
select * from payments;
-- delete from orders where idOrderClient in  (1,2,3,4);
desc orders;
-- idOrder, order_status, order_description, sendValue
insert into orders (idOrder, order_status, order_description, Client_idClient, sendValue) values 
							 (1,'Confirmado', null, 1,default),
                             (2,'Confirmado', null, 2,default),
                             (3,'Cancelado',null, 3, default),
                             (4,'Em processamento', null, 4, default),
                             (5,'Em processamento', null, 5,default),
                             (6,'Confirmado', null, 6,default),
                             (7,'Cancelado',null, 7,default);

-- quantity, date_order, total_value, details_order_status
select * from orders;
desc details_order;
insert into details_order (idProduct, idOrder, quantity, date_order, total_value, details_order_status) values
						 (1,1,1,'2022-10-10',201,default),
                         (2,2,1,'2022-10-10',202,default),
                         (3,3,1,'2022-10-10',203,default),
                         (4,4,1,'2022-10-10',204,default),
                         (5,5,1,'2022-10-10',205,default),
                         (6,6,1,'2022-10-10',206,default),
                         (7,7,1,'2022-10-10',207,default);

show tables;
desc product_storage;
-- storageLocation,quantity
insert into product_storage (idProdStorage, storageLocation, SKU) values 
							(1,'Rio de Janeiro',1000),
                            (2,'Rio de Janeiro',500),
                            (3,'São Paulo',10),
                            (4,'São Paulo',100),
                            (5,'São Paulo',10),
                            (6,'Brasília',60);

show tables;
desc location;
insert into location (idProdStorage, idProduct, quantity) values (1,1,1);
insert into location (idProdStorage, idProduct, quantity) values (2,2,2);
insert into location (idProdStorage, idProduct, quantity) values (3,3,3);
insert into location (idProdStorage, idProduct, quantity) values (4,4,4);
insert into location (idProdStorage, idProduct, quantity) values (5,5,5);
insert into location (idProdStorage, idProduct, quantity) values (6,6,6);

desc supplier;
insert into supplier (corporate_name, CNPJ, Inscricao_estadual,email,contact) values 
							('Almeida e filhos', 12345678912346,'219854734', 'teste@teste.com','123456'),
                            ('Eletrônicos Silva',85451964914457,'219854844', 'teste1@teste.com','223256'),
                            ('Eletrônicos Valma', 93456789934695,'219755474', 'teste2@teste.com','323456');
                            
select * from supplier;

desc product_supplier;
insert into product_supplier (idProd_Supplier, idProd_Product, quantity) values
						 (1,1,500),
                         (1,2,400),
                         (2,4,633),
                         (3,3,5),
                         (2,5,10);

desc seller;
insert into seller (Corporate_name, CNPJ, Inscricao_estadual, location, adress, email, telefone) values 
						('Tech eletronics', 12456789456321, null, 'Rio de Janeiro','adress 1', 'teste@teste', 219946287),
					    ('Botique Durgas',11156789456311,123456783,'Rio de Janeiro', 'adress 2', 'teste@teste', 219567895),
						('Kids World',45678912654485,null,'São Paulo', 1198657484, 'adress 3', 'ateste@teste, 2343545346');

select * from seller;
desc product_seller;

insert into product_seller (idProd_seller, idProd_product, prod_quantity) values 
						 (1,6,80),
                         (2,7,10);

select * 
from product_seller;

select count(*) from clients;
select count(*) from clients_pj;
select count(*) from clients_pf;

select * 
from clients c, orders o 
where c.idClient = idOrder;

desc clients_pf;
select Fname,Lname, idOrder, order_status 
from clients_pf c, orders o 
where c.idPF = idOrder;

select concat(Fname,' ',Lname) as ClientS, idOrder as Request, order_status 
from clients_pf c, orders o 
where c.idPF = idOrder;

desc orders;
insert into orders (idOrder, order_status, order_description, Client_idClient, sendValue) values 
							 (8, default,'compra via aplicativo', 8, default);

desc orders;                             
select order_status 
from clients_pf c, orders o 
where c.idPF = idOrder;

select count(*) 
from clients_pj c, orders o 
where c.idPJ = idOrder;

select * 
from orders;

desc product_seller;
select * from location;
desc product_supplier;
desc location;

--

SELECT DISTINCT idProduct 
FROM product
WHERE idProduct IN
	(SELECT DISTINCT idProduct FROM product_seller as se, product_supplier as su WHERE se.idProd_product = su.idProd_Product)
    OR
    idProduct IN (SELECT DISTINCT idProduct FROM location, product_seller as se WHERE idProduct = se.idProd_product);
    
--
select * from product;
SELECT Category, Price, Description_product, idProduct 
FROM product
WHERE Price = ANY (SELECT Price
					FROM product 
                    WHERE product_score = 5);
                    
SELECT Category, Price, Description_product, idProduct, product_score
FROM product
ORDER BY product_score DESC; 

SELECT product_score, count(*)
FROM product
GROUP BY product_score
HAVING count(*) >= 2; 

-- recuperação de pedido com produto
select * 
from clients_pf c 
	inner join orders o 
    ON c.idPF = o.idOrder
    inner join details_order p 
    on p.idOrder = o.idOrder
group by idPF; 
        
-- Recuperar quantos pedidos foram realizados pelos clientes
select c.idPF, Fname, count(*) as Number_of_orders 
from clients_pf c 
	inner join orders o 
    ON c.idPF = o.idOrder
group by idPF;
        
-- Quantos pedidos foram feitos por cada cliente?

SELECT idPF, CPF, count(*) 
FROM clients_pf c, orders o 
WHERE c.idPF = o.idOrder 
GROUP BY idPF;

SELECT idPJ, CNPJ, count(*) 
FROM clients_pj c, orders o 
WHERE c.idPJ = o.idOrder
GROUP BY idPJ;

-- Algum vendedor também é fornecedor?

select * from supplier;
select * from seller;

SELECT * 
FROM supplier AS su 
INNER JOIN seller as se
WHERE su.corporate_name = se.corporate_name;

-- Relação de produtos fornecedores e estoques;

select * from product;
select * from product_supplier;
select * from location;

SELECT prod.idProduct, prod.product_name, su.idProd_Supplier, l.idProdStorage
FROM product as prod
INNER JOIN product_supplier as su ON idProduct = su.idProd_Product
INNER JOIN location as l ON l.idProduct = su.idProd_Product;

-- Relação de nomes dos fornecedores e nomes dos produtos;

SELECT * FROM supplier;
SELECT * FROM product_supplier;
SELECT * FROM product;

SELECT corporate_name, Description_product
FROM supplier AS su
INNER JOIN product_supplier ON idProd_Supplier = idSupplier
INNER JOIN product ON idProd_Product = idProduct;