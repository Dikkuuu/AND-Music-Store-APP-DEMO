enum StockFilter { semua, tersedia, habis }

class MenuItem {
  final String id;
  final String nama;
  final String harga;
  final String kategori;
  final String gambar;
  final String deskripsi;
  final bool tersedia;

  const MenuItem({
    required this.id,
    required this.nama,
    required this.harga,
    required this.kategori,
    required this.gambar,
    required this.deskripsi,
    this.tersedia = true,
  });

  MenuItem copyWith({bool? tersedia}) {
    return MenuItem(
      id: id,
      nama: nama,
      harga: harga,
      kategori: kategori,
      gambar: gambar,
      deskripsi: deskripsi,
      tersedia: tersedia ?? this.tersedia,
    );
  }
}

const List<MenuItem> initialMusicCatalog = [
  MenuItem(
    id: 'm1',
    nama: 'Fender Player Stratocaster',
    harga: 'Rp 12.500.000',
    kategori: 'Gitar Elektrik',
    gambar: 'images/stratocaster.png',
    deskripsi:
        'Gitar elektrik dengan body alder, neck maple profil Modern C, dan konfigurasi pickup Alnico 5 SSS untuk karakter suara jernih hingga blues-rock.',
  ),
  MenuItem(
    id: 'm2',
    nama: 'Yamaha FG800 Dreadnought',
    harga: 'Rp 3.450.000',
    kategori: 'Gitar Akustik',
    gambar: 'images/akustik_dreadnought.png',
    deskripsi:
        'Gitar akustik steel-string dengan top solid Sitka spruce dan scalloped bracing untuk resonansi frekuensi rendah yang tebal dan bertenaga.',
  ),
  MenuItem(
    id: 'm3',
    nama: 'Squier Classic Vibe Jazz Bass',
    harga: 'Rp 6.800.000',
    kategori: 'Bass Elektrik',
    gambar: 'images/bass_jazz.png',
    deskripsi:
        'Bass 4-senar dengan dual Fender-Designed Alnico single-coil pickups dan profil neck ramping yang nyaman untuk teknik fingerstyle maupun slap.',
  ),
  MenuItem(
    id: 'm4',
    nama: 'Ibanez TS9 Tube Screamer',
    harga: 'Rp 1.850.000',
    kategori: 'Efek Gitar',
    gambar: 'images/pedal_overdrive.png',
    deskripsi:
        'Pedal overdrive legendaris dengan karakter mid-hump hangat untuk mendorong tabung amplifier maupun mempertegas solo gitar.',
  ),
  MenuItem(
    id: 'm5',
    nama: 'Boss Katana-50 MkII Amp',
    harga: 'Rp 4.750.000',
    kategori: 'Amplifier',
    gambar: 'images/ampli_gitar.png',
    deskripsi:
        'Amplifier combo 50-watt dengan 5 karakter amp bawaan, efek terintegrasi, serta kontrol daya untuk latihan kamar hingga panggung kecil.',
  ),
  MenuItem(
    id: 'm6',
    nama: 'Roland XPS-10 Synthesizer',
    harga: 'Rp 7.900.000',
    kategori: 'Keyboard & Synth',
    gambar: 'images/synth_keyboard.png',
    deskripsi:
        'Keyboard synthesizer 61-tuts ringan dengan lebih dari 1.500 suara instrumen panggung, audio pad, dan fitur split/layer instan.',
  ),
  MenuItem(
    id: 'm7',
    nama: 'Alesis Nitro Mesh Drum Kit',
    harga: 'Rp 6.950.000',
    kategori: 'Drum Elektrik',
    gambar: 'images/drum_elektrik.png',
    deskripsi:
        'Set drum elektrik 8-piece dengan mesh head responsif yang senyap, 40 kit siap pakai, dan konektivitas USB MIDI untuk rekaman.',
  ),
  MenuItem(
    id: 'm8',
    nama: 'Audio-Technica AT2020 Mic',
    harga: 'Rp 1.650.000',
    kategori: 'Pro Audio',
    gambar: 'images/mic_kondensor.png',
    deskripsi:
        'Mikrofon kondensor cardioid diafragma sedang dengan penanganan SPL tinggi, ideal untuk rekaman vokal dan instrumen akustik di home studio.',
  ),
  MenuItem(
    id: 'm9',
    nama: 'Focusrite Scarlett 2i2 Gen 4',
    harga: 'Rp 3.150.000',
    kategori: 'Audio Interface',
    gambar: 'images/audio_interface.png',
    deskripsi:
        'Audio interface USB-C 2-in/2-out dengan preamp ultra-low-noise, mode Air khas konsol studio, dan konverter 24-bit/192kHz.',
  ),
  MenuItem(
    id: 'm10',
    nama: 'Sony MDR-7506 Studio Monitor',
    harga: 'Rp 1.750.000',
    kategori: 'Headphone',
    gambar: 'images/headphone_monitor.png',
    deskripsi:
        'Headphone closed-back standar industri penyiaran dan rekaman dengan driver neodymium 40mm yang akurat untuk mixing dan tracking.',
  ),
];