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
                  imagePath: "assets/solot.png",
                  isSelected: selectedPeople == "Single",
                  onTap: () => onPeopleSelected("Single"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SelectionButton(
                  label: "Couple",
                  imagePath: "assets/couplet.png",
                  isSelected: selectedPeople == "Couple",
                  onTap: () => onPeopleSelected("Couple"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SelectionButton(
                  label: "Friends",
                  imagePath: "assets/frand.png",
                  isSelected: selectedPeople == "Friends",
                  onTap: () => onPeopleSelected("Friends"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SelectionButton(
                  label: "Family",
                  imagePath: "assets/famil.png",
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
