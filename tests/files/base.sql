-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Erstellungszeit: 29. Mai 2021 um 08:15
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
(1, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 'Logo', 'image/svg+xml'),
(2, '2021-05-29 08:15:24', '2021-05-29 08:15:24', NULL, 'image/jpeg'),
(3, '2021-05-29 08:15:24', '2021-05-29 08:15:24', NULL, 'image/jpeg'),
(4, '2021-05-29 08:15:24', '2021-05-29 08:15:24', NULL, 'image/jpeg'),
(5, '2021-05-29 08:15:25', '2021-05-29 08:15:25', NULL, 'image/jpeg');

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
(1, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 'Einzel-Box'),
(2, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 'Sammel-Anlagen-Stellplatz'),
(3, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 'Cargo-Bike');

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

;

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
(1, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 1, '0.1900', 'Open Bike GmbH', NULL, 'Fahrradstraße 1', '12345', 'Fahrradstadt', 'de', 'open-bike-gmbh', 'https://openbikebox.de', 'test@open-bike.gmbh'),
(2, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 1, '0.1900', 'Open Cargo GmbH', NULL, 'Fahrradstraße 1', '12345', 'Fahrradstadt', 'de', 'open-cargo-gmbh', 'https://opencargobike.de', 'test@open-cargo.gmbh');

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
(1, '2021-05-29 08:15:24', '2021-05-29 08:15:24', NULL, '0.2000', '1.0000', '5.0000', '15.0000', '100.0000');

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
(1, '2021-05-29 08:15:24', '2021-05-29 08:15:24', NULL, 2, 36000, 68400),
(2, '2021-05-29 08:15:24', '2021-05-29 08:15:24', NULL, 3, 54000, 68400),
(3, '2021-05-29 08:15:24', '2021-05-29 08:15:24', NULL, 4, 54000, 68400),
(4, '2021-05-29 08:15:24', '2021-05-29 08:15:24', NULL, 5, 36000, 68400);

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
(1, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 1, 1, 1, 1, 1, NULL, 'b6ec774d-2e39-4911-9d77-32f60b8fa11f', NULL, '01', '01', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 1, 1, 0, 0, NULL),
(2, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 1, 1, 1, 1, 1, NULL, '5bd6124c-c665-4264-a443-fdeb9f3a5d51', NULL, '02', '02', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 3, 1, 2, 0, NULL),
(3, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 1, 1, 1, 1, 1, NULL, '4ed735b5-d1d3-4a7e-a91f-8852e2c856e8', NULL, '03', '03', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 1, 2, 0, 1, NULL),
(4, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 1, 1, 1, 1, 1, NULL, '70a9e464-855b-490e-863a-c72250652d87', NULL, '04', '04', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 3, 2, 2, 1, NULL),
(5, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 1, 1, 1, 1, 1, NULL, 'a8ead1a5-2aa6-48fe-9d1a-7a1d4af49cbc', NULL, '05', '05', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 1, 3, 0, 2, NULL),
(6, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 1, 1, 1, 1, 1, NULL, 'fc76723b-45d4-4fdc-a10f-00a845599bbf', NULL, '06', '06', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 3, 3, 2, 2, NULL),
(7, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 1, 1, 1, 1, 1, NULL, 'fb1ccd39-91f7-4a39-a47d-827c8f4e5d8c', NULL, '07', '07', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 1, 4, 0, 3, NULL),
(8, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 1, 1, 1, 1, 1, NULL, '62a35ee1-cdbf-4b0a-972b-2becec0b1562', NULL, '08', '08', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 3, 4, 2, 3, NULL),
(9, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 1, 1, 1, 1, 1, NULL, '77d359bd-e49d-4527-b748-0ea8433013dd', NULL, '09', '09', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 1, 5, 0, 4, NULL),
(10, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 1, 1, 1, 1, 1, NULL, 'e3722411-c96d-47b7-8301-aea8e70da786', NULL, '10', '10', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 3, 5, 2, 4, NULL),
(11, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, 'e165f1b0-cda1-4a2f-94f6-f0dbf61d8427', NULL, '001', '001', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 1, 1, 0, 0, NULL),
(12, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '22378479-e6b9-4ecf-a54e-fdf02d4721e1', NULL, '002', '002', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 2, 1, 1, 0, NULL),
(13, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '39deff71-7769-4605-8699-2120b4f05a31', NULL, '003', '003', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 3, 1, 2, 0, NULL),
(14, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '21678897-f742-4b9c-9cbc-04bea923aeed', NULL, '004', '004', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 4, 1, 3, 0, NULL),
(15, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '82448562-991e-439e-b3b9-adee04d36ec9', NULL, '005', '005', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 5, 1, 4, 0, NULL),
(16, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '9eb91f2f-bb98-45a5-a64e-fbab3147f113', NULL, '006', '006', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 6, 1, 5, 0, NULL),
(17, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '8d28ef48-d0c7-46fe-9da0-b17d9e0b2706', NULL, '007', '007', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 7, 1, 6, 0, NULL),
(18, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '3606a5c6-a4d4-4500-97fd-a1f83041ecde', NULL, '008', '008', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 8, 1, 7, 0, NULL),
(19, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '1bca14ab-c4c8-4752-ba56-6b9e105233b8', NULL, '009', '009', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 9, 1, 8, 0, NULL),
(20, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '4f5e2d28-3469-4e62-ad1c-e6f6aa89633f', NULL, '010', '010', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 10, 1, 9, 0, NULL),
(21, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, 'c088c8ff-898c-4ee4-85c2-d98dffca4fe0', NULL, '011', '011', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 1, 3, 0, 2, NULL),
(22, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, 'ea83c061-bddb-4830-a339-c08c0a5d8c53', NULL, '012', '012', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 2, 3, 1, 2, NULL),
(23, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '83d55ee8-dd4c-467d-91a4-553ac008724f', NULL, '013', '013', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 3, 3, 2, 2, NULL),
(24, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '7e4ba6f1-ab1e-4a90-ac6a-75a5ee78489c', NULL, '014', '014', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 4, 3, 3, 2, NULL),
(25, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '7e12a533-f4ec-4af3-982d-cae17574fbbe', NULL, '015', '015', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 5, 3, 4, 2, NULL),
(26, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '3004241f-503e-4927-a9ec-6a87ca1ddfba', NULL, '016', '016', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 6, 3, 5, 2, NULL),
(27, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '0d165148-15fa-414e-a9ad-fcc5ac2d7786', NULL, '017', '017', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 7, 3, 6, 2, NULL),
(28, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '2823b824-7044-449d-a5f9-ed0d1dcdb1c0', NULL, '018', '018', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 8, 3, 7, 2, NULL),
(29, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '3e6e7bff-ce03-4c1c-ad76-f143a2b73d96', NULL, '019', '019', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 9, 3, 8, 2, NULL),
(30, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, 'e245d56d-47b8-4230-81bf-0912d3aef911', NULL, '020', '020', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 10, 3, 9, 2, NULL),
(31, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '52b522ef-2ed2-458c-b71f-216d0ff3e6af', NULL, '021', '021', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 1, 4, 0, 3, NULL),
(32, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '64d3aaa8-19be-4925-8009-b2e338090af9', NULL, '022', '022', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 2, 4, 1, 3, NULL),
(33, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '6b7918c3-b6e9-4723-8bef-ce4d6666a726', NULL, '023', '023', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 3, 4, 2, 3, NULL),
(34, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '728febbe-ec58-4e69-ac75-b84f500395f1', NULL, '024', '024', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 4, 4, 3, 3, NULL),
(35, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '5a3fd91f-51b4-4abd-8a85-aa14edd9aff1', NULL, '025', '025', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 5, 4, 4, 3, NULL),
(36, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '24d05c85-2779-4014-a8db-666f76898fed', NULL, '026', '026', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 6, 4, 5, 3, NULL),
(37, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '9b0ce458-03ed-43fc-9337-c9048659b685', NULL, '027', '027', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 7, 4, 6, 3, NULL),
(38, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, 'fbc24de3-9db1-4f0c-8084-e07697d3a183', NULL, '028', '028', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 8, 4, 7, 3, NULL),
(39, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, 'de3744f1-b8ce-44a3-b8e6-2b3589ad39aa', NULL, '029', '029', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 9, 4, 8, 3, NULL),
(40, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '9662fe60-a39a-443c-8107-228c32859dcd', NULL, '030', '030', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 10, 4, 9, 3, NULL),
(41, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, 'c2b0cd06-9054-4423-8d93-51a6d8e78d1e', NULL, '031', '031', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 1, 6, 0, 5, NULL),
(42, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '8c33a1ec-3ead-4e51-9042-ded51dab2734', NULL, '032', '032', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 2, 6, 1, 5, NULL),
(43, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '8e954409-28ce-4822-9340-87461522368b', NULL, '033', '033', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 3, 6, 2, 5, NULL),
(44, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '42ec5534-acdd-4d13-9e49-5106847b77f9', NULL, '034', '034', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 4, 6, 3, 5, NULL),
(45, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '6fd97f70-f66c-480e-be0d-f03418142d72', NULL, '035', '035', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 5, 6, 4, 5, NULL),
(46, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '370e193d-fa09-4663-ac65-5b869383c27b', NULL, '036', '036', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 6, 6, 5, 5, NULL),
(47, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '1c36ccad-3db8-4d4f-a932-f1a0fb583d12', NULL, '037', '037', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 7, 6, 6, 5, NULL),
(48, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '0a74ed2d-f842-4870-8509-80b92365ed0f', NULL, '038', '038', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 8, 6, 7, 5, NULL),
(49, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '59036931-c621-4371-ae87-e242ad696b99', NULL, '039', '039', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 9, 6, 8, 5, NULL),
(50, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '39fec9d4-c122-4cc6-8325-24b2d386935f', NULL, '040', '040', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 10, 6, 9, 5, NULL),
(51, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '4e1c29c1-ff5d-427c-ab5d-9fdc28e62dff', NULL, '041', '041', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 1, 7, 0, 6, NULL),
(52, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '9d83099c-992f-48d9-99cc-b69977c7fb52', NULL, '042', '042', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 2, 7, 1, 6, NULL),
(53, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '88c6ea3f-5997-4192-aad3-161112c281f3', NULL, '043', '043', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 3, 7, 2, 6, NULL),
(54, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '34ecdb40-a2ca-4aae-986a-ab8471f110f3', NULL, '044', '044', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 4, 7, 3, 6, NULL),
(55, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '1dcbf632-9ad5-4665-a0bb-dd82c13aa19b', NULL, '045', '045', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 5, 7, 4, 6, NULL),
(56, '2021-05-29 08:15:24', '2021-05-29 08:15:24', 2, 1, 2, 2, 2, NULL, '7fcf1d1b-bd55-49f5-85f8-b3025d646125', NULL, '046', '046', 'free', NULL, '2021-05-29 08:15:24', NULL, NULL, 6, 7, 5, 6, NULL),
(57, '2021-05-29 08:15:25', '2021-05-29 08:15:25', 2, 1, 2, 2, 2, NULL, '12b88cd4-c3da-435b-9e3e-7850cd7bc161', NULL, '047', '047', 'free', NULL, '2021-05-29 08:15:25', NULL, NULL, 7, 7, 6, 6, NULL),
(58, '2021-05-29 08:15:25', '2021-05-29 08:15:25', 2, 1, 2, 2, 2, NULL, 'ed72cd86-687a-4776-86b0-d6ca4bdac722', NULL, '048', '048', 'free', NULL, '2021-05-29 08:15:25', NULL, NULL, 8, 7, 7, 6, NULL),
(59, '2021-05-29 08:15:25', '2021-05-29 08:15:25', 2, 1, 2, 2, 2, NULL, '6c510a2c-9714-4bcc-9440-76f3f76cdf94', NULL, '049', '049', 'free', NULL, '2021-05-29 08:15:25', NULL, NULL, 9, 7, 8, 6, NULL),
(60, '2021-05-29 08:15:25', '2021-05-29 08:15:25', 2, 1, 2, 2, 2, NULL, '7dc5b3f4-0228-4573-b91a-a3abdc2bf3cc', NULL, '050', '050', 'free', NULL, '2021-05-29 08:15:25', NULL, NULL, 10, 7, 9, 6, NULL),
(61, '2021-05-29 08:15:25', '2021-05-29 08:15:25', 2, 1, 2, 2, 2, NULL, 'fd54ccbd-6668-49ce-be7e-6c6944bf8f2d', NULL, '051', '051', 'free', NULL, '2021-05-29 08:15:25', NULL, NULL, 1, 9, 0, 8, NULL),
(62, '2021-05-29 08:15:25', '2021-05-29 08:15:25', 2, 1, 2, 2, 2, NULL, 'e86f43ef-b5db-487d-aa8f-90feff94cace', NULL, '052', '052', 'free', NULL, '2021-05-29 08:15:25', NULL, NULL, 2, 9, 1, 8, NULL),
(63, '2021-05-29 08:15:25', '2021-05-29 08:15:25', 2, 1, 2, 2, 2, NULL, '9ec2d007-2cc2-4ff6-a98b-fa95c9dc5864', NULL, '053', '053', 'free', NULL, '2021-05-29 08:15:25', NULL, NULL, 3, 9, 2, 8, NULL),
(64, '2021-05-29 08:15:25', '2021-05-29 08:15:25', 2, 1, 2, 2, 2, NULL, '58dd3268-2da0-4236-8359-950f4c6d83b3', NULL, '054', '054', 'free', NULL, '2021-05-29 08:15:25', NULL, NULL, 4, 9, 3, 8, NULL),
(65, '2021-05-29 08:15:25', '2021-05-29 08:15:25', 2, 1, 2, 2, 2, NULL, '609b1eb1-a243-41e3-bd46-690d814cce2e', NULL, '055', '055', 'free', NULL, '2021-05-29 08:15:25', NULL, NULL, 5, 9, 4, 8, NULL),
(66, '2021-05-29 08:15:25', '2021-05-29 08:15:25', 2, 1, 2, 2, 2, NULL, '220ec409-b950-4298-b6dc-cfcca3cccf97', NULL, '056', '056', 'free', NULL, '2021-05-29 08:15:25', NULL, NULL, 6, 9, 5, 8, NULL),
(67, '2021-05-29 08:15:25', '2021-05-29 08:15:25', 2, 1, 2, 2, 2, NULL, 'e45a7f35-9170-40e0-8c17-fa141e901fce', NULL, '057', '057', 'free', NULL, '2021-05-29 08:15:25', NULL, NULL, 7, 9, 6, 8, NULL),
(68, '2021-05-29 08:15:25', '2021-05-29 08:15:25', 2, 1, 2, 2, 2, NULL, '61bd8012-969d-42f5-8046-b4bd1cc80d5e', NULL, '058', '058', 'free', NULL, '2021-05-29 08:15:25', NULL, NULL, 8, 9, 7, 8, NULL),
(69, '2021-05-29 08:15:25', '2021-05-29 08:15:25', 2, 1, 2, 2, 2, NULL, 'fb13ec64-5f5a-4b43-bad6-0faed0ab203c', NULL, '059', '059', 'free', NULL, '2021-05-29 08:15:25', NULL, NULL, 9, 9, 8, 8, NULL),
(70, '2021-05-29 08:15:25', '2021-05-29 08:15:25', 2, 1, 2, 2, 2, NULL, '16597e05-06a8-49dd-b64c-05e2027d9e52', NULL, '060', '060', 'free', NULL, '2021-05-29 08:15:25', NULL, NULL, 10, 9, 9, 8, NULL),
(71, '2021-05-29 08:15:25', '2021-05-29 08:15:25', 3, 1, 3, NULL, NULL, NULL, '4ba4fbee-8711-450c-96ee-78e108d05b8a', NULL, 'cargobike-1', 'cargobike-1', 'free', NULL, '2021-05-29 08:15:25', NULL, NULL, NULL, NULL, NULL, NULL, 5);

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
(1, '2021-05-29 08:15:24', '2021-05-29 08:15:24', NULL, '001', '123456'),
(2, '2021-05-29 08:15:24', '2021-05-29 08:15:24', NULL, '002', '654321');

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
(1, '2021-05-29 08:15:24', '2021-05-29 08:15:24', NULL, 'Fahrrad-Station Teststadt', NULL, 'fahrrad-station-teststadt', 'teststadt-1', 'teststadt-1', 'active', 365, '2021-05-29 08:15:24', NULL, NULL),
(2, '2021-05-29 08:15:24', '2021-05-29 08:15:24', NULL, 'Fahrrad-Station Demostadt', NULL, 'fahrrad-station-demostadt', 'demostadt-1', 'demostadt-1', 'active', 365, '2021-05-29 08:15:24', NULL, NULL);

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
(1, '2021-05-29 08:15:24', '2021-05-29 08:15:24', NULL, 'test@binary-butterfly.de', '$2b$12$4463cNMUCpSTfurgT.LL.up/Qaz3pDP7CcJFlCC4taxSoimUNPaby', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'binary butterfly GmbH', 'Am Hertinger Tor', '59423', 'Unna', 'DE', 'de', NULL, NULL, '[\"admin\"]');

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
