-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 14 Apr 2022 pada 03.15
-- Versi server: 10.4.19-MariaDB
-- Versi PHP: 8.0.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kosan`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `akun`
--

CREATE TABLE `akun` (
  `username` varchar(50) NOT NULL,
  `pwd` varchar(32) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `user_group` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `akun`
--

INSERT INTO `akun` (`username`, `pwd`, `last_login`, `user_group`) VALUES
('admin', '21232f297a57a5a743894a0e4a801fc3', '2022-03-20 22:24:07', 'admin'),
('bambang', 'a9711cbb2e3c2d5fc97a63e45bbe5076', '2021-04-23 13:06:25', 'pemilik'),
('hendro', '66cb5177a2d8017b6e71983e95659388', '2021-04-27 11:02:35', 'pemilik'),
('tora', '8303220f39c4f57e9499733006a1d3cc', '2021-04-23 10:39:58', 'analis');

-- --------------------------------------------------------

--
-- Struktur dari tabel `buah`
--

CREATE TABLE `buah` (
  `IdBuah` int(11) NOT NULL DEFAULT 0,
  `NamaBuah` varchar(50) DEFAULT NULL,
  `Gambar` varchar(100) DEFAULT 'default.jpg',
  `Kategori` varchar(50) DEFAULT NULL,
  `Stok` int(11) DEFAULT NULL,
  `Harga` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `buah`
--

INSERT INTO `buah` (`IdBuah`, `NamaBuah`, `Gambar`, `Kategori`, `Stok`, `Harga`) VALUES
(1, 'Mangga', 'mangga.jpg', 'Lokal', 51, 10000),
(10, 'Semangka', 'manggis.jpg', 'Lokal', 23, 120000),
(12, 'Apel', '5e4025f8cf52e.jpg', 'Impor', 0, 25000),
(13, 'Pear', '5e4026268ce8b.jpg', 'Impor', 8, 20000),
(19, 'Durian', '5e427054beb33.jpg', 'Impor', 110, 100000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `coa`
--

CREATE TABLE `coa` (
  `id` int(11) NOT NULL,
  `kode_coa` varchar(100) NOT NULL,
  `nama_coa` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `coa`
--

INSERT INTO `coa` (`id`, `kode_coa`, `nama_coa`) VALUES
(1, '111', 'beban'),
(2, '112', 'Beban peralatan'),
(3, '113', 'beban perlengkapan'),
(4, '115', 'beban perlengkapan ');

-- --------------------------------------------------------

--
-- Struktur dari tabel `form_input`
--

CREATE TABLE `form_input` (
  `id` int(11) NOT NULL,
  `waktu` datetime NOT NULL,
  `dokumen` varchar(100) NOT NULL,
  `gambar` varchar(100) NOT NULL,
  `tanggal` date NOT NULL,
  `jenis` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `form_input`
--

INSERT INTO `form_input` (`id`, `waktu`, `dokumen`, `gambar`, `tanggal`, `jenis`) VALUES
(1, '2021-03-16 14:22:00', '60505d72d2f76.pdf', '60505d72d2f76.jpg', '2021-03-16', 'male');

-- --------------------------------------------------------

--
-- Struktur dari tabel `form_input_detail`
--

CREATE TABLE `form_input_detail` (
  `id` int(11) NOT NULL,
  `hobi` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `form_input_detail`
--

INSERT INTO `form_input_detail` (`id`, `hobi`) VALUES
(1, 'Musik');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jurnal`
--

