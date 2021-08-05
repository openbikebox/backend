-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Erstellungszeit: 05. Aug 2021 um 16:46
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
  `user_identifier` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `auth_methods` int(11) DEFAULT NULL,
  `predefined_daterange` enum('day','week','month','year') COLLATE utf8_unicode_ci DEFAULT NULL
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
('aaf8cfeb6ba5');

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
(1, '2021-08-05 16:42:48', '2021-08-05 16:42:48', 'Logo', 'image/svg+xml'),
(2, '2021-08-05 16:42:48', '2021-08-05 16:42:48', NULL, 'image/jpeg'),
(3, '2021-08-05 16:42:48', '2021-08-05 16:42:48', NULL, 'image/jpeg'),
(4, '2021-08-05 16:42:48', '2021-08-05 16:42:48', NULL, 'image/jpeg'),
(5, '2021-08-05 16:42:49', '2021-08-05 16:42:49', NULL, 'image/jpeg'),
(6, '2021-08-05 16:42:49', '2021-08-05 16:42:49', NULL, 'image/jpeg'),
(7, '2021-08-05 16:42:49', '2021-08-05 16:42:49', NULL, 'image/jpeg'),
(8, '2021-08-05 16:42:49', '2021-08-05 16:42:49', NULL, 'image/jpeg');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `hardware`
--

