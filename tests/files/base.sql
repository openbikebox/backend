-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Erstellungszeit: 02. Mai 2021 um 08:18
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
('877460bb55ba');

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
(1, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 'Logo', 'image/svg+xml'),
(2, '2021-05-02 08:18:16', '2021-05-02 08:18:16', NULL, 'image/jpeg'),
(3, '2021-05-02 08:18:16', '2021-05-02 08:18:16', NULL, 'image/jpeg');

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
(1, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 'Einzel-Box'),
(2, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 'Sammel-Anlagen-Stellplatz');

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
  `osm_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Daten für Tabelle `location`
--

INSERT INTO `location` (`id`, `created`, `modified`, `operator_id`, `photo_id`, `name`, `slug`, `lat`, `lon`, `address`, `postalcode`, `locality`, `country`, `description`, `osm_id`) VALUES
(1, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 1, 2, 'Fahrrad-Station Dortmund', 'fahrrad-station-dortmund', '51.5174770', '7.4605470', 'Königswall 15', '44137', 'Dortmund', 'de', NULL, NULL),
(2, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 1, 3, 'Fahrrad-Station Bochum', 'fahrrad-station-bochum', '51.4791580', '7.2229040', 'Kurt-Schumacher-Platz 1', '44787', 'Bochum', 'de', NULL, NULL);

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
  `country` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Daten für Tabelle `operator`
--

INSERT INTO `operator` (`id`, `created`, `modified`, `logo_id`, `tax_rate`, `name`, `description`, `address`, `postalcode`, `locality`, `country`) VALUES
(1, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 1, '0.1600', 'Open Bike GmbH', NULL, 'Fahrradstraße 1', '12345', 'Fahrradstadt', 'de');

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
(1, '2021-05-02 08:18:16', '2021-05-02 08:18:16', NULL, '0.2000', '1.0000', '5.0000', '15.0000', '100.0000');

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
  `polygon_left` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Daten für Tabelle `resource`
--

INSERT INTO `resource` (`id`, `created`, `modified`, `location_id`, `pricegroup_id`, `hardware_id`, `resource_group_id`, `resource_access_id`, `name`, `slug`, `description`, `internal_identifier`, `user_identifier`, `status`, `unavailable_until`, `installed_at`, `maintenance_from`, `maintenance_till`, `polygon_top`, `polygon_right`, `polygon_bottom`, `polygon_left`) VALUES
(1, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 1, 1, 1, 1, 1, NULL, 'b1428b07-2bb5-4ae3-a32e-0a7fd48edf1b', NULL, '01', '01', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 1, 1, 0, 0),
(2, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 1, 1, 1, 1, 1, NULL, '2531405f-a40b-4799-aa16-0ac3ec8047e2', NULL, '02', '02', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 3, 1, 2, 0),
(3, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 1, 1, 1, 1, 1, NULL, '1b880156-4f30-4fd8-922e-1677a244bbc8', NULL, '03', '03', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 1, 2, 0, 1),
(4, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 1, 1, 1, 1, 1, NULL, '6e9fd74f-e92e-4e9d-b212-1b14a710a72a', NULL, '04', '04', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 3, 2, 2, 1),
(5, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 1, 1, 1, 1, 1, NULL, '33c28141-dde1-4785-8688-d038c1db0ac2', NULL, '05', '05', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 1, 3, 0, 2),
(6, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 1, 1, 1, 1, 1, NULL, '3b5583fa-6195-4d2f-8a0f-7fe69ee9dbaf', NULL, '06', '06', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 3, 3, 2, 2),
(7, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 1, 1, 1, 1, 1, NULL, '3054380a-439b-41c5-9d0f-b9c3bf99d632', NULL, '07', '07', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 1, 4, 0, 3),
(8, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 1, 1, 1, 1, 1, NULL, 'd7884681-4f0e-486b-92d7-0d9b6ec2cd27', NULL, '08', '08', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 3, 4, 2, 3),
(9, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 1, 1, 1, 1, 1, NULL, '1969a003-1e78-4f01-a222-b145851509f4', NULL, '09', '09', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 1, 5, 0, 4),
(10, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 1, 1, 1, 1, 1, NULL, '07a1ea0a-ac4b-4bd2-bc76-9001aebf9516', NULL, '10', '10', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 3, 5, 2, 4),
(11, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, 'a21354ff-36fb-4365-8d75-a50166e559f5', NULL, '001', '001', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 1, 1, 0, 0),
(12, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, 'ea25ffb7-5440-4f89-a339-9cfa032041bf', NULL, '002', '002', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 2, 1, 1, 0),
(13, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, '5d86ad1f-3b82-4be6-9cf4-b3f4a25d6957', NULL, '003', '003', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 3, 1, 2, 0),
(14, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, 'e31b71b3-e0f1-4cbd-b9b1-33f5fce0f8db', NULL, '004', '004', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 4, 1, 3, 0),
(15, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, 'a5e3e64f-8bd3-4142-b477-daede9573875', NULL, '005', '005', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 5, 1, 4, 0),
(16, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, '39656fdc-5fe2-4a1c-9685-516c46e1c32c', NULL, '006', '006', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 6, 1, 5, 0),
(17, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, 'b986205f-0dc9-435b-b6ad-33ff13a9e953', NULL, '007', '007', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 7, 1, 6, 0),
(18, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, '07ec719f-2c20-4e22-a3d9-5ff17936d734', NULL, '008', '008', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 8, 1, 7, 0),
(19, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, '2caf6255-647c-4572-a0e6-a0cb59203532', NULL, '009', '009', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 9, 1, 8, 0),
(20, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, 'ee3c0797-07e7-4194-bbb3-254b6cd36c3c', NULL, '010', '010', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 10, 1, 9, 0),
(21, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, '6f0f82f3-74d5-4aa9-b8f5-7d259db02e4c', NULL, '011', '011', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 1, 3, 0, 2),
(22, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, '007cd58a-0da2-4101-b007-f52cd5ee94fe', NULL, '012', '012', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 2, 3, 1, 2),
(23, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, 'bb361e30-8569-4a72-949a-afad0b262f1c', NULL, '013', '013', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 3, 3, 2, 2),
(24, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, '097107dd-c3f3-4940-978c-08960ce80f4a', NULL, '014', '014', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 4, 3, 3, 2),
(25, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, '79108bc8-1681-473e-a6a1-cc67a976c18c', NULL, '015', '015', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 5, 3, 4, 2),
(26, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, 'ebf4f040-f334-46d8-9487-e62cb6527f23', NULL, '016', '016', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 6, 3, 5, 2),
(27, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, '86c2f545-de45-4314-9c75-38182277fb4b', NULL, '017', '017', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 7, 3, 6, 2),
(28, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, 'ecd8ac8c-6b37-4b38-b6cf-9c074515411a', NULL, '018', '018', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 8, 3, 7, 2),
(29, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, '9e47f365-781b-4aca-a519-deb3865827c7', NULL, '019', '019', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 9, 3, 8, 2),
(30, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, '9a4b9e88-c40f-4ab1-b192-3e59e1dee968', NULL, '020', '020', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 10, 3, 9, 2),
(31, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, 'd81f0680-bfd1-4a59-922b-4020839a556c', NULL, '021', '021', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 1, 4, 0, 3),
(32, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, 'd31739e6-077c-4fdd-b850-2cdb0996d72d', NULL, '022', '022', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 2, 4, 1, 3),
(33, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, 'c281a217-c287-4cea-8386-b4c7acec8b0c', NULL, '023', '023', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 3, 4, 2, 3),
(34, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, 'd3c1f1c6-57d0-4bc4-8423-177af47f9703', NULL, '024', '024', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 4, 4, 3, 3),
(35, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, 'd8272b4f-b472-4197-b2e7-b3c33a3a2ae9', NULL, '025', '025', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 5, 4, 4, 3),
(36, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, 'd1a682a0-d21d-404f-8b3a-1f70a0eb7afe', NULL, '026', '026', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 6, 4, 5, 3),
(37, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, '5dcf6605-72a2-4c97-90e3-a428cfc25bfd', NULL, '027', '027', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 7, 4, 6, 3),
(38, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, '0a075c0a-286c-4ccb-8f78-0f71fcd579fe', NULL, '028', '028', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 8, 4, 7, 3),
(39, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, 'c96008fd-d6d2-4904-b1de-20cef97e2ec6', NULL, '029', '029', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 9, 4, 8, 3),
(40, '2021-05-02 08:18:16', '2021-05-02 08:18:16', 2, 1, 2, 2, 2, NULL, 'e904d188-9dbd-4090-b3ff-0179826eb614', NULL, '030', '030', 'free', NULL, '2021-05-02 08:18:16', NULL, NULL, 10, 4, 9, 3),
(41, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, 'e74c74d0-581c-400e-8723-d7b7a030b76c', NULL, '031', '031', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 1, 6, 0, 5),
(42, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, 'f72c75cc-4028-4b7d-8ed4-3d1e85f22945', NULL, '032', '032', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 2, 6, 1, 5),
(43, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, '5b519469-e053-40d9-b5e8-70360490f72b', NULL, '033', '033', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 3, 6, 2, 5),
(44, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, '8c553fea-e221-489e-b824-dc0fc3664267', NULL, '034', '034', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 4, 6, 3, 5),
(45, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, '1a329bae-ae57-4a15-802d-8e28af4da57a', NULL, '035', '035', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 5, 6, 4, 5),
(46, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, '911423c3-0559-4750-8ba3-0d5580b8ab07', NULL, '036', '036', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 6, 6, 5, 5),
(47, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, '20edc705-22a7-4a3d-aaeb-115389f9831a', NULL, '037', '037', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 7, 6, 6, 5),
(48, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, '5466c7d3-4759-4f74-a78b-299c7696b48d', NULL, '038', '038', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 8, 6, 7, 5),
(49, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, '07077356-7e07-484b-86c6-9b33920e12d3', NULL, '039', '039', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 9, 6, 8, 5),
(50, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, '970ae278-4f95-4904-8ff7-c19970f59d12', NULL, '040', '040', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 10, 6, 9, 5),
(51, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, '2a33adc8-a147-4687-bfea-72b26f4926f0', NULL, '041', '041', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 1, 7, 0, 6),
(52, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, '38ce0001-4039-4196-990e-b6e7656b1bd4', NULL, '042', '042', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 2, 7, 1, 6),
(53, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, '45a98498-494b-47db-b576-8f44edcaef4b', NULL, '043', '043', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 3, 7, 2, 6),
(54, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, 'c586ba31-de4e-4c56-8581-74eb098d2487', NULL, '044', '044', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 4, 7, 3, 6),
(55, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, '3d032098-5f31-4263-b157-0bd46e2724bc', NULL, '045', '045', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 5, 7, 4, 6),
(56, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, '2a80f895-d99c-4e81-bb84-a6da4c20a8d4', NULL, '046', '046', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 6, 7, 5, 6),
(57, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, '420f4e1c-80ef-43db-9703-69a206ff8465', NULL, '047', '047', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 7, 7, 6, 6),
(58, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, '6c52472e-c9ee-42ed-b884-24c2b8984dd9', NULL, '048', '048', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 8, 7, 7, 6),
(59, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, 'e4e5fa48-5593-4d9e-830b-abc1d8b79334', NULL, '049', '049', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 9, 7, 8, 6),
(60, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, 'e8ea80c2-f91c-4a91-8399-9d31110e72c3', NULL, '050', '050', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 10, 7, 9, 6),
(61, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, 'a1084642-2fd5-4114-99da-7a6435f9a6d0', NULL, '051', '051', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 1, 9, 0, 8),
(62, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, '7b62da2d-abd9-43ba-b08b-d68fe64dd900', NULL, '052', '052', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 2, 9, 1, 8),
(63, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, 'cfece57d-efcf-4c20-a646-0ab9bba4db6f', NULL, '053', '053', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 3, 9, 2, 8),
(64, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, '07a119a0-6868-4bf6-9ae1-d3296057a705', NULL, '054', '054', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 4, 9, 3, 8),
(65, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, '3360efc4-3ac3-49b7-adc1-f5e7b9ed9093', NULL, '055', '055', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 5, 9, 4, 8),
(66, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, 'dfca3206-3b36-447f-9252-10a350aa7e85', NULL, '056', '056', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 6, 9, 5, 8),
(67, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, '33ac0440-264c-4398-9908-8e4a93f3c210', NULL, '057', '057', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 7, 9, 6, 8),
(68, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, '432024e1-cef6-4024-9eb9-188a0a5d3e75', NULL, '058', '058', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 8, 9, 7, 8),
(69, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, '318822f2-9be2-4e8b-83b3-afec6395c379', NULL, '059', '059', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 9, 9, 8, 8),
(70, '2021-05-02 08:18:17', '2021-05-02 08:18:17', 2, 1, 2, 2, 2, NULL, '979adf45-eac1-4c94-bdf7-95f3d966337a', NULL, '060', '060', 'free', NULL, '2021-05-02 08:18:17', NULL, NULL, 10, 9, 9, 8);

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
(1, '2021-05-02 08:18:16', '2021-05-02 08:18:16', NULL, '001', '123456'),
(2, '2021-05-02 08:18:16', '2021-05-02 08:18:16', NULL, '002', '654321');

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
(1, '2021-05-02 08:18:16', '2021-05-02 08:18:16', NULL, 'Fahrrad-Station Dortmund', NULL, 'fahrrad-station-dortmund', 'dortmund-1', 'dortmund-1', 'active', 365, '2021-05-02 08:18:16', NULL, NULL),
(2, '2021-05-02 08:18:16', '2021-05-02 08:18:16', NULL, 'Fahrrad-Station Bochum', NULL, 'fahrrad-station-bochum', 'bochum-1', 'bochum-1', 'active', 365, '2021-05-02 08:18:16', NULL, NULL);

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
(1, '2021-05-02 08:18:16', '2021-05-02 08:18:16', NULL, 'mail@ernestoruge.de', '$2b$12$/uNmC3ebGPwgsXgil3MnU.hR.H1WucoKJFbew1P/850yNi/eyr6s6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'binary butterfly GmbH', 'Am Hertinger Tor', '59423', 'Unna', 'DE', 'de', NULL, NULL, '[\"admin\"]');

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
-- Indizes für die Tabelle `operator`
--
ALTER TABLE `operator`
  ADD PRIMARY KEY (`id`),
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
-- Indizes für die Tabelle `resource`
--
ALTER TABLE `resource`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ix_resource_slug` (`slug`),
  ADD KEY `pricegroup_id` (`pricegroup_id`),
  ADD KEY `hardware_id` (`hardware_id`),
  ADD KEY `resource_group_id` (`resource_group_id`),
  ADD KEY `resource_access_id` (`resource_access_id`),
  ADD KEY `location_id` (`location_id`);

