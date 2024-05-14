-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 18, 2023 at 07:31 PM
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
-- Database: `musysys_1`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `clonar_edicao_P1` (IN `edicao_clone` INT(15), IN `data_inicial` DATE)   BEGIN
DECLARE nova_ed INT;


  SELECT MAX(numero) + 1 INTO nova_ed FROM edicao;


  INSERT INTO edicao (numero, nome, localidade, local_e, data_inicio, data_fim, lotacao )
 SELECT nova_ed as numero, nome, localidade, local_e, data_inicial AS data_inicio,DATE_ADD( edicao.data_fim, INTERVAL DATEDIFF(data_inicial, edicao.data_inicio) DAY) AS data_fim, lotacao
    FROM edicao
    WHERE edicao.numero = edicao_clone
    LIMIT 1;


  INSERT INTO palco (Edicao_numero, codigo, nome)
  SELECT nova_ed AS Edicao_numero, codigo, nome
    FROM palco
    WHERE palco.Edicao_numero = edicao_clone;

 
  INSERT INTO dia_festival(Edicao_numero, data, espetadores)
  SELECT nova_ed AS Edicao_numero, DATE_ADD(dia_festival.data, INTERVAL DATEDIFF(data_inicial, edicao.data_inicio) DAY) AS data, 0 AS qtd_espetadores
    FROM dia_festival, edicao
    WHERE dia_festival.Edicao_numero = edicao.numero
    AND dia_festival.Edicao_numero = edicao_clone;

COMMIT;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `criar_edicao_P2` (IN `nome_edicao` VARCHAR(15), IN `localidade` VARCHAR(15), IN `local_` VARCHAR(15), IN `lotacao` INT(100), IN `data_inicio` DATE, IN `data_fim` DATE, IN `nr_palcos` INT(15))   BEGIN
DECLARE i INTEGER;
DECLARE numero_edicao INTEGER;

SET numero_edicao=(SELECT MAX(numero) FROM edicao)+1;
INSERT INTO edicao(numero,nome,localidade,local_e,data_inicio,data_fim,lotacao) VALUES (numero_edicao,nome_edicao,localidade,local_,data_inicio,data_fim,lotacao);


SET i=nr_palcos;

WHILE  i>0 DO


INSERT INTO palco(Edicao_numero,codigo,nome) VALUES (numero_edicao,i,(SELECT CONCAT('Palco',i)));

COMMIT;

SET i=i-1;
END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Q1_Cartaz` (IN `edicao_num` TINYINT)   SELECT  
    participante.nome as Participante, 
    contrata.Dia_festival_data as Dia
FROM 
    participante, contrata
WHERE 
    participante.codigo = contrata.Participante_codigo_ 
    AND contrata.Edicao_numero_ = edicao_num
ORDER BY
    contrata.Dia_festival_data ASC,
    contrata.cachet DESC$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `CalcularMedia_F1` () RETURNS INT(11)  BEGIN
DECLARE
    media_lucro NUMERIC;
    SELECT AVG(edicao.lucro) INTO media_lucro
    FROM edicao;

    RETURN media_lucro;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `CalcularNrParticipantes_F2` () RETURNS INT(11)  BEGIN 
DECLARE nr_edicao INTEGER;

SET nr_edicao = ( SELECT Max(edicao.numero) from edicao);

RETURN (SELECT edicao.nr_participantes FROM edicao WHERE edicao.numero = nr_edicao);

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `acesso`
--

CREATE TABLE `acesso` (
  `Dia_festival_data_` date NOT NULL,
  `Tipo_de_bilhete_Nome_` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `acesso`
--

INSERT INTO `acesso` (`Dia_festival_data_`, `Tipo_de_bilhete_Nome_`) VALUES
('2024-04-12', 'Diário 12'),
('2024-04-14', 'Diário 12');

-- --------------------------------------------------------

--
-- Table structure for table `bilhete`
--

CREATE TABLE `bilhete` (
  `num_serie` int(11) NOT NULL,
  `Tipo_de_bilhete_Nome` varchar(30) NOT NULL,
  `Espetador_com_bilhete_Espetador_identificador` int(11) DEFAULT NULL,
  `designacao` varchar(60) DEFAULT NULL,
  `devolvido` tinyint(1) DEFAULT 0,
  `Edicao_numero` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bilhete`
--

INSERT INTO `bilhete` (`num_serie`, `Tipo_de_bilhete_Nome`, `Espetador_com_bilhete_Espetador_identificador`, `designacao`, `devolvido`, `Edicao_numero`) VALUES
(1, 'Diário 12', NULL, 'Diário 2', 0, 1),
(2, 'Diário 12', NULL, 'Diário 3', 0, 2);

--
-- Triggers `bilhete`
--
DELIMITER $$
CREATE TRIGGER `AuxLucro_F1` AFTER INSERT ON `bilhete` FOR EACH ROW BEGIN



