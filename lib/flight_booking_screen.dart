 
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';

// class FlightBookingWidget extends StatefulWidget {
//   @override
//   _FlightBookingWidgetState createState() => _FlightBookingWidgetState();
// }

// class _FlightBookingWidgetState extends State<FlightBookingWidget> {
//   TextEditingController departureDateController = TextEditingController();
//   TextEditingController returnDateController = TextEditingController();
//   TextEditingController fromCityController = TextEditingController();
//   TextEditingController toCityController = TextEditingController();
//   bool isExpanded = false;
//   bool isRoundTrip = false;

//   final Map<String, String> airportCodes = {
//     "New Delhi": "DEL",
//     "Mumbai": "BOM",
//     "Bangalore": "BLR",
//     "Kolkata": "CCU",
//     "Chennai": "MAA",
//     "Hyderabad": "HYD",
//     "Pune": "PNQ",
//     "Goa": "GOI",
//     "Dubai": "DXB",
//     "New York": "JFK",
//     "London": "LHR",
//   };

//   void searchFlights() {
//     String? fromCode = airportCodes[fromCityController.text];
//     String? toCode = airportCodes[toCityController.text];

//     if (fromCode == null || toCode == null || departureDateController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please select cities and date!")),
//       );
//       return;
//     }

//     String formattedDeparture = _formatDate(departureDateController.text);
//     String formattedReturn = returnDateController.text.isNotEmpty ? _formatDate(returnDateController.text) : "";

//     String url = "https://www.makemytrip.com/flight/search?"
//         "itinerary=${fromCode}-${toCode}-${formattedDeparture}"
//         "${returnDateController.text.isNotEmpty ? "~${toCode}-${fromCode}-${formattedReturn}" : ""}"
//         "&tripType=${returnDateController.text.isEmpty ? 'O' : 'R'}"
//         "&paxType=A-1_C-0_I-0"
//         "&intl=false"
//         "&cabinClass=E"
//         "&lang=eng";

//      print("Generated URL: $url");      

//     _launchUrl(url);
//   }

//   String _formatDate(String date) {
//     DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
//     return DateFormat('ddMMyyyy').format(parsedDate); // Correct format for MakeMyTrip
//   }

//   Future<void> _launchUrl(String url) async {
//     Uri uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Could not open the website")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(vertical: 16),
//       child: Column(
//         children: [
//           ListTile(
//             leading: const Icon(Icons.flight, color: Colors.blue),
//             title: const Text("Find Flight", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             trailing: Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
//             onTap: () => setState(() => isExpanded = !isExpanded),
//           ),
//           if (isExpanded) ...[
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   buildAutoCompleteField("From", fromCityController),
//                   const SizedBox(height: 10),
//                   buildAutoCompleteField("To", toCityController),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: buildDateField("Departure Date", departureDateController),
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: buildDateField("Return Date", returnDateController, enabled: isRoundTrip),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: searchFlights,
//                     child: const Text("Search Flights"),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget buildAutoCompleteField(String label, TextEditingController controller) {
//     return Autocomplete<String>(
//       optionsBuilder: (TextEditingValue textEditingValue) {
//         if (textEditingValue.text.isEmpty) {
//           return const Iterable<String>.empty();
//         }
//         return airportCodes.keys.where((city) => city.toLowerCase().contains(textEditingValue.text.toLowerCase()));
//       },
//       onSelected: (String selection) {
//         setState(() {
//           controller.text = selection;
//         });
//       },
//       fieldViewBuilder: (context, fieldController, focusNode, onEditingComplete) {
//         return TextField(
//           controller: fieldController,
//           focusNode: focusNode,
//           decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
//           onEditingComplete: onEditingComplete,
//         );
//       },
//     );
//   }

//   Widget buildDateField(String label, TextEditingController controller, {bool enabled = true}) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(),
//       ),
//       readOnly: true,
//       enabled: enabled,
//       onTap: enabled
//           ? () async {
//               DateTime? pickedDate = await showDatePicker(
//                 context: context,
//                 initialDate: DateTime.now(),
//                 firstDate: DateTime.now(),
//                 lastDate: DateTime(2101),
//               );
//               if (pickedDate != null) {
//                 setState(() {
//                   controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
//                 });
//               }
//             }
//           : null,
//     );
//   }
// }













// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';

// class FlightBookingWidget extends StatefulWidget {
//   @override
//   _FlightBookingWidgetState createState() => _FlightBookingWidgetState();
// }

// class _FlightBookingWidgetState extends State<FlightBookingWidget> {
//   TextEditingController departureDateController = TextEditingController();
//   TextEditingController returnDateController = TextEditingController();
//   TextEditingController fromCityController = TextEditingController();
//   TextEditingController toCityController = TextEditingController();
//   bool isExpanded = false;
//   bool isRoundTrip = false;

//   final Map<String, String> airportCodes = {
//     "New Delhi": "DEL",
//     "Mumbai": "BOM",
//     "Bangalore": "BLR",
//     "Kolkata": "CCU",
//     "Chennai": "MAA",
//     "Hyderabad": "HYD",
//     "Pune": "PNQ",
//     "Goa": "GOI",
//     "Dubai": "DXB",
//     "New York": "JFK",
//     "London": "LHR",
//   };

//   void searchFlights() {
//     String? fromCode = airportCodes[fromCityController.text];
//     String? toCode = airportCodes[toCityController.text];

//     if (fromCode == null || toCode == null || departureDateController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please select cities and date!")),
//       );
//       return;
//     }

//     String formattedDeparture = _formatDate(departureDateController.text);
//     String formattedReturn = returnDateController.text.isNotEmpty ? _formatDate(returnDateController.text) : "";

//     String url = "https://www.makemytrip.com/flight/search?"
//         "itinerary=${fromCode}-${toCode}-${formattedDeparture}"
//         "${returnDateController.text.isNotEmpty ? '~${toCode}-${fromCode}-${formattedReturn}' : ''}"
//         "&tripType=${returnDateController.text.isEmpty ? 'O' : 'R'}"
//         "&paxType=A-1_C-0_I-0"
//         "&intl=false"
//         "&cabinClass=E"
//         "&lang=eng";

//     _launchUrl(url);
//   }

//   String _formatDate(String date) {
//     DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
//     return DateFormat('dd-MM-yyyy').format(parsedDate);
//   }

