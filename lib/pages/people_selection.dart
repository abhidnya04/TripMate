import 'package:flutter/material.dart';

import '../components/selection_button.dart';


class PeopleSelection extends StatelessWidget {
  final String selectedPeople;
  final Function(String) onPeopleSelected;

  const PeopleSelection({
    super.key,
    required this.selectedPeople,
    required this.onPeopleSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          SizedBox(
            height: 80,

            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                
                children: [
                  SelectionButton(
                    label: "Single",
                    imagePath: "lib/images/Couple.png",
                    isSelected: selectedPeople == "Single",
                    onTap: () => onPeopleSelected("Single"),
                  ),
                  const SizedBox(width: 20),
                  SelectionButton(
                    label: "Couple",
                    imagePath: "lib/images/Couple.png",
                    isSelected: selectedPeople == "Couple",
                    onTap: () => onPeopleSelected("Couple"),
                  ),
                  SelectionButton(
                    label: "Friend",
                    imagePath: "lib/images/Couple.png",
                    isSelected: selectedPeople == "Friend",
                    onTap: () => onPeopleSelected("Friend"),
                  ),
                  SelectionButton(
                    label: "Family",
                    imagePath: "lib/images/Couple.png",
                    isSelected: selectedPeople == "Family",
                    onTap: () => onPeopleSelected("Family"),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
         
        ],
      ),
    );
  }
}
