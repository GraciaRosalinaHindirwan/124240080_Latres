
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class FilterBottomSheet extends StatelessWidget {
  final String? selectedStatus;
  final Function(String?) onApply;

  const FilterBottomSheet({
    super.key,
    required this.selectedStatus,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    String? tempStatus = selectedStatus;

    return StatefulBuilder(
      builder: (context, setModalState) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.unknown,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'FILTER CHARACTERS',
                style: AppTextStyles.heading.copyWith(
                  color: AppColors.primary,
                  fontSize: 24,
                ),
              ),

              const SizedBox(height: 20),

              ...['Alive', 'Dead', 'Unknown'].map((status) {
                final isSelected = tempStatus == status;

                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    status,
                    style: AppTextStyles.body,
                  ),
                  trailing: Checkbox(
                    value: isSelected,
                    activeColor: AppColors.primary,
                    checkColor: AppColors.background,
                    side: const BorderSide(
                      color: AppColors.unknown,
                    ),
                    onChanged: (value) {
                      setModalState(() {
                        tempStatus = value == true
                            ? status
                            : null;
                      });
                    },
                  ),
                  onTap: () {
                    setModalState(() {
                      tempStatus =
                          isSelected ? null : status;
                    });
                  },
                );
              }),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        onApply(null);
                        Navigator.pop(context);
                      },
                      child: Text('Reset', 
                        style: AppTextStyles.button.copyWith(
                          color: AppColors.textPrimary
                        )
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        onApply(tempStatus);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.background,
                      ),
                      child: Text('Apply Filter', 
                        style: AppTextStyles.button.copyWith(
                        )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
