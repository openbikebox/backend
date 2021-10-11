-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Erstellungszeit: 11. Okt 2021 um 13:05
-- Server-Version: 10.3.11-MariaDB-1:10.3.11+maria~bionic
-- PHP-Version: 7.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

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
  `predefined_daterange` enum('day','week','month','quarter','year') CHARACTER SET utf8 DEFAULT NULL
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
('2449b459e676');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(1, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 'Logo', 'image/svg+xml'),
(2, '2021-10-11 13:04:58', '2021-10-11 13:04:58', NULL, 'image/jpeg'),
(3, '2021-10-11 13:04:58', '2021-10-11 13:04:58', NULL, 'image/jpeg'),
(4, '2021-10-11 13:04:58', '2021-10-11 13:04:58', NULL, 'image/jpeg'),
(5, '2021-10-11 13:04:59', '2021-10-11 13:04:59', NULL, 'image/jpeg'),
(6, '2021-10-11 13:04:59', '2021-10-11 13:04:59', NULL, 'image/jpeg'),
(7, '2021-10-11 13:04:59', '2021-10-11 13:04:59', NULL, 'image/jpeg'),
(8, '2021-10-11 13:04:59', '2021-10-11 13:04:59', NULL, 'image/jpeg');

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
  `supported_auth_methods` int(11) DEFAULT NULL,
  `lot_name` varchar(192) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Daten für Tabelle `hardware`
--

