












import 'dart:io';
import 'package:appdev/flight_booking_screen.dart';
import 'package:appdev/itinerary_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';

class ItineraryPage extends StatefulWidget {
  final String itinerary;

  const ItineraryPage({super.key, required this.itinerary});

  @override
  _ItineraryPageState createState() => _ItineraryPageState();
}

class _ItineraryPageState extends State<ItineraryPage> {
  Future<void> _launchURL(BuildContext context, String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to open link: $url')),
      );
    }
  }

  Future<void> _generatePdf(BuildContext context, Itinerary itineraryData) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(itineraryData.title, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text("Lodging Options:", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            ...itineraryData.lodgingOptions.map((hotel) => pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(hotel.hotelName, style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                    pw.Text("Price: ${hotel.price}"),
                    pw.SizedBox(height: 5),
                  ],
                )),
            pw.SizedBox(height: 20),
            pw.Text("Daily Plan:", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            ...itineraryData.days.map((day) => pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("Day ${day.dayNumber}: ${day.title}", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 5),
                    pw.Text("Morning: ${day.morning}"),
                    pw.Text("Afternoon: ${day.afternoon}"),
                    pw.Text("Evening: ${day.evening}"),
                    pw.Text("Dinner: ${day.dinnerRecommendation.restaurantName}", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
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
      final sanitizedTitle = itineraryData.title.replaceAll(" ", "_");
      final filePath = "${directory.path}/$sanitizedTitle.pdf";
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("PDF saved successfully!"),
          action: SnackBarAction(
            label: "Open",
            onPressed: () => OpenFile.open(filePath),
          ),
        ),
      );
    } catch (e) {
      debugPrint("Error saving PDF: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save PDF.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Itinerary itineraryData = Itinerary.fromJson(widget.itinerary);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Itinerary'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () => _generatePdf(context, itineraryData),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            itineraryData.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xff03045e)),
          ),
          const SizedBox(height: 10),

          FlightBookingWidget(),
          const SizedBox(height: 10),

          Text("Lodging Options:", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...itineraryData.lodgingOptions.map((hotel) => Card(
                elevation: 4,
                shadowColor: Color(0xff03045e),
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  title: Text(hotel.hotelName, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("Price: ${hotel.price}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.open_in_new , color: Color(0xff03045e),),
                    onPressed: () => _launchURL(context, hotel.link),
                  ),
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
                          Text("Morning:", style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(day.morning),
                          const SizedBox(height: 8),
                          Text("Afternoon:", style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(day.afternoon),
                          const SizedBox(height: 8),
                          Text("Evening:", style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(day.evening),
                        ],
                      ),
                    )
                  ],
                ),
          )),
         
          const SizedBox(height: 20),
          Text("Budget-Friendly Tips:", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...itineraryData.budgetFriendlyTips.map((tip) => ListTile(
                leading: const Icon(Icons.monetization_on , color: Color(0xff03045e),),
                title: Text(tip,style: const TextStyle(fontSize: 15)),
              )),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _generatePdf(context, itineraryData),
            child: const Text("Download Itinerary"),
          ),

          const SizedBox(height: 40),
           
        ],
      ),
    );
  }
}










// import 'dart:io';
// import 'package:appdev/flight_booking_screen.dart';
// import 'package:appdev/itinerary_model.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// //import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:open_file/open_file.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ItineraryPage extends StatelessWidget {
//   final String itinerary;

//   const ItineraryPage({super.key, required this.itinerary});

//   Future<void> _launchURL(BuildContext context, String url) async {
//     try {
//       final Uri uri = Uri.parse(url);
//       if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
//         throw Exception('Could not launch $url');
//       }
//     } catch (e) {
//       debugPrint('Error launching URL: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to open link: $url')),
//       );
//     }
//   }