--
-- Indizes für die Tabelle `resource_access`
--
ALTER TABLE `resource_access`
  ADD PRIMARY KEY (`id`),
  ADD KEY `location_id` (`location_id`);

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
-- AUTO_INCREMENT für Tabelle `file`
--
ALTER TABLE `file`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `hardware`
--
ALTER TABLE `hardware`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `location`
--
ALTER TABLE `location`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `operator`
--
ALTER TABLE `operator`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
-- AUTO_INCREMENT für Tabelle `resource`
--
ALTER TABLE `resource`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

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
-- Constraints der Tabelle `location`
--
ALTER TABLE `location`
  ADD CONSTRAINT `location_ibfk_1` FOREIGN KEY (`photo_id`) REFERENCES `file` (`id`),
  ADD CONSTRAINT `location_ibfk_2` FOREIGN KEY (`operator_id`) REFERENCES `operator` (`id`);

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
-- Constraints der Tabelle `resource`
--
ALTER TABLE `resource`
  ADD CONSTRAINT `resource_ibfk_1` FOREIGN KEY (`pricegroup_id`) REFERENCES `pricegroup` (`id`),
  ADD CONSTRAINT `resource_ibfk_2` FOREIGN KEY (`hardware_id`) REFERENCES `hardware` (`id`),
  ADD CONSTRAINT `resource_ibfk_3` FOREIGN KEY (`resource_group_id`) REFERENCES `resource_group` (`id`),
  ADD CONSTRAINT `resource_ibfk_4` FOREIGN KEY (`resource_access_id`) REFERENCES `resource_access` (`id`),
  ADD CONSTRAINT `resource_ibfk_5` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`);

--
-- Constraints der Tabelle `resource_access`
--
ALTER TABLE `resource_access`
  ADD CONSTRAINT `resource_access_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`);

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
