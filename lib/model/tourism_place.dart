class TourismPlace {
  String name;
  String location;
  String description;
  String openDays;
  String openTime;
  String ticketPrice;
  String imageAsset;
  List<String> imageUrls;
  List<String> reviews;

  TourismPlace({
    required this.name,
    required this.location,
    required this.description,
    required this.openDays,
    required this.openTime,
    required this.ticketPrice,
    required this.imageAsset,
    required this.imageUrls,
    required this.reviews,
  });
}

var tourismPlaceList = [
  TourismPlace(
    name: 'Pantai Kuta',
    location: 'Kuta, Bali',
    description:
        'Pantai Kuta adalah salah satu pantai paling terkenal di Bali. Dikenal dengan ombaknya yang cocok untuk berselancar, pantai ini juga menawarkan pemandangan matahari terbenam yang spektakuler. Cocok untuk wisatawan yang mencari aktivitas pantai dan suasana malam yang hidup.',
    openDays: 'Open Everyday',
    openTime: '06:00 - 19:00',
    ticketPrice: 'Gratis',
    imageAsset: 'images/pantai_kuta.jpg',
    imageUrls: [],
    reviews: [
      'Pantai yang sangat indah, ombaknya sempurna untuk berselancar!',
      'Pemandangan matahari terbenamnya luar biasa.',
      'Tempat yang ideal untuk bersantai dan menikmati suasana pantai.'
    ],
  ),
  TourismPlace(
    name: 'Pura Besakih',
    location: 'Karangasem, Bali',
    description:
        'Pura Besakih adalah pura terbesar dan paling suci di Bali, sering disebut sebagai "Mother Temple" dari Bali. Terletak di lereng Gunung Agung, pura ini merupakan pusat kegiatan keagamaan dan memiliki pemandangan yang menakjubkan. Pengunjung dapat merasakan atmosfer spiritual dan budaya Bali yang mendalam di sini.',
    openDays: 'Open Everyday',
    openTime: '08:00 - 18:00',
    ticketPrice: 'Rp 50,000',
    imageAsset: 'images/pura_besakih.jpg',
    imageUrls: [],
    reviews: [
      'Pemandangan yang sangat menakjubkan dan suasana yang damai.',
      'Sangat direkomendasikan untuk pengalaman spiritual.',
      'Arsitektur yang indah dan kaya akan sejarah.'
    ],
  ),
  TourismPlace(
    name: 'Monkey Forest',
    location: 'Ubud, Bali',
    description:
        'Ubud Monkey Forest adalah hutan tropis yang dihuni oleh kelompok monyet ekor panjang. Selain bertemu dengan monyet yang jinak, pengunjung juga dapat menjelajahi kuil kuno dan menikmati suasana hutan yang tenang. Destinasi ini ideal bagi pecinta alam dan satwa liar.',
    openDays: 'Open Everyday',
    openTime: '07:00 - 18:00',
    ticketPrice: 'Rp 60,000',
    imageAsset: 'images/monkey_forest.jpg',
    imageUrls: [],
    reviews: [
      'Pengalaman yang sangat menyenangkan melihat monyet!',
      'Suasana hutan yang tenang dan damai.',
      'Kuil-kuilnya sangat indah dan menarik untuk dijelajahi.'
    ],
  ),
  TourismPlace(
    name: 'Tanah Lot',
    location: 'Tabanan, Bali',
    description:
        'Tanah Lot adalah salah satu pura laut yang paling ikonik di Bali. Terletak di atas batu karang besar yang menghadap ke Samudra Hindia, pura ini menjadi tempat yang sempurna untuk menikmati keindahan matahari terbenam. Kunjungan ke Tanah Lot akan memberikan pengalaman spiritual yang unik dan pemandangan alam yang menakjubkan.',
    openDays: 'Open Everyday',
    openTime: '08:00 - 19:00',
    ticketPrice: 'Rp 60,000',
    imageAsset: 'images/tanah_lot.jpg',
    imageUrls: [],
    reviews: [
      'Sangat indah saat matahari terbenam.',
      'Tempat yang bagus untuk foto-foto!',
      'Suasana yang sangat menenangkan.'
    ],
  ),
  TourismPlace(
    name: 'GWK',
    location: 'Jimbaran, Bali',
    description:
        'Garuda Wisnu Kencana (GWK) adalah taman budaya dengan patung raksasa Dewa Wisnu yang menunggangi Garuda. Terletak di Jimbaran, GWK menawarkan pemandangan yang menakjubkan, pertunjukan seni, dan berbagai kegiatan budaya. Tempat ini sangat cocok untuk menikmati seni dan budaya Bali dalam satu lokasi.',
    openDays: 'Open Everyday',
    openTime: '06:00 - 19:00',
    ticketPrice: 'Rp 60.000',
    imageAsset: 'images/gwk.jpg',
    imageUrls: [],
    reviews: [
      'Patungnya sangat mengesankan!',
      'Pertunjukan budayanya luar biasa.',
      'Tempat yang wajib dikunjungi bagi pecinta budaya.'
    ],
  ),
  TourismPlace(
    name: 'Kebun Raya',
    location: 'Bedugul, Bali',
    description:
        'Kebun Raya Bedugul adalah taman botani yang luas di tengah pegunungan Bedugul. Dengan koleksi berbagai jenis tanaman, termasuk anggrek dan tanaman langka, kebun raya ini menawarkan suasana yang sejuk dan menyegarkan. Ideal untuk berjalan-jalan santai dan menikmati keindahan alam.',
    openDays: 'Open Everyday',
    openTime: '06:00 - 19:00',
    ticketPrice: 'Rp 30.000',
    imageAsset: 'images/bedugul.jpg',
    imageUrls: [],
    reviews: [
      'Tempat yang indah untuk berjalan-jalan.',
      'Pemandangan yang sangat menenangkan dan alami.',
      'Sangat cocok untuk keluarga dan anak-anak.'
    ],
  ),
  TourismPlace(
    name: 'Pura Ulun Danu',
    location: 'Bedugul, Bali',
    description:
        'Pura Ulun Danu adalah pura yang terletak di tepi Danau Beratan, dikelilingi oleh pegunungan hijau yang menakjubkan. Dikenal dengan arsitekturnya yang indah dan lokasi yang menawan, pura ini adalah tempat yang sempurna untuk merasakan kedamaian dan keindahan alam. Tempat ini juga populer untuk berfoto dan bersantai.',
    openDays: 'Open Everyday',
    openTime: '06:00 - 19:00',
    ticketPrice: 'Rp 40.000',
    imageAsset: 'images/pura_ulun_danu.jpg',
    imageUrls: [],
    reviews: [
      'Arsitektur yang sangat cantik.',
      'Pemandangan danau yang menakjubkan.',
      'Tempat yang sempurna untuk bersantai.'
    ],
  ),
  TourismPlace(
    name: 'Klinking Beach',
    location: 'Nusa Dua, Bali',
    description:
        'Klinking Beach adalah pantai tersembunyi yang menawarkan suasana tenang dengan pasir putih dan air laut yang jernih. Ideal untuk berenang, berjemur, atau hanya bersantai sambil menikmati keindahan laut. Tempat ini cocok bagi mereka yang mencari pelarian dari keramaian.',
    openDays: 'Open Everyday',
    openTime: '06:00 - 19:00',
    ticketPrice: 'Rp 10.000',
    imageAsset: 'images/klinking_beach.jpg',
    imageUrls: [],
    reviews: [
      'Pantai yang tenang dan indah.',
      'Air laut yang jernih, sangat cocok untuk berenang.',
      'Sangat menyenangkan untuk bersantai di sini.'
    ],
  ),
];
