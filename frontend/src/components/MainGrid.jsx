import * as React from 'react';
import { useEffect, useState, useRef } from 'react';
import { useReactToPrint } from 'react-to-print';
import Box from '@mui/material/Box';
import Fab from '@mui/material/Fab';
import Zoom from '@mui/material/Zoom';
import KeyboardArrowUpIcon from '@mui/icons-material/KeyboardArrowUp';
import Copyright from '../internals/components/Copyright';
import HomeView from './views/HomeView.jsx';
import TahunAreaView from './views/TahunAreaView.jsx';
import AreaTahunTipeGasView from './views/AreaTahunTipeGasView.jsx';
import TahunTipeGasView from './views/TahunTipeGasView.jsx';
import TabelDataView from './views/TabelDataView.jsx';
import AnalisisNonParametrikView from './views/AnalisisNonParametrikView.jsx';
import InformasiPenggunaanView from './views/InformasiPenggunaanView.jsx';

const DEFAULT_COUNTRY = 'World';
const DEFAULT_YEAR_RANGE = [2013, 2023];
const GAS_KEYS = [
  { key: 'total', title: 'Total Emisi GHG (MtCO2)' },
  { key: 'co2', title: 'Emisi Gas CO2 (MtCO2)' },
  { key: 'n2o', title: 'Emisi Gas N2O (MtCO2)' },
  { key: 'ch4', title: 'Emisi Gas CH4 (MtCO2)' },
];

export default function MainGrid() {
  // State untuk UI
  const [activeComponentIndex, setActiveComponentIndex] = useState(0);
  const [showScroll, setShowScroll] = useState(false);

  // State untuk data dan filter
  const [country, setCountry] = useState(DEFAULT_COUNTRY);
  const [yearRange, setYearRange] = useState(DEFAULT_YEAR_RANGE);
  const [stats, setStats] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [countryCode, setCountryCode] = useState('WLD');

  // Logic untuk mencetak semua halaman
  const printComponentRef = useRef(null);
  const handlePrint = useReactToPrint({
    content: () => printComponentRef.current,
    documentTitle: `Laporan Lengkap - Emisi GHG - ${country}`,
  });

  // --- HOOKS ---

  // 1. Listener untuk perintah cetak dari komponen manapun
  useEffect(() => {
    const triggerPrint = () => handlePrint();
    window.addEventListener('print:request', triggerPrint);
    return () => {
      window.removeEventListener('print:request', triggerPrint);
    };
  }, [handlePrint]);

  // 2. Listener untuk navigasi menu dari sidebar
  useEffect(() => {
    const handleMenuSelect = (event) => {
      setActiveComponentIndex(event.detail.menuIndex);
      window.scrollTo({ top: 0, behavior: 'smooth' });
    };
    window.addEventListener('mainmenu:select', handleMenuSelect);
    return () => {
      window.removeEventListener('mainmenu:select', handleMenuSelect);
    };
  }, []);

  // 3. Listener untuk tombol scroll-to-top
  useEffect(() => {
    const handleScroll = () => setShowScroll(window.scrollY > 200);
    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  // 4. Listener untuk mengambil data dari API saat filter berubah
  useEffect(() => {
    if (!country || yearRange.length !== 2) return;
    setLoading(true);
    setError(null);
    const loadData = async () => {
      try {
        const countriesRes = await fetch('http://127.0.0.1:8000/countries');
        const countriesData = await countriesRes.json();
        const countryObj = countriesData.countries.find(c => c.name === country);
        setCountryCode(countryObj ? countryObj.code : 'WLD');

        const statsRes = await fetch(`http://127.0.0.1:8000/statistics?country_code=${countryObj ? countryObj.code : 'WLD'}&start_year=${yearRange[0]}&end_year=${yearRange[1]}`);
        const statsData = await statsRes.json();
        setStats(statsData);
      } catch (err) {
        setError('Gagal memuat data statistik.');
        console.error('Error loading data:', err);
      } finally {
        setLoading(false);
      }
    };
    loadData();
  }, [country, yearRange]);


  // --- PENGATURAN KOMPONEN ---

  // Array komponen untuk ditampilkan secara interaktif di layar
  const components = [
    <HomeView />,
    <TahunAreaView
      stats={stats} loading={loading} error={error} country={country}
      setCountry={setCountry} yearRange={yearRange} setYearRange={setYearRange}
      setStats={setStats} countryCode={countryCode} gasKeys={GAS_KEYS}
    />,
    <AreaTahunTipeGasView
      stats={stats} yearRange={yearRange} country={country}
      loading={loading} error={error}
    />,
    <TahunTipeGasView />,
    <TabelDataView />,
    <AnalisisNonParametrikView />,
    <InformasiPenggunaanView />,
    // <AboutView />, 
    // <FeedbackView />,
  ];


  return (
    <Box id="dashboard-print-wrapper" sx={{ width: '100%'}}>
      {/* Konten yang terlihat oleh pengguna */}
      <Box>
        {components[activeComponentIndex]}
      </Box>

      {/* Bagian Footer dan Tombol Scroll */}
      <Copyright sx={{ my: 4 }} />
      <Zoom in={showScroll}>
        <Fab
          color="primary"
          size="medium"
          onClick={() => window.scrollTo({ top: 0, behavior: 'smooth' })}
          sx={{ position: 'fixed', bottom: 32, right: 32, zIndex: 1201 }}
          aria-label="scroll to top"
        >
          <KeyboardArrowUpIcon sx={{ fontSize: 32 }} />
        </Fab>
      </Zoom>
    </Box>
  );
}