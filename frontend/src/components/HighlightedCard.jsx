// src/components/HighlightedCard.jsx

import * as React from 'react';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import Button from '@mui/material/Button';
import Typography from '@mui/material/Typography';
import ChevronRightRoundedIcon from '@mui/icons-material/ChevronRightRounded';
import PictureAsPdfIcon from '@mui/icons-material/PictureAsPdf';
import { printDashboardToPDF } from '../utils/print';

// Komponen ini TIDAK PERLU menerima prop onPrint
export default function HighlightedCard() {
  const handlePrintRequest = () => {
    printDashboardToPDF();
  };

  return (
    <Card sx={{ height: '100%', p: 2, width: '100%'}}>
      <CardContent>
        <PictureAsPdfIcon />
        <Typography component="h2" variant="subtitle2" gutterBottom sx={{ fontWeight: '600' }}>
          Cetak Output
        </Typography>
        <Typography sx={{ color: 'text.secondary', mb: '8px' }}>
          Cetak output data dalam format PDF (seperti Ctrl+P)
        </Typography>
        <Button
          variant="contained"
          size="small"
          color="primary"
          endIcon={<ChevronRightRoundedIcon />}
          onClick={handlePrintRequest} // Panggil fungsi yang mengirim event
        >
          Export PDF
        </Button>
      </CardContent>
    </Card>
  );
}