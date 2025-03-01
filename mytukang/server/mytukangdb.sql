-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 01, 2025 at 01:07 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mytukangdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_tukangs`
--

CREATE TABLE `tbl_tukangs` (
  `tukang_id` int(5) NOT NULL,
  `tukang_name` varchar(100) NOT NULL,
  `tukang_field` varchar(50) NOT NULL,
  `tukang_desc` varchar(600) NOT NULL,
  `tukang_phone` varchar(15) NOT NULL,
  `tukang_email` varchar(50) NOT NULL,
  `tukang_location` varchar(50) NOT NULL,
  `tukang_datereg` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `tukang_otp` varchar(5) NOT NULL,
  `tukang_pass` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_tukangs`
--

INSERT INTO `tbl_tukangs` (`tukang_id`, `tukang_name`, `tukang_field`, `tukang_desc`, `tukang_phone`, `tukang_email`, `tukang_location`, `tukang_datereg`, `tukang_otp`, `tukang_pass`) VALUES
(1, 'Abu Kassim', 'Plumber', '5 years experience with plumbing and able to work on call.', '0133323223', 'abukasim@email.com', 'Kuala Muda', '2025-02-08 10:58:49.277824', '25641', '7e2f0296bb115846158ba4a9370c19e564f0042e'),
(3, 'Azman Hadi', 'Painter', '3 years paint experience working in construction', '0133325554', 'azman@email.com', 'Kuala Muda', '2025-02-08 11:10:10.908986', '74818', 'd69ce09268b7a2397dd8fdb527ad007703e8d4dd'),
(4, 'Ah Cong', 'Cook', '5 years restaurant experience as cook.', '0145554433', 'acong@email.com', 'Baling', '2025-02-08 11:13:36.311323', '30895', '4dd547824840341f05896332d8f3b8f59a3af915'),
(5, 'Joe Labu', 'Mechanic', '5 years experience in continental car.', '0154445523', 'joelabu@email.com', 'Pendang', '2025-02-15 09:39:08.239238', '89796', 'b76c7f1cb54af11169301e0bdda6ca1332abd1f6'),
(6, 'John Steward', 'Plumber', '5 Years experience in plumbing construction', '0155544456', 'john@email.com', 'Pokok Sena', '2025-02-15 09:54:48.231970', '46093', 'ae7281b1522cfc16dbdcf0c3325472e75eebe86e');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_tukangs`
--
ALTER TABLE `tbl_tukangs`
  ADD PRIMARY KEY (`tukang_id`),
  ADD UNIQUE KEY `tukang_email` (`tukang_email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_tukangs`
--
ALTER TABLE `tbl_tukangs`
  MODIFY `tukang_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
