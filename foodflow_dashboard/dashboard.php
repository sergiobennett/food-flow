<?php
require_once __DIR__ . '/koneksi.php';

mysqli_set_charset($conn, 'utf8mb4');

function h($value): string
{
    return htmlspecialchars((string) $value, ENT_QUOTES, 'UTF-8');
}

function rupiah($value): string
{
    return 'Rp ' . number_format((float) $value, 0, ',', '.');
}

function validDate(string $value): bool
{
    if ($value === '') {
        return true;
    }

    $date = DateTime::createFromFormat('!Y-m-d', $value);
    return $date !== false && $date->format('Y-m-d') === $value;
}

/** Execute a prepared SELECT query and return all rows. */
function fetchRows(mysqli $conn, string $sql, string $types = '', array $params = []): array
{
    $stmt = $conn->prepare($sql);
    if (!$stmt) {
        throw new RuntimeException('Gagal menyiapkan query: ' . $conn->error);
    }

    if ($types !== '') {
        $bind = [$types];
        foreach ($params as $key => $value) {
            $bind[] = &$params[$key];
        }
        call_user_func_array([$stmt, 'bind_param'], $bind);
    }

    if (!$stmt->execute()) {
        $error = $stmt->error;
        $stmt->close();
        throw new RuntimeException('Gagal menjalankan query: ' . $error);
    }

    $result = $stmt->get_result();
    if ($result === false) {
        $stmt->close();
        throw new RuntimeException('Hasil query tidak dapat dibaca.');
    }

    $rows = $result->fetch_all(MYSQLI_ASSOC);
    $stmt->close();
    return $rows;
}

// Read and validate filter values from the URL/form.
$tanggalAwal = trim($_GET['tanggal_awal'] ?? '');
$tanggalAkhir = trim($_GET['tanggal_akhir'] ?? '');
$idMitra = trim($_GET['id_mitra'] ?? '');
$idProduk = trim($_GET['id_produk'] ?? '');
$errorMessage = '';

if (!validDate($tanggalAwal)) {
    $tanggalAwal = '';
    $errorMessage = 'Format tanggal awal tidak valid.';
}
if (!validDate($tanggalAkhir)) {
    $tanggalAkhir = '';
    $errorMessage = 'Format tanggal akhir tidak valid.';
}
if ($tanggalAwal !== '' && $tanggalAkhir !== '' && $tanggalAwal > $tanggalAkhir) {
    $tanggalAwal = '';
    $tanggalAkhir = '';
    $errorMessage = 'Tanggal awal tidak boleh melewati tanggal akhir.';
}

if ($idMitra !== '' && (!ctype_digit($idMitra) || (int) $idMitra < 1)) {
    $idMitra = '';
}
if ($idProduk !== '' && (!ctype_digit($idProduk) || (int) $idProduk < 1)) {
    $idProduk = '';
}

// One shared filter is used by the table, summary cards, and all three charts.
$where = [
    "d.status_transaksi = 'selesai'",
    "d.status_konfirmasi_mitra = 'disetujui'",
];
$types = '';
$params = [];

if ($tanggalAwal !== '') {
    $where[] = 'd.tanggal >= ?';
    $types .= 's';
    $params[] = $tanggalAwal;
}
if ($tanggalAkhir !== '') {
    $where[] = 'd.tanggal <= ?';
    $types .= 's';
    $params[] = $tanggalAkhir;
}
if ($idMitra !== '') {
    $where[] = 'd.id_mitra = ?';
    $types .= 'i';
    $params[] = (int) $idMitra;
}
if ($idProduk !== '') {
    $where[] = 'dd.id_produk = ?';
    $types .= 'i';
    $params[] = (int) $idProduk;
}
$whereSql = implode(' AND ', $where);

