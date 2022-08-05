-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 04, 2022 at 11:47 AM
-- Server version: 10.3.16-MariaDB
-- PHP Version: 7.3.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `toko_buah`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getKelompokProc` (IN `v_user` VARCHAR(20), IN `v_pwd` VARCHAR(100))  BEGIN

SELECT kelompok
FROM akun_user
WHERE id_user = v_user
AND password = md5(v_pwd);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getSupplierIdProc` (OUT `v_supplier_id` VARCHAR(25))  BEGIN
DECLARE 
	nilai_maks INT;
	
SELECT MAX(SUBSTRING(id_supplier, 4))+0 INTO nilai_maks
FROM supplier;

SET v_supplier_id = CONCAT('ID-',LPAD(nilai_maks+1,3,'0'));

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilBuah` ()  BEGIN

SELECT * FROM buah;

END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `getHargaJual` (`harga_dasar` DOUBLE, `keuntungan_dalam_persen` FLOAT) RETURNS DOUBLE BEGIN
DECLARE hasil DOUBLE; 
DECLARE pengali FLOAT;

SET pengali = (100+keuntungan_dalam_persen)/100 ;
SET hasil = pengali*harga_dasar;
SET hasil = ROUND(hasil, 2);

RETURN hasil;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `akun_user`
--

CREATE TABLE `akun_user` (
  `id_user` varchar(20) CHARACTER SET utf8 NOT NULL,
  `password` varchar(32) CHARACTER SET utf8 NOT NULL,
  `kelompok` varchar(50) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `akun_user`
--

INSERT INTO `akun_user` (`id_user`, `password`, `kelompok`) VALUES
('admin', '21232f297a57a5a743894a0e4a801fc3', 'Admin'),
('bambang', 'a9711cbb2e3c2d5fc97a63e45bbe5076', 'Pegawai'),
('hendro', '66cb5177a2d8017b6e71983e95659388', 'Pemilik'),
('syahrini', '81dc9bdb52d04dc20036dbd8313ed055', 'Pegawai');

-- --------------------------------------------------------

--
-- Table structure for table `buah`
--

CREATE TABLE `buah` (
  `IdBuah` int(11) NOT NULL,
  `NamaBuah` varchar(50) DEFAULT NULL,
  `Gambar` varchar(100) DEFAULT 'default.jpg',
  `Kategori` varchar(50) DEFAULT NULL,
  `Stok` int(11) DEFAULT NULL,
  `HPP_AVERAGE` float(11,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `buah`
--

INSERT INTO `buah` (`IdBuah`, `NamaBuah`, `Gambar`, `Kategori`, `Stok`, `HPP_AVERAGE`) VALUES
(1, 'Mangga', 'mangga.jpg', 'Lokal', 51, 19066),
(10, 'Semangka', 'manggis.jpg', 'Lokal', 23, 242250),
(12, 'Apel', '5e4025f8cf52e.jpg', 'Impor', 0, 32788),
(13, 'Pear', '5e4026268ce8b.jpg', 'Impor', 8, 7000),
(19, 'Durian', '5e427054beb33.jpg', 'Impor', 81, 63333);

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `tgl_input` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`id`, `nama`, `tgl_input`) VALUES
(1, 'Berdiam di rumah mengasyikkan.', '2020-04-08 14:58:51'),
(2, 'Kugapai suksesku tanpanya', '2020-04-08 08:00:00');

--
-- Triggers `buku`
--
DELIMITER $$
CREATE TRIGGER `af_update_buku` AFTER UPDATE ON `buku` FOR EACH ROW BEGIN
INSERT INTO history_buku
SET id = OLD.id,
  nama_lama = OLD.nama,
  nama_baru = NEW.nama,
  tgl_input_lama = OLD.tgl_input,
  tgl_input_baru = NEW.tgl_input,
  tgl_perubahan = now();

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `bef_insert_buku` BEFORE INSERT ON `buku` FOR EACH ROW BEGIN
DECLARE v_tanggal DATETIME ;
   SELECT IFNULL(NEW.tgl_input,NOW()) INTO v_tanggal;
   SET NEW.tgl_input = v_tanggal;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `coa`
--

CREATE TABLE `coa` (
  `kode_akun` int(11) NOT NULL,
  `nama_akun` varchar(100) CHARACTER SET utf8 NOT NULL,
  `header_kode_akun` int(11) NOT NULL,
  `posisi_d_c` varchar(1) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `coa`
--

INSERT INTO `coa` (`kode_akun`, `nama_akun`, `header_kode_akun`, `posisi_d_c`) VALUES
(1, 'Aktiva', 0, 'd'),
(2, 'Kewajiban', 0, 'c'),
(3, 'Modal', 0, 'c'),
(4, 'Pendapatan', 0, 'c'),
(5, 'Beban', 0, 'd'),
(11, 'Aktiva Lancar', 1, 'd'),
(12, 'Aktiva Tetap', 1, 'd'),
(21, 'Kewajiban Lancar', 2, 'c'),
(22, 'Kewajiban Jangka Panjang', 2, 'c'),
(31, 'Modal Pemilik', 3, 'c'),
(41, 'Pendapatan Operasional', 4, 'c'),
(42, 'Pendapatan Non Operasional', 4, 'c'),
(51, 'Beban Operasional', 5, 'd'),
(52, 'Beban Non Operasional', 5, 'd'),
(111, 'Kas', 11, 'd'),
(112, 'Persediaan Barang Dagang', 11, 'd'),
(411, 'Penjualan', 41, 'c'),
(412, 'Harga Pokok Penjualan', 41, 'd'),
(511, 'Beban Administrasi dan Umum', 51, 'd');

-- --------------------------------------------------------

--
-- Table structure for table `detail_pembelian`
--

CREATE TABLE `detail_pembelian` (
  `id_transaksi_pembelian` int(10) NOT NULL,
  `id_buah` int(11) DEFAULT NULL,
  `id_supplier` varchar(6) DEFAULT NULL,
  `harga_satuan` int(11) DEFAULT NULL,
  `jumlah_pembelian` int(11) DEFAULT NULL,
  `no_faktur` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `detail_pembelian`
--

INSERT INTO `detail_pembelian` (`id_transaksi_pembelian`, `id_buah`, `id_supplier`, `harga_satuan`, `jumlah_pembelian`, `no_faktur`) VALUES
(14, 12, 'ID-001', 4000, 2, 'FKT-01'),
(15, 1, 'ID-001', 5000, 20, 'FKT-01'),
(16, 12, 'ID-004', 50000, 3, 'JKT-48'),
(17, 13, 'ID-004', 7000, 8, 'JKT-48'),
(18, 19, 'ID-004', 70000, 9, 'JKT-48'),
(19, 1, 'ID-004', 400, 2, 'JKT-48'),
(20, 10, 'ID-004', 9000, 2, 'JKT-48'),
(21, 12, 'ID-004', 5000, 2, 'KPI'),
(22, 10, 'ID-004', 900000, 10, 'KPI'),
(31, 12, 'ID-003', 28000, 2, 'FKT-02'),
(32, 10, 'ID-003', 30000, 1, 'FKT-02'),
(33, 19, 'ID-003', 80000, 10, 'FKT-02'),
(34, 12, 'ID-003', 20000, 4, 'KJU'),
(35, 19, 'ID-003', 100000, 2, 'KJU'),
(42, 1, 'ID-001', 80000, 100, 'ZX2'),
(43, 12, 'ID-001', 800000, 2, 'KJ7'),
(50, 12, 'ID-003', 8000, 6, 'AC3'),
(51, 1, 'ID-003', 9000, 1, 'AC3'),
(52, 1, 'ID-003', 10000, 5, 'JKW-20910-103'),
(53, 12, 'ID-003', 25000, 5, 'JKW-20910-103'),
(54, 12, 'ID-003', 110000, 2, 'TREQ-13301'),
(55, 19, 'ID-001', 10000, 100, 'TR23'),
(56, 1, 'ID-001', 10000, 23, 'TR23'),
(57, 19, 'ID-003', 40000, 2, 'ACX123'),
(59, 12, 'ID-004', 10000, 2, 'ABC-D1'),
(60, 19, 'ID-004', 100000, 3, 'ABC-D1'),
(62, 12, 'ID-003', 20000, 45, 'FKT-01-20202502'),
(63, 19, 'ID-003', 200000, 2, 'FKT-01-20202502'),
(64, 10, 'ID-003', 30000, 10, 'FKT-01-20202502'),
(65, 12, 'ID-004', 20000, 5, 'PJL-8713121'),
(66, 19, 'ID-004', 50000, 10, 'PJL-8713121'),
(67, 12, 'ID-001', 20000, 4, 'KYT-01-02'),
(68, 19, 'ID-001', 100000, 5, 'KYT-01-02'),
(90, 12, 'ID-001', 25000, 5, 'BDG-2020-19-03'),
(91, 19, 'ID-001', 70000, 5, 'BDG-2020-19-03'),
(92, 12, 'ID-001', 10000, 5, 'ZXXXXX'),
(93, 19, 'ID-001', 50000, 10, 'ZXXXXX');

--
-- Triggers `detail_pembelian`
--
DELIMITER $$
CREATE TRIGGER `after_delete_detail_pembelian` BEFORE DELETE ON `detail_pembelian` FOR EACH ROW BEGIN
	DECLARE hpp_average_lama integer;
	DECLARE hpp_average_lama_tabel integer;
	
	SELECT HPP_AVERAGE INTO hpp_average_lama_tabel
	FROM buah WHERE IdBuah = OLD.id_buah;
	
	SET hpp_average_lama=(2*hpp_average_lama_tabel)-OLD.harga_satuan;
	
	UPDATE buah 
	SET HPP_AVERAGE = hpp_average_lama
	WHERE IdBuah = OLD.id_buah;
	
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_detail_pembelian` BEFORE INSERT ON `detail_pembelian` FOR EACH ROW BEGIN
	DECLARE jml_data integer;
	DECLARE hpp_average_lama integer;
	
	SELECT COUNT(*) INTO jml_data
	FROM detail_pembelian
	WHERE id_buah = NEW.id_buah;
	
	IF(jml_data=0) THEN
		UPDATE buah 
		SET HPP_AVERAGE = NEW.harga_satuan
		WHERE IdBuah = NEW.id_buah;
	ELSE
		SELECT HPP_AVERAGE INTO hpp_average_lama
		FROM buah WHERE IdBuah = NEW.id_buah;
		
		UPDATE buah 
		SET HPP_AVERAGE = (NEW.harga_satuan+hpp_average_lama)/2 
		WHERE IdBuah = NEW.id_buah;
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_detail_pembelian` BEFORE UPDATE ON `detail_pembelian` FOR EACH ROW BEGIN
	DECLARE hpp_average_lama integer;
	DECLARE hpp_average_lama_tabel integer;
	
	IF(OLD.harga_satuan<>NEW.harga_satuan) THEN
		SELECT HPP_AVERAGE INTO hpp_average_lama_tabel
		FROM buah WHERE IdBuah = NEW.id_buah;
		
		SET hpp_average_lama=(2*hpp_average_lama_tabel)-OLD.harga_satuan;
		
		UPDATE buah 
		SET HPP_AVERAGE = (NEW.harga_satuan+hpp_average_lama)/2 
		WHERE IdBuah = NEW.id_buah;
	
	END IF;
	
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `detail_penjualan`
--

CREATE TABLE `detail_penjualan` (
  `id_transaksi_penjualan` int(11) NOT NULL,
  `id_penjualan` varchar(30) DEFAULT NULL,
  `id_buah` int(11) DEFAULT NULL,
  `jml_buah` int(11) DEFAULT NULL,
  `harga_jual` int(11) DEFAULT NULL,
  `hpp` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `detail_penjualan`
--

INSERT INTO `detail_penjualan` (`id_transaksi_penjualan`, `id_penjualan`, `id_buah`, `jml_buah`, `harga_jual`, `hpp`) VALUES
(1, 'FAK-000001', 12, 10, 28062, 23385),
(4, 'FAK-000002', 12, 3, 24000, 20000),
(5, 'FAK-000002', 19, 33, 23586, 19655),
(90, 'FAK-000003', 1, 100, 22880, 19067),
(93, 'FAK-000004', 12, 24, 66692, 55577),
(94, 'FAK-000004', 19, 10, 91999, 76666),
(95, 'FAK-000005', 12, 2, 66692, 55577),
(96, 'FAK-000006', 19, 10, 91999, 76666),
(97, 'FAK-000007', 19, 24, 91999, 76666),
(98, 'FAK-000008', 12, 5, 39346, 32788);

-- --------------------------------------------------------

--
-- Table structure for table `form_input`
--

CREATE TABLE `form_input` (
  `id` int(11) NOT NULL,
  `nama` varchar(25) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `jml_saudara` int(11) DEFAULT NULL,
  `uang_saku` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `form_input`
--

INSERT INTO `form_input` (`id`, `nama`, `email`, `tgl_lahir`, `jml_saudara`, `uang_saku`) VALUES
(1, 'Hendro', 'agil@gmail.com', '2000-01-07', 0, 200000),
(2, 'kljljkjkljkl', 'jarwo@gmail.com', '2000-01-01', 2, 2500000),
(3, 'Sutris', 'sutris@yahoo.com', '2000-08-06', 10, 10000000),
(5, 'Supriyono2', 'dasda@yahoo.com', '2002-04-01', 6, 500000),
(8, 'Reska', 'reska@yahoo.com', '2020-02-13', 0, 7000000),
(9, 'reska', 'reska@yahoo.com', '2020-02-13', 6, 8000000);

-- --------------------------------------------------------

--
-- Table structure for table `history_buku`
--

CREATE TABLE `history_buku` (
  `id` int(11) DEFAULT NULL,
  `nama_lama` varchar(100) DEFAULT NULL,
  `nama_baru` varchar(100) DEFAULT NULL,
  `tgl_input_lama` datetime DEFAULT NULL,
  `tgl_input_baru` datetime DEFAULT NULL,
  `tgl_perubahan` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `history_buku`
--

INSERT INTO `history_buku` (`id`, `nama_lama`, `nama_baru`, `tgl_input_lama`, `tgl_input_baru`, `tgl_perubahan`) VALUES
(2, 'Kugapai suksesku bersamanya', 'Kugapai suksesku tanpanya', '2020-04-08 08:00:00', '2020-04-08 08:00:00', '2020-04-08 15:23:02');

-- --------------------------------------------------------

--
-- Table structure for table `iklan`
--

CREATE TABLE `iklan` (
  `tv` float NOT NULL,
  `radio` float NOT NULL,
  `newspaper` float NOT NULL,
  `sales` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `iklan`
--

INSERT INTO `iklan` (`tv`, `radio`, `newspaper`, `sales`) VALUES
(0, 0, 0, 0),
(230.1, 37.8, 69.2, 22.1),
(44.5, 39.3, 45.1, 10.4),
(17.2, 45.9, 69.3, 12),
(151.5, 41.3, 58.5, 16.5),
(180.8, 10.8, 58.4, 17.9),
(8.7, 48.9, 75, 7.2),
(57.5, 32.8, 23.5, 11.8),
(120.2, 19.6, 11.6, 13.2),
(8.6, 2.1, 1, 4.8),
(199.8, 2.6, 21.2, 15.6),
(66.1, 5.8, 24.2, 12.6),
(214.7, 24, 4, 17.4),
(23.8, 35.1, 65.9, 9.2),
(97.5, 7.6, 7.2, 13.7),
(204.1, 32.9, 46, 19),
(195.4, 47.7, 52.9, 22.4),
(67.8, 36.6, 114, 12.5),
(281.4, 39.6, 55.8, 24.4),
(69.2, 20.5, 18.3, 11.3),
(147.3, 23.9, 19.1, 14.6),
(218.4, 27.7, 53.4, 18),
(237.4, 5.1, 23.5, 17.5),
(13.2, 15.9, 49.6, 5.6),
(228.3, 16.9, 26.2, 20.5),
(62.3, 12.6, 18.3, 9.7),
(262.9, 3.5, 19.5, 17),
(142.9, 29.3, 12.6, 15),
(240.1, 16.7, 22.9, 20.9),
(248.8, 27.1, 22.9, 18.9),
(70.6, 16, 40.8, 10.5),
(292.9, 28.3, 43.2, 21.4),
(112.9, 17.4, 38.6, 11.9),
(97.2, 1.5, 30, 13.2),
(265.6, 20, 0.3, 17.4),
(95.7, 1.4, 7.4, 11.9),
(290.7, 4.1, 8.5, 17.8),
(266.9, 43.8, 5, 25.4),
(74.7, 49.4, 45.7, 14.7),
(43.1, 26.7, 35.1, 10.1),
(228, 37.7, 32, 21.5),
(202.5, 22.3, 31.6, 16.6),
(177, 33.4, 38.7, 17.1),
(293.6, 27.7, 1.8, 20.7),
(206.9, 8.4, 26.4, 17.9),
(25.1, 25.7, 43.3, 8.5),
(175.1, 22.5, 31.5, 16.1),
(89.7, 9.9, 35.7, 10.6),
(239.9, 41.5, 18.5, 23.2),
(227.2, 15.8, 49.9, 19.8),
(66.9, 11.7, 36.8, 9.7),
(199.8, 3.1, 34.6, 16.4),
(100.4, 9.6, 3.6, 10.7),
(216.4, 41.7, 39.6, 22.6),
(182.6, 46.2, 58.7, 21.2),
(262.7, 28.8, 15.9, 20.2),
(198.9, 49.4, 60, 23.7),
(7.3, 28.1, 41.4, 5.5),
(136.2, 19.2, 16.6, 13.2),
(210.8, 49.6, 37.7, 23.8),
(210.7, 29.5, 9.3, 18.4),
(53.5, 2, 21.4, 8.1),
(261.3, 42.7, 54.7, 24.2),
(239.3, 15.5, 27.3, 20.7),
(102.7, 29.6, 8.4, 14),
(131.1, 42.8, 28.9, 16),
(69, 9.3, 0.9, 11.3),
(31.5, 24.6, 2.2, 11),
(139.3, 14.5, 10.2, 13.4),
(237.4, 27.5, 11, 18.9),
(216.8, 43.9, 27.2, 22.3),
(199.1, 30.6, 38.7, 18.3),
(109.8, 14.3, 31.7, 12.4),
(26.8, 33, 19.3, 8.8),
(129.4, 5.7, 31.3, 11),
(213.4, 24.6, 13.1, 17),
(16.9, 43.7, 89.4, 8.7),
(27.5, 1.6, 20.7, 6.9),
(120.5, 28.5, 14.2, 14.2),
(5.4, 29.9, 9.4, 5.3),
(116, 7.7, 23.1, 11),
(76.4, 26.7, 22.3, 11.8),
(239.8, 4.1, 36.9, 17.3),
(75.3, 20.3, 32.5, 11.3),
(68.4, 44.5, 35.6, 13.6),
(213.5, 43, 33.8, 21.7),
(193.2, 18.4, 65.7, 20.2),
(76.3, 27.5, 16, 12),
(110.7, 40.6, 63.2, 16),
(88.3, 25.5, 73.4, 12.9),
(109.8, 47.8, 51.4, 16.7),
(134.3, 4.9, 9.3, 14),
(28.6, 1.5, 33, 7.3),
(217.7, 33.5, 59, 19.4),
(250.9, 36.5, 72.3, 22.2),
(107.4, 14, 10.9, 11.5),
(163.3, 31.6, 52.9, 16.9),
(197.6, 3.5, 5.9, 16.7),
(184.9, 21, 22, 20.5),
(289.7, 42.3, 51.2, 25.4),
(135.2, 41.7, 45.9, 17.2),
(222.4, 4.3, 49.8, 16.7),
(296.4, 36.3, 100.9, 23.8),
(280.2, 10.1, 21.4, 19.8),
(187.9, 17.2, 17.9, 19.7),
(238.2, 34.3, 5.3, 20.7),
(137.9, 46.4, 59, 15),
(25, 11, 29.7, 7.2),
(90.4, 0.3, 23.2, 12),
(13.1, 0.4, 25.6, 5.3),
(255.4, 26.9, 5.5, 19.8),
(225.8, 8.2, 56.5, 18.4),
(241.7, 38, 23.2, 21.8),
(175.7, 15.4, 2.4, 17.1),
(209.6, 20.6, 10.7, 20.9),
(78.2, 46.8, 34.5, 14.6),
(75.1, 35, 52.7, 12.6),
(139.2, 14.3, 25.6, 12.2),
(76.4, 0.8, 14.8, 9.4),
(125.7, 36.9, 79.2, 15.9),
(19.4, 16, 22.3, 6.6),
(141.3, 26.8, 46.2, 15.5),
(18.8, 21.7, 50.4, 7),
(224, 2.4, 15.6, 16.6),
(123.1, 34.6, 12.4, 15.2),
(229.5, 32.3, 74.2, 19.7),
(87.2, 11.8, 25.9, 10.6),
(7.8, 38.9, 50.6, 6.6),
(80.2, 0, 9.2, 11.9),
(220.3, 49, 3.2, 24.7),
(59.6, 12, 43.1, 9.7),
(0.7, 39.6, 8.7, 1.6),
(265.2, 2.9, 43, 17.7),
(8.4, 27.2, 2.1, 5.7),
(219.8, 33.5, 45.1, 19.6),
(36.9, 38.6, 65.6, 10.8),
(48.3, 47, 8.5, 11.6),
(25.6, 39, 9.3, 9.5),
(273.7, 28.9, 59.7, 20.8),
(43, 25.9, 20.5, 9.6),
(184.9, 43.9, 1.7, 20.7),
(73.4, 17, 12.9, 10.9),
(193.7, 35.4, 75.6, 19.2),
(220.5, 33.2, 37.9, 20.1),
(104.6, 5.7, 34.4, 10.4),
(96.2, 14.8, 38.9, 12.3),
(140.3, 1.9, 9, 10.3),
(240.1, 7.3, 8.7, 18.2),
(243.2, 49, 44.3, 25.4),
(38, 40.3, 11.9, 10.9),
(44.7, 25.8, 20.6, 10.1),
(280.7, 13.9, 37, 16.1),
(121, 8.4, 48.7, 11.6),
(197.6, 23.3, 14.2, 16.6),
(171.3, 39.7, 37.7, 16),
(187.8, 21.1, 9.5, 20.6),
(4.1, 11.6, 5.7, 3.2),
(93.9, 43.5, 50.5, 15.3),
(149.8, 1.3, 24.3, 10.1),
(11.7, 36.9, 45.2, 7.3),
(131.7, 18.4, 34.6, 12.9),
(172.5, 18.1, 30.7, 16.4),
(85.7, 35.8, 49.3, 13.3),
(188.4, 18.1, 25.6, 19.9),
(163.5, 36.8, 7.4, 18),
(117.2, 14.7, 5.4, 11.9),
(234.5, 3.4, 84.8, 16.9),
(17.9, 37.6, 21.6, 8),
(206.8, 5.2, 19.4, 17.2),
(215.4, 23.6, 57.6, 17.1),
(284.3, 10.6, 6.4, 20),
(50, 11.6, 18.4, 8.4),
(164.5, 20.9, 47.4, 17.5),
(19.6, 20.1, 17, 7.6),
(168.4, 7.1, 12.8, 16.7),
(222.4, 3.4, 13.1, 16.5),
(276.9, 48.9, 41.8, 27),
(248.4, 30.2, 20.3, 20.2),
(170.2, 7.8, 35.2, 16.7),
(276.7, 2.3, 23.7, 16.8),
(165.6, 10, 17.6, 17.6),
(156.6, 2.6, 8.3, 15.5),
(218.5, 5.4, 27.4, 17.2),
(56.2, 5.7, 29.7, 8.7),
(287.6, 43, 71.8, 26.2),
(253.8, 21.3, 30, 17.6),
(205, 45.1, 19.6, 22.6),
(139.5, 2.1, 26.6, 10.3),
(191.1, 28.7, 18.2, 17.3),
(286, 13.9, 3.7, 20.9),
(18.7, 12.1, 23.4, 6.7),
(39.5, 41.1, 5.8, 10.8),
(75.5, 10.8, 6, 11.9),
(17.2, 4.1, 31.6, 5.9),
(166.8, 42, 3.6, 19.6),
(149.7, 35.6, 6, 17.3),
(38.2, 3.7, 13.8, 7.6),
(94.2, 4.9, 8.1, 14),
(177, 9.3, 6.4, 14.8),
(283.6, 42, 66.2, 25.5),
(232.1, 8.6, 8.7, 18.4);

-- --------------------------------------------------------

--
-- Table structure for table `jurnal_umum`
--

CREATE TABLE `jurnal_umum` (
  `id_transaksi` int(11) NOT NULL,
  `kode_akun` int(11) NOT NULL,
  `tgl_jurnal` date NOT NULL,
  `posisi_d_c` varchar(1) CHARACTER SET utf8 NOT NULL,
  `nominal` double NOT NULL,
  `kelompok` int(11) NOT NULL,
  `transaksi` varchar(100) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jurnal_umum`
