import 'dart:io';
import 'package:appdev/flight_booking_screen.dart';
import 'package:appdev/itinerary_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';

class DelhiItinerary extends StatefulWidget {
  @override
  _DelhiItineraryState createState() => _DelhiItineraryState();
}

class _DelhiItineraryState extends State<DelhiItinerary> {
  final Itinerary itineraryData = Itinerary(
    title: "2-Day Delhi Family Trip",
    lodgingOptions: [
      LodgingOption(hotelName: "The Park New Delhi", price: "₹6,500 per night", link: "https://www.theparkhotels.com/"),
      LodgingOption(hotelName: "Hotel Surya International", price: "₹4,000 per night", link: "https://www.hotelsuryainternational.com/")
    ],
    days: [
      DayPlan(
        dayNumber: 1,
        title: "Historic Delhi & India Gate",
        morning: "Visit Red Fort and explore Chandni Chowk for local shopping and food.",
        afternoon: "Visit India Gate and Rajpath for sightseeing and photography.",
        evening: "Enjoy a light show at Akshardham Temple and dinner at Gulati Restaurant.",
        dinnerRecommendation: DinnerRecommendation(
          restaurantName: "Gulati Restaurant",
          cuisine: "North Indian, Mughlai",
          link: "https://www.zomato.com/ncr/gulati-pandara-road"
        ),
      ),
      DayPlan(
        dayNumber: 2,
        title: "Cultural & Shopping Tour",
        morning: "Visit Lotus Temple and Humayun's Tomb.",
        afternoon: "Explore Dilli Haat for shopping and traditional food.",
        evening: "Visit Connaught Place for street shopping, then dinner at Saravana Bhavan.",
        dinnerRecommendation: DinnerRecommendation(
          restaurantName: "Saravana Bhavan",
          cuisine: "South Indian",
          link: "https://www.saravanabhavan.com/"
        ),
      ),
    ],
    budgetFriendlyTips: [
      "Use Delhi Metro for quick and budget-friendly transport.",
      "Try street food at Chandni Chowk instead of high-end restaurants.",
      "Buy souvenirs from Dilli Haat instead of overpriced malls.",
      "Visit historical sites early to avoid crowds and save on entry fees."
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
      appBar: AppBar(title: const Text('Delhi Itinerary'), centerTitle: true),
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
        const SizedBox(height: 20),

        ElevatedButton(onPressed: () => _generatePdf(context), child: const Text("Download Itinerary")),
        const SizedBox(height: 40),
      ]),
      
    );
  }
}