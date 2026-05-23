-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 23, 2026 at 11:19 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wsu_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `course_id` int(11) NOT NULL,
  `course_code` varchar(20) NOT NULL,
  `course_name` varchar(100) NOT NULL,
  `credit_hours` int(11) NOT NULL,
  `department` varchar(100) NOT NULL,
  `year_level` int(11) DEFAULT 1,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`course_id`, `course_code`, `course_name`, `credit_hours`, `department`, `year_level`, `created_date`) VALUES
(1, 'CS101', 'Introduction to Programming', 3, 'Computer Science', 1, '2026-05-16 21:01:12'),
(2, 'CS102', 'Object Oriented Programming', 3, 'Computer Science', 1, '2026-05-16 21:01:12'),
(3, 'CS201', 'Data Structures and Algorithms', 4, 'Computer Science', 2, '2026-05-16 21:01:12'),
(4, 'CS202', 'Database Systems', 4, 'Computer Science', 2, '2026-05-16 21:01:12'),
(5, 'CS203', 'Computer Architecture', 3, 'Computer Science', 2, '2026-05-16 21:01:12'),
(6, 'CS301', 'Web Development', 3, 'Computer Science', 3, '2026-05-16 21:01:12'),
(7, 'CS302', 'Operating Systems', 4, 'Computer Science', 3, '2026-05-16 21:01:12'),
(8, 'CS401', 'Software Engineering', 4, 'Computer Science', 4, '2026-05-16 21:01:12'),
(9, 'SE101', 'Programming Fundamentals', 3, 'Software Engineering', 1, '2026-05-16 21:01:12'),
(10, 'SE102', 'Object Oriented Analysis', 3, 'Software Engineering', 1, '2026-05-16 21:01:12'),
(11, 'SE201', 'Software Requirements Engineering', 3, 'Software Engineering', 2, '2026-05-16 21:01:12'),
(12, 'SE202', 'Software Design and Architecture', 4, 'Software Engineering', 2, '2026-05-16 21:01:12'),
(13, 'SE203', 'Database Design', 3, 'Software Engineering', 2, '2026-05-16 21:01:12'),
(14, 'SE301', 'Software Testing and Quality', 3, 'Software Engineering', 3, '2026-05-16 21:01:12'),
(15, 'SE302', 'Mobile App Development', 3, 'Software Engineering', 3, '2026-05-16 21:01:12'),
(16, 'SE401', 'Software Project Management', 4, 'Software Engineering', 4, '2026-05-16 21:01:12'),
(17, 'IT101', 'IT Fundamentals', 3, 'Information Technology', 1, '2026-05-16 21:01:12'),
(18, 'IT102', 'Introduction to Computing', 3, 'Information Technology', 1, '2026-05-16 21:01:12'),
(19, 'IT201', 'Network Administration', 4, 'Information Technology', 2, '2026-05-16 21:01:12'),
(20, 'IT202', 'System Analysis and Design', 3, 'Information Technology', 2, '2026-05-16 21:01:12'),
(21, 'IT203', 'IT Infrastructure', 3, 'Information Technology', 2, '2026-05-16 21:01:12'),
(22, 'IT301', 'Information Security', 3, 'Information Technology', 3, '2026-05-16 21:01:12'),
(23, 'IT302', 'Cloud Computing', 3, 'Information Technology', 3, '2026-05-16 21:01:12'),
(24, 'IT401', 'IT Capstone Project', 4, 'Information Technology', 4, '2026-05-16 21:01:12'),
(25, 'EE101', 'Circuit Analysis I', 3, 'Electrical Engineering', 1, '2026-05-16 21:01:12'),
(26, 'EE102', 'Circuit Analysis II', 3, 'Electrical Engineering', 1, '2026-05-16 21:01:12'),
(27, 'EE201', 'Electronics I', 4, 'Electrical Engineering', 2, '2026-05-16 21:01:12'),
(28, 'EE202', 'Electronics II', 4, 'Electrical Engineering', 2, '2026-05-16 21:01:12'),
(29, 'EE203', 'Digital Logic Design', 3, 'Electrical Engineering', 2, '2026-05-16 21:01:12'),
(30, 'EE301', 'Power Systems', 4, 'Electrical Engineering', 3, '2026-05-16 21:01:12'),
(31, 'EE302', 'Electrical Machines', 4, 'Electrical Engineering', 3, '2026-05-16 21:01:12'),
(32, 'EE401', 'Renewable Energy Systems', 3, 'Electrical Engineering', 4, '2026-05-16 21:01:12'),
(33, 'CE101', 'Engineering Drawing', 3, 'Civil Engineering', 1, '2026-05-16 21:01:12'),
(34, 'CE102', 'Engineering Mechanics', 3, 'Civil Engineering', 1, '2026-05-16 21:01:12'),
(35, 'CE201', 'Structural Analysis I', 4, 'Civil Engineering', 2, '2026-05-16 21:01:12'),
(36, 'CE202', 'Structural Analysis II', 4, 'Civil Engineering', 2, '2026-05-16 21:01:12'),
(37, 'CE203', 'Fluid Mechanics', 3, 'Civil Engineering', 2, '2026-05-16 21:01:12'),
(38, 'CE301', 'Construction Management', 3, 'Civil Engineering', 3, '2026-05-16 21:01:12'),
(39, 'CE302', 'Geotechnical Engineering', 4, 'Civil Engineering', 3, '2026-05-16 21:01:12'),
(40, 'CE401', 'Hydraulics and Hydrology', 3, 'Civil Engineering', 4, '2026-05-16 21:01:12'),
(41, 'ME101', 'Engineering Drawing', 3, 'Mechanical Engineering', 1, '2026-05-16 21:01:12'),
(42, 'ME102', 'Engineering Mechanics', 3, 'Mechanical Engineering', 1, '2026-05-16 21:01:12'),
(43, 'ME201', 'Thermodynamics I', 4, 'Mechanical Engineering', 2, '2026-05-16 21:01:12'),
(44, 'ME202', 'Thermodynamics II', 4, 'Mechanical Engineering', 2, '2026-05-16 21:01:12'),
(45, 'ME203', 'Fluid Mechanics', 3, 'Mechanical Engineering', 2, '2026-05-16 21:01:12'),
(46, 'ME301', 'Heat Transfer', 4, 'Mechanical Engineering', 3, '2026-05-16 21:01:12'),
(47, 'ME302', 'Machine Design', 4, 'Mechanical Engineering', 3, '2026-05-16 21:01:12'),
(48, 'ME401', 'Manufacturing Processes', 3, 'Mechanical Engineering', 4, '2026-05-16 21:01:12'),
(49, 'CHE101', 'General Chemistry', 3, 'Chemical Engineering', 1, '2026-05-16 21:01:12'),
(50, 'CHE102', 'Organic Chemistry', 3, 'Chemical Engineering', 1, '2026-05-16 21:01:12'),
(51, 'CHE201', 'Material Science', 3, 'Chemical Engineering', 2, '2026-05-16 21:01:12'),
(52, 'CHE202', 'Chemical Thermodynamics', 4, 'Chemical Engineering', 2, '2026-05-16 21:01:12'),
(53, 'CHE203', 'Fluid Mechanics', 3, 'Chemical Engineering', 2, '2026-05-16 21:01:12'),
(54, 'CHE301', 'Heat and Mass Transfer', 4, 'Chemical Engineering', 3, '2026-05-16 21:01:12'),
(55, 'CHE302', 'Chemical Reaction Engineering', 4, 'Chemical Engineering', 3, '2026-05-16 21:01:12'),
(56, 'CHE401', 'Plant Design', 4, 'Chemical Engineering', 4, '2026-05-16 21:01:12'),
(57, 'AF101', 'Principles of Accounting I', 3, 'Accounting and Finance', 1, '2026-05-16 21:01:12'),
(58, 'AF102', 'Principles of Accounting II', 3, 'Accounting and Finance', 1, '2026-05-16 21:01:12'),
(59, 'AF201', 'Financial Accounting', 3, 'Accounting and Finance', 2, '2026-05-16 21:01:12'),
(60, 'AF202', 'Managerial Accounting', 3, 'Accounting and Finance', 2, '2026-05-16 21:01:12'),
(61, 'AF203', 'Corporate Finance', 3, 'Accounting and Finance', 2, '2026-05-16 21:01:12'),
(62, 'AF301', 'Auditing Principles', 3, 'Accounting and Finance', 3, '2026-05-16 21:01:12'),
(63, 'AF302', 'Taxation', 3, 'Accounting and Finance', 3, '2026-05-16 21:01:12'),
(64, 'AF401', 'Financial Risk Management', 3, 'Accounting and Finance', 4, '2026-05-16 21:01:12'),
(65, 'MM101', 'Principles of Marketing', 3, 'Marketing Management', 1, '2026-05-16 21:01:12'),
(66, 'MM102', 'Consumer Behavior', 3, 'Marketing Management', 1, '2026-05-16 21:01:12'),
(67, 'MM201', 'Marketing Research', 3, 'Marketing Management', 2, '2026-05-16 21:01:12'),
(68, 'MM202', 'Advertising and Promotion', 3, 'Marketing Management', 2, '2026-05-16 21:01:12'),
(69, 'MM203', 'Sales Management', 3, 'Marketing Management', 2, '2026-05-16 21:01:12'),
(70, 'MM301', 'Digital Marketing', 3, 'Marketing Management', 3, '2026-05-16 21:01:12'),
(71, 'MM302', 'International Marketing', 3, 'Marketing Management', 3, '2026-05-16 21:01:12'),
(72, 'MM401', 'Strategic Marketing', 4, 'Marketing Management', 4, '2026-05-16 21:01:12'),
(73, 'PH101', 'Introduction to Public Health', 3, 'Public Health', 1, '2026-05-16 21:01:12'),
(74, 'PH102', 'Health Education', 3, 'Public Health', 1, '2026-05-16 21:01:12'),
(75, 'PH201', 'Epidemiology I', 3, 'Public Health', 2, '2026-05-16 21:01:12'),
(76, 'PH202', 'Biostatistics', 3, 'Public Health', 2, '2026-05-16 21:01:12'),
(77, 'PH203', 'Health Policy and Management', 3, 'Public Health', 2, '2026-05-16 21:01:12'),
(78, 'PH301', 'Environmental Health', 3, 'Public Health', 3, '2026-05-16 21:01:12'),
(79, 'PH302', 'Maternal and Child Health', 3, 'Public Health', 3, '2026-05-16 21:01:12'),
(80, 'PH401', 'Health Program Evaluation', 4, 'Public Health', 4, '2026-05-16 21:01:12');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `dept_id` int(11) NOT NULL,
  `dept_name` varchar(100) NOT NULL,
  `dept_code` varchar(10) NOT NULL,
  `faculty` varchar(100) NOT NULL,
  `established_year` int(11) DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`dept_id`, `dept_name`, `dept_code`, `faculty`, `established_year`, `created_date`) VALUES