try {
    $mitraOptions = fetchRows(
        $conn,
        'SELECT id_mitra, nama_mitra FROM mitra ORDER BY nama_mitra ASC'
    );
    $produkOptions = fetchRows(
        $conn,
        'SELECT id_produk, nama_produk FROM produk ORDER BY nama_produk ASC'
    );

    // Summary card 1: total quantity of sold products, following active filters.
    $summaryProduk = fetchRows(
        $conn,
        "SELECT COALESCE(SUM(dd.qty_terjual), 0) AS total_produk_terjual
         FROM detail_distribusi dd
         INNER JOIN distribusi d ON d.id_distribusi = dd.id_distribusi
         WHERE $whereSql",
        $types,
        $params
    );

    // Summary card 2 follows Bilovi's query: count all registered partners.
    $summaryMitra = fetchRows(
        $conn,
        'SELECT COUNT(*) AS total_mitra FROM mitra'
    );

    // Summary card 3: gross sales revenue, following active filters.
    $summaryPendapatan = fetchRows(
        $conn,
        "SELECT COALESCE(SUM(dd.subtotal_omzet), 0) AS total_pendapatan
         FROM detail_distribusi dd
         INNER JOIN distribusi d ON d.id_distribusi = dd.id_distribusi
         WHERE $whereSql",
        $types,
        $params
    );

    // Bar chart: sold quantity grouped by product.
    $barRows = fetchRows(
        $conn,
        "SELECT p.nama_produk, SUM(dd.qty_terjual) AS total_produk_terjual
         FROM produk p
         INNER JOIN detail_distribusi dd ON dd.id_produk = p.id_produk
         INNER JOIN distribusi d ON d.id_distribusi = dd.id_distribusi
         WHERE $whereSql
         GROUP BY p.id_produk, p.nama_produk
         ORDER BY total_produk_terjual DESC",
        $types,
        $params
    );

    // Line chart: gross revenue grouped by distribution date.
    $lineRows = fetchRows(
        $conn,
        "SELECT d.tanggal, SUM(dd.subtotal_omzet) AS total_pendapatan
         FROM distribusi d
         INNER JOIN detail_distribusi dd ON dd.id_distribusi = d.id_distribusi
         WHERE $whereSql
         GROUP BY d.tanggal
         ORDER BY d.tanggal ASC",
        $types,
        $params
    );

    // Pie chart: gross revenue grouped by partner.
    $pieRows = fetchRows(
        $conn,
        "SELECT m.nama_mitra, SUM(dd.subtotal_omzet) AS total_pendapatan
         FROM mitra m
         INNER JOIN distribusi d ON d.id_mitra = m.id_mitra
         INNER JOIN detail_distribusi dd ON dd.id_distribusi = d.id_distribusi
         WHERE $whereSql
         GROUP BY m.id_mitra, m.nama_mitra
         ORDER BY total_pendapatan DESC",
        $types,
        $params
    );

    // Detail table: one row per date, partner, and product.
    $tableRows = fetchRows(
        $conn,
        "SELECT d.tanggal, m.nama_mitra, p.nama_produk,
                SUM(dd.qty_terjual) AS qty_terjual,
                SUM(dd.subtotal_omzet) AS subtotal_omzet
         FROM distribusi d
         INNER JOIN mitra m ON m.id_mitra = d.id_mitra
         INNER JOIN detail_distribusi dd ON dd.id_distribusi = d.id_distribusi
         INNER JOIN produk p ON p.id_produk = dd.id_produk
         WHERE $whereSql
         GROUP BY d.tanggal, m.id_mitra, m.nama_mitra, p.id_produk, p.nama_produk
         ORDER BY d.tanggal DESC, m.nama_mitra ASC, p.nama_produk ASC",
        $types,
        $params
    );
} catch (Throwable $exception) {
    http_response_code(500);
    $errorMessage = 'Dashboard gagal memuat data. Periksa koneksi dan struktur database. Detail: ' . $exception->getMessage();
    $mitraOptions = $produkOptions = $barRows = $lineRows = $pieRows = $tableRows = [];
    $summaryProduk = [['total_produk_terjual' => 0]];
    $summaryMitra = [['total_mitra' => 0]];
    $summaryPendapatan = [['total_pendapatan' => 0]];
}

