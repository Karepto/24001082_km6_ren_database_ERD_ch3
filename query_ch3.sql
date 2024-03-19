-- Active: 1710511749892@@127.0.0.1@5432@bank

-- pembuatan database bank
CREATE DATABASE bank;

CREATE Table nasabah (
    id bigserial PRIMARY KEY,
    nama varchar(255) NOT NULL,
    alamat varchar(255) NOT NULL,
    email varchar(255) NOT NULL UNIQUE
);

-- pembuatan table database bank
CREATE Table daftar_akun (
    id bigserial PRIMARY KEY,
    id_nasabah INT NOT NULL,
    id_akun INT NOT NULL
);

CREATE Table akun (
    id bigserial PRIMARY KEY,
    no_rekening varchar(255) NOT NULL UNIQUE,
    saldo int NOT NULL,
    tgl_dibuat date NOT NULL,
    email varchar(255) NOT NULL UNIQUE,
    password varchar(255) NOT NULL
);

CREATE table transaksi (
    id bigserial PRIMARY KEY,
    tgl_transaksi date NOT NULL,
    deskripsi varchar(255) NOT NULL
);

create Table detail_transaksi (
    id bigserial PRIMARY KEY,
    id_akun int NOT NULL,
    id_transaksi int NOT NULL,
    tipe_transaksi VARCHAR(255) NOT NULL,
    nominal int NOT NULL
);

-- Query Create (insert)
INSERT INTO nasabah (nama, alamat, email)
VALUES ('Ahmad', 'Nganjuk', 'Ahmad@gmail.com'),
('Budi', 'Jember', 'Budi@gmail.com'),
('Caca', 'Surabaya', 'Caca@gmail.com');

INSERT INTO akun (no_rekening, saldo, tgl_dibuat, email, password) 
VALUES('123456', 1000000, '2022-01-01', 'Ahmad@gmail.com', '123456'),
('678901', 1000000, '2022-01-01', 'Ahmad2@gmail.com', '123456'),
('123457', 1000000, '2022-01-01', 'Budi@gmail.com', '123456');

INSERT into daftar_akun (id_nasabah, id_akun)
VALUES (1, 1),
(1, 2),
(2, 3);

INSERT into transaksi (tgl_transaksi, deskripsi)
VALUES ('2022-01-01', 'penarikan dan setoran di atm hotel'),
('2022-01-01', 'penarikan di atm bank'),
('2022-01-04', 'transfer ke rekening bank di atm minimarket');

INSERT into transaksi (tgl_transaksi, deskripsi)
VALUES 
('2022-01-06', 'transfer ke rekening bank lain di atm bank');

INSERT INTO detail_transaksi (id_akun, id_transaksi, tipe_transaksi, nominal)
VALUES (1, 1, 'withdraw', 100000),
(1, 1, 'deposit', 200000),
(3, 2, 'withdraw', 200000),
(3, 3, 'transfer', 300000),
(1, 4, 'transfer', 400000);

-- Query Read
SELECT * FROM nasabah;
SELECT * FROM akun;
SELECT * FROM daftar_akun;
SELECT * FROM transaksi;
SELECT * FROM detail_transaksi;

-- Query Read dengan Join untuk memperlihatkan nasabah dan akunnya
SELECT nasabah.id, nasabah.nama, nasabah.alamat, nasabah.email, akun.no_rekening, akun.saldo, akun.tgl_dibuat
FROM nasabah
JOIN daftar_akun
ON nasabah.id = daftar_akun.id_nasabah
JOIN akun
ON daftar_akun.id_akun = akun.id;

-- Query Read dengan Join untuk memperlihatkan riwayat transaksi
SELECT nasabah.id, nasabah.nama, nasabah.alamat, nasabah.email, akun.no_rekening, akun.tgl_dibuat, transaksi.tgl_transaksi, transaksi.deskripsi
FROM nasabah
JOIN daftar_akun
ON nasabah.id = daftar_akun.id_nasabah
JOIN akun
ON daftar_akun.id_akun = akun.id
JOIN detail_transaksi
ON akun.id = detail_transaksi.id_akun
JOIN transaksi
ON detail_transaksi.id_transaksi = transaksi.id;


-- Query Update
UPDATE nasabah SET alamat = 'Jakarta' WHERE id = 1;
UPDATE akun SET saldo = 700000 WHERE id = 1;

UPDATE akun set saldo = 500000 WHERE id = 3;

-- Query Delete
DELETE FROM nasabah WHERE id = 3;
DELETE FROM akun WHERE id = 2;
DELETE from daftar_akun where id = 2;
