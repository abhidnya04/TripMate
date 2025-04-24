import 'package:flutter/material.dart';

class MaldivesArticle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Maldives")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset('assets/maldives.jpg', fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Discover the Serenity of Maldives: A Paradise Unveiled",
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    "The Maldives, a tropical archipelago scattered across the Indian Ocean, is synonymous with tranquility and beauty. Known for its overwater bungalows, turquoise lagoons, and vibrant marine life, the Maldives is a dream destination for travelers seeking luxury, adventure, or pure relaxation. Beyond its postcard-perfect views lies a culture shaped by the sea and a commitment to sustainable paradise living.",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  _buildSection(
                    "Overwater Villas and Luxurious Resorts",
                    "The Maldives is world-famous for its luxurious resorts, especially the iconic overwater villas that stretch into the sea. Whether you’re waking up to sunrise views or stepping directly into the ocean from your deck, the experience is unmatched. Resorts often feature private pools, spas, and world-class dining, making it a top choice for honeymoons and luxury getaways."
                  ),
                  _buildSection(
                    "Snorkeling and Scuba Diving Adventures",
                    "Beneath the calm, clear waters lies a vibrant underwater world teeming with life. Coral reefs, manta rays, sea turtles, and colorful fish make snorkeling and diving in the Maldives unforgettable. Many resorts have their own house reefs, and excursions to dive sites like Banana Reef and Maaya Thila are popular among enthusiasts."
                  ),
                  _buildSection(
                    "Sunsets, Sandbanks, and Secluded Beaches",
                    "Few places on Earth offer sunsets as magical as those in the Maldives. Whether you're enjoying dinner on a private sandbank or simply strolling along a secluded beach, the island’s natural beauty offers peaceful moments away from the world. Some resorts even organize floating breakfasts and movie nights under the stars."
                  ),
                  _buildSection(
                    "Maldivian Culture and Island Life",
                    "While many travelers come for the luxury, a visit to a local island offers insight into the Maldivian way of life. Traditional fishing, Bodu Beru drumming, and vibrant craft markets show a culture deeply connected to the ocean. Friendly locals and colorful mosques add to the island charm."
                  ),
                  _buildSection(
                    "Sustainable Tourism and Eco-Islands",
                    "With rising sea levels, the Maldives is at the forefront of sustainable tourism. Many resorts are now eco-friendly, powered by solar energy and committed to coral restoration. Staying at one of these eco-resorts allows you to enjoy paradise while supporting its preservation."
                  ),
                  _buildSection(
                    "Romantic Getaways and Wellness Retreats",
                    "Whether it’s a candlelit dinner by the sea or a couple’s spa retreat, the Maldives is perfect for romance. Yoga sessions at sunrise, overwater spa treatments, and quiet evenings in your villa make it a top destination for couples and wellness seekers alike."
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
