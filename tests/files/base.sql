-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Erstellungszeit: 10. Jun 2021 um 08:00
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
(1, '2021-06-10 08:00:29', '2021-06-10 08:00:29', 'Logo', 'image/svg+xml'),
(2, '2021-06-10 08:00:29', '2021-06-10 08:00:29', NULL, 'image/jpeg'),
(3, '2021-06-10 08:00:29', '2021-06-10 08:00:29', NULL, 'image/jpeg'),
(4, '2021-06-10 08:00:29', '2021-06-10 08:00:29', NULL, 'image/jpeg'),
(5, '2021-06-10 08:00:30', '2021-06-10 08:00:30', NULL, 'image/jpeg'),
(6, '2021-06-10 08:00:30', '2021-06-10 08:00:30', NULL, 'image/jpeg'),
(7, '2021-06-10 08:00:30', '2021-06-10 08:00:30', NULL, 'image/jpeg'),
(8, '2021-06-10 08:00:30', '2021-06-10 08:00:30', NULL, 'image/jpeg');

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
(1, '2021-06-10 08:00:29', '2021-06-10 08:00:29', 'Einzel-Box', 0, NULL),
(2, '2021-06-10 08:00:29', '2021-06-10 08:00:29', 'Sammel-Anlagen-Stellplatz', 0, NULL),
(3, '2021-06-10 08:00:29', '2021-06-10 08:00:29', 'Cargo-Bike', 1, NULL);

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
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `future_booking` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Daten für Tabelle `operator`
--

