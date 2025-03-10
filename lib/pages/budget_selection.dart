import 'package:flutter/material.dart';

import '../components/budget_button.dart';


class BudgetSelection extends StatelessWidget {
  final String selectedBudget;
  final Function(String) onBudgetSelected;

  const BudgetSelection({
    super.key,
    required this.selectedBudget,
    required this.onBudgetSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BudgetButton(
              label: "Low",
              imagePath: "lib/images/budget.png",
              isSelected: selectedBudget == "Low",
              onTap: () => onBudgetSelected("Low"),
            ),
            BudgetButton(
              label: "Medium",
              imagePath: "lib/images/budget.png",
              isSelected: selectedBudget == "Medium",
              onTap: () => onBudgetSelected("Medium"),
            ),
            BudgetButton(
              label: "High",
              imagePath: "lib/images/budget.png",
              isSelected: selectedBudget == "High",
              onTap: () => onBudgetSelected("High"),
            ),
            
          ],
        ),
      
    );
  }
}