-- Explorando os comandos de DDL

-- hora atual do sistema
SELECT now() AS Timestamp;

CREATE DATABASE IF NOT EXISTS manipulation;
USE manipulation;

CREATE TABLE bankAccounts (
	Id_account INT auto_increment PRIMARY KEY,
	Ag_num INT NOT NULL,
	Ac_num INT NOT NULL,
	Saldo FLOAT,
	CONSTRAINT identification_account_constraint UNIQUE (Ag_num, Ac_num)
);

INSERT INTO bankAccounts (Ag_num, Ac_num, Saldo) VALUES(156,264358,0);
SELECT * FROM bankAccounts;
ALTER TABLE bankAccounts ADD Limite_Credito FLOAT NOT NULL DEFAULT 500.00; 
DESC bankAccounts;
ALTER TABLE bankAccounts ADD email VARCHAR(60);
ALTER TABLE bankAccounts DROP email;
DESC bankAccounts;
-- alter table nome_tabela modify column nome_atributo tipo_dados condição;
-- alter table nome_tabela add constraint nome_constraint condições;

CREATE TABLE bankClient(
	Id_client INT auto_increment PRIMARY KEY,
	ClientAccount INT,
	CPF CHAR(11) NOT NULL,
	RG CHAR(9) NOT NULL,
	Nome VARCHAR(50) NOT NULL,
	Endereço VARCHAR(100) NOT NULL,
	Renda_mensal FLOAT,
	CONSTRAINT fk_acconut_client FOREIGN KEY (ClientAccount) REFERENCES bankAccounts(Id_account) 
	ON UPDATE CASCADE
);

INSERT INTO bankClient VALUES(1,12342432545,3242342,'Fulano','Rua','5500.20');
SELECT * FROM bankClient;
ALTER TABLE bankClient ADD uff CHAR(20) NOT NULL DEFAULT 'RJ';
INSERT INTO bankClient (ClientAccount, CPF, RG, Nome, Endereço, Renda_mensal, uff) VALUES('1','12345678901','123456789','Beltrano','Rua 15',600.00,'SP'); 
UPDATE bankClient SET uff='RJ' WHERE ClientAccount='1';

CREATE TABLE bankTransactions(
	Id_transcation INT auto_increment PRIMARY KEY,
	Ocorrencia DATETIME,
	Status_transaction VARCHAR(20),
	Valor_transferido FLOAT,
	Source_account INT,
	Destination_account INT,
	CONSTRAINT fk_source_transaction FOREIGN KEY (Source_account) REFERENCES
	bankAccounts(id_Account),
	CONSTRAINT fk_destionation_transaction FOREIGN KEY (destination_account) REFERENCES
	bankAccounts(id_Account)
);

UPDATE Customers SET UF ='RJ' WHERE City='Rio de Janeiro';

-- drop versus delete statement

drop table bankTransactions;
drop database manipulation;

DELETE FROM bankClient WHERE name='Teste';

ALTER TABLE bankClient ADD Email varchar(255);
ALTER TABLE Customers DROP COLUMN Email;
-- ALTER TABLE table_name MODIFY COLUMN column_name datatype;
-- ALTER TABLE Custumers ADD CONSTRAINT;


SELECT account_id, product_cd, open_date, avail_balance
FROM account
ORDER BY avail_balance DESC;