INSERT INTO `operator` (`id`, `created`, `modified`, `logo_id`, `tax_rate`, `name`, `description`, `address`, `postalcode`, `locality`, `country`, `slug`, `url`, `email`, `future_booking`) VALUES
(1, '2021-06-10 08:00:29', '2021-06-10 08:00:29', 1, '0.1900', 'Open Bike GmbH', NULL, 'Fahrradstraße 1', '12345', 'Fahrradstadt', 'de', 'open-bike-gmbh', 'https://openbikebox.de', 'test@open-bike.gmbh', '0'),
(2, '2021-06-10 08:00:29', '2021-06-10 08:00:29', 1, '0.1900', 'Open Cargo GmbH', NULL, 'Fahrradstraße 1', '12345', 'Fahrradstadt', 'de', 'open-cargo-gmbh', 'https://opencargobike.de', 'test@open-cargo.gmbh', '1');

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
(1, '2021-06-10 08:00:29', '2021-06-10 08:00:29', NULL, '0.2000', '1.0000', '5.0000', '15.0000', '100.0000', NULL, NULL);

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
(1, '2021-06-10 08:00:29', '2021-06-10 08:00:29', NULL, 2, 36000, 68400),
(2, '2021-06-10 08:00:29', '2021-06-10 08:00:29', NULL, 3, 54000, 68400),
(3, '2021-06-10 08:00:29', '2021-06-10 08:00:29', NULL, 4, 54000, 68400),
(4, '2021-06-10 08:00:29', '2021-06-10 08:00:29', NULL, 5, 36000, 68400);

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
(1, '2021-06-10 08:00:29', '2021-06-10 08:00:29', 1, 1, 1, 1, 1, NULL, '0400bf8c-22c8-44fb-93f5-314c7c0a0794', NULL, '01', '01', 'free', NULL, '2021-06-10 08:00:29', NULL, NULL, 1, 1, 0, 0, NULL),
(2, '2021-06-10 08:00:29', '2021-06-10 08:00:29', 1, 1, 1, 1, 1, NULL, 'd7c6efde-0966-4512-8723-b6eb004faeda', NULL, '02', '02', 'free', NULL, '2021-06-10 08:00:29', NULL, NULL, 3, 1, 2, 0, NULL),
(3, '2021-06-10 08:00:29', '2021-06-10 08:00:29', 1, 1, 1, 1, 1, NULL, '7fb5d4f0-2aec-4fe0-8ec9-6385aa86e83f', NULL, '03', '03', 'free', NULL, '2021-06-10 08:00:29', NULL, NULL, 1, 2, 0, 1, NULL),
(4, '2021-06-10 08:00:29', '2021-06-10 08:00:29', 1, 1, 1, 1, 1, NULL, 'da7bf760-abe5-4b27-9e88-08f55e3e78de', NULL, '04', '04', 'free', NULL, '2021-06-10 08:00:29', NULL, NULL, 3, 2, 2, 1, NULL),
(5, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 1, 1, 1, 1, 1, NULL, '3af719fd-3df5-4d4b-992a-cf8447111d6a', NULL, '05', '05', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 1, 3, 0, 2, NULL),
(6, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 1, 1, 1, 1, 1, NULL, 'd57949c5-c9a9-47ff-821e-cbab62b69573', NULL, '06', '06', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 3, 3, 2, 2, NULL),
(7, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 1, 1, 1, 1, 1, NULL, 'd7fe0919-96d7-4c7c-b9c3-9cde6bcc6d01', NULL, '07', '07', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 1, 4, 0, 3, NULL),
(8, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 1, 1, 1, 1, 1, NULL, '4ae14d33-3976-484f-8312-de871bedb139', NULL, '08', '08', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 3, 4, 2, 3, NULL),
(9, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 1, 1, 1, 1, 1, NULL, '23a0dc9c-bae8-44f7-bbf7-5b4cc0c0105c', NULL, '09', '09', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 1, 5, 0, 4, NULL),
(10, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 1, 1, 1, 1, 1, NULL, 'dcb22bd7-0096-4df9-b5b7-43b4d1ca2d28', NULL, '10', '10', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 3, 5, 2, 4, NULL),
(11, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '7ffb7559-35ae-4168-865e-49fdd94a2479', NULL, '001', '001', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 1, 1, 0, 0, NULL),
(12, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'ec14710e-a5bd-4fe7-91da-8af1f1fc5870', NULL, '002', '002', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 2, 1, 1, 0, NULL),
(13, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'c2e8f7b9-1297-40e1-97b3-9813490dc4ef', NULL, '003', '003', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 3, 1, 2, 0, NULL),
(14, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '2b106517-b707-458a-a433-2bc157eaa4f4', NULL, '004', '004', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 4, 1, 3, 0, NULL),
(15, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '98666d46-42df-45e5-90ac-07cbe4a7880a', NULL, '005', '005', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 5, 1, 4, 0, NULL),
(16, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '4f80fb85-75fa-4ec1-96fc-79778afd463a', NULL, '006', '006', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 6, 1, 5, 0, NULL),
(17, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'c0ea7f92-edb7-45ca-a6f0-e91fefc8428b', NULL, '007', '007', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 7, 1, 6, 0, NULL),
(18, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '922f3715-0dce-4766-b350-4acc7648d38e', NULL, '008', '008', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 8, 1, 7, 0, NULL),
(19, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '7cc52896-7efc-4b55-b243-512dd6cc8e93', NULL, '009', '009', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 9, 1, 8, 0, NULL),
(20, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '721a5ef5-6f91-4e6d-a901-f361fdd9e616', NULL, '010', '010', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 10, 1, 9, 0, NULL),
(21, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'f09eae3d-540f-4348-b0de-fe7f1f749f83', NULL, '011', '011', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 1, 3, 0, 2, NULL),
(22, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '016b72fb-d81f-4471-9729-27b1f6a7ce3b', NULL, '012', '012', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 2, 3, 1, 2, NULL),
(23, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'ed1a5ad3-54a7-479f-8cee-53493db8ea8c', NULL, '013', '013', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 3, 3, 2, 2, NULL),
(24, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'a9758220-22cb-4cb0-98a8-0a59fa986455', NULL, '014', '014', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 4, 3, 3, 2, NULL),
(25, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '3fc64e57-3697-43f7-9edf-8c55ef1241ad', NULL, '015', '015', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 5, 3, 4, 2, NULL),
(26, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '2e3ab951-d590-45f1-8f54-d49aa4cf8785', NULL, '016', '016', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 6, 3, 5, 2, NULL),
(27, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '83e27eb7-6a22-4d00-a842-019c3fde38e0', NULL, '017', '017', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 7, 3, 6, 2, NULL),
(28, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '0151b89c-ae86-4e9f-b351-5fa55ad5dd4d', NULL, '018', '018', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 8, 3, 7, 2, NULL),
(29, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'f91a9fc9-b0df-4f2f-ab17-10d5ece9c592', NULL, '019', '019', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 9, 3, 8, 2, NULL),
(30, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '187875ad-e0d0-43f7-b71d-82042feba601', NULL, '020', '020', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 10, 3, 9, 2, NULL),
(31, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '4f18913b-94bd-46bf-b8f2-5866a48e3e31', NULL, '021', '021', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 1, 4, 0, 3, NULL),
(32, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '16652268-3172-459a-bd00-dc37cbaf742f', NULL, '022', '022', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 2, 4, 1, 3, NULL),
(33, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'bc759597-9e83-48a3-9faf-ee99bf3a62cc', NULL, '023', '023', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 3, 4, 2, 3, NULL),
(34, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'f1dc3eff-55de-4cbf-82e8-0efeef3ee6ef', NULL, '024', '024', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 4, 4, 3, 3, NULL),
(35, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'd7794e4c-282c-4449-83e9-639f49029db3', NULL, '025', '025', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 5, 4, 4, 3, NULL),
(36, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '315477be-263d-424b-baf3-c95e76d86e55', NULL, '026', '026', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 6, 4, 5, 3, NULL),
(37, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'a0275683-b1c0-4aff-8b33-2e7d5e2894de', NULL, '027', '027', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 7, 4, 6, 3, NULL),
(38, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'a1fd325f-81d2-4b3a-8349-13d420ecdd71', NULL, '028', '028', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 8, 4, 7, 3, NULL),
(39, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'c9fb126b-ad3a-47de-a29c-7492b7914e3c', NULL, '029', '029', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 9, 4, 8, 3, NULL),
(40, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'b56010f6-d314-4b7f-86a1-4f912f947d28', NULL, '030', '030', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 10, 4, 9, 3, NULL),
(41, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '45eda749-07ae-48f6-a90a-4d15d157e2f6', NULL, '031', '031', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 1, 6, 0, 5, NULL),
(42, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '282a0479-aaa2-42b4-9cbf-c1f160ea03cd', NULL, '032', '032', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 2, 6, 1, 5, NULL),
(43, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '08b94d8d-70c0-48d2-9ac3-a20ad0994bb8', NULL, '033', '033', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 3, 6, 2, 5, NULL),
(44, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '922e8e54-7128-4d14-b525-d8abfb5c0277', NULL, '034', '034', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 4, 6, 3, 5, NULL),
(45, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '8d6b3572-397d-48a2-a61b-9345aadaa795', NULL, '035', '035', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 5, 6, 4, 5, NULL),
(46, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '02922e9d-09c8-4d21-80f0-e21fe833e0b9', NULL, '036', '036', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 6, 6, 5, 5, NULL),
(47, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '59b82382-fffe-45c5-adc8-1caa87c9dbc0', NULL, '037', '037', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 7, 6, 6, 5, NULL),
(48, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '071b574b-6e90-4db9-a6e6-e02c1a4f3246', NULL, '038', '038', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 8, 6, 7, 5, NULL),
(49, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '07ebd9fa-3b86-4fb2-a727-bef5f17c9dc1', NULL, '039', '039', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 9, 6, 8, 5, NULL),
(50, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '1e83d518-be17-4f1c-855e-d3aaf56c4d6a', NULL, '040', '040', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 10, 6, 9, 5, NULL),
(51, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '9547ea8f-4691-4a83-bb38-9a37179a04f4', NULL, '041', '041', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 1, 7, 0, 6, NULL),
(52, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'aecbca70-1ca1-4707-970c-d4d10905e237', NULL, '042', '042', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 2, 7, 1, 6, NULL),
(53, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'aad2498b-a61f-46e9-8ddc-dac72d3d70e2', NULL, '043', '043', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 3, 7, 2, 6, NULL),
(54, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '4107f2a0-9376-45b6-b872-25cd61e97ce8', NULL, '044', '044', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 4, 7, 3, 6, NULL),
(55, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'a78e5702-d60c-4004-a590-13bd18ec7b6e', NULL, '045', '045', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 5, 7, 4, 6, NULL),
(56, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'b461807a-cd50-4fc7-b04e-b2d1e10ecd2d', NULL, '046', '046', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 6, 7, 5, 6, NULL),
(57, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'b881c8ed-5b35-43cc-9359-9120963b98a7', NULL, '047', '047', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 7, 7, 6, 6, NULL),
(58, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'd729abc2-3ec8-43f7-b153-1adc19e36e39', NULL, '048', '048', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 8, 7, 7, 6, NULL),
(59, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'af66b504-d82e-4bbb-a4a3-f1253245d1ae', NULL, '049', '049', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 9, 7, 8, 6, NULL),
(60, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'c40b11d6-36ad-4383-abb3-53eea1e5253a', NULL, '050', '050', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 10, 7, 9, 6, NULL),
(61, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'debf0355-e769-410f-85e0-21a91e141fcc', NULL, '051', '051', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 1, 9, 0, 8, NULL),
(62, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'dac89c08-b458-4de1-aee8-643685f7c19b', NULL, '052', '052', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 2, 9, 1, 8, NULL),
(63, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '24af310f-ca54-456a-9e2b-3c5b3d6cd85f', NULL, '053', '053', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 3, 9, 2, 8, NULL),
(64, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '989c0f6b-00f7-45c3-b9b8-86dee8fc2c0d', NULL, '054', '054', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 4, 9, 3, 8, NULL),
(65, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '15f8aaa7-49c8-485e-b2fb-3e9032d1cc84', NULL, '055', '055', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 5, 9, 4, 8, NULL),
(66, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, 'b84b9b60-e892-445d-919a-eb8a9105ace2', NULL, '056', '056', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 6, 9, 5, 8, NULL),
(67, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '21641801-0a28-4fb1-a575-90be4bbec8f1', NULL, '057', '057', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 7, 9, 6, 8, NULL),
(68, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '692e2497-b2d4-4ebc-b7a8-a1f282e21dad', NULL, '058', '058', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 8, 9, 7, 8, NULL),
(69, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '40bcaf80-827c-44cd-94c5-c0908401f05e', NULL, '059', '059', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 9, 9, 8, 8, NULL),
(70, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 2, 1, 2, 2, 2, NULL, '7fc72b97-8229-4145-b61d-913bbb10a0cc', NULL, '060', '060', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, 10, 9, 9, 8, NULL),
(71, '2021-06-10 08:00:30', '2021-06-10 08:00:30', 3, 1, 3, NULL, NULL, NULL, '55877581-7011-47cc-8222-ae7788a22708', NULL, 'cargobike-1', 'cargobike-1', 'free', NULL, '2021-06-10 08:00:30', NULL, NULL, NULL, NULL, NULL, NULL, 5);

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
(1, '2021-06-10 08:00:29', '2021-06-10 08:00:29', NULL, '001', '123456'),
(2, '2021-06-10 08:00:29', '2021-06-10 08:00:29', NULL, '002', '654321');

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
(1, '2021-06-10 08:00:29', '2021-06-10 08:00:29', NULL, 'Fahrrad-Station Teststadt', NULL, 'fahrrad-station-teststadt', 'teststadt-1', 'teststadt-1', 'active', 365, '2021-06-10 08:00:29', NULL, NULL),
(2, '2021-06-10 08:00:29', '2021-06-10 08:00:29', NULL, 'Fahrrad-Station Demostadt', NULL, 'fahrrad-station-demostadt', 'demostadt-1', 'demostadt-1', 'active', 365, '2021-06-10 08:00:29', NULL, NULL);

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
(1, '2021-06-10 08:00:29', '2021-06-10 08:00:29', NULL, 'test@binary-butterfly.de', '$2b$12$dXfM5fSrvGsVvs6BO3jgnumU6//0yt/6V.4ThdkaBCFmIixhoanYG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'binary butterfly GmbH', 'Am Hertinger Tor', '59423', 'Unna', 'DE', 'de', NULL, NULL, '[\"admin\"]');

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