--

INSERT INTO `jurnal_umum` (`id_transaksi`, `kode_akun`, `tgl_jurnal`, `posisi_d_c`, `nominal`, `kelompok`, `transaksi`) VALUES
(1, 111, '2020-02-21', 'c', 108000, 1, 'pembelian'),
(1, 112, '2020-02-21', 'd', 108000, 1, 'pembelian'),
(2, 111, '2020-02-22', 'c', 280000, 1, 'pembelian'),
(2, 112, '2020-02-22', 'd', 280000, 1, 'pembelian'),
(3, 111, '2020-02-22', 'c', 8000000, 1, 'pembelian'),
(3, 112, '2020-02-22', 'd', 8000000, 1, 'pembelian'),
(4, 111, '2020-02-22', 'c', 1600000, 1, 'pembelian'),
(4, 112, '2020-02-22', 'd', 1600000, 1, 'pembelian'),
(5, 111, '2020-02-22', 'c', 57000, 1, 'pembelian'),
(5, 112, '2020-02-22', 'd', 57000, 1, 'pembelian'),
(6, 111, '2020-02-23', 'c', 220000, 1, 'pembelian'),
(6, 112, '2020-02-23', 'd', 220000, 1, 'pembelian'),
(7, 111, '2020-02-23', 'c', 1230000, 1, 'pembelian'),
(7, 112, '2020-02-23', 'd', 1230000, 1, 'pembelian'),
(8, 111, '2020-02-23', 'c', 80000, 1, 'pembelian'),
(8, 112, '2020-02-23', 'd', 80000, 1, 'pembelian'),
(9, 111, '2020-02-25', 'c', 1600000, 1, 'pembelian'),
(9, 112, '2020-02-25', 'd', 1600000, 1, 'pembelian'),
(10, 111, '2020-02-26', 'c', 600000, 1, 'pembelian'),
(10, 112, '2020-02-26', 'd', 600000, 1, 'pembelian'),
(11, 111, '2020-02-26', 'c', 320000, 1, 'pembelian'),
(11, 112, '2020-02-26', 'd', 320000, 1, 'pembelian'),
(12, 111, '2020-02-29', 'd', 280620, 1, 'penjualan'),
(12, 112, '2020-02-29', 'c', 233850, 2, 'penjualan'),
(12, 411, '2020-02-29', 'c', 280620, 1, 'penjualan'),
(12, 412, '2020-02-29', 'd', 233850, 2, 'penjualan'),
(13, 111, '2020-02-29', 'd', 850338, 1, 'penjualan'),
(13, 112, '2020-02-29', 'c', 708615, 2, 'penjualan'),
(13, 411, '2020-02-29', 'c', 850338, 1, 'penjualan'),
(13, 412, '2020-02-29', 'd', 708615, 2, 'penjualan'),
(14, 111, '2020-03-05', 'c', 580000, 1, 'pembelian'),
(14, 112, '2020-03-05', 'd', 580000, 1, 'pembelian'),
(15, 111, '2020-03-05', 'd', 2288000, 1, 'penjualan'),
(15, 112, '2020-03-05', 'c', 1906700, 2, 'penjualan'),
(15, 411, '2020-03-05', 'c', 2288000, 1, 'penjualan'),
(15, 412, '2020-03-05', 'd', 1906700, 2, 'penjualan'),
(16, 111, '2020-03-19', 'c', 475000, 1, 'pembelian'),
(16, 112, '2020-03-19', 'd', 475000, 1, 'pembelian'),
(17, 111, '2020-03-19', 'd', 2520598, 1, 'penjualan'),
(17, 112, '2020-03-19', 'c', 2100508, 2, 'penjualan'),
(17, 411, '2020-03-19', 'c', 2520598, 1, 'penjualan'),
(17, 412, '2020-03-19', 'd', 2100508, 2, 'penjualan'),
(18, 111, '2020-03-20', 'c', 50000, 1, 'pembebanan'),
(18, 511, '2020-03-20', 'd', 50000, 1, 'pembebanan'),
(19, 31, '2020-01-01', 'c', 30000000, 1, 'pemodalan'),
(19, 111, '2020-01-01', 'd', 30000000, 1, 'pemodalan'),
(20, 111, '2020-04-04', 'd', 133384, 1, 'penjualan'),
(20, 112, '2020-04-04', 'c', 111154, 2, 'penjualan'),
(20, 411, '2020-04-04', 'c', 133384, 1, 'penjualan'),
(20, 412, '2020-04-04', 'd', 111154, 2, 'penjualan'),
(21, 111, '2020-04-08', 'd', 919990, 1, 'penjualan'),
(21, 112, '2020-04-08', 'c', 766660, 2, 'penjualan'),
(21, 411, '2020-04-08', 'c', 919990, 1, 'penjualan'),
(21, 412, '2020-04-08', 'd', 766660, 2, 'penjualan'),
(22, 111, '2021-05-27', 'd', 2207976, 1, 'penjualan'),
(22, 112, '2021-05-27', 'c', 1839984, 2, 'penjualan'),
(22, 411, '2021-05-27', 'c', 2207976, 1, 'penjualan'),
(22, 412, '2021-05-27', 'd', 1839984, 2, 'penjualan'),
(23, 111, '2022-07-04', 'c', 550000, 1, 'pembelian'),
(23, 112, '2022-07-04', 'd', 550000, 1, 'pembelian');

