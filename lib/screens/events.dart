import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:skill_factorial/screens/common_widgets/custom_app_bar.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final String eventsJson = '''
  [
    {
      "id": "1",
      "imageUrl": "https://i.ibb.co/S4pwHMDr/javascript.png",
      "title": "Building AI Agents Using Python",
      "subtitle": "Learn how to build AI agents using Python.",
      "address": "Online",
      "date": "August 15, 2025",
      "cost": "FREE"
    },
    {
      "id": "2",
      "imageUrl": "https://i.ibb.co/S4pwHMDr/javascript.png",
      "title": "Tech Meetup: AI in Action",
      "subtitle": "Explore the latest in Artificial Intelligence and network with experts.",
      "address": "456 Innovation Ave, Tech Town, NY 10001",
      "date": "September 01, 2025",
      "cost": "199/-"
    },
    {
      "id": "3",
      "imageUrl": "https://i.ibb.co/S4pwHMDr/javascript.png",
      "title": "Python for Beginners",
      "subtitle": " Learn the basics of Python programming and get started with your coding journey.",
      "address": "789 Harvest Lane, Farmville, TX 75001",
      "date": "September 20, 2025",
      "cost": "FREE"
    },
    {
      "id": "4",
      "imageUrl": "https://i.ibb.co/S4pwHMDr/javascript.png",
      "title": "Build Your First AI Agent",
      "subtitle": " Join us for a fun-filled day of coding and learning.",
      "address": "Online",
      "date": "October 05, 2025",
      "cost": "FREE"
    },
    {
      "id": "5",
      "imageUrl": "https://i.ibb.co/S4pwHMDr/javascript.png",
      "title": "Full Stack Development Using AI Tools",
      "subtitle": "Join us for a fun-filled day of coding and learning.",
      "address": "123 Tech Street, Tech City, CA 90210",
      "date": "October 10, 2025",
      "cost": "199/-"
    }
  ]
  ''';

  List<dynamic> _events = [];

  @override
  void initState() {
    super.initState();
    _parseEventsJson();
  }

  void _parseEventsJson() {
    setState(() {
      _events = json.decode(eventsJson);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: _events.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                int crossAxisCount = 1;
                if (constraints.maxWidth >= 600) {
                  crossAxisCount = 2;
                }
                if (constraints.maxWidth >= 900) {
                  crossAxisCount = 3;
                }
                if (constraints.maxWidth >= 1200) {
                  crossAxisCount = 4;
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 20.0, // Increased spacing
                    mainAxisSpacing: 20.0, // Increased spacing
                    childAspectRatio:
                        0.8, // Adjusted aspect ratio for better look
                  ),
                  itemCount: _events.length,
                  itemBuilder: (context, index) {
                    final event = _events[index];
                    return EventCard(event: event); // Use the new widget
                  },
                );
              },
            ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Map<String, dynamic> event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle the entire card being tapped
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Viewing details for ${event['title']}'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: Card(
        elevation: 10.0, // Increased elevation for a floating effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image with Overlay
            Stack(
              children: [
                Image.network(
                  event['imageUrl'],
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover, // Ensures the image fills the space
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 180,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: Icon(Icons.image_not_supported,
                          size: 60, color: Colors.grey[400]),
                      alignment: Alignment.center,
                    );
                  },
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black
                              .withOpacity(0.6), // Dark overlay for text
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Text(
                    event['date'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event['title'],
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    event['subtitle'],
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[700],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 18.0, color: Colors.blueGrey[700]),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          event['address'],
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.blueGrey[700],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  // "Cost" Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.amber[600],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Cost: ${event['cost']}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
