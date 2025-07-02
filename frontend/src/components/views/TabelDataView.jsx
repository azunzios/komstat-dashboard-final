// views/TabelDataView.jsx
import * as React from 'react';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Divider from '@mui/material/Divider';
import CustomizedDataGrid from '../CustomizedDataGrid'; // Sesuaikan path jika perlu

export default function TabelDataView() {
  return (
    <Box sx={{ px: { xs: 0, md: 10 } }}>
      <Typography component="h2" variant="h4" sx={{ mb: 2, mt: 2 }}>
        Tabel Data
      </Typography>
      <Divider sx={{ mb: 2 }} />
      <CustomizedDataGrid />
    </Box>
  );
}