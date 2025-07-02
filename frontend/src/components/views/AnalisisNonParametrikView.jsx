// views/AnalisisNonParametrikView.jsx
import * as React from 'react';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Divider from '@mui/material/Divider';

export default function AnalisisNonParametrikView() {
  return (
    <Box sx={{ px: { xs: 4, md: 10 } }}>
      <Typography component="h2" variant="h4" sx={{ mb: 2, mt: 2 }}>
        Analisis Non Parametrik
      </Typography>
      <Divider sx={{ mb: 2 }} />
      <Typography>
        Konten untuk analisis non-parametrik akan ditampilkan di sini.
      </Typography>
    </Box>
  );
}