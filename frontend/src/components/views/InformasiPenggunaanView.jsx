import { Box, Grid, Typography } from '@mui/material';
import Stack from '@mui/material/Stack';
import Avatar from '@mui/material/Avatar';
import { deepOrange, deepPurple, purple } from '@mui/material/colors';
import Card from '@mui/material/Card';


export default function InformasiPenggunaanView() {
    return (
        <Box sx={{ px: { xs: 0, md: 10 }, pb: 2 }}>
            <Grid container columns={3} spacing={2} sx={{ mb: 2, mt: 2 }}   >
                <Grid item size={3}>
                    <Box>
                        <Typography variant="h4">
                            Informasi Data & Petunjuk Penggunaan
                        </Typography>
                        <Card component="div" sx={{ whiteSpace: 'wrap', overflow: 'auto', borderRadius: 1, p: 2 }}>
                            <h3>📊 Informasi Data</h3>
                            <p>
                                Sumber utama dari data dalam dashboard ini berasal dari <strong>Bank Dunia</strong> dan dapat diakses melalui situs resminya di{' '}
                                <Box
                                    component="a"
                                    href="https://data360.worldbank.org/"
                                    target="_blank"
                                    rel="noopener noreferrer"
                                    sx={{
                                        color: '#000',
                                        textDecoration: 'none',
                                        '&:hover': {
                                            textDecoration: 'underline'
                                        }
                                    }}
                                >
                                    https://data360.worldbank.org/
                                </Box>
                                . Data yang ditampilkan mencakup estimasi tahunan emisi gas rumah kaca dari berbagai negara dan wilayah dunia, serta total global.
                            </p>
                            <Box>
                                <p>
                                    Dashboard ini memanfaatkan data dari <strong>EDGAR (Emissions Database for Global Atmospheric Research)</strong> melalui Community GHG Database, sebuah kolaborasi antara <em>European Commission</em> dan <em>Joint Research Centre (JRC)</em>, serta <em>International Energy Agency (IEA)</em>. Basis data ini terdiri dari:
                                    <ul>
                                        <li>IEA-EDGAR CO<sub>2</sub></li>
                                        <li>EDGAR CH<sub>4</sub></li>
                                        <li>EDGAR N<sub>2</sub>O</li>
                                        <li>EDGAR F-GASES</li>
                                        <li>Versi 8.0 (2023), dirilis oleh European Commission dan JRC</li>
                                    </ul>
                                </p>

                                <p>
                                    Data yang digunakan <strong>tidak mencakup LULUCF</strong> (Land Use, Land-Use Change, and Forestry), yaitu aktivitas yang berkaitan dengan perubahan penggunaan lahan seperti deforestasi atau reforestasi yang dapat memengaruhi stok karbon di alam. Dengan mengecualikan LULUCF, maka yang dianalisis adalah emisi dari sektor energi, industri, limbah, dan pertanian.
                                </p>

                                <h3>🛠️ Petunjuk Penggunaan</h3>
                                <p>
                                    Di dalam dashboard ini, Anda akan menemukan berbagai elemen interaktif seperti <strong>input teks, dropdown, pemilih tahun (slider), pilihan negara dan tipe gas</strong>. Komponen-komponen ini telah dikelompokkan dan dirancang agar mudah diubah sesuai kebutuhan analisis pengguna. Anda dapat dengan bebas memilih kombinasi negara, rentang waktu, dan tipe gas rumah kaca untuk menyesuaikan tampilan informasi yang ingin Anda telusuri.
                                </p>

                                <p>
                                    Salah satu fitur menarik dalam dashboard ini adalah formulir yang memungkinkan Anda <strong>melakukan simulasi perubahan data</strong>. Artinya, Anda bisa memasukkan nilai secara manual untuk melihat bagaimana perubahan angka tertentu dapat memengaruhi keseluruhan statistik seperti rata-rata, pertumbuhan tahunan, hingga grafik visualisasi tren. Perlu dicatat bahwa perubahan ini bersifat lokal dan tidak akan mengubah data asli.
                                </p>

                                <p>
                                    Di bagian atas atau samping dashboard tersedia navigasi berupa <strong>daftar isi atau tombol loncat section</strong>. Anda dapat menggunakannya untuk langsung menuju bagian yang ingin Anda lihat tanpa harus menggulir manual. Beberapa section penting di dalam dashboard ini adalah:
                                </p>

                                <ul>
                                    <li><strong>Gambaran Umum GHGE berdasarkan Tahun dan Area:</strong> Menampilkan tren emisi gas rumah kaca global berdasarkan lokasi geografis dan rentang waktu tertentu, memberikan konteks spasial dan temporal.</li>
                                    <li><strong>Gambaran Umum GHGE berdasarkan Area, Tahun, dan Tipe Gas:</strong> Memberikan rincian distribusi emisi untuk setiap tipe gas seperti CO<sub>2</sub>, CH<sub>4</sub>, N<sub>2</sub>O secara per wilayah dan waktu.</li>
                                    <li><strong>Gambaran Umum GHGE berdasarkan Tahun dan Tipe Gas:</strong> Menampilkan evolusi masing-masing tipe gas dari tahun ke tahun, berguna untuk mengidentifikasi gas mana yang memiliki tren peningkatan atau penurunan signifikan.</li>
                                    <li><strong>Tabel Data Detail:</strong> Disediakan dalam bentuk tabel yang dapat dicari dan difilter. Tabel ini menampilkan data numerik mentah dari hasil pemrosesan dan dapat digunakan untuk referensi analitis lebih lanjut.</li>
                                </ul>

                                <h3>📈 Menu Analisis</h3>
                                <p>
                                    Selain dashboard utama, pengguna dapat mengakses halaman khusus <strong>Analisis</strong> yang tersedia melalui menu navigasi (navbar). Di halaman ini, disediakan berbagai jenis analisis deskriptif dan non-parametrik yang membantu memahami lebih dalam pola, anomali, dan korelasi dari data emisi.
                                </p>

                                <p>
                                    Analisis yang tersedia mencakup: tren pertumbuhan tahunan, variasi antar negara, dan perbandingan per sektor. Semua metode analisis dilakukan berdasarkan prinsip transparansi data dan tidak dimodifikasi untuk menghasilkan bias atau opini tertentu.
                                </p>
                            </Box>
                        </Card>
                        <Typography variant="h4" sx={{ mt: 2 }}>
                            Anggota Kelompok
                        </Typography>
                        <Card>
                            <Box id="tentang-kami-section">
                                <Stack direction="column" spacing={2}>
                                    <Stack direction="row" spacing={2} sx={{ display: 'flex', alignItems: 'center' }}>
                                        <Avatar sx={{ bgcolor: deepOrange[500], width: 28, height: 28 }}>A</Avatar>
                                        <Typography>
                                            Alif Zakiansyah As Syauqi
                                        </Typography>
                                        <Typography>
                                            222312958
                                        </Typography>
                                    </Stack>
                                    <Stack direction="row" spacing={2} sx={{ display: 'flex', alignItems: 'center' }}>
                                        <Avatar sx={{ bgcolor: deepPurple[500], width: 28, height: 28 }}>M</Avatar>
                                        <Typography>
                                            Moses Noel Estomihi Simanullang
                                        </Typography>
                                        <Typography>
                                            222313217
                                        </Typography>
                                    </Stack>
                                    <Stack direction="row" spacing={2} sx={{ display: 'flex', alignItems: 'center' }}>
                                        <Avatar sx={{ bgcolor: purple['A100'], width: 28, height: 28 }}>N</Avatar>
                                        <Typography>
                                            Narangga Khoirul Utama
                                        </Typography>
                                        <Typography>
                                            222313288
                                        </Typography>
                                    </Stack>
                                </Stack>
                            </Box>
                        </Card>
                    </Box>
                </Grid>
            </Grid>
        </Box>
    )
}