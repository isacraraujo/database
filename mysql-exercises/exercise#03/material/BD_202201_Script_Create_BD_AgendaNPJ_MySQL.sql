-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema AgendaNPJ
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema AgendaNPJ
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `AgendaNPJ` DEFAULT CHARACTER SET utf8 ;
USE `AgendaNPJ` ;

-- -----------------------------------------------------
-- Table `AgendaNPJ`.`Area`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AgendaNPJ`.`Area` ;

CREATE TABLE IF NOT EXISTS `AgendaNPJ`.`Area` (
  `idArea` INT NOT NULL,
  `nmArea` VARCHAR(45) NOT NULL,
  `sgArea` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idArea`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nmArea_UNIQUE` ON `AgendaNPJ`.`Area` (`nmArea` ASC) VISIBLE;

CREATE UNIQUE INDEX `sgArea_UNIQUE` ON `AgendaNPJ`.`Area` (`sgArea` ASC) INVISIBLE;


-- -----------------------------------------------------
-- Table `AgendaNPJ`.`Local`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AgendaNPJ`.`Local` ;

CREATE TABLE IF NOT EXISTS `AgendaNPJ`.`Local` (
  `idLocal` INT NOT NULL,
  `nmLocal` VARCHAR(45) NOT NULL,
  `sgLocal` VARCHAR(15) NOT NULL,
  `edLocal` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idLocal`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nmLocal_UNIQUE` ON `AgendaNPJ`.`Local` (`nmLocal` ASC) VISIBLE;

CREATE UNIQUE INDEX `sgLocal_UNIQUE` ON `AgendaNPJ`.`Local` (`sgLocal` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `AgendaNPJ`.`LocalArea`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AgendaNPJ`.`LocalArea` ;

CREATE TABLE IF NOT EXISTS `AgendaNPJ`.`LocalArea` (
  `idLocalArea` INT NOT NULL,
  `Area_idArea` INT NOT NULL,
  `Local_idLocal` INT NOT NULL,
  PRIMARY KEY (`idLocalArea`),
  CONSTRAINT `fk_LocalArea_Area`
    FOREIGN KEY (`Area_idArea`)
    REFERENCES `AgendaNPJ`.`Area` (`idArea`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LocalArea_Local1`
    FOREIGN KEY (`Local_idLocal`)
    REFERENCES `AgendaNPJ`.`Local` (`idLocal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_LocalArea_Area_idx` ON `AgendaNPJ`.`LocalArea` (`Area_idArea` ASC) VISIBLE;

CREATE INDEX `fk_LocalArea_Local1_idx` ON `AgendaNPJ`.`LocalArea` (`Local_idLocal` ASC) INVISIBLE;

CREATE UNIQUE INDEX `uk_LocalArea_LocalArea` ON `AgendaNPJ`.`LocalArea` (`Area_idArea` ASC, `Local_idLocal` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `AgendaNPJ`.`Horario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AgendaNPJ`.`Horario` ;

CREATE TABLE IF NOT EXISTS `AgendaNPJ`.`Horario` (
  `idHorario` INT NOT NULL,
  `hrInicio` TIME NULL,
  `hrFim` TIME NULL,
  `nuVagas` SMALLINT NULL,
  `LocalArea_idLocalArea` INT NOT NULL,
  PRIMARY KEY (`idHorario`),
  CONSTRAINT `fk_Horario_LocalArea1`
    FOREIGN KEY (`LocalArea_idLocalArea`)
    REFERENCES `AgendaNPJ`.`LocalArea` (`idLocalArea`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Horario_LocalArea1_idx` ON `AgendaNPJ`.`Horario` (`LocalArea_idLocalArea` ASC) VISIBLE;

CREATE UNIQUE INDEX `uk_Horario_LocalArea_hrInicio` ON `AgendaNPJ`.`Horario` (`hrInicio` ASC, `LocalArea_idLocalArea` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `AgendaNPJ`.`Agenda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AgendaNPJ`.`Agenda` ;

CREATE TABLE IF NOT EXISTS `AgendaNPJ`.`Agenda` (
  `idAgenda` INT NOT NULL,
  `dtAgenda` DATE NOT NULL,
  `Horario_idHorario` INT NOT NULL,
  PRIMARY KEY (`idAgenda`),
  CONSTRAINT `fk_Agenda_Horario1`
    FOREIGN KEY (`Horario_idHorario`)
    REFERENCES `AgendaNPJ`.`Horario` (`idHorario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Agenda_Horario1_idx` ON `AgendaNPJ`.`Agenda` (`Horario_idHorario` ASC) VISIBLE;

CREATE UNIQUE INDEX `uk_Agenda_Horario_Data` ON `AgendaNPJ`.`Agenda` (`dtAgenda` ASC, `Horario_idHorario` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `AgendaNPJ`.`Assistido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AgendaNPJ`.`Assistido` ;

CREATE TABLE IF NOT EXISTS `AgendaNPJ`.`Assistido` (
  `idAssistido` INT NOT NULL,
  `nmAssistido` VARCHAR(100) NOT NULL,
  `nuCPF` VARCHAR(11) NOT NULL,
  `nuIdentidade` VARCHAR(45) NOT NULL,
  `deEndereco` VARCHAR(255) NOT NULL,
  `coSenha` VARCHAR(16) NOT NULL,
  `edIPAceite` VARCHAR(45) NULL,
  `dtAceite` DATETIME NULL,
  PRIMARY KEY (`idAssistido`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nuCPF_UNIQUE` ON `AgendaNPJ`.`Assistido` (`nuCPF` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `AgendaNPJ`.`Agendamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AgendaNPJ`.`Agendamento` ;

CREATE TABLE IF NOT EXISTS `AgendaNPJ`.`Agendamento` (
  `idAgendamento` INT NOT NULL,
  `dtAgendamento` DATETIME NOT NULL,
  `Agenda_idAgenda` INT NOT NULL,
  `Assistido_idAssistido` INT NOT NULL,
  PRIMARY KEY (`idAgendamento`),
  CONSTRAINT `fk_Agendamento_Agenda1`
    FOREIGN KEY (`Agenda_idAgenda`)
    REFERENCES `AgendaNPJ`.`Agenda` (`idAgenda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Agendamento_Assistido1`
    FOREIGN KEY (`Assistido_idAssistido`)
    REFERENCES `AgendaNPJ`.`Assistido` (`idAssistido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Agendamento_Agenda1_idx` ON `AgendaNPJ`.`Agendamento` (`Agenda_idAgenda` ASC) VISIBLE;

CREATE INDEX `fk_Agendamento_Assistido1_idx` ON `AgendaNPJ`.`Agendamento` (`Assistido_idAssistido` ASC) VISIBLE;

CREATE UNIQUE INDEX `uk_Agendamento_Agenda_Assistido` ON `AgendaNPJ`.`Agendamento` (`Agenda_idAgenda` ASC, `Assistido_idAssistido` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
