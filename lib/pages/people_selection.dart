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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distributes buttons evenly
            children: [
              Expanded(
                child: SelectionButton(
                  label: "Single",
                  imagePath: "lib/images/Couple.png",
                  isSelected: selectedPeople == "Single",
                  onTap: () => onPeopleSelected("Single"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SelectionButton(
                  label: "Couple",
                  imagePath: "lib/images/Couple.png",
                  isSelected: selectedPeople == "Couple",
                  onTap: () => onPeopleSelected("Couple"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SelectionButton(
                  label: "Friend",
                  imagePath: "lib/images/Couple.png",
                  isSelected: selectedPeople == "Friend",
                  onTap: () => onPeopleSelected("Friend"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SelectionButton(
                  label: "Family",
                  imagePath: "lib/images/Couple.png",
                  isSelected: selectedPeople == "Family",
                  onTap: () => onPeopleSelected("Family"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