INSERT INTO `hardware` (`id`, `created`, `modified`, `name`, `future_booking`, `supported_auth_methods`, `lot_name`) VALUES
(1, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 'Einzel-Box', 0, 1, NULL),
(2, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 'Sammel-Anlagen-Stellplatz', 0, 1, NULL),
(3, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 'Cargo-Bike', 1, 2, NULL);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(1, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 1, '0.1900', 'Open Bike GmbH', NULL, 'Fahrradstraße 1', '12345', 'Fahrradstadt', 'de', 'open-bike-gmbh', 'https://openbikebox.de', 'test@open-bike.gmbh', '0'),
(2, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 1, '0.1900', 'Open Cargo GmbH', NULL, 'Fahrradstraße 1', '12345', 'Fahrradstadt', 'de', 'open-cargo-gmbh', 'https://opencargobike.de', 'test@open-cargo.gmbh', '1');

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
  `max_booking_time` int(11) DEFAULT NULL,
  `fee_quarter` decimal(7,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Daten für Tabelle `pricegroup`
--

INSERT INTO `pricegroup` (`id`, `created`, `modified`, `operator_id`, `fee_hour`, `fee_day`, `fee_week`, `fee_month`, `fee_year`, `detailed_calculation`, `max_booking_time`, `fee_quarter`) VALUES
(1, '2021-10-11 13:04:58', '2021-10-11 13:04:58', NULL, '0.2000', '1.0000', '5.0000', '15.0000', '100.0000', NULL, NULL, '0.0000');

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
(1, '2021-10-11 13:04:58', '2021-10-11 13:04:58', NULL, 2, 36000, 68400),
(2, '2021-10-11 13:04:58', '2021-10-11 13:04:58', NULL, 3, 54000, 68400),
(3, '2021-10-11 13:04:58', '2021-10-11 13:04:58', NULL, 4, 54000, 68400),
(4, '2021-10-11 13:04:58', '2021-10-11 13:04:58', NULL, 5, 36000, 68400);

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
(1, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 1, 1, 1, 1, 1, NULL, '870b4d8a-6653-4307-9849-ab9a24a3218e', NULL, '01', '01', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 1, 1, 0, 0, NULL),
(2, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 1, 1, 1, 1, 1, NULL, 'e999ae55-b837-4efe-a20b-29d1498deb69', NULL, '02', '02', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 3, 1, 2, 0, NULL),
(3, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 1, 1, 1, 1, 1, NULL, 'a58c43c0-36a8-4c94-b204-226dacf8978a', NULL, '03', '03', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 1, 2, 0, 1, NULL),
(4, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 1, 1, 1, 1, 1, NULL, 'a39f95ed-6efd-4a79-aedd-4360e0249114', NULL, '04', '04', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 3, 2, 2, 1, NULL),
(5, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 1, 1, 1, 1, 1, NULL, '83621e83-5b7b-434b-8140-fb7f5b1777f7', NULL, '05', '05', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 1, 3, 0, 2, NULL),
(6, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 1, 1, 1, 1, 1, NULL, '488f2164-8c20-42f6-939d-090a2d412f35', NULL, '06', '06', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 3, 3, 2, 2, NULL),
(7, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 1, 1, 1, 1, 1, NULL, '70155683-71ca-40a2-a318-34710d9a3f63', NULL, '07', '07', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 1, 4, 0, 3, NULL),
(8, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 1, 1, 1, 1, 1, NULL, '59031cee-57fd-438d-a1d1-369a2fb110d2', NULL, '08', '08', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 3, 4, 2, 3, NULL),
(9, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 1, 1, 1, 1, 1, NULL, '4250752a-8dc4-4b3c-9c04-17be60441fef', NULL, '09', '09', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 1, 5, 0, 4, NULL),
(10, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 1, 1, 1, 1, 1, NULL, '95745e59-9a2b-4536-ad46-db65e1c82748', NULL, '10', '10', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 3, 5, 2, 4, NULL),
(11, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, 'ad30c7cc-9466-4241-8388-83851c547793', NULL, '001', '001', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 1, 1, 0, 0, NULL),
(12, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '456fe46d-a45c-4e86-ac77-c35a8561c019', NULL, '002', '002', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 2, 1, 1, 0, NULL),
(13, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '78294a4d-62eb-4529-9dbe-f89d9d3d9705', NULL, '003', '003', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 3, 1, 2, 0, NULL),
(14, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, 'f06a58bc-aa8c-4688-ac20-fc792b39cfff', NULL, '004', '004', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 4, 1, 3, 0, NULL),
(15, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '08b326f4-5e54-40cc-8267-bbd7f061cd3d', NULL, '005', '005', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 5, 1, 4, 0, NULL),
(16, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '95d08f16-68fc-4d14-80a8-0819f03c1b48', NULL, '006', '006', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 6, 1, 5, 0, NULL),
(17, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '7c7a76ed-24ee-459e-b687-a85c79654ac6', NULL, '007', '007', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 7, 1, 6, 0, NULL),
(18, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '6435f20e-4865-473d-b62c-673492106a71', NULL, '008', '008', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 8, 1, 7, 0, NULL),
(19, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '84f4cb74-5a89-413e-976a-73b0c39c3d7f', NULL, '009', '009', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 9, 1, 8, 0, NULL),
(20, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, 'a589d1ea-802d-4f0a-a8a1-f342837bc37d', NULL, '010', '010', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 10, 1, 9, 0, NULL),
(21, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, 'b080c101-24d8-4927-a7b9-0b6c9134632a', NULL, '011', '011', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 1, 3, 0, 2, NULL),
(22, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '53f556f2-fda2-4e2a-ac54-5e3ed4789768', NULL, '012', '012', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 2, 3, 1, 2, NULL),
(23, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '30595286-1cce-46f7-853f-9b7e76683a2f', NULL, '013', '013', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 3, 3, 2, 2, NULL),
(24, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '86fd2acc-13c8-4ec0-8fa9-6aeafaba192e', NULL, '014', '014', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 4, 3, 3, 2, NULL),
(25, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '8590b695-4be1-4de1-811f-35198fe298c8', NULL, '015', '015', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 5, 3, 4, 2, NULL),
(26, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, 'bec859c9-b043-455e-a1e0-3c1605297a6b', NULL, '016', '016', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 6, 3, 5, 2, NULL),
(27, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, 'b2edefb4-64a2-4dd1-b676-801fc3525376', NULL, '017', '017', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 7, 3, 6, 2, NULL),
(28, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, 'b8c791fc-9199-4f8f-9204-81b7230d7808', NULL, '018', '018', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 8, 3, 7, 2, NULL),
(29, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, 'bb8d523c-b13d-4f6c-b1e5-0a4e1dc4e47c', NULL, '019', '019', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 9, 3, 8, 2, NULL),
(30, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '33d51673-23e5-47c0-8615-25fc7ea36462', NULL, '020', '020', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 10, 3, 9, 2, NULL),
(31, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '67958485-bfac-4ec5-ad05-9c93a7ae68a8', NULL, '021', '021', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 1, 4, 0, 3, NULL),
(32, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '95186687-6482-4da1-b814-d8ca006bce86', NULL, '022', '022', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 2, 4, 1, 3, NULL),
(33, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '8dc4cad3-b5a4-487a-bd22-361fcd03eeb0', NULL, '023', '023', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 3, 4, 2, 3, NULL),
(34, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, 'a8900421-a618-4482-85af-9ac6951140d5', NULL, '024', '024', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 4, 4, 3, 3, NULL),
(35, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '61cfbb1d-8901-4afa-90e7-cf479e8b9ae6', NULL, '025', '025', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 5, 4, 4, 3, NULL),
(36, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, 'ad49aed7-57cd-4317-9218-f02720ff9b04', NULL, '026', '026', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 6, 4, 5, 3, NULL),
(37, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '6d9c4eee-d0a9-4501-b533-8d56b85a118a', NULL, '027', '027', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 7, 4, 6, 3, NULL),
(38, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '2559851f-2494-4f93-af9c-1d0d4e20c4e9', NULL, '028', '028', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 8, 4, 7, 3, NULL),
(39, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, 'd4783069-145f-43fa-9d81-537ebe7800e0', NULL, '029', '029', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 9, 4, 8, 3, NULL),
(40, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '2bdd7a33-67c1-4500-b6d5-bb5c8d3a6f54', NULL, '030', '030', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 10, 4, 9, 3, NULL),
(41, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '60c3cc4e-209b-4e79-b74b-99cb4cca0d64', NULL, '031', '031', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 1, 6, 0, 5, NULL),
(42, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '63f02965-2e59-4129-839d-99b0150a0bcc', NULL, '032', '032', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 2, 6, 1, 5, NULL),
(43, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, 'c8b27484-4fef-4426-a5c6-006bd2a7d036', NULL, '033', '033', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 3, 6, 2, 5, NULL),
(44, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '55fec060-a50e-4cf3-8b9e-7d111b4bdf5b', NULL, '034', '034', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 4, 6, 3, 5, NULL),
(45, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, 'ab4b4823-54a5-44d6-ac09-29d0ae0aac1a', NULL, '035', '035', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 5, 6, 4, 5, NULL),
(46, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, 'e0e1a898-e961-4af3-bab7-953c85f35e54', NULL, '036', '036', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 6, 6, 5, 5, NULL),
(47, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, 'ba417818-c2ad-45d4-bd92-0ec3bc0a89c6', NULL, '037', '037', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 7, 6, 6, 5, NULL),
(48, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '1b8f0ce6-2ab1-4181-8417-3c89300d9742', NULL, '038', '038', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 8, 6, 7, 5, NULL),
(49, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, 'ec8005c4-1832-46b4-b71d-e5bdc5c4f1ed', NULL, '039', '039', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 9, 6, 8, 5, NULL),
(50, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '077cbfc8-3cd8-41c1-8d42-b119b3f5f911', NULL, '040', '040', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 10, 6, 9, 5, NULL),
(51, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '1003ce07-6db4-4d28-9cc6-6dc383d3ade2', NULL, '041', '041', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 1, 7, 0, 6, NULL),
(52, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, 'b8c4065b-06f6-4770-b6c9-121749b3958f', NULL, '042', '042', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 2, 7, 1, 6, NULL),
(53, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '2fb7789d-ef42-4968-bb71-f0b5c2329e46', NULL, '043', '043', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 3, 7, 2, 6, NULL),
(54, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '1ccf747b-14cf-42bf-9154-e1553c264389', NULL, '044', '044', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 4, 7, 3, 6, NULL),
(55, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, 'af4f9595-7c8d-43bd-947a-7526700b1c9a', NULL, '045', '045', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 5, 7, 4, 6, NULL),
(56, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, 'cf52a8f5-f118-431d-a102-2e4b080a7fc0', NULL, '046', '046', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 6, 7, 5, 6, NULL),
(57, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '09a1424d-2840-4ce3-85bd-3bd0a806cfdb', NULL, '047', '047', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 7, 7, 6, 6, NULL),
(58, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '39c17e5d-0afe-44ae-bf0e-f5d175bd5c48', NULL, '048', '048', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 8, 7, 7, 6, NULL),
(59, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, 'dca480af-f2ea-40ef-a999-deaafa4a9179', NULL, '049', '049', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 9, 7, 8, 6, NULL),
(60, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, 'c1b965bd-721d-4f07-af1e-cb428275a303', NULL, '050', '050', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 10, 7, 9, 6, NULL),
(61, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '67a96852-4395-4e19-b812-0e5eef2416d2', NULL, '051', '051', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 1, 9, 0, 8, NULL),
(62, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, 'ab3f81d1-a73f-4b17-829b-c7d862002ca0', NULL, '052', '052', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 2, 9, 1, 8, NULL),
(63, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '6a8a8d46-0aee-478d-b274-66624f110c94', NULL, '053', '053', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 3, 9, 2, 8, NULL),
(64, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, 'd5e6669b-01d9-4268-98a4-768758353d26', NULL, '054', '054', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 4, 9, 3, 8, NULL),
(65, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '9f30eb40-0c6f-433d-8a5f-d8257b1d570b', NULL, '055', '055', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 5, 9, 4, 8, NULL),
(66, '2021-10-11 13:04:58', '2021-10-11 13:04:58', 2, 1, 2, 2, 2, NULL, '7b8f85b5-fd93-4c91-b1ec-970e4a763578', NULL, '056', '056', 'free', NULL, '2021-10-11 13:04:58', NULL, NULL, 6, 9, 5, 8, NULL),
(67, '2021-10-11 13:04:59', '2021-10-11 13:04:59', 2, 1, 2, 2, 2, NULL, '843f6cbf-83e3-4b69-a919-cedff87c1f35', NULL, '057', '057', 'free', NULL, '2021-10-11 13:04:59', NULL, NULL, 7, 9, 6, 8, NULL),
(68, '2021-10-11 13:04:59', '2021-10-11 13:04:59', 2, 1, 2, 2, 2, NULL, '716360d0-f7fb-4554-afc5-3616ecdd7e58', NULL, '058', '058', 'free', NULL, '2021-10-11 13:04:59', NULL, NULL, 8, 9, 7, 8, NULL),
(69, '2021-10-11 13:04:59', '2021-10-11 13:04:59', 2, 1, 2, 2, 2, NULL, '01b93ad6-4747-4650-9739-d31171221269', NULL, '059', '059', 'free', NULL, '2021-10-11 13:04:59', NULL, NULL, 9, 9, 8, 8, NULL),
(70, '2021-10-11 13:04:59', '2021-10-11 13:04:59', 2, 1, 2, 2, 2, NULL, 'a347d61e-42c0-430e-8927-47f14f3b8a78', NULL, '060', '060', 'free', NULL, '2021-10-11 13:04:59', NULL, NULL, 10, 9, 9, 8, NULL),
(71, '2021-10-11 13:04:59', '2021-10-11 13:04:59', 3, 1, 3, NULL, NULL, NULL, 'aba63044-a10b-4397-9534-c94feac292c2', 'this is a wonderful cargobike', 'cargobike-1', 'cargobike-1', 'free', NULL, '2021-10-11 13:04:59', NULL, NULL, NULL, NULL, NULL, NULL, 5);

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
(1, '2021-10-11 13:04:58', '2021-10-11 13:04:58', NULL, '001', '123456'),
(2, '2021-10-11 13:04:58', '2021-10-11 13:04:58', NULL, '002', '654321');

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
(1, '2021-10-11 13:04:58', '2021-10-11 13:04:58', NULL, 'Fahrrad-Station Teststadt', NULL, 'fahrrad-station-teststadt', 'teststadt-1', 'teststadt-1', 'active', 365, '2021-10-11 13:04:58', NULL, NULL),
(2, '2021-10-11 13:04:58', '2021-10-11 13:04:58', NULL, 'Fahrrad-Station Demostadt', NULL, 'fahrrad-station-demostadt', 'demostadt-1', 'demostadt-1', 'active', 365, '2021-10-11 13:04:58', NULL, NULL);

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
(1, '2021-10-11 13:04:58', '2021-10-11 13:04:58', NULL, 'test@binary-butterfly.de', '$2b$12$o3VNHBTll3yBL2XQEr3ZuOG9HXRg9WR5LPMXl/NSMrHJfq.6R0uzq', NULL, NULL, NULL, NULL, NULL, NULL, 'binary butterfly GmbH', 'Am Hertinger Tor', '59423', 'Unna', 'DE', 'de', NULL, NULL, '[\"admin\"]', NULL, 'Test', 'User');

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix_hardware_lot_name` (`lot_name`);

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
