import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skill_factorial/constants/colors.dart';

class FormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController mobileNumberController;
  final TextEditingController? collegeController;
  final TextEditingController? cityController;
  final TextEditingController? stateController;
  final DateTime? selectedDate;
  final String? selectedGender;
  final List<String> genderOptions;
  final Function(BuildContext) onSelectDate;
  final ValueChanged<String?> onGenderChanged;
  final VoidCallback onSave;
  final bool isLoading;
  final String? userEmail; // Keep for potential use
  final bool showGenerateProfessorButton;
  final Future<void> Function()? onGenerateProfessorId;
  final bool isGeneratingProfessorId;

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
    this.userEmail,
    this.collegeController,
    this.cityController,
    this.stateController,
    this.showGenerateProfessorButton = false,
    this.onGenerateProfessorId,
    this.isGeneratingProfessorId = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Professor Details Section (Optional)
          if (collegeController != null ||
              cityController != null ||
              stateController != null) ...[
            Text(
              'College Details (Optional for Professors)',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: collegeController,
              decoration: InputDecoration(
                labelText: 'College Name',
                prefixIcon:
                    FaIcon(Icons.school_outlined, color: Color(0xFF4A90E2)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Color(0xFF4A90E2), width: 2),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: cityController,
                    decoration: InputDecoration(
                      labelText: 'City',
                      prefixIcon: FaIcon(Icons.location_city_outlined,
                          color: Color(0xFF4A90E2)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            BorderSide(color: Color(0xFF4A90E2), width: 2),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: stateController,
                    decoration: InputDecoration(
                      labelText: 'State',
                      prefixIcon:
                          FaIcon(Icons.map_outlined, color: Color(0xFF4A90E2)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            BorderSide(color: Color(0xFF4A90E2), width: 2),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    ),
                  ),
                ),
              ],
            ),
            if (showGenerateProfessorButton &&
                onGenerateProfessorId != null) ...[
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: isGeneratingProfessorId
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : FaIcon(Icons.badge_outlined),
                  label: Text(
                    isGeneratingProfessorId
                        ? 'Generating...'
                        : 'Generate Professor ID',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed:
                      isGeneratingProfessorId ? null : onGenerateProfessorId,
                ),
              ),
            ],
            const SizedBox(height: 28),
          ],

          // Name Field
          TextFormField(
            controller: nameController,
            style: GoogleFonts.poppins(color: Colors.black87),
            decoration: InputDecoration(
              labelText: 'Full Name *',
              prefixIcon:
                  FaIcon(Icons.person_outline, color: Color(0xFF4A90E2)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Color(0xFF4A90E2), width: 2),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              labelStyle: TextStyle(color: Colors.grey.shade600),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Mobile Number Field
          TextFormField(
            controller: mobileNumberController,
            style: GoogleFonts.poppins(color: Colors.black87),
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Mobile Number *',
              prefixIcon:
                  FaIcon(Icons.phone_outlined, color: Color(0xFF4A90E2)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Color(0xFF4A90E2), width: 2),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              labelStyle: TextStyle(color: Colors.grey.shade600),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your mobile number';
              }
              if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                return 'Enter valid 10-digit number';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Date of Birth Field
          InkWell(
            onTap: () => onSelectDate(context),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade50,
              ),
              child: Row(
                children: [
                  FaIcon(
                    Icons.calendar_today_outlined,
                    color: Color(0xFF4A90E2),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      selectedDate != null
                          ? DateFormat('dd MMMM yyyy').format(selectedDate!)
                          : 'Date of Birth',
                      style: GoogleFonts.poppins(
                        color: selectedDate != null
                            ? Colors.black87
                            : Colors.grey.shade600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Gender Dropdown
          DropdownButtonFormField<String>(
            value: selectedGender,
            style: GoogleFonts.poppins(color: Colors.black87),
            decoration: InputDecoration(
              labelText: 'Gender',
              prefixIcon: FaIcon(Icons.wc_outlined, color: Color(0xFF4A90E2)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Color(0xFF4A90E2), width: 2),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              labelStyle: TextStyle(color: Colors.grey.shade600),
            ),
            items: genderOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: onGenderChanged,
          ),
          const SizedBox(height: 32),

          // Save Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4A90E2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              onPressed: isLoading ? null : onSave,
              child: isLoading
                  ? SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      'Save Changes',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