//   Future<void> _generatePdf(BuildContext context, Itinerary itineraryData) async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) => pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             pw.Text(itineraryData.title, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 10),
//             pw.Text("Lodging Options:", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//             ...itineraryData.lodgingOptions.map((hotel) => pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text(hotel.hotelName, style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
//                     pw.Text("Price: ${hotel.price}"),
//                     pw.SizedBox(height: 5),
//                   ],
//                 )),
//             pw.SizedBox(height: 20),
//             pw.Text("Daily Plan:", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//             ...itineraryData.days.map((day) => pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text("Day ${day.dayNumber}: ${day.title}", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
//                     pw.SizedBox(height: 5),
//                     pw.Text("Morning: ${day.morning}"),
//                     pw.Text("Afternoon: ${day.afternoon}"),
//                     pw.Text("Evening: ${day.evening}"),
//                     pw.Text("Dinner: ${day.dinnerRecommendation.restaurantName}", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                     pw.SizedBox(height: 10),
//                   ],
//                 )),
//             pw.SizedBox(height: 20),
//             pw.Text("Budget-Friendly Tips:", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//             ...itineraryData.budgetFriendlyTips.map((tip) => pw.Text("- $tip")),
//           ],
//         ),
//       ),
//     );

//     try {
//       final directory = await getApplicationDocumentsDirectory();
//        final sanitizedTitle = itineraryData.title;
//       final filePath = "${directory.path}/$sanitizedTitle  .pdf";
//       final file = File(filePath);
//       await file.writeAsBytes(await pdf.save());

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("PDF saved successfully!"),
//           action: SnackBarAction(
//             label: "Open",
//             onPressed: () => OpenFile.open(filePath),
//           ),
//         ),
//       );
//     } catch (e) {
//       debugPrint("Error saving PDF: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Failed to save PDF.")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Itinerary itineraryData = Itinerary.fromJson(itinerary);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Your Itinerary'),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           Text(
//             itineraryData.title,
//             style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),

//            FlightBookingWidget(),
           
