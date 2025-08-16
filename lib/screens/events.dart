import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:skill_factorial/screens/common_widgets/custom_app_bar.dart'; // Required for JSON decoding

class Events extends StatefulWidget {
  const Events({super.key}); // Added key for best practice

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  // Dummy JSON data for events, embedded directly in the screen
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
      "imageUrl": "URL_ADDRESS.ibb.co/S4pwHMDr/javascript.png",
      "title": "Full Stack Development Using AI Tools",
      "subtitle": "Join us for a fun-filled day of coding and learning.",
      "address": "123 Tech Street, Tech City, CA 90210",
      "date": "October 10, 2025",
      "cost": "199/-"
    }
  ]
  ''';

  List<dynamic> _events = []; // List to hold parsed event data

  @override
  void initState() {
    super.initState();
    _parseEventsJson(); // Parse JSON when the widget is initialized
  }

  // Function to decode the JSON string into a Dart list
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
          ? const Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator if events are not loaded
          : LayoutBuilder(
              // Use LayoutBuilder for responsive grid
              builder: (BuildContext context, BoxConstraints constraints) {
                // Determine crossAxisCount based on screen width
                int crossAxisCount = 1; // Default for mobile
                if (constraints.maxWidth >= 600) {
                  crossAxisCount = 2; // 2 columns for tablets/small desktops
                }
                if (constraints.maxWidth >= 900) {
                  crossAxisCount = 3; // 3 columns for medium desktops
                }
                if (constraints.maxWidth >= 1200) {
                  crossAxisCount = 4; // 4 columns for large desktops
                }

                // If on a desktop-like view (more than 1 column), use GridView
                if (crossAxisCount > 1) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16.0, // Spacing between columns
                      mainAxisSpacing: 16.0, // Spacing between rows
                      childAspectRatio:
                          0.75, // Adjusted to make cards slightly taller and fit better in grid
                    ),
                    itemCount: _events.length,
                    itemBuilder: (context, index) {
                      var event = _events[index]; // Get the current event data
                      return Card(
                        margin: EdgeInsets
                            .zero, // No extra margin as GridView handles spacing
                        elevation:
                            8.0, // Increased elevation for a more prominent card
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15.0), // Rounded corners for the card
                        ),
                        clipBehavior: Clip
                            .antiAlias, // Ensures content respects rounded corners
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Event Image
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15.0)),
                              child: Image.network(
                                event['imageUrl'],
                                height:
                                    160, // Adjusted height for desktop grid view
                                width: double.infinity,
                                fit: BoxFit.cover,
                                // Error builder for broken image URLs
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height:
                                        160, // Adjusted height for desktop grid view
                                    width: double.infinity,
                                    color: Colors.grey[300],
                                    child: Icon(Icons.broken_image,
                                        size: 60, color: Colors.grey[600]),
                                    alignment: Alignment.center,
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Event Title
                                  Text(
                                    event['title'],
                                    style: const TextStyle(
                                      fontSize:
                                          18.0, // Slightly smaller font for desktop grid
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                    ),
                                    maxLines: 1, // Limit title to one line
                                    overflow: TextOverflow
                                        .ellipsis, // Add ellipsis if overflow
                                  ),
                                  const SizedBox(height: 8.0),
                                  // Event Subtitle
                                  Text(
                                    event['subtitle'],
                                    style: TextStyle(
                                      fontSize:
                                          13.0, // Slightly smaller font for desktop grid
                                      color: Colors.grey[700],
                                    ),
                                    maxLines: 2, // Limit subtitle to two lines
                                    overflow: TextOverflow
                                        .ellipsis, // Add ellipsis if overflow
                                  ),
                                  const SizedBox(height: 12.0),
                                  // Event Address
                                  Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          size: 16.0,
                                          color: Colors.blueGrey[700]),
                                      const SizedBox(width: 8.0),
                                      Expanded(
                                        child: Text(
                                          event['address'],
                                          style: TextStyle(
                                            fontSize: 11.0,
                                            color: Colors.blueGrey[700],
                                          ),
                                          maxLines:
                                              1, // Limit address to one line
                                          overflow: TextOverflow
                                              .ellipsis, // Add ellipsis if overflow
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  // Event Date
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today,
                                          size: 16.0,
                                          color: Colors.blueGrey[700]),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        'Date: ${event['date']}',
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          color: Colors.blueGrey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                      height: 10.0), // Reduced spacing
                                  // View Details Button
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Viewing details for ${event['title']}'),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.info_outline,
                                        size: 16), // Smaller icon
                                    label: const Text(
                                      'Register Now',
                                      style: TextStyle(
                                          fontSize: 13.0), // Smaller text
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 7), // Smaller padding
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      elevation: 3.0,
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  // Event Cost
                                  Text(
                                    'Cost: ${event['cost']}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  // For mobile view (crossAxisCount is 1), use ListView
                  return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _events.length,
                    itemBuilder: (context, index) {
                      var event = _events[index]; // Get the current event data
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        elevation:
                            8.0, // Increased elevation for a more prominent card
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15.0), // Rounded corners for the card
                        ),
                        clipBehavior: Clip
                            .antiAlias, // Ensures content respects rounded corners
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Event Image
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15.0)),
                              child: Image.network(
                                event['imageUrl'],
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                // Error builder for broken image URLs
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 200,
                                    width: double.infinity,
                                    color: Colors.grey[300],
                                    child: Icon(Icons.broken_image,
                                        size: 60, color: Colors.grey[600]),
                                    alignment: Alignment.center,
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Event Title
                                  Text(
                                    event['title'],
                                    style: const TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  // Event Subtitle
                                  Text(
                                    event['subtitle'],
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  const SizedBox(height: 12.0),
                                  // Event Address
                                  Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          size: 20.0,
                                          color: Colors.blueGrey[700]),
                                      const SizedBox(width: 8.0),
                                      Expanded(
                                        child: Text(
                                          event['address'],
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.blueGrey[700],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  // Event Date
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today,
                                          size: 20.0,
                                          color: Colors.blueGrey[700]),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        'Date: ${event['date']}',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.blueGrey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20.0),
                                  // View Details Button
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        // Action when the button is pressed
                                        // In a real app, you would navigate to a detailed event screen here.
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Viewing details for ${event['title']}'),
                                            duration:
                                                const Duration(seconds: 2),
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons
                                          .info_outline), // Icon for the button
                                      label: const Text(
                                        'View Details',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors
                                            .deepPurple, // Button background color
                                        foregroundColor: Colors
                                            .white, // Button text/icon color
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.0), // Rounded button corners
                                        ),
                                        elevation: 5.0, // Button shadow
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
    );
  }
}
