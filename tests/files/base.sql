-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Erstellungszeit: 01. Jun 2021 um 06:59
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
('cc9ecd78e189');

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
(1, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 'Logo', 'image/svg+xml'),
(2, '2021-06-01 06:57:39', '2021-06-01 06:57:39', NULL, 'image/jpeg'),
(3, '2021-06-01 06:57:39', '2021-06-01 06:57:39', NULL, 'image/jpeg'),
(4, '2021-06-01 06:57:39', '2021-06-01 06:57:39', NULL, 'image/jpeg'),
(5, '2021-06-01 06:57:40', '2021-06-01 06:57:40', NULL, 'image/jpeg'),
(6, '2021-06-01 06:57:40', '2021-06-01 06:57:40', NULL, 'image/jpeg'),
(7, '2021-06-01 06:57:40', '2021-06-01 06:57:40', NULL, 'image/jpeg'),
(8, '2021-06-01 06:57:40', '2021-06-01 06:57:40', NULL, 'image/jpeg');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `hardware`
--

CREATE TABLE `hardware` (
  `id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Daten für Tabelle `hardware`
--

INSERT INTO `hardware` (`id`, `created`, `modified`, `name`) VALUES
(1, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 'Einzel-Box'),
(2, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 'Sammel-Anlagen-Stellplatz'),
(3, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 'Cargo-Bike');

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
  `twentyforseven` tinyint(1) DEFAULT NULL,
  `geometry` point NOT NULL
) ;

--
-- Daten für Tabelle `location`
--

INSERT INTO `location` (`id`, `created`, `modified`, `operator_id`, `photo_id`, `name`, `slug`, `lat`, `lon`, `address`, `postalcode`, `locality`, `country`, `description`, `osm_id`, `twentyforseven`, `geometry`) VALUES
(1, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 1, 2, 'Fahrrad-Station Teststadt 1', 'fahrrad-station-teststadt', '51.5174770', '7.4605470', 'Königswall 15', '44137', 'Dortmund', 'de', NULL, NULL, 1, '\0\0\0\0\0\0\0R·³¯<@jý¡ם@'),
(2, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 1, 3, 'Fahrrad-Station Demostadt', 'fahrrad-station-demo', '51.4791580', '7.2229040', 'Kurt-Schumacher-Platz 1', '44787', 'Bochum', 'de', NULL, NULL, 1, '\0\0\0\0\0\0\0򎡌U½I@ 8򀤜@'),
(3, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 4, 'Cargo-Bike-Station', 'cargo-bike-station', '48.5938110', '8.8632880', 'Bahnhofstraße 12', '71083', 'Herrenberg', 'de', NULL, NULL, 0, '\0\0\0\0\0\0\0¦´ÿLH@ú~✰º!@');

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
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Daten für Tabelle `operator`
--

INSERT INTO `operator` (`id`, `created`, `modified`, `logo_id`, `tax_rate`, `name`, `description`, `address`, `postalcode`, `locality`, `country`, `slug`, `url`, `email`) VALUES
(1, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 1, '0.1900', 'Open Bike GmbH', NULL, 'Fahrradstraße 1', '12345', 'Fahrradstadt', 'de', 'open-bike-gmbh', 'https://openbikebox.de', 'test@open-bike.gmbh'),
(2, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 1, '0.1900', 'Open Cargo GmbH', NULL, 'Fahrradstraße 1', '12345', 'Fahrradstadt', 'de', 'open-cargo-gmbh', 'https://opencargobike.de', 'test@open-cargo.gmbh');

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
(1, '2021-06-01 06:57:39', '2021-06-01 06:57:39', NULL, '0.2000', '1.0000', '5.0000', '15.0000', '100.0000');

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
(1, '2021-06-01 06:57:39', '2021-06-01 06:57:39', NULL, 2, 36000, 68400),
(2, '2021-06-01 06:57:39', '2021-06-01 06:57:39', NULL, 3, 54000, 68400),
(3, '2021-06-01 06:57:39', '2021-06-01 06:57:39', NULL, 4, 54000, 68400),
(4, '2021-06-01 06:57:39', '2021-06-01 06:57:39', NULL, 5, 36000, 68400);

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
(1, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 1, 1, 1, 1, 1, NULL, '546a7201-c825-4ba9-b349-8971f90909bf', NULL, '01', '01', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 1, 1, 0, 0, NULL),
(2, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 1, 1, 1, 1, 1, NULL, '8c57731e-fe2a-40f0-bd77-4856b9cadcc2', NULL, '02', '02', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 3, 1, 2, 0, NULL),
(3, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 1, 1, 1, 1, 1, NULL, '4d04f8aa-a2b9-4687-9e1e-c0dd09996b21', NULL, '03', '03', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 1, 2, 0, 1, NULL),
(4, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 1, 1, 1, 1, 1, NULL, 'e50f420c-187e-4fc4-a6c8-d48e3336c16f', NULL, '04', '04', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 3, 2, 2, 1, NULL),
(5, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 1, 1, 1, 1, 1, NULL, 'ed6dc33e-abde-4874-8b82-216efcf91d8b', NULL, '05', '05', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 1, 3, 0, 2, NULL),
(6, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 1, 1, 1, 1, 1, NULL, 'c4b11c63-5bc1-4973-8191-2ac36da5a6fe', NULL, '06', '06', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 3, 3, 2, 2, NULL),
(7, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 1, 1, 1, 1, 1, NULL, 'd7966072-2981-45dd-96bc-51848b3b5744', NULL, '07', '07', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 1, 4, 0, 3, NULL),
(8, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 1, 1, 1, 1, 1, NULL, '255d1f5b-7e80-458d-9a1c-320d437dcfd2', NULL, '08', '08', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 3, 4, 2, 3, NULL),
(9, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 1, 1, 1, 1, 1, NULL, 'df7d0a1b-7369-4a64-8bef-d7d6dd618dae', NULL, '09', '09', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 1, 5, 0, 4, NULL),
(10, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 1, 1, 1, 1, 1, NULL, '2c0840ad-3bd1-494e-bef7-f69a3411cac7', NULL, '10', '10', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 3, 5, 2, 4, NULL),
(11, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, 'f843c3fc-f863-4b7a-b91c-7474e682f76b', NULL, '001', '001', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 1, 1, 0, 0, NULL),
(12, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '1493d6f6-b5ce-4666-a351-bc86629fccb5', NULL, '002', '002', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 2, 1, 1, 0, NULL),
(13, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, 'e83ac15f-ad58-46ee-8468-77aaa5d85b04', NULL, '003', '003', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 3, 1, 2, 0, NULL),
(14, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, 'dabdbff4-5a62-4e94-9703-e9d48028b54f', NULL, '004', '004', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 4, 1, 3, 0, NULL),
(15, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '639ab6db-98f2-4fb7-8fcc-517f17fb7751', NULL, '005', '005', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 5, 1, 4, 0, NULL),
(16, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, 'af7f192d-57b5-4f17-9b8f-9f48f06f1968', NULL, '006', '006', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 6, 1, 5, 0, NULL),
(17, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, 'b5d5881a-a315-4a33-9ffb-fedde13f1953', NULL, '007', '007', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 7, 1, 6, 0, NULL),
(18, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '1d5fbf35-bf7e-4085-adba-2119f4f143ed', NULL, '008', '008', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 8, 1, 7, 0, NULL),
(19, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '3e6e3fab-8e30-4d60-bb99-f363efb1cd89', NULL, '009', '009', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 9, 1, 8, 0, NULL),
(20, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '26a091bf-abc5-435c-97c7-469c979bed19', NULL, '010', '010', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 10, 1, 9, 0, NULL),
(21, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, 'c9668f6f-38b3-4c0b-8c72-2366ce18dc92', NULL, '011', '011', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 1, 3, 0, 2, NULL),
(22, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '4649cefd-9d0c-426b-9675-1f5d0b862f36', NULL, '012', '012', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 2, 3, 1, 2, NULL),
(23, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '11cd306a-4f25-4bd6-b7b3-1951ad77223b', NULL, '013', '013', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 3, 3, 2, 2, NULL),
(24, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '632f9ad1-0030-423f-b3d7-1cacd63433e6', NULL, '014', '014', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 4, 3, 3, 2, NULL),
(25, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '5eaaed50-5ab0-4fe0-bede-d40749646e85', NULL, '015', '015', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 5, 3, 4, 2, NULL),
(26, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '12baaf21-52a3-4218-b810-032d2d535d7a', NULL, '016', '016', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 6, 3, 5, 2, NULL),
(27, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '2be9a9f2-9f29-4227-8467-a14b0bba8ed4', NULL, '017', '017', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 7, 3, 6, 2, NULL),
(28, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '3a61b5a4-c5db-4ec2-8218-86521b6f0ee9', NULL, '018', '018', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 8, 3, 7, 2, NULL),
(29, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, 'ea650883-638a-48cc-92e2-c7fd32306d29', NULL, '019', '019', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 9, 3, 8, 2, NULL),
(30, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '890c016c-cbd8-4d43-bebc-6a3ce755420e', NULL, '020', '020', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 10, 3, 9, 2, NULL),
(31, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, 'bdf4c83a-f9cd-4a40-9f57-2b16ad0af25d', NULL, '021', '021', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 1, 4, 0, 3, NULL),
(32, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '06a20b1a-b7bd-43cc-9605-e4e3afc2ef13', NULL, '022', '022', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 2, 4, 1, 3, NULL),
(33, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '49612531-ca81-454f-b2f3-4b809b34e9f5', NULL, '023', '023', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 3, 4, 2, 3, NULL),
(34, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, 'd0e94c6b-5443-4453-a2a4-cf208304732c', NULL, '024', '024', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 4, 4, 3, 3, NULL),
(35, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '14f1b7bc-6598-4f2b-882d-2710be7c13d6', NULL, '025', '025', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 5, 4, 4, 3, NULL),
(36, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '5e8f2897-ed1b-44da-a2c7-560792519206', NULL, '026', '026', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 6, 4, 5, 3, NULL),
(37, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '7d6812f8-653b-4c01-8aca-cad215d69b0f', NULL, '027', '027', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 7, 4, 6, 3, NULL),
(38, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '768b4bbf-dfea-41f2-8a5e-5f04c3acb3a2', NULL, '028', '028', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 8, 4, 7, 3, NULL),
(39, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '6f39737c-4575-44b7-8a9e-a6422522acf2', NULL, '029', '029', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 9, 4, 8, 3, NULL),
(40, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, 'b6db034f-605d-41b2-9fac-9f7e462a6711', NULL, '030', '030', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 10, 4, 9, 3, NULL),
(41, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '2381f826-5804-4819-b8ba-6ac0af3c6f19', NULL, '031', '031', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 1, 6, 0, 5, NULL),
(42, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '4bc9579a-8a09-40c3-bd7c-410d82e05fa4', NULL, '032', '032', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 2, 6, 1, 5, NULL),
(43, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '71dc7638-f188-4ece-be66-eebc7e048eec', NULL, '033', '033', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 3, 6, 2, 5, NULL),
(44, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '2c1acb99-a830-4957-a52a-5634fb8f714f', NULL, '034', '034', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 4, 6, 3, 5, NULL),
(45, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, 'd16783b2-d683-43e3-bfc2-453818aba037', NULL, '035', '035', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 5, 6, 4, 5, NULL),
(46, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '16e83428-c249-4b9a-9857-878357f3a7f5', NULL, '036', '036', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 6, 6, 5, 5, NULL),
(47, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '8e39796e-dc61-4294-bc51-776b63b13e91', NULL, '037', '037', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 7, 6, 6, 5, NULL),
(48, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, 'ad3e63be-d16d-4cf8-a0bc-cb065481d742', NULL, '038', '038', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 8, 6, 7, 5, NULL),
(49, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '09ba4b20-dd62-483a-8080-9216bb74e1dd', NULL, '039', '039', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 9, 6, 8, 5, NULL),
(50, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '6a490188-cdf6-4283-91e3-bc33ac1f6d65', NULL, '040', '040', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 10, 6, 9, 5, NULL),
(51, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, 'c0b1c05e-f818-4447-a321-7ef31a6cc586', NULL, '041', '041', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 1, 7, 0, 6, NULL),
(52, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '2f33db8f-42a3-47eb-a30e-73ff7f8c4f42', NULL, '042', '042', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 2, 7, 1, 6, NULL),
(53, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '1683746c-d44e-4a69-b520-8b1e16a476c4', NULL, '043', '043', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 3, 7, 2, 6, NULL),
(54, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '26cf3535-ce3b-4e53-a6f1-83bb74e98acf', NULL, '044', '044', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 4, 7, 3, 6, NULL),
(55, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '68976d66-ea5f-4d64-91a6-967075405e20', NULL, '045', '045', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 5, 7, 4, 6, NULL),
(56, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '3a40e528-2584-46c1-996b-ab885a0da738', NULL, '046', '046', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 6, 7, 5, 6, NULL),
(57, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '84a6600e-04f3-4b16-8829-97fc5b379dcf', NULL, '047', '047', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 7, 7, 6, 6, NULL),
(58, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '890451fb-e13c-4bc7-a50d-b0243dd8b558', NULL, '048', '048', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 8, 7, 7, 6, NULL),
(59, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '4449bf27-8ea2-49bb-8cfd-8eea9b2ad44d', NULL, '049', '049', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 9, 7, 8, 6, NULL),
(60, '2021-06-01 06:57:39', '2021-06-01 06:57:39', 2, 1, 2, 2, 2, NULL, '3d1e5966-a6c3-4a6e-ad6c-01b2904ec3c8', NULL, '050', '050', 'free', NULL, '2021-06-01 06:57:39', NULL, NULL, 10, 7, 9, 6, NULL),
(61, '2021-06-01 06:57:40', '2021-06-01 06:57:40', 2, 1, 2, 2, 2, NULL, '1d1db21f-f77f-41e1-812a-bc14b6b9c9c0', NULL, '051', '051', 'free', NULL, '2021-06-01 06:57:40', NULL, NULL, 1, 9, 0, 8, NULL),
(62, '2021-06-01 06:57:40', '2021-06-01 06:57:40', 2, 1, 2, 2, 2, NULL, 'df953289-4aa4-4eb0-82d8-b00afd9f8161', NULL, '052', '052', 'free', NULL, '2021-06-01 06:57:40', NULL, NULL, 2, 9, 1, 8, NULL),
(63, '2021-06-01 06:57:40', '2021-06-01 06:57:40', 2, 1, 2, 2, 2, NULL, '330be743-1488-4db3-be96-f767a0f63160', NULL, '053', '053', 'free', NULL, '2021-06-01 06:57:40', NULL, NULL, 3, 9, 2, 8, NULL),
(64, '2021-06-01 06:57:40', '2021-06-01 06:57:40', 2, 1, 2, 2, 2, NULL, 'd975faf0-6364-4f17-a54f-a146b4237785', NULL, '054', '054', 'free', NULL, '2021-06-01 06:57:40', NULL, NULL, 4, 9, 3, 8, NULL),
(65, '2021-06-01 06:57:40', '2021-06-01 06:57:40', 2, 1, 2, 2, 2, NULL, '4917993b-a91d-4334-b2c7-910fc49a1935', NULL, '055', '055', 'free', NULL, '2021-06-01 06:57:40', NULL, NULL, 5, 9, 4, 8, NULL),
(66, '2021-06-01 06:57:40', '2021-06-01 06:57:40', 2, 1, 2, 2, 2, NULL, 'bfd2123d-c4c2-4aec-8be2-3e457d2fd88d', NULL, '056', '056', 'free', NULL, '2021-06-01 06:57:40', NULL, NULL, 6, 9, 5, 8, NULL),
(67, '2021-06-01 06:57:40', '2021-06-01 06:57:40', 2, 1, 2, 2, 2, NULL, '26fff667-213a-43dc-97fc-487b38e6761e', NULL, '057', '057', 'free', NULL, '2021-06-01 06:57:40', NULL, NULL, 7, 9, 6, 8, NULL),
(68, '2021-06-01 06:57:40', '2021-06-01 06:57:40', 2, 1, 2, 2, 2, NULL, '6a7fc553-643b-4056-8b0d-4d64fda23e43', NULL, '058', '058', 'free', NULL, '2021-06-01 06:57:40', NULL, NULL, 8, 9, 7, 8, NULL),
(69, '2021-06-01 06:57:40', '2021-06-01 06:57:40', 2, 1, 2, 2, 2, NULL, '8ba49a10-cd4a-4e7e-bea5-2dbeb4a4b7c9', NULL, '059', '059', 'free', NULL, '2021-06-01 06:57:40', NULL, NULL, 9, 9, 8, 8, NULL),
(70, '2021-06-01 06:57:40', '2021-06-01 06:57:40', 2, 1, 2, 2, 2, NULL, '1a0aaeec-8ef4-43a8-aff1-f1b4e9a715de', NULL, '060', '060', 'free', NULL, '2021-06-01 06:57:40', NULL, NULL, 10, 9, 9, 8, NULL),
(71, '2021-06-01 06:57:40', '2021-06-01 06:57:40', 3, 1, 3, NULL, NULL, NULL, 'd25ba151-886c-4542-803d-65211c030f11', NULL, 'cargobike-1', 'cargobike-1', 'free', NULL, '2021-06-01 06:57:40', NULL, NULL, NULL, NULL, NULL, NULL, 5);

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
(1, '2021-06-01 06:57:39', '2021-06-01 06:57:39', NULL, '001', '123456'),
(2, '2021-06-01 06:57:39', '2021-06-01 06:57:39', NULL, '002', '654321');

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
(71, 8),
(71, 7);

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
(1, '2021-06-01 06:57:39', '2021-06-01 06:57:39', NULL, 'Fahrrad-Station Teststadt', NULL, 'fahrrad-station-teststadt', 'teststadt-1', 'teststadt-1', 'active', 365, '2021-06-01 06:57:39', NULL, NULL),
(2, '2021-06-01 06:57:39', '2021-06-01 06:57:39', NULL, 'Fahrrad-Station Demostadt', NULL, 'fahrrad-station-demostadt', 'demostadt-1', 'demostadt-1', 'active', 365, '2021-06-01 06:57:39', NULL, NULL);

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
(1, '2021-06-01 06:57:39', '2021-06-01 06:57:39', NULL, 'test@binary-butterfly.de', '$2b$12$9n3po0x6JvnrlgY3EgHjkumNKW2U2UXb3mREq5.abQJylRNqEmCva', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'binary butterfly GmbH', 'Am Hertinger Tor', '59423', 'Unna', 'DE', 'de', NULL, NULL, '[\"admin\"]');

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
  ADD KEY `operator_id` (`operator_id`),
  ADD SPATIAL KEY `geometry_index` (`geometry`);

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
