const express = require("express");
const app = express();
const cors = require("cors");

app.use(cors());

app.get("/istighotsah", (req, res) => {
  res.json({
    arabic: `
اَسْتَغْفِرُ اللّٰهَ الْعَظِيْمَ الَّذِيْ لاَ إِلٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّوْمُ وَأَتُوْبُ إِلَيْهِ
اَسْتَغْفِرُ اللّٰهَ الْعَظِيْمَ مِنْ جَمِيْعِ الذُّنُوْبِ وَالآثَامِ وَأَتُوْبُ إِلَيْهِ
اَللّٰهُمَّ صَلِّ عَلَى سَيِّدِنَا مُحَمَّدٍ صَلاَةً تُنْجِيْنَا بِهَا مِنْ جَمِيْعِ الأَهْوَالِ وَالآفَاتِ وَتَقْضِيْ لَنَا بِهَا جَمِيْعَ الْحَاجَاتِ وَتُطَهِّرُنَا بِهَا مِنْ جَمِيْعِ السَّيِّئَاتِ
يَا رَبَّنَا تَقَبَّلْ مِنَّا دُعَاءَنَا إِنَّكَ أَنْتَ السَّمِيْعُ الْعَلِيْمُ
يَا اللهُ، يَا قَدِيْمَ الإِحْسَانِ، يَا دَائِمَ الإِفْضَالِ، يَا بَاسِطَ الْيَدَيْنِ بِالْعَطَايَا
نَسْأَلُكَ السَّلاَمَةَ وَالْعَافِيَةَ وَالْمُعَافَاةَ الدَّائِمَةَ فِي الدِّينِ وَالدُّنْيَا وَالآخِرَةِ
يَا حَيُّ يَا قَيُّوْمُ بِرَحْمَتِكَ نَسْتَغِيْثُ
  `,

    latin: `
Astaghfirullaahal ‘Azhiimalladzii laa ilaaha illaa Huwal Hayyul Qayyum wa atuubu ilaih.
Astaghfirullaahal ‘Azhiima min jamii‘idz dzunuubi wal aatsaami wa atuubu ilaih.

Allaahumma shalli ‘alaa Sayyidinaa Muhammadin shalaatan tunjinaa bihaa min jamii’il ahwaali wal aafaati
wa taqdhii lanaa bihaa jamii'al haajaati wa tuthahhirunaa bihaa min jamii'is sayyiaati.

Yaa Rabbanaa taqabbal minnaa du'aa'anaa innaka antas samii'ul 'aliim.

Yaa Allaah, Yaa Qadiimal ihsaan, Yaa Daa’imal ifdhool, Yaa Baasithal yadayni bil ‘athayaa.
Nas’aluka as-salaamata wal ‘aafiyata wal mu’aafaata daaimatan fid diin wad dunyaa wal aakhirah.

Yaa Hayyu Yaa Qayyumu birahmatika nastaghiits.
  `,

    translation: `
“Aku memohon ampun kepada Allah Yang Maha Agung, yang tidak ada Tuhan selain Dia, Yang Maha Hidup lagi terus menerus mengurus makhluk-Nya, dan aku bertobat kepada-Nya.

Aku memohon ampun kepada Allah Yang Maha Agung dari seluruh dosa dan kesalahan, dan aku bertobat kepada-Nya.

Ya Allah, limpahkanlah shalawat kepada Nabi Muhammad, shalawat yang dengannya Engkau menyelamatkan kami dari segala ketakutan dan bencana, dengan itu pula Engkau memenuhi semua hajat kami, Engkau membersihkan kami dari semua keburukan.

Ya Tuhan kami, terimalah doa kami. Sesungguhnya Engkau Maha Mendengar lagi Maha Mengetahui.

Wahai Allah, Dzat yang selalu memberi kebaikan, yang tak pernah berhenti memberi karunia, yang melapangkan tangan dengan pemberian. Kami memohon keselamatan, kesehatan, dan perlindungan yang terus-menerus dalam urusan agama, dunia, dan akhirat.

Wahai Dzat Yang Maha Hidup dan Berdiri Sendiri, dengan rahmat-Mu kami memohon pertolongan.”
    `
  });
});

app.listen(3000, () => {
  console.log("Server running on http://localhost:3000");
});
