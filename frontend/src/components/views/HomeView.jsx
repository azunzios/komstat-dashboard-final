// views/HomeView.jsx
import * as React from 'react';
import Grid from '@mui/material/Grid';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Card from '@mui/material/Card';
import QuiltedImageList from '../ImageList.jsx'; // Sesuaikan path jika perlu

export default function HomeView() {
  return (
    <Box sx={{ width: '100%', minHeight: 180, mt: 2, px: 2, minHeight: '70vh', display: 'flex', flexDirection: 'column', justifyContent: 'center', alignItems: 'center' }}>
      <Grid container justifyContent="center" alignItems="center" columns={{ xs: 1, md: 2 }} spacing={5} margin={2}>
        <Grid item size={1} sx={{ width: { xs: 'auto', md: 540 }, height: { xs: 'auto', md:'auto',lg: 450 }}} >
          <Box sx={{ width: '100%', height: '100%', display: 'flex', flexDirection: 'column', justifyContent: 'center', alignItems: 'center' }}>
            <Typography component="div" variant="h1" sx={{ fontWeight: 700, fontSize: { xs: '2rem', md: '2.7rem' }, mb: { xs: 0, md: 0.5 }, textAlign: 'left' }}>
              Dashboard Emisi Global
              Gas Rumah Kaca
            </Typography>
          </Box>
        </Grid>
        <Grid item size={1}>
          <QuiltedImageList />
        </Grid>
        <Grid item size={2}>
          <Card sx={{ mt: 2, mx: { xs: 0, md: 10 }, p: 2 }}>
            <Typography variant="subtitle1" component="p"  sx={{ textAlign: 'justify' }}>
              Dashboard ini merupakan dashboard yang menampilkan deskripsi dan analisis non-parametrik dari data emisi gas rumah kaca global.
            </Typography>
            <Typography variant="subtitle1" component="p" sx={{ textAlign: 'justify' }}>
              Dashboard ini dirancang sebagai alat visualisasi interaktif untuk memahami dan menganalisis tren emisi gas rumah kaca (GRK) secara global dalam rentang waktu yang cukup panjang, yaitu dari tahun <strong>1970 hingga 2023</strong>.
            </Typography>
          </Card>
        </Grid>
      </Grid>
    </Box>
  );
}