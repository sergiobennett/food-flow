<?php

$conn = mysqli_connect(
    'localhost',
    'foodflow_app',
    'GANTI_DENGAN_PASSWORD_DATABASE',
    'foodflow_latest'
);

if (!$conn) {
    die('Koneksi database gagal: ' . mysqli_connect_error());
}

mysqli_set_charset($conn, 'utf8mb4');

?>