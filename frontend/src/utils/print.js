// src/utils/print.js

// Cetak langsung ke printer (seperti Ctrl+P) tanpa dialog simpan file PDF secara manual
export const printDashboardToPDF = () => {
    const originalTitle = document.title;
    document.title = 'dashboard-cetak';

    // Print langsung
    window.print();
    
    // Cleanup
    document.title = originalTitle;
  };