CREATE TABLE `jurnal` (
  `id` int(11) NOT NULL,
  `id_transaksi` int(11) NOT NULL,
  `kode_akun` int(11) NOT NULL,
  `tgl_jurnal` date NOT NULL,
  `posisi_d_c` varchar(1) NOT NULL,
  `nominal` double NOT NULL,
  `kelompok` int(11) NOT NULL,
  `transaksi` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `jurnal`
--

INSERT INTO `jurnal` (`id`, `id_transaksi`, `kode_akun`, `tgl_jurnal`, `posisi_d_c`, `nominal`, `kelompok`, `transaksi`) VALUES
(1, 11, 111, '2021-03-11', 'd', 50000000, 1, 'pemodalan'),
(2, 11, 3, '2021-03-11', 'c', 50000000, 1, 'pemodalan'),
(3, 12, 32, '2021-03-11', 'd', 1000000, 2, 'pemodalan'),
(4, 12, 111, '2021-03-11', 'c', 1000000, 2, 'pemodalan'),
(5, 23, 51, '2021-03-05', 'd', 300000, 1, 'pembebanan'),
(6, 23, 111, '2021-03-05', 'c', 300000, 1, 'pembebanan'),
(7, 24, 113, '2021-03-13', 'd', 500000, 2, 'pembayaran'),
(8, 24, 231, '2021-03-13', 'c', 500000, 2, 'pembayaran'),
(9, 24, 111, '2021-03-13', 'd', 500000, 1, 'pembayaran'),
(10, 24, 113, '2021-03-13', 'c', 500000, 1, 'pembayaran'),
(11, 25, 111, '2021-03-13', 'd', 1000000, 1, 'pembayaran'),
(12, 25, 113, '2021-03-13', 'c', 1000000, 1, 'pembayaran'),
(13, 26, 113, '2021-03-16', 'd', 4000000, 2, 'pembayaran'),
(14, 26, 231, '2021-03-16', 'c', 4000000, 2, 'pembayaran'),
(15, 26, 111, '2021-03-16', 'd', 500000, 1, 'pembayaran'),
(16, 26, 113, '2021-03-16', 'c', 500000, 1, 'pembayaran'),
(17, 27, 111, '2021-03-20', 'd', 10000000, 1, 'pemodalan'),
(18, 27, 3, '2021-03-20', 'c', 10000000, 1, 'pemodalan'),
(22, 28, 231, '2021-02-28', 'd', 333333.3333, 3, 'pembayaran'),
(23, 28, 41, '2021-02-28', 'c', 333333.3333, 3, 'pembayaran'),
(24, 29, 111, '2021-03-20', 'd', 200000, 1, 'pembayaran'),
(25, 29, 113, '2021-03-20', 'c', 200000, 1, 'pembayaran'),
(26, 31, 111, '2021-04-16', 'd', 8000000, 1, 'pemodalan'),
(27, 31, 3, '2021-04-16', 'c', 8000000, 1, 'pemodalan'),
(29, 32, 111, '2021-04-16', 'd', 8000000, 1, 'pemodalan'),
(30, 32, 3, '2021-04-16', 'c', 8000000, 1, 'pemodalan'),
(32, 33, 111, '2021-04-07', 'd', 8000000, 1, 'pemodalan'),
(33, 33, 3, '2021-04-07', 'c', 8000000, 1, 'pemodalan'),
(34, 34, 111, '2021-03-31', 'd', 7000000, 1, 'pemodalan'),
(35, 34, 3, '2021-03-31', 'c', 7000000, 1, 'pemodalan'),
(37, 35, 111, '2021-04-09', 'd', 10000000, 1, 'pemodalan'),
(38, 35, 3, '2021-04-09', 'c', 10000000, 1, 'pemodalan'),
(40, 36, 32, '2021-04-09', 'd', 7000000, 2, 'pemodalan'),
(41, 36, 111, '2021-04-09', 'c', 7000000, 2, 'pemodalan'),
(42, 37, 231, '2021-04-30', 'd', 833333.3333, 3, 'pembayaran'),
(43, 37, 41, '2021-04-30', 'c', 833333.3333, 3, 'pembayaran'),
(45, 38, 231, '2021-04-30', 'd', 750, 3, 'pembayaran'),
(46, 38, 41, '2021-04-30', 'c', 750, 3, 'pembayaran'),
(48, 39, 231, '2021-04-30', 'd', 375000, 3, 'pembayaran'),
(49, 39, 41, '2021-04-30', 'c', 375000, 3, 'pembayaran'),
(51, 40, 231, '2021-04-30', 'd', 333333.3333, 3, 'pembayaran'),
(52, 40, 41, '2021-04-30', 'c', 333333.3333, 3, 'pembayaran'),
(54, 41, 231, '2021-04-30', 'd', 416666.6667, 3, 'pembayaran'),
(55, 41, 41, '2021-04-30', 'c', 416666.6667, 3, 'pembayaran'),
(56, 42, 113, '2021-10-14', 'd', 1000000, 2, 'pembayaran'),
(57, 42, 231, '2021-10-14', 'c', 1000000, 2, 'pembayaran'),
(59, 42, 111, '2021-10-14', 'd', 500000, 1, 'pembayaran'),
(60, 42, 113, '2021-10-14', 'c', 500000, 1, 'pembayaran'),
(61, 43, 111, '2021-10-20', 'd', 500000, 1, 'pembayaran'),
(62, 43, 113, '2021-10-20', 'c', 500000, 1, 'pembayaran');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kamar`
--

CREATE TABLE `kamar` (
  `id` int(11) NOT NULL,
  `id_kos` int(11) NOT NULL,
  `nomer` varchar(100) NOT NULL,
  `lantai` int(11) NOT NULL,
  `harga` int(11) NOT NULL,
  `status` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `kamar`
--

INSERT INTO `kamar` (`id`, `id_kos`, `nomer`, `lantai`, `harga`, `status`) VALUES
(1, 6, '101', 1, 5000000, 'Isi'),
(2, 6, '102', 1, 5000000, 'Isi'),
(3, 6, '103', 1, 9000, 'Isi'),
(4, 6, '104', 1, 5000000, 'Kosong'),
(5, 6, '105', 1, 5000000, 'Isi'),
(6, 6, '106', 1, 5000000, 'Kosong'),
(7, 6, '107', 1, 5000000, 'Kosong'),
(8, 6, '108', 1, 5000000, 'Kosong'),
(9, 6, '109', 1, 5000000, 'Kosong'),
(10, 6, '110', 1, 5000000, 'Kosong'),
(11, 6, '111', 1, 5000000, 'Kosong'),
(17, 6, '217', 2, 5000000, 'Kosong'),
(18, 6, '218', 2, 5000000, 'Kosong'),
(19, 6, '219', 2, 5000000, 'Kosong'),
(20, 6, '220', 2, 5000000, 'Kosong'),
(21, 6, '221', 2, 5000000, 'Kosong'),
(22, 6, '222', 2, 5000000, 'Kosong'),
(23, 6, '223', 2, 5000000, 'Kosong'),
(24, 6, '224', 2, 5000000, 'Kosong'),
(25, 6, '225', 2, 5000000, 'Kosong'),
(26, 6, '226', 2, 5000000, 'Kosong'),
(32, 6, '332', 3, 5000000, 'Isi'),
(33, 6, '333', 3, 5000000, 'Kosong'),
(34, 6, '334', 3, 5000000, 'Kosong'),
(35, 6, '335', 3, 5000000, 'Kosong'),
(36, 6, '336', 3, 5000000, 'Kosong'),
(37, 6, '337', 3, 5000000, 'Kosong'),
(38, 6, '338', 3, 5000000, 'Kosong'),
(39, 6, '339', 3, 5000000, 'Kosong'),
(40, 6, '340', 3, 5000000, 'Kosong'),
(41, 6, '341', 3, 5000000, 'Kosong'),
(47, 6, '302', 3, 5000000, 'Kosong'),
(48, 17, '101', 1, 5000000, 'Kosong'),
(49, 17, '302', 2, 5000000, 'Kosong'),
(51, 6, '112', 1, 7500000, 'Kosong'),
(52, 7, '101', 1, 15000000, 'Isi'),
(53, 7, '102', 2, 10000000, 'Isi');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kos`
--

CREATE TABLE `kos` (
  `id_kos` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `jenis_kos` varchar(25) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `telepon` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `kos`
--

INSERT INTO `kos` (`id_kos`, `nama`, `jenis_kos`, `alamat`, `telepon`) VALUES
(6, 'Milenial 1', 'Campur', 'Jl Menco 40', '081321405671'),
(7, 'Milenial 2', 'Laki-Laki', 'Jl Keagungan Ilahi No. 1', '081'),
(17, 'Milenial 3', 'Perempuan', 'Jl Kamboja No. 25 Cikancung Jabar', '0811123123131'),
(42, 'Milenial 3', 'Campur', 'bandung', '082334567889');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id_pembayaran` int(11) NOT NULL,
  `id_pemesanan` int(11) NOT NULL,
  `no_kuitansi` varchar(20) NOT NULL,
  `tgl_bayar` date NOT NULL,
  `besar_bayar` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `pembayaran`
--

INSERT INTO `pembayaran` (`id_pembayaran`, `id_pemesanan`, `no_kuitansi`, `tgl_bayar`, `besar_bayar`) VALUES
(5, 6, 'KWI-20210305-7-001', '2021-03-05', 1000000),
(6, 7, 'KWI-20210305-6-001', '2021-03-05', 1000),
(9, 10, 'KWI-20210305-6-001', '2021-03-06', 1000000),
(10, 11, 'KWI-20210306-6-001', '2021-03-06', 500000),
(18, 11, 'KWI-20210307-6-001', '2021-03-07', 500000),
(19, 11, 'KWI-20210307-6-002', '2021-03-07', 250000),
(20, 11, 'KWI-20210307-6-003', '2021-03-07', 750000),
(21, 7, 'KWI-20210307-6-004', '2021-03-07', 1000),
(22, 12, 'KWI-20210310-6-001', '2021-03-11', 5000000),
(23, 13, 'KWI-20210412-6-001', '2021-04-13', 5000000),
(24, 14, 'KWI-20210412-7-001', '2021-04-13', 5000000),
(25, 14, 'KWI-20210413-7-001', '2021-04-13', 5000000),
(42, 15, 'KWI-20211014-6-001', '2021-10-14', 500000),
(43, 15, 'KWI-20211020-6-001', '2021-10-20', 500000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pembayaran_payment_gateway`
--

CREATE TABLE `pembayaran_payment_gateway` (
  `id_pembayaran` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `gross_amount` int(11) NOT NULL,
  `payment_type` varchar(255) NOT NULL,
  `transaction_time` datetime NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `bill_key` int(11) NOT NULL,
  `biller_code` varchar(100) NOT NULL,
  `pdf_url` varchar(255) NOT NULL,
  `status_code` int(11) NOT NULL,
  `settlement_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pembebanan`
--

CREATE TABLE `pembebanan` (
  `id_transaksi` int(11) NOT NULL,
  `biaya` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `waktu` datetime NOT NULL,
  `id_kos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `pembebanan`
--

INSERT INTO `pembebanan` (`id_transaksi`, `biaya`, `nama`, `waktu`, `id_kos`) VALUES
(23, 300000, 'Listrik Bulan Maret 2021', '2021-03-05 00:00:00', 6);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pemesanan`
--

CREATE TABLE `pemesanan` (
  `id_pesan` int(11) NOT NULL,
  `id_penghuni` int(11) NOT NULL,
  `id_kamar` int(11) NOT NULL,
  `tgl_pesan` date NOT NULL,
  `tgl_mulai` date NOT NULL,
  `tgl_selesai` date NOT NULL,
  `status_bayar` varchar(100) NOT NULL,
  `status_kamar` varchar(100) NOT NULL,
  `harga_deal` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `pemesanan`
--

INSERT INTO `pemesanan` (`id_pesan`, `id_penghuni`, `id_kamar`, `tgl_pesan`, `tgl_mulai`, `tgl_selesai`, `status_bayar`, `status_kamar`, `harga_deal`) VALUES
(6, 3, 52, '2021-03-05', '2021-03-05', '2022-03-05', 'Belum Lunas', 'Isi', 10000000),
(7, 4, 32, '2021-03-05', '2021-03-04', '2022-03-04', 'Belum Lunas', 'Isi', 9000),
(10, 1, 5, '2021-03-06', '2021-03-05', '2022-03-05', 'Belum Lunas', 'Selesai', 4500000),
(11, 5, 5, '2021-03-06', '2021-03-06', '2021-09-06', 'Lunas', 'Isi', 2000000),
(12, 6, 2, '2021-03-11', '2021-03-11', '2022-03-11', 'Lunas', 'Isi', 5000000),
(13, 1, 1, '2021-04-13', '2021-04-08', '2022-04-08', 'Lunas', 'Isi', 5000000),
(14, 2, 53, '2021-04-13', '2021-04-13', '2022-04-13', 'Lunas', 'Isi', 10000000),
(15, 8, 3, '2021-10-14', '2021-10-14', '2022-10-14', 'Lunas', 'Isi', 1000000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pemilik_kos`
--

CREATE TABLE `pemilik_kos` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `id_kos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `pemilik_kos`
--

INSERT INTO `pemilik_kos` (`id`, `username`, `id_kos`) VALUES
(1, 'bambang', 6),
(2, 'bambang', 7),
(3, 'hendro', 17);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pemodalan`
--

CREATE TABLE `pemodalan` (
  `id_transaksi` int(11) NOT NULL,
  `besar` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `waktu` datetime NOT NULL,
  `id_kos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `pemodalan`
--

INSERT INTO `pemodalan` (`id_transaksi`, `besar`, `nama`, `waktu`, `id_kos`) VALUES
(11, 50000000, 'Modal Awal Bln Maret 2021', '2021-03-11 00:00:00', 6),
(12, 1000000, 'Penarikan Modal Untuk Kepentingan Pribadi', '2021-03-11 00:00:00', 6),
(27, 10000000, 'Modal Pertengahan Bulan Maret ke-2', '2021-03-20 00:00:00', 6),
(29, 8000000, 'Modal awal ', '2021-04-08 00:00:00', 6),
(30, 8000000, 'Modal awal ', '2021-04-23 00:00:00', 6),
(31, 8000000, 'Modal awal', '2021-04-16 00:00:00', 7),
(32, 8000000, 'Modal awal', '2021-04-16 00:00:00', 7),
(33, 8000000, 'Modal Awal', '2021-04-07 00:00:00', 7),
(34, 7000000, 'Modal awalll', '2021-03-31 00:00:00', 6),
(35, 10000000, 'Modal Kain', '2021-04-09 00:00:00', 6),
(36, 7000000, 'Tarik ', '2021-04-09 00:00:00', 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pendapatan`
--

CREATE TABLE `pendapatan` (
  `id_transaksi` int(11) NOT NULL,
  `besar_bayar` int(11) NOT NULL,
  `tgl_bayar` date NOT NULL,
  `id_pemesanan` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `pendapatan`
--

INSERT INTO `pendapatan` (`id_transaksi`, `besar_bayar`, `tgl_bayar`, `id_pemesanan`) VALUES
(28, 333333, '2021-02-28', 18),
(37, 833333, '2021-04-30', 6),
(38, 750, '2021-04-30', 7),
(39, 375000, '2021-04-30', 10),
(40, 333333, '2021-04-30', 11),
(41, 416667, '2021-04-30', 12);

-- --------------------------------------------------------

--
-- Struktur dari tabel `penghuni`
--

CREATE TABLE `penghuni` (
  `id` int(11) NOT NULL,
  `ktp` varchar(100) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telepon` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `penghuni`
--

INSERT INTO `penghuni` (`id`, `ktp`, `nama`, `email`, `telepon`) VALUES
(1, '1113123131', 'Hendro Suroto', 'hendro@gmail.com', '08132131321'),
(3, '11232123123', 'Maryono', 'maryono@d3sia.com', '9812312313123123'),
(4, '3-515-065-702-030-001', 'Sudibyo', 'sudib@desacerdas.id', '08-111-123-133'),
(5, '300-000-000-000', 'Sumarni', 'sumarni@gmail.com', '081-122-334-455'),
(6, '1-231-313-131-311', 'Sukaryo Bams', 'bambang@ngadirejo.com', '111-111-111-111'),
(7, '131-111-111-111-111', 'Sundari Sukoco', 'sundari@gmail.com', '08-111-222-333'),
(8, '111-321', 'Ratna Maulida', 'ratna@gmail.cpm', '081321771231');

-- --------------------------------------------------------

--
-- Struktur dari tabel `penjualan`
--

CREATE TABLE `penjualan` (
  `Region` varchar(100) NOT NULL,
  `Country` varchar(100) NOT NULL,
  `ItemType` varchar(100) NOT NULL,
  `SalesChannel` varchar(100) NOT NULL,
  `OrderPrio` varchar(10) NOT NULL,
  `OrderDate` date NOT NULL,
  `OrderId` float NOT NULL,
  `ShipDate` date NOT NULL,
  `UnitSold` float NOT NULL,
  `UnitPrice` float NOT NULL,
  `UnitCost` float NOT NULL,
  `TotalRevenue` float NOT NULL,
  `TotalCost` float NOT NULL,
  `TotalProfit` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `penjualan`
--

INSERT INTO `penjualan` (`Region`, `Country`, `ItemType`, `SalesChannel`, `OrderPrio`, `OrderDate`, `OrderId`, `ShipDate`, `UnitSold`, `UnitPrice`, `UnitCost`, `TotalRevenue`, `TotalCost`, `TotalProfit`) VALUES
('Australia and Oceania', 'Tuvalu', 'Baby Food', 'Offline', 'H', '2010-05-28', 669166000, '2010-06-27', 9925, 255.28, 159.42, 2533650, 1582240, 951410),
('Central America and the Caribbean', 'Grenada', 'Cereal', 'Online', 'C', '2012-08-22', 963881000, '2012-09-15', 2804, 205.7, 117.11, 576783, 328376, 248406),
('Europe', 'Russia', 'Office Supplies', 'Offline', 'L', '2014-05-02', 341417000, '2014-05-08', 1779, 651.21, 524.96, 1158500, 933904, 224599),
('Sub-Saharan Africa', 'Sao Tome and Principe', 'Fruits', 'Online', 'C', '2014-06-20', 514322000, '2014-07-05', 8102, 9.33, 6.92, 75591.7, 56065.8, 19525.8),
('Sub-Saharan Africa', 'Rwanda', 'Office Supplies', 'Offline', 'L', '2013-02-01', 115457000, '2013-02-06', 5062, 651.21, 524.96, 3296420, 2657350, 639078),
('Australia and Oceania', 'Solomon Islands', 'Baby Food', 'Online', 'C', '2015-02-04', 547996000, '2015-02-21', 2974, 255.28, 159.42, 759203, 474115, 285088),
('Sub-Saharan Africa', 'Angola', 'Household', 'Offline', 'M', '2011-04-23', 135425000, '2011-04-27', 4187, 668.27, 502.54, 2798050, 2104140, 693912),
('Sub-Saharan Africa', 'Burkina Faso', 'Vegetables', 'Online', 'H', '2012-07-17', 871544000, '2012-07-27', 8082, 154.06, 90.93, 1245110, 734896, 510217),
('Sub-Saharan Africa', 'Republic of the Congo', 'Personal Care', 'Offline', 'M', '2015-07-14', 770463000, '2015-08-25', 6070, 81.73, 56.67, 496101, 343987, 152114),
('Sub-Saharan Africa', 'Senegal', 'Cereal', 'Online', 'H', '2014-04-18', 616607000, '2014-05-30', 6593, 205.7, 117.11, 1356180, 772106, 584074),
('Asia', 'Kyrgyzstan', 'Vegetables', 'Online', 'H', '2011-06-24', 814712000, '2011-07-12', 124, 154.06, 90.93, 19103.4, 11275.3, 7828.12),
('Sub-Saharan Africa', 'Cape Verde', 'Clothes', 'Offline', 'H', '2014-08-02', 939826000, '2014-08-19', 4168, 109.28, 35.84, 455479, 149381, 306098),
('Asia', 'Bangladesh', 'Clothes', 'Online', 'L', '2017-01-13', 187311000, '2017-03-01', 8263, 109.28, 35.84, 902981, 296146, 606835),
('Central America and the Caribbean', 'Honduras', 'Household', 'Offline', 'H', '2017-02-08', 522840000, '2017-02-13', 8974, 668.27, 502.54, 5997060, 4509790, 1487260),
('Asia', 'Mongolia', 'Personal Care', 'Offline', 'C', '2014-02-19', 832401000, '2014-02-23', 4901, 81.73, 56.67, 400559, 277740, 122819),
('Europe', 'Bulgaria', 'Clothes', 'Online', 'M', '2012-04-23', 972292000, '2012-06-03', 1673, 109.28, 35.84, 182825, 59960.3, 122865),
('Asia', 'Sri Lanka', 'Cosmetics', 'Offline', 'M', '2016-11-19', 419124000, '2016-12-18', 6952, 437.2, 263.33, 3039410, 1830670, 1208740),
('Sub-Saharan Africa', 'Cameroon', 'Beverages', 'Offline', 'C', '2015-04-01', 519821000, '2015-04-18', 5430, 47.45, 31.79, 257654, 172620, 85033.8),
('Asia', 'Turkmenistan', 'Household', 'Offline', 'L', '2010-12-30', 441619000, '2011-01-20', 3830, 668.27, 502.54, 2559470, 1924730, 634746),
('Australia and Oceania', 'East Timor', 'Meat', 'Online', 'L', '2012-07-31', 322068000, '2012-09-11', 5908, 421.89, 364.69, 2492530, 2154590, 337938),
('Europe', 'Norway', 'Baby Food', 'Online', 'L', '2014-05-14', 819028000, '2014-06-28', 7450, 255.28, 159.42, 1901840, 1187680, 714157),
('Europe', 'Portugal', 'Baby Food', 'Online', 'H', '2015-07-31', 860674000, '2015-09-03', 1273, 255.28, 159.42, 324971, 202942, 122030),
('Central America and the Caribbean', 'Honduras', 'Snacks', 'Online', 'L', '2016-06-30', 795491000, '2016-07-26', 2225, 152.58, 97.44, 339490, 216804, 122686),
('Australia and Oceania', 'New Zealand', 'Fruits', 'Online', 'H', '2014-09-08', 142278000, '2014-10-04', 2187, 9.33, 6.92, 20404.7, 15134, 5270.67),
('Europe', 'Moldova ', 'Personal Care', 'Online', 'L', '2016-05-07', 740148000, '2016-05-10', 5070, 81.73, 56.67, 414371, 287317, 127054),
('Europe', 'France', 'Cosmetics', 'Online', 'H', '2017-05-22', 898523000, '2017-06-05', 1815, 437.2, 263.33, 793518, 477944, 315574),
('Australia and Oceania', 'Kiribati', 'Fruits', 'Online', 'M', '2014-10-13', 347140000, '2014-11-10', 5398, 9.33, 6.92, 50363.3, 37354.2, 13009.2),
('Sub-Saharan Africa', 'Mali', 'Fruits', 'Online', 'L', '2010-05-07', 686048000, '2010-05-10', 5822, 9.33, 6.92, 54319.3, 40288.2, 14031),
('Europe', 'Norway', 'Beverages', 'Offline', 'C', '2014-07-18', 435609000, '2014-07-30', 5124, 47.45, 31.79, 243134, 162892, 80241.8),
('Sub-Saharan Africa', 'The Gambia', 'Household', 'Offline', 'L', '2012-05-26', 886495000, '2012-06-09', 2370, 668.27, 502.54, 1583800, 1191020, 392780),
('Europe', 'Switzerland', 'Cosmetics', 'Offline', 'M', '2012-09-17', 249693000, '2012-10-20', 8661, 437.2, 263.33, 3786590, 2280700, 1505890),
('Sub-Saharan Africa', 'South Sudan', 'Personal Care', 'Offline', 'C', '2013-12-29', 406503000, '2014-01-28', 2125, 81.73, 56.67, 173676, 120424, 53252.5),
('Australia and Oceania', 'Australia', 'Office Supplies', 'Online', 'C', '2015-10-27', 158535000, '2015-11-25', 2924, 651.21, 524.96, 1904140, 1534980, 369155),
('Asia', 'Myanmar', 'Household', 'Offline', 'H', '2015-01-16', 177714000, '2015-03-01', 8250, 668.27, 502.54, 5513230, 4145960, 1367270),
('Sub-Saharan Africa', 'Djibouti', 'Snacks', 'Online', 'M', '2017-02-25', 756275000, '2017-02-25', 7327, 152.58, 97.44, 1117950, 713943, 404011),
('Central America and the Caribbean', 'Costa Rica', 'Personal Care', 'Offline', 'L', '2017-05-08', 456767000, '2017-05-21', 6409, 81.73, 56.67, 523808, 363198, 160610),
('Middle East and North Africa', 'Syria', 'Fruits', 'Online', 'L', '2011-11-22', 162052000, '2011-12-03', 3784, 9.33, 6.92, 35304.7, 26185.3, 9119.44),
('Sub-Saharan Africa', 'The Gambia', 'Meat', 'Online', 'M', '2017-01-14', 825304000, '2017-01-23', 4767, 421.89, 364.69, 2011150, 1738480, 272672),
('Asia', 'Brunei', 'Office Supplies', 'Online', 'L', '2012-04-01', 320009000, '2012-05-08', 6708, 651.21, 524.96, 4368320, 3521430, 846885),
('Europe', 'Bulgaria', 'Office Supplies', 'Online', 'M', '2012-02-16', 189966000, '2012-02-28', 3987, 651.21, 524.96, 2596370, 2093020, 503359),
('Sub-Saharan Africa', 'Niger', 'Personal Care', 'Online', 'H', '2017-03-11', 699286000, '2017-03-28', 3015, 81.73, 56.67, 246416, 170860, 75555.9),
('Middle East and North Africa', 'Azerbaijan', 'Cosmetics', 'Online', 'M', '2010-02-06', 382392000, '2010-02-25', 7234, 437.2, 263.33, 3162700, 1904930, 1257780),
('Sub-Saharan Africa', 'The Gambia', 'Cereal', 'Offline', 'H', '2012-06-07', 994022000, '2012-06-08', 2117, 205.7, 117.11, 435467, 247922, 187545),
('Europe', 'Slovakia', 'Vegetables', 'Online', 'H', '2012-10-06', 759224000, '2012-11-10', 171, 154.06, 90.93, 26344.3, 15549, 10795.2),
('Asia', 'Myanmar', 'Clothes', 'Online', 'H', '2015-11-14', 223360000, '2015-11-18', 5930, 109.28, 35.84, 648030, 212531, 435499),
('Sub-Saharan Africa', 'Comoros', 'Cereal', 'Offline', 'H', '2016-03-29', 902102000, '2016-04-29', 962, 205.7, 117.11, 197883, 112660, 85223.6),
('Europe', 'Iceland', 'Cosmetics', 'Online', 'C', '2016-12-31', 331438000, '2016-12-31', 8867, 437.2, 263.33, 3876650, 2334950, 1541710),
('Europe', 'Switzerland', 'Personal Care', 'Online', 'M', '2010-12-23', 617667000, '2011-01-31', 273, 81.73, 56.67, 22312.3, 15470.9, 6841.38),
('Europe', 'Macedonia', 'Clothes', 'Offline', 'C', '2014-10-14', 787399000, '2014-11-14', 7842, 109.28, 35.84, 856974, 281057, 575916),
('Sub-Saharan Africa', 'Mauritania', 'Office Supplies', 'Offline', 'C', '2012-01-11', 837559000, '2012-01-13', 1266, 651.21, 524.96, 824432, 664599, 159832),
('Europe', 'Albania', 'Clothes', 'Online', 'C', '2010-02-02', 385383000, '2010-03-18', 2269, 109.28, 35.84, 247956, 81321, 166635),
('Sub-Saharan Africa', 'Lesotho', 'Fruits', 'Online', 'L', '2013-08-18', 918420000, '2013-09-18', 9606, 9.33, 6.92, 89624, 66473.5, 23150.5),
('Middle East and North Africa', 'Saudi Arabia', 'Cereal', 'Online', 'M', '2013-03-25', 844530000, '2013-03-28', 4063, 205.7, 117.11, 835759, 475818, 359941),
('Sub-Saharan Africa', 'Sierra Leone', 'Office Supplies', 'Offline', 'M', '2011-11-26', 441888000, '2012-01-07', 3457, 651.21, 524.96, 2251230, 1814790, 436446),
('Sub-Saharan Africa', 'Sao Tome and Principe', 'Fruits', 'Offline', 'H', '2013-09-17', 508981000, '2013-10-24', 7637, 9.33, 6.92, 71253.2, 52848, 18405.2),
('Sub-Saharan Africa', 'Cote d\'Ivoire', 'Clothes', 'Online', 'C', '2012-06-08', 114607000, '2012-06-27', 3482, 109.28, 35.84, 380513, 124795, 255718),
('Australia and Oceania', 'Fiji', 'Clothes', 'Offline', 'C', '2010-06-30', 647876000, '2010-08-01', 9905, 109.28, 35.84, 1082420, 354995, 727423),
('Europe', 'Austria', 'Cosmetics', 'Offline', 'H', '2015-02-23', 868215000, '2015-03-02', 2847, 437.2, 263.33, 1244710, 749700, 495008),
('Europe', 'United Kingdom', 'Household', 'Online', 'L', '2012-01-05', 955357000, '2012-02-14', 282, 668.27, 502.54, 188452, 141716, 46735.9),
('Sub-Saharan Africa', 'Djibouti', 'Cosmetics', 'Offline', 'H', '2014-04-07', 259353000, '2014-04-19', 7215, 437.2, 263.33, 3154400, 1899930, 1254470),
('Australia and Oceania', 'Australia', 'Cereal', 'Offline', 'H', '2013-06-09', 450564000, '2013-07-02', 682, 205.7, 117.11, 140287, 79869, 60418.4),
('Europe', 'San Marino', 'Baby Food', 'Online', 'L', '2013-06-26', 569663000, '2013-07-01', 4750, 255.28, 159.42, 1212580, 757245, 455335),
('Sub-Saharan Africa', 'Cameroon', 'Office Supplies', 'Online', 'M', '2011-11-07', 177637000, '2011-11-15', 5518, 651.21, 524.96, 3593380, 2896730, 696648),
('Middle East and North Africa', 'Libya', 'Clothes', 'Offline', 'H', '2010-10-30', 705784000, '2010-11-17', 6116, 109.28, 35.84, 668356, 219197, 449159),
('Central America and the Caribbean', 'Haiti', 'Cosmetics', 'Offline', 'H', '2013-10-13', 505717000, '2013-11-16', 1705, 437.2, 263.33, 745426, 448978, 296448),
('Sub-Saharan Africa', 'Rwanda', 'Cosmetics', 'Offline', 'H', '2013-10-11', 699358000, '2013-11-25', 4477, 437.2, 263.33, 1957340, 1178930, 778416),
('Sub-Saharan Africa', 'Gabon', 'Personal Care', 'Offline', 'L', '2012-07-08', 228945000, '2012-07-09', 8656, 81.73, 56.67, 707455, 490536, 216919),
('Central America and the Caribbean', 'Belize', 'Clothes', 'Offline', 'M', '2016-07-25', 807025000, '2016-09-07', 5498, 109.28, 35.84, 600821, 197048, 403773),
('Europe', 'Lithuania', 'Office Supplies', 'Offline', 'H', '2010-10-24', 166461000, '2010-11-17', 8287, 651.21, 524.96, 5396580, 4350340, 1046230),
('Sub-Saharan Africa', 'Madagascar', 'Clothes', 'Offline', 'L', '2015-04-25', 610426000, '2015-05-28', 7342, 109.28, 35.84, 802334, 263137, 539196),
('Asia', 'Turkmenistan', 'Office Supplies', 'Online', 'M', '2013-04-23', 462406000, '2013-05-20', 5010, 651.21, 524.96, 3262560, 2630050, 632512),
('Middle East and North Africa', 'Libya', 'Fruits', 'Online', 'L', '2015-08-14', 816200000, '2015-09-30', 673, 9.33, 6.92, 6279.09, 4657.16, 1621.93),
('Sub-Saharan Africa', 'Democratic Republic of the Congo', 'Beverages', 'Online', 'C', '2011-05-26', 585920000, '2011-07-15', 5741, 47.45, 31.79, 272410, 182506, 89904.1),
('Sub-Saharan Africa', 'Djibouti', 'Cereal', 'Online', 'H', '2017-05-20', 555990000, '2017-06-17', 8656, 205.7, 117.11, 1780540, 1013700, 766835),
('Middle East and North Africa', 'Pakistan', 'Cosmetics', 'Offline', 'L', '2013-07-05', 231145000, '2013-08-16', 9892, 437.2, 263.33, 4324780, 2604860, 1719920),
('North America', 'Mexico', 'Household', 'Offline', 'C', '2014-11-06', 986435000, '2014-12-12', 6954, 668.27, 502.54, 4647150, 3494660, 1152490),
('Australia and Oceania', 'Federated States of Micronesia', 'Beverages', 'Online', 'C', '2014-10-28', 217221000, '2014-11-15', 9379, 47.45, 31.79, 445034, 298158, 146875),
('Asia', 'Laos', 'Vegetables', 'Offline', 'C', '2011-09-15', 789177000, '2011-10-23', 3732, 154.06, 90.93, 574952, 339351, 235601),
('Europe', 'Monaco', 'Baby Food', 'Offline', 'H', '2012-05-29', 688288000, '2012-06-02', 8614, 255.28, 159.42, 2198980, 1373240, 825738),
('Australia and Oceania', 'Samoa ', 'Cosmetics', 'Online', 'H', '2013-07-20', 670855000, '2013-08-07', 9654, 437.2, 263.33, 4220730, 2542190, 1678540),
('Europe', 'Spain', 'Household', 'Offline', 'L', '2012-10-21', 213487000, '2012-11-30', 4513, 668.27, 502.54, 3015900, 2267960, 747940),
('Middle East and North Africa', 'Lebanon', 'Clothes', 'Online', 'L', '2012-09-18', 663110000, '2012-10-08', 7884, 109.28, 35.84, 861564, 282563, 579001),
('Middle East and North Africa', 'Iran', 'Cosmetics', 'Online', 'H', '2016-11-15', 286959000, '2016-12-08', 6489, 437.2, 263.33, 2836990, 1708750, 1128240),
('Sub-Saharan Africa', 'Zambia', 'Snacks', 'Online', 'L', '2011-01-04', 122584000, '2011-01-05', 4085, 152.58, 97.44, 623289, 398042, 225247),
('Sub-Saharan Africa', 'Kenya', 'Vegetables', 'Online', 'L', '2012-03-18', 827845000, '2012-04-07', 6457, 154.06, 90.93, 994765, 587135, 407630),
('North America', 'Mexico', 'Personal Care', 'Offline', 'L', '2012-02-17', 430916000, '2012-03-20', 6422, 81.73, 56.67, 524870, 363935, 160935),
('Sub-Saharan Africa', 'Sao Tome and Principe', 'Beverages', 'Offline', 'C', '2011-01-16', 180284000, '2011-01-21', 8829, 47.45, 31.79, 418936, 280674, 138262),
('Sub-Saharan Africa', 'The Gambia', 'Baby Food', 'Offline', 'M', '2014-02-03', 494747000, '2014-03-20', 5559, 255.28, 159.42, 1419100, 886216, 532886),
('Middle East and North Africa', 'Kuwait', 'Fruits', 'Online', 'M', '2012-04-30', 513418000, '2012-05-18', 522, 9.33, 6.92, 4870.26, 3612.24, 1258.02),
('Europe', 'Slovenia', 'Beverages', 'Offline', 'C', '2016-10-23', 345719000, '2016-11-25', 4660, 47.45, 31.79, 221117, 148141, 72975.6),
('Sub-Saharan Africa', 'Sierra Leone', 'Office Supplies', 'Offline', 'H', '2016-12-06', 621387000, '2016-12-14', 948, 651.21, 524.96, 617347, 497662, 119685),
('Australia and Oceania', 'Australia', 'Beverages', 'Offline', 'H', '2014-07-07', 240470000, '2014-07-11', 9389, 47.45, 31.79, 445508, 298476, 147032),
('Middle East and North Africa', 'Azerbaijan', 'Office Supplies', 'Online', 'M', '2012-06-13', 423331000, '2012-07-24', 2021, 651.21, 524.96, 1316100, 1060940, 255151),
('Europe', 'Romania', 'Cosmetics', 'Online', 'H', '2010-11-26', 660643000, '2010-12-25', 7910, 437.2, 263.33, 3458250, 2082940, 1375310),
('Central America and the Caribbean', 'Nicaragua', 'Beverages', 'Offline', 'C', '2011-02-08', 963393000, '2011-03-21', 8156, 47.45, 31.79, 387002, 259279, 127723),
('Sub-Saharan Africa', 'Mali', 'Clothes', 'Online', 'M', '2011-07-26', 512878000, '2011-09-03', 888, 109.28, 35.84, 97040.6, 31825.9, 65214.7),
('Asia', 'Malaysia', 'Fruits', 'Offline', 'L', '2011-11-11', 810711000, '2011-12-28', 6267, 9.33, 6.92, 58471.1, 43367.6, 15103.5),
('Sub-Saharan Africa', 'Sierra Leone', 'Vegetables', 'Offline', 'C', '2016-06-01', 728815000, '2016-06-29', 1485, 154.06, 90.93, 228779, 135031, 93748),
('North America', 'Mexico', 'Personal Care', 'Offline', 'M', '2015-07-30', 559427000, '2015-08-08', 5767, 81.73, 56.67, 471337, 326816, 144521),
('Sub-Saharan Africa', 'Mozambique', 'Household', 'Offline', 'L', '2012-02-10', 665095000, '2012-02-15', 5367, 668.27, 502.54, 3586600, 2697130, 889473);

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi_coa`
--

CREATE TABLE `transaksi_coa` (
  `transaksi` varchar(100) NOT NULL,
  `kode_akun` int(11) NOT NULL,
  `posisi` varchar(1) NOT NULL,
  `kelompok` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `transaksi_coa`
--

INSERT INTO `transaksi_coa` (`transaksi`, `kode_akun`, `posisi`, `kelompok`) VALUES
('pemodalan', 111, 'd', 1),
('pemodalan', 3, 'c', 1),
('pemodalan', 32, 'd', 2),
('pemodalan', 111, 'c', 2),
('pembayaran', 111, 'd', 1),
('pembayaran', 113, 'c', 1),
('pembayaran', 113, 'd', 2),
('pembayaran', 231, 'c', 2),
('pembayaran', 231, 'd', 3),
('pembayaran', 41, 'c', 3),
('pembebanan', 51, 'd', 1),
('pembebanan', 111, 'c', 1);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_transaksi`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_transaksi` (
`id_transaksi` int(11)
,`waktu` datetime
,`sumber` varchar(10)
);

-- --------------------------------------------------------

--
-- Struktur untuk view `view_transaksi`
--
DROP TABLE IF EXISTS `view_transaksi`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_transaksi`  AS SELECT `pembebanan`.`id_transaksi` AS `id_transaksi`, `pembebanan`.`waktu` AS `waktu`, 'pembebanan' AS `sumber` FROM `pembebanan` ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `akun`
--
ALTER TABLE `akun`
  ADD PRIMARY KEY (`username`);

--
-- Indeks untuk tabel `buah`
--
ALTER TABLE `buah`
  ADD PRIMARY KEY (`IdBuah`);

--
-- Indeks untuk tabel `coa`
--
ALTER TABLE `coa`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `form_input`
--
ALTER TABLE `form_input`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `jurnal`
--
ALTER TABLE `jurnal`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `kamar`
--
ALTER TABLE `kamar`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `kos`
--
ALTER TABLE `kos`
  ADD PRIMARY KEY (`id_kos`);

--
-- Indeks untuk tabel `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id_pembayaran`);

--
-- Indeks untuk tabel `pembayaran_payment_gateway`
--
ALTER TABLE `pembayaran_payment_gateway`
  ADD PRIMARY KEY (`id_pembayaran`);

--
-- Indeks untuk tabel `pembebanan`
--
ALTER TABLE `pembebanan`
  ADD PRIMARY KEY (`id_transaksi`);

--
-- Indeks untuk tabel `pemesanan`
--
ALTER TABLE `pemesanan`
  ADD PRIMARY KEY (`id_pesan`);

--
-- Indeks untuk tabel `pemilik_kos`
--
ALTER TABLE `pemilik_kos`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `pemodalan`
--
ALTER TABLE `pemodalan`
  ADD PRIMARY KEY (`id_transaksi`);

--
-- Indeks untuk tabel `pendapatan`
--
ALTER TABLE `pendapatan`
  ADD PRIMARY KEY (`id_transaksi`);

--
-- Indeks untuk tabel `penghuni`
--
ALTER TABLE `penghuni`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `coa`
--
ALTER TABLE `coa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `form_input`
--
ALTER TABLE `form_input`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `jurnal`
--
ALTER TABLE `jurnal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT untuk tabel `kamar`
--
ALTER TABLE `kamar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT untuk tabel `kos`
--
ALTER TABLE `kos`
  MODIFY `id_kos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT untuk tabel `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `id_pembayaran` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT untuk tabel `pemesanan`
--
ALTER TABLE `pemesanan`
  MODIFY `id_pesan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT untuk tabel `pemilik_kos`
--
ALTER TABLE `pemilik_kos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `penghuni`
--
ALTER TABLE `penghuni`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