(1, 'Computer Science', 'CS', 'Natural and Computational Science', 2010, '2026-05-16 21:01:11'),
(2, 'Software Engineering', 'SE', 'Natural and Computational Science', 2015, '2026-05-16 21:01:11'),
(3, 'Information Technology', 'IT', 'Natural and Computational Science', 2012, '2026-05-16 21:01:11'),
(4, 'Electrical Engineering', 'EE', 'Engineering and Technology', 2008, '2026-05-16 21:01:11'),
(5, 'Civil Engineering', 'CE', 'Engineering and Technology', 2005, '2026-05-16 21:01:11'),
(6, 'Mechanical Engineering', 'ME', 'Engineering and Technology', 2007, '2026-05-16 21:01:11'),
(7, 'Chemical Engineering', 'ChE', 'Engineering and Technology', 2013, '2026-05-16 21:01:11'),
(8, 'Accounting and Finance', 'AF', 'Business and Economics', 2010, '2026-05-16 21:01:11'),
(9, 'Marketing Management', 'MM', 'Business and Economics', 2011, '2026-05-16 21:01:11'),
(10, 'Public Health', 'PH', 'Health Sciences', 2014, '2026-05-16 21:01:11'),
(11, 'Administration', 'ADMIN', 'University Administration', 2000, '2026-05-16 21:01:11');

