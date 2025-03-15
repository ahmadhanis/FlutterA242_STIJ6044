-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 15, 2025 at 12:03 PM
-- Server version: 10.3.39-MariaDB-cll-lve
-- PHP Version: 8.1.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `slumber6_mytukangdb`
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
  `tukang_pass` varchar(40) NOT NULL,
  `tukang_rating` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_tukangs`
--

INSERT INTO `tbl_tukangs` (`tukang_id`, `tukang_name`, `tukang_field`, `tukang_desc`, `tukang_phone`, `tukang_email`, `tukang_location`, `tukang_datereg`, `tukang_otp`, `tukang_pass`, `tukang_rating`) VALUES
(3, 'Azman Hadi', 'Painter', '3 years paint experience working in construction', '0133325554', 'azman@email.com', 'Kuala Muda', '2025-02-08 11:10:10.908986', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 3),
(4, 'Ah Cong', 'Cook', '5 years restaurant experience as cook.', '0145554433', 'acong@email.com', 'Baling', '2025-02-08 11:13:36.311323', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 3),
(5, 'Joe Labu', 'Mechanic', '5 years experience in continental car.', '0154445523', 'joelabu@email.com', 'Pendang', '2025-02-15 09:39:08.239238', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 2),
(6, 'John Steward', 'Plumber', '5 Years experience in plumbing construction', '0155544456', 'john@email.com', 'Pokok Sena', '2025-02-15 09:54:48.231970', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 3),
(7, 'Singh Singam', 'Builder', '10 year experience in building and supervising. ', '01554445552', 'singh@email.com', 'Padang Terap', '2025-03-01 08:25:09.547679', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(8, 'Pn Mahani Ahmad', 'Cook', '5 years restaurant experience. Malay or English cooking.', '0125554458', 'mahani@email.com', 'Kulim', '2025-03-01 09:14:28.016129', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(9, 'Ahmad Albab', 'Plumber', '5 years plumbing experience ', '0177754458', 'albab@email.com', 'Pendang', '2025-03-01 09:17:01.008000', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(10, 'Ahmad Bin Ali', 'Plumber', 'Expert in fixing leaks and installing pipes.', '0123456789', 'ahmadbinali@email.com', 'Kota Setar', '2025-03-01 09:43:17.818381', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 4),
(11, 'Siti Aminah', 'Electrician', 'Skilled electrician with expertise in wiring and repairs.', '0167890123', 'sitiaminah@email.com', 'Bandar Baharu', '2025-03-01 09:43:17.828774', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(12, 'Lim Wei', 'Gardener', 'Passionate about creating beautiful landscapes and gardens.', '0134567890', 'limwei@email.com', 'Kulim', '2025-03-01 09:43:17.834258', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 5),
(13, 'Tan Mei Ling', 'Painter', 'Creative painter delivering vibrant and lasting finishes.', '0198765432', 'tanmeiling@email.com', 'Langkawi', '2025-03-01 09:43:17.840291', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(14, 'Roslan', 'Cleaner', 'Reliable cleaner with attention to detail and efficiency.', '0129876543', 'roslan@email.com', 'Pendang', '2025-03-01 09:43:17.846005', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(15, 'Noraini', 'Cook', 'Talented cook known for delicious and authentic meals.', '0171234567', 'noraini@email.com', 'Sik', '2025-03-01 09:43:17.852291', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(16, 'Suresh Kumar', 'Driver', 'Professional driver with a clean record and punctual service.', '0162345678', 'sureshkumar@email.com', 'Yan', '2025-03-01 09:43:17.858065', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(17, 'Vijay Kumar', 'Builder', 'Experienced builder skilled in constructing durable structures.', '0156781234', 'vijaykumar@email.com', 'Pokok Sena', '2025-03-01 09:43:17.863616', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(18, 'Zainal Abidin', 'Carpenter', 'Detail-oriented carpenter specializing in custom woodwork.', '0181234567', 'zainalabidin@email.com', 'Padang Terap', '2025-03-01 09:43:17.869660', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(19, 'Hasniza', 'Mechanic', 'Seasoned mechanic who ensures smooth vehicle performance.', '0123344556', 'hasniza@email.com', 'Kubang Pasu', '2025-03-01 09:43:17.875450', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(20, 'Rahimah Rahim', 'Caterer', 'Dedicated caterer providing exceptional service for events.', '0139988776', 'rahimah@email.com', 'Kuala Muda', '2025-03-01 09:43:17.881452', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(21, 'Kumar Subramaniam', 'Other', 'Versatile worker capable of handling a variety of tasks.', '0161122334', 'kumarsubramaniam@email.com', 'Baling', '2025-03-01 09:43:17.887878', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(22, 'Lee Chong Wei', 'Plumber', 'Expert in fixing leaks and installing pipes.', '0174455667', 'leechong@email.com', 'Pokok Sena', '2025-03-01 09:43:17.893967', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(23, 'Faridah', 'Electrician', 'Skilled electrician with expertise in wiring and repairs.', '0192233445', 'faridah@email.com', 'Kulim', '2025-03-01 09:43:17.900367', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(24, 'Ramesh Singh', 'Gardener', 'Passionate about creating beautiful landscapes and gardens.', '0125566778', 'rameshsingh@email.com', 'Langkawi', '2025-03-01 09:43:17.906213', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 4),
(25, 'Anita Devi', 'Painter', 'Creative painter delivering vibrant and lasting finishes.', '0136677889', 'anitadevi@email.com', 'Kota Setar', '2025-03-01 09:43:17.912188', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(26, 'Mohammed Idris', 'Cleaner', 'Reliable cleaner with attention to detail and efficiency.', '0167788990', 'mohammedidris@email.com', 'Bandar Baharu', '2025-03-01 09:43:17.918704', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(27, 'Chong Li', 'Cook', 'Talented cook known for delicious and authentic meals.', '0158899001', 'chongli@email.com', 'Kubang Pasu', '2025-03-01 09:43:17.925026', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(28, 'Lai Mei', 'Driver', 'Professional driver with a clean record and punctual service.', '0179900112', 'laimei@email.com', 'Padang Terap', '2025-03-01 09:43:17.930687', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(29, 'Gopal Raj', 'Builder', 'Experienced builder skilled in constructing durable structures.', '0181011121', 'gopalraj@email.com', 'Pendang', '2025-03-01 09:43:17.939257', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(30, 'Aminah', 'Carpenter', 'Detail-oriented carpenter specializing in custom woodwork.', '0121212121', 'aminah@email.com', 'Sik', '2025-03-01 09:43:17.945231', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(31, 'Faizal Rahman', 'Mechanic', 'Seasoned mechanic who ensures smooth vehicle performance.', '0132323232', 'faizalrahman@email.com', 'Yan', '2025-03-01 09:43:17.951256', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(32, 'Ibrahim', 'Caterer', 'Dedicated caterer providing exceptional service for events.', '0163434343', 'ibrahim@email.com', 'Pokok Sena', '2025-03-01 09:43:17.956999', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(33, 'Jasmine Tan', 'Other', 'Versatile worker capable of handling a variety of tasks.', '0154545454', 'jasminetan@email.com', 'Kuala Muda', '2025-03-01 09:43:17.962646', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 5),
(34, 'Syed Omar', 'Plumber', 'Expert in fixing leaks and installing pipes.', '0195656565', 'syedomar@email.com', 'Baling', '2025-03-01 09:43:17.968371', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 2),
(35, 'Chen Xi', 'Electrician', 'Skilled electrician with expertise in wiring and repairs.', '0126767676', 'chenxi@email.com', 'All', '2025-03-01 09:43:17.974060', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(36, 'Puteri Aisyah', 'Gardener', 'Passionate about creating beautiful landscapes and gardens.', '0137878787', 'puteriaisyah@email.com', 'Kulim', '2025-03-01 09:43:17.980478', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 3),
(37, 'Arumugam', 'Painter', 'Creative painter delivering vibrant and lasting finishes.', '0168989898', 'arumugam@email.com', 'Langkawi', '2025-03-01 09:43:17.986325', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(38, 'Siti Nur', 'Cleaner', 'Reliable cleaner with attention to detail and efficiency.', '0159090909', 'sitinur@email.com', 'Kota Setar', '2025-03-01 09:43:17.992502', '0', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 0),
(41, 'Ahmad Hanis', 'Plumber', '3 years with cert', '0194702493', 'slumberjer@gmail.com', 'Pendang', '2025-03-15 11:41:03.084570', '0', '54316813a7fad93a570987af8875381168711bb3', 3);

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
  MODIFY `tukang_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
