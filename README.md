# Dashboard Mata Kuliah Komputasi Statistik React JS + R
Dashboard ini menampilkan visualisasi gas efek rumah kaca secara global dan juga disertai analisis non parametriknya.  
Bagian frontend dashboard dibangun dengan React JS, sedangkan bagian backend menggunakan R. Bagian tampilan analisis dibuat dengan RShiny.  
Dependensi bisa dilihat pada package.json.   
## Cara menginstall
1. Clone Repo Github ini
2. Install dependensi di bagian frontend
```cmd
cd frontend
npm install
```
3. Setup server kemudian install dependensinya
```cmd
::(kembali ke direktori parent)
cd server
RScript run_both.R
::otomatis akan menginstall dependensi yang dibutuhkan
```
4. Apabila ada package R yang belum terinstall, maka bisa diinstall terlebih dahulu
```R
#misalnya nama packagenya adalah "car"

install.packages("car");
#atau buat line ini:
if (!require("car", character.only = TRUE)) {
install.packages("car")
library("car")
}
```
6. Run
Run frontend
```
::kembali ke parent directory
cd frontend
npm start
```
Run server
```
cd server
RScript run_both.R
```
## Preview
Nanti akan dilampirkan link preview setelah web ini dihosting.
