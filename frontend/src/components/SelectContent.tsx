import * as React from 'react';
import MuiAvatar from '@mui/material/Avatar';
import { styled } from '@mui/material/styles';
import DevicesRoundedIcon from '@mui/icons-material/DevicesRounded';
import Typography from '@mui/material/Typography';

const Avatar = styled(MuiAvatar)(({ theme }) => ({
  width: 28,
  height: 28,
  backgroundColor: (theme.vars || theme).palette.background.paper,
  color: (theme.vars || theme).palette.text.secondary,
  border: `1px solid ${(theme.vars || theme).palette.divider}`,
}));

export default function StaticContent() {
  return (
    <div
      style={{
        display: 'flex',
        alignItems: 'center',
        gap: '8px',
        padding: '8px 12px',
        border: '1px solid #ccc',
        borderRadius: '8px',
        width: 215,
        height: 56,
      }}
    >
      <Avatar alt="GHGE Dashboard">
        <DevicesRoundedIcon sx={{ fontSize: '1rem' }} />
      </Avatar>
      <div>
        <Typography>Global GHGE</Typography>
        <Typography style={{ fontSize: '0.8rem', color: '#666' }}>Dashboard</Typography>
      </div>
    </div>
  );
}