//   Future<void> _launchUrl(String url) async {
//   Uri uri = Uri.parse(url);
//   if (await canLaunchUrl(uri)) {
//     await launchUrl(uri, mode: LaunchMode.externalApplication); // Ensures opening in a browser
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Could not open the website")),
//     );
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(vertical: 16),
//       child: Column(
//         children: [
//           ListTile(
//             leading: const Icon(Icons.flight, color: Colors.blue),
//             title: const Text("Find Flight", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             trailing: Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
//             onTap: () => setState(() => isExpanded = !isExpanded),
//           ),
//           if (isExpanded) ...[
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   buildAutoCompleteField("From", fromCityController),
//                   const SizedBox(height: 10),
//                   buildAutoCompleteField("To", toCityController),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ListTile(
//                           contentPadding: EdgeInsets.zero,
//                           title: const Text("One Way", style: TextStyle(fontSize: 14)),
//                           leading: Radio(
//                             value: false,
//                             groupValue: isRoundTrip,
//                             onChanged: (bool? value) {
//                               setState(() {
//                                 isRoundTrip = value!;
//                                 returnDateController.clear();
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: ListTile(
//                           contentPadding: EdgeInsets.zero,
//                           title: const Text("Round Trip", style: TextStyle(fontSize: 14)),
//                           leading: Radio(
//                             value: true,
//                             groupValue: isRoundTrip,
//                             onChanged: (bool? value) {
//                               setState(() {
//                                 isRoundTrip = value!;
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: buildDateField("Departure Date", departureDateController),
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: buildDateField("Return Date", returnDateController, enabled: isRoundTrip),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: searchFlights,
//                     child: const Text("Search Flights"),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget buildAutoCompleteField(String label, TextEditingController controller) {
//     return Autocomplete<String>(
//       optionsBuilder: (TextEditingValue textEditingValue) {
//         if (textEditingValue.text.isEmpty) {
//           return const Iterable<String>.empty();
//         }
//         return airportCodes.keys.where((city) => city.toLowerCase().contains(textEditingValue.text.toLowerCase()));
//       },
//       onSelected: (String selection) {
//         setState(() {
//           controller.text = selection;
//         });
//       },
//       fieldViewBuilder: (context, fieldController, focusNode, onEditingComplete) {
//         return TextField(
//           controller: fieldController,
//           focusNode: focusNode,
//           decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
//           onEditingComplete: onEditingComplete,
//         );
//       },
//     );
//   }

//   Widget buildDateField(String label, TextEditingController controller, {bool enabled = true}) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(),
//       ),
//       readOnly: true,
//       enabled: enabled,
//       onTap: enabled
//           ? () async {
//               DateTime? pickedDate = await showDatePicker(
//                 context: context,
//                 initialDate: DateTime.now(),
//                 firstDate: DateTime.now(),
//                 lastDate: DateTime(2101),
//               );
//               if (pickedDate != null) {
//                 setState(() {
//                   controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
//                 });
//               }
//             }
//           : null,
//     );
//   }
// }








import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class FlightBookingWidget extends StatefulWidget {
  @override
  _FlightBookingWidgetState createState() => _FlightBookingWidgetState();
}

class _FlightBookingWidgetState extends State<FlightBookingWidget> {
  TextEditingController departureDateController = TextEditingController();
  TextEditingController returnDateController = TextEditingController();
  String? fromCity;
  String? toCity;
  String? fromCode;
  String? toCode;
  bool isExpanded = false;

  final Map<String, String> airportCodes = {
    "New Delhi": "DEL",
    "Mumbai": "BOM",
    "Bangalore": "BLR",
    "Kolkata": "CCU",
    "Chennai": "MAA",
    "Hyderabad": "HYD",
    "Pune": "PNQ",
    "Goa": "GOI",
    "Dubai": "DXB",
    "New York": "JFK",
    "London": "LHR",
  };

  void searchFlights() {
    if (fromCode == null || toCode == null || departureDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select cities and date!")),
      );
      return;
    }

    String formattedDeparture = _formatDate(departureDateController.text);
    String formattedReturn = returnDateController.text.isNotEmpty ? _formatDate(returnDateController.text) : "";

    String url = "https://www.makemytrip.com/flight/search?"
        "itinerary=${fromCode}-${toCode}-${formattedDeparture}${returnDateController.text.isNotEmpty ? '~${toCode}-${fromCode}-${formattedReturn}' : ''}"
        "&tripType=${returnDateController.text.isEmpty ? 'O' : 'R'}"
        "&paxType=A-1_C-0_I-0"
        "&intl=false"
        "&cabinClass=E"
        "&lang=eng";

    _launchUrl(url);
  }

  String _formatDate(String date) {
    DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: InkWell(
        onTap: () => setState(() => isExpanded = !isExpanded),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Find Flights",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              if (isExpanded) ...[
                const SizedBox(height: 10),
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<String>.empty();
                    }
                    return airportCodes.keys.where((city) => city.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                  },
                  onSelected: (String selection) {
                    setState(() {
                      fromCity = selection;
                      fromCode = airportCodes[selection];
                    });
                  },
                  fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: const InputDecoration(labelText: "From (City)"),
                      onEditingComplete: onEditingComplete,
                    );
                  },
                ),
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<String>.empty();
                    }
                    return airportCodes.keys.where((city) => city.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                  },
                  onSelected: (String selection) {
                    setState(() {
                      toCity = selection;
                      toCode = airportCodes[selection];
                    });
                  },
                  fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: const InputDecoration(labelText: "To (City)"),
                      onEditingComplete: onEditingComplete,
                    );
                  },
                ),
                TextField(
                  controller: departureDateController,
                  decoration: const InputDecoration(labelText: "Departure Date (YYYY-MM-DD)"),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        departureDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                      });
                    }
                  },
                ),
                TextField(
                  controller: returnDateController,
                  decoration: const InputDecoration(labelText: "Return Date (Optional, YYYY-MM-DD)"),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        returnDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                      });
                    }
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: searchFlights,
                  child: const Text("Search Flights"),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}















// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';

// class FlightBookingWidget extends StatefulWidget {
//   @override
//   _FlightBookingWidgetState createState() => _FlightBookingWidgetState();
// }

// class _FlightBookingWidgetState extends State<FlightBookingWidget> {
//   TextEditingController departureDateController = TextEditingController();
//   TextEditingController returnDateController = TextEditingController();

//   String? fromCity;
//   String? toCity;
//   String? fromCode;
//   String? toCode;

//   // Airport data (City Name -> Airport Code)
//   final Map<String, String> airportCodes = {
//     "New Delhi": "DEL",
//     "Mumbai": "BOM",
//     "Bangalore": "BLR",
//     "Kolkata": "CCU",
//     "Chennai": "MAA",
//     "Hyderabad": "HYD",
//     "Pune": "PNQ",
//     "Goa": "GOI",
//     "Dubai": "DXB",
//     "New York": "JFK",
//     "London": "LHR",
//   };

//   void searchFlights() {
//     if (fromCode == null || toCode == null || departureDateController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please select cities and date!")),
//       );
//       return;
//     }

//     String formattedDeparture = _formatDate(departureDateController.text);
//     String formattedReturn = returnDateController.text.isNotEmpty ? _formatDate(returnDateController.text) : "";

//     String url = "https://www.makemytrip.com/flight/search?"
//         "itinerary=${fromCode}-${toCode}-${formattedDeparture}${returnDateController.text.isNotEmpty ? '~${toCode}-${fromCode}-${formattedReturn}' : ''}"
//         "&tripType=${returnDateController.text.isEmpty ? 'O' : 'R'}"
//         "&paxType=A-1_C-0_I-0"
//         "&intl=false"
//         "&cabinClass=E"
//         "&lang=eng";

//     _launchUrl(url);
//   }

//   String _formatDate(String date) {
//     DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
//     return DateFormat('dd/MM/yyyy').format(parsedDate);
//   }

//   Future<void> _launchUrl(String url) async {
//     if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
//       throw Exception("Could not launch $url");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(vertical: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Book Flights",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),

//             // FROM City Autocomplete
//             Autocomplete<String>(
//               optionsBuilder: (TextEditingValue textEditingValue) {
//                 if (textEditingValue.text.isEmpty) {
//                   return const Iterable<String>.empty();
//                 }
//                 return airportCodes.keys.where((city) =>
//                     city.toLowerCase().contains(textEditingValue.text.toLowerCase()));
//               },
//               onSelected: (String selection) {
//                 setState(() {
//                   fromCity = selection;
//                   fromCode = airportCodes[selection];
//                 });
//               },
//               fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
//                 return TextField(
//                   controller: controller,
//                   focusNode: focusNode,
//                   decoration: const InputDecoration(labelText: "From (City)"),
//                   onEditingComplete: onEditingComplete,
//                 );
//               },
//             ),

//             // TO City Autocomplete
//             Autocomplete<String>(
//               optionsBuilder: (TextEditingValue textEditingValue) {
//                 if (textEditingValue.text.isEmpty) {
//                   return const Iterable<String>.empty();
//                 }
//                 return airportCodes.keys.where((city) =>
//                     city.toLowerCase().contains(textEditingValue.text.toLowerCase()));
//               },
//               onSelected: (String selection) {
//                 setState(() {
//                   toCity = selection;
//                   toCode = airportCodes[selection];
//                 });
//               },
//               fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
//                 return TextField(
//                   controller: controller,
//                   focusNode: focusNode,
//                   decoration: const InputDecoration(labelText: "To (City)"),
//                   onEditingComplete: onEditingComplete,
//                 );
//               },
//             ),

