import 'package:flutter/material.dart';

class KyotoArticle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kyoto")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Full-width image without padding
            SizedBox(
              width: double.infinity,
              child: Image.asset('assets/kyoto.jpg', fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Exploring the Ancient Temples of Kyoto, Japan",
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),

                  const SizedBox(height: 16.0),
                  const Text(
                    "Kyoto, the cultural heart of Japan, is a city where history and tradition come alive through its ancient temples. As the former imperial capital, Kyoto boasts over a thousand temples, each with its own unique charm, architecture, and spiritual significance. Whether you're drawn to the grandeur of golden pavilions, the serenity of Zen gardens, or the mystique of moss-covered shrines, Kyoto's temples offer an unforgettable journey through time.",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  // _buildSection("Tofuku-ji: The Zen Autumn Wonderland",  ""),
                  _buildSection("Kinkaku-ji: The Golden Pavilion", "One of Kyoto’s most iconic landmarks, Kinkaku-ji (Golden Pavilion) is a Zen temple covered in brilliant gold leaf, reflecting beautifully in the surrounding pond. Originally a shogun’s villa, it was transformed into a temple in the 15th century. Strolling through its meticulously landscaped gardens, visitors can experience the harmony of nature and architecture that defines traditional Japanese aesthetics."),
                  _buildSection("Ginkaku-ji: The Silver Pavilion",  "In contrast to Kinkaku-ji, Ginkaku-ji (Silver Pavilion) embraces understated elegance. Built in the late 15th century, it was designed as a retreat for the shogun and later converted into a Zen temple. The temple’s famous sand garden, the “Sea of Silver Sand,” and its mossy pathways make it a peaceful spot for quiet reflection."),
                  _buildSection("Kiyomizu-dera: A Temple with a View",  "Perched on a hillside, Kiyomizu-dera offers breathtaking views of Kyoto from its massive wooden terrace. Founded in 778, the temple is dedicated to Kannon, the goddess of mercy. Visitors often drink from the Otowa Waterfall, believing its streams grant health, success, or love. In autumn and spring, the temple is particularly stunning, surrounded by fiery maple leaves or cherry blossoms."),
                  _buildSection("Ryoan-ji: The Zen Rock Garden",  "Ryoan-ji is home to Japan’s most famous rock garden, a masterpiece of Zen minimalism. The 15 carefully arranged rocks in a bed of white gravel invite contemplation, as their true meaning remains open to interpretation. The temple’s tranquil atmosphere and scenic pond make it a must-visit for those seeking inner peace."),
                  _buildSection("Fushimi Inari Taisha: The Thousand Torii Gates", "Although technically a Shinto shrine, Fushimi Inari Taisha is an essential stop on any Kyoto temple tour. The mesmerizing path of thousands of vermilion torii gates leads up Mount Inari, offering a mystical journey through the sacred forest. Dedicated to Inari, the deity of rice and prosperity, the shrine is famous for its fox statues, believed to be messengers of the gods."),
                  _buildSection("Tofuku-ji: The Zen Autumn Wonderland", 
                  "If you visit Kyoto in the fall, Tofuku-ji is the place to see vibrant autumn foliage. Its Tsutenkyo Bridge overlooks a valley of maple trees that turn brilliant shades of red and orange. The temple’s Zen gardens, featuring checkerboard moss and raked gravel, showcase Kyoto’s mastery of landscape design."),


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
