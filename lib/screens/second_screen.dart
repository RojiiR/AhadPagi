import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color darkBlue = Color(0xFF222B35); // Warna biru gelap

    return Scaffold(
      backgroundColor: darkBlue,
      body: Column(
        children: [
          // Bagian atas (header)
          Container(
            width: double.infinity,
            color: darkBlue,
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: const [
                Text(
                  'سورة يس',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Amiri',
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Surat Yā-Sīn',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          // Bagian tengah (isi ayat di latar abu-abu terang)
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.grey.shade200,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SingleChildScrollView(
                child: const Text(
                  '''
بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ
يس (1) وَالْقُرْآنِ الْحَكِيمِ (2)
إِنَّكَ لَمِنَ الْمُرْسَلِينَ (3)
عَلَى صِرَاطٍ مُّسْتَقِيمٍ (4)
تَنزِيلَ الْعَزِيزِ الرَّحِيمِ (5)
لِتُنذِرَ قَوْمًا مَّا أُنذِرَ آبَاؤُهُمْ فَهُمْ غَافِلُونَ (6)
لَقَدْ حَقَّ الْقَوْلُ عَلَى أَكْثَرِهِمْ فَهُمْ لَا يُؤْمِنُونَ (7)
إِنَّا جَعَلْنَا فِي أَعْنَاقِهِمْ أَغْلَالًا
فَهِيَ إِلَى الْأَذْقَانِ فَهُمْ مُّقْمَحُونَ (8)
وَجَعَلْنَا مِن بَيْنِ أَيْدِيهِمْ سَدًّا
وَمِنْ خَلْفِهِمْ سَدًّا فَأَغْشَيْنَاهُمْ فَهُمْ لَا يُبْصِرُونَ (9)
وَسَوَاءٌ عَلَيْهِمْ أَأَنذَرْتَهُمْ أَمْ لَمْ تُنذِرْهُمْ لَا يُؤْمِنُونَ (10)
إِنَّمَا تُنذِرُ مَنِ اتَّبَعَ الذِّكْرَ
وَخَشِيَ الرَّحْمَٰنَ بِالْغَيْبِ
فَبَشِّرْهُ بِمَغْفِرَةٍ وَأَجْرٍ كَرِيمٍ (11)
إِنَّا نَحْنُ نُحْيِي الْمَوْتَى
وَنَكْتُبُ مَا قَدَّمُوا وَآثَارَهُمْ
وَكُلَّ شَيْءٍ أَحْصَيْنَاهُ فِي إِمَامٍ مُّبِينٍ (12)
                  ''',
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontFamily: 'Amiri',
                    height: 2.0,
                  ),
                ),
              ),
            ),
          ),

          // Bagian bawah (footer biru gelap)
          Container(
            width: double.infinity,
            color: darkBlue,
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: const Center(
              child: Text(
                'An-nur 3 Murah Banyu',
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
