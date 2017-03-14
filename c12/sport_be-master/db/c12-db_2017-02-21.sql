-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Feb 21, 2017 at 05:59 PM
-- Server version: 5.6.35
-- PHP Version: 7.1.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `c12`
--

-- --------------------------------------------------------

--
-- Table structure for table `atleti`
--

CREATE TABLE `atleti` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `datanascita` date DEFAULT NULL,
  `sesso` char(1) DEFAULT NULL,
  `cf` varchar(16) DEFAULT 'UNIQUE',
  `telefono` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `atleti`
--

INSERT INTO `atleti` (`id`, `nome`, `datanascita`, `sesso`, `cf`, `telefono`) VALUES
(2, 'Beep Beep', '2017-02-12', 'f', 'BPEBPE79H59H501R', '32973211789'),
(3, 'Bolt', '1980-05-15', 'm', 'BLTUSN779467622', '34099988676'),
(4, 'carlo conti', '1967-02-10', 'm', 'CNTCRL445897123B', '34567986543');

-- --------------------------------------------------------

--
-- Table structure for table `categorie`
--

CREATE TABLE `categorie` (
  `id` int(11) NOT NULL,
  `categoria` varchar(50) NOT NULL DEFAULT 'UNIQUE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `categorie`
--

INSERT INTO `categorie` (`id`, `categoria`) VALUES
(1, 'maratona'),
(2, '10 km'),
(3, 'mezza maratona');

-- --------------------------------------------------------

--
-- Table structure for table `classifiche`
--

CREATE TABLE `classifiche` (
  `id` int(11) NOT NULL,
  `iscrizioni_id` int(11) NOT NULL,
  `tempo` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `classifiche`
--

INSERT INTO `classifiche` (`id`, `iscrizioni_id`, `tempo`) VALUES
(2, 2, '01:10:33'),
(3, 3, '01:14:00'),
(4, 4, '05:00:00');

-- --------------------------------------------------------

--
-- Stand-in structure for view `esvista`
-- (See below for the actual view)
--
CREATE TABLE `esvista` (
`nome` varchar(50)
,`cf` varchar(16)
,`pettorale` int(11)
,`gara` varchar(100)
,`km` int(11)
,`categoria` varchar(50)
,`tempo` time
);

-- --------------------------------------------------------

--
-- Table structure for table `gare`
--

CREATE TABLE `gare` (
  `id` int(11) NOT NULL,
  `gara` varchar(100) NOT NULL,
  `km` int(11) DEFAULT NULL,
  `orapartenza` timestamp NULL DEFAULT NULL,
  `luogopartenza` varchar(100) DEFAULT NULL,
  `luogoarrivo` varchar(100) DEFAULT NULL,
  `categorie_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `gare`
--

INSERT INTO `gare` (`id`, `gara`, `km`, `orapartenza`, `luogopartenza`, `luogoarrivo`, `categorie_id`) VALUES
(1, 'Torino - Lione', 666, '2017-02-27 23:00:00', 'Torino', 'Lione', 1);

-- --------------------------------------------------------

--
-- Table structure for table `iscrizioni`
--

CREATE TABLE `iscrizioni` (
  `id` int(11) NOT NULL,
  `atleti_id` int(11) NOT NULL,
  `gare_id` int(11) NOT NULL,
  `pettorale` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `iscrizioni`
--

INSERT INTO `iscrizioni` (`id`, `atleti_id`, `gare_id`, `pettorale`) VALUES
(2, 2, 1, 101),
(3, 3, 1, 2),
(4, 4, 1, 8);

-- --------------------------------------------------------

--
-- Stand-in structure for view `podio`
-- (See below for the actual view)
--
CREATE TABLE `podio` (
`id` int(11)
,`nome` varchar(50)
,`cf` varchar(16)
,`pettorale` int(11)
,`gara` varchar(100)
,`km` int(11)
,`categoria` varchar(50)
,`tempo` time
);

-- --------------------------------------------------------

--
-- Structure for view `esvista`
--
DROP TABLE IF EXISTS `esvista`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `esvista`  AS  select `atleti`.`nome` AS `nome`,`atleti`.`cf` AS `cf`,`iscrizioni`.`pettorale` AS `pettorale`,`gare`.`gara` AS `gara`,`gare`.`km` AS `km`,`categorie`.`categoria` AS `categoria`,`classifiche`.`tempo` AS `tempo` from ((((`classifiche` join `iscrizioni` on((`classifiche`.`iscrizioni_id` = `iscrizioni`.`id`))) join `atleti` on((`iscrizioni`.`atleti_id` = `atleti`.`id`))) join `gare` on((`iscrizioni`.`gare_id` = `gare`.`id`))) join `categorie` on((`gare`.`categorie_id` = `categorie`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `podio`
--
DROP TABLE IF EXISTS `podio`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `podio`  AS  select `classifiche`.`id` AS `id`,`atleti`.`nome` AS `nome`,`atleti`.`cf` AS `cf`,`iscrizioni`.`pettorale` AS `pettorale`,`gare`.`gara` AS `gara`,`gare`.`km` AS `km`,`categorie`.`categoria` AS `categoria`,`classifiche`.`tempo` AS `tempo` from ((((`classifiche` left join `iscrizioni` on((`classifiche`.`iscrizioni_id` = `iscrizioni`.`id`))) left join `atleti` on((`iscrizioni`.`atleti_id` = `atleti`.`id`))) left join `gare` on((`iscrizioni`.`gare_id` = `gare`.`id`))) left join `categorie` on((`gare`.`categorie_id` = `categorie`.`id`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `atleti`
--
ALTER TABLE `atleti`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categorie`
--
ALTER TABLE `categorie`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `classifiche`
--
ALTER TABLE `classifiche`
  ADD PRIMARY KEY (`id`),
  ADD KEY `iscrizioni_id` (`iscrizioni_id`);

--
-- Indexes for table `gare`
--
ALTER TABLE `gare`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `gara` (`gara`),
  ADD KEY `categorie_id` (`categorie_id`);

--
-- Indexes for table `iscrizioni`
--
ALTER TABLE `iscrizioni`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pettorale` (`pettorale`),
  ADD KEY `atleti_id` (`atleti_id`),
  ADD KEY `gare_id` (`gare_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `atleti`
--
ALTER TABLE `atleti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `categorie`
--
ALTER TABLE `categorie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `classifiche`
--
ALTER TABLE `classifiche`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `gare`
--
ALTER TABLE `gare`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `iscrizioni`
--
ALTER TABLE `iscrizioni`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `classifiche`
--
ALTER TABLE `classifiche`
  ADD CONSTRAINT `classifiche_ibfk_2` FOREIGN KEY (`iscrizioni_id`) REFERENCES `iscrizioni` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `gare`
--
ALTER TABLE `gare`
  ADD CONSTRAINT `gare_ibfk_1` FOREIGN KEY (`categorie_id`) REFERENCES `categorie` (`id`);

--
-- Constraints for table `iscrizioni`
--
ALTER TABLE `iscrizioni`
  ADD CONSTRAINT `iscrizioni_ibfk_2` FOREIGN KEY (`gare_id`) REFERENCES `gare` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `iscrizioni_ibfk_7` FOREIGN KEY (`atleti_id`) REFERENCES `atleti` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
