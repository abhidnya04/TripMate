import 'package:flutter/material.dart';

class NewYorkArticle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New York")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset('assets/lombok.jpg', fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Unveiling the Magic of New York: Where Dreams, Diversity, and Skyline Collide",
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    "New York City — a cultural powerhouse, a melting pot of people, and a beacon of ambition. From Broadway lights to world-famous museums, and towering skyscrapers to peaceful park strolls, the Big Apple offers a little bit of everything. It’s a place where energy never fades, where inspiration is on every corner, and where every street tells a story.",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  _buildSection(
                    "Times Square: The Heartbeat of Manhattan",
                    "Bright lights, bustling crowds, and towering billboards — Times Square is where New York's electrifying energy truly comes alive. Whether you're there for the Broadway shows, the street performers, or the iconic New Year's Eve ball drop, it's an unforgettable sensory experience."
                  ),
                  _buildSection(
                    "Central Park: Nature in the Concrete Jungle",
                    "Escape the fast pace of the city with a walk through Central Park. This green oasis spans over 800 acres and offers tranquil lakes, scenic trails, cultural performances, and even a zoo. It's a place where both locals and visitors come to relax, exercise, and connect with nature."
                  ),
                  _buildSection(
                    "Statue of Liberty & Ellis Island",
                    "A symbol of freedom and hope, the Statue of Liberty is an essential New York experience. A ferry ride takes you to this iconic statue and nearby Ellis Island, which tells the story of millions of immigrants who once passed through its gates in search of a better life."
                  ),
                  _buildSection(
                    "Brooklyn Vibes and Street Art",
                    "Brooklyn has become a cultural hub known for its art, food, and indie spirit. Explore the vibrant street murals of Bushwick, stroll across the Brooklyn Bridge, or try world-class pizza in Williamsburg. It’s where old-school charm meets creative innovation."
                  ),
                  _buildSection(
                    "Museums, Galleries, and the Arts",
                    "New York is a cultural feast with institutions like the Metropolitan Museum of Art, MoMA, and the American Museum of Natural History. Whether you're into fine art, dinosaurs, or avant-garde exhibitions, there’s something for every curious mind."
                  ),
                  _buildSection(
                    "The Skyline and Rooftop Views",
                    "Few skylines are as iconic as New York’s. From the top of the Empire State Building to rooftop bars in Midtown, the view of the city — especially at sunset — is a sight to behold. It’s a moment of reflection above the hustle below."
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
