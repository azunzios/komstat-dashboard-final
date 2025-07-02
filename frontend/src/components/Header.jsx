// src/components/Header.jsx

import * as React from 'react';
import Stack from '@mui/material/Stack';
import NavbarBreadcrumbs from './NavbarBreadcrumbs';
import ColorModeIconDropdown from '../theme/ColorModeIconDropdown';
import RegexSearch from './RegexSearch';
import TodayDate from './TodayDate';

export default function Header({ currentPageName }) {
  return (
    <Stack
      direction="row"
      sx={{
        display: { xs: 'none', md: 'flex' },
        width: '100%',
        alignItems: 'center',
        justifyContent: 'space-between',
        maxWidth: { sm: '100%', md: '1700px' },
        pt: 1.5,
      }}
      spacing={2}
    >
      <NavbarBreadcrumbs currentPageName={currentPageName} />

      <Stack direction="row" sx={{ gap: 1 }}>
        <RegexSearch />
        <TodayDate />
        <ColorModeIconDropdown />
      </Stack>
    </Stack>
  );
}