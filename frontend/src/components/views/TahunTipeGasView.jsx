// views/TahunTipeGasView.jsx
import * as React from 'react';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Divider from '@mui/material/Divider';
import MapChart from '../MapScatterHeatChartandOther.jsx'; // Sesuaikan path jika perlu

export default function TahunTipeGasView() {
  return (
    <Box sx={{ px: { xs: 0, md: 10 } }}>
      <Typography component="h2" variant="h4" sx={{ mb: 2, mt: 2 }}>
        Gambaran Umum GHGE berdasarkan Tahun dan Tipe Gas
      </Typography>
      <Divider sx={{ mb: 2 }} />
      <Box id="peta-section" sx={{ width: '100%', mt: 4 }}>
        <Typography component="h3" variant="h6" sx={{ mb: 2 }}>
          Peta Choropleth Global
        </Typography>
        <MapChart />
      </Box>
    </Box>
  );
}