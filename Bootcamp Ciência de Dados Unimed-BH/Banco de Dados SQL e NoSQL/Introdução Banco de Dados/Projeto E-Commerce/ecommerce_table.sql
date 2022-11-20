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
	idPJ INT AUTO_INCREMENT,
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
	idPF INT AUTO_INCREMENT,
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
	idOrder INT auto_increment,
    order_status ENUM('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    order_description VARCHAR(255),
    Client_idClient INT,
    PRIMARY KEY (idOrder, Client_idClient, bank_status),
    CONSTRAINT fk_order_client FOREIGN KEY (Client_idClient) REFERENCES clients(idClient),
    sendValue FLOAT DEFAULT 19.99,
    bank_status ENUM('Cancelado','Confirmado','Em processamento'),
    CONSTRAINT fk_bank_approvation FOREIGN KEY (bank_status) REFERENCES payments(bank_approvation),
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
	idProdStorage INT AUTO_INCREMENT PRIMARY KEY,
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
    Corporate_name VARCHAR(45) NOT NULL,
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