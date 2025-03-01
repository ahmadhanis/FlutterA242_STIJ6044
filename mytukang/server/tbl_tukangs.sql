-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 01, 2025 at 04:11 AM
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
(3, 'Azman Hadi', 'Painter', '3 years paint experience working in construction', '0133325554', 'azman@email.com', 'Kuala Muda', '2025-02-08 11:10:10.908986', '74818', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(4, 'Ah Cong', 'Cook', '5 years restaurant experience as cook.', '0145554433', 'acong@email.com', 'Baling', '2025-02-08 11:13:36.311323', '30895', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(5, 'Joe Labu', 'Mechanic', '5 years experience in continental car.', '0154445523', 'joelabu@email.com', 'Pendang', '2025-02-15 09:39:08.239238', '89796', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(6, 'John Steward', 'Plumber', '5 Years experience in plumbing construction', '0155544456', 'john@email.com', 'Pokok Sena', '2025-02-15 09:54:48.231970', '46093', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(7, 'Singh Singam', 'Builder', '10 year experience in building and supervising. ', '01554445552', 'singh@email.com', 'Padang Terap', '2025-03-01 08:25:09.547679', '42110', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(8, 'Pn Mahani', 'Cook', '5 years restaurant experience.', '0125554458', 'mahani@email.com', 'Bandar Baharu', '2025-03-01 09:14:28.016129', '37810', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(9, 'Ahmad Albab', 'Plumber', '5 years plumbing experience ', '0177754458', 'albab@email.com', 'Pendang', '2025-03-01 09:17:01.008000', '15032', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(10, 'Ahmad Bin Ali', 'Plumber', 'Expert in fixing leaks and installing pipes.', '0123456789', 'ahmadbinali@email.com', 'Kota Setar', '2025-03-01 09:43:17.818381', '12345', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(11, 'Siti Aminah', 'Electrician', 'Skilled electrician with expertise in wiring and repairs.', '0167890123', 'sitiaminah@email.com', 'Bandar Baharu', '2025-03-01 09:43:17.828774', '23456', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(12, 'Lim Wei', 'Gardener', 'Passionate about creating beautiful landscapes and gardens.', '0134567890', 'limwei@email.com', 'Kulim', '2025-03-01 09:43:17.834258', '34567', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(13, 'Tan Mei Ling', 'Painter', 'Creative painter delivering vibrant and lasting finishes.', '0198765432', 'tanmeiling@email.com', 'Langkawi', '2025-03-01 09:43:17.840291', '45678', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(14, 'Roslan', 'Cleaner', 'Reliable cleaner with attention to detail and efficiency.', '0129876543', 'roslan@email.com', 'Pendang', '2025-03-01 09:43:17.846005', '56789', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(15, 'Noraini', 'Cook', 'Talented cook known for delicious and authentic meals.', '0171234567', 'noraini@email.com', 'Sik', '2025-03-01 09:43:17.852291', '67890', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(16, 'Suresh Kumar', 'Driver', 'Professional driver with a clean record and punctual service.', '0162345678', 'sureshkumar@email.com', 'Yan', '2025-03-01 09:43:17.858065', '78901', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(17, 'Vijay Kumar', 'Builder', 'Experienced builder skilled in constructing durable structures.', '0156781234', 'vijaykumar@email.com', 'Pokok Sena', '2025-03-01 09:43:17.863616', '89012', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(18, 'Zainal Abidin', 'Carpenter', 'Detail-oriented carpenter specializing in custom woodwork.', '0181234567', 'zainalabidin@email.com', 'Padang Terap', '2025-03-01 09:43:17.869660', '90123', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(19, 'Hasniza', 'Mechanic', 'Seasoned mechanic who ensures smooth vehicle performance.', '0123344556', 'hasniza@email.com', 'Kubang Pasu', '2025-03-01 09:43:17.875450', '11223', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(20, 'Rahimah', 'Caterer', 'Dedicated caterer providing exceptional service for events.', '0139988776', 'rahimah@email.com', 'Kuala Muda', '2025-03-01 09:43:17.881452', '22334', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(21, 'Kumar Subramaniam', 'Other', 'Versatile worker capable of handling a variety of tasks.', '0161122334', 'kumarsubramaniam@email.com', 'Baling', '2025-03-01 09:43:17.887878', '33445', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(22, 'Lee Chong', 'Plumber', 'Expert in fixing leaks and installing pipes.', '0174455667', 'leechong@email.com', 'All', '2025-03-01 09:43:17.893967', '44556', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(23, 'Faridah', 'Electrician', 'Skilled electrician with expertise in wiring and repairs.', '0192233445', 'faridah@email.com', 'Kulim', '2025-03-01 09:43:17.900367', '55667', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(24, 'Ramesh Singh', 'Gardener', 'Passionate about creating beautiful landscapes and gardens.', '0125566778', 'rameshsingh@email.com', 'Langkawi', '2025-03-01 09:43:17.906213', '66778', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(25, 'Anita Devi', 'Painter', 'Creative painter delivering vibrant and lasting finishes.', '0136677889', 'anitadevi@email.com', 'Kota Setar', '2025-03-01 09:43:17.912188', '77889', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(26, 'Mohammed Idris', 'Cleaner', 'Reliable cleaner with attention to detail and efficiency.', '0167788990', 'mohammedidris@email.com', 'Bandar Baharu', '2025-03-01 09:43:17.918704', '88990', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(27, 'Chong Li', 'Cook', 'Talented cook known for delicious and authentic meals.', '0158899001', 'chongli@email.com', 'Kubang Pasu', '2025-03-01 09:43:17.925026', '99001', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(28, 'Lai Mei', 'Driver', 'Professional driver with a clean record and punctual service.', '0179900112', 'laimei@email.com', 'Padang Terap', '2025-03-01 09:43:17.930687', '10112', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(29, 'Gopal Raj', 'Builder', 'Experienced builder skilled in constructing durable structures.', '0181011121', 'gopalraj@email.com', 'Pendang', '2025-03-01 09:43:17.939257', '12131', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(30, 'Aminah', 'Carpenter', 'Detail-oriented carpenter specializing in custom woodwork.', '0121212121', 'aminah@email.com', 'Sik', '2025-03-01 09:43:17.945231', '13141', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(31, 'Faizal Rahman', 'Mechanic', 'Seasoned mechanic who ensures smooth vehicle performance.', '0132323232', 'faizalrahman@email.com', 'Yan', '2025-03-01 09:43:17.951256', '14151', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(32, 'Ibrahim', 'Caterer', 'Dedicated caterer providing exceptional service for events.', '0163434343', 'ibrahim@email.com', 'Pokok Sena', '2025-03-01 09:43:17.956999', '15161', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(33, 'Jasmine Tan', 'Other', 'Versatile worker capable of handling a variety of tasks.', '0154545454', 'jasminetan@email.com', 'Kuala Muda', '2025-03-01 09:43:17.962646', '16171', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(34, 'Syed Omar', 'Plumber', 'Expert in fixing leaks and installing pipes.', '0195656565', 'syedomar@email.com', 'Baling', '2025-03-01 09:43:17.968371', '17181', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(35, 'Chen Xi', 'Electrician', 'Skilled electrician with expertise in wiring and repairs.', '0126767676', 'chenxi@email.com', 'All', '2025-03-01 09:43:17.974060', '18191', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(36, 'Puteri Aisyah', 'Gardener', 'Passionate about creating beautiful landscapes and gardens.', '0137878787', 'puteriaisyah@email.com', 'Kulim', '2025-03-01 09:43:17.980478', '19201', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(37, 'Arumugam', 'Painter', 'Creative painter delivering vibrant and lasting finishes.', '0168989898', 'arumugam@email.com', 'Langkawi', '2025-03-01 09:43:17.986325', '20212', '6367c48dd193d56ea7b0baad25b19455e529f5ee'),
(38, 'Siti Nur', 'Cleaner', 'Reliable cleaner with attention to detail and efficiency.', '0159090909', 'sitinur@email.com', 'Kota Setar', '2025-03-01 09:43:17.992502', '21222', '6367c48dd193d56ea7b0baad25b19455e529f5ee');

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
  MODIFY `tukang_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
