// src/components/RegexSearch.jsx

import * as React from 'react';
import { useState } from 'react';
import TextField from '@mui/material/TextField';
import InputAdornment from '@mui/material/InputAdornment';
import SearchIcon from '@mui/icons-material/Search';

// Fungsi untuk menghapus sorotan sebelumnya
const clearHighlights = () => {
  const highlighted = document.querySelectorAll('mark.search-highlight');
  highlighted.forEach(el => {
    const parent = el.parentNode;
    parent.replaceChild(document.createTextNode(el.textContent), el);
    parent.normalize(); // Menggabungkan node teks yang terpisah
  });
};

// Fungsi rekursif untuk mencari dan menyorot teks
const highlightText = (node, regex) => {
  if (node.nodeType === 3) { // Node tipe 3 adalah Text Node
    const match = node.data.match(regex);
    if (match) {
      const mark = document.createElement('mark');
      mark.className = 'search-highlight'; // Tambahkan kelas untuk identifikasi
      const matchText = document.createTextNode(match[0]);
      mark.appendChild(matchText);

      const after = node.splitText(node.data.indexOf(match[0]));
      after.deleteData(0, match[0].length);
      
      const parent = node.parentNode;
      parent.insertBefore(mark, after);
    }
  } else if (node.nodeType === 1 && node.nodeName !== 'SCRIPT' && node.nodeName !== 'STYLE' && node.className !== 'search-highlight') {
    // Node tipe 1 adalah Element Node
    // Jelajahi semua anak dari elemen ini
    for (let i = 0; i < node.childNodes.length; i++) {
      highlightText(node.childNodes[i], regex);
    }
  }
};


export default function RegexSearch() {
  const [query, setQuery] = useState('');

  const handleSearch = (event) => {
    // Hanya jalankan saat tombol Enter ditekan
    if (event.key === 'Enter') {
      clearHighlights(); // Bersihkan hasil sebelumnya

      if (!query) {
        return; // Jangan cari jika input kosong
      }

      try {
        const regex = new RegExp(query, 'gi'); // 'g' = global, 'i' = case-insensitive
        // Mulai pencarian dari body dokumen
        highlightText(document.body, regex);
      } catch (e) {
        console.error("Regex tidak valid:", e);
        // Anda bisa menambahkan notifikasi untuk pengguna di sini
      }
    }
  };

  return (
    <>
      {/* Tambahkan style untuk sorotan, bisa diletakkan di file CSS utama */}
      <style>{`.search-highlight { background-color: yellow; color: black; }`}</style>
      <TextField
        size="small"
        variant="outlined"
        placeholder="Cari"
        value={query}
        onChange={(e) => setQuery(e.target.value)}
        onKeyDown={handleSearch}
        InputProps={{
          startAdornment: (
            <InputAdornment position="start">
              <SearchIcon />
            </InputAdornment>
          ),
          sx: { borderRadius: '12px' }
        }}
      />
    </>
  );
}