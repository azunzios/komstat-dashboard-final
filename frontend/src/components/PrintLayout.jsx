// src/components/PrintLayout.jsx (SUDAH BENAR, TIDAK PERLU DIUBAH)

import * as React from 'react';
import { Box, Typography } from '@mui/material';

// Impor semua komponen view yang ingin Anda cetak
import HomeView from './views/HomeView.jsx';
import TahunAreaView from './views/TahunAreaView.jsx';
import AreaTahunTipeGasView from './views/AreaTahunTipeGasView.jsx';
// ... impor view lainnya

const PrintLayout = React.forwardRef((props, ref) => {
  const pageStyle = {
    padding: '2rem',
    pageBreakAfter: 'always',
  };

  return (
    <div ref={ref}>
      <Typography variant="h3" gutterBottom>Laporan Emisi Gas Rumah Kaca</Typography>
      <Typography variant="h5" gutterBottom>Negara: {props.country}</Typography>
      <Typography variant="h5" gutterBottom>Periode: {props.yearRange.join(' - ')}</Typography>
      
      <Box sx={pageStyle}>
        <Typography variant="h4" gutterBottom>Home</Typography>
        <HomeView {...props} />
      </Box>

      <Box sx={pageStyle}>
        <Typography variant="h4" gutterBottom>Gambaran Umum Berdasarkan Tahun dan Area</Typography>
        <TahunAreaView {...props} />
      </Box>

      <Box sx={pageStyle}>
        <Typography variant="h4" gutterBottom>Gambaran Umum Berdasarkan Area, Tahun, dan Tipe Gas</Typography>
        <AreaTahunTipeGasView {...props} />
      </Box>
    </div>
  );
});

export default PrintLayout;