//             // Departure Date Picker
//             TextField(
//               controller: departureDateController,
//               decoration: const InputDecoration(labelText: "Departure Date (YYYY-MM-DD)"),
//               readOnly: true,
//               onTap: () async {
//                 DateTime? pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime.now(),
//                   lastDate: DateTime(2101),
//                 );
//                 if (pickedDate != null) {
//                   setState(() {
//                     departureDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
//                   });
//                 }
//               },
//             ),

//             // Return Date Picker
//             TextField(
//               controller: returnDateController,
//               decoration: const InputDecoration(labelText: "Return Date (Optional, YYYY-MM-DD)"),
//               readOnly: true,
//               onTap: () async {
//                 DateTime? pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime.now(),
//                   lastDate: DateTime(2101),
//                 );
//                 if (pickedDate != null) {
//                   setState(() {
//                     returnDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
//                   });
//                 }
//               },
//             ),

//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: searchFlights,
//               child: const Text("Search Flights"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
















// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';

// class FlightBookingWidget extends StatefulWidget {
//   @override
//   _FlightBookingWidgetState createState() => _FlightBookingWidgetState();
// }

// class _FlightBookingWidgetState extends State<FlightBookingWidget> {
//   TextEditingController fromController = TextEditingController();
//   TextEditingController toController = TextEditingController();
//   TextEditingController departureDateController = TextEditingController();
//   TextEditingController returnDateController = TextEditingController();

//   void searchFlights() {
//     if (fromController.text.isEmpty || toController.text.isEmpty || departureDateController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please fill all required fields!")),
//       );
//       return;
//     }

//     String from = fromController.text.toUpperCase();
//     String to = toController.text.toUpperCase();
//     String departure = departureDateController.text;
//     String returnDate = returnDateController.text.isNotEmpty ? returnDateController.text : "";

//     String formattedDeparture = _formatDate(departure);
//     String formattedReturn = returnDate.isNotEmpty ? _formatDate(returnDate) : "";

//     String url = "https://www.makemytrip.com/flight/search?"
//                  "itinerary=${from}-${to}-${formattedDeparture}${returnDate.isNotEmpty ? '~${to}-${from}-${formattedReturn}' : ''}"
//                  "&tripType=${returnDate.isEmpty ? 'O' : 'R'}"
//                  "&paxType=A-1_C-0_I-0"
//                  "&intl=false"
//                  "&cabinClass=E"
//                  "&lang=eng";

//     _launchUrl(url);
//   }

//   String _formatDate(String date) {
//     DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
//     return DateFormat('dd/MM/yyyy').format(parsedDate);
//   }

//   Future<void> _launchUrl(String url) async {
//     if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
//       throw Exception("Could not launch $url");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(vertical: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Book Flights",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             TextField(
//               controller: fromController,
//               decoration: const InputDecoration(labelText: "From (Airport Code e.g. DEL)"),
//             ),
//             TextField(
//               controller: toController,
//               decoration: const InputDecoration(labelText: "To (Airport Code e.g. BOM)"),
//             ),
//             TextField(
//               controller: departureDateController,
//               decoration: const InputDecoration(labelText: "Departure Date (YYYY-MM-DD)"),
//               readOnly: true,
//               onTap: () async {
//                 DateTime? pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime.now(),
//                   lastDate: DateTime(2101),
//                 );
//                 if (pickedDate != null) {
//                   setState(() {
//                     departureDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
//                   });
//                 }
//               },
//             ),
//             TextField(
//               controller: returnDateController,
//               decoration: const InputDecoration(labelText: "Return Date (Optional, YYYY-MM-DD)"),
//               readOnly: true,
//               onTap: () async {
//                 DateTime? pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime.now(),
//                   lastDate: DateTime(2101),
//                 );
//                 if (pickedDate != null) {
//                   setState(() {
//                     returnDateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
//                   });
//                 }
//               },
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: searchFlights,
//               child: const Text("Search Flights"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
