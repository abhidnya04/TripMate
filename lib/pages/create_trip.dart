import 'package:appdev/pages/custom_text_field.dart';
import 'package:flutter/material.dart';

import 'budget_selection.dart';
import 'people_selection.dart';

class CreateTrip extends StatefulWidget {
  const CreateTrip({super.key});

  @override
  State<CreateTrip> createState() => _CreateTripState();
}

class _CreateTripState extends State<CreateTrip> {
  String selectedBudget = ""; // To track the selected budget
  String selectedPeople = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        title: const Text(
          'Create Trip',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
        ),
      ),
      
        body: LayoutBuilder(
  builder: (context, constraints) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: constraints.maxHeight,
        ),
          
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section
                SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: Image.asset(
                    'lib/images/travel.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
            
                // Using CustomTextField component
                //Trip name
                const CustomTextField(
                    label: "Name Trip", hintText: "Enter Trip Name"),
                const SizedBox(height: 15),
                const CustomTextField(
                    label: "Travel Destination", hintText: "Enter Destination"),
                const SizedBox(height: 15),
                const CustomTextField(
                    label: "Duration", hintText: "Enter No. Of Days"),
            
                const SizedBox(height: 20),
            
                // Budget Selection
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Select Budget",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
            
                BudgetSelection(
                  selectedBudget: selectedBudget,
                  onBudgetSelected: (budget) {
                    setState(() {
                      selectedBudget = budget;
                    });
                  },
                ),
        
                const SizedBox(height: 20),
            
                // no of peopl
                 const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Who Are You Traveling With?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                PeopleSelection(
                  selectedPeople: selectedPeople,
                  onPeopleSelected: (people) {
                    setState(() {
                      selectedPeople = people;
                    });
                  },
                ),
            
                 const SizedBox(height: 30),

                 Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle trip creation logic here
                      print("Trip Created with:");
                      print("Trip Name: ${selectedBudget}");
                      print("People: ${selectedPeople}");
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text("Create Trip"),
                  ),
                ),
                 ),
            
              ],
            ),
          ),
        ),
   
        );
  }  ,
    ),
    );
  }
}










// import 'package:flutter/material.dart';

// class CreateTrip extends StatefulWidget {
//   const CreateTrip({super.key});

//   @override
//   State<CreateTrip> createState() => _CreateTripState();
// }

// class _CreateTripState extends State<CreateTrip> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 70, // Increases height to add space from the top
//     centerTitle: true, // Centers the title
//         title: const Text(
//           'Create Trip',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 23,
//           ),
//         ),
//       ),


//       body:  Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Image Section (Below Travel Preferences)

//             SizedBox(
//               height: 160,
//               width: double.infinity,
//               child: Image.asset(
//                 'lib/images/travel.jpeg', // Ensure correct path
//                 fit: BoxFit.cover, // Fills the entire space
//               ),
//             ),

//             const SizedBox(height: 20),


//             //trip name

//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Stack(
//                 children: [
//                   TextField(
//                     textAlignVertical: TextAlignVertical.bottom,
//                     style: const TextStyle(fontSize: 20, color: Colors.black),
//                     decoration: InputDecoration(
//                       contentPadding: const EdgeInsets.only(
//                           top: 35, left: 22, bottom: 12), // Space for label
//                       hintText: "Enter Trip Name", // User input at the bottom
//                       hintStyle:
//                           const TextStyle(color: Colors.black, fontSize: 20),
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                         borderSide: const BorderSide(color: Colors.grey),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                         borderSide:  BorderSide(color: Colors.grey[300]!,width: 1),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                         borderSide:
//                             const BorderSide(color: Colors.blue, width: 2),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 20,
//                     top: 15,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 4),
//                       color: Colors.white,
//                       child: const Text(
//                         "Name Trip",
//                         style: TextStyle(color: Colors.grey, fontSize: 14),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 15),

//           //Travel Destination

//            Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Stack(
//                 children: [
//                   TextField(
//                     textAlignVertical: TextAlignVertical.bottom,
//                     style: const TextStyle(fontSize: 20, color: Colors.black),
//                     decoration: InputDecoration(
//                       contentPadding: const EdgeInsets.only(
//                           top: 35, left: 22, bottom: 12), // Space for label
//                       hintText: "Enter Destination", // User input at the bottom
//                       hintStyle:
//                           const TextStyle(color: Colors.black, fontSize: 20),
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                         borderSide: const BorderSide(color: Colors.grey),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                         borderSide: BorderSide(color: Colors.grey[300]!,width: 1),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                         borderSide:
//                             const BorderSide(color: Colors.blue, width: 2),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 20,
//                     top: 15,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 4),
//                       color: Colors.white,
//                       child: const Text(
//                         "Travel Destination",
//                         style: TextStyle(color: Colors.grey, fontSize: 14),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 15),

//             //Duration

//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Stack(
//                 children: [
//                   TextField(
//                     textAlignVertical: TextAlignVertical.bottom,
//                     style: const TextStyle(fontSize: 20, color: Colors.black),
//                     decoration: InputDecoration(
//                       contentPadding: const EdgeInsets.only(
//                           top: 35, left: 22, bottom: 12), // Space for label
//                       hintText: "Enter No. Of Days", // User input at the bottom
//                       hintStyle:
//                           const TextStyle(color: Colors.black, fontSize: 20),
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                         borderSide: const BorderSide(color: Colors.grey),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                         borderSide:  BorderSide(color: Colors.grey[300]!,width: 1),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                         borderSide:
//                             const BorderSide(color: Colors.blue, width: 2),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 20,
//                     top: 15,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 4),
//                       color: Colors.white,
//                       child: const Text(
//                         "Duration",
//                         style: TextStyle(color: Colors.grey, fontSize: 14),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),




//           ],
//         ),
      
//     );
//   }
// }
