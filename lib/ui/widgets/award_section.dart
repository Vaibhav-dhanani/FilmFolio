import 'package:filmfolio/models/award.dart';
import 'package:flutter/material.dart';

class AwardsSection extends StatelessWidget {
  final List<Award> allAwards;
  final List<Award> selectedAwards;
  final Function(Award, bool) onAwardSelected;

  const AwardsSection({
    Key? key,
    required this.allAwards,
    required this.selectedAwards,
    required this.onAwardSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Awards (Optional):'),
        Wrap(
          spacing: 8,
          children: allAwards.map((award) => FilterChip(
            label: Text('${award.category}: ${award.name}'),
            selected: selectedAwards.contains(award),
            onSelected: (selected) => onAwardSelected(award, selected),
          )).toList(),
        ),
      ],
    );
  }
}