$totalProduk = (int) ($summaryProduk[0]['total_produk_terjual'] ?? 0);
$totalMitra = (int) ($summaryMitra[0]['total_mitra'] ?? 0);
$totalPendapatan = (float) ($summaryPendapatan[0]['total_pendapatan'] ?? 0);

$chartData = [
    'bar' => [
        'labels' => array_column($barRows, 'nama_produk'),
        'values' => array_map('intval', array_column($barRows, 'total_produk_terjual')),
    ],
    'line' => [
        'labels' => array_column($lineRows, 'tanggal'),
        'values' => array_map('floatval', array_column($lineRows, 'total_pendapatan')),
    ],
    'pie' => [
        'labels' => array_column($pieRows, 'nama_mitra'),
        'values' => array_map('floatval', array_column($pieRows, 'total_pendapatan')),
    ],
];
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard FoodFlow</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root { --orange: #f47721; --orange-dark: #df6413; --ink: #263238; --muted: #718096; --bg: #f5f7fa; --white: #fff; --line: #e7ebf0; }
        * { box-sizing: border-box; }
        body { margin: 0; background: var(--bg); color: var(--ink); font-family: Arial, Helvetica, sans-serif; }
        .container { width: min(1180px, calc(100% - 36px)); margin: 32px auto 50px; }
        .page-header { display: flex; justify-content: space-between; align-items: center; gap: 16px; margin-bottom: 22px; }
        h1 { margin: 0 0 7px; color: var(--orange-dark); font-size: 30px; }
        .subtitle { margin: 0; color: var(--muted); font-size: 14px; }
        .badge { background: #fff0e5; color: var(--orange-dark); border-radius: 999px; padding: 9px 14px; font-size: 12px; font-weight: 700; }
        .cards { display: grid; grid-template-columns: repeat(3, 1fr); gap: 18px; margin-bottom: 22px; }
        .card, .panel { background: var(--white); border: 1px solid var(--line); border-radius: 14px; box-shadow: 0 4px 16px rgba(22, 34, 51, .04); }
        .card { padding: 21px 22px; }
        .card-label { color: var(--muted); font-size: 13px; margin-bottom: 13px; }
        .card-value { color: var(--orange-dark); font-size: 27px; font-weight: 750; letter-spacing: -.5px; }
        .card-note { color: #98a2ad; font-size: 11px; margin-top: 9px; }
        .panel { padding: 22px; margin-bottom: 22px; }
        .panel h2 { font-size: 17px; margin: 0 0 17px; }
        .filters { display: grid; grid-template-columns: repeat(4, minmax(150px, 1fr)) auto auto; gap: 13px; align-items: end; }
        label { display: block; color: #52606d; font-size: 12px; font-weight: 700; margin-bottom: 7px; }
        input, select { width: 100%; padding: 11px 12px; border: 1px solid #d9e0e7; border-radius: 8px; background: #fff; color: var(--ink); font-size: 13px; }
        button, .reset { display: inline-flex; justify-content: center; align-items: center; min-height: 39px; padding: 0 17px; border: 0; border-radius: 8px; background: var(--orange); color: white; text-decoration: none; font-size: 13px; font-weight: 700; cursor: pointer; }
        button:hover { background: var(--orange-dark); }
        .reset { background: #eef1f5; color: #4a5560; }
        .hint { color: var(--muted); font-size: 11px; margin: 13px 0 0; }
        .alert { background: #fff3f0; border: 1px solid #ffd2c6; color: #a63b20; border-radius: 9px; padding: 12px 14px; margin-bottom: 18px; font-size: 13px; overflow-wrap: anywhere; }
        .charts { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 18px; }
        .chart-panel { min-height: 340px; }
        .chart-panel.wide { grid-column: 1 / -1; }
        .chart-wrap { position: relative; height: 275px; }
        .table-wrap { overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; min-width: 650px; font-size: 13px; }
        thead { background: var(--orange); color: #fff; }
        th, td { padding: 12px 13px; text-align: left; border-bottom: 1px solid var(--line); }
        tbody tr:hover { background: #fff8f2; }
        td.number, th.number { text-align: right; }
        .empty { color: var(--muted); text-align: center; padding: 25px; }
        footer { color: #9aa4af; font-size: 11px; text-align: center; padding: 8px; }
        @media (max-width: 850px) { .cards { grid-template-columns: 1fr; } .filters { grid-template-columns: repeat(2, minmax(0, 1fr)); } .charts { grid-template-columns: 1fr; } .chart-panel.wide { grid-column: auto; } }
        @media (max-width: 520px) { .container { width: min(100% - 22px, 1180px); margin-top: 20px; } .page-header { align-items: flex-start; flex-direction: column; } .filters { grid-template-columns: 1fr; } .panel { padding: 16px; } .card-value { font-size: 24px; } }
    </style>
</head>
<body>
<div class="container">
    <header class="page-header">
        <div>
            <h1>Dashboard FoodFlow</h1>
            <p class="subtitle">Monitoring penjualan dan distribusi produk</p>
        </div>
        <span class="badge">OWNER DASHBOARD</span>
    </header>

    <?php if ($errorMessage !== ''): ?>
        <div class="alert"><?= h($errorMessage) ?></div>
    <?php endif; ?>

    <section class="cards" aria-label="Ringkasan penjualan">
        <article class="card">
            <div class="card-label">Total Produk Terjual</div>
            <div class="card-value"><?= number_format($totalProduk, 0, ',', '.') ?></div>
            <div class="card-note">Unit terjual pada transaksi yang sesuai filter</div>
        </article>
        <article class="card">
            <div class="card-label">Total Cabang / Mitra</div>
            <div class="card-value"><?= number_format($totalMitra, 0, ',', '.') ?></div>
            <div class="card-note">Jumlah mitra yang terdaftar</div>
        </article>
        <article class="card">
            <div class="card-label">Total Pendapatan</div>
            <div class="card-value"><?= h(rupiah($totalPendapatan)) ?></div>
            <div class="card-note">Omzet kotor, bukan keuntungan bersih</div>
        </article>
    </section>

    <section class="panel">
        <h2>Filter Data</h2>
        <form method="get" action="">
            <div class="filters">
                <div>
                    <label for="tanggal_awal">Tanggal Awal</label>
                    <input type="date" id="tanggal_awal" name="tanggal_awal" value="<?= h($tanggalAwal) ?>">
                </div>
                <div>
                    <label for="tanggal_akhir">Tanggal Akhir</label>
                    <input type="date" id="tanggal_akhir" name="tanggal_akhir" value="<?= h($tanggalAkhir) ?>">
                </div>
                <div>
                    <label for="id_mitra">Mitra</label>
                    <select id="id_mitra" name="id_mitra">
                        <option value="">Semua Mitra</option>
                        <?php foreach ($mitraOptions as $mitra): ?>
                            <option value="<?= h($mitra['id_mitra']) ?>" <?= $idMitra === (string) $mitra['id_mitra'] ? 'selected' : '' ?>><?= h($mitra['nama_mitra']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div>
                    <label for="id_produk">Produk</label>
                    <select id="id_produk" name="id_produk">
                        <option value="">Semua Produk</option>
                        <?php foreach ($produkOptions as $produk): ?>
                            <option value="<?= h($produk['id_produk']) ?>" <?= $idProduk === (string) $produk['id_produk'] ? 'selected' : '' ?>><?= h($produk['nama_produk']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <button type="submit">Terapkan Filter</button>
                <a class="reset" href="dashboard.php">Reset</a>
            </div>
        </form>
        <p class="hint">Dashboard hanya menghitung transaksi dengan status selesai dan konfirmasi mitra disetujui.</p>
    </section>

    <section class="panel">
        <h2>Visualisasi Data Penjualan</h2>
        <div class="charts">
            <article class="panel chart-panel">
                <h2>Bar Chart — Produk Terjual</h2>
                <div class="chart-wrap"><canvas id="barChart"></canvas></div>
            </article>
            <article class="panel chart-panel">
                <h2>Line Chart — Perkembangan Omzet</h2>
                <div class="chart-wrap"><canvas id="lineChart"></canvas></div>
            </article>
            <article class="panel chart-panel wide">
                <h2>Pie Chart — Kontribusi Omzet Mitra</h2>
                <div class="chart-wrap"><canvas id="pieChart"></canvas></div>
            </article>
        </div>
    </section>

    <section class="panel">
        <h2>Hasil Data Penjualan</h2>
        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>Tanggal</th>
                        <th>Nama Mitra</th>
                        <th>Nama Produk</th>
                        <th class="number">Total Terjual</th>
                        <th class="number">Total Omzet</th>
                    </tr>
                </thead>
                <tbody>
                <?php if (count($tableRows) > 0): ?>
                    <?php foreach ($tableRows as $row): ?>
                        <tr>
                            <td><?= h(date('d-m-Y', strtotime($row['tanggal']))) ?></td>
                            <td><?= h($row['nama_mitra']) ?></td>
                            <td><?= h($row['nama_produk']) ?></td>
                            <td class="number"><?= number_format((int) $row['qty_terjual'], 0, ',', '.') ?></td>
                            <td class="number"><?= h(rupiah($row['subtotal_omzet'])) ?></td>
                        </tr>
                    <?php endforeach; ?>
                <?php else: ?>
                    <tr><td colspan="5" class="empty">Tidak ada data penjualan untuk filter yang dipilih.</td></tr>
                <?php endif; ?>
                </tbody>
            </table>
        </div>
    </section>
    <footer>FoodFlow Dashboard · Data ditampilkan dari database MySQL</footer>
</div>

<script>
const chartData = <?= json_encode($chartData, JSON_UNESCAPED_UNICODE | JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_AMP | JSON_HEX_QUOT) ?>;
const rupiahTick = (value) => 'Rp ' + Number(value).toLocaleString('id-ID');

new Chart(document.getElementById('barChart'), {
    type: 'bar',
    data: {
        labels: chartData.bar.labels,
        datasets: [{ label: 'Produk Terjual', data: chartData.bar.values, backgroundColor: '#f47721', borderRadius: 6 }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: { legend: { display: false } },
        scales: { y: { beginAtZero: true, ticks: { precision: 0 } } }
    }
});

new Chart(document.getElementById('lineChart'), {
    type: 'line',
    data: {
        labels: chartData.line.labels,
        datasets: [{ label: 'Total Omzet', data: chartData.line.values, borderColor: '#2f9e73', backgroundColor: 'rgba(47, 158, 115, .15)', fill: true, tension: .3, pointRadius: 4 }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: { tooltip: { callbacks: { label: (context) => rupiahTick(context.parsed.y) } } },
        scales: { y: { beginAtZero: true, ticks: { callback: (value) => rupiahTick(value) } } }
    }
});

new Chart(document.getElementById('pieChart'), {
    type: 'pie',
    data: {
        labels: chartData.pie.labels,
        datasets: [{ label: 'Kontribusi Omzet', data: chartData.pie.values, backgroundColor: chartData.pie.labels.map((_, i) => `hsl(${24 + i * 63}, 76%, 58%)`), borderColor: '#ffffff', borderWidth: 2 }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: { tooltip: { callbacks: { label: (context) => `${context.label}: ${rupiahTick(context.parsed)}` } } }
    }
});
</script>
</body>
</html>
