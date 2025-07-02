// src/views/AreaTahunTipeGasView.jsx

import * as React from 'react';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Divider from '@mui/material/Divider';
import YoYGrowthTrend from '../yoYChartAndGauge'; // Impor komponen yang baru dibuat

export default function AreaTahunTipeGasView(props) {
  return (
    <Box sx={{ px: { xs: 0, md: 10 } }}>
      <Typography component="h2" variant="h4" sx={{ mb: 2, mt: 2 }}>
        Gambaran Umum GHGE berdasarkan Area, Tahun, dan Tipe Gas
      </Typography>
      <Divider sx={{ mb: 3 }} />
      {/* Teruskan semua props ke komponen visualisasi */}
      <YoYGrowthTrend {...props} />
    </Box>
  );
}