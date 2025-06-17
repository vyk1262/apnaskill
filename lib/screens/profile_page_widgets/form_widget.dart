import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skill_factorial/constants/colors.dart'; // Make sure this path is correct for your project

class FormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController mobileNumberController;
  final DateTime? selectedDate;
  final String? selectedGender;
  final List<String> genderOptions;
  final Function(BuildContext) onSelectDate;
  final ValueChanged<String?> onGenderChanged;
  final VoidCallback onSave;
  final bool isLoading;
  final double profileCompletionPercentage;
  final String? userEmail;

  const FormWidget({
    Key? key,
    required this.formKey,
    required this.nameController,
    required this.mobileNumberController,
    required this.selectedDate,
    required this.selectedGender,
    required this.genderOptions,
    required this.onSelectDate,
    required this.onGenderChanged,
    required this.onSave,
    required this.isLoading,
    required this.profileCompletionPercentage,
    this.userEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'My Profile',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center, // Already centered
          ),
          // Profile completion percentage
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              // Keep crossAxisAlignment: CrossAxisAlignment.start for the progress bar labels
              // as this is a standard and clear layout for this element.
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Keeps labels at ends
                  children: [
                    Text(
                      'Profile Completion',
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                    ),
                    Text(
                      '${profileCompletionPercentage.toStringAsFixed(0)}%',
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: profileCompletionPercentage / 100,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Email (Non-editable) - Adjusted for centering content within the card
          Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                // Center the content (Email label and email value) within this card
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Email',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.grey[700])),
                  const SizedBox(height: 4),
                  Text(
                    userEmail ?? 'N/A',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign:
                        TextAlign.center, // Explicitly center the email text
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Name - Stays stretched for good form UX
          TextFormField(
            controller: nameController,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              labelText: 'Name', // Label within the field
              labelStyle: TextStyle(color: Colors.grey[700]),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              filled: true,
              fillColor: Colors.grey[50],
              prefixIcon: Icon(Icons.person_outline, color: Colors.grey[600]),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          // Mobile Number - Stays stretched for good form UX
          TextFormField(
            controller: mobileNumberController,
            style: TextStyle(color: Colors.black87),
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Mobile Number', // Label within the field
              labelStyle: TextStyle(color: Colors.grey[700]),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              filled: true,
              fillColor: Colors.grey[50],
              prefixIcon: Icon(Icons.phone_outlined, color: Colors.grey[600]),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your mobile number';
              }
              // Basic mobile number validation (e.g., 10 digits)
              if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                return 'Please enter a valid 10-digit mobile number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Date of Birth - Stays stretched for good form UX
          InkWell(
            onTap: () => onSelectDate(context),
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Date of Birth', // Label within the field
                labelStyle: TextStyle(color: Colors.grey[700]),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                filled: true,
                fillColor: Colors.grey[50],
                prefixIcon: Icon(Icons.calendar_today_outlined,
                    color: Colors.grey[600]),
              ),
              child: Text(
                selectedDate != null
                    ? DateFormat('dd MMMM yyyy').format(selectedDate!)
                    : 'Select your date of birth',
                style: TextStyle(
                  color: selectedDate == null
                      ? Colors.grey[600]
                      : Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Gender - Stays stretched for good form UX
          DropdownButtonFormField<String>(
            value: selectedGender,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              labelText: 'Gender', // Label within the field
              labelStyle: TextStyle(color: Colors.grey[700]),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              filled: true,
              fillColor: Colors.grey[50],
              prefixIcon: Icon(Icons.wc_outlined, color: Colors.grey[600]),
            ),
            items: genderOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: onGenderChanged,
            // validator: (value) => value == null ? 'Please select your gender' : null, // Optional validation
          ),
          const SizedBox(height: 32),

          // Save Button - Stays stretched and centered due to Column's stretch
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            onPressed: isLoading ? null : onSave,
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white)))
                : const Text('Save Changes', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
