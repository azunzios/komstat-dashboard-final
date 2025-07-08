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
                        {/* Sisipkan video di sini */}
                        <Box sx={{ my: 2 }}>
                            <video width="100%" controls style={{borderRadius:30}}>
                                <source src="/assets/profile_video_c.mp4" type="video/mp4" />
                                Your browser does not support the video tag.
                            </video>
                        </Box>
                        <Card
                            component="div"
                        >
                            <h3>📊 Informasi Data</h3>
                            <p>
                                Sumber utama dari data dalam dashboard ini berasal dari <strong>Bank Dunia</strong> dan dapat diakses melalui situs resminya di{' '}
                                <Box
                                    component="a"
                                    href="https://data360.worldbank.org/"
                                    target="_blank"
                                    rel="noopener noreferrer"
                                    sx={{
                                        textDecoration: 'none',
                                        fontWeight: 1000,
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
                                    Data yang digunakan <strong>tidak mencakup LULUCF</strong> (Land Use, Land-Use Change, and Forestry), yaitu aktivitas yang berkaitan dengan perubahan penggunaan lahan seperti deforestasi atau reforestasi yang dapat memengaruhi stok karbon di alam. Hal ini memungkinkan analisis yang lebih terfokus pada emisi dari sumber energi, industri, limbah, dan pertanian.
                                </p>

                                <h3>🛠️ Petunjuk Penggunaan</h3>
                                <p>
                                    Di dalam dashboard ini, Anda akan menemukan berbagai elemen interaktif seperti <strong>input teks, dropdown, pemilih tahun (slider), pilihan negara dan tipe gas</strong>. Semua komponen ini disusun agar mudah dikonfigurasi sesuai dengan kebutuhan analisis data. Anda dapat memilih kombinasi parameter untuk menyesuaikan visualisasi data, yang secara otomatis akan memperbarui grafik, tabel, dan statistik yang ditampilkan.
                                </p>
                                <p>
                                    Fitur unggulan lainnya adalah formulir simulasi perubahan data. Dengan formulir ini, Anda bisa memasukkan nilai manual untuk melihat dampak perubahan terhadap statistik, seperti perhitungan rata-rata, median, serta tren pertumbuhan tahunan. Fitur ini sangat berguna untuk analisis "what-if" yang membantu memberikan gambaran tentang potensi skenario jika terjadi perubahan data.
                                </p>
                                <p>
                                    Selain itu, navigasi yang disediakan di bagian atas atau samping dashboard memungkinkan Anda untuk langsung meloncat ke section tertentu, sehingga memudahkan akses ke informasi yang ingin Anda telusuri, seperti tren historis emisi atau detail data per negara.
                                </p>
                                <p>
                                    Petunjuk penggunaan juga mencakup panduan langkah demi langkah tentang cara menggunakan fitur-fitur ini, sehingga pengguna, baik pemula maupun yang berpengalaman, dapat dengan mudah memahami dan mengoptimalkan penggunaan dashboard.
                                </p>
                            </Box>
                        </Card>
                        <Typography variant="h4" sx={{ mt: 2 }}>
                            Anggota Kelompok
                        </Typography>
                        <Card sx={{ p: 2, mb: 2 }}>
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
                        {/* Tambahan informasi di bawah Anggota Kelompok */}
                        <Typography variant="body2" sx={{ mt: 2, fontStyle: 'italic' }}>
                            ditujukan untuk memenuhi penugasan mata kuliah komputasi statistik kelas 2KS1 politeknik Statistika STIS
                        </Typography>
                    </Box>
                </Grid>

            </Grid>
        </Box>
    )
}