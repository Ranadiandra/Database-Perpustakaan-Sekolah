-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 23 Feb 2025 pada 15.11
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbperpustakaan`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteBuku` (`pId_buku` INT)   BEGIN
DELETE FROM buku where id_buku = pId_buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePeminjaman` (`pId_peminjaman` INT)   BEGIN 
DELETE FROM peminjaman WHERE id_peminjaman = pId_peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteSiswa` (`pId_siswa` INT)   BEGIN 
DELETE FROM siswa WHERE id_siswa = pId_siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertBuku` (`pJudul_buku` VARCHAR(100), `pPenulis` VARCHAR(100), `pKategori` VARCHAR(100), `pStok` INT)   BEGIN 
INSERT INTO buku (judul_buku, penulis, kategori, stok)
VALUES (pJudul_buku, pPenulis, pKategori, pStok);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertPeminjaman` (`pId_siswa` INT, `pId_buku` INT, `pTanggal_pinjam` DATE, `pTanggal_kembali` DATE, `pStatus` VARCHAR(20))   BEGIN
INSERT INTO peminjaman(id_siswa, id_buku, tanggal_pinjam, tanggal_kembali, status)
VALUES(pId_siswa, pId_buku, pTanggal_pinjam, pTanggal_kembali, pStatus);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertSiswa` (`pNama_siswa` VARCHAR(100), `pKelas` VARCHAR(20))   BEGIN
INSERT INTO siswa(nama_siswa, kelas) 
    VALUES (pNama_siswa, pKelas);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `returnBuku` (`pId_peminjaman` INT)   BEGIN
UPDATE peminjaman 
SET status = 'Dikembalikan', tanggal_kembali = CURRENT_DATE
WHERE id_peminjaman = pId_peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `semua_buku` ()   BEGIN
SELECT buku.id_buku, buku.judul_buku, buku.penulis, buku.kategori, buku.stok,
CASE
WHEN peminjaman.id_peminjaman IS NOT NULL THEN 'Pernah dipinjam'
ELSE 'Belum pernah dipinjam'
END AS 'status_pinjam'
FROM buku
LEFT JOIN peminjaman ON buku.id_buku = peminjaman.id_buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `semua_siswa` ()   BEGIN
SELECT siswa.id_siswa, siswa.nama_siswa, siswa.kelas,
CASE
WHEN peminjaman.id_peminjaman is NOT NULL THEN 'Pernah meminjam'
ELSE 'Belum pernah meminjam'
END as status_peminjaman
FROM siswa 
LEFT join peminjaman ON siswa.id_siswa = peminjaman.id_siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showBuku` ()   BEGIN
SELECT * FROM buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showPeminjaman` ()   BEGIN
SELECT * FROM peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showSiswa` ()   BEGIN
SELECT * FROM siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `siswaPernahPinjam` ()   BEGIN 
SELECT nama_siswa, kelas FROM siswa 
INNER JOIN peminjaman ON siswa.id_siswa = peminjaman.id_siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateBuku` (`pId_buku` INT, `pJudul_buku` VARCHAR(100), `pPenulis` VARCHAR(100), `pKategori` VARCHAR(100), `pStok` INT)   BEGIN
UPDATE buku SET 
	judul_buku = pJudul_buku,
    penulis = pPenulis,
    kategori = pKategori,
    stok = pStok
WHERE id_buku = pId_buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updatePeminjaman` (`pId_peminjaman` INT, `pId_siswa` INT, `pId_buku` INT, `pTanggal_pinjam` DATE, `pTanggal_kembali` DATE, `pStatus` VARCHAR(20))   BEGIN
    UPDATE peminjaman 
    SET id_siswa = pId_siswa, id_buku = pId_buku, tanggal_pinjam = pTanggal_pinjam, 			tanggal_kembali = pTanggal_kembali, status = pStatus
    WHERE id_peminjaman = pId_peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateSiswa` (`pId_siswa` INT, `pNama_siswa` VARCHAR(100), `pKelas` VARCHAR(20))   BEGIN 
UPDATE siswa SET 
    nama_siswa = pNama_siswa,
    kelas = pKelas
WHERE id_siswa = pId_siswa;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `buku`
--

CREATE TABLE `buku` (
  `id_buku` int(11) NOT NULL,
  `judul_buku` varchar(100) DEFAULT NULL,
  `penulis` varchar(100) DEFAULT NULL,
  `kategori` varchar(100) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `buku`
--

INSERT INTO `buku` (`id_buku`, `judul_buku`, `penulis`, `kategori`, `stok`) VALUES
(1, 'Algoritma dan Pemrograman', 'Andi Wijaya', 'Teknologi', 5),
(2, 'Dasar-Dasar Dtabase', 'Budi Santoso', 'Teknologi', 7),
(3, 'Matematika Diskrit', 'Rina sari', 'Matematika', 4),
(4, 'Sejarah Dunia', 'John Smith', 'Sejarah', 3),
(5, 'Pemrograman Web dengan PHP', 'Eko Prasetyo', 'Teknologi', 8),
(6, 'Sistem Operasi', 'Dian Kurniawan', 'Teknologi', 6),
(7, 'Jaringan Komputer', 'Ahmad Fauzi', 'Teknologi', 5),
(8, 'Cerita Rakyat Nusantara', 'Lestari Dewi', 'Sasta', 9),
(9, 'Bahasa Inggris untuk Pemula', 'Jane Doe', 'Bahasa', 10),
(10, 'Biologi Dasar', 'Budi Rahman', 'Sains', 7),
(11, 'Kimia Organik', 'Siti Aminah', 'Sains', 5),
(12, 'Teknik Elektro', 'Ridwan Hakim', 'Teknik', 6),
(13, 'Fisika Modern', 'Albert Einstein', 'Sains', 4),
(14, 'Manajemen Waktu', 'Steven Covey', 'Pengembangan', 8),
(15, 'Strategi Belajar Efektif', 'Tony Buzan', 'Pendidikan', 6);

-- --------------------------------------------------------

--
-- Struktur dari tabel `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id_peminjaman` int(11) NOT NULL,
  `id_siswa` int(11) DEFAULT NULL,
  `id_buku` int(11) DEFAULT NULL,
  `tanggal_pinjam` date DEFAULT NULL,
  `tanggal_kembali` date DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `peminjaman`
--

INSERT INTO `peminjaman` (`id_peminjaman`, `id_siswa`, `id_buku`, `tanggal_pinjam`, `tanggal_kembali`, `status`) VALUES
(1, 11, 2, '2025-02-01', '2025-02-08', 'Dipinjam'),
(2, 2, 5, '2025-01-28', '2025-02-04', 'Dikembalikan'),
(3, 3, 8, '2025-02-02', '2025-02-09', 'Dipinjam'),
(4, 4, 10, '2025-01-30', '2025-02-06', 'Dikembalikan'),
(5, 5, 3, '2025-01-25', '2025-02-01', 'Dikembalikan'),
(6, 15, 7, '2025-02-01', '2025-02-08', 'Dipinjam'),
(7, 7, 1, '2025-01-29', '2025-02-05', 'Dikembalikan'),
(8, 8, 9, '2025-02-02', '2025-02-10', 'Dipinjam'),
(9, 13, 4, '2025-01-27', '2025-02-03', 'Dikembalikan'),
(10, 10, 11, '2025-02-01', '2025-02-08', 'Dipinjam');

--
-- Trigger `peminjaman`
--
DELIMITER $$
CREATE TRIGGER `stok_kurang` AFTER INSERT ON `peminjaman` FOR EACH ROW BEGIN
    UPDATE buku SET stok = stok - 1 WHERE id_buku = NEW.id_buku;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `stok_tambah` AFTER UPDATE ON `peminjaman` FOR EACH ROW BEGIN
	IF new.status = 'Dikembalikan' THEN
    UPDATE buku SET stok = stok + 1 WHERE id_buku = new.id_buku;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `siswa`
--

CREATE TABLE `siswa` (
  `id_siswa` int(11) NOT NULL,
  `nama_siswa` varchar(100) DEFAULT NULL,
  `kelas` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `siswa`
--

INSERT INTO `siswa` (`id_siswa`, `nama_siswa`, `kelas`) VALUES
(1, 'Andi Saputra', 'X-RPL'),
(2, 'Budi Wijaya', 'X-TKJ'),
(3, 'Citra Lestari', 'XI-RPL'),
(4, 'Dewi Kurniawan', 'XI-TKJ'),
(5, 'Eko Prasetyo', 'XII-RPL'),
(6, 'Farhan Maulana', 'XII-TKJ'),
(7, 'Gita Permata', 'X-RPL'),
(8, 'Hadi Sucipto', 'X-TKJ'),
(9, 'Intan Permadi', 'XI-RPL'),
(10, 'Joko Santoso', 'XI-TKJ'),
(11, 'Kartika Sari', 'XII-RPL'),
(12, 'Lintang Putri', 'XII-TKJ'),
(13, 'Muhammad Rizky', 'X-RPL'),
(14, 'Novi Andriana', 'X-TKJ'),
(15, 'Olivia Hernanda', 'XI-RPL');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id_buku`);

--
-- Indeks untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`);

--
-- Indeks untuk tabel `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`id_siswa`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `buku`
--
ALTER TABLE `buku`
  MODIFY `id_buku` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id_peminjaman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id_siswa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
