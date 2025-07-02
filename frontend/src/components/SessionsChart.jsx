import * as React from 'react';
import { useMemo } from 'react';
import { useTheme } from '@mui/material/styles';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';
import { LineChart } from '@mui/x-charts/LineChart';

// Komponen helper ini tidak perlu diubah
function AreaGradient({ color, id }) {
  return (
    <linearGradient id={id} x1="50%" y1="0%" x2="50%" y2="100%">
      <stop offset="0%" stopColor={color} stopOpacity={0.3} />
      <stop offset="100%" stopColor={color} stopOpacity={0} />
    </linearGradient>
  );
}

// Komponen Chart yang sudah diperbaiki
// Menerima statsData, loading, error, dan yearRange dari props
export default function SessionsChart({ statsData, loading, error, yearRange }) {
  const theme = useTheme();

  // Proses data dari props menggunakan useMemo agar efisien
  const { gasData, years } = useMemo(() => {
    if (!statsData || Object.keys(statsData).length === 0) {
      return { gasData: [], years: [] };
    }

    const yearsArr = [];
    for (let y = yearRange[0]; y <= yearRange[1]; y++) {
      yearsArr.push(y.toString());
    }

    const processGasData = (rawValues = {}, yearsList) => {
      return yearsList.map(year => {
        const value = rawValues[year]?.[0];
        return value !== undefined ? value : 0;
      });
    };

    const processedData = [
      { id: 'total', label: 'Total GHG', color: theme.palette.primary.dark, data: processGasData(statsData.total?.raw_values, yearsArr) },
      { id: 'co2', label: 'CO2', color: theme.palette.error.main, data: processGasData(statsData.co2?.raw_values, yearsArr) },
      { id: 'n2o', label: 'N2O', color: theme.palette.warning.main, data: processGasData(statsData.n2o?.raw_values, yearsArr) },
      { id: 'ch4', label: 'CH4', color: theme.palette.success.main, data: processGasData(statsData.ch4?.raw_values, yearsArr) }
    ];

    return { gasData: processedData, years: yearsArr };
  }, [statsData, yearRange, theme]); // Dijalankan ulang hanya jika props ini berubah

  // Tampilkan pesan loading atau error
  if (loading) return <Typography>Memuat chart...</Typography>;
  if (error) return <Typography color="error">{error}</Typography>;
  if (gasData.length === 0) return <Typography>Data tidak tersedia.</Typography>;

  const colorPalette = gasData.map(gas => gas.color);

  return (
    <Card variant="outlined" sx={{ width: '100%' }}>
      <CardContent>
        <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 2 }}>
          <Box>
            <Typography component="h2" variant="subtitle2">
              GHG Emissions Trend
            </Typography>
            <Typography variant="caption" color="text.secondary">
              Menampilkan data tahun {yearRange[0]}-{yearRange[1]}
            </Typography>
          </Box>
          <Box sx={{ display: 'flex', gap: 1 }}>
            {gasData.map((gas) => (
              <Box key={gas.id} sx={{ display: 'flex', alignItems: 'center', gap: 0.5 }}>
                <Box sx={{ width: 12, height: 12, bgcolor: gas.color, borderRadius: '2px' }} />
                <Typography variant="caption" sx={{ color: 'text.secondary' }}>{gas.label}</Typography>
              </Box>
            ))}
          </Box>
        </Box>
        <LineChart
          colors={colorPalette}
          xAxis={[{ scaleType: 'point', data: years }]}
          series={gasData.map((gas) => ({
            id: gas.id,
            label: gas.label,
            showMark: false,
            curve: 'linear',
            area: true,
            stackOrder: 'ascending',
            data: gas.data,
          }))}
          height={250}
          margin={{ left: 30, right: 20, top: 20, bottom: 30 }}
          grid={{ horizontal: true }}
          sx={{
            '& .MuiAreaElement-series-total': { fill: "url('#total')" },
            '& .MuiAreaElement-series-co2': { fill: "url('#co2')" },
            '& .MuiAreaElement-series-n2o': { fill: "url('#n2o')" },
            '& .MuiAreaElement-series-ch4': { fill: "url('#ch4')" },
          }}
          hideLegend
        >
          {gasData.map((gas) => (
            <AreaGradient key={gas.id} color={gas.color} id={gas.id} />
          ))}
        </LineChart>
      </CardContent>
    </Card>
  );
}