import 'dart:io'; 
import 'package:appdev/flight_booking_screen.dart';
import 'package:appdev/itinerary_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';

class KolkataItinerary extends StatefulWidget {
  @override
  _KolkataItineraryState createState() => _KolkataItineraryState();
}

class _KolkataItineraryState extends State<KolkataItinerary> {
  final Itinerary itineraryData = Itinerary(
    title: "2-Day Solo Trip to Kolkata",
    lodgingOptions: [
      LodgingOption(hotelName: "The Peerless Inn Kolkata", price: "₹4,500 per night", link: "https://www.peerlesshotels.com/"),
      LodgingOption(hotelName: "Astoria Hotel Kolkata", price: "₹3,000 per night", link: "https://www.astoriahotelkolkata.com/")
    ],
    days: [
      DayPlan(
        dayNumber: 1,
        title: "Historical & Cultural Exploration",
        morning: "Start your day with breakfast at Flurys, then visit Victoria Memorial and St. Paul's Cathedral.",
        afternoon: "Explore the Indian Museum and grab lunch at Peter Cat (famous for Chelo Kebabs).",
        evening: "Visit Park Street for shopping and enjoy dinner at Mocambo.",
        dinnerRecommendation: DinnerRecommendation(
          restaurantName: "Mocambo",
          cuisine: "Continental, Mughlai",
          link: "https://www.zomato.com/kolkata/mocambo-park-street-area"
        ),
      ),
      DayPlan(
        dayNumber: 2,
        title: "Spiritual & Local Delights",
        morning: "Enjoy a sunrise visit to Howrah Bridge and breakfast at a local chai shop, then visit Dakshineswar Kali Temple.",
        afternoon: "Explore Kumartuli (famous for idol-making) and try authentic Bengali cuisine at 6 Ballygunge Place.",
        evening: "Walk along Princep Ghat and relax at a riverside café before heading back.",
        dinnerRecommendation: DinnerRecommendation(
          restaurantName: "6 Ballygunge Place",
          cuisine: "Bengali",
          link: "https://www.zomato.com/kolkata/6-ballygunge-place-ballygunge"
        ),
      ),
    ],
    budgetFriendlyTips: [
      "Use Kolkata Metro and local taxis for budget-friendly travel.",
      "Try local street food like Kathi Rolls and Puchkas instead of expensive restaurants.",
      "Visit free attractions like Princep Ghat and Howrah Bridge.",
      "Book hotels in advance to get the best deals."
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
      appBar: AppBar(title: const Text('Kolkata Itinerary'), centerTitle: true),
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
