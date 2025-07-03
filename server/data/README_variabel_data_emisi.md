# Dokumentasi Variabel File Data Emisi (data_*.csv)

Dokumentasi ini menjelaskan variabel/keterangan kolom pada setiap file data emisi gas rumah kaca yang dapat digunakan untuk analisis nonparametrik di aplikasi R Shiny.

## 1. data_ch4.csv
- **Country Name**: Nama negara
- **Country Code**: Kode negara (ISO)
- **Indicator Name**: Nama indikator (Methane (CH4) emissions (total) excluding LULUCF (Mt CO2e))
- **Indicator Code**: Kode indikator
- **1960, 1961, ..., 2024**: Nilai emisi CH4 per tahun (dalam Mt CO2e) untuk setiap negara

  **Variabel untuk analisis nonparametrik:**
  - Nilai emisi CH4 per tahun (1960-2024) untuk setiap negara

## 2. data_co2.csv
- **Country Name**: Nama negara
- **Country Code**: Kode negara (ISO)
- **Indicator Name**: Nama indikator (Carbon dioxide (CO2) emissions (total) excluding LULUCF (Mt CO2e))
- **Indicator Code**: Kode indikator
- **1960, 1961, ..., 2024**: Nilai emisi CO2 per tahun (dalam Mt CO2e) untuk setiap negara

  **Variabel untuk analisis nonparametrik:**
  - Nilai emisi CO2 per tahun (1960-2024) untuk setiap negara

## 3. data_n2o.csv
- **Country Name**: Nama negara
- **Country Code**: Kode negara (ISO)
- **Indicator Name**: Nama indikator (Nitrous oxide (N2O) emissions (total) excluding LULUCF (Mt CO2e))
- **Indicator Code**: Kode indikator
- **1960, 1961, ..., 2024**: Nilai emisi N2O per tahun (dalam Mt CO2e) untuk setiap negara

  **Variabel untuk analisis nonparametrik:**
  - Nilai emisi N2O per tahun (1960-2024) untuk setiap negara

## 4. data_total_greenhouse.csv
- **Country Name**: Nama negara
- **Country Code**: Kode negara (ISO)
- **Indicator Name**: Nama indikator (Total greenhouse gas emissions excluding LULUCF (Mt CO2e))
- **Indicator Code**: Kode indikator
- **1960, 1961, ..., 2024**: Nilai total emisi gas rumah kaca per tahun (dalam Mt CO2e) untuk setiap negara

  **Variabel untuk analisis nonparametrik:**
  - Nilai total emisi gas rumah kaca per tahun (1960-2024) untuk setiap negara

---

**Catatan:**
- Semua file memiliki struktur serupa dan dapat digunakan untuk analisis nonparametrik pada data emisi tahunan per negara.
- Analisis nonparametrik dapat dilakukan pada distribusi nilai emisi antar negara, antar tahun, atau tren waktu.
