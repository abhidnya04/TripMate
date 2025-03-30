import 'dart:io'; 
import 'package:appdev/flight_booking_screen.dart';
import 'package:appdev/itinerary_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';

class GoaItinerary extends StatefulWidget {
  @override
  _GoaItineraryState createState() => _GoaItineraryState();
}

class _GoaItineraryState extends State<GoaItinerary> {
  final Itinerary itineraryData = Itinerary(
    title: "4-Day Goa Trip with Friends (Low Budget)",
    lodgingOptions: [
      LodgingOption(hotelName: "Zostel Goa", price: "₹800 per night", link: "https://www.zostel.com/goa"),
      LodgingOption(hotelName: "Pappi Chulo Hostel", price: "₹600 per night", link: "https://www.pappichulo.com/")
    ],
    days: [
      DayPlan(
        dayNumber: 1,
        title: "Beaches & Shacks",
        morning: "Relax at Baga Beach and enjoy water sports.",
        afternoon: "Have lunch at Britto’s Shack and explore Anjuna Beach.",
        evening: "Party at Curlies Beach Shack.",
        dinnerRecommendation: DinnerRecommendation(
          restaurantName: "Curlies Beach Shack",
          cuisine: "Goan, Seafood",
          link: "https://www.curliesgoa.com/"
        ),
      ),
      DayPlan(
        dayNumber: 2,
        title: "North Goa Exploration",
        morning: "Visit Aguada Fort and Candolim Beach.",
        afternoon: "Try local Goan thali at Ritz Classic.",
        evening: "Sunset at Chapora Fort (Dil Chahta Hai point).",
        dinnerRecommendation: DinnerRecommendation(
          restaurantName: "Ritz Classic",
          cuisine: "Goan, Seafood",
          link: "https://www.zomato.com/goa/ritz-classic"
        ),
      ),
      DayPlan(
        dayNumber: 3,
        title: "South Goa & Hidden Gems",
        morning: "Explore Palolem Beach and rent a kayak.",
        afternoon: "Lunch at Fisherman’s Wharf near Colva Beach.",
        evening: "Relax at Colva Beach and enjoy live music.",
        dinnerRecommendation: DinnerRecommendation(
          restaurantName: "Fisherman’s Wharf",
          cuisine: "Goan, Continental",
          link: "https://www.thefishermanswharf.in/"
        ),
      ),
      DayPlan(
        dayNumber: 4,
        title: "Local Markets & Departure",
        morning: "Shop at Mapusa Market for souvenirs.",
        afternoon: "Brunch at Vinayak Family Restaurant.",
        evening: "Relax at Vagator Beach before heading back.",
        dinnerRecommendation: DinnerRecommendation(
          restaurantName: "Vinayak Family Restaurant",
          cuisine: "Goan, Vegetarian",
          link: "https://www.zomato.com/goa/vinayak-family-restaurant"
        ),
      ),
    ],
    budgetFriendlyTips: [
      "Rent scooters for cheap travel around Goa.",
      "Eat at local shacks for authentic and budget-friendly meals.",
      "Book hostels or dorms instead of hotels.",
      "Try free entry beach parties instead of expensive clubs."
    ],
  );
Future<void> _generatePdf(BuildContext context) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(itineraryData.title, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text("Lodging Options:", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            ...itineraryData.lodgingOptions.map((lodging) => pw.Text("- ${lodging.hotelName} (${lodging.price})")),
            pw.SizedBox(height: 20),
            pw.Text("Daily Plan:", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            ...itineraryData.days.map((day) => pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("Day ${day.dayNumber}: ${day.title}", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                    pw.Text("Morning: ${day.morning}"),
                    pw.Text("Afternoon: ${day.afternoon}"),
                    pw.Text("Evening: ${day.evening}"),
                     pw.Text("Dinner: ${day.dinnerRecommendation.restaurantName} (${day.dinnerRecommendation.cuisine})"),
                    pw.SizedBox(height: 10),
                  ],
                )),
            pw.SizedBox(height: 20),
            pw.Text("Budget-Friendly Tips:", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            ...itineraryData.budgetFriendlyTips.map((tip) => pw.Text("- $tip")),
          ],
        ),
      ),
    );

    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = "${directory.path}/Shimla_Itinerary.pdf";
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("PDF saved successfully!"), action: SnackBarAction(label: "Open", onPressed: () => OpenFile.open(filePath))),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to save PDF.")));
    }
  }

  Future<void> _launchURL(BuildContext context, String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to open link: $url')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Goa Itinerary'), centerTitle: true),
      body: ListView(padding: const EdgeInsets.all(16.0), children: [
        Text(itineraryData.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
        FlightBookingWidget(),
        const SizedBox(height: 10),
        
        Text("Lodging Options:", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...itineraryData.lodgingOptions.map((lodging) => Card(
          elevation: 4,
          child: ListTile(
            title: Text(lodging.hotelName, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Price: ${lodging.price}"),
            trailing: IconButton(icon: const Icon(Icons.open_in_new), onPressed: () => _launchURL(context, lodging.link)),
          ),
        )),
        const SizedBox(height: 20),
       
        Text("Daily Plan:", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...itineraryData.days.map((day) => Card(
          elevation: 4,
          child: ExpansionTile(
            title: Text("Day ${day.dayNumber}: ${day.title}",
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("🌅 Morning:", style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(day.morning),
                    const SizedBox(height: 8),
                    Text("🌞 Afternoon:", style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(day.afternoon),
                    const SizedBox(height: 8),
                    Text("🌆 Evening:", style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(day.evening),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () => _launchURL(context, day.dinnerRecommendation.link),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: "Dinner: ", 
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            TextSpan(
                              text: "${day.dinnerRecommendation.restaurantName} (${day.dinnerRecommendation.cuisine})",
                              style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
        
        const SizedBox(height: 20),

        Text("Budget-Friendly Tips:", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...itineraryData.budgetFriendlyTips.map((tip) => ListTile(
          leading: const Icon(Icons.monetization_on),
          title: Text(tip, style: const TextStyle(fontSize: 15)),
        )),
        ElevatedButton(onPressed: () => _generatePdf(context), child: const Text("Download Itinerary")),
        const SizedBox(height: 40),
      ]),
    );
  }
}
