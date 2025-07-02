// src/MenuContent.tsx

import * as React from 'react';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import Stack from '@mui/material/Stack';
import HomeRoundedIcon from '@mui/icons-material/HomeRounded';
import AnalyticsRoundedIcon from '@mui/icons-material/AnalyticsRounded';
import FlagCircleIcon from '@mui/icons-material/FlagCircle';
import PublicIcon from '@mui/icons-material/Public';
import DatasetIcon from '@mui/icons-material/Dataset';
import AssignmentRoundedIcon from '@mui/icons-material/AssignmentRounded';
import InfoRoundedIcon from '@mui/icons-material/InfoRounded';
import HelpRoundedIcon from '@mui/icons-material/HelpRounded';

const mainListItems = [
  { text: 'Home', icon: <HomeRoundedIcon /> },
  { text: 'Gambaran Umum GHGE berdasarkan Tahun dan Area', icon: <FlagCircleIcon/> },
  { text: 'Gambaran Umum GHGE berdasarkan Area, Tahun, dan Tipe Gas', icon: <AnalyticsRoundedIcon /> },
  { text: 'Gambaran Umum GHGE berdasarkan Tahun dan Tipe Gas', icon: <PublicIcon /> },
  { text: 'Tabel Data', icon: <DatasetIcon /> },
  { text: 'Analisis Non Parametrik', icon: <AssignmentRoundedIcon /> },
];

const secondaryListItems = [
  { text: 'About', icon: <InfoRoundedIcon /> }
];

export default function MenuContent() {
  const handleMenuClick = (index: number) => {
    const menuEvent = new CustomEvent('mainmenu:select', {
      detail: { menuIndex: index }
    });
    window.dispatchEvent(menuEvent);
  };

  return (
    <Stack sx={{ flexGrow: 1, p: 1, justifyContent: 'space-between' }}>
      <List dense>
        {mainListItems.map((item, index) => (
          <ListItem key={item.text} disablePadding>
            <ListItemButton onClick={() => handleMenuClick(index)}>
              <ListItemIcon>{item.icon}</ListItemIcon>
              <ListItemText primary={item.text} />
            </ListItemButton>
          </ListItem>
        ))}
      </List>
      <List dense>
        {secondaryListItems.map((item, index) => (
          <ListItem key={item.text} disablePadding>
            {/* Beri index lanjutan dari menu utama */}
            <ListItemButton onClick={() => handleMenuClick(mainListItems.length + index)}>
              <ListItemIcon>{item.icon}</ListItemIcon>
              <ListItemText primary={item.text} />
            </ListItemButton>
          </ListItem>
        ))}
      </List>
    </Stack>
  );
}