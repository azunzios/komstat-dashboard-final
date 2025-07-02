// src/components/TodayDate.jsx

import * as React from 'react';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Stack from '@mui/material/Stack';
import CalendarTodayRoundedIcon from '@mui/icons-material/CalendarTodayRounded';

export default function TodayDate() {
  // Opsi untuk memformat tanggal ke format Indonesia (e.g., "2 Juli 2025")
  const options = {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  };
  
  // Ambil tanggal hari ini dan format
  const today = new Date().toLocaleDateString('id-ID', options);

  return (
    <Stack 
      direction="row" 
      alignItems="center" 
      spacing={1}
      sx={{
        p: '8px 12px',
        border: '1px solid',
        borderColor: 'divider',
        borderRadius: '12px',
        bgcolor: 'background.paper',
      }}
    >
      <CalendarTodayRoundedIcon sx={{ fontSize: 20, color: 'text.secondary' }} />
      <Typography variant="body2" sx={{ fontWeight: 500 }}>
        {today}
      </Typography>
    </Stack>
  );
}