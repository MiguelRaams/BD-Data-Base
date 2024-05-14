-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 27, 2023 at 03:42 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `festival2`
--

-- --------------------------------------------------------

--
-- Table structure for table `associado`
--

CREATE TABLE `associado` (
  `Dia_Dia_ID_` int(11) NOT NULL,
  `Tipo_bilhete_Tipo_bilhete_ID_` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `associado`
--

INSERT INTO `associado` (`Dia_Dia_ID_`, `Tipo_bilhete_Tipo_bilhete_ID_`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `bilhete`
--

CREATE TABLE `bilhete` (
  `Tipo_bilhete_Tipo_bilhete_ID` int(11) NOT NULL,
  `Bilhete_ID` int(11) NOT NULL,
  `num_serie` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bilhete`
--

INSERT INTO `bilhete` (`Tipo_bilhete_Tipo_bilhete_ID`, `Bilhete_ID`, `num_serie`) VALUES
(1, 1, 1),
(2, 2, 2),
(2, 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `convidado`
--

CREATE TABLE `convidado` (
  `Espectador_bilhete_Espectador_Espectador_ID` int(11) NOT NULL,
  `profissao` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `convidado`
--

INSERT INTO `convidado` (`Espectador_bilhete_Espectador_Espectador_ID`, `profissao`) VALUES
(2, 'COZINHEIRO\r\n');

-- --------------------------------------------------------

--
-- Table structure for table `devolucao`
--

CREATE TABLE `devolucao` (
  `Pagante_Espectador_bilhete_Espectador_Espectador_ID` int(11) NOT NULL,
  `Devolucao_ID` int(11) NOT NULL,
  `estado` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `devolucao`
--

INSERT INTO `devolucao` (`Pagante_Espectador_bilhete_Espectador_Espectador_ID`, `Devolucao_ID`, `estado`) VALUES
(1, 1, 'Sim');

-- --------------------------------------------------------

--
-- Table structure for table `dia`
--

CREATE TABLE `dia` (
  `Festival_Festival_ID` int(11) NOT NULL,
  `Dia_ID` int(11) NOT NULL,
  `data_dia` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dia`
--

INSERT INTO `dia` (`Festival_Festival_ID`, `Dia_ID`, `data_dia`) VALUES
(1, 1, '2023-10-06'),
(1, 2, '2023-10-07');

-- --------------------------------------------------------

--
-- Table structure for table `entrevista`
--

CREATE TABLE `entrevista` (
  `Participante_Participante_ID_` int(11) NOT NULL,
  `Jornalista_Espectador_Espectador_ID_` int(11) NOT NULL,
  `data` date DEFAULT NULL,
  `hora` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `entrevista`
--

INSERT INTO `entrevista` (`Participante_Participante_ID_`, `Jornalista_Espectador_Espectador_ID_`, `data`, `hora`) VALUES
(1, 3, '2023-10-07', '15:21:19');

-- --------------------------------------------------------

--
-- Table structure for table `espectador`
--

CREATE TABLE `espectador` (
  `Festival_Festival_ID` int(11) NOT NULL,
  `Espectador_ID` int(11) NOT NULL,
  `id_espectador` int(11) DEFAULT NULL,
  `genero` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `espectador`
--

INSERT INTO `espectador` (`Festival_Festival_ID`, `Espectador_ID`, `id_espectador`, `genero`) VALUES
(1, 1, 1, 'MASCULINO'),
(1, 2, 2, 'FEMININO'),
(1, 3, 3, 'MASCULINO'),
(1, 4, 4, NULL),
(1, 5, 5, 'FEMININO\r\n');

-- --------------------------------------------------------

--
-- Table structure for table `espectador_bilhete`
--

CREATE TABLE `espectador_bilhete` (
  `Espectador_Espectador_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `espectador_bilhete`
--

INSERT INTO `espectador_bilhete` (`Espectador_Espectador_ID`) VALUES
(1),
(2);

-- --------------------------------------------------------

--
-- Table structure for table `festival`
--

CREATE TABLE `festival` (
  `Localidade_Localidade_ID` int(11) NOT NULL,
  `Festival_ID` int(11) NOT NULL,
  `edicao_festival` int(11) DEFAULT NULL,
  `nome_festival` varchar(255) DEFAULT NULL,
  `lotacao` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `festival`
--

INSERT INTO `festival` (`Localidade_Localidade_ID`, `Festival_ID`, `edicao_festival`, `nome_festival`, `lotacao`) VALUES
(1, 1, 1, 'Festival do Caloiro', 2000);

-- --------------------------------------------------------

--
-- Table structure for table `grupo`
--

CREATE TABLE `grupo` (
  `Participante_Participante_ID` int(11) NOT NULL,
  `num_elementos` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `grupo`
--

INSERT INTO `grupo` (`Participante_Participante_ID`, `num_elementos`) VALUES
(1, 4),
(3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `individual`
--

CREATE TABLE `individual` (
  `Participante_Participante_ID` int(11) NOT NULL,
  `Grupo_Participante_Participante_ID` int(11) NOT NULL,
  `Nacionalidade_Nacionalidade_ID` int(11) NOT NULL,
  `nome_artista` varchar(255) DEFAULT NULL,
  `papel` varchar(255) DEFAULT NULL,
  `instrumento` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `individual`
--

INSERT INTO `individual` (`Participante_Participante_ID`, `Grupo_Participante_Participante_ID`, `Nacionalidade_Nacionalidade_ID`, `nome_artista`, `papel`, `instrumento`) VALUES
(1, 1, 1, 'Pedro ', 'Vocalista', 'Guitarra');

-- --------------------------------------------------------

--
-- Table structure for table `jornalista`
--

CREATE TABLE `jornalista` (
  `Espectador_Espectador_ID` int(11) NOT NULL,
  `num_car_jor` int(11) DEFAULT NULL,
  `media` varchar(255) DEFAULT NULL,
  `num_liv_trans` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jornalista`
--

INSERT INTO `jornalista` (`Espectador_Espectador_ID`, `num_car_jor`, `media`, `num_liv_trans`) VALUES
(3, 123, 'TVI', 1);

-- --------------------------------------------------------

--
-- Table structure for table `localidade`
--

CREATE TABLE `localidade` (
  `Localidade_ID` int(11) NOT NULL,
  `pais_localidade` varchar(255) DEFAULT NULL,
  `local` varchar(255) DEFAULT NULL,
  `localidade` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `localidade`
--

INSERT INTO `localidade` (`Localidade_ID`, `pais_localidade`, `local`, `localidade`) VALUES
(1, 'Portugal', 'ISCTE', 'Lisboa');

-- --------------------------------------------------------

--
-- Table structure for table `nacionalidade`
--

CREATE TABLE `nacionalidade` (
  `Nacionalidade_ID` int(11) NOT NULL,
  `pais` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nacionalidade`
--

INSERT INTO `nacionalidade` (`Nacionalidade_ID`, `pais`) VALUES
(1, 'PT'),
(2, 'EN'),
(3, 'BR');

-- --------------------------------------------------------

--
-- Table structure for table `organizacao`
--

CREATE TABLE `organizacao` (
  `Tecnico_Tecnico_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `organizacao`
--

INSERT INTO `organizacao` (`Tecnico_Tecnico_ID`) VALUES
(2);

-- --------------------------------------------------------

--
-- Table structure for table `pagante`
--

CREATE TABLE `pagante` (
  `Espectador_bilhete_Espectador_Espectador_ID` int(11) NOT NULL,
  `idade_pagante` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pagante`
--

INSERT INTO `pagante` (`Espectador_bilhete_Espectador_Espectador_ID`, `idade_pagante`) VALUES
(1, 20);

-- --------------------------------------------------------

--
-- Table structure for table `palco`
--

CREATE TABLE `palco` (
  `Palco_ID` int(11) NOT NULL,
  `codigo_palco` int(11) DEFAULT NULL,
  `nome_palco` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `palco`
--

INSERT INTO `palco` (`Palco_ID`, `codigo_palco`, `nome_palco`) VALUES
(1, 1, 'Palco Principal'),
(2, 2, 'Palco Pátio 2');

-- --------------------------------------------------------

--
-- Table structure for table `participacao`
--

CREATE TABLE `participacao` (
  `Participante_Participante_ID_` int(11) NOT NULL,
  `Festival_Festival_ID_` int(11) NOT NULL,
  `Dia_Dia_ID` int(11) NOT NULL,
  `cachet` int(11) DEFAULT NULL,
  `hora` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `participante`
--

CREATE TABLE `participante` (
  `Participante_Participante_ID` int(11) NOT NULL,
  `Participante_ID` int(11) NOT NULL,
  `codigo_participante` int(11) DEFAULT NULL,
  `nome_participante` varchar(255) DEFAULT NULL,
  `estilo_participante` varchar(255) DEFAULT NULL,
  `inicio_prev` datetime DEFAULT NULL,
  `fim_prev` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `participante`
--

INSERT INTO `participante` (`Participante_Participante_ID`, `Participante_ID`, `codigo_participante`, `nome_participante`, `estilo_participante`, `inicio_prev`, `fim_prev`) VALUES
(0, 0, NULL, NULL, NULL, NULL, NULL),
(0, 1, 1, 'En1', 'Rock', '2023-10-06 13:46:51', '2023-10-06 15:46:51'),
(0, 2, 2, 'Xutos', 'Rock', '2023-10-03 13:47:30', '2023-10-03 14:47:30'),
(2, 3, 3, 'Rui Veloso', 'Pop', '2023-10-07 11:50:27', '2023-10-07 12:50:27');

-- --------------------------------------------------------

--
-- Table structure for table `pertence`
--

CREATE TABLE `pertence` (
  `Bilhete_Bilhete_ID_` int(11) NOT NULL,
  `Espectador_bilhete_Espectador_Espectador_ID_` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pertence`
--

INSERT INTO `pertence` (`Bilhete_Bilhete_ID_`, `Espectador_bilhete_Espectador_Espectador_ID_`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `roadie`
--

CREATE TABLE `roadie` (
  `Participante_Participante_ID` int(11) NOT NULL,
  `Tecnico_Tecnico_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roadie`
--

INSERT INTO `roadie` (`Participante_Participante_ID`, `Tecnico_Tecnico_ID`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tecnico`
--

CREATE TABLE `tecnico` (
  `Tecnico_ID` int(11) NOT NULL,
  `num_tecnico` int(11) DEFAULT NULL,
  `nome_tecnico` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tecnico`
--

INSERT INTO `tecnico` (`Tecnico_ID`, `num_tecnico`, `nome_tecnico`) VALUES
(1, 1, 'Joao'),
(2, 2, 'Maria'),
(3, 3, 'António');

-- --------------------------------------------------------

--
-- Table structure for table `tecnificam`
--

CREATE TABLE `tecnificam` (
  `Tecnico_Tecnico_ID_` int(11) NOT NULL,
  `Palco_Palco_ID_` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tecnificam`
--

INSERT INTO `tecnificam` (`Tecnico_Tecnico_ID_`, `Palco_Palco_ID_`) VALUES
(2, 2),
(3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tema`
--

CREATE TABLE `tema` (
  `Participante_Participante_ID` int(11) NOT NULL,
  `Tema_ID` int(11) NOT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `ordem` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tema`
--

INSERT INTO `tema` (`Participante_Participante_ID`, `Tema_ID`, `titulo`, `ordem`) VALUES
(1, 1, 'Dias de Glória', 1),
(2, 2, 'Chuva Dissolvente', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tipo_bilhete`
--

CREATE TABLE `tipo_bilhete` (
  `Tipo_bilhete_ID` int(11) NOT NULL,
  `preco_bilhete` float DEFAULT NULL,
  `tipo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tipo_bilhete`
--

INSERT INTO `tipo_bilhete` (`Tipo_bilhete_ID`, `preco_bilhete`, `tipo`) VALUES
(1, 23.5, 'Diario'),
(2, 30, 'Passe Geral');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `associado`
--
ALTER TABLE `associado`
  ADD PRIMARY KEY (`Dia_Dia_ID_`,`Tipo_bilhete_Tipo_bilhete_ID_`),
  ADD KEY `FK_Tipo_bilhete_associado_Dia_` (`Tipo_bilhete_Tipo_bilhete_ID_`);

--
-- Indexes for table `bilhete`
--
ALTER TABLE `bilhete`
  ADD PRIMARY KEY (`Bilhete_ID`),
  ADD KEY `FK_Bilhete_tem_Tipo_bilhete` (`Tipo_bilhete_Tipo_bilhete_ID`);

--
-- Indexes for table `convidado`
--
ALTER TABLE `convidado`
  ADD PRIMARY KEY (`Espectador_bilhete_Espectador_Espectador_ID`);

--
-- Indexes for table `devolucao`
--
ALTER TABLE `devolucao`
  ADD PRIMARY KEY (`Devolucao_ID`),
  ADD KEY `FK_Devolucao_noname_Pagante` (`Pagante_Espectador_bilhete_Espectador_Espectador_ID`);

--
-- Indexes for table `dia`
--
ALTER TABLE `dia`
  ADD PRIMARY KEY (`Dia_ID`),
  ADD KEY `FK_Dia_noname_Festival` (`Festival_Festival_ID`);

--
-- Indexes for table `entrevista`
--
ALTER TABLE `entrevista`
  ADD PRIMARY KEY (`Participante_Participante_ID_`,`Jornalista_Espectador_Espectador_ID_`),
  ADD KEY `FK_Jornalista_Entrevista_Participante_` (`Jornalista_Espectador_Espectador_ID_`);

--
-- Indexes for table `espectador`
--
ALTER TABLE `espectador`
  ADD PRIMARY KEY (`Espectador_ID`),
  ADD KEY `FK_Espectador_noname_Festival` (`Festival_Festival_ID`);

--
-- Indexes for table `espectador_bilhete`
--
ALTER TABLE `espectador_bilhete`
  ADD PRIMARY KEY (`Espectador_Espectador_ID`);

--
-- Indexes for table `festival`
--
ALTER TABLE `festival`
  ADD PRIMARY KEY (`Festival_ID`),
  ADD KEY `FK_Festival_noname_Localidade` (`Localidade_Localidade_ID`);

--
-- Indexes for table `grupo`
--
ALTER TABLE `grupo`
  ADD PRIMARY KEY (`Participante_Participante_ID`);

--
-- Indexes for table `individual`
--
ALTER TABLE `individual`
  ADD PRIMARY KEY (`Participante_Participante_ID`,`Grupo_Participante_Participante_ID`),
  ADD KEY `FK_Individual_nascido_Nacionalidade` (`Nacionalidade_Nacionalidade_ID`),
  ADD KEY `FK_Individual_noname_Grupo` (`Grupo_Participante_Participante_ID`);

--
-- Indexes for table `jornalista`
--
ALTER TABLE `jornalista`
  ADD PRIMARY KEY (`Espectador_Espectador_ID`);

--
-- Indexes for table `localidade`
--
ALTER TABLE `localidade`
  ADD PRIMARY KEY (`Localidade_ID`);

--
-- Indexes for table `nacionalidade`
--
ALTER TABLE `nacionalidade`
  ADD PRIMARY KEY (`Nacionalidade_ID`);

--
-- Indexes for table `organizacao`
--
ALTER TABLE `organizacao`
  ADD PRIMARY KEY (`Tecnico_Tecnico_ID`);

--
-- Indexes for table `pagante`
--
ALTER TABLE `pagante`
  ADD PRIMARY KEY (`Espectador_bilhete_Espectador_Espectador_ID`);

--
-- Indexes for table `palco`
--
ALTER TABLE `palco`
  ADD PRIMARY KEY (`Palco_ID`);

--
-- Indexes for table `participacao`
--
ALTER TABLE `participacao`
  ADD PRIMARY KEY (`Participante_Participante_ID_`,`Festival_Festival_ID_`),
  ADD KEY `FK_Participacao_atuacao_Dia` (`Dia_Dia_ID`),
  ADD KEY `FK_Festival_Participacao_Participante_` (`Festival_Festival_ID_`);

--
-- Indexes for table `participante`
--
ALTER TABLE `participante`
  ADD PRIMARY KEY (`Participante_ID`),
  ADD KEY `FK_Participante_convite_Participante` (`Participante_Participante_ID`);

--
-- Indexes for table `pertence`
--
ALTER TABLE `pertence`
  ADD PRIMARY KEY (`Bilhete_Bilhete_ID_`,`Espectador_bilhete_Espectador_Espectador_ID_`),
  ADD KEY `FK_Espectador_bilhete_pertence_Bilhete_` (`Espectador_bilhete_Espectador_Espectador_ID_`);

--
-- Indexes for table `roadie`
--
ALTER TABLE `roadie`
  ADD PRIMARY KEY (`Tecnico_Tecnico_ID`),
  ADD KEY `FK_Roadie_orientam_Participante` (`Participante_Participante_ID`);

--
-- Indexes for table `tecnico`
--
ALTER TABLE `tecnico`
  ADD PRIMARY KEY (`Tecnico_ID`);

--
-- Indexes for table `tecnificam`
--
ALTER TABLE `tecnificam`
  ADD PRIMARY KEY (`Tecnico_Tecnico_ID_`,`Palco_Palco_ID_`),
  ADD KEY `FK_Palco_tecnificam_Tecnico_` (`Palco_Palco_ID_`);

--
-- Indexes for table `tema`
--
ALTER TABLE `tema`
  ADD PRIMARY KEY (`Tema_ID`),
  ADD KEY `FK_Tema_tocam_Participante` (`Participante_Participante_ID`);

--
-- Indexes for table `tipo_bilhete`
--
ALTER TABLE `tipo_bilhete`
  ADD PRIMARY KEY (`Tipo_bilhete_ID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `associado`
--
ALTER TABLE `associado`
  ADD CONSTRAINT `FK_Dia_associado_Tipo_bilhete_` FOREIGN KEY (`Dia_Dia_ID_`) REFERENCES `dia` (`Dia_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Tipo_bilhete_associado_Dia_` FOREIGN KEY (`Tipo_bilhete_Tipo_bilhete_ID_`) REFERENCES `tipo_bilhete` (`Tipo_bilhete_ID`);

--
-- Constraints for table `bilhete`
--
ALTER TABLE `bilhete`
  ADD CONSTRAINT `FK_Bilhete_tem_Tipo_bilhete` FOREIGN KEY (`Tipo_bilhete_Tipo_bilhete_ID`) REFERENCES `tipo_bilhete` (`Tipo_bilhete_ID`) ON UPDATE CASCADE;

--
-- Constraints for table `convidado`
--
ALTER TABLE `convidado`
  ADD CONSTRAINT `FK_Convidado_Espectador_bilhete` FOREIGN KEY (`Espectador_bilhete_Espectador_Espectador_ID`) REFERENCES `espectador_bilhete` (`Espectador_Espectador_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `devolucao`
--
ALTER TABLE `devolucao`
  ADD CONSTRAINT `FK_Devolucao_noname_Pagante` FOREIGN KEY (`Pagante_Espectador_bilhete_Espectador_Espectador_ID`) REFERENCES `pagante` (`Espectador_bilhete_Espectador_Espectador_ID`);

--
-- Constraints for table `dia`
--
ALTER TABLE `dia`
  ADD CONSTRAINT `FK_Dia_noname_Festival` FOREIGN KEY (`Festival_Festival_ID`) REFERENCES `festival` (`Festival_ID`);

--
-- Constraints for table `entrevista`
--
ALTER TABLE `entrevista`
  ADD CONSTRAINT `FK_Jornalista_Entrevista_Participante_` FOREIGN KEY (`Jornalista_Espectador_Espectador_ID_`) REFERENCES `jornalista` (`Espectador_Espectador_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Participante_Entrevista_Jornalista_` FOREIGN KEY (`Participante_Participante_ID_`) REFERENCES `participante` (`Participante_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `espectador`
--
ALTER TABLE `espectador`
  ADD CONSTRAINT `FK_Espectador_noname_Festival` FOREIGN KEY (`Festival_Festival_ID`) REFERENCES `festival` (`Festival_ID`) ON UPDATE CASCADE;

--
-- Constraints for table `espectador_bilhete`
--
ALTER TABLE `espectador_bilhete`
  ADD CONSTRAINT `FK_Espectador_bilhete_Espectador` FOREIGN KEY (`Espectador_Espectador_ID`) REFERENCES `espectador` (`Espectador_ID`);

--
-- Constraints for table `festival`
--
ALTER TABLE `festival`
  ADD CONSTRAINT `FK_Festival_noname_Localidade` FOREIGN KEY (`Localidade_Localidade_ID`) REFERENCES `localidade` (`Localidade_ID`) ON UPDATE CASCADE;

--
-- Constraints for table `grupo`
--
ALTER TABLE `grupo`
  ADD CONSTRAINT `FK_Grupo_Participante` FOREIGN KEY (`Participante_Participante_ID`) REFERENCES `participante` (`Participante_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `individual`
--
ALTER TABLE `individual`
  ADD CONSTRAINT `FK_Individual_Participante` FOREIGN KEY (`Participante_Participante_ID`) REFERENCES `participante` (`Participante_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Individual_nascido_Nacionalidade` FOREIGN KEY (`Nacionalidade_Nacionalidade_ID`) REFERENCES `nacionalidade` (`Nacionalidade_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Individual_noname_Grupo` FOREIGN KEY (`Grupo_Participante_Participante_ID`) REFERENCES `grupo` (`Participante_Participante_ID`);

--
-- Constraints for table `jornalista`
--
ALTER TABLE `jornalista`
  ADD CONSTRAINT `FK_Jornalista_Espectador` FOREIGN KEY (`Espectador_Espectador_ID`) REFERENCES `espectador` (`Espectador_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `organizacao`
--
ALTER TABLE `organizacao`
  ADD CONSTRAINT `FK_Organizacao_Tecnico` FOREIGN KEY (`Tecnico_Tecnico_ID`) REFERENCES `tecnico` (`Tecnico_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pagante`
--
ALTER TABLE `pagante`
  ADD CONSTRAINT `FK_Pagante_Espectador_bilhete` FOREIGN KEY (`Espectador_bilhete_Espectador_Espectador_ID`) REFERENCES `espectador_bilhete` (`Espectador_Espectador_ID`) ON UPDATE CASCADE;

--
-- Constraints for table `participacao`
--
ALTER TABLE `participacao`
  ADD CONSTRAINT `FK_Festival_Participacao_Participante_` FOREIGN KEY (`Festival_Festival_ID_`) REFERENCES `festival` (`Festival_ID`),
  ADD CONSTRAINT `FK_Participacao_atuacao_Dia` FOREIGN KEY (`Dia_Dia_ID`) REFERENCES `dia` (`Dia_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Participante_Participacao_Festival_` FOREIGN KEY (`Participante_Participante_ID_`) REFERENCES `participante` (`Participante_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `participante`
--
ALTER TABLE `participante`
  ADD CONSTRAINT `FK_Participante_convite_Participante` FOREIGN KEY (`Participante_Participante_ID`) REFERENCES `participante` (`Participante_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pertence`
--
ALTER TABLE `pertence`
  ADD CONSTRAINT `FK_Bilhete_pertence_Espectador_bilhete_` FOREIGN KEY (`Bilhete_Bilhete_ID_`) REFERENCES `bilhete` (`Bilhete_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_Espectador_bilhete_pertence_Bilhete_` FOREIGN KEY (`Espectador_bilhete_Espectador_Espectador_ID_`) REFERENCES `espectador_bilhete` (`Espectador_Espectador_ID`);

--
-- Constraints for table `roadie`
--
ALTER TABLE `roadie`
  ADD CONSTRAINT `FK_Roadie_Tecnico` FOREIGN KEY (`Tecnico_Tecnico_ID`) REFERENCES `tecnico` (`Tecnico_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Roadie_orientam_Participante` FOREIGN KEY (`Participante_Participante_ID`) REFERENCES `participante` (`Participante_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tecnificam`
--
ALTER TABLE `tecnificam`
  ADD CONSTRAINT `FK_Palco_tecnificam_Tecnico_` FOREIGN KEY (`Palco_Palco_ID_`) REFERENCES `palco` (`Palco_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Tecnico_tecnificam_Palco_` FOREIGN KEY (`Tecnico_Tecnico_ID_`) REFERENCES `tecnico` (`Tecnico_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tema`
--
ALTER TABLE `tema`
  ADD CONSTRAINT `FK_Tema_tocam_Participante` FOREIGN KEY (`Participante_Participante_ID`) REFERENCES `participante` (`Participante_ID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