CREATE TABLE `hardware` (
  `id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `future_booking` tinyint(1) DEFAULT NULL,
  `supported_auth_methods` int(11) DEFAULT NULL
) ;

--
-- Daten für Tabelle `hardware`
--

INSERT INTO `hardware` (`id`, `created`, `modified`, `name`, `future_booking`, `supported_auth_methods`) VALUES
(1, '2021-08-05 16:42:48', '2021-08-05 16:42:48', 'Einzel-Box', 0, 1),
(2, '2021-08-05 16:42:48', '2021-08-05 16:42:48', 'Sammel-Anlagen-Stellplatz', 0, 1),
(3, '2021-08-05 16:42:48', '2021-08-05 16:42:48', 'Cargo-Bike', 1, 2);

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
  `twentyfourseven` tinyint(1) DEFAULT NULL,
  `booking_base_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `terms_and_conditions` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bike_size_information` text COLLATE utf8_unicode_ci DEFAULT NULL
) ;

--
-- Daten für Tabelle `location`
--

INSERT INTO `location` (`id`, `created`, `modified`, `operator_id`, `photo_id`, `name`, `slug`, `lat`, `lon`, `address`, `postalcode`, `locality`, `country`, `description`, `osm_id`, `geometry`, `type`, `twentyfourseven`, `booking_base_url`, `terms_and_conditions`, `bike_size_information`) VALUES
(1, '2021-08-05 16:42:48', '2021-08-05 16:42:48', 1, 2, 'Fahrrad-Station Teststadt 1', 'fahrrad-station-teststadt', '51.5174770', '7.4605470', 'Königswall 15', '44137', 'Dortmund', 'de', 'This is a wonderful description for Fahrrad-Station Teststadt 1', NULL, '\0\0\0\0\0\0\0R·³¯<@jý¡ם@', 'bikebox', 1, 'https://openbikebox.de', NULL, NULL),
(2, '2021-08-05 16:42:48', '2021-08-05 16:42:48', 1, 3, 'Fahrrad-Station Demostadt', 'fahrrad-station-demo', '51.4791580', '7.2229040', 'Kurt-Schumacher-Platz 1', '44787', 'Bochum', 'de', 'This is a wonderful description for Fahrrad-Station Demostadt', NULL, '\0\0\0\0\0\0\0򎡌U½I@ 8򀤜@', 'bikebox', 1, 'https://openbikebox.de', NULL, NULL),
(3, '2021-08-05 16:42:48', '2021-08-05 16:42:48', 2, 4, 'Cargo-Bike-Station', 'cargo-bike-station', '48.5938110', '8.8632880', 'Bahnhofstraße 12', '71083', 'Herrenberg', 'de', 'This is a wonderful description for Cargo-Bike-Station', NULL, '\0\0\0\0\0\0\0¦´ÿLH@ú~✰º!@', 'cargobike', 0, 'https://opencargobike.de', NULL, NULL);

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
(1, '2021-08-05 16:42:48', '2021-08-05 16:42:48', 1, '0.1900', 'Open Bike GmbH', NULL, 'Fahrradstraße 1', '12345', 'Fahrradstadt', 'de', 'open-bike-gmbh', 'https://openbikebox.de', 'test@open-bike.gmbh', '0'),
(2, '2021-08-05 16:42:48', '2021-08-05 16:42:48', 1, '0.1900', 'Open Cargo GmbH', NULL, 'Fahrradstraße 1', '12345', 'Fahrradstadt', 'de', 'open-cargo-gmbh', 'https://opencargobike.de', 'test@open-cargo.gmbh', '1');

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
  `fee_year` decimal(7,4) DEFAULT NULL,
  `detailed_calculation` tinyint(1) DEFAULT NULL,
  `max_booking_time` int(11) DEFAULT NULL
) ;

--
-- Daten für Tabelle `pricegroup`
--

INSERT INTO `pricegroup` (`id`, `created`, `modified`, `operator_id`, `fee_hour`, `fee_day`, `fee_week`, `fee_month`, `fee_year`, `detailed_calculation`, `max_booking_time`) VALUES
(1, '2021-08-05 16:42:48', '2021-08-05 16:42:48', NULL, '0.2000', '1.0000', '5.0000', '15.0000', '100.0000', NULL, NULL);

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
(1, '2021-08-05 16:42:48', '2021-08-05 16:42:48', NULL, 2, 36000, 68400),
(2, '2021-08-05 16:42:48', '2021-08-05 16:42:48', NULL, 3, 54000, 68400),
(3, '2021-08-05 16:42:48', '2021-08-05 16:42:48', NULL, 4, 54000, 68400),
(4, '2021-08-05 16:42:48', '2021-08-05 16:42:48', NULL, 5, 36000, 68400);

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
(1, '2021-08-05 16:42:48', '2021-08-05 16:42:48', 1, 1, 1, 1, 1, NULL, 'ae51f0d9-a786-4eb3-9850-8f47dd852c3b', NULL, '01', '01', 'free', NULL, '2021-08-05 16:42:48', NULL, NULL, 1, 1, 0, 0, NULL),
(2, '2021-08-05 16:42:48', '2021-08-05 16:42:48', 1, 1, 1, 1, 1, NULL, '11f116cc-e1e1-4712-a5d6-163880894db6', NULL, '02', '02', 'free', NULL, '2021-08-05 16:42:48', NULL, NULL, 3, 1, 2, 0, NULL),
(3, '2021-08-05 16:42:48', '2021-08-05 16:42:48', 1, 1, 1, 1, 1, NULL, '9646596c-a88a-49c9-a7e2-8d9f2fafc7b2', NULL, '03', '03', 'free', NULL, '2021-08-05 16:42:48', NULL, NULL, 1, 2, 0, 1, NULL),
(4, '2021-08-05 16:42:48', '2021-08-05 16:42:48', 1, 1, 1, 1, 1, NULL, 'd0747121-9422-4e91-9e25-ac1d964622dd', NULL, '04', '04', 'free', NULL, '2021-08-05 16:42:48', NULL, NULL, 3, 2, 2, 1, NULL),
(5, '2021-08-05 16:42:48', '2021-08-05 16:42:48', 1, 1, 1, 1, 1, NULL, '75d7cddb-8dcb-4b20-a02a-c524f83a9051', NULL, '05', '05', 'free', NULL, '2021-08-05 16:42:48', NULL, NULL, 1, 3, 0, 2, NULL),
(6, '2021-08-05 16:42:48', '2021-08-05 16:42:48', 1, 1, 1, 1, 1, NULL, '556ceee1-68a6-445b-b7cf-95fbc3c5ee54', NULL, '06', '06', 'free', NULL, '2021-08-05 16:42:48', NULL, NULL, 3, 3, 2, 2, NULL),
(7, '2021-08-05 16:42:48', '2021-08-05 16:42:48', 1, 1, 1, 1, 1, NULL, '1353631b-5d35-4147-ae61-337acc7275b1', NULL, '07', '07', 'free', NULL, '2021-08-05 16:42:48', NULL, NULL, 1, 4, 0, 3, NULL),
(8, '2021-08-05 16:42:48', '2021-08-05 16:42:48', 1, 1, 1, 1, 1, NULL, '01fe9e9a-f42b-4692-92e7-693178264264', NULL, '08', '08', 'free', NULL, '2021-08-05 16:42:48', NULL, NULL, 3, 4, 2, 3, NULL),
(9, '2021-08-05 16:42:48', '2021-08-05 16:42:48', 1, 1, 1, 1, 1, NULL, '4bbb3773-cf8f-4abe-9826-f12f85d6d284', NULL, '09', '09', 'free', NULL, '2021-08-05 16:42:48', NULL, NULL, 1, 5, 0, 4, NULL),
(10, '2021-08-05 16:42:48', '2021-08-05 16:42:48', 1, 1, 1, 1, 1, NULL, '289fbd10-08ee-4616-8c57-ed3fccd6183c', NULL, '10', '10', 'free', NULL, '2021-08-05 16:42:48', NULL, NULL, 3, 5, 2, 4, NULL),
(11, '2021-08-05 16:42:48', '2021-08-05 16:42:48', 2, 1, 2, 2, 2, NULL, 'e5c80fee-ddb9-4ff5-8694-27e9f775b526', NULL, '001', '001', 'free', NULL, '2021-08-05 16:42:48', NULL, NULL, 1, 1, 0, 0, NULL),
(12, '2021-08-05 16:42:48', '2021-08-05 16:42:48', 2, 1, 2, 2, 2, NULL, '122c9c91-ba1c-4318-8f65-685eb275c12d', NULL, '002', '002', 'free', NULL, '2021-08-05 16:42:48', NULL, NULL, 2, 1, 1, 0, NULL),
(13, '2021-08-05 16:42:48', '2021-08-05 16:42:48', 2, 1, 2, 2, 2, NULL, '7b66a653-cad2-427b-b699-36113efc3fbe', NULL, '003', '003', 'free', NULL, '2021-08-05 16:42:48', NULL, NULL, 3, 1, 2, 0, NULL),
(14, '2021-08-05 16:42:48', '2021-08-05 16:42:48', 2, 1, 2, 2, 2, NULL, '4011af40-4f54-477e-89e7-aeef83017b84', NULL, '004', '004', 'free', NULL, '2021-08-05 16:42:48', NULL, NULL, 4, 1, 3, 0, NULL),
(15, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, 'd29dc636-a3f6-4c15-a702-c5577b2bcb7f', NULL, '005', '005', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 5, 1, 4, 0, NULL),
(16, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '3fa060bb-4e8c-45eb-990b-007645ad445f', NULL, '006', '006', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 6, 1, 5, 0, NULL),
(17, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, 'ae21d87c-2ca9-4b20-abb4-b4535b243b6f', NULL, '007', '007', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 7, 1, 6, 0, NULL),
(18, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '52fb9825-4aa7-4d5e-8f36-ea368e13c885', NULL, '008', '008', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 8, 1, 7, 0, NULL),
(19, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '098d141b-ba48-4475-b59f-e4afccf70c82', NULL, '009', '009', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 9, 1, 8, 0, NULL),
(20, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, 'c2242b8f-6dcc-4e30-801a-120877d6965c', NULL, '010', '010', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 10, 1, 9, 0, NULL),
(21, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '903efde6-ccc2-4fd2-9322-bd213dec3662', NULL, '011', '011', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 1, 3, 0, 2, NULL),
(22, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '85c39f40-4a92-459e-a864-525131f587f1', NULL, '012', '012', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 2, 3, 1, 2, NULL),
(23, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '3afd9367-8b65-4488-a2d2-ae856c775ee9', NULL, '013', '013', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 3, 3, 2, 2, NULL),
(24, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '4a9da41c-c2d8-4dac-9154-f89e063c2d84', NULL, '014', '014', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 4, 3, 3, 2, NULL),
(25, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '82d38448-8ba0-47e8-a5ac-9f4740951cad', NULL, '015', '015', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 5, 3, 4, 2, NULL),
(26, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '2282c0cd-8a29-4d4f-813c-6615d39cc4b3', NULL, '016', '016', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 6, 3, 5, 2, NULL),
(27, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, 'b4db7458-ae05-4c06-8605-20e1e7ce02c4', NULL, '017', '017', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 7, 3, 6, 2, NULL),
(28, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '14a99f3a-c821-4248-867c-458f53889c79', NULL, '018', '018', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 8, 3, 7, 2, NULL),
(29, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, 'ae74cc21-ec67-46d2-a7f7-8f536ed47b1a', NULL, '019', '019', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 9, 3, 8, 2, NULL),
(30, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '0a710916-03a6-46fc-a27e-ec7cbd1b364e', NULL, '020', '020', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 10, 3, 9, 2, NULL),
(31, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '563d2fd5-2193-4b94-a029-4a7e803f2dd6', NULL, '021', '021', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 1, 4, 0, 3, NULL),
(32, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '662fdc35-93ef-46cb-8305-def3f29f709b', NULL, '022', '022', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 2, 4, 1, 3, NULL),
(33, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '07edb48e-8b23-4433-b793-f774d088b7bb', NULL, '023', '023', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 3, 4, 2, 3, NULL),
(34, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '6bb74c31-c39e-429f-8bac-f2e85cedc313', NULL, '024', '024', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 4, 4, 3, 3, NULL),
(35, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, 'cc796991-649b-45ac-8fc5-70b0e71c4c1d', NULL, '025', '025', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 5, 4, 4, 3, NULL),
(36, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '73ab7cdc-279b-44dd-9066-9113750aaea0', NULL, '026', '026', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 6, 4, 5, 3, NULL),
(37, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '61b7b840-c3ae-498c-a6bc-379f87184452', NULL, '027', '027', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 7, 4, 6, 3, NULL),
(38, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '8cec87cd-b59a-47bc-bf59-01b1a88b5d74', NULL, '028', '028', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 8, 4, 7, 3, NULL),
(39, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '7a5183ae-ab6a-4b86-a1d3-730aeda9533b', NULL, '029', '029', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 9, 4, 8, 3, NULL),
(40, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '625e3804-6c2b-4896-965a-ef364eeb990e', NULL, '030', '030', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 10, 4, 9, 3, NULL),
(41, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '8be97994-c999-4ca5-8baf-890eabfd1c5c', NULL, '031', '031', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 1, 6, 0, 5, NULL),
(42, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, 'e25d7372-0a69-4804-b7a6-c451210c9019', NULL, '032', '032', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 2, 6, 1, 5, NULL),
(43, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, 'ad48135f-8abc-4b46-b20c-4fb6ac0932f6', NULL, '033', '033', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 3, 6, 2, 5, NULL),
(44, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '0b804521-b400-4444-b37e-ef47242cbb0c', NULL, '034', '034', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 4, 6, 3, 5, NULL),
(45, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '4cf05b9f-99c2-45da-ba98-767adbe81792', NULL, '035', '035', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 5, 6, 4, 5, NULL),
(46, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '59a4e355-96ad-49c4-b398-4adfb5b503c7', NULL, '036', '036', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 6, 6, 5, 5, NULL),
(47, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, 'c8517b9f-92ce-44ab-adc0-462179264d0d', NULL, '037', '037', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 7, 6, 6, 5, NULL),
(48, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '05f4d0a6-8a71-4747-a572-ffc1b7c9cd01', NULL, '038', '038', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 8, 6, 7, 5, NULL),
(49, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '9d8f5692-64b8-4980-a10c-145f9a22a2a6', NULL, '039', '039', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 9, 6, 8, 5, NULL),
(50, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, 'ee79060f-959c-43c6-9db5-804e3f9d2989', NULL, '040', '040', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 10, 6, 9, 5, NULL),
(51, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '7962d688-8a07-46ba-9a37-57ce8e49beef', NULL, '041', '041', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 1, 7, 0, 6, NULL),
(52, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, 'd22eb1f1-a5f9-47d0-b8db-ec9bdcf181d4', NULL, '042', '042', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 2, 7, 1, 6, NULL),
(53, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, 'fc5d3ba0-121b-45c0-b933-52953ccfb509', NULL, '043', '043', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 3, 7, 2, 6, NULL),
(54, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '851759ba-57fc-4b4c-af8a-907f55d76145', NULL, '044', '044', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 4, 7, 3, 6, NULL),
(55, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, 'ed44d50e-080f-43b8-bc07-99bcc6d3768e', NULL, '045', '045', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 5, 7, 4, 6, NULL),
(56, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, 'b10ec87f-e4a8-4536-9d63-fad9cfc47147', NULL, '046', '046', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 6, 7, 5, 6, NULL),
(57, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '66392616-ee88-4543-8b27-6927ce0f49dc', NULL, '047', '047', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 7, 7, 6, 6, NULL),
(58, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '648791de-3f23-4cdd-8afa-b15115478f26', NULL, '048', '048', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 8, 7, 7, 6, NULL),
(59, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, 'a12a2fe8-bf56-46d1-8569-878dd1f20d9f', NULL, '049', '049', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 9, 7, 8, 6, NULL),
(60, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '985246fe-4a00-434e-9616-4f9f64e23cf3', NULL, '050', '050', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 10, 7, 9, 6, NULL),
(61, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '86426637-e317-44a7-b484-8b2a9d392362', NULL, '051', '051', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 1, 9, 0, 8, NULL),
(62, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, 'deb34004-21d3-4afb-a3f9-53bcb77d1b6c', NULL, '052', '052', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 2, 9, 1, 8, NULL),
(63, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '40f85d61-33ba-47af-8b7e-1dadff16d739', NULL, '053', '053', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 3, 9, 2, 8, NULL),
(64, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, 'de35139e-ffe7-407d-8ceb-a181aabc7b49', NULL, '054', '054', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 4, 9, 3, 8, NULL),
(65, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '58186137-3a82-4f82-86ea-e9334dce45f8', NULL, '055', '055', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 5, 9, 4, 8, NULL),
(66, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '547b11f8-b281-45f7-a35e-63b15bc93b7c', NULL, '056', '056', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 6, 9, 5, 8, NULL),
(67, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '7f81ea11-c41c-49bf-80f8-88d0fc1d8195', NULL, '057', '057', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 7, 9, 6, 8, NULL),
(68, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, '50f952eb-e7a3-450d-a8e4-2b05679107b8', NULL, '058', '058', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 8, 9, 7, 8, NULL),
(69, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, 'c7baff06-5a0b-448b-888d-a8eed53b330b', NULL, '059', '059', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 9, 9, 8, 8, NULL),
(70, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 2, 1, 2, 2, 2, NULL, 'b0023797-03b2-42d1-b327-300e65c32758', NULL, '060', '060', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, 10, 9, 9, 8, NULL),
(71, '2021-08-05 16:42:49', '2021-08-05 16:42:49', 3, 1, 3, NULL, NULL, NULL, '072d0605-dad0-43da-a696-c3bf11a5eb5b', 'this is a wonderful cargobike', 'cargobike-1', 'cargobike-1', 'free', NULL, '2021-08-05 16:42:49', NULL, NULL, NULL, NULL, NULL, NULL, 5);

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
(1, '2021-08-05 16:42:48', '2021-08-05 16:42:48', NULL, '001', '123456'),
(2, '2021-08-05 16:42:48', '2021-08-05 16:42:48', NULL, '002', '654321');

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
(1, '2021-08-05 16:42:48', '2021-08-05 16:42:48', NULL, 'Fahrrad-Station Teststadt', NULL, 'fahrrad-station-teststadt', 'teststadt-1', 'teststadt-1', 'active', 365, '2021-08-05 16:42:48', NULL, NULL),
(2, '2021-08-05 16:42:48', '2021-08-05 16:42:48', NULL, 'Fahrrad-Station Demostadt', NULL, 'fahrrad-station-demostadt', 'demostadt-1', 'demostadt-1', 'active', 365, '2021-08-05 16:42:48', NULL, NULL);

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
  `company` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postalcode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `locality` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `language` enum('de','en') COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `capabilities` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `role` enum('admin','operator') COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Daten für Tabelle `user`
--

INSERT INTO `user` (`id`, `created`, `modified`, `operator_id`, `email`, `password`, `login_datetime`, `last_login_datetime`, `login_ip`, `last_login_ip`, `failed_login_count`, `last_failed_login_count`, `company`, `address`, `postalcode`, `locality`, `country`, `language`, `phone`, `mobile`, `capabilities`, `role`, `first_name`, `last_name`) VALUES
(1, '2021-08-05 16:42:48', '2021-08-05 16:42:48', NULL, 'test@binary-butterfly.de', '$2b$12$jeO9FxsvjujeiIVJez6pwuTe9AO9PO8VUOWpw2Yu/D8lUtRJHTTcK', NULL, NULL, NULL, NULL, NULL, NULL, 'binary butterfly GmbH', 'Am Hertinger Tor', '59423', 'Unna', 'DE', 'de', NULL, NULL, '[\"admin\"]', NULL, 'Test', 'User');

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

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
