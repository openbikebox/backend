-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Erstellungszeit: 10. Jun 2021 um 09:14
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
('2671af663659');

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
(1, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 'Logo', 'image/svg+xml'),
(2, '2021-06-10 09:14:08', '2021-06-10 09:14:08', NULL, 'image/jpeg'),
(3, '2021-06-10 09:14:08', '2021-06-10 09:14:08', NULL, 'image/jpeg'),
(4, '2021-06-10 09:14:08', '2021-06-10 09:14:08', NULL, 'image/jpeg'),
(5, '2021-06-10 09:14:09', '2021-06-10 09:14:09', NULL, 'image/jpeg'),
(6, '2021-06-10 09:14:09', '2021-06-10 09:14:09', NULL, 'image/jpeg'),
(7, '2021-06-10 09:14:09', '2021-06-10 09:14:09', NULL, 'image/jpeg'),
(8, '2021-06-10 09:14:09', '2021-06-10 09:14:09', NULL, 'image/jpeg');

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
(1, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 'Einzel-Box', 0, NULL),
(2, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 'Sammel-Anlagen-Stellplatz', 0, NULL),
(3, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 'Cargo-Bike', 1, NULL);

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
  `booking_base_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ;

--
-- Daten für Tabelle `location`
--

INSERT INTO `location` (`id`, `created`, `modified`, `operator_id`, `photo_id`, `name`, `slug`, `lat`, `lon`, `address`, `postalcode`, `locality`, `country`, `description`, `osm_id`, `geometry`, `type`, `twentyfourseven`, `booking_base_url`) VALUES
(1, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 1, 2, 'Fahrrad-Station Teststadt 1', 'fahrrad-station-teststadt', '51.5174770', '7.4605470', 'Königswall 15', '44137', 'Dortmund', 'de', 'This is a wonderful description for Fahrrad-Station Teststadt 1', NULL, '\0\0\0\0\0\0\0R·³¯<@jý¡ם@', 'cargobike', 1, 'https://openbikebox.de'),
(2, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 1, 3, 'Fahrrad-Station Demostadt', 'fahrrad-station-demo', '51.4791580', '7.2229040', 'Kurt-Schumacher-Platz 1', '44787', 'Bochum', 'de', 'This is a wonderful description for Cargo-Bike-Station', NULL, '\0\0\0\0\0\0\0򎡌U½I@ 8򀤜@', NULL, 1, 'https://openbikebox.de'),
(3, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 4, 'Cargo-Bike-Station', 'cargo-bike-station', '48.5938110', '8.8632880', 'Bahnhofstraße 12', '71083', 'Herrenberg', 'de', NULL, NULL, '\0\0\0\0\0\0\0¦´ÿLH@ú~✰º!@', NULL, 0, 'https://opencargobike.de');

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
(1, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 1, '0.1900', 'Open Bike GmbH', NULL, 'Fahrradstraße 1', '12345', 'Fahrradstadt', 'de', 'open-bike-gmbh', 'https://openbikebox.de', 'test@open-bike.gmbh', '0'),
(2, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 1, '0.1900', 'Open Cargo GmbH', NULL, 'Fahrradstraße 1', '12345', 'Fahrradstadt', 'de', 'open-cargo-gmbh', 'https://opencargobike.de', 'test@open-cargo.gmbh', '1');

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
(1, '2021-06-10 09:14:08', '2021-06-10 09:14:08', NULL, '0.2000', '1.0000', '5.0000', '15.0000', '100.0000', NULL, NULL);

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
(1, '2021-06-10 09:14:08', '2021-06-10 09:14:08', NULL, 2, 36000, 68400),
(2, '2021-06-10 09:14:08', '2021-06-10 09:14:08', NULL, 3, 54000, 68400),
(3, '2021-06-10 09:14:08', '2021-06-10 09:14:08', NULL, 4, 54000, 68400),
(4, '2021-06-10 09:14:08', '2021-06-10 09:14:08', NULL, 5, 36000, 68400);

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
(1, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 1, 1, 1, 1, 1, NULL, '7b892b57-5083-4dd8-a409-c4730eafd293', NULL, '01', '01', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 1, 1, 0, 0, NULL),
(2, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 1, 1, 1, 1, 1, NULL, 'a8833a9e-ee0f-4e63-8d51-e574992a9a6b', NULL, '02', '02', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 3, 1, 2, 0, NULL),
(3, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 1, 1, 1, 1, 1, NULL, 'fb03f05b-961d-4ab7-83b7-19ca6c8a43dd', NULL, '03', '03', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 1, 2, 0, 1, NULL),
(4, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 1, 1, 1, 1, 1, NULL, '0708d446-53bc-4438-a38b-1cf5b3b4f23f', NULL, '04', '04', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 3, 2, 2, 1, NULL),
(5, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 1, 1, 1, 1, 1, NULL, 'b6f23b68-593c-442a-9793-656c6707dfa0', NULL, '05', '05', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 1, 3, 0, 2, NULL),
(6, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 1, 1, 1, 1, 1, NULL, '3e3bc257-7dc1-4d83-85cc-8522ce0639de', NULL, '06', '06', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 3, 3, 2, 2, NULL),
(7, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 1, 1, 1, 1, 1, NULL, 'c65abaac-c799-40e8-b3e5-4faf14094cba', NULL, '07', '07', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 1, 4, 0, 3, NULL),
(8, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 1, 1, 1, 1, 1, NULL, '5a862118-0c9a-49f2-9cf8-efd28be0d6e4', NULL, '08', '08', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 3, 4, 2, 3, NULL),
(9, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 1, 1, 1, 1, 1, NULL, '353ab819-d8f4-47b2-831b-71dd8006ea3c', NULL, '09', '09', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 1, 5, 0, 4, NULL),
(10, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 1, 1, 1, 1, 1, NULL, '3db08a02-621e-4efa-aaf3-386043b3fb79', NULL, '10', '10', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 3, 5, 2, 4, NULL),
(11, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '9cf29029-0658-4386-9338-30eb6deca2b7', NULL, '001', '001', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 1, 1, 0, 0, NULL),
(12, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '5fd3ecf6-0250-4a57-9cc1-f19dceb2c674', NULL, '002', '002', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 2, 1, 1, 0, NULL),
(13, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '956b837c-35c3-4707-aad2-35a4cba19f24', NULL, '003', '003', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 3, 1, 2, 0, NULL),
(14, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, 'ce56eeb7-750c-4e90-bd61-b26d7c624baa', NULL, '004', '004', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 4, 1, 3, 0, NULL),
(15, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '74f8ebaa-b051-4d76-9b48-870c42ce07b1', NULL, '005', '005', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 5, 1, 4, 0, NULL),
(16, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '61d6e14c-778c-46c4-9f39-712da7d869fd', NULL, '006', '006', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 6, 1, 5, 0, NULL),
(17, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '96e2e388-ae01-4f7f-bc93-80674676107c', NULL, '007', '007', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 7, 1, 6, 0, NULL),
(18, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '9738dbf2-ec7a-4276-8981-66d766a320e2', NULL, '008', '008', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 8, 1, 7, 0, NULL),
(19, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, 'd6d0cbb0-fbd2-47e5-990e-eab719b5e60f', NULL, '009', '009', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 9, 1, 8, 0, NULL),
(20, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '9d92979d-7187-475d-be4c-db1288ce81c1', NULL, '010', '010', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 10, 1, 9, 0, NULL),
(21, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '5b52ccab-18e8-4dca-8847-2c68505ef08d', NULL, '011', '011', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 1, 3, 0, 2, NULL),
(22, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, 'f764dce2-384d-4c79-b04c-e6f069524723', NULL, '012', '012', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 2, 3, 1, 2, NULL),
(23, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '99737365-5845-468e-bc2c-dd35da004e0b', NULL, '013', '013', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 3, 3, 2, 2, NULL),
(24, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '3ed145f1-bc59-4a4a-bafe-91e5de0dd69c', NULL, '014', '014', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 4, 3, 3, 2, NULL),
(25, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '12694d38-c645-4a0d-9607-a7c213065238', NULL, '015', '015', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 5, 3, 4, 2, NULL),
(26, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, 'b89abc2b-6014-4205-af19-94d3c63b8110', NULL, '016', '016', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 6, 3, 5, 2, NULL),
(27, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '1a2dc892-bfca-4766-82be-a29dcb226ca0', NULL, '017', '017', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 7, 3, 6, 2, NULL),
(28, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '4c44319f-a0b5-4752-a148-c5664f616237', NULL, '018', '018', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 8, 3, 7, 2, NULL),
(29, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '61d11596-5b4c-4dda-98ae-4023c490d9b8', NULL, '019', '019', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 9, 3, 8, 2, NULL),
(30, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '3cb57fd2-a340-4446-abaa-35585bf6d45f', NULL, '020', '020', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 10, 3, 9, 2, NULL),
(31, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '129e213a-26ec-4d37-a9bf-7c9965eb1e2a', NULL, '021', '021', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 1, 4, 0, 3, NULL),
(32, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '81775b04-c3f2-4c0a-8e33-01f70e40fa88', NULL, '022', '022', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 2, 4, 1, 3, NULL),
(33, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '0f423916-5657-492f-acf9-a1b91a6ea609', NULL, '023', '023', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 3, 4, 2, 3, NULL),
(34, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, 'a3978ddb-c07f-414e-9cdb-42ff77c87283', NULL, '024', '024', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 4, 4, 3, 3, NULL),
(35, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, 'f948e984-8258-4242-a9e0-520b600958a4', NULL, '025', '025', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 5, 4, 4, 3, NULL),
(36, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '5c80f191-1d5c-4bca-90f0-21f924e72ef2', NULL, '026', '026', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 6, 4, 5, 3, NULL),
(37, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '12728440-5a01-4eab-9c99-5104427293df', NULL, '027', '027', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 7, 4, 6, 3, NULL),
(38, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '2ce5f39a-4b3f-420a-ae0d-e676935005d1', NULL, '028', '028', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 8, 4, 7, 3, NULL),
(39, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '651a3e43-0099-4f99-986f-5179b7b939ae', NULL, '029', '029', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 9, 4, 8, 3, NULL),
(40, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '3749fb4b-95d6-4a16-a4a9-05e6bb999b1a', NULL, '030', '030', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 10, 4, 9, 3, NULL),
(41, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, 'a828de05-7223-4105-9416-eb274728bc8c', NULL, '031', '031', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 1, 6, 0, 5, NULL),
(42, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '9661bcd7-bc79-47c5-ba2a-cffc0a868419', NULL, '032', '032', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 2, 6, 1, 5, NULL),
(43, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '5674f466-3ade-405a-beca-80ebccbc4f55', NULL, '033', '033', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 3, 6, 2, 5, NULL),
(44, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '57f226dd-446e-42a9-a628-e7e9d4f52f8c', NULL, '034', '034', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 4, 6, 3, 5, NULL),
(45, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, 'e2723a97-42e2-4e6b-ae47-18406181a96c', NULL, '035', '035', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 5, 6, 4, 5, NULL),
(46, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '443498ed-93a5-4c36-809c-2cc983311c72', NULL, '036', '036', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 6, 6, 5, 5, NULL),
(47, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, 'b04bc863-4d23-4fd2-95f4-e5d65c718b7a', NULL, '037', '037', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 7, 6, 6, 5, NULL),
(48, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '49216b95-7ff9-4fe6-b513-bbe1f5f4f86f', NULL, '038', '038', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 8, 6, 7, 5, NULL),
(49, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '7ec833bd-a053-4571-af5c-ddc38453b830', NULL, '039', '039', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 9, 6, 8, 5, NULL),
(50, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, 'cc595be0-456c-49ee-9085-a27797a7e9c4', NULL, '040', '040', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 10, 6, 9, 5, NULL),
(51, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, 'd8921dc4-2ea7-4127-9b46-58ab756667d7', NULL, '041', '041', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 1, 7, 0, 6, NULL),
(52, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, 'e15fbef1-3e11-4bc6-a9f2-eb03b1690ab4', NULL, '042', '042', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 2, 7, 1, 6, NULL),
(53, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '67306520-fef7-463c-9699-06093800d86b', NULL, '043', '043', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 3, 7, 2, 6, NULL),
(54, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, 'c3ba44ee-816f-4527-956a-07c6fb7b4671', NULL, '044', '044', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 4, 7, 3, 6, NULL),
(55, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '2868b2a8-580b-4140-9a91-2dc09aa5f51a', NULL, '045', '045', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 5, 7, 4, 6, NULL),
(56, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, 'dca56be0-9354-4d77-a318-dbbe245741a9', NULL, '046', '046', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 6, 7, 5, 6, NULL),
(57, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, 'd2d3af9a-3cb2-457f-aa17-407b3d222da6', NULL, '047', '047', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 7, 7, 6, 6, NULL),
(58, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '6597b4b3-f47c-47a1-ba15-2d8ab721c641', NULL, '048', '048', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 8, 7, 7, 6, NULL),
(59, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, 'defc6d79-8f5e-47f1-aef7-e0dd8944a2e8', NULL, '049', '049', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 9, 7, 8, 6, NULL),
(60, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, 'd4f24cae-6556-4005-9e37-abc2508ec2bd', NULL, '050', '050', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 10, 7, 9, 6, NULL),
(61, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, 'de88add3-c5e6-480b-a8c9-f96e8c65df16', NULL, '051', '051', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 1, 9, 0, 8, NULL),
(62, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '4b4b49f9-70f0-4827-bf5d-582577d016ca', NULL, '052', '052', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 2, 9, 1, 8, NULL),
(63, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '9fa415af-7313-4363-949b-2e77f201f400', NULL, '053', '053', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 3, 9, 2, 8, NULL),
(64, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '75ef4e3a-f180-4447-b981-9abf7f98844c', NULL, '054', '054', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 4, 9, 3, 8, NULL),
(65, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '954e18a7-18bc-4ddf-9d56-b9a5e5c13338', NULL, '055', '055', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 5, 9, 4, 8, NULL),
(66, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, '9f1d42c8-c0e7-459a-ba85-6a5517e6f2a4', NULL, '056', '056', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 6, 9, 5, 8, NULL),
(67, '2021-06-10 09:14:08', '2021-06-10 09:14:08', 2, 1, 2, 2, 2, NULL, 'd9a3bb70-7c99-41f8-8949-3a0df0343c10', NULL, '057', '057', 'free', NULL, '2021-06-10 09:14:08', NULL, NULL, 7, 9, 6, 8, NULL),
(68, '2021-06-10 09:14:09', '2021-06-10 09:14:09', 2, 1, 2, 2, 2, NULL, 'a7fc0c77-85bb-428d-86d2-190e29e496f0', NULL, '058', '058', 'free', NULL, '2021-06-10 09:14:09', NULL, NULL, 8, 9, 7, 8, NULL),
(69, '2021-06-10 09:14:09', '2021-06-10 09:14:09', 2, 1, 2, 2, 2, NULL, '612d8ceb-58a1-4070-94bb-8bf55f257d15', NULL, '059', '059', 'free', NULL, '2021-06-10 09:14:09', NULL, NULL, 9, 9, 8, 8, NULL),
(70, '2021-06-10 09:14:09', '2021-06-10 09:14:09', 2, 1, 2, 2, 2, NULL, '6bd0357d-2947-4955-8498-f7be6074a7d6', NULL, '060', '060', 'free', NULL, '2021-06-10 09:14:09', NULL, NULL, 10, 9, 9, 8, NULL),
(71, '2021-06-10 09:14:09', '2021-06-10 09:14:09', 3, 1, 3, NULL, NULL, NULL, '84a9eeba-9f1a-4c5f-8272-097c65a6530e', 'this is a wonderful cargobike', 'cargobike-1', 'cargobike-1', 'free', NULL, '2021-06-10 09:14:09', NULL, NULL, NULL, NULL, NULL, NULL, 5);

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
(1, '2021-06-10 09:14:08', '2021-06-10 09:14:08', NULL, '001', '123456'),
(2, '2021-06-10 09:14:08', '2021-06-10 09:14:08', NULL, '002', '654321');

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
(71, 8),
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
(1, '2021-06-10 09:14:08', '2021-06-10 09:14:08', NULL, 'Fahrrad-Station Teststadt', NULL, 'fahrrad-station-teststadt', 'teststadt-1', 'teststadt-1', 'active', 365, '2021-06-10 09:14:08', NULL, NULL),
(2, '2021-06-10 09:14:08', '2021-06-10 09:14:08', NULL, 'Fahrrad-Station Demostadt', NULL, 'fahrrad-station-demostadt', 'demostadt-1', 'demostadt-1', 'active', 365, '2021-06-10 09:14:08', NULL, NULL);

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
(1, '2021-06-10 09:14:08', '2021-06-10 09:14:08', NULL, 'test@binary-butterfly.de', '$2b$12$5ke3Bv7i0pDYC6QZe5hqe.FZ9GqhmYQwWEanf/sQu118xNPr7n/py', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'binary butterfly GmbH', 'Am Hertinger Tor', '59423', 'Unna', 'DE', 'de', NULL, NULL, '[\"admin\"]');

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
