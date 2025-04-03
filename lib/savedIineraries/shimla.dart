import 'dart:io';
import 'package:appdev/flight_booking_screen.dart';
import 'package:appdev/itinerary_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';

class ShimlaItinerary extends StatefulWidget {
  @override
  _ShimlaItineraryState createState() => _ShimlaItineraryState();
}

class _ShimlaItineraryState extends State<ShimlaItinerary> {
  final Itinerary itineraryData = Itinerary(
    title: "3-Day Shimla Couple Trip",
    lodgingOptions: [
      LodgingOption(hotelName: "The Oberoi Cecil", price: "₹8,000 per night", link: "https://www.oberoihotels.com/"),
      LodgingOption(hotelName: "Clarkes Hotel", price: "₹5,500 per night", link: "https://www.clarkesshimla.com/")
    ],
    days: [
      DayPlan(
        dayNumber: 1,
        title: "Arrival & Mall Road Exploration",
        morning: "Arrive in Shimla, check into hotel, relax and freshen up.",
        afternoon: "Visit Mall Road, shop for souvenirs, and explore cafes.",
        evening: "Sunset at Scandal Point and dinner at Cafe Sol.",
        dinnerRecommendation: DinnerRecommendation(
      restaurantName: "Cafe Sol",
      cuisine: "Italian, Continental",
      link: "https://www.tripadvisor.in/Restaurant_Review-g304552-d970220-Reviews-Cafe_Sol-Shimla_Shimla_District_Himachal_Pradesh.html",
    ), 
      ),
      DayPlan(
        dayNumber: 2,
        title: "Kufri & Adventure Activities",
        morning: "Visit Kufri, enjoy horse riding and panoramic views.",
        afternoon: "Visit Himalayan Nature Park and Kufri Fun World.",
        evening: "Return to Shimla, dinner at Eighteen71 Cookhouse & Bar.",
        dinnerRecommendation:  DinnerRecommendation(
      restaurantName: "Eighteen71 Cookhouse & Bar",
      cuisine: "Indian, Continental",
      link: "https://www.zomato.com/shimla/eighteen71-cookhouse-bar-mall-road",
    ),
      ),
      DayPlan(
        dayNumber: 3,
        title: "Jakhoo Temple & Departure",
        morning: "Hike to Jakhoo Temple and enjoy the scenic beauty.",
        afternoon: "Relax at Ridge Road and visit Christ Church.",
        evening: "Head back to the hotel, checkout, and depart.",
         dinnerRecommendation: DinnerRecommendation(
    restaurantName: "The Devicos",
    cuisine: "Indian, Chinese, Continental",
    link: "https://www.zomato.com/shimla/the-devicos-mall-road",
  ),
      ),
    ],
    budgetFriendlyTips: [
      "Use local buses or shared taxis instead of private cabs.",
      "Book hotels in advance for better deals.",
      "Try local street food instead of expensive restaurants.",
      "Shop at local markets instead of high-end stores."
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
      appBar: AppBar(title: const Text('Shimla Itinerary'), centerTitle: true, actions: [IconButton(icon: const Icon(Icons.picture_as_pdf), onPressed: () => _generatePdf(context))]),
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
       
        // Daily Plan
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
      style: const TextStyle(color: Colors.black, ), // Clickable link style
      children: [
        TextSpan(
          text: "Dinner: ", 
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, decoration: TextDecoration.none), // Only "Dinner:" is bold and not underlined
        ),
        TextSpan(
          text: "${day.dinnerRecommendation.restaurantName} (${day.dinnerRecommendation.cuisine})",
          
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

    // Budget-Friendly Tips
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
