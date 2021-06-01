-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Erstellungszeit: 01. Jun 2021 um 12:15
-- Server-Version: 10.3.11-MariaDB-1:10.3.11+maria~bionic
-- PHP-Version: 7.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `open-bike-box-backend`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `action`
--

CREATE TABLE `action` (
  `id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `uid` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `request_uid` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `session` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `resource_id` bigint(20) DEFAULT NULL,
  `location_id` bigint(20) DEFAULT NULL,
  `resource_access_id` bigint(20) DEFAULT NULL,
  `pricegroup_id` bigint(20) DEFAULT NULL,
  `operator_id` bigint(20) DEFAULT NULL,
  `resource_cache` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `location_cache` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `resource_access_cache` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `pricegroup_cache` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `operator_cache` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `requested_at` datetime DEFAULT NULL,
  `valid_till` datetime DEFAULT NULL,
  `paid_at` datetime DEFAULT NULL,
  `begin` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `pin` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('reserved','booked','timeouted','cancelled','disrupted') COLLATE utf8_unicode_ci NOT NULL,
  `value_gross` decimal(8,4) NOT NULL,
  `value_net` decimal(8,4) NOT NULL,
  `value_tax` decimal(8,4) NOT NULL,
  `tax_rate` decimal(5,4) NOT NULL,
  `source` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_identifier` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `alembic_version`
--

CREATE TABLE `alembic_version` (
  `version_num` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `alembic_version`
--

INSERT INTO `alembic_version` (`version_num`) VALUES
('0fdb569171cc');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `alert`
--

CREATE TABLE `alert` (
  `id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `operator_id` bigint(20) DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` enum('other','closure') COLLATE utf8_unicode_ci DEFAULT NULL,
  `summary` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `file`
--

CREATE TABLE `file` (
  `id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mimetype` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Daten für Tabelle `file`
--

INSERT INTO `file` (`id`, `created`, `modified`, `name`, `mimetype`) VALUES
(1, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 'Logo', 'image/svg+xml'),
(2, '2021-06-01 12:14:40', '2021-06-01 12:14:40', NULL, 'image/jpeg'),
(3, '2021-06-01 12:14:40', '2021-06-01 12:14:40', NULL, 'image/jpeg'),
(4, '2021-06-01 12:14:40', '2021-06-01 12:14:40', NULL, 'image/jpeg'),
(5, '2021-06-01 12:14:41', '2021-06-01 12:14:41', NULL, 'image/jpeg'),
(6, '2021-06-01 12:14:41', '2021-06-01 12:14:41', NULL, 'image/jpeg'),
(7, '2021-06-01 12:14:41', '2021-06-01 12:14:41', NULL, 'image/jpeg'),
(8, '2021-06-01 12:14:41', '2021-06-01 12:14:41', NULL, 'image/jpeg');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `hardware`
--

CREATE TABLE `hardware` (
  `id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `future_booking` tinyint(1) DEFAULT NULL
) ;

--
-- Daten für Tabelle `hardware`
--

INSERT INTO `hardware` (`id`, `created`, `modified`, `name`, `future_booking`) VALUES
(1, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 'Einzel-Box', 0),
(2, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 'Sammel-Anlagen-Stellplatz', 0),
(3, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 'Cargo-Bike', 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `location`
--

CREATE TABLE `location` (
  `id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `operator_id` bigint(20) DEFAULT NULL,
  `photo_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lat` decimal(10,7) DEFAULT NULL,
  `lon` decimal(10,7) DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postalcode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `locality` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `osm_id` bigint(20) DEFAULT NULL,
  `geometry` point NOT NULL,
  `type` enum('bikebox','cargobike') COLLATE utf8_unicode_ci DEFAULT NULL,
  `twentyfourseven` tinyint(1) DEFAULT NULL
) ;

--
-- Daten für Tabelle `location`
--

INSERT INTO `location` (`id`, `created`, `modified`, `operator_id`, `photo_id`, `name`, `slug`, `lat`, `lon`, `address`, `postalcode`, `locality`, `country`, `description`, `osm_id`, `geometry`, `type`, `twentyfourseven`) VALUES
(1, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 1, 2, 'Fahrrad-Station Teststadt 1', 'fahrrad-station-teststadt', '51.5174770', '7.4605470', 'Königswall 15', '44137', 'Dortmund', 'de', NULL, NULL, '\0\0\0\0\0\0\0R·³¯<@jý¡ם@', 'cargobike', NULL),
(2, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 1, 3, 'Fahrrad-Station Demostadt', 'fahrrad-station-demo', '51.4791580', '7.2229040', 'Kurt-Schumacher-Platz 1', '44787', 'Bochum', 'de', NULL, NULL, '\0\0\0\0\0\0\0򎡌U½I@ 8򀤜@', NULL, NULL),
(3, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 4, 'Cargo-Bike-Station', 'cargo-bike-station', '48.5938110', '8.8632880', 'Bahnhofstraße 12', '71083', 'Herrenberg', 'de', NULL, NULL, '\0\0\0\0\0\0\0¦´ÿLH@ú~✰º!@', NULL, NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `location_alert`
--

CREATE TABLE `location_alert` (
  `location_id` bigint(20) DEFAULT NULL,
  `alert_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `location_file`
--

CREATE TABLE `location_file` (
  `location_id` bigint(20) DEFAULT NULL,
  `file_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `operator`
--

CREATE TABLE `operator` (
  `id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `logo_id` bigint(20) DEFAULT NULL,
  `tax_rate` decimal(5,4) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postalcode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `locality` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `future_booking` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Daten für Tabelle `operator`
--

INSERT INTO `operator` (`id`, `created`, `modified`, `logo_id`, `tax_rate`, `name`, `description`, `address`, `postalcode`, `locality`, `country`, `slug`, `url`, `email`, `future_booking`) VALUES
(1, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 1, '0.1900', 'Open Bike GmbH', NULL, 'Fahrradstraße 1', '12345', 'Fahrradstadt', 'de', 'open-bike-gmbh', 'https://openbikebox.de', 'test@open-bike.gmbh', '0'),
(2, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 1, '0.1900', 'Open Cargo GmbH', NULL, 'Fahrradstraße 1', '12345', 'Fahrradstadt', 'de', 'open-cargo-gmbh', 'https://opencargobike.de', 'test@open-cargo.gmbh', '1');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `option`
--

CREATE TABLE `option` (
  `id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `key` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` enum('string','date','datetime','integer','decimal','dict','list') COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pricegroup`
--

CREATE TABLE `pricegroup` (
  `id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `operator_id` bigint(20) DEFAULT NULL,
  `fee_hour` decimal(7,4) DEFAULT NULL,
  `fee_day` decimal(7,4) DEFAULT NULL,
  `fee_week` decimal(7,4) DEFAULT NULL,
  `fee_month` decimal(7,4) DEFAULT NULL,
  `fee_year` decimal(7,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Daten für Tabelle `pricegroup`
--

INSERT INTO `pricegroup` (`id`, `created`, `modified`, `operator_id`, `fee_hour`, `fee_day`, `fee_week`, `fee_month`, `fee_year`) VALUES
(1, '2021-06-01 12:14:40', '2021-06-01 12:14:40', NULL, '0.2000', '1.0000', '5.0000', '15.0000', '100.0000');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `regular_hours`
--

CREATE TABLE `regular_hours` (
  `id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `location_id` bigint(20) DEFAULT NULL,
  `weekday` smallint(6) DEFAULT NULL,
  `period_begin` int(11) DEFAULT NULL,
  `period_end` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Daten für Tabelle `regular_hours`
--

INSERT INTO `regular_hours` (`id`, `created`, `modified`, `location_id`, `weekday`, `period_begin`, `period_end`) VALUES
(1, '2021-06-01 12:14:40', '2021-06-01 12:14:40', NULL, 2, 36000, 68400),
(2, '2021-06-01 12:14:40', '2021-06-01 12:14:40', NULL, 3, 54000, 68400),
(3, '2021-06-01 12:14:40', '2021-06-01 12:14:40', NULL, 4, 54000, 68400),
(4, '2021-06-01 12:14:40', '2021-06-01 12:14:40', NULL, 5, 36000, 68400);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `resource`
--

CREATE TABLE `resource` (
  `id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `location_id` bigint(20) DEFAULT NULL,
  `pricegroup_id` bigint(20) DEFAULT NULL,
  `hardware_id` bigint(20) DEFAULT NULL,
  `resource_group_id` bigint(20) DEFAULT NULL,
  `resource_access_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `internal_identifier` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_identifier` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('free','taken','reserved','inactive','faulted') COLLATE utf8_unicode_ci DEFAULT NULL,
  `unavailable_until` datetime DEFAULT NULL,
  `installed_at` datetime DEFAULT NULL,
  `maintenance_from` datetime DEFAULT NULL,
  `maintenance_till` datetime DEFAULT NULL,
  `polygon_top` float DEFAULT NULL,
  `polygon_right` float DEFAULT NULL,
  `polygon_bottom` float DEFAULT NULL,
  `polygon_left` float DEFAULT NULL,
  `photo_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Daten für Tabelle `resource`
--

INSERT INTO `resource` (`id`, `created`, `modified`, `location_id`, `pricegroup_id`, `hardware_id`, `resource_group_id`, `resource_access_id`, `name`, `slug`, `description`, `internal_identifier`, `user_identifier`, `status`, `unavailable_until`, `installed_at`, `maintenance_from`, `maintenance_till`, `polygon_top`, `polygon_right`, `polygon_bottom`, `polygon_left`, `photo_id`) VALUES
(1, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 1, 1, 1, 1, 1, NULL, '3c9e762b-122c-4d0d-b023-77739d389cf4', NULL, '01', '01', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 1, 1, 0, 0, NULL),
(2, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 1, 1, 1, 1, 1, NULL, 'c0751923-5bd8-4d8c-829d-6f104c81a175', NULL, '02', '02', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 3, 1, 2, 0, NULL),
(3, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 1, 1, 1, 1, 1, NULL, '74b414e9-27bc-4f1b-9e4e-3b92f45ebea2', NULL, '03', '03', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 1, 2, 0, 1, NULL),
(4, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 1, 1, 1, 1, 1, NULL, '91e5b58a-30fb-41d5-bc37-e357e31b9074', NULL, '04', '04', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 3, 2, 2, 1, NULL),
(5, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 1, 1, 1, 1, 1, NULL, '8e468fae-e28a-4e04-b9e2-a893ff8fd2ff', NULL, '05', '05', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 1, 3, 0, 2, NULL),
(6, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 1, 1, 1, 1, 1, NULL, 'a93abe4e-8ef2-407c-9e95-d4869c686344', NULL, '06', '06', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 3, 3, 2, 2, NULL),
(7, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 1, 1, 1, 1, 1, NULL, 'd8cf3cca-c70a-48d9-9a17-44e16ed9a402', NULL, '07', '07', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 1, 4, 0, 3, NULL),
(8, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 1, 1, 1, 1, 1, NULL, 'd52c5b39-ea87-43b1-8f6a-fc645769f56c', NULL, '08', '08', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 3, 4, 2, 3, NULL),
(9, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 1, 1, 1, 1, 1, NULL, '927fcb25-ab7c-4d94-84e2-990d7a88dfff', NULL, '09', '09', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 1, 5, 0, 4, NULL),
(10, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 1, 1, 1, 1, 1, NULL, '72536b74-ddea-4eee-b965-bda725a8dc2f', NULL, '10', '10', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 3, 5, 2, 4, NULL),
(11, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, 'fa419a0a-5fed-4eb2-80da-a90a7b39c92f', NULL, '001', '001', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 1, 1, 0, 0, NULL),
(12, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, 'b0271303-8ec6-4b6b-a66a-d0dda2c54b4f', NULL, '002', '002', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 2, 1, 1, 0, NULL),
(13, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, '075b6ff6-d4aa-4d3c-9975-1cf0654ba099', NULL, '003', '003', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 3, 1, 2, 0, NULL),
(14, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, '3098c398-1528-4549-9e53-a667b1fe6b05', NULL, '004', '004', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 4, 1, 3, 0, NULL),
(15, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, '9a3bd6a0-f8e0-4354-8394-3213c2b2e9c2', NULL, '005', '005', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 5, 1, 4, 0, NULL),
(16, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, '67fb4934-cf5d-47a7-a2b9-ed0810fc9173', NULL, '006', '006', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 6, 1, 5, 0, NULL),
(17, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, '4aa3ad58-7f56-48e4-b4af-dd12d48e9684', NULL, '007', '007', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 7, 1, 6, 0, NULL),
(18, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, 'd9a58261-b40e-4b92-bb2e-f76e3c8c1ecb', NULL, '008', '008', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 8, 1, 7, 0, NULL),
(19, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, 'ad10d1a2-a245-4233-b5d0-117e89aecb7c', NULL, '009', '009', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 9, 1, 8, 0, NULL),
(20, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, '8ff3ab70-7a8e-48ec-ba60-d2b05e9572a3', NULL, '010', '010', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 10, 1, 9, 0, NULL),
(21, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, 'ba52eb7c-480e-4f70-9e39-c098927d97b6', NULL, '011', '011', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 1, 3, 0, 2, NULL),
(22, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, 'a15dab30-0350-42d8-bc93-7dcf622da373', NULL, '012', '012', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 2, 3, 1, 2, NULL),
(23, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, 'e981393a-cb4b-4b9d-88b2-6f98c833bb19', NULL, '013', '013', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 3, 3, 2, 2, NULL),
(24, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, '3774e91a-ed73-4293-82f1-846b01c3f35b', NULL, '014', '014', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 4, 3, 3, 2, NULL),
(25, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, 'c42222ba-7200-4552-8ae0-337177f52223', NULL, '015', '015', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 5, 3, 4, 2, NULL),
(26, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, 'b0ebab61-9d52-492a-9ee8-b193df63cd25', NULL, '016', '016', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 6, 3, 5, 2, NULL),
(27, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, '3ad4cf86-3da8-43e5-9464-2ba54fc10c9f', NULL, '017', '017', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 7, 3, 6, 2, NULL),
(28, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, 'ae0789a0-9cbc-4352-813b-6ffb3c6518f1', NULL, '018', '018', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 8, 3, 7, 2, NULL),
(29, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, '1af46150-1665-4491-afe7-851d675d93ec', NULL, '019', '019', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 9, 3, 8, 2, NULL),
(30, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, '0bd3296f-1270-4124-8d99-e1a4a3b15693', NULL, '020', '020', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 10, 3, 9, 2, NULL),
(31, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, '88b933e8-04df-46ca-9fd4-8d138ecc22eb', NULL, '021', '021', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 1, 4, 0, 3, NULL),
(32, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, '0085f114-da4a-40ae-81a6-bdd928dbc1f0', NULL, '022', '022', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 2, 4, 1, 3, NULL),
(33, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, 'aefc7c79-b334-4bfd-bbfd-770e092987aa', NULL, '023', '023', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 3, 4, 2, 3, NULL),
(34, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, '714e3db0-5f3f-404a-8b04-f7a39bbc86b3', NULL, '024', '024', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 4, 4, 3, 3, NULL),
(35, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, '5d3be4cd-27cb-4507-a24d-1cc6ba4662c1', NULL, '025', '025', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 5, 4, 4, 3, NULL),
(36, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, '0545dfd9-d206-4450-835a-990a0e56f273', NULL, '026', '026', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 6, 4, 5, 3, NULL),
(37, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, 'c1849892-0cb2-47d6-aee1-34e03fdcb19f', NULL, '027', '027', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 7, 4, 6, 3, NULL),
(38, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, '2e30fdda-4111-4049-a9b6-8ac741bc079f', NULL, '028', '028', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 8, 4, 7, 3, NULL),
(39, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, 'ab54dfbd-53fc-4849-a817-975229e90a4a', NULL, '029', '029', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 9, 4, 8, 3, NULL),
(40, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, 'd0cadd5d-d53a-41cd-aa6f-07c8210fe9dc', NULL, '030', '030', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 10, 4, 9, 3, NULL),
(41, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, '3022c74b-1db7-4f21-bff0-f871f3f391af', NULL, '031', '031', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 1, 6, 0, 5, NULL),
(42, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, 'a695a21f-95bf-459e-863c-ecaabff04782', NULL, '032', '032', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 2, 6, 1, 5, NULL),
(43, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, 'dbf5841f-2d49-4419-b5ce-ef6c82654415', NULL, '033', '033', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 3, 6, 2, 5, NULL),
(44, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, 'd9be7cc9-b746-4bef-b714-5aa23d5c719c', NULL, '034', '034', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 4, 6, 3, 5, NULL),
(45, '2021-06-01 12:14:40', '2021-06-01 12:14:40', 2, 1, 2, 2, 2, NULL, '012d25a7-4a7c-4261-82e1-3f90e4133c36', NULL, '035', '035', 'free', NULL, '2021-06-01 12:14:40', NULL, NULL, 5, 6, 4, 5, NULL),
(46, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, 'c328d879-9b65-4a0b-b99b-65d88632d773', NULL, '036', '036', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 6, 6, 5, 5, NULL),
(47, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, 'fd1387e1-5586-4a29-96d0-8b5964b8ddc0', NULL, '037', '037', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 7, 6, 6, 5, NULL),
(48, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, '521409d5-5798-438d-8b97-a9132f812661', NULL, '038', '038', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 8, 6, 7, 5, NULL),
(49, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, 'fb0ca776-d389-425d-8732-132da41779c2', NULL, '039', '039', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 9, 6, 8, 5, NULL),
(50, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, '6fb4b958-bf55-4c9d-a29b-8bffc6e35e15', NULL, '040', '040', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 10, 6, 9, 5, NULL),
(51, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, '304b74e9-164f-41be-aa30-45d466e78455', NULL, '041', '041', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 1, 7, 0, 6, NULL),
(52, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, '04df55b0-1071-4372-ab12-7894196cd330', NULL, '042', '042', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 2, 7, 1, 6, NULL),
(53, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, '4dfda907-d78c-4f1e-a181-acfe5c2dcb6e', NULL, '043', '043', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 3, 7, 2, 6, NULL),
(54, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, '4fafcb2e-df69-49e6-b543-425e370a6dc5', NULL, '044', '044', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 4, 7, 3, 6, NULL),
(55, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, 'c8ba844f-148d-4bd7-a7ce-64a6acd58f10', NULL, '045', '045', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 5, 7, 4, 6, NULL),
(56, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, '984e71f5-b21f-4a06-9d35-5146d61f065c', NULL, '046', '046', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 6, 7, 5, 6, NULL),
(57, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, '98b936c9-27c3-4af0-ae3f-3173e99ecefc', NULL, '047', '047', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 7, 7, 6, 6, NULL),
(58, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, '8dbbe05f-da21-4d0e-b257-db64b6684367', NULL, '048', '048', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 8, 7, 7, 6, NULL),
(59, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, 'f72c64a5-d116-44c8-a7ae-a9dc1a0c9701', NULL, '049', '049', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 9, 7, 8, 6, NULL),
(60, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, '0d406092-d5c5-4144-ba6a-0bc098d32f1d', NULL, '050', '050', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 10, 7, 9, 6, NULL),
(61, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, '9348dc23-2672-450a-9eb4-39c6269caeb0', NULL, '051', '051', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 1, 9, 0, 8, NULL),
(62, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, 'b403509f-b80d-40d1-b966-bec6a1356189', NULL, '052', '052', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 2, 9, 1, 8, NULL),
(63, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, 'ec1dd863-0392-4564-a7aa-ab3c2d6cb6b8', NULL, '053', '053', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 3, 9, 2, 8, NULL),
(64, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, '67c9e4f9-3283-4935-8fc2-2218c9157037', NULL, '054', '054', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 4, 9, 3, 8, NULL),
(65, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, '7c99fed2-2166-480d-ba95-3ec929863de6', NULL, '055', '055', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 5, 9, 4, 8, NULL),
(66, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, 'e164d6d6-cc5f-40b5-b54d-feae15cbd120', NULL, '056', '056', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 6, 9, 5, 8, NULL),
(67, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, '7e221b39-29c3-4014-9387-dea89ba898ff', NULL, '057', '057', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 7, 9, 6, 8, NULL),
(68, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, '602ac53d-2448-4f6c-88d9-dd9f738c2cbe', NULL, '058', '058', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 8, 9, 7, 8, NULL),
(69, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, '8b439e90-5080-41af-a1c9-5f3adc59f71b', NULL, '059', '059', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 9, 9, 8, 8, NULL),
(70, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 2, 1, 2, 2, 2, NULL, '9cb3bccc-aa68-4eb1-a469-e85f7b85abd0', NULL, '060', '060', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, 10, 9, 9, 8, NULL),
(71, '2021-06-01 12:14:41', '2021-06-01 12:14:41', 3, 1, 3, NULL, NULL, NULL, 'd41e6658-611d-4829-a6ba-3b4ac9612525', NULL, 'cargobike-1', 'cargobike-1', 'free', NULL, '2021-06-01 12:14:41', NULL, NULL, NULL, NULL, NULL, NULL, 5);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `resource_access`
--

CREATE TABLE `resource_access` (
  `id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `location_id` bigint(20) DEFAULT NULL,
  `internal_identifier` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `salt` varchar(255) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Daten für Tabelle `resource_access`
--

INSERT INTO `resource_access` (`id`, `created`, `modified`, `location_id`, `internal_identifier`, `salt`) VALUES
(1, '2021-06-01 12:14:40', '2021-06-01 12:14:40', NULL, '001', '123456'),
(2, '2021-06-01 12:14:40', '2021-06-01 12:14:40', NULL, '002', '654321');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `resource_alert`
--

CREATE TABLE `resource_alert` (
  `resource_id` bigint(20) DEFAULT NULL,
  `alert_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `resource_file`
--

CREATE TABLE `resource_file` (
  `resource_id` bigint(20) DEFAULT NULL,
  `file_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `resource_file`
--

INSERT INTO `resource_file` (`resource_id`, `file_id`) VALUES
(71, 6),
(71, 7),
(71, 8);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `resource_group`
--

CREATE TABLE `resource_group` (
  `id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `location_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `internal_identifier` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_identifier` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive','faulted') COLLATE utf8_unicode_ci DEFAULT NULL,
  `max_bookingdate` int(11) DEFAULT NULL,
  `installed_at` datetime DEFAULT NULL,
  `maintenance_from` datetime DEFAULT NULL,
  `maintenance_till` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Daten für Tabelle `resource_group`
--

INSERT INTO `resource_group` (`id`, `created`, `modified`, `location_id`, `name`, `description`, `slug`, `internal_identifier`, `user_identifier`, `status`, `max_bookingdate`, `installed_at`, `maintenance_from`, `maintenance_till`) VALUES
(1, '2021-06-01 12:14:40', '2021-06-01 12:14:40', NULL, 'Fahrrad-Station Teststadt', NULL, 'fahrrad-station-teststadt', 'teststadt-1', 'teststadt-1', 'active', 365, '2021-06-01 12:14:40', NULL, NULL),
(2, '2021-06-01 12:14:40', '2021-06-01 12:14:40', NULL, 'Fahrrad-Station Demostadt', NULL, 'fahrrad-station-demostadt', 'demostadt-1', 'demostadt-1', 'active', 365, '2021-06-01 12:14:40', NULL, NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `resource_group_image`
--

CREATE TABLE `resource_group_image` (
  `resource_group_id` bigint(20) DEFAULT NULL,
  `file_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `user`
--

CREATE TABLE `user` (
  `id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `operator_id` bigint(20) DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `login_datetime` datetime DEFAULT NULL,
  `last_login_datetime` datetime DEFAULT NULL,
  `login_ip` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_login_ip` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `failed_login_count` int(11) DEFAULT NULL,
  `last_failed_login_count` int(11) DEFAULT NULL,
  `firstname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postalcode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `locality` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `language` enum('de','en') COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `capabilities` text COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Daten für Tabelle `user`
--

INSERT INTO `user` (`id`, `created`, `modified`, `operator_id`, `email`, `password`, `login_datetime`, `last_login_datetime`, `login_ip`, `last_login_ip`, `failed_login_count`, `last_failed_login_count`, `firstname`, `lastname`, `company`, `address`, `postalcode`, `locality`, `country`, `language`, `phone`, `mobile`, `capabilities`) VALUES
(1, '2021-06-01 12:14:40', '2021-06-01 12:14:40', NULL, 'test@binary-butterfly.de', '$2b$12$WjJ/YNe2SqbD0l1lz4VXWeEk5RI3HdnpOovFiuWyZVhEeeLPX15NW', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'binary butterfly GmbH', 'Am Hertinger Tor', '59423', 'Unna', 'DE', 'de', NULL, NULL, '[\"admin\"]');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `action`
--
ALTER TABLE `action`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uid` (`uid`),
  ADD KEY `ix_action_source` (`source`);

--
-- Indizes für die Tabelle `alembic_version`
--
ALTER TABLE `alembic_version`
  ADD PRIMARY KEY (`version_num`);

--
-- Indizes für die Tabelle `alert`
--
ALTER TABLE `alert`
  ADD PRIMARY KEY (`id`),
  ADD KEY `operator_id` (`operator_id`);

--
-- Indizes für die Tabelle `file`
--
ALTER TABLE `file`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `hardware`
--
ALTER TABLE `hardware`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ix_location_slug` (`slug`),
  ADD KEY `photo_id` (`photo_id`),
  ADD KEY `operator_id` (`operator_id`);

--
-- Indizes für die Tabelle `location_alert`
--
ALTER TABLE `location_alert`
  ADD KEY `alert_id` (`alert_id`),
  ADD KEY `location_id` (`location_id`);

--
-- Indizes für die Tabelle `location_file`
--
ALTER TABLE `location_file`
  ADD KEY `file_id` (`file_id`),
  ADD KEY `location_id` (`location_id`);

--
-- Indizes für die Tabelle `operator`
--
ALTER TABLE `operator`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ix_operator_slug` (`slug`),
  ADD KEY `logo_id` (`logo_id`);

--
-- Indizes für die Tabelle `option`
--
ALTER TABLE `option`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ix_option_key` (`key`);

--
-- Indizes für die Tabelle `pricegroup`
--
ALTER TABLE `pricegroup`
  ADD PRIMARY KEY (`id`),
  ADD KEY `operator_id` (`operator_id`);

--
-- Indizes für die Tabelle `regular_hours`
--
ALTER TABLE `regular_hours`
  ADD PRIMARY KEY (`id`),
  ADD KEY `location_id` (`location_id`);

--
-- Indizes für die Tabelle `resource`
--
ALTER TABLE `resource`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ix_resource_slug` (`slug`),
  ADD KEY `pricegroup_id` (`pricegroup_id`),
  ADD KEY `hardware_id` (`hardware_id`),
  ADD KEY `resource_group_id` (`resource_group_id`),
  ADD KEY `resource_access_id` (`resource_access_id`),
  ADD KEY `location_id` (`location_id`),
  ADD KEY `photo_id` (`photo_id`);

--
-- Indizes für die Tabelle `resource_access`
--
ALTER TABLE `resource_access`
  ADD PRIMARY KEY (`id`),
  ADD KEY `location_id` (`location_id`);

--
-- Indizes für die Tabelle `resource_alert`
--
ALTER TABLE `resource_alert`
  ADD KEY `alert_id` (`alert_id`),
  ADD KEY `resource_id` (`resource_id`);

--
-- Indizes für die Tabelle `resource_file`
--
ALTER TABLE `resource_file`
  ADD KEY `file_id` (`file_id`),
  ADD KEY `resource_id` (`resource_id`);

--
-- Indizes für die Tabelle `resource_group`
--
ALTER TABLE `resource_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ix_resource_group_slug` (`slug`),
  ADD KEY `location_id` (`location_id`);

--
-- Indizes für die Tabelle `resource_group_image`
--
ALTER TABLE `resource_group_image`
  ADD KEY `file_id` (`file_id`),
  ADD KEY `resource_group_id` (`resource_group_id`);

--
-- Indizes für die Tabelle `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ix_user_email` (`email`),
  ADD KEY `operator_id` (`operator_id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `action`
--
ALTER TABLE `action`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `alert`
--
ALTER TABLE `alert`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `file`
--
ALTER TABLE `file`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT für Tabelle `hardware`
--
ALTER TABLE `hardware`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `location`
--
ALTER TABLE `location`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `operator`
--
ALTER TABLE `operator`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `option`
--
ALTER TABLE `option`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `pricegroup`
--
ALTER TABLE `pricegroup`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `regular_hours`
--
ALTER TABLE `regular_hours`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `resource`
--
ALTER TABLE `resource`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT für Tabelle `resource_access`
--
ALTER TABLE `resource_access`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `resource_group`
--
ALTER TABLE `resource_group`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `user`
--
ALTER TABLE `user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `alert`
--
ALTER TABLE `alert`
  ADD CONSTRAINT `alert_ibfk_2` FOREIGN KEY (`operator_id`) REFERENCES `operator` (`id`);

--
-- Constraints der Tabelle `location`
--
ALTER TABLE `location`
  ADD CONSTRAINT `location_ibfk_1` FOREIGN KEY (`photo_id`) REFERENCES `file` (`id`),
  ADD CONSTRAINT `location_ibfk_2` FOREIGN KEY (`operator_id`) REFERENCES `operator` (`id`);

--
-- Constraints der Tabelle `location_alert`
--
ALTER TABLE `location_alert`
  ADD CONSTRAINT `location_alert_ibfk_1` FOREIGN KEY (`alert_id`) REFERENCES `alert` (`id`),
  ADD CONSTRAINT `location_alert_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`);

--
-- Constraints der Tabelle `location_file`
--
ALTER TABLE `location_file`
  ADD CONSTRAINT `location_file_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `file` (`id`),
  ADD CONSTRAINT `location_file_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`);

--
-- Constraints der Tabelle `operator`
--
ALTER TABLE `operator`
  ADD CONSTRAINT `operator_ibfk_1` FOREIGN KEY (`logo_id`) REFERENCES `file` (`id`);

--
-- Constraints der Tabelle `pricegroup`
--
ALTER TABLE `pricegroup`
  ADD CONSTRAINT `pricegroup_ibfk_1` FOREIGN KEY (`operator_id`) REFERENCES `operator` (`id`);

--
-- Constraints der Tabelle `regular_hours`
--
ALTER TABLE `regular_hours`
  ADD CONSTRAINT `regular_hours_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`);

--
-- Constraints der Tabelle `resource`
--
ALTER TABLE `resource`
  ADD CONSTRAINT `resource_ibfk_1` FOREIGN KEY (`pricegroup_id`) REFERENCES `pricegroup` (`id`),
  ADD CONSTRAINT `resource_ibfk_2` FOREIGN KEY (`hardware_id`) REFERENCES `hardware` (`id`),
  ADD CONSTRAINT `resource_ibfk_3` FOREIGN KEY (`resource_group_id`) REFERENCES `resource_group` (`id`),
  ADD CONSTRAINT `resource_ibfk_4` FOREIGN KEY (`resource_access_id`) REFERENCES `resource_access` (`id`),
  ADD CONSTRAINT `resource_ibfk_5` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`),
  ADD CONSTRAINT `resource_ibfk_6` FOREIGN KEY (`photo_id`) REFERENCES `file` (`id`);

--
-- Constraints der Tabelle `resource_access`
--
ALTER TABLE `resource_access`
  ADD CONSTRAINT `resource_access_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`);

--
-- Constraints der Tabelle `resource_alert`
--
ALTER TABLE `resource_alert`
  ADD CONSTRAINT `resource_alert_ibfk_1` FOREIGN KEY (`alert_id`) REFERENCES `alert` (`id`),
  ADD CONSTRAINT `resource_alert_ibfk_2` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`);

--
-- Constraints der Tabelle `resource_file`
--
ALTER TABLE `resource_file`
  ADD CONSTRAINT `resource_file_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `file` (`id`),
  ADD CONSTRAINT `resource_file_ibfk_2` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`);

--
-- Constraints der Tabelle `resource_group`
--
ALTER TABLE `resource_group`
  ADD CONSTRAINT `resource_group_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`);

--
-- Constraints der Tabelle `resource_group_image`
--
ALTER TABLE `resource_group_image`
  ADD CONSTRAINT `resource_group_image_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `file` (`id`),
  ADD CONSTRAINT `resource_group_image_ibfk_2` FOREIGN KEY (`resource_group_id`) REFERENCES `resource_group` (`id`);

--
-- Constraints der Tabelle `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`operator_id`) REFERENCES `operator` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
