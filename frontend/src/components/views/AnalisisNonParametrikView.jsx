import React from 'react';
import { Card, CardContent, Grid, Box } from '@mui/material';

const AnalisisNonparametrikView = () => {
  return (
    <Box>
      <Grid container spacing={3}>
        <Grid item xs={12}>
          <Card>
            {/* Hapus padding dari CardContent agar iframe menempel sempurna */}
            <CardContent sx={{ p: 0, '&:last-child': { pb: 0 } }}>
              <iframe
                src="http://$API_BASE_URL:3838" // Pastikan URL ini sesuai dengan app Shiny Anda
                title="Analisis Nonparametrik - R Shiny"
                style={{
                  width: '85vw',
                  height: '85vh', // Tinggi bisa disesuaikan (85% dari tinggi viewport)
                  border: 'none',
                  display: 'block', // Untuk menghilangkan space di bawah iframe
                }}
              />
            </CardContent>
          </Card>
        </Grid>
      </Grid>
    </Box>
  );
};

export default AnalisisNonparametrikView;