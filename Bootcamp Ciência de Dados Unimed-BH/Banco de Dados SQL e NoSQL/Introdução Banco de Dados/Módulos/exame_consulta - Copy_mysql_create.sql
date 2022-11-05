CREATE TABLE `Paciente` (
	`id_paciente` BINARY NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id_paciente`)
);

CREATE TABLE `Médico` (
	`id_medico` BINARY NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id_medico`)
);

CREATE TABLE `Exame` (
	`id_exame` INT NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`id_exame`)
);

CREATE TABLE `Consulta` (
	`id_medico` BINARY NOT NULL,
	`id_paciente` BINARY NOT NULL,
	`id_exame` BINARY NOT NULL
);

ALTER TABLE `Consulta` ADD CONSTRAINT `Consulta_fk0` FOREIGN KEY (`id_medico`) REFERENCES `Médico`(`id_medico`);

ALTER TABLE `Consulta` ADD CONSTRAINT `Consulta_fk1` FOREIGN KEY (`id_paciente`) REFERENCES `Paciente`(`id_paciente`);

ALTER TABLE `Consulta` ADD CONSTRAINT `Consulta_fk2` FOREIGN KEY (`id_exame`) REFERENCES `Exame`(`id_exame`);





