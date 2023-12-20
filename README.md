# PBP-F11

## Nama Anggota Kelompok PBP-F11:
- Arju Naja
- Cyrilus Yodha
- Farrel Ayman Abisatyo
- Humam Al Labib
- Raquel Nayyara

## Link Markdown: [![Build status](https://build.appcenter.ms/v0.1/apps/c0c13a2b-ec57-4ba3-946e-7ed6a2f1f1ca/branches/main/badge)](https://appcenter.ms)
## Cerita Aplikasi

Kongres Bahasa Indonesia merupakan salah satu acara terkemuka dalam bidang kebahasaan dan kesastraan di Indonesia. Kongres ini diselenggarakan oleh Badan Pengembangan dan Pembinaan Bahasa, Kementerian Pendidikan, Kebudayaan, Riset, dan Teknologi setiap lima tahun sekali. Kongres Bahasa Indonesia memiliki peran penting dalam membahas isu-isu kebahasaan dan kesastraan yang relevan dengan perkembangan bangsa.

Dengan itu, kami ingin membuat aplikasi yang mengembangkan konsep dasar katalog buku di Django dengan menerapkan model berbasis class. Selain itu, kami ingin memasukkan setidaknya 100 data buku ke dalam basis data Django dari dataset katalog buku yang bervariasi. Sumber dataset ini dapat diperoleh dari berbagai sumber terpercaya seperti Project Gutenberg, Google Books API, Kaggle, atau Data Skripsi LONTAR. Dengan pendekatan ini, kami akan memiliki sistem yang memungkinkan penyimpanan, pengelolaan, dan penampilan informasi buku dengan baik di aplikasi Django yang kami kembangkan. 

Aplikasi yang ingin kami kembangkan bernama Bookly. Bookly adalah aplikasi yang menghadirkan pengalaman berbagi sesama pecinta buku. Pengguna dapat membuat profil pribadi, memberikan review, dan memberikan peringkat buku yang telah mereka baca. Pengguna dapat membentuk komunitas membaca, berpartisipasi dalam diskusi buku, dan mengikuti teman-teman mereka untuk memperluas jaringan literasi mereka. Bookly memiliki antarmuka yang intuitif dan ramah pengguna. Aplikasi ini mendorong minat literasi dan membantu pengguna menjelajahi dunia literatur dengan lebih mudah dan menyenangkan.

## Daftar Modul yang Akan Diimplementasikan
1. Auth (login n register), Show review, Search: kelompok
2. Profile: Cyrilus Yodha
3. Add review: Farrel Ayman
4. Edit/delete review: Raquel Nayyara
5. Add book: Human al Labib
6. Edit/delete book: Arju Naja

<table>
  <tr>
    <th>
      Modul
    </th>
    <th>
      Penjelasan
    </th>
  </tr>
  <tr>
    <td>
      Register
    </td>
    <td>
      Mendaftarkan user baru ke Aplikasi.
    </td>
  </tr>
  <tr>
    <td>
      Login
    </td>
    <td>
      Login ke Aplikasi sesuai user yang telah diregister
    </td>
  </tr>
  <tr>
    <td>
      Search
    </td>
    <td>
    Bisa search buku berdasarkan judul
    </td>
  </tr>
  <tr>
    <td>
      Show review
    </td>
    <td>
      Menampilkan output berupa kumpulan review buku dari buku yang dipilih di halaman search
    </td>
  </tr>
  <tr>
    <td>
      Profile (UR)
    </td>
    <td>
      Tab / Page baru yang dapat diaskes oleh member untuk melihat informasi mengenai pengguna serta melihat review yang telah diberikan olehnya.
    </td>
  </tr>
  <tr>
    <td>
      Add review (CR)
    </td>
    <td>
      Member dapat memberi review mengenai buku yang dipilih.
    </td>
  </tr>
  <tr>
    <td>
      Edit/delete review (UR)
    </td>
    <td>
      Mengubah dan menghapus review yang telah diberikan user untuk suatu buku
    </td>
  </tr>
  <tr>
    <td>
      Add book (CR)
    </td>
    <td>
      Memasukkan buku baru ke dalam dataset dan memastikan tidak memasukkan buku yang sudah ada.
    </td>
  </tr>
  <tr>
    <td>
      Edit/delete book (UR)
    </td>
    <td>
      Mengubah dan menghapus informasi mengenai suatu buku yang telah diberikan user untuk suatu buku
    </td>
  </tr>
</table>

## Sumber Dataset Katalog Buku
- https://drive.google.com/file/d/17jiAwHx_68zUrolbTl75IoLRFK_JLYrx/view
- https://univindonesia-my.sharepoint.com/:x:/g/personal/iisafriyanti_office_ui_ac_id/EY1Lmwm40rJLhtbWtKerNOYBI3BxiLSlDbLuL3mFIsw8wA?rtime=0DhkUsXI20g

## Role atau Peran Pengguna Beserta Deskripsinya
Dalam aplikasi kami, pengguna yang berinteraksi akan memiliki peran sebagai pengamat katalog buku yang kami sediakan. Para pengguna juga dapat menggunakan beberapa fitur yang disediakan oleh aplikasi kami, seperti add review, edit review, dan delete review. Selain itu, pengguna juga dapat menambahkan, mengubah, dan menghapus buku dalam dataset.

## Alur pengintegrasian dengan web service untuk terhubung dengan aplikasi web yang sudah dibuat saat Proyek Tengah Semester
1. Mendefinisikan model-model yang diperlukan saat pemanggilan web service.
2. Menambahkan dependensi http pada proyek aplikasi
3. Menambahkan potongan kode untuk memperbolehkan akses internet pada aplikasi Flutter di file android/app/src/main/AndroidManifest.xml.
4. Melakukan fetch data dengan hit endpoint API menggunakan method POST, GET, DELETE, dan lain-lain.
5. Data yang sudah di-fetch kemudian di-decode menjadi bentuk JSON.
6. Data dalam bentuk JSON dikonversi lagi menjadi data dalam bentuk sebuah model.
7. Data dalam bentuk model tersebut ditampilkan pada app Flutter.

## Menambahkan tautan berita acara ke README.md
[Tautan Berita](https://docs.google.com/spreadsheets/d/1iMTYbRv7P_zatXg2rPocMPP-_elBeP-Q/edit#gid=1894349254)