//           Text(
//             "Lodging Options:",
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           ...itineraryData.lodgingOptions.map((hotel) => ListTile(
//                 title: Text(hotel.hotelName),
//                 subtitle: Text("Price: ${hotel.price}"),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.open_in_new),
//                   onPressed: () {
//                     debugPrint("Trying to open: ${hotel.link}");
//                     _launchURL(context, hotel.link);
//                   },
//                 ),
//               )),
//           const SizedBox(height: 20),
//           Text(
//             "Daily Plan:",
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           ...itineraryData.days.map((day) {
//             return Card(
//               elevation: 4,
//               margin: const EdgeInsets.symmetric(vertical: 8),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Day ${day.dayNumber}: ${day.title}",
//                       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8),
//                     Text("Morning:", style: const TextStyle(fontWeight: FontWeight.bold)),
//                     Text(day.morning),
//                     const SizedBox(height: 8),
//                     Text("Afternoon:", style: const TextStyle(fontWeight: FontWeight.bold)),
//                     Text(day.afternoon),
//                     const SizedBox(height: 8),
//                     Text("Evening:", style: const TextStyle(fontWeight: FontWeight.bold)),
//                     Text(day.evening),
//                     const SizedBox(height: 10),
//                     Text(
//                       "Dinner: ${day.dinnerRecommendation.restaurantName}",
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//           const SizedBox(height: 20),
//           Text(
//             "Budget-Friendly Tips:",
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           ...itineraryData.budgetFriendlyTips.map((tip) => ListTile(
//                 leading: const Icon(Icons.monetization_on),
//                 title: Text(tip),
//               )),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () => _generatePdf(context, itineraryData),
//             child: const Text("Download Itinerary"),
//           ),
//            const SizedBox(height: 40),
//         ],
//       ),
//     );
//   }
// }
















// import 'package:appdev/itinerary_model.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/pdf.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';

// class ItineraryPage extends StatelessWidget {
//   final String itinerary;

//   const ItineraryPage({super.key, required this.itinerary});

//   Future<void> _launchURL(BuildContext context, String url) async {
//     try {
//       final Uri uri = Uri.parse(url);
//       if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
//         throw Exception('Could not launch $url');
//       }
//     } catch (e) {
//       debugPrint('Error launching URL: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to open link: $url')),
//       );
//     }
//   }

//   Future<void> _generatePDF(BuildContext context, Itinerary itineraryData) async {
//     final pdf = pw.Document();
//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) => pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             pw.Text("Your Itinerary", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 10),
//             pw.Text(itineraryData.title, style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 10),
//             pw.Text("Lodging Options:", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
//             ...itineraryData.lodgingOptions.map((hotel) => pw.Text("${hotel.hotelName} - Price: ${hotel.price}")),
//             pw.SizedBox(height: 10),
//             pw.Text("Daily Plan:", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
//             ...itineraryData.days.map((day) => pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text("Day ${day.dayNumber}: ${day.title}", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                     pw.Text("Morning: ${day.morning}"),
//                     pw.Text("Afternoon: ${day.afternoon}"),
//                     pw.Text("Evening: ${day.evening}"),
//                     pw.Text("Dinner: ${day.dinnerRecommendation.restaurantName}"),
//                     pw.SizedBox(height: 5),
//                   ],
//                 )),
//             pw.SizedBox(height: 10),
//             pw.Text("Budget-Friendly Tips:", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
//             ...itineraryData.budgetFriendlyTips.map((tip) => pw.Text("- $tip")),
//           ],
//         ),
//       ),
//     );

//     final directory = await getApplicationDocumentsDirectory();
//     final file = File("${directory.path}/itinerary.pdf");
//     await file.writeAsBytes(await pdf.save());

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('PDF saved at ${file.path}')),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Itinerary itineraryData = Itinerary.fromJson(itinerary);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Your Itinerary'),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           Text(
//             itineraryData.title,
//             style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () => _generatePDF(context, itineraryData),
//             child: const Text("Download Itinerary"),
//           ),
//           const SizedBox(height: 10),
//           Text("Lodging Options:", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           ...itineraryData.lodgingOptions.map((hotel) => ListTile(
//                 title: Text(hotel.hotelName),
//                 subtitle: Text("Price: ${hotel.price}"),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.open_in_new),
//                   onPressed: () => _launchURL(context, hotel.link),
//                 ),
//               )),
//           const SizedBox(height: 20),
//           Text("Daily Plan:", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           ...itineraryData.days.map((day) => Card(
//                 elevation: 4,
//                 margin: const EdgeInsets.symmetric(vertical: 8),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Day ${day.dayNumber}: ${day.title}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                       Text("Morning: ${day.morning}"),
//                       Text("Afternoon: ${day.afternoon}"),
//                       Text("Evening: ${day.evening}"),
//                       Text("Dinner: ${day.dinnerRecommendation.restaurantName}", style: const TextStyle(fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                 ),
//               )),
//           const SizedBox(height: 20),
//           Text("Budget-Friendly Tips:", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           ...itineraryData.budgetFriendlyTips.map((tip) => ListTile(
//                 leading: const Icon(Icons.monetization_on),
//                 title: Text(tip),
//               )),
//         ],
//       ),
//     );
//   }
// }


















// import 'package:appdev/itinerary_model.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ItineraryPage extends StatelessWidget {
//   final String itinerary;

//   const ItineraryPage({super.key, required this.itinerary});

//   Future<void> _launchURL(BuildContext context, String url) async {
//     try {
//       final Uri uri = Uri.parse(url);
//       if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
//         throw Exception('Could not launch $url');
//       }
//     } catch (e) {
//       debugPrint('Error launching URL: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to open link: $url')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Itinerary itineraryData = Itinerary.fromJson(itinerary);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Your Itinerary'),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           Text(
//             itineraryData.title,
//             style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),

//           // Lodging Options
//           Text(
//             "Lodging Options:",
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           ...itineraryData.lodgingOptions.map((hotel) => ListTile(
//                 title: Text(hotel.hotelName),
//                 subtitle: Text("Price: ${hotel.price}"),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.open_in_new),
//                   onPressed: () {
//                     debugPrint("Trying to open: ${hotel.link}");
//                     _launchURL(context, hotel.link);
//                   },
//                 ),
//               )),

//           const SizedBox(height: 20),
//           Text(
//             "Daily Plan:",
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           ...itineraryData.days.map((day) {
//             return Card(
//               elevation: 4,
//               margin: const EdgeInsets.symmetric(vertical: 8),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Day ${day.dayNumber}: ${day.title}",
//                       style: const TextStyle(
//                           fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8),
//                     Text("Morning:",
//                         style: const TextStyle(fontWeight: FontWeight.bold)),
//                     Text(day.morning),
//                     const SizedBox(height: 8),
//                     Text("Afternoon:",
//                         style: const TextStyle(fontWeight: FontWeight.bold)),
//                     Text(day.afternoon),
//                     const SizedBox(height: 8),
//                     Text("Evening:",
//                         style: const TextStyle(fontWeight: FontWeight.bold)),
//                     Text(day.evening),
//                     const SizedBox(height: 10),
//                     Text(
//                       "Dinner: ${day.dinnerRecommendation.restaurantName}",
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),

//           const SizedBox(height: 20),
//           Text(
//             "Budget-Friendly Tips:",
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           ...itineraryData.budgetFriendlyTips.map((tip) => ListTile(
//                 leading: const Icon(Icons.monetization_on),
//                 title: Text(tip),
//               )),
//         ],
//       ),
//     );
//   }
// }
















// import 'package:flutter/material.dart';

// class ItineraryPage extends StatelessWidget {
//   final String itinerary;

//   const ItineraryPage({super.key, required this.itinerary});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Generated Itinerary")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Text(itinerary, style: TextStyle(fontSize: 16)),
//         ),
//       ),
//     );
//   }
//}










// import 'dart:io';
// import 'package:appdev/flight_booking_screen.dart';
// import 'package:appdev/itinerary_model.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// //import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:open_file/open_file.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ItineraryPage extends StatelessWidget {
//   final String itinerary;

//   const ItineraryPage({super.key, required this.itinerary});

//   Future<void> _launchURL(BuildContext context, String url) async {
//     try {
//       final Uri uri = Uri.parse(url);
//       if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
//         throw Exception('Could not launch $url');
//       }
//     } catch (e) {
//       debugPrint('Error launching URL: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to open link: $url')),
//       );
//     }
//   }

//   Future<void> _generatePdf(BuildContext context, Itinerary itineraryData) async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) => pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             pw.Text(itineraryData.title, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 10),
//             pw.Text("Lodging Options:", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//             ...itineraryData.lodgingOptions.map((hotel) => pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text(hotel.hotelName, style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
//                     pw.Text("Price: ${hotel.price}"),
//                     pw.SizedBox(height: 5),
//                   ],
//                 )),
//             pw.SizedBox(height: 20),
//             pw.Text("Daily Plan:", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//             ...itineraryData.days.map((day) => pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text("Day ${day.dayNumber}: ${day.title}", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
//                     pw.SizedBox(height: 5),
//                     pw.Text("Morning: ${day.morning}"),
//                     pw.Text("Afternoon: ${day.afternoon}"),
//                     pw.Text("Evening: ${day.evening}"),
//                     pw.Text("Dinner: ${day.dinnerRecommendation.restaurantName}", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                     pw.SizedBox(height: 10),
//                   ],
//                 )),
//             pw.SizedBox(height: 20),
//             pw.Text("Budget-Friendly Tips:", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//             ...itineraryData.budgetFriendlyTips.map((tip) => pw.Text("- $tip")),
//           ],
//         ),
//       ),
//     );

//     try {
//       final directory = await getApplicationDocumentsDirectory();
//        final sanitizedTitle = itineraryData.title;
//       final filePath = "${directory.path}/$sanitizedTitle  .pdf";
//       final file = File(filePath);
//       await file.writeAsBytes(await pdf.save());

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("PDF saved successfully!"),
//           action: SnackBarAction(
//             label: "Open",
//             onPressed: () => OpenFile.open(filePath),
//           ),
//         ),
//       );
//     } catch (e) {
//       debugPrint("Error saving PDF: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Failed to save PDF.")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Itinerary itineraryData = Itinerary.fromJson(itinerary);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Your Itinerary'),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           Text(
//             itineraryData.title,
//             style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),

//            FlightBookingWidget(),
           
//           Text(
//             "Lodging Options:",
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           ...itineraryData.lodgingOptions.map((hotel) => ListTile(
//                 title: Text(hotel.hotelName),
//                 subtitle: Text("Price: ${hotel.price}"),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.open_in_new),
//                   onPressed: () {
//                     debugPrint("Trying to open: ${hotel.link}");
//                     _launchURL(context, hotel.link);
//                   },
//                 ),
//               )),
//           const SizedBox(height: 20),
//           Text(
//             "Daily Plan:",
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           ...itineraryData.days.map((day) {
//             return Card(
//               elevation: 4,
//               margin: const EdgeInsets.symmetric(vertical: 8),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Day ${day.dayNumber}: ${day.title}",
//                       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8),
//                     Text("Morning:", style: const TextStyle(fontWeight: FontWeight.bold)),
//                     Text(day.morning),
//                     const SizedBox(height: 8),
//                     Text("Afternoon:", style: const TextStyle(fontWeight: FontWeight.bold)),
//                     Text(day.afternoon),
//                     const SizedBox(height: 8),
//                     Text("Evening:", style: const TextStyle(fontWeight: FontWeight.bold)),
//                     Text(day.evening),
//                     const SizedBox(height: 10),
//                     Text(
//                       "Dinner: ${day.dinnerRecommendation.restaurantName}",
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//           const SizedBox(height: 20),
//           Text(
//             "Budget-Friendly Tips:",
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           ...itineraryData.budgetFriendlyTips.map((tip) => ListTile(
//                 leading: const Icon(Icons.monetization_on),
//                 title: Text(tip),
//               )),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () => _generatePdf(context, itineraryData),
//             child: const Text("Download Itinerary"),
//           ),
//            const SizedBox(height: 40),
//         ],
//       ),
//     );
//   }
// }
















// import 'package:appdev/itinerary_model.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/pdf.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';

// class ItineraryPage extends StatelessWidget {
//   final String itinerary;

//   const ItineraryPage({super.key, required this.itinerary});

//   Future<void> _launchURL(BuildContext context, String url) async {
//     try {
//       final Uri uri = Uri.parse(url);
//       if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
//         throw Exception('Could not launch $url');
//       }
//     } catch (e) {
//       debugPrint('Error launching URL: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to open link: $url')),
//       );
//     }
//   }

//   Future<void> _generatePDF(BuildContext context, Itinerary itineraryData) async {
//     final pdf = pw.Document();
//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) => pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             pw.Text("Your Itinerary", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 10),
//             pw.Text(itineraryData.title, style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 10),
//             pw.Text("Lodging Options:", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
//             ...itineraryData.lodgingOptions.map((hotel) => pw.Text("${hotel.hotelName} - Price: ${hotel.price}")),
//             pw.SizedBox(height: 10),
//             pw.Text("Daily Plan:", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
//             ...itineraryData.days.map((day) => pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text("Day ${day.dayNumber}: ${day.title}", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                     pw.Text("Morning: ${day.morning}"),
//                     pw.Text("Afternoon: ${day.afternoon}"),
//                     pw.Text("Evening: ${day.evening}"),
//                     pw.Text("Dinner: ${day.dinnerRecommendation.restaurantName}"),
//                     pw.SizedBox(height: 5),
//                   ],
//                 )),
//             pw.SizedBox(height: 10),
//             pw.Text("Budget-Friendly Tips:", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
//             ...itineraryData.budgetFriendlyTips.map((tip) => pw.Text("- $tip")),
//           ],
//         ),
//       ),
//     );

//     final directory = await getApplicationDocumentsDirectory();
//     final file = File("${directory.path}/itinerary.pdf");
//     await file.writeAsBytes(await pdf.save());

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('PDF saved at ${file.path}')),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Itinerary itineraryData = Itinerary.fromJson(itinerary);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Your Itinerary'),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           Text(
//             itineraryData.title,
//             style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () => _generatePDF(context, itineraryData),
//             child: const Text("Download Itinerary"),
//           ),
//           const SizedBox(height: 10),
//           Text("Lodging Options:", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           ...itineraryData.lodgingOptions.map((hotel) => ListTile(
//                 title: Text(hotel.hotelName),
//                 subtitle: Text("Price: ${hotel.price}"),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.open_in_new),
//                   onPressed: () => _launchURL(context, hotel.link),
//                 ),
//               )),
//           const SizedBox(height: 20),
//           Text("Daily Plan:", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           ...itineraryData.days.map((day) => Card(
//                 elevation: 4,
//                 margin: const EdgeInsets.symmetric(vertical: 8),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Day ${day.dayNumber}: ${day.title}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                       Text("Morning: ${day.morning}"),
//                       Text("Afternoon: ${day.afternoon}"),
//                       Text("Evening: ${day.evening}"),
//                       Text("Dinner: ${day.dinnerRecommendation.restaurantName}", style: const TextStyle(fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                 ),
//               )),
//           const SizedBox(height: 20),
//           Text("Budget-Friendly Tips:", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           ...itineraryData.budgetFriendlyTips.map((tip) => ListTile(
//                 leading: const Icon(Icons.monetization_on),
//                 title: Text(tip),
//               )),
//         ],
//       ),
//     );
//   }
// }


















// import 'package:appdev/itinerary_model.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ItineraryPage extends StatelessWidget {
//   final String itinerary;

//   const ItineraryPage({super.key, required this.itinerary});

//   Future<void> _launchURL(BuildContext context, String url) async {
//     try {
//       final Uri uri = Uri.parse(url);
//       if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
//         throw Exception('Could not launch $url');
//       }
//     } catch (e) {
//       debugPrint('Error launching URL: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to open link: $url')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Itinerary itineraryData = Itinerary.fromJson(itinerary);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Your Itinerary'),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           Text(
//             itineraryData.title,
//             style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),

//           // Lodging Options
//           Text(
//             "Lodging Options:",
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           ...itineraryData.lodgingOptions.map((hotel) => ListTile(
//                 title: Text(hotel.hotelName),
//                 subtitle: Text("Price: ${hotel.price}"),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.open_in_new),
//                   onPressed: () {
//                     debugPrint("Trying to open: ${hotel.link}");
//                     _launchURL(context, hotel.link);
//                   },
//                 ),
//               )),

//           const SizedBox(height: 20),
//           Text(
//             "Daily Plan:",
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           ...itineraryData.days.map((day) {
//             return Card(
//               elevation: 4,
//               margin: const EdgeInsets.symmetric(vertical: 8),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Day ${day.dayNumber}: ${day.title}",
//                       style: const TextStyle(
//                           fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8),
//                     Text("Morning:",
//                         style: const TextStyle(fontWeight: FontWeight.bold)),
//                     Text(day.morning),
//                     const SizedBox(height: 8),
//                     Text("Afternoon:",
//                         style: const TextStyle(fontWeight: FontWeight.bold)),
//                     Text(day.afternoon),
//                     const SizedBox(height: 8),
//                     Text("Evening:",
//                         style: const TextStyle(fontWeight: FontWeight.bold)),
//                     Text(day.evening),
//                     const SizedBox(height: 10),
//                     Text(
//                       "Dinner: ${day.dinnerRecommendation.restaurantName}",
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),

//           const SizedBox(height: 20),
//           Text(
//             "Budget-Friendly Tips:",
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           ...itineraryData.budgetFriendlyTips.map((tip) => ListTile(
//                 leading: const Icon(Icons.monetization_on),
//                 title: Text(tip),
//               )),
//         ],
//       ),
//     );
//   }
// }
















// import 'package:flutter/material.dart';

// class ItineraryPage extends StatelessWidget {
//   final String itinerary;

//   const ItineraryPage({super.key, required this.itinerary});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Generated Itinerary")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Text(itinerary, style: TextStyle(fontSize: 16)),
//         ),
//       ),
//     );
//   }
//}
