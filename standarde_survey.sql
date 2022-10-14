-- phpMyAdmin SQL Dump
-- version 5.0.4deb2+deb11u1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 14, 2022 at 03:04 PM
-- Server version: 10.5.15-MariaDB-0+deb11u1
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `survey`
--

-- --------------------------------------------------------

--
-- Table structure for table `answer`
--

CREATE TABLE `answer` (
  `id` int(11) NOT NULL,
  `value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `answer`
--

INSERT INTO `answer` (`id`, `value`) VALUES
(1, 'Mahesh Traders 1'),
(2, 'GST1234567890'),
(3, '1'),
(4, 'Annapurna Kitchen'),
(5, 'GST456'),
(6, 'Doshi Enterprises'),
(7, 'GST42069123'),
(8, 'Satara');

--
-- Triggers `answer`
--
DELIMITER $$
CREATE TRIGGER `audit_trigger` BEFORE UPDATE ON `answer` FOR EACH ROW BEGIN
	INSERT INTO `audit` 
		(`version`, survey_id, question_id, answer_id, previous_value)
	SELECT 
		version_table.next_version, 
		`survey_answer`.`survey_id`, `survey_answer`.`question_id`, `survey_answer`.`answer_id`, `answer`.`value`
	FROM 
		`survey`.`survey_answer`
	INNER JOIN
		`survey`.`answer`
	on
		(`survey_answer`.`answer_id` = `answer`.`id`)
	CROSS JOIN
		(SELECT COUNT(survey_id) + 1 as next_version FROM audit WHERE answer_id = old.id) version_table
	Where 
		`survey_answer`.`survey_id` = (SELECT survey_id from `survey_answer` WHERE answer_id = old.id);

    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `audit`
--

CREATE TABLE `audit` (
  `id` int(11) NOT NULL,
  `version` int(11) NOT NULL DEFAULT 1,
  `survey_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `answer_id` int(11) NOT NULL,
  `previous_value` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `audit`
--

INSERT INTO `audit` (`id`, `version`, `survey_id`, `question_id`, `answer_id`, `previous_value`, `timestamp`) VALUES
(1, 1, 1, 1, 1, 'Mahesh Traders 1', '2022-10-11 09:41:50'),
(2, 1, 1, 2, 2, 'GST1234567890', '2022-10-11 09:41:50'),
(3, 1, 1, 3, 3, '1', '2022-10-11 09:41:50'),
(4, 2, 1, 1, 1, 'Mahesh Traders', '2022-10-11 09:42:01'),
(5, 2, 1, 2, 2, 'GST1234567890', '2022-10-11 09:42:01'),
(6, 2, 1, 3, 3, '1', '2022-10-11 09:42:01'),
(7, 1, 2, 1, 4, 'Annapurna Paripurna Kitchen', '2022-10-11 09:42:28'),
(8, 1, 2, 2, 5, 'GST456', '2022-10-11 09:42:28'),
(10, 1, 6, 1, 6, 'Doshi Enterprises', '2022-10-12 14:21:34'),
(11, 1, 6, 2, 7, 'GST42069', '2022-10-12 14:21:34'),
(12, 1, 6, 4, 8, 'Satara', '2022-10-12 14:21:34');

-- --------------------------------------------------------

--
-- Table structure for table `choice`
--

CREATE TABLE `choice` (
  `id` int(11) NOT NULL,
  `choice` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `choice`
--

INSERT INTO `choice` (`id`, `choice`) VALUES
(1, 'Pune'),
(2, 'Nagpur'),
(3, 'Banglore'),
(4, 'Satara'),
(5, 'MH'),
(6, 'KA'),
(7, 'MH'),
(8, 'KA');

-- --------------------------------------------------------

--
-- Table structure for table `question`
--

CREATE TABLE `question` (
  `id` int(11) NOT NULL,
  `question` text NOT NULL,
  `type` enum('image','text','number','boolean','single_select') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `question`
--

INSERT INTO `question` (`id`, `question`, `type`) VALUES
(1, 'Legal name of the entity ?', 'text'),
(2, 'GST Number?', 'text'),
(3, 'Does the shop have glass facade?', 'boolean'),
(4, 'Which city ?', 'single_select'),
(5, 'What is your name?', 'text'),
(6, 'Which State?', 'single_select'),
(7, 'What is your name?', 'text'),
(8, 'Which State?', 'single_select');

-- --------------------------------------------------------

--
-- Table structure for table `question_choice`
--

CREATE TABLE `question_choice` (
  `id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `choice_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `question_choice`
--

INSERT INTO `question_choice` (`id`, `question_id`, `choice_id`) VALUES
(1, 4, 1),
(2, 4, 2),
(3, 4, 3),
(4, 4, 4),
(5, 6, 5),
(6, 6, 6),
(7, 8, 7),
(8, 8, 8);

-- --------------------------------------------------------

--
-- Table structure for table `schema`
--

CREATE TABLE `schema` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `schema`
--

INSERT INTO `schema` (`id`, `name`) VALUES
(1, 'shop_survey'),
(2, 'hotel_survey'),
(3, 'Person survey'),
(4, 'Person survey 2');

-- --------------------------------------------------------

--
-- Table structure for table `schema_question`
--

CREATE TABLE `schema_question` (
  `id` int(11) NOT NULL,
  `schema_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `schema_question`
--

INSERT INTO `schema_question` (`id`, `schema_id`, `question_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 2, 1),
(5, 2, 2),
(6, 1, 4),
(7, 2, 4),
(8, 3, 5),
(9, 4, 7),
(10, 4, 8);

-- --------------------------------------------------------

--
-- Table structure for table `survey`
--

CREATE TABLE `survey` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `survey`
--

INSERT INTO `survey` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'First survey', '2022-10-12 07:34:32', '2022-10-12 07:35:04'),
(2, 'Second survey', '2022-10-12 07:34:32', '2022-10-12 07:35:18'),
(3, 'Third survey', '2022-10-12 07:35:27', '2022-10-12 07:35:53'),
(4, 'Forth Survey', '2022-10-12 07:37:07', '2022-10-12 07:37:07'),
(6, 'Doshi Enterprises', '2022-10-12 10:10:07', '2022-10-12 10:10:07');

-- --------------------------------------------------------

--
-- Table structure for table `survey_answer`
--

CREATE TABLE `survey_answer` (
  `id` int(11) NOT NULL,
  `survey_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `answer_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `survey_answer`
--

INSERT INTO `survey_answer` (`id`, `survey_id`, `question_id`, `answer_id`) VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 1, 3, 3),
(4, 2, 1, 4),
(5, 2, 2, 5),
(6, 6, 1, 6),
(7, 6, 2, 7),
(8, 6, 4, 8);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `answer`
--
ALTER TABLE `answer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `audit`
--
ALTER TABLE `audit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `survey_id` (`survey_id`),
  ADD KEY `question_id` (`question_id`),
  ADD KEY `answer_id` (`answer_id`);

--
-- Indexes for table `choice`
--
ALTER TABLE `choice`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `question_choice`
--
ALTER TABLE `question_choice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_id` (`question_id`),
  ADD KEY `choice_id` (`choice_id`);

--
-- Indexes for table `schema`
--
ALTER TABLE `schema`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `schema_question`
--
ALTER TABLE `schema_question`
  ADD PRIMARY KEY (`id`),
  ADD KEY `schema_id` (`schema_id`),
  ADD KEY `question_id` (`question_id`);

--
-- Indexes for table `survey`
--
ALTER TABLE `survey`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `survey_answer`
--
ALTER TABLE `survey_answer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `survey_id` (`survey_id`),
  ADD KEY `question_id` (`question_id`),
  ADD KEY `answer_id` (`answer_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `answer`
--
ALTER TABLE `answer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `audit`
--
ALTER TABLE `audit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `choice`
--
ALTER TABLE `choice`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `question`
--
ALTER TABLE `question`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `question_choice`
--
ALTER TABLE `question_choice`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `schema`
--
ALTER TABLE `schema`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `schema_question`
--
ALTER TABLE `schema_question`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `survey`
--
ALTER TABLE `survey`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `survey_answer`
--
ALTER TABLE `survey_answer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit`
--
ALTER TABLE `audit`
  ADD CONSTRAINT `audit_ibfk_1` FOREIGN KEY (`survey_id`) REFERENCES `survey_answer` (`survey_id`),
  ADD CONSTRAINT `audit_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `survey_answer` (`question_id`),
  ADD CONSTRAINT `audit_ibfk_3` FOREIGN KEY (`answer_id`) REFERENCES `survey_answer` (`answer_id`);

--
-- Constraints for table `question_choice`
--
ALTER TABLE `question_choice`
  ADD CONSTRAINT `question_choice_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`),
  ADD CONSTRAINT `question_choice_ibfk_2` FOREIGN KEY (`choice_id`) REFERENCES `choice` (`id`);

--
-- Constraints for table `schema_question`
--
ALTER TABLE `schema_question`
  ADD CONSTRAINT `schema_question_ibfk_1` FOREIGN KEY (`schema_id`) REFERENCES `schema` (`id`),
  ADD CONSTRAINT `schema_question_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`);

--
-- Constraints for table `survey_answer`
--
ALTER TABLE `survey_answer`
  ADD CONSTRAINT `survey_answer_ibfk_1` FOREIGN KEY (`survey_id`) REFERENCES `survey` (`id`),
  ADD CONSTRAINT `survey_answer_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`),
  ADD CONSTRAINT `survey_answer_ibfk_3` FOREIGN KEY (`answer_id`) REFERENCES `answer` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
