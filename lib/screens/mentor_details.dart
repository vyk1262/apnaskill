import 'package:flutter/material.dart';
import 'package:skill_factorial/custom_app_bar.dart';

class MentorDetailScreen extends StatefulWidget {
  final dynamic mentor;

  const MentorDetailScreen({
    super.key,
    required this.mentor,
  });

  @override
  State<MentorDetailScreen> createState() => _MentorDetailScreenState();
}

class _MentorDetailScreenState extends State<MentorDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _hoursController = TextEditingController();
  final _topicController = TextEditingController();
  final _expectationsController = TextEditingController();

  @override
  void dispose() {
    _hoursController.dispose();
    _topicController.dispose();
    _expectationsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildMentorHeader(),
            _buildMentorDetails(),
            _buildBookingForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildMentorHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(
        children: [
          Hero(
            tag: widget.mentor["id"],
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(widget.mentor["image"]),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.mentor["name"],
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            widget.mentor["profession"],
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.amber[600]),
              Text(
                '${widget.mentor["rating"]} (${widget.mentor["experience"]}+ years exp.)',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMentorDetails() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailSection('Expertise', widget.mentor["expertise"]),
          const SizedBox(height: 16),
          _buildDetailSection('Education', [widget.mentor["education"]]),
          const SizedBox(height: 16),
          Text(
            'About',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(widget.mentor["bio"]),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String title, List<dynamic> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: items.map((e) => Chip(label: Text(e.toString()))).toList(),
        ),
      ],
    );
  }

  Widget _buildBookingForm() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Book Session',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField(
              items: [1, 2, 3].map((hour) {
                return DropdownMenuItem(
                  value: hour,
                  child: Text('$hour hour(s)'),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Duration',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {},
              validator: (value) => value == null ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _topicController,
              decoration: const InputDecoration(
                labelText: 'Discussion Topic',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _expectationsController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Your Expectations',
                border: OutlineInputBorder(),
                hintText:
                    'Describe what you hope to achieve in this session...',
              ),
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle form submission
                    _showConfirmationDialog();
                  }
                },
                child: const Text('Request Session'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Request'),
        content: const Text('Are you sure you want to send this request?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Request sent successfully!')),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