IF (SELECT new.devolvido)=1 THEN
UPDATE edicao
SET lucro=lucro-(SELECT p.preco FROM tipo_de_bilhete p WHERE new.Tipo_de_bilhete_Nome=p.nome);
ELSE
UPDATE edicao
SET lucro=lucro+(SELECT p.preco FROM tipo_de_bilhete p WHERE new.Tipo_de_bilhete_Nome=p.nome);
END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `manage_ticket_T2` BEFORE INSERT ON `bilhete` FOR EACH ROW BEGIN
IF new.devolvido=0 THEN

IF (SELECT e.qtd_espetadores FROM edicao e WHERE e.numero=new.Edicao_numero)>=(SELECT e.lotacao FROM edicao e WHERE e.numero=new.Edicao_numero) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT="Lotação do festival excedida";
END IF;

UPDATE edicao SET qtd_espetadores = qtd_espetadores + 1 WHERE edicao.numero = new.Edicao_numero;
ELSE
UPDATE edicao SET qtd_espetadores = qtd_espetadores - 1 WHERE edicao.numero = new.Edicao_numero;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `contrata`
--

CREATE TABLE `contrata` (
  `Edicao_numero_` tinyint(4) NOT NULL,
  `Participante_codigo_` smallint(6) NOT NULL,
  `cachet` int(11) DEFAULT NULL,
  `Palco_Edicao_numero` tinyint(4) NOT NULL,
  `Palco_codigo` tinyint(4) NOT NULL,
  `Dia_festival_data` date NOT NULL,
  `hora_inicio` time DEFAULT NULL,
  `hora_fim` time DEFAULT NULL,
  `Convidado_Edicao_numero_` tinyint(4) DEFAULT NULL,
  `Convidado_Participante_codigo_` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contrata`
--

INSERT INTO `contrata` (`Edicao_numero_`, `Participante_codigo_`, `cachet`, `Palco_Edicao_numero`, `Palco_codigo`, `Dia_festival_data`, `hora_inicio`, `hora_fim`, `Convidado_Edicao_numero_`, `Convidado_Participante_codigo_`) VALUES
(1, 4, 666, 1, 1, '2024-04-13', '20:49:00', '30:49:00', NULL, NULL),
(2, 4, 5555, 1, 1, '2024-04-12', '21:23:52', '18:23:52', NULL, NULL);

--
-- Triggers `contrata`
--
DELIMITER $$
CREATE TRIGGER `AuxNrParticipantes_F2` AFTER INSERT ON `contrata` FOR EACH ROW BEGIN
UPDATE edicao
SET nr_participantes=nr_participantes+1
WHERE edicao.numero=new.Edicao_numero_;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `dia_festival`
--

CREATE TABLE `dia_festival` (
  `Edicao_numero` tinyint(4) NOT NULL,
  `data` date NOT NULL,
  `Faturacao` int(10) NOT NULL,
  `espetadores` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dia_festival`
--

INSERT INTO `dia_festival` (`Edicao_numero`, `data`, `Faturacao`, `espetadores`) VALUES
(2, '2024-04-12', 0, 400),
(2, '2024-04-13', 0, 200),
(2, '2024-04-14', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `edicao`
--

CREATE TABLE `edicao` (
  `numero` tinyint(4) NOT NULL,
  `nome` varchar(60) DEFAULT NULL,
  `localidade` varchar(60) DEFAULT NULL,
  `local_e` varchar(60) DEFAULT NULL,
  `data_inicio` date DEFAULT NULL,
  `data_fim` date DEFAULT NULL,
  `lotacao` int(11) DEFAULT NULL,
  `qtd_espetadores` int(11) NOT NULL,
  `lucro` decimal(10,0) NOT NULL,
  `nr_participantes` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `edicao`
--

INSERT INTO `edicao` (`numero`, `nome`, `localidade`, `local_e`, `data_inicio`, `data_fim`, `lotacao`, `qtd_espetadores`, `lucro`, `nr_participantes`) VALUES
(1, 'Iscte Fest', 'Lisboa', 'Entrecampos', '2023-12-12', '2023-12-14', 7000, 0, 50, 2),
(2, 'Iscte Fest', 'Lisboa', 'Entrecampos', '2024-04-12', '2024-04-14', 10000, 2, 5000, 2),
(3, 'ISCTE LISBOA', 'LISBOA', 'ISCTE', '2023-12-01', '2023-12-03', 5000, 0, 0, 0),
(4, 'Iscte', 'Lisboa', 'Iscte', '2023-12-01', '2023-12-04', 6666, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `elemento_grupo`
--

CREATE TABLE `elemento_grupo` (
  `Individual_Participante_codigo_` smallint(6) NOT NULL,
  `Grupo_Participante_codigo_` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `entrevista`
--

CREATE TABLE `entrevista` (
  `Participante_codigo_` smallint(6) NOT NULL,
  `Jornalista_num_carteira_profissional_` int(11) NOT NULL,
  `data` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `edicao_entrevista` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `entrevista`
--

INSERT INTO `entrevista` (`Participante_codigo_`, `Jornalista_num_carteira_profissional_`, `data`, `hora`, `edicao_entrevista`) VALUES
(4, 1, '2023-12-01', '18:22:25', 2),
(4, 2, '2024-04-12', '20:00:00', 2);

-- --------------------------------------------------------

--
-- Table structure for table `espetador`
--

CREATE TABLE `espetador` (
  `identificador` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `genero` enum('M','F') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `espetador`
--

INSERT INTO `espetador` (`identificador`, `nome`, `genero`) VALUES
(1, 'Luís', 'M'),
(2, 'Filipe', 'M'),
(3, 'Luísa', 'F'),
(4, 'Sofia', 'F');

-- --------------------------------------------------------

--
-- Table structure for table `espetador_com_bilhete`
--

CREATE TABLE `espetador_com_bilhete` (
  `Espetador_identificador` int(11) NOT NULL,
  `profissao` varchar(60) NOT NULL,
  `tipo` enum('Pagante','Convidado') NOT NULL,
  `idade` tinyint(4) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `genero` enum('M','F') NOT NULL,
  `dia_festival_data` date NOT NULL,
  `nome_Bilhete` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `espetador_com_bilhete`
--

INSERT INTO `espetador_com_bilhete` (`Espetador_identificador`, `profissao`, `tipo`, `idade`, `nome`, `genero`, `dia_festival_data`, `nome_Bilhete`) VALUES
(2, 'Professor', 'Pagante', 30, 'Filipe', 'M', '2024-04-12', 'Geral'),
(3, 'Engenheira', 'Pagante', 24, 'Luísa', 'F', '2024-04-13', 'Diário 12'),
(4, 'Cabeleireira', 'Pagante', 54, 'Sofia', 'F', '2024-04-14', 'Diário 12');

-- --------------------------------------------------------

--
-- Table structure for table `estilo`
--

CREATE TABLE `estilo` (
  `Nome` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `estilo`
--

INSERT INTO `estilo` (`Nome`) VALUES
('Pop'),
('Trap');

-- --------------------------------------------------------

--
-- Table structure for table `estilo_de_artista`
--

CREATE TABLE `estilo_de_artista` (
  `Participante_codigo_` smallint(6) NOT NULL,
  `Estilo_Nome_` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `grupo`
--

CREATE TABLE `grupo` (
  `Participante_codigo` smallint(6) NOT NULL,
  `qtd_elementos` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `individual`
--

CREATE TABLE `individual` (
  `Participante_codigo` smallint(6) NOT NULL,
  `Pais_nome` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jornalista`
--

CREATE TABLE `jornalista` (
  `Espetador_identificador` int(11) NOT NULL,
  `Media_nome` varchar(30) NOT NULL,
  `num_carteira_profissional` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jornalista`
--

INSERT INTO `jornalista` (`Espetador_identificador`, `Media_nome`, `num_carteira_profissional`) VALUES
(3, 'Megahits', 1),
(1, 'TVI', 2);

-- --------------------------------------------------------

--
-- Table structure for table `livre_transito`
--

CREATE TABLE `livre_transito` (
  `Edicao_numero_` tinyint(4) NOT NULL,
  `Jornalista_num_carteira_profissional_` int(11) NOT NULL,
  `numero` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `livre_transito`
--

INSERT INTO `livre_transito` (`Edicao_numero_`, `Jornalista_num_carteira_profissional_`, `numero`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `nome` varchar(30) NOT NULL,
  `tipo` enum('Rádio','TV','Jornal','Revista') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `media`
--

INSERT INTO `media` (`nome`, `tipo`) VALUES
('Megahits', 'Rádio'),
('TVI', 'TV');

-- --------------------------------------------------------

--
-- Table structure for table `montado`
--

CREATE TABLE `montado` (
  `Palco_Edicao_numero_` tinyint(4) NOT NULL,
  `Palco_codigo_` tinyint(4) NOT NULL,
  `Tecnico_numero_` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `montado`
--
DELIMITER $$
CREATE TRIGGER `confirm_roadieT1` AFTER INSERT ON `montado` FOR EACH ROW BEGIN
IF (SELECT a.Palco_codigo FROM contrata a WHERE a.Participante_codigo_=(SELECT p.Participante_codigo FROM tecnico p WHERE p.numero=new.Tecnico_numero_)) != new.Palco_codigo_ THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Roadie to Participante do not correspond";
  DELETE FROM montado WHERE montado.Palco_Edicao_numero_=new.Palco_Edicao_numero_ AND montado.Palco_codigo_=new.Palco_codigo_ AND montado.Tecnico_numero_=new.Tecnico_numero_;

END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pais`
--

CREATE TABLE `pais` (
  `nome` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pais`
--

INSERT INTO `pais` (`nome`) VALUES
('Portugal'),
('Senegal');

-- --------------------------------------------------------

--
-- Table structure for table `palco`
--

CREATE TABLE `palco` (
  `Edicao_numero` tinyint(4) NOT NULL,
  `codigo` tinyint(4) NOT NULL,
  `nome` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `palco`
--

INSERT INTO `palco` (`Edicao_numero`, `codigo`, `nome`) VALUES
(1, 1, 'Oeste'),
(1, 2, 'Norte'),
(2, 3, 'Norte'),
(2, 4, 'Sul');

-- --------------------------------------------------------

--
-- Table structure for table `papel`
--

CREATE TABLE `papel` (
  `Nome` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `papel`
--

INSERT INTO `papel` (`Nome`) VALUES
('Vocalista');

-- --------------------------------------------------------

--
-- Table structure for table `papel_no_grupo`
--

CREATE TABLE `papel_no_grupo` (
  `Elemento_grupo_Individual_Participante_codigo__` smallint(6) NOT NULL,
  `Elemento_grupo_Grupo_Participante_codigo__` smallint(6) NOT NULL,
  `Papel_Nome_` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `participante`
--

CREATE TABLE `participante` (
  `codigo` smallint(6) NOT NULL,
  `nome` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `participante`
--

INSERT INTO `participante` (`codigo`, `nome`) VALUES
(4, 'Rui Veloso');

-- --------------------------------------------------------

--
-- Stand-in structure for view `q2_resultados_diarios`
-- (See below for the actual view)
--
CREATE TABLE `q2_resultados_diarios` (
`Edicao` tinyint(4)
,`Dia_Festival` date
,`Quantidade de espetadores` bigint(21)
,`Faturacao diaria` decimal(28,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `q3_quantidade_espetadores`
-- (See below for the actual view)
--
CREATE TABLE `q3_quantidade_espetadores` (
`numero_edicao` tinyint(4)
,`dia_festival` date
,`total_espetadores` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `q4_estilos_musicais_por_edicao`
-- (See below for the actual view)
--
CREATE TABLE `q4_estilos_musicais_por_edicao` (
`Edicao` tinyint(4)
,`Estilo` varchar(30)
,`Qtd_artistas` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `q5_todos_os_participantes`
-- (See below for the actual view)
--
CREATE TABLE `q5_todos_os_participantes` (
`codigo_participante` smallint(6)
,`nome_participante` varchar(80)
,`anos_desde_ultima_atuacao` bigint(21)
,`cachet_ultima_atuacao` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `q6_entrevistados`
-- (See below for the actual view)
--
CREATE TABLE `q6_entrevistados` (
`Edicao` tinyint(4)
,`Jornalista` int(11)
,`Participantes Entrevistados` mediumtext
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `q7_sem_entrevista`
-- (See below for the actual view)
--
CREATE TABLE `q7_sem_entrevista` (
`Edicao` tinyint(4)
,`Jornalista` int(11)
,`Participante sem entrevista` mediumtext
);

-- --------------------------------------------------------

--
-- Table structure for table `reportagem`
--

CREATE TABLE `reportagem` (
  `Dia_festival_data_` date NOT NULL,
  `Jornalista_num_carteira_profissional_` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reportagem`
--

INSERT INTO `reportagem` (`Dia_festival_data_`, `Jornalista_num_carteira_profissional_`) VALUES
('2024-04-12', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tecnico`
--

CREATE TABLE `tecnico` (
  `numero` int(11) NOT NULL,
  `nome` varchar(120) DEFAULT NULL,
  `tipo` enum('Roadie','Organização','','') NOT NULL,
  `Participante_codigo` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tema`
--

CREATE TABLE `tema` (
  `Edicao_numero` tinyint(4) NOT NULL,
  `Participante_codigo` smallint(6) NOT NULL,
  `nr_ordem` tinyint(4) NOT NULL,
  `titulo` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tipo_de_bilhete`
--

CREATE TABLE `tipo_de_bilhete` (
  `Nome` varchar(30) NOT NULL,
  `preco` decimal(6,2) NOT NULL,
  `id_tipo_bilhete` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tipo_de_bilhete`
--

INSERT INTO `tipo_de_bilhete` (`Nome`, `preco`, `id_tipo_bilhete`) VALUES
('Diário 12', 5.00, 1),
('Geral', 10.00, 2);

-- --------------------------------------------------------

--
-- Structure for view `q2_resultados_diarios`
--
DROP TABLE IF EXISTS `q2_resultados_diarios`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `q2_resultados_diarios`  AS SELECT `dia_festival`.`Edicao_numero` AS `Edicao`, `dia_festival`.`data` AS `Dia_Festival`, count(`espetador_com_bilhete`.`dia_festival_data` = `dia_festival`.`data` and `espetador_com_bilhete`.`nome_Bilhete` = `tipo_de_bilhete`.`Nome`) AS `Quantidade de espetadores`, sum(case when `bilhete`.`devolvido` = 0 and `espetador_com_bilhete`.`nome_Bilhete` = `tipo_de_bilhete`.`Nome` and `bilhete`.`Edicao_numero` = `dia_festival`.`Edicao_numero` and `espetador_com_bilhete`.`tipo` = 'Pagante' then `tipo_de_bilhete`.`preco` else 0 end) AS `Faturacao diaria` FROM (((`dia_festival` join `bilhete`) join `tipo_de_bilhete`) join `espetador_com_bilhete`) WHERE `dia_festival`.`Edicao_numero` = `bilhete`.`Edicao_numero` AND `dia_festival`.`data` = `espetador_com_bilhete`.`dia_festival_data` AND `espetador_com_bilhete`.`nome_Bilhete` = `tipo_de_bilhete`.`Nome` GROUP BY `espetador_com_bilhete`.`dia_festival_data` ;

-- --------------------------------------------------------

--
-- Structure for view `q3_quantidade_espetadores`
--
DROP TABLE IF EXISTS `q3_quantidade_espetadores`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `q3_quantidade_espetadores`  AS SELECT `edicao`.`numero` AS `numero_edicao`, `dia_festival`.`data` AS `dia_festival`, count(distinct `espetador`.`identificador`) AS `total_espetadores` FROM ((((((`bilhete` join `edicao`) join `dia_festival`) join `acesso`) join `espetador`) join `espetador_com_bilhete`) join `jornalista`) WHERE `dia_festival`.`Edicao_numero` = `edicao`.`numero` AND `dia_festival`.`data` = `espetador_com_bilhete`.`dia_festival_data` AND `acesso`.`Dia_festival_data_` = `dia_festival`.`data` AND `espetador_com_bilhete`.`Espetador_identificador` = `espetador`.`identificador` OR `jornalista`.`Espetador_identificador` = `espetador`.`identificador` GROUP BY `edicao`.`numero`, `dia_festival`.`data` ;

-- --------------------------------------------------------

--
-- Structure for view `q4_estilos_musicais_por_edicao`
--
DROP TABLE IF EXISTS `q4_estilos_musicais_por_edicao`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `q4_estilos_musicais_por_edicao`  AS SELECT `contrata`.`Edicao_numero_` AS `Edicao`, `estilo`.`Nome` AS `Estilo`, count(`participante`.`codigo`) AS `Qtd_artistas` FROM (((`contrata` join `participante`) join `estilo_de_artista`) join `estilo`) WHERE `participante`.`codigo` = `contrata`.`Participante_codigo_` AND `estilo_de_artista`.`Participante_codigo_` = `participante`.`codigo` AND `estilo`.`Nome` = `estilo_de_artista`.`Estilo_Nome_` GROUP BY `contrata`.`Edicao_numero_`, `estilo`.`Nome` ;

-- --------------------------------------------------------

--
-- Structure for view `q5_todos_os_participantes`
--
DROP TABLE IF EXISTS `q5_todos_os_participantes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `q5_todos_os_participantes`  AS SELECT `participante`.`codigo` AS `codigo_participante`, `participante`.`nome` AS `nome_participante`, timestampdiff(YEAR,`contrata`.`Dia_festival_data`,max(`edicao`.`data_fim`)) AS `anos_desde_ultima_atuacao`, `contrata`.`cachet` AS `cachet_ultima_atuacao` FROM ((`participante` join `contrata`) join `edicao`) WHERE `participante`.`codigo` = `contrata`.`Participante_codigo_` AND `contrata`.`Edicao_numero_` = `edicao`.`numero` AND `edicao`.`numero` = `contrata`.`Edicao_numero_` GROUP BY `participante`.`codigo`, `participante`.`nome`, `contrata`.`cachet` ;

-- --------------------------------------------------------

--
-- Structure for view `q6_entrevistados`
--
DROP TABLE IF EXISTS `q6_entrevistados`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `q6_entrevistados`  AS SELECT `edicao`.`numero` AS `Edicao`, `jornalista`.`num_carteira_profissional` AS `Jornalista`, group_concat(distinct case when `entrevista`.`Participante_codigo_` = `participante`.`codigo` then `participante`.`nome` end separator ',') AS `Participantes Entrevistados` FROM ((((`edicao` join `participante`) join `jornalista`) join `entrevista`) join `contrata`) WHERE `edicao`.`numero` = `entrevista`.`edicao_entrevista` AND `entrevista`.`Jornalista_num_carteira_profissional_` = `jornalista`.`num_carteira_profissional` AND `participante`.`codigo` = `entrevista`.`Participante_codigo_` GROUP BY `edicao`.`numero`, `jornalista`.`num_carteira_profissional`, `entrevista`.`edicao_entrevista` ;

-- --------------------------------------------------------

--
-- Structure for view `q7_sem_entrevista`
--
DROP TABLE IF EXISTS `q7_sem_entrevista`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `q7_sem_entrevista`  AS SELECT max(`edicao`.`numero`) AS `Edicao`, `jornalista`.`num_carteira_profissional` AS `Jornalista`, group_concat(distinct `participante`.`nome` separator ',') AS `Participante sem entrevista` FROM ((((`edicao` join `entrevista`) join `contrata`) join `jornalista`) join `participante`) WHERE `edicao`.`numero` = `contrata`.`Edicao_numero_` AND `entrevista`.`Jornalista_num_carteira_profissional_` = `jornalista`.`num_carteira_profissional` AND `participante`.`codigo` <> `entrevista`.`Participante_codigo_` AND !(`participante`.`codigo` in (select `entrevista`.`Participante_codigo_` from `entrevista` where `jornalista`.`num_carteira_profissional` = `entrevista`.`Jornalista_num_carteira_profissional_`)) GROUP BY `entrevista`.`edicao_entrevista`, `jornalista`.`num_carteira_profissional` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `acesso`
--
ALTER TABLE `acesso`
  ADD PRIMARY KEY (`Dia_festival_data_`,`Tipo_de_bilhete_Nome_`),
  ADD KEY `FK_Tipo_de_bilhete_acesso_Dia_festival_` (`Tipo_de_bilhete_Nome_`);

--
-- Indexes for table `bilhete`
--
ALTER TABLE `bilhete`
  ADD PRIMARY KEY (`num_serie`),
  ADD KEY `FK_Bilhete_noname_Tipo_de_bilhete` (`Tipo_de_bilhete_Nome`),
  ADD KEY `FK_Bilhete_tem_Espetador_com_bilhete` (`Espetador_com_bilhete_Espetador_identificador`);

--
-- Indexes for table `contrata`
--
ALTER TABLE `contrata`
  ADD PRIMARY KEY (`Edicao_numero_`,`Participante_codigo_`),
  ADD KEY `FK_Participante_Contrata_Edicao_` (`Participante_codigo_`),
  ADD KEY `FK_Contrata_apresenta_Palco` (`Palco_Edicao_numero`,`Palco_codigo`),
  ADD KEY `FK_Contrata_Atuacao_Dia_festival` (`Dia_festival_data`),
  ADD KEY `FK_Participante_Convida_Participante_` (`Convidado_Edicao_numero_`,`Convidado_Participante_codigo_`);

--
-- Indexes for table `dia_festival`
--
ALTER TABLE `dia_festival`
  ADD PRIMARY KEY (`data`),
  ADD KEY `FK_Dia_festival_noname_Edicao` (`Edicao_numero`);

--
-- Indexes for table `edicao`
--
ALTER TABLE `edicao`
  ADD PRIMARY KEY (`numero`);

--
-- Indexes for table `elemento_grupo`
--
ALTER TABLE `elemento_grupo`
  ADD PRIMARY KEY (`Individual_Participante_codigo_`,`Grupo_Participante_codigo_`),
  ADD KEY `FK_Grupo_Elemento_grupo_Individual_` (`Grupo_Participante_codigo_`);

--
-- Indexes for table `entrevista`
--
ALTER TABLE `entrevista`
  ADD PRIMARY KEY (`Participante_codigo_`,`Jornalista_num_carteira_profissional_`),
  ADD KEY `FK_Jornalista_Entrevista_Participante_` (`Jornalista_num_carteira_profissional_`),
  ADD KEY `Edicao_numero` (`edicao_entrevista`);

--
-- Indexes for table `espetador`
--
ALTER TABLE `espetador`
  ADD PRIMARY KEY (`identificador`);

--
-- Indexes for table `espetador_com_bilhete`
--
ALTER TABLE `espetador_com_bilhete`
  ADD PRIMARY KEY (`Espetador_identificador`),
  ADD KEY `Espetador_com_bilhete_Nome_Bilhete` (`nome_Bilhete`),
  ADD KEY `dia_festival_data` (`dia_festival_data`),
  ADD KEY `nome_Bilhete` (`nome_Bilhete`);

--
-- Indexes for table `estilo`
--
ALTER TABLE `estilo`
  ADD PRIMARY KEY (`Nome`);

--
-- Indexes for table `estilo_de_artista`
--
ALTER TABLE `estilo_de_artista`
  ADD PRIMARY KEY (`Participante_codigo_`,`Estilo_Nome_`),
  ADD KEY `FK_Estilo_estilo_de_artista_Participante_` (`Estilo_Nome_`);

--
-- Indexes for table `grupo`
--
ALTER TABLE `grupo`
  ADD PRIMARY KEY (`Participante_codigo`);

--
-- Indexes for table `individual`
--
ALTER TABLE `individual`
  ADD PRIMARY KEY (`Participante_codigo`),
  ADD KEY `FK_Individual_origem_Pais` (`Pais_nome`);

--
-- Indexes for table `jornalista`
--
ALTER TABLE `jornalista`
  ADD PRIMARY KEY (`num_carteira_profissional`),
  ADD KEY `FK_Jornalista_Espetador` (`Espetador_identificador`),
  ADD KEY `FK_Jornalista_representa_Media` (`Media_nome`);

--
-- Indexes for table `livre_transito`
--
ALTER TABLE `livre_transito`
  ADD PRIMARY KEY (`Edicao_numero_`,`Jornalista_num_carteira_profissional_`),
  ADD KEY `FK_Jornalista_Livre_transito_Edicao_` (`Jornalista_num_carteira_profissional_`);

--
-- Indexes for table `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`nome`);

--
-- Indexes for table `montado`
--
ALTER TABLE `montado`
  ADD PRIMARY KEY (`Palco_Edicao_numero_`,`Palco_codigo_`,`Tecnico_numero_`),
  ADD KEY `FK_Tecnico_montado_Palco_` (`Tecnico_numero_`);

--
-- Indexes for table `pais`
--
ALTER TABLE `pais`
  ADD PRIMARY KEY (`nome`);

--
-- Indexes for table `palco`
--
ALTER TABLE `palco`
  ADD PRIMARY KEY (`Edicao_numero`,`codigo`);

--
-- Indexes for table `papel`
--
ALTER TABLE `papel`
  ADD PRIMARY KEY (`Nome`);

--
-- Indexes for table `papel_no_grupo`
--
ALTER TABLE `papel_no_grupo`
  ADD PRIMARY KEY (`Elemento_grupo_Individual_Participante_codigo__`,`Elemento_grupo_Grupo_Participante_codigo__`,`Papel_Nome_`),
  ADD KEY `FK_Papel_papel_no_grupo_Elemento_grupo_` (`Papel_Nome_`);

--
-- Indexes for table `participante`
--
ALTER TABLE `participante`
  ADD PRIMARY KEY (`codigo`);

--
-- Indexes for table `reportagem`
--
ALTER TABLE `reportagem`
  ADD PRIMARY KEY (`Dia_festival_data_`,`Jornalista_num_carteira_profissional_`),
  ADD KEY `FK_Jornalista_Reportagem_Dia_festival_` (`Jornalista_num_carteira_profissional_`);

--
-- Indexes for table `tecnico`
--
ALTER TABLE `tecnico`
  ADD PRIMARY KEY (`numero`),
  ADD KEY `ligado` (`Participante_codigo`);

--
-- Indexes for table `tema`
--
ALTER TABLE `tema`
  ADD PRIMARY KEY (`Edicao_numero`,`Participante_codigo`,`nr_ordem`);

--
-- Indexes for table `tipo_de_bilhete`
--
ALTER TABLE `tipo_de_bilhete`
  ADD PRIMARY KEY (`Nome`,`id_tipo_bilhete`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `acesso`
--
ALTER TABLE `acesso`
  ADD CONSTRAINT `FK_Dia_festival_acesso_Tipo_de_bilhete_` FOREIGN KEY (`Dia_festival_data_`) REFERENCES `dia_festival` (`data`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Tipo_de_bilhete_acesso_Dia_festival_` FOREIGN KEY (`Tipo_de_bilhete_Nome_`) REFERENCES `tipo_de_bilhete` (`Nome`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `bilhete`
--
ALTER TABLE `bilhete`
  ADD CONSTRAINT `FK_Bilhete_noname_Tipo_de_bilhete` FOREIGN KEY (`Tipo_de_bilhete_Nome`) REFERENCES `tipo_de_bilhete` (`Nome`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Bilhete_tem_Espetador_com_bilhete` FOREIGN KEY (`Espetador_com_bilhete_Espetador_identificador`) REFERENCES `espetador_com_bilhete` (`Espetador_identificador`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `contrata`
--
ALTER TABLE `contrata`
  ADD CONSTRAINT `FK_Contrata_Atuacao_Dia_festival` FOREIGN KEY (`Dia_festival_data`) REFERENCES `dia_festival` (`data`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Contrata_apresenta_Palco` FOREIGN KEY (`Palco_Edicao_numero`,`Palco_codigo`) REFERENCES `palco` (`Edicao_numero`, `codigo`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Edicao_Contrata_Participante_` FOREIGN KEY (`Edicao_numero_`) REFERENCES `edicao` (`numero`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Participante_Contrata_Edicao_` FOREIGN KEY (`Participante_codigo_`) REFERENCES `participante` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Participante_Convida_Participante_` FOREIGN KEY (`Convidado_Edicao_numero_`,`Convidado_Participante_codigo_`) REFERENCES `contrata` (`Edicao_numero_`, `Participante_codigo_`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `dia_festival`
--
ALTER TABLE `dia_festival`
  ADD CONSTRAINT `FK_Dia_festival_noname_Edicao` FOREIGN KEY (`Edicao_numero`) REFERENCES `edicao` (`numero`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `elemento_grupo`
--
ALTER TABLE `elemento_grupo`
  ADD CONSTRAINT `FK_Grupo_Elemento_grupo_Individual_` FOREIGN KEY (`Grupo_Participante_codigo_`) REFERENCES `grupo` (`Participante_codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Individual_Elemento_grupo_Grupo_` FOREIGN KEY (`Individual_Participante_codigo_`) REFERENCES `individual` (`Participante_codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `entrevista`
--
ALTER TABLE `entrevista`
  ADD CONSTRAINT `FK_Jornalista_Entrevista_Participante_` FOREIGN KEY (`Jornalista_num_carteira_profissional_`) REFERENCES `jornalista` (`num_carteira_profissional`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Participante_Entrevista_Jornalista_` FOREIGN KEY (`Participante_codigo_`) REFERENCES `participante` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Fk_edicao` FOREIGN KEY (`edicao_entrevista`) REFERENCES `edicao` (`numero`);

--
-- Constraints for table `espetador_com_bilhete`
--
ALTER TABLE `espetador_com_bilhete`
  ADD CONSTRAINT `FK_Espetador_com_bilhete_Espetador` FOREIGN KEY (`Espetador_identificador`) REFERENCES `espetador` (`identificador`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Fk_espetador_com_bilhete_data_festival` FOREIGN KEY (`dia_festival_data`) REFERENCES `dia_festival` (`data`),
  ADD CONSTRAINT `Fk_nome_Bilhete` FOREIGN KEY (`nome_Bilhete`) REFERENCES `tipo_de_bilhete` (`Nome`);

--
-- Constraints for table `estilo_de_artista`
--
ALTER TABLE `estilo_de_artista`
  ADD CONSTRAINT `FK_Estilo_estilo_de_artista_Participante_` FOREIGN KEY (`Estilo_Nome_`) REFERENCES `estilo` (`Nome`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Participante_estilo_de_artista_Estilo_` FOREIGN KEY (`Participante_codigo_`) REFERENCES `participante` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `grupo`
--
ALTER TABLE `grupo`
  ADD CONSTRAINT `FK_Grupo_Participante` FOREIGN KEY (`Participante_codigo`) REFERENCES `participante` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `individual`
--
ALTER TABLE `individual`
  ADD CONSTRAINT `FK_Individual_Participante` FOREIGN KEY (`Participante_codigo`) REFERENCES `participante` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Individual_origem_Pais` FOREIGN KEY (`Pais_nome`) REFERENCES `pais` (`nome`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `jornalista`
--
ALTER TABLE `jornalista`
  ADD CONSTRAINT `FK_Jornalista_Espetador` FOREIGN KEY (`Espetador_identificador`) REFERENCES `espetador` (`identificador`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Jornalista_representa_Media` FOREIGN KEY (`Media_nome`) REFERENCES `media` (`nome`) ON UPDATE CASCADE;

--
-- Constraints for table `livre_transito`
--
ALTER TABLE `livre_transito`
  ADD CONSTRAINT `FK_Edicao_Livre_transito_Jornalista_` FOREIGN KEY (`Edicao_numero_`) REFERENCES `edicao` (`numero`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Jornalista_Livre_transito_Edicao_` FOREIGN KEY (`Jornalista_num_carteira_profissional_`) REFERENCES `jornalista` (`num_carteira_profissional`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `montado`
--
ALTER TABLE `montado`
  ADD CONSTRAINT `FK_Palco_montado_Tecnico_` FOREIGN KEY (`Palco_Edicao_numero_`,`Palco_codigo_`) REFERENCES `palco` (`Edicao_numero`, `codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Tecnico_montado_Palco_` FOREIGN KEY (`Tecnico_numero_`) REFERENCES `tecnico` (`numero`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `palco`
--
ALTER TABLE `palco`
  ADD CONSTRAINT `FK_Palco_tem_Edicao` FOREIGN KEY (`Edicao_numero`) REFERENCES `edicao` (`numero`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `papel_no_grupo`
--
ALTER TABLE `papel_no_grupo`
  ADD CONSTRAINT `FK_Elemento_grupo_papel_no_grupo_Papel_` FOREIGN KEY (`Elemento_grupo_Individual_Participante_codigo__`,`Elemento_grupo_Grupo_Participante_codigo__`) REFERENCES `elemento_grupo` (`Individual_Participante_codigo_`, `Grupo_Participante_codigo_`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Papel_papel_no_grupo_Elemento_grupo_` FOREIGN KEY (`Papel_Nome_`) REFERENCES `papel` (`Nome`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `reportagem`
--
ALTER TABLE `reportagem`
  ADD CONSTRAINT `FK_Dia_festival_Reportagem_Jornalista_` FOREIGN KEY (`Dia_festival_data_`) REFERENCES `dia_festival` (`data`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Jornalista_Reportagem_Dia_festival_` FOREIGN KEY (`Jornalista_num_carteira_profissional_`) REFERENCES `jornalista` (`num_carteira_profissional`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tecnico`
--
ALTER TABLE `tecnico`
  ADD CONSTRAINT `tecnico_ibfk_1` FOREIGN KEY (`Participante_codigo`) REFERENCES `participante` (`codigo`) ON UPDATE CASCADE;

--
-- Constraints for table `tema`
--
ALTER TABLE `tema`
  ADD CONSTRAINT `FK_Tema_enterpretado_Contrata` FOREIGN KEY (`Edicao_numero`,`Participante_codigo`) REFERENCES `contrata` (`Edicao_numero_`, `Participante_codigo_`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