-- --------------------------------------------------------

--
-- Table structure for table `pembebanan`
--

CREATE TABLE `pembebanan` (
  `id_transaksi` int(11) NOT NULL,
  `biaya` int(11) NOT NULL,
  `nama` varchar(100) CHARACTER SET utf8 NOT NULL,
  `waktu` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pembebanan`
--

INSERT INTO `pembebanan` (`id_transaksi`, `biaya`, `nama`, `waktu`) VALUES
(18, 50000, 'Bayar Beban Bulan Maret', '2020-03-20 08:11:12');

--
-- Triggers `pembebanan`
--
DELIMITER $$
CREATE TRIGGER `after_delete_pembebanan` AFTER DELETE ON `pembebanan` FOR EACH ROW BEGIN
	DELETE FROM jurnal_umum WHERE id_transaksi = OLD.id_transaksi;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `bef_insert_pembebanan` BEFORE INSERT ON `pembebanan` FOR EACH ROW BEGIN
	DECLARE id_trans integer;
	
	SELECT IFNULL(MAX(id_transaksi),0)+1 INTO id_trans 
	FROM
	(
		SELECT id_transaksi 
		FROM pembelian
		UNION
		SELECT id_transaksi 
		FROM penjualan
		UNION 
		SELECT id_transaksi 
		FROM pembebanan
		UNION
		SELECT id_transaksi 
		FROM pemodalan
		ORDER BY 1
	) TBL;
	
	SET NEW.id_transaksi = id_trans ;
	
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pembelian`
--

CREATE TABLE `pembelian` (
  `no_faktur` varchar(25) NOT NULL DEFAULT '',
  `id_supplier` varchar(10) NOT NULL DEFAULT '',
  `waktu_transaksi` datetime DEFAULT NULL,
  `dokumen` varchar(100) DEFAULT NULL,
  `qrcode` varchar(100) DEFAULT NULL,
  `id_transaksi` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pembelian`
--

INSERT INTO `pembelian` (`no_faktur`, `id_supplier`, `waktu_transaksi`, `dokumen`, `qrcode`, `id_transaksi`) VALUES
('ABC-D1', 'ID-004', '2020-02-26 21:50:10', NULL, NULL, 11),
('AC3', 'ID-003', '2020-02-22 11:24:32', '5e5224f9d606a.jpg', '5e5224fa6b76b.png', 5),
('ACX123', 'ID-003', '2020-02-23 02:11:20', NULL, NULL, 8),
('BDG-2020-19-03', 'ID-001', '2020-03-19 19:40:39', NULL, NULL, 16),
('FKT-01', 'ID-001', '2020-02-21 00:06:34', '5e50743f1807a.jpg', '5e50a09588f7c.png', 1),
('FKT-01-20202502', 'ID-003', '2020-02-25 13:54:45', '5e54c7e5165f0.jpg', '5e54c7e581f1a.png', 9),
('KJ7', 'ID-001', '2020-02-22 11:02:06', NULL, NULL, 4),
('KJU', 'ID-003', '2020-02-22 10:11:31', '5e50a07a8e3eb.jpg', '5e50a07aaccf1.png', 2),
('KYT-01-02', 'ID-001', '2020-03-05 06:27:13', NULL, NULL, 14),
('PJL-8713121', 'ID-004', '2020-02-26 07:20:19', '5e54dae3ae8b2.jpg', '5e54dae434b93.png', 10),
('TR23', 'ID-001', '2020-02-23 02:07:14', NULL, NULL, 7),
('TREQ-13301', 'ID-003', '2020-02-23 02:06:20', NULL, NULL, 6),
('ZX2', 'ID-001', '2020-02-22 10:26:48', NULL, NULL, 3),
('ZXXXXX', 'ID-001', '2022-07-04 16:39:19', NULL, NULL, 23);

--
-- Triggers `pembelian`
--
DELIMITER $$
CREATE TRIGGER `after_delete_pembelian` AFTER DELETE ON `pembelian` FOR EACH ROW BEGIN
	DELETE FROM jurnal_umum WHERE id_transaksi = OLD.id_transaksi;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `bef_insert_pembelian` BEFORE INSERT ON `pembelian` FOR EACH ROW BEGIN
	DECLARE id_trans integer;
	
	SELECT IFNULL(MAX(id_transaksi),0)+1 INTO id_trans 
	FROM
	(
		SELECT id_transaksi 
		FROM pembelian
		UNION
		SELECT id_transaksi 
		FROM penjualan
		UNION 
		SELECT id_transaksi 
		FROM pembebanan
		UNION
		SELECT id_transaksi 
		FROM pemodalan
		ORDER BY 1
	) TBL;
	
	SET NEW.id_transaksi = id_trans ;
	
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pemodalan`
--

CREATE TABLE `pemodalan` (
  `id_transaksi` int(11) NOT NULL,
  `besar` int(11) NOT NULL,
  `nama` varchar(100) CHARACTER SET utf8 NOT NULL,
  `waktu` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pemodalan`
--

INSERT INTO `pemodalan` (`id_transaksi`, `besar`, `nama`, `waktu`) VALUES
(19, 30000000, 'Modal awal usaha', '2020-01-01 08:11:12');

--
-- Triggers `pemodalan`
--
DELIMITER $$
CREATE TRIGGER `after_delete_pemodalan` AFTER DELETE ON `pemodalan` FOR EACH ROW BEGIN
	DELETE FROM jurnal_umum WHERE id_transaksi = OLD.id_transaksi;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `bef_insert_pemodalan` BEFORE INSERT ON `pemodalan` FOR EACH ROW BEGIN
	DECLARE id_trans integer;
	
	SELECT IFNULL(MAX(id_transaksi),0)+1 INTO id_trans 
	FROM
	(
		SELECT id_transaksi 
		FROM pembelian
		UNION
		SELECT id_transaksi 
		FROM penjualan
		UNION 
		SELECT id_transaksi 
		FROM pembebanan
		UNION
		SELECT id_transaksi 
		FROM pemodalan
		ORDER BY 1
	) TBL;
	
	SET NEW.id_transaksi = id_trans ;
	
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `penjualan`
--

CREATE TABLE `penjualan` (
  `id_penjualan` varchar(30) NOT NULL,
  `waktu` datetime DEFAULT NULL,
  `id_transaksi` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `penjualan`
--

INSERT INTO `penjualan` (`id_penjualan`, `waktu`, `id_transaksi`) VALUES
('FAK-000001', '2020-02-29 20:19:48', 12),
('FAK-000002', '2020-02-29 20:44:02', 13),
('FAK-000003', '2020-03-05 17:59:24', 15),
('FAK-000004', '2020-03-19 19:41:02', 17),
('FAK-000005', '2020-04-04 21:40:18', 20),
('FAK-000006', '2020-04-08 13:21:47', 21),
('FAK-000007', '2021-05-27 12:52:23', 22),
('FAK-000008', '2022-07-04 16:45:14', 24);

--
-- Triggers `penjualan`
--
DELIMITER $$
CREATE TRIGGER `after_delete_penjualan` AFTER DELETE ON `penjualan` FOR EACH ROW BEGIN
	DELETE FROM jurnal_umum WHERE id_transaksi = OLD.id_transaksi;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `bef_insert_penjualan` BEFORE INSERT ON `penjualan` FOR EACH ROW BEGIN
	DECLARE id_trans integer;
	
	SELECT IFNULL(MAX(id_transaksi),0)+1 INTO id_trans 
	FROM
	(
		SELECT id_transaksi 
		FROM pembelian
		UNION
		SELECT id_transaksi 
		FROM penjualan
		UNION 
		SELECT id_transaksi 
		FROM pembebanan
		UNION
		SELECT id_transaksi 
		FROM pemodalan
		ORDER BY 1
	) TBL;
	
	SET NEW.id_transaksi = id_trans ;
	
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `id_supplier` varchar(25) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `lokasi` varchar(100) DEFAULT NULL,
  `no_telp` varchar(25) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`id_supplier`, `nama`, `lokasi`, `no_telp`, `email`) VALUES
('ID-001', 'CV Angkasa Pura', 'Jl jalan terus', '081-312-312-313', 'jalanterus@aja.com'),
('ID-003', 'CV Pasti Jaya Bersama Putra Bangsa', 'Jl Pelan pelan banyak ranjau', '1-231-231-223', 'sada@yahoo.com'),
('ID-004', 'PT Bersama Kita Bisa', 'Komplek Agak Jauh Dari Pusat', '313-123', 'rtda@tada.com'),
('ID-005', 'CV Dirumah Aja Lawan COVID-19', 'Jalan jalan tidak diperbolehkan', '081-231-123-122', 'cvdirumahaja@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi_coa`
--

CREATE TABLE `transaksi_coa` (
  `transaksi` varchar(100) CHARACTER SET utf8 NOT NULL,
  `kode_akun` int(11) NOT NULL,
  `posisi` varchar(1) CHARACTER SET utf8 NOT NULL,
  `kelompok` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transaksi_coa`
--

INSERT INTO `transaksi_coa` (`transaksi`, `kode_akun`, `posisi`, `kelompok`) VALUES
('pembebanan', 111, 'c', 1),
('pembebanan', 511, 'd', 1),
('pembelian', 111, 'c', 1),
('pembelian', 112, 'd', 1),
('pemodalan', 31, 'c', 1),
('pemodalan', 111, 'd', 1),
('penjualan', 111, 'd', 1),
('penjualan', 112, 'c', 2),
('penjualan', 411, 'c', 1),
('penjualan', 412, 'd', 2);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_coa`
-- (See below for the actual view)
--
CREATE TABLE `view_coa` (
`transaksi` varchar(100)
,`kode_akun` int(11)
,`nama_akun` varchar(100)
,`posisi` varchar(1)
,`kelompok` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_transaksi`
-- (See below for the actual view)
--
CREATE TABLE `view_transaksi` (
`id_transaksi` int(11)
,`waktu` datetime
,`sumber` varchar(10)
);

-- --------------------------------------------------------

--
-- Structure for view `view_coa`
--
DROP TABLE IF EXISTS `view_coa`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_coa`  AS  select `a`.`transaksi` AS `transaksi`,`a`.`kode_akun` AS `kode_akun`,`b`.`nama_akun` AS `nama_akun`,`a`.`posisi` AS `posisi`,`a`.`kelompok` AS `kelompok` from (`transaksi_coa` `a` join `coa` `b` on(`a`.`kode_akun` = `b`.`kode_akun`)) ;

-- --------------------------------------------------------

--
-- Structure for view `view_transaksi`
--
DROP TABLE IF EXISTS `view_transaksi`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_transaksi`  AS  select `pembelian`.`id_transaksi` AS `id_transaksi`,`pembelian`.`waktu_transaksi` AS `waktu`,'pembelian' AS `sumber` from `pembelian` union select `penjualan`.`id_transaksi` AS `id_transaksi`,`penjualan`.`waktu` AS `waktu`,'penjualan' AS `sumber` from `penjualan` union select `pembebanan`.`id_transaksi` AS `id_transaksi`,`pembebanan`.`waktu` AS `waktu`,'pembebanan' AS `sumber` from `pembebanan` union select `pemodalan`.`id_transaksi` AS `id_transaksi`,`pemodalan`.`waktu` AS `waktu`,'pemodalan' AS `sumber` from `pemodalan` order by 1 ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `akun_user`
--
ALTER TABLE `akun_user`
  ADD PRIMARY KEY (`id_user`);

--
-- Indexes for table `buah`
--
ALTER TABLE `buah`
  ADD PRIMARY KEY (`IdBuah`);

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coa`
--
ALTER TABLE `coa`
  ADD PRIMARY KEY (`kode_akun`);

--
-- Indexes for table `detail_pembelian`
--
ALTER TABLE `detail_pembelian`
  ADD PRIMARY KEY (`id_transaksi_pembelian`,`no_faktur`);

--
-- Indexes for table `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  ADD PRIMARY KEY (`id_transaksi_penjualan`);

--
-- Indexes for table `form_input`
--
ALTER TABLE `form_input`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jurnal_umum`
--
ALTER TABLE `jurnal_umum`
  ADD PRIMARY KEY (`id_transaksi`,`kode_akun`);

--
-- Indexes for table `pembelian`
--
ALTER TABLE `pembelian`
  ADD PRIMARY KEY (`no_faktur`,`id_supplier`);

--
-- Indexes for table `pemodalan`
--
ALTER TABLE `pemodalan`
  ADD PRIMARY KEY (`id_transaksi`);

--
-- Indexes for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD PRIMARY KEY (`id_penjualan`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`id_supplier`);

--
-- Indexes for table `transaksi_coa`
--
ALTER TABLE `transaksi_coa`
  ADD PRIMARY KEY (`transaksi`,`kode_akun`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `buah`
--
ALTER TABLE `buah`
  MODIFY `IdBuah` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `buku`
--
ALTER TABLE `buku`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `detail_pembelian`
--
ALTER TABLE `detail_pembelian`
  MODIFY `id_transaksi_pembelian` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- AUTO_INCREMENT for table `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  MODIFY `id_transaksi_penjualan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT for table `form_input`
--
ALTER TABLE `form_input`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