-- --------------------------------------------------------

--
-- Table structure for table `enrollments`
--

CREATE TABLE `enrollments` (
  `id` int(11) NOT NULL,
  `student_id` varchar(20) DEFAULT NULL,
  `course_code` varchar(20) DEFAULT NULL,
  `enrollment_date` date DEFAULT curdate(),
  `status` varchar(20) DEFAULT 'Enrolled',
  `grade` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `enrollments`
--

INSERT INTO `enrollments` (`id`, `student_id`, `course_code`, `enrollment_date`, `status`, `grade`) VALUES
(1, 'CS001/25', 'CS101', '2026-05-16', 'Enrolled', NULL),
(2, 'CS001/25', 'CS202', '2026-05-16', 'Enrolled', NULL),
(3, 'CS001/25', 'CS301', '2026-05-16', 'Enrolled', NULL),
(4, 'CS002/25', 'CS101', '2026-05-16', 'Enrolled', NULL),
(5, 'CS002/25', 'CS201', '2026-05-16', 'Enrolled', NULL),
(6, 'SE001/25', 'SE101', '2026-05-16', 'Enrolled', NULL),
(7, 'SE001/25', 'SE202', '2026-05-16', 'Enrolled', NULL),
(8, 'SE002/25', 'SE101', '2026-05-16', 'Enrolled', NULL),
(9, 'IT001/25', 'IT101', '2026-05-16', 'Enrolled', NULL),
(10, 'IT001/25', 'IT201', '2026-05-16', 'Enrolled', NULL),
(11, 'EE001/25', 'EE101', '2026-05-16', 'Enrolled', NULL),
(12, 'EE001/25', 'EE201', '2026-05-16', 'Enrolled', NULL),
(13, 'CE001/25', 'CE101', '2026-05-16', 'Enrolled', NULL),
(14, 'CE001/25', 'CE201', '2026-05-16', 'Enrolled', NULL),
(15, 'ME001/25', 'ME203', '2026-05-16', 'Enrolled', NULL),
(16, 'SE001/25', 'SE401', '2026-05-16', 'Enrolled', NULL),
(17, 'SE001/25', 'SE102', '2026-05-16', 'Enrolled', NULL),
(18, 'SE001/25', 'SE201', '2026-05-16', 'Enrolled', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `student_id` varchar(20) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `department` varchar(100) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `registration_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `student_id`, `full_name`, `email`, `password`, `department`, `phone`, `registration_date`) VALUES
(1, 'ADMIN001', 'System Administrator', 'admin@wsu.edu.et', 'admin123', 'Administration', '0000000000', '2026-05-16 21:01:12'),
(2, 'CS001/25', 'Abebe Kebede', 'abebe.cs@wsu.edu.et', 'student123', 'Computer Science', '0912345678', '2026-05-16 21:01:12'),
(3, 'CS002/25', 'Almaz Desta', 'almaz.cs@wsu.edu.et', 'student123', 'Computer Science', '0923456789', '2026-05-16 21:01:12'),
(4, 'SE001/25', 'Bekele Tola', 'bekele.se@wsu.edu.et', 'student123', 'Software Engineering', '0934567890', '2026-05-16 21:01:12'),
(5, 'SE002/25', 'Chala Desta', 'chala.se@wsu.edu.et', 'student123', 'Software Engineering', '0945678901', '2026-05-16 21:01:12'),
(6, 'IT001/25', 'Daniel Worku', 'daniel.it@wsu.edu.et', 'student123', 'Information Technology', '0956789012', '2026-05-16 21:01:12'),
(7, 'IT002/25', 'Eleni Haile', 'eleni.it@wsu.edu.et', 'student123', 'Information Technology', '0967890123', '2026-05-16 21:01:12'),
(8, 'EE001/25', 'Fikre Alem', 'fikre.ee@wsu.edu.et', 'student123', 'Computer Science', '0978901234', '2026-05-16 21:01:12'),
(9, 'CE001/25', 'Genet Hailu', 'genet.ce@wsu.edu.et', 'student123', 'Civil Engineering', '0989012345', '2026-05-16 21:01:12'),
(10, 'ME001/25', 'Henok Tesfaye', 'henok.me@wsu.edu.et', 'student123', 'Mechanical Engineering', '0990123456', '2026-05-16 21:01:12'),
(11, 'CHE001/25', 'Ibrahim Ahmed', 'ibrahim.che@wsu.edu.et', 'student123', 'Chemical Engineering', '0911234567', '2026-05-16 21:01:12'),
(12, 'AF001/25', 'Jemila Mohammed', 'jemila.af@wsu.edu.et', 'student123', 'Software Engineering', '0922345678', '2026-05-16 21:01:12'),
(13, 'MM001/25', 'Kebede Tola', 'kebede.mm@wsu.edu.et', 'student123', 'Marketing Management', '0933456789', '2026-05-16 21:01:12'),
(14, 'PH001/25', 'Liya Worku', 'liya.ph@wsu.edu.et', 'student123', 'Public Health', '0944567890', '2026-05-16 21:01:12');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`course_id`),
  ADD UNIQUE KEY `course_code` (`course_code`),
  ADD KEY `department` (`department`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`dept_id`),
  ADD UNIQUE KEY `dept_name` (`dept_name`),
  ADD UNIQUE KEY `dept_code` (`dept_code`);

--
-- Indexes for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_enrollment` (`student_id`,`course_code`),
  ADD KEY `course_code` (`course_code`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `student_id` (`student_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `department` (`department`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `dept_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `enrollments`
--
ALTER TABLE `enrollments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`department`) REFERENCES `departments` (`dept_name`) ON DELETE CASCADE;

--
-- Constraints for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD CONSTRAINT `enrollments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `enrollments_ibfk_2` FOREIGN KEY (`course_code`) REFERENCES `courses` (`course_code`) ON DELETE CASCADE;

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`department`) REFERENCES `departments` (`dept_name`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
