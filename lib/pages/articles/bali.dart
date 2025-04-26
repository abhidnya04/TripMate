import 'package:flutter/material.dart';

class BaliArticle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bali")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Full-width image
            SizedBox(
              width: double.infinity,
              child: Image.asset('assets/bali.jpg', fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Art and Tradition: Exploring Bali's Cultural Scene",
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    "Bali is much more than just a tropical paradise; it's a living canvas of culture, art, and tradition. From colorful ceremonies to intricate wood carvings and expressive dance, Bali’s cultural heartbeat is felt in every village and temple. For travelers seeking more than beaches, Bali offers a vibrant journey into the island's soul.",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  _buildSection(
                    "Ubud: The Artistic Capital",
                    "Nestled in the lush highlands, Ubud is Bali’s cultural and artistic hub. It's home to countless galleries, craft studios, and traditional markets. You can witness Balinese painters, sculptors, and batik artists at work, and even join a workshop to learn the crafts yourself. Ubud Palace and its nightly dance performances are a gateway to Bali’s storytelling traditions."
                  ),
                  _buildSection(
                    "Balinese Dance and Drama",
                    "Balinese dance is more than performance—it’s a form of religious expression. Traditional dances like Barong and Legong are rich with symbolism and often performed in temples during ceremonies. The precise gestures and vibrant costumes captivate audiences and tell ancient tales of good versus evil."
                  ),
                  _buildSection(
                    "Temple Rituals and Offerings",
                    "Daily offerings known as *canang sari*—made from palm leaves, flowers, and incense—are placed on doorsteps, shrines, and sidewalks as a way of giving thanks. Attending a temple ceremony, especially during festivals like Galungan, provides a window into Bali’s spiritual devotion and community life."
                  ),
                  _buildSection(
                    "Traditional Crafts: Wood, Stone & Silver",
                    "Villages like Mas, Celuk, and Batubulan are known for their artistic heritage. Mas excels in wood carving, Celuk in silver jewelry, and Batubulan in stone sculpture. Visitors can explore workshops, interact with artisans, and bring home unique handmade pieces that reflect Bali's identity."
                  ),
                  _buildSection(
                    "The Sacred Kecak Dance at Uluwatu",
                    "Performed at sunset on a cliff overlooking the sea, the Kecak dance is one of Bali’s most iconic experiences. With no instruments, only the chanting of dozens of men, the performance reenacts scenes from the Ramayana epic in a hypnotic, unforgettable display of rhythm and drama."
                  ),
                  _buildSection(
                    "Balinese Painting Styles",
                    "Bali is also known for its distinctive painting styles such as Kamasan, Batuan, and Ubud styles. These artworks often depict Hindu epics, daily Balinese life, or mythical creatures. Galleries across the island allow art lovers to dive into these visual narratives and even meet the artists behind them."
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(
            